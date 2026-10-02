`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2025 12:18:44 PM
// Design Name: 
// Module Name: BARTLETT
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




`include "constants.vh"



	


module theta_generator_sim #(
	parameter THETA_WIDTH = 16
	) (
	input clk,
	input reset_n,
	
	output reg[THETA_WIDTH-1:0] m_axis_theta_tdata,
	output reg m_axis_theta_tvalid,
	output reg m_axis_theta_tlast
	);
	reg [31:0] pause_counter;
	reg [31:0] theta_counter;

	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_theta_tdata <= 0;
			m_axis_theta_tvalid <= 0;
			m_axis_theta_tlast <= 0;
			pause_counter <= 0;
			theta_counter <= 0;
		end else begin
			pause_counter <= pause_counter == 100 ? 0 : pause_counter + 1;
			if(pause_counter == 0 )begin
				theta_counter <= theta_counter + 1;
				m_axis_theta_tdata <= theta_counter * 182;
				m_axis_theta_tvalid <= 1;
				if(theta_counter == 360) m_axis_theta_tlast <= 1;
				else m_axis_theta_tlast <= 0;
			end else begin 
				m_axis_theta_tvalid <= 0;
				m_axis_theta_tlast <= 0;
				m_axis_theta_tdata <= 0;
				
			end	
		end
	end


endmodule


// upsample by a factor of 2 using lerp
module linear_interpolator #(
	parameter WORD_SIZE = 16
	)(
	input s_axis_clk,
	input s_axis_aresetn, // global reset
	
	input reset, // logic reset from '''controller'''
	
	input[WORD_SIZE-1:0] s_axis_tdata,
	input s_axis_tvalid,
	output reg s_axis_tready,
	
	output reg [WORD_SIZE-1:0] m_axis_tdata,
	output reg m_axis_tvalid,
	input m_axis_tready
	);
	
	reg[WORD_SIZE-1:0] values[1:0];
	reg[1:0] valid;
	wire[WORD_SIZE:0] out_pipe;
	reg out_pipe_valid;
	wire sign;
	
	reg out_pipe_valid_delayed;
	assign out_pipe = values[0] + values[1];
	assign sign = values[0][WORD_SIZE-1] ^ values[1][WORD_SIZE-1];

	always@(posedge s_axis_clk or negedge s_axis_aresetn)begin
		if(!s_axis_aresetn || reset)begin
			values[0]<=0;
			values[1]<=0;
			valid <= 0;
			out_pipe_valid <= 0;
			s_axis_tready <= 0;
			m_axis_tvalid <= 0;
			m_axis_tdata <= 0;
			out_pipe_valid_delayed <= 0;
		end else begin
			s_axis_tready <= ~s_axis_tvalid && !(&valid);
			if(s_axis_tvalid && s_axis_tready)begin
				values[0] <= s_axis_tdata;
				valid[0] <= 1;
				values[1] <= values[0];
				valid[1] <= valid[0];
				out_pipe_valid <= 0;
			end else if(m_axis_tready && &valid)begin
				valid[1] <= 0;
				out_pipe_valid <= 1;
			end else begin
				out_pipe_valid <= 0;
			end
			out_pipe_valid_delayed <= out_pipe_valid;
			
			if(out_pipe_valid) begin
				if(sign) m_axis_tdata <= out_pipe[WORD_SIZE-1:0]; // upper bits, overflow
				else m_axis_tdata <= out_pipe[WORD_SIZE:1]; // lower bits, no overflow
			end else m_axis_tdata <= values[0]; //passthrough
			m_axis_tvalid <= out_pipe_valid || out_pipe_valid_delayed;
			
			
		end
	end
	
endmodule
	


module bartlett_datapath #(
	parameter NUM_SIZE = 32  //bits per complex number.EX: NUM_SIZE = 32. num = {imag_16,real_16}
	) (
    input clk,
    input reset_n,
	
    input [NUM_SIZE * `HYDROPHONE_COUNT - 1:0] s_axis_tdata,// 6 hydrophone channels
    input s_axis_tvalid,
    output s_axis_tready,
    input s_axis_tlast,
		
	input[8 + 8 + 8 + 32 - 1 : 0] s_axis_config_tdata, // {beam_freq 8, upper frequency bound 8, lower frequency bound 8 , magnitude threshold 32}
	input[6:0] s_axis_config_tstrb,
	input s_axis_config_tvalid,
	output s_axis_config_tready,

	output[31:0] m_axis_tdata,
	output m_axis_tvalid, m_axis_tlast,
	output[7:0] m_axis_tdest

    );
	
	localparam THETA_WIDTH = 16;
	
	wire[7:0]beam_freq;
	

	fft_max #(
		.NUM_SIZE(NUM_SIZE)
		) fft_max_inst(
		.clk(clk),
		.reset_n(reset_n),
		
		.s_axis_tdata(s_axis_tdata),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tready(s_axis_tready),
        .s_axis_tlast(s_axis_tlast),
		
		.s_axis_config_tdata(s_axis_config_tdata), // {upper frequency bound 8, lower frequency bound 8 , magnitude threshold 32}
		.s_axis_config_tready(s_axis_config_tready),
		.s_axis_config_tstrb(s_axis_config_tstrb),
		.s_axis_config_tvalid(s_axis_config_tvalid),
		
		.m_axis_tdata(m_axis_signal_freq_tdata),
		.m_axis_tlast(m_axis_signal_freq_tlast),
		.m_axis_tvalid(m_axis_signal_freq_tvalid),
		.m_axis_tready(m_axis_signal_freq_tready),
		.m_axis_tuser(m_axis_signal_freq_tuser),
		
		.beam_freq(beam_freq)
		);	
		
wire	[`HYDROPHONE_COUNT*NUM_SIZE - 1:0]	m_axis_signal_freq_tdata;
wire		m_axis_signal_freq_tvalid;
wire		m_axis_signal_freq_tready;
wire		m_axis_signal_freq_tlast;
wire	[7:0]	m_axis_signal_freq_tuser;

		
wire	[NUM_SIZE - 1:0]	m_axis_rxx_tdata;
wire		m_axis_rxx_tvalid;
wire		m_axis_rxx_tready;
wire		m_axis_rxx_tlast;
wire	[$clog2(`HYDROPHONE_COUNT)-1:0]	m_axis_rxx_tuser;


		    // Instantiate Rxx for the signal
    signal_covariance #(
        .NUM_SIZE(NUM_SIZE)
    ) signal_covariance_inst (
        .clk(clk),
        .reset_n(reset_n),
        .clken(1'b1), // Always enabled, can customize

        .s_axis_tdata(m_axis_signal_freq_tdata),
        .s_axis_tvalid(m_axis_signal_freq_tvalid),
        .s_axis_tlast(m_axis_signal_freq_tlast),
        .s_axis_tready(m_axis_signal_freq_tready),

        .m_axis_tdata(m_axis_rxx_tdata),
        .m_axis_tvalid(m_axis_rxx_tvalid),
        .m_axis_tready(m_axis_rxx_tready),
		.m_axis_tlast(m_axis_rxx_tlast)
    );

	
	
wire	[15:0]	m_axis_theta_tdata;
wire		m_axis_theta_tvalid;
wire		m_axis_theta_tlast;


	
theta_generator_sim #(
	.THETA_WIDTH(THETA_WIDTH)
	) theta_generator_inst(
	.clk(clk),
	.reset_n(reset_n),
	
	.m_axis_theta_tdata(m_axis_theta_tdata), // theta value
	.m_axis_theta_tvalid(m_axis_theta_tvalid),
	.m_axis_theta_tlast(m_axis_theta_tlast) // last theta value
	
	);
	

Parallel_Beamformer_Wrapper #(
	.THETA_WIDTH(THETA_WIDTH),
	.NUM_SIZE(32),
	.LATENCY(7)
	)
PBW_inst(
	.clk(clk),
	.reset_n(reset_n),
	
	.s_axis_theta_tdata(m_axis_theta_tdata),
	.s_axis_theta_tvalid(m_axis_theta_tvalid),
	.s_axis_theta_tlast(m_axis_theta_tlast),
	.s_axis_theta_tready(),
	
	.beam_freq(beam_freq), // 2 bit mux to select frequency value
	
	.m_axis_tdata(m_axis_beam_vector_tdata), // steering vector values
	.m_axis_tvalid(m_axis_beam_vector_tvalid),
	.m_axis_tlast(m_axis_beam_vector_tlast), // last value of the current vector
	.m_axis_tready(m_axis_beam_vector_tready),
	.m_axis_tuser(m_axis_beam_vector_tuser) // last vector + theta value of current vector = {1'bLAST, THETA_WIDTH'THETA}
	);

wire	[`HYDROPHONE_COUNT*NUM_SIZE - 1:0]	m_axis_beam_vector_tdata;
wire		m_axis_beam_vector_tvalid;
wire		m_axis_beam_vector_tready;
wire		m_axis_beam_vector_tlast;
wire	[THETA_WIDTH:0]	m_axis_beam_vector_tuser;

		
wire [NUM_SIZE - 1 : 0] m_axis_stheta_tdata;
wire m_axis_stheta_tvalid, m_axis_stheta_tlast, m_axis_stheta_tready;
wire[THETA_WIDTH:0] m_axis_stheta_tuser; 
	    // Instantiate Rxx for the beam
    beam_covariance #(
        .NUM_SIZE(NUM_SIZE),
		.TUSER_SIZE(THETA_WIDTH+1)
    ) beam_covariance_inst (
        .clk(clk),
        .reset_n(reset_n),
        .clken(1'b1), // Always enabled, can customize

		.s_axis_tdata(m_axis_beam_vector_tdata),
		.s_axis_tvalid(m_axis_beam_vector_tvalid),
		.s_axis_tlast(m_axis_beam_vector_tlast),
		.s_axis_tready(m_axis_beam_vector_tready),
		.s_axis_tuser(m_axis_beam_vector_tuser),
		

        .m_axis_tdata(m_axis_stheta_tdata),
        .m_axis_tvalid(m_axis_stheta_tvalid),
        .m_axis_tready(m_axis_stheta_tready),
		.m_axis_tlast(m_axis_stheta_tlast),
		.m_axis_tuser(m_axis_stheta_tuser)
    );

assign m_axis_stheta_tready = 1;
assign m_axis_rxx_tready = 1;
	
	
	complex_dot_product #(
		.NUM_SIZE(NUM_SIZE),
		.TUSER_SIZE(THETA_WIDTH+1)
		) cdp_inst (
		.clk(clk),
		.reset_n(reset_n),
		.s_axis_tdata(s_axis_tdata),
		.s_axis_tvalid(s_axis_tvalid),
		.s_axis_tlast(s_axis_tlast),
		.s_axis_tuser(s_axis_tuser),
		
		.m_axis_tdata(m_axis_tdata),
		.m_axis_tvalid(m_axis_tvalid),
		.m_axis_tuser(m_axis_tuser)
);


	max #(
		.NUM_SIZE(NUM_SIZE)
		) 
	max_inst (
		.clk(clk),
		.reset_n(reset_n),
		
        .s_axis_tdata(0),
        .s_axis_tvalid(0),
        .s_axis_tlast(0),
        .s_axis_tuser(0),
        .s_axis_tready(),
		
        .m_axis_max_tdata(),
        .m_axis_max_tvalid(),
        .m_axis_max_tlast()
		);
		
	
	
endmodule

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

`define THETA_COUNT 19
`define MATRIX_SIZE 4


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
    input reset_b,
	
    input [NUM_SIZE * 4 - 1:0] s_axis_tdata,//4 hydrophone channels
    input s_axis_tvalid,
    output s_axis_tready,
    input s_axis_tlast,
		
	input[8 + 8 + 32 - 1 : 0] s_axis_config_tdata, // {upper frequency bound 8, lower frequency bound 8 , magnitude threshold 32}
	input[5:0] s_axis_config_tstrb,
	input s_axis_config_tvalid,
	output s_axis_config_tready,

	output[31:0] m_axis_tdata,
	output m_axis_tvalid, m_axis_tlast,
	output[7:0] m_axis_tdest,

    //test

    output [`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE - 1:0] debug_rxx,
	output debug_rxx_valid,
	
	output [NUM_SIZE * 4 -1 : 0] debug_fft,
	output debug_fft_valid, 
	
	output[8:0] debug_fft_max_index,
	output debug_fft_max_index_valid,
	
	output[31:0] debug_fft_mag,
	output debug_fft_mag_valid,
	
	output[33:0] debug_current_magnitude,
	output debug_current_magnitude_valid,
	
	output [NUM_SIZE * 4 - 1:0] debug_max_freq_vec,
	output debug_max_freq_vec_valid

    );
	
	linear_interpolator #(.WORD_SIZE(16))lerp(
		.s_axis_clk(clk),
		.s_axis_aresetn(reset_b),
		.s_axis_tdata(s_axis_tdata[15:0]),
		.s_axis_tvalid(s_axis_tvalid),
		.m_axis_tready(1)
		);


	assign debug_max_freq_vec = m_axis_fft_max_tdata;
	assign debug_max_freq_vec_valid = m_axis_fft_max_tvalid;
	
	
	wire[NUM_SIZE * 4 - 1:0]  m_axis_fft_max_tdata;
	wire m_axis_fft_max_tready ,m_axis_fft_max_tlast ,m_axis_fft_max_tvalid;
	
	wire[NUM_SIZE * 4 - 1:0]  m_axis_converted_fft_max_tdata;
	wire m_axis_converted_fft_max_tready ,m_axis_converted_fft_max_tlast ,m_axis_converted_fft_max_tvalid;
		
	
	assign debug_fft_max_index_valid = m_axis_fft_max_tvalid;

	fft_max fft_max_inst(
		.clk(clk),
		.reset_n(reset_b),
		
		.s_axis_tdata(s_axis_tdata),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tready(s_axis_tready),
        .s_axis_tlast(s_axis_tlast),
		
		.s_axis_config_tdata(s_axis_config_tdata), // {upper frequency bound 8, lower frequency bound 8 , magnitude threshold 32}
		.s_axis_config_tready(s_axis_config_tready),
		.s_axis_config_tstrb(s_axis_config_tstrb),
		.s_axis_config_tvalid(s_axis_config_tvalid),
		
		.m_axis_tdata (m_axis_fft_max_tdata),
		.m_axis_tlast (m_axis_fft_max_tlast),
		.m_axis_tvalid(m_axis_fft_max_tvalid),
		.m_axis_tready(m_axis_fft_max_tready),
		.m_axis_tuser(debug_fft_max_index),
		
		.debug_fft(debug_fft),
		.debug_fft_valid(debug_fft_valid),
		.debug_current_magnitude(debug_current_magnitude),
		.debug_current_magnitude_valid(debug_current_magnitude_valid)
		);	
	
	
	bartlett_time_domain #(
		.NUM_SIZE(NUM_SIZE)
		) bartlett_time_domain_inst (
		
		.clk(clk),
		.reset_n(reset_b),
		
		.s_axis_fft_tdata (m_axis_fft_max_tdata),
		.s_axis_fft_tvalid(m_axis_fft_max_tvalid),
		.s_axis_fft_tlast (m_axis_fft_max_tlast),
		.s_axis_fft_tready(m_axis_fft_max_tready),
		.s_axis_fft_tuser(m_axis_fft_max_tuser),
		
		.m_axis_tdata(m_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tlast(m_axis_tlast),
		.m_axis_tdest(m_axis_tdest),
		
		.debug_rxx(debug_rxx),
		.debug_rxx_valid(debug_rxx_valid)
	);
		

endmodule

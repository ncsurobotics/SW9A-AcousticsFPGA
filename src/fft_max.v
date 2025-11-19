`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/13/2025 01:17:03 PM
// Design Name: 
// Module Name: hilbert
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


module fft_max (
    input clk,
    input reset_n,

    //data from RAM
    input [127:0] s_axis_tdata,

    //flags from controller
    input s_axis_tvalid,
    input s_axis_tlast,

    //flag to controller
    output reg s_axis_tready,

    //outputs of IFFT
    output [127:0] m_axis_tdata,
	output[15:0] m_axis_tuser,
    output m_axis_tvalid,
    input m_axis_tready,
    output m_axis_tlast,
	
	
	// debug
	
	output[127:0] debug_fft,
	output debug_fft_valid,
	
	output[33:0] debug_current_magnitude,
	output debug_current_magnitude_valid
	
);
    //config parameters
    localparam [11:0] ZERO_PAD = 12'b0;
    localparam [3:0] FWD = 4'b1111;
    localparam [3:0] REV = 4'b0000;
    wire [15:0] fft_s_axis_config_tdata; 
	assign fft_s_axis_config_tdata = {ZERO_PAD, FWD};       //block float
	
	wire [8:0] k_index;
	assign k_index = m_axis_tuser[7:0];
	
	wire [127:0] m_axis_spectrum_tdata;
	wire[15:0] m_axis_spectrum_tuser;
    wire m_axis_spectrum_tvalid;
    wire m_axis_spectrum_tready;
    wire m_axis_spectrum_tlast;
	
	assign debug_fft = m_axis_spectrum_tdata;
	assign debug_fft_valid = m_axis_spectrum_tvalid;
	
	reg toggle_ready;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n) begin
			s_axis_tready <= 1;
			toggle_ready <= 0;
		end else begin
			s_axis_tready <= s_axis_tready ^ toggle_ready;
			if(s_axis_tready)begin
				toggle_ready <= s_axis_tvalid && s_axis_tlast;
			end else begin
				toggle_ready <= m_axis_spectrum_tlast;
			end
		end
	end
	
	shift_register  #(
		.SIZE(1),
		.STAGES(5)
		) input_delay(
		.clk(clk),
		.reset_n(reset_n),
		.enable(1),
		.din(toggle_ready),
		.dout(max_bin_reset)
	);
	
    //first FFT
xfft_0 your_instance_name (
  .aclk(clk),                                                // input wire aclk
  .aresetn(reset_n),                                          // input wire aresetn
  .s_axis_config_tdata(fft_s_axis_config_tdata),                  // input wire [79 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(1),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready),                // output wire s_axis_config_tready
  
  .s_axis_data_tdata(s_axis_tdata),                      // input wire [127 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_tvalid),                    // input wire s_axis_data_tvalid
  //.s_axis_data_tready(s_axis_tready),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_tlast),                      // input wire s_axis_data_tlast
  
  .m_axis_data_tdata(m_axis_spectrum_tdata),                      // output wire [127 : 0] m_axis_data_tdata
  .m_axis_data_tuser(m_axis_spectrum_tuser),                      // output wire [15 : 0] m_axis_data_tuser
  .m_axis_data_tvalid(m_axis_spectrum_tvalid),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(m_axis_spectrum_tready),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_spectrum_tlast),                      // output wire m_axis_data_tlast
  
  .m_axis_status_tdata(m_axis_status_tdata),                  // output wire [7 : 0] m_axis_status_tdata
  .m_axis_status_tvalid(m_axis_status_tvalid),                // output wire m_axis_status_tvalid
  .m_axis_status_tready(1),                // input wire m_axis_status_tready
  
  .event_frame_started(event_frame_started),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing),                  // output wire event_tlast_missing
 // .event_fft_overflow(event_fft_overflow),                    // output wire event_fft_overflow
  .event_status_channel_halt(event_status_channel_halt),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt)  // output wire event_data_out_channel_halt
);



wire[15:0] real_part[3:0], imag_part[3:0];

assign real_part[0] = m_axis_spectrum_tdata[32 * 0 +: 16];
assign imag_part[0] = m_axis_spectrum_tdata[32 * 0 + 16 +: 16];
assign real_part[1] = m_axis_spectrum_tdata[32 * 1 +: 16];
assign imag_part[1] = m_axis_spectrum_tdata[32 * 1 + 16 +: 16];
assign real_part[2] = m_axis_spectrum_tdata[32 * 2 +: 16];
assign imag_part[2] = m_axis_spectrum_tdata[32 * 2 + 16 +: 16 ];
assign real_part[3] = m_axis_spectrum_tdata[32 * 3 +: 16];
assign imag_part[3] = m_axis_spectrum_tdata[32 * 3 + 16+: 16];


max_fft_bin #(.NUM_SIZE(32), .INDEX_COUNT(256))
	 max_fft_bin_inst (
	 .clk(clk),
	 .reset_n(reset_n && !max_bin_reset),
     .s_axis_weight_tdata(m_axis_spectrum_tdata),
     .s_axis_weight_tvalid(m_axis_spectrum_tvalid),
     .s_axis_weight_tlast(m_axis_spectrum_tlast),
     .s_axis_weight_tuser(m_axis_spectrum_tuser[7:0]),
     .s_axis_weight_tready(m_axis_spectrum_tready),
	 
     .m_axis_max_tdata(m_axis_tdata),
     .m_axis_max_tvalid(m_axis_tvalid),
     .m_axis_max_tuser(m_axis_tuser),
     .m_axis_max_tlast(m_axis_tlast),
     .m_axis_max_tready(m_axis_tready),
	 
	 .debug_current_magnitude(debug_current_magnitude),
	 .debug_current_magnitude_valid(debug_current_magnitude_valid)
	);
		
	

endmodule


// finds the maximum frequency based on channel 0's magnitude squared
module max_fft_bin #(
	parameter NUM_SIZE = 32,
	parameter INDEX_COUNT = 256
	) (
	input clk, reset_n,

	// current weight input channel
	input[4 * NUM_SIZE - 1 : 0] s_axis_weight_tdata,
	input s_axis_weight_tvalid, s_axis_weight_tlast, 
	input[$clog2(INDEX_COUNT)  - 1: 0] s_axis_weight_tuser,
	output reg s_axis_weight_tready,
	
	output reg[4 * NUM_SIZE - 1 :0] m_axis_max_tdata,
	output reg m_axis_max_tvalid, m_axis_max_tlast,
	output reg [$clog2(INDEX_COUNT)  - 1: 0] m_axis_max_tuser,
	input m_axis_max_tready,
	
	output[NUM_SIZE+1:0] debug_current_magnitude,
	output debug_current_magnitude_valid
	);
	
	assign debug_current_magnitude_valid = s_axis_weight_tvalid;
	assign debug_current_magnitude = current_magnitude;
/*
	real factor[3:0];
	real average_difference, min_ad;
	initial min_ad = 99999999;
	always@(*)begin
		factor[0] = real_part[0] / 0.0827;
		factor[1] = real_part[1] / -0.1353;
		factor[2] = real_part[2] / -0.0896;
		factor[3] = real_part[3] / 0.1363;
		average_difference = 	factor[0] != 0 ? ((factor[0] - factor[1]) + 
								(factor[0] - factor[2]) +
								(factor[0] - factor[3]) +
								(factor[1] - factor[2]) +
								(factor[1] - factor[3]) +
								(factor[2] - factor[3]) )/6 : 99999999;
		if(average_difference < 0) average_difference = average_difference * -1;
		min_ad = average_difference < min_ad ? average_difference : min_ad;
	end
	*/
	wire signed [15:0] real_part[3:0], imag_part[3:0];
	
	assign real_part[0] = s_axis_weight_tdata[NUM_SIZE * 0 +: NUM_SIZE/2];
	assign imag_part[0] = s_axis_weight_tdata[NUM_SIZE * 0 + NUM_SIZE/2 +: NUM_SIZE/2];
	assign real_part[1] = s_axis_weight_tdata[NUM_SIZE * 1 +: NUM_SIZE/2];
	assign imag_part[1] = s_axis_weight_tdata[NUM_SIZE * 1 + NUM_SIZE/2 +: NUM_SIZE/2];
	assign real_part[2] = s_axis_weight_tdata[NUM_SIZE * 2 +: NUM_SIZE/2];
	assign imag_part[2] = s_axis_weight_tdata[NUM_SIZE * 2 + NUM_SIZE/2 +: NUM_SIZE/2 ];
	assign real_part[3] = s_axis_weight_tdata[NUM_SIZE * 3 +: NUM_SIZE/2];
	assign imag_part[3] = s_axis_weight_tdata[NUM_SIZE * 3 + NUM_SIZE/2+: NUM_SIZE/2];
	
	wire [15:0] max_real_part[3:0], max_imag_part[3:0];
	
	assign max_real_part[0] = m_axis_max_tdata[NUM_SIZE * 0 +: NUM_SIZE/2];
	assign max_imag_part[0] = m_axis_max_tdata[NUM_SIZE * 0 + NUM_SIZE/2 +: NUM_SIZE/2];
	assign max_real_part[1] = m_axis_max_tdata[NUM_SIZE * 1 +: NUM_SIZE/2];
	assign max_imag_part[1] = m_axis_max_tdata[NUM_SIZE * 1 + NUM_SIZE/2 +: NUM_SIZE/2];
	assign max_real_part[2] = m_axis_max_tdata[NUM_SIZE * 2 +: NUM_SIZE/2];
	assign max_imag_part[2] = m_axis_max_tdata[NUM_SIZE * 2 + NUM_SIZE/2 +: NUM_SIZE/2 ];
	assign max_real_part[3] = m_axis_max_tdata[NUM_SIZE * 3 +: NUM_SIZE/2];
	assign max_imag_part[3] = m_axis_max_tdata[NUM_SIZE * 3 + NUM_SIZE/2+: NUM_SIZE/2];
	
	reg signed [NUM_SIZE+1:0]  current_magnitude, maximum_magnitude;
	reg signed [NUM_SIZE:0]  partial_prod[1:0];
		
	localparam SR_SIZE = 2;
	integer i;
	reg valid_sr[SR_SIZE-1:0], last_sr[SR_SIZE-1:0];
	reg[7:0] user_sr[SR_SIZE-1:0];
	reg[4 * NUM_SIZE - 1:0] data_sr[SR_SIZE-1:0];
		
always@(posedge clk or negedge reset_n)begin
	if(!reset_n)begin	
		for( i = 0; i < SR_SIZE; i= i + 1)begin
			valid_sr[i] <= 0;
			user_sr[i] <= 0;
			last_sr[i] <= 0;
			data_sr[i] <= 0;
		end
	end else begin
		valid_sr[0] <= s_axis_weight_tvalid;
		user_sr[0] <= s_axis_weight_tuser;
		last_sr[0] <= s_axis_weight_tlast;
		data_sr[0] <= s_axis_weight_tdata;
		for( i = 1; i < SR_SIZE; i= i + 1)begin
			valid_sr[i] <= valid_sr[i-1];
			user_sr[i] <= user_sr[i-1];
			last_sr[i] <= last_sr[i-1];
			data_sr[i] <= data_sr[i-1];
		end
	end
end
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			current_magnitude <= 0;
			maximum_magnitude <= 0;
			partial_prod[0] <= 0;
			partial_prod[1] <= 0; 
			m_axis_max_tdata <= 0;
			m_axis_max_tuser <= 0;
			s_axis_weight_tready <= 0;
		end else begin
			if(s_axis_weight_tvalid && s_axis_weight_tuser[7])begin //only selects frequencies >= 128
				partial_prod[1] <= imag_part[0] * imag_part[0];
				partial_prod[0] <= real_part[0] * real_part[0];
			end else begin
				partial_prod[0] <= 0;
				partial_prod[1] <= 0;
			end
			
			if(valid_sr[0] && user_sr[0][7])begin
				current_magnitude <= partial_prod[0] + partial_prod[1];
			end else begin
				current_magnitude <= 0;
			end

			if(current_magnitude > maximum_magnitude)begin
				m_axis_max_tdata <= data_sr[1];
				m_axis_max_tuser <= user_sr[1];
				maximum_magnitude <= current_magnitude;
			end
			else begin
				m_axis_max_tdata <= m_axis_max_tdata;
				m_axis_max_tuser <= m_axis_max_tuser;
				maximum_magnitude <= maximum_magnitude;
			end				

			s_axis_weight_tready <= m_axis_max_tready;
			m_axis_max_tlast <= last_sr[1];
			m_axis_max_tvalid <= last_sr[1];

		end
	end

	
endmodule


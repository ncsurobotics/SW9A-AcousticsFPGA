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

module bartlett_datapath #(
	parameter NUM_SIZE = 32  //bits per complex number.EX: NUM_SIZE = 32. num = {imag_16,real_16}
	) (
    input clk,
    input reset_b,
	
    input [NUM_SIZE * 4 - 1:0] s_axis_tdata,
    input s_axis_tvalid,
    output s_axis_tready,
    input s_axis_tlast,
		
	input[8 + 8 + 32 - 1 : 0] s_axis_config_tdata, // {upper frequency bound 8, lower frequency bound 8 , magnitude threshold 32}
	input[5:0] s_axis_config_tstrb,
	input s_axis_config_tvalid,
	output s_axis_config_tready,

	// max theta output channel
	output[$clog2(`THETA_COUNT) - 1:0]  m_axis_max_tdata, 
	output m_axis_max_tvalid, m_axis_max_tuser, m_axis_max_tlast,
	input m_axis_max_tready,
	
	// all thetas output channel
	output[`THETA_COUNT * NUM_SIZE - 1:0]  m_axis_all_tdata, 
	output m_axis_all_tvalid, m_axis_all_tuser, m_axis_all_tlast,
	input m_axis_all_tready,
	

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
		
		
	
	
	wire[4:0] s_axis_theta_tdata;
	
	theta_driver theta_driver_inst(
		.clk(clk),
		.reset_n(reset_b),
		
		.enable(s_axis_theta_tready),
		
		.m_axis_theta_tdata(s_axis_theta_tdata),
		.m_axis_theta_tlast(s_axis_theta_tlast),
		//.m_axis_theta_tuser(s_axis_theta_tuser),
		.m_axis_theta_tvalid(s_axis_theta_tvalid)
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
		
		.s_axis_theta_tdata(s_axis_theta_tdata),
		.s_axis_theta_tlast(s_axis_theta_tlast),
		.s_axis_theta_tready(s_axis_theta_tready),
		.s_axis_theta_tuser(s_axis_theta_tuser),
		.s_axis_theta_tvalid(s_axis_theta_tvalid),
		
		.m_axis_max_tdata(m_axis_max_tdata),
        .m_axis_max_tvalid(m_axis_max_tvalid),
        .m_axis_max_tuser(m_axis_max_tuser),
        .m_axis_max_tlast(m_axis_max_tlast),
        .m_axis_max_tready(m_axis_max_tready),
		
		.m_axis_all_tdata(m_axis_all_tdata),
        .m_axis_all_tvalid(m_axis_all_tvalid),
        .m_axis_all_tuser(m_axis_all_tuser),
        .m_axis_all_tlast(m_axis_all_tlast),
        .m_axis_all_tready(m_axis_all_tready),
		
		.debug_rxx(debug_rxx),
		.debug_rxx_valid(debug_rxx_valid)
	);
		

endmodule

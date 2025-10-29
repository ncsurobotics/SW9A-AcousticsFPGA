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
	
    input [NUM_SIZE * 4 - 1:0] x_s_axis_data_tdata,
    input x_s_axis_data_tvalid,
    output x_s_axis_data_tready,
    input x_s_axis_data_tlast,
/*
	// theta input channel
	input[$clog2(`THETA_COUNT) - 1: 0] s_axis_theta_tdata, // theta_store[s_axis_theta_tdata] 
	input s_axis_theta_tvalid, s_axis_theta_tlast, s_axis_theta_tuser, //tlast is overwritten
	output s_axis_theta_tready,
	*/
	input theta_enable,
	
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
	
	output [NUM_SIZE * 4:0] debug_fft, debug_filtered_fft,
	output debug_fft_valid, debug_filtered_fft_valid

    );

	wire[NUM_SIZE * 4 - 1:0] ifft_m_axis_data_tdata;
	wire[NUM_SIZE * 4 - 1:0]  m_axis_hilbert_tdata;
	wire x_m_axis_data_tvalid;
	
	assign x_s_axis_data_tready = 1;
	
	hilbert_fir_filter_axis_wrapper #(
		.FIR_LATENCY(13)
		) hilbert_inst(
		.clk(clk),
		.reset_n(reset_b),
		.clk_enable(1),
		
		.s_axis_tdata(x_s_axis_data_tdata),
        .s_axis_tvalid(x_s_axis_data_tvalid),
		.s_axis_tlast(x_s_axis_data_tlast),

        .m_axis_tdata(ifft_m_axis_data_tdata),
        .m_axis_tvalid(ifft_m_axis_data_tvalid),
		.m_axis_tlast(ifft_m_axis_data_tlast)
		);
	
	
	
	
	wire[4:0] s_axis_theta_tdata;
	
	theta_driver theta_driver_inst(
		.clk(clk),
		.reset_n(reset_b),
		
		.enable(s_axis_theta_tready),
		
		.m_axis_theta_tdata(s_axis_theta_tdata),
		.m_axis_theta_tlast(s_axis_theta_tlast),
		.m_axis_theta_tuser(s_axis_theta_tuser),
		.m_axis_theta_tvalid(s_axis_theta_tvalid)
		);

	type_converter #(
		.INT_SIZE(NUM_SIZE/2)
		) type_converter_inst (
		
		.clk(clk),
		.reset_n(reset_b),
		
		.s_axis_tdata(ifft_m_axis_data_tdata),
        .s_axis_tvalid(ifft_m_axis_data_tvalid),
        .s_axis_tready(ifft_m_axis_data_tready),
        .s_axis_tlast(ifft_m_axis_data_tlast),
		.s_axis_tuser(0),
		
		.m_axis_tdata (m_axis_hilbert_tdata),
		.m_axis_tlast (m_axis_hilbert_tlast),
		.m_axis_tuser (m_axis_hilbert_tuser),
		.m_axis_tvalid(m_axis_hilbert_tvalid),
		.m_axis_tready(m_axis_hilbert_tready)
		);		
		
	
	bartlett_time_domain #(
		.NUM_SIZE(NUM_SIZE)
		) bartlett_time_domain_inst (
		
		.clk(clk),
		.reset_n(reset_b),
		
		.s_axis_fft_tdata (m_axis_hilbert_tdata),
		.s_axis_fft_tvalid(m_axis_hilbert_tvalid),
		.s_axis_fft_tlast (m_axis_hilbert_tlast),
		.s_axis_fft_tready(m_axis_hilbert_tready),
		.s_axis_fft_tuser(m_axis_hilbert_tuser),
		
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

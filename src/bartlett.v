`timescale 1ns/1ps


`include "constants.vh"

module bartlett_time_domain #(
	parameter NUM_SIZE = 32  //bits per complex number.EX: NUM_SIZE = 32. num = {imag_16,real_16}
	) (
	input clk, reset_n,
	
	// 4x256 matrix input channel
	input[`MATRIX_SIZE * NUM_SIZE - 1 : 0] s_axis_fft_tdata, //MSB->LSB{channel_3, channel_2, channel_1, channel_0}
	input s_axis_fft_tvalid, s_axis_fft_tlast, s_axis_fft_tuser,
	output s_axis_fft_tready,
	
	// theta input channel
	input[$clog2(`THETA_COUNT) - 1: 0] s_axis_theta_tdata, // theta_store[s_axis_theta_tdata] 
	input s_axis_theta_tvalid, s_axis_theta_tlast, s_axis_theta_tuser, //tlast is overwritten
	output s_axis_theta_tready,
	
	// max theta output channel
	output[$clog2(`THETA_COUNT) - 1:0]  m_axis_max_tdata, 
	output m_axis_max_tvalid, m_axis_max_tuser, m_axis_max_tlast,
	input m_axis_max_tready,
	
	// all thetas output channel
	output[`THETA_COUNT * NUM_SIZE - 1:0]  m_axis_all_tdata, 
	output m_axis_all_tvalid, m_axis_all_tuser, m_axis_all_tlast,
	input m_axis_all_tready	
	);
	
	
wire [`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE - 1:0] rxx_data;
    wire rxx_valid, rxx_last, rxx_user, rxx_ready;
	wire [NUM_SIZE - 1 : 0] m_axis_weight_tdata;

    // Instantiate Rxx computation
    rxx #(
        .NUM_SIZE(NUM_SIZE)
    ) rxx_inst (
        .clk(clk),
        .reset_n(reset_n),
        .clken(1'b1), // Always enabled, can customize

        .s_axis_tdata(s_axis_fft_tdata),
        .s_axis_tvalid(s_axis_fft_tvalid),
        .s_axis_tlast(s_axis_fft_tlast),
        .s_axis_tuser(s_axis_fft_tuser),
        .s_axis_tready(s_axis_fft_tready),

        .m_axis_tdata(rxx_data),
        .m_axis_tvalid(rxx_valid),
        .m_axis_tuser(rxx_user),
        .m_axis_tlast(rxx_last),
        .m_axis_tready(rxx_ready)
    );

    // Instantiate P_theta computation
    p_theta #(
        .NUM_SIZE(NUM_SIZE)
    ) p_theta_inst (
        .clk(clk),
        .reset_n(reset_n),

        .s_axis_r_tdata(rxx_data),
        .s_axis_r_tvalid(rxx_valid),
        .s_axis_r_tlast(rxx_last),
        .s_axis_r_tuser(rxx_user),
        .s_axis_r_tready(rxx_ready),

        .s_axis_theta_tdata(s_axis_theta_tdata),
        .s_axis_theta_tvalid(s_axis_theta_tvalid),
        .s_axis_theta_tlast(s_axis_theta_tlast),
        .s_axis_theta_tuser(s_axis_theta_tuser),
        .s_axis_theta_tready(s_axis_theta_tready),

        .m_axis_tdata(m_axis_weight_tdata),
        .m_axis_tvalid(m_axis_weight_tvalid),
        .m_axis_tuser(m_axis_weight_tuser),
        .m_axis_tlast(m_axis_weight_tlast),
        .m_axis_tready(m_axis_weight_tready)
    );
	
	
	output_store #(
		.NUM_SIZE(NUM_SIZE)
		) 
	output_store_inst (
		.clk(clk),
		.reset_n(reset_n),

        .s_axis_weight_tdata(m_axis_weight_tdata),
        .s_axis_weight_tvalid(m_axis_weight_tvalid),
        .s_axis_weight_tlast(m_axis_weight_tlast),
        .s_axis_weight_tuser(m_axis_weight_tuser),
        .s_axis_weight_tready(m_axis_weight_tready),

        .s_axis_theta_tdata(s_axis_theta_tdata),
        .s_axis_theta_tvalid(s_axis_theta_tvalid),
        .s_axis_theta_tlast(s_axis_theta_tlast),
        .s_axis_theta_tuser(s_axis_theta_tuser),
        .s_axis_theta_tready(s_axis_theta_tready),

        .m_axis_all_tdata(m_axis_all_tdata),
        .m_axis_all_tvalid(m_axis_all_tvalid),
        .m_axis_all_tuser(m_axis_all_tuser),
        .m_axis_all_tlast(m_axis_all_tlast),
        .m_axis_all_tready(m_axis_all_tready)
		);
		
		
		
	max #(
		.NUM_SIZE(NUM_SIZE)
		) 
	max_inst (
		.clk(clk),
		.reset_n(reset_n),
		
        .s_axis_weight_tdata(m_axis_weight_tdata),
        .s_axis_weight_tvalid(m_axis_weight_tvalid),
        .s_axis_weight_tlast(m_axis_weight_tlast),
        .s_axis_weight_tuser(m_axis_weight_tuser),
        .s_axis_weight_tready(m_axis_weight_tready),

        .s_axis_theta_tdata(s_axis_theta_tdata),
        .s_axis_theta_tvalid(s_axis_theta_tvalid),
        .s_axis_theta_tlast(s_axis_theta_tlast),
        .s_axis_theta_tuser(s_axis_theta_tuser),
        .s_axis_theta_tready(s_axis_theta_tready),

        .m_axis_max_tdata(m_axis_max_tdata),
        .m_axis_max_tvalid(m_axis_max_tvalid),
        .m_axis_max_tuser(m_axis_max_tuser),
        .m_axis_max_tlast(m_axis_max_tlast),
        .m_axis_max_tready(m_axis_max_tready)
		);
		
	
	
endmodule
	

	
	
	


 `timescale 1ns/1ps


`include "constants.vh"

module bartlett_time_domain #(
	parameter NUM_SIZE = 64  //bits per complex number.EX: NUM_SIZE = 32. num = {imag_16,real_16}
	) (
	input clk, reset_n,
	
	// 4x256 matrix input channel
	input[`MATRIX_SIZE * NUM_SIZE - 1 : 0] s_axis_fft_tdata, //MSB->LSB{channel_3, channel_2, channel_1, channel_0}
	input s_axis_fft_tvalid, s_axis_fft_tlast, s_axis_fft_tuser,
	output s_axis_fft_tready,
	

	output [31 : 0] m_axis_tdata,
	output m_axis_tvalid, m_axis_tlast,
	output[7:0] m_axis_tdest,
	
	output [NUM_SIZE - 1:0] debug_rxx,
	output debug_rxx_valid
	
	);
	
	// max theta output channel
	wire[$clog2(`THETA_COUNT) - 1:0]  m_axis_max_tdata;
	wire m_axis_max_tvalid, m_axis_max_tlast;
	
	
	wire [NUM_SIZE - 1:0] rxx_data;
    wire rxx_valid,rxx_ready;
	wire[3:0] rxx_tid;
	wire [NUM_SIZE- 1 : 0] m_axis_weight_tdata;
	
	wire[$clog2(`THETA_COUNT)-1:0] rxx_user, m_axis_weight_tdest;
	
	assign s_axis_theta_tready = rxx_last;
	assign debug_rxx = rxx_data;
	assign debug_rxx_valid = rxx_valid;

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
        .s_axis_tready(s_axis_fft_tready),

        .m_axis_tdata(rxx_data),
        .m_axis_tvalid(rxx_valid),
        .m_axis_tready(rxx_ready),
		.m_axis_tlast(rxx_last),
		.m_axis_tid(rxx_tid)
    );


    // Instantiate P_theta computation
    p_theta #(
        .NUM_SIZE(NUM_SIZE)
    ) p_theta_inst (
        .clk(clk),
        .reset_n(reset_n),
		.clken(1'b1),

        .s_axis_r_tdata(rxx_data),
        .s_axis_r_tvalid(rxx_valid),
        .s_axis_r_tlast(rxx_last),
        .s_axis_r_tready(rxx_ready),
		.s_axis_r_tid(rxx_tid),

        .m_axis_tdata(m_axis_weight_tdata),
        .m_axis_tvalid(m_axis_weight_tvalid),
        .m_axis_tdest(m_axis_weight_tdest), //theta
        .m_axis_tlast(m_axis_weight_tlast),
        .m_axis_tready(m_axis_weight_tready)
    );
	
		
	max #(
		.NUM_SIZE(NUM_SIZE)
		) 
	max_inst (
		.clk(clk),
		.reset_n(reset_n),
		
        .s_axis_tdata(m_axis_weight_tdata),
        .s_axis_tvalid(m_axis_weight_tvalid),
        .s_axis_tlast(m_axis_weight_tlast),
        .s_axis_tuser(m_axis_weight_tdest),
        .s_axis_tready(m_axis_weight_tready),
		
        .m_axis_max_tdata(m_axis_max_tdata),
        .m_axis_max_tvalid(m_axis_max_tvalid),
        .m_axis_max_tlast(m_axis_max_tlast)
		);
		
	assign m_axis_tdata = m_axis_max_tvalid ? m_axis_max_tdata : m_axis_weight_tdata;
	assign m_axis_tvalid = m_axis_max_tvalid | m_axis_weight_tvalid;
	assign m_axis_tlast = m_axis_max_tvalid ? m_axis_max_tlast : m_axis_weight_tlast;
	assign m_axis_tdest = m_axis_max_tvalid ? `THETA_COUNT : m_axis_weight_tdest;
	
endmodule
	

	
	
	


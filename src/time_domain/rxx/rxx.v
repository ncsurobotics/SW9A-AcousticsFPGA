`timescale 1ns/1ps

`include "constants.vh"

module rxx #(
	parameter NUM_SIZE = 32 //bits per complex number.EX: NUM_SIZE = 32. num = {imag_16,real_16}
	) (
	input clk, reset_n, clken,
	
	// 4x256 matrix input channel
	input[`MATRIX_SIZE * NUM_SIZE - 1 : 0] s_axis_tdata, //MSB->LSB{channel_3, channel_2, channel_1, channel_0}
	input s_axis_tvalid, s_axis_tlast, 
	output s_axis_tready,
	
	// 4 x 4 matrix output channel
	output[`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE - 1:0]  m_axis_tdata, //MSB->LSB{r44, r43, r42... r00}
	output m_axis_tvalid, m_axis_tlast,
	input m_axis_tready
	);
	

covariance_matrix #(
	.NUM_SIZE(NUM_SIZE)
	) covariance_matrix_inst(
	.clk(clk),
	.reset_n(reset_n),
	
	.s_axis_tdata(s_axis_tdata),
	.s_axis_tvalid(s_axis_tvalid),
	.s_axis_tready(s_axis_tready),
	.m_axis_tdata(m_axis_tdata),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tready(m_axis_tready)
	);




endmodule

	
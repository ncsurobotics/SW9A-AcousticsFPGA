`timescale 1ns/1ps


`include "constants.vh"


module p_theta #(
	parameter NUM_SIZE = 32 //bits per complex number.EX: NUM_SIZE = 32. num = {imag_16,real_16}
	) (
	input clk, reset_n, clken,
	
	// 4x4 matrix input channel
	input[`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE - 1 : 0] s_axis_r_tdata, //MSB->LSB{channel_3, channel_2, channel_1, channel_0}
	input s_axis_r_tvalid, s_axis_r_tlast, //tlast is overwritten
	output s_axis_r_tready,
	
	// theta input channel
	input[$clog2(`THETA_COUNT) - 1: 0] s_axis_theta_tdata, // theta_store[s_axis_theta_tdata] 
	input s_axis_theta_tvalid, s_axis_theta_tlast, //tlast is overwritten
	output s_axis_theta_tready,
		
	// 1x1 weight
	output[NUM_SIZE - 1:0]  m_axis_tdata,//real 
	output m_axis_tvalid, m_axis_tlast,
	output[$clog2(`THETA_COUNT) - 1:0] m_axis_tuser,
	input m_axis_tready	
	);
	
	reg theta_valid_buffer, theta_last_buffer;
	reg[$clog2(`THETA_COUNT) - 1: 0] theta_buffer;
	reg[`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE - 1 : 0] r_buffer;

	always@(posedge clk or negedge reset_n)begin
		if(~reset_n) begin
			theta_buffer <= 0;
			r_buffer <= 0;
			theta_valid_buffer <= 0;
			theta_last_buffer <= 0;
		end
		else begin
			theta_last_buffer <= s_axis_theta_tlast;
			
			if(s_axis_theta_tvalid) theta_buffer <= s_axis_theta_tdata;
			else theta_buffer <= theta_buffer;
			
			if(s_axis_r_tvalid) r_buffer <= s_axis_r_tdata;
			else r_buffer <= r_buffer;
			
			theta_valid_buffer <= s_axis_theta_tvalid;
		end
	end
	
	wire[`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE - 1 : 0] s_sh_theta;
	
	s_theta_16 s_theta_inst(
		.theta(theta_buffer),
		.s_sh_theta(s_sh_theta)
		);
		

	wire[`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE * 2 - 1 : 0] matrix_tdata;
	wire[$clog2(`THETA_COUNT) - 1: 0] matrix_tuser;

complex_matrix_hadamard #(
	.NUM_SIZE(NUM_SIZE),
	.WIDTH(`MATRIX_SIZE),
	.HEIGHT(`MATRIX_SIZE)
	) 
complex_matrix_hadamard_inst (
	.clk(clk),
	.reset_n(reset_n),
	.clken(clken),
	
	.s_axis_a_tdata(r_buffer),
	.s_axis_a_tvalid(theta_valid_buffer),
	.s_axis_a_tlast(theta_last_buffer), 
	.s_axis_a_tuser(theta_buffer),
	.s_axis_a_tready(s_axis_r_tready),
	
	.s_axis_b_tdata(s_sh_theta),
	.s_axis_b_tvalid(theta_valid_buffer),
	.s_axis_b_tlast(theta_last_buffer),
	.s_axis_b_tuser(theta_buffer),  
	.s_axis_b_tready(s_axis_theta_tready),

	
	.m_axis_tdata(matrix_tdata),
	.m_axis_tvalid(matrix_tvalid),
	.m_axis_tlast(matrix_tlast),
	.m_axis_tuser(matrix_tuser),
	.m_axis_tready(matrix_tready)
	);
	
matrix_accumulator_no_latency_real #(
	.NUM_SIZE(NUM_SIZE * 2)
	) 
matrix_accumulator_no_latency_inst (
	.clk(clk),
	.reset_n(reset_n),
	
	.s_axis_tdata(matrix_tdata),
	.s_axis_tvalid(matrix_tvalid),
	.s_axis_tlast(matrix_tlast),
	.s_axis_tuser(matrix_tuser),
	.s_axis_tready(matrix_tready),
	
	
	.m_axis_tdata(m_axis_tdata),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tlast(m_axis_tlast),
	.m_axis_tuser(m_axis_tuser),
	.m_axis_tready(m_axis_tready)
	);

endmodule

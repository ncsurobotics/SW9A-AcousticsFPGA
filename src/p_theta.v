`timescale 1ns/1ps


`include "constants.vh"


module p_theta #(
	parameter NUM_SIZE = 32 //bits per complex number.EX: NUM_SIZE = 32. num = {imag_16,real_16}
	) (
	input clk, reset_n,
	
	// 4x4 matrix input channel
	input[`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE - 1 : 0] s_axis_r_tdata, //MSB->LSB{channel_3, channel_2, channel_1, channel_0}
	input s_axis_r_tvalid, s_axis_r_tlast, s_axis_r_tuser, //tlast is overwritten
	output s_axis_r_tready,
	
	// theta input channel
	input[$clog2(`THETA_COUNT): 0] s_axis_theta_tdata, // theta_store[s_axis_theta_tdata] 
	input s_axis_theta_tvalid, s_axis_theta_tlast, s_axis_theta_tuser, //tlast is overwritten
	output s_axis_theta_tready,
	
	// 1x1 weight
	output[NUM_SIZE - 1:0]  m_axis_tdata, 
	output m_axis_tvalid, m_axis_tuser, m_axis_tlast,
	input m_axis_tready	
	);
	
	reg[$clog2(`THETA_COUNT): 0] theta_buffer;
	reg[`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE - 1 : 0] r_buffer;
	
	reg s_axis_r_tvalid_buf, s_axis_r_tlast_buf, s_axis_r_tuser_buf;
	reg s_axis_theta_tvalid_buf, s_axis_theta_tlast_buf, s_axis_theta_tuser_buf;
	
	always@(posedge clk or negedge reset_n)begin
		if(~reset_n) begin
			theta_buffer <= 0;
			r_buffer <= 0;
			s_axis_r_tvalid_buf <= 0;
			s_axis_r_tlast_buf <= 0;
			s_axis_r_tuser_buf <= 0;
			s_axis_theta_tvalid_buf <= 0;
			s_axis_theta_tlast_buf <= 0;
			s_axis_theta_tuser_buf <= 0;
		end
		else begin
			if(s_axis_theta_tready & s_axis_theta_tvalid) theta_buffer <= s_axis_theta_tdata;
			else theta_buffer <= theta_buffer;
			
			if(s_axis_r_tready & s_axis_r_tvalid) r_buffer <= s_axis_r_tdata;
			else r_buffer <= r_buffer;
			
			s_axis_r_tvalid_buf <= s_axis_r_tvalid;
			s_axis_r_tlast_buf <= s_axis_r_tlast;
			s_axis_r_tuser_buf <= s_axis_r_tuser;
			s_axis_theta_tvalid_buf <= s_axis_theta_tvalid;
			s_axis_theta_tlast_buf <= s_axis_theta_tlast;
			s_axis_theta_tuser_buf <= s_axis_theta_tuser;
			
		end
	end
	
	localparam S_SH_THETA_0 = 	32'h00010001;
	localparam S_SH_THETA_1 = 	32'h00010001;
	localparam S_SH_THETA_2 = 	32'h00010001;
	localparam S_SH_THETA_3 = 	32'h00010001;
	localparam S_SH_THETA_4 = 	32'h00010001;
	localparam S_SH_THETA_5 = 	32'h00010001;
	localparam S_SH_THETA_6 = 	32'h00010001;
	localparam S_SH_THETA_7 = 	32'h00010001;
	localparam S_SH_THETA_8 = 	32'h00010001;
	localparam S_SH_THETA_9 = 	32'h00010001;
	localparam S_SH_THETA_10 = 	32'h00010001;
	localparam S_SH_THETA_11 = 	32'h00010001;
	localparam S_SH_THETA_12 = 	32'h00010001;
	localparam S_SH_THETA_13 = 	32'h00010001;
	localparam S_SH_THETA_14 = 	32'h00010001;
	localparam S_SH_THETA_15 = 	32'h00010001;
	
	
	reg[`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE - 1 : 0] s_sh_theta_matrix[`THETA_COUNT-1:0];
	
	initial begin
		s_sh_theta_matrix[0] 	= S_SH_THETA_0 ;
		s_sh_theta_matrix[1] 	= S_SH_THETA_1 ;
		s_sh_theta_matrix[2] 	= S_SH_THETA_2 ;
		s_sh_theta_matrix[3] 	= S_SH_THETA_3 ;
		s_sh_theta_matrix[4] 	= S_SH_THETA_4 ;
		s_sh_theta_matrix[5] 	= S_SH_THETA_5 ;
		s_sh_theta_matrix[6] 	= S_SH_THETA_6 ;
		s_sh_theta_matrix[7] 	= S_SH_THETA_7 ;
		s_sh_theta_matrix[8] 	= S_SH_THETA_8 ;
		s_sh_theta_matrix[9] 	= S_SH_THETA_9 ;
		s_sh_theta_matrix[10] 	= S_SH_THETA_10;
		s_sh_theta_matrix[11] 	= S_SH_THETA_11;
		s_sh_theta_matrix[12] 	= S_SH_THETA_12;
		s_sh_theta_matrix[13] 	= S_SH_THETA_13;
		s_sh_theta_matrix[14] 	= S_SH_THETA_14;
		s_sh_theta_matrix[15] 	= S_SH_THETA_15;
	end
	
	wire[`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE - 1 : 0] matrix_tdata;
	

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
	.s_axis_a_tvalid(s_axis_r_tvalid_buf),
	.s_axis_a_tlast(s_axis_r_tlast_buf),
	.s_axis_a_tuser(s_axis_r_tuser_buf),
	.s_axis_a_tready(s_axis_r_tready),
	
	.s_axis_b_tdata(s_sh_theta_matrix[theta_buffer]),
	.s_axis_b_tvalid(s_axis_theta_tvalid_buf),
	.s_axis_b_tlast(s_axis_theta_tlast_buf),
	.s_axis_b_tuser(s_axis_theta_tuser_buf),
	.s_axis_b_tready(s_axis_theta_tready),

	
	.m_axis_tdata(matrix_tdata),
	.m_axis_tvalid(matrix_tvalid),
	.m_axis_tlast(matrix_tlast),
	.m_axis_tuser(matrix_tuser),
	.m_axis_tready(matrix_tready)
	);
	
matrix_accumulator_no_latency #(
	.NUM_SIZE(NUM_SIZE)
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

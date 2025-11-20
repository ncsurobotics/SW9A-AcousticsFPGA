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
	output[`MATRIX_SIZE * NUM_SIZE - 1:0]  m_axis_tdata, //MSB->LSB{r44, r43, r42... r00}
	output m_axis_tvalid, m_axis_tlast,
	input m_axis_tready
	);
	
	wire[NUM_SIZE/2 - 1 :0] real_channel[3:0], imag_channel[3:0];
	assign real_channel[0] = s_axis_tdata[0+:NUM_SIZE/2];
	assign real_channel[1] = s_axis_tdata[1 * NUM_SIZE +:NUM_SIZE/2];
	assign real_channel[2] = s_axis_tdata[2 * NUM_SIZE +:NUM_SIZE/2];
	assign real_channel[3] = s_axis_tdata[3 * NUM_SIZE +:NUM_SIZE/2];
	
	assign imag_channel[0] = s_axis_tdata[NUM_SIZE/2 + 0+:NUM_SIZE/2];
	assign imag_channel[1] = s_axis_tdata[NUM_SIZE/2 + 1 * NUM_SIZE +:NUM_SIZE/2];
	assign imag_channel[2] = s_axis_tdata[NUM_SIZE/2 + 2 * NUM_SIZE +:NUM_SIZE/2];
	assign imag_channel[3] = s_axis_tdata[NUM_SIZE/2 + 3 * NUM_SIZE +:NUM_SIZE/2];
	
	reg[NUM_SIZE - 1 : 0] base[3:0],conj[3:0];
	reg[3:0] index;
	wire[1:0] base_index, conj_index;
	assign conj_index = index[1:0];
	assign base_index = index[3:2];
	reg valid;
	reg state;
	assign m_axis_tlast = index == 4'b1111;
	
	
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			for(i = 0; i < 4; i = i + 1)begin
				base[i] <= 0;
				conj[i] <= 0;
			end
			index <= 0;
			valid <= 0;
			state <= 0;
		end else begin
			state = state ? !m_axis_tlast : s_axis_tvalid; // 0 - idle, 1 - sending data
			index = state && m_axis_tready ? index = index + 1 : index;
			for(i = 0; i < 4; i = i + 1)begin
				base[i] <= {imag_channel[i],real_channel[i]};
				conj[i] <= {-imag_channel[i],real_channel[i]};
			end
		end
	end
	
	
	
complex_vector_multiply_rxx_4 #(
	.NUM_SIZE(NUM_SIZE)
	) complex_vector_multiply_rxx_4_inst(
	.clk(clk),
	.reset_n(reset_n),
	
	.s_axis_a_tdata(base[base_index]),
	.s_axis_a_tvalid(state),
	.s_axis_a_tready(s_axis_tready),
	
	//.s_axis_b_tready(s_axis_tready),
	.s_axis_b_tvalid(state),
	.s_axis_b_tdata(conj[conj_index]),
	
	.m_axis_tdata(m_axis_tdata),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tready(m_axis_tready)
	);




endmodule

	
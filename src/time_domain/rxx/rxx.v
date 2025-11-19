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
	input m_axis_tready,
	
	output[`MATRIX_SIZE * `MATRIX_SIZE * NUM_SIZE * 2 - 1 : 0] debug_mid,
	output debug_mid_valid
	
	);
	
	assign debug_mid = mid_tdata;
	assign debug_mid_valid = mid_tvalid;

// mult -> addition -> scalar divide
// complex_matrix_multiplier_zeroed -> scalar_divide_const
assign m_axis_tvalid = m_axis_tvalid_buf & m_axis_tlast;
	
wire mid_tlast, mid_tvalid;
wire[`MATRIX_SIZE * `MATRIX_SIZE * (NUM_SIZE * 2) - 1: 0] mid_tdata; 
/*
wire[`MATRIX_SIZE * `MATRIX_SIZE * (NUM_SIZE * 2) - 1:0] m_axis_tdata_buf;//larger buffer to prevent overflow
genvar i;
generate
for(i = 0; i < `MATRIX_SIZE * `MATRIX_SIZE; i = i + 1)begin
	assign m_axis_tdata[NUM_SIZE * i +: NUM_SIZE] = {
	m_axis_tdata_buf[(NUM_SIZE * 2) * i + NUM_SIZE +: NUM_SIZE/2], 
	m_axis_tdata_buf[(NUM_SIZE * 2) * i +: NUM_SIZE/2]
	};
end
endgenerate 
*/	
	
	shift_register #(
		.SIZE(1),.STAGES(1)
		) self_reset_sr(
		.clk(clk),
		.reset_n(reset_n),
		.din(mid_tvalid),
		.dout(self_reset),
		.enable(1)
		);
		
complex_matrix_multiplier #(
	.NUM_SIZE(NUM_SIZE)
	)
complex_matrix_multiplier_inst(
	.clk(clk),
	.reset_n(reset_n && !self_reset),
	.clken(clken),
	
	.channel_0_base(s_axis_tdata[0 * NUM_SIZE +: NUM_SIZE]),
	.channel_1_base(s_axis_tdata[1 * NUM_SIZE +: NUM_SIZE]),
	.channel_2_base(s_axis_tdata[2 * NUM_SIZE +: NUM_SIZE]),
	.channel_3_base(s_axis_tdata[3 * NUM_SIZE +: NUM_SIZE]),
	
	.s_axis_tvalid(s_axis_tvalid),
	.s_axis_tlast(s_axis_tlast),
	.s_axis_tuser(0),
	.s_axis_tready(s_axis_tready),
	
	.m_axis_dout_tready(mid_tready),
	.m_axis_dout_tlast(mid_tlast),
	//.m_axis_dout_tuser(mid_tuser),
	.m_axis_dout_tvalid(mid_tvalid),
	
	.result_matrix_0_0(mid_tdata[15 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]), 
    .result_matrix_0_1(mid_tdata[14 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_0_2(mid_tdata[13 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_0_3(mid_tdata[12 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_1_0(mid_tdata[11 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_1_1(mid_tdata[10 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_1_2(mid_tdata[9 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_1_3(mid_tdata[8 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_2_0(mid_tdata[7 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_2_1(mid_tdata[6 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_2_2(mid_tdata[5 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_2_3(mid_tdata[4 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_3_0(mid_tdata[3 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_3_1(mid_tdata[2 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_3_2(mid_tdata[1 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)]),
    .result_matrix_3_3(mid_tdata[0 * (2 * NUM_SIZE) +: (2 * NUM_SIZE)])
);

// debug, non synthesized
wire [NUM_SIZE -1 :0] real_values[15:0], imag_values[15:0];

assign real_values[0] = mid_tdata[0 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[1] = mid_tdata[1 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[2] = mid_tdata[2 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[3] = mid_tdata[3 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[4] = mid_tdata[4 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[5] = mid_tdata[5 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[6] = mid_tdata[6 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[7] = mid_tdata[7 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[8] = mid_tdata[8 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[9] = mid_tdata[9 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[10] = mid_tdata[10 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[11] = mid_tdata[11 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[12] = mid_tdata[12 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[13] = mid_tdata[13 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[14] = mid_tdata[14 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign real_values[15] = mid_tdata[15 * (2 * NUM_SIZE) +:  NUM_SIZE];

assign imag_values[0] = mid_tdata[NUM_SIZE + 0 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[1] = mid_tdata[NUM_SIZE + 1 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[2] = mid_tdata[NUM_SIZE + 2 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[3] = mid_tdata[NUM_SIZE + 3 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[4] = mid_tdata[NUM_SIZE + 4 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[5] = mid_tdata[NUM_SIZE + 5 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[6] = mid_tdata[NUM_SIZE + 6 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[7] = mid_tdata[NUM_SIZE + 7 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[8] = mid_tdata[NUM_SIZE + 8 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[9] = mid_tdata[NUM_SIZE + 9 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[10] = mid_tdata[NUM_SIZE + 10 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[11] = mid_tdata[NUM_SIZE + 11 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[12] = mid_tdata[NUM_SIZE + 12 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[13] = mid_tdata[NUM_SIZE + 13 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[14] = mid_tdata[NUM_SIZE + 14 * (2 * NUM_SIZE) +:  NUM_SIZE];
assign imag_values[15] = mid_tdata[NUM_SIZE + 15 * (2 * NUM_SIZE) +:  NUM_SIZE];

	
scalar_divide_const #(
	.MAT_HEIGHT(`MATRIX_SIZE),
	.MAT_WIDTH(`MATRIX_SIZE),
	.NUM_SIZE(NUM_SIZE * 2),
	.SCALAR(256)
	)
scalar_divide_const_inst(
	.clk(clk),
	.reset_n(reset_n),
	
	.s_axis_tdata(mid_tdata),
	.s_axis_tvalid(mid_tvalid),
	.s_axis_tlast(mid_tlast),
	.s_axis_tready(mid_tready),
	
	.m_axis_tdata(m_axis_tdata),
	.m_axis_tvalid(m_axis_tvalid_buf),
	.m_axis_tlast(m_axis_tlast),
	.m_axis_tready(m_axis_tready)
);



endmodule

	
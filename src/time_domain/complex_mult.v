`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2025 12:39:59 AM
// Design Name: 
// Module Name: complex_mult
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

`include "constants.vh"


module complex_matrix_hadamard #(
	parameter NUM_SIZE = 32,
	parameter WIDTH = 4,
	parameter HEIGHT = 4
	) (
	input clk, reset_n, clken,
	
	// Input matrix A 
	input s_axis_a_tvalid, s_axis_a_tlast, 
	input [$clog2(`THETA_COUNT) - 1: 0] s_axis_a_tuser,
	input [NUM_SIZE * WIDTH * HEIGHT - 1 : 0] s_axis_a_tdata,
	output s_axis_a_tready,
	
	// Input matrix B
	input s_axis_b_tvalid, s_axis_b_tlast, 
	input [$clog2(`THETA_COUNT) - 1: 0] s_axis_b_tuser,
	input [NUM_SIZE * WIDTH * HEIGHT - 1 : 0] s_axis_b_tdata,
	output s_axis_b_tready,
	
	//Output matrix 
	output m_axis_tvalid, m_axis_tlast,
	output[$clog2(`THETA_COUNT) - 1: 0]	m_axis_tuser,
	output [NUM_SIZE * 2 * WIDTH * HEIGHT - 1 : 0] m_axis_tdata,
	input m_axis_tready
	);
	
	genvar i;
	
	wire[WIDTH * HEIGHT - 1: 0] s_axis_a_tready_buf, s_axis_b_tready_buf, m_axis_tvalid_buf, m_axis_tlast_buf;
	wire[9: 0] m_axis_tuser_buf[WIDTH * HEIGHT - 1: 0];
	assign s_axis_a_tready = s_axis_a_tready_buf[0];
	assign s_axis_b_tready = s_axis_b_tready_buf[0];
	assign m_axis_tvalid = m_axis_tvalid_buf[0];
	assign m_axis_tlast = m_axis_tlast_buf[0]; 
	assign m_axis_tuser = m_axis_tuser_buf[0][4:0];
	
	wire[NUM_SIZE * 2 - 1:0] matrix[HEIGHT * WIDTH - 1:0];
	assign m_axis_tdata[NUM_SIZE * 2 * 0 +: NUM_SIZE * 2] =  {matrix[0][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[0][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 1 +: NUM_SIZE * 2] =  {matrix[1][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[1][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 2 +: NUM_SIZE * 2] =  {matrix[2][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[2][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 3 +: NUM_SIZE * 2] =  {matrix[3][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[3][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 4 +: NUM_SIZE * 2] =  {matrix[4][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[4][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 5 +: NUM_SIZE * 2] =  {matrix[5][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[5][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 6 +: NUM_SIZE * 2] =  {matrix[6][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[6][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 7 +: NUM_SIZE * 2] =  {matrix[7][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[7][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 8 +: NUM_SIZE * 2] =  {matrix[8][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[8][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 9 +: NUM_SIZE * 2] =  {matrix[9][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[9][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 10 +: NUM_SIZE * 2] = {matrix[10][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[10][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 11 +: NUM_SIZE * 2] = {matrix[11][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[11][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 12 +: NUM_SIZE * 2] = {matrix[12][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[12][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 13 +: NUM_SIZE * 2] = {matrix[13][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[13][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 14 +: NUM_SIZE * 2] = {matrix[14][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[14][NUM_SIZE - 1:0] };
	assign m_axis_tdata[NUM_SIZE * 2 * 15 +: NUM_SIZE * 2] = {matrix[15][NUM_SIZE * 2 - 1:NUM_SIZE] ,matrix[15][NUM_SIZE - 1:0] };
	
	generate
		for(i = 0; i < HEIGHT * WIDTH; i = i + 1) begin // (rows)
			cmpy_1 x_complex_multiplier_0 (
				.aclk(clk),                              // input wire aclk
				.aresetn(reset_n),                       // input wire aresetn
				////.aclken(clken),                           // input wire aclken
				
				.s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
				.s_axis_a_tready(s_axis_a_tready_buf[i]), 		// output wire s_axis_a_tready
				.s_axis_a_tdata(s_axis_a_tdata[NUM_SIZE * i +: NUM_SIZE]),        // input wire [31 : 0] s_axis_a_tdata
				
				.s_axis_a_tuser(s_axis_a_tuser),            // input wire [4 : 0] s_axis_a_tuser
				.s_axis_a_tlast(s_axis_a_tlast),            // input wire s_axis_a_tlast
				
				.s_axis_b_tdata(s_axis_b_tdata[NUM_SIZE * i +: NUM_SIZE]),        // input wire [31 : 0] s_axis_b_tdata
				.s_axis_b_tready(s_axis_b_tready_buf[i]), // output wire s_axis_b_tready
				.s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid
				
				.s_axis_b_tuser(s_axis_b_tuser),            // input wire [4 : 0] s_axis_b_tuser
				.s_axis_b_tlast(s_axis_b_tlast),            // input wire s_axis_b_tlast
				
				.m_axis_dout_tvalid(m_axis_tvalid_buf[i]),  // output wire m_axis_dout_tvalid
				.m_axis_dout_tdata(matrix[i]),    // output wire [63 : 0] m_axis_dout_tdata
				
				.m_axis_dout_tready(m_axis_tready),  // input wire m_axis_dout_tready
				.m_axis_dout_tuser(m_axis_tuser_buf[i]),    // output wire [1 : 0] m_axis_dout_tuser
				.m_axis_dout_tlast(m_axis_tlast_buf[i])   // output wire m_axis_dout_tlast
			);
		end
	endgenerate
endmodule

/*
module no_ip_complex_matrix_hadamard #(
	parameter NUM_SIZE = 32,
	parameter WIDTH = 4,
	parameter HEIGHT = 4
	) (
	input clk, reset_n, clken,
	
	// Input matrix A 
	input s_axis_a_tvalid, s_axis_a_tlast, s_axis_a_tuser,
	input [NUM_SIZE * WIDTH * HEIGHT - 1 : 0] s_axis_a_tdata,
	output s_axis_a_tready,
	
	// Input matrix B
	input s_axis_b_tvalid, s_axis_b_tlast, s_axis_b_tuser,
	input [NUM_SIZE * WIDTH * HEIGHT - 1 : 0] s_axis_b_tdata,
	output s_axis_b_tready,
	
	//Output matrix 
	output m_axis_tvalid, m_axis_tlast,
	output[$clog2(`THETA_COUNT) - 1: 0]	m_axis_tuser,
	output [128 * WIDTH * HEIGHT - 1 : 0] m_axis_tdata,
	input m_axis_tready
	);
	
	genvar i;
	
	wire[WIDTH * HEIGHT - 1: 0] s_axis_a_tready_buf, s_axis_b_tready_buf, m_axis_tvalid_buf, m_axis_tlast_buf;
	wire[$clog2(`THETA_COUNT) - 1: 0] m_axis_tuser_buf[WIDTH * HEIGHT - 1: 0];
	assign s_axis_a_tready = s_axis_a_tready_buf[0];
	assign s_axis_b_tready = s_axis_b_tready_buf[0];
	assign m_axis_tvalid = m_axis_tvalid_buf[0];
	assign m_axis_tlast = m_axis_tuser_buf[0];
	assign m_axis_tuser = m_axis_tlast_buf[0];
	
	wire[127:0] matrix[15:0];
	assign m_axis_tdata[128 * 0 +: 128] =  {matrix[0][127:64],matrix[0][63:0]};
	assign m_axis_tdata[128 * 1 +: 128] =  {matrix[1][127:64],matrix[1][63:0]};
	assign m_axis_tdata[128 * 2 +: 128] =  {matrix[2][127:64],matrix[2][63:0]};
	assign m_axis_tdata[128 * 3 +: 128] =  {matrix[3][127:64],matrix[3][63:0]};
	assign m_axis_tdata[128 * 4 +: 128] =  {matrix[4][127:64],matrix[4][63:0]};
	assign m_axis_tdata[128 * 5 +: 128] =  {matrix[5][127:64],matrix[5][63:0]};
	assign m_axis_tdata[128 * 6 +: 128] =  {matrix[6][127:64],matrix[6][63:0]};
	assign m_axis_tdata[128 * 7 +: 128] =  {matrix[7][127:64],matrix[7][63:0]};
	assign m_axis_tdata[128 * 8 +: 128] =  {matrix[8][127:64],matrix[8][63:0]};
	assign m_axis_tdata[128 * 9 +: 128] =  {matrix[9][127:64],matrix[9][63:0]};
	assign m_axis_tdata[128 * 10 +: 128] = {matrix[10][127:64],matrix[10][63:0]};
	assign m_axis_tdata[128 * 11 +: 128] = {matrix[11][127:64],matrix[11][63:0]};
	assign m_axis_tdata[128 * 12 +: 128] = {matrix[12][127:64],matrix[12][63:0]};
	assign m_axis_tdata[128 * 13 +: 128] = {matrix[13][127:64],matrix[13][63:0]};
	assign m_axis_tdata[128 * 14 +: 128] = {matrix[14][127:64],matrix[14][63:0]};
	assign m_axis_tdata[128 * 15 +: 128] = {matrix[15][127:64],matrix[15][63:0]};
	
	generate
		for(i = 0; i < HEIGHT * WIDTH; i = i + 1) begin // (rows)
			complex_multiplier #(
				.NUM_SIZE(NUM_SIZE)
				) mult_0 (
				.clk(clk),                              // input wire aclk
				.reset_n(reset_n),                       // input wire aresetn
				
				.s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
				.s_axis_a_tready(s_axis_a_tready_buf[i]), 		// output wire s_axis_a_tready
				.s_axis_a_tdata(s_axis_a_tdata[NUM_SIZE * i +: NUM_SIZE]),        // input wire [31 : 0] s_axis_a_tdata
				
				.s_axis_a_tuser(s_axis_a_tuser),            // input wire [0 : 0] s_axis_a_tuser
				.s_axis_a_tlast(s_axis_a_tlast),            // input wire s_axis_a_tlast
				
				.s_axis_b_tdata(s_axis_b_tdata[NUM_SIZE * i +: NUM_SIZE]),        // input wire [31 : 0] s_axis_b_tdata
				.s_axis_b_tready(s_axis_b_tready_buf[i]), // output wire s_axis_b_tready
				.s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid
				
				.s_axis_b_tuser(s_axis_b_tuser),            // input wire [0 : 0] s_axis_b_tuser
				.s_axis_b_tlast(s_axis_b_tlast),            // input wire s_axis_b_tlast
				
				.m_axis_dout_tvalid(m_axis_tvalid_buf[i]),  // output wire m_axis_dout_tvalid
				.m_axis_dout_tdata(matrix[i]),    // output wire [63 : 0] m_axis_dout_tdata
				
				.m_axis_dout_tready(m_axis_tready),  // input wire m_axis_dout_tready
				.m_axis_dout_tuser(m_axis_tuser_buf[i]),    // output wire [1 : 0] m_axis_dout_tuser
				.m_axis_dout_tlast(m_axis_tlast_buf[i])   // output wire m_axis_dout_tlast
			);
		end
	endgenerate
endmodule

*/
/*
module complex_matrix_multiplier_axi #(
	parameter NUM_SIZE = 32,
	parameter WIDTH = 4
	) (
	input clk, reset_n, clken,
	
	// Input matrix A (WIDTH x 1)
	input s_axis_a_tvalid, s_axis_a_tlast, s_axis_a_tuser,
	input [NUM_SIZE * WIDTH - 1 : 0] s_axis_a_tdata,
	output s_axis_b_atready,
	
	// Input matrix B (1 x WIDTH)
	input s_axis_b_tvalid, s_axis_b_tlast, s_axis_b_tuser,
	input [NUM_SIZE * WIDTH - 1 : 0] s_axis_b_tdata,
	output s_axis_b_tready,
	
	//Output matrix (WIDTH x WIDTH)
	output m_axis_tvalid, m_axis_tlast, m_axis_tuser,
	output [NUM_SIZE * WIDTH * WIDTH - 1 : 0] m_axis_tdata,
	input m_axis_tready
	);
	
	genvar i, j;
	
	generate
		for(i = 0; i < WIDTH; i = i + 1)begin // WIDTH x 1 (rows)
			for(j = 0; j < WIDTH; j = j + 1)begin // 1 x WIDTH (cols)
				wire first = (i == 0) && (j == 0);
				cmpy_1 x_complex_multiplier (
				.aclk(clk),                              // input wire aclk
				.aresetn(reset_n),                       // input wire aresetn
				//.aclken(clken),                           // input wire aclken
				
				.s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
				.s_axis_a_tready(first ? s_axis_a_tready : 0), 		// output wire s_axis_a_tready
				.s_axis_a_tdata(s_axis_a_tdata[NUM_SIZE * i +: NUM_SIZE]),        // input wire [31 : 0] s_axis_a_tdata
				
				.s_axis_a_tuser(s_axis_a_tuser),            // input wire [0 : 0] s_axis_a_tuser
				.s_axis_a_tlast(s_axis_a_tlast),            // input wire s_axis_a_tlast
				
				.s_axis_b_tdata(s_axis_b_tdata[NUM_SIZE * j +: NUM_SIZE]),        // input wire [31 : 0] s_axis_b_tdata
				.s_axis_b_tready(first ? s_axis_b_tready : 0), // output wire s_axis_b_tready
				.s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid
				
				.s_axis_b_tuser(s_axis_b_tuser),            // input wire [0 : 0] s_axis_b_tuser
				.s_axis_b_tlast(s_axis_b_tlast),            // input wire s_axis_b_tlast
				
				.m_axis_dout_tvalid(first ? m_axis_tvalid : 0),  // output wire m_axis_dout_tvalid
				.m_axis_dout_tdata(m_axis_tdata[(i * WIDTH + j) * NUM_SIZE +: NUM_SIZE]),    // output wire [63 : 0] m_axis_dout_tdata
				
				.m_axis_dout_tready(m_axis_tready),  // input wire m_axis_dout_tready
				.m_axis_dout_tuser(first ? m_axis_tuser : 0),    // output wire [1 : 0] m_axis_dout_tuser
				.m_axis_dout_tlast(first ? m_axis_tlast : 0)   // output wire m_axis_dout_tlast
				);
			end
		end	
	endgenerate
endmodule*/


module covariance_matrix #(
	parameter NUM_SIZE = 32
	) (
	input clk, reset_n,
	input [NUM_SIZE * 4 - 1 : 0] s_axis_tdata, 
	input s_axis_tvalid, 
	output s_axis_tready,
	
	output[NUM_SIZE * 16 - 1 : 0] m_axis_tdata,
	output m_axis_tvalid, 
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
	reg valid;
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			for(i = 0; i < 4; i = i + 1)begin
				base[i] <= 0;
				conj[i] <= 0;
			end
			valid <= 0;
		end else begin
			valid <= s_axis_tvalid;
			for(i = 0; i < 4; i = i + 1)begin
				base[i] <= {imag_channel[i],real_channel[i]};
				conj[i] <= {-imag_channel[i],real_channel[i]};
			end
		end
	end
	
	wire[15:0] ready_wires, valid_wires;
	assign s_axis_tready = ready_wires[0];
	assign m_axis_tvalid = valid_wires[0];
	
	genvar j;
	genvar k;
	generate
	for(j = 0; j < 4; j = j + 1)begin
		for(k = 0; k < 4; k = k + 1)begin
cmpy_rxx your_instance_name (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                        // input wire aresetn
  .s_axis_a_tvalid(valid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(ready_wires[(j*4+k)]),        // output wire s_axis_a_tready
  .s_axis_a_tdata(base[j]),          // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(valid),        // input wire s_axis_b_tvalid
  //.s_axis_b_tready(s_axis_b_tready),        // output wire s_axis_b_tready
  .s_axis_b_tdata(conj[k]),          // input wire [31 : 0] s_axis_b_tdata
  .m_axis_dout_tvalid(valid_wires[(j * 4 + k)]),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tready(m_axis_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tdata(m_axis_tdata[(j * 4 + k)*NUM_SIZE +: NUM_SIZE])    // output wire [31 : 0] m_axis_dout_tdata
);
		end
	end
	endgenerate
	
	
endmodule


module complex_matrix_multiplier #(
	parameter NUM_SIZE = 32
	) (
	input clk, reset_n, clken,
	input s_axis_tvalid, s_axis_tlast, 
	input [$clog2(`THETA_COUNT) - 1: 0] s_axis_tuser,
	input m_axis_dout_tready,
	output reg m_axis_dout_tvalid, s_axis_tready, m_axis_dout_tlast, 
	output reg [$clog2(`THETA_COUNT) - 1: 0] m_axis_dout_tuser,
	
	input[NUM_SIZE-1:0] channel_0_base,
	input[NUM_SIZE-1:0] channel_1_base,
	input[NUM_SIZE-1:0] channel_2_base,
	input[NUM_SIZE-1:0] channel_3_base,
	
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_0_0,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_0_1,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_0_2,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_0_3,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_1_0,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_1_1,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_1_2,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_1_3,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_2_0,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_2_1,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_2_2,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_2_3,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_3_0,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_3_1,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_3_2,
	output reg signed[NUM_SIZE * 2 - 1:0] result_matrix_3_3
	);
	
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_0_0;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_0_1;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_0_2;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_0_3;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_1_0;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_1_1;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_1_2;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_1_3;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_2_0;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_2_1;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_2_2;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_2_3;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_3_0;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_3_1;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_3_2;
	wire[NUM_SIZE * 2 - 1:0] next_result_matrix_3_3;
	
	wire m_axis_dout_tvalid_0_0;
	wire m_axis_dout_tvalid_0_1;
	wire m_axis_dout_tvalid_0_2;
	wire m_axis_dout_tvalid_0_3;
	wire m_axis_dout_tvalid_1_0;
	wire m_axis_dout_tvalid_1_1;
	wire m_axis_dout_tvalid_1_2;
	wire m_axis_dout_tvalid_1_3;
	wire m_axis_dout_tvalid_2_0;
	wire m_axis_dout_tvalid_2_1;
	wire m_axis_dout_tvalid_2_2;
	wire m_axis_dout_tvalid_2_3;
	wire m_axis_dout_tvalid_3_0;
	wire m_axis_dout_tvalid_3_1;
	wire m_axis_dout_tvalid_3_2;
	wire m_axis_dout_tvalid_3_3;
	
	wire[9:0] m_axis_dout_tuser_0_0;
	wire[9:0] m_axis_dout_tuser_0_1;
	wire[9:0] m_axis_dout_tuser_0_2;
	wire[9:0] m_axis_dout_tuser_0_3;
	wire[9:0] m_axis_dout_tuser_1_0;
	wire[9:0] m_axis_dout_tuser_1_1;
	wire[9:0] m_axis_dout_tuser_1_2;
	wire[9:0] m_axis_dout_tuser_1_3;
	wire[9:0] m_axis_dout_tuser_2_0;
	wire[9:0] m_axis_dout_tuser_2_1;
	wire[9:0] m_axis_dout_tuser_2_2;
	wire[9:0] m_axis_dout_tuser_2_3;
	wire[9:0] m_axis_dout_tuser_3_0;
	wire[9:0] m_axis_dout_tuser_3_1;
	wire[9:0] m_axis_dout_tuser_3_2;
	wire[9:0] m_axis_dout_tuser_3_3;
	
	
	assign s_axis_a_tvalid = s_axis_tvalid; //The entire system pauses if one cmpy is not ready
	assign s_axis_b_tvalid = s_axis_tvalid; //The entire system pauses if one cmpy is not ready
	
	
	always@(*) s_axis_tready = s_axis_a_tready_0_0 & s_axis_b_tready_0_0; //Assume all have the same ready.
	
	wire signed [NUM_SIZE/2 - 1 : 0] real_channel[3:0], imag_channel[3:0];
	
	assign real_channel[0] = channel_0_base[NUM_SIZE/2 - 1:0];
	assign real_channel[1] = channel_1_base[NUM_SIZE/2 - 1:0];
	assign real_channel[2] = channel_2_base[NUM_SIZE/2 - 1:0];
	assign real_channel[3] = channel_3_base[NUM_SIZE/2 - 1:0];
	
	assign imag_channel[0] = channel_0_base[NUM_SIZE-1: NUM_SIZE/2 ];
	assign imag_channel[1] = channel_1_base[NUM_SIZE-1: NUM_SIZE/2 ];
	assign imag_channel[2] = channel_2_base[NUM_SIZE-1: NUM_SIZE/2 ];
	assign imag_channel[3] = channel_3_base[NUM_SIZE-1: NUM_SIZE/2 ];
	
	
	wire[NUM_SIZE-1:0] channel_0_conj, channel_1_conj, channel_2_conj, channel_3_conj;
	assign channel_0_conj = {-imag_channel[0],real_channel[0]};
	assign channel_1_conj = {-imag_channel[1],real_channel[1]};
	assign channel_2_conj = {-imag_channel[2],real_channel[2]};
	assign channel_3_conj = {-imag_channel[3],real_channel[3]};

	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			result_matrix_0_0 <= 0;
			result_matrix_0_1 <= 0;
			result_matrix_0_2 <= 0;
			result_matrix_0_3 <= 0;
			result_matrix_1_0 <= 0;
			result_matrix_1_1 <= 0;
			result_matrix_1_2 <= 0;
			result_matrix_1_3 <= 0;
			result_matrix_2_0 <= 0;
			result_matrix_2_1 <= 0;
			result_matrix_2_2 <= 0;
			result_matrix_2_3 <= 0;
			result_matrix_3_0 <= 0;
			result_matrix_3_1 <= 0;
			result_matrix_3_2 <= 0;
			result_matrix_3_3 <= 0;
			m_axis_dout_tvalid <= 0;
			m_axis_dout_tuser  <= 0;
			m_axis_dout_tlast  <= 0;
		end
		else begin
	
			result_matrix_0_0 <= m_axis_dout_tvalid_0_0 ? {(result_matrix_0_0[NUM_SIZE +: NUM_SIZE] + next_result_matrix_0_0[NUM_SIZE +: NUM_SIZE]),(result_matrix_0_0[0 +: NUM_SIZE] + next_result_matrix_0_0[0 +: NUM_SIZE])}: {result_matrix_0_0};
			result_matrix_0_1 <= m_axis_dout_tvalid_0_1 ? {(result_matrix_0_1[NUM_SIZE +: NUM_SIZE] + next_result_matrix_0_1[NUM_SIZE +: NUM_SIZE]),(result_matrix_0_1[0 +: NUM_SIZE] + next_result_matrix_0_1[0 +: NUM_SIZE])}: {result_matrix_0_1};
			result_matrix_0_2 <= m_axis_dout_tvalid_0_2 ? {(result_matrix_0_2[NUM_SIZE +: NUM_SIZE] + next_result_matrix_0_2[NUM_SIZE +: NUM_SIZE]),(result_matrix_0_2[0 +: NUM_SIZE] + next_result_matrix_0_2[0 +: NUM_SIZE])}: {result_matrix_0_2};
			result_matrix_0_3 <= m_axis_dout_tvalid_0_3 ? {(result_matrix_0_3[NUM_SIZE +: NUM_SIZE] + next_result_matrix_0_3[NUM_SIZE +: NUM_SIZE]),(result_matrix_0_3[0 +: NUM_SIZE] + next_result_matrix_0_3[0 +: NUM_SIZE])}: {result_matrix_0_3};
			result_matrix_1_0 <= m_axis_dout_tvalid_1_0 ? {(result_matrix_1_0[NUM_SIZE +: NUM_SIZE] + next_result_matrix_1_0[NUM_SIZE +: NUM_SIZE]),(result_matrix_1_0[0 +: NUM_SIZE] + next_result_matrix_1_0[0 +: NUM_SIZE])}: {result_matrix_1_0};
			result_matrix_1_1 <= m_axis_dout_tvalid_1_1 ? {(result_matrix_1_1[NUM_SIZE +: NUM_SIZE] + next_result_matrix_1_1[NUM_SIZE +: NUM_SIZE]),(result_matrix_1_1[0 +: NUM_SIZE] + next_result_matrix_1_1[0 +: NUM_SIZE])}: {result_matrix_1_1};
			result_matrix_1_2 <= m_axis_dout_tvalid_1_2 ? {(result_matrix_1_2[NUM_SIZE +: NUM_SIZE] + next_result_matrix_1_2[NUM_SIZE +: NUM_SIZE]),(result_matrix_1_2[0 +: NUM_SIZE] + next_result_matrix_1_2[0 +: NUM_SIZE])}: {result_matrix_1_2};
			result_matrix_1_3 <= m_axis_dout_tvalid_1_3 ? {(result_matrix_1_3[NUM_SIZE +: NUM_SIZE] + next_result_matrix_1_3[NUM_SIZE +: NUM_SIZE]),(result_matrix_1_3[0 +: NUM_SIZE] + next_result_matrix_1_3[0 +: NUM_SIZE])}: {result_matrix_1_3};
			result_matrix_2_0 <= m_axis_dout_tvalid_2_0 ? {(result_matrix_2_0[NUM_SIZE +: NUM_SIZE] + next_result_matrix_2_0[NUM_SIZE +: NUM_SIZE]),(result_matrix_2_0[0 +: NUM_SIZE] + next_result_matrix_2_0[0 +: NUM_SIZE])}: {result_matrix_2_0};
			result_matrix_2_1 <= m_axis_dout_tvalid_2_1 ? {(result_matrix_2_1[NUM_SIZE +: NUM_SIZE] + next_result_matrix_2_1[NUM_SIZE +: NUM_SIZE]),(result_matrix_2_1[0 +: NUM_SIZE] + next_result_matrix_2_1[0 +: NUM_SIZE])}: {result_matrix_2_1};
			result_matrix_2_2 <= m_axis_dout_tvalid_2_2 ? {(result_matrix_2_2[NUM_SIZE +: NUM_SIZE] + next_result_matrix_2_2[NUM_SIZE +: NUM_SIZE]),(result_matrix_2_2[0 +: NUM_SIZE] + next_result_matrix_2_2[0 +: NUM_SIZE])}: {result_matrix_2_2};
			result_matrix_2_3 <= m_axis_dout_tvalid_2_3 ? {(result_matrix_2_3[NUM_SIZE +: NUM_SIZE] + next_result_matrix_2_3[NUM_SIZE +: NUM_SIZE]),(result_matrix_2_3[0 +: NUM_SIZE] + next_result_matrix_2_3[0 +: NUM_SIZE])}: {result_matrix_2_3};
			result_matrix_3_0 <= m_axis_dout_tvalid_3_0 ? {(result_matrix_3_0[NUM_SIZE +: NUM_SIZE] + next_result_matrix_3_0[NUM_SIZE +: NUM_SIZE]),(result_matrix_3_0[0 +: NUM_SIZE] + next_result_matrix_3_0[0 +: NUM_SIZE])}: {result_matrix_3_0};
			result_matrix_3_1 <= m_axis_dout_tvalid_3_1 ? {(result_matrix_3_1[NUM_SIZE +: NUM_SIZE] + next_result_matrix_3_1[NUM_SIZE +: NUM_SIZE]),(result_matrix_3_1[0 +: NUM_SIZE] + next_result_matrix_3_1[0 +: NUM_SIZE])}: {result_matrix_3_1};
			result_matrix_3_2 <= m_axis_dout_tvalid_3_2 ? {(result_matrix_3_2[NUM_SIZE +: NUM_SIZE] + next_result_matrix_3_2[NUM_SIZE +: NUM_SIZE]),(result_matrix_3_2[0 +: NUM_SIZE] + next_result_matrix_3_2[0 +: NUM_SIZE])}: {result_matrix_3_2};
			result_matrix_3_3 <= m_axis_dout_tvalid_3_3 ? {(result_matrix_3_3[NUM_SIZE +: NUM_SIZE] + next_result_matrix_3_3[NUM_SIZE +: NUM_SIZE]),(result_matrix_3_3[0 +: NUM_SIZE] + next_result_matrix_3_3[0 +: NUM_SIZE])}: {result_matrix_3_3};
			
			
			m_axis_dout_tvalid <= m_axis_dout_tvalid_0_0;
			m_axis_dout_tuser  <= m_axis_dout_tuser_0_0[4:0];
			m_axis_dout_tlast  <= m_axis_dout_tlast_0_0;
		end
	end


cmpy_1 x_complex_multiplier_0_0 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_0_0), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_0_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_0_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_0_0), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_0_0),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_0_0),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_0_0),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_0_0)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_0_1 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_0_1), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_0_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_1_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_0_1), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_0_1),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_0_1),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_0_1),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_0_1)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_0_2 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_0_2), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_0_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_2_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_0_2), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_0_2),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_0_2),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_0_2),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_0_2)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_0_3 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_0_3), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_0_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_3_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_0_3), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_0_3),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_0_3),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_0_3),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_0_3)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_1_0 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_1_0), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_1_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_0_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_1_0), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_1_0),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_1_0),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_1_0),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_1_0)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_1_1 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_1_1), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_1_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_1_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_1_1), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_1_1),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_1_1),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_1_1),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_1_1)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_1_2 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_1_2), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_1_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_2_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_1_2), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_1_2),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_1_2),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_1_2),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_1_2)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_1_3 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_1_3), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_1_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_3_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_1_3), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_1_3),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_1_3),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_1_3),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_1_3)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_2_0 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_2_0), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_2_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_0_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_2_0), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_2_0),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_2_0),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_2_0),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_2_0)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_2_1 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_2_1), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_2_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_1_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_2_1), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_2_1),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_2_1),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_2_1),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_2_1)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_2_2 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_2_2), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_2_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_2_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_2_2), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_2_2),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_2_2),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_2_2),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_2_2)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_2_3 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_2_3), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_2_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_3_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_2_3), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_2_3),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_2_3),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_2_3),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_2_3)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_3_0 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_3_0), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_3_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_0_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_3_0), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_3_0),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_3_0),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_3_0),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_3_0)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_3_1 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_3_1), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_3_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_1_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_3_1), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_3_1),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_3_1),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_3_1),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_3_1)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_3_2 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_3_2), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_3_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_2_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_3_2), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_3_2),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_3_2),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_3_2),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_3_2)   // output wire m_axis_dout_tlast
);
cmpy_1 x_complex_multiplier_3_3 (
  .aclk(clk),                              // input wire aclk
  .aresetn(reset_n),                       // input wire aresetn
  //.aclken(clken),                           // input wire aclken

  .s_axis_a_tvalid(s_axis_a_tvalid),        // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready_3_3), // output wire s_axis_a_tready
  .s_axis_a_tdata(channel_3_base),        // input wire [31 : 0] s_axis_a_tdata

  .s_axis_a_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_a_tuser
  .s_axis_a_tlast(s_axis_tlast),            // input wire s_axis_a_tlast

  .s_axis_b_tdata(channel_3_conj),        // input wire [31 : 0] s_axis_b_tdata
  .s_axis_b_tready(s_axis_b_tready_3_3), // output wire s_axis_b_tready
  .s_axis_b_tvalid(s_axis_b_tvalid),        // input wire s_axis_b_tvalid

  .s_axis_b_tuser(s_axis_tuser),            // input wire [0 : 0] s_axis_b_tuser
  .s_axis_b_tlast(s_axis_tlast),            // input wire s_axis_b_tlast

  .m_axis_dout_tvalid(m_axis_dout_tvalid_3_3),  // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(next_result_matrix_3_3),    // output wire [63 : 0] m_axis_dout_tdata

  .m_axis_dout_tready(m_axis_dout_tready),  // input wire m_axis_dout_tready
  .m_axis_dout_tuser(m_axis_dout_tuser_3_3),    // output wire [1 : 0] m_axis_dout_tuser
  .m_axis_dout_tlast(m_axis_dout_tlast_3_3)   // output wire m_axis_dout_tlast
);




endmodule

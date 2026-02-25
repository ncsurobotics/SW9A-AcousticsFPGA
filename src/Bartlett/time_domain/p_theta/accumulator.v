`timescale 1ns/1ps

`include "constants.vh"


module adder #( // dummy module to make switch to complex adder easier
	parameter NUM_SIZE = 32
	)(
	input[NUM_SIZE-1:0] a, b,
	output[NUM_SIZE:0] sum
	);
	
	assign sum = {a[NUM_SIZE-1],a} + {b[NUM_SIZE-1],b};
	
endmodule

/*
module complex_accumulator #(
	parameter NUM_SIZE = 32
	) (
	input clk, reset_n,
	input [NUM_SIZE -1 : 0] s_axis_tdata,
	input s_axis_tvalid, s_axis_tlast,
	input[3:0] s_axis_tid,
	input [$clog2(`THETA_COUNT) - 1: 0] s_axis_tdest,
	
	output reg[NUM_SIZE -1 : 0] m_axis_tdata,
	output reg m_axis_tvalid, m_axis_tlast,
	output reg [$clog2(`THETA_COUNT) - 1: 0] m_axis_tdest
	);
	
	reg valid_buf, last_buf;
	reg[3:0] tid_buf;
	reg[$clog2(`THETA_COUNT) - 1: 0] dest_buf;
	
	reg[NUM_SIZE - 1:0] sum_buf;
	wire[NUM_SIZE - 1:0] sum_w;
	wire first;
	assign first = &s_axis_tid;
	
	always@(posedge clk or negedge reset_n)begin
		if(~reset_n)begin
			valid_buf <= 0;
			last_buf <= 0;
			tid_buf <= 0;
			dest_buf <= 0;
			
			sum_buf <= 0;
			
			m_axis_tdata <= 0;
			m_axis_tvalid <= 0;
			m_axis_tlast <= 0;
			m_axis_tdest <= 0;
		end else begin
			valid_buf <= s_axis_tvalid;
			last_buf <= s_axis_tlast;
			tid_buf <= s_axis_tid;
			dest_buf <= s_axis_tdest;
			
			sum_buf <= sum_w;
			
			m_axis_tdata <= valid_buf ? sum_buf : m_axis_tdata;
			m_axis_tvalid <= last_buf;
			m_axis_tlast <= last_buf;
			m_axis_tdest <= dest_buf;
		end
	end
	
	complex_adder_saturate #(.ELEMENT_SIZE(NUM_SIZE)) accum(
		.a(s_axis_tdata),
		.b((first ? 0 : sum_buf)),
		.sum(sum_w)
		);
	
endmodule
*/

module real_accumulator #(
	parameter NUM_SIZE = 32
	) (
	input clk, reset_n,
	input [NUM_SIZE -1 : 0] s_axis_tdata,
	input s_axis_tvalid, s_axis_tlast,
	input[3:0] s_axis_tid,
	input [$clog2(`THETA_COUNT) - 1: 0] s_axis_tdest,
	
	output reg[NUM_SIZE -1 : 0] m_axis_tdata,
	output reg m_axis_tvalid, m_axis_tlast,
	output reg [$clog2(`THETA_COUNT) - 1: 0] m_axis_tdest
	);
	
	reg valid_buf[1:0], last_buf[1:0];
	reg[3:0] tid_buf[1:0];
	reg[$clog2(`THETA_COUNT) - 1: 0] dest_buf[1:0];
	
	reg[NUM_SIZE - 1:0] sum_buf;
	wire[NUM_SIZE - 1:0] sum_w;
	wire first, last;
	assign first = !(|s_axis_tid);
	assign last = &s_axis_tid;
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(~reset_n)begin
			for(i = 0; i < 2; i = i + 1)begin
				valid_buf[i] <= 0;
				last_buf[i] <= 0;
				tid_buf[i] <= 0;
				dest_buf[i] <= 0;
			end
			sum_buf <= 0;
			
			m_axis_tdata <= 0;
			m_axis_tvalid <= 0;
			m_axis_tlast <= 0;
			m_axis_tdest <= 0;
		end else begin
			valid_buf[0] <= last & s_axis_tvalid;
			last_buf[0] <= s_axis_tlast;
			tid_buf[0] <= s_axis_tid;
			dest_buf[0] <= s_axis_tdest;

			sum_buf <= sum_w;
			
			m_axis_tdata <= valid_buf[0] ? sum_buf : m_axis_tdata;
			m_axis_tvalid <= valid_buf[0];
			m_axis_tlast <= last_buf[0];
			m_axis_tdest <= valid_buf[0] ? dest_buf[0] : m_axis_tdest;
		end
	end
	
	real_adder_saturate #(.ELEMENT_SIZE(NUM_SIZE)) accum(
		.a(s_axis_tdata),
		.b((first ? 0 : sum_buf)),
		.sum(sum_w)
		);
	
endmodule



module matrix_accumulator_no_latency_real #(
	parameter NUM_SIZE = 32, //element size
	parameter WIDTH = 4 //Matrix width
	)(
	input clk, reset_n,
	input[NUM_SIZE * WIDTH * WIDTH - 1:0] s_axis_tdata,
	
	output reg[NUM_SIZE/2 - 1:0] m_axis_tdata, //no imaginary component
	//TODO implement functional AXI protocol
	input [$clog2(`THETA_COUNT) - 1: 0] s_axis_tuser,
	input s_axis_tvalid, s_axis_tlast,
	output s_axis_tready,
	
	input m_axis_tready,
	output  m_axis_tvalid, m_axis_tlast,
	output[$clog2(`THETA_COUNT) - 1: 0]m_axis_tuser
	);
	
	localparam L0W = 16;//Layer 0 NUM_SIZE
	localparam L1W = 8; // Layer 1 NUM_SIZE
	localparam L2W = 4; // Layer 2 NUM_SIZE
	localparam L3W = 2; // Layer 3 NUM_SIZE
	localparam L4W = 1; // Layer 4 NUM_SIZE
	
	
	wire[NUM_SIZE:0] layer1[L1W-1:0];
	wire[NUM_SIZE+1:0] layer2[L2W-1:0];
	wire[NUM_SIZE+2:0] layer3[L3W-1:0];
	wire[NUM_SIZE+3:0] layer4[L4W-1:0];
	
	
	reg[NUM_SIZE-1:0] matrix[WIDTH * WIDTH - 1:0];

	wire enable = 1;
	
	
shift_register_n #(
	.SIZE(1), .STAGES(1)
	)  s_axis_tready_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din(m_axis_tready),
	.dout(s_axis_tready)
	);
	
shift_register #(
	.SIZE(1), .STAGES(1)
	) tlast_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din(s_axis_tlast),
	.dout(m_axis_tlast)
	);
	
shift_register #(
	.SIZE(1), .STAGES(1)
	) tvalid_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din(s_axis_tvalid),
	.dout(m_axis_tvalid)
	);
	
shift_register #(
	.SIZE($clog2(`THETA_COUNT)), .STAGES(1)
	) tuser_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din(s_axis_tuser),
	.dout(m_axis_tuser)
	);
	


	integer i;

	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n) begin
			m_axis_tdata <= 0;
		end else begin
			m_axis_tdata <= layer4[0] >> 4;
		end
	end
	
	
	always@(*)begin
		for(i = 0; i < WIDTH * WIDTH; i = i + 1)begin
			matrix[i] = {
				{0,s_axis_tdata[NUM_SIZE * i + NUM_SIZE/2 +: NUM_SIZE/2]},
				{0,s_axis_tdata[NUM_SIZE * i +: NUM_SIZE/2]}
				};
		end
	end

	genvar j;
	generate
	for(j = 0; j < L0W; j = j + 2)begin
		adder #(.NUM_SIZE(NUM_SIZE/2)) layer_1_adder(
		.a(matrix[j][NUM_SIZE/2 - 1 :0]),
		.b(matrix[j+1][NUM_SIZE/2 - 1 :0]),
		.sum(layer1[j/2])
		);
	end
	for(j = 0; j < L1W; j = j + 2)begin
		adder #(.NUM_SIZE(NUM_SIZE/2 + 1)) layer_2_adder(
		.a(layer1[j][NUM_SIZE/2:0]),
		.b(layer1[j+1][NUM_SIZE/2:0]),
		.sum(layer2[j/2])
		);
	end
	for(j = 0; j < L2W; j = j + 2)begin
		adder #(.NUM_SIZE(NUM_SIZE/2 + 2)) layer_3_adder(
		.a(layer2[j][NUM_SIZE/2 + 2:0]),
		.b(layer2[j+1][NUM_SIZE/2 + 2:0]),
		.sum(layer3[j/2])
		);
	end
	for(j = 0; j < L3W; j = j + 2)begin
		adder #(.NUM_SIZE(NUM_SIZE/2 + 3)) layer_4_adder(
		.a(layer3[j][NUM_SIZE/2 + 3:0]),
		.b(layer3[j+1][NUM_SIZE/2 + 3:0]),
		.sum(layer4[j/2])
		);
	end
	endgenerate
	
endmodule



module matrix_accumulator_no_latency #(
	parameter NUM_SIZE = 32, //element size
	parameter WIDTH = 4 //Matrix width
	)(
	input clk, reset_n,
	input[NUM_SIZE * WIDTH * WIDTH - 1:0] s_axis_tdata,
	
	output reg[NUM_SIZE - 1:0] m_axis_tdata, //no imaginary component
	//TODO implement functional AXI protocol
	input [$clog2(`THETA_COUNT) - 1: 0] s_axis_tuser,
	input s_axis_tvalid, s_axis_tlast,
	output s_axis_tready,
	
	input m_axis_tready,
	output  m_axis_tvalid, m_axis_tlast,
	output[$clog2(`THETA_COUNT) - 1: 0]m_axis_tuser
	);
	
	localparam L0W = 16;//Layer 0 NUM_SIZE
	localparam L1W = 8; // Layer 1 NUM_SIZE
	localparam L2W = 4; // Layer 2 NUM_SIZE
	localparam L3W = 2; // Layer 3 NUM_SIZE
	localparam L4W = 1; // Layer 4 NUM_SIZE
	
	
	wire[NUM_SIZE-1:0] layer1[L1W-1:0];
	wire[NUM_SIZE-1:0] layer2[L2W-1:0];
	wire[NUM_SIZE-1:0] layer3[L3W-1:0];
	wire[NUM_SIZE-1:0] layer4[L4W-1:0];
	
	
	reg[NUM_SIZE-1:0] matrix[WIDTH * WIDTH - 1:0];

	wire enable = 1;
	
	
shift_register_n #(
	.SIZE(1), .STAGES(1)
	)  s_axis_tready_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din(m_axis_tready),
	.dout(s_axis_tready)
	);
	
shift_register #(
	.SIZE(1), .STAGES(1)
	) tlast_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din(s_axis_tlast),
	.dout(m_axis_tlast)
	);
	
shift_register #(
	.SIZE(1), .STAGES(1)
	) tvalid_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din(s_axis_tvalid),
	.dout(m_axis_tvalid)
	);
	
shift_register #(
	.SIZE($clog2(`THETA_COUNT)), .STAGES(1)
	) tuser_sr (
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable),
	.din(s_axis_tuser),
	.dout(m_axis_tuser)
	);
	


	integer i;

	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n) begin
			m_axis_tdata <= 0;
		end else begin
			m_axis_tdata <= layer4[0];
		end
	end
	
	
	always@(*)begin
		for(i = 0; i < WIDTH * WIDTH; i = i + 1)begin
			matrix[i] = {
				{0,s_axis_tdata[NUM_SIZE * i + NUM_SIZE/2 +: NUM_SIZE/2]},
				{0,s_axis_tdata[NUM_SIZE * i +: NUM_SIZE/2]}
				};
		end
	end

	genvar j;
	generate
	for(j = 0; j < L0W; j = j + 2)begin
		complex_adder_saturate #(.ELEMENT_SIZE(NUM_SIZE)) layer_1_adder(
		.a(matrix[j]),
		.b(matrix[j+1]),
		.sum(layer1[j/2])
		);
	end
	for(j = 0; j < L1W; j = j + 2)begin
		complex_adder_saturate_real #(.ELEMENT_SIZE(NUM_SIZE)) layer_2_adder(
		.a(layer1[j]),
		.b(layer1[j+1]),
		.sum(layer2[j/2])
		);
	end
	for(j = 0; j < L2W; j = j + 2)begin
		complex_adder_saturate_real #(.ELEMENT_SIZE(NUM_SIZE)) layer_3_adder(
		.a(layer2[j]),
		.b(layer2[j+1]),
		.sum(layer3[j/2])
		);
	end
	for(j = 0; j < L3W; j = j + 2)begin
		complex_adder_saturate_real #(.ELEMENT_SIZE(NUM_SIZE)) layer_4_adder(
		.a(layer3[j]),
		.b(layer3[j+1]),
		.sum(layer4[j/2])
		);
	end
	endgenerate
	
endmodule
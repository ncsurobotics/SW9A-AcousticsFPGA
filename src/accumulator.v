`timescale 1ns/1ps

module adder #( // dummy module to make switch to complex adder easier
	parameter NUM_SIZE = 32
	)(
	input[NUM_SIZE-1:0] a, b,
	output[NUM_SIZE-1:0] c
	);
	
	assign c = a + b;
	
endmodule


module matrix_accumulator_no_latency #(
	parameter NUM_SIZE = 32, //element size
	parameter WIDTH = 4 //Matrix width
	)(
	input clk, reset_n,
	input[NUM_SIZE * WIDTH * WIDTH - 1:0] s_axis_tdata,
	
	output reg[NUM_SIZE - 1:0] m_axis_tdata,
	//TODO implement functional AXI protocol
	input s_axis_tuser, s_axis_tvalid, s_axis_tlast,
	output s_axis_tready,
	
	input m_axis_tready,
	output m_axis_tuser, m_axis_tvalid, m_axis_tlast
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
			matrix[i] = s_axis_tdata[NUM_SIZE * i +: NUM_SIZE];
		end
	end

	genvar j;
	generate
	for(j = 0; j < L0W; j = j + 2)begin
		adder #(.NUM_SIZE(NUM_SIZE)) layer_1_adder(
		.a(matrix[j]),
		.b(matrix[j+1]),
		.c(layer1[j/2])
		);
	end
	for(j = 0; j < L1W; j = j + 2)begin
		adder #(.NUM_SIZE(NUM_SIZE)) layer_2_adder(
		.a(layer1[j]),
		.b(layer1[j+1]),
		.c(layer2[j/2])
		);
	end
	for(j = 0; j < L2W; j = j + 2)begin
		adder #(.NUM_SIZE(NUM_SIZE)) layer_3_adder(
		.a(layer2[j]),
		.b(layer2[j+1]),
		.c(layer3[j/2])
		);
	end
	for(j = 0; j < L3W; j = j + 2)begin
		adder #(.NUM_SIZE(NUM_SIZE)) layer_4_adder(
		.a(layer3[j]),
		.b(layer3[j+1]),
		.c(layer4[j/2])
		);
	end
	endgenerate
	
endmodule

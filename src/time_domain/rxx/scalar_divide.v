`timescale 1ns/1ps

`include "constants.vh"


module scalar_complex_divider_const #(
	NUM_SIZE = 32, 
	SCALAR = 256
	)(
	input[NUM_SIZE-1:0] a,
	output reg[NUM_SIZE -1:0] quotient
	);
	
	reg[NUM_SIZE/2 - 1 : 0] real_value, imag_value;
	always@(*)begin
		real_value <= $signed(a[NUM_SIZE/2 - 1 : 0]) / SCALAR;
		imag_value <= $signed(a[NUM_SIZE-1:NUM_SIZE/2])/SCALAR;
		quotient <= {imag_value, real_value};
	end
	
endmodule

module scalar_complex_divider_const_reduce #(
	NUM_SIZE = 32, 
	SCALAR = 256
	)(
	input[NUM_SIZE-1:0] a,
	output reg[NUM_SIZE/2 -1:0] quotient
	);
	
	reg[NUM_SIZE/4 - 1 : 0] real_value, imag_value;
	always@(*)begin
		real_value <= {a[NUM_SIZE/2 - 1],$signed(a[NUM_SIZE/2 - 1 : 0]) / SCALAR};
		imag_value <= {a[NUM_SIZE - 1],$signed(a[NUM_SIZE-1:NUM_SIZE/2])/SCALAR};
		quotient <= {imag_value, real_value};
	end
	
endmodule


module scalar_complex_divider_const_reduce_2 #(
	NUM_SIZE = 32, 
	BASE = 8
	)(
	input signed[NUM_SIZE-1:0] a,
	output reg signed[NUM_SIZE/2 -1:0] quotient
	);
	
	reg signed[NUM_SIZE/4 - 1 : 0] real_value, imag_value;
	always@(*)begin
		real_value <= $signed(a[NUM_SIZE/2 - 1 : 0]) >>> BASE;
		imag_value <= $signed(a[NUM_SIZE - 1 : NUM_SIZE/2]) >>> BASE;
		quotient <= {imag_value, real_value};
	end
	
endmodule



module scalar_complex_divider #(NUM_SIZE = 32)(
	input[NUM_SIZE-1:0] a,
	input[NUM_SIZE/2 - 1:0] b,
	output reg[NUM_SIZE-1:0] quotient
	);
	
	reg[NUM_SIZE/2 - 1 : 0] real_value, imag_value;
	always@(*)begin
		real_value <= $signed(a[NUM_SIZE/2 - 1 : 0]) / b;
		imag_value <= $signed(a[NUM_SIZE-1:NUM_SIZE/2])/b;
		quotient <= {imag_value, real_value};
	end
	
endmodule



module scalar_divide_const #(
	parameter MAT_WIDTH = 4,
	parameter MAT_HEIGHT = 4,
	parameter NUM_SIZE = 32,
	parameter SCALAR = 256
	) (
	input clk, reset_n,
	input [MAT_WIDTH * MAT_HEIGHT * NUM_SIZE - 1:0] s_axis_tdata,
	output reg[MAT_WIDTH * MAT_HEIGHT * NUM_SIZE/2 - 1:0] m_axis_tdata,
	input s_axis_tvalid, s_axis_tlast, m_axis_tready,
	output reg s_axis_tready, m_axis_tvalid, m_axis_tlast
	);
	
	
	wire load_data = s_axis_tvalid;
	wire[MAT_WIDTH * MAT_HEIGHT * NUM_SIZE/2 - 1:0] result;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_tdata <= 0;
			m_axis_tlast <= 0;
			s_axis_tready <= 1;
			m_axis_tvalid <= 0;
		end else begin
			m_axis_tlast <= s_axis_tlast;
			s_axis_tready <= m_axis_tready;
			m_axis_tvalid <= load_data;
			if(load_data) begin
				m_axis_tdata <= result;
			end else begin
				m_axis_tdata <= m_axis_tdata;
			end
		end
		
	end
	
	
	genvar i, j;
	generate
		for(i = 0; i < MAT_HEIGHT * MAT_WIDTH; i = i + 1)begin
			scalar_complex_divider_const_reduce_2 #(
				.NUM_SIZE(NUM_SIZE),
				.BASE(16)
				) divider (
				.a(s_axis_tdata[i * NUM_SIZE +: NUM_SIZE]),
				.quotient(result[i * NUM_SIZE/2 +: NUM_SIZE/2])
				);
		end
	endgenerate
	
endmodule


module scalar_divide #(
	parameter MAT_WIDTH = 4,
	parameter MAT_HEIGHT = 4,
	parameter NUM_SIZE = 32
	) (
	input clk, reset_n,
	input [MAT_WIDTH * MAT_HEIGHT * NUM_SIZE - 1:0] s_axis_a_tdata,  s_axis_b_tdata,
	output reg[MAT_WIDTH * MAT_HEIGHT * NUM_SIZE - 1:0] m_axis_tdata,
	input s_axis_a_tvalid, s_axis_a_tlast, s_axis_a_tuser, 
	input s_axis_b_tvalid, s_axis_b_tlast, s_axis_b_tuser, 
	input m_axis_tready,
	output reg s_axis_a_tready, s_axis_b_tready,
	output reg  m_axis_tvalid, m_axis_tlast,
	output reg[1:0]  m_axis_tuser
	);
	
	
	wire load_data;
	assign load_data = s_axis_a_tvalid & s_axis_b_tvalid & s_axis_a_tready & s_axis_b_tready;
	wire[MAT_WIDTH * MAT_HEIGHT * NUM_SIZE - 1:0] result;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_tdata <= 0;
			m_axis_tlast <= 0;
			s_axis_a_tready <= 0;
			s_axis_b_tready <= 0;
			m_axis_tuser <= 0;
			m_axis_tvalid <= 0;
		end else begin
			m_axis_tlast <= s_axis_a_tlast | s_axis_b_tlast ;
			s_axis_a_tready <= m_axis_tready;
			s_axis_b_tready <= m_axis_tready;
			m_axis_tuser <= {s_axis_a_tuser, s_axis_b_tuser};
			m_axis_tvalid <= load_data;
			if(load_data)begin
				m_axis_tdata <= result;
			end else begin
				m_axis_tdata <= m_axis_tdata;
			end
		end
		
	end
	
	
	genvar i, j;
	generate
		for(i = 0; i < MAT_HEIGHT; i = i + 1)begin
			for(j = 0; j < MAT_WIDTH; j = j + 1)begin
				scalar_complex_divider #(.NUM_SIZE(NUM_SIZE)) 
				divider(.a(s_axis_a_tdata[(i * MAT_WIDTH + j + 1) * NUM_SIZE - 1 : (i * MAT_WIDTH + j) * NUM_SIZE]),
						.b(s_axis_b_tdata[(i * MAT_WIDTH + j + 1) * NUM_SIZE - 1 : (i * MAT_WIDTH + j) * NUM_SIZE]),
							  .quotient(result[(i * MAT_WIDTH + j + 1) * NUM_SIZE - 1 : (i * MAT_WIDTH + j) * NUM_SIZE])
							  );
			end
		end
	endgenerate
	
endmodule
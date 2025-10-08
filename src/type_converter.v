`timescale 1ns / 1ps


module signed_mag_to_twos_complement #(
	parameter INT_SIZE = 32
	) (
    input  [INT_SIZE - 1:0] signed_mag,        // [31] = sign, [30:0] = magnitude
    output [INT_SIZE - 1:0] twos_complement
);
    wire sign = signed_mag[INT_SIZE - 1];
    wire [INT_SIZE - 2:0] magnitude = signed_mag[INT_SIZE - 2:0];
    
    // If negative, take 2's complement of magnitude
    wire [INT_SIZE - 1:0] neg_value = ~{1'b0, magnitude} + 1;

    assign twos_complement = sign ? neg_value : signed_mag;

endmodule

module pass_through #(
	parameter INT_SIZE = 32
	) (
    input  [INT_SIZE - 1:0] signed_mag,        // [31] = sign, [30:0] = magnitude
    output [INT_SIZE - 1:0] twos_complement
);
    assign twos_complement = signed_mag;

endmodule


module type_converter #(
	parameter INT_SIZE = 32,
	parameter INT_COUNT = 8
	) (
	input clk, reset_n,

	input [INT_SIZE * INT_COUNT - 1:0] s_axis_tdata, // 8 32-bit signed magnitude numbers
	input s_axis_tuser, s_axis_tlast, s_axis_tvalid,
	output reg s_axis_tready,
	
	output reg [INT_SIZE * INT_COUNT - 1:0] m_axis_tdata, //8 32-bit 2's complement numbers
	output reg m_axis_tuser, m_axis_tlast, m_axis_tvalid,
	input m_axis_tready
	);
	
	wire[INT_SIZE * INT_COUNT - 1:0] next_data;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_tdata <= 0;
			m_axis_tuser <= 0;
			m_axis_tvalid <= 0;
			m_axis_tlast <= 0;
			s_axis_tready <= 1;
		end else begin
			if(s_axis_tvalid) begin
				m_axis_tdata <= next_data;
				m_axis_tuser <= s_axis_tuser;
				m_axis_tlast <= s_axis_tlast;
			end else begin
				m_axis_tdata <= m_axis_tdata;
				m_axis_tuser <= m_axis_tuser;
				m_axis_tlast <= m_axis_tlast;
			end
			s_axis_tready <= m_axis_tready;
			m_axis_tvalid <= s_axis_tvalid;
		end
	
	end
	
	genvar i;
	generate
	for( i = 0; i < INT_COUNT; i = i + 1)
		pass_through #(.INT_SIZE(INT_SIZE))
		converter(
			.signed_mag(s_axis_tdata[INT_SIZE * i +: INT_SIZE]),
			.twos_complement(next_data[INT_SIZE * i +: INT_SIZE])
			);
	endgenerate
	
endmodule
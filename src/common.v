`timescale 1ns/1ps








module complex_adder #(ELEMENT_SIZE = 16)(
	input[ELEMENT_SIZE-1:0] a, b,
	output reg[ELEMENT_SIZE-1:0] sum
	);
	
	always@(*)begin
		sum = {
		a[ELEMENT_SIZE-1:ELEMENT_SIZE/2] + b[ELEMENT_SIZE-1:ELEMENT_SIZE/2],
		a[ELEMENT_SIZE/2 - 1:0] + b[ELEMENT_SIZE/2 - 1:0]};
	end
	
endmodule

module shift_register #(
	parameter SIZE = 32,
	parameter STAGES = 3
	)(
	input clk, reset_n, enable,
	input[SIZE-1:0] din,
	output reg[SIZE-1:0] dout
	);
	
	reg[SIZE-1:0] buffer[STAGES-1:0];
	
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			for(i = 0; i < STAGES; i = i + 1)begin
				buffer[i] <= 0;
			end
		end else begin
			for(i = 0; i < STAGES; i = i + 1)begin
				if(enable)begin
					if(i == 0) buffer[i] <= din;
					else buffer[i] <= buffer[i-1];
				end else buffer[i] <= buffer[i];
			end
		end
	end
	
	always@(*)begin
		dout <= buffer[STAGES-1];
	end
	
endmodule


module conjugate_multiplier #(
	parameter SIZE = 32,
	parameter LATENCY = 3
	)(
	input clk, reset_n, clken,
	input s_axis_tvalid, s_axis_tuser, s_axis_tlast,
	input[SIZE-1:0] s_axis_tdata,
	output s_axis_tready,
	
	output m_axis_dout_tlast, m_axis_dout_tuser, m_axis_dout_tvalid,
	output[2*SIZE-1:0] m_axis_dout_tdata,
	input m_axis_dout_tready
	);
	
	assign s_axis_a_tready = m_axis_dout_tready;
	wire sr_enable;
	assign sr_enable = m_axis_dout_tready & clken;
	reg[SIZE - 1:0] real_result, imag_result, prod1, prod2;
	reg[2*SIZE-1:0] result;
	
	always@(*)begin
		prod1 <= s_axis_tdata[SIZE-1:SIZE/2] * s_axis_tdata[SIZE-1:SIZE/2]; //a^2
		prod2 <= s_axis_tdata[SIZE/2 - 1:0] * s_axis_tdata[SIZE/2 - 1:0]; //b^2
		real_result <= prod1 + prod2; //a^2 + b^2
		imag_result <= {0}; //zero imag
		result = {real_result,imag_result};
	end
	
	shift_register #(.SIZE(1),.STAGES(LATENCY))  tvalid_sr 
		(.clk(clk),.reset_n(reset_n),.din(s_axis_a_tvalid),.dout(m_axis_dout_tvalid),.enable(sr_enable));
		
	shift_register  #(.SIZE(1),.STAGES(LATENCY))
		tlast_sr (.clk(clk),.reset_n(reset_n),.din(s_axis_tlast),.dout(m_axis_dout_tlast),.enable(sr_enable));
		
	shift_register  #(.SIZE(1),.STAGES(LATENCY))
		tuser_sr(.clk(clk),.reset_n(reset_n),.din(s_axis_tuser),.dout(m_axis_dout_tuser),.enable(sr_enable));
		
	shift_register  #(.SIZE(2 * SIZE),.STAGES(LATENCY))
		tdata_sr (.clk(clk),.reset_n(reset_n),.din(result),.dout(m_axis_dout_tdata),.enable(sr_enable));
		
endmodule


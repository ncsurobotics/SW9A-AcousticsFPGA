`timescale 1ns/1ps

`include "constants.vh"

module max #(
	parameter NUM_SIZE = 32,
	parameter TUSER_SIZE = 16
	) (
	input clk, reset_n,


	
	// current weight input channel
	input[NUM_SIZE - 1 : 0] s_axis_tdata,
	input [TUSER_SIZE - 1:0] s_axis_tuser,//theta
	input s_axis_tvalid, s_axis_tlast,
	
	// max theta output channel
	output reg[TUSER_SIZE - 1:0]  m_axis_max_tdata, 
	output reg m_axis_max_tvalid, m_axis_max_tlast
	);
	
	reg[NUM_SIZE - 1 :0] max_weight;
	reg valid_buf, last_buf;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_max_tdata <= 0;
			max_weight <= 0;
			m_axis_max_tvalid <= 0;
			m_axis_max_tlast <= 0;
			
			last_buf <= 0;
			valid_buf <= 0;
		end else begin
			valid_buf <= s_axis_tvalid;
			last_buf <= s_axis_tlast;
			m_axis_max_tvalid <= s_axis_tlast && s_axis_tvalid;
			m_axis_max_tlast <= s_axis_tlast;
			if(s_axis_tvalid) begin //enable
				m_axis_max_tdata <= $signed(s_axis_tdata) > $signed(max_weight) ? s_axis_tuser : m_axis_max_tdata;
				if(m_axis_max_tvalid) max_weight <= 0;
				else max_weight <= $signed(s_axis_tdata) > $signed(max_weight) ? s_axis_tdata : max_weight;
			end else if(m_axis_max_tvalid)begin
				max_weight <= 0;
			end
		end
	end
	
endmodule


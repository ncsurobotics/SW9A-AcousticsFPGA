`timescale 1ns/1ps

`include "constants.vh"

module max #(
	parameter NUM_SIZE = 32
	) (
	input clk, reset_n,


	
	// current weight input channel
	input[NUM_SIZE - 1 : 0] s_axis_tdata,
	input [$clog2(`THETA_COUNT) - 1:0] s_axis_tuser,//theta
	input s_axis_tvalid, s_axis_tlast,
	output reg s_axis_tready,
	
	// max theta output channel
	output reg[$clog2(`THETA_COUNT) - 1:0]  m_axis_max_tdata, 
	output reg m_axis_max_tvalid, m_axis_max_tuser, m_axis_max_tlast,
	input m_axis_max_tready	
	);
	
	reg[NUM_SIZE - 1 :0] max_weight;
	
	initial begin
		s_axis_tready <= 1;
		m_axis_max_tuser <= 0;
	end
		
	always@(*)begin
		m_axis_max_tlast <= s_axis_tlast;
	end
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_max_tdata <= 0;
			max_weight <= 0;
			m_axis_max_tvalid <= 0;
		end else begin
			if(m_axis_max_tready) begin				
				m_axis_max_tvalid <= s_axis_tlast;
				if(s_axis_tvalid) begin //enable
					m_axis_max_tdata <= $signed(s_axis_tdata) > $signed(max_weight) ? s_axis_tuser : m_axis_max_tdata;
					if(s_axis_tlast) max_weight <= 0;
					else max_weight <= $signed(s_axis_tdata) > $signed(max_weight) ? s_axis_tdata : max_weight;
				end 
			end
			
		end
	end
	
endmodule


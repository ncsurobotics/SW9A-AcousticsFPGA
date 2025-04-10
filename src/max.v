`timescale 1ns/1ps

`include "constants.vh"

module max #(
	parameter NUM_SIZE = 32
	) (
	input clk, reset_n,

	// current theta input channel
	input[$clog2(`THETA_COUNT): 0] s_axis_theta_tdata, 
	input s_axis_theta_tvalid, s_axis_theta_tlast, s_axis_theta_tuser, 
	output reg s_axis_theta_tready,
	
	// current weight input channel
	input[NUM_SIZE - 1 : 0] s_axis_weight_tdata,
	input s_axis_weight_tvalid, s_axis_weight_tlast, s_axis_weight_tuser,
	output reg s_axis_weight_tready,
	
	// max theta output channel
	output reg[$clog2(`THETA_COUNT):0]  m_axis_max_tdata, 
	output reg m_axis_max_tvalid, m_axis_max_tuser, m_axis_max_tlast,
	input m_axis_max_tready	
	);
	
	reg[NUM_SIZE - 1 :0] max_weight;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_max_tdata <= 0;
			max_weight <= 0;
			m_axis_max_tvalid <= 0;
		end else begin
			if(m_axis_max_tready) begin
				s_axis_weight_tready <= 1;
				s_axis_theta_tready <= 1;
				m_axis_max_tvalid <= s_axis_theta_tlast && s_axis_weight_tlast;
				if(s_axis_theta_tvalid && s_axis_weight_tvalid) begin //enable
					m_axis_max_tdata <= s_axis_weight_tdata > max_weight ? s_axis_theta_tdata : m_axis_max_tdata;
					max_weight <= s_axis_weight_tdata > max_weight ? s_axis_weight_tdata : max_weight;
				end else begin
					m_axis_max_tdata <= m_axis_max_tdata;
					max_weight <= max_weight;
				end
			end else begin
				s_axis_weight_tready <= 0;
				s_axis_theta_tready <= 0;
				m_axis_max_tdata <= m_axis_max_tdata;
				max_weight <= max_weight;
			end
			
		end
	end
	
endmodule


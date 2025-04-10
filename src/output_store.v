`timescale 1ns/1ps


`include "constants.vh"


module output_store #(
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
	
	// all weights output channel
	output reg[`THETA_COUNT * NUM_SIZE:0]  m_axis_all_tdata, 
	output reg m_axis_all_tvalid, m_axis_all_tuser, m_axis_all_tlast,
	input m_axis_all_tready	
	);
	
	integer i;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_all_tdata <= 0;
			s_axis_weight_tready <= 0;
			s_axis_theta_tready <= 0;
			m_axis_all_tvalid <= 0;
		end else begin
			m_axis_all_tvalid <= !(s_axis_theta_tvalid | s_axis_weight_tvalid);
			s_axis_weight_tready <= m_axis_all_tready;
			s_axis_theta_tready <= m_axis_all_tready;
			for(i = 0; i < `THETA_COUNT; i = i + 1)begin
				if(i == s_axis_theta_tdata && s_axis_weight_tvalid && s_axis_theta_tvalid) begin
					m_axis_all_tdata[i] <= s_axis_theta_tdata;
				end
				else m_axis_all_tdata[i] <= m_axis_all_tdata[i];
			end
		end
	end
	
endmodule


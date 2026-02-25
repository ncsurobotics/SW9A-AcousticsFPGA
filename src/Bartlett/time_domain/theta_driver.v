`timescale 1ns / 1ps

`include "constants.vh"

module theta_driver (
	input clk, reset_n,
	input enable, //when high, theta values will be sent starting from 0
	
	output reg[4:0] m_axis_theta_tdata,
	output reg m_axis_theta_tlast, m_axis_theta_tvalid
	);
	
	reg enable_latch;
	wire limit_met = m_axis_theta_tdata == `THETA_COUNT - 2 ;
	
	reg[3: 0] counter;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_theta_tdata <= 5'b11111;
			m_axis_theta_tvalid <= 0;
			m_axis_theta_tlast <= 0;
			enable_latch <= 0;
			counter <= 0;
		end else begin
			if(enable_latch)begin
				enable_latch <= limit_met ? 0 : 1;
				m_axis_theta_tvalid <= 1;
				m_axis_theta_tlast <= limit_met ? 1 : 0;
				m_axis_theta_tdata <= m_axis_theta_tdata + &counter;
				counter <= counter + 1;
			end else begin	
				enable_latch <= enable;
				m_axis_theta_tdata <= 5'b11111;
				m_axis_theta_tvalid <= 0;
				m_axis_theta_tlast <= 0;
				counter <= 0;
			end
		end
	
	end
	
endmodule
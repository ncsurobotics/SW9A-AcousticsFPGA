`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/03/2026 12:12:17 AM
// Design Name: 
// Module Name: bartlett_config_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bartlett_config_controller(
	input clk,
	input reset_n,
	
	input [31 : 0] threshold,
	input [7:0] min_frequency, max_frequency,
	
	input m_axis_config_tready,
	output [32 + 8 + 8 - 1 : 0] m_axis_config_tdata,
	output m_axis_config_tvalid,
	output reg[5:0] m_axis_config_tstrb
    );
	
	
	assign m_axis_config_tdata = {max_frequency_reg,min_frequency_reg,threshold_reg};
	assign m_axis_config_tvalid = |m_axis_config_tstrb;
	
	reg[31:0] threshold_reg;
	reg[7:0] min_frequency_reg, max_frequency_reg;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			threshold_reg <= 0;
			min_frequency_reg <= 0;
			max_frequency_reg <= 0;
			m_axis_config_tstrb <= 0;
		end else begin
			threshold_reg <= threshold;
			min_frequency_reg <= min_frequency;
			max_frequency_reg <= max_frequency;
		
		
		
			if(max_frequency_reg != max_frequency) m_axis_config_tstrb[5] <= 1'b1;
			else if(m_axis_config_tready) m_axis_config_tstrb[5] <= 1'b0;
			
			if(min_frequency_reg != min_frequency) m_axis_config_tstrb[4] <= 1'b1;
			else if(m_axis_config_tready) m_axis_config_tstrb[4] <= 1'b0;
			
			if(threshold_reg != threshold) m_axis_config_tstrb[3:0] <= 4'b1111;
			else if(m_axis_config_tready) m_axis_config_tstrb[3:0] <= 4'b0000;
		end
	end
	
	
	
	
endmodule

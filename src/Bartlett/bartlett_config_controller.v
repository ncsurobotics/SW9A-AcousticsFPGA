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
	output reg m_axis_config_tvalid,
	output reg[5:0] m_axis_config_tstrb
    );
	
	
	assign m_axis_config_tdata = {max_frequency_reg,min_frequency_reg,threshold_reg};
	
	reg[31:0] threshold_reg, threshold_input_buffer;
	reg[7:0] min_frequency_reg, min_frequency_input_buffer, max_frequency_reg, max_frequency_input_buffer;
	
	wire max_compare, min_compare, threshold_compare;
	assign max_compare = max_frequency_reg != max_frequency_input_buffer;
	assign min_compare = min_frequency_reg != min_frequency_input_buffer;
	assign threshold_compare = threshold_reg != threshold_input_buffer;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			threshold_reg <= 32'd0;
			threshold_input_buffer <= 32'd0;
			min_frequency_reg <= 8'd0;
			min_frequency_input_buffer <= 8'd0;
			max_frequency_reg <= 8'd0;
			max_frequency_input_buffer <= 8'd0;
			m_axis_config_tstrb <= 6'b000000;
			m_axis_config_tvalid <= 1'b0;
		end else begin
			if(m_axis_config_tvalid) threshold_reg <= threshold_input_buffer;
			threshold_input_buffer <= threshold;
			
			if(m_axis_config_tvalid) min_frequency_reg <= min_frequency_input_buffer;
			min_frequency_input_buffer <= min_frequency;
			
			if(m_axis_config_tvalid) max_frequency_reg <= max_frequency_input_buffer;
			max_frequency_input_buffer <= max_frequency;
		
			m_axis_config_tvalid <= m_axis_config_tready && (max_compare || min_compare || threshold_compare);
		
			if(max_compare) m_axis_config_tstrb[5] <= 1'b1;
			else if(m_axis_config_tvalid) m_axis_config_tstrb[5] <= 1'b0;
			else m_axis_config_tstrb[5] <= m_axis_config_tstrb[5];
			
			if(min_compare) m_axis_config_tstrb[4] <= 1'b1;
			else if(m_axis_config_tvalid) m_axis_config_tstrb[4] <= 1'b0;
			else m_axis_config_tstrb[4] <= m_axis_config_tstrb[4];
			
			if(threshold_compare) m_axis_config_tstrb[3:0] <= 4'b1111;
			else if(m_axis_config_tvalid) m_axis_config_tstrb[3:0] <= 4'b0000;
			else  m_axis_config_tstrb[3:0] <= m_axis_config_tstrb[3:0];
		end
	end
	
	
	
	
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 1/13/2025 2:45:00 PM
// Design Name: 
// Module Name: SPI_WRAPPER
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


module SPI_WRAPPER #(parameter CHANNELS = 4, parameter WIDTH = 10, parameter TOTAL_BITS = 14) (
	input clk, SPI_clk, reset_b, spi_areset_n,
	input [CHANNELS-1:0] SPI_en,
	input[CHANNELS-1:0] data_in,
	output[CHANNELS-1:0] CS, Data_Ready,
	output[CHANNELS * WIDTH - 1:0] SPI_Data_out,
	output reg data_last
	);
	
	reg [7:0] counter;
	always@(posedge clk or negedge reset_b)begin
		if(!reset_b)begin
			counter <= 0;
			data_last <= 0;
		end else begin
			data_last <= &counter[7:0];
			if(Data_Ready[0]) begin
				if(data_last) counter <= 0;
				else counter <= counter + 1;
			end 
		end
	end
	
	genvar i;
	generate
	for(i = 0; i < CHANNELS; i = i + 1)begin
		SPI #(.WIDTH(WIDTH) , .TOTAL_BITS(TOTAL_BITS)) SPI_inst (
			.clk(clk),
			.SPI_clk(SPI_clk),
			.reset_b(reset_b),
			.spi_areset_n(spi_areset_n),
			.SPI_Data_in(data_in[i]),
			.SPI_en(SPI_en[i]),
			.SPI_Data_out(SPI_Data_out[(i+1)*WIDTH - 1: i*WIDTH]),
			.Data_Ready(Data_Ready[i]),
			.CS(CS[i])	
		);
	end
	endgenerate

endmodule
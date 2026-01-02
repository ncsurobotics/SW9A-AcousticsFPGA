`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2025 05:43:52 PM
// Design Name: 
// Module Name: uartRegMap
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
module uartRegMap(
	input clk,
	input rst_n,
	input [7:0] rx_data,
	input rx_valid,
	output reg [7:0] addr,
	output reg [31:0] dataOut,
	output reg ready
    );
	
	
	reg [7:0] shiftReg;
	reg [2:0] byteCounter;
	reg [2:0] bitCounter;
	
	reg [7:0] completeBytes [0:4]; // Stack
	
	
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			bitCounter <= 0;
			byteCounter <= 0;
			shiftReg <= 0;
			addr <= 0;
			dataOut <= 0;
		end
		else  begin
		    ready <= 0;
		    if (rx_valid) begin
			completeBytes[byteCounter] <= rx_data;
			bitCounter <= bitCounter + 1;
				if (byteCounter == 3'b100) begin
					addr <= completeBytes[0];
					dataOut <= {completeBytes[4], completeBytes[3], completeBytes[2], completeBytes[1]};
					ready <= 1;
					byteCounter <= 0;
				end else begin
				    byteCounter <= byteCounter + 1;
				end
			end
		end
	end
endmodule

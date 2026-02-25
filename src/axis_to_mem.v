`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2025 07:37:35 PM
// Design Name: 
// Module Name: axis_to_mem
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


module axis_to_mem(
    input clk,
    input rst_n,
    input [31:0] big_bits, // 32 bits each
    input bin_valid,
    output reg [4:0] address, // output address for the register file
    output reg [31:0] data_out,
    output reg wr_en
);
    reg [4:0] data_select; // selector for the mux

    // send current bin data until 19 (then max angle)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_select <= 0;
            address <= 0;
            data_out <= 0;
            wr_en <= 0;
        end else begin
            if (bin_valid && data_select < 19) begin
                address  <= data_select;
                data_out  <= big_bits;
                wr_en  <= 1;
                data_select <= data_select + 1;
            end
            else if (bin_valid && data_select == 19) begin
                address <= data_select;
                data_out <= big_bits; // max is in bin 19
                wr_en <= 1;
                data_select <= data_select + 1;
            end
            else if (data_select == 20) begin // reset if 20
                data_select <= 0;
                address <= 0;
                data_out <= 0;
                wr_en <= 0;
            end
            else begin
                wr_en <= 0; // default to no writing
            end
        end
    end  
endmodule
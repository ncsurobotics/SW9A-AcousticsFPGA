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
    input [607:0] big_bits, // 608 / 32 = 19
    input [7:0] max_angle, // final 8 bit value that we are gonna write
    input bin_valid,
    input max_valid,
    output reg [4:0] address, // output address for the register file
    output reg [31:0] data_out,
    output reg wr_en
);

    reg [4:0] data_select; // selector for the mux
    reg [31:0] bins [0:18];
    
    // put the data into the bins
    integer i;
    always @(*) begin
        for (i = 0; i < 19; i = i + 1) begin
            bins[i] = big_bits[i * 32 +: 32]; // bin[0] gets the first 32 bits and so on
        end
    end
    
    // do the mux for the valid to wr_en
    // send current bin data until 19 (max_angle)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin // reset everything
            data_select <= 0;
            address <= 0;
            data_out <= 0;
            wr_en <= 0;
        end else begin
            address <= data_select; // assign the outputs based on what data_select is currently
            if (data_select < 19) begin
                data_out <= bins[data_select];
                wr_en <= bin_valid;
            end else begin
                data_out <= {24'b0, max_angle};
                wr_en <= max_valid;
            end
            if (wr_en) // after the write go to the next data_select
                data_select <= data_select + 1;
        end
    end  
endmodule

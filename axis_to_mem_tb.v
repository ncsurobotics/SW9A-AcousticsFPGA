`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2025 11:15:01 AM
// Design Name: 
// Module Name: mem_to_axis_tb
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

module axis_to_mem_tb;

    reg clk;
    reg rst_n;
    reg [31:0] big_bits;
    reg bin_valid;
    reg max_valid;
    wire [4:0] address;
    wire [31:0] data_out;
    wire wr_en;

    axis_to_mem dut (
        .clk(clk),
        .rst_n(rst_n),
        .big_bits(big_bits),
        .bin_valid(bin_valid),
        .max_valid(max_valid),
        .address(address),
        .data_out(data_out),
        .wr_en(wr_en)
    );

    // make the clock
    initial clk = 0;
    always #5 clk = ~clk; // 10ns

    // start the test
    integer i;
    initial begin
        $display("Start");
        rst_n = 0;
        bin_valid = 0;
        max_valid = 0;
        big_bits = 0;
        
        // reset everything
        #12 rst_n = 1;

        // go through one a time
        #10 bin_valid = 1;
        for (i = 0; i < 19; i = i + 1) begin
            big_bits = 32'h1000 + i;
            #10; // wait for a bit
        end
        bin_valid = 0;

        // try max angle
        #10 max_valid = 1;
        big_bits = 32'h000000AB;
        #10 max_valid = 0;

        #50;
        $finish;
    end

    // for seeing the stuff
    always @(posedge clk) begin
        if (wr_en) begin
            $display("Cycle %0t: address=%0d, data_out=0x%08X, wr_en=%b",
                     $time, address, data_out, wr_en);
        end
    end
endmodule

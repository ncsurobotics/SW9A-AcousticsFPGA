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
    reg [607:0] big_bits;
    reg [7:0] max_angle;
    reg bin_valid;
    reg max_valid;
    wire [4:0] address;
    wire [31:0] data_out;
    wire wr_en;

    axis_to_mem dut (
        .clk(clk),
        .rst_n(rst_n),
        .big_bits(big_bits),
        .max_angle(max_angle),
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
        max_angle = 8'hAB;

        // reset everything
        #12 rst_n = 1;

        // put the data in the bins
        for (i = 0; i < 19; i = i + 1) begin
            big_bits[i * 32 +: 32] = 32'h1000 + i;
        end

        #10 bin_valid = 1;

        // wait for everything to be transferred
        #200 bin_valid = 0;

        // try max angle
        #10 max_valid = 1;
        #10 max_valid = 0;

        #50;
        $finish;
    end

    // for seeing the stuff
    always @(posedge clk) begin
        if (wr_en) begin
            $display("Cycle %0t: address=%0d, data_out=0x%08X, wr_en=%b", $time, address, data_out, wr_en);
        end
    end
endmodule

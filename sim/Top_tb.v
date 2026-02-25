`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AquaPack Robotics
// Engineer: Myles Oakley
// 
// Create Date: 10/12/2025 02:55:26 PM
// Design Name: 
// Module Name: SW9_tb
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
/*
*/

module SW9_tb;
    // vars
    reg clock_100MHz;
    reg clock_5_76MHz;
    reg clock_3MHz;

    reg reset_b;

    // ADC signals
    wire ADC_clk1, ADC_clk2, ADC_clk3, ADC_clk4;
    wire ADC_cs1, ADC_cs2, ADC_cs3, ADC_cs4;
    reg [13:0] ADC_data1, ADC_data2, ADC_data3, ADC_data4;

    // UART signals
    reg [9:0] UART_rx;
    wire [9:0] UART_tx;

    // VGA signals
    wire VGA1, VGA2, VGA3, VGA4;

    // misc debug signals
    wire debug1, debug2, debug3, debug4;


    // DUT instantiation
    top DUT (
        .reset_b(reset_b),
        .clk(clock_100MHz),

        // ADCs
        .ADC_clk1(ADC_clk1),
        .ADC_clk2(ADC_clk2),
        .ADC_clk3(ADC_clk3),
        .ADC_clk4(ADC_clk4),

        .ADC_cs1(ADC_cs1),
        .ADC_cs2(ADC_cs2),
        .ADC_cs3(ADC_cs3),
        .ADC_cs4(ADC_cs4),

        .ADC_serial_data1(ADC_data1),
        .ADC_serial_data2(ADC_data2),
        .ADC_serial_data3(ADC_data3),
        .ADC_serial_data4(ADC_data4),

        // UART
        .UART_tx(UART_tx),
        .UART_rx(UART_rx),

        // VGA
        .VGA1(VGA1),
        .VGA2(VGA2),
        .VGA3(VGA3),
        .VGA4(VGA4),

        // Other I/O
        .debug1(debug1),
        .debug2(debug2),
        .debug3(debug3),
        .debug4(debug4)

    );
    parameter 
        UART_CMD_COUNT = 10,
        ADC_SAMPLES = 1024;


    // clock_100MHz generation
   initial begin
        clock_100MHz = 0;
        forever #5 clock_100MHz = ~clock_100MHz;
    end
    // UART clock generation
    initial begin
        clock_5_76MHz = 0;
        forever #86.8055556 clock_5_76MHz = ~clock_5_76MHz; // period = 173.611111 ns
    end
    // SPI clock generation
    initial begin
        clock_3MHz = 0;
        forever #166.666667 clock_3MHz = ~clock_3MHz; // period = 333.33333 ns
    end

    // Reset generation
    initial begin
        reset_b = 0;
        #30 reset_b = 1;
    end

    // testbench stimulus
    initial begin
        UART_rx = 1'b1;
        UART_rx = 1'b1;
        #166.666667 UART_rx = 1'b0;
        #166.666667 UART_rx = 1'b1;
        #166.666667 UART_rx = 1'b0;
        #166.666667 UART_rx = 1'b1;
        #166.666667 UART_rx = 1'b1;
        #166.666667 UART_rx = 1'b0;
        #166.666667 UART_rx = 1'b1;
        #166.666667 UART_rx = 1'b1;
        #166.666667 UART_rx = 1'b1;
        #166.666667 UART_rx = 1'b1;
        #166.666667 UART_rx = 1'b1;
        #500 $finish;
    end

endmodule


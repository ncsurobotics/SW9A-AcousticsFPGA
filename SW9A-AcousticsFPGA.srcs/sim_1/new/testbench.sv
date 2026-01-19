`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2026 02:01:33 AM
// Design Name: 
// Module Name: testbench
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

// 0 - no print, 1 - some print, 2 - lots of print
`define LOG_LEVEL 2

module testbench(

    );
	
	    // dut vars
    logic clock_12MHz;
    logic reset_b;

    logic ADC_clk1, ADC_clk2, ADC_clk3, ADC_clk4;
    logic ADC_cs1, ADC_cs2, ADC_cs3, ADC_cs4;
    reg ADC_data1, ADC_data2, ADC_data3, ADC_data4;

    reg UART_rx;
    logic UART_tx;

    logic [2:0] VGA1, VGA2, VGA3, VGA4;

    logic debug1, debug2, debug3, debug4;

    // memories for ADC samples
    logic [9:0] ADC1_samples [int];
    logic [9:0] ADC2_samples [int];
    logic [9:0] ADC3_samples [int];
    logic [9:0] ADC4_samples [int];
    
    int ADC1_sample_number = 0; 
    int ADC2_sample_number = 0; 
    int ADC3_sample_number = 0;
    int ADC4_sample_number = 0;

    int ADC1_total_samples = 0;
    int ADC2_total_samples = 0;
    int ADC3_total_samples = 0;
    int ADC4_total_samples = 0;

    // DUT instantiation
    top DUT (
        .reset_b(reset_b),
        .clk_12mhz(clock_12MHz),

        // ADCs
        .ADC_clk1(ADC_clk1),
        .ADC_cs1(ADC_cs1),
        .ADC_serial_data1(ADC_data1),

        .ADC_clk2(ADC_clk2),
        .ADC_cs2(ADC_cs2),
        .ADC_serial_data2(ADC_data2),
        .ADC_clk3(ADC_clk3),
        .ADC_cs3(ADC_cs3),
        .ADC_serial_data3(ADC_data3),

        .ADC_clk4(ADC_clk4),
        .ADC_cs4(ADC_cs4),
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
	
	    // parameters / defines
    parameter 
        period_12MHz = 83.333333,  
        period_115200Baud = 8680.55,
        period_3MHz = 333.33333;


    // clk_12mhz generation
   initial begin
        clock_12MHz = 0;
        forever #(period_12MHz/2) clock_12MHz = ~clock_12MHz;
    end

    // Reset generation
    initial begin
        reset_b = 0;
        #50000 
		if(`LOG_LEVEL>=2) $display("Ending reset");
		reset_b = 1;
    end


endmodule

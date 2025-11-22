`timescale 1ns / 1ps
module command_reader_tb;
// wwaveform dump
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, command_reader_tb);
  end
// clk and reset
  reg clk;
  reg rst_n;
// uart signals
  reg [6:0] uart_addr;
  reg uart_wr_en;
  reg [31:0] uart_data_in;
  wire [31:0] uart_data_out;
// bartlett signals
  reg [4:0] bartlett_addr;
  reg bartlett_wr_en;
  reg [31:0] bartlett_data_in;
  wire [31:0] bartlett_data_out;
// outputs
  wire [31:0] threshold;
  wire [31:0] min_frequency;
  wire [31:0] max_frequency;
  wire [31:0] vga;
  wire dumpram;
  wire sendmaxangle;
  wire softreset;
  wire [31:0] maxangle;
// instantiate dut
  command_reader dut (
    .clk(clk),
    .rst_n(rst_n),
    .uart_addr(uart_addr),
    .uart_wr_en(uart_wr_en),
    .uart_data_in(uart_data_in),
    .uart_data_out(uart_data_out),
    .bartlett_addr(bartlett_addr),
    .bartlett_wr_en(bartlett_wr_en),
    .bartlett_data_in(bartlett_data_in),
    .bartlett_data_out(bartlett_data_out),
    .threshold(threshold),
    .min_frequency(min_frequency),
    .max_frequency(max_frequency),
    .vga(vga),
    .dumpram(dumpram),
    .sendmaxangle(sendmaxangle),
    .softreset(softreset),
    .maxangle(maxangle)
  );
// clock gen
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns period
// test sequence
  initial begin
    $display("Started");
    uart_addr = 0;
    uart_wr_en = 0;
    uart_data_in = 0;
    bartlett_addr = 0;
    bartlett_wr_en = 0;
    bartlett_data_in = 0;
    rst_n = 0;
    // reset pulse
    #10 rst_n = 1;
    // uart write threshold
    #10 uart_addr = 7'd20;
        uart_data_in = 32'h000000AA;
        uart_wr_en = 1;
    #10 uart_wr_en = 0;
    // uart write min frequency
    #10 uart_addr = 7'd21;
        uart_data_in = 32'h000000BB;
        uart_wr_en = 1;
    #10 uart_wr_en = 0;
    // uart write max frequency
    #10 uart_addr = 7'd22;
        uart_data_in = 32'h000000CC;
        uart_wr_en = 1;
    #10 uart_wr_en = 0;
    // uart write vga
    #10 uart_addr = 7'd23;
        uart_data_in = 32'h000000DD;
        uart_wr_en = 1;
    #10 uart_wr_en = 0;
    // uart read threshold
    #10 uart_addr = 7'd20;
    #10 $display("UART Read flipflops[20] = %h", uart_data_out);
    // bartlett write bin 0
    #10 bartlett_addr = 5'd0;
        bartlett_data_in = 32'hCAFEBABE;
        bartlett_wr_en = 1;
    #10 bartlett_wr_en = 0;
    // bartlett write maxangle
    #10 bartlett_addr = 5'd19;
        bartlett_data_in = 32'hDEADBEEF;
        bartlett_wr_en = 1;
    #10 bartlett_wr_en = 0;
    // bartlett read threshold
    #10 bartlett_addr = 5'd20;
    #10 $display("Bartlett Read flipflops[20] = %h", bartlett_data_out);
    // bartlett read min frequency
    #10 bartlett_addr = 5'd21;
    #10 $display("Bartlett Read flipflops[21] = %h", bartlett_data_out);
    // check outputs
    #10 $display("Threshold     = %h", threshold);
        $display("Min Frequency = %h", min_frequency);
        $display("Max Frequency = %h", max_frequency);
        $display("VGA           = %h", vga);
        $display("Max Angle     = %h", maxangle);
    // uart write to bartlett address (should fail)
    #10 uart_addr = 7'd5;
        uart_data_in = 32'h11111111;
        uart_wr_en = 1;
    #10 uart_wr_en = 0;
    // bartlett write to uart address (should fail)
    #10 bartlett_addr = 5'd21;
        bartlett_data_in = 32'h22222222;
        bartlett_wr_en = 1;
    #10 bartlett_wr_en = 0;
    // uart read bartlett bin 5
    #10 uart_addr = 7'd5;
    #10 $display("UART Read flipflops[5] = %h (should be all Z)", uart_data_out);
    // uart read min frequency
    #10 uart_addr = 7'd21;
    #10 $display("UART Read flipflops[21] = %h (should be bb)", uart_data_out);
    // done
    #10 $finish;
  end
endmodule

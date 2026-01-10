`timescale 1ns / 1ps
// uses negedge reset
module command_reader (
  input clk,
  input rst_n,                
  input [6:0] uart_addr,
  input uart_wr_en,
  input [31:0] uart_data_in,
  output reg [31:0] uart_data_out,
  input [4:0] bartlett_addr,
  input bartlett_wr_en,
  input [31:0] bartlett_data_in,
  output reg [31:0] bartlett_data_out,  // to let the bartlett read from bins 20-22
  output [31:0] threshold,
  output [31:0] min_frequency,
  output [31:0] max_frequency,
  output [31:0] vga,
  output dumpram,
  output softreset,
  output [31:0] maxangle
);
  // bartlett bins and maxangle
  reg [31:0] bartlett_flipflops [0:19];
  
  // uart bins
  reg [31:0] uart_flipflops [20:25];
  
  // uart writing
  integer i;
  always @(posedge clk or negedge rst_n) begin  
    if (!rst_n) begin
      for (i = 20; i <= 25; i = i + 1)
        uart_flipflops[i] <= 0;
      // default stuff
      uart_flipflops[20] <= 32'h0001000;  // threshold
      uart_flipflops[21] <= 32'h0007;     // min frequency
      uart_flipflops[22] <= 32'h0013;     // max frequency
      uart_flipflops[23] <= 32'h0005;     // vga
    end else if (uart_wr_en && uart_addr >= 20 && uart_addr <= 25) begin
      uart_flipflops[uart_addr] <= uart_data_in;
    end
  end
  
  // bartlett writing
  integer j;
  always @(posedge clk or negedge rst_n) begin  
    if (!rst_n) begin
      for (j = 0; j <= 19; j = j + 1)
        bartlett_flipflops[j] <= 0;
      bartlett_flipflops[19] <= 32'hFFFF;  // default value for the maxangle
    end else if (bartlett_wr_en && bartlett_addr <= 19) begin
      bartlett_flipflops[bartlett_addr] <= bartlett_data_in;
    end
  end
  
  // uart reading
  always @(*) begin
    if (uart_addr <= 19)
      uart_data_out = bartlett_flipflops[uart_addr];
    else if (uart_addr >= 20 && uart_addr <= 25)
      uart_data_out = uart_flipflops[uart_addr];  
    else
      uart_data_out = 32'hzzzzzzzz;  // invalid read
  end
  
  // bartlett reading
  always @(*) begin
    if (bartlett_addr >= 20 && bartlett_addr <= 22)
      bartlett_data_out = uart_flipflops[bartlett_addr];
    else
      bartlett_data_out = 32'hzzzzzzzz;  // invalid read
  end
  
  assign maxangle      = bartlett_flipflops[19];
  assign threshold     = uart_flipflops[20];
  assign min_frequency = uart_flipflops[21];
  assign max_frequency = uart_flipflops[22];
  assign vga           = uart_flipflops[23];
  assign dumpram       = uart_flipflops[24][0];
  assign softreset     = uart_flipflops[25][0];
endmodule
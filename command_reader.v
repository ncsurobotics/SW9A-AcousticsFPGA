`timescale 1ns / 1ps
// uses negedge reset
module command_reader (
  input clk,
  input rst_n,                
  input [7:0] uart_addr,
  input uart_wr_en,
  input [31:0] uart_data_in,
  output reg [31:0] uart_data_out,
  input [4:0] bartlett_addr,
  input bartlett_wr_en,
  input [31:0] bartlett_data_in,
  output [7:0] threshold,
  output [7:0] frequency,
  output [7:0] vga,
  output dumpram,
  output sendmaxangle,
  output softreset
);

  // do the actual register file with 26 of them and each is 32 bits
  reg [31:0] flipflops [0:25];

  // to write the data to the flipflops
  integer i;
  always @(posedge clk or negedge rst_n) begin  
    if (!rst_n) begin
      for (i = 21; i <= 25; i = i + 1)
        flipflops[i] <= 0;
    end else if (uart_wr_en && uart_addr >= 21 && uart_addr <= 25) begin
      flipflops[uart_addr] <= uart_data_in;
    end
  end
  
  integer j;
  always @(posedge clk or negedge rst_n) begin  
    if (!rst_n) begin
      for (j = 0; j <= 19; j = j + 1)
        flipflops[j] <= 0;
    end else if (bartlett_wr_en && bartlett_addr <= 19) begin
      flipflops[bartlett_addr] <= bartlett_data_in;
    end
  end

  // to read the data from the flipflops (mux)
  // uart
  always @(*) begin
    if (uart_addr >= 21 && uart_addr <= 25)
      uart_data_out = flipflops[uart_addr];  
    else
      uart_data_out = 32'hzzzzzzzz;  // invalid read
  end

  assign threshold     = flipflops[20][7:0];
  assign frequency     = flipflops[21][7:0];
  assign vga           = flipflops[22][7:0];
  assign dumpram       = flipflops[23][0];  // hardwired output for dump ram
  assign sendmaxangle  = flipflops[24][0];  // hardwired output for max angle
  assign softreset     = flipflops[25][0];  // hardwired output for soft reset

endmodule

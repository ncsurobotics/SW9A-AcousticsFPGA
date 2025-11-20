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
  output [31:0] threshold,
  output [31:0] frequency,
  output [31:0] vga,
  output dumpram,
  output sendmaxangle,
  output softreset,
  output [31:0] maxangle,
  output reg [31:0] bartlett_flipflops [0:19]
);


  // Random Message


  reg [31:0] uart_flipflops [20:25];

  // to write the data to the flipflops
  // uart
  integer i;
  always @(posedge clk or negedge rst_n) begin  
    if (!rst_n) begin
      for (i = 19; i <= 24; i = i + 1)
        uart_flipflops[i] <= 0;
    end else if (uart_wr_en && uart_addr >= 20 && uart_addr <= 25) begin
      uart_flipflops[uart_addr] <= uart_data_in;
    end
  end
  
  // bartlett
  integer j;
  always @(posedge clk or negedge rst_n) begin  
    if (!rst_n) begin
      for (j = 0; j <= 19; j = j + 1)
        bartlett_flipflops[j] <= 0;
    end else if (bartlett_wr_en && bartlett_addr <= 19) begin
      bartlett_flipflops[bartlett_addr] <= bartlett_data_in;
    end
  end

  // to read the data from the flipflops (mux)
  // uart
  always @(*) begin
    if (uart_addr >= 19 && uart_addr <= 24)
      uart_data_out = uart_flipflops[uart_addr];  
    else
      uart_data_out = 32'hzzzzzzzz;  // invalid read
  end

  assign maxangle      = uart_flipflops[19][7:0]
  assign threshold     = uart_flipflops[20][7:0];
  assign frequency     = uart_flipflops[21][7:0];
  assign vga           = uart_flipflops[22][7:0];
  assign dumpram       = uart_flipflops[23][0];  // hardwired output for dump ram
  assign softreset     = uart_flipflops[25][0];  // hardwired output for soft reset

endmodule

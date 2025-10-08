`timescale 1ns / 1ps
// uses negedge reset
module command_reader (
  input clk,
  input rst_n,                
  input [7:0] addr,           
  input wr_en,
  input rd_en,
  input [31:0] data_in,
  output reg [31:0] data_out,
  input [4:0] bartlett_addr,
  input bartlett_rd_en,
  output reg [31:0] bartlett_data_out,
  output [7:0] threshold,
  output [7:0] frequency,
  output [7:0] vga
);

  // do the actual register file with 26 of them and each is 32 bits
  reg [31:0] flipflops [0:25];

// to write the data to the flipflops
  integer i;
  always @(posedge clk or negedge rst_n) begin  
    if (!rst_n) begin
      for (i = 0; i <= 25; i = i + 1)
        flipflops[i] <= 0;
    end else if (wr_en) begin
      flipflops[addr] <= data_in;
    end
  end

  // to read the data from the flipflops (mux)

  //uart
  always @(*) begin
      data_out = flipflops[addr];  
  end

  //bartlett
  always @(*) begin
      bartlett_data_out = flipflops[bartlett_addr];
  end

  assign threshold = flipflops[20][7:0];
  assign frequency = flipflops[21][7:0];
  assign vga = flipflops[22][7:0];
  wire dumpram       = flipflops[23][0];
  wire sendmaxangle  = flipflops[24][0];
  wire softreset     = flipflops[25][0];

endmodule

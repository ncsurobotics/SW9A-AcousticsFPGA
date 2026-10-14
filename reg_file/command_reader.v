`timescale 1ns / 1ps
// uses negedge reset
module command_reader (
  input clk,
  input rst_n,
  // axi4-lite write address channel
  input [8:0] s_axi_awaddr,
  input s_axi_awvalid,
  output reg s_axi_awready,
  // axi4-lite write data channel
  input [31:0] s_axi_wdata,
  input [3:0] s_axi_wstrb,
  input s_axi_wvalid,
  output reg s_axi_wready,
  // axi4-lite write response channel
  output reg [1:0] s_axi_bresp,
  output reg s_axi_bvalid,
  input s_axi_bready,
  // axi4-lite read address channel
  input [8:0] s_axi_araddr,
  input s_axi_arvalid,
  output reg s_axi_arready,
  // axi4-lite read data channel
  output reg [31:0] s_axi_rdata,
  output reg [1:0] s_axi_rresp,
  output reg s_axi_rvalid,
  input s_axi_rready,
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

  // latched addresses for the write and read channels
  reg [8:0] axi_awaddr;
  reg [8:0] axi_araddr;

  // word index pulled out of the latched byte address, same 0-25 space as before
  wire [6:0] wr_idx = axi_awaddr[8:2];
  wire [6:0] rd_idx = axi_araddr[8:2];

  // write fires once we have a valid address and data both latched
  wire slv_reg_wren = s_axi_wready && s_axi_wvalid && s_axi_awready && s_axi_awvalid;
  // read fires once we have a valid address latched and arent already holding a response
  wire slv_reg_rden = s_axi_arready && s_axi_arvalid && !s_axi_rvalid;

  // aw channel handshake, latch the address
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      s_axi_awready <= 0;
      axi_awaddr <= 0;
    end else if (!s_axi_awready && s_axi_awvalid && s_axi_wvalid) begin
      s_axi_awready <= 1;
      axi_awaddr <= s_axi_awaddr;
    end else begin
      s_axi_awready <= 0;
    end
  end

  // w channel handshake
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      s_axi_wready <= 0;
    else if (!s_axi_wready && s_axi_wvalid && s_axi_awvalid)
      s_axi_wready <= 1;
    else
      s_axi_wready <= 0;
  end

  // uart writing
  integer i;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      for (i = 20; i <= 25; i = i + 1)
        uart_flipflops[i] <= 0;
      // default stuff
      uart_flipflops[20] <= 32'h0800000;  // threshold
      uart_flipflops[21] <= 32'h0007;     // min frequency
      uart_flipflops[22] <= 32'h0013;     // max frequency
      uart_flipflops[23] <= 32'h0005;     // vga
    end else if (slv_reg_wren && wr_idx >= 20 && wr_idx <= 25) begin
      uart_flipflops[wr_idx] <= s_axi_wdata;
    end
  end

  // b channel, ack the write
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      s_axi_bvalid <= 0;
      s_axi_bresp <= 0;
    end else if (slv_reg_wren && !s_axi_bvalid) begin
      s_axi_bvalid <= 1;
      s_axi_bresp <= 2'b00;  // okay, we dont bother flagging slverr on bad addrs
    end else if (s_axi_bready && s_axi_bvalid) begin
      s_axi_bvalid <= 0;
    end
  end

  // ar channel handshake, latch the address
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      s_axi_arready <= 0;
      axi_araddr <= 0;
    end else if (!s_axi_arready && s_axi_arvalid) begin
      s_axi_arready <= 1;
      axi_araddr <= s_axi_araddr;
    end else begin
      s_axi_arready <= 0;
    end
  end

  // r channel, uart reading
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      s_axi_rvalid <= 0;
      s_axi_rresp <= 0;
    end else if (slv_reg_rden) begin
      s_axi_rvalid <= 1;
      s_axi_rresp <= 2'b00;
      if (rd_idx == 19)
        s_axi_rdata <= bartlett_flipflops[rd_idx];
      else if (rd_idx >= 20 && rd_idx <= 25)
        s_axi_rdata <= uart_flipflops[rd_idx];
      else
        s_axi_rdata <= 32'hzzzzzzzz;  // invalid read
    end else if (s_axi_rvalid && s_axi_rready) begin
      s_axi_rvalid <= 0;
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
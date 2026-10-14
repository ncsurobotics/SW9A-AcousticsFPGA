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
// axi write address channel
  reg [8:0] s_axi_awaddr;
  reg s_axi_awvalid;
  wire s_axi_awready;
// axi write data channel
  reg [31:0] s_axi_wdata;
  reg [3:0] s_axi_wstrb;
  reg s_axi_wvalid;
  wire s_axi_wready;
// axi write response channel
  wire [1:0] s_axi_bresp;
  wire s_axi_bvalid;
  reg s_axi_bready;
// axi read address channel
  reg [8:0] s_axi_araddr;
  reg s_axi_arvalid;
  wire s_axi_arready;
// axi read data channel
  wire [31:0] s_axi_rdata;
  wire [1:0] s_axi_rresp;
  wire s_axi_rvalid;
  reg s_axi_rready;
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
  wire softreset;
  wire [31:0] maxangle;
// instantiate dut
  command_reader dut (
    .clk(clk),
    .rst_n(rst_n),
    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awready(s_axi_awready),
    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(s_axi_wstrb),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wready(s_axi_wready),
    .s_axi_bresp(s_axi_bresp),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bready(s_axi_bready),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready),
    .bartlett_addr(bartlett_addr),
    .bartlett_wr_en(bartlett_wr_en),
    .bartlett_data_in(bartlett_data_in),
    .bartlett_data_out(bartlett_data_out),
    .threshold(threshold),
    .min_frequency(min_frequency),
    .max_frequency(max_frequency),
    .vga(vga),
    .dumpram(dumpram),
    .softreset(softreset),
    .maxangle(maxangle)
  );
// clk gen
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns period

// axi write task, word index shifted up by 2 to make a byte address
  task axi_write(input [6:0] idx, input [31:0] data);
    begin
      @(posedge clk);
      s_axi_awaddr = {idx, 2'b00};
      s_axi_awvalid = 1;
      s_axi_wdata = data;
      s_axi_wstrb = 4'hF;
      s_axi_wvalid = 1;
      s_axi_bready = 1;
      @(posedge clk);
      while (!(s_axi_awready && s_axi_wready)) @(posedge clk);
      s_axi_awvalid = 0;
      s_axi_wvalid = 0;
      while (!s_axi_bvalid) @(posedge clk);
      @(posedge clk);
      s_axi_bready = 0;
    end
  endtask

// axi read task, same idx to byte addr shift
  task axi_read(input [6:0] idx, output [31:0] data);
    begin
      @(posedge clk);
      s_axi_araddr = {idx, 2'b00};
      s_axi_arvalid = 1;
      s_axi_rready = 1;
      @(posedge clk);
      while (!s_axi_arready) @(posedge clk);
      s_axi_arvalid = 0;
      while (!s_axi_rvalid) @(posedge clk);
      data = s_axi_rdata;
      @(posedge clk);
      s_axi_rready = 0;
    end
  endtask

// test sequence
  reg [31:0] readback;
  initial begin
    $display("Started");
    s_axi_awaddr = 0;
    s_axi_awvalid = 0;
    s_axi_wdata = 0;
    s_axi_wstrb = 0;
    s_axi_wvalid = 0;
    s_axi_bready = 0;
    s_axi_araddr = 0;
    s_axi_arvalid = 0;
    s_axi_rready = 0;
    bartlett_addr = 0;
    bartlett_wr_en = 0;
    bartlett_data_in = 0;
    rst_n = 0;
    // reset pulse
    #10 rst_n = 1;
    // axi write threshold
    axi_write(7'd20, 32'h000000AA);
    // axi write min frequency
    axi_write(7'd21, 32'h000000BB);
    // axi write max frequency
    axi_write(7'd22, 32'h000000CC);
    // axi write vga
    axi_write(7'd23, 32'h000000DD);
    // axi read threshold
    axi_read(7'd20, readback);
    $display("AXI Read flipflops[20] = %h", readback);
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
    // axi write to bartlett address (should land, axi side doesnt know about the bartlett split)
    axi_write(7'd5, 32'h11111111);
    // bartlett write to uart address (should fail)
    #10 bartlett_addr = 5'd21;
        bartlett_data_in = 32'h22222222;
        bartlett_wr_en = 1;
    #10 bartlett_wr_en = 0;
    // axi read bartlett bin 5
    axi_read(7'd5, readback);
    $display("AXI Read flipflops[5] = %h (should be all Z)", readback);
    // axi read min frequency
    axi_read(7'd21, readback);
    $display("AXI Read flipflops[21] = %h (should be bb)", readback);
    // done
    #10 $finish;
  end
endmodule
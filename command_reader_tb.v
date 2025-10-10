`timescale 1ns / 1ps

module command_reader_tb;

// waveform dump setup
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, command_reader_tb);
  end

 // do the signals that run this
  reg clk;
  reg rst_n;

// for the uart
  reg [7:0] uart_addr;
  reg uart_wr_en;
  reg [31:0] uart_data_in;
  wire [31:0] uart_data_out;

// for the bartlett
  reg [4:0] bartlett_addr;
  reg bartlett_wr_en;
  reg [31:0] bartlett_data_in;

// the outputs
  wire [7:0] threshold;
  wire [7:0] frequency;
  wire [7:0] vga;

// connect everything
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
    .threshold(threshold),
    .frequency(frequency),
    .vga(vga)
  );

// make the clock
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns period

// start the test
  initial begin
    $display("Started");

    // get everything ready
    uart_addr = 0;
    uart_wr_en = 0;
    uart_data_in = 0;
    bartlett_addr = 0;
    bartlett_wr_en = 0;
    bartlett_data_in = 0;
    rst_n = 0;

    // reset
    #10 rst_n = 1;

    // simulate the uart writing to the threshold
    #10 uart_addr = 8'd20;
        uart_data_in = 32'h000000AA;
        uart_wr_en = 1;
    #10 uart_wr_en = 0;

    // simulate the uart writing to the frequency
    #10 uart_addr = 8'd21;
        uart_data_in = 32'h000000BB;
        uart_wr_en = 1;
    #10 uart_wr_en = 0;

    // simulate the uart writing to the vga
    #10 uart_addr = 8'd22;
        uart_data_in = 32'h000000CC;
        uart_wr_en = 1;
    #10 uart_wr_en = 0;

    // simulate uart reading from the threshold
    #10 uart_addr = 8'd20;
    #10 $display("UART Read flipflops[20] = %h", uart_data_out);

    // simulate bartlett writing to bin 0
    #10 bartlett_addr = 5'd0;
        bartlett_data_in = 32'hCAFEBABE;
        bartlett_wr_en = 1;
    #10 bartlett_wr_en = 0;

    // simulate the bartlett writing to bin 19
    #10 bartlett_addr = 5'd19;
        bartlett_data_in = 32'hCAFEBABE;
        bartlett_wr_en = 1;
    #10 bartlett_wr_en = 0;

    // check the hardwired outputs
    #10 $display("Threshold = %h", threshold);
        $display("Frequency = %h", frequency);
        $display("VGA       = %h", vga);

    // try to enter in a bartlett address into the uart_addr port
    #10 uart_addr = 8'd5;
        uart_data_in = 32'h11111111;
        uart_wr_en = 1;
    #10 uart_wr_en = 0;

    // try to enter in a uart address into the bartlett_addr port
    #10 bartlett_addr = 5'd21;
        bartlett_data_in = 32'h22222222;
        bartlett_wr_en = 1;
    #10 bartlett_wr_en = 0;

    // read back both to see what happened
    #10 uart_addr = 8'd5;
    #10 $display("UART Read flipflops[5] = %h", uart_data_out);

    #10 uart_addr = 8'd21;
    #10 $display("UART Read flipflops[21] = %h", uart_data_out);

    // finish up the simulation
    #10 $finish;
  end

endmodule

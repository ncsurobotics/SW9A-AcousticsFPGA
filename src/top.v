`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2025 12:45:30 AM
// Design Name: 
// Module Name: top
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
`define CHANNEL_COUNT 4
module cmod_a7_board(
	input sysclk, // 12mhz on board oscillator
	
	//LEDS - NOT USED
	output[1:0] led, // single color leds
	output led0_b,//tricolor led blue channel
	output led0_g,//tricolor led green channel
	output led0_r,//tricolor led red channel
	
	//Buttons
	input [1:0] btn, //on board buttons
	
	//PMOD Header JA - NOT USED
	//inout[7:0] ja, // pmod header
	
	// Analog XADC Pins - UNCOMMENT THESE IF USING THE XADC (WE DONT USE IT)
	//input[1:0] xa_n,negative input
	//input[1:0] xa_p,positive input
	
	//GPIO Pins - number corresponds to physical board pin number
	output pio1, // UART RX - to mcu
	output pio2, // UART TX - to mcu
	input pio3, // not connected
	input pio4, // not connected
	input pio5, // not connected
	input pio6, // not connected
	input pio7, // not connected
	input pio8, // not connected
	input pio9, // not connected
	input pio10,// not connected
	input pio11,// not connected
	input pio12,// not connected
	input pio13,// not connected
	input pio14,// not connected
	// pio15 == analog
	// pio 16 == analog
	input pio17,// not connected
	input pio18,// not connected
	input pio19,// not connected
	input pio20,// not connected
	input pio21,// not connected
	input pio22,// not connected
	input pio23,// not connected
	// pio24 == +3.3V
	// pio25 == GND
	output pio26,// not connected
	output pio27,// not connected
	output pio28,// not connected
	output pio29,// not connected
	output pio30,// not connected
	output pio31,// not connected
	output pio32,// not connected
	output pio33,// not connected
	output pio34,// not connected
	input pio35,// not not connected
	input pio36,//  not connected
	input pio37,//  not connected
	input pio38,//  not connected
	input pio39,//  not connected
	input pio40,//  not connected
	input pio41,//  not connected
	input pio42,// not  connected
	input pio44,// not connected
	input pio43,// ot connected
	input pio45,// ot connected
	input pio46,// ot connected
	input pio47,// ot connected
	input pio48,// ot connected
	
	
	// UART - Connects to USB port- NOT USED
	input uart_txd_in,
	output uart_rxd_out
	
	//Crypto 1 Wire interface - NOT USED
	//input crypto_sda, 

	// Cellular RAM - 512kb of off chip on board SRAM - NOT USED
	// output[19:0] MemAdr, // memory address
	// inout[7:0] MemDB, // memory data line
	// output RamOEn, // output enable - active low
	// output RamWEn, // write enable - active low
	// output RAMCEn // chip enable - active low
);
	
	wire [5:0] SPI_SCLK;
	wire [5:0] SPI_CS_N;
	wire [5:0] SPI_DI;
	wire [5:0] SPI_SDO_DRDY;
	wire [5:0] SPI_START;
	
	
	assign pio34 = 1'bz; // nc
	assign pio33 = 1'bz; // nc
	assign pio32 = SPI_SDO_DRDY[0];
	assign pio31 = SPI_SCLK[0];
	assign pio30 = 1'bz; // nc
	assign pio29 = SPI_DI[0];
	assign pio28 = SPI_CS_N[0];
	assign pio27 = ~btn[1];// active low reset
	assign pio26 = SPI_START[0];
	
	assign pio1 = uart_rxd_out; // UART RX - to mcu
	assign pio2 = uart_txd_in; // UART TX - to mcu
	
top  #(
	.CLOCK_MODE("SYNTHESIS"),
	.DEBUG_MODE("FALSE")
	) top_inst(
    .reset_b(led_button),
    .clk_12mhz(sysclk),

	.SPI_SCLK(SPI_SCLK),
	.SPI_CS_N(SPI_CS_N),
	.SPI_DI(SPI_DI),
	.SPI_SDO_DRDY(SPI_SDO_DRDY),
	.SPI_START(SPI_START),
	
        
		// UART
    .UART_tx(uart_rxd_out),
    .UART_rx(uart_txd_in)

    // VGA
    //.VGA1({pio6,pio7,pio8}),
    //.VGA2({pio48,pio47,pio46}),
    //.VGA3({pio36,pio37,pio38}),
    //.VGA4({pio34,pio33,pio32}),

    // Other I/O
    //.debug1(pio23),
    //.debug2(pio22),
    //.debug3(pio21),
    //.debug4(pio20)

);
    
	reg led_button;
	always@(posedge sysclk)begin
		led_button <= ~btn[0];
	end
	assign led[0] = led_button & sysclk; //%50 duty cycle
	assign led[1] = 0;
	
	assign led0_b = 1'bz;
	assign led0_g = 1'bz;
	assign led0_r = 1'bz;
	
endmodule

module top #(
	parameter CLOCK_MODE = "SYNTHESIS", //valid clock modes - "SYNTHESIS":valid for synthesis/bitstream, "SIMULATION_FAST":valid for simulation, all clocks are sysclk
	parameter DEBUG_MODE = "FALSE" // false - the spi continuously tries to read from the ADC, true - the spi only reads from 'adc' per button press.
	)(
    input reset_b,
    input clk_12mhz,
	input sample_mem_reset,

    // SPI
	// To and From ADC (off chip)
	output[5:0] SPI_SCLK,
	output[5:0]	SPI_CS_N,
	output[5:0] SPI_DI,
	input[5:0] SPI_SDO_DRDY,
	output[5:0] SPI_START,
	
	
    // UART
    output UART_tx,
    input UART_rx,

    // VGA
    output[2:0] VGA1,
    output[2:0] VGA2,
    output[2:0] VGA3,
    output[2:0] VGA4,

    // Other I/O
    output debug1,
    output debug2,
    output debug3,
    output debug4
);

////////////////////////////////////////////////////////////////////////////////////////////
// clocking wizard and clock divider to generate required clocks
wire UART_clk, SPI_clk_2x, SPI_clk,clk_100mhz;

generate
if(CLOCK_MODE=="SYNTHESIS")begin
clk_wiz_0 clk_wiz_inst (
    .clk_in1(clk_12mhz),  // input 12 MHz

    .UART_clk(UART_clk),  // output 5.76 MHz
    .SPI_clk_2x(SPI_clk_2x),   // output 6 MHz (IP cannot output below 5MHz)
	.clk_100mhz(clk_100mhz) // output 100.28571
);
clk_divide_2 clk_div_inst (
    .clk_in(SPI_clk_2x), // input 6 MHz
    .clk_out(SPI_clk) // output 3 MHz
);
end else if(CLOCK_MODE=="SIMULATION_FAST")begin
assign SPI_clk = clk_12mhz;
assign SPI_clk_2x = clk_12mhz;
assign UART_clk = clk_12mhz;
assign clk_100mhz = clk_12mhz;
end
endgenerate

wire spi_aresetn, uart_aresetn, aresetn_100;
assign spi_aresetn = reset_b;
assign uart_aresetn = reset_b;
assign aresetn_100 = reset_b;
/*
   xpm_cdc_async_rst #(
      .DEST_SYNC_FF(4),    // DECIMAL; range: 2-10
      .INIT_SYNC_FF(0),    // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      .RST_ACTIVE_HIGH(0)  // DECIMAL; 0=active low reset, 1=active high reset
   )
   spi_xpm_adc (
      .dest_arst(spi_aresetn), // 1-bit output: src_arst asynchronous reset signal synchronized to destination
                             // clock domain. This output is registered. NOTE: Signal asserts asynchronously
                             // but deasserts synchronously to dest_clk. Width of the reset signal is at least
                             // (DEST_SYNC_FF*dest_clk) period.

      .dest_clk(SPI_clk),   // 1-bit input: Destination clock.
      .src_arst(reset_b)    // 1-bit input: Source asynchronous reset signal.
   );

   xpm_cdc_async_rst #(
      .DEST_SYNC_FF(4),    // DECIMAL; range: 2-10
      .INIT_SYNC_FF(0),    // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      .RST_ACTIVE_HIGH(0)  // DECIMAL; 0=active low reset, 1=active high reset
   )
   uart_xpm_adc (
      .dest_arst(uart_aresetn), // 1-bit output: src_arst asynchronous reset signal synchronized to destination
                             // clock domain. This output is registered. NOTE: Signal asserts asynchronously
                             // but deasserts synchronously to dest_clk. Width of the reset signal is at least
                             // (DEST_SYNC_FF*dest_clk) period.

      .dest_clk(UART_clk),   // 1-bit input: Destination clock.
      .src_arst(reset_b)    // 1-bit input: Source asynchronous reset signal.
   );

   xpm_cdc_async_rst #(
      .DEST_SYNC_FF(4),    // DECIMAL; range: 2-10
      .INIT_SYNC_FF(0),    // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
      .RST_ACTIVE_HIGH(0)  // DECIMAL; 0=active low reset, 1=active high reset
   )
   main_xpm_adc (
      .dest_arst(aresetn_100), // 1-bit output: src_arst asynchronous reset signal synchronized to destination
                             // clock domain. This output is registered. NOTE: Signal asserts asynchronously
                             // but deasserts synchronously to dest_clk. Width of the reset signal is at least
                             // (DEST_SYNC_FF*dest_clk) period.

      .dest_clk(clk_100mhz),   // 1-bit input: Destination clock.
      .src_arst(reset_b)    // 1-bit input: Source asynchronous reset signal.
   );
*/

////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////

/*
    Need to implement reset_handler to include soft reset functionality
*/

////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////
// Instantiate the UART Modules
wire[7:0] s_axis_uart_tdata;
wire s_axis_uart_tvalid, s_axis_uart_tready;

wire[7:0] m_axis_uart_tdata;
wire m_axis_uart_tvalid;

	UART_axis_wrapper uart_inst(
		.s_axis_clk(clk_100mhz),
		.s_axis_areset_n(aresetn_100),
		
		.s_axis_tdata(s_axis_uart_tdata),
		.s_axis_tvalid(s_axis_uart_tvalid),
		.s_axis_tready(s_axis_uart_tready),
		
		.m_axis_tdata(m_axis_uart_tdata),
		.m_axis_tvalid(m_axis_uart_tvalid),
		
		
		.uart_clk(UART_clk),
		.uart_areset_n(uart_aresetn),
		
		.uart_rx_in(UART_rx),
		.uart_tx_out(UART_tx)
		);
		

UART_TRANSACTION_HANDLER_v2 UART_TRANSACTION_HANDLER_v2_inst(
	.s_axis_clk(clk_100mhz),
	.s_axis_aresetn(aresetn_100),
	
	.s_axis_uart_tdata(m_axis_uart_tdata),
	.s_axis_uart_tvalid(m_axis_uart_tvalid),
	
	.m_axis_uart_tdata(s_axis_uart_tdata),
	.m_axis_uart_tvalid(s_axis_uart_tvalid),
	.m_axis_uart_tready(s_axis_uart_tready),
	
	.regmap_addr(reg_map_addr),
	.regmap_din(reg_map_datain),
	.regmap_dout(reg_map_dataout),
	.regmap_wea(regmap_uart_wen),
	
	.m_axis_spi_tdata(axis_u2s_tdata),
	.m_axis_spi_tdest(axis_u2s_tdest),
	.m_axis_spi_tvalid(axis_u2s_tvalid),
	.m_axis_spi_tready(axis_u2s_tready),
	
	.s_axis_spi_tdata(axis_s2u_tdata),
	.s_axis_spi_tvalid(axis_s2u_tvalid),
	.s_axis_spi_tlast(axis_s2u_tready),
	.s_axis_spi_tready(axis_s2u_tlast),
	
	.mem_addr(),
	.mem_din(),
	.mem_dout(),
	.mem_wea(),
	
	.max_angle(maxangle)
	);
	
	
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// Instantiate the Register map
wire [31:0] reg_map_datain, reg_map_dataout;
wire bartlett_valid, dumpram, softreset;
wire UART_ready, regmap_uart_wen;
wire [2:0] vga;
wire [5:0] reg_map_addr;
wire spi_select;
command_reader command_reader_inst (
    .clk(clk_100mhz),
    .rst_n(aresetn_100),
    .uart_addr(reg_map_addr),
    .uart_wr_en(regmap_uart_wen),
    .uart_data_in(reg_map_datain),
    .uart_data_out(reg_map_dataout),
    .bartlett_addr(bartlett_addr),
    .bartlett_wr_en(bartlett_valid),
    .bartlett_data_in(bartlett_data_in),
    .bartlett_data_out(),
    .threshold(threshold),
    .min_frequency(min_frequency),
    .max_frequency(max_frequency),
    .vga(vga),
    .dumpram(dumpram),
    .softreset(softreset),
    .maxangle(maxangle),
	.spi_select(spi_select)
);

// assign 3 Lsb's of vga to VGA outputs
assign VGA1 = vga;
assign VGA2 = vga;
assign VGA3 = vga;
assign VGA4 = vga;

//////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////


wire[15:0] axis_u2s_tdata;
wire[`CHANNEL_COUNT:0] axis_u2s_tdest;
wire axis_u2s_tvalid, axis_u2s_tready;

wire[7:0] axis_s2u_tdata;
wire axis_s2u_tvalid, axis_s2u_tready, axis_s2u_tlast;

ADC_SPI_BATCH #(
	.CHANNEL_COUNT(`CHANNEL_COUNT), // number of hydrophones/channels
	.CONVERSION_FRAME_SIZE(256) // fft frame size
	) ADC_SPI_BATCH_inst(
	.clk(clk_100mhz),
	.reset_n(aresetn_100),
	
	.SPI_clk(SPI_clk),
	.SPI_reset_n(spi_aresetn),
	
	// From regmap
	.SPI_select(spi_select),
	
	// To and From ADC (off chip)
	.SPI_SCLK(SPI_SCLK),
	.SPI_CS_N(SPI_CS_N),
	.SPI_DI(SPI_DI),
	.SPI_SDO_DRDY(SPI_SDO_DRDY),
	.SPI_START(SPI_START),
	
	// From UART
	.s_axis_tdata(axis_u2s_tdata),
	.s_axis_tdest(axis_u2s_tdest),
	.s_axis_tvalid(axis_u2s_tvalid),
	.s_axis_tready(axis_u2s_tready),
	
	// To UART
	.m_axis_reg_tdata(axis_s2u_tdata),
	.m_axis_reg_tvalid(axis_s2u_tvalid),
	.m_axis_reg_tready(axis_s2u_tready),
	.m_axis_reg_tlast(axis_s2u_tlast),
	
	// To DSP
	.m_axis_conversion_tdata(m_axis_conversion_tdata),
	.m_axis_conversion_tlast(m_axis_conversion_tlast),
	.m_axis_conversion_tvalid(m_axis_conversion_tvalid),
	.m_axis_conversion_tready(m_axis_conversion_tready)
	);
		
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
axis_combiner_0 axis_combiner_0_inst (
  .aclk(clk_100mhz),                    // input wire aclk
  .aresetn(aresetn_100),              // input wire aresetn
  .s_axis_tvalid(m_axis_conversion_tvalid),  // input wire [3 : 0] s_axis_tvalid
  .s_axis_tready(m_axis_conversion_tready),  // output wire [3 : 0] s_axis_tready
  .s_axis_tdata(m_axis_conversion_tdata),    // input wire [63 : 0] s_axis_tdata
  .s_axis_tlast(m_axis_conversion_tlast),    // input wire [3 : 0] s_axis_tlast
  .m_axis_tvalid(m_axis_combined_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(m_axis_combined_tready),  // input wire m_axis_tready
  .m_axis_tdata(m_axis_combined_tdata),    // output wire [63 : 0] m_axis_tdata
  .m_axis_tlast(m_axis_combined_tlast)    // output wire m_axis_tlast
);

wire[63:0] m_axis_combined_tdata;
wire m_axis_combined_tvalid, m_axis_combined_tready, m_axis_combined_tlast; 

wire[16 * `CHANNEL_COUNT - 1:0] m_axis_conversion_tdata;
wire[`CHANNEL_COUNT - 1:0] m_axis_conversion_tvalid, m_axis_conversion_tready, m_axis_conversion_tlast; 

//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// Instantiate the Bartlett Modules and related modules
wire bartlett_ready;
wire bartlett_last;
wire [7:0] bartlett_addr;
wire [31:0] bartlett_data_in, bartlett_data_out, maxangle;
wire [31:0] min_frequency, max_frequency, threshold;
wire data_valid, data_last;
	
wire[47:0] s_axis_bartlett_config_tdata;
wire s_axis_bartlett_config_tvalid, s_axis_bartlett_config_tready;
wire[5:0] s_axis_bartlett_config_tstrb;

// debug

bartlett_datapath bartlett_inst(
    .clk(clk_100mhz), // (in)
    .reset_b(aresetn_100), //(in)
        
    .s_axis_tdata({	16'd0,m_axis_combined_tdata[15:0], 
                        16'd0,m_axis_combined_tdata[31:16],  
                        16'd0,m_axis_combined_tdata[47:32], 
                        16'd0,m_axis_combined_tdata[63:48] }), // (in) 4 channels of 32-bit data
    .s_axis_tvalid(m_axis_combined_tvalid), // (in)
    .s_axis_tready(m_axis_combined_tready), // (out)
    .s_axis_tlast(m_axis_combined_tlast), // (in)
            
    // Config data is preloaded with correct parameters
    .s_axis_config_tdata(s_axis_bartlett_config_tdata), // (in) {upper frequency bound 8, lower frequency bound 8 , magnitude threshold 32}
    .s_axis_config_tstrb(s_axis_bartlett_config_tstrb), // (in)
    .s_axis_config_tvalid(s_axis_bartlett_config_tvalid), // (in)
    .s_axis_config_tready(s_axis_bartlett_config_tready), // (out)

    // output data channel
    .m_axis_tdata(bartlett_data_in), // (out)
    .m_axis_tvalid(bartlett_valid), // (out)
    .m_axis_tlast(bartlett_last), // (out)
    .m_axis_tdest(bartlett_addr), // (out)
        
    //test
    .debug_rxx(), // (out)
    .debug_rxx_valid(), // (out)
	
	.debug_fft(), // (out)
	.debug_fft_valid(), // (out)
	
	.debug_fft_max_index(), // (out)
	.debug_fft_max_index_valid(), // (out)
	
	.debug_fft_mag(), // (out)
	.debug_fft_mag_valid(), // (out)
	
	.debug_current_magnitude(), // (out)
	.debug_current_magnitude_valid(), // (out)
	
	.debug_max_freq_vec(), // (out)
	.debug_max_freq_vec_valid() // (out)
);
	
	
// Controller for bartlett config	
bartlett_config_controller bartlett_config_controller_inst(
	.clk(clk_100mhz),
	.reset_n(aresetn_100),
	.max_frequency(max_frequency),
	.min_frequency(min_frequency),
	.threshold(threshold),
	.m_axis_config_tdata(s_axis_bartlett_config_tdata),
	.m_axis_config_tstrb(s_axis_bartlett_config_tstrb),
	.m_axis_config_tvalid(s_axis_bartlett_config_tvalid),
	.m_axis_config_tready(s_axis_bartlett_config_tready)
);
   
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// assign debug outputs
assign debug1 = 1'b1;
assign debug2 = 1'b1;
assign debug3 = 1'b0;assign debug4 = 1'b0;

//////////////////////////////////////////////////////////////////////////////////////////////


wire[31:0] bram_dina;
wire[31:0] bram_doutb;
wire[12:0] bram_addra;
wire bram_ena, bram_wea;
bartlett_to_dsm bartlett_to_dsm_inst(
	.clk(clk_100mhz),
	.reset_n(aresetn_100),
	.s_axis_tdata(bartlett_data_in),
	.s_axis_tvalid(bartlett_valid),
	.bram_wea(bram_wea),
	.bram_ena(bram_ena),
	.bram_dina(bram_dina),
	.bram_addra(bram_addra)
	);
	
data_storage_memory your_instance_name (
  .clka(clk_100mhz),    // input wire clka
  .ena(bram_ena),      // input wire ena
  .wea(bram_wea),      // input wire [0 : 0] wea
  .addra(bram_addra),  // input wire [12 : 0] addra
  .dina(bram_dina),    // input wire [31 : 0] dina
  .douta(),  // output wire [31 : 0] douta
  
  .clkb(clk_100mhz),    // input wire clkb
  .enb(1),      // input wire enb
  .web(0),      // input wire [0 : 0] web
  .addrb(reg_map_datain),  // input wire [12 : 0] addrb
  .dinb(0),    // input wire [31 : 0] dinb
  .doutb(bram_doutb)  // output wire [31 : 0] doutb
);






endmodule
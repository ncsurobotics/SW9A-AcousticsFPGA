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

module cmod_a7_board(
	input sysclk, // 12mhz on board oscillator
	
	//LEDS - NOT USED
	output[1:0] led, // single color leds
	//output led0_b,//tricolor led blue channel
	//output led0_g,//tricolor led green channel
	//output led0_r,//tricolor led red channel
	
	//Buttons
	input [1:0] btn, //on board buttons
	
	//PMOD Header JA - NOT USED
	//inout[7:0] ja, // pmod header
	
	// Analog XADC Pins - UNCOMMENT THESE IF USING THE XADC (WE DONT USE IT)
	//input[1:0] xa_n,negative input
	//input[1:0] xa_p,positive input
	
	//GPIO Pins - number corresponds to physical board pin number
	input pio1, // UART RX
	output pio2, // UART TX
	output pio3, // Acoustic Single Channel 1 - Clock 
	input pio4, // Acoustic Single Channel 1 - Data
	output pio5, // Acoustic Single Channel 1 - CS (Chip Select)
	output pio6, // Acoustic Single Channel 1 - VGA Gain[2] 
	output pio7, // Acoustic Single Channel 1 - VGA Gain[1]
	output pio8, // Acoustic Single Channel 1 - VGA Gain[0]
	input pio9, // not connected
	input pio10,// not connected
	input pio11,// not connected
	input pio12,// not connected
	input pio13,// not connected
	input pio14,// not connected
	// pio15 == analog
	// pio 16 == analog
	input pio17,// not connected
	input pio18,// reset_n pushbutton (active low)
	input pio19,// not connected
	output pio20,// debug header 4
	output pio21,// debug header 3
	output pio22,// debug header 2
	output pio23,// debug header 1
	// pio24 == +3.3V
	// pio25 == GND
	input pio26,// not connected
	input pio27,// not connected
	input pio28,// not connected
	output pio29,// Acoustic Single Channel 4 - CS (Chip Select) 
	output pio30,// Acoustic Single Channel 4 - Clock
	input pio31,// Acoustic Single Channel 4 - Data
	output pio32,// Acoustic Single Channel 4 - VGA Gain[0] 
	output pio33,// Acoustic Single Channel 4 - VGA Gain[1]
	output pio34,// Acoustic Single Channel 4 - VGA Gain[2]
	input pio35,// not connected
	output pio36,// Acoustic Single Channel 3 - VGA Gain[2]
	output pio37,// Acoustic Single Channel 3 - VGA Gain[1]
	output pio38,// Acoustic Single Channel 3 - VGA Gain[0]
	output pio39,// Acoustic Single Channel 3 - CS (Chip Select)  
	input pio40,// Acoustic Single Channel 3 - Data
	output pio41,// Acoustic Single Channel 3 - Clock
	input pio42,// not connected
	input pio44,// Acoustic Single Channel 2 - Data
	output pio43,// Acoustic Single Channel 2 - Clock
	output pio45,// Acoustic Single Channel 2 - CS (Chip Select)  
	output pio46,// Acoustic Single Channel 2 - VGA Gain[0]
	output pio47,// Acoustic Single Channel 2 - VGA Gain[1]
	output pio48// Acoustic Single Channel 2 - VGA Gain[2]
	
	
	// UART - Connects to USB port- NOT USED
	//input uart_txd_in,
	//output uart_rxd_out,
	
	//Crypto 1 Wire interface - NOT USED
	//input crypto_sda, 

	// Cellular RAM - 512kb of off chip on board SRAM - NOT USED
	// output[19:0] MemAdr, // memory address
	// inout[7:0] MemDB, // memory data line
	// output RamOEn, // output enable - active low
	// output RamWEn, // write enable - active low
	// output RAMCEn // chip enable - active low
);
	
	
	
top top_inst (
    .reset_b(pio18),
    .clk_12mhz(sysclk),

    // ADCs
    .ADC_clk1(pio3),
    .ADC_cs1(pio5),
    .ADC_serial_data1(pio4),

    .ADC_clk2(pio43),
    .ADC_cs2(pio45),
    .ADC_serial_data2(pio44),
	
    .ADC_clk3(pio41),
    .ADC_cs3(pio39),
    .ADC_serial_data3(pio40),

    .ADC_clk4(pio30),
    .ADC_cs4(pio29),
    .ADC_serial_data4(pio31),
        
		// UART
    .UART_tx(pio2),
    .UART_rx(pio1),

    // VGA
    .VGA1({pio6,pio7,pio8}),
    .VGA2({pio48,pio47,pio46}),
    .VGA3({pio36,pio37,pio38}),
    .VGA4({pio34,pio33,pio32}),

    // Other I/O
    .debug1(pio23),
    .debug2(pio22),
    .debug3(pio21),
    .debug4(pio20)

);
    
	reg led_button;
	always@(posedge sysclk or negedge pio18)begin
		if(!pio18)begin
			led_button <= 0;
		end else begin
			led_button <= led_button ^ btn[0];
		end
	end
	assign led[0] = led_button & sysclk; //%50 duty cycle
	assign led[1] = 0;
	
endmodule
	

module top(
    input reset_b,
    input clk_12mhz,
    input SPI_btn,

    // ADCs
    output ADC_clk1,
    output ADC_clk2,
    output ADC_clk3,
    output ADC_clk4,

    output ADC_cs1,
    output ADC_cs2,
    output ADC_cs3,
    output ADC_cs4,

    input ADC_serial_data1,
    input ADC_serial_data2,
    input ADC_serial_data3,
    input ADC_serial_data4,

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
wire clock_locked,internal_reset;

  clk_wiz_0 instance_name
   (
    // Clock out ports
    .UART_clk(UART_clk),     // output UART_clk
    .SPI_clk_2x(SPI_clk_2x),     // output SPI_clk_2x
    .clk_100mhz(clk_100mhz),     // output clk_100mhz
    // Status and control signals
    .resetn(reset_b), // input resetn
    .locked(clock_locked),       // output locked
   // Clock in ports
    .clk_in1(clk_12mhz)      // input clk_in1
);

shift_register #(
	.SIZE(1), .STAGES(10)
	) internal_reset_sr (
	.clk(clk_12mhz),
	.reset_n(reset_b),
	.enable(1),
	.din(clock_locked),
	.dout(internal_reset)
	);


clk_div clk_div_inst (
    .clk_in(SPI_clk_2x), // input 6 MHz
    .reset_b(clock_locked), // active low reset
    .clk_out(SPI_clk) // output 3 MHz
);



assign ADC_clk1 = SPI_clk;
assign ADC_clk2 = SPI_clk;
assign ADC_clk3 = SPI_clk;
assign ADC_clk4 = SPI_clk;

////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////

/*
    Need to implement reset_handler to include soft reset functionality
*/

////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////
// Instantiate the UART Modules
wire rx_ready, tx_ready, Word_To_Send_en;
wire [7:0] rx_data, Word_To_Send;

UART UART_inst(	
    .UART_clk(UART_clk),
    .clk(clk_100mhz),
    .reset_b(internal_reset),
    .TX_Data_in(Word_To_Send),
    .TX_en(Word_To_Send_en),
    .RX_Data_in(UART_rx),
                    
    .TX_Data_out(UART_tx),
    .TX_Ready_To_Send(tx_ready),
    .RX_Data_out(rx_data),
    .RX_Data_Ready(rx_ready)   
);

UART_TRANSACTION_HANDLER UART_TRANSACTION_HANDLER_inst( // handles communication between UART and register map
    .clk(clk_100mhz),
    .reset_n(internal_reset),
    .rx_data(rx_data),
    .rx_ready(rx_ready),
    .command_reader_out(reg_map_dataout),
    .uart_tx_ready(tx_ready),
    .uart_addr(reg_map_addr),
    .op(op),
    .uart_data_in(reg_map_datain),
    .Word_To_Send(Word_To_Send),
    .Word_To_Send_en(Word_To_Send_en)
);

//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// Instantiate the Register map
wire [31:0] reg_map_datain, reg_map_dataout;
wire bartlett_valid, dumpram, softreset;
wire UART_ready, op;
wire [2:0] vga;
wire [6:0] reg_map_addr;

command_reader command_reader_inst (
    .clk(clk_100mhz),
    .rst_n(internal_reset),
    .uart_addr(reg_map_addr),
    .uart_wr_en(op),
    .uart_data_in(reg_map_datain),
    .uart_data_out(reg_map_dataout),
    .bartlett_valid(bartlett_valid),
    .bartlett_data_in(bartlett_data_in),
    .threshold(threshold),
    .min_frequency(min_frequency),
    .max_frequency(max_frequency),
    .vga(vga),
    .dumpram(dumpram),
    .softreset(softreset),
    .maxangle(maxangle)
);

// assign 3 Lsb's of vga to VGA outputs
assign VGA1 = vga;
assign VGA2 = vga;
assign VGA3 = vga;
assign VGA4 = vga;

//////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////
// Instantiate the SPI Modules and connect to memory (Ring Buffers)
// Both of these modules are controlled by the SPI_TRANSACTION_HANDLER
// wire SPI_en1, SPI_en2, SPI_en3, SPI_en4;
wire ADC_Ready1, ADC_Ready2, ADC_Ready3, ADC_Ready4;
wire RAM_Overflow1, RAM_Overflow2, RAM_Overflow3, RAM_Overflow4;
wire [9:0] ADC_data1, ADC_data2, ADC_data3, ADC_data4;


SPI_WRAPPER SPI_WRAPPER_inst( //contains 4 parallelized SPI channels.
    .clk(clk_100mhz), // 100 MHz (input)
    .SPI_clk(SPI_clk), // 3 MHz (input)
    .reset_b(internal_reset),  // active low reset (input)
    .data_in({ADC_serial_data1, ADC_serial_data2, ADC_serial_data3, ADC_serial_data4}), //From outside FPGA
    .SPI_en({bartlett_ready, bartlett_ready, bartlett_ready, bartlett_ready}), //From FSM
    .CS({ADC_cs1, ADC_cs2, ADC_cs3, ADC_cs4}), //Outputs out of FPGA
	.Data_Ready({ADC_Ready1, ADC_Ready2, ADC_Ready3, ADC_Ready4}),
    .SPI_Data_out({ADC_data1, ADC_data2, ADC_data3, ADC_data4}) // parallelized data outputs for FFT and Bartlett
);

/*
// memories to store ADC data before sending to Bartlett module
RING_BUFFER RING_BUFFER_channel_1_inst(

    .clk(clk_100mhz),
    .reset_b(internal_reset),
    .Input_Data(ADC_data1),
    .Input_Data_Ready(ADC_Ready1),
    .Triggered(1'b1),
    .Send_Frame(),
    .RAM_Overflow(),
    .Output_Data()

);

RING_BUFFER RING_BUFFER_channel_2_inst(

    .clk(clk_100mhz),
    .reset_b(internal_reset),
    .Input_Data(ADC_data2),
    .Input_Data_Ready(ADC_Ready2),
    .Triggered(1'b1),
    .Send_Frame(),
    .RAM_Overflow(),
    .Output_Data()

);

RING_BUFFER RING_BUFFER_channel_3_inst(

    .clk(clk_100mhz),
    .reset_b(internal_reset),
    .Input_Data(ADC_data3),
    .Input_Data_Ready(ADC_Ready3),
    .Triggered(1'b1),
    .Send_Frame(),
    .RAM_Overflow(),
    .Output_Data()

);

RING_BUFFER RING_BUFFER_channel_4_inst(

    .clk(clk_100mhz),
    .reset_b(internal_reset),
    .Input_Data(ADC_data4),
    .Input_Data_Ready(ADC_Ready4),
    .Triggered(1'b1),
    .Send_Frame(),
    .RAM_Overflow(),
    .Output_Data()

);

// Controls the SPI transaction process

SPI_TRANSACTION_HANDLER SPI_TRANSACTION_HANDLER_inst(
    .clk(clk_100mhz),
    .reset_n(internal_reset),

    .sample_ready({ADC_Ready1, ADC_Ready2, ADC_Ready3, ADC_Ready4}),
    .bartlett_ready(bartlett_ready),
    .SPI_en({SPI_en1, SPI_en2, SPI_en3, SPI_en4}),
    .Send_Frame({Send_Frame1, Send_Frame2, Send_Frame3, Send_Frame4}),
    .data_valid(data_valid),
    .data_last(data_last)
);
*/
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
// Instantiate the Bartlett Modules and related modules
wire bartlett_ready;
wire [4:0] bartlett_addr;
wire [31:0] bartlett_data_in, bartlett_data_out, maxangle;
// wire [9:0] bartlett_CH1, bartlett_CH2, bartlett_CH3, bartlett_CH4;
wire [31:0] min_frequency, max_frequency, threshold;
wire data_valid, data_last;
	
wire[47:0] s_axis_bartlett_config_tdata;
wire s_axis_bartlett_config_tvalid, s_axis_bartlett_config_tready;
wire[5:0] s_axis_bartlett_config_tstrb;

// debug
assign data_valid = (ADC_Ready1 | ADC_Ready2) | (ADC_Ready3 | ADC_Ready4);
assign data_last = 1'b0;

bartlett_datapath bartlett_inst(
    .clk(clk_100mhz), // (in)
    .reset_b(internal_reset), //(in)
        
    .s_axis_tdata({	16'd0,{6{ADC_data1[9]}},ADC_data1, 
                        16'd0,{6{ADC_data2[9]}},ADC_data2,  
                        16'd0,{6{ADC_data3[9]}},ADC_data3, 
                        16'd0,{6{ADC_data4[9]}},ADC_data4 }), // (in) 4 channels of 32-bit data
    .s_axis_tvalid(data_valid), // (in)
    .s_axis_tready(bartlett_ready), // (out)
    .s_axis_tlast(data_last), // (in)
            
    // Config data is preloaded with correct parameters
    .s_axis_config_tdata(s_axis_bartlett_config_tdata), // (in) {upper frequency bound 8, lower frequency bound 8 , magnitude threshold 32}
    .s_axis_config_tstrb(s_axis_bartlett_config_tstrb), // (in)
    .s_axis_config_tvalid(s_axis_bartlett_config_tvalid), // (in)
    .s_axis_config_tready(s_axis_bartlett_config_tready), // (out)

    // output data channel
    .m_axis_tdata(bartlett_data_in), // (out)
    .m_axis_tvalid(bartlett_valid), // (out)
    .m_axis_tlast(), // (out)
    .m_axis_tdest(), // (out)
        
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
	.reset_n(internal_reset),
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
assign debug3 = 1'b0;
assign debug4 = 1'b0;

//////////////////////////////////////////////////////////////////////////////////////////////

endmodule
`timescale 1ns / 1ps
module cmod_a7_board(
	input sysclk, 		// 12MHz on-board oscillator
	
	//LEDS - NOT USED
	output [1:0] led, 	// single color leds
	output led0_b,		// tricolor led blue channel
	output led0_g,		// tricolor led green channel
	output led0_r,		// tricolor led red channel
	
	//Buttons
	input [1:0] btn, // on board buttons
	
	//PMOD Header JA - NOT USED
	//inout[7:0] ja, // pmod header
	
	//GPIO Pins - number corresponds to physical board pin number
	input  pio1,	// AD14N
	input  pio2, 	// AD14P
	input  pio3, 	// not connected
	input  pio4, 	// AD6N
	input  pio5, 	// not connected
	input  pio6, 	// AD5P
	output pio7, 	// PGA Gain G0
	output pio8, 	// PGA Gain G1
	output pio9, 	// PGA Gain G2
	input  pio10,	// AD6P
	input  pio11,	// AD5N
	input  pio12,	// AD13P
	input  pio13,	// not connected
	input  pio14,	// AD13N
	// pio15 :- analog
	// pio16 :- analog
	input  pio17,	// AD7N
	input  pio18,	// not connected
	input  pio19,	// not connected
	input  pio20,	// AD7P
	input  pio21,	// AD15N
	input  pio22,	// AD15P
	input  pio23,	// not connected
	// pio24 :- +3.3V
	// pio25 :- GND
	output pio26,	// LED on Acoustics Board
	input  pio27,	// Debug 3 (debug[2])
	input  pio28,	// Debug 2 (debug[1])
	input  pio29,	// Debug 1 (debug[0])
	input  pio30, 	// not connected
	input  pio31, 	// not connected
	input  pio32, 	// not connected
	input  pio33, 	// not connected
	input  pio34, 	// not connected
	input  pio35, 	// not connected
	input  pio36, 	// not connected
	input  pio37, 	// not connected
	input  pio38, 	// not connected
	input  pio39, 	// not connected
	input  pio40, 	// not connected
	input  pio41, 	// not connected
	input  pio42, 	// not connected
	input  pio44, 	// not connected
	input  pio43, 	// not connected
	input  pio45, 	// not connected
	input  pio46, 	// not connected
	input  pio47,	// UART RX - to MCU
	output pio48,	// UART TX - to MCU
	
	
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

	wire reset_n;			// Asynchronous active low reset, from button

	// Goes to XADC
	wire AD5N;
	wire AD5P;
	wire AD6N;
	wire AD6P;
	wire AD7N;
	wire AD7P;
	wire AD13N;
	wire AD13P;
	wire AD14N;
	wire AD14P;
	wire AD15N;
	wire AD15P;
	
	wire [2:0] PGA_G;		// Gain control for PGAs
	
	// UART with MCU
	wire mcu_uart_tx;
	wire mcu_uart_rx;

	wire [2:0] debug;		// Debug pins on acoustics board
	wire acoustics_led;		// LED on acoustics board, active high

	
	assign reset_n = ~btn[0];
	
	assign AD5N  = pio11;
	assign AD5P  = pio6;
	assign AD6N  = pio4;
	assign AD6P  = pio10;
	assign AD7N  = pio17;
	assign AD7P  = pio20;
	assign AD13N = pio14;
	assign AD13P = pio12;
	assign AD14N = pio1;
	assign AD14P = pio2;
	assign AD15N = pio21;
	assign AD15P = pio22;

	assign {pio9, pio8, pio7} = PGA_G[2:0];

	assign pio48 = mcu_uart_tx;
	assign mcu_uart_rx = pio47;

	assign pio26 = acoustics_led;
	assign debug[2:0] = {pio27, pio28, pio29};

	assign uart_rxd_out = 1'b0;


	assign led[0] = ~reset_n & sysclk;	// Glows at half-brightness during reset
	assign led[1] = 1'b0;	// Turned off
	assign led0_b = 1'b1;	// Turned off
	assign led0_g = 1'b1;	// Turned off
	assign led0_r = 1'b1;	// Turned off
	assign acoustics_led = 1'b0;


	top_bd_wrapper TOP (
		.sysclk(sysclk),
		.reset_n(reset_n),
		.AD5_v_n(AD5N),
        .AD5_v_p(AD5P),
        .AD6_v_n(AD6N),
        .AD6_v_p(AD6P),
        .AD7_v_n(AD7N),
        .AD7_v_p(AD7P),
		.AD13_v_n(AD13N),
        .AD13_v_p(AD13P),
        .AD14_v_n(AD14N),
        .AD14_v_p(AD14P),
        .AD15_v_n(AD15N),
        .AD15_v_p(AD15P),
		.PGA_G(PGA_G),
		.uart_tx(mcu_uart_tx),
		.uart_rx(mcu_uart_rx)
	);


endmodule

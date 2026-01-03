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


module top(
    input reset_b,
    input clk,

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
    output VGA1,
    output VGA2,
    output VGA3,
    output VGA4,

    // Other I/O
    output debug1,
    output debug2,
    output debug3,
    output debug4
    );

////////////////////////////////////////////////////////////////////////////////////////////`
    // clocking wizard and clock divider to generate required clocks
    wire UART_clk, SPI_clk_2x, SPI_clk;

    clk_wiz_0 clk_wiz_inst (
        .clk_in1(clk),      // input 100 MHz
        .resetn(reset_b),   // active low reset
        .UART_clk(UART_clk),  // output 5.76 MHz
        .SPI_clk_2x(SPI_clk_2x)   // output 6 MHz (IP cannot output below 5MHz)
    );
    clk_div clk_div_inst (
        .clk_in(SPI_clk_2x), // input 6 MHz
        .reset_b(reset_b), // active low reset
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
        .clk(clk),
        .reset_b(reset_b),
        .TX_Data_in(Word_To_Send),
        .TX_en(Word_To_Send_en),
        .RX_Data_in(UART_rx),
                    
        .TX_Data_out(UART_tx),
        .TX_Ready_To_Send(tx_ready),
        .RX_Data_out(rx_data),
        .RX_Data_Ready(rx_ready)
        
    );

    UART_TRANSACTION_HANDLER UART_TRANSACTION_HANDLER_inst( // handles communication between UART and register map
        .clk(clk),
        .reset_n(reset_b),
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
    wire bartlett_wr_en, dumpram, softreset;
    wire UART_ready, op;
    wire [2:0] vga;
    wire [6:0] reg_map_addr;
    wire [31:0] reg_map_datain, reg_map_dataout;

    command_reader command_reader_inst (
        .clk(clk),
        .rst_n(reset_b),
        .uart_addr(reg_map_addr),
        .uart_wr_en(op),
        .uart_data_in(reg_map_datain),
        .uart_data_out(reg_map_dataout),
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

// assign 3 Lsb's of vga to VGA outputs
assign VGA1 = vga;
assign VGA2 = vga;
assign VGA3 = vga;
assign VGA4 = vga;

//////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////
    // Instantiate the SPI Modules and connect to memory (Ring Buffers)
    // Both of these modules are controlled by the SPI_TRANSACTION_HANDLER
    wire SPI_en1, SPI_en2, SPI_en3, SPI_en4;
    wire ADC_Ready1, ADC_Ready2, ADC_Ready3, ADC_Ready4;
    wire RAM_Overflow1, RAM_Overflow2, RAM_Overflow3, RAM_Overflow4;
    wire [9:0] ADC_data1, ADC_data2, ADC_data3, ADC_data4;

SPI_WRAPPER SPI_WRAPPER_inst( //contains 4 parallelized SPI channels.
    .clk(clk), // 100 MHz (input)
    .SPI_clk(SPI_clk), // 3 MHz (input)
    .reset_b(reset_b),  // active low reset (input)
    .data_in({ADC_serial_data1, ADC_serial_data2, ADC_serial_data3, ADC_serial_data4}), //From outside FPGA
    .SPI_en({SPI_en4, SPI_en3, SPI_en2, SPI_en1}), //From FSM
    .CS({ADC_cs4, ADC_cs3, ADC_cs2, ADC_cs1}), //Outputs out of FPGA
	.Data_Ready({ADC_Ready1, ADC_Ready2, ADC_Ready3, ADC_Ready4}),
    .SPI_Data_out({ADC_data1, ADC_data2, ADC_data3, ADC_data4}) // parallelized data outputs for FFT and Bartlett
);

// memories to store ADC data before sending to Bartlett module
RING_BUFFER RING_BUFFER_channel_1_inst(

    .clk(clk),
    .reset_b(reset_b),
    .Input_Data({22'd0, ADC_data1}),
    .Input_Data_Ready(ADC_Ready1),
    .Triggered(1'b1),
    .Send_Frame(Send_Frame1),
    .RAM_Overflow(),
    .Output_Data(bartlett_CH1)

);

RING_BUFFER RING_BUFFER_channel_2_inst(

    .clk(clk),
    .reset_b(reset_b),
    .Input_Data({22'd0, ADC_data2}),
    .Input_Data_Ready(ADC_Ready2),
    .Triggered(1'b1),
    .Send_Frame(Send_Frame2),
    .RAM_Overflow(),
    .Output_Data(bartlett_CH2)

);

RING_BUFFER RING_BUFFER_channel_3_inst(

    .clk(clk),
    .reset_b(reset_b),
    .Input_Data({22'd0, ADC_data3}),
    .Input_Data_Ready(ADC_Ready3),
    .Triggered(1'b1),
    .Send_Frame(Send_Frame3),
    .RAM_Overflow(),
    .Output_Data(bartlett_CH3)

);

RING_BUFFER RING_BUFFER_channel_4_inst(

    .clk(clk),
    .reset_b(reset_b),
    .Input_Data({22'd0, ADC_data4}),
    .Input_Data_Ready(ADC_Ready4),
    .Triggered(1'b1),
    .Send_Frame(Send_Frame4),
    .RAM_Overflow(),
    .Output_Data(bartlett_CH4)

);

// Controls the SPI transaction process
SPI_HANDLER_WRAPPER SPI_TRANSACTION_HANDLER_inst(
    .clk(clk),
    .reset_n(reset_b),

    .sample_ready({ADC_Ready1, ADC_Ready2, ADC_Ready3, ADC_Ready4}),
    //.RAM_Overflow({RAM_Overflow1, RAM_Overflow2, RAM_Overflow3, RAM_Overflow4}),
    //.bartlett_ready(bartlett_ready),
    //.SPI_en({SPI_en4, SPI_en3, SPI_en2, SPI_en1}),
    //.Send_Frame({Send_Frame4, Send_Frame3, Send_Frame2, Send_Frame1}),
    //.data_valid_out(data_valid),
    .data_last_out(data_last)
);

//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
/*
    
*/

//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
    // Instantiate the Bartlett Modules
    wire bartlett_ready;
    wire [4:0] bartlett_addr;
    wire [31:0] bartlett_data_in, bartlett_data_out, maxangle;
    wire [31:0] bartlett_CH1, bartlett_CH2, bartlett_CH3, bartlett_CH4;
    wire [31:0] min_frequency, max_frequency, threshold;
    wire data_valid, data_last;

    bartlett_datapath bartlett_inst(
    .clk(clk), // (in)
    .reset_b(reset_b), //(in)
	
    .s_axis_tdata({bartlett_CH1, bartlett_CH2, bartlett_CH3, bartlett_CH4}), // (in) 4 channels of 32-bit data
    .s_axis_tvalid(data_valid), // (in)
    .s_axis_tready(bartlett_ready), // (out)
    .s_axis_tlast(data_last), // (in)
		
	.s_axis_config_tdata({max_frequency[7:0], min_frequency[7:0], threshold}), // (in) {upper frequency bound 8, lower frequency bound 8 , magnitude threshold 32}
	.s_axis_config_tstrb(6'b0), // (in)
	.s_axis_config_tvalid(1'b1), // (in)
	.s_axis_config_tready(), // (out)

	// output data channel
	.m_axis_tdata(bartlett_data_out), // (out)
	.m_axis_tvalid(bartlett_wr_en), // (out)
	.m_axis_tlast(), // (out)
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
    
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
    // assign debug outputs
    assign debug1 = 1'b0;
    assign debug2 = 1'b0;
    assign debug3 = 1'b0;
    assign debug4 = 1'b0;

//////////////////////////////////////////////////////////////////////////////////////////////

endmodule
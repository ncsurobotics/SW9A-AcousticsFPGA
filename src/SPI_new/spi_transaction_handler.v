`timescale 1ns/1ps

module spi_transaction_handler #(
    parameter CHANNEL_COUNT = 6,
    parameter CONVERSION_FRAME_SIZE = 256,
    parameter CLK_DIVIDE = 2,
    parameter DELAY_CYCLES = 10
)(
    input clk,      // 100 MHz
	input reset_n,  // asynchronous
	
	input SPI_select, // 0-adc conversion into dsp, 1-uart passthrough to SPI
	
	// connects to ADCs
	output [CHANNEL_COUNT-1:0] SPI_SCLK,
	output [CHANNEL_COUNT-1:0] SPI_CS_N,
	output [CHANNEL_COUNT-1:0] SPI_DI,
	input  [CHANNEL_COUNT-1:0] SPI_SDO_DRDY,
	output                     SPI_START,
	
	// input channel (for register operations)
    input  [15:0] s_axis_tdata,
	input  [CHANNEL_COUNT-1:0] s_axis_tuser, // bit mask to indicate the corresponding enabled ADCs for register R/W
	input  s_axis_tvalid,
	output s_axis_tready,
	
	// output channels
	output [7:0] m_axis_reg_tdata, // register data
	output m_axis_reg_tvalid,
	output m_axis_reg_tlast,
	input  m_axis_reg_tready,
		
	output [(16*CHANNEL_COUNT)-1:0] m_axis_conversion_tdata, // conversion data
	output m_axis_conversion_tlast,
	output m_axis_conversion_tvalid,
	input m_axis_conversion_tready 
);


    wire [(16*CHANNEL_COUNT)-1:0] decode_cmnd_axis_tdata;
    wire [CHANNEL_COUNT-1:0] decode_cmnd_axis_tvalid;
    wire [CHANNEL_COUNT-1:0] decode_cmnd_axis_tready;

    wire [(16*CHANNEL_COUNT)-1:0] decode_resp_axis_tdata;
    wire [CHANNEL_COUNT-1:0] decode_resp_axis_tvalid;
    wire [CHANNEL_COUNT-1:0] decode_resp_axis_tready;
    wire [CHANNEL_COUNT-1:0] decode_resp_axis_tid;


    wire [(16*CHANNEL_COUNT)-1:0] spi_cmnd_axis_tdata;
    wire [CHANNEL_COUNT-1:0] spi_cmnd_axis_tvalid;
    wire [CHANNEL_COUNT-1:0] spi_cmnd_axis_tready;
    wire [CHANNEL_COUNT-1:0] spi_cmnd_axis_tuser;

    wire [(16*CHANNEL_COUNT)-1:0] spi_resp_axis_tdata;
    wire [CHANNEL_COUNT-1:0] spi_resp_axis_tvalid;
    wire [CHANNEL_COUNT-1:0] spi_resp_axis_tready;
    wire [CHANNEL_COUNT-1:0] spi_resp_axis_tuser;


    adc_spi


    genvar i;
    generate
        for (i = 0; i < CHANNEL_COUNT; i = i + 1) begin
            adc_spi_ads127l21 adc_spi_ads127l21_inst(
                .clk(clk),
                .reset_n(reset_n),

                .s_axis_tdata(decode_cmnd_axis_tdata[i*16 +: 16]),
                .s_axis_tvalid(decode_cmnd_axis_tvalid[i]),
                .s_axis_tready(decode_cmnd_axis_tready[i]),

                .m_axis_tdata(decode_resp_axis_tdata[i*16 +: 16]),
                .m_axis_tvalid(decode_resp_axis_tvalid[i]),
                .m_axis_tready(decode_resp_axis_tready[i]),
                .m_axis_tid(decode_resp_axis_tid[i])

                // Change the signals to SPI_IF
            );

            spi_if #(
                .CLK_DIVIDE(CLK_DIVIDE),
                .DELAY_CYCLES(DELAY_CYCLES)
            ) spi_if_inst (
                .clk(clk),
                .reset_n(reset_n),
                
                .SPI_SCLK(SPI_SCLK[i]),
                .SPI_CS_N(SPI_CS_N[i]),
                .SPI_DI(SPI_DI[i]),
                .SPI_SDO_DRDY(SPI_SDO_DRDY[i]),

                .s_axis_tdata(spi_cmnd_axis_tdata[i*16 +: 16]),
                .s_axis_tvalid(spi_cmnd_axis_tvalid[i]),
                .s_axis_tready(spi_cmnd_axis_tready[i]),
                .s_axis_tuser(spi_cmnd_axis_tuser[i]),

                .m_axis_tdata(spi_resp_axis_tdata[i*16 +: 16]),
                .m_axis_tvalid(spi_resp_axis_tvalid[i]),
                .m_axis_tready(spi_resp_axis_tready[i]),
                .m_axis_tuser(spi_resp_axis_tuser[i])
            );
        end
    endgenerate
    




endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 04:09:35 PM
// Design Name: 
// Module Name: serial_tb
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


module serial_tb();

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
	.SPI_SCLK(),
	.SPI_CS_N(),
	.SPI_DI(),
	.SPI_SDO_DRDY(),
	.SPI_START(),
	
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
	
	
endmodule

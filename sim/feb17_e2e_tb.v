`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2026 10:32:04 PM
// Design Name: 
// Module Name: feb17_e2e_tb
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


module feb17_e2e_tb();


	
top  #(
	.CLOCK_MODE("SIMULATION_FAST"),
	.DEBUG_MODE("TRUE")
	) dut(
    .reset_b(reset_n),
    .clk_12mhz(sysclk),
    .SPI_btn(send_spi_sample),
	.sample_mem_reset(smr),
	
		// UART
    .UART_tx(pio2),
    .UART_rx(pio1)
);

logic reset_n;
logic sysclk;
logic send_spi_sample;
logic smr;


always #5 sysclk = ~sysclk;


initial begin
	sysclk = 1;
	reset_n = 0;
	smr = 1;
	send_spi_sample = 0;
	#10000 reset_n = 1; smr = 0;
	#100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
	#60000 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
		#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
			#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
			#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
			#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
			#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
			#60000 reset_n = 0; #50 reset_n = 1; #100 send_spi_sample = 1;
	#10 send_spi_sample = 0;
	

end

endmodule

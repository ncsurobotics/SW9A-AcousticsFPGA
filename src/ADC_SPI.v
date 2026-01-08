`timescale 1ns/1ps



module ADC_SPI_LTC1197 #(
	parameter PRECISION = 10, // number of bits in the output. 
	parameter PULSE_LENGTH = 14, // number of cycles to hold CS active for
	parameter CS_ACTIVE = 0 // 0 == active low CS, 1 == active high CS
	) (
	input clk,
	input reset_n,
	
	input SPI_clk,
	input SPI_din,
	output reg SPI_CS,
	
	output reg[PRECISION - 1 : 0] m_axis_tdata,
	output reg m_axis_tvalid,
	input m_axis_tready // initiates
	);
	
	wire converted_bit,converted_valid;
	wire[PRECISION - 1 : 0] converted_word, SPI_word;
	reg[$clog2(PULSE_LENGTH) - 1 : 0] spi_counter;
	
	localparam S_IDLE = 2'b0;
	localparam S_CONTROL = 2'b01;
	localparam S_RECEIVING = 2'b10;
	
	reg state;
	
	
	always@(posedge SPI_clk or negedge reset_n)begin
		if(!reset_n)begin
			spi_counter <= 0;
			SPI_CS <= !CS_ACTIVE;
		end else begin
			if(state == S_RECEIVING) begin 
				spi_counter <= spi_counter + 1;
				SPI_CS <= CS_ACTIVE;
			end else begin
				spi_counter <= 0;
				SPI_CS <= !CS_ACTIVE;
			end
			
		end
	end
	wire SPI_valid;
	assign SPI_valid = spi_counter > 3;
	
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_tdata <= 0;
			m_axis_tvalid <= 0;
			state <= S_IDLE;
		end else begin
			case (state)
				S_IDLE:begin
					if(m_axis_tready) state <= S_RECEIVING;
					else state <= S_IDLE;
					m_axis_tvalid <= 0;
					
				end
				S_RECEIVING:begin
					if(spi_counter == PULSE_LENGTH - 1) state <= S_IDLE;
					else state <= S_RECEIVING;
					m_axis_tvalid <= spi_counter == PULSE_LENGTH - 1;
				end
			endcase
			m_axis_tdata <= converted_word;
			
		end
	end


    SIPO #(
		.INPUT_WIDTH(1),
		.OUTPUT_WIDTH(10)
		)
	SIPO_INST(
        .clk(clk),
        .data_in(SPI_din),
        .reset_b(reset_n),
        .data_logging(SPI_valid), //enable
        .data_out(SPI_word)
    );
    
	CDC_DRIVER #(
		.DATA_LENGTH(PRECISION)
		)
		CDC_DRIVER_INST(
		.src_clk(SPI_clk),
		.dest_clk(clk),
		.reset_b(reset_n),
		.Data_Ready(SPI_valid),
		.Data_in(SPI_word),
		.Data_out(converted_word),
		.dest_req(converted_valid)
		);

	
endmodule


module ADC_SPI_LTC1197_CONTROLLER #(
	parameter WAKEUP_CYCLES = 8
	)(
	input reset_n,
	input SPI_clk,
	output reg m_axis_tready
	);
	reg[$clog2(WAKEUP_CYCLES) : 0] counter;
	always@(posedge SPI_clk or negedge reset_n)begin
		if(!reset_n)begin
			m_axis_tready <= 0;
			counter <= 0;
		end else begin
			counter <= counter + 1;
			m_axis_tready <= m_axis_tready ? 1 : counter == WAKEUP_CYCLES;
		end
	end
endmodule


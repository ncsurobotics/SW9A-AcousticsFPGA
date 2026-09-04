module SPI_IF #(
	parameter CLK_DIVIDE = 3 // how many times to divide master clk to produce SCLK, make sure this is 3+
)(
    // source
	input clk, // 100 MHz
	input spi_reset_n, // asynchronous(?)
	
	// connects to ADC
	output logic spi_SCLK,
	output logic spi_CS_n,
	output spi_DI,
	input spi_SDO_DRDY,
	
	// input channel
	input [15:0] s_axis_tdata, // two byte command. specified below
	input s_axis_tvalid,
	output logic s_axis_tready,
	output logic s_axis_tuser, // flag for sending write command to change from 24-bit to 16-bit resolution
	
	// output channel
	output logic [15:0] m_axis_tdata,
	output logic m_axis_tvalid,
	input m_axis_tready,
	output logic m_axis_tuser // stores DRDY
);


	/* 
	The following information is defined by the ADSS127L21 datasheet
	https://www.ti.com/lit/ds/symlink/ads127l21.pdf
	
		commands: 
	Description				Byte 1			Byte 2
	NOP/read conversion		00h				00h
	Read register			40h+addr[4:0]	don't care
	Write register			80h+addr[4:0]	write data
	
	Frame based communication:
		Frame starts when CS goes low, and ends when it goes high
		Within a frame there can be 2-5 bytes transferred.
		Each byte corresponds to 8 cycles of SPI_SCLK
		Register reads are sent on frame(n) and data comes back on frame(n+1)
		
		SPI_SDO_DRDY = {STATUS,CONV_DATA_MSB,CONV_DATA_MID,CONV_DATA_LOW,CRC} at max with no register read on previous frame
		SPI_SDO_DRDY = {STATUS,reg_data,00h,00h,CRC} at max with register read on previous frame
		
		Configuration choices we make:
		No CRC
		No status byte
		16 bit conversions
		Start/Stop mode with Start pin
		SDO_DRDY as DRDY and DO. 
		
		SDO_DRDY - When CS goes low, this pin becomes DRDY. It becomes DO once SCLK starts ticking.
		Our operation will then be: Start frame, wait a few ticks to get DRDY, then start clock operation
	*/


	logic sclk_en; // toggles sclk when counter overflows, <40 MHz
	logic counter_en;
	logic [$clog2(CLK_DIVIDE)-1:0] sclk_counter; // counter for dividing clk to generate SCLK
	logic sclk_counter_maxed;

	logic [1:0] delay_counter; // counter for delays

	logic init_flag; // flag for sending write command to change from 24-bit to 16-bit resolution
	logic drdy_n;

	logic [3:0] bit_count;
	logic sipo_din_valid;
	logic piso_shift, piso_load;
	
	typedef enum logic [2:0] {
		S_IDLE, 			// wait for command, lower CS
		S_WAIT_DRDY,		// wait for DRDY to be driven, and then store it
		S_WAIT_INIT,		// wait for 8 bits during writing configuration from 24-bit to 16-bit resolution
		S_DATA_SHIFT_OUT,	// transmit data out on DI
		S_DATA_SAMPLE_IN,	// receive data on SDO_DRDY
		S_END_DELAY,		// delay between negedge SCLK and posedge CS
		S_RECEIVED			// sends back the received data
	} state_t;
	state_t state;

	// AXI4-S signals
	assign s_axis_tready = (state == S_IDLE);
	assign m_axis_tvalid = (state == S_RECEIVED);
	assign m_axis_tuser = drdy_n;


	assign sclk_counter_maxed = (sclk_counter == (CLK_DIVIDE-1));

	always_ff @(posedge clk or negedge spi_reset_n) begin
		if (~spi_reset_n) begin
			sclk_counter <= 0;
			spi_SCLK <= 0;
		end

		// sclk_counter counts upto (CLK_DIVIDE - 1) when sclk_en is asserted
		else if (sclk_en) begin
			if (sclk_counter_maxed) begin
				sclk_counter <= 0;
				spi_SCLK <= ~spi_SCLK;
			end
			else sclk_counter <= sclk_counter + 1;
		end
	end

	// Combinational logic for various control signals
	always_comb begin
		// default values
		sclk_en = 0;
		piso_shift = 0;
		piso_load = 0;
		sipo_din_valid = 0;
		
		case (state)
			S_IDLE: begin
				piso_load = (s_axis_tvalid & s_axis_tready);
			end
			S_WAIT_DRDY: begin
			end
			S_WAIT_INIT: begin
				sclk_en = 1;
			end
			S_DATA_SHIFT_OUT: begin
				sclk_en = 1;
				piso_shift = ~spi_SCLK & sclk_counter_maxed;
			end
			S_DATA_SAMPLE_IN: begin
				sclk_en = 1;
				sipo_din_valid = spi_SCLK & sclk_counter_maxed;
			end
			S_RECEIVED: begin
			end
		endcase
	end


	always_ff @(posedge clk or negedge spi_reset_n) begin
		if (~spi_reset_n) begin
			spi_CS_n <= 1;
			bit_count <= 0;
			state <= S_IDLE;

		end else begin
			case (state)
				S_IDLE: begin
					if (s_axis_tvalid) begin
						init_flag <= s_axis_tuser;
						spi_CS_n <= 0;
						delay_counter <= 0;
						state <= S_WAIT_DRDY;
					end
				end

				S_WAIT_DRDY: begin
					delay_counter <= delay_counter + 1;
					
					// wait 30ns for DRDY to leave high-impedance state
					if (delay_counter >= 2) begin
						delay_counter <= 0;
						drdy_n <= spi_SDO_DRDY;
						state <= (init_flag) ? S_WAIT_INIT : S_DATA_SHIFT_OUT;
					end
				end

				S_WAIT_INIT: begin
					// Delay for 8 cycles SCLK, the data doesn't matter 
					if (spi_SCLK & sclk_counter_maxed) begin
						if (bit_count < 7) begin
							bit_count <= bit_count + 1;
						end else begin
							bit_count <= 0;
							state <= S_DATA_SHIFT_OUT;
						end
					end
				end

				S_DATA_SHIFT_OUT: begin
					if (~spi_SCLK & sclk_counter_maxed) begin
						state <= S_DATA_SAMPLE_IN;
					end
				end

				S_DATA_SAMPLE_IN: begin
					if (spi_SCLK & sclk_counter_maxed) begin
						if (bit_count < 15) begin
							bit_count <= bit_count + 1;
							state <= S_DATA_SHIFT_OUT;
						end else begin
							bit_count <= 0;
							state <= S_END_DELAY;
						end
					end
				end

				S_END_DELAY: begin
					delay_counter <= delay_counter + 1;

					// wait 20ns before pulling up CS
					if (delay_counter >= 1) begin
						delay_counter <= 0;
						spi_CS_n <= 1;
						state <= S_RECEIVED;
					end
				end

				S_RECEIVED: begin
					if (m_axis_tready) begin
						state <= S_IDLE;
					end
				end

				default: state <= S_IDLE;
			endcase
		end
	end

	sipo #(
		.WORD_SIZE(1), 
		.WORD_COUNT(16)
	) USIPO (
		.clk(clk),
		.reset_n(spi_reset_n),
		.din(spi_SDO_DRDY),
		.din_valid(sipo_din_valid),
		.dout(m_axis_tdata),
		.word_count(), // don't need
		.clear(1'b0) // don't need
	);

	piso #(
		.WORD_SIZE(1),
		.WORD_COUNT(16)
	) UPISO (
		.clk(clk),
		.reset_n(spi_reset_n),
		.din(s_axis_tdata),
		.dout(spi_DI),
		.shift(piso_shift),
		.load(piso_load)
	);

    
endmodule

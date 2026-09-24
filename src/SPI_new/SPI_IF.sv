`timescale 1ns/1ps

module SPI_IF #(
	parameter CLK_DIVIDE = 7, 			// how many times to divide master clk to produce half cycle SCLK
	parameter DELAY_CYCLES = 10			// absolute minimum should be 5
)(
    // source
	input clk, 							// 100 MHz
	input reset_n, 						// asynchronous(?)
	
	// connects to ADC
	output logic SPI_SCLK,
	output logic SPI_CS_N,
	output SPI_DI,
	input SPI_SDO_DRDY,
	
	// input channel
	input [15:0] s_axis_tdata, 			// two byte command. specified below
	input s_axis_tvalid,
	output logic s_axis_tready,
	output logic s_axis_tuser, 			// flag for sending write command to change from 24-bit to 16-bit resolution
	
	// output channel
	output logic [15:0] m_axis_tdata,
	output logic m_axis_tvalid,
	input m_axis_tready,
	output logic m_axis_tuser 			// stores DRDY
);

	// TODO:
	// Have SDO/DRDY synchronized with 2 registers to avoid metastability
	// Use counter for delay instead of making clock divider extremely slow
	// Does drdy need to be invalidated during the first 24-bit conversion?


	logic SDO_DRDY_sync_1, SDO_DRDY_sync_2;  // 2FF synchronizer for asynchronous input

	logic sclk_en; // toggles sclk when counter overflows, <40 MHz
	logic counter_en;
	logic [$clog2(CLK_DIVIDE)-1:0] sclk_counter; // counter for dividing clk to generate SCLK
	logic sclk_counter_maxed;

	logic [$clog2(DELAY_CYCLES)-1:0] delay_counter; // counter for delays

	logic init_flag; // flag for sending write command to change from 24-bit to 16-bit resolution
	logic conv_flag; // flag for whether the opertion is a conversion
	logic drdy_n;

	logic [3:0] bit_count;
	logic sipo_din_valid;
	logic [15:0] sipo_data;
	logic piso_shift, piso_load;
	logic [15:0] piso_data;
	logic piso_out;
	
	typedef enum logic [2:0] {
		S_IDLE, 			// wait for command, lower CS
		S_WAIT_DRDY,		// wait for DRDY to be driven, and then store it
		S_WAIT_INIT,		// wait for 8 bits during writing configuration from 24-bit to 16-bit resolution
		S_DATA_SHIFT_OUT,	// transmit data out on DI
		S_DATA_SAMPLE_IN,	// receive data on SDO_DRDY
		S_DATA_SAMPLE_BUF,	// store the buffered data from SDO_DRDY_sync_2
		S_END_DELAY,		// delay between negedge SCLK and posedge CS
		S_RECEIVED			// sends back the received data
	} state_t;
	state_t state;

	always_ff @(posedge clk) begin
		SDO_DRDY_sync_1 <= SPI_SDO_DRDY;
		SDO_DRDY_sync_2 <= SDO_DRDY_sync_1;
	end

	// AXI4-S signals
	assign s_axis_tready = (state == S_IDLE);
	assign m_axis_tvalid = (state == S_RECEIVED);
	assign m_axis_tuser = drdy_n;


	assign sclk_counter_maxed = (sclk_counter == (CLK_DIVIDE-1));

	always_ff @(posedge clk or negedge reset_n) begin
		if (~reset_n) begin
			sclk_counter <= 0;
			SPI_SCLK <= 0;
		end

		// sclk_counter counts upto (CLK_DIVIDE - 1) when sclk_en is asserted
		else if (sclk_en) begin
			if (sclk_counter_maxed) begin
				sclk_counter <= 0;
				SPI_SCLK <= ~SPI_SCLK;
			end
			else sclk_counter <= sclk_counter + 1;
		end
	end


	// SIPO logic
	assign m_axis_tdata = sipo_data;
	always_ff @(posedge clk) begin
		if (sipo_din_valid) begin
			sipo_data <= {sipo_data[14:0], SDO_DRDY_sync_2};
		end
	end

	// PISO logic
	assign SPI_DI = piso_out;
	always_ff @(posedge clk) begin
		if (piso_load) begin
			piso_data <= s_axis_tdata;
		end
		else if (piso_shift) begin
			piso_data <= {piso_data[14:0], 1'b0};
			piso_out <= piso_data[15];
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
				piso_shift = sclk_counter_maxed;
			end
			S_DATA_SAMPLE_IN: begin
				sclk_en = 1;
			end
			S_DATA_SAMPLE_BUF: begin
				sclk_en = bit_count < 15;
				sipo_din_valid = delay_counter >= 1;
			end
			S_RECEIVED: begin
			end
		endcase
	end


	always_ff @(posedge clk or negedge reset_n) begin
		if (~reset_n) begin
			SPI_CS_N <= 1;
			bit_count <= 0;
			state <= S_IDLE;

		end else begin
			case (state)
				S_IDLE: begin
					if (s_axis_tvalid) begin
						init_flag <= s_axis_tuser;
						conv_flag <= s_axis_tdata[15:14] == 2'b00;
						SPI_CS_N <= 0;
						delay_counter <= 0;
						state <= S_WAIT_DRDY;
					end
				end

				S_WAIT_DRDY: begin
					// If doing a conversion, wait the appropriate delay for conversion to complete
					// Otherwise, we still need to wait 30ns for DRDY pin to leave high-impedance state + 2 cycles pipeline latency
					delay_counter <= delay_counter + 1;
					if (delay_counter >= (conv_flag ? (DELAY_CYCLES-1) : 4)) begin
						delay_counter <= 0;
						bit_count <= 0;
						drdy_n <= SDO_DRDY_sync_2;
						state <= (init_flag) ? S_WAIT_INIT : S_DATA_SHIFT_OUT;
					end
				end

				S_WAIT_INIT: begin
					// Delay for 8 cycles SCLK, the data doesn't matter 
					if (SPI_SCLK & sclk_counter_maxed) begin
						if (bit_count < 7) begin
							bit_count <= bit_count + 1;
						end else begin
							bit_count <= 0;
							state <= S_DATA_SHIFT_OUT;
						end
					end
				end

				S_DATA_SHIFT_OUT: begin
					if (/*~SPI_SCLK & */sclk_counter_maxed) begin
						state <= S_DATA_SAMPLE_IN;
					end
				end

				S_DATA_SAMPLE_IN: begin
					if (/*SPI_SCLK & */sclk_counter_maxed) begin
						state <= S_DATA_SAMPLE_BUF;
					end
				end

				S_DATA_SAMPLE_BUF: begin
					// Delay for the SDO to propagate through synchronizer buffers
					// Also, it serves as 20 ns end delay on the last bit before CS is pulled up
					delay_counter <= delay_counter + 1;
					if (delay_counter >= 1) begin
						delay_counter <= 0;
						if (bit_count < 15) begin
							bit_count <= bit_count + 1;
							state <= S_DATA_SHIFT_OUT;
						end else begin
							bit_count <= 0;
							SPI_CS_N <= 1;
							state <= S_RECEIVED;
						end
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
    
endmodule

`timescale 1ns/1ps
module ADC_SPI_BATCH #(
	parameter CHANNEL_COUNT = 6,
	parameter CONVERSION_FRAME_SIZE = 256
)(
	input clk,      // 100 MHz
	input reset_n,  // asynchronous
	
	input SPI_select, // 0-adc conversion into dsp, 1-uart passthrough to SPI
	
	// connects to ADCs
	output [CHANNEL_COUNT-1:0] SPI_SCLK,
	output [CHANNEL_COUNT-1:0] SPI_CS_N,
	output [CHANNEL_COUNT-1:0] SPI_DI,
	input [CHANNEL_COUNT-1:0] SPI_SDO_DRDY,
	output SPI_START,
	
	// input channel (for register operations)
    input [15:0] s_axis_tdata,
	input [CHANNEL_COUNT-1:0] s_axis_tdest, // bit mask to select an ADC. multi/broadcast only work on write
	input s_axis_tvalid,
	output s_axis_tready,
	
	// output channels
	output reg [7:0] m_axis_reg_tdata, // register data
	output m_axis_reg_tvalid,
	output m_axis_reg_tlast,
	input m_axis_reg_tready,
		
	output [(16*CHANNEL_COUNT)-1:0] m_axis_conversion_tdata, // conversion data
	output [CHANNEL_COUNT-1:0] m_axis_conversion_tlast,
	output [CHANNEL_COUNT-1:0] m_axis_conversion_tvalid,
	input [CHANNEL_COUNT-1:0] m_axis_conversion_tready
	
);

/*
	There are two modes, conversion mode, and UART passthrough to SPI.
	The SPI_select input selects the mode, but internally, it is controlled by internal_select signal.

	Conversion mode:
		Conversion data is read from the ADCs and sent to the DSP.
		An FFT frame will have conversion data sent CONVERSION_FRAME_SIZE times.
		Only after the frame is finished will the internal_select check for spi_select changes

	Register mode:
		Register data is read from or written to ADC internal registers.
		s_axis_tdest selects which channels are written to during writes
		internal

*/
    typedef enum logic [1:0] {S_START, S_WAIT, S_RESPOND} state_t;
    state_t state; // 0 idle, 1 waiting, 2 responding
	
	logic internal_select;
	logic SPI_select_buffer; // buffer the signal

	logic [$clog2(CONVERSION_FRAME_SIZE)-1:0] counter; // counts samples as it sends them
	logic [7:0] reg_values [CHANNEL_COUNT-1:0]; // buffered values for regmap
	logic [CHANNEL_COUNT-1:0] channel_enable; // whether the channel is used 
	logic channels_done; // asserted when all channels are either valid or unused
	logic [7:0] reg_values_index; // index for output

	logic [15:0] s_axis_adc_tdata [CHANNEL_COUNT-1:0];
	logic [CHANNEL_COUNT-1:0] s_axis_adc_tid;  // Unused, maybe useful for debugging
	logic [CHANNEL_COUNT-1:0] s_axis_adc_tvalid;
	logic [CHANNEL_COUNT-1:0] s_axis_adc_tready;
	
	logic [CHANNEL_COUNT-1:0] m_axis_adc_tready;
	logic [CHANNEL_COUNT-1:0] m_axis_adc_tvalid;
	logic [15:0] m_axis_adc_tdata [CHANNEL_COUNT-1:0];

	integer j;


	always_ff @(posedge clk) begin
		SPI_select_buffer <= SPI_select;
	end

	always_ff @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			internal_select <= 1;
			state <= S_START;

			counter <= 0;

			channel_enable <= '0;
			for (j = 0; j < CHANNEL_COUNT; j = j + 1) begin
				reg_values[j] <= 0;
			end

			reg_values_index <= 0;

		end else begin

			// internal select chooses between adc conversion mode and adc register mode
			if (internal_select == 0) begin // adc conversion mode
				
				// Checks if one packet of conversion data can be sent
				// Wait for all external tready and adc tvalid to be asserted before doing handshake
				if ((&m_axis_conversion_tready) & (&s_axis_adc_tvalid)) begin
					if (counter == (CONVERSION_FRAME_SIZE-1)) begin // Checks if this is the last packet in the frame
						counter <= 0; // resets counter
						internal_select <= SPI_select_buffer; // after one fft frame is sent, we can check for spi select changes
					end else begin
						counter <= counter + 1; // otherwise keep sending conversion data
					end
				end

			end else begin // in reg mode, we dont go back to conversion unless reg mode is done
				case (state)
					S_START: begin // start command
						channel_enable <= s_axis_tdest;

						// If doing a read command, need to send back the received data as well, so we change state
						// Wait for the external tvalid and all the targeted ADC tready before handshake
						if (s_axis_tvalid & (&(m_axis_adc_tready | ~s_axis_tdest)) & s_axis_tdata[14]) begin
							state <= S_WAIT; // If this is read command, need to wait and send back data
						end else begin
							internal_select <= SPI_select_buffer;  // Only update internal_select if no R/W command handshake
						end
					end
					S_WAIT: begin // waits for commands to complete
						for(j = 0; j < CHANNEL_COUNT; j = j + 1)begin
							if(s_axis_adc_tvalid[j]) begin
								reg_values[j] <= s_axis_adc_tdata[j];
							end
						end
						if (channels_done) begin
							state <= S_RESPOND;
						end
						reg_values_index <= 0;
					end
					S_RESPOND: begin // checks ready and leaves
					// For now, reading only supports reading all the channels
						if (m_axis_reg_tready) begin						
							reg_values_index <= reg_values_index + 1;
							if (reg_values_index == (CHANNEL_COUNT-1)) state <= S_START;
						end
					end
					default: begin  // Should this be used?
						state <= S_START;
					end
					
				endcase
			end
			
		end
	end
	
	assign SPI_START = ~internal_select;
			
	
	// assign s_axis_tready = m_axis_adc_tready[0];

	// Ready to receive commands when all destinations are ready
	assign s_axis_tready = (state == S_START) & (&(m_axis_adc_tready | ~s_axis_tdest)) & (internal_select);

	assign m_axis_reg_tdata = reg_values[reg_values_index];
	assign m_axis_reg_tvalid = (state == S_RESPOND) & (channel_enable[reg_values_index] | (reg_values_index == (CHANNEL_COUNT-1)));
	assign m_axis_reg_tlast = reg_values_index == (CHANNEL_COUNT-1);

	assign channels_done = &(~channel_enable | s_axis_adc_tvalid);

	genvar i;
	generate
		for(i = 0; i < CHANNEL_COUNT; i = i + 1)begin
			assign m_axis_adc_tdata[i] = internal_select ? s_axis_tdata : 16'h0000;
			assign m_axis_adc_tvalid[i] = internal_select ? (s_axis_tvalid && s_axis_tdest[i]) : 1;
			ADC_SPI_ADS127L21 u1(
				.clk(clk),
				.reset_n(reset_n),
				
				.SPI_SCLK(SPI_SCLK[i]),
				.SPI_CS_N(SPI_CS_N[i]),
				.SPI_DI(SPI_DI[i]),
				.SPI_SDO_DRDY(SPI_SDO_DRDY[i]),
				
				.s_axis_tdata(m_axis_adc_tdata[i]),
				.s_axis_tvalid(m_axis_adc_tvalid[i]),
				.s_axis_tready(m_axis_adc_tready[i]),
				
				.m_axis_tdata(s_axis_adc_tdata[i]),
				.m_axis_tid(s_axis_adc_tid[i]),
				.m_axis_tvalid(s_axis_adc_tvalid[i]),
				.m_axis_tready(s_axis_adc_tready[i])

			);
			assign m_axis_conversion_tdata[i * 16 +: 16] = internal_select ? 0 : s_axis_adc_tdata[i];
			assign m_axis_conversion_tvalid[i] = internal_select ? 0 : s_axis_adc_tvalid[i];
			assign m_axis_conversion_tlast[i] = (counter == (CONVERSION_FRAME_SIZE-1)) /*& ~internal_select*/;
			assign s_axis_adc_tready[i] = internal_select ? 1 : (&m_axis_conversion_tready);
		end
	endgenerate
	
	
	
endmodule

// (Check) In S_START, if internal_select is 1 and SPI_select_buffer is 0 it will cause issue
// If doing a write, make sure proper handshake is done with ADCs
// (Check) Fix xor_rvv -> changed to channels_done
// In S_RESPOND, assert valid on last valid channel instead of last channel
// (Check) In S_RESPOND, valid should not be dependent on ready and other issues.
// Does s_axis_adc_tready[i] need to be dependent on &m_axis_conversion_tready instead?

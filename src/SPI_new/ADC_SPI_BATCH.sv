`timescale 1ns/1ps
module ADC_SPI_BATCH #(
	parameter CHANNEL_COUNT = 6,
	parameter CONVERSION_FRAME_SIZE = 256
)(
	input clk,      // 100 MHz
	input reset_n,  // asynchronous
	
	input SPI_select, // 0-adc conversion into dsp, 1-uart passthrough to SPI
	
	// connects to ADC
	output [CHANNEL_COUNT-1:0] SPI_SCLK,
	output [CHANNEL_COUNT-1:0] SPI_CS_N,
	output [CHANNEL_COUNT-1:0] SPI_DI,
	input [CHANNEL_COUNT-1:0] SPI_SDO_DRDY,
	output SPI_START,
	
	// input channel (for register operations)
    input [15:0] s_axis_tdata,
	input [CHANNEL_COUNT-1:0] s_axis_tdest, // one hot encoding to select an ADC. multi/broadcast only work on write
	input s_axis_tvalid,
	output s_axis_tready,
	
	// output channels
	output reg [7:0] m_axis_reg_tdata, // register data
	output reg m_axis_reg_tvalid,
	output reg m_axis_reg_tlast,
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
    typedef enum logic [1:0] {S_IDLE, S_WAIT, S_RESPOND} state_t;
    state_t state; // 0 idle, 1 waiting, 2 responding
	
	logic internal_select;
	logic SPI_select_buffer; // buffer the signal

	logic [$clog2(CONVERSION_FRAME_SIZE)-1:0] counter; // counts samples as it sends them
	logic [7:0] reg_values[CHANNEL_COUNT - 1 : 0]; // buffered values for regmap
	logic [1:0] reg_values_valid [CHANNEL_COUNT - 1 : 0]; // [0] == tdest, [1] == valid
	logic [CHANNEL_COUNT-1:0] xor_rvv;
	logic [7:0] reg_values_index; // index for output

	logic [15:0] s_axis_adc_tdata [CHANNEL_COUNT-1:0];
	logic s_axis_adc_tid [CHANNEL_COUNT-1:0];
	logic s_axis_adc_tvalid [CHANNEL_COUNT-1:0];
	logic s_axis_adc_tready [CHANNEL_COUNT-1:0];
	logic m_axis_adc_tready [CHANNEL_COUNT-1:0];
	logic m_axis_adc_tvalid [CHANNEL_COUNT-1:0];
	logic [15:0] m_axis_adc_tdata [CHANNEL_COUNT-1:0];

	integer j;

	always@ (posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			internal_select <= 1;
			SPI_select_buffer <= 1;
			counter <= 0;
			state <= 0;
			for (j = 0; j < CHANNEL_COUNT; j = j + 1) begin
				reg_values[j] <= 0;
				reg_values_valid[j] <= 0;
			end
			m_axis_reg_tvalid <= 0;
			m_axis_reg_tdata <= 0;
			m_axis_reg_tlast <= 0;
			reg_values_index <= 0;

		end else begin
			SPI_select_buffer <= SPI_select; // saves pending select until frame is done being sent
			// internal select chooses between adc conversion mode and adc register mode
			if (internal_select == 0) begin // adc conversion mode
				if (&m_axis_conversion_tready & m_axis_conversion_tvalid) begin // Checks if one packet of conversion data can be sent
					if (counter == (CONVERSION_FRAME_SIZE-1)) begin // Checks if this is the last packet in the frame
						counter <= 0; // resets counter
						internal_select <= SPI_select_buffer; // after one fft frame is sent, we can check for spi select changes
					end else begin
						counter <= counter + 1; // otherwise keep sending conversion data
					end
				end

			end else begin // in reg mode, we dont go back to conversion unless reg mode is done
				case (state)
					S_IDLE: begin // start command
						if (s_axis_tvalid & s_axis_tready & s_axis_tdata[14]) begin
							state <= S_WAIT;
							for(j = 0; j < CHANNEL_COUNT; j = j + 1)begin
								reg_values[j] <= 0;
								reg_values_valid[j][1] <= s_axis_tdest[j];
								reg_values_valid[j][0] <= 0;
							end
						end else begin
							internal_select <= SPI_select_buffer;
						end
						reg_values_index <= 0;
						m_axis_reg_tvalid <= 0;
						m_axis_reg_tdata <= 0;
						m_axis_reg_tlast <= 0;
					end
					S_WAIT: begin // sends commands and waits for commands to complete
						for(j = 0; j < CHANNEL_COUNT; j = j + 1)begin
							if(s_axis_adc_tvalid[j]) begin
								reg_values[j] <= s_axis_adc_tdata[j];
								reg_values_valid[j][0] <= 1;
							end
						end
						if (!(|xor_rvv)) begin // no xors == all valid
							state <= S_RESPOND;
						end
						reg_values_index <= 0;
					end
					S_RESPOND: begin // checks ready and leaves
						if (m_axis_reg_tready) begin						
							reg_values_index<= reg_values_index + 1;
							m_axis_reg_tdata <= reg_values[reg_values_index];
							m_axis_reg_tvalid <= &reg_values_valid[reg_values_index] || reg_values_index == (CHANNEL_COUNT-1);
							m_axis_reg_tlast <= reg_values_index == (CHANNEL_COUNT-1);
							if(reg_values_index == (CHANNEL_COUNT-1)) state <= S_IDLE;
						end else begin
							reg_values_index<= reg_values_index;
							m_axis_reg_tdata <= 0;
							m_axis_reg_tvalid <= 0;
							m_axis_reg_tlast <= 0;
						end
					end
					default: begin
						state <= S_IDLE;
					end
					
				endcase
			end
			
		end
	end
	
	assign SPI_START = ~internal_select;
			
	
	// assign s_axis_tready = m_axis_adc_tready[0];
	assign s_axis_tready = &(m_axis_adc_tready | ~s_axis_tdest) & (internal_select) & (state == S_IDLE);
	
	genvar i;
	generate
		for(i = 0; i < CHANNEL_COUNT; i = i + 1)begin
			assign m_axis_adc_tdata[i] = internal_select ? s_axis_tdata : 16'h0000;
			assign m_axis_adc_tvalid[i] = internal_select ? (s_axis_tvalid && s_axis_tdest[i]) : 1;
			assign xor_rvv[i] = ^reg_values_valid[i];
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
			assign s_axis_adc_tready[i] = internal_select ? 1 : m_axis_conversion_tready[i];
		end
	endgenerate
	
	
	
endmodule

// In S_IDLE, if internal_select is 1 and SPI_select_buffer is 0 it will cause issue
// 'if (m_axis_conversion_tvalid)' or 'if (&m_axis_conversion_tvalid)', which is better 

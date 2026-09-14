`timescale 1ns/1ps

module ADC_SPI_ADS127L21 (
	input clk,
	input reset_n,
	
	// connects to ADC
	output SPI_SCLK,
	output SPI_CS_N,
	output SPI_DI,
	input SPI_SDO_DRDY,
	
	// input channel
	input [15:0] s_axis_tdata, // two byte command. specified below
	input s_axis_tvalid,
	output logic s_axis_tready,
	
	// output channel
	output logic [15:0] m_axis_tdata, // conversion data or {register data, 8'h00}
	output logic m_axis_tid, // 0 == adc conversion, 1 == register read
	output logic m_axis_tvalid,
	input m_axis_tready
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
		Each byte corresponds to 8 cycles of SCLK
		Register reads are sent on frame(n) and data comes back on frame(n+1)
		
		SPI_SDO_DRDY = {STATUS,CONV_DATA_MSB,CONV_DATA_MID,CONV_DATA_LOW,CRC} at max with no register read on previous frame
		SPI_SDO_DRDY = {STATUS,reg_data,00h,00h,CRC} at max with register read on previous frame
		
		Configuration choices we make:
		No CRC
		No status byte
		16 bit conversions
		Start/Stop mode with Start pin
		SDO_DRDY as DRDY and DO.

        On reset, 24-bit mode is enabled. We send a write command upon reset which changes to 16-bit mode.
        With our desired config:
        SPI_SDO_DRDY = {CONV_DATA_MSB,CONV_DATA_LOW} with no register read on previous frame
		SPI_SDO_DRDY = {reg_data,00h} with register read on previous frame
		
		SDO_DRDY - When CS goes low, this pin becomes DRDY after a delay. It becomes DO once SCLK starts ticking.
		Our operation will then be: Start frame, wait a few ticks to get DRDY, then start clock operation

		Max SCLK is 50MHz or so
		If sampling rate f_DATA is 512 kSam/s:
		- Minimum SCLK is 2.048 MHz (assuming I understood what the datasheet meant)
		- The conversion will happen at a period of 1953 ns, so the plan is that SCLK is selected so the SPI frame around
		  the same amount of time as the conversion so the next one is ready in time
	*/
	

    typedef enum logic [2:0] {
        S_IDLE,			// Wait for command
        S_SEND, 		// Send command to IF
        S_RECEIVE,		// Receive data from IF
		S_OUTPUT
    } state_t;
	state_t state;


    // AXI-S signals with SPI_IF
    logic [15:0] m_axis_spi_tdata;
	logic m_axis_spi_tvalid;
	logic m_axis_spi_tready;
    logic m_axis_spi_tuser;
	
	logic [15:0] s_axis_spi_tdata;
	logic s_axis_spi_tvalid;
    logic s_axis_spi_tready;
	logic s_axis_spi_tuser;


	logic [15:0] buffer;
	logic drdy_buffer;  // right now this is unused, we are assuming the conversion is always ready

	logic read_twice;
	logic [1:0] operation;
    
	localparam OP_NOP = 2'b00;
	localparam OP_READ = 2'b01;
	localparam OP_WRITE = 2'b10;

	localparam INIT_COMMAND = 16'h86_80;

	// AXI-S control signals based on current state
	always_comb begin
		s_axis_tready = 0;
		m_axis_tvalid = 0;
		m_axis_spi_tvalid = 0;
		s_axis_spi_tready = 0;

		case (state)
			S_IDLE: s_axis_tready = 1;
			S_SEND: m_axis_spi_tvalid = 1;
			S_RECEIVE: s_axis_spi_tready = 1;
			S_OUTPUT: m_axis_tvalid = 1;
		endcase
	end

	assign m_axis_tid = (operation == OP_READ);

	
	always_ff @(posedge clk or negedge reset_n) begin
		if (~reset_n) begin
			// Write initial config
			operation <= OP_WRITE;
			m_axis_spi_tdata <= INIT_COMMAND;
			m_axis_spi_tuser <= 1; // Tell SPI_IF that this is the initial config write
			state <= S_SEND;

			read_twice <= 0;
			// m_axis_tdata <= 0;
			// m_axis_tid <= 0;
		end else begin
			case (state)
				S_IDLE: begin
					operation <= s_axis_tdata[15:14];
					m_axis_spi_tdata <= s_axis_tdata;
					m_axis_spi_tuser <= 0;
					if (s_axis_tvalid) begin
						state <= S_SEND;
					end
				end
				S_SEND: begin
					if (m_axis_spi_tready) begin
						state <= S_RECEIVE;
					end
				end
				S_RECEIVE: begin
					m_axis_tdata <= s_axis_spi_tdata;
					drdy_buffer <= s_axis_spi_tuser;

					if (s_axis_spi_tvalid) begin
						case (operation)
							OP_NOP: begin
								state <= S_OUTPUT;
							end
							OP_READ: begin
								if (~read_twice) begin
									// Read second time to get register value
									read_twice <= 1;
									m_axis_spi_tdata <= 16'h0000;
									state <= S_SEND;
								end else begin
									// Second read complete
									read_twice <= 0;
									state <= S_OUTPUT;
								end
							end
							OP_WRITE: begin
								state <= S_IDLE;
							end
							default: begin
								state <= S_IDLE;
							end
						endcase
					end
				end
				S_OUTPUT: begin
					if (m_axis_tready) begin
						state <= S_IDLE;
					end
				end
				default: begin
					state <= S_IDLE;
				end
			endcase
		end
	end
	
	
	// handles the serial interface but no logic
    SPI_IF SPI_IF_inst (
        .clk(clk),
        .reset_n(reset_n),

        .SPI_SCLK(SPI_SCLK),
        .SPI_CS_N(SPI_CS_N),
        .SPI_DI(SPI_DI),
        .SPI_SDO_DRDY(SPI_SDO_DRDY),

        .s_axis_tdata(m_axis_spi_tdata),
        .s_axis_tvalid(m_axis_spi_tvalid),
        .s_axis_tready(m_axis_spi_tready),
        .s_axis_tuser(m_axis_spi_tuser),
        
        .m_axis_tdata(s_axis_spi_tdata),
        .m_axis_tvalid(s_axis_spi_tvalid),
        .m_axis_tready(s_axis_spi_tready),
        .m_axis_tuser(s_axis_spi_tuser)
    );
	
	
endmodule

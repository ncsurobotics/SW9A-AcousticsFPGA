`timescale 1ns/1ps


module ADC_SPI_BATCH #(
	parameter CHANNEL_COUNT = 6,
	parameter CONVERSION_FRAME_SIZE = 256
	)(
	input clk,
	input reset_n,
	
	// source
	input SPI_clk,
	input SPI_reset_n,
	
	input SPI_select, // 0-adc conversion into dsp, 1-uart passthrough to SPI
	
	// connects to ADC
	output[CHANNEL_COUNT - 1 : 0] SPI_SCLK,
	output[CHANNEL_COUNT - 1 : 0] SPI_CS_N,
	output[CHANNEL_COUNT - 1 : 0] SPI_DI,
	input[CHANNEL_COUNT - 1 : 0] SPI_SDO_DRDY,
	output SPI_START,
	
	// input channel
	input[15:0] s_axis_tdata, 
	input[CHANNEL_COUNT-1:0] s_axis_tdest, // one hot encoding to select an ADC. multi/broadcast only work on write
	input s_axis_tvalid,
	output s_axis_tready,
	
	// output channel
	output reg[7:0] m_axis_reg_tdata, // register data
	output reg m_axis_reg_tvalid,
	output reg m_axis_reg_tlast,
	input m_axis_reg_tready,
		
	output[16 * CHANNEL_COUNT - 1 : 0] m_axis_conversion_tdata, // conversion data
	output[CHANNEL_COUNT - 1 : 0] m_axis_conversion_tlast,
	output[CHANNEL_COUNT - 1 : 0] m_axis_conversion_tvalid,
	input[CHANNEL_COUNT - 1 : 0] m_axis_conversion_tready
	
	);
	
	reg internal_select, SPI_select_buffer;
	reg[$clog2(CONVERSION_FRAME_SIZE)-1:0] counter;
	reg[CHANNEL_COUNT-1:0] last_dest;
	reg[7:0] reg_values[CHANNEL_COUNT - 1 : 0]; // buffered values for regmap
	reg[1:0] reg_values_valid [CHANNEL_COUNT - 1 : 0]; // [0] == tdest, [1] == valid
	wire[CHANNEL_COUNT-1:0] xor_rvv;
	reg[7:0] reg_values_index; // index for output
	reg[1:0] reg_state; // 0 idle, 1 waiting, 2 responding
	wire[15:0] m_axis_tdata[CHANNEL_COUNT-1:0];
	wire m_axis_tid[CHANNEL_COUNT-1:0];
	wire m_axis_tvalid[CHANNEL_COUNT-1:0];
	wire m_axis_tready[CHANNEL_COUNT-1:0];
	wire s_axis_tready_i[CHANNEL_COUNT-1:0];
	wire s_axis_tvalid_i[CHANNEL_COUNT-1:0];
	wire[15:0] s_axis_tdata_i[CHANNEL_COUNT-1:0];
	integer j;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			internal_select <= 1;
			SPI_select_buffer <= 1;
			counter <= 0;
			last_dest <= 0;
			reg_state <= 0;
			for(j = 0; j < CHANNEL_COUNT; j = j + 1)begin
				reg_values[j] <= 0;
				reg_values_valid[j] <= 0;
			end
			m_axis_reg_tvalid<= 0;
			m_axis_reg_tdata<= 0;
			m_axis_reg_tlast<= 0;
			reg_values_index <= 0;
		end else begin
			SPI_select_buffer <= SPI_select;
			if(internal_select==0)begin // conversion
				if(m_axis_conversion_tvalid)begin
					counter <= counter + 1;
				end
				if(counter==(CONVERSION_FRAME_SIZE-1))begin // after one fft frame is sent, we can check for spi select changes
					counter <= 0;
					internal_select <= SPI_select_buffer;
				end // otherwise keep sending conversion data
			end else begin // in reg mode, we dont go back to conversion unless reg mode is done
				last_dest <= s_axis_tvalid ? s_axis_tdest : last_dest;
				case(reg_state)
					2'b00:begin
						if(s_axis_tvalid && s_axis_tdata[14])begin
							reg_state <= 2'b01;
							for(j = 0; j < CHANNEL_COUNT; j = j + 1)begin
								reg_values[j] <= 0;
								reg_values_valid[j][1] <= s_axis_tdest[j];
								reg_values_valid[j][0] <= 0;
							end
						end
						internal_select <= SPI_select_buffer;
						reg_values_index <= 0;
						m_axis_reg_tvalid <= 0;
						m_axis_reg_tdata <= 0;
						m_axis_reg_tlast <= 0;
					end
					2'b01:begin
						for(j = 0; j < CHANNEL_COUNT; j = j + 1)begin
							if(m_axis_tvalid[j]) begin
								reg_values[j] <= m_axis_tdata[j];
								reg_values_valid[j][0] <= 1;
							end
						end
						if(!(|xor_rvv))begin // no xors == all valid
							reg_state <= 2'b10;
						end
						reg_values_index <= 0;
					end
					2'b10:begin
						if(m_axis_reg_tready)begin						
							reg_values_index<= reg_values_index + 1;
							m_axis_reg_tdata <= reg_values[reg_values_index];
							m_axis_reg_tvalid <= &reg_values_valid[reg_values_index] || reg_values_index == (CHANNEL_COUNT-1);
							m_axis_reg_tlast <= reg_values_index == (CHANNEL_COUNT-1);
							if(reg_values_index == (CHANNEL_COUNT-1)) reg_state <= 2'b00;
						end else begin
							reg_values_index<= reg_values_index;
							m_axis_reg_tdata <= 0;
							m_axis_reg_tvalid <= 0;
							m_axis_reg_tlast <= 0;
						end
					end
					
				endcase
			end
			
		end
	end
	
	assign SPI_START = !internal_select;
			
	
	assign s_axis_tready = s_axis_tready_i[0];
	
	genvar i;
	generate
		for(i = 0; i < CHANNEL_COUNT; i = i + 1)begin
			assign s_axis_tdata_i[i] = internal_select 	? s_axis_tdata	:	16'h0000;
			assign s_axis_tvalid_i[i] = internal_select 	? (s_axis_tvalid && s_axis_tdest[i])	:	1;
			assign xor_rvv[i] = ^reg_values_valid[i];
			ADC_SPI_ADS127L21 u1(
				.clk(clk),
				.reset_n(reset_n),
				.SPI_clk(SPI_clk),
				.SPI_reset_n(SPI_reset_n),
				
				.SPI_SCLK(SPI_SCLK[i]),
				.SPI_CS_N(SPI_CS_N[i]),
				.SPI_DI(SPI_DI[i]),
				.SPI_SDO_DRDY(SPI_SDO_DRDY[i]),
				
				.s_axis_tdata(s_axis_tdata_i[i]),
				.s_axis_tvalid(s_axis_tvalid_i[i]),
				.s_axis_tready(s_axis_tready_i[i]),
				
				.m_axis_tdata(m_axis_tdata[i]),
				.m_axis_tid(m_axis_tid[i]),
				.m_axis_tvalid(m_axis_tvalid[i]),
				.m_axis_tready(m_axis_tready[i])

			);
			assign m_axis_conversion_tdata[i * 16 +: 16] = internal_select ? 0 : m_axis_tdata[i];
			assign m_axis_conversion_tvalid[i] = internal_select ? 0 : m_axis_tvalid[i];
			assign m_axis_tready[i] = internal_select ? 1 : m_axis_conversion_tready[i];
		end
	endgenerate
	
	
	
endmodule





module ADC_SPI_ADS127L21 (
	input clk,
	input reset_n,
	
	// source
	input SPI_clk,
	input SPI_reset_n,
	
	// connects to ADC
	output SPI_SCLK,
	output SPI_CS_N,
	output SPI_DI,
	input SPI_SDO_DRDY,
	
	// input channel
	input[15:0] s_axis_tdata, // two byte command. specified below
	input s_axis_tvalid,
	output reg s_axis_tready,
	
	// output channel
	output reg[15:0] m_axis_tdata, // conversion data or {register data, 8'h00}
	output reg m_axis_tid, // 0 == adc conversion, 1 == register read
	output reg m_axis_tvalid,
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
		
		
		FSM:
		IDLE
		WRITE - sends write commands
		READ - sends command and indicates next read will be register read (if applicable)
	*/
	
	reg [2:0] state;
	localparam S_IDLE 			= 3'b000;
	localparam S_SEND 			= 3'b001; 	
	localparam S_WAIT 			= 3'b010; 
	localparam S_RECEIVE 		= 3'b011; 
	localparam S_SEND_AGAIN 	= 3'b100; 
	localparam S_WAIT_AGAIN 	= 3'b101; 
	localparam S_RECEIVE_AGAIN 	= 3'b110;

	reg[15:0] buffer;
	reg drdy_buffer;
	
	reg[15:0] f2s_data; // fast 2 slow data
	reg f2s_valid; // fast 2 slow valid
	
	wire[16:0] s2f_data; // slow 2 fast data
	wire s2f_valid; // slow 2 fast valid

	reg m_axis_if_tready;
	reg read_twice;
	reg[1:0] operation;
	localparam OP_NOP = 2'b00;
	localparam OP_READ = 2'b01;
	localparam OP_WRITE = 2'b10;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			state <= S_IDLE;
			buffer <= 0;
			f2s_data <= 0;
			f2s_valid <= 0;
			operation <= 0;
			drdy_buffer <= 0;
			read_twice <= 0;
			m_axis_if_tready <= 0;
			s_axis_tready <= 0;
			m_axis_tvalid <= 0;
			m_axis_tdata <= 0;
			m_axis_tid <= 0;
		end else begin
			case(state)
				S_IDLE:begin
					m_axis_tdata <= 0;
					m_axis_tvalid <= 0;
					m_axis_tid <= 0;
					buffer <= s_axis_tdata;
					if(s_axis_tvalid)begin
						operation <= s_axis_tdata[15:14];
						state <= S_SEND;
						s_axis_tready <= 0;
					end else s_axis_tready <= 1;
				end
				S_SEND:begin
					s_axis_tready <= 0;
					f2s_data <= buffer;
					f2s_valid <= 1;
					m_axis_if_tready <= 1;
					state <= S_WAIT;
				end
				S_WAIT:begin
					f2s_valid <= 0;
					if(s2f_valid)begin
						buffer <= s2f_data[16:1];
						drdy_buffer <= s2f_data[0];
						state <= S_RECEIVE;
					end
				end
				S_RECEIVE:begin
					case(operation)
						OP_NOP:begin
							m_axis_tdata <= buffer;
							m_axis_tvalid <= drdy_buffer;
							m_axis_tid <= 0;
							state <= S_IDLE;
							s_axis_tready <= 1;
						end
						OP_WRITE:begin
							// nothing to writeback with
							state <= S_IDLE;
							s_axis_tready <= 1;
						end
						OP_READ:begin
							if(read_twice)begin
								read_twice <= 0;
								m_axis_tdata <= buffer;
								m_axis_tvalid <= 1;
								m_axis_tid <= 1;
								state <= S_IDLE;
								s_axis_tready <= 1;
							end else begin
								read_twice <= 1;
								buffer <= 16'h0000;
								state <= S_SEND;
							end
						end
						default: begin
							state <= S_IDLE;
							s_axis_tready <= 1;
						end
					endcase
				end
				
			endcase
		end
	end
	    

	wire [15:0] s_axis_if_tdata;
	wire s_axis_if_tvalid;
	wire s_axis_if_tready;
	
	wire [15:0] m_axis_if_tdata;
	wire m_axis_if_tvalid;
	wire m_axis_if_tid;
	

	// spi to main, s2f
    CDC_DRIVER#(.DATA_LENGTH(17)) receiver_cdc(
        .src_clk(SPI_clk),
        .dest_clk(clk),
        .reset_b(reset_n),
        .Data_Ready(m_axis_if_tvalid), //valid
        .Data_in({m_axis_if_tdata,m_axis_if_tid}),

        .Data_out(s2f_data),
        .dest_req(s2f_valid)//valid
    );
	
	// main to spi, f2s
	CDC_DRIVER#(.DATA_LENGTH(16)) transmitter_cdc(
        .src_clk(clk),
        .dest_clk(SPI_clk),
        .reset_b(reset_n),
        .Data_Ready(f2s_valid), //valid
        .Data_in(f2s_data),

        .Data_out(s_axis_if_tdata),
        .dest_req(s_axis_if_tvalid)//valid
    );
	
	
	// handles the serial interface but no logic
SPI_IF SPI_IF_inst(
	.SPI_clk(SPI_clk),
	.SPI_reset_n(SPI_reset_n),
	.SPI_SCLK(SPI_SCLK),
	.SPI_CS_N(SPI_CS_N),
	.SPI_DI(SPI_DI),
	.SPI_SDO_DRDY(SPI_SDO_DRDY),
	
	.s_axis_tdata(s_axis_if_tdata),
	.s_axis_tvalid(s_axis_if_tvalid),
	.s_axis_tready(s_axis_if_tready), // output
	
	.m_axis_tdata(m_axis_if_tdata),
	.m_axis_tid(m_axis_if_tid), // drdy value
	.m_axis_tvalid(m_axis_if_tvalid),
	.m_axis_tready(m_axis_if_tready) // input
	);
	
	
endmodule


// handles the tx and rx but no logic.
module SPI_IF(
	// source
	input SPI_clk,
	input SPI_reset_n,
	
	// connects to ADC
	output SPI_SCLK,
	output reg SPI_CS_N,
	output SPI_DI,
	input SPI_SDO_DRDY,
	
	// input channel
	input[15:0] s_axis_tdata, // two byte command. specified below
	input s_axis_tvalid,
	output reg s_axis_tready,
	
	// output channel
	output reg[15:0] m_axis_tdata,
	output reg m_axis_tid, // DRDY value read before other stuff
	output reg m_axis_tvalid,
	input m_axis_tready

	
	);
	
	reg send_clk;
		
	assign SPI_SCLK = send_clk ? SPI_clk : 1;
	wire [15:0] sipo_out;
	wire [3:0] sipo_word_count;
	reg sipo_in_valid, sipo_clear;
	reg piso_shift, piso_load;
	
	reg [3:0] state;
	localparam S_IDLE 		= 	3'b000; // wait for command
	localparam S_CS 		= 	3'b001; // lower CS
	localparam S_DRDY 		= 	3'b010; // poll drdy
	localparam S_DATA	 	= 	3'b011; // transmit/receive data
	localparam S_RECEIVE	=	3'b100;	// sends back the received data
	
	always@(posedge SPI_clk or negedge SPI_reset_n)begin
		if(!SPI_reset_n)begin
			send_clk <= 0;
			SPI_CS_N <= 1;
			s_axis_tready <= 0;
			state <= S_IDLE;
			piso_load <= 0;
			piso_shift<=0;
		end else begin
			case(state)
				S_IDLE: begin
					SPI_CS_N = 1; // inactive CS
					send_clk = 0; // dont send clock
					m_axis_tid <= 0;
					m_axis_tvalid <= 0;
					s_axis_tready <= 1; // ready to receive command
					if(s_axis_tvalid)begin
						piso_load <= 1;
						state = S_CS;
					end
				end
				S_CS: begin
					piso_load <= 0;
					SPI_CS_N = 0; // active CS
					send_clk = 0;
					state = S_DRDY;
				end
				S_DRDY: begin
					state = S_DATA;
					m_axis_tid <= SPI_SDO_DRDY;
					send_clk <= 1;
					sipo_in_valid <= 1;
					sipo_clear <= 1;
					piso_shift <= 1;
				end
				S_DATA: begin
					sipo_clear <= 0;
					if(sipo_word_count==4'd15)begin
						state <= S_RECEIVE;
						sipo_in_valid <= 0;
						send_clk <= 0;
						piso_shift <= 0;
					end 
				end
				S_RECEIVE: begin
					m_axis_tdata <= sipo_out;
					m_axis_tvalid <= 1;
					if(m_axis_tready && m_axis_tvalid) state <= S_IDLE;
				end
				default:begin
					state = S_IDLE;
				end
			endcase
		end
	end
	sipo #(
		.WORD_SIZE(1),
		.WORD_COUNT(16)
		) input_buffer(
		.clk(SPI_clk),
		.reset_n(SPI_reset_n),
		.clear(sipo_clear),
		.din(SPI_SDO_DRDY),
		.dout(sipo_out),
		.din_valid(sipo_in_valid),
		.word_count(sipo_word_count)
		);
		
	piso #(
		.WORD_SIZE(1),
		.WORD_COUNT(16)
		) output_buffer(
		.clk(SPI_clk),
		.reset_n(SPI_reset_n),
		.din(s_axis_tdata),
		.dout(SPI_DI),
		.shift(piso_shift),
		.load(piso_load)
		);	
	
endmodule
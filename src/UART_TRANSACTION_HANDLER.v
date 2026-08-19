`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Myles
// 
// Create Date: 12/18/2025 12:41:51 AM
// Design Name: 
// Module Name: UART_TRANSACTION_HANDLER
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: NEEDS TO BE MADE PARAMETERIZED
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define IS_WRITE (operation[3])
`define IS_READ (!(`IS_WRITE))

`define IS_SPI_BROADCAST (operation[0])

`define REGMAP_TO_SPI(_address) (_address[4:0])


module UART_TRANSACTION_HANDLER_v2(
	input s_axis_clk,
	input s_axis_aresetn,
	//UART
	input[7:0] s_axis_uart_tdata,
	input s_axis_uart_tvalid,
	output reg s_axis_uart_tready,
	
	output[7:0] m_axis_uart_tdata,
	output reg m_axis_uart_tvalid,
	input m_axis_uart_tready,
	
	//REGMAP - 1 tick read latency
	output reg[7:0] regmap_addr,
	output [31:0] regmap_din,
	input[31:0] regmap_dout,
	output reg regmap_wea,
	
	
	//SPI
	output reg[15:0] m_axis_spi_tdata,
	output reg[7:0] m_axis_spi_tdest,
	output reg m_axis_spi_tvalid,	
	input m_axis_spi_tready,
	
	input[7:0] s_axis_spi_tdata,
	input s_axis_spi_tvalid,
	input s_axis_spi_tlast,
	output reg s_axis_spi_tready,
	
	
	//MEMORY
	output reg[7:0] mem_addr,
	output [31:0] mem_din,
	input[31:0] mem_dout,
	output reg mem_wea,
	
	// Angle
	input[31:0] max_angle
	
	);
	
			
	// Message format:
	// 	1 byte		[1 byte]  	[4 bytes]
	// 	Opcode		address		data
	
	// Opcodes:
	//	0x00	- 	Get Angle 								- 0 bytes
	// 	0x40	-	Read									- 1 bytes	- 8 bit address
	//	0x50	-	Read all SPI 							- 1 bytes	- 8 bit address
	//	0x60	-	Read Memory (separate from regmap)		- 2 bytes 	- 16 bit address
	// 	0x70	- 	Read ???								- 0 bytes 	- reserved for future implementation
	//	0x80	-	Write									- 5 bytes	- 8 bit address + 32 bit data
	//	0x90	-	Write all SPI							- 2 bytes	- 8 bit address + 8 bit data
	//	0xA0	-	Write Memory (separate from regmap)		- 6 bytes 	- 16 bit address + 32 bit data
	// 	0xB0	-	Write ???								- 0 bytes 	- reserved for future implementation
	
	// 2 bits - read or write. 2 bits - target. 4 LSB of byte are ignored
	localparam OP_GET_ANGLE 			= 4'h0; 	// 0000
	localparam OP_READ 					= 4'h4;		// 0100
	localparam OP_READ_ALL_SPI 			= 4'h5;		// 0101
	localparam OP_READ_MEM 				= 4'h6;		// 0110
	localparam OP_READ_ERR 				= 4'h7;		// 0111
	localparam OP_WRITE 				= 4'h8;		// 1000
	localparam OP_WRITE_ALL_SPI 		= 4'h9;		// 1001
	localparam OP_WRITE_MEM 			= 4'hA;		// 1010
	localparam OP_WRITE_ERR 			= 4'hB;		// 1011
	
	assign regmap_din = ibuf[4*WORD_SIZE - 1 : 0];
	assign mem_din = ibuf[4*WORD_SIZE - 1 : 0]; // first four words


		
	localparam WORD_SIZE = 8; 
	localparam INPUT_BUFFER_WORDS = 6; 
	localparam OUTPUT_BUFFER_WORDS = 6; 

	wire[INPUT_BUFFER_WORDS*WORD_SIZE -1 :0] ibuf,spi_buf;
	reg[OUTPUT_BUFFER_WORDS*WORD_SIZE -1 :0] obuf;
	wire[WORD_SIZE -1 : 0] ibuf_words[INPUT_BUFFER_WORDS-1:0];
	genvar i;
	generate
		for(i = 0; i < INPUT_BUFFER_WORDS; i = i + 1)begin
			assign ibuf_words[i] = ibuf[i*WORD_SIZE +: WORD_SIZE];
		end
	endgenerate

	reg[3:0] state;
	reg[3:0] operation;
	reg[2:0] rx_counter, tx_counter;
	wire[2:0] word_count;
	reg piso_load, piso_shift,sipo_clear, sipo_enable;
	reg pause;
	localparam S_IDLE 			= 	4'b0000;//0
	localparam S_SET_COUNTER	=	4'b0001;//1
	localparam S_RECEIVE		=	4'b0010;//2
	localparam S_READ			=	4'b0011;//3
	localparam S_READ_LOAD		=	4'b0100;//4
	localparam S_READ_SPI		=	4'b0101;//5
	localparam S_READ_SEND		=	4'b0110;//6
	localparam S_WRITE			=	4'b0111;//7
	localparam S_PISO_LOAD		=	4'b1000;//8
	

	
	always@(posedge s_axis_clk or negedge s_axis_aresetn)begin
		if(!s_axis_aresetn)begin
			state 			<= 	S_IDLE;
			piso_load 		<= 	0;
			piso_shift		<=	0;
			sipo_clear		<=	0;
			rx_counter		<=	0;
			obuf 			<=	0;
			sipo_enable 	<=	0;
			operation		<=	0;
			tx_counter		<=	0;
			pause			<=	0;
			s_axis_spi_tready<= 0;
			m_axis_spi_tvalid<= 0;
			m_axis_uart_tvalid<=0;
			regmap_addr 	<=	0;
			s_axis_uart_tready<=0;
			m_axis_spi_tdata <= 0;
			m_axis_spi_tdest <= 0;
		end else begin
			case(state)
				S_IDLE:begin
					piso_load <= 0;
					piso_shift <= 0;
					sipo_clear <= 0;
					obuf <= 0;
					sipo_enable <= 0;
					m_axis_uart_tvalid <= 0;
					m_axis_spi_tvalid <=0;
					regmap_wea <= 0;
					mem_wea <= 0;
					s_axis_uart_tready <= 1;
					if(s_axis_uart_tvalid)begin
						operation <= s_axis_uart_tdata[7:4]; // msb operation
						state <= S_SET_COUNTER;
					end else begin
						state <= S_IDLE;
					end
				end
				S_SET_COUNTER:begin
					sipo_enable <= 1;
					case(operation)
						OP_GET_ANGLE:begin
							rx_counter <= 0;
						end
						OP_READ:begin
							rx_counter <= 1;
						end
						OP_READ_ALL_SPI:begin
							rx_counter <= 1;
						end
						OP_READ_MEM:begin
							rx_counter <= 2;
						end
						OP_READ_ERR:begin
							rx_counter <= 0;
						end
						OP_WRITE:begin
							rx_counter <= 5;
						end
						OP_WRITE_ALL_SPI:begin
							rx_counter <= 2;
						end
						OP_WRITE_MEM:begin
							rx_counter <= 6;
						end
						OP_WRITE_ERR:begin
							rx_counter <= 0;
						end
						default: begin
							rx_counter <= 0;
						end
					endcase
					state <= S_RECEIVE;
				end
				S_RECEIVE:begin
					if(rx_counter == word_count) begin
						s_axis_uart_tready <= 0;
						if(operation[3]) state <= S_WRITE;
						else state <= S_READ;
					end
				end
				S_READ: begin
					case(operation)
						OP_GET_ANGLE:begin
							state <= S_READ_LOAD;
							tx_counter <= 4;
						end
						OP_READ:begin
							case(ibuf_words[0][7:5])
								3'b000: m_axis_spi_tdest <= 8'h01;
								3'b001: m_axis_spi_tdest <= 8'h02;
								3'b010: m_axis_spi_tdest <= 8'h04;
								3'b011: m_axis_spi_tdest <= 8'h08;
								3'b100: m_axis_spi_tdest <= 8'h10;
								3'b101: m_axis_spi_tdest <= 8'h20;
								3'b110: m_axis_spi_tdest <= 8'h40;
								3'b111: m_axis_spi_tdest <= 8'h80;
							endcase
							if(ibuf_words[0][7:5] == 3'b000 || ibuf_words[0][7:5] == 3'b111)begin // not SPI
								state <= S_READ_LOAD;
								tx_counter <= 4;
							end else begin // SPI
								m_axis_spi_tvalid <= 1;
								state <= S_READ_SPI;
								tx_counter <= 1;
							end 
							m_axis_spi_tdata <= {2'b01,ibuf_words[0][5:0],8'h00};
							regmap_addr <= ibuf_words[0];
							
						end
						OP_READ_ALL_SPI:begin
							m_axis_spi_tdest <= 8'hFF;
							m_axis_spi_tdata <= {2'b01,ibuf_words[0][5:0],8'h00};
							m_axis_spi_tvalid <= 1;
							state <= S_READ_SPI;
							tx_counter <= 6;
						end
						OP_READ_MEM:begin
							mem_addr <= ibuf[2*WORD_SIZE - 1 : 0];
							state <= S_READ_LOAD;
							tx_counter <= 4;
						end
						default: begin
							tx_counter <= 1;
						end
					endcase
				end
				S_READ_LOAD:begin
					state <= S_PISO_LOAD;
					case(operation)
						OP_GET_ANGLE:begin
							obuf <= {max_angle,8'h00,8'h00};
						end
						OP_READ:begin
							obuf <= {regmap_dout,8'h00,8'h00};
						end
						OP_READ_ALL_SPI:begin
							obuf <= spi_buf;
						end
						OP_READ_MEM:begin
							obuf <= mem_dout;
						end
						default: begin
						end
					endcase
				end
				S_READ_SPI:begin
					s_axis_spi_tready <= 1;
					if(m_axis_spi_tready) m_axis_spi_tvalid <= 0;
					if(s_axis_spi_tlast && s_axis_spi_tvalid) begin
						state <= S_READ_LOAD;
					end
					
				end
				S_PISO_LOAD:begin
					piso_load <= 1;
					state <= S_READ_SEND;
				end
				S_READ_SEND:begin
					piso_load <= 0;
					sipo_clear <= 1;
					if(m_axis_uart_tready && pause)begin
						piso_shift <= 1;
						tx_counter <= tx_counter - 1;
						m_axis_uart_tvalid <= 1;
						pause <= 0;
					end else begin
						m_axis_uart_tvalid <= 0;
						piso_shift <= 0;
						pause <= 1; // ensures that there is a 1 tick pause to check tready
					end
					if(tx_counter == 0) state <= S_IDLE;
					else state <= S_READ_SEND;
				end
				S_WRITE:begin
				    sipo_enable <= 0;
					sipo_clear <= 1;
					case(operation)
						OP_WRITE:begin
							case(ibuf_words[0][7:5])
								3'b000: m_axis_spi_tdest <= 8'h01;
								3'b001: m_axis_spi_tdest <= 8'h02;
								3'b010: m_axis_spi_tdest <= 8'h04;
								3'b011: m_axis_spi_tdest <= 8'h08;
								3'b100: m_axis_spi_tdest <= 8'h10;
								3'b101: m_axis_spi_tdest <= 8'h20;
								3'b110: m_axis_spi_tdest <= 8'h40;
								3'b111: m_axis_spi_tdest <= 8'h80;
							endcase
							if(ibuf_words[0][7:5] != 3'b000 && ibuf_words[0][7:5] != 3'b111)begin // SPI mode
								m_axis_spi_tvalid <= 1;
							end
							m_axis_spi_tdata <= {ibuf_words[1],ibuf_words[0]};
							regmap_addr <= ibuf_words[4];
							regmap_wea <= 1;
							state <= S_IDLE;
						end
						OP_WRITE_ALL_SPI:begin
							m_axis_spi_tdest <= 8'hFF;
							m_axis_spi_tdata <= {ibuf_words[1],ibuf_words[0]};
							m_axis_spi_tvalid <= 1;
							if(m_axis_spi_tready) state <= S_IDLE;
						end
						OP_WRITE_MEM:begin
							mem_addr <= ibuf[6*WORD_SIZE - 1 : 4*WORD_SIZE];
							mem_wea <= 1;
							state <= S_IDLE;
						end
					endcase		
					
				end
			endcase
		end
	end
	
	sipo #(
		.WORD_SIZE(WORD_SIZE),
		.WORD_COUNT(INPUT_BUFFER_WORDS)
		) input_buffer(
		.clk(s_axis_clk),
		.reset_n(s_axis_aresetn),
		.clear(sipo_clear),
		.din(s_axis_uart_tdata),
		.dout(ibuf),
		.din_valid(s_axis_uart_tvalid && sipo_enable),
		.word_count(word_count)
		);
		

	piso #(
		.WORD_SIZE(WORD_SIZE),
		.WORD_COUNT(OUTPUT_BUFFER_WORDS)
		) output_buffer(
		.clk(s_axis_clk),
		.reset_n(s_axis_aresetn),
		.din(obuf),
		.dout(m_axis_uart_tdata),
		.shift(piso_shift),
		.load(piso_load)
		);
		
	sipo #(
		.WORD_SIZE(WORD_SIZE),
		.WORD_COUNT(INPUT_BUFFER_WORDS)
		) spi_buffer(
		.clk(s_axis_clk),
		.reset_n(s_axis_aresetn),
		.clear(sipo_clear),
		.din(s_axis_spi_tdata),
		.din_valid(s_axis_spi_tvalid),
		.dout(spi_buf),
		.word_count()
		);
	
endmodule




module piso #(
	parameter WORD_SIZE = 8, 
	parameter WORD_COUNT = 4
	)(
	input clk, reset_n,
	input[WORD_COUNT * WORD_SIZE -1 : 0] din,
	output[WORD_SIZE -1  : 0] dout,
	input load, shift
	);
	
	
	reg[WORD_SIZE - 1 : 0] words[WORD_COUNT -1 : 0];
	assign dout = words[WORD_COUNT-1];

	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			for(i = 0;i <WORD_COUNT;i=i+1)begin
				words[i] <= 0;
			end
		end else begin
			if(load)begin
				for(i = 0; i < WORD_COUNT; i = i + 1)begin
					words[i] <= din[i*WORD_SIZE +: WORD_SIZE];
				end
			end if(shift) begin
				for(i = 0; i < WORD_COUNT; i = i + 1)begin
					if(i!=0) words[i] <= words[i-1];
					else words[i] <= 0;
				end
			end
		end
	end
	
endmodule

module sipo #(
	parameter WORD_SIZE = 8, 
	parameter WORD_COUNT = 4
	)(
	input clk, reset_n,
	input[WORD_SIZE -1 : 0] din,
	input din_valid,
	output reg[WORD_COUNT * WORD_SIZE -1  : 0] dout,
	output reg[$clog2(WORD_COUNT)-1:0] word_count,
	input clear
	);
	
	reg[WORD_SIZE - 1 : 0] words[WORD_COUNT -1 : 0];

	always@(*)begin
		for(i = 0; i < WORD_COUNT; i = i+1)begin
			dout[i*WORD_SIZE +:WORD_SIZE] <= words[i];
		end
	end
	
	integer i;
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n || clear)begin
			word_count<=0;
			for(i = 0;i <WORD_COUNT;i=i+1)begin
				words[i] <= 0;
			end
		end else begin
			if(din_valid)begin	
				word_count <= word_count+1;
				for(i = 0; i < WORD_COUNT; i = i + 1)begin
					if(i!=0) words[i] <= words[i-1];
					else words[i] <= din;
				end
			end
		end
	end
	
endmodule

	

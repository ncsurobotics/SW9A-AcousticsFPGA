`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 01/13/2026 11:41:03 PM
// Design Name:
// Module Name: top
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
module sample_mem(
	input clk, //100mhz clk
	input[0:0] sw, //switch
	input btnC, // reset, active high, center button
	input spi_clk,
	input spi_cs,
    input button,
	output[3:0] spi_dout
);
	
	
controller controller_inst(
	.clk(spi_clk),
	.reset(btnC),
	.spi_cs(spi_cs),
	.piso_load(piso_load),
	.piso_shift(piso_shift),
	.get_word(get_word),
    .address_offset(address_offset),
	.tristate(tristate),
	.button(button)
);
	reg tristate_buffer;
	always@(posedge spi_clk or posedge btnC)begin
		if(btnC)begin
			tristate_buffer <= 0;
		end else begin
			tristate_buffer <= tristate;
		end
	end
	

	
wire[10:0] addresses[3:0];
wire[159:0] rom_dout[3:0];
wire[9:0] mem_reader_dout[3:0];
wire [10:0] address_offset;
wire serial_out[3:0];


genvar i;
generate
for(i = 0; i < 4;i = i + 1)begin
	memory_reader_v2 memory_reader_inst(
		.clk(spi_clk),
		.reset(btnC),
		.get_word(get_word),
		.dout(mem_reader_dout[i]),
		.address(addresses[i]),
        .address_offset(address_offset),
		.rom_dout(rom_dout[i])
);
			
piso_sample_mem piso_inst(
	.clk(spi_clk),
	.reset(btnC),
	.load(piso_load),
	.shift(piso_shift),
	.word(mem_reader_dout[i]),
	.serial(serial_out[i])
);

assign spi_dout[i] = (tristate_buffer && sw[0]) ? serial_out[i] : 1'bz;
	
end
endgenerate
	
blk_mem_gen_0 channel_0_memory(
	.clka(spi_clk),
	.addra(addresses[0]),
	.douta(rom_dout[0])
);
blk_mem_gen_1 channel_1_memory(
	.clka(spi_clk),
	.addra(addresses[1]),
	.douta(rom_dout[1])
);
blk_mem_gen_2 channel_2_memory(
	.clka(spi_clk),
	.addra(addresses[2]),
	.douta(rom_dout[2])
);
blk_mem_gen_3 channel_3_memory(
	.clka(spi_clk),
	.addra(addresses[3]),
	.douta(rom_dout[3])
);	
	
endmodule

module memory_reader #(
	parameter WORD_SIZE = 10
)
(
input clk,
input reset,
input get_word,
output [WORD_SIZE - 1:0]dout,
	
input [159:0] rom_dout,
output [10:0] address
);
	
	reg[14:0] index;
	wire[3:0] offset;
	wire[14:0] next;
	assign address = index[14:4];
	assign offset = index[3:0];
	assign next = index+1;
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			index <= 0;
		end else begin
			if(get_word)begin
				index <= next;
			end else index <= index;
		end
	end
	
	assign dout = rom_dout[offset * WORD_SIZE +: WORD_SIZE];
	
endmodule
module piso_sample_mem #(
	parameter WORD_SIZE = 10
	)(
	input clk,
	input reset,
	input load,
	input shift,
	input[WORD_SIZE - 1 : 0] word,
	output reg serial
	);
	integer i;
	reg[WORD_SIZE -1 : 0] word_buffer;
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			word_buffer <= 0;
			serial <= 0;
		end else begin
			if(load) begin
				word_buffer <= word;
				serial <= 1'b0;
			end
			else if(shift)begin
				for(i = 0; i < WORD_SIZE; i = i + 1)begin
					if(i == 0) word_buffer[i] <= 0;
					else word_buffer[i] <= word_buffer[i-1];
				end			
				serial <= word_buffer[WORD_SIZE - 1];
			end
			else begin
				serial <= 1'b0;
				word_buffer <= word_buffer;
			end
		end
	end
	
endmodule

module controller(
	input clk,
	input reset,
	input spi_cs,
    input button,
	output reg piso_load,
	output reg piso_shift,
	output reg get_word,
	output reg tristate,
    output reg [10:0] address_offset
	);
	localparam WORD_SIZE = 10;
	localparam IDLE = 3'b000;
	localparam CS = 3'b001;
	localparam LOAD = 3'b010;
	localparam SENDING = 3'b011;
    localparam DELAY = 3'b100;
	localparam BUT_INC = 3'b101;

	reg[3:0] counter;
	reg[2:0] state;
	reg[7:0] sample_number;
	reg[7:0] sample_counter;
	reg sent_sample;
	reg button_reg;
	reg button_increment;
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			sample_number <= 0;
			sample_counter <= 0;
			sent_sample <= 0;
			tristate <= 0;
		    get_word <= 0;
		    piso_shift <= 0;
		    piso_load <= 0;
			counter <= 0;
			state <= 0;
            address_offset <= 0;
			button_reg <= 0;
			button_increment <= 0;
		end else begin
			
			button_reg <= button;
			if((button && !button_reg)) begin // detect rising edge
				button_increment <= 1; 
			end else begin
				button_increment <= 0;
			end


			case(state)
				IDLE:begin
					tristate <= 0;
					get_word <= !spi_cs && !sent_sample && !button_increment;
					piso_shift <= 0;
					piso_load <= 0;
					counter <= 0;
					if(button_increment && sent_sample) state <= BUT_INC;
					else if(!spi_cs && !sent_sample) state <= LOAD;
					else state <= state;
				end
				/*
				CS:begin
					tristate <= 0;
					get_word <= 1;
					piso_shift <= 0;
					piso_load <= 0;
					counter <= 0;
					state <= LOAD;
				end*/
				LOAD:begin
					tristate <= 0;
					get_word <= 0;
					piso_shift <= 0;
					piso_load <= 1;
					counter <= 0;
					state <= SENDING;
				end
				SENDING:begin
					tristate <= 1;
					get_word <= 0;
					piso_shift <= 1;
					piso_load <= 0;
					counter <= counter + 1;
					if(counter == (WORD_SIZE-1) && spi_cs) state <= IDLE;
					else if (counter == (WORD_SIZE-1))state <= DELAY;
                    else state <= SENDING;
				end
                DELAY: begin
                    tristate <= 0;
                    get_word <= 0;
                    piso_shift <= 0;
                    piso_load <= 0;
                    counter <= 0;
					if(sample_counter == 8'hFF) sent_sample <= 1;
                    if(spi_cs) begin 
						state <= IDLE;
						sample_counter <= sample_counter + 1;
					end else state <= DELAY;
                end
				BUT_INC: begin
					sample_number <= sample_number + 1;
					sent_sample <= 0;
					sample_counter <= 0;
					state <= IDLE;
				end
			
			endcase
		end
	end
	
	
	
endmodule

module memory_reader_v2 #(
	parameter WORD_SIZE = 10
)
(
input clk,
input reset,
input get_word,
input [10:0] address_offset,
output reg [WORD_SIZE - 1:0]dout,

input [159:0] rom_dout,
output [10:0] address
);
	
	reg[14:0] index;
	wire[3:0] offset;
	wire[14:0] next;
	assign address = index[14:4] + address_offset;
	assign offset = index[3:0];
	assign next = index+1;
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			index <= 15'd0; 
			dout <= 0;
		end else begin
			dout <= rom_dout[offset * WORD_SIZE +: WORD_SIZE];
			if(next[14:4]==256)begin
				index <= 0;
			end else if(get_word)begin
				index <= next;
			end else index <= index;
		end
	end
	
endmodule
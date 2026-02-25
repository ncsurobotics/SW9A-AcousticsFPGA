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


module UART_TRANSACTION_HANDLER(
    input clk,
    input reset_n,

    input [7:0] rx_data,
    input rx_ready,

    input [31:0] command_reader_out,
    input uart_tx_ready,

	input [31:0] data_storage_memory_out,

    output [5:0] uart_addr,
    output uart_wen,
    output [31:0] uart_data_in,

    output [7:0] Word_To_Send,
    output Word_To_Send_en
    );

    wire [3:0] byte_counter;
	wire[1:0] op;
	reg[1:0] last_op;
	
	wire[31:0] tx_data_in;

    UART_RX_DECODER UART_RX_DECODER_inst(
        .clk(clk),
        .reset_n(reset_n),
        .RX_Data_in(rx_data),
        .RX_Data_ready(rx_ready),
        .address(uart_addr),
        .op(op),
        .data_out(uart_data_in),

        .byte_counter(byte_counter)
    );
	
	assign uart_wen = op == 2'b01;
	assign tx_data_in = last_op == 2'b10 ? data_storage_memory_out : command_reader_out;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			last_op <= 0;
		end else begin
			last_op <= op;
		end
	end

    UART_TX_ENCODER UART_TX_ENCODER_inst(
        .clk(clk),
        .reset_n(reset_n),
        .byte_counter(byte_counter),
        .data_in(tx_data_in),
        .uart_tx_ready(uart_tx_ready),
        .op(op),
        .Word_To_Send(Word_To_Send),
        .Word_To_Send_en(Word_To_Send_en)
    );


endmodule

module UART_RX_DECODER(
    input clk,
    input reset_n,

    input [7:0] RX_Data_in,
    input RX_Data_ready,

    output [5:0] address,
    output [1:0] op, // 2'b00 for read, 2'b01 for write, 2'b10 for a bram read, 2'b11 reserved
    output [31:0] data_out,

    output reg [3:0] byte_counter

);
integer i;
reg [7:0] SIPO [0:4];

localparam OP_REGMAP_READ = 2'b00; // 2'b00 + 6 bit regmap address
localparam OP_REGMAP_WRITE = 2'b01; // 2'b01 + 6 bit regmap address, byte[3], byte[2], byte[1], byte[0]
localparam OP_BRAM_READ = 2'b10; // 2'b10 + 6 bit dont care, addr[3], addr[2], addr[1], addr[0]
localparam OP_RESERVED = 2'b11; // 2'b11 + 6 bit dont care

always@(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        byte_counter <= 4'h0;
        for (i = 0; i < 5; i = i + 1) SIPO[i] <= 0;
    end else begin
        case (byte_counter)
            4'h0: begin
                if (RX_Data_ready) begin
                    SIPO[0] <= RX_Data_in;
					case (RX_Data_in[7:6])
						OP_REGMAP_READ: 	byte_counter <= 4'hE;
						OP_REGMAP_WRITE: 	byte_counter <= 4'h1;
						OP_BRAM_READ: 		byte_counter <= 4'h1;
						OP_RESERVED: 		byte_counter <= 4'hE;
					endcase
                end
            end
            4'h1: begin
                if (RX_Data_ready) begin
                    SIPO[1] <= RX_Data_in;
                    byte_counter <= 4'h2;
                end
            end
            4'h2: begin
                if (RX_Data_ready) begin
                    SIPO[2] <= RX_Data_in;
                    byte_counter <= 4'h3;
                end
            end
            4'h3: begin
                if (RX_Data_ready) begin
                    SIPO[3] <= RX_Data_in;
                    byte_counter <= 4'h4;
                end
            end
            4'h4: begin
                if (RX_Data_ready) begin
                    SIPO[4] <= RX_Data_in;
                    byte_counter <= 4'hE;
                end
            end
            4'hE: begin
                byte_counter <= 4'hF;
            end
            4'hF: begin
                for (i = 0; i < 5; i = i + 1) SIPO[i] <= 0;
                byte_counter <= 4'h0;
            end
            default: begin
                byte_counter <= 4'b0; // safety reset
                for (i = 0; i < 5; i = i + 1) SIPO[i] <= 0;
            end
        endcase
    end
    end


    assign address = (byte_counter > 4'hD) ? SIPO[0][6:0] : 7'h0;
    assign op = (byte_counter > 4'hD) ? SIPO[0][7:6] : 2'b00;
    assign data_out = (byte_counter > 4'hD) ? {SIPO[1], SIPO[2], SIPO[3], SIPO[4]} : 32'h0;

endmodule

module UART_TX_ENCODER(
    input clk,
    input reset_n,

    input [3:0] byte_counter,
    input [31:0] data_in,
    input uart_tx_ready,
    input [1:0] op,

    output [7:0] Word_To_Send,
    output Word_To_Send_en

);

localparam PISO_DEPTH = 4;
integer i;
reg [8:0] PISO [0:PISO_DEPTH-1];

    always@(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            for (i = 0; i < PISO_DEPTH; i = i + 1) PISO[i] <= 0;
        end else begin
            if (byte_counter == 4'hF && op != 2'b01) begin
                PISO[3] <= {1'b1, data_in[7:0]};
                PISO[2] <= {1'b1, data_in[15:8]};
                PISO[1] <= {1'b1, data_in[23:16]};
                PISO[0] <= {1'b1, data_in[31:24]};
            end
            if((uart_tx_ready) && (PISO[0][8] == 1'b1)) begin
                for (i = 0; i < PISO_DEPTH - 1; i = i + 1) begin
                    PISO[i] <= PISO[i + 1];
                end
                PISO[PISO_DEPTH - 1] <= 9'b0;
            end
        end
    end

    assign Word_To_Send = ((PISO[0][8] == 1'b1)) ? PISO[0][7:0] : 8'b0;
    assign Word_To_Send_en = (uart_tx_ready) & (PISO[0][8] == 1'b1);
endmodule


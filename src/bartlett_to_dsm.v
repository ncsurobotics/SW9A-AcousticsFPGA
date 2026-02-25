`timescale 1ns/1ps



module bartlett_to_dsm #(
	parameter WORD_SIZE = 32,
	parameter ADDRESS_WIDTH = 13
	)(
	input clk,
	input reset_n,
	
	input [WORD_SIZE -1 : 0] s_axis_tdata,
	input s_axis_tvalid,
	
	output reg bram_wea,
	output reg[WORD_SIZE - 1 : 0] bram_dina,
	output reg[ADDRESS_WIDTH - 1 : 0] bram_addra,
	output reg bram_ena
	
	);
	
	
	reg [26:0] sample_counter;
	reg [4:0] word_counter;
	
	reg[1:0] state;
	localparam S_IDLE = 2'b00;
	localparam S_RECEIVING = 2'b01;
	localparam S_FILL = 2'b10;
	localparam S_DONE = 2'b11;
	
	always@(posedge clk or negedge reset_n)begin
		if(!reset_n)begin
			sample_counter <= 0;
			word_counter <= 0;
			state <= S_IDLE;
			bram_wea <= 0;
			bram_ena <= 0;
			bram_dina <= 0;
			bram_addra <= 0;
		end else begin
			case(state)
				S_IDLE: begin
					sample_counter <= sample_counter;
					word_counter <= s_axis_tvalid ? word_counter + 1 : 0;
					state <= s_axis_tvalid ? S_RECEIVING : S_IDLE;
					bram_wea <= s_axis_tvalid;
					bram_ena <= s_axis_tvalid;
					bram_dina <= s_axis_tdata;
					bram_addra <= {sample_counter,word_counter};
					
				end
				S_RECEIVING: begin
					word_counter <= s_axis_tvalid ? word_counter + 1 : word_counter;
					sample_counter <= sample_counter;
					state <= word_counter == 5'd20 ? S_FILL : S_RECEIVING;
					bram_wea <= s_axis_tvalid;
					bram_ena <= s_axis_tvalid;
					bram_dina <= s_axis_tdata;
					bram_addra <= {sample_counter,word_counter};
				end
				S_FILL: begin
					word_counter <= word_counter + 1;
					sample_counter <= sample_counter;
					state <= word_counter == 5'b11111 ? S_DONE : S_FILL;
					bram_wea <= 1'b1;
					bram_ena <= 1'b1;
					bram_dina <= {5'd0,sample_counter};
					bram_addra <= {sample_counter,word_counter};
				end
				S_DONE: begin
					word_counter <= 0;
					sample_counter <= sample_counter + 1;
					state <= S_IDLE;
					bram_wea <= 1'b0;
					bram_ena <= 1'b0;
					bram_dina <= {5'd0,sample_counter};
					bram_addra <= {sample_counter,word_counter};
				end
			
			endcase
		end
	end
endmodule
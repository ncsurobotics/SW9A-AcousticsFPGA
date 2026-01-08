`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2025 10:46:08 AM
// Design Name: 
// Module Name: SPI_TRANSACTION_HANDLER
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

/*
module SPI_TRANSACTION_HANDLER #(parameter SAMPLES = 256) (
    input clk,
    input reset_n,
    input sample_ready,

    output data_last
);

localparam IDLE = 0,
           SAMPLE = 1,
           SAMPLE_AND_SEND = 2,
           SEND_DATA = 3,
           LAST = 4,
           ADDR_TRANSITION = 5;

reg [$clog2(SAMPLES):0] sample_counter;

// future me will c the vision
always@(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        sample_counter <= 0;
    end
    else begin
        if(sample_ready & (sample_counter == SAMPLES - 2)) begin
            sample_counter <= 0;
        end
        else begin
            if(sample_ready) begin
                sample_counter <= sample_counter + 1;
            end
        end
    end
end

assign data_last = (sample_counter == SAMPLES - 2 && sample_ready);

endmodule
*/

module SPI_TRANSACTION_HANDLER #(parameter SAMPLES = 256, parameter CHANNELS = 4) (
    input clk,
    input reset_n,

    input sample_ready,
    
    input bartlett_ready,

    output reg[CHANNELS - 1 : 0] SPI_en,
    output reg[CHANNELS - 1 : 0] Send_Frame,

    output reg data_valid,
    output reg data_last
);

localparam IDLE = 0,
           SAMPLE = 1,
           COUNT = 2,
           DATA_TO_BARTLETT = 3,
           LAST = 4,
           ADDR_TRANSITION = 5;


reg [3:0] state;
reg [11:0] sample_counter, bartlett_counter;

always@(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state <= IDLE;
        sample_counter <= 0;
        bartlett_counter <= 0;
        SPI_en <= 0;
        Send_Frame <= 0;
        data_valid <= 0;
        data_last <= 0;
    end else begin
        case (state)
            IDLE: begin
                state <= SAMPLE;
                sample_counter <= 0;
                bartlett_counter <= 0;
                SPI_en <= 0;
                Send_Frame <= 0;
                data_valid <= 0;
                data_last <= 0;
            end
            SAMPLE: begin
                // Sample
                SPI_en <= 4'hF;
                if(sample_ready) state <= COUNT;
                else state <= SAMPLE;
            end
            COUNT: begin
                SPI_en <= 4'hF;
                if (sample_counter <= SAMPLES) begin
                    sample_counter <= sample_counter + 1;
                    state <= SAMPLE;
                end else begin
                    sample_counter <= 0;
                    state <= DATA_TO_BARTLETT;
                end
            end
            DATA_TO_BARTLETT: begin
                SPI_en <= 0;
                if (bartlett_ready) begin
                    Send_Frame <= 4'hF;
                    data_valid <= 1;
                    if (bartlett_counter < SAMPLES) begin
                        bartlett_counter <= bartlett_counter + 1;
                        state <= DATA_TO_BARTLETT;
                    end
                    else state <= LAST;
                end else begin
                    state <= DATA_TO_BARTLETT;
                    Send_Frame <= 0;
                    data_valid <= 0;
                end
            end
            LAST: begin
                SPI_en <= 0;
                if (bartlett_ready) begin
                    Send_Frame <= 4'hF;
                    data_valid <= 1;
                    data_last <= 1;
                    state <= IDLE;
                end
                else begin
                    state <= LAST;
                    Send_Frame <= 0;
                    data_valid <= 0;
                    data_last <= 0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule



module SPI_HANDLER_WRAPPER #(parameter CHANNELS = 4) (
	input clk,
    input reset_n,
    input [CHANNELS-1:0] sample_ready,
    output data_last_out);
	
    wire [CHANNELS-1:0] data_last;
	genvar i;
	generate
	for(i = 0; i < CHANNELS; i = i + 1)begin
		SPI_TRANSACTION_HANDLER SPI_HANDLER_inst (
			.clk(clk),
            .reset_n(reset_n),
            .sample_ready(sample_ready[i]),
            .data_last(data_last[i])
		);
	end
	endgenerate

    // temporary logic to combine data_valid and data_last signals
    assign data_last_out = |data_last;


endmodule

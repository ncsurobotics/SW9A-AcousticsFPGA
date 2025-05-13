`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2025 05:40:14 PM
// Design Name: 
// Module Name: COMMAND_READER
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


module COMMAND_READER(
    input clk,
    input reset_b,
    input [7:0] command,

    output reg [5:0] frequency

    );

    // State machine states
    parameter IDLE = 8'h0x;
    parameter DUMP = 8'h1x;
    parameter MAX = 8'h2x;
    parameter SET_FREQUENCY = 8'h4x;
    parameter SET_THRESHOLD = 8'h8x;

    //registers
    reg [7:0] current_state;
    reg [7:0] next_state;

    reg [5:0] next_frequency;

    always@ (posedge clk or negedge reset_b) begin
        if (!reset_b) begin
            current_state <= IDLE; // Reset to IDLE state
            frequency<=6'h10; // Default frequency
        end
        else begin
            current_state <= next_state; // Update to next state
            frequency <= next_frequency; // Update frequency
        end
    end

    always@(*) begin
        casex(command)
            IDLE: begin
                
            end

            DUMP: begin
                
            end

            MAX: begin
                
            end

            SET_FREQUENCY: begin
                next_frequency = {2'b00, command[3:0]}; // Set frequency from command
            end

            SET_THRESHOLD: begin
                
            end
        endcase
    end



endmodule

`timescale 1ns / 1ps

module clk_div #(parameter DIVISOR = 2, parameter COUNTER_WIDTH = 1)(
    input clk_in,
    input reset_b,
    output clk_out
    );
    reg [COUNTER_WIDTH-1:0] count;
    reg clk_out_reg;

    always @(posedge clk_in or negedge reset_b) begin
        if (!reset_b) begin
            count <= 0;
            clk_out_reg <= 0;
        end else begin
            if (count == (DIVISOR - 1)) begin
                clk_out_reg <= ~clk_out_reg;
                count <= 0;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    assign clk_out = clk_out_reg;


endmodule


module clk_divide_2(
    input clk_in,
    output reg clk_out
    );
    
    always@(posedge clk_in) begin
        case(clk_out)
            1'b0: clk_out <= 1'b1;
            1'b1: clk_out <= 1'b0;
            default: clk_out <= 1'b0;
        endcase
    end


endmodule

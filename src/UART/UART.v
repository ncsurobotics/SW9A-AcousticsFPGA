//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2023 05:28:27 PM
// Design Name: 
// Module Name: UART
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

module UART_axis_wrapper(
	input s_axis_clk,
	input s_axis_areset_n,
	
	input[7:0] s_axis_tdata,
	input s_axis_tvalid,
	output s_axis_tready,
	
	output [7:0] m_axis_tdata,
	output m_axis_tvalid,
	
	input uart_clk,
	input uart_areset_n,
	
	input uart_rx_in,
	output uart_tx_out
	
	);
	
	UART #(
		.WORD_SIZE(8),
		.WORD_SIZE_WIDTH(4)
		)
		UART_inst(
		.clk(s_axis_clk),
		.UART_clk(uart_clk),
		.reset_b(s_axis_areset_n),
		.uart_aresetn(uart_areset_n),
		
		.TX_Data_in(s_axis_tdata),
		.TX_en(s_axis_tvalid),
		.TX_Ready_To_Send(s_axis_tready),
		
		.RX_Data_out(m_axis_tdata),
		.RX_Data_Ready(m_axis_tvalid),
		
		.TX_Data_out(uart_tx_out),
		.RX_Data_in(uart_rx_in)
		);
		
	
	
	
endmodule

module UART #(parameter WORD_SIZE=8, parameter WORD_SIZE_WIDTH=4) (

    input clk,
    input UART_clk,
    input reset_b,
	input uart_aresetn,
    input [WORD_SIZE-1:0] TX_Data_in,
    input TX_en,
    input RX_Data_in,
    
    output wire TX_Data_out,
    output wire TX_Ready_To_Send,
    output wire [WORD_SIZE-1:0] RX_Data_out,
    output wire RX_Data_Ready

    
);

    UART_TX UART_TX_inst(
        .clk(clk), // 100 MHz
        .UART_clk(UART_clk), // 5.76 MHz,
        .reset_b(reset_b),
		.uart_aresetn(uart_aresetn),

        .TX_en(TX_en), // all inputs are from outside modules running at 100 MHz
        .TX_Data_in(TX_Data_in),

        .TX_Ready(TX_Ready_To_Send),
        .TX_Data_out(TX_Data_out)
    );

    /*wire [WORD_SIZE-1:0] RX_Data_Captured;
    integer i;
    always@(posedge clk or negedge reset_b) begin
        if(!reset_b) begin
            for( i = 0 ; i < WORD_SIZE ; i = i + 1)  RX_Data_out[i] <= 1'b1;
        end
        else begin
            if(RX_Data_Ready) RX_Data_out <= RX_Data_Captured;
            else RX_Data_out <= RX_Data_out;
        end 
    
    end*/


    UART_RX #(.WORD_SIZE(WORD_SIZE), .WORD_SIZE_WIDTH(WORD_SIZE_WIDTH)) UART_RX_inst(
    
        .clk(clk),
        .reset_b(reset_b),
        .RX_Data_in(RX_Data_in),
        
        .RX_Data_out(/*RX_Data_Captured*/RX_Data_out),
        .RX_Data_Ready(RX_Data_Ready)
        
    );
    
  
endmodule

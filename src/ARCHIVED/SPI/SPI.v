`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2023 10:10:14 PM
// Design Name: 
// Module Name: SPI
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


module SPI #(parameter WIDTH=10, parameter TOTAL_BITS=14) (

    input clk,
    input SPI_clk,
    input reset_b,
	input spi_areset_n,
    input SPI_Data_in,
    input SPI_en,
    
    output reg [WIDTH-1:0] SPI_Data_out,
    output reg Data_Ready,
    output wire CS

);

    wire Data_Ready_Internal;
    wire[WIDTH-1:0] SPI_Data_out_Internal;
    wire Bit_Count_Reached;
    wire RX_Shift_Register_sel, Bit_Counter_sel;
    //assign Data_Ready = Data_Ready_Internal;

    SPI_DATAPATH #(.WIDTH(WIDTH) , .TOTAL_BITS(TOTAL_BITS)) SPI_DATAPATH_inst(
    
        //.clk(clk),
        .SPI_clk(SPI_clk),
        .reset_b(spi_areset_n),
        .SPI_Data_in(SPI_Data_in),
        .Bit_Counter_sel(Bit_Counter_sel),
        .Data_Ready(Data_Ready_Internal),
        .RX_Shift_Register_sel(RX_Shift_Register_sel),
        
        .SPI_Data_out(SPI_Data_out_Internal),
        .Bit_Count_Reached(Bit_Count_Reached)
    
    );
    
    SPI_CONTROLLER SPI_CONTROLLER_inst(
    
        .clk(SPI_clk),
        .reset_b(spi_areset_n),
        .SPI_en(SPI_en),
        .Bit_Count_Reached(Bit_Count_Reached),
        
        .RX_Shift_Register_sel(RX_Shift_Register_sel),
        .Bit_Counter_sel(Bit_Counter_sel),
        .Data_Ready(Data_Ready_Internal),
        .CS(CS)
    
    );


	wire [WIDTH-1:0] cdc_data_out;
	wire cdc_dest_req;
    CDC_DRIVER#(.DATA_LENGTH(WIDTH)) DATA_DRIVER_inst(
        .src_clk(SPI_clk),
        .dest_clk(clk),
        .reset_b(reset_b),
        .Data_Ready(Data_Ready_Internal),
        .Data_in(SPI_Data_out_Internal),

        .Data_out(cdc_data_out),
        .dest_req(cdc_dest_req)
    );
	
	always@(posedge clk or negedge reset_b)begin
		if(!reset_b)begin
			SPI_Data_out <= 0;
			Data_Ready <= 0;
		end else begin
			SPI_Data_out <= cdc_dest_req ? cdc_data_out : 0;
			Data_Ready <= cdc_dest_req;
		end
	end

endmodule

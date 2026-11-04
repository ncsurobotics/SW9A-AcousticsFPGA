`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: 
//
// Create Date: 
// Design Name:
// Module Name: UART_TRANSACTION_HANDLER
// Project Name:
// Target Devices:
// Tool Versions:
// Description: NEEDS TO BE MADE PARAMETERIZED
//
// Cleaned version for the new UART <-> AXI-Lite direction.
// Old BRAM-specific routing has been removed.
//
// TODO FOR THE NEW DESIGN (comments only -- AXI-Lite logic is NOT added here):
//   1. Add the AXI-Lite master interface ports.
//   2. Use the decoded UART address as the AXI-Lite address source.
//   3. Use the decoded UART write data as the AXI-Lite write-data source.
//   4. Replace command_reader_out with AXI-Lite read-response data.
//   5. Add AXI-Lite read/write handshake control.
//   6. Add/keep the GET_ANGLE operation as the one special UART operation.
//      GET_ANGLE was not present in this source file, so no implementation was
//      invented here.
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module UART_TRANSACTION_HANDLER #(
    parameter AXI_ADDR_WIDTH = 32,
    parameter AXI_DATA_WIDTH = 32
)(
    input clk,
    input reset_n,

    input  [7:0] rx_data,
    input        rx_ready,

    input        uart_tx_ready,
    output [7:0] Word_To_Send,
    output       Word_To_Send_en,

    input [31:0] max_angle,

    output reg [AXI_ADDR_WIDTH-1:0] m_axi_awaddr,
    output reg                      m_axi_awvalid,
    input                           m_axi_awready,

    output reg [AXI_DATA_WIDTH-1:0] m_axi_wdata,
    output reg [(AXI_DATA_WIDTH/8)-1:0] m_axi_wstrb,
    output reg                      m_axi_wvalid,
    input                           m_axi_wready,

    input  [1:0]                    m_axi_bresp,
    input                           m_axi_bvalid,
    output reg                      m_axi_bready,

    output reg [AXI_ADDR_WIDTH-1:0] m_axi_araddr,
    output reg                      m_axi_arvalid,
    input                           m_axi_arready,

    input  [AXI_DATA_WIDTH-1:0]     m_axi_rdata,
    input  [1:0]                    m_axi_rresp,
    input                           m_axi_rvalid,
    output reg                      m_axi_rready
);

    wire [3:0] byte_counter;
    wire [1:0] op;
    
    wire [5:0] uart_addr;
    wire [31:0] uart_data_in;
    
    reg aw_done;
    reg w_done;

    reg [31:0] tx_data_in;
    reg [AXI_ADDR_WIDTH-1:0] uart_addr_reg;
    reg [AXI_DATA_WIDTH-1:0] uart_data_reg;
    reg tx_start;
    wire tx_done;

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
    
    wire command_valid = (byte_counter == 4'hF);
    
    reg [2:0] state;
    localparam [2:0] IDLE = 3'd0, AXI_READ_ADDR = 3'd1, AXI_READ_DATA = 3'd2, AXI_WRITE = 3'd3, AXI_WRITE_RESP = 3'd4, UART_SEND = 3'd5, UART_WAIT = 3'd6;
    localparam [1:0] OP_READ = 2'b00, OP_WRITE = 2'b01, OP_GET_ANGLE = 2'b10;
       
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= IDLE;
            uart_addr_reg <= 0;
            uart_data_reg <= 0;
            aw_done <= 1'b0;
            w_done  <= 1'b0;
            m_axi_awaddr <= 0;
            m_axi_awvalid <= 0;
            m_axi_wdata <= 0;
            m_axi_wstrb <= 0;
            m_axi_wvalid <= 0;
            m_axi_bready <= 0;
            m_axi_araddr <= 0;
            m_axi_arvalid <= 0;
            m_axi_rready <= 0;
            tx_start <= 0;
            tx_data_in <= 0;
        end
        else begin
            case(state)
                IDLE: begin
                        tx_start <= 1'b0;
                        if (command_valid) begin
                            uart_addr_reg <= {{(AXI_ADDR_WIDTH-6){1'b0}}, uart_addr};
                            uart_data_reg <= uart_data_in;                            
                            
                            case (op)
                                OP_READ:      state <= AXI_READ_ADDR;
                                OP_WRITE: begin
                                    aw_done <= 1'b0;
                                    w_done  <= 1'b0;
                                    state <= AXI_WRITE;
                                end
                                OP_GET_ANGLE: begin
                                    tx_data_in <= max_angle;
                                    state <= UART_SEND;
                                end
                                default:      state <= IDLE;
                            endcase
                        end
                      end
                AXI_READ_ADDR: begin
                        m_axi_araddr <= uart_addr_reg;
                        m_axi_arvalid <= 1'b1;
                        if(m_axi_arvalid && m_axi_arready) begin
                            m_axi_rready <= 1'b1;
                            m_axi_arvalid <= 1'b0;
                            state <= AXI_READ_DATA;
                        end
                      end
                AXI_READ_DATA: begin
                        if (m_axi_rvalid && m_axi_rready) begin
                            if (m_axi_rresp == 2'b00) tx_data_in <= m_axi_rdata;
                            else tx_data_in <= 32'hDEAD0001; // example error code
                                
                            m_axi_rready <= 1'b0;
                            state <= UART_SEND;
                        end
                      end
                AXI_WRITE: begin
                        m_axi_awaddr <= uart_addr_reg;
                        m_axi_wdata  <= uart_data_reg;
                        m_axi_wstrb  <= {AXI_DATA_WIDTH/8{1'b1}};
                    
                        if (!aw_done)
                            m_axi_awvalid <= 1'b1;
                    
                        if (m_axi_awvalid && m_axi_awready) begin
                            m_axi_awvalid <= 1'b0;
                            aw_done <= 1'b1;
                        end
                    
                        if (!w_done)
                            m_axi_wvalid <= 1'b1;
                    
                        if (m_axi_wvalid && m_axi_wready) begin
                            m_axi_wvalid <= 1'b0;
                            w_done <= 1'b1;
                        end
                    
                        if (aw_done && w_done) begin
                            m_axi_bready <= 1'b1;
                            state <= AXI_WRITE_RESP;
                        end
                      end
                AXI_WRITE_RESP: begin
                        if (m_axi_bvalid && m_axi_bready) begin
                            if (m_axi_bresp != 2'b00) begin
                                m_axi_bready <= 1'b0;
                                state <= IDLE;
                            end
                            else begin
                                m_axi_bready <= 1'b0;
                                state <= IDLE;
                            end
                        end
                      end
                UART_SEND: begin
                        tx_start <= 1'b1;
                        state <= UART_WAIT;
                      end
                UART_WAIT: begin
                    tx_start <= 1'b0;
                    if(tx_done) state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end
    
    UART_TX_ENCODER UART_TX_ENCODER_inst(
        .clk(clk),
        .reset_n(reset_n),
        .tx_start(tx_start),
        .data_in(tx_data_in),
        .uart_tx_ready(uart_tx_ready),
        .Word_To_Send(Word_To_Send),
        .Word_To_Send_en(Word_To_Send_en),
        .tx_done(tx_done)
    );
    
endmodule


// -----------------------------------------------------------------------------
// UART receive decoder
//
// The first UART byte contains the current command/address information.
// For a write, four more UART bytes are collected into SIPO[1]..SIPO[4].
// The resulting 32-bit value is exposed on data_out.
// -----------------------------------------------------------------------------
module UART_RX_DECODER(
    input clk,
    input reset_n,

    input [7:0] RX_Data_in,
    input RX_Data_ready,

    output [5:0] address,
    output [1:0] op,
    output [31:0] data_out,

    output reg [3:0] byte_counter

);
integer i;
reg [7:0] SIPO [0:4];

localparam OP_REGMAP_READ  = 2'b00;
localparam OP_REGMAP_WRITE = 2'b01;
localparam OP_GET_ANGLE   = 2'b10;
localparam OP_RESERVED_1   = 2'b11;

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
                        OP_REGMAP_READ:  byte_counter <= 4'hE;
                        OP_REGMAP_WRITE: byte_counter <= 4'h1;
                        OP_GET_ANGLE:   byte_counter <= 4'hE;
                        OP_RESERVED_1:   byte_counter <= 4'hE;
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
                byte_counter <= 4'b0;
                for (i = 0; i < 5; i = i + 1) SIPO[i] <= 0;
            end
        endcase
    end
end

assign address = (byte_counter > 4'hD) ? SIPO[0][5:0] : 6'h0;
assign op = (byte_counter > 4'hD) ? SIPO[0][7:6] : 2'b00;
assign data_out = (byte_counter > 4'hD) ? {SIPO[1], SIPO[2], SIPO[3], SIPO[4]} : 32'h0;

endmodule

// -----------------------------------------------------------------------------
// UART transmit encoder
//
// Loads one 32-bit response and sends it as four UART bytes.
// This block can still be reused for AXI-Lite read responses and GET_ANGLE.
// -----------------------------------------------------------------------------
module UART_TX_ENCODER(
    input clk,
    input reset_n,

    input tx_start,
    input [31:0] data_in,
    input uart_tx_ready,

    output [7:0] Word_To_Send,
    output Word_To_Send_en,
    output tx_done
);

localparam PISO_DEPTH = 4;
integer i;
reg [8:0] PISO [0:PISO_DEPTH-1];

always@(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        for (i = 0; i < PISO_DEPTH; i = i + 1) PISO[i] <= 0;
    end else begin
    
        if (tx_start) begin
            PISO[3] <= {1'b1, data_in[7:0]};
            PISO[2] <= {1'b1, data_in[15:8]};
            PISO[1] <= {1'b1, data_in[23:16]};
            PISO[0] <= {1'b1, data_in[31:24]};
        end else if ((uart_tx_ready) && (PISO[0][8] == 1'b1)) begin
            for (i = 0; i < PISO_DEPTH - 1; i = i + 1) begin
                PISO[i] <= PISO[i + 1];
            end
            PISO[PISO_DEPTH - 1] <= 9'b0;
        end
    end
end

assign Word_To_Send = (PISO[0][8] == 1'b1) ? PISO[0][7:0] : 8'b0;
assign Word_To_Send_en = uart_tx_ready & (PISO[0][8] == 1'b1);

assign tx_done = uart_tx_ready && (PISO[0][8] == 1'b1) && (PISO[1][8] == 1'b0);

endmodule

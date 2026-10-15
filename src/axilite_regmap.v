`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 09:29:23 AM
// Design Name: 
// Module Name: axilite_regmap
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
// full r/w permissions
module axilite_regmap #(
	parameter ADDR_WIDTH     = 16,
	parameter DATA_WIDTH     = 16,
	parameter REGISTER_COUNT = 20
)(
	input                          s_axi_clk,
	input                          s_axi_resetn,

	// Read Address
	input  [ADDR_WIDTH-1:0]        s_axi_araddr,
	input                          s_axi_arvalid,
	output                         s_axi_arready,

	// Read Data
	output reg [DATA_WIDTH-1:0]    s_axi_rdata,
	output reg                     s_axi_rvalid,
	output [1:0]                   s_axi_rresp,
	input                          s_axi_rready,

	// Write Address
	input  [ADDR_WIDTH-1:0]        s_axi_awaddr,
	input                          s_axi_awvalid,
	output                         s_axi_awready,

	// Write Data
	input  [DATA_WIDTH-1:0]        s_axi_wdata,
	input                          s_axi_wvalid,
	input  [DATA_WIDTH/8-1:0]      s_axi_wstrb,
	output                         s_axi_wready,

	// Write Response
	output [1:0]                   s_axi_bresp,
	output reg                     s_axi_bvalid,
	input                          s_axi_bready,

	output [DATA_WIDTH*REGISTER_COUNT-1:0] registers_cat
);

	localparam STRB_WIDTH = DATA_WIDTH/8;
	// Registers are DATA_WIDTH wide, so they sit on (DATA_WIDTH/8)-byte boundaries.
	// The low BYTE_BITS address bits select a byte inside a register and are dropped.
	localparam BYTE_BITS  = $clog2(STRB_WIDTH);

	reg [DATA_WIDTH-1:0] registers [REGISTER_COUNT-1:0];

	// Flatten the register array onto one output bus
	genvar j;
	generate
		for (j = 0; j < REGISTER_COUNT; j = j + 1) begin : g_cat
			assign registers_cat[j*DATA_WIDTH +: DATA_WIDTH] = registers[j];
		end
	endgenerate

	// No errors are reported, so the response channels are tied to OKAY.
	assign s_axi_bresp = 2'b00;
	assign s_axi_rresp = 2'b00;

	// ---------------------------------------------------------------
	// Write channel
	// AW and W are accepted together, only when no response is pending.
	// ---------------------------------------------------------------
	wire write_fire = s_axi_awvalid && s_axi_wvalid && !s_axi_bvalid;
	assign s_axi_awready = write_fire;
	assign s_axi_wready  = write_fire;

	wire [ADDR_WIDTH-1:0] wr_index = s_axi_awaddr >> BYTE_BITS;

	integer i, b;
	always @(posedge s_axi_clk) begin
		if (!s_axi_resetn) begin
			for (i = 0; i < REGISTER_COUNT; i = i + 1)
				registers[i] <= {DATA_WIDTH{1'b0}};
			s_axi_bvalid <= 1'b0;
		end else begin
			if (write_fire) begin
				// Out-of-range writes are silently ignored
				if (wr_index < REGISTER_COUNT) begin
					for (b = 0; b < STRB_WIDTH; b = b + 1)
						if (s_axi_wstrb[b])
							registers[wr_index][b*8 +: 8] <= s_axi_wdata[b*8 +: 8];
				end
				s_axi_bvalid <= 1'b1;
			end else if (s_axi_bvalid && s_axi_bready) begin
				s_axi_bvalid <= 1'b0;
			end
		end
	end

	// ---------------------------------------------------------------
	// Read channel
	// ---------------------------------------------------------------
	wire read_fire = s_axi_arvalid && !s_axi_rvalid;
	assign s_axi_arready = read_fire;

	wire [ADDR_WIDTH-1:0] rd_index = s_axi_araddr >> BYTE_BITS;

	always @(posedge s_axi_clk) begin
		if (!s_axi_resetn) begin
			s_axi_rvalid <= 1'b0;
			s_axi_rdata  <= {DATA_WIDTH{1'b0}};
		end else begin
			if (read_fire) begin
				// Out-of-range reads return 0
				s_axi_rdata  <= (rd_index < REGISTER_COUNT) ? registers[rd_index]
				                                            : {DATA_WIDTH{1'b0}};
				s_axi_rvalid <= 1'b1;
			end else if (s_axi_rvalid && s_axi_rready) begin
				s_axi_rvalid <= 1'b0;
			end
		end
	end

endmodule
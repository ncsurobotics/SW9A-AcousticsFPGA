`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2026 03:02:16 PM
// Design Name: 
// Module Name: uart_th_tb
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




module uart_th_tb();


logic[7:0] s_axis_uart_tdata;
logic s_axis_uart_tvalid;
logic clk, reset_n;

// Regmap logic
logic[31:0] fake_regmap[255:0];
logic[31:0] regmap_dout, regmap_din;
logic regmap_wea;
logic[7:0] regmap_addr;

always@(posedge clk)begin
	if(regmap_wea) fake_regmap[regmap_addr] = regmap_din;
	regmap_dout = fake_regmap[regmap_addr];
end

logic[15:0] axis_u2s_tdata;
logic[5:0] axis_u2s_tdest;
logic axis_u2s_tvalid;
logic axis_u2s_tready;
logic[7:0] axis_s2u_tdata;
logic axis_s2u_tvalid;
logic axis_s2u_tready;
logic axis_s2u_tlast;

logic[5:0] SPI_SCLK;
logic[5:0] SPI_CS_N;
logic[5:0] SPI_DI;
logic[5:0] SPI_SDO_DRDY;
// add dummy adc spi logic

logic SPI_mode; // 0 == drdy, 1 == data

always@(*)begin
	if(!SPI_CS_N && SPI_SCLK) SPI_mode = 1;
	if(SPI_CS_N) SPI_mode = 0;
	foreach(SPI_SDO_DRDY[i])begin
		if(!SPI_CS_N)begin
			if(SPI_mode) SPI_SDO_DRDY[i]= spi_hash[i];
			else SPI_SDO_DRDY[i] = 1;
		end else begin
			SPI_SDO_DRDY[i]=0;
		end
	end
end
	
logic[3:0] spi_counter[5:0];
logic spi_hash[5:0];

initial begin
foreach(spi_counter[i]) spi_counter[i] = i;
foreach(spi_hash[i])spi_hash[i] = 0;
end

always@(posedge clk)begin
	foreach(spi_counter[i]) spi_counter[i] =spi_counter[i]+1;
	foreach(spi_hash[i]) spi_hash[i] = ^spi_counter[i];
end	

ADC_SPI_BATCH #(
	.CHANNEL_COUNT(6), // number of hydrophones/channels
	.CONVERSION_FRAME_SIZE(256) // fft frame size
	) ADC_SPI_BATCH_inst(
	.clk(clk),
	.reset_n(reset_n),
	
	.SPI_clk(clk),
	.SPI_reset_n(reset_n),
	
	// From regmap
	.SPI_select(1),
	
	// To and From ADC (off chip)
	.SPI_SCLK(SPI_SCLK),
	.SPI_CS_N(SPI_CS_N),
	.SPI_DI(SPI_DI),
	.SPI_SDO_DRDY(SPI_SDO_DRDY),
	.SPI_START(SPI_START),
	
	// From UART
	.s_axis_tdata(axis_u2s_tdata),
	.s_axis_tdest(axis_u2s_tdest),
	.s_axis_tvalid(axis_u2s_tvalid),
	.s_axis_tready(axis_u2s_tready),
	
	// To UART
	.m_axis_reg_tdata(axis_s2u_tdata),
	.m_axis_reg_tvalid(axis_s2u_tvalid),
	.m_axis_reg_tready(axis_s2u_tready),
	.m_axis_reg_tlast(axis_s2u_tlast),
	
	// To DSP
	//.m_axis_conversion_tdata(m_axis_conversion_tdata),
	//.m_axis_conversion_tlast(m_axis_conversion_tlast),
	//.m_axis_conversion_tvalid(m_axis_conversion_tvalid),
	.m_axis_conversion_tready(6'b111111)
	);

logic[7:0] s_axis_spaced_tdata;
logic s_axis_spaced_tvalid;
logic s_axis_spaced_tready;

axis_spacer #(
	.DATA_WIDTH(8)
	) axis_spacer_inst(
	.clk(clk),
	.reset_n(reset_n),
	.s_axis_tdata(s_axis_uart_tdata),
	.s_axis_tvalid(s_axis_uart_tvalid),
	.s_axis_tready(s_axis_uart_tready),
	.m_axis_tdata(s_axis_spaced_tdata),
	.m_axis_tvalid(s_axis_spaced_tvalid),
	.m_axis_tready(s_axis_spaced_tready)
	);


UART_TRANSACTION_HANDLER_v2 UART_TRANSACTION_HANDLER_v2_inst(
	.s_axis_clk(clk),
	.s_axis_aresetn(reset_n),
	
	.s_axis_uart_tdata(s_axis_spaced_tdata),
	.s_axis_uart_tvalid(s_axis_spaced_tvalid),
	.s_axis_uart_tready(s_axis_spaced_tready),
	
	.m_axis_uart_tdata(),
	.m_axis_uart_tvalid(),
	.m_axis_uart_tready(1),
	
	.regmap_addr(regmap_addr),
	.regmap_din(regmap_din),
	.regmap_dout(regmap_dout),
	.regmap_wea(regmap_wea),
	
	.m_axis_spi_tdata(axis_u2s_tdata),
	.m_axis_spi_tdest(axis_u2s_tdest),
	.m_axis_spi_tvalid(axis_u2s_tvalid),
	.m_axis_spi_tready(axis_u2s_tready),
	
	.s_axis_spi_tdata(axis_s2u_tdata),
	.s_axis_spi_tvalid(axis_s2u_tvalid),
	.s_axis_spi_tlast(axis_s2u_tlast),
	.s_axis_spi_tready(axis_s2u_tready),
	
	.mem_addr(),
	.mem_din(),
	.mem_dout(),
	.mem_wea(),
	
	.max_angle({28'hABCDEF0,spi_counter[0]})
	);
	
	
always#5 clk = ~clk;

localparam COMMAND_LENGTH = 6;
localparam OP_GET = 8'h00;
localparam OP_R = 8'h40;
localparam OP_RS = 8'h50;
localparam OP_RM = 8'h60;
localparam OP_RX = 8'h70;
localparam OP_W = 8'h80;
localparam OP_WS = 8'h90;
localparam OP_WM = 8'hA0;
localparam OP_WX = 8'hB0;
			
	// Message format:
	// 	1 byte		[1 byte]  	[4 bytes]
	// 	Opcode		address		data
	
	// Opcodes:
	//	0x00	- 	Get Angle 								- 0 bytes
	// 	0x40	-	Read									- 1 bytes	- 8 bit address
	//	0x50	-	Read all SPI 							- 1 bytes	- 8 bit address
	//	0x60	-	Read Memory (separate from regmap)		- 2 bytes 	- 16 bit address
	// 	0x70	- 	Read ???								- 0 bytes 	- reserved for future implementation
	//	0x80	-	Write									- 5 bytes	- 8 bit address + 32 bit data
	//	0x90	-	Write all SPI							- 2 bytes	- 8 bit address + 8 bit data
	//	0xA0	-	Write Memory (separate from regmap)		- 6 bytes 	- 16 bit address + 32 bit data
	// 	0xB0	-	Write ???								- 0 bytes 	- reserved for future implementation
	

integer i;

task SendCommand(
    input [47:0] command,
    input [5:0]  valid
);
begin
@(posedge clk);
    $display("Sending command: %x, valid bits: %b",
             command, valid);

    for(i = 5; i >= 0; i = i - 1) begin
		
        if(valid[i]) begin
			$display("Starting word %d",i);
            s_axis_uart_tdata  = command[i*8 +: 8];
            s_axis_uart_tvalid = 1;
			$display(s_axis_uart_tdata);
			$display(s_axis_uart_tvalid);
            // Wait for handshake
            while(!s_axis_uart_tready)begin
                @(posedge clk);
				$display("Waiting for tready");
			end
            // Handshake occurs here
            @(posedge clk);

            s_axis_uart_tvalid = 0;
        end
    end
end
endtask

task GetAngle();
$display("Getting angle");
	SendCommand({OP_GET,42'h000000000000},6'b100000);
	
endtask

task Read(input [7:0] addr);
$display("Reading regmap address: %x",addr);
	SendCommand({OP_R,addr,32'h000000000000},6'b110000);
endtask

task ReadSPI(input [7:0] addr);
$display("Reading all SPI: %x",addr);
	SendCommand({OP_RS,addr,32'h00000000},6'b110000);
endtask

task Write(input [7:0] addr,input[31:0] data);
$display("Writing regmap addr: %x with %x",addr,data);
	SendCommand({OP_W,addr,data},6'b111111);
endtask

task WriteSPI(input [7:0] addr, input [7:0] data);
$display("Writing all SPI: %x with %x",addr,data);
	SendCommand({OP_WS,addr,data,24'h000000},6'b111000);
endtask

task TestRead();
	// Valid
	for(j = 0; j < REGMAP_MAX_ADDRESS; j++)begin
		#10 Read(j); // read sends the opcode to regmap addr and addr to regmap din
	end
	wait(s_axis_uart_tready);
	#500 $stop();
endtask

task TestSPIRead();
	// Valid
	for(j = 0; j < SPI_MAX_ADDRESS; j++)begin
		#10 ReadSPI(j);
	end
	wait(s_axis_uart_tready);
	#500 $stop();
	
endtask

task TestWrite();
	// Valid
	for(j = 0; j < REGMAP_MAX_ADDRESS; j++)begin
		#10 Write(j,{32'hABCDEF98});
	end	
	wait(s_axis_uart_tready);
	#500 $stop();
endtask

task TestSPIWrite();
	// Valid
	for(j = 0; j < SPI_MAX_ADDRESS; j++)begin
		#10 WriteSPI(j,{8'h37});
	end	
	wait(s_axis_uart_tready);
	#500 $stop();
endtask

task TestGetAngle();
	#50 GetAngle();
	#50 GetAngle();
	#50 GetAngle();
	#50 GetAngle();
	#50 GetAngle();
	#50 GetAngle();
	#50 GetAngle();
	#50 GetAngle();
	#500 $stop();
endtask


logic[7:0] j;

localparam REGMAP_MAX_ADDRESS = 16;
localparam SPI_MAX_ADDRESS = 16;

initial begin
	clk = 1;
	s_axis_uart_tvalid = 0;
	s_axis_uart_tdata = 0;
	reset_n = 0;
	j = 0;i = 0;
	foreach(fake_regmap[i])begin
		fake_regmap[i] = {24'hFEDCAB,i[7:0]};
	end
	
	#100 reset_n = 1;
	
	TestGetAngle();
	TestRead();
	TestSPIRead();
	TestWrite();
	TestSPIWrite();


end	
	
	

endmodule

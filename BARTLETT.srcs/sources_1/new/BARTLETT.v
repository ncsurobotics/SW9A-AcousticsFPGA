`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2025 12:18:44 PM
// Design Name: 
// Module Name: BARTLETT
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

module BARTLETT(
    input clk,
    input reset_b,
    input [255:0] x_s_axis_data_tdata,
    input x_s_axis_data_tvalid,
    output x_s_axis_data_tready,
    input x_s_axis_data_tlast,

    output [255:0] ifft_m_axis_data_tdata,
    output ifft_m_axis_data_tvalid,
    input ifft_m_axis_data_tready,
    output ifft_m_axis_data_tlast
    );

    //Instantiate the BARTLETT_DATAPATH module
    HILBERT_DATAPATH HILBERT_DATAPATH_inst (
        .clk(clk),
        .reset_b(reset_b),

        .x_s_axis_data_tdata(x_s_axis_data_tdata),
        .x_s_axis_data_tvalid(x_s_axis_data_tvalid),
        .x_s_axis_data_tlast(x_s_axis_data_tlast),
        .x_s_axis_data_tready(x_s_axis_data_tready),

        .ifft_m_axis_data_tdata(ifft_m_axis_data_tdata),
        .ifft_m_axis_data_tvalid(ifft_m_axis_data_tvalid),
        .ifft_m_axis_data_tready(ifft_m_axis_data_tready),
        .ifft_m_axis_data_tlast(ifft_m_axis_data_tlast)

    );

endmodule

module HILBERT_DATAPATH (
    input clk,
    input reset_b,

    //data from RAM
    input [255:0] x_s_axis_data_tdata,

    //flags from controller
    input x_s_axis_data_tvalid,
    input x_s_axis_data_tlast,

    //flag to controller
    output x_s_axis_data_tready,

    //outputs of IFFT
    output [255:0] ifft_m_axis_data_tdata,
    output ifft_m_axis_data_tvalid,
    input ifft_m_axis_data_tready,
    output ifft_m_axis_data_tlast

);
    //config parameters
    localparam [11:0] ZERO_PAD = 12'b0;
    //localparam [63:0] SCALE_SCHEDULE = 64'b0101010101010110_0101010101010110_0101010101010110_0101010101010110; //conservative (original)
    //localparam [63:0] SCALE_SCHEDULE = 64'b0000000000000000_0000000000000000_0000000000000000_0000000000000000;
    localparam [63:0] SCALE_SCHEDULE = 64'b0101010101010100_0101010101010100_0101010101010100_0101010101010100;
    localparam [3:0] FWD = 4'b1111;
    localparam [3:0] REV = 4'b0000;

    //config of FFT cores
    wire [79:0] ifft_s_axis_config_tdata, fft_s_axis_config_tdata;
    assign fft_s_axis_config_tdata = {ZERO_PAD, SCALE_SCHEDULE, FWD};       //tie to do regular FFT, SCALED
    assign ifft_s_axis_config_tdata = {ZERO_PAD, SCALE_SCHEDULE, REV};      //tie to do inverse FFT, SCALED
    //assign fft_s_axis_config_tdata = {ZERO_PAD, FWD};       //tie to do regular FFT, NONSCALED
    //assign ifft_s_axis_config_tdata = {ZERO_PAD, REV};      //tie to do inverse FFT, NONSCALED

    wire x_s_axis_config_tvalid, x_s_axis_config_tready;
    wire ifft_s_axis_config_tvalid, ifft_s_axis_config_tready;
    assign x_s_axis_config_tvalid = 1'b1;       //tie high to indicate valid config data
    assign ifft_s_axis_config_tvalid = 1'b1;    //tie high to indicate valid config data

    //interconnect between FFT and IFFT
    wire ifft_s_axis_data_tvalid, x_m_axis_data_tvalid;
    wire x_m_axis_data_tready, ifft_s_axis_data_tready;
    wire ifft_s_axis_data_tlast, x_m_axis_data_tlast;

    wire [255:0] ifft_s_axis_data_tdata, x_m_axis_data_tdata;

    //first FFT
    xfft_256pt_32bit xfft_inst(
    .aclk(clk),                                                 // input wire aclk
    .aresetn(reset_b),                                          // input wire aresetn
    .s_axis_config_tdata(       fft_s_axis_config_tdata),                  // input wire [23 : 0] s_axis_config_tdata
    .s_axis_config_tvalid(        x_s_axis_config_tvalid),                // input wire s_axis_config_tvalid
    .s_axis_config_tready(        x_s_axis_config_tready),                // output wire s_axis_config_tready

    .s_axis_data_tdata(           x_s_axis_data_tdata),                      // input wire [127 : 0] s_axis_data_tdata
    .s_axis_data_tvalid(          x_s_axis_data_tvalid),                      // input wire s_axis_data_tvalid
    .s_axis_data_tready(          x_s_axis_data_tready),                    // output wire s_axis_data_tready
    .s_axis_data_tlast(           x_s_axis_data_tlast),                      // input wire s_axis_data_tlast

    .m_axis_data_tdata(           x_m_axis_data_tdata),                      // output wire [31 : 0] m_axis_data_tdata
    .m_axis_data_tvalid(          x_m_axis_data_tvalid),                    // output wire m_axis_data_tvalid
    .m_axis_data_tready(          x_m_axis_data_tready),                    // input wire m_axis_data_tready
    .m_axis_data_tlast(           x_m_axis_data_tlast)                      // output wire m_axis_data_tlast
    //.event_fft_overflow(ovflo_fwd)                                     // Unused status channel
    );


    //Sets all frequency bins above 127 to zero
    DATA_CORRECTOR data_corrector_inst(
        .clk(clk),
        .reset_b(reset_b),
        //fft
        .x_m_axis_data_tvalid(x_m_axis_data_tvalid),
        .x_m_axis_data_tready(x_m_axis_data_tready),
        .x_m_axis_data_tlast(x_m_axis_data_tlast),
        
        //ifft
        .ifft_s_axis_data_tready(ifft_s_axis_data_tready),
        .ifft_s_axis_data_tvalid(ifft_s_axis_data_tvalid),
        .ifft_s_axis_data_tlast(ifft_s_axis_data_tlast),
        
        //data
        .data_in(x_m_axis_data_tdata),
        .data_out(ifft_s_axis_data_tdata)
    );

    //IFFT
    xfft_256pt_32bit inverse_xfft_inst(
    .aclk(clk),                                                 // input wire aclk
    .aresetn(reset_b),                                          // input wire aresetn
    .s_axis_config_tdata(         ifft_s_axis_config_tdata),                  // input wire [23 : 0] s_axis_config_tdata
    .s_axis_config_tvalid(        ifft_s_axis_config_tvalid),                // input wire s_axis_config_tvalid
    .s_axis_config_tready(        ifft_s_axis_config_tready),                // output wire s_axis_config_tready

    .s_axis_data_tdata(           ifft_s_axis_data_tdata),                      // input wire [127 : 0] s_axis_data_tdata
    .s_axis_data_tvalid(          ifft_s_axis_data_tvalid),                    // input wire s_axis_data_tvalid
    .s_axis_data_tready(          ifft_s_axis_data_tready),                    // output wire s_axis_data_tready
    .s_axis_data_tlast(           ifft_s_axis_data_tlast),                      // input wire s_axis_data_tlast

    .m_axis_data_tdata(           ifft_m_axis_data_tdata),                      // output wire [127 : 0] m_axis_data_tdata
    .m_axis_data_tvalid(          ifft_m_axis_data_tvalid),                    // output wire m_axis_data_tvalid
    .m_axis_data_tready(          ifft_m_axis_data_tready),                    // input wire m_axis_data_tready
    .m_axis_data_tlast(           ifft_m_axis_data_tlast)                      // output wire m_axis_data_tlast
    //.event_fft_overflow(ovflo_rev)                     // Unused status channel
    );

endmodule

//handles handshake between FFT and IFFT
module DATA_CORRECTOR(
    input clk,
    input reset_b,
    
    //fft
    input x_m_axis_data_tvalid,
    output x_m_axis_data_tready,
    input x_m_axis_data_tlast,
    

    //ifft
    input ifft_s_axis_data_tready,
    output ifft_s_axis_data_tvalid, 
    output ifft_s_axis_data_tlast,


    input [255:0] data_in,
    output [255:0] data_out
);
    reg valid, ready, last;

    reg [7:0] frequency_bin;

    reg [255:0] corrected_data;

    wire [255:0] data_2c;

// wtf is this gay shit
    always @(posedge clk or negedge reset_b) begin
        if(!reset_b) begin
            frequency_bin <= 8'h00;
            corrected_data <= 256'h0000000000000000000000000000000000000000000000000000000000000000;
            valid <= 1'b0;
            ready <= 1'b0;
            last <= 1'b0;
        end
        else if(x_m_axis_data_tvalid && ifft_s_axis_data_tready) begin
            frequency_bin <= frequency_bin + 1'b1;

            if (frequency_bin < 8'h80) begin
                corrected_data <= data_2c;
            end
            else corrected_data <= 256'h0000000000000000000000000000000000000000000000000000000000000000;
            
            valid <= x_m_axis_data_tvalid;
            ready <= ifft_s_axis_data_tready;
            last <= x_m_axis_data_tlast;            
        end
        else begin
            frequency_bin <= 8'h00;
            corrected_data <= 256'h0000000000000000000000000000000000000000000000000000000000000000;
            valid <= 1'b0;
            ready <= 1'b0;
            last <= 1'b0;            
        end
    end

    fixed_to_2c channel3(
        .data_in(data_in[255:192]),
        .data_out(data_2c[255:192])
    );
    fixed_to_2c channel2(
        .data_in(data_in[191:128]),
        .data_out(data_2c[191:128])
    );
    fixed_to_2c channel1(
        .data_in(data_in[127:64]),
        .data_out(data_2c[127:64])
    );
    fixed_to_2c channel0(
        .data_in(data_in[63:0]),
        .data_out(data_2c[63:0])
    );

    assign ifft_s_axis_data_tvalid = valid;
    assign x_m_axis_data_tready = ready;
    assign data_out = corrected_data;
    assign ifft_s_axis_data_tlast = last;

endmodule

module fixed_to_2c(
    input [63:0] data_in,
    output reg [63:0] data_out
);
always @(*) begin
    // Convert fixed-point to 2's complement
    // Check the sign bit (MSB)
    // If the sign bit is 0, keep the data as is
    // If the sign bit is 1, perform 2's complement
    
    case(data_in[63]) 
        1'b0: data_out[63:32] = data_in[63:32];
        1'b1: data_out[63:32] = {data_in[63], (~data_in[62:32] + 1'b1)};
        default: data_out[63:32] = 32'h00000000;
    endcase

    case(data_in[31]) 
        1'b0: data_out[31:0] = data_in[31:0];
        1'b1: data_out[31:0] = {data_in[31], (~data_in[30:0] + 1'b1)};
        default: data_out[31:0] = 32'h00000000;
    endcase
end


endmodule

`timescale 1ns / 1ps


module HILBERT_DATAPATH (
    input clk,
    input reset_b,

    //data from RAM
    input [127:0] x_s_axis_data_tdata,

    //flags from controller
    input x_s_axis_data_tvalid,
    input x_s_axis_data_tlast,

    //flag to controller
    output x_s_axis_data_tready,

    //outputs of IFFT
    output [127:0] ifft_m_axis_data_tdata,
    output ifft_m_axis_data_tvalid,
    input ifft_m_axis_data_tready,
    output ifft_m_axis_data_tlast

);
    //config parameters
    localparam [11:0] ZERO_PAD = 12'b0;
    localparam [63:0] SCALE_SCHEDULE = 64'b0101010101010110_0101010101010110_0101010101010110_0101010101010110;
    localparam [3:0] FWD = 4'b1111;
    localparam [3:0] REV = 4'b0000;

    //config of FFT cores
    wire [79:0] ifft_s_axis_config_tdata, fft_s_axis_config_tdata;
    assign fft_s_axis_config_tdata = {ZERO_PAD, SCALE_SCHEDULE, FWD};       //tie to do regular FFT
    assign ifft_s_axis_config_tdata = {ZERO_PAD, SCALE_SCHEDULE, REV};      //tie to do inverse FFT

    wire x_s_axis_config_tvalid, x_s_axis_config_tready;
    wire ifft_s_axis_config_tvalid, ifft_s_axis_config_tready;
    assign x_s_axis_config_tvalid = 1'b1;       //tie high to indicate valid config data
    assign ifft_s_axis_config_tvalid = 1'b1;    //tie high to indicate valid config data

    //interconnect between FFT and IFFT
    wire ifft_s_axis_data_tvalid, x_m_axis_data_tvalid;
    wire x_m_axis_data_tready, ifft_s_axis_data_tready;
    wire ifft_s_axis_data_tlast, x_m_axis_data_tlast;

    wire [127:0] ifft_s_axis_data_tdata, x_m_axis_data_tdata;




    //first FFT
    xfft_0 xfft_inst(
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
    //.m_axis_status_tready(        1'b1)                                     // Unused status channel
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
    xfft_0 inverse_xfft_inst(
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
    //.m_axis_status_tready(                          1'b1)                     // Unused status channel
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


    input [127:0] data_in,
    output [127:0] data_out
);
    reg valid, ready, last;

    reg [7:0] frequency_bin;

    reg [127:0] corrected_data;

// wtf is this gay shit
    always @(posedge clk or negedge reset_b) begin
        if (~reset_b) begin
            frequency_bin <= 8'h00;
            corrected_data <= 128'h00000000000000000000000000000000;
            valid <= 1'b0;
            ready <= 1'b0;
            last <= 1'b0;
        end else begin
            if (x_m_axis_data_tvalid && ifft_s_axis_data_tready) begin
                frequency_bin <= frequency_bin + 1'b1;

                if (frequency_bin < 8'h80) corrected_data <= data_in;
                
                else corrected_data <= 128'h00000000000000000000000000000000;
                
            end

            else begin
                frequency_bin <= 8'h00;
                corrected_data <= 128'h00000000000000000000000000000000;
            end
            
            valid <= x_m_axis_data_tvalid;
            ready <= ifft_s_axis_data_tready;
            last <= x_m_axis_data_tlast;
        end
    end

    assign ifft_s_axis_data_tvalid = valid;
    assign x_m_axis_data_tready = ready;
    assign data_out = corrected_data;
    assign ifft_s_axis_data_tlast = last;

endmodule

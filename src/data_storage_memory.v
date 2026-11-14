`timescale 1ns/1ps

module data_storage_memory #(
  // If changing these, change FIFO width in the FIFO IP too
  parameter POWER_WIDTH = 32,
  parameter ANGLE_WIDTH = 16
)(
  input clk,
  input reset_n,            // Asynchronous reset

  input dsm_capture,        // Register that triggers the capture of data from barlett datapath
  output dsm_capture_clr,   // Clears dsm_capture
  input dsm_dump,           // Register that triggers the dump of data to UART transaction handler
  output dsm_dump_clr,      // Clears dsm_dump

  // From bartlett datapath
  input [POWER_WIDTH-1:0] s_axis_bartlett_tdata,          // power data
  input  s_axis_bartlett_tvalid,
  output s_axis_bartlett_tready,
  input  s_axis_bartlett_tlast,
  input [ANGLE_WIDTH-1:0] s_axis_bartlett_tuser,          // angle data

  // To UART transaction handler
  output reg [POWER_WIDTH+ANGLE_WIDTH-1:0] m_axis_dsm_tdata,  // Packed as 32 bits power data, 16 bits angle data
  output  m_axis_dsm_tvalid,
  input   m_axis_dsm_tready,
  output  m_axis_dsm_tlast,

  output fifo_overflow   // For debugging, if this is ever asserted it means that the FIFO depth is too small
);


  // DSM can clear dsm_capture and dsm_dump registers but they are set by a write externally
  // It clears them by asserting the corresponding clr signal
  // DSM will store one frame of data from bartlett, and then it will not store anything else until that frame has been fully read out


  localparam S_WAIT_STORE=0, S_STORE=1, S_WAIT_DUMP=2, S_DUMP=3;
  reg [1:0] state;
  
  reg bartlett_frame_mid;           // Whether in the middle of a frame
  wire bartlett_next_bw_frames;     // Whether we won't be in the middle of a frame next cycle
  wire bartlett_valid_last;         // Last beat in the bartlett frame

  wire out_load;                    // Read from FIFO to dsm_tdata

  wire fifo_rst;
  wire [POWER_WIDTH+ANGLE_WIDTH-1:0] fifo_din, fifo_dout;
  wire fifo_wr_en, fifo_rd_en;
  wire fifo_full, fifo_empty;

  assign bartlett_next_bw_frames = s_axis_bartlett_tvalid ? s_axis_bartlett_tlast : ~bartlett_frame_mid;
  assign bartlett_valid_last = s_axis_bartlett_tvalid & s_axis_bartlett_tlast;

  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      bartlett_frame_mid <= 0;
    end
    else if (s_axis_bartlett_tvalid) begin
      bartlett_frame_mid <= s_axis_bartlett_tlast ? 0 : 1;
    end
  end

  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      state <= S_WAIT_STORE;
    end
    else begin
      case (state)
        S_WAIT_STORE: begin
          if (dsm_capture & bartlett_next_bw_frames) begin
            state <= S_STORE;
          end
        end
        S_STORE: begin
          if (bartlett_valid_last) begin
            state <= dsm_dump ? S_DUMP : S_WAIT_DUMP;
          end
        end
        S_WAIT_DUMP: begin
          if (dsm_dump) begin
            state <= S_DUMP;
          end
        end
        S_DUMP: begin
          if (fifo_empty & m_axis_dsm_tready) begin
            state <= (dsm_capture & bartlett_next_bw_frames) ? S_STORE : S_WAIT_STORE;
          end
        end
      endcase
    end
  end

  assign out_load = ((state == S_STORE) & bartlett_valid_last) | ((state == S_DUMP)  & m_axis_dsm_tready);

  always @(posedge clk) begin
    if (out_load) begin
      m_axis_dsm_tdata <= fifo_dout;
    end
  end

  assign s_axis_bartlett_tready = 1;  // Bartlett output is non-blocking so tready kept high to avoid confusion

  assign m_axis_dsm_tvalid = (state == S_DUMP);
  assign m_axis_dsm_tlast = fifo_empty;

  assign dsm_capture_clr = (state == S_STORE) & bartlett_valid_last;
  assign dsm_dump_clr = (state == S_DUMP) & fifo_empty & m_axis_dsm_tready;

  assign fifo_rst = ~reset_n;
  assign fifo_wr_en = (state == S_STORE) & s_axis_bartlett_tvalid;
  assign fifo_rd_en = out_load & ~fifo_empty;
  assign fifo_din = {s_axis_bartlett_tdata, s_axis_bartlett_tuser};

  fifo_generator_0 FIFO_DSM (
  .clk(clk),                 // input wire clk
  .rst(fifo_rst),            // input wire rst
  .din(fifo_din),            // input wire [47 : 0] din
  .wr_en(fifo_wr_en),        // input wire wr_en
  .rd_en(fifo_rd_en),        // input wire rd_en
  .dout(fifo_dout),          // output wire [47 : 0] dout
  .full(fifo_full),          // output wire full
  .overflow(fifo_overflow),  // output wire overflow
  .empty(fifo_empty)         // output wire empty
);


endmodule

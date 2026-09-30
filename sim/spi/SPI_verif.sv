interface axis_if #(
  parameter int DATA_WIDTH = 16,
  parameter int DEST_WIDTH = 1
)(
  input logic clk,
  input logic reset_n
);

  localparam DEST_W = (DEST_WIDTH > 0) ? DEST_WIDTH : 1;
  localparam ID_W = (ID_WIDTH > 0) ? ID_WIDTH : 1;

  logic                     tvalid;
  logic                     tready;
  logic [DATA_WIDTH-1:0]    tdata;
  logic                     tlast;
  logic [DEST_W-1:0]        tdest;
  logic                     tid;

  modport master (input tready, output tvalid, tdata, tlast, tdest, tid);
  modport slave (input tvalid, tdata, tlast, tdest, tid, output tready);
  
  clocking cb_master @(posedge clk);
    default input #1step output #1;
    input tready;
    output tvalid, tdata, tlast, tdest, tid;
  endclocking

  clocking cb_slave @(posedge clk);
    default input #1step output #1;
    input tvalid, tdata, tlast, tdest, tid;
    output tready;
  endclocking

  modport tb_master (clocking cb_master);
  modport tb_slave (clocking cb_slave);

endinterface

interface adc_spi_if ();
  logic CS;
  logic SCLK;
  logic SDO_DRDY;
  logic SDI;
  logic START;

  bit mode16 = 0; // For use in testbench... 0: 24-bit mode, 1: 16-bit mode

  // DUT
  modport dut (input SDO_DRDY, output CS, SCLK, SDI, START);

endinterface


class axis_packet #(
  parameter int DATA_WIDTH = 16,
  parameter int DEST_WIDTH = 1,
  parameter int LAST_VEC_WIDTH = 1
);

  localparam DEST_W = (DEST_WIDTH > 0) ? DEST_WIDTH : 1;

  rand bit [DATA_WIDTH-1:0] data;
  rand bit [DEST_W-1:0]     dest;
  bit [LAST_VEC_WIDTH-1:0]  last_vec; // vector of returned tlast in order
  bit                       id;

  rand int                  delay;

  constraint delay_c { delay dist {0 := 50, [1:3] :/ 50}; }
  constraint opcode_rw_c { data[DATA_WIDTH-1 -: 2] inside {2'b01, 2'b10}; }

  function bit is_cmnd_wr();
    return (data[DATA_WIDTH-1 -: 2] == 2'b10);
  endfunction

  function void print();
    $display("[t:%0t] data=0x%0h dest=0x%0h last_vec=0x%0h id=0x%0h", $time, data, dest, last_vec, id);
  endfunction
endclass


class spi_packet;
  rand bit [23:0]  out_data;
  bit      [23:0]  in_data;
  // rand bit         drdy;
  string           op_str; // "conv", "read", "write", "unknown"

  function void print ();
    $display("[t:%0t] out_data=0x%0h in_data=0x%0h op_str=%s", $time, out_data, in_data, op_str);
  endfunction
endclass


class spi_driver;
  virtual adc_spi_if vif;
  mailbox #(spi_packet) drv_mbx;

  task run();
    
    forever begin
      spi_packet packet;
      int bits_per_frame;

      @(negedge vif.CS);
      if (!drv_mbx.try_get(packet)) begin
        // If the mailbox is empty by accident
        $warning("[t:%0t] SPI driver mailbox empty during start of frame", $time);
        packet = new();
        packet.out_data = 0;
      end
      bits_per_frame = vif.mode16 ? 16 : 24;

      vif.SDO_DRDY <= 1; // always DRDY=1 (for now)
        
      fork begin  
        fork
          for (int i = bits_per_frame-1; i >= 0; --i) begin
            @(posedge vif.SCLK) vif.SDO_DRDY <= packet.out_data[i];
          end
        join_none
        @(posedge vif.CS);
        disable fork;
      end join

      vif.SDO_DRDY <= 1'bz;
    end

  endtask

endclass


class spi_monitor;
  virtual adc_spi_if vif;
  mailbox #(spi_packet) scb_mbx;

  task run();

    forever begin
      spi_packet packet = new();
      int bits_per_frame;
      bit frame_done = 0;
      
      @(negedge vif.CS);
      bits_per_frame = vif.mode16 ? 16 : 24;

      // Get DRDY here after a delay (not implemented yet)

      fork begin
        fork
          begin
            for (int i = bits_per_frame-1; i >= 0; --i) begin
              @(negedge vif.SCLK) 
              packet.in_data[i] = vif.SDI;
              packet.out_data[i] = vif.SDO_DRDY;
            end
            frame_done = 1;
          end
        join_none
        @(posedge vif.CS);
        disable fork;
      end join

      if (!frame_done) begin
        $error("[t:%0t] CS pulled up before SPI frame complete", $time);
        continue;
      end

      if (!vif.mode16 && (packet.in_data[15:7] == {8'h86, 1'b1})) begin
        vif.mode16 = 1;
      end

      case (packet.in_data[15:14])
        2'b00: packet.op_str = "conv";
        2'b01: packet.op_str = "read";
        2'b10: packet.op_str = "write";
        default: packet.op_str = "unknown";
      endcase
      scb_mbx.put(packet);
    end

  endtask
  
endclass

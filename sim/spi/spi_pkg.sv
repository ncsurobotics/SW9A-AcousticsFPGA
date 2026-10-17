interface adc_spi_if ();
  logic CS;
  logic SCLK;
  logic SDO_DRDY;
  logic SDI;
  logic START;

  bit mode16 = 0; // For use in testbench... 0: 24-bit mode, 1: 16-bit mode
endinterface


package spi_pkg;

  class spi_packet;
    rand bit [23:0]  out_data;
    bit      [23:0]  in_data;
    // rand bit         drdy;
    string           op_str; // "conv", "read", "write", "unknown"

    function void print();
      $display("[t:%0t] out_data=0x%0h in_data=0x%0h op_str=%s", $time, out_data, in_data, op_str);
    endfunction
  endclass


  class spi_driver;
    virtual adc_spi_if vif;
    mailbox #(spi_packet) drv_mbx;

    function new(virtual adc_spi_if vif, mailbox #(spi_packet) drv_mbx);
      this.vif = vif;
      this.drv_mbx = drv_mbx;
    endfunction

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

    function new(virtual adc_spi_if vif, mailbox #(spi_packet) scb_mbx);
      this.vif = vif;
      this.scb_mbx = scb_mbx;
    endfunction

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


  class spi_generator;
    mailbox #(spi_packet) drv_mbx;
    
    function new(mailbox #(spi_packet) drv_mbx);
      this.drv_mbx = drv_mbx;
    endfunction

    task send_random(int num_items);
      spi_packet packet;
      repeat(num_items) begin
        packet = new();
        packet.randomize();
        drv_mbx.put(); // Blocks if mailbox is not empty yet
      end
    endtask

    // Send a specific data in to the module instead of randomizing
    task send_data(bit [23:0] adc_data);
      spi_packet packet = new();
      packet.out_data = adc_data;
      drv_mbx.put();
    endtask
  endclass


  class spi_agent;
    virtual adc_spi_if vif;
    mailbox #(spi_packet) drv_mbx;
    mailbox #(spi_packet) scb_mbx;

    spi_generator gen;
    spi_driver drv;
    spi_monitor mon;

    function new(virtual adc_spi_if vif, mailbox #(spi_packet) scb_mbx);
      this.vif = vif;
      this.scb_mbx = scb_mbx;

      drv_mbx = new(1); // Bounded mailbox

      gen = new(drv_mbx);
      drv = new(vif, drv_mbx);
      mon = new(vif, scb_mbx);
    endfunction

    task send_random(int num_items);
      gen.send_random(num_items);
    endtask

    task send_data(bit [23:0] adc_data);
      gen.send_data(adc_data);
    endtask
  endclass

endpackage

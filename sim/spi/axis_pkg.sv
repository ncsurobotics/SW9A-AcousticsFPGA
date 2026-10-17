`timescale 1ns/1ps

interface axis_if (input logic clk, input logic reset_n);
  import axis_defs_pkg::*;
 
  wire                       tvalid;
  wire                       tready;
  wire                       tlast;
  wire [AXIS_MAX_DATA_W-1:0] tdata;
  wire [AXIS_MAX_USER_W-1:0] tuser;
  wire [AXIS_MAX_ID_W-1:0]   tid;
 
  // TB drives tvalid/tdata/... (TB acts as AXIS master, DUT is the sink)
  clocking cb_master @(posedge clk);
    default input #1step output #1;
    input  tready;
    output tvalid, tdata, tlast, tuser, tid;
  endclocking
 
  // TB drives tready (TB acts as AXIS slave, DUT is the source)
  clocking cb_slave @(posedge clk);
    default input #1step output #1;
    input  tvalid, tdata, tlast, tuser, tid;
    output tready;
  endclocking
 
  // Passive observation, works for either role
  clocking cb_mon @(posedge clk);
    default input #1step;
    input tvalid, tready, tdata, tlast, tuser, tid;
  endclocking
endinterface




package axis_pkg;
  import axis_defs_pkg::*;

  typedef enum { AXIS_MASTER, AXIS_SLAVE } axis_role_e;
 
  // Configuration for the specific AXIS agent
  class axis_cfg;
    string       name       = "axis"; // identifying name for the agent     
    axis_role_e  role       = AXIS_MASTER;
    int unsigned data_width = 16;
    int unsigned user_width = 0;     // 0 = no tuser
    int unsigned id_width   = 0;     // 0 = no tid
    bit          has_tlast  = 0;     // 0 = tlast not used on this bus
    bit          check_x    = 1;     // monitor X/Z checks
    int unsigned ready_pct  = 100;   // slave only: % of cycles tready is high
 
    function new(
      string name = "axis",
      axis_role_e role = AXIS_MASTER,
      int unsigned data_width = 16
    );
      this.name       = name;
      this.role       = role;
      this.data_width = data_width;
    endfunction
 
    function axis_data_t data_mask();
      return ~({AXIS_MAX_DATA_W{1'b1}} << data_width);
    endfunction
    function axis_user_t user_mask();
      return ~({AXIS_MAX_USER_W{1'b1}} << user_width);
    endfunction
    function axis_id_t id_mask();
      return ~({AXIS_MAX_ID_W{1'b1}} << id_width);
    endfunction
  endclass
 
 
  // -------------------------------------------------------------------
  // Beat: one accepted transfer (tvalid && tready)
  // `last` is NOT randomized: the monitor fills it in; as a master it
  // stays 0 unless a DUT-specific test sets it explicitly.
  // -------------------------------------------------------------------
  class axis_beat;
    rand axis_data_t  data;
    rand axis_user_t  user;
    rand axis_id_t    id;
    rand int unsigned delay;       // idle cycles before this beat (driver only)
    bit               last = 0;
    time              timestamp;   // set by the monitor
 
    constraint delay_c { delay dist {0 := 50, [1:3] :/ 50}; }
 
    // Subclasses override clone() so the generator produces the right type.
    virtual function axis_beat clone();
      axis_beat b = new();
      b.copy_from(this);
      return b;
    endfunction
 
    virtual function void copy_from(axis_beat o);
      data = o.data;  user = o.user;  id = o.id;  last = o.last;
      delay = o.delay;  timestamp = o.timestamp;
    endfunction
 
    function string convert2string();
      return $sformatf("data=0x%0h user=0x%0h id=0x%0h last=%0b", data, user, id, last);
    endfunction
  endclass
 
 
  // Generator: clones a prototype beat and randomizes it
  class axis_generator;
    axis_cfg  cfg;
    axis_beat proto;   // swap with a DUT-specific subclass instance
 
    function new(axis_cfg cfg);
      this.cfg = cfg;
      proto    = new();
    endfunction
 
    function axis_beat new_beat();   // cloned, NOT randomized
      return proto.clone();
    endfunction
 
    function axis_beat next();       // cloned and randomized
      axis_beat b = new_beat();
      if (!b.randomize()) $fatal(1, "[%s] beat randomize failed", cfg.name);
      return b;
    endfunction
  endclass
 
 
  // -------------------------------------------------------------------
  // Master driver: drives tvalid/tdata/... from beats in a mailbox.
  // tvalid never depends on tready (AXI rule).
  // -------------------------------------------------------------------
  class axis_master_driver;
    virtual axis_if       vif;
    axis_cfg              cfg;
    mailbox #(axis_beat)  mbx;
    int unsigned          beats_done = 0;
 
    function new(virtual axis_if vif, axis_cfg cfg, mailbox #(axis_beat) mbx);
      this.vif = vif;
      this.cfg = cfg;
      this.mbx = mbx;
    endfunction
 
    task idle();
      vif.cb_master.tvalid <= 1'b0;
      vif.cb_master.tlast  <= 1'b0;
      vif.cb_master.tdata  <= '0;
      vif.cb_master.tuser  <= '0;
      vif.cb_master.tid    <= '0;
    endtask
 
    task run();
      axis_beat b;
      idle();
      wait (vif.reset_n === 1'b1);
      @(vif.cb_master);
      forever begin
        // try_get keeps queued beats gapless; if the mailbox is empty we
        // go idle, block, then re-align to the clock edge.
        if (!mbx.try_get(b)) begin
          idle();
          mbx.get(b);
          @(vif.cb_master);
        end
        drive_beat(b);
        beats_done++;
      end
    endtask
 
    task drive_beat(axis_beat b);
      if (b.delay > 0) begin
        idle();
        repeat (b.delay) @(vif.cb_master);
      end
 
      vif.cb_master.tvalid <= 1'b1;
      vif.cb_master.tdata  <= b.data & cfg.data_mask();
      vif.cb_master.tuser  <= b.user & cfg.user_mask();
      vif.cb_master.tid    <= b.id   & cfg.id_mask();
      vif.cb_master.tlast  <= cfg.has_tlast && b.last;
 
      // beat is accepted on the first edge where tready is high
      do @(vif.cb_master); while (vif.cb_master.tready !== 1'b1);
    endtask
  endclass
 
 
  // -------------------------------------------------------------------
  // Slave driver: drives tready according to cfg.ready_pct
  // -------------------------------------------------------------------
  class axis_slave_driver;
    virtual axis_if vif;
    axis_cfg        cfg;
    bit             enabled = 1;   // set to 0 to hold tready low
 
    function new(virtual axis_if vif, axis_cfg cfg);
      this.vif = vif;
      this.cfg = cfg;
    endfunction
 
    task run();
      vif.cb_slave.tready <= 1'b0;
      wait (vif.reset_n === 1'b1);
      forever begin
        @(vif.cb_slave);
        vif.cb_slave.tready <= enabled && ($urandom_range(99) < cfg.ready_pct);
      end
    endtask
  endclass
 
 
  // -------------------------------------------------------------------
  // Monitor: same for both roles. Publishes every accepted beat.
  // -------------------------------------------------------------------
  class axis_monitor;
    virtual axis_if       vif;
    axis_cfg              cfg;
    mailbox #(axis_beat)  subs[$];
    int unsigned          beats_seen = 0;
 
    function new(virtual axis_if vif, axis_cfg cfg);
      this.vif = vif;
      this.cfg = cfg;
    endfunction
 
    function void add_subscriber(mailbox #(axis_beat) m);
      subs.push_back(m);
    endfunction
 
    function void publish(axis_beat b);
      beats_seen++;
      foreach (subs[i]) subs[i].put(b.clone());   // clone so subscribers can't interfere
    endfunction
 
    // Control signals: every cycle after reset.
    // Payload: only while tvalid, and only the bits that exist on this
    // bus (the rest of the max-width interface floats).
    function void check_x();
      if ($isunknown(vif.cb_mon.tvalid) || $isunknown(vif.cb_mon.tready))
        $error("[%s] X/Z on tvalid/tready", cfg.name);
      if (vif.cb_mon.tvalid === 1'b1) begin
        if ($isunknown(vif.cb_mon.tdata & cfg.data_mask()))
          $error("[%s] X/Z on tdata", cfg.name);
        if ($isunknown(vif.cb_mon.tuser & cfg.user_mask()))
          $error("[%s] X/Z on tuser", cfg.name);
        if ($isunknown(vif.cb_mon.tid & cfg.id_mask()))
          $error("[%s] X/Z on tid", cfg.name);
        if (cfg.has_tlast && $isunknown(vif.cb_mon.tlast))
          $error("[%s] X/Z on tlast", cfg.name);
      end
    endfunction
 
    task run();
      bit prev_stall = 0;
      wait (vif.reset_n === 1'b1);
      forever begin
        @(vif.cb_mon);
 
        if (cfg.check_x) check_x();
 
        // protocol check: tvalid must stay high until tready
        if (prev_stall && vif.cb_mon.tvalid !== 1'b1)
          $error("[%s] tvalid dropped before tready", cfg.name);
        prev_stall = (vif.cb_mon.tvalid === 1'b1) && (vif.cb_mon.tready !== 1'b1);
 
        if (vif.cb_mon.tvalid === 1'b1 && vif.cb_mon.tready === 1'b1) begin
          axis_beat b = new();
          b.timestamp = $time;
          b.data = vif.cb_mon.tdata & cfg.data_mask();
          b.user = vif.cb_mon.tuser & cfg.user_mask();
          b.id   = vif.cb_mon.tid   & cfg.id_mask();
          b.last = cfg.has_tlast && (vif.cb_mon.tlast === 1'b1);
          publish(b);
        end
      end
    endtask
  endclass
 
 
  // -------------------------------------------------------------------
  // Agent: the object tests/env interact with
  // -------------------------------------------------------------------
  class axis_agent;
    axis_cfg           cfg;
    virtual axis_if    vif;
    axis_generator     gen;
    axis_monitor       mon;
    axis_master_driver mdrv;   // null when role == SLAVE
    axis_slave_driver  sdrv;   // null when role == MASTER
 
    mailbox #(axis_beat) drv_mbx = new();   // beats waiting to be driven
    mailbox #(axis_beat) rx_mbx  = new();   // beats seen (slave role)
    int unsigned         queued  = 0;
 
    function new(axis_cfg cfg, virtual axis_if vif);
      this.cfg = cfg;
      this.vif = vif;
      gen = new(cfg);
      mon = new(vif, cfg);
      if (cfg.role == AXIS_MASTER) begin
        mdrv = new(vif, cfg, drv_mbx);
      end else begin
        sdrv = new(vif, cfg);
        mon.add_subscriber(rx_mbx);   // slave agent keeps what it receives
      end
    endfunction
 
    // Call once from the env; spawns the background processes
    virtual task start();
      fork
        if (mdrv != null) mdrv.run();
        if (sdrv != null) sdrv.run();
        mon.run();
      join_none
    endtask
 
    function void check_role(axis_role_e r, string api);
      if (cfg.role != r)
        $fatal(1, "[%s] %s() is only valid on a %s agent", cfg.name, api, r.name());
    endfunction
 
    function void add_subscriber(mailbox #(axis_beat) m);
      mon.add_subscriber(m);   // scoreboard / coverage hook
    endfunction
 
    // ---------------- master-side API ----------------
    function axis_beat new_beat();   // for randomize() with {...}
      return gen.new_beat();
    endfunction
 
    function void send_beat(axis_beat b);   // non-blocking: queue it
      check_role(AXIS_MASTER, "send_beat");
      queued++;
      drv_mbx.put(b);
    endfunction
 
    task send_beat_blocking(axis_beat b);   // returns after the beat is accepted
      int unsigned target;
      send_beat(b);
      target = queued;
      wait (mdrv.beats_done >= target);
    endtask
 
    task send_word(axis_data_t w, bit blocking = 0);
      axis_beat b = new();
      b.data = w;
      if (blocking) send_beat_blocking(b);
      else          send_beat(b);
    endtask
 
    task send_random(int unsigned n, bit blocking = 0);
      repeat (n) send_beat(gen.next());
      if (blocking) wait_idle();
    endtask
 
    task wait_idle();
      check_role(AXIS_MASTER, "wait_idle");
      wait (mdrv.beats_done == queued);
    endtask
 
    // ---------------- slave-side API ----------------
    task get_beat(output axis_beat b);   // blocks until a beat arrives
      check_role(AXIS_SLAVE, "get_beat");
      rx_mbx.get(b);
    endtask
 
    function bit try_get_beat(output axis_beat b);
      check_role(AXIS_SLAVE, "try_get_beat");
      return (rx_mbx.try_get(b) > 0);
    endfunction
 
    function int rx_pending();
      return rx_mbx.num();
    endfunction
 
    function void set_ready_pct(int unsigned pct);   // backpressure knob
      check_role(AXIS_SLAVE, "set_ready_pct");
      cfg.ready_pct = pct;
    endfunction
 
    function void set_ready_enable(bit en);
      check_role(AXIS_SLAVE, "set_ready_enable");
      sdrv.enabled = en;
    endfunction
  endclass




endpackage

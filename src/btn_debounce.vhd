library ieee;
use ieee.std_logic_1164.all;
library xpm;
use xpm.vcomponents.all;

-- Synchronize a button with a clock and debounce
-- Can also generate a one cycle pulse on the needed edge of the debounced signal

entity btn_debounce is
  generic (
    G_STABLE_CYCLES : positive             := 1000000; -- No. of cycles button has to be stable
    G_PULSE_ENABLED : boolean              := false;   -- Optional: 1 cycle pulse on specified edge of debounced signal
    G_PULSE_EDGE    : natural range 0 to 2 := 2        -- 0:Pulse at rising edge, 1:Falling edge, 2:Both edges
  );
  port (
    clk       : in std_logic;
    btn_async : in std_logic;
    btn_dbncd : out std_logic; -- debounced level of the button
    btn_pulse : out std_logic  -- pulse on edge/s of debounced button
  );
end entity btn_debounce;
architecture rtl of btn_debounce is

  signal btn_dbncd_r    : std_logic := '0';
  signal btn_sync_r     : std_logic;
  signal btn_prev_r     : std_logic                          := '0';
  signal stable_count_r : natural range 0 to G_STABLE_CYCLES := 0;

begin

  -- xpm_cdc_single: Single-bit Synchronizer
  -- Xilinx Parameterized Macro, version 2022.2
  xpm_cdc_single_inst : xpm_cdc_single
  generic map(
    DEST_SYNC_FF   => 2, -- DECIMAL; range: 2-10
    INIT_SYNC_FF   => 0, -- DECIMAL; 0=disable simulation init values, 1=enable simulation init values
    SIM_ASSERT_CHK => 0, -- DECIMAL; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 0  -- DECIMAL; 0=do not register input, 1=register input
  )
  port map
  (
    dest_out => btn_sync_r, -- 1-bit output: src_in synchronized to the destination clock domain. This output is registered.
    dest_clk => clk,        -- 1-bit input: Clock signal for the destination clock domain.
    src_clk  => '0',        -- 1-bit input: optional; required when SRC_INPUT_REG = 1
    src_in   => btn_async   -- 1-bit input: Input signal to be synchronized to dest_clk domain.
  );
  -- End of xpm_cdc_single_inst instantiation

  p_debounce : process (clk) begin
    if rising_edge(clk) then
      btn_prev_r <= btn_dbncd_r;

      if btn_sync_r = btn_dbncd_r then
        stable_count_r <= 0;
      else
        if stable_count_r >= G_STABLE_CYCLES then
          stable_count_r <= 0;
          btn_dbncd_r    <= btn_sync_r;
        else
          stable_count_r <= stable_count_r + 1;
        end if;
      end if;

    end if;
  end process p_debounce;

  btn_dbncd <= btn_dbncd_r;

  g_pulse : if G_PULSE_ENABLED generate
    g_rise_pulse : if G_PULSE_EDGE = 0 generate
      btn_pulse <= btn_dbncd_r and not btn_prev_r;
    end generate g_rise_pulse;

    g_fall_pulse : if G_PULSE_EDGE = 1 generate
      btn_pulse <= not btn_dbncd_r and btn_prev_r;
    end generate g_fall_pulse;

    g_both_pulse : if G_PULSE_EDGE = 2 generate
      btn_pulse <= btn_dbncd_r xor btn_prev_r;
    end generate g_both_pulse;
  end generate g_pulse;

  g_no_pulse : if not G_PULSE_ENABLED generate
    btn_pulse <= '0';
  end generate g_no_pulse;

end architecture rtl;

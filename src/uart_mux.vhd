library ieee;
use ieee.std_logic_1164.all;

entity uart_mux is
  port (
    clk : in std_logic;
    swap : in std_logic;         -- 1 cycle pulse switches the channels
    status_led : out std_logic;

    -- Directions are from the outside's point of view
    -- With main design
    core_uart_rx : out std_logic; -- Data to main design
    core_uart_tx : in std_logic;  -- Data from main design

    -- With MCU
    mcu_uart_rx : out std_logic; -- Data to microcontroller
    mcu_uart_tx : in std_logic;  -- Data from microcontroller

    -- With USB
    usb_uart_rx : out std_logic; -- Data to USB
    usb_uart_tx : in std_logic   -- Data from USB
  );
end entity;

architecture rtl of uart_mux is
  type state_t is (S_MCU, S_USB);
  signal state_r : state_t := S_MCU;
begin

  p_state : process (clk) begin
    if rising_edge(clk) then
      if swap = '1' then
        if state_r = S_MCU then
          state_r <= S_USB;
        else
          state_r <= S_MCU;
        end if;
      end if;
    end if;
  end process p_state;

  core_uart_rx <= mcu_uart_tx when (state_r = S_MCU) else
    usb_uart_tx;

  -- UART idle is high
  mcu_uart_rx <= core_uart_tx when (state_r = S_MCU) else '1';
  usb_uart_rx <= core_uart_tx when (state_r = S_USB) else '1';

  status_led <= '1' when state_r = S_USB else '0';

end architecture;
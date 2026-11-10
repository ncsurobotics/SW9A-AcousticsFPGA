-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Mon Oct 26 20:34:32 2026
-- Host        : JokeJet running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim {c:/Users/Praneeth
--               Satishkumar/eda/designs/riscv32-sky130-asic/SW9A-AcousticsFPGA/SW9A-AcousticsFPGA.gen/sources_1/bd/design_2/ip/design_2_UART_TRANSACTION_HAN_0_0/design_2_UART_TRANSACTION_HAN_0_0_sim_netlist.vhdl}
-- Design      : design_2_UART_TRANSACTION_HAN_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_UART_TRANSACTION_HAN_0_0_UART_RX_DECODER is
  port (
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    uart_addr_reg_0 : out STD_LOGIC;
    \SIPO_reg[0][7]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \SIPO_reg[0][6]_0\ : out STD_LOGIC;
    \SIPO_reg[0][6]_1\ : out STD_LOGIC;
    reset_n_0 : out STD_LOGIC;
    \SIPO_reg[0][5]_0\ : out STD_LOGIC_VECTOR ( 5 downto 0 );
    \SIPO_reg[1][7]_0\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 4 downto 0 );
    \FSM_onehot_state_reg[0]\ : in STD_LOGIC;
    \FSM_onehot_state_reg[0]_0\ : in STD_LOGIC;
    \FSM_onehot_state_reg[0]_1\ : in STD_LOGIC;
    rx_ready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    \tx_data_in_reg[0]\ : in STD_LOGIC;
    rx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    w_done : in STD_LOGIC;
    w_done_reg : in STD_LOGIC;
    aw_done : in STD_LOGIC;
    aw_done_reg : in STD_LOGIC;
    reset_n : in STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_2_UART_TRANSACTION_HAN_0_0_UART_RX_DECODER : entity is "UART_RX_DECODER";
end design_2_UART_TRANSACTION_HAN_0_0_UART_RX_DECODER;

architecture STRUCTURE of design_2_UART_TRANSACTION_HAN_0_0_UART_RX_DECODER is
  signal \FSM_onehot_state[5]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_byte_counter[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_byte_counter[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_byte_counter[2]_i_1_n_0\ : STD_LOGIC;
  signal SIPO : STD_LOGIC;
  signal SIPO0_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \SIPO[0][7]_i_1_n_0\ : STD_LOGIC;
  signal \SIPO[1][7]_i_1_n_0\ : STD_LOGIC;
  signal \SIPO[2][7]_i_1_n_0\ : STD_LOGIC;
  signal \SIPO[3][7]_i_1_n_0\ : STD_LOGIC;
  signal \SIPO[4][0]_i_1_n_0\ : STD_LOGIC;
  signal \SIPO[4][1]_i_1_n_0\ : STD_LOGIC;
  signal \SIPO[4][2]_i_1_n_0\ : STD_LOGIC;
  signal \SIPO[4][3]_i_1_n_0\ : STD_LOGIC;
  signal \SIPO[4][4]_i_1_n_0\ : STD_LOGIC;
  signal \SIPO[4][5]_i_1_n_0\ : STD_LOGIC;
  signal \SIPO[4][6]_i_1_n_0\ : STD_LOGIC;
  signal \SIPO[4][7]_i_2_n_0\ : STD_LOGIC;
  signal \byte_counter__0\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal p_1_in : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^reset_n_0\ : STD_LOGIC;
  signal \^uart_addr_reg_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_state[5]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \FSM_sequential_byte_counter[0]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \FSM_sequential_byte_counter[1]_i_1\ : label is "soft_lutpair1";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_byte_counter_reg[0]\ : label is "iSTATE:000,iSTATE0:010,iSTATE1:011,iSTATE2:100,iSTATE3:110,iSTATE4:001,iSTATE5:101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_byte_counter_reg[1]\ : label is "iSTATE:000,iSTATE0:010,iSTATE1:011,iSTATE2:100,iSTATE3:110,iSTATE4:001,iSTATE5:101";
  attribute FSM_ENCODED_STATES of \FSM_sequential_byte_counter_reg[2]\ : label is "iSTATE:000,iSTATE0:010,iSTATE1:011,iSTATE2:100,iSTATE3:110,iSTATE4:001,iSTATE5:101";
  attribute SOFT_HLUTNM of \SIPO[0][0]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \SIPO[0][1]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \SIPO[0][2]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \SIPO[0][3]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \SIPO[0][4]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \SIPO[0][5]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \SIPO[0][6]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \SIPO[0][7]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \SIPO[4][0]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \SIPO[4][1]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \SIPO[4][2]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \SIPO[4][3]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \SIPO[4][4]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \SIPO[4][5]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \SIPO[4][6]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \SIPO[4][7]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \uart_addr_reg[5]_i_1\ : label is "soft_lutpair0";
begin
  reset_n_0 <= \^reset_n_0\;
  uart_addr_reg_0 <= \^uart_addr_reg_0\;
\FSM_onehot_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFEEEEEEEEEEEEEE"
    )
        port map (
      I0 => Q(4),
      I1 => Q(2),
      I2 => \FSM_onehot_state[5]_i_2_n_0\,
      I3 => Q(0),
      I4 => p_1_in(1),
      I5 => p_1_in(0),
      O => D(0)
    );
\FSM_onehot_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F01010F0F0F0F0F0"
    )
        port map (
      I0 => p_1_in(0),
      I1 => p_1_in(1),
      I2 => Q(0),
      I3 => \byte_counter__0\(1),
      I4 => \byte_counter__0\(0),
      I5 => \byte_counter__0\(2),
      O => D(1)
    );
\FSM_onehot_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000080008000000"
    )
        port map (
      I0 => p_1_in(0),
      I1 => Q(0),
      I2 => p_1_in(1),
      I3 => \byte_counter__0\(2),
      I4 => \byte_counter__0\(0),
      I5 => \byte_counter__0\(1),
      O => D(2)
    );
\FSM_onehot_state[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0040"
    )
        port map (
      I0 => \FSM_onehot_state[5]_i_2_n_0\,
      I1 => Q(0),
      I2 => p_1_in(1),
      I3 => p_1_in(0),
      I4 => Q(1),
      O => D(3)
    );
\FSM_onehot_state[5]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9F"
    )
        port map (
      I0 => \byte_counter__0\(1),
      I1 => \byte_counter__0\(0),
      I2 => \byte_counter__0\(2),
      O => \FSM_onehot_state[5]_i_2_n_0\
    );
\FSM_onehot_state[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => Q(3),
      I1 => \^uart_addr_reg_0\,
      I2 => \FSM_onehot_state_reg[0]\,
      I3 => \FSM_onehot_state_reg[0]_0\,
      I4 => \FSM_onehot_state_reg[0]_1\,
      O => E(0)
    );
\FSM_sequential_byte_counter[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"D21A"
    )
        port map (
      I0 => rx_ready,
      I1 => \byte_counter__0\(2),
      I2 => \byte_counter__0\(0),
      I3 => \byte_counter__0\(1),
      O => \FSM_sequential_byte_counter[0]_i_1_n_0\
    );
\FSM_sequential_byte_counter[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"D3E0"
    )
        port map (
      I0 => rx_ready,
      I1 => \byte_counter__0\(2),
      I2 => \byte_counter__0\(0),
      I3 => \byte_counter__0\(1),
      O => \FSM_sequential_byte_counter[1]_i_1_n_0\
    );
\FSM_sequential_byte_counter[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF00000FF00FFB0"
    )
        port map (
      I0 => rx_data(7),
      I1 => rx_data(6),
      I2 => rx_ready,
      I3 => \byte_counter__0\(2),
      I4 => \byte_counter__0\(0),
      I5 => \byte_counter__0\(1),
      O => \FSM_sequential_byte_counter[2]_i_1_n_0\
    );
\FSM_sequential_byte_counter_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => \^reset_n_0\,
      D => \FSM_sequential_byte_counter[0]_i_1_n_0\,
      Q => \byte_counter__0\(0)
    );
\FSM_sequential_byte_counter_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => \^reset_n_0\,
      D => \FSM_sequential_byte_counter[1]_i_1_n_0\,
      Q => \byte_counter__0\(1)
    );
\FSM_sequential_byte_counter_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => \^reset_n_0\,
      D => \FSM_sequential_byte_counter[2]_i_1_n_0\,
      Q => \byte_counter__0\(2)
    );
\SIPO[0][0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(0),
      I1 => \byte_counter__0\(2),
      O => SIPO0_in(0)
    );
\SIPO[0][1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(1),
      I1 => \byte_counter__0\(2),
      O => SIPO0_in(1)
    );
\SIPO[0][2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(2),
      I1 => \byte_counter__0\(2),
      O => SIPO0_in(2)
    );
\SIPO[0][3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(3),
      I1 => \byte_counter__0\(2),
      O => SIPO0_in(3)
    );
\SIPO[0][4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(4),
      I1 => \byte_counter__0\(2),
      O => SIPO0_in(4)
    );
\SIPO[0][5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(5),
      I1 => \byte_counter__0\(2),
      O => SIPO0_in(5)
    );
\SIPO[0][6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(6),
      I1 => \byte_counter__0\(2),
      O => SIPO0_in(6)
    );
\SIPO[0][7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3002"
    )
        port map (
      I0 => rx_ready,
      I1 => \byte_counter__0\(0),
      I2 => \byte_counter__0\(1),
      I3 => \byte_counter__0\(2),
      O => \SIPO[0][7]_i_1_n_0\
    );
\SIPO[0][7]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(7),
      I1 => \byte_counter__0\(2),
      O => SIPO0_in(7)
    );
\SIPO[1][7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3008"
    )
        port map (
      I0 => rx_ready,
      I1 => \byte_counter__0\(0),
      I2 => \byte_counter__0\(1),
      I3 => \byte_counter__0\(2),
      O => \SIPO[1][7]_i_1_n_0\
    );
\SIPO[2][7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3020"
    )
        port map (
      I0 => rx_ready,
      I1 => \byte_counter__0\(0),
      I2 => \byte_counter__0\(1),
      I3 => \byte_counter__0\(2),
      O => \SIPO[2][7]_i_1_n_0\
    );
\SIPO[3][7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3080"
    )
        port map (
      I0 => rx_ready,
      I1 => \byte_counter__0\(0),
      I2 => \byte_counter__0\(1),
      I3 => \byte_counter__0\(2),
      O => \SIPO[3][7]_i_1_n_0\
    );
\SIPO[4][0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(0),
      I1 => \byte_counter__0\(1),
      O => \SIPO[4][0]_i_1_n_0\
    );
\SIPO[4][1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(1),
      I1 => \byte_counter__0\(1),
      O => \SIPO[4][1]_i_1_n_0\
    );
\SIPO[4][2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(2),
      I1 => \byte_counter__0\(1),
      O => \SIPO[4][2]_i_1_n_0\
    );
\SIPO[4][3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(3),
      I1 => \byte_counter__0\(1),
      O => \SIPO[4][3]_i_1_n_0\
    );
\SIPO[4][4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(4),
      I1 => \byte_counter__0\(1),
      O => \SIPO[4][4]_i_1_n_0\
    );
\SIPO[4][5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(5),
      I1 => \byte_counter__0\(1),
      O => \SIPO[4][5]_i_1_n_0\
    );
\SIPO[4][6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(6),
      I1 => \byte_counter__0\(1),
      O => \SIPO[4][6]_i_1_n_0\
    );
\SIPO[4][7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3200"
    )
        port map (
      I0 => rx_ready,
      I1 => \byte_counter__0\(0),
      I2 => \byte_counter__0\(1),
      I3 => \byte_counter__0\(2),
      O => SIPO
    );
\SIPO[4][7]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => rx_data(7),
      I1 => \byte_counter__0\(1),
      O => \SIPO[4][7]_i_2_n_0\
    );
\SIPO_reg[0][0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[0][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(0),
      Q => \SIPO_reg[0][5]_0\(0)
    );
\SIPO_reg[0][1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[0][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(1),
      Q => \SIPO_reg[0][5]_0\(1)
    );
\SIPO_reg[0][2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[0][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(2),
      Q => \SIPO_reg[0][5]_0\(2)
    );
\SIPO_reg[0][3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[0][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(3),
      Q => \SIPO_reg[0][5]_0\(3)
    );
\SIPO_reg[0][4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[0][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(4),
      Q => \SIPO_reg[0][5]_0\(4)
    );
\SIPO_reg[0][5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[0][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(5),
      Q => \SIPO_reg[0][5]_0\(5)
    );
\SIPO_reg[0][6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[0][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(6),
      Q => p_1_in(0)
    );
\SIPO_reg[0][7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[0][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(7),
      Q => p_1_in(1)
    );
\SIPO_reg[1][0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[1][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(0),
      Q => \SIPO_reg[1][7]_0\(24)
    );
\SIPO_reg[1][1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[1][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(1),
      Q => \SIPO_reg[1][7]_0\(25)
    );
\SIPO_reg[1][2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[1][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(2),
      Q => \SIPO_reg[1][7]_0\(26)
    );
\SIPO_reg[1][3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[1][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(3),
      Q => \SIPO_reg[1][7]_0\(27)
    );
\SIPO_reg[1][4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[1][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(4),
      Q => \SIPO_reg[1][7]_0\(28)
    );
\SIPO_reg[1][5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[1][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(5),
      Q => \SIPO_reg[1][7]_0\(29)
    );
\SIPO_reg[1][6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[1][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(6),
      Q => \SIPO_reg[1][7]_0\(30)
    );
\SIPO_reg[1][7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[1][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(7),
      Q => \SIPO_reg[1][7]_0\(31)
    );
\SIPO_reg[2][0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[2][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(0),
      Q => \SIPO_reg[1][7]_0\(16)
    );
\SIPO_reg[2][1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[2][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(1),
      Q => \SIPO_reg[1][7]_0\(17)
    );
\SIPO_reg[2][2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[2][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(2),
      Q => \SIPO_reg[1][7]_0\(18)
    );
\SIPO_reg[2][3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[2][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(3),
      Q => \SIPO_reg[1][7]_0\(19)
    );
\SIPO_reg[2][4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[2][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(4),
      Q => \SIPO_reg[1][7]_0\(20)
    );
\SIPO_reg[2][5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[2][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(5),
      Q => \SIPO_reg[1][7]_0\(21)
    );
\SIPO_reg[2][6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[2][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(6),
      Q => \SIPO_reg[1][7]_0\(22)
    );
\SIPO_reg[2][7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[2][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(7),
      Q => \SIPO_reg[1][7]_0\(23)
    );
\SIPO_reg[3][0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[3][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(0),
      Q => \SIPO_reg[1][7]_0\(8)
    );
\SIPO_reg[3][1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[3][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(1),
      Q => \SIPO_reg[1][7]_0\(9)
    );
\SIPO_reg[3][2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[3][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(2),
      Q => \SIPO_reg[1][7]_0\(10)
    );
\SIPO_reg[3][3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[3][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(3),
      Q => \SIPO_reg[1][7]_0\(11)
    );
\SIPO_reg[3][4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[3][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(4),
      Q => \SIPO_reg[1][7]_0\(12)
    );
\SIPO_reg[3][5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[3][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(5),
      Q => \SIPO_reg[1][7]_0\(13)
    );
\SIPO_reg[3][6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[3][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(6),
      Q => \SIPO_reg[1][7]_0\(14)
    );
\SIPO_reg[3][7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \SIPO[3][7]_i_1_n_0\,
      CLR => \^reset_n_0\,
      D => SIPO0_in(7),
      Q => \SIPO_reg[1][7]_0\(15)
    );
\SIPO_reg[4][0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => SIPO,
      CLR => \^reset_n_0\,
      D => \SIPO[4][0]_i_1_n_0\,
      Q => \SIPO_reg[1][7]_0\(0)
    );
\SIPO_reg[4][1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => SIPO,
      CLR => \^reset_n_0\,
      D => \SIPO[4][1]_i_1_n_0\,
      Q => \SIPO_reg[1][7]_0\(1)
    );
\SIPO_reg[4][2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => SIPO,
      CLR => \^reset_n_0\,
      D => \SIPO[4][2]_i_1_n_0\,
      Q => \SIPO_reg[1][7]_0\(2)
    );
\SIPO_reg[4][3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => SIPO,
      CLR => \^reset_n_0\,
      D => \SIPO[4][3]_i_1_n_0\,
      Q => \SIPO_reg[1][7]_0\(3)
    );
\SIPO_reg[4][4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => SIPO,
      CLR => \^reset_n_0\,
      D => \SIPO[4][4]_i_1_n_0\,
      Q => \SIPO_reg[1][7]_0\(4)
    );
\SIPO_reg[4][5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => SIPO,
      CLR => \^reset_n_0\,
      D => \SIPO[4][5]_i_1_n_0\,
      Q => \SIPO_reg[1][7]_0\(5)
    );
\SIPO_reg[4][6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => SIPO,
      CLR => \^reset_n_0\,
      D => \SIPO[4][6]_i_1_n_0\,
      Q => \SIPO_reg[1][7]_0\(6)
    );
\SIPO_reg[4][7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => SIPO,
      CLR => \^reset_n_0\,
      D => \SIPO[4][7]_i_2_n_0\,
      Q => \SIPO_reg[1][7]_0\(7)
    );
aw_done_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF7FF00"
    )
        port map (
      I0 => \^uart_addr_reg_0\,
      I1 => p_1_in(0),
      I2 => p_1_in(1),
      I3 => aw_done,
      I4 => aw_done_reg,
      O => \SIPO_reg[0][6]_1\
    );
\m_axi_awaddr[5]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => reset_n,
      O => \^reset_n_0\
    );
\tx_data_in[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF08080808080808"
    )
        port map (
      I0 => \^uart_addr_reg_0\,
      I1 => p_1_in(1),
      I2 => p_1_in(0),
      I3 => Q(1),
      I4 => m_axi_rvalid,
      I5 => \tx_data_in_reg[0]\,
      O => \SIPO_reg[0][7]_0\(0)
    );
\uart_addr_reg[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => \byte_counter__0\(0),
      I1 => \byte_counter__0\(1),
      I2 => \byte_counter__0\(2),
      I3 => Q(0),
      O => \^uart_addr_reg_0\
    );
w_done_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF7FF00"
    )
        port map (
      I0 => \^uart_addr_reg_0\,
      I1 => p_1_in(0),
      I2 => p_1_in(1),
      I3 => w_done,
      I4 => w_done_reg,
      O => \SIPO_reg[0][6]_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_UART_TRANSACTION_HAN_0_0_UART_TX_ENCODER is
  port (
    \PISO_reg[1][8]_0\ : out STD_LOGIC;
    Word_To_Send_en : out STD_LOGIC;
    Word_To_Send : out STD_LOGIC_VECTOR ( 7 downto 0 );
    uart_tx_ready : in STD_LOGIC;
    \PISO_reg[3][8]_0\ : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    \PISO_reg[0][7]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clk : in STD_LOGIC;
    \PISO_reg[0][8]_0\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_2_UART_TRANSACTION_HAN_0_0_UART_TX_ENCODER : entity is "UART_TX_ENCODER";
end design_2_UART_TRANSACTION_HAN_0_0_UART_TX_ENCODER;

architecture STRUCTURE of design_2_UART_TRANSACTION_HAN_0_0_UART_TX_ENCODER is
  signal PISO : STD_LOGIC;
  signal \PISO[0][0]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[0][1]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[0][2]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[0][3]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[0][4]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[0][5]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[0][6]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[0][7]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[0][8]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[1][0]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[1][1]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[1][2]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[1][3]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[1][4]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[1][5]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[1][6]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[1][7]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[1][8]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[2][0]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[2][1]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[2][2]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[2][3]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[2][4]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[2][5]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[2][6]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[2][7]_i_1_n_0\ : STD_LOGIC;
  signal \PISO[2][8]_i_1_n_0\ : STD_LOGIC;
  signal \PISO_reg[2]\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \PISO_reg[3]\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \PISO_reg_n_0_[0][0]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[0][1]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[0][2]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[0][3]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[0][4]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[0][5]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[0][6]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[0][7]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[1][0]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[1][1]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[1][2]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[1][3]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[1][4]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[1][5]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[1][6]\ : STD_LOGIC;
  signal \PISO_reg_n_0_[1][7]\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal p_0_in1_in : STD_LOGIC;
  signal p_0_in_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_state[6]_i_2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \PISO[0][1]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \PISO[0][2]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \PISO[0][3]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \PISO[0][4]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \PISO[0][5]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \PISO[0][6]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \PISO[0][7]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \PISO[0][8]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \PISO[1][0]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \PISO[1][1]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \PISO[1][2]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \PISO[1][3]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \PISO[1][4]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \PISO[1][5]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \PISO[1][6]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \PISO[1][7]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \PISO[1][8]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \PISO[2][0]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \PISO[2][1]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \PISO[2][2]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \PISO[2][3]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \PISO[2][4]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \PISO[2][5]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \PISO[2][6]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \PISO[2][7]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \PISO[2][8]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \PISO[3][0]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \PISO[3][1]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \PISO[3][2]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \PISO[3][3]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \PISO[3][4]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \PISO[3][5]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \PISO[3][6]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \PISO[3][7]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \Word_To_Send[0]_INST_0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \Word_To_Send[1]_INST_0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \Word_To_Send[2]_INST_0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \Word_To_Send[3]_INST_0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \Word_To_Send[4]_INST_0\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \Word_To_Send[5]_INST_0\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \Word_To_Send[6]_INST_0\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \Word_To_Send[7]_INST_0\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of Word_To_Send_en_INST_0 : label is "soft_lutpair10";
begin
\FSM_onehot_state[6]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => p_0_in_0,
      I1 => Q(0),
      I2 => p_0_in1_in,
      I3 => uart_tx_ready,
      O => \PISO_reg[1][8]_0\
    );
\PISO[0][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(24),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg_n_0_[1][0]\,
      O => \PISO[0][0]_i_1_n_0\
    );
\PISO[0][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(25),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg_n_0_[1][1]\,
      O => \PISO[0][1]_i_1_n_0\
    );
\PISO[0][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(26),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg_n_0_[1][2]\,
      O => \PISO[0][2]_i_1_n_0\
    );
\PISO[0][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(27),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg_n_0_[1][3]\,
      O => \PISO[0][3]_i_1_n_0\
    );
\PISO[0][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(28),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg_n_0_[1][4]\,
      O => \PISO[0][4]_i_1_n_0\
    );
\PISO[0][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(29),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg_n_0_[1][5]\,
      O => \PISO[0][5]_i_1_n_0\
    );
\PISO[0][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(30),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg_n_0_[1][6]\,
      O => \PISO[0][6]_i_1_n_0\
    );
\PISO[0][7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(31),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg_n_0_[1][7]\,
      O => \PISO[0][7]_i_1_n_0\
    );
\PISO[0][8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \PISO_reg[3][8]_0\,
      I1 => p_0_in_0,
      O => \PISO[0][8]_i_1_n_0\
    );
\PISO[1][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(16),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[2]\(0),
      O => \PISO[1][0]_i_1_n_0\
    );
\PISO[1][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(17),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[2]\(1),
      O => \PISO[1][1]_i_1_n_0\
    );
\PISO[1][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(18),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[2]\(2),
      O => \PISO[1][2]_i_1_n_0\
    );
\PISO[1][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(19),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[2]\(3),
      O => \PISO[1][3]_i_1_n_0\
    );
\PISO[1][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(20),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[2]\(4),
      O => \PISO[1][4]_i_1_n_0\
    );
\PISO[1][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(21),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[2]\(5),
      O => \PISO[1][5]_i_1_n_0\
    );
\PISO[1][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(22),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[2]\(6),
      O => \PISO[1][6]_i_1_n_0\
    );
\PISO[1][7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(23),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[2]\(7),
      O => \PISO[1][7]_i_1_n_0\
    );
\PISO[1][8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \PISO_reg[3][8]_0\,
      I1 => \PISO_reg[2]\(8),
      O => \PISO[1][8]_i_1_n_0\
    );
\PISO[2][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(8),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[3]\(0),
      O => \PISO[2][0]_i_1_n_0\
    );
\PISO[2][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(9),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[3]\(1),
      O => \PISO[2][1]_i_1_n_0\
    );
\PISO[2][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(10),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[3]\(2),
      O => \PISO[2][2]_i_1_n_0\
    );
\PISO[2][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(11),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[3]\(3),
      O => \PISO[2][3]_i_1_n_0\
    );
\PISO[2][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(12),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[3]\(4),
      O => \PISO[2][4]_i_1_n_0\
    );
\PISO[2][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(13),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[3]\(5),
      O => \PISO[2][5]_i_1_n_0\
    );
\PISO[2][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(14),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[3]\(6),
      O => \PISO[2][6]_i_1_n_0\
    );
\PISO[2][7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \PISO_reg[0][7]_0\(15),
      I1 => \PISO_reg[3][8]_0\,
      I2 => \PISO_reg[3]\(7),
      O => \PISO[2][7]_i_1_n_0\
    );
\PISO[2][8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \PISO_reg[3][8]_0\,
      I1 => \PISO_reg[3]\(8),
      O => \PISO[2][8]_i_1_n_0\
    );
\PISO[3][0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \PISO_reg[3][8]_0\,
      I1 => \PISO_reg[0][7]_0\(0),
      O => p_0_in(0)
    );
\PISO[3][1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \PISO_reg[3][8]_0\,
      I1 => \PISO_reg[0][7]_0\(1),
      O => p_0_in(1)
    );
\PISO[3][2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \PISO_reg[3][8]_0\,
      I1 => \PISO_reg[0][7]_0\(2),
      O => p_0_in(2)
    );
\PISO[3][3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \PISO_reg[3][8]_0\,
      I1 => \PISO_reg[0][7]_0\(3),
      O => p_0_in(3)
    );
\PISO[3][4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \PISO_reg[3][8]_0\,
      I1 => \PISO_reg[0][7]_0\(4),
      O => p_0_in(4)
    );
\PISO[3][5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \PISO_reg[3][8]_0\,
      I1 => \PISO_reg[0][7]_0\(5),
      O => p_0_in(5)
    );
\PISO[3][6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \PISO_reg[3][8]_0\,
      I1 => \PISO_reg[0][7]_0\(6),
      O => p_0_in(6)
    );
\PISO[3][7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \PISO_reg[3][8]_0\,
      I1 => \PISO_reg[0][7]_0\(7),
      O => p_0_in(7)
    );
\PISO[3][8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F8"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => uart_tx_ready,
      I2 => \PISO_reg[3][8]_0\,
      O => PISO
    );
\PISO_reg[0][0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[0][0]_i_1_n_0\,
      Q => \PISO_reg_n_0_[0][0]\
    );
\PISO_reg[0][1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[0][1]_i_1_n_0\,
      Q => \PISO_reg_n_0_[0][1]\
    );
\PISO_reg[0][2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[0][2]_i_1_n_0\,
      Q => \PISO_reg_n_0_[0][2]\
    );
\PISO_reg[0][3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[0][3]_i_1_n_0\,
      Q => \PISO_reg_n_0_[0][3]\
    );
\PISO_reg[0][4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[0][4]_i_1_n_0\,
      Q => \PISO_reg_n_0_[0][4]\
    );
\PISO_reg[0][5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[0][5]_i_1_n_0\,
      Q => \PISO_reg_n_0_[0][5]\
    );
\PISO_reg[0][6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[0][6]_i_1_n_0\,
      Q => \PISO_reg_n_0_[0][6]\
    );
\PISO_reg[0][7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[0][7]_i_1_n_0\,
      Q => \PISO_reg_n_0_[0][7]\
    );
\PISO_reg[0][8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[0][8]_i_1_n_0\,
      Q => p_0_in1_in
    );
\PISO_reg[1][0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[1][0]_i_1_n_0\,
      Q => \PISO_reg_n_0_[1][0]\
    );
\PISO_reg[1][1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[1][1]_i_1_n_0\,
      Q => \PISO_reg_n_0_[1][1]\
    );
\PISO_reg[1][2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[1][2]_i_1_n_0\,
      Q => \PISO_reg_n_0_[1][2]\
    );
\PISO_reg[1][3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[1][3]_i_1_n_0\,
      Q => \PISO_reg_n_0_[1][3]\
    );
\PISO_reg[1][4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[1][4]_i_1_n_0\,
      Q => \PISO_reg_n_0_[1][4]\
    );
\PISO_reg[1][5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[1][5]_i_1_n_0\,
      Q => \PISO_reg_n_0_[1][5]\
    );
\PISO_reg[1][6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[1][6]_i_1_n_0\,
      Q => \PISO_reg_n_0_[1][6]\
    );
\PISO_reg[1][7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[1][7]_i_1_n_0\,
      Q => \PISO_reg_n_0_[1][7]\
    );
\PISO_reg[1][8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[1][8]_i_1_n_0\,
      Q => p_0_in_0
    );
\PISO_reg[2][0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[2][0]_i_1_n_0\,
      Q => \PISO_reg[2]\(0)
    );
\PISO_reg[2][1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[2][1]_i_1_n_0\,
      Q => \PISO_reg[2]\(1)
    );
\PISO_reg[2][2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[2][2]_i_1_n_0\,
      Q => \PISO_reg[2]\(2)
    );
\PISO_reg[2][3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[2][3]_i_1_n_0\,
      Q => \PISO_reg[2]\(3)
    );
\PISO_reg[2][4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[2][4]_i_1_n_0\,
      Q => \PISO_reg[2]\(4)
    );
\PISO_reg[2][5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[2][5]_i_1_n_0\,
      Q => \PISO_reg[2]\(5)
    );
\PISO_reg[2][6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[2][6]_i_1_n_0\,
      Q => \PISO_reg[2]\(6)
    );
\PISO_reg[2][7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[2][7]_i_1_n_0\,
      Q => \PISO_reg[2]\(7)
    );
\PISO_reg[2][8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO[2][8]_i_1_n_0\,
      Q => \PISO_reg[2]\(8)
    );
\PISO_reg[3][0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => p_0_in(0),
      Q => \PISO_reg[3]\(0)
    );
\PISO_reg[3][1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => p_0_in(1),
      Q => \PISO_reg[3]\(1)
    );
\PISO_reg[3][2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => p_0_in(2),
      Q => \PISO_reg[3]\(2)
    );
\PISO_reg[3][3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => p_0_in(3),
      Q => \PISO_reg[3]\(3)
    );
\PISO_reg[3][4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => p_0_in(4),
      Q => \PISO_reg[3]\(4)
    );
\PISO_reg[3][5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => p_0_in(5),
      Q => \PISO_reg[3]\(5)
    );
\PISO_reg[3][6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => p_0_in(6),
      Q => \PISO_reg[3]\(6)
    );
\PISO_reg[3][7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => p_0_in(7),
      Q => \PISO_reg[3]\(7)
    );
\PISO_reg[3][8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => PISO,
      CLR => \PISO_reg[0][8]_0\,
      D => \PISO_reg[3][8]_0\,
      Q => \PISO_reg[3]\(8)
    );
\Word_To_Send[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => \PISO_reg_n_0_[0][0]\,
      O => Word_To_Send(0)
    );
\Word_To_Send[1]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => \PISO_reg_n_0_[0][1]\,
      O => Word_To_Send(1)
    );
\Word_To_Send[2]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => \PISO_reg_n_0_[0][2]\,
      O => Word_To_Send(2)
    );
\Word_To_Send[3]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => \PISO_reg_n_0_[0][3]\,
      O => Word_To_Send(3)
    );
\Word_To_Send[4]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => \PISO_reg_n_0_[0][4]\,
      O => Word_To_Send(4)
    );
\Word_To_Send[5]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => \PISO_reg_n_0_[0][5]\,
      O => Word_To_Send(5)
    );
\Word_To_Send[6]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => \PISO_reg_n_0_[0][6]\,
      O => Word_To_Send(6)
    );
\Word_To_Send[7]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => p_0_in1_in,
      I1 => \PISO_reg_n_0_[0][7]\,
      O => Word_To_Send(7)
    );
Word_To_Send_en_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => uart_tx_ready,
      I1 => p_0_in1_in,
      O => Word_To_Send_en
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_UART_TRANSACTION_HAN_0_0_UART_TRANSACTION_HANDLER is
  port (
    m_axi_arvalid : out STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 5 downto 0 );
    Word_To_Send_en : out STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_rready_reg_0 : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    Word_To_Send : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_ready : in STD_LOGIC;
    clk : in STD_LOGIC;
    uart_tx_ready : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    max_angle : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reset_n : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_2_UART_TRANSACTION_HAN_0_0_UART_TRANSACTION_HANDLER : entity is "UART_TRANSACTION_HANDLER";
end design_2_UART_TRANSACTION_HAN_0_0_UART_TRANSACTION_HANDLER;

architecture STRUCTURE of design_2_UART_TRANSACTION_HAN_0_0_UART_TRANSACTION_HANDLER is
  signal \FSM_onehot_state[6]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[6]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[0]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[1]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[2]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[3]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[4]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[6]\ : STD_LOGIC;
  signal \SIPO_reg[1]\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \SIPO_reg[2]\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \SIPO_reg[3]\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \SIPO_reg[4]\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal UART_RX_DECODER_inst_n_0 : STD_LOGIC;
  signal UART_RX_DECODER_inst_n_2 : STD_LOGIC;
  signal UART_RX_DECODER_inst_n_3 : STD_LOGIC;
  signal UART_RX_DECODER_inst_n_4 : STD_LOGIC;
  signal UART_RX_DECODER_inst_n_5 : STD_LOGIC;
  signal UART_RX_DECODER_inst_n_6 : STD_LOGIC;
  signal UART_RX_DECODER_inst_n_7 : STD_LOGIC;
  signal UART_RX_DECODER_inst_n_8 : STD_LOGIC;
  signal UART_RX_DECODER_inst_n_9 : STD_LOGIC;
  signal UART_TX_ENCODER_inst_n_0 : STD_LOGIC;
  signal aw_done : STD_LOGIC;
  signal aw_done_reg_n_0 : STD_LOGIC;
  signal \^m_axi_arvalid\ : STD_LOGIC;
  signal m_axi_arvalid_i_1_n_0 : STD_LOGIC;
  signal \^m_axi_awvalid\ : STD_LOGIC;
  signal m_axi_awvalid_i_1_n_0 : STD_LOGIC;
  signal \^m_axi_bready\ : STD_LOGIC;
  signal m_axi_bready_i_1_n_0 : STD_LOGIC;
  signal m_axi_rready_i_1_n_0 : STD_LOGIC;
  signal \^m_axi_rready_reg_0\ : STD_LOGIC;
  signal \^m_axi_wvalid\ : STD_LOGIC;
  signal m_axi_wvalid_i_1_n_0 : STD_LOGIC;
  signal tx_data_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \tx_data_in[0]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[10]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[11]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[12]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[13]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[14]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[15]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[16]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[17]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[18]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[19]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[1]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[20]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[21]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[22]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[23]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[24]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[25]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[26]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[27]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[28]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[29]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[2]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[30]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[31]_i_2_n_0\ : STD_LOGIC;
  signal \tx_data_in[3]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[4]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[5]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[6]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[7]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[8]_i_1_n_0\ : STD_LOGIC;
  signal \tx_data_in[9]_i_1_n_0\ : STD_LOGIC;
  signal tx_start : STD_LOGIC;
  signal tx_start_i_1_n_0 : STD_LOGIC;
  signal tx_start_reg_n_0 : STD_LOGIC;
  signal uart_addr : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal uart_addr_reg : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal uart_addr_reg_0 : STD_LOGIC;
  signal uart_data_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal w_done : STD_LOGIC;
  signal w_done_reg_n_0 : STD_LOGIC;
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[0]\ : label is "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[1]\ : label is "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[2]\ : label is "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[3]\ : label is "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[4]\ : label is "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[5]\ : label is "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[6]\ : label is "AXI_READ_DATA:0000100,AXI_WRITE_RESP:0010000,UART_WAIT:1000000,IDLE:0000001,UART_SEND:0100000,AXI_WRITE:0001000,AXI_READ_ADDR:0000010";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of aw_done_i_2 : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of m_axi_awvalid_i_1 : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of m_axi_wvalid_i_1 : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of w_done_i_2 : label is "soft_lutpair33";
begin
  m_axi_arvalid <= \^m_axi_arvalid\;
  m_axi_awvalid <= \^m_axi_awvalid\;
  m_axi_bready <= \^m_axi_bready\;
  m_axi_rready_reg_0 <= \^m_axi_rready_reg_0\;
  m_axi_wvalid <= \^m_axi_wvalid\;
\FSM_onehot_state[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF80808080808080"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[4]\,
      I1 => m_axi_bvalid,
      I2 => \^m_axi_bready\,
      I3 => \FSM_onehot_state_reg_n_0_[3]\,
      I4 => aw_done_reg_n_0,
      I5 => w_done_reg_n_0,
      O => \FSM_onehot_state[6]_i_3_n_0\
    );
\FSM_onehot_state[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF80808080808080"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[2]\,
      I1 => m_axi_rvalid,
      I2 => \^m_axi_rready_reg_0\,
      I3 => \^m_axi_arvalid\,
      I4 => m_axi_arready,
      I5 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \FSM_onehot_state[6]_i_4_n_0\
    );
\FSM_onehot_state_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_0,
      D => UART_RX_DECODER_inst_n_6,
      PRE => UART_RX_DECODER_inst_n_9,
      Q => \FSM_onehot_state_reg_n_0_[0]\
    );
\FSM_onehot_state_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => UART_RX_DECODER_inst_n_5,
      Q => \FSM_onehot_state_reg_n_0_[1]\
    );
\FSM_onehot_state_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \FSM_onehot_state_reg_n_0_[1]\,
      Q => \FSM_onehot_state_reg_n_0_[2]\
    );
\FSM_onehot_state_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => UART_RX_DECODER_inst_n_4,
      Q => \FSM_onehot_state_reg_n_0_[3]\
    );
\FSM_onehot_state_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \FSM_onehot_state_reg_n_0_[3]\,
      Q => \FSM_onehot_state_reg_n_0_[4]\
    );
\FSM_onehot_state_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => UART_RX_DECODER_inst_n_3,
      Q => tx_start
    );
\FSM_onehot_state_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => tx_start,
      Q => \FSM_onehot_state_reg_n_0_[6]\
    );
UART_RX_DECODER_inst: entity work.design_2_UART_TRANSACTION_HAN_0_0_UART_RX_DECODER
     port map (
      D(3) => UART_RX_DECODER_inst_n_3,
      D(2) => UART_RX_DECODER_inst_n_4,
      D(1) => UART_RX_DECODER_inst_n_5,
      D(0) => UART_RX_DECODER_inst_n_6,
      E(0) => UART_RX_DECODER_inst_n_0,
      \FSM_onehot_state_reg[0]\ => UART_TX_ENCODER_inst_n_0,
      \FSM_onehot_state_reg[0]_0\ => \FSM_onehot_state[6]_i_3_n_0\,
      \FSM_onehot_state_reg[0]_1\ => \FSM_onehot_state[6]_i_4_n_0\,
      Q(4) => \FSM_onehot_state_reg_n_0_[6]\,
      Q(3) => tx_start,
      Q(2) => \FSM_onehot_state_reg_n_0_[4]\,
      Q(1) => \FSM_onehot_state_reg_n_0_[2]\,
      Q(0) => \FSM_onehot_state_reg_n_0_[0]\,
      \SIPO_reg[0][5]_0\(5 downto 0) => uart_addr(5 downto 0),
      \SIPO_reg[0][6]_0\ => UART_RX_DECODER_inst_n_7,
      \SIPO_reg[0][6]_1\ => UART_RX_DECODER_inst_n_8,
      \SIPO_reg[0][7]_0\(0) => UART_RX_DECODER_inst_n_2,
      \SIPO_reg[1][7]_0\(31 downto 24) => \SIPO_reg[1]\(7 downto 0),
      \SIPO_reg[1][7]_0\(23 downto 16) => \SIPO_reg[2]\(7 downto 0),
      \SIPO_reg[1][7]_0\(15 downto 8) => \SIPO_reg[3]\(7 downto 0),
      \SIPO_reg[1][7]_0\(7 downto 0) => \SIPO_reg[4]\(7 downto 0),
      aw_done => aw_done,
      aw_done_reg => aw_done_reg_n_0,
      clk => clk,
      m_axi_rvalid => m_axi_rvalid,
      reset_n => reset_n,
      reset_n_0 => UART_RX_DECODER_inst_n_9,
      rx_data(7 downto 0) => rx_data(7 downto 0),
      rx_ready => rx_ready,
      \tx_data_in_reg[0]\ => \^m_axi_rready_reg_0\,
      uart_addr_reg_0 => uart_addr_reg_0,
      w_done => w_done,
      w_done_reg => w_done_reg_n_0
    );
UART_TX_ENCODER_inst: entity work.design_2_UART_TRANSACTION_HAN_0_0_UART_TX_ENCODER
     port map (
      \PISO_reg[0][7]_0\(31 downto 0) => tx_data_in(31 downto 0),
      \PISO_reg[0][8]_0\ => UART_RX_DECODER_inst_n_9,
      \PISO_reg[1][8]_0\ => UART_TX_ENCODER_inst_n_0,
      \PISO_reg[3][8]_0\ => tx_start_reg_n_0,
      Q(0) => \FSM_onehot_state_reg_n_0_[6]\,
      Word_To_Send(7 downto 0) => Word_To_Send(7 downto 0),
      Word_To_Send_en => Word_To_Send_en,
      clk => clk,
      uart_tx_ready => uart_tx_ready
    );
aw_done_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[3]\,
      I1 => m_axi_awready,
      I2 => \^m_axi_awvalid\,
      O => aw_done
    );
aw_done_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => UART_RX_DECODER_inst_n_9,
      D => UART_RX_DECODER_inst_n_8,
      Q => aw_done_reg_n_0
    );
\m_axi_araddr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[1]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(0),
      Q => m_axi_araddr(0)
    );
\m_axi_araddr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[1]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(1),
      Q => m_axi_araddr(1)
    );
\m_axi_araddr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[1]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(2),
      Q => m_axi_araddr(2)
    );
\m_axi_araddr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[1]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(3),
      Q => m_axi_araddr(3)
    );
\m_axi_araddr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[1]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(4),
      Q => m_axi_araddr(4)
    );
\m_axi_araddr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[1]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(5),
      Q => m_axi_araddr(5)
    );
m_axi_arvalid_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \^m_axi_arvalid\,
      I1 => m_axi_arready,
      O => m_axi_arvalid_i_1_n_0
    );
m_axi_arvalid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[1]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => m_axi_arvalid_i_1_n_0,
      Q => \^m_axi_arvalid\
    );
\m_axi_awaddr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(0),
      Q => m_axi_awaddr(0)
    );
\m_axi_awaddr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(1),
      Q => m_axi_awaddr(1)
    );
\m_axi_awaddr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(2),
      Q => m_axi_awaddr(2)
    );
\m_axi_awaddr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(3),
      Q => m_axi_awaddr(3)
    );
\m_axi_awaddr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(4),
      Q => m_axi_awaddr(4)
    );
\m_axi_awaddr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr_reg(5),
      Q => m_axi_awaddr(5)
    );
m_axi_awvalid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"27AA"
    )
        port map (
      I0 => \^m_axi_awvalid\,
      I1 => m_axi_awready,
      I2 => aw_done_reg_n_0,
      I3 => \FSM_onehot_state_reg_n_0_[3]\,
      O => m_axi_awvalid_i_1_n_0
    );
m_axi_awvalid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => UART_RX_DECODER_inst_n_9,
      D => m_axi_awvalid_i_1_n_0,
      Q => \^m_axi_awvalid\
    );
m_axi_bready_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF70707070707070"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[4]\,
      I1 => m_axi_bvalid,
      I2 => \^m_axi_bready\,
      I3 => \FSM_onehot_state_reg_n_0_[3]\,
      I4 => aw_done_reg_n_0,
      I5 => w_done_reg_n_0,
      O => m_axi_bready_i_1_n_0
    );
m_axi_bready_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => UART_RX_DECODER_inst_n_9,
      D => m_axi_bready_i_1_n_0,
      Q => \^m_axi_bready\
    );
m_axi_rready_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF70707070707070"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[2]\,
      I1 => m_axi_rvalid,
      I2 => \^m_axi_rready_reg_0\,
      I3 => \^m_axi_arvalid\,
      I4 => m_axi_arready,
      I5 => \FSM_onehot_state_reg_n_0_[1]\,
      O => m_axi_rready_i_1_n_0
    );
m_axi_rready_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => UART_RX_DECODER_inst_n_9,
      D => m_axi_rready_i_1_n_0,
      Q => \^m_axi_rready_reg_0\
    );
\m_axi_wdata_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(0),
      Q => m_axi_wdata(0)
    );
\m_axi_wdata_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(10),
      Q => m_axi_wdata(10)
    );
\m_axi_wdata_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(11),
      Q => m_axi_wdata(11)
    );
\m_axi_wdata_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(12),
      Q => m_axi_wdata(12)
    );
\m_axi_wdata_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(13),
      Q => m_axi_wdata(13)
    );
\m_axi_wdata_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(14),
      Q => m_axi_wdata(14)
    );
\m_axi_wdata_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(15),
      Q => m_axi_wdata(15)
    );
\m_axi_wdata_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(16),
      Q => m_axi_wdata(16)
    );
\m_axi_wdata_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(17),
      Q => m_axi_wdata(17)
    );
\m_axi_wdata_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(18),
      Q => m_axi_wdata(18)
    );
\m_axi_wdata_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(19),
      Q => m_axi_wdata(19)
    );
\m_axi_wdata_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(1),
      Q => m_axi_wdata(1)
    );
\m_axi_wdata_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(20),
      Q => m_axi_wdata(20)
    );
\m_axi_wdata_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(21),
      Q => m_axi_wdata(21)
    );
\m_axi_wdata_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(22),
      Q => m_axi_wdata(22)
    );
\m_axi_wdata_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(23),
      Q => m_axi_wdata(23)
    );
\m_axi_wdata_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(24),
      Q => m_axi_wdata(24)
    );
\m_axi_wdata_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(25),
      Q => m_axi_wdata(25)
    );
\m_axi_wdata_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(26),
      Q => m_axi_wdata(26)
    );
\m_axi_wdata_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(27),
      Q => m_axi_wdata(27)
    );
\m_axi_wdata_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(28),
      Q => m_axi_wdata(28)
    );
\m_axi_wdata_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(29),
      Q => m_axi_wdata(29)
    );
\m_axi_wdata_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(2),
      Q => m_axi_wdata(2)
    );
\m_axi_wdata_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(30),
      Q => m_axi_wdata(30)
    );
\m_axi_wdata_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(31),
      Q => m_axi_wdata(31)
    );
\m_axi_wdata_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(3),
      Q => m_axi_wdata(3)
    );
\m_axi_wdata_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(4),
      Q => m_axi_wdata(4)
    );
\m_axi_wdata_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(5),
      Q => m_axi_wdata(5)
    );
\m_axi_wdata_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(6),
      Q => m_axi_wdata(6)
    );
\m_axi_wdata_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(7),
      Q => m_axi_wdata(7)
    );
\m_axi_wdata_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(8),
      Q => m_axi_wdata(8)
    );
\m_axi_wdata_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_data_reg(9),
      Q => m_axi_wdata(9)
    );
\m_axi_wstrb_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_onehot_state_reg_n_0_[3]\,
      CLR => UART_RX_DECODER_inst_n_9,
      D => '1',
      Q => m_axi_wstrb(0)
    );
m_axi_wvalid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"27AA"
    )
        port map (
      I0 => \^m_axi_wvalid\,
      I1 => m_axi_wready,
      I2 => w_done_reg_n_0,
      I3 => \FSM_onehot_state_reg_n_0_[3]\,
      O => m_axi_wvalid_i_1_n_0
    );
m_axi_wvalid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => UART_RX_DECODER_inst_n_9,
      D => m_axi_wvalid_i_1_n_0,
      Q => \^m_axi_wvalid\
    );
\tx_data_in[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(0),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(0),
      O => \tx_data_in[0]_i_1_n_0\
    );
\tx_data_in[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(10),
      I2 => m_axi_rdata(10),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[10]_i_1_n_0\
    );
\tx_data_in[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(11),
      I2 => m_axi_rdata(11),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[11]_i_1_n_0\
    );
\tx_data_in[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(12),
      I2 => m_axi_rdata(12),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[12]_i_1_n_0\
    );
\tx_data_in[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(13),
      I2 => m_axi_rdata(13),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[13]_i_1_n_0\
    );
\tx_data_in[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(14),
      I2 => m_axi_rdata(14),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[14]_i_1_n_0\
    );
\tx_data_in[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(15),
      I2 => m_axi_rdata(15),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[15]_i_1_n_0\
    );
\tx_data_in[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(16),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(16),
      O => \tx_data_in[16]_i_1_n_0\
    );
\tx_data_in[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(17),
      I2 => m_axi_rdata(17),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[17]_i_1_n_0\
    );
\tx_data_in[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(18),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(18),
      O => \tx_data_in[18]_i_1_n_0\
    );
\tx_data_in[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(19),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(19),
      O => \tx_data_in[19]_i_1_n_0\
    );
\tx_data_in[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(1),
      I2 => m_axi_rdata(1),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[1]_i_1_n_0\
    );
\tx_data_in[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(20),
      I2 => m_axi_rdata(20),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[20]_i_1_n_0\
    );
\tx_data_in[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(21),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(21),
      O => \tx_data_in[21]_i_1_n_0\
    );
\tx_data_in[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(22),
      I2 => m_axi_rdata(22),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[22]_i_1_n_0\
    );
\tx_data_in[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(23),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(23),
      O => \tx_data_in[23]_i_1_n_0\
    );
\tx_data_in[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(24),
      I2 => m_axi_rdata(24),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[24]_i_1_n_0\
    );
\tx_data_in[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(25),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(25),
      O => \tx_data_in[25]_i_1_n_0\
    );
\tx_data_in[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(26),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(26),
      O => \tx_data_in[26]_i_1_n_0\
    );
\tx_data_in[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(27),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(27),
      O => \tx_data_in[27]_i_1_n_0\
    );
\tx_data_in[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(28),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(28),
      O => \tx_data_in[28]_i_1_n_0\
    );
\tx_data_in[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(29),
      I2 => m_axi_rdata(29),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[29]_i_1_n_0\
    );
\tx_data_in[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(2),
      I2 => m_axi_rdata(2),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[2]_i_1_n_0\
    );
\tx_data_in[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(30),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(30),
      O => \tx_data_in[30]_i_1_n_0\
    );
\tx_data_in[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0E0F0E0F0E0"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(0),
      I2 => \FSM_onehot_state_reg_n_0_[2]\,
      I3 => m_axi_rdata(31),
      I4 => \FSM_onehot_state_reg_n_0_[0]\,
      I5 => max_angle(31),
      O => \tx_data_in[31]_i_2_n_0\
    );
\tx_data_in[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(3),
      I2 => m_axi_rdata(3),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[3]_i_1_n_0\
    );
\tx_data_in[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(4),
      I2 => m_axi_rdata(4),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[4]_i_1_n_0\
    );
\tx_data_in[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(5),
      I2 => m_axi_rdata(5),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[5]_i_1_n_0\
    );
\tx_data_in[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(6),
      I2 => m_axi_rdata(6),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[6]_i_1_n_0\
    );
\tx_data_in[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(7),
      I2 => m_axi_rdata(7),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[7]_i_1_n_0\
    );
\tx_data_in[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(8),
      I2 => m_axi_rdata(8),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[8]_i_1_n_0\
    );
\tx_data_in[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888888888F888"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => max_angle(9),
      I2 => m_axi_rdata(9),
      I3 => \FSM_onehot_state_reg_n_0_[2]\,
      I4 => m_axi_rresp(1),
      I5 => m_axi_rresp(0),
      O => \tx_data_in[9]_i_1_n_0\
    );
\tx_data_in_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[0]_i_1_n_0\,
      Q => tx_data_in(0)
    );
\tx_data_in_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[10]_i_1_n_0\,
      Q => tx_data_in(10)
    );
\tx_data_in_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[11]_i_1_n_0\,
      Q => tx_data_in(11)
    );
\tx_data_in_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[12]_i_1_n_0\,
      Q => tx_data_in(12)
    );
\tx_data_in_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[13]_i_1_n_0\,
      Q => tx_data_in(13)
    );
\tx_data_in_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[14]_i_1_n_0\,
      Q => tx_data_in(14)
    );
\tx_data_in_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[15]_i_1_n_0\,
      Q => tx_data_in(15)
    );
\tx_data_in_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[16]_i_1_n_0\,
      Q => tx_data_in(16)
    );
\tx_data_in_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[17]_i_1_n_0\,
      Q => tx_data_in(17)
    );
\tx_data_in_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[18]_i_1_n_0\,
      Q => tx_data_in(18)
    );
\tx_data_in_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[19]_i_1_n_0\,
      Q => tx_data_in(19)
    );
\tx_data_in_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[1]_i_1_n_0\,
      Q => tx_data_in(1)
    );
\tx_data_in_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[20]_i_1_n_0\,
      Q => tx_data_in(20)
    );
\tx_data_in_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[21]_i_1_n_0\,
      Q => tx_data_in(21)
    );
\tx_data_in_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[22]_i_1_n_0\,
      Q => tx_data_in(22)
    );
\tx_data_in_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[23]_i_1_n_0\,
      Q => tx_data_in(23)
    );
\tx_data_in_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[24]_i_1_n_0\,
      Q => tx_data_in(24)
    );
\tx_data_in_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[25]_i_1_n_0\,
      Q => tx_data_in(25)
    );
\tx_data_in_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[26]_i_1_n_0\,
      Q => tx_data_in(26)
    );
\tx_data_in_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[27]_i_1_n_0\,
      Q => tx_data_in(27)
    );
\tx_data_in_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[28]_i_1_n_0\,
      Q => tx_data_in(28)
    );
\tx_data_in_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[29]_i_1_n_0\,
      Q => tx_data_in(29)
    );
\tx_data_in_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[2]_i_1_n_0\,
      Q => tx_data_in(2)
    );
\tx_data_in_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[30]_i_1_n_0\,
      Q => tx_data_in(30)
    );
\tx_data_in_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[31]_i_2_n_0\,
      Q => tx_data_in(31)
    );
\tx_data_in_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[3]_i_1_n_0\,
      Q => tx_data_in(3)
    );
\tx_data_in_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[4]_i_1_n_0\,
      Q => tx_data_in(4)
    );
\tx_data_in_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[5]_i_1_n_0\,
      Q => tx_data_in(5)
    );
\tx_data_in_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[6]_i_1_n_0\,
      Q => tx_data_in(6)
    );
\tx_data_in_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[7]_i_1_n_0\,
      Q => tx_data_in(7)
    );
\tx_data_in_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[8]_i_1_n_0\,
      Q => tx_data_in(8)
    );
\tx_data_in_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => UART_RX_DECODER_inst_n_2,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \tx_data_in[9]_i_1_n_0\,
      Q => tx_data_in(9)
    );
tx_start_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CDCC"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[6]\,
      I1 => tx_start,
      I2 => \FSM_onehot_state_reg_n_0_[0]\,
      I3 => tx_start_reg_n_0,
      O => tx_start_i_1_n_0
    );
tx_start_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => UART_RX_DECODER_inst_n_9,
      D => tx_start_i_1_n_0,
      Q => tx_start_reg_n_0
    );
\uart_addr_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr(0),
      Q => uart_addr_reg(0)
    );
\uart_addr_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr(1),
      Q => uart_addr_reg(1)
    );
\uart_addr_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr(2),
      Q => uart_addr_reg(2)
    );
\uart_addr_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr(3),
      Q => uart_addr_reg(3)
    );
\uart_addr_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr(4),
      Q => uart_addr_reg(4)
    );
\uart_addr_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => uart_addr(5),
      Q => uart_addr_reg(5)
    );
\uart_data_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[4]\(0),
      Q => uart_data_reg(0)
    );
\uart_data_reg_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[3]\(2),
      Q => uart_data_reg(10)
    );
\uart_data_reg_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[3]\(3),
      Q => uart_data_reg(11)
    );
\uart_data_reg_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[3]\(4),
      Q => uart_data_reg(12)
    );
\uart_data_reg_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[3]\(5),
      Q => uart_data_reg(13)
    );
\uart_data_reg_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[3]\(6),
      Q => uart_data_reg(14)
    );
\uart_data_reg_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[3]\(7),
      Q => uart_data_reg(15)
    );
\uart_data_reg_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[2]\(0),
      Q => uart_data_reg(16)
    );
\uart_data_reg_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[2]\(1),
      Q => uart_data_reg(17)
    );
\uart_data_reg_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[2]\(2),
      Q => uart_data_reg(18)
    );
\uart_data_reg_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[2]\(3),
      Q => uart_data_reg(19)
    );
\uart_data_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[4]\(1),
      Q => uart_data_reg(1)
    );
\uart_data_reg_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[2]\(4),
      Q => uart_data_reg(20)
    );
\uart_data_reg_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[2]\(5),
      Q => uart_data_reg(21)
    );
\uart_data_reg_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[2]\(6),
      Q => uart_data_reg(22)
    );
\uart_data_reg_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[2]\(7),
      Q => uart_data_reg(23)
    );
\uart_data_reg_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[1]\(0),
      Q => uart_data_reg(24)
    );
\uart_data_reg_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[1]\(1),
      Q => uart_data_reg(25)
    );
\uart_data_reg_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[1]\(2),
      Q => uart_data_reg(26)
    );
\uart_data_reg_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[1]\(3),
      Q => uart_data_reg(27)
    );
\uart_data_reg_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[1]\(4),
      Q => uart_data_reg(28)
    );
\uart_data_reg_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[1]\(5),
      Q => uart_data_reg(29)
    );
\uart_data_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[4]\(2),
      Q => uart_data_reg(2)
    );
\uart_data_reg_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[1]\(6),
      Q => uart_data_reg(30)
    );
\uart_data_reg_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[1]\(7),
      Q => uart_data_reg(31)
    );
\uart_data_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[4]\(3),
      Q => uart_data_reg(3)
    );
\uart_data_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[4]\(4),
      Q => uart_data_reg(4)
    );
\uart_data_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[4]\(5),
      Q => uart_data_reg(5)
    );
\uart_data_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[4]\(6),
      Q => uart_data_reg(6)
    );
\uart_data_reg_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[4]\(7),
      Q => uart_data_reg(7)
    );
\uart_data_reg_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[3]\(0),
      Q => uart_data_reg(8)
    );
\uart_data_reg_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => uart_addr_reg_0,
      CLR => UART_RX_DECODER_inst_n_9,
      D => \SIPO_reg[3]\(1),
      Q => uart_data_reg(9)
    );
w_done_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[3]\,
      I1 => m_axi_wready,
      I2 => \^m_axi_wvalid\,
      O => w_done
    );
w_done_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => UART_RX_DECODER_inst_n_9,
      D => UART_RX_DECODER_inst_n_7,
      Q => w_done_reg_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_UART_TRANSACTION_HAN_0_0 is
  port (
    clk : in STD_LOGIC;
    reset_n : in STD_LOGIC;
    rx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_ready : in STD_LOGIC;
    uart_tx_ready : in STD_LOGIC;
    Word_To_Send : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Word_To_Send_en : out STD_LOGIC;
    max_angle : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_2_UART_TRANSACTION_HAN_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_2_UART_TRANSACTION_HAN_0_0 : entity is "design_2_UART_TRANSACTION_HAN_0_0,UART_TRANSACTION_HANDLER,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_2_UART_TRANSACTION_HAN_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_2_UART_TRANSACTION_HAN_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_2_UART_TRANSACTION_HAN_0_0 : entity is "UART_TRANSACTION_HANDLER,Vivado 2022.2";
end design_2_UART_TRANSACTION_HAN_0_0;

architecture STRUCTURE of design_2_UART_TRANSACTION_HAN_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^m_axi_araddr\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \^m_axi_awaddr\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \^m_axi_wstrb\ : STD_LOGIC_VECTOR ( 2 to 2 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF m_axi, FREQ_HZ 100285714, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_arready : signal is "xilinx.com:interface:aximm:1.0 m_axi ARREADY";
  attribute X_INTERFACE_INFO of m_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 m_axi ARVALID";
  attribute X_INTERFACE_INFO of m_axi_awready : signal is "xilinx.com:interface:aximm:1.0 m_axi AWREADY";
  attribute X_INTERFACE_INFO of m_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 m_axi AWVALID";
  attribute X_INTERFACE_INFO of m_axi_bready : signal is "xilinx.com:interface:aximm:1.0 m_axi BREADY";
  attribute X_INTERFACE_INFO of m_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 m_axi BVALID";
  attribute X_INTERFACE_INFO of m_axi_rready : signal is "xilinx.com:interface:aximm:1.0 m_axi RREADY";
  attribute X_INTERFACE_PARAMETER of m_axi_rready : signal is "XIL_INTERFACENAME m_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100285714, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 m_axi RVALID";
  attribute X_INTERFACE_INFO of m_axi_wready : signal is "xilinx.com:interface:aximm:1.0 m_axi WREADY";
  attribute X_INTERFACE_INFO of m_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 m_axi WVALID";
  attribute X_INTERFACE_INFO of reset_n : signal is "xilinx.com:signal:reset:1.0 reset_n RST";
  attribute X_INTERFACE_PARAMETER of reset_n : signal is "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 m_axi ARADDR";
  attribute X_INTERFACE_INFO of m_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 m_axi AWADDR";
  attribute X_INTERFACE_INFO of m_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 m_axi BRESP";
  attribute X_INTERFACE_INFO of m_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 m_axi RDATA";
  attribute X_INTERFACE_INFO of m_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 m_axi RRESP";
  attribute X_INTERFACE_INFO of m_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 m_axi WDATA";
  attribute X_INTERFACE_INFO of m_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 m_axi WSTRB";
begin
  m_axi_araddr(31) <= \<const0>\;
  m_axi_araddr(30) <= \<const0>\;
  m_axi_araddr(29) <= \<const0>\;
  m_axi_araddr(28) <= \<const0>\;
  m_axi_araddr(27) <= \<const0>\;
  m_axi_araddr(26) <= \<const0>\;
  m_axi_araddr(25) <= \<const0>\;
  m_axi_araddr(24) <= \<const0>\;
  m_axi_araddr(23) <= \<const0>\;
  m_axi_araddr(22) <= \<const0>\;
  m_axi_araddr(21) <= \<const0>\;
  m_axi_araddr(20) <= \<const0>\;
  m_axi_araddr(19) <= \<const0>\;
  m_axi_araddr(18) <= \<const0>\;
  m_axi_araddr(17) <= \<const0>\;
  m_axi_araddr(16) <= \<const0>\;
  m_axi_araddr(15) <= \<const0>\;
  m_axi_araddr(14) <= \<const0>\;
  m_axi_araddr(13) <= \<const0>\;
  m_axi_araddr(12) <= \<const0>\;
  m_axi_araddr(11) <= \<const0>\;
  m_axi_araddr(10) <= \<const0>\;
  m_axi_araddr(9) <= \<const0>\;
  m_axi_araddr(8) <= \<const0>\;
  m_axi_araddr(7) <= \<const0>\;
  m_axi_araddr(6) <= \<const0>\;
  m_axi_araddr(5 downto 0) <= \^m_axi_araddr\(5 downto 0);
  m_axi_awaddr(31) <= \<const0>\;
  m_axi_awaddr(30) <= \<const0>\;
  m_axi_awaddr(29) <= \<const0>\;
  m_axi_awaddr(28) <= \<const0>\;
  m_axi_awaddr(27) <= \<const0>\;
  m_axi_awaddr(26) <= \<const0>\;
  m_axi_awaddr(25) <= \<const0>\;
  m_axi_awaddr(24) <= \<const0>\;
  m_axi_awaddr(23) <= \<const0>\;
  m_axi_awaddr(22) <= \<const0>\;
  m_axi_awaddr(21) <= \<const0>\;
  m_axi_awaddr(20) <= \<const0>\;
  m_axi_awaddr(19) <= \<const0>\;
  m_axi_awaddr(18) <= \<const0>\;
  m_axi_awaddr(17) <= \<const0>\;
  m_axi_awaddr(16) <= \<const0>\;
  m_axi_awaddr(15) <= \<const0>\;
  m_axi_awaddr(14) <= \<const0>\;
  m_axi_awaddr(13) <= \<const0>\;
  m_axi_awaddr(12) <= \<const0>\;
  m_axi_awaddr(11) <= \<const0>\;
  m_axi_awaddr(10) <= \<const0>\;
  m_axi_awaddr(9) <= \<const0>\;
  m_axi_awaddr(8) <= \<const0>\;
  m_axi_awaddr(7) <= \<const0>\;
  m_axi_awaddr(6) <= \<const0>\;
  m_axi_awaddr(5 downto 0) <= \^m_axi_awaddr\(5 downto 0);
  m_axi_wstrb(3) <= \^m_axi_wstrb\(2);
  m_axi_wstrb(2) <= \^m_axi_wstrb\(2);
  m_axi_wstrb(1) <= \^m_axi_wstrb\(2);
  m_axi_wstrb(0) <= \^m_axi_wstrb\(2);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.design_2_UART_TRANSACTION_HAN_0_0_UART_TRANSACTION_HANDLER
     port map (
      Word_To_Send(7 downto 0) => Word_To_Send(7 downto 0),
      Word_To_Send_en => Word_To_Send_en,
      clk => clk,
      m_axi_araddr(5 downto 0) => \^m_axi_araddr\(5 downto 0),
      m_axi_arready => m_axi_arready,
      m_axi_arvalid => m_axi_arvalid,
      m_axi_awaddr(5 downto 0) => \^m_axi_awaddr\(5 downto 0),
      m_axi_awready => m_axi_awready,
      m_axi_awvalid => m_axi_awvalid,
      m_axi_bready => m_axi_bready,
      m_axi_bvalid => m_axi_bvalid,
      m_axi_rdata(31 downto 0) => m_axi_rdata(31 downto 0),
      m_axi_rready_reg_0 => m_axi_rready,
      m_axi_rresp(1 downto 0) => m_axi_rresp(1 downto 0),
      m_axi_rvalid => m_axi_rvalid,
      m_axi_wdata(31 downto 0) => m_axi_wdata(31 downto 0),
      m_axi_wready => m_axi_wready,
      m_axi_wstrb(0) => \^m_axi_wstrb\(2),
      m_axi_wvalid => m_axi_wvalid,
      max_angle(31 downto 0) => max_angle(31 downto 0),
      reset_n => reset_n,
      rx_data(7 downto 0) => rx_data(7 downto 0),
      rx_ready => rx_ready,
      uart_tx_ready => uart_tx_ready
    );
end STRUCTURE;

-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Tue Dec 30 17:54:36 2025
-- Host        : AustinsPC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top cmpy_rxx -prefix
--               cmpy_rxx_ cmpy_rxx_stub.vhdl
-- Design      : cmpy_rxx
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cmpy_rxx is
  Port ( 
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_a_tvalid : in STD_LOGIC;
    s_axis_a_tready : out STD_LOGIC;
    s_axis_a_tuser : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_a_tlast : in STD_LOGIC;
    s_axis_a_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_b_tvalid : in STD_LOGIC;
    s_axis_b_tready : out STD_LOGIC;
    s_axis_b_tuser : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_b_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_dout_tvalid : out STD_LOGIC;
    m_axis_dout_tready : in STD_LOGIC;
    m_axis_dout_tuser : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_dout_tlast : out STD_LOGIC;
    m_axis_dout_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end cmpy_rxx;

architecture stub of cmpy_rxx is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,aresetn,s_axis_a_tvalid,s_axis_a_tready,s_axis_a_tuser[1:0],s_axis_a_tlast,s_axis_a_tdata[31:0],s_axis_b_tvalid,s_axis_b_tready,s_axis_b_tuser[1:0],s_axis_b_tdata[31:0],m_axis_dout_tvalid,m_axis_dout_tready,m_axis_dout_tuser[3:0],m_axis_dout_tlast,m_axis_dout_tdata[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "cmpy_v6_0_21,Vivado 2022.2";
begin
end;

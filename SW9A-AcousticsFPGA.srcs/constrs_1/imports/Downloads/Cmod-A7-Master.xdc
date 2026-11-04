## ============================================================
## 12 MHz Clock
## ============================================================

set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33} [get_ports {clk_12MHz}]
create_clock -add -name sys_clk_pin -period 83.333 -waveform {0 41.667} [get_ports {clk_12MHz}]


## ============================================================
## Reset
## Uses Cmod A7 button 0
## ============================================================

set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports {reset}]


## ============================================================
## UART
##
## PC TX -> FPGA RX
## FPGA TX -> PC RX
## ============================================================

set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {RX_data_in}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {Tx_data_out}]


## ============================================================
## XADC VAUX5
## ============================================================

set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33} [get_ports {Vaux5_0_v_n}]
set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports {Vaux5_0_v_p}]


## ============================================================
## XADC VAUX6
## ============================================================

set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports {Vaux6_0_v_n}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {Vaux6_0_v_p}]


## ============================================================
## XADC VAUX7
## ============================================================

set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports {Vaux7_0_v_n}]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports {Vaux7_0_v_p}]


## ============================================================
## XADC VAUX13
## ============================================================

set_property -dict {PACKAGE_PIN L2 IOSTANDARD LVCMOS33} [get_ports {Vaux13_0_v_n}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {Vaux13_0_v_p}]


## ============================================================
## XADC VAUX14
## ============================================================

set_property -dict {PACKAGE_PIN M3 IOSTANDARD LVCMOS33} [get_ports {Vaux14_0_v_n}]
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports {Vaux14_0_v_p}]


## ============================================================
## XADC VAUX15
## ============================================================

set_property -dict {PACKAGE_PIN N1 IOSTANDARD LVCMOS33} [get_ports {Vaux15_0_v_n}]
set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS33} [get_ports {Vaux15_0_v_p}]

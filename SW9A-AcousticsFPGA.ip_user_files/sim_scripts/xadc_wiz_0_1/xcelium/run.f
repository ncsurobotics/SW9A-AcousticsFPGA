-makelib xcelium_lib/xpm -sv \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../SW9A-AcousticsFPGA.gen/sources_1/ip/xadc_wiz_0_1/xadc_wiz_0_drp_arbiter.vhd" \
  "../../../../SW9A-AcousticsFPGA.gen/sources_1/ip/xadc_wiz_0_1/xadc_wiz_0_drp_to_axi_stream.vhd" \
  "../../../../SW9A-AcousticsFPGA.gen/sources_1/ip/xadc_wiz_0_1/xadc_wiz_0_xadc_core_drp.vhd" \
  "../../../../SW9A-AcousticsFPGA.gen/sources_1/ip/xadc_wiz_0_1/xadc_wiz_0_axi_xadc.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../SW9A-AcousticsFPGA.gen/sources_1/ip/xadc_wiz_0_1/xadc_wiz_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib


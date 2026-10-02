vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../../SW9A-AcousticsFPGA.gen/sources_1/ip/xadc_wiz_0_1/xadc_wiz_0_drp_arbiter.vhd" \
"../../../../SW9A-AcousticsFPGA.gen/sources_1/ip/xadc_wiz_0_1/xadc_wiz_0_drp_to_axi_stream.vhd" \
"../../../../SW9A-AcousticsFPGA.gen/sources_1/ip/xadc_wiz_0_1/xadc_wiz_0_xadc_core_drp.vhd" \
"../../../../SW9A-AcousticsFPGA.gen/sources_1/ip/xadc_wiz_0_1/xadc_wiz_0_axi_xadc.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  \
"../../../../SW9A-AcousticsFPGA.gen/sources_1/ip/xadc_wiz_0_1/xadc_wiz_0.v" \

vlog -work xil_defaultlib \
"glbl.v"


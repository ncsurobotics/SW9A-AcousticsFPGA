onbreak resume
onerror resume
vsim -voptargs=+acc work.hilbert_fir_filter_1027_tb

add wave sim:/hilbert_fir_filter_1027_tb/u_hilbert_fir_filter_1027/clk
add wave sim:/hilbert_fir_filter_1027_tb/u_hilbert_fir_filter_1027/reset
add wave sim:/hilbert_fir_filter_1027_tb/u_hilbert_fir_filter_1027/clk_enable
add wave sim:/hilbert_fir_filter_1027_tb/u_hilbert_fir_filter_1027/dataIn
add wave sim:/hilbert_fir_filter_1027_tb/u_hilbert_fir_filter_1027/validIn
add wave sim:/hilbert_fir_filter_1027_tb/u_hilbert_fir_filter_1027/resetIn
add wave sim:/hilbert_fir_filter_1027_tb/u_hilbert_fir_filter_1027/ce_out
add wave sim:/hilbert_fir_filter_1027_tb/u_hilbert_fir_filter_1027/dataOut
add wave sim:/hilbert_fir_filter_1027_tb/dataOut_ref
add wave sim:/hilbert_fir_filter_1027_tb/u_hilbert_fir_filter_1027/validOut
add wave sim:/hilbert_fir_filter_1027_tb/validOut_ref
run -all

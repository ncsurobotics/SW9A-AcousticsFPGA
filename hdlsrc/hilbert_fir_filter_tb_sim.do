onbreak resume
onerror resume
vsim -voptargs=+acc work.hilbert_fir_filter_tb

add wave sim:/hilbert_fir_filter_tb/u_hilbert_fir_filter/clk
add wave sim:/hilbert_fir_filter_tb/u_hilbert_fir_filter/reset
add wave sim:/hilbert_fir_filter_tb/u_hilbert_fir_filter/clk_enable
add wave sim:/hilbert_fir_filter_tb/u_hilbert_fir_filter/dataIn
add wave sim:/hilbert_fir_filter_tb/u_hilbert_fir_filter/validIn
add wave sim:/hilbert_fir_filter_tb/u_hilbert_fir_filter/ce_out
add wave sim:/hilbert_fir_filter_tb/u_hilbert_fir_filter/dataOut
add wave sim:/hilbert_fir_filter_tb/dataOut_ref
add wave sim:/hilbert_fir_filter_tb/u_hilbert_fir_filter/validOut
add wave sim:/hilbert_fir_filter_tb/validOut_ref
run -all

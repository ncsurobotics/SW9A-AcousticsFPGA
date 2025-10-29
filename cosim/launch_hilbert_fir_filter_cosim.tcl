
# Save off existing xsim.dir
if {[file exists xsim.dir] == 1} {
    set mtime [file mtime xsim.dir]
    set mtimestamp [clock format $mtime -format %Y%m%d_%H%M%S]
    set xsim_savefile "xsim.dir.$mtimestamp"
    file rename xsim.dir $xsim_savefile
}

 set hdlsrc {C:\Users\Aweso\MATLAB\codegen\hilbert_fir_filter\hdlsrc}
exec xvlog $hdlsrc/FilterCoef.v
exec xvlog $hdlsrc/FilterTapSystolicPreAddWvlIn.v
exec xvlog $hdlsrc/FilterTapSystolicWvldInC0.v
exec xvlog $hdlsrc/subFilter.v
exec xvlog $hdlsrc/Filter.v
exec xvlog $hdlsrc/dsphdl_FIRFilter.v
exec xvlog $hdlsrc/hilbert_fir_filter.v

exec xelab hilbert_fir_filter --timescale 1ps/1ps --override_timeunit --override_timeprecision -dll --snapshot design -debug wave 



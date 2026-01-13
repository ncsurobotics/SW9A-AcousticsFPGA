onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib cmpy_rxx_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {cmpy_rxx.udo}

run 1000ns

quit -force

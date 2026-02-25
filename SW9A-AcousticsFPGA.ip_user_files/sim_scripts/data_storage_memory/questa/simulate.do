onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib data_storage_memory_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {data_storage_memory.udo}

run 1000ns

quit -force

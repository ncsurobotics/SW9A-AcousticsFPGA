onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib cmpy_dot_product_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {cmpy_dot_product.udo}

run 1000ns

quit -force

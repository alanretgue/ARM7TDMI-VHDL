vlib work
vcom -93 ../../src/extend_sign.vhd
vcom -93 extend_sign_tb.vhd

vsim mux21_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

add wave CLK

add wave -radix hexadecimal E
add wave -radix hexadecimal S

run -a
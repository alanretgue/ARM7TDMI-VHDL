vlib work
vcom -93 ../../src/mux21.vhd
vcom -93 mux21_tb.vhd

vsim mux21_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

add wave CLK

add wave -radix binary COM
add wave -radix hexadecimal A
add wave -radix hexadecimal B
add wave -radix hexadecimal S

run -a
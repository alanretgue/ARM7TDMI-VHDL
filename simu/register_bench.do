vlib work
vcom -93 ../src/register_bench.vhd
vcom -93 register_bench_tb.vhd

vsim register_bench_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

add wave CLK
add wave Reset

add wave -radix hexadecimal RA
add wave -radix hexadecimal RB
add wave -radix hexadecimal RW

add wave -radix hexadecimal A
add wave -radix hexadecimal B
add wave -radix hexadecimal W
add wave -radix binary WE

run -a
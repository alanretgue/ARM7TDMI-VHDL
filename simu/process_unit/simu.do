vlib work
vcom -93 ../../src/alu.vhd
vcom -93 ../../src/register_bench.vhd
vcom -93 ../../src/process_unit.vhd
vcom -93 process_unit_tb.vhd

vsim process_unit_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

add wave CLK
add wave Reset

add wave -radix hexadecimal RA
add wave -radix hexadecimal RB
add wave -radix hexadecimal RW

add wave -radix binary OP
add wave -radix binary WE
add wave -radix binary Z
add wave -radix binary N
add wave -radix binary V
add wave -radix binary C

add wave -radix hexadecimal sim:/process_unit_tb/P/REG/A
add wave -radix hexadecimal sim:/process_unit_tb/P/REG/B
add wave -radix hexadecimal sim:/process_unit_tb/P/REG/W

run -a
vlib work
-- compile entity needed
vcom -2008 ../../src/alu.vhd
vcom -2008 ../../src/register_bench.vhd
vcom -2008 ../../src/mux21.vhd
vcom -2008 ../../src/extend_sign.vhd
vcom -2008 ../../src/data_memory.vhd

vcom -2008 ../../src/process_unit_2.vhd
vcom -2008 process_unit_2_tb.vhd

vsim process_unit_2_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

add wave CLK
add wave Reset

add wave -radix hexadecimal RA
add wave -radix hexadecimal RB
add wave -radix hexadecimal RW

add wave -radix hexadecimal BLA

run -a
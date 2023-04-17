vlib work
vcom -2008 ../../src/data_memory.vhd
vcom -2008 data_memory_tb.vhd

vsim data_memory_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

add wave CLK
add wave Reset

add wave -radix binary Addr
add wave -radix binary WrEn

add wave -radix hexadecimal DataIn
add wave -radix hexadecimal DataOut

run -a

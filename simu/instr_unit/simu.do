vlib work
vcom -2008 ../../src/instr_memory.vhd
vcom -2008 ../../src/mux21.vhd
vcom -2008 ../../src/pc.vhd
vcom -2008 ../../src/extend_sign.vhd

vcom -2008 ../../src/instr_unit.vhd
vcom -2008 instr_unit_tb.vhd

vsim instr_unit_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

add wave CLK
add wave Reset

add wave -radix binary nPCsel
add wave -radix decimal offset
add wave -radix hexadecimal instruction

run -a
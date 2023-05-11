vlib work

-- compile entity needed
vcom -2008 ../../src/alu.vhd
vcom -2008 ../../src/register_bench.vhd
vcom -2008 ../../src/seven_segment.vhd
vcom -2008 ../../src/mux21.vhd
vcom -2008 ../../src/extend_sign.vhd
vcom -2008 ../../src/data_memory.vhd
vcom -2008 ../../src/register_psr.vhd
vcom -2008 ../../src/register_and_memory.vhd
vcom -2008 ../../src/instr_memory.vhd
vcom -2008 ../../src/pc.vhd
vcom -2008 ../../src/instr_unit.vhd
vcom -2008 ../../src/decoder.vhd

vcom -2008 ../../src/top_level.vhd
vcom -2008 top_level_tb.vhd

vsim top_level_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

add wave CLK
add wave Reset

add wave -radix hexadecimal RegisterBench
add wave -radix hexadecimal DataBench
add wave -position 3 -radix hexadecimal sim:/top_level_tb/P/Instruction
add wave -position 4 sim:/top_level_tb/P/Dec/RegWr
add wave -position 5 sim:/top_level_tb/P/REG_PSR/DATAIN
add wave -position 6 sim:/top_level_tb/P/REG_PSR/DATAOUT
add wave -position 7 sim:/top_level_tb/P/nPCSel
add wave -position end sim:/top_level_tb/P/REGISTER_AND_MEMORY/Afficheur

add wave -position end  sim:/top_level_tb/P/HEX0
add wave -position end  sim:/top_level_tb/P/HEX1
add wave -position end  sim:/top_level_tb/P/HEX2
add wave -position end  sim:/top_level_tb/P/HEX3

run -a
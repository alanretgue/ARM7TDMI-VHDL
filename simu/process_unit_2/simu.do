vlib work
-- compile entity needed
vcom -93 ../../src/alu.vhd
vcom -93 ../../src/register_bench.vhd
vcom -93 ../../src/mux21.vhd
vcom -93 ../../src/extend_sign.vhd
vcom -93 ../../src/data_memory.vhd

vcom -93 ../../src/process_unit_2.vhd
-- vcom -93 process_unit_2_tb.vhd

-- vsim process_unit_2_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

-- add wave CLK
-- add wave Reset

-- add wave -radix hexadecimal RA
-- add wave -radix hexadecimal RB
-- add wave -radix hexadecimal RW

-- add wave -radix hexadecimal A
-- add wave -radix hexadecimal B
-- add wave -radix hexadecimal W
-- add wave -radix binary WE

-- run -a
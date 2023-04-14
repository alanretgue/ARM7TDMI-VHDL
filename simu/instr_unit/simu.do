vlib work
vcom -93 ../../src/instr_memory.vhd
vcom -93 ../../src/mux21.vhd
vcom -93 ../../src/pc.vhd
vcom -93 ../../src/extend_sign.vhd

vcom -93 ../../src/instr_unit.vhd
-- vcom -93 instr_unit_tb.vhd

-- vsim instr_unit_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

-- run -a
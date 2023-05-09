vlib work

-- compile entity needed
vcom -2008 ../../src/vic.vhd

vcom -2008 vic_tb.vhd

vsim vic_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

add wave CLK
add wave Reset

add wave -radix hexadecimal VICPC
add wave IRQ_SERV
add wave IRQ0
add wave IRQ1

run -a
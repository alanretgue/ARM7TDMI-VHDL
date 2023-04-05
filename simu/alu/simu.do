vlib work
vcom -93 ../../src/alu.vhd
vcom -93 alu_tb.vhd

vsim alu_tb

add wave CLK
add wave -radix octal OP
add wave -radix hexadecimal A
add wave -radix hexadecimal B
add wave -radix hexadecimal S
add wave -radix binary Z
add wave -radix binary C
add wave -radix binary N
add wave -radix binary V

run -a
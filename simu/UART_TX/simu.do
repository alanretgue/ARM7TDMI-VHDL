vlib work

-- compile entity needed
vcom -2008 ../../src/UART_TX.vhd

vcom -2008 UART_TX_tb.vhd

vsim UART_TX_tb

set StdArithNoWarnings 1
set NumericStdNoWarnings 1

add wave CLK
add wave Reset

add wave TX
add wave state
add wave Tick_bit
add wave -position end  sim:/uart_tx_tb/G/cnt_bit


run -a
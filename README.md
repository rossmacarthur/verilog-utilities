# Verilog Utilities

Some utility modules for use in HDL applications.

### PmodDA4

Continuously sends the 12-bit unsigned input value via SPI to the PmodDA4. This module utilises an FSM in order to setup the internal reference voltage of the PmodDA4.

### SevenSegment

A multi seven-segment display controller. The module assumes that the segment lines go to all of the displays. The module cycles through selecting each of the displays and outputs the corresponding display value for each of them. The module is also parameterised for any number of displays.

### VGA

A 1024 x 768 resolution Video Graphics Array (VGA) controller. The module takes a pixel clock and has two counters, one for the horizontal direction and one for the vertical direction. The counters count the addressable pixel values and append the required front porch, sync and back porch times before repeating the cycle.

### UART

Both the transmitter and receiver use a 10 bit data frame (start bit, stop bit and one byte of data). The receiver needs a clock of 16 times the baudrate for correct sampling.

## Debounce

Simple button (or any signal) debouncer. This uses 3 flip flops that are clocked at 190 Hz and each driven from the previous flip flop. Only when all flip flops are outputting a high does the output go high. This corresponds to about a 15 ms debounce time. 

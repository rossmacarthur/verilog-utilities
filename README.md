# Verilog Utilities

Each folder in this repository contains the Verilog module(s) for the utility and a top level Driver entity that demonstrates/tests the utility module(s). Some utilities may be used when demonstrating others. All constraints files are targeted to a Nexys4 Artix-7 FPGA and all demonstrative tests are accompanied with a Xilinx ISE project file.

### VGA

*A 1024 x 768 resolution Video Graphics Array (VGA) controller.*

The module takes a pixel clock and has two counters, one for the horizontal direction and one for the vertical direction. The counters coount the addressable pixel values and append the required front porch, sync and back porch times before repeating the cycle.

This is demonstrated by outputting a full 12 bit color spectrum (see below for expected output). The pixel clock of 65 MHz is achieved using a Xilinx generated core.

![expected output](vga_output.jpg)

### UART

*A universal asynchronous receiver/transmitter (UART).*

Both the transmitter and receiver use a 10 bit data frame (start bit, stop bit and one byte of data). The receiver needs a clock of 16 times the baudrate for correct sampling.

A Python script is provided for testing at a baudrate of 65000 Hz where you can send and receive a single character. When pressing a button the transmitter sends the values present on the first 8 switches. The receiver, when enabled using a toggle switch, displays the received byte on the LEDs.

### Debounce

*Simple button (or any signal) debouncer.*

This uses 3 flip flops that are clocked at 190 Hz and each driven from the previous flip flop. Only when all flip flops are outputting a high does the output go high. This corresponds to about a 15 ms debounce time. 

This is tested by incrementing a counter when pressing button and displaying this counter value on the LEDs. It can be observed that it only increments by one each time.
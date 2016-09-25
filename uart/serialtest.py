#!/usr/bin/python

import serial

ser = serial.Serial(port='/dev/ttyUSB1', baudrate=62500)

while True:
    ser.write(raw_input("Enter a char: "))
    r = ser.read()
    print "{:08b}{:>7}".format(ord(r), r)

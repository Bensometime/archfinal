#simple middleware script which takes 3 values for the rgb of a color
#and sets a string of lights to that color

import sys
import os
import board
import neopixel

pixels = neopixel.NeoPixel(board.D18, 30)

#turn the pixels off
pixels.fill((0,0,0))

#loop forever
while True:
    #get a new line of input (piped in by main.asm)
    inputstring = sys.stdin.readline()
    #split the string on spaces, making the rgb values easily accessible
    parsed = inputstring.split(" ")
    #cast the split values to ints and set the LEDs to be that color
    pixels.fill((int(parsed[0]),int(parsed[1]),int(parsed[2])))

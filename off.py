#technically not a part of my final, a simple script to set all the LEDs
#to off

import sys
import os
import board
import neopixel

pixels = neopixel.NeoPixel(board.D18, 30)
pixels.fill((0,0,0))

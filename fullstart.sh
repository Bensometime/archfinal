#linux script to start the presentation version of the project with LEDs
#requires a raspberry pi with adafruit neopixel configured and set up
#on pin 18 
node chatfetch | java -jar mars.jar nc main.asm | python3 mips2led.py

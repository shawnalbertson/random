# The lights in our room
The super fun and exciting lights hanging above the bed in our room (209 Florentia St, Seattle) as of 11/20/23 are neopixels, powered and controlled by Arduino Nano. 

## General use
Arduino (mounted in pink PLA) has USB wire which can be plugged into the power bank which sits next to it. Plug in to turn on, unplug to turn off

## Change the color
1. [Choose color!](https://www.rapidtables.com/web/color/RGB_Color.html) Find its corresponding RGB values. We can change brightness by scaling the values up or down.
2. Find Shawn's old Macbook from URI
3. Open Documents/Arduino/simple.ino
4. Find the part of the script that sets r, g, b values to a number. Should happen near the top.
5. Plug arduino (on shelf) into Macbook
6. Near the top left of Arduino IDE, should be a right facing arrow --> which will upload the script to the arduino. Press it
7. Watch in wonder as lights magically change

## Hopes and dreams
- Put the code from simple.ino on github so we can collaborate on it!
- Some kind of hardware interface which would allow us to
  - switch on/off without unplugging
  - dim without changing color
  - change color
![bed_lighting](pics/bed_lighting.png)

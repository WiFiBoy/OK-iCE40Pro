================================================
nes-snake demo rom for OK:iCE40 fpga dev console
================================================

Thanks to https://8bitworkshop.com for the great nes game dev platform.

Please goto 8bitworkshop online dev web and create a new project to
include our demo files: snake.c, music.h, chr_generic.s

And you'll see the autorun nes-snake emu game on screen.
You can download the .nes rom file and convert it to ok-ice40 .bin file:

$ ./nes2bin.py snake.nes snake.bin

and flash it to OK:iCE40 console:

$ iceprog -o 0x100000 snake.bin

or use icegreen.py to flash to OK:iCE40 iceGreen bootloader:

$ ./icegreen.py -p /dev/ttyACM0 -w snake.bin -a 0x100000

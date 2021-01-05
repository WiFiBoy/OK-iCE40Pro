/*
 * Character Map Example (on 32bit RISC-V core, picosoc)
 * Jan-2-21 tklua@wifiboy.org
 */

#include "lcd.h"
#include "clkcnt.h"

uint32_t _rnd=12345679; // random seed

uint32_t rand()
{
    _rnd = (_rnd*733+997) & 0x0000ffff;
    return _rnd;
}

void main()
{
    uint16_t x, y;
    
	lcd_init();                     // initialize LCD
	lcd_fillScreen(COLOR_BLACK);    // clear screen, check lcd.h for colors
	lcd_on();                       // turn on LCD backlight 

	while(1) {
	    x = (rand()/1000)%20;
	    y = (rand()/1000)%16;
	    lcd_drawChar(x*8, y*8, x+y*16, rand()%65536, COLOR_BLACK);
	}
}

/*
 * UART Terminal Fun Example (on 32bit RISC-V core, picosoc)
 * Jan-2-21 tklua@wifiboy.org
 */

#include "lcd.h"
#include "acia.h"

void main()
{
    uint16_t x, y;
    int ch;
    
	lcd_init();                     // initialize LCD
	lcd_fillScreen(COLOR_BLACK);    // clear screen, check lcd.h for colors
	lcd_on();                       // turn on LCD backlight 
	
	lcd_drawChar(0, 0, '>', COLOR_CYAN, COLOR_BLACK);
    acia_puts("\n\r\n\rOK:iCE40Pro UART Test\n\r>");
    x=1; y=0;
	while(1) {
	    lcd_drawChar(x*8, y*10, 16, COLOR_YELLOW, COLOR_BLACK);
	    while((ch=acia_getc())==-1);
	    acia_putc((char)ch); // echo back
	    if (ch!=13) lcd_drawChar(x*8, y*10, ch, COLOR_GREEN, COLOR_BLACK);
	    else lcd_drawChar(x*8, y*10, 16, COLOR_BLACK, COLOR_BLACK);
	    x++;
	    if ((ch==13) || (x>19)) {
	        x=0; y++;
	        acia_puts("\n\r>");
	        spkr=10000;
	        if (y>11) {
	            x=0; y=0;
	            lcd_fillScreen(COLOR_BLACK);
	            spkr=20000;
	        }
	        lcd_drawChar(x*8, y*10, '>', COLOR_CYAN, COLOR_BLACK);
	        x++;
	    } else spkr=5000;
	}
}

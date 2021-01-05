/*
 * Hello Example (on 32bit RISC-V core, picosoc)
 * Jan-2-21 tklua@wifiboy.org
 */

#include "lcd.h"
#include "acia.h"

void main()
{
	lcd_init();                     // initialize LCD
	
	lcd_fillScreen(COLOR_BLACK);    // clear screen, check lcd.h for colors
	
	lcd_drawStr(24,30,"Hello, RISC-V!", COLOR_GREEN, COLOR_BLACK);
	lcd_emptyRect(24, 70, 112, 24, COLOR_RED);
    lcd_drawStr(32,78,"OK-iCE40 Pro", COLOR_YELLOW, COLOR_BLACK);

	lcd_on();                    // turn on LCD backlight 
	
	acia_puts("\n\rHello, OK:iCE40Pro!\n\r"); // UART 115200bps, /dev/ttyUSB1 or COMx
}

/*
 * Show BMP image Example (on 32bit RISC-V core, picosoc)
 * Jan-2-21 tklua@wifiboy.org
 *
 * Before running this example, please upload a bmp image to 0x20000 first!
 *
 * Prepare a 160x128 RGB565-16bit BMP (Microsoft format)
 * Then flash this bmp to OK:iCE40 Pro console:
 * $ iceprog -o 0x20000 image.bmp
 *
 */

#include "lcd.h"
#include "flash.h"

void show_screen(int addr)
{
	uint8_t buf[320];
	int blitaddr, blitsz;
	uint8_t tmp;
	
	blitaddr = addr;
	blitsz = 320;
	for(int i=0;i<128;i++)
	{
		flash_read(SPI0, (uint8_t *)buf, blitaddr, blitsz);
		for(int j=0; j<blitsz; j+=2) {
		    tmp=buf[j]; buf[j]=buf[j+1]; buf[j+1]=tmp; // reverse byte order
		}
		lcd_blit(0, 127-i, 160, 1, (uint16_t *)buf);
		blitaddr += blitsz;
	}
}

void main()
{
	lcd_init();                 // initialize LCD
	lcd_off();
	flash_init(SPI0);           // wake up the flash chip
	show_screen(0x20046);       // show bmp address 0x20000
	lcd_on();                   // turn on LCD backlight 
}

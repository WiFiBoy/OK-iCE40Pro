/*
 * Random Lines Drawing Example (picorv32, picosoc)
 * 12-16-20 tklua@wifiboy.org
 */

#include "acia.h"
#include "clkcnt.h"
#include "lcd.h"

int i;

char buf[16];
void itoa4(char *buf, uint32_t val) // 4 digits itoa()
{
    buf[4]=0;
    for(i=3; i>=0; i--) {
        buf[i] = (char)(val % 10)+48;
        val /= 10;
    }
}

uint32_t _rnd;
uint32_t rand()
{
    _rnd = (_rnd*733+997)&0x0fffffff;
    return _rnd;
}

uint8_t get_key(void)
{
    return(uint8_t)((127-(gp_in & 0x7F)));
}

void system_init()
{
	lcd_init();     // initialize LCD
	
	lcd_fillScreen(COLOR_BLACK); // clear screen
	lcd_emptyRect(0,0, 160, 128, COLOR_RED);
	lcd_drawStr(12,20,"Random Lines Demo", COLOR_GREEN, COLOR_BLACK);
	lcd_drawStr(16,56,"for OK:iCE40 Pro", COLOR_CYAN, COLOR_BLACK);
	lcd_drawStr(20,110,"Any Key to Play", COLOR_YELLOW, COLOR_BLACK);
	lcd_on(); // turn on LCD backlight 
	
	clkcnt_reg = 0;         //
	while(get_key()==0);    // make a human-made random seed
	_rnd = clkcnt_reg;      //
	
	lcd_fillScreen(COLOR_BLACK);
	lcd_drawStr(32,0,"lines/second", COLOR_GREEN, COLOR_BLACK);
}

void main()
{
    int x0, y0, x1, y1, color, count;
    
	system_init(); // game setup()
	        
	clkcnt_reg = 0;
	count = 0;
	while(1) { // game loop()
	    x0 = rand() % 160;
	    y0 = rand() % 120+8;
	    x1 = rand() % 160;
	    y1 = rand() % 120+8;
	    color = rand() % 65536;
	    
	    lcd_drawLine(x0, y0, x1, y1, color);

	    count++;
	    if (clkcnt_reg > 24000000) {// 1 second
	        itoa4(buf, count);
            lcd_drawStr(0,0, buf, COLOR_RED, COLOR_BLACK);
            count = 0;
	        clkcnt_reg = 0;
	    }
	    if (get_key()>0) {
	        spkr = 100000; // make a sound (divider=50000, 24000000/100000=240hz)
	        while(get_key() > 0);
	        lcd_fillRect(0, 8, 160, 120, COLOR_BLACK);
	        count = 0;
	        clkcnt_reg = 0;
	    }
	}
}

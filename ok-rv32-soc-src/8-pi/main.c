/*
 * Pi Calculation Example (on 32bit RISC-V core, picosoc)
 * Jan-2-21 tklua@wifiboy.org
 
 3.14159265358979323846264338327950288419716939937510
   58209749445923078164062862089986280348253421170679
   82148086513282306647093844609550582231725359408128
   48111745028410270193852110555964462294895493038196
   44288109756659334461284756482337867831652712019091
   45648566923460348610454326648213393607260249141273
   72458700660631558 (317 digits)
 */
 
#include "lcd.h"
#include "acia.h"
#define N 318
int32_t a[1061], cx=0, cy=0;

void draw_digit(char c)
{
    if (cy<=120) lcd_drawChar(cx, cy, c, COLOR_GREEN, COLOR_BLACK);
    cx+=8; if (cx>152) {cx=0; cy+=8;}
    acia_putc(c);
}

void main()
{
    int32_t i,j,x,k,q,nines=0,predigit=0,len;
    
    lcd_init();                 // initialize LCD
    lcd_fillScreen(COLOR_BLACK);  // clear screen, check lcd.h for colors
	lcd_on();                   // turn on LCD backlight 
	
    acia_puts("\n\rPi=");
    len = (10*N/3)+1;
    for(i=0; i<len; i++) a[i]=2;
    for(j=1; j<N+1; j++) {        
        q=0; if (j==3) draw_digit('.');
        for(i=len; i>0; i--) {
            x = 10*a[i-1]+q*i; a[i-1] = x%(2*i-1); q = x/(2*i-1);
        }
        a[0]=q%10; q=q/10;
        if (q==10) {
            draw_digit(predigit+49);
            for(k=0; k<nines; k++) draw_digit(48);
            predigit=0; nines=0;
        } else {
            draw_digit(predigit+48); predigit=q;
            if (nines!=0) {    
                for(k=0; k<nines; k++) draw_digit(57); 
                nines=0;
            }
        }
    }
    draw_digit(predigit+48); 
    lcd_drawChar(0, 0, '=', COLOR_RED, COLOR_BLACK);
    acia_puts("\n\r");
}

/*
 * lcd.h - ST7735 LCD driver
 * 07-03-19 E. Brombaugh
 * 12-08-20 tklua@wifiboy.org
 */
#include "lcd.h"
#include "spi.h"
#include "clkcnt.h"
#include "font_8x8.h"

#define LCD_DC_CMD()    (gp_out&=~(1<<30))
#define LCD_DC_DATA()   (gp_out|=(1<<30))
#define LCD_RST_LOW()   (gp_out&=~(1<<31))
#define LCD_RST_HIGH()  (gp_out|=(1<<31))
#define LCD_BL_ON()     (gp_out&=~(1))
#define LCD_BL_OFF()    (gp_out|=(1))
#define LCD_CMD 0x100
#define LCD_DLY 0x200
#define LCD_END 0x400

/* some flags for init */
#define INITR_GREENTAB 0x0
#define INITR_REDTAB   0x1
#define LCD_NOP     0x00
#define LCD_SWRESET 0x01
#define LCD_RDDID   0x04
#define LCD_RDDST   0x09
#define LCD_SLPIN   0x10
#define LCD_SLPOUT  0x11
#define LCD_PTLON   0x12
#define LCD_NORON   0x13

#define LCD_INVOFF  0x20
#define LCD_INVON   0x21
#define LCD_GAMMASET 0x26
#define LCD_DISPOFF 0x28
#define LCD_DISPON  0x29
#define LCD_CASET   0x2A
#define LCD_RASET   0x2B
#define LCD_RAMWR   0x2C
#define LCD_RAMRD   0x2E
#define LCD_PTLAR   0x30
#define LCD_PIXFMT  0x3A
#define LCD_MADCTL  0x36
#define LCD_FRMCTR1 0xB1
#define LCD_FRMCTR2 0xB2
#define LCD_FRMCTR3 0xB3
#define LCD_INVCTR  0xB4
#define LCD_DFUNCTR 0xB6
#define LCD_PWCTR1  0xC0
#define LCD_PWCTR2  0xC1
#define LCD_PWCTR3  0xC2
#define LCD_PWCTR4  0xC3
#define LCD_PWCTR5  0xC4
#define LCD_VMCTR1  0xC5
#define LCD_VMCTR2  0xC7
#define LCD_RDID1   0xDA
#define LCD_RDID2   0xDB
#define LCD_RDID3   0xDC
#define LCD_RDID4   0xDD
#define LCD_PWCTR6  0xFC
#define LCD_GMCTRP1 0xE0
#define LCD_GMCTRN1 0xE1

const static uint16_t initlst[] = {
	0x1 | LCD_CMD,           // Soft Reset
	100 | LCD_DLY,            //  100 ms delay
	0x11 | LCD_CMD,           // Exit Sleep
	100 | LCD_DLY,            //  120 ms delay
	0xB1 | LCD_CMD,
	0x05, 0x3C, 0x3C,
	0xB2 | LCD_CMD,
	0x05, 0x3C, 0x3C,
	0xB3 | LCD_CMD,
	0x05, 0x3C, 0x3C, 0x05, 0x3C, 0x3C,
	0xB4 | LCD_CMD,
	0x03, 
	0xC0 | LCD_CMD,
	0x28, 0x08, 0x04,
	0xC1 | LCD_CMD,
	0xC0,
	0xC2 | LCD_CMD,
	0x0D, 0x00,
	0xC3 | LCD_CMD,
	0x8D, 0x2A,
	0xC4 | LCD_CMD,
	0x8D, 0xEE,
	0xC5 | LCD_CMD,
	0x1A,
	0x36 | LCD_CMD,
	0xA0,
	0x3A | LCD_CMD,
	0x05,
	0xE0 | LCD_CMD,
	0x04,0x22,0x07,0x0a,0x2e,0x30,0x25,0x2a,0x28,0x26,0x2e,0x3a,0x00,0x01,0x03,0x13,
	0xE1 | LCD_CMD,
	0x04,0x16,0x06,0x0d,0x2d,0x26,0x23,0x27,0x27,0x25,0x2d,0x3b,0x00,0x01,0x04,0x13,
	0x29 | LCD_CMD,
	100 | LCD_DLY,
	LCD_END
};

/* pointer to SPI port */
SPI_TypeDef *lcd_spi;

/*
 * send single byte via SPI - cmd or data depends on bit 8
 */
void lcd_write(uint16_t dat)
{
	if((dat&LCD_CMD) == LCD_CMD) LCD_DC_CMD();
	else LCD_DC_DATA();
	spi_tx_byte(lcd_spi, dat&0xff);
}

void lcd_on(void)
{
    LCD_BL_ON();
}

void lcd_off(void)
{
    LCD_BL_OFF();
}

/*
 * initialize the LCD
 */
void lcd_init(void)
{
    LCD_BL_OFF();
    
    spi_init(SPI1);
    
	// save SPI port
	lcd_spi = SPI1;
	
	// Reset it
	LCD_RST_LOW();
	clkcnt_delayms(50);
	LCD_RST_HIGH();
	clkcnt_delayms(50);

	// Send init command list
	uint16_t *addr = (uint16_t *)initlst, ms;
	while(*addr != LCD_END) {
		if((*addr & LCD_DLY) != LCD_DLY) lcd_write(*addr++);
		else {
			ms = (*addr++)&0x1ff;        // strip delay time (ms)
			clkcnt_delayms(ms);
		}	
	}	
}

/*
 * opens a window into display mem for bitblt
 */
void spitx(uint8_t data)
{
    spi_tx_wait(lcd_spi);
    
	lcd_spi->SPITXDR = data;
}

void lcd_setAddrWindow(uint16_t x0, uint16_t y0, uint16_t x1, uint16_t y1)
{
/*
    spi_cs_low(lcd_spi);
    LCD_DC_CMD();
    spitx(LCD_CASET);
    LCD_DC_DATA();
	spitx(0);
	spitx((x0+1)&0xff);     // XSTART 
	spitx(0);
	spitx((x1+1)&0xff);     // XEND
	LCD_DC_CMD();
	spitx(LCD_RASET); // Row addr set
	LCD_DC_DATA();
	spitx(0);
	spitx((y0+2)&0xff);     // YSTART
	spitx(0);
	spitx((y1+2)&0xff);     // YEND
	LCD_DC_CMD();
	spitx(LCD_RAMWR); // write to RAM
	spi_rx_wait(lcd_spi);
	spi_cs_high(lcd_spi);
	*/

	lcd_write(LCD_CASET | LCD_CMD); // Column addr set
	lcd_write(0);
	lcd_write((x0+1)&0xff);     // XSTART 
	lcd_write(0);
	lcd_write((x1+1)&0xff);     // XEND
	lcd_write(LCD_RASET | LCD_CMD); // Row addr set
	lcd_write(0);
	lcd_write((y0+2)&0xff);     // YSTART
	lcd_write(0);
	lcd_write((y1+2)&0xff);     // YEND
	lcd_write(LCD_RAMWR | LCD_CMD); // write to RAM
	
}

/*
 * Convert HSV triple to RGB triple
 * use algorithm from
 * http://en.wikipedia.org/wiki/HSL_and_HSV#Converting_to_RGB
 */
void lcd_hsv2rgb(uint8_t rgb[], uint8_t hsv[])
{
	uint16_t C;
	int16_t Hprime, Cscl;
	uint8_t hs, X, m;
	
	/* default */
	rgb[0] = 0;
	rgb[1] = 0;
	rgb[2] = 0;
	/* calcs are easy if v = 0 */
	if(hsv[2] == 0) return;	
	/* C is the chroma component */
	C = ((uint16_t)hsv[1] * (uint16_t)hsv[2])>>8;
	/* Hprime is fixed point with range 0-5.99 representing hue sector */
	Hprime = (int16_t)hsv[0] * 6;
	/* get intermediate value X */
	Cscl = (Hprime%512)-256;
	Cscl = Cscl < 0 ? -Cscl : Cscl;
	Cscl = 256 - Cscl;
	X = ((uint16_t)C * Cscl)>>8;
	/* m is value offset */
	m = hsv[2] - C;
	/* get the hue sector (1 of 6) */
	hs = (Hprime)>>8;
	/* map by sector */
	switch(hs) {
		case 0:
			/* Red -> Yellow sector */
			rgb[0] = C + m;
			rgb[1] = X + m;
			rgb[2] = m;
			break;
		case 1:
			/* Yellow -> Green sector */
			rgb[0] = X + m;
			rgb[1] = C + m;
			rgb[2] = m;
			break;
		case 2:
			/* Green -> Cyan sector */
			rgb[0] = m;
			rgb[1] = C + m;
			rgb[2] = X + m;
			break;
		case 3:
			/* Cyan -> Blue sector */
			rgb[0] = m;
			rgb[1] = X + m;
			rgb[2] = C + m;
			break;
		case 4:
			/* Blue -> Magenta sector */
			rgb[0] = X + m;
			rgb[1] = m;
			rgb[2] = C + m;
			break;
		case 5:
			/* Magenta -> Red sector */
			rgb[0] = C + m;
			rgb[1] = m;
			rgb[2] = X + m;
			break;
	}
}

/*
 * Convert 8-bit (each) R,G,B to 16-bit rgb565 packed color
 */
uint16_t lcd_color565(uint8_t r, uint8_t g, uint8_t b)
{
	return ((r & 0xF8) << 8) | ((g & 0xFC) << 3) | (b >> 3);
}

/*
 * fast color fill
 */
void lcd_fillColor(uint16_t color, uint32_t sz)
{
	uint8_t lo = color&0xff, hi = color>>8;
	
	while(sz--) {
		spi_tx_wait(lcd_spi);/* wait for tx ready */
		lcd_spi->SPITXDR = hi;/* transmit hi byte */
		spi_tx_wait(lcd_spi);/* wait for tx ready */
		lcd_spi->SPITXDR = lo;/* transmit hi byte */
	}
}

/*
 * draw single pixel
 */
void lcd_drawPixel(int16_t x, int16_t y, uint16_t color)
{
	if((x < 0) ||(x >= LCD_TFTWIDTH) || (y < 0) || (y >= LCD_TFTHEIGHT)) return;
	lcd_setAddrWindow(x,y,x+1,y+1);
	LCD_DC_DATA();
	spi_cs_low(lcd_spi);
    lcd_fillColor(color, 1);
	spi_cs_high(lcd_spi);
}

/*
 * abs() helper function for line drawing
 */
int16_t lcd_abs(int16_t x)
{
	return (x<0) ? -x : x;
}

/*
 * swap() helper function for line drawing
 */
void lcd_swap(int16_t *z0, int16_t *z1)
{
	int16_t temp = *z0;
	*z0 = *z1;
	*z1 = temp;
}

/*
 * Bresenham line draw routine swiped from Wikipedia
 */
void lcd_drawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1, uint16_t color)
{
	int8_t steep;
	int16_t deltax, deltay, error, ystep, x, y;
	/* flip sense 45deg to keep error calc in range */
	steep = (lcd_abs(y1 - y0) > lcd_abs(x1 - x0));
	if(steep) {
		lcd_swap(&x0, &y0);
		lcd_swap(&x1, &y1);
	}
	/* run low->high */
	if(x0 > x1) {
		lcd_swap(&x0, &x1);
		lcd_swap(&y0, &y1);
	}
	/* set up loop initial conditions */
	deltax = x1 - x0;
	deltay = lcd_abs(y1 - y0);
	error = deltax/2;
	y = y0;
	if(y0 < y1) ystep = 1;
	else ystep = -1;
	/* loop x */
	for(x=x0;x<=x1;x++) {
		/* plot point */
		if(steep) lcd_drawPixel(y, x, color);/* flip point & plot */
		else lcd_drawPixel(x, y, color);/* just plot */
		error = error - deltay;/* update error */
		if(error < 0) {/* update y */
			y = y + ystep;
			error = error + deltax;
		}
	}
}

/*
 * fast vert line
 */
void lcd_drawFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color)
{
	// clipping
	if((x >= LCD_TFTWIDTH) || (y >= LCD_TFTHEIGHT)) return;
	if((y+h-1) >= LCD_TFTHEIGHT) h = LCD_TFTHEIGHT-y;
	lcd_setAddrWindow(x, y, x, y+h-1);
	LCD_DC_DATA();
	spi_cs_low(lcd_spi);
	lcd_fillColor(color, h);
	spi_cs_high(lcd_spi);
}

/*
 * fast horiz line
 */
void lcd_drawFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color)
{
	// clipping
	if((x >= LCD_TFTWIDTH) || (y >= LCD_TFTHEIGHT)) return;
	if((x+w-1) >= LCD_TFTWIDTH)  w = LCD_TFTWIDTH-x;
	lcd_setAddrWindow(x, y, x+w-1, y);
	LCD_DC_DATA();
	spi_cs_low(lcd_spi);
	lcd_fillColor(color, w);
	spi_cs_high(lcd_spi);
}

/*
 * empty rect
 */
void lcd_emptyRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color)
{
	/* top & bottom */
    lcd_drawFastHLine(x, y, w, color);
    lcd_drawFastHLine(x, y+h-1, w, color);
	/* left & right - don't redraw corners */
    lcd_drawFastVLine(x, y+1, h-2, color);
    lcd_drawFastVLine(x+w-1, y+1, h-2, color);
}

/*
 * fill a rectangle
 */
void lcd_fillRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color)
{
	// clipping
	if((x >= LCD_TFTWIDTH) || (y >= LCD_TFTHEIGHT)) return;
	if((x + w - 1) >= LCD_TFTWIDTH)  w = LCD_TFTWIDTH  - x;
	if((y + h - 1) >= LCD_TFTHEIGHT) h = LCD_TFTHEIGHT - y;
	lcd_setAddrWindow(x, y, x+w-1, y+h-1);
	LCD_DC_DATA();
	spi_cs_low(lcd_spi);
	lcd_fillColor(color, h*w);
	spi_cs_high(lcd_spi);
}

/*
 * fill screen w/ single color
 */
void lcd_fillScreen(uint16_t color)
{
	lcd_fillRect(0, 0, 160, 128, color);
}

/*
 * Draw character direct to the display
 */
void lcd_drawChar(int16_t x, int16_t y, uint8_t chr, uint16_t fg, uint16_t bg)
{
	uint16_t i, j, col;
	uint8_t d;
	
	lcd_setAddrWindow(x, y, x+7, y+7);
	
	LCD_DC_DATA();
	spi_cs_low(lcd_spi);
	for(i=0;i<8;i++) {
		d = fontdata[(chr<<3)+i];
		for(j=0;j<8;j++) {
			if(d&0x80) col = fg;
			else if (fg != bg) col = bg;
			lcd_fillColor(col, 1);
			// next bit
			d <<= 1;
		}
	}
	spi_cs_high(lcd_spi);
}

// draw a string to the display
void lcd_drawStr(int16_t x, int16_t y, char *str, uint16_t fg, uint16_t bg)
{
	uint8_t c;
	while((c=*str++)) {
		lcd_drawChar(x, y, c, fg, bg);
		x += 8;
		if(x>LCD_TFTWIDTH) break;
	}
}

/*
 * send a buffer to the LCD
 */
void lcd_blit(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t *src)
{
	// clipping
	if((x >= LCD_TFTWIDTH) || (y >= LCD_TFTHEIGHT)) return;
	if((x + w - 1) >= LCD_TFTWIDTH)  w = LCD_TFTWIDTH  - x;
	if((y + h - 1) >= LCD_TFTHEIGHT) h = LCD_TFTHEIGHT - y;
	lcd_setAddrWindow(x, y, x+w-1, y+h-1);
	LCD_DC_DATA();
	spi_cs_low(lcd_spi);
	spi_transmit(lcd_spi, (uint8_t *)src, h*w*sizeof(uint16_t));
	spi_cs_high(lcd_spi);
}


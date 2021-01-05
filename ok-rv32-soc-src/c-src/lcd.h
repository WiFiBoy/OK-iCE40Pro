/*
 * lcd.h - ST7735 LCD driver
 * 07-03-19 E. Brombaugh
 * 12-08-20 tklua@wifiboy.org
 */

#ifndef __lcd__
#define __lcd__

#include "okice40.h"

// Color definitions
#define COLOR_BLACK   0x0000
#define COLOR_BLUE    0x001F
#define COLOR_RED     0xF800
#define COLOR_GREEN   0x07E0
#define COLOR_DARKGREEN   0x03E0
#define COLOR_CYAN    0x07FF
#define COLOR_MAGENTA 0xF81F
#define COLOR_YELLOW  0xFFE0  
#define COLOR_WHITE   0xFFFF

#define LCD_TFTWIDTH  160
#define LCD_TFTHEIGHT 128

#define LCD_BL_LOW()  (gp_out&=(~1))
#define LCD_BL_HIGH()  (gp_out|=1)

void lcd_init(void);
void lcd_on(void);
void lcd_off(void);
void lcd_drawPixel(int16_t x, int16_t y, uint16_t color);
void lcd_drawFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color);
void lcd_drawFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color);
void lcd_hsv2rgb(uint8_t rgb[], uint8_t hsv[]);
uint16_t lcd_color565(uint8_t r, uint8_t g, uint8_t b);
void lcd_emptyRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color);
void lcd_fillRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color);
void lcd_fillScreen(uint16_t color);
void lcd_drawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1, uint16_t color);
void lcd_drawChar(int16_t x, int16_t y, uint8_t chr, uint16_t fg, uint16_t bg);
void lcd_drawStr(int16_t x, int16_t y, char *str, uint16_t fg, uint16_t bg);
void lcd_blit(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t *src);
#endif


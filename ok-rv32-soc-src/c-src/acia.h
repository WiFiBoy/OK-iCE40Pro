/*
 * acia.h - serial port driver
 * 07-01-19 E. Brombaugh
 * 12-08-20 tklua@wifiboy.org
 */

#ifndef __acia__
#define __acia__

#include "okice40.h"

void acia_putc(char c);
void acia_puts(char *str);
int acia_getc(void);

#endif


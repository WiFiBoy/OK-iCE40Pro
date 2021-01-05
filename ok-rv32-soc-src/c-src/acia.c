/*
 * acia.c - serial port driver
 * 07-01-19 E. Brombaugh
 * 12-08-20 tklua@wifiboy.org
 */

#include <stdio.h>
#include "acia.h"
#include "clkcnt.h"

// serial transmit character
void acia_putc(char c)
{
	while(!(acia_ctlstat & 2)); // wait for tx ready
	acia_data = c; // send char
}

// serial transmit string
void acia_puts(char *str)
{
	uint8_t c;
	while((c=*str++)) acia_putc(c);
}

// serial receive char
int acia_getc(void)
{
	if(!(acia_ctlstat & 1)) return -1;
	else return acia_data;
	return -1;
}


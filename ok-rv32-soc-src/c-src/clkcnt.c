/*
 * clkcnt.h - clock cycle counter driver
 * 07-03-19 E. Brombaugh
 * 12-08-20 tklua@wifiboy.org
 */

#include "clkcnt.h"

// delay for exactly 1 millisecond
void clkcnt_1ms(void)
{
	clkcnt_reg = 0;
	while(clkcnt_reg < 24000);
}

void clkcnt_1us(void)
{
	clkcnt_reg = 0;
	while(clkcnt_reg < 24);
}
// delay for number of milliseconds
void clkcnt_delayms(uint32_t ms)
{
	while(ms--) clkcnt_1ms();
}
// delay for number of microseconds
void clkcnt_delayus(uint32_t us)
{
	while(us--) clkcnt_1us();
}


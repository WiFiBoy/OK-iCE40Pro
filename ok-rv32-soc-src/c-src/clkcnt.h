/*
 * clkcnt.h - clock cycle counter driver
 * 07-03-19 E. Brombaugh
 */

#ifndef __clkcnt__
#define __clkcnt__

#include "okice40.h"

void clkcnt_delayus(uint32_t us);
void clkcnt_delayms(uint32_t ms);

#endif


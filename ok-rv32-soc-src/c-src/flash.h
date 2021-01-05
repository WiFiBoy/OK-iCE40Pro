/*
 * flash.h - flash memory driver
 * 07-03-19 E. Brombaugh
 * 12-08-20 tklua@wifiboy.org
 */

#ifndef __flash__
#define __flash__

#include "okice40.h"

void flash_init(SPI_TypeDef *s);
void flash_read(SPI_TypeDef *s, uint8_t *dst, uint32_t addr, uint32_t len);
uint8_t flash_rdreg(SPI_TypeDef *s, uint8_t cmd);
uint8_t flash_status(SPI_TypeDef *s);
void flash_busy_wait(SPI_TypeDef *s);
void flash_eraseblk(SPI_TypeDef *s, uint32_t addr);
void flash_write(SPI_TypeDef *s, uint8_t *src, uint32_t addr, uint32_t len);
uint32_t flash_id(SPI_TypeDef *s);
uint32_t flash_uuid(SPI_TypeDef *s);

#endif


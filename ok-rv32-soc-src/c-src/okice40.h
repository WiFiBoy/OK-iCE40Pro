/*
 * okice40.h - hardware definitions for ok:ice40
 * 07-01-19 E. Brombaugh (picorv32, picosoc)
 * 12-08-20 tklua@wifiboy.org
 */

#ifndef __okice40__
#define __okice40__

#include <stdint.h>

#define gp_out (*(volatile uint32_t *)0x20000000)
#define gp_in (*(volatile uint32_t *)0x70000000)
#define spkr (*(volatile uint32_t *)0x80000000)
#define wboot (*(volatile uint32_t *)0x90000000)
#define clkcnt_reg (*(volatile uint32_t *)0x50000000)
#define acia_ctlstat (*(volatile uint8_t *)0x30000000)
#define acia_data (*(volatile uint8_t *)0x30000004)

// SPI cores @ BUS_ADDR74 = 0b0000 and 0b0010
#define SPI0_BASE 0x40000000
#define SPI1_BASE 0x40000080

typedef struct
{
	uint32_t reserved0[8];
	volatile uint8_t SPICR0;
	uint8_t reserved1[3];
	volatile uint8_t SPICR1;
	uint8_t reserved2[3];
	volatile uint8_t SPICR2;
	uint8_t reserved3[3];
	volatile uint8_t SPIBR;
	uint8_t reserved4[3];
	volatile uint8_t SPISR;
	uint8_t reserved5[3];
	volatile uint8_t SPITXDR;
	uint8_t reserved6[3];
	volatile uint8_t SPIRXDR;
	uint8_t reserved7[3];
	volatile uint8_t SPICSR;
	uint8_t reserved8[3];
} SPI_TypeDef;

#define SPI0 ((SPI_TypeDef *) SPI0_BASE)
#define SPI1 ((SPI_TypeDef *) SPI1_BASE)

#endif

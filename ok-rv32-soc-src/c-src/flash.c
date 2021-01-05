/*
 * flash.c - flash memory driver
 * 07-03-19 E. Brombaugh
 * 12-08-20 tklua@wifiboy.org
 */

#include "flash.h"
#include "spi.h"

/* flash commands */
#define FLASH_WRPG 0x02 // write page
#define FLASH_READ 0x03 // read data
#define FLASH_RSR1 0x05 // read status reg 1
#define FLASH_RSR2 0x35 // read status reg 2
#define FLASH_RSR3 0x15 // read status reg 3
#define FLASH_WSR1 0x01 // write status reg 1
#define FLASH_WSR2 0x31 // write status reg 2
#define FLASH_WSR3 0x11 // write status reg 3
#define FLASH_WEN  0x06 // write enable
#define FLASH_EB32 0x52 // erase block 32k
#define FLASH_GBUL 0x98 // global unlock
#define FLASH_WKUP 0xAB // wakeup
#define FLASH_ERST 0x66 // enable reset
#define FLASH_RST  0x99 // reset
#define FLASH_ID   0x9f // get ID bytes
#define FLASH_UUID 0x4B // get UUID bytes (4 dummies + 8 uuid bytes)

/*
 * wake up SPI Flash
 */
void flash_init(SPI_TypeDef *s)
{
    spi_init(s); 
	spi_tx_byte(s, FLASH_WKUP);
}

/*
 * send a header to the SPI Flash (for read/erase/write commands)
 */
void flash_header(SPI_TypeDef *s, uint8_t cmd, uint32_t addr)
{
	uint8_t txdat[4];
	
	/* assemble header */
	txdat[0] = cmd;
	txdat[1] = (addr>>16)&0xff;
	txdat[2] = (addr>>8)&0xff;
	txdat[3] = (addr)&0xff;
	
	/* send the header */
	spi_transmit(s, txdat, 4);
}

/*
 * read bytes from SPI Flash
 */
void flash_read(SPI_TypeDef *s, uint8_t *dst, uint32_t addr, uint32_t len)
{
	uint8_t dummy __attribute ((unused));
	
	spi_cs_low(s);
	
	/* send read header */
	flash_header(s, FLASH_READ, addr);
	
	/* wait for tx ready */
	spi_tx_wait(s);
	
	/* dummy reads */
	dummy = s->SPIRXDR;
	dummy = s->SPIRXDR;
	
	/* get the buffer */
	spi_receive(s, dst, len);
	
	spi_cs_high(s);
}

/*
 * read bytes from SPI Flash
 */
uint8_t flash_rdreg(SPI_TypeDef *s, uint8_t cmd)
{
	uint8_t result;
	
	spi_cs_low(s);
	
	/* wait for tx ready */
	spi_tx_wait(s);
	
	/* send command */
	s->SPITXDR = cmd;
	
	/* wait for rx ready */
	spi_rx_wait(s);
		
	/* dummy read */
	result = s->SPIRXDR;

	/* send dummy data */
	s->SPITXDR = 0;
	
	/* wait for rx ready */
	spi_rx_wait(s);
		
	/* read data */
	result = s->SPIRXDR;
		
	spi_cs_high(s);
	
	return result;
}

/*
 * get SPI Flash status byte
 */
uint8_t flash_status(SPI_TypeDef *s)
{
	return flash_rdreg(s, FLASH_RSR1);
}

/*
 * wait for SPI Flash not busy
 */
void flash_busy_wait(SPI_TypeDef *s)
{
	while((flash_status(s)&1));
}

/*
 * erase 32kB block in SPI Flash
 */
void flash_eraseblk(SPI_TypeDef *s, uint32_t addr)
{
	/* write enable */
	spi_tx_byte(s, FLASH_WEN);
	
	spi_cs_low(s);
	
	/* send read header */
	flash_header(s, FLASH_EB32, addr);
	
	/* wait for rx ready */
	spi_rx_wait(s);
	
	spi_cs_high(s);
}

/*
 * write bytes to SPI Flash
 */
void flash_write(SPI_TypeDef *s, uint8_t *src, uint32_t addr, uint32_t len)
{
	/* write enable */
	spi_tx_byte(s, FLASH_WEN);
	
	spi_cs_low(s);
	
	/* send read header */
	flash_header(s, FLASH_WRPG, addr);
	
	/* send data packet */
	spi_transmit(s, src, len);
	
	spi_cs_high(s);
}

/*
 * get ID from SPI Flash
 */
uint32_t flash_id(SPI_TypeDef *s)
{
	uint8_t result[3];
	
	spi_cs_low(s);
	
	/* send command */
	spi_tx_wait(s);
	s->SPITXDR = FLASH_ID;
	spi_rx_wait(s);
	result[0] = s->SPIRXDR;	// dummy read
	
	/* get id bytes */
	spi_receive(s, result, 3);

	spi_cs_high(s);
	
	return (result[0]<<16) | (result[1]<<8) | result[2];
}

/*
 * get UUID from SPI Flash (OK:iCE40 uses Winbond)
 */
uint32_t flash_uuid(SPI_TypeDef *s)
{
	uint8_t result[8];
	
	spi_cs_low(s);
	
	/* send command */
	spi_tx_wait(s);
	s->SPITXDR = FLASH_UUID;
	spi_rx_wait(s);
	result[0] = s->SPIRXDR;	// dummy read
	
	/* get dummy bytes */
	spi_receive(s, result, 4);
        /* get uuid bytes */
	spi_receive(s, result, 8);

	spi_cs_high(s);
	
	return (result[4]<<24) | (result[5]<<16) | (result[6]<<8) | result[7];
}

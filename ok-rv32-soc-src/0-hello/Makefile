CROSS = ../../tools/riscv64-toolchain/bin/riscv64-unknown-elf-
CC = $(CROSS)gcc
OBJCOPY = $(CROSS)objcopy
OBJDUMP = $(CROSS)objdump

CFLAGS=-Wall -Os -march=rv32i -mabi=ilp32 -ffreestanding -flto -nostartfiles -fomit-frame-pointer -I../c-src/

HEADER = ../c-src/okice40.h ../c-src/acia.h ../c-src/spi.h ../c-src/flash.h ../c-src/clkcnt.h ../c-src/lcd.h

SOURCES = ../c-src/start.S main.c ../c-src/acia.c ../c-src/spi.c ../c-src/flash.c ../c-src/clkcnt.c ../c-src/lcd.c

main.elf: ../c-src/lnk-app.lds $(HEADERS) $(SOURCES)
	$(CC) $(CFLAGS)  -Wl,-Bstatic,-T,../c-src/lnk-app.lds,--strip-debug -o $@ $(SOURCES)
	$(OBJCOPY) -O binary main.elf main.bin
	../../tools/hexdumper main.bin > code.hex
	cp code.hex ..

clean:
	rm -f *.bin *.hex *.elf *.dis

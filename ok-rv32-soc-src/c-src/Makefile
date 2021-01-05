CROSS = ../../tools/riscv64-toolchain/bin/riscv64-unknown-elf-
CC = $(CROSS)gcc
OBJCOPY = $(CROSS)objcopy
OBJDUMP = $(CROSS)objdump

CFLAGS=-Wall -Os -march=rv32i -mabi=ilp32 -ffreestanding -flto -nostartfiles -fomit-frame-pointer

HEADER = icegreen.h acia.h spi.h flash.h clkcnt.h lcd.h

SOURCES = start.S main.c acia.c spi.c flash.c clkcnt.c lcd.c

main.elf: lnk-app.lds $(HEADERS) $(SOURCES)
	$(CC) $(CFLAGS)  -Wl,-Bstatic,-T,lnk-app.lds,--strip-debug -o $@ $(SOURCES)
	$(OBJCOPY) -O binary main.elf main.bin
	../../tools/hexdumper main.bin > code.hex
	cp code.hex ..

clean:
	rm -f *.bin *.hex *.elf *.dis

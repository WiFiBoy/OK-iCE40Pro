# Makefile for icestorm tools + yosys + nextpnr
# Modified from examples in icestorm distribution
# 01-16-18 E. Brombaugh
# 12-12-20 tklua@wifiboy.org 

# src directory
SRC = okrv32.v system.v spram_16kx32.v wb_bus.v wb_master.v picorv32.v acia.v acia_rx.v acia_tx.v
	
# preparing the machine code
FAKE_HEX = rom.hex
REAL_HEX = code.hex

# project stuff
PROJ = okrv32
PIN_DEF = okice40pro.pcf
SDC = okrv32.sdc
DEVICE = up5k --package sg48

YOSYS = yosys
NEXTPNR = nextpnr-ice40
NEXTPNR_ARGS = --placer heap --timing-allow-fail
ICEPACK = icepack
ICETIME = icetime
ICEPROG = iceprog
ICEBRAM = icebram
ICEMULT = icemulti
CDCPROG = iceprog

all: $(PROJ).bin

$(FAKE_HEX):
	$(ICEBRAM) -g 32 2048 > $(FAKE_HEX)

$(REAL_HEX):
	$(MAKE) -C ./0-hello/  
	cp ./0-hello/code.hex .
	
%.json: $(SRC) $(FAKE_HEX)
	$(YOSYS) -p 'synth_ice40 -dsp -top $(PROJ) -json $@' $(SRC)

%.asc: %.json $(PIN_DEF) 
	$(NEXTPNR) $(NEXTPNR_ARGS) --$(DEVICE) --json $< --pcf $(PIN_DEF) --asc $@ --freq 24
		
%.bin: %.asc $(REAL_HEX)
	$(ICEBRAM) $(FAKE_HEX) code.hex < $< > temp.asc
	$(ICEPACK) temp.asc $@

%.rpt: %.asc
	$(ICETIME) -d $(DEVICE) -mtr $@ $<

prog: $(PROJ).bin
	$(CDCPROG) $<

recode:
	rm -f $(REAL_HEX) $(PROJ).bin
	$(MAKE) prog

clean:
	$(MAKE) -C ./0-hello/ clean
	$(MAKE) -C ./1-lines/ clean
	$(MAKE) -C ./2-snake/ clean
	rm -f *.json *.asc *.rpt *.bin *.hex
	
hello: ./0-hello/*.c 
	$(MAKE) -C ./0-hello/  
	cp ./0-hello/code.hex .

lines: ./1-lines/*.c
	$(MAKE) -C ./1-lines/  
	cp ./1-lines/code.hex .
		
snake: ./2-snake/*.c 
	$(MAKE) -C ./2-snake/
	cp ./2-snake/code.hex .

image: ./3-image/*.c
	$(MAKE) -C ./3-image/  
	cp ./3-image/code.hex .

music: ./4-music/*.c
	$(MAKE) -C ./4-music/  
	cp ./4-music/code.hex .

piano: ./5-piano/*.c
	$(MAKE) -C ./5-piano/  
	cp ./5-piano/code.hex .

chars: ./6-chars/*.c
	$(MAKE) -C ./6-chars/  
	cp ./6-chars/code.hex .
	
uart: ./7-uart/*.c
	$(MAKE) -C ./7-uart/  
	cp ./7-uart/code.hex .
	
.SECONDARY:
.PHONY: all prog clean

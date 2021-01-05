# Makefile for icestorm tools + yosys + nextpnr
# 12-12-20 tklua@wifiboy.org, for ok-ice40-pro 	

PROJ = blink
SRC = $(PROJ).v

PIN_DEF = okice40pro.pcf
DEVICE = up5k --package sg48
YOSYS = yosys
NEXTPNR = nextpnr-ice40
ICEPACK = icepack
ICEPROG = iceprog

all: $(PROJ).bin
	
%.json: $(SRC) 
	$(YOSYS) -p 'synth_ice40 -top $(PROJ) -json $@' $(SRC)

%.asc: %.json $(PIN_DEF) 
	$(NEXTPNR) $(NEXTPNR_ARGS) --$(DEVICE) --json $< --pcf $(PIN_DEF) --asc $@
		
%.bin: %.asc 
	$(ICEPACK) $< $@

prog: $(PROJ).bin
	$(ICEPROG) $<

clean:
	rm -f *.json *.asc *.rpt *.bin *.hex

.SECONDARY:
.PHONY: all prog clean

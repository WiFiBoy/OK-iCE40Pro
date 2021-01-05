VERILOGS = j1a.v uart.v j1.v stack2.v
NEXTPNR_ARGS = --placer heap --timing-allow-fail --up5k --package sg48

all: j1a.bin

j1a.bin: $(VERILOGS) okice40pro.pcf Makefile ram.v
	yosys  -q -p "synth_ice40 -top top -json j1a.json" $(VERILOGS)
	nextpnr-ice40 $(NEXTPNR_ARGS) --json j1a.json --pcf okice40pro.pcf --asc j1a.asc --freq 24
	icepack j1a.asc j1a0.bin
	icemulti -p0 j1a0.bin > j1a.bin && rm j1a0.bin

j1a: j1a.bin
	iceprog j1a.bin

clean:
	rm -f j1a.json j1a.asc j1a.bin j1a.rpt j1a.bin j1a.hex

.PHONY: clean
.PHONY: j1a



ram.v: nuc.hex mkrom.py
	python mkrom.py

nuc.hex: cross.fs basewords.fs nuc.fs
	gforth cross.fs basewords.fs nuc.fs


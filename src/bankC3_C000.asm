; Segment bankC3_C000: not yet disassembled. It starts where the previous segment ends.
org $C3C70E
	incbin "../Extracted/segments/bankC3_C000.bin":$70E..$1000

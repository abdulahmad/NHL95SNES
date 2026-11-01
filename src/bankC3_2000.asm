; Segment bankC3_2000: not yet disassembled. It starts where bankC3_1000 ends.
org $C32001
	incbin "../Extracted/segments/bankC3_2000.bin":$1..$1000

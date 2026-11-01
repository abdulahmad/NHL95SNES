; Segment bankC3_3000: not yet disassembled. It starts where bankC3_2000 ends.
org $C33008
	incbin "../Extracted/segments/bankC3_3000.bin":$8..$1000

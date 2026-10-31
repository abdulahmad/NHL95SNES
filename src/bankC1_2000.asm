; Segment bankC1_2000: not yet disassembled. It starts with a sprite frame's tiles, in the previous 4 KB.
org $C1211C
	incbin "../Extracted/segments/bankC1_2000.bin":$11C..$1000

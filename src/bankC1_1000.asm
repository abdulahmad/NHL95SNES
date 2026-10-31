; Segment bankC1_1000: not yet disassembled. It starts with a sprite frame's tiles, in the previous 4 KB.
org $C110B8
	incbin "../Extracted/segments/bankC1_1000.bin":$B8..$1000

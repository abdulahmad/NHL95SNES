; Segment bankC0_4000: not yet disassembled. It starts after the uniform palettes, with a packed set.
org $C04642
	incbin "../Extracted/segments/bankC0_4000.bin":$642..$1000

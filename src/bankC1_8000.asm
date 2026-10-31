; Segment bankC1_8000: not yet disassembled. It starts with a sprite frame's tiles, in the previous 4 KB.
org $C18034
	incbin "../Extracted/segments/bankC1_8000.bin":$34..$1000

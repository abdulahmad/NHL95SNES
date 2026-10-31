; Segment bankC1_9000: not yet disassembled. It starts with a sprite frame's tiles, in the previous 4 KB.
org $C19084
	incbin "../Extracted/segments/bankC1_9000.bin":$84..$1000

; Segment bankC1_A000: not yet disassembled. It starts after the sprite pieces, in the previous 4 KB.
org $C19B68
	incbin "../Extracted/segments/bankC1_9000.bin":$B68..$1000
	incbin "../Extracted/segments/bankC1_A000.bin"

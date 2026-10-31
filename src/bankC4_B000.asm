; Segment bankC4_B000: not yet disassembled. It starts where bankC4_A000 ends.
org $C4B00F
	incbin "../Extracted/segments/bankC4_B000.bin":$F..$1000

; Segment bankC4_F000: not yet disassembled. It starts where bankC4_E000 ends.
org $C4F01E
	incbin "../Extracted/segments/bankC4_F000.bin":$1E..$1000

; Segment bankC3_A000: not yet disassembled. It starts where bankC3_9000 ends.
org $C3AC29
	incbin "../Extracted/segments/bankC3_A000.bin":$C29..$1000

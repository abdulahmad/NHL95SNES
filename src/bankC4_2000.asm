; Segment bankC4_2000: not yet disassembled. It starts where bankC4_1000 ends.
org $C42030
	incbin "../Extracted/segments/bankC4_2000.bin":$30..$1000

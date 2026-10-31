; Segment bankC4_C000: not yet disassembled. It starts where bankC4_B000 ends, in the previous 4 KB.
org $C4BF47
	incbin "../Extracted/segments/bankC4_B000.bin":$F47..$1000
	incbin "../Extracted/segments/bankC4_C000.bin"

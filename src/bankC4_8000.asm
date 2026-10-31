; Segment bankC4_8000: not yet disassembled. It starts where bankC4_7000 ends, in the previous 4 KB.
org $C47FB5
	incbin "../Extracted/segments/bankC4_7000.bin":$FB5..$1000
	incbin "../Extracted/segments/bankC4_8000.bin"

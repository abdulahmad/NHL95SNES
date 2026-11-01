; Segment bankC4_E000: not yet disassembled. It starts where bankC4_D000 ends, in the previous 4 KB.
org $C4DFD6
	incbin "../Extracted/segments/bankC4_D000.bin":$FD6..$1000
	incbin "../Extracted/segments/bankC4_E000.bin"

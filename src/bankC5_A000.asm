; Segment bankC5_A000: not yet disassembled. It starts at a routine in the previous 4 KB.
org $C59F79
	incbin "../Extracted/segments/bankC5_9000.bin":$F79..$1000
	incbin "../Extracted/segments/bankC5_A000.bin"

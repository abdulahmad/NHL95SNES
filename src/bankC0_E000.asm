; Segment bankC0_E000: not yet disassembled. It starts with a sound sample, in the previous 4 KB.
org $C0E5C5
	incbin "../Extracted/segments/bankC0_E000.bin":$5C5..$1000

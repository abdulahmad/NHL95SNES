; Segment bankC0_B000: not yet disassembled. It starts with a sound sample, in the previous 4 KB.
org $C0B5BF
	incbin "../Extracted/segments/bankC0_B000.bin":$5BF..$1000

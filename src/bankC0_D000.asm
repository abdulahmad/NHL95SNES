; Segment bankC0_D000: not yet disassembled. It starts with a sound sample, in the previous 4 KB.
org $C0D359
	incbin "../Extracted/segments/bankC0_D000.bin":$359..$1000

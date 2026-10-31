; Segment bankC0_F000: not yet disassembled. It starts with a sound sample, in the previous 4 KB.
org $C0F288
	incbin "../Extracted/segments/bankC0_F000.bin":$288..$1000

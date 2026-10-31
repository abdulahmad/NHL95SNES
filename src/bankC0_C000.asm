; Segment bankC0_C000: not yet disassembled. It starts with a sound sample, in the previous 4 KB.
org $C0C1CB
	incbin "../Extracted/segments/bankC0_C000.bin":$1CB..$1000

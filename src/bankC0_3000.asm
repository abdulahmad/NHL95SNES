; Segment bankC0_3000: not yet disassembled. It starts after the fonts, with a packed set.
org $C03CF9
	incbin "../Extracted/segments/bankC0_3000.bin":$CF9..$1000

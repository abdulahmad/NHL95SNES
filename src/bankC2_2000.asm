; Segment bankC2_2000: not yet disassembled. It starts with the title players' colours, in the previous 4 KB.
org $C22C8B
TitlePlayersPalette:				; the colours chunk of the title players' map set
	incbin "../Extracted/segments/bankC2_2000.bin":$C8B..$1000

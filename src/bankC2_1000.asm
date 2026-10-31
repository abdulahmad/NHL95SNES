; Segment bankC2_1000: not yet disassembled. It starts with the title players' tiles, in the previous 4 KB.
org $C20DE6
TitlePlayersTiles:					; the tiles chunk of the title players' map set
	incbin "../Extracted/segments/bankC2_0000.bin":$DE6..$1000
	incbin "../Extracted/segments/bankC2_1000.bin"

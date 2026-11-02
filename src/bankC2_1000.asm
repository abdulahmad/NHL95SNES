; Segment bankC2_1000: the tiles chunk of the title players' map set (as in bankC1_B000).
org $C20DE6
TitlePlayersTiles:					; the title players' tiles (316)
	dw TitlePlayersPalette-TitlePlayersTiles-2	; the chunk's length
	dw 316							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $2780						; the unpacked size
	incbin "../Extracted/segments/bankC2_0000.bin":$DF0..$1000
	incbin "../Extracted/segments/bankC2_1000.bin"
	incbin "../Extracted/segments/bankC2_2000.bin":0..$C8B

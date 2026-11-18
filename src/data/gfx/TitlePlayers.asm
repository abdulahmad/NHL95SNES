TitlePlayersMap:					; the title screen's front layer (BG1): three players; two other
									; screen setups in bank $C4 load it too
	dw TitlePlayersTiles-TitlePlayersMap-2	; the chunk's length (the bytes after this word)
	db $20,$14						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $0500						; the unpacked size
	incbin "../../../Extracted/segments/bankC2_0000.bin":$ABF..$DE6
TitlePlayersTiles:					; the title players' tiles (316)
	dw TitlePlayersPalette-TitlePlayersTiles-2	; the chunk's length
	dw 316							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $2780						; the unpacked size
	incbin "../../../Extracted/segments/bankC2_0000.bin":$DF0..$1000
	incbin "../../../Extracted/segments/bankC2_1000.bin"
	incbin "../../../Extracted/segments/bankC2_2000.bin":0..$C8B
TitlePlayersPalette:				; the title players' colours (16)
	dw TitleGoalieMap-TitlePlayersPalette-2	; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $03E0,$1400,$1800,$2020,$2840,$2C81,$34C2,$3D03
	dw $4565,$49A6,$5207,$5A49,$62AB,$66ED,$6F4F,$7FE0

PlayoffBracketMap:					; the playoff bracket with the Stanley Cup, 100 x 28 tiles (94S
									; PlayoffBracketMap); code in bank $C4 unpacks it to unpackbuf
	dw PlayoffBracketTiles-PlayoffBracketMap-2	; the chunk's length (the bytes after this word)
	db $64,$1C						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $15E0						; the unpacked size
	incbin "../../../Extracted/segments/bankC1_D000.bin":$C82..$1000
	incbin "../../../Extracted/segments/bankC1_E000.bin":0..$5B
PlayoffBracketTiles:				; its tiles (106)
	dw PlayoffBracketPalette-PlayoffBracketTiles-2	; the chunk's length
	dw 106							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $0D40						; the unpacked size
	incbin "../../../Extracted/segments/bankC1_E000.bin":$65..$98B
PlayoffBracketPalette:				; its colours (16)
	dw TeamNameBarsMap-PlayoffBracketPalette-2	; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $3400,$5929,$4884,$3400,$2400,$001F,$0012,$0009
	dw $7FFF,$6F7B,$5AD6,$4A52,$35AD,$2529,$1084,$0000

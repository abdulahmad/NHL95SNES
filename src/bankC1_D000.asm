; Segment bankC1_D000: two map sets (the pad's buttons, the playoff bracket), three chunks each (map, tiles,
; colours) as in bankC1_B000.
org $C1D778
PadButtonsMap:						; a pad's four buttons (Y, B, X, A) with tape-deck symbols; the screen
									; that shows it is not traced
	dw PadButtonsTiles-PadButtonsMap-2	; the chunk's length (the bytes after this word)
	db $20,$07						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $01C0						; the unpacked size
	incbin "../Extracted/segments/bankC1_D000.bin":$77F..$81B
PadButtonsTiles:					; its tiles (53)
	dw PadButtonsPalette-PadButtonsTiles-2	; the chunk's length
	dw 53							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), two bytes that must match, a zero
	dw $06A0						; the unpacked size
	incbin "../Extracted/segments/bankC1_D000.bin":$825..$C54
PadButtonsPalette:					; its colours (16)
	dw PlayoffBracketMap-PadButtonsPalette-2	; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $7FFF,$7FBD,$7FBA,$6F7B,$0000,$5AD6,$35AD,$2529
	dw $5ADB,$4A5F,$353B,$6E4D,$12DB,$7ED2,$1084,$7F72
PlayoffBracketMap:					; the playoff bracket with the Stanley Cup, 100 x 28 tiles (94S
									; PlayoffBracketMap); code in bank $C4 unpacks it to unpackbuf
	dw PlayoffBracketTiles-PlayoffBracketMap-2	; the chunk's length (the bytes after this word)
	db $64,$1C						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $15E0						; the unpacked size
	incbin "../Extracted/segments/bankC1_D000.bin":$C82..$1000
	incbin "../Extracted/segments/bankC1_E000.bin":0..$5B
PlayoffBracketTiles:				; its tiles (106)
	dw PlayoffBracketPalette-PlayoffBracketTiles-2	; the chunk's length
	dw 106							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), two bytes that must match, a zero
	dw $0D40						; the unpacked size
	incbin "../Extracted/segments/bankC1_E000.bin":$65..$98B
PlayoffBracketPalette:				; its colours (16)
	dw TeamNameBarsMap-PlayoffBracketPalette-2	; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $3400,$5929,$4884,$3400,$2400,$001F,$0012,$0009
	dw $7FFF,$6F7B,$5AD6,$4A52,$35AD,$2529,$1084,$0000

PadButtonsMap:						; the instant replay's controller legend: a pad's four buttons (Y, B, X,
									; A) with tape-deck symbols; ReplayMode unpacks it and queues its map,
									; tiles and palette
	dw PadButtonsTiles-PadButtonsMap-2	; the chunk's length (the bytes after this word)
	db $20,$07						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $01C0						; the unpacked size
	incbin "../../../Extracted/segments/bankC1_D000.bin":$77F..$81B
PadButtonsTiles:					; its tiles (53)
	dw PadButtonsPalette-PadButtonsTiles-2	; the chunk's length
	dw 53							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $06A0						; the unpacked size
	incbin "../../../Extracted/segments/bankC1_D000.bin":$825..$C54
PadButtonsPalette:					; its colours (16)
	dw PlayoffBracketMap-PadButtonsPalette-2	; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $7FFF,$7FBD,$7FBA,$6F7B,$0000,$5AD6,$35AD,$2529
	dw $5ADB,$4A5F,$353B,$6E4D,$12DB,$7ED2,$1084,$7F72

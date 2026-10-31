; Segment bankC2_C000: the ref windows' map set (map, tiles, colours as in bankC1_B000).
org $C2CC6E
RefsMap:							; the ref windows: 7 x 8 tiles per entry, 7 to a row (94S RefsMap);
									; the game screen setup copies them into a map buffer
	dw RefTiles-RefsMap-2			; the chunk's length (the bytes after this word)
	db $31,$18						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $0930						; the unpacked size
	incbin "../Extracted/segments/bankC2_C000.bin":$C75..$F40
RefTiles:							; its tiles (197)
	dw RefPalette-RefTiles-2		; the chunk's length
	dw 197							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $18A0						; the unpacked size
	incbin "../Extracted/segments/bankC2_C000.bin":$F4A..$1000
	incbin "../Extracted/segments/bankC2_D000.bin":0..$F14
RefPalette:							; its colours (16)
	dw Sample09-RefPalette-2		; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $7F76,$1000,$7FB9,$025B,$7ECD,$7D24,$7FFF,$4A5F
	dw $001B,$6EDF,$7F72,$49AD,$5A52,$6ED6,$2484,$3529

VisualConceptsMap:					; the developer credit: VISUAL CONCEPTS ... PRESENT; one screen
									; setup in bank $C4 loads it and HighScoreMap
	dw VisualConceptsTiles-VisualConceptsMap-2	; the chunk's length (the bytes after this word)
	db $20,$0C						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $0300						; the unpacked size
	incbin "../../../Extracted/segments/bankC2_B000.bin":$151..$27C
VisualConceptsTiles:				; its tiles (101)
	dw VisualConceptsPalette-VisualConceptsTiles-2	; the chunk's length
	dw 101							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $0CA0						; the unpacked size
	incbin "../../../Extracted/segments/bankC2_B000.bin":$286..$B22
VisualConceptsPalette:				; its colours (32)
	dw HighScoreMap-VisualConceptsPalette-2	; the chunk's length
	db 2							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 32							; the colour count
	dw $0000,$0000,$0C63,$1084,$18C6,$2108,$2D6B,$35AD
	dw $3DEF,$4631,$5294,$5AD6,$6318,$6F7B,$77BD,$7FFF
	dw $03E0,$5AD6,$4631,$35AD,$2D6B,$7B18,$7A95,$7E32
	dw $2108,$716C,$18C6,$5CC6,$5064,$1084,$3C00,$3400

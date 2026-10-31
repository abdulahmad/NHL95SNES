; Segment bankC2_B000: the High Score Productions credit's map set (map, tiles, colours as in bankC1_B000).
org $C2BB69
HighScoreMap:						; the developer credit: HIGH SCORE PRODUCTIONS AND, shown with
									; VisualConceptsMap
	dw HighScoreTiles-HighScoreMap-2	; the chunk's length (the bytes after this word)
	db $20,$0F						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $03C0						; the unpacked size
	incbin "../Extracted/segments/bankC2_B000.bin":$B70..$D15
HighScoreTiles:						; its tiles (153)
	dw HighScorePalette-HighScoreTiles-2	; the chunk's length
	dw 153							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $1320						; the unpacked size
	incbin "../Extracted/segments/bankC2_B000.bin":$D1F..$1000
	incbin "../Extracted/segments/bankC2_C000.bin":0..$BA7
HighScorePalette:					; its colours (96)
	dw RefsMap-HighScorePalette-2	; the chunk's length
	db 6							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 96							; the colour count
	dw $7C1F,$7BDE,$7B7B,$6F18,$5E73,$6AD5,$4DEE,$39CE
	dw $456B,$2D6B,$3929,$28C6,$18C6,$3886,$1C23,$0000
	dw $001F,$0000,$6AD5,$5E73,$5631,$4DEE,$456B,$3929
	dw $28C6,$1843,$2403,$44E7,$28C6,$18C6,$3886,$1843
	dw $03E0,$0000,$6AD5,$62B0,$4DEE,$456B,$7B7B,$3929
	dw $6F18,$44E7,$28C6,$18C6,$7376,$28C6,$1843,$2403
	dw $7C00,$456B,$39CE,$62B0,$0048,$44E7,$7376,$0000
	dw $5631,$7BDE,$7B7B,$1843,$04CF,$28C6,$6AD5,$2D6B
	dw $03FF,$7BDE,$1EDA,$1658,$7376,$6AD5,$0D94,$5631
	dw $04CF,$4DEE,$39CE,$456B,$314A,$0048,$1843,$0000
	dw $7FE0,$0000,$5631,$39CE,$3BFF,$2D6B,$456B,$2BBE
	dw $3929,$1EDA,$6F18,$1658,$28C6,$6AD5,$18C6,$1843

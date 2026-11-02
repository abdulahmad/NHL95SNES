; Segment bankC2_A000: the end of CenterIceTiles, the centre ice logos' colours, then the Visual Concepts
; credit's map set (map, tiles, colours as in bankC1_B000).
org $C2A000
	incbin "../Extracted/segments/bankC2_A000.bin":0..$DCA	; the rest of CenterIceTiles' stream
CenterIcePalettes:					; 16 colours per team in team order, for CenterIceTiles; the game
									; screen setup sends the home team's to CGRAM palette 3
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; ANH
	dw $7FFF,$2524,$11A4,$108D,$1089,$1092,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; BOS
	dw $7FFF,$01B6,$02DF,$2529,$1084,$037F,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; BUF
	dw $7FFF,$4804,$5889,$5889,$3400,$037F,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; CGY
	dw $7FFF,$0016,$001F,$2529,$1084,$037F,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; CHI
	dw $7FFF,$1084,$1084,$2529,$1084,$001F,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; DAL
	dw $7FFF,$1084,$1084,$2529,$1084,$25A0,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; DET
	dw $7FFF,$0016,$001F,$0016,$000D,$5AD6,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; EDM
	dw $7FFF,$3404,$4889,$4889,$3404,$01BF,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; FLA
	dw $7FFF,$0016,$001F,$4889,$3404,$037F,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; HFD
	dw $7FFF,$2529,$4A4D,$3484,$1000,$0124,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; LA
	dw $7FFF,$1084,$1084,$2529,$1084,$4A52,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; MTL
	dw $7FFF,$0016,$001F,$5884,$3400,$6F7B,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; NJ
	dw $7FFF,$1084,$1084,$2529,$1084,$0016,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; NYI
	dw $7FFF,$0092,$009B,$5800,$3400,$7C80,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; NYR
	dw $7FFF,$6C04,$7D20,$001B,$0012,$001F,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; OTW
	dw $7FFF,$0092,$109B,$2529,$1084,$2529,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; PHI
	dw $7FFF,$009B,$013F,$2529,$1084,$1084,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; PIT
	dw $7FFF,$01BF,$02DF,$2529,$1084,$1084,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; QUE
	dw $7FFF,$6D24,$7DA4,$6D24,$6C84,$6F7B,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; SJ
	dw $7FFF,$35A4,$4A44,$2529,$1084,$35AD,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; STL
	dw $7FFF,$4800,$6C00,$6C00,$4800,$013F,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; TB
	dw $7FFF,$1084,$1084,$2529,$1084,$6C00,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; TOR
	dw $7FFF,$5800,$7C00,$7C00,$5800,$5AD6,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; VAN
	dw $7FFF,$025F,$037F,$2529,$1084,$013F,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; WSH
	dw $7FFF,$0016,$001F,$6C00,$3400,$6C00,$025B,$7ED2
	dw $7F72,$1084,$4A52,$6F7B,$7FFF,$4A5B,$35B6,$4A52	; WPG
	dw $7FFF,$4800,$6C00,$001B,$0012,$0016,$025B,$7ED2
	dw $7FF2,$35A0,$0000,$5816,$5816,$7FFF,$0000,$009B	; ASE
	dw $0012,$0009,$6F7B,$3652,$5AD2,$3529,$49A9,$35AD
	dw $7FF2,$5889,$0000,$5816,$5816,$7FFF,$0000,$0096	; ASW
	dw $0012,$1009,$35AD,$5809,$4804,$6F7B,$2529,$4A52
VisualConceptsMap:					; the developer credit: VISUAL CONCEPTS ... PRESENT; one screen
									; setup in bank $C4 loads it and HighScoreMap
	dw VisualConceptsTiles-VisualConceptsMap-2	; the chunk's length (the bytes after this word)
	db $20,$0C						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $0300						; the unpacked size
	incbin "../Extracted/segments/bankC2_B000.bin":$151..$27C
VisualConceptsTiles:				; its tiles (101)
	dw VisualConceptsPalette-VisualConceptsTiles-2	; the chunk's length
	dw 101							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $0CA0						; the unpacked size
	incbin "../Extracted/segments/bankC2_B000.bin":$286..$B22
VisualConceptsPalette:				; its colours (32)
	dw HighScoreMap-VisualConceptsPalette-2	; the chunk's length
	db 2							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 32							; the colour count
	dw $0000,$0000,$0C63,$1084,$18C6,$2108,$2D6B,$35AD
	dw $3DEF,$4631,$5294,$5AD6,$6318,$6F7B,$77BD,$7FFF
	dw $03E0,$5AD6,$4631,$35AD,$2D6B,$7B18,$7A95,$7E32
	dw $2108,$716C,$18C6,$5CC6,$5064,$1084,$3C00,$3400

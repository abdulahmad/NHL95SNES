; Segment bankC1_C000: the faceoff box's map set, three chunks (map, tiles, colours) as in bankC1_B000.
org $C1CFE2
FaceOffMap:							; the faceoff box: 4 frames of 12 x 10 tiles, the referee dropping
									; the puck (94S FaceOffMap)
	dw FaceOffTiles-FaceOffMap-2	; the chunk's length (the bytes after this word)
	db $20,$28						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $0A00						; the unpacked size
	incbin "../Extracted/segments/bankC1_C000.bin":$FE9..$1000
	incbin "../Extracted/segments/bankC1_D000.bin":0..$1BD
FaceOffTiles:						; its tiles (78)
	dw FaceOffPalette-FaceOffTiles-2	; the chunk's length
	dw 78							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), two bytes that must match, a zero
	dw $09C0						; the unpacked size
	incbin "../Extracted/segments/bankC1_D000.bin":$1C7..$751
FaceOffPalette:						; its colours (16)
	dw PadButtonsMap-FaceOffPalette-2	; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $0240,$0000,$318C,$4E73,$6739,$4A5B,$35B6,$5AD6
	dw $7FFF,$739C,$7FB8,$012D,$0089,$2108,$025B,$7ED2

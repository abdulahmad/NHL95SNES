; Segment bankC2_7000: the end of the title goalie's map set, then the title logo's map set (map, tiles,
; colours as in bankC1_B000; the logo is 2bpp, for BG3 in mode 1).
org $C27000
	incbin "../Extracted/segments/bankC2_7000.bin":0..$1CF	; the rest of TitleGoalieTiles' stream
TitleGoaliePalette:					; the title goalie's colours (16)
	dw TitleLogoMap-TitleGoaliePalette-2	; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $03E0,$1400,$1800,$2020,$2840,$2C81,$34C2,$3D03
	dw $4565,$49A6,$5207,$5A49,$62AB,$66ED,$6F4F,$7FE0
TitleLogoMap:						; the title logo (BG3, 2bpp): EA SPORTS presents NHL '95 with the
									; (R) mark (94S TitleLogoTiles)
	dw TitleLogoTiles-TitleLogoMap-2	; the chunk's length (the bytes after this word)
	db $20,$14						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $0500						; the unpacked size
	incbin "../Extracted/segments/bankC2_7000.bin":$1FD..$487
TitleLogoTiles:						; its tiles (176)
	dw TitleLogoPalette-TitleLogoTiles-2	; the chunk's length
	dw 176							; the tile count (not read by the loaders)
	db $80,$02,$02,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $0B00						; the unpacked size
	incbin "../Extracted/segments/bankC2_7000.bin":$491..$90C
TitleLogoPalette:					; its colours (12)
	dw CenterIceTiles-TitleLogoPalette-2	; the chunk's length
	db 3							; the palette count (not read by the loaders)
	dw 4							; colours per palette
	dw 12							; the colour count
	dw $6B5A,$0000,$3569,$7FFF,$6B5A,$0000,$085F,$0434
	dw $6B5A,$0000,$7C00,$5000

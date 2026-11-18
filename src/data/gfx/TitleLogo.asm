TitleLogoMap:						; the title logo (BG3, 2bpp): EA SPORTS presents NHL '95 with the
									; (R) mark (94S TitleLogoTiles)
	dw TitleLogoTiles-TitleLogoMap-2	; the chunk's length (the bytes after this word)
	db $20,$14						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $0500						; the unpacked size
	incbin "../../../Extracted/segments/bankC2_7000.bin":$1FD..$487
TitleLogoTiles:						; its tiles (176)
	dw TitleLogoPalette-TitleLogoTiles-2	; the chunk's length
	dw 176							; the tile count (not read by the loaders)
	db $80,$02,$02,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $0B00						; the unpacked size
	incbin "../../../Extracted/segments/bankC2_7000.bin":$491..$90C
TitleLogoPalette:					; its colours (12)
	dw CenterIceTiles-TitleLogoPalette-2	; the chunk's length
	db 3							; the palette count (not read by the loaders)
	dw 4							; colours per palette
	dw 12							; the colour count
	dw $6B5A,$0000,$3569,$7FFF,$6B5A,$0000,$085F,$0434
	dw $6B5A,$0000,$7C00,$5000

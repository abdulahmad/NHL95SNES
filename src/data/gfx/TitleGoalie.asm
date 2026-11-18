TitleGoalieMap:						; the title screen's back layer (BG2): a goalie in the crease, the
									; boards and the crowd, 64 x 20 tiles
	dw TitleGoalieTiles-TitleGoalieMap-2	; the chunk's length (the bytes after this word)
	db $40,$14						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $0A00						; the unpacked size
	incbin "../../../Extracted/segments/bankC2_2000.bin":$CB9..$1000
	incbin "../../../Extracted/segments/bankC2_3000.bin":0..$34F
TitleGoalieTiles:					; the title goalie's tiles (677)
	dw TitleGoaliePalette-TitleGoalieTiles-2	; the chunk's length
	dw 677							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $54A0						; the unpacked size
	incbin "../../../Extracted/segments/bankC2_3000.bin":$359..$1000
	incbin "../../../Extracted/segments/bankC2_4000.bin"	; TitleGoalieTiles' stream, continued
	incbin "../../../Extracted/segments/bankC2_5000.bin"	; TitleGoalieTiles' stream, continued
	incbin "../../../Extracted/segments/bankC2_6000.bin"	; TitleGoalieTiles' stream, continued
	incbin "../../../Extracted/segments/bankC2_7000.bin":0..$1CF	; the rest of TitleGoalieTiles' stream
TitleGoaliePalette:					; the title goalie's colours (16)
	dw TitleLogoMap-TitleGoaliePalette-2	; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $03E0,$1400,$1800,$2020,$2840,$2C81,$34C2,$3D03
	dw $4565,$49A6,$5207,$5A49,$62AB,$66ED,$6F4F,$7FE0

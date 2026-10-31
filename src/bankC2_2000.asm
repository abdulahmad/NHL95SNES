; Segment bankC2_2000: the title players' colours, then the map chunk of the title goalie's map set (as in
; bankC1_B000); its tiles start bankC2_3000.
org $C22C8B
TitlePlayersPalette:				; the title players' colours (16)
	dw TitleGoalieMap-TitlePlayersPalette-2	; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $03E0,$1400,$1800,$2020,$2840,$2C81,$34C2,$3D03
	dw $4565,$49A6,$5207,$5A49,$62AB,$66ED,$6F4F,$7FE0
TitleGoalieMap:						; the title screen's back layer (BG2): a goalie in the crease, the
									; boards and the crowd, 64 x 20 tiles
	dw TitleGoalieTiles-TitleGoalieMap-2	; the chunk's length (the bytes after this word)
	db $40,$14						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $0A00						; the unpacked size
	incbin "../Extracted/segments/bankC2_2000.bin":$CB9..$1000
	incbin "../Extracted/segments/bankC2_3000.bin":0..$34F

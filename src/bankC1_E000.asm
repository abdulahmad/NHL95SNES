; Segment bankC1_E000: the map chunk of the team name bars' map set (map, tiles, colours as in bankC1_B000);
; its tiles start bankC1_F000.
org $C1E9B2
TeamNameBarsMap:					; the city name bars of the 26 teams in team colours, 12 x 2 tiles
									; each; code in bank $C4 unpacks it to unpackbuf after the
									; playoff bracket
	dw TeamNameBarsTiles-TeamNameBarsMap-2	; the chunk's length (the bytes after this word)
	db $0C,$34						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $04E0						; the unpacked size
	incbin "../Extracted/segments/bankC1_E000.bin":$9B9..$E6B

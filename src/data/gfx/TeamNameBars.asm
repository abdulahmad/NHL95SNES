TeamNameBarsMap:					; the playoff bracket's team name bars: the 26 teams' city names in team
									; colours, 12 x 2 tiles each; PopulateBracketTeams copies them into
									; rinkmapbuf (CopyBracketTeamBar)
	dw TeamNameBarsTiles-TeamNameBarsMap-2	; the chunk's length (the bytes after this word)
	db $0C,$34						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $04E0						; the unpacked size
	incbin "../../../Extracted/segments/bankC1_E000.bin":$9B9..$E6B
TeamNameBarsTiles:					; the team name bars' tiles (460)
	dw TeamNameBarsPalette-TeamNameBarsTiles-2	; the chunk's length
	dw 460							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $3980						; the unpacked size
	incbin "../../../Extracted/segments/bankC1_E000.bin":$E75..$1000
	incbin "../../../Extracted/segments/bankC1_F000.bin"
org $C20000
	incbin "../../../Extracted/segments/bankC2_0000.bin":0..$A91	; the rest of TeamNameBarsTiles' stream
TeamNameBarsPalette:				; the team name bars' colours (16)
	dw TitlePlayersMap-TeamNameBarsPalette-2	; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $0000,$6F7B,$4A52,$2529,$1084,$025B,$01B6,$0000
	dw $4884,$3400,$0124,$0080,$0136,$000D,$35B6,$112D

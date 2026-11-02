; Segment bankC2_0000: the end of the team name bars' map set, then the title screen's first map set (map,
; tiles, colours as in bankC1_B000); its tiles start bankC2_1000.
org $C20000
	incbin "../Extracted/segments/bankC2_0000.bin":0..$A91	; the rest of TeamNameBarsTiles' stream
TeamNameBarsPalette:				; the team name bars' colours (16)
	dw TitlePlayersMap-TeamNameBarsPalette-2	; the chunk's length
	db 1							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 16							; the colour count
	dw $0000,$6F7B,$4A52,$2529,$1084,$025B,$01B6,$0000
	dw $4884,$3400,$0124,$0080,$0136,$000D,$35B6,$112D
TitlePlayersMap:					; the title screen's front layer (BG1): three players; two other
									; screen setups in bank $C4 load it too
	dw TitlePlayersTiles-TitlePlayersMap-2	; the chunk's length (the bytes after this word)
	db $20,$14						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $0500						; the unpacked size
	incbin "../Extracted/segments/bankC2_0000.bin":$ABF..$DE6

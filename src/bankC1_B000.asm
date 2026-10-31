; Segment bankC1_B000: the pause screen's map set, as MapSetToVRAM and the WRAM loader read it: three chunks
; (map, tiles, colours), each a length word first; the map and tile streams are LZSS (DecompressLZSS).
org $C1BA31
PauseScreenMap:						; the pause screen: the Info / Stats / Options tabs, the periods,
									; both penalty boxes, dot-matrix digits; a screen setup in bank $C5
									; loads it into a WRAM buffer
	dw PauseScreenTiles-PauseScreenMap-2	; the chunk's length (the bytes after this word)
	db $20,$23						; the width and height in tiles
	db $8C							; flags: bit 7 packed (LZSS), bit 2 a map of words (bit 3 not
									; traced)
	dw $08C0						; the unpacked size
	incbin "../Extracted/segments/bankC1_B000.bin":$A38..$E61
PauseScreenTiles:					; its tiles (272)
	dw PauseScreenPalette-PauseScreenTiles-2	; the chunk's length
	dw 272							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $2200						; the unpacked size
	incbin "../Extracted/segments/bankC1_B000.bin":$E6B..$1000
	incbin "../Extracted/segments/bankC1_C000.bin":0..$F9B
PauseScreenPalette:					; its colours (32)
	dw FaceOffMap-PauseScreenPalette-2	; the chunk's length
	db 2							; the palette count (not read by the loaders)
	dw 16							; colours per palette
	dw 32							; the colour count
	dw $7C12,$0000,$7FFF,$7FFB,$777B,$7F76,$62D6,$24E7
	dw $1884,$7ECD,$5252,$3DAD,$7D25,$314A,$7C12,$1042
	dw $7C12,$7FFF,$62D6,$24E7,$1884,$0000,$001B,$27FF
	dw $012C,$4A5F,$1CA5,$1042,$314A,$6C1F,$6C1F,$6C1F

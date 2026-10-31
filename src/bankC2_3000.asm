; Segment bankC2_3000: the tiles chunk of the title goalie's map set (as in bankC1_B000); its LZSS stream runs
; on through bankC2_4000 to bankC2_6000 and ends in bankC2_7000.
org $C2334F
TitleGoalieTiles:					; the title goalie's tiles (677)
	dw TitleGoaliePalette-TitleGoalieTiles-2	; the chunk's length
	dw 677							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $54A0						; the unpacked size
	incbin "../Extracted/segments/bankC2_3000.bin":$359..$1000

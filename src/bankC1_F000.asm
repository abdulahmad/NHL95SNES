; Segment bankC1_F000: the tiles chunk of the team name bars' map set (as in bankC1_B000); its LZSS stream
; runs on into bankC2_0000, which has the colours chunk after it.
org $C1EE6B
TeamNameBarsTiles:					; the team name bars' tiles (460)
	dw TeamNameBarsPalette-TeamNameBarsTiles-2	; the chunk's length
	dw 460							; the tile count (not read by the loaders)
	db $80,$04,$04,$00				; flags (bit 7 packed), the bits per pixel twice (they must match), a zero
	dw $3980						; the unpacked size
	incbin "../Extracted/segments/bankC1_E000.bin":$E75..$1000
	incbin "../Extracted/segments/bankC1_F000.bin"

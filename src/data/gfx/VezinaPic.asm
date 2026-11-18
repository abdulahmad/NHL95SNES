VezinaPicMap:						; the picture of award 0 (AwardPictures): Vezina Trophy
	dw VezinaPicTiles-VezinaPicMap-2	; map chunk length
	db $09,$0D						; width and height in tiles
	db $8C							; packed word map; other flag bits not traced
	dw $00EA						; unpacked map size
	incbin "../../../Extracted/segments/bankC6_F000.bin":$DEF..$E87
VezinaPicTiles:						; its tiles (59); LZSS stream continues into the next bank
	dw VezinaPicPalette-VezinaPicTiles-2	; tiles chunk length
	dw $003B						; tile count
	db $80,$04,$04,$00				; packed tiles; bits per pixel twice, then zero
	dw $0760						; unpacked tile size
check bankcross off
	incbin "../../../Extracted/segments/bankC6_F000.bin":$E91..$1000
	incbin "../../../Extracted/segments/bankC7_0000.bin":$0..$517
VezinaPicPalette:					; its colours (16)
	dw .end-VezinaPicPalette-2		; palette chunk length
	db $01							; palette count
	dw $0010,$0010					; colours per palette and total colours
	dw $7C00,$5AD6,$4A52,$35AD,$2529,$35B2,$252D,$1129
	dw $35B2,$0004,$0089,$1089,$7F7F,$5AD6,$4A56,$0000
.end:								; end of the picture
check bankcross full

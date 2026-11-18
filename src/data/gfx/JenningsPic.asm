JenningsPicMap:						; the picture of award 3 (AwardPictures): William M. Jennings Trophy
	dw JenningsPicTiles-JenningsPicMap-2	; map chunk length
	db $09,$0D						; width and height in tiles
	db $8C							; packed word map; other flag bits not traced
	dw $00EA						; unpacked map size
check bankcross off
	incbin "../../../Extracted/segments/bankC9_F000.bin":$FF2..$1000
	incbin "../../../Extracted/segments/bankCA_0000.bin":$0..$D6
JenningsPicTiles:					; its tiles (95)
	dw JenningsPicPalette-JenningsPicTiles-2	; tiles chunk length
	dw $005F						; tile count
	db $80,$04,$04,$00				; packed tiles; bits per pixel twice, then zero
	dw $0BE0						; unpacked tile size
	incbin "../../../Extracted/segments/bankCA_0000.bin":$E0..$9B2
JenningsPicPalette:					; its colours (16)
	dw .end-JenningsPicPalette-2	; palette chunk length
	db $01							; palette count
	dw $0010,$0010					; colours per palette and total colours
	dw $7C00,$5AD6,$4A56,$4A52,$35AD,$2529,$35B2,$2529
	dw $252D,$1084,$0000,$1089,$6F7B,$7FFF,$5AD6,$0000
.end:								; end of the picture
check bankcross full

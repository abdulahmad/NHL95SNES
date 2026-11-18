HartPicMap:							; the picture of award 4 (AwardPictures): Hart Memorial Trophy
	dw HartPicTiles-HartPicMap-2	; map chunk length
	db $09,$0D						; width and height in tiles
	db $8C							; packed word map; other flag bits not traced
	dw $00EA						; unpacked map size
	incbin "../../../Extracted/segments/bankCD_F000.bin":$332..$3B8
HartPicTiles:						; its tiles (49)
	dw HartPicPalette-HartPicTiles-2	; tiles chunk length
	dw $0031						; tile count
	db $80,$04,$04,$00				; packed tiles; bits per pixel twice, then zero
	dw $0620						; unpacked tile size
	incbin "../../../Extracted/segments/bankCD_F000.bin":$3C2..$923
HartPicPalette:						; its colours (16)
	dw .end-HartPicPalette-2		; palette chunk length
	db $01							; palette count
	dw $0010,$0010					; colours per palette and total colours
	dw $7C00,$7FFF,$6F7B,$35AD,$1084,$35B2,$0004,$3656
	dw $35B2,$4ADB,$5AD6,$2529,$1CE7,$35AD,$4A52,$0000
.end:								; end of the picture

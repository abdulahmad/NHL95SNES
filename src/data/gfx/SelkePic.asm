SelkePicMap:						; the picture of award 1 (AwardPictures): Frank J. Selke Trophy
	dw SelkePicTiles-SelkePicMap-2	; map chunk length
	db $09,$0D						; width and height in tiles
	db $8C							; packed word map; other flag bits not traced
	dw $00EA						; unpacked map size
	incbin "../../../Extracted/segments/bankC7_F000.bin":$E85..$F65
SelkePicTiles:						; its tiles (47); LZSS stream continues into the next bank
	dw SelkePicPalette-SelkePicTiles-2	; tiles chunk length
	dw $002F						; tile count
	db $80,$04,$04,$00				; packed tiles; bits per pixel twice, then zero
	dw $05E0						; unpacked tile size
check bankcross off
	incbin "../../../Extracted/segments/bankC7_F000.bin":$F6F..$1000
	incbin "../../../Extracted/segments/bankC8_0000.bin":$0..$532
SelkePicPalette:					; its colours (16)
	dw .end-SelkePicPalette-2		; palette chunk length
	db $01							; palette count
	dw $0010,$0010					; colours per palette and total colours
	dw $7C00,$0000,$5ADB,$5AD6,$5816,$35AD,$4A52,$35B2
	dw $1089,$2529,$1084,$35B2,$252D,$7F7F,$6F7B,$0000
.end:								; end of the picture
check bankcross full

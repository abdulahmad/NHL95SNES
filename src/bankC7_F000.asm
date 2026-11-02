; Raw planar frame tiles, followed by an award picture that ends in the next bank.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C7F09E
DATA8_C7F09E:						; raw frame tiles for transfer index $0FB; pose not traced
	incbin "../Extracted/segments/bankC7_F000.bin":$9E..$31E
DATA8_C7F31E:						; raw frame tiles for transfer index $0FC; pose not traced
	incbin "../Extracted/segments/bankC7_F000.bin":$31E..$57E
DATA8_C7F57E:						; raw frame tiles for transfer index $0FD; pose not traced
	incbin "../Extracted/segments/bankC7_F000.bin":$57E..$77E
DATA8_C7F77E:						; raw frame tiles for transfer index $0FE; pose not traced
	incbin "../Extracted/segments/bankC7_F000.bin":$77E..$9DE
DATA8_C7F9DE:						; raw frame tiles for transfer index $0FF; pose not traced
	incbin "../Extracted/segments/bankC7_F000.bin":$9DE..$C5E
DATA8_C7FC5E:						; raw frame tiles for transfer index $100; pose not traced
	incbin "../Extracted/segments/bankC7_F000.bin":$C5E..$E7E
SelkePicMap:						; the picture of award 1 (AwardPictures): Frank J. Selke Trophy
	dw SelkePicTiles-SelkePicMap-2	; map chunk length
	db $09,$0D						; width and height in tiles
	db $8C							; packed word map; other flag bits not traced
	dw $00EA						; unpacked map size
	incbin "../Extracted/segments/bankC7_F000.bin":$E85..$F65
SelkePicTiles:						; its tiles (47); LZSS stream continues into the next bank
	dw SelkePicPalette-SelkePicTiles-2	; tiles chunk length
	dw $002F						; tile count
	db $80,$04,$04,$00				; packed tiles; bits per pixel twice, then zero
	dw $05E0						; unpacked tile size
check bankcross off
	incbin "../Extracted/segments/bankC7_F000.bin":$F6F..$1000
	incbin "../Extracted/segments/bankC8_0000.bin":$0..$532
SelkePicPalette:					; its colours (16)
	dw .end-SelkePicPalette-2		; palette chunk length
	db $01							; palette count
	dw $0010,$0010					; colours per palette and total colours
	dw $7C00,$0000,$5ADB,$5AD6,$5816,$35AD,$4A52,$35B2
	dw $1089,$2529,$1084,$35B2,$252D,$7F7F,$6F7B,$0000
.end:								; end of the picture
check bankcross full

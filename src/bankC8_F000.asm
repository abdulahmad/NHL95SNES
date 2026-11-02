; Raw planar frame tiles, followed by an award picture that ends in the next bank.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C8F1B9
DATA8_C8F1B9:						; raw frame tiles for transfer index $1D0; pose not traced
	incbin "../Extracted/segments/bankC8_F000.bin":$1B9..$439
DATA8_C8F439:						; raw frame tiles for transfer index $1D1; pose not traced
	incbin "../Extracted/segments/bankC8_F000.bin":$439..$6B9
DATA8_C8F6B9:						; raw frame tiles for transfer index $1D2; pose not traced
	incbin "../Extracted/segments/bankC8_F000.bin":$6B9..$939
DATA8_C8F939:						; raw frame tiles for transfer index $1D3; pose not traced
	incbin "../Extracted/segments/bankC8_F000.bin":$939..$BB9
DATA8_C8FBB9:						; raw frame tiles for transfer index $1D4; pose not traced
	incbin "../Extracted/segments/bankC8_F000.bin":$BB9..$E39
ConnSmythePicMap:					; the picture of award 2 (AwardPictures): Conn Smythe Trophy
	dw ConnSmythePicTiles-ConnSmythePicMap-2	; map chunk length
	db $09,$0D						; width and height in tiles
	db $8C							; packed word map; other flag bits not traced
	dw $00EA						; unpacked map size
	incbin "../Extracted/segments/bankC8_F000.bin":$E40..$EFE
ConnSmythePicTiles:					; its tiles (76); LZSS stream continues into the next bank
	dw ConnSmythePicPalette-ConnSmythePicTiles-2	; tiles chunk length
	dw $004C						; tile count
	db $80,$04,$04,$00				; packed tiles; bits per pixel twice, then zero
	dw $0980						; unpacked tile size
check bankcross off
	incbin "../Extracted/segments/bankC8_F000.bin":$F08..$1000
	incbin "../Extracted/segments/bankC9_0000.bin":$0..$744
ConnSmythePicPalette:				; its colours (16)
	dw .end-ConnSmythePicPalette-2	; palette chunk length
	db $01							; palette count
	dw $0010,$0010					; colours per palette and total colours
	dw $7C00,$7FFF,$6F7B,$252D,$4A52,$2529,$1084,$0000
	dw $112D,$008D,$1089,$5ADF,$5AD6,$4A52,$35AD,$0000
.end:								; end of the picture
check bankcross full

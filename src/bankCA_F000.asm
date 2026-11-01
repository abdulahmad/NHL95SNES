; Raw planar frame tiles, followed by an award picture that ends in the next bank.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CAF039
DATA8_CAF039:						; raw frame tiles for transfer index $2D0; pose not traced
	incbin "../Extracted/segments/bankCA_F000.bin":$39..$299
DATA8_CAF299:						; raw frame tiles for transfer index $2D1; pose not traced
	incbin "../Extracted/segments/bankCA_F000.bin":$299..$4F9
DATA8_CAF4F9:						; raw frame tiles for transfer index $2D2; pose not traced
	incbin "../Extracted/segments/bankCA_F000.bin":$4F9..$779
DATA8_CAF779:						; raw frame tiles for transfer index $2D3; pose not traced
	incbin "../Extracted/segments/bankCA_F000.bin":$779..$979
DATA8_CAF979:						; raw frame tiles for transfer index $2D4; pose not traced
	incbin "../Extracted/segments/bankCA_F000.bin":$979..$BF9
DATA8_CAFBF9:						; raw frame tiles for transfer index $2D5; pose not traced
	incbin "../Extracted/segments/bankCA_F000.bin":$BF9..$DF9
ArtRossPicMap:						; the picture of award 5 (AwardPictures): Art Ross Trophy
	dw ArtRossPicTiles-ArtRossPicMap-2	; map chunk length
	db $09,$0D						; width and height in tiles
	db $8C							; packed word map; other flag bits not traced
	dw $00EA						; unpacked map size
	incbin "../Extracted/segments/bankCA_F000.bin":$E00..$ECC
ArtRossPicTiles:					; its tiles (82); LZSS stream continues into the next bank
	dw ArtRossPicPalette-ArtRossPicTiles-2	; tiles chunk length
	dw $0052						; tile count
	db $80,$04,$04,$00				; packed tiles; bits per pixel twice, then zero
	dw $0A40						; unpacked tile size
check bankcross off
	incbin "../Extracted/segments/bankCA_F000.bin":$ED6..$1000
	incbin "../Extracted/segments/bankCB_0000.bin":$0..$88E
ArtRossPicPalette:					; its colours (16)
	dw .end-ArtRossPicPalette-2		; palette chunk length
	db $01							; palette count
	dw $0010,$0010					; colours per palette and total colours
	dw $7C00,$7FFF,$1084,$6F7B,$252D,$4A52,$2529,$1089
	dw $112D,$35B2,$1132,$25B6,$5AD6,$35AD,$4AD6,$0000
.end:								; continue
check bankcross full

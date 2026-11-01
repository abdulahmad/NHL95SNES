; Raw planar frame tiles, followed by an award picture that ends in the next bank.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CBF175
DATA8_CBF175:						; raw frame tiles for transfer index $375; pose not traced
	incbin "../Extracted/segments/bankCB_F000.bin":$175..$3D5
DATA8_CBF3D5:						; raw frame tiles for transfer index $376; pose not traced
	incbin "../Extracted/segments/bankCB_F000.bin":$3D5..$5D5
DATA8_CBF5D5:						; raw frame tiles for transfer index $377; pose not traced
	incbin "../Extracted/segments/bankCB_F000.bin":$5D5..$7D5
DATA8_CBF7D5:						; raw frame tiles for transfer index $378; pose not traced
	incbin "../Extracted/segments/bankCB_F000.bin":$7D5..$9D5
DATA8_CBF9D5:						; raw frame tiles for transfer index $379; pose not traced
	incbin "../Extracted/segments/bankCB_F000.bin":$9D5..$BD5
DATA8_CBFBD5:						; raw frame tiles for transfer index $37A; pose not traced
	incbin "../Extracted/segments/bankCB_F000.bin":$BD5..$DD5
NorrisPicMap:						; the picture of award 6 (AwardPictures): James Norris Memorial Trophy
	dw NorrisPicTiles-NorrisPicMap-2	; map chunk length
	db $09,$0D						; width and height in tiles
	db $8C							; packed word map; other flag bits not traced
	dw $00EA						; unpacked map size
	incbin "../Extracted/segments/bankCB_F000.bin":$DDC..$E83
NorrisPicTiles:						; its tiles (66); LZSS stream continues into the next bank
	dw NorrisPicPalette-NorrisPicTiles-2	; tiles chunk length
	dw $0042						; tile count
	db $80,$04,$04,$00				; packed tiles; bits per pixel twice, then zero
	dw $0840						; unpacked tile size
check bankcross off
	incbin "../Extracted/segments/bankCB_F000.bin":$E8D..$1000
	incbin "../Extracted/segments/bankCC_0000.bin":$0..$5BE
NorrisPicPalette:					; its colours (16)
	dw .end-NorrisPicPalette-2		; palette chunk length
	db $01							; palette count
	dw $0010,$0010					; colours per palette and total colours
	dw $7C00,$6F7B,$5ADB,$5AD6,$5AD6,$35B2,$0004,$252D
	dw $0084,$4A52,$35AD,$2529,$25AD,$1084,$1129,$0000
.end:								; end of the picture
check bankcross full

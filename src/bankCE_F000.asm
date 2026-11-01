; Segment bankCE_F000: PresidentsPic (the Presidents Trophy picture), then StanleyCupMap / Tiles / Palette
; (the Stanley Cup), then zeros to the end of the bank.
org $CEF0AB
PresidentsPicMap:					; the picture of award 7 (AwardPictures): Presidents Trophy
	dw PresidentsPicTiles-PresidentsPicMap-2	; map chunk length
	db $09,$0D						; width and height in tiles
	db $8C							; packed word map; other flag bits not traced
	dw $00EA						; unpacked map size
	incbin "../Extracted/segments/bankCE_F000.bin":$B2..$146
PresidentsPicTiles:					; its tiles (34)
	dw PresidentsPicPalette-PresidentsPicTiles-2	; tiles chunk length
	dw $0022						; tile count
	db $80,$04,$04,$00				; packed tiles; bits per pixel twice, then zero
	dw $0440						; unpacked tile size
	incbin "../Extracted/segments/bankCE_F000.bin":$150..$3C2
PresidentsPicPalette:				; its colours (16)
	dw .end-PresidentsPicPalette-2	; palette chunk length
	db $01							; palette count
	dw $0010,$0010					; colours per palette and total colours
	dw $7C00,$0000,$5AD6,$6F7B,$35AD,$4A52,$35B2,$252D
	dw $6318,$1129,$1089,$0084,$2529,$6F7F,$7FFF,$0000
.end:								; continue
StanleyCupMap:						; the Stanley Cup (rendered), 8 x 14 tiles; CODE_C4DFD6 loads it
	dw StanleyCupTiles-StanleyCupMap-2	; map chunk length
	db $08,$0E						; width and height in tiles
	db $8C							; packed word map; other flag bits not traced
	dw $00E0						; unpacked map size
	incbin "../Extracted/segments/bankCE_F000.bin":$3F0..$4C7
StanleyCupTiles:					; its tiles (87)
	dw StanleyCupPalette-StanleyCupTiles-2	; tiles chunk length
	dw $0057						; tile count
	db $80,$04,$04,$00				; packed tiles; bits per pixel twice, then zero
	dw $0AE0						; unpacked tile size
	incbin "../Extracted/segments/bankCE_F000.bin":$4D1..$E50
StanleyCupPalette:					; its colours (16)
	dw .end-StanleyCupPalette-2		; palette chunk length
	db $01							; palette count
	dw $0010,$0010					; colours per palette and total colours
	dw $27E0,$3529,$1084,$5A52,$2CE7,$1000,$2484,$6ED6
	dw $5A52,$49AD,$49B2,$2529,$7F7B,$0000,$5AD6,$6F7B
.end:								; continue
	padbyte $00						; unused to the end of the bank
	pad $CF0000

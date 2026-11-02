; Segment bankCD_1000: the rest of the IceRinkTiles stream, then IceRinkPalette.
org $CD1000
; The IceRinkTiles stream continues from the previous segment.
	incbin "../Extracted/segments/bankCD_1000.bin":$0..$1000
	incbin "../Extracted/segments/bankCD_2000.bin":$0..$559
IceRinkPalette:						; its colours (64), 4 palettes
	dw .end-IceRinkPalette-2		; palette chunk length
	db $04							; palette count
	dw $0010,$0040					; colours per palette and total colours
	dw $7FFF,$1400,$7FD9,$025B,$7ECD,$7D25,$7FFF,$4A5F
	dw $18DF,$6EDF,$7F72,$49AD,$5A52,$6ED6,$24A5,$3529
	dw $7F76,$0000,$1084,$3529,$49AD,$5A52,$2529,$7FFF
	dw $125B,$0132,$4A56,$012D,$5A52,$49AD,$01A0,$6DA0
	dw $7F76,$0000,$4BE0,$6FE0,$7FE0,$4BFB,$37F6,$5BF6
	dw $03E0,$13F6,$27FF,$03ED,$03E9,$03FF,$03FB,$7FF2
	dw $7F76,$0000,$4880,$6D20,$7E40,$4A5B,$35B6,$5AD6
	dw $7FFF,$1016,$241F,$012D,$0089,$03FF,$025B,$7ED2
.end:								; end of the map set

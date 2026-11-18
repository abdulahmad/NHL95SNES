PadArrow2:							; DrawPadArrows' step for pad 2 (c1playernum+2), continuing with PadArrow3
	ldy.w c1playernum+2
	bmi PadArrow3
	ldx.w #PadArrow3&$FFFF
	bra DrawPadArrow

PadArrow3:							; DrawPadArrows' step for pad 3 (c1playernum+4), continuing with PadArrow4
	ldy.w c1playernum+4
	bmi PadArrow4
	ldx.w #PadArrow4&$FFFF
	bra DrawPadArrow

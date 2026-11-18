PadArrow4:							; DrawPadArrows' step for pad 4 (c1playernum+6), continuing with PadArrow5
	ldy.w c1playernum+6
	bmi PadArrow5
	ldx.w #PadArrow5&$FFFF
	bra DrawPadArrow

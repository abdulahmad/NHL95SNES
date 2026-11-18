PadArrow5:							; pad 5 player arrow, then PadArrowsDone
	ldy.w c1playernum+8
	bmi PadArrowsDone
	ldx.w #PadArrowsDone&$FFFF
	bra DrawPadArrow

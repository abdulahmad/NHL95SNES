DrawPadArrows:						; the arrow sprite over the player each pad controls (c1playernum on), for
									; the five pads in turn, written straight to the OAM buffer
	dec.b QueueBusy
	tsc
	sta.b $1C
	lda.b $28
	tcs
	ldy.w c1playernum
	bmi PadArrow2
	ldx.w #PadArrow2&$FFFF
	bra DrawPadArrow

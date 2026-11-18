ReadMenuPads:						; the buttons of all 5 pads ORed into the menu pad word; repeatdelayframes
									; counts the frames they stay the same (0 on a change)
	lda.b PadRaw1
	ora.b PadRaw2
	ora.b PadRaw3
	ora.b PadRaw4
	ora.b PadRaw5
	sta.w padchangeany
	inc.w repeatdelayframes
	cmp.w padlast1
	beq .rtl
	stz.w repeatdelayframes
	sta.w padlast1
.rtl:								; return
	rtl

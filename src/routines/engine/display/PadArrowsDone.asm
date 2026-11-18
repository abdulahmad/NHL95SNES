PadArrowsDone:						; the end of DrawPadArrows: the OAM pointer ($28) kept, the stack back,
									; QueueBusy cleared
	tsc
	sta.b $28
	lda.b $1C
	tcs
	stz.b QueueBusy
	rtl

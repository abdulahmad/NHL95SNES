NextSortedGameObject:				; advance the sorted object loop or restore the caller stack
	ldx.b $1A
	dex
	bpl DrawSortedGameObject
	tsc
	sta.b $28
	lda.b $1C
	tcs
	sty.b $2A
	stz.b QueueBusy
	rtl

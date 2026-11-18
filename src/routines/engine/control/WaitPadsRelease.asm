WaitPadsRelease:					; wait until every standard pad has released its buttons
	phx
	pha
.loop:								; loop: X = $0008
	ldx.w #$0008
.loop2:								; loop: A = PadRaw1,x, if a $000F bit set go to .1, ...
	lda.b PadRaw1,x
	bit.w #$000F
	bne .1
	and.w #$FFF0
	bne .loop
.1:									; X - 1, X - 1, if the result >= 0 go to .loop2, pull A, ...
	dex
	dex
	bpl .loop2
	pla
	plx
	rtl

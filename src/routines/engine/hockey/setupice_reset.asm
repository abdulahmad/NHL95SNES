setupice_reset:						; resets the rink state: Oldrow $03E7, the pause bit cleared, Hpos / Vpos
									; 0, the sort objects, pfgoal turned with the direction of play, sfhormode
									; 0, then the scoreboard
	jsl.l forceblack
	lda.w #$03E7
	sta.w Oldrow
	lda.w #$0001
	trb.w sflags
	stz.b Hpos
	stz.b Vpos
	lda.b $5F
	dec a
	dec a
	sta.w vcountmark+2
	jsl.l defaultsprites_0
	lda.w gmode
	bit.w #$0002
	beq .1
	ldx.w #$0016
.loop:								; loop: A = pfgoal,x, A xor $0001, pfgoal,x = A, X - 1, ...
	lda.w pfgoal,x
	eor.w #$0001
	sta.w pfgoal,x
	dex
	dex
	bpl .loop
.1:									; sfhormode = 0, go to DrawScoreBox
	stz.w sfhormode
	jmp.w DrawScoreBox

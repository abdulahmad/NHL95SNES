Gameloop:							; the game loop: frame counts and the speed, a random team song, the time
									; steps from Vcount, ReadPads, the clock and the game, Pausemode on the
									; sflags pause bit
	lda.b $26
	lsr a
	lda.w #$E000
	bcs .1
	lda.w #$F000
.1:									; $D7 = A, A = Vcount, X = A, A - OldVcount, ...
	sta.b $D7
	lda.b Vcount
	tax
	sec
	sbc.w OldVcount
	bne .2
	inc a
	inx
.2:									; push X, push A, A = $003C, X = gameframes, ...
	phx
	pha
	lda.w #$003C
	ldx.b gameframes
	inx
	stx.b gameframes
	stx.b $26
	jsl.l Mul16x8U
	lda.w FrameCount
	sta.b r1
	jsl.l Div32U
	lda.b r0
	sta.w gamefps
	lda.w gsp
	cmp.w #$0002
	bne .3
	jsl.l RandomWord
	and.w #$03FF
	bne .3
	lda.w #$0005
	jsl.l PlayTeamSong
.3:									; pull A, pull X, d7 = A, timestep = A, ...
	pla
	plx
	sta.b d7
	sta.w timestep
	asl a
	sta.w impactstep
	asl a
	asl a
	asl a
	sta.w velstep
	asl a
	sta.w gravstep
	asl a
	adc.w gravstep
	sta.w gravstep
	stx.w lastframevc
	stx.w OldVcount
	jsl.l ReadPads
	lda.w sflags
	bit.w #$0001
	bne .8
	lda.w gmclock
	bne .8
	lda.w shootoutmode
	bne .6
	lda.w PenShotActive
	beq .6
	lda.w pstimer
	ldx.b d7
	dex
	beq .4
	sec
	sbc.b d7
.4:									; A - d7, pstimer = A, if plus go to .5, call EndPenaltyShot, ...
	sec
	sbc.b d7
	sta.w pstimer
	bpl .5
	jsl.l EndPenaltyShot
	bra .8
.5:									; r2 = A, r1 = $001E, call Div16x8U, d0 = r0, ...
	sta.b r2
	lda.w #$001E
	sta.b r1
	jsl.l Div16x8U
	lda.b r0
	sta.b d0
	jsl.l PushTime
	ldx.w #$007E
	lda.b a1
	ldy.w #$5B23
	jsl.l QueueVRAMDMALen
	bra .8
.6:									; X = d7, X - 1, if the result = 0 go to .7, call GameClockTick
	ldx.b d7
	dex
	beq .7
	jsr.w GameClockTick
.7:									; call GameClockTick
	jsr.w GameClockTick
.8:									; if cheercnt = 0 go to .9, A = Vcount, A - cheervc, ...
	lda.w cheercnt
	beq .9
	lda.b Vcount
	sec
	sbc.w cheervc
	cmp.w #$0096
	bcc .9
	dec.w cheercnt
	lda.w cheervc
	clc
	adc.w #$0096
	sta.w cheervc
.9:									; call DoGameFrame, call demoread, A = sflags, ...
	jsl.l DoGameFrame
	jsl.l demoread
	lda.w sflags
	bit.w #$0001
	bne .10
	lda.w mp5warning
	beq .11
	lda.w gmode
	bit.w #$0010
	bne .11
	lda.w #$0001
	tsb.w sflags
.10:								; call Pausemode
	jsl.l Pausemode
.11:								; if shootoutmode = 0 go to .12, if shootoutturnover = 0 go to .12, return
	lda.w shootoutmode
	beq .12
	lda.w shootoutturnover
	beq .12
	rtl
.12:								; go to Gameloop
	jmp.w Gameloop

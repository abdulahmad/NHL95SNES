Intermission:						; the intermission between periods: the teams set up
									; (SetupTeamForIntermission), the ticker, the pause pad, then
									; Pausemode_menu
	jsl.l SetupTeamForIntermission
	lda.w #$0000
	ldy.w #$001E
.loop:								; loop: Xpos,y = A, Y - 1, Y - 1, if the result >= 0 go to .loop, ...
	sta.w Xpos,y
	dey
	dey
	bpl .loop
	lda.b Vcount
	ldy.b $5F
	sta.w vcountmark
	sty.w vcountmark+2
	lda.w #$0001
	trb.w sflags
	lda.w gsp
	cmp.w #$0004
	beq .1
	bra .1
.1:									; pausetimer = $0708, demoflag = $0001, A = Vcount, A - $0150, ...
	lda.w #$0708
	sta.w pausetimer
	lda.w #$0001
	sta.w demoflag
	lda.b Vcount
	sec
	sbc.w #$0150
	sta.w tickervc
	jsl.l Intermission_ticker
	lda.w TickerNum
	sta.w tickerstart
	lda.w #$FFFF
	sta.w sfpj
	ldy.w #$0000
	tyx
.loop2:								; loop: if cont1team,y is not 0 go to .2, X + 1, X + 1, ...
	lda.w cont1team,y
	bne .2
	inx
	inx
	cpx.w #$0008
	bne .loop2
	lda.w #$0001
.2:									; A xor $FFFF, A + 1, sfpj = A, A = cont1team, ...
	eor.w #$FFFF
	inc a
	sta.w sfpj
	lda.w cont1team
	ora.w cont2team
	ora.w cont3team
	ora.w cont4team
	ora.w cont5team
	bne .3
	stz.w sfpj
.3:									; InIntermission = $0001, if DemoMode = 0 go to .4, go to .5
	lda.w #$0001
	sta.w InIntermission
	lda.w DemoMode
	beq .4
	jmp.w .5
.4:									; call AddIntermissionGoals
	jsl.l AddIntermissionGoals
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	pei ($8F)
	pei ($91)
	pei ($93)
	pei ($95)
	pei ($97)
	pei ($99)
	pei ($9B)
	pei ($9D)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	pei ($73)
	pei ($75)
	pei ($77)
	pei ($79)
	pei ($7B)
	pei ($7D)
	jsl.l Pausemode_menu
	pla
	sta.b $7D
	pla
	sta.b $7B
	pla
	sta.b $79
	pla
	sta.b $77
	pla
	sta.b $75
	pla
	sta.b a4
	pla
	sta.b a3+2
	pla
	sta.b a3
	pla
	sta.b a2+2
	pla
	sta.b a2
	pla
	sta.b a1+2
	pla
	sta.b a1
	pla
	sta.b a0+2
	pla
	sta.b a0
	pla
	sta.b d7+2
	pla
	sta.b d7
	pla
	sta.b d6+2
	pla
	sta.b d6
	pla
	sta.b d5+2
	pla
	sta.b d5
	pla
	sta.b d4+2
	pla
	sta.b d4
	pla
	sta.b d3+2
	pla
	sta.b d3
	pla
	sta.b d2+2
	pla
	sta.b d2
	pla
	sta.b d1+2
	pla
	sta.b d1
	pla
	sta.b d0+2
	pla
	sta.b d0
	jsl.l FreePauseBuffers
	jsl.l QueueSavedTextMap
	jsl.l SoundVolumeUp
.5:									; Vcount = 0, OldVcount = 0, pausemenuon = 0, InIntermission = 0, ...
	stz.b Vcount
	stz.w OldVcount
	stz.w pausemenuon
	stz.w InIntermission
	stz.w demoflag
Intermission_rtl:					; the return at the end of Intermission; Intermission_ticker leaves
									; through it when there is no ticker game
	rtl

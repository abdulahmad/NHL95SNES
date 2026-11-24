PassReceiverOneTimer:				; animate and time the pass receiver one-timer attempt
	lda.w SPA,x
	cmp.w #SPAonetimef&$FFFF
	beq .7
	cmp.w #SPAonetimeb&$FFFF
	beq .7
	phy
	ldy.w #$0000
	cpx.w #$000C
	bmi .1
	ldy.w #$0002
.1:									; A = tmOneTimerSwings,y, A + 1, tmOneTimerSwings,y = A, pull Y, ...
	lda.w tmOneTimerSwings,y
	inc a
	sta.w tmOneTimerSwings,y
	ply
	lda.w #$0000
	sec
	sbc.w passtargetx
	sta.b d0
	lda.w pfgoal,x
	bne .2
	lda.w #$FEF2
	sec
	sbc.w passtargety
	sta.b d1
	bra .3
.2:									; A = $010E, A - passtargety, d1 = A
	lda.w #$010E
	sec
	sbc.w passtargety
	sta.b d1
.3:									; call vtoa, call Findhittype, if zero go to .4, ...
	jsl.l vtoa
	jsl.l Findhittype
	beq .4
	lda.w #SPAonetimeb&$FFFF
	bra .5
.4:									; A = SPAonetimef
	lda.w #SPAonetimef&$FFFF
.5:									; call SetSPAFromA, go to PassReceiverReturn
	jsl.l SetSPAFromA
	jmp.w PassReceiverReturn
.6:									; go to EndPassReceiverAssignment
	jmp.w EndPassReceiverAssignment
.7:									; nopuck,x = $000A, if SPAnum,x >= $0010 go to .6, if minus go to .6, ...
	lda.w #$000A
	sta.w nopuck,x
	lda.w SPAnum,x
	cmp.w #$0010
	bcs .6
	bit.w OneTimerDist
	bmi .6
	txa
	jsl.l GetHot
	lda.w Xpos,x
	clc
	adc.b d0
	sec
	sbc.w puckx
	tay
	lda.w Ypos,x
	clc
	adc.b d1
	sec
	sbc.w pucky
	jsl.l ApproxLength
	cmp.w OneTimerDist
	sta.w OneTimerDist
	bcs .8
	jmp.w .14
.8:									; A = Xpos,x, A - puckx, Y = A, A = Ypos,x, ...
	lda.w Xpos,x
	sec
	sbc.w puckx
	tay
	lda.w Ypos,x
	sec
	sbc.w pucky
	jsl.l ApproxLength
	cmp.w #$001C
	bcs .14
	lda.w #$FFFF
	sta.w OneTimerDist
	stz.w puckvx
	stz.w puckvy
	stz.w SPAcnt,x
	stx.w puckc
	ldy.w playerpad,x
	bmi .9
	lda.w paddir,y
	sta.w passdir
	bra .10
.9:									; passdir = $0008
	lda.w #$0008
	sta.w passdir
.10:								; passspeed = $0024, pfalock,x = A, if gmclock is not 0 go to .12, ...
	lda.w #$0024
	sta.w passspeed
	sta.w pfalock,x
	lda.w gmclock
	bne .12
	phy
	ldy.w #$0000
	cpx.w #$000C
	bmi .11
	ldy.w #$0002
.11:								; A = tmOneTimers,y, A + 1, tmOneTimers,y = A, pull Y
	lda.w tmOneTimers,y
	inc a
	sta.w tmOneTimers,y
	ply
.12:								; onetimer = $0001, A = CwdExciteLvl, A + $000A, ...
	lda.w #$0001
	sta.w onetimer
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi .13
	sta.w CwdExciteLvl
.13:								; a2 = X, call a2touchpuck, pull A, a2 = A, ...
	pei ($6B)
	stx.b a2
	jsl.l a2touchpuck
	pla
	sta.b a2
	jsl.l doshot
	jmp.w EndPassReceiverAssignment
.14:								; if puckc < 0 go to .rtl, if X = puckc go to .rtl, go to
									; EndPassReceiverAssignment
	lda.w puckc
	bmi .rtl
	cpx.w puckc
	beq .rtl
	jmp.w EndPassReceiverAssignment
.rtl:								; return
	rtl

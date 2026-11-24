passtoa0:							; from dopass and other segments
	jsl.l loadTeamStruct
	lda.w gmclock
	bne .1
	ldy.b a2
	lda.w tmpasses,y
	inc a
	sta.w tmpasses,y
.1:									; X = topgoalie,y, A = aidef,x, A / 2, A + $0001, ...
	ldx.w topgoalie,y
	lda.w aidef,x
	lsr a
	clc
	adc.w #$0001
	adc.w temp1,x
	sta.w temp1,x
	lda.b a0
	sta.w passReceiverPlayerNum
	ldx.b a0
	lda.w #$0015
	sta.b d0
	jsl.l assinsert
	ldx.b a3
	ldy.b a0
	lda.w frame,y
	pha
	lda.w attribute,y
	bit.w #$0800
	beq .2
	lda.w #$0000
	sec
	sbc.w facedir,y
	bra .3
.2:									; A = facedir,y
	lda.w facedir,y
.3:									; A and $0007, A * 2, X = A, A = SPAonetimef,x, ...
	and.w #$0007
	asl a
	tax
	lda.l SPAonetimef,x
	tax
	lda.l $C40000,x
	ldx.b a3
	ldy.b a0
	sta.w frame,y
	lda.b a0
	jsl.l GetHot
	ldy.b a0
	pla
	sta.w frame,y
	lda.b d1
	clc
	adc.w Ypos,y
	sec
	sbc.w pucky
	sta.b d1
	lda.b d0
	clc
	adc.w Xpos,y
	sec
	sbc.w puckx
	sta.b d0
	lda.w #$0018
	sta.b d6
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldy.b a0
	ldx.w Xvel,y
	jsl.l Mul16XS
	lda.b r2+2
	clc
	adc.b d0
	sta.b d2
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldx.w Yvel,y
	jsl.l Mul16XS
	lda.b r2+2
	clc
	adc.b d1
	sta.b d3
	ldy.b d2
	jsl.l ApproxLength
	sta.b d4
	asl a
	tax
	lda.w #$0003
	jsl.l DivX8U
	cmp.w #$0040
	bcc .4
	cmp.w #$0050
	bcc .6
	ldx.b d4
	lda.w #$0005
	jsl.l DivX8U
	sta.b d6
	lda.w #$0050
	bra .5
.4:									; A = d4, A / 2, A / 2, d6 = A, ...
	lda.b d4
	lsr a
	lsr a
	sta.b d6
	lda.w #$0040
.5:									; push A, A = d6, A * 2, A * 2, ...
	pha
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldy.b a0
	ldx.w Xvel,y
	jsl.l Mul16XS
	lda.b r2+2
	clc
	adc.b d0
	sta.b d2
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldx.w Yvel,y
	jsl.l Mul16XS
	lda.b r2+2
	clc
	adc.b d1
	sta.b d3
	ldy.b d2
	jsl.l ApproxLength
	sta.b d4
	pla
.6:									; d5 = A, passspeed = A, X = curobj, A = $0010, ...
	sta.b d5
	sta.w passspeed
	ldx.b curobj
	lda.w #$0010
	sec
	sbc.w passacc,x
	jsl.l randomd0s
	clc
	adc.b d5
	sta.b d5
	ldx.b d2
	jsl.l Mul16x8XS
	lda.b d4
	sta.b r1
	jsl.l Div32S
	lda.b r0
	xba
	and.w #$FF00
	sta.w puckvx
	lda.b d5
	ldx.b d3
	jsl.l Mul16x8XS
	lda.b d4
	sta.b r1
	jsl.l Div32S
	lda.b r0
	xba
	and.w #$FF00
	sta.w puckvy
	lda.b d2
	clc
	adc.w puckx
	sta.w passtargetx
	lda.b d3
	clc
	adc.w pucky
	sta.w passtargety
	lda.b d4
	asl a
	asl a
	asl a
	sta.w puckvz
	lda.w #$000A
	sta.w nopuck+28
	ldy.b a0
	lda.b d6
	clc
	adc.w #$0006
	sta.w passwait,y
	ldx.b curobj
	lda.b d6
	sta.w nopuck,x
	ldy.b a2
	lda.w playerpad,x
	sta.w passpad,y
	lda.w position,x
	bne .rtl
	lda.w playerpad,x
	bmi .rtl
	stz.w Xvel,x
	stz.w Yvel,x
	lda.w playerpad,x
	sta.b d4
	lda.w passReceiverPlayerNum
	sta.b d0
	jsl.l AssignPadIfFree
	lda.w playerpad,x
	bmi .rtl
	jsl.l findpc
.rtl:								; return
	rtl

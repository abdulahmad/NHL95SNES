DrawPadArrow:						; the arrow for player Y: over him when he is on screen, else at the
									; screen edge pointing at him; then on to the continuation in X
	stx.b tmp3
	lda.w Xpos,y
	clc
	adc.w #$0080
	sec
	sbc.b Hpos
	sta.b $0A
	sec
	lda.b Vpos
	sbc.w Ypos,y
	clc
	adc.w #$005E
	sta.b $0C
	bmi .4
	cmp.w #$00E0
	bcc .1
	jmp.w .10
.1:									; if $0A >= 0 go to .2, go to .20
	lda.b $0A
	bpl .2
	jmp.w .20
.2:									; if A < $0100 go to .3, go to .16
	cmp.w #$0100
	bcc .3
	jmp.w .16
.3:									; jump through $00A5
	jmp ($00A5)
.4:									; tmp2 = $C4FFF6,x, tmp1 = $C4FFF8,x, if $0A >= 0 go to .5, go to .24
	lda.l $C4FFF6,x
	sta.b tmp2
	lda.l $C4FFF8,x
	sta.b tmp1
	lda.b $0A
	bpl .5
	jmp.w .24
.5:									; if A < $0100 go to .6, go to .26
	cmp.w #$0100
	bcc .6
	jmp.w .26
.6:									; A = $C4FFF2,x, Y = A, if $0000,y = 0 go to .7, $0000,y = $0000, ...
	lda.l $C4FFF2,x
	tay
	lda.w $0000,y
	beq .7
	lda.w #$0000
	sta.w $0000,y
	jsr.w QueuePadArrowVert
.7:									; if $0A < $00E9 go to .8, A = $00E8
	lda.b $0A
	cmp.w #$00E9
	bcc .8
	lda.w #$00E8
.8:									; if A >= $0009 go to .9, A = $0009
	cmp.w #$0009
	bcs .9
	lda.w #$0009
.9:									; A or $0800, $0A = A, push A, X = $2A, ...
	ora.w #$0800
	sta.b $0A
	clc
	pei ($A3)
	pha
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	lda.b $0A
	adc.w #$0510
	pha
	iny
	phy
	adc.w #$02E8
	pha
	iny
	phy
	adc.w #$080C
	pha
	jmp ($00A5)
.10:								; A = $C4FFF6,x, A or $8000, tmp2 = A, A = $C4FFF8,x, ...
	lda.l $C4FFF6,x
	ora.w #$8000
	sta.b tmp2
	lda.l $C4FFF8,x
	ora.w #$8000
	sta.b tmp1
	lda.b $0A
	bpl .11
	jmp.w .28
.11:								; if A < $0100 go to .12, go to .30
	cmp.w #$0100
	bcc .12
	jmp.w .30
.12:								; A = $C4FFF2,x, Y = A, if $0000,y = 0 go to .13, $0000,y = $0000, ...
	lda.l $C4FFF2,x
	tay
	lda.w $0000,y
	beq .13
	lda.w #$0000
	sta.w $0000,y
	jsr.w QueuePadArrowVert
.13:								; if $0A < $00E9 go to .14, A = $00E8
	lda.b $0A
	cmp.w #$00E9
	bcc .14
	lda.w #$00E8
.14:								; if A >= $0009 go to .15, A = $0009
	cmp.w #$0009
	bcs .15
	lda.w #$0009
.15:								; A or $C800, $0A = A, push A, X = $2A, ...
	ora.w #$C800
	sta.b $0A
	clc
	pei ($A3)
	pha
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	lda.b $0A
	adc.w #$0310
	pha
	iny
	phy
	adc.w #$FCE8
	pha
	iny
	phy
	adc.w #$F80B
	pha
	jmp ($00A5)
.16:								; tmp2 = $C4FFF6,x, tmp1 = $C4FFF8,x, A = $C4FFF2,x, Y = A, ...
	lda.l $C4FFF6,x
	sta.b tmp2
	lda.l $C4FFF8,x
	sta.b tmp1
	lda.l $C4FFF2,x
	tay
	lda.w #$0002
	cmp.w $0000,y
	beq .17
	sta.w $0000,y
	clc
	jsr.w QueuePadArrowSide
.17:								; if $0C >= $0009 go to .18, A = $0009
	lda.b $0C
	cmp.w #$0009
	bcs .18
	lda.w #$0009
.18:								; if A < $00C8 go to .19, A = $00C7
	cmp.w #$00C8
	bcc .19
	lda.w #$00C7
.19:								; A or $00E8, $0C = A, push A, X = $2A, ...
	xba
	ora.w #$00E8
	sta.b $0C
	clc
	pei ($A3)
	pha
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	lda.b $0C
	adc.w #$F803
	pha
	iny
	phy
	adc.w #$17FF
	pha
	iny
	phy
	adc.w #$F3F5
	pha
	jmp ($00A5)
.20:								; A = $C4FFF6,x, A or $4000, tmp2 = A, A = $C4FFF8,x, ...
	lda.l $C4FFF6,x
	ora.w #$4000
	sta.b tmp2
	lda.l $C4FFF8,x
	ora.w #$4000
	sta.b tmp1
	lda.l $C4FFF2,x
	tay
	lda.w #$0002
	cmp.w $0000,y
	beq .21
	sta.w $0000,y
	clc
	jsr.w QueuePadArrowSide
.21:								; if $0C >= $0009 go to .22, A = $0009
	lda.b $0C
	cmp.w #$0009
	bcs .22
	lda.w #$0009
.22:								; if A < $00C8 go to .23, A = $00C7
	cmp.w #$00C8
	bcc .23
	lda.w #$00C7
.23:								; A or $0008, $0C = A, push A, X = $2A, ...
	xba
	ora.w #$0008
	sta.b $0C
	clc
	pei ($A3)
	pha
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	lda.b $0C
	adc.w #$F805
	pha
	iny
	phy
	adc.w #$17FF
	pha
	iny
	phy
	adc.w #$F40B
	pha
	jmp ($00A5)
.24:								; A = $C4FFF2,x, Y = A, if zero go to .25, $0000,y = A, ...
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq .25
	sta.w $0000,y
	jsr.w QueuePadArrowCorner
.25:								; A = $4000, A or tmp2, push A, X = $2A, ...
	lda.w #$4000
	tsb.b tmp1
	ora.b tmp2
	pha
	pea.w $0908
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	pea.w $0418
	iny
	phy
	pea.w $1903
	iny
	phy
	pea.w $1514
	jmp ($00A5)
.26:								; A = $C4FFF2,x, Y = A, if zero go to .27, $0000,y = A, ...
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq .27
	sta.w $0000,y
	jsr.w QueuePadArrowCorner
.27:								; X = $2A, $00,x = $0002, $02,x = 0, A = X, ...
	pei ($A3)
	pea.w $09E8
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	pea.w $04E0
	iny
	phy
	pea.w $19F5
	iny
	phy
	pea.w $15E4
	jmp ($00A5)
.28:								; A = $C4FFF2,x, Y = A, if zero go to .29, $0000,y = A, ...
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq .29
	sta.w $0000,y
	jsr.w QueuePadArrowCorner
.29:								; A = $4000, A or tmp2, push A, X = $2A, ...
	lda.w #$4000
	tsb.b tmp1
	ora.b tmp2
	pha
	pea.w $C708
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	pea.w $D418
	iny
	phy
	pea.w $BF03
	iny
	phy
	pea.w $C314
	jmp ($00A5)
.30:								; A = $C4FFF2,x, Y = A, if zero go to .31, $0000,y = A, ...
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq .31
	sta.w $0000,y
	jsr.w QueuePadArrowCorner
.31:								; X = $2A, $00,x = $0002, $02,x = 0, A = X, ...
	pei ($A3)
	pea.w $C7E8
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	pea.w $D4E0
	iny
	phy
	pea.w $BFF5
	iny
	phy
	pea.w $C3E4
	jmp ($00A5)

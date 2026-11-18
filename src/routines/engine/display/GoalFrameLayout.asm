GoalFrameLayout:					; the layout code of the second net, SPFgoal+1 (layouts $8F / $90): its 16
									; x 16 pieces at fixed offsets, then on through tmp3
	pei ($A3)
	ldx.w #$0002
	lda.b $0A
	bpl .1
	cmp.w #$FFF1
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, if $0C >= 0 go to .3, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $0C
	bpl .3
	cmp.w #$FFF1
	and.w #$00FF
	bcs .4
.2:									; pull A, go to .5
	pla
	bra .5
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.5:									; A = tmp2, A + $0002, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$0002
	pha
	ldx.w #$0002
	clc
	lda.w #$0010
	adc.b $0A
	bpl .6
	cmp.w #$FFF1
	bcc .7
	inx
	and.w #$00FF
.6:									; if A >= $0100 go to .7, tmp0 = A, if $0C >= 0 go to .8, ...
	cmp.w #$0100
	bcs .7
	sta.b tmp0
	lda.b $0C
	bpl .8
	cmp.w #$FFF1
	and.w #$00FF
	bcs .9
.7:									; pull A, go to .10
	pla
	bra .10
.8:									; if A >= $00E0 go to .7
	cmp.w #$00E0
	bcs .7
.9:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.10:								; A = tmp2, A + $0004, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$0004
	pha
	ldx.w #$0002
	lda.b $0A
	bpl .11
	cmp.w #$FFF1
	bcc .12
	inx
	and.w #$00FF
.11:								; if A >= $0100 go to .12, tmp0 = A, A = $0010, A + $0C, ...
	cmp.w #$0100
	bcs .12
	sta.b tmp0
	lda.w #$0010
	adc.b $0C
	bpl .13
	cmp.w #$FFF1
	and.w #$00FF
	bcs .14
.12:								; pull A, go to .15
	pla
	bra .15
.13:								; if A >= $00E0 go to .12
	cmp.w #$00E0
	bcs .12
.14:								; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.15:								; A = tmp2, A + $0006, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$0006
	pha
	ldx.w #$0002
	clc
	lda.w #$0010
	adc.b $0A
	bpl .16
	cmp.w #$FFF1
	bcc .17
	inx
	and.w #$00FF
.16:								; if A >= $0100 go to .17, tmp0 = A, A = $0010, A + $0C, ...
	cmp.w #$0100
	bcs .17
	sta.b tmp0
	lda.w #$0010
	adc.b $0C
	bpl .18
	cmp.w #$FFF1
	and.w #$00FF
	bcs .19
.17:								; pull A, go to .20
	pla
	bra .20
.18:								; if A >= $00E0 go to .17
	cmp.w #$00E0
	bcs .17
.19:								; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.20:								; A = tmp2, A + $4000, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$4000
	pha
	ldx.w #$0002
	clc
	lda.w #$002D
	adc.b $0A
	bpl .21
	cmp.w #$FFF1
	bcc .22
	inx
	and.w #$00FF
.21:								; if A >= $0100 go to .22, tmp0 = A, if $0C >= 0 go to .23, ...
	cmp.w #$0100
	bcs .22
	sta.b tmp0
	lda.b $0C
	bpl .23
	cmp.w #$FFF1
	and.w #$00FF
	bcs .24
.22:								; pull A, go to .25
	pla
	bra .25
.23:								; if A >= $00E0 go to .22
	cmp.w #$00E0
	bcs .22
.24:								; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.25:								; A = tmp2, A + $4002, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$4002
	pha
	ldx.w #$0002
	clc
	lda.w #$001D
	adc.b $0A
	bpl .26
	cmp.w #$FFF1
	bcc .27
	inx
	and.w #$00FF
.26:								; if A >= $0100 go to .27, tmp0 = A, if $0C >= 0 go to .28, ...
	cmp.w #$0100
	bcs .27
	sta.b tmp0
	lda.b $0C
	bpl .28
	cmp.w #$FFF1
	and.w #$00FF
	bcs .29
.27:								; pull A, go to .30
	pla
	bra .30
.28:								; if A >= $00E0 go to .27
	cmp.w #$00E0
	bcs .27
.29:								; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.30:								; A = tmp2, A + $4004, push A, X = $0002
	clc
	lda.b tmp2
	adc.w #$4004
	pha
	ldx.w #$0002
	clc
	lda.w #$002D
	adc.b $0A
	bpl .31
	cmp.w #$FFF1
	bcc .32
	inx
	and.w #$00FF
.31:								; if A >= $0100 go to .32, tmp0 = A, A = $0010, A + $0C, ...
	cmp.w #$0100
	bcs .32
	sta.b tmp0
	lda.w #$0010
	adc.b $0C
	bpl .33
	cmp.w #$FFF1
	and.w #$00FF
	bcs .34
.32:								; pull A, go to .35
	pla
	bra .35
.33:								; if A >= $00E0 go to .32
	cmp.w #$00E0
	bcs .32
.34:								; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.35:								; A = tmp2, A + $4006, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$4006
	pha
	ldx.w #$0002
	clc
	lda.w #$001D
	adc.b $0A
	bpl .36
	cmp.w #$FFF1
	bcc .37
	inx
	and.w #$00FF
.36:								; if A >= $0100 go to .37, tmp0 = A, A = $0010, A + $0C, ...
	cmp.w #$0100
	bcs .37
	sta.b tmp0
	lda.w #$0010
	adc.b $0C
	bpl .38
	cmp.w #$FFF1
	and.w #$00FF
	bcs .39
.37:								; pull A, go to .40
	pla
	bra .40
.38:								; if A >= $00E0 go to .37
	cmp.w #$00E0
	bcs .37
.39:								; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.40:								; jump through $00A5
	jmp ($00A5)

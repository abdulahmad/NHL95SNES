PuckFrameLayout:					; the layout code of the flipping puck, SPFpuck+1 to +10 (layouts $91 /
									; $92): one 8 x 8 piece raised by puckz * 3 / 2, then on through tmp3
	pei ($A1)
	ldx.w #$0000
	lda.b $0A
	bpl .1
	cmp.w #$FFF9
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = puckz, A * 2, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.w puckz
	asl a
	adc.w puckz
	lsr a
	eor.w #$FFFF
	sec
	adc.b $0C
	bpl .3
	cmp.w #$FFF9
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
.5:									; jump through $00A5
	jmp ($00A5)
	padbyte $00						; unused to the end of the ROM
	pad $D00000

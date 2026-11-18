SmallPieces4:						; four 8 x 8 pieces: their x / y bytes, the tile counter + 3, the fourth
									; piece's sprite, then PutSmallPiece3
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	lda.l $CF0003,x
	and.w #$00FF
	sta.b $E9
	lda.l $CF0004,x
	and.w #$00FF
	sta.b $F1
	lda.l $CF0005,x
	and.w #$00FF
	sta.b $EB
	lda.l $CF0006,x
	and.w #$00FF
	sta.b $F3
	lda.l $CF0007,x
	and.w #$00FF
	sta.b $ED
	lda.l $CF0008,x
	and.w #$00FF
	sta.b $F5
	clc
	lda.b tmp1
	adc.w #$0003
	sta.b tmp1
	lda.b tmp1
	pha
	dec a
	sta.b tmp1
	ldx.w #$0000
	clc
	lda.b $ED
	adc.b $0A
	bpl .1
	cmp.w #$FFF9
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $F5, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $F5
	adc.b $0C
	bpl .3
	cmp.w #$FFF9
	and.w #$00FF
	bcs .4
.2:									; pull A, go to PutSmallPiece3
	pla
	bra PutSmallPiece3
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
PutSmallPiece3:						; the third 8 x 8 piece's sprite (tile tmp1, x $EB / y $F3) when on
									; screen, then PutSmallPiece2
	lda.b tmp1
	pha
	dec a
	sta.b tmp1
	ldx.w #$0000
	clc
	lda.b $EB
	adc.b $0A
	bpl .1
	cmp.w #$FFF9
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $F3, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $F3
	adc.b $0C
	bpl .3
	cmp.w #$FFF9
	and.w #$00FF
	bcs .4
.2:									; pull A, go to PutSmallPiece2
	pla
	bra PutSmallPiece2
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
PutSmallPiece2:						; the second 8 x 8 piece's sprite (x $E9 / y $F1), then PutSmallPiece1
	lda.b tmp1
	pha
	dec a
	sta.b tmp1
	ldx.w #$0000
	clc
	lda.b $E9
	adc.b $0A
	bpl .1
	cmp.w #$FFF9
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $F1, A + $0C, ...
									; ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $F1
	adc.b $0C
	bpl .3
	cmp.w #$FFF9
	and.w #$00FF
	bcs .4
.2:									; pull A, go to PutSmallPiece1
	pla
	bra PutSmallPiece1
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
PutSmallPiece1:						; the first 8 x 8 piece's sprite (x $E7 / y $EF), then LayoutDone
	pei ($A1)
	ldx.w #$0000
	clc
	lda.b $E7
	adc.b $0A
	bpl .1
	cmp.w #$FFF9
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $EF, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $EF
	adc.b $0C
	bpl .3
	cmp.w #$FFF9
	and.w #$00FF
	bcs .4
.2:									; pull A, go to LayoutDone
	pla
	bra LayoutDone
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
LayoutDone:							; the end of a frame layout: on to the caller's continuation in tmp3
	jmp ($00A5)

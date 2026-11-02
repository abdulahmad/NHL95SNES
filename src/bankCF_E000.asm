; Segment bankCF_E000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $CFEE1D
NextSortedGameObjectJump:			; jumps to NextSortedGameObject: DrawSortedGameObject's continuation (in
									; $A5) for the frame code
	jml.l NextSortedGameObject
PadTagFrameDoneJump:				; jumps to PadTagFrameDone: the tags' continuation (in $A5) for the frame
									; code
	jml.l PadTagFrameDone
DrawFrameLayoutFlip:				; DrawFrameLayout for an x-flipped object: the flipped offsets and the
									; record next to the normal one
	asl a
	tax
	lda.l DATA8_C618D8,x
	adc.b $0C
	sta.b $0C
	clc
	lda.b $0A
	adc.l DATA8_C62120,x
	sta.b $0A
	lda.l DATA8_C60848+1,x
	and.w #$00FF
	dec a
	eor.w #$0001
	cmp.w #$008E
	bcs .1
	asl a
	tax
	lda.l DATA8_CFF3A2,x
	tax
	stx.b $E5
	lda.l $CF0000,x
	and.w #$00FF
	tax
	jmp (LayoutBigPieces,x)
.1:									; if A >= $0090 go to .2, A xor $0001, A * 2, X = A, ...
	cmp.w #$0090
	bcs .2
	eor.w #$0001
	asl a
	tax
	jmp (DATA8_CFF3A2,x)
.2:									; jump through $00A5
	jmp ($00A5)
DrawFrameLayout:					; draws frame A of a game object at x $0A / y $0C from its bank $CF layout
									; record: 1-4 16 x 16 pieces, then 1-4 8 x 8 ones, into the OAM buffer;
									; then on through $A5
	asl a
	tax
	lda.l DATA8_C61090,x
	adc.b $0A
	sta.b $0A
	clc
	lda.l DATA8_C618D8,x
	adc.b $0C
	sta.b $0C
	lda.l DATA8_C60848+1,x
	and.w #$00FF
	beq .2
	cmp.w #$008F
	bcs .1
	asl a
	tax
	lda.l DATA8_CFF3A0,x
	sta.b $E5
	tax
	lda.l $CF0000,x
	and.w #$00FF
	tax
	jmp (LayoutBigPieces,x)
.1:									; if A >= $0092 go to .2, A * 2, X = A, jump through DATA8_CFF3A0,x
	cmp.w #$0092
	bcs .2
	asl a
	tax
	jmp (DATA8_CFF3A0,x)
.2:									; jump through $00A5
	jmp ($00A5)
LayoutBigPieces:					; a layout record's 16 x 16 pieces by its first byte: 1, 2, 3 or 4 pieces,
									; or none (LayoutSmallNext)
	dw BigPieces1,BigPieces2,BigPieces3,BigPieces4
	dw LayoutSmallNext
BigPieces1:							; one 16 x 16 piece: its x / y bytes, then PutBigPiece1
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	jmp.w PutBigPiece1
BigPieces2:							; two 16 x 16 pieces: their x / y bytes, the tile counter + 2, then
									; PutBigPiece2
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
	lda.b tmp2
	inc a
	inc a
	sta.b tmp2
	jmp.w PutBigPiece2
BigPieces3:							; three 16 x 16 pieces: their x / y bytes, the tile counter + 4, then
									; PutBigPiece3
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
	clc
	lda.b tmp2
	adc.w #$0004
	sta.b tmp2
	jmp.w PutBigPiece3
BigPieces4:							; four 16 x 16 pieces: their x / y bytes, the tile counter + 6, the fourth
									; piece's sprite, then PutBigPiece3
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
	lda.b tmp2
	adc.w #$0006
	sta.b tmp2
	lda.b tmp2
	pha
	dec a
	dec a
	sta.b tmp2
	ldx.w #$0002
	clc
	lda.b $ED
	adc.b $0A
	bpl .1
	cmp.w #$FFF1
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
	cmp.w #$FFF1
	and.w #$00FF
	bcs .4
.2:									; pull A, go to PutBigPiece3
	pla
	bra PutBigPiece3
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
PutBigPiece3:						; the third 16 x 16 piece's sprite (tile tmp2, x $EB / y $F3 from x $0A /
									; y $0C) when on screen, then PutBigPiece2
	lda.b tmp2
	pha
	dec a
	dec a
	sta.b tmp2
	ldx.w #$0002
	clc
	lda.b $EB
	adc.b $0A
	bpl .1
	cmp.w #$FFF1
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
	cmp.w #$FFF1
	and.w #$00FF
	bcs .4
.2:									; pull A, go to PutBigPiece2
	pla
	bra PutBigPiece2
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
PutBigPiece2:						; the second 16 x 16 piece's sprite (x $E9 / y $F1), then PutBigPiece1
	lda.b tmp2
	pha
	dec a
	dec a
	sta.b tmp2
	ldx.w #$0002
	clc
	lda.b $E9
	adc.b $0A
	bpl .1
	cmp.w #$FFF1
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $F1, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $F1
	adc.b $0C
	bpl .3
	cmp.w #$FFF1
	and.w #$00FF
	bcs .4
.2:									; pull A, go to PutBigPiece1
	pla
	bra PutBigPiece1
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
PutBigPiece1:						; the first 16 x 16 piece's sprite (x $E7 / y $EF), then LayoutSmallNext
	pei ($A3)
	ldx.w #$0002
	clc
	lda.b $E7
	adc.b $0A
	bpl .1
	cmp.w #$FFF1
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
	cmp.w #$FFF1
	and.w #$00FF
	bcs .4
.2:									; pull A, go to LayoutSmallNext
	pla
	bra LayoutSmallNext
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
LayoutSmallNext:					; steps $E5 past the 16 x 16 part to the 8 x 8 part and runs it by its
									; first byte (LayoutSmallPieces)
	ldx.b $E5
	lda.l $CF0000,x
	and.w #$000F
	cmp.w #$0008
	bcc .1
	inx
	bra .2
.1:									; A + $0003, A + $E5, X = A
	adc.w #$0003
	adc.b $E5
	tax
.2:									; $E5 = X, A = $CF0000,x, A and $00FF, X = A, ...
	stx.b $E5
	lda.l $CF0000,x
	and.w #$00FF
	tax
	jmp (LayoutSmallPieces,x)
LayoutSmallPieces:					; a layout record's 8 x 8 pieces by their first byte: 1, 2, 3 or 4 pieces,
									; or none (LayoutDone)
	dw SmallPieces1,SmallPieces2,SmallPieces3,SmallPieces4
	dw LayoutDone
SmallPieces1:						; one 8 x 8 piece: its x / y bytes, then PutSmallPiece1
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	jmp.w PutSmallPiece1

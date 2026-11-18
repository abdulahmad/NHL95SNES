DrawFrameLayout:					; draws frame A of a game object at x $0A / y $0C from its bank $CF layout
									; record: 1-4 16 x 16 pieces, then 1-4 8 x 8 ones, into the OAM buffer;
									; then on through tmp3
	asl a
	tax
	lda.l FrameOffsetX,x
	adc.b $0A
	sta.b $0A
	clc
	lda.l FrameOffsetY,x
	adc.b $0C
	sta.b $0C
	lda.l FrameBankLayout+1,x
	and.w #$00FF
	beq .2
	cmp.w #$008F
	bcs .1
	asl a
	tax
	lda.l LayoutPointers-2,x
	sta.b $E5
	tax
	lda.l $CF0000,x
	and.w #$00FF
	tax
	jmp (LayoutBigPieces,x)
.1:									; if A >= $0092 go to .2, A * 2, X = A, jump through LayoutPointers-2,x
	cmp.w #$0092
	bcs .2
	asl a
	tax
	jmp (LayoutPointers-2,x)
.2:									; jump through $00A5
	jmp ($00A5)

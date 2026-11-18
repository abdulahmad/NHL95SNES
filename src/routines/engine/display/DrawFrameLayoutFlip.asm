DrawFrameLayoutFlip:				; DrawFrameLayout for an x-flipped object: the flipped offsets and the
									; record next to the normal one
	asl a
	tax
	lda.l FrameOffsetY,x
	adc.b $0C
	sta.b $0C
	clc
	lda.b $0A
	adc.l FrameOffsetXFlip,x
	sta.b $0A
	lda.l FrameBankLayout+1,x
	and.w #$00FF
	dec a
	eor.w #$0001
	cmp.w #$008E
	bcs .1
	asl a
	tax
	lda.l LayoutPointers,x
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
	jmp (LayoutPointers,x)
.2:									; jump through $00A5
	jmp ($00A5)

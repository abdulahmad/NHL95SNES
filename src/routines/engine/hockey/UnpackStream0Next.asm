UnpackStream0Next:					; the copy built in the DMA registers jumps back here: the stream pointer
									; from X
	stx.b $12
UnpackStream0Loop:					; the command loop, run through the bank $85 mirror
	lda.b [$12]
	bit.w #$0080
	beq .1
	and.w #$007F
	beq .2
	sta.b $15
	inc.b $12
	lda.b [$12]
	adc.b $18
	tax
	lda.b $12
	adc.w #$0002
	sta.b $12
	lda.b $15
	mvn $7E,$7E
	bra UnpackStream0Loop
.1:									; A and $007F, X = $12, X + 1, go to DMAP2
	and.w #$007F
	ldx.b $12
	inx
	jmp.w DMAP2						; run the literal copy built in the DMA registers
.2:									; X = $12, X + 1, A = $0000, go to .rts
	ldx.b $12
	inx
	lda.w #$0000
	tcd
	jml.l .rts
.rts:								; return
	rts

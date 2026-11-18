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

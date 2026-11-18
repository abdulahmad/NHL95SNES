BigPieces1:							; one 16 x 16 piece: its x / y bytes, then PutBigPiece1
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	jmp.w PutBigPiece1

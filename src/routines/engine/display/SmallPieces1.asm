SmallPieces1:						; one 8 x 8 piece: its x / y bytes, then PutSmallPiece1
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	jmp.w PutSmallPiece1

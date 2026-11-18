SmallPieces2:						; two 8 x 8 pieces: their x / y bytes, the tile counter + 1, then
									; PutSmallPiece2
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
	inc.b tmp1
	jmp.w PutSmallPiece2

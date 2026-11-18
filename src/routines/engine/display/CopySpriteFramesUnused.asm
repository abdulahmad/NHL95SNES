CopySpriteFramesUnused:				; sprite object A takes up to three frame words of object X ($28 on, up to
									; a negative one), $FFFF after them, then UploadSpriteAnimFrames; nothing
									; calls it
	txy
	tax
	stx.b p0
	lda.w $0028,y
	sta.b $28,x
	inx
	inx
	lda.w $002A,y
	bmi .1
	sta.b $28,x
	inx
	inx
	lda.w $002C,y
	bmi .1
	sta.b $28,x
	inx
	inx
.1:									; terminate the copied frame list and enter its upload continuation
	lda.w #$FFFF
	sta.b $28,x
	ldx.b p0
	bra UploadSpriteAnimFrames

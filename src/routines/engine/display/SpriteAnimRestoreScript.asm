SpriteAnimRestoreScript:			; restart the saved script and set the animation flag $4000
	lda.w $0020,y
	sta.w $001E,y
	asl a
	adc.w $002E,y
	tax
	lda.b $00,x
	tyx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	lda.b $22,x
	ora.w #$4000
	sta.b $22,x
	jmp.w ReadSpriteAnim

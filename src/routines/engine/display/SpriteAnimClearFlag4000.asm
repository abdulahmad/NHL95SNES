SpriteAnimClearFlag4000:			; clear the animation flag $4000 and continue
	tyx
	lda.b $22,x
	and.w #$BFFF
	sta.b $22,x
	jmp.w ReadSpriteAnim

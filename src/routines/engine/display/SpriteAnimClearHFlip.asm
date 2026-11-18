SpriteAnimClearHFlip:				; clear the horizontal flip attribute and continue
	tyx
	lda.b $36,x
	and.w #$BFFF
	sta.b $36,x
	jmp.w ReadSpriteAnim

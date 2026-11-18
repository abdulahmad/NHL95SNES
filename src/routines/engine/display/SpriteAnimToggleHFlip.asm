SpriteAnimToggleHFlip:				; toggle the horizontal flip attribute and continue
	tyx
	lda.b $36,x
	eor.w #$4000
	sta.b $36,x
	jmp.w ReadSpriteAnim

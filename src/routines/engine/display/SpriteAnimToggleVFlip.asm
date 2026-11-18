SpriteAnimToggleVFlip:				; toggle the vertical tile flip attribute and continue
	tyx
	lda.b $36,x
	eor.w #$8000
	sta.b $36,x
	jmp.w ReadSpriteAnim

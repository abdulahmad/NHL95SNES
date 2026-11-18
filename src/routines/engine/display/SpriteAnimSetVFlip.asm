SpriteAnimSetVFlip:					; set the vertical tile flip attribute and continue
	tyx
	lda.b $36,x
	ora.w #$8000
	sta.b $36,x
	jmp.w ReadSpriteAnim

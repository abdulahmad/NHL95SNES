SpriteAnimClearVFlip:				; clear the vertical tile flip attribute and continue
	tyx
	lda.b $36,x
	and.w #$7FFF
	sta.b $36,x
	jmp.w ReadSpriteAnim

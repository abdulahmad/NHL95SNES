SpriteAnimToggleFlips:				; toggle both tile flip attributes and continue
	tyx
	lda.b $36,x
	eor.w #$C000
	sta.b $36,x
	jmp.w ReadSpriteAnim

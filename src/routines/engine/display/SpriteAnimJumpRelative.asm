SpriteAnimJumpRelative:				; add the following word to the opcode position and continue
	ldx.b tmp1
	lda.w $0030,y
	dec a
	adc.b $01,x
	sta.w $0030,y
	tyx
	jmp.w ReadSpriteAnim

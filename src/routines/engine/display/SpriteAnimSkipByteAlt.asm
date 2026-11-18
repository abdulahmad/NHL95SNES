SpriteAnimSkipByteAlt:				; read a word but skip only one operand byte, then continue
	phy
	ldx.b tmp1
	lda.b $01,x
	ply
	tyx
	inc.b $30,x
	jmp.w ReadSpriteAnim

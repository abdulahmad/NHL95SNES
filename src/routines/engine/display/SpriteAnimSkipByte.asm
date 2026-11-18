SpriteAnimSkipByte:					; read and discard one operand byte, then continue
	phy
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	tax
	ply
	tyx
	inc.b $30,x
	jmp.w ReadSpriteAnim

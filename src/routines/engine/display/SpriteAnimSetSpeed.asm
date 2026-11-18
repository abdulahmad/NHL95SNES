SpriteAnimSetSpeed:					; read a little-endian word into the timer decrement field
	ldx.b tmp1
	lda.b $01,x
	tyx
	sta.b $0A,x
	inc.b $30,x
	inc.b $30,x
	jmp.w ReadSpriteAnim

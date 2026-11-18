DispatchSpriteAnim:					; advance past the opcode and dispatch its low seven bits
	tyx
	inc.b $30,x
	and.w #$007F
	asl a
	tax
	jmp (SpriteAnimCommands,x)

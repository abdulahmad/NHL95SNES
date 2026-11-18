SpriteAnimRestart:					; restart the current script at position zero immediately
	tyx
	stz.w $0030,x
	jmp.w ReadSpriteAnim

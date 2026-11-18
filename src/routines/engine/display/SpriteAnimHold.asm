SpriteAnimHold:						; rewind to this command and yield until the next timer expiry
	tyx
	dec.b $30,x
	ldy.b tmp0
	clc
	jmp.w AnimateNextSprite

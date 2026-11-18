SpriteAnimDelete:					; call DeleteSprite via jsr, although its returns use rtl
	tyx
	jsr.w DeleteSprite
	ldy.b tmp0
	clc
	jmp.w AnimateNextSprite

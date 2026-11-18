SpriteAnimYield:					; yield with the script position after this command
	tyx
	ldy.b tmp0
	clc
	jmp.w AnimateNextSprite

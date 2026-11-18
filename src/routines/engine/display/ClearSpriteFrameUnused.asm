ClearSpriteFrameUnused:				; sprite object X's frame words $28 / $2A = $FFFF, Y = r2, then
									; AnimateNextSprite; nothing calls it
	lda.w #$FFFF
	sta.b $28,x
	sta.b $2A,x
	ldy.b r2
	clc
	jmp.w AnimateNextSprite

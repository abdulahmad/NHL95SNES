RemoveSpriteSlot0:					; DeleteSprite's list close from slot 0: each later SpriteList word moves
									; down one
	lda.w SpriteList+2
	sta.w SpriteList
RemoveSpriteSlot1:					; the list close from slot 1
	lda.w SpriteList+4
	sta.w SpriteList+2
RemoveSpriteSlot2:					; the list close from slot 2
	lda.w SpriteList+6
	sta.w SpriteList+4
RemoveSpriteSlot3:					; the list close from slot 3
	lda.w SpriteList+8
	sta.w SpriteList+6
RemoveSpriteSlot4:					; the list close from slot 4
	lda.w SpriteList+10
	sta.w SpriteList+8
RemoveSpriteSlot5:					; the list close from slot 5
	lda.w SpriteList+12
	sta.w SpriteList+10
RemoveSpriteSlot6:					; the list close from slot 6
	lda.w SpriteList+14
	sta.w SpriteList+12
RemoveSpriteSlot7:					; the list close from slot 7: nothing to move
	rts

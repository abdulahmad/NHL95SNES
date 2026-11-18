AnimateSprites:						; the animation tick: step the script of each sprite object
	lda.w SpriteCount
	bne .1
	rtl
.1:									; A - 1, A * 2, Y = A, $08 = WorkBufMark
	dec a
	asl a
	tay
	lda.w WorkBufMark
	sta.b $08
AnimateSpriteObject:				; step the timer when the object's update selector matches
	ldx.w SpriteList,y
	lda.b $26
	eor.b $38,x
	bit.w #$0001
	bne AnimateNextSprite
	lda.b $0E,x
	clc								; subtract speed plus one, then test the sign of the result
	sbc.b $0A,x
	bmi BeginSpriteAnimStep
	sta.b $0E,x
AnimateNextSprite:					; continue with the previous active-list entry or return
	dey
	dey
	bpl AnimateSpriteObject
	rtl

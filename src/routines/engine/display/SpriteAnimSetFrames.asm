SpriteAnimSetFrames:				; read a count and frame bytes, upload the list and yield
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	sta.b p0
	sta.b p0+2
	phy
.loop:								; loop: A = $02,x, A and $00FF, $0028,y = A, Y + 1, ...
	lda.b $02,x
	and.w #$00FF
	sta.w $0028,y
	iny
	iny
	inx
	dec.b p0
	bne .loop
	ora.w #$FFFF
	sta.w $0028,y
	lda.b p0+2
	sec
	plx
	adc.b $30,x
	sta.b $30,x
	stx.b p0
	pei ($9F)
UploadSpriteAnimFrames:				; upload the frame list and restore the saved active-list index
	jsr.w UploadSpriteFrames
	ldx.b p0
	ply
	jmp.w AnimateNextSprite

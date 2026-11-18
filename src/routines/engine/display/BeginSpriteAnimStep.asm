BeginSpriteAnimStep:				; save the active-list index and reload the object's timer
	sty.b tmp0
	lda.b $0C,x
	sta.b $0E,x
	txy
ReadSpriteAnim:						; read a frame byte or dispatch a command at the script position
	lda.b $30,x
	clc
	adc.b $32,x
	tax
	lda.b $00,x
	stx.b tmp1
	bit.w #$0080
	beq .1
	jmp.w DispatchSpriteAnim
.1:									; X = Y, Y = tmp0, A and $007F, if A is not $28,x go to .3
	tyx
	ldy.b tmp0
	and.w #$007F
	cmp.b $28,x
	bne .3
.2:									; advance one script byte and yield to the next object
	inc.b $30,x
	clc
	bra AnimateNextSprite
.3:									; $28,x = A, $2A,x = $FFFF, A = $22,x, if $2000 bits clear go to .2, ...
	sta.b $28,x
	lda.w #$FFFF
	sta.b $2A,x
	lda.b $22,x
	bit.w #$2000
	beq .2
	sty.b r2
	stx.b r2+2
UploadSpriteAnimFrame:				; update sprite VRAM placement and upload the selected frame
	lda.b $12,x
	cmp.b $10,x
	bne .1
	lda.b $18,x
	cmp.b $16,x
	beq .5
	sta.b $16,x
	lda.b $12,x
	sta.b $10,x
	bra .2
.1:									; $10,x = A, $16,x = $18,x
	sta.b $10,x
	lda.b $18,x
	sta.b $16,x
.2:									; if $00,x >= 0 go to .3, A = $10,x, A / 2, A / 2, ...
	lda.b $00,x
	bpl .3
	lda.b $10,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$01FF
	adc.b $1A,x
	sta.w SmallTileNext
	lda.b $16,x
	adc.b $1C,x
	sta.w LargeSlotNext
	bra .4
.3:									; Y = A, A = $1A,x, A * 2, A * 2, ...
	tay
	clc
	lda.b $1A,x
	asl a
	asl a
	asl a
	asl a
	adc.b $10,x
	sta.w $0012,y
	lda.b $16,x
	adc.b $1C,x
	sta.w $0018,y
.4:									; A = $16,x, A * 2, Y = X, X = A, ...
	lda.b $16,x
	asl a
	txy
	tax
	lda.l LargeSlotTiles,x
	asl a
	asl a
	asl a
	asl a
	adc.b $DB
	tyx
	sta.b $14,x
.5:									; call UploadSpriteFrame, X = r2+2, $30,x + 1, Y = r2, ...
	jsr.w UploadSpriteFrame
	ldx.b r2+2
	inc.b $30,x
	ldy.b r2
	clc
	jmp.w AnimateNextSprite

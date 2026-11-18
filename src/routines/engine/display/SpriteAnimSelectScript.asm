SpriteAnimSelectScript:				; select and save the byte-indexed script, then start it immediately
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	sta.w $001E,y
	sta.w $0020,y
	asl a
	adc.w $002E,y
	tax
	lda.b $00,x
	tyx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	jmp.w ReadSpriteAnim

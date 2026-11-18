SpriteAnimIncWordUnused:			; script command $89 (no script uses it): brk for an index of 4 or more,
									; else increments the word a pointer at UploadSpriteFrames + index * 2
									; (code bytes) points at
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	cmp.w #$0004
	bcc .1
	brk #$00						; a brk in the ROM, between routines
.1:									; read the indexed word from uploader code and use it as a pointer
	asl a
	tax
	lda.l UploadSpriteFrames,x
	tax
	inc.w $0000,x
	tyx
	inc.b $30,x
	jmp.w ReadSpriteAnim

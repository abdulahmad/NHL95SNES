SpriteAnimCallUnused:				; script command $8E (no script uses it): calls through a pointer at
									; UploadSpriteFrames + index * 2 (code bytes), holds when it returns carry
									; set
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	asl a
	tax
	jsr (UploadSpriteFrames,x)
	bcs .1
	tyx
	inc.b $30,x
	jmp.w ReadSpriteAnim
.1:									; go to SpriteAnimHold
	jmp.w SpriteAnimHold

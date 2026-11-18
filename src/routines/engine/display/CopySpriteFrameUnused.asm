CopySpriteFrameUnused:				; sprite object A takes object X's frame words ($28, $2A), $36 = A, then
									; UploadSpriteAnimFrame; nothing calls it
	txy
	tax
	lda.w $0028,y
	sta.b $28,x
	lda.w $002A,y
	sta.b $2A,x
	stx.b r2+2
	jmp.w UploadSpriteAnimFrame

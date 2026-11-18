FreePauseBuffers:					; frees the pause screen's work buffers (FreeWorkBuf $040E, MarkWorkBuf),
									; then RestorePauseBuffers
	lda.w #$040E
	jsl.l FreeWorkBuf
	jsl.l MarkWorkBuf
RestorePauseBuffers:				; copies BackupPauseBuffers' two buffers back (the sprite objects at
									; SpriteObjRAM, the palette slots from PalSlotList) and re-uploads the
									; frames of the objects in use
	ldx.w PauseSpriteBackup
	ldy.w #SpriteObjRAM
	lda.w #$01FD
	mvn $7E,$7E
	ldy.w #PalSlotList
	lda.w #$020F
	mvn $7E,$7E
	lda.w SpriteCount
	dec a
	asl a
	tay
.loop:								; loop: X = SpriteList,y, if $0A,x = $FFFF go to .1, push Y, ...
	ldx.w SpriteList,y
	lda.b $0A,x
	cmp.w #$FFFF
	beq .1
	phy
	jsr.w UploadSpriteFrame
	lda.b $34,x
	jsl.l QueueSpritePalette
	ply
.1:									; Y - 1, Y - 1, if the result >= 0 go to .loop, A = HomeSpritePal, ...
	dey
	dey
	bpl .loop
	lda.w HomeSpritePal
	asl a
	tax
	lda.w SpritePalUse,x
	and.w #$FF00
	ora.w HomeSpritePal
	jsl.l QueueSpritePalette
	lda.w VisSpritePal
	asl a
	tax
	lda.w SpritePalUse,x
	and.w #$FF00
	ora.w VisSpritePal
	jsl.l QueueSpritePalette
	lda.w SpritePalUse+$170
	and.w #$FF00
	ora.w #$00B8
	jsl.l QueueSpritePalette
	lda.w SpritePalUse+$172
	and.w #$FF00
	ora.w #$00B9
	jsl.l QueueSpritePalette
	jsl.l WaitTransfers
	jml.l RestoreWorkBuf

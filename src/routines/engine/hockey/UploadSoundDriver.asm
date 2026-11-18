UploadSoundDriver:					; uploads SoundRAMClear and SoundDriver, acknowledges driver readiness and
									; clears the CPU command queue
	lda.w #SoundRAMClear&$FFFF
	ldx.w #SoundRAMClear>>16
	jsl.l SPCUpload
	lda.w #SoundDriver&$FFFF
	ldx.w #SoundDriver>>16
	jsl.l SPCUpload
	sep #$20
	lda.b #$7F
.loop:								; loop: if A is not APUIO3 go to .loop, APUIO0 = A, A 16-bit, ...
	cmp.l APUIO3
	bne .loop
	sta.l APUIO0
	rep #$20
	lda.w #$FFFF
	sta.w SoundUploadUnused
	stz.w SoundQueueHead
	stz.w SoundQueueTail
	rtl

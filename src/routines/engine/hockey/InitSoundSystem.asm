InitSoundSystem:					; uploads the sound driver and initializes the CPU sound state and fade
									; volume
	stz.w SoundAllocWraps
	jsl.l UploadSoundDriver
	lda.w #$8001
	sta.w SoundInitUnused
	lda.w #$FFFF
	sta.w SoundInitUnused2
	lda.w #$007F
	sta.w SoundVolume
	rtl

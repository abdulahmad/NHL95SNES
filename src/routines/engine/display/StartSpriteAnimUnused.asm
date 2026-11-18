StartSpriteAnimUnused:				; sprite object X starts animation script A: SetSpriteAnim's start steps
									; without $22,x bit $4000, ending rts; nothing calls it
	sta.b $1E,x
	asl a
	adc.b $2E,x
	phx
	tax
	lda.b $00,x
	plx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	lda.b $36,x
	and.w #$7FFF
	sta.b $36,x
	rts

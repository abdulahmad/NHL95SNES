GameClockTick:						; one frame of the game clock: gameclock+2 - $0AAA; on a borrow gameclock
									; - 1, clockbcd - 1 second, showclockdma, CwdExciteLvl - 3
	lda.w gameclock
	beq .rts
	lda.w gameclock+2
	sec
	sbc.w #$0AAA
	sta.w gameclock+2
	bcs .rts
	dec.w gameclock
	sep #$29
	lda.w clockbcd
	sbc.b #$01
	bcs .1
	lda.w clockbcd+1
	sbc.b #$00
	sta.w clockbcd+1
	lda.b #$59
.1:									; clockbcd = A, call showclockdma, A = CwdExciteLvl, A + $FFFD, ...
	sta.w clockbcd
	rep #$28
	jsl.l showclockdma
	lda.w CwdExciteLvl
	clc
	adc.w #$FFFD
	bmi .rts
	sta.w CwdExciteLvl
.rts:								; return
	rts

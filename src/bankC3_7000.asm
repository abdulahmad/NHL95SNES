; Segment bankC3_7000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C36FF2
CODE_C36FF2:						; called from other segments
	lda.b PadRaw1
	eor.w $0565
	sta.w $0579
	and.b PadRaw1
	sta.w padnew
	lda.b PadRaw2
	eor.w $0567
	sta.w $057B
	and.b PadRaw2
	sta.w $0585
	lda.b $C5
	eor.w $0569
	sta.w $057D
	and.b $C5
	sta.w $0587
	lda.b $C7
	eor.w $056B
	sta.w $057F
	and.b $C7
	sta.w $0589
	lda.b $C9
	eor.w $056D
	sta.w $0581
	and.b $C9
	sta.w $058B
	lda.b PadRaw1
	sta.w $0565
	lda.b PadRaw2
	sta.w $0567
	lda.b $C5
	sta.w $0569
	lda.b $C7
	sta.w $056B
	lda.b $C9
	sta.w $056D
	rts
ReadjoyA:							; from CODE_C370A5 and other segments
	phx
	asl a
	tax
	lda.b PadRaw1,x
	sta.b d3
	lda.w $0579,x
	sta.b d2
	lda.w padnew,x
	sta.b d1
	lda.w paddir,x
	sta.b d0
	plx
	rtl
CODE_C37065:						; called from other segments
	jsl.l CODE_C370A5
	lda.b d3
	sta.w $058D
	inc.w repeatdelayframes
	cmp.w $0565
	beq .rtl
	stz.w repeatdelayframes
	sta.w $0565
.rtl:								; return
	rtl
ReadJoy1:							; called from other segments
	lda.b PadRaw1
	sta.b d3
	lda.w $0579
	sta.b d2
	lda.w padnew
	sta.b d1
	lda.w paddir
	sta.b d0
	rtl
CODE_C37091:						; no caller found (not traced)
	lda.b PadRaw2
	sta.b d3
	lda.w $057B
	sta.b d2
	lda.w $0585
	sta.b d1
	lda.w $0571
	sta.b d0
	rtl
CODE_C370A5:						; from CODE_C37065, CODE_C37609 and other segments
	lda.w pausepad
	lsr a
	jmp.w ReadjoyA
CODE_C370AC:						; called from other segments
	lda.w $058D
	sta.b d1
	rtl
ProcessInputWithRepeat:				; called from other segments
	lda.b d3
	beq .rtl
	lda.b d2
	bne .1
	dec.w repeatdelayframes
	bpl .rtl
	lda.w #$0006
	sta.w repeatdelayframes
	lda.b d3
	sta.b d1
.rtl:								; return
	rtl
.1:									; repeatdelayframes = $0014, return
	lda.w #$0014
	sta.w repeatdelayframes
	rtl
RemapTiles:							; no caller found (not traced)
	lda.w #$000E
	sta.b $A4
	sta.b $A4
.loop:								; loop: A, X / Y 16-bit, Y = $A4, tmp0 = [a0],y, A = Y, ...
	rep #$30
	ldy.b $A4
	lda.b [a0],y
	sta.b tmp0
	tya
	clc
	adc.w #$0010
	tay
	lda.b [a0],y
	sta.b tmp1
	sep #$30
	ldx.b $A4
	lda.b #$07
	sta.b tmp2
.loop2:								; loop: Y = $00, $A2 * 2, if carry clear go to .1, Y = $08
	ldy.b #$00
	asl.b $A2
	bcc .1
	ldy.b #$08
.1:									; tmp1 * 2, if carry clear go to .2, Y + 1, Y + 1, ...
	asl.b tmp1
	bcc .2
	iny
	iny
	iny
	iny
.2:									; $A0 * 2, if carry clear go to .3, Y + 1, Y + 1
	asl.b $A0
	bcc .3
	iny
	iny
.3:									; tmp0 * 2, if carry clear go to .4, Y + 1
	asl.b tmp0
	bcc .4
	iny
.4:									; A = [a1],y, A / 2, A / 2, A / 2, ...
	lda.b [a1],y
	lsr a
	rol.w RemapOut,x
	lsr a
	rol.w $04D6,x
	lsr a
	rol.w $04E5,x
	lsr a
	rol.w $04E6,x
	dec.b tmp2
	bpl .loop2
	dec.b $A4
	dec.b $A4
	bpl .loop
	rep #$30
	ldx.w #$0000
.loop3:								; loop: VMDATAL = RemapOut,x, X + 1, X + 1, ...
	lda.w RemapOut,x
	sta.l VMDATAL
	inx
	inx
	cpx.w #$0020
	bne .loop3
	lda.b a0
	clc
	adc.w #$0020
	sta.b a0
	dec.b d0
	bne RemapTiles
	rtl
CODE_C37149:						; no caller found (not traced)
	phx
	pha
	ldx.w pausepad
.loop:								; loop: if PadRaw1,x is not 0 go to .loop, pull A, pull X, return
	lda.b PadRaw1,x
	bne .loop
	pla
	plx
	rtl
CODE_C37155:						; no caller found (not traced)
	phx
	pha
.loop:								; loop: X = $0008
	ldx.w #$0008
.loop2:								; loop: A = PadRaw1,x, if a $000F bit set go to .1, ...
	lda.b PadRaw1,x
	bit.w #$000F
	bne .1
	and.w #$FFF0
	bne .loop
.1:									; X - 1, X - 1, if the result >= 0 go to .loop2, pull A, ...
	dex
	dex
	bpl .loop2
	pla
	plx
	rtl
CODE_C3716D:						; called from other segments
	jsl.l CODE_C37171
CODE_C37171:						; from CODE_C3716D and other segments
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	inc.b $26
	jml.l WaitTransfers
CODE_C3718D:						; called from other segments
	lda.w gsp
	cmp.w #$0003
	beq .rtl
	stz.b r0
	lda.w $1864
	cmp.w #$0003
	bne .1
	inc.b r0
.1:									; A = r0, A * 2, A * 2, A * 2, ...
	lda.b r0
	asl a
	asl a
	asl a
	asl a
	sta.w CwdExciteLvl
.rtl:								; return
	rtl
CODE_C371AB:						; called from other segments
	lda.w $1EA5
	beq .rtl
	lda.b crowdhold
	beq .3
	cmp.w #$003D
	bcc .1
	lda.w #$003C
.1:									; A - d7, if the result >= 0 go to .2, A = $0000
	sec
	sbc.b d7
	bpl .2
	lda.w #$0000
.2:									; crowdhold = A
	sta.b crowdhold
.rtl:								; return
	rtl
.3:									; X = $0002, A = $48BA,x, A and $00FF, X = A, ...
	ldx.w #$0002
	lda.w $48BA,x
	and.w #$00FF
	tax
	lda.w $24CA
	cmp.w #$0481
	bcc .4
	lda.w #$0480
.4:									; A - $07A4, if the result >= 0 go to .5, A = $0000
	sec
	sbc.w $07A4
	bpl .5
	lda.w #$0000
.5:									; $24CA = A, A / 2, A / 2, A / 2, ...
	sta.w $24CA
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b tmp0
	xba
	ora.b tmp0
	tay
	lda.w #$0015
	jml.l QueueSoundCmd
updatereplay:						; called from other segments
	lda.w gmode
	bit.w #$0010
	bne .1
	lda.w replaydelay
	beq .3
	dec a
	bne .2
.1:									; go to .rtl
	jmp.w .rtl
.2:									; replaydelay = A
	sta.w replaydelay
.3:									; A = sflags, if a $0400 bit set go to .5, A = recbpr, A + $007A, ...
	lda.w sflags
	bit.w #$0400
	bne .5
	lda.w recbpr
	clc
	adc.w #$007A
	sta.w recbpr
	bcc .4
	inc.w $07E2
.4:									; if A is not $8EF8 go to .5, if $07E2 is not $007F go to .5, ...
	cmp.w #$8EF8
	bne .5
	lda.w $07E2
	cmp.w #$007F
	bne .5
	lda.w #$0010
	tsb.w sflags
	lda.w #$007F
	sta.w $07E2
	stz.w recbpr
.5:									; A = $2100, WMADDL&$FF = recbpr, A 8-bit, WMADDH&$FF = $07E2, ...
	phd
	lda.w #$2100
	tcd
	lda.w recbpr
	sta.b WMADDL&$FF
	sep #$20
	lda.w $07E2
	sta.b WMADDH&$FF
	lda.b #$0F
	sta.w d2
	ldx.w #$0000
	ldy.w #$0001
.loop:								; loop: WMDATA&$FF = Xpos,x, A = $0815,x, A and $0F, r3 = A, ...
	lda.w Xpos,x
	sta.b WMDATA&$FF
	lda.w $0815,x
	and.b #$0F
	sta.w r3
	lda.w $0897,x
	asl a
	asl a
	asl a
	asl a
	ora.w r3
	sta.b WMDATA&$FF
	lda.w Ypos,x
	sta.b WMDATA&$FF
	lda.w frame,x
	sta.b WMDATA&$FF
	lda.w $0857,x
	and.b #$3F
	sta.w r3
	lda.w $08E1,x
	and.b #$18
	asl a
	asl a
	asl a
	ora.w r3
	sta.b WMDATA&$FF
	inx
	inx
	dec.w d2
	bpl .loop
	lda.b #$05
	sta.w d2
	ldx.w #$0000
.loop2:								; loop: WMDATA&$FF = rostnum,x, WMDATA&$FF = $0EE2,x, ...
	lda.w rostnum,x
	sta.b WMDATA&$FF
	lda.w $0EE2,x
	sta.b WMDATA&$FF
	lda.w position,x
	bpl .6
	lda.b #$FF
.6:									; A and $0F, r3 = A, if $0A22,x >= 0 go to .7, A = $FF
	and.b #$0F
	sta.w r3
	lda.w $0A22,x
	bpl .7
	lda.b #$FF
.7:									; A * 2, A * 2, A * 2, A * 2, ...
	asl a
	asl a
	asl a
	asl a
	ora.w r3
	sta.b WMDATA&$FF
	inx
	inx
	inx
	inx
	dec.w d2
	bpl .loop2
	lda.w puckz
	sta.b WMDATA&$FF
	lda.w shadowz
	sta.b WMDATA&$FF
	lda.w recsfx
	sta.b WMDATA&$FF
	lda.w recsfxpitch
	sta.b WMDATA&$FF
	lda.w $0779
	sta.b WMDATA&$FF
	lda.w $077B
	sta.b WMDATA&$FF
	lda.w recsfx2
	sta.b WMDATA&$FF
	lda.w recsfxpitch2
	sta.b WMDATA&$FF
	lda.w $077F
	sta.b WMDATA&$FF
	lda.w $0781
	sta.b WMDATA&$FF
	lda.w d7
	sta.b WMDATA&$FF
	lda.w $05B0
	asl a
	asl a
	asl a
	asl a
	ora.w PadControlObj
	sta.b WMDATA&$FF
	lda.w $05B4
	asl a
	asl a
	asl a
	asl a
	ora.w $05B2
	sta.b WMDATA&$FF
	lda.w $05B8
	asl a
	asl a
	asl a
	asl a
	ora.w $05B6
	sta.b WMDATA&$FF
	lda.l $7E24CA
	sta.b WMDATA&$FF
	lda.l $7E24CB
	sta.b WMDATA&$FF
	lda.w PBnum
	sta.b WMDATA&$FF
	lda.w $00CB
	sta.b WMDATA&$FF
	lda.w $00CC
	sta.b WMDATA&$FF
	lda.w $00CD
	sta.b WMDATA&$FF
	lda.w $00CE
	sta.b WMDATA&$FF
	lda.w $06F2
	sta.b WMDATA&$FF
	lda.w $06F3
	sta.b WMDATA&$FF
	rep #$20
	lda.w #$FFFF
	sta.w recsfx
	sta.w recsfx2
	pld
.rtl:								; return
	rtl
CODE_C3736B:						; called from other segments
	bit.w pausepad
	bpl .1
	stz.w pausepad
.1:									; $2CDF = $48, $2CE1 = 0, $7E24CA = $0000, A = $0800, ...
	lda.b $48
	sta.w $2CDF
	stz.w $2CE1
	lda.w #$0000
	sta.l $7E24CA
	lda.w #$0800
	tsb.w sflags
	jsl.l CODE_C52264
	jsl.l CODE_C5897B
	jsl.l WaitTransfers
	sep #$20
	lda.b #$13
	sta.l TM
	pea.w $7F98
	lda.b #$00
	sta.l CGADD
	pla
	sta.l CGDATA
	pla
	sta.l CGDATA
	rep #$20
	lda.w #$FFFF
	sta.w $0774
	sta.l $7E24DA
	lda.w #$007E
	sta.b $32
	lda.b $08
	sta.b r1
	ldx.w #PadButtonsMap>>16
	lda.w #PadButtonsMap&$FFFF
	jsl.l CODE_C5881C
	ldx.b $08
	ldy.w #$00DF
	clc
.loop:								; loop: A = $7E0000,x, A + $3E4B, $7E0000,x = A, X + 1, ...
	lda.l $7E0000,x
	adc.w #$3E4B
	sta.l $7E0000,x
	inx
	inx
	dey
	bpl .loop
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $06A0
	pea.w $44B0
	pea.w $007E
	lda.b $08
	clc
	adc.w #$01C0
	pha
	pea.w $01C0
	pea.w $5821
	pea.w $007E
	pei ($08)
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0070
	pea.w $007E
	adc.w #$06A0
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	lda.w recbpr
	pha
	lda.w $07E2
	pha
	lda.w #$0020
	trb.w sflags
	lda.b $CD
	pha
	lda.b $CB
	pha
	lda.w recbpr
	cmp.w #$0000
	lda.w $07E2
	sbc.w #$007F
	bcs .2
.loop2:								; loop: $07E2 = $007F, recbpr = 0
	lda.w #$007F
	sta.w $07E2
	stz.w recbpr
.2:									; A = $007F, A - $07E2, if carry clear go to .loop2, A = recbpr, ...
	lda.w #$8EF8
	cmp.w recbpr
	lda.w #$007F
	sbc.w $07E2
	bcc .loop2
	lda.w recbpr
	sec
	sbc.w #$0000
	sta.b r2
	lda.w $07E2
	sbc.w #$007F
	sta.b $36
	lda.w #$007A
	sta.b r1
	jsl.l Div32U
	lda.b $36
	bne .loop2
	lda.w $07E2
	sta.b $75
	lda.w recbpr
	sta.b a4
	pea.w $0000
.loop3:								; loop: $2CE1 - 1, call suba4, pull A, A + 1, ...
	dec.w $2CE1
	jsl.l suba4
	pla
	inc a
	pha
	lda.b d7
	bne .loop3
	pla
	lsr a
	pha
.loop4:								; loop: if $01,s = 0 go to .3, $2CE1 + 1, call adda4, pull A, ...
	lda.b $01,s
	beq .3
	inc.w $2CE1
	jsl.l adda4
	pla
	dec a
	pha
	bra .loop4
.3:									; pull A, $0786 = $CB, $0788 = $CD, fadestep = $000A, ...
	pla
	lda.b $CB
	sta.w $0786
	lda.b $CD
	sta.w $0788
	lda.w #$000A
	sta.w fadestep
	jsl.l ScreenOn
	jsl.l SprSort
	lda.w #$0001
	sta.b d7
	lda.w #$0002
	trb.w sflags3
CODE_C374CF:						; from CODE_C37609, CODE_C377DB
	lda.w $0774
	bpl .1
	jmp.w .12
.1:									; X = A, $0834 = Xpos,x, if Xpos,x - $0786 >= 0 go to .3, A = $0786, ...
	tax
	lda.w Xpos,x
	sta.w $0834
	cmp.w $0786
	bpl .3
	lda.w $0786
	sec
	sbc.w #$0004
	cmp.w $0834
	bpl .2
	lda.w $0834
.2:									; go to .4
	bra .4
.3:									; A = $0786, A + $0004, if A - $0834 < 0 go to .4, A = $0834
	lda.w $0786
	clc
	adc.w #$0004
	cmp.w $0834
	bmi .4
	lda.w $0834
.4:									; if A - $FFC8 >= 0 go to .5, A = $FFC8
	cmp.w #$FFC8
	bpl .5
	lda.w #$FFC8
.5:									; if A - $0038 < 0 go to .6, A = $0038
	cmp.w #$0038
	bmi .6
	lda.w #$0038
.6:									; $CB = A, $0786 = A, $08B6 = Ypos,x, if Ypos,x - $0788 >= 0 go to .8, ...
	sta.b $CB
	sta.w $0786
	lda.w Ypos,x
	sta.w $08B6
	cmp.w $0788
	bpl .8
	lda.w $0788
	sec
	sbc.w #$0004
	cmp.w $08B6
	bpl .7
	lda.w $08B6
.7:									; go to .9
	bra .9
.8:									; A = $0788, A + $0004, if A - $08B6 < 0 go to .9, A = $08B6
	lda.w $0788
	clc
	adc.w #$0004
	cmp.w $08B6
	bmi .9
	lda.w $08B6
.9:									; if A - $FF39 >= 0 go to .10, A = $FF39
	cmp.w #$FF39
	bpl .10
	lda.w #$FF39
.10:								; if A - $0100 < 0 go to .11, A = $0100
	cmp.w #$0100
	bmi .11
	lda.w #$0100
.11:								; $CD = A, $0788 = A, A = X, A / 2, ...
	sta.b $CD
	sta.w $0788
	txa
	lsr a
	sta.w $05BA
	jmp.w .24
.12:								; if A = $FFFF go to .23, if $0834 - $0786 >= 0 go to .14, A = $0786, ...
	cmp.w #$FFFF
	beq .23
	lda.w $0834
	cmp.w $0786
	bpl .14
	lda.w $0786
	sec
	sbc.w #$0002
	cmp.w $0834
	bpl .13
	lda.w $0834
.13:								; go to .15
	bra .15
.14:								; A = $0786, A + $0002, if A - $0834 < 0 go to .15, A = $0834
	lda.w $0786
	clc
	adc.w #$0002
	cmp.w $0834
	bmi .15
	lda.w $0834
.15:								; if A - $FFC8 >= 0 go to .16, A = $FFC8
	cmp.w #$FFC8
	bpl .16
	lda.w #$FFC8
.16:								; if A - $0038 < 0 go to .17, A = $0038
	cmp.w #$0038
	bmi .17
	lda.w #$0038
.17:								; $CB = A, $0786 = A, if $08B6 - $0788 >= 0 go to .19, A = $0788, ...
	sta.b $CB
	sta.w $0786
	lda.w $08B6
	cmp.w $0788
	bpl .19
	lda.w $0788
	sec
	sbc.w #$0002
	cmp.w $08B6
	bpl .18
	lda.w $08B6
.18:								; go to .20
	bra .20
.19:								; A = $0788, A + $0002, if A - $08B6 < 0 go to .20, A = $08B6
	lda.w $0788
	clc
	adc.w #$0002
	cmp.w $08B6
	bmi .20
	lda.w $08B6
.20:								; if A - $FF39 >= 0 go to .21, A = $FF39
	cmp.w #$FF39
	bpl .21
	lda.w #$FF39
.21:								; if A - $0100 < 0 go to .22, A = $0100
	cmp.w #$0100
	bmi .22
	lda.w #$0100
.22:								; $CD = A, $0788 = A, go to .24
	sta.b $CD
	sta.w $0788
	bra .24
.23:								; $0786 = $CB, $0788 = $CD
	lda.b $CB
	sta.w $0786
	lda.b $CD
	sta.w $0788
.24:								; timestep = d7, call SprSort, $28 = $1D8F, $2A = $1E00, ...
	lda.b d7
	sta.w timestep
	jsl.l SprSort
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l CODE_C37E57
	jsl.l WaitTransfers
	stz.w $0782
CODE_C37609:						; from CODE_C377DB
	inc.w $2CE1
	ldx.b d7
	bne .1
	inx
.1:									; call CODE_C36CBF, call CODE_C370A5, d7 = $0001, if minus go to .2, ...
	jsl.l CODE_C36CBF
	jsl.l CODE_C370A5
	lda.w #$0001
	sta.b d7
	bit.w $0774
	bmi .2
	lda.b d2
	bit.w #$0F00
	bne .2
	lda.b d0
	and.w #$FFF8
	ora.w #$0008
	sta.b d0
.2:									; A = d0, if $0008 bits clear go to .3, go to CODE_C377DB
	lda.b d0
	bit.w #$0008
	beq .3
	jmp.w CODE_C377DB
.3:									; d5 = A, d4 = $FFFF, $91 = A, $0774 = A, ...
	sta.b d5
	lda.w #$FFFF
	sta.b d4
	sta.b $91
	sta.w $0774
	lda.w #$0016
	sta.b a0
.loop:								; loop: Y = a0, if position,y < 0 go to .5, A = Xpos,y, A - $0834, ...
	ldy.b a0
	lda.w position,y
	bmi .5
	lda.w Xpos,y
	sec
	sbc.w $0834
	sta.b d0
	sta.b d2
	lda.w Ypos,y
	sec
	sbc.w $08B6
	sta.b d1
	sta.b d3
	jsl.l vtoa
	cmp.w #$0008
	beq .5
	sec
	sbc.b d5
	beq .4
	cmp.w #$0001
	beq .4
	cmp.w #$0007
	bne .5
.4:									; A = d2, A / 2, A / 2, A and $01FE, ...
	lda.b d2
	lsr a
	lsr a
	and.w #$01FE
	tax
	lda.l DATA8_C38A4A,x
	sta.b d0
	lda.b d3
	lsr a
	and.w #$03FC
	lsr a
	tax
	lda.l DATA8_C38A4A,x
	adc.b d0
	cmp.b $91
	bcs .5
	sta.b $91
	lda.b a0
	sta.b d4
.5:									; a0 - 1, a0 - 1, if the result >= 0 go to .loop, if d4 < 0 go to .6, ...
	dec.b a0
	dec.b a0
	bpl .loop
	lda.b d4
	bmi .6
	lda.b $91
	cmp.w #$0002
	bcs .6
	lda.b d4
	sta.w $0774
	lda.w #$001E
	sta.b d7
	lda.w #$0020
	trb.w sflags
	jmp.w CODE_C374CF
.6:									; call CODE_C370A5, $0774 = $FFFE, A = $0020, d0 * 2, ...
	jsl.l CODE_C370A5
	lda.w #$FFFE
	sta.w $0774
	lda.w #$0020
	tsb.w sflags
	asl.b d0
	asl.b d0
	ldx.b d0
	lda.l DATA8_C377BB,x
	adc.w $0834
	sta.b d2
	ldy.w #$0020
	lda.l DATA8_C377BB,x
	xba
	and.w #$FF00
	sta.w Xvel,y
	pha
	lda.l DATA8_C377BD,x
	clc
	adc.w $08B6
	sta.b d3
	lda.l DATA8_C377BD,x
	xba
	and.w #$FF00
	sta.w Yvel,y
	pha
	phy
	pei ($87)
	pei ($8B)
	sty.b a3
	lda.w #$0000
	sta.w Wallcos,y
	sta.w Wallsin,y
	tyx
	lda.w #$0001
	sta.w $07FA
	sta.w wcradiusy
	jsl.l checkwallcoll
	pla
	sta.b d3
	pla
	sta.b d2
	ply
	lda.w Wallsin,y
	ora.w Wallcos,y
	beq .13
	lda.w Xvel,y
	bpl .7
	bit.w #$0080
	beq .8
	sec
	sbc.w #$0100
	bra .8
.7:									; if $0080 bits clear go to .8, A + $0100
	bit.w #$0080
	beq .8
	clc
	adc.w #$0100
.8:									; A and $FF00, A + $03,s, A and $00FF, if $0080 bits clear go to .9, ...
	and.w #$FF00
	clc
	adc.b $03,s
	xba
	and.w #$00FF
	bit.w #$0080
	beq .9
	ora.w #$FF00
.9:									; A + d2, d2 = A, A = Yvel,y, if plus go to .10, ...
	clc
	adc.b d2
	sta.b d2
	lda.w Yvel,y
	bit.w #$0080
	bpl .10
	bit.w #$0080
	beq .11
	sec
	sbc.w #$0100
	bra .11
.10:								; if $0080 bits clear go to .11, A + $0100
	bit.w #$0080
	beq .11
	clc
	adc.w #$0100
.11:								; A and $FF00, A + $01,s, A and $00FF, if $0080 bits clear go to .12, ...
	and.w #$FF00
	clc
	adc.b $01,s
	xba
	and.w #$00FF
	bit.w #$0080
	beq .12
	ora.w #$FF00
.12:								; A + d3, d3 = A
	clc
	adc.b d3
	sta.b d3
.13:								; pull A, pull A, $0834 = d2, $CB = A, ...
	pla
	pla
	lda.b d2
	sta.w $0834
	sta.b $CB
	lda.b d3
	sta.w $08B6
	sta.b $CD
	lda.w #$0010
	sta.w $05BA
	jmp.w CODE_C374CF
DATA8_C377BB:						; not traced: a table read by CODE_C37609
	db $00,$00
DATA8_C377BD:						; not traced: a table read by CODE_C37609
	db $02,$00,$00,$00,$02,$00,$02,$00,$00,$00,$02,$00,$00,$00,$00,$00
	db $FE,$FF,$00,$00,$FE,$FF,$FE,$FF,$00,$00,$FE,$FF,$00,$00
CODE_C377DB:						; from CODE_C37609
	lda.w $0774
	cmp.w #$FFFF
	bne .6
	lda.w PadControlObj
	cmp.w #$000F
	beq .1
	asl a
	tax
	lda.w #$000F
	sta.w $05BA
	lda.w Xpos,x
	sta.w $0834
	lda.w Ypos,x
	sta.w $08B6
	bra .6
.1:									; $05BA = $000F, if $0830 - $FF65 >= 0 go to .2, A = $FF65
	lda.w #$000F
	sta.w $05BA
	lda.w $0830
	cmp.w #$FF65
	bpl .2
	lda.w #$FF65
.2:									; if A - $009B < 0 go to .3, A = $009B
	cmp.w #$009B
	bmi .3
	lda.w #$009B
.3:									; $0834 = A, if pucky - $FED4 >= 0 go to .4, A = $FED4
	sta.w $0834
	lda.w pucky
	cmp.w #$FED4
	bpl .4
	lda.w #$FED4
.4:									; if A - $012C < 0 go to .5, A = $012C
	cmp.w #$012C
	bmi .5
	lda.w #$012C
.5:									; $08B6 = A
	sta.w $08B6
.6:									; A = d1, if $8000 bits clear go to .8, if $7E24DA = 0 go to .7, ...
	lda.b d1
	bit.w #$8000
	beq .8
	lda.l $7E24DA
	beq .7
	jsl.l CODE_C5897B
	jsl.l WaitTransfers
	lda.w #$0000
	sta.l $7E24DA
.7:									; A = sflags3, A xor $0002, sflags3 = A
	lda.w sflags3
	eor.w #$0002
	sta.w sflags3
.8:									; A = d3, if a $0020 bit set go to .9, if a $0050 bit set go to .13, ...
	lda.b d3
	bit.w #$0020
	bne .9
	bit.w #$0050
	bne .13
	lda.b d1
	bit.w #$2000
	bne .11
	bit.w #$1000
	bne .10
	lda.b d3
	bit.w #$0080
	bne .12
	bit.w #$4000
	beq .16
	jsl.l suba4
	jsl.l suba4
	bra .15
.9:									; call suba4, X = $0003, go to .14
	jsl.l suba4
	ldx.w #$0003
	bra .14
.10:								; go to .18
	jmp.w .18
.11:								; $0774 = $FFFF, A = $0020, go to CODE_C37609
	lda.w #$FFFF
	sta.w $0774
	lda.w #$0020
	trb.w sflags
	jmp.w CODE_C37609
.12:								; call adda4, call adda4, go to .15
	jsl.l adda4
	jsl.l adda4
	bra .15
.13:								; call adda4, X = $0003, A = d3, if a $0010 bit set go to .14, ...
	jsl.l adda4
	ldx.w #$0003
	lda.b d3
	bit.w #$0010
	bne .14
	ldx.w #$0006
.14:								; Y = $0000, call WaitFrames_Inc
	ldy.w #$0000
	jsl.l WaitFrames_Inc
.15:								; d7 = $0001, A = $0002, go to CODE_C374CF
	lda.w #$0001
	sta.b d7
	lda.w #$0002
	trb.w sflags3
	jmp.w CODE_C374CF
.16:								; A = sflags3, if a $0002 bit set go to .17, go to CODE_C37609
	lda.w sflags3
	bit.w #$0002
	bne .17
	jmp.w CODE_C37609
.17:								; call adda4, if d7 = 0 go to .15, go to CODE_C374CF
	jsl.l adda4
	lda.b d7
	beq .15
	jmp.w CODE_C374CF
.18:								; $05BA = $000F, pull A, $CB = A, pull A, ...
	lda.w #$000F
	sta.w $05BA
	pla
	sta.b $CB
	pla
	sta.b $CD
	pla
	sta.w $07E2
	pla
	sta.w recbpr
	lda.w #$0020
	trb.w sflags
	lda.w $07E2
	sta.b $75
	lda.w recbpr
	sta.b a4
	jsl.l RestoreReplayFrame
	lda.w #$0800
	trb.w sflags
	jsl.l CODE_C5226A
	stz.w $079C
	lda.w #$03FF
	sta.w $079E
	jsl.l CODE_C50E94
	jsl.l forceblack
	lda.w $189C
	bne .19
	lda.w $0784
	beq .19
	lda.w $1864
	beq .19
	cmp.w #$0004
	beq .19
	lda.w $24C4
	cmp.w #$0002
	bcc .19
	jmp.w .19
.19:								; $48 = $2CDF, return
	lda.w $2CDF
	sta.b $48
	rtl
suba4:								; from CODE_C3736B, CODE_C377DB and other segments
	lda.b a4
	cmp.w #$0000
	bne .1
	lda.b $75
	cmp.w #$007F
	bne .1
	lda.w sflags
	bit.w #$0010
	beq .6
	lda.w #$007F
	sta.b $75
	lda.w #$8EF8
	sta.b a4
.1:									; A = a4, A - $007A, a4 = A, A = $75, ...
	lda.b a4
	sec
	sbc.w #$007A
	sta.b a4
	lda.b $75
	sbc.w #$0000
	sta.b $75
	lda.b a4
	cmp.w recbpr
	beq .2
	jml.l RestoreReplayFrame
.2:									; if $75 = $07E2 go to .3, go to RestoreReplayFrame
	lda.b $75
	cmp.w $07E2
	beq .3
	jml.l RestoreReplayFrame
.3:									; A = a4, A + $007A, a4 = A, if carry clear go to .4, ...
	lda.b a4
	clc
	adc.w #$007A
	sta.b a4
	bcc .4
	inc.b $75
.4:									; if A is not $8EF8 go to .5, if $75 is not $007F go to .5, ...
	cmp.w #$8EF8
	bne .5
	lda.b $75
	cmp.w #$007F
	bne .5
	lda.w #$007F
	sta.b $75
	stz.b a4
.5:									; d7 = 0, return
	stz.b d7
	rtl
.6:									; call RestoreReplayFrame, d7 = 0, return
	jsl.l RestoreReplayFrame
	stz.b d7
	rtl
adda4:								; from CODE_C3736B, CODE_C377DB, CODE_C377DB, ...
	stz.b d7
	lda.w sflags
	bit.w #$0400
	beq .1
	pei ($75)
	pei ($73)
	jsl.l adda43
	lda.b $75
	sta.b tmp1
	lda.b a4
	sta.b tmp0
	pla
	sta.b a4
	pla
	sta.b $75
	lda.b tmp0
	cmp.w recbpr
	bne .1
	lda.b tmp1
	cmp.w $07E2
	bne .1
	rtl
.1:									; if a4 is not recbpr go to .2, if $75 is not $07E2 go to .2, return
	lda.b a4
	cmp.w recbpr
	bne .2
	lda.b $75
	cmp.w $07E2
	bne .2
	rtl
.2:									; call RestoreReplayFrame
	jsl.l RestoreReplayFrame
adda43:								; from adda4 and other segments
	lda.b a4
	clc
	adc.w #$007A
	sta.b a4
	bcc .1
	inc.b $75
.1:									; if A is not $8EF8 go to .rtl, if $75 is not $007F go to .rtl, ...
	cmp.w #$8EF8
	bne .rtl
	lda.b $75
	cmp.w #$007F
	bne .rtl
	lda.w #$007F
	sta.b $75
	stz.b a4
.rtl:								; return
	rtl
.loop:								; loop: Xpos,x = $80, r3 = $80, A and $000F, ...
	lda.b $80
	sta.w Xpos,x
	lda.b $80
	sta.w r3
	and.w #$000F
	bit.w #$0008
	beq .2
	ora.w #$00F0
.2:									; $0815,x = A, Ypos,x = $80, A = r3, A / 2, ...
	sta.w $0815,x
	lda.b $80
	sta.w Ypos,x
	lda.w r3
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0008
	beq .3
	ora.w #$00F0
.3:									; $0897,x = A, frame,x = $80, r3 = $80, A and $003F, ...
	sta.w $0897,x
	lda.b $80
	sta.w frame,x
	lda.b $80
	sta.w r3
	and.w #$003F
	sta.w $0857,x
	lda.w $08E1,x
	and.w #$00E7
	sta.w $08E1,x
	lda.w r3
	lsr a
	lsr a
	lsr a
	and.w #$0018
	ora.w $08E1,x
	sta.w $08E1,x
	inx
	inx
	dey
	bpl .loop
	lda.b $80
	sta.w $0818,x
	lda.b $80
	sta.w r3
	and.w #$000F
	bit.w #$0008
	beq .4
	ora.w #$00F0
.4:									; $0819,x = A, $089A,x = $80, A = r3, A / 2, ...
	sta.w $0819,x
	lda.b $80
	sta.w $089A,x
	lda.w r3
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0008
	beq .5
	ora.w #$00F0
.5:									; $089B,x = A, $085A,x = $80, r3 = $80, A and $003F, ...
	sta.w $089B,x
	lda.b $80
	sta.w $085A,x
	lda.b $80
	sta.w r3
	and.w #$003F
	sta.w $085B,x
	lda.w $08E5,x
	and.w #$00E7
	sta.w $08E5,x
	lda.w r3
	lsr a
	lsr a
	lsr a
	and.w #$0018
	ora.w $08E5,x
	sta.w $08E5,x
	ldx.w #$0000
.loop2:								; loop: $082C,x = $80, r3 = $80, A and $000F, ...
	lda.b $80
	sta.w $082C,x
	lda.b $80
	sta.w r3
	and.w #$000F
	bit.w #$0008
	beq .6
	ora.w #$00F0
.6:									; $082D,x = A, $08AE,x = $80, A = r3, A / 2, ...
	sta.w $082D,x
	lda.b $80
	sta.w $08AE,x
	lda.w r3
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0008
	beq .7
	ora.w #$00F0
.7:									; $08AF,x = A, $086E,x = $80, r3 = $80, A and $003F, ...
	sta.w $08AF,x
	lda.b $80
	sta.w $086E,x
	lda.b $80
	sta.w r3
	and.w #$003F
	sta.w $086F,x
	lda.w $08F9,x
	and.w #$00E7
	sta.w $08F9,x
	lda.w r3
	lsr a
	lsr a
	lsr a
	and.w #$0018
	ora.w $08F9,x
	sta.w $08F9,x
	inx
	inx
	cpx.w #$0004
	bcc .loop2
	ldx.w tmp0
	ldy.w #$0002
.loop3:								; loop: rostnum,x = $80, $0EE2,x = $80, $0A21,x = 0, r3 = $80, ...
	lda.b $80
	sta.w rostnum,x
	lda.b $80
	sta.w $0EE2,x
	stz.w $0A21,x
	lda.b $80
	sta.w r3
	and.w #$000F
	cmp.w #$000F
	bne .8
	lda.w #$FFFF
	sta.w $0A21,x
.8:									; position,x = A, $0A23,x = 0, A = r3, A / 2, ...
	sta.w position,x
	stz.w $0A23,x
	lda.w r3
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$000F
	cmp.w #$000F
	bne .9
	lda.w #$FFFF
	sta.w $0A23,x
.9:									; $0A22,x = A, X + 1, X + 1, X + 1, ...
	sta.w $0A22,x
	inx
	inx
	inx
	inx
	dey
	bpl .loop3
	lda.b $80
	sta.w puckz
	bpl .10
	lda.w #$FFFF
	bra .11
.10:								; A = $0000
	lda.w #$0000
.11:								; $08D9 = A, shadowz = $80, if $80 >= 0 go to .12, A = $FFFF, ...
	sta.w $08D9
	lda.b $80
	sta.w shadowz
	bpl .12
	lda.w #$FFFF
	bra .13
.12:								; A = $0000
	lda.w #$0000
.13:								; $08DB = A, recsfx = $80, recsfxpitch = $80, $0779 = $80, ...
	sta.w $08DB
	lda.b $80
	sta.w recsfx
	lda.b $80
	sta.w recsfxpitch
	lda.b $80
	sta.w $0779
	lda.b $80
	sta.w $077B
	lda.b $80
	sta.w recsfx2
	lda.b $80
	sta.w recsfxpitch2
	lda.b $80
	sta.w $077F
	lda.b $80
	sta.w $0781
	lda.b $80
	sta.w d7
	lda.b $80
	sta.w r3
	and.w #$000F
	sta.w PadControlObj
	lda.w r3
	lsr a
	lsr a
	lsr a
	lsr a
	sta.w $05B0
	lda.b $80
	sta.w r3
	and.w #$000F
	sta.w $05B2
	lda.w r3
	lsr a
	lsr a
	lsr a
	lsr a
	sta.w $05B4
	lda.b $80
	sta.w r3
	and.w #$000F
	sta.w $05B6
	lda.w r3
	lsr a
	lsr a
	lsr a
	lsr a
	sta.w $05B8
	lda.b $80
	sta.l $7E24CA
	lda.b $80
	sta.l $7E24CB
	lda.b $80
	sta.w PBnum
	bpl .14
	lda.w #$FFFF
	bra .15
.14:								; A = $0000
	lda.w #$0000
.15:								; $1140 = A, A = sflags, if a $0020 bit set go to .16, $CB = $80, ...
	sta.w $1140
	lda.w sflags
	bit.w #$0020
	bne .16
	lda.b $80
	sta.b $CB
	lda.b $80
	sta.b $CC
	lda.b $80
	sta.b $CD
	lda.b $80
	sta.b $CE
	lda.b $80
	sta.w $06F2
	lda.b $80
	sta.w $06F3
	bra RestoreReplayFrame
.16:								; A = $80, A = $80, A = $80, A = $80, ...
	lda.b $80
	lda.b $80
	lda.b $80
	lda.b $80
	lda.b $80
	sta.w $06F2
	lda.b $80
	sta.w $06F3
RestoreReplayFrame:					; from suba4, adda4, ...
	pei ($83)
	inc.w $0782
	lda.b a4
	sta.l WMADDL
	sep #$20
	lda.b $75
	sta.l WMADDH
	lda.b #$0F
	sta.b d1
	ldx.w #$0000
.loop:								; loop: Xpos,x = WMDATA, r3 = WMDATA, A and $0F, ...
	lda.l WMDATA
	sta.w Xpos,x
	lda.l WMDATA
	sta.b r3
	and.b #$0F
	bit.b #$08
	beq .1
	ora.b #$F0
.1:									; $0815,x = A, Ypos,x = WMDATA, A = r3, A / 2, ...
	sta.w $0815,x
	lda.l WMDATA
	sta.w Ypos,x
	lda.b r3
	lsr a
	lsr a
	lsr a
	lsr a
	bit.b #$08
	beq .2
	ora.b #$F0
.2:									; $0897,x = A, frame,x = WMDATA, r3 = WMDATA, A and $3F, ...
	sta.w $0897,x
	lda.l WMDATA
	sta.w frame,x
	lda.l WMDATA
	sta.b r3
	and.b #$3F
	sta.w $0857,x
	lda.w $08E1,x
	and.b #$E7
	sta.w $08E1,x
	lda.b r3
	lsr a
	lsr a
	lsr a
	and.b #$18
	ora.w $08E1,x
	sta.w $08E1,x
	inx
	inx
	dec.b d1
	bpl .loop
	lda.b #$05
	sta.b d1
	ldx.w #$0000
.loop2:								; loop: rostnum,x = WMDATA, $0EE2,x = WMDATA, $0A21,x = 0, ...
	lda.l WMDATA
	sta.w rostnum,x
	lda.l WMDATA
	sta.w $0EE2,x
	stz.w $0A21,x
	lda.l WMDATA
	sta.b r3
	and.b #$0F
	cmp.b #$0F
	bne .3
	lda.b #$FF
	sta.w $0A21,x
.3:									; position,x = A, $0A23,x = 0, A = r3, A / 2, ...
	sta.w position,x
	stz.w $0A23,x
	lda.b r3
	lsr a
	lsr a
	lsr a
	lsr a
	and.b #$0F
	cmp.b #$0F
	bne .4
	lda.b #$FF
	sta.w $0A23,x
.4:									; $0A22,x = A, X + 1, X + 1, X + 1, ...
	sta.w $0A22,x
	inx
	inx
	inx
	inx
	dec.b d1
	bpl .loop2
	lda.l WMDATA
	sta.w puckz
	bpl .5
	lda.b #$FF
	bra .6
.5:									; A = $00
	lda.b #$00
.6:									; $08D9 = A, shadowz = WMDATA, if WMDATA >= 0 go to .7, A = $FF, ...
	sta.w $08D9
	lda.l WMDATA
	sta.w shadowz
	bpl .7
	lda.b #$FF
	bra .8
.7:									; A = $00
	lda.b #$00
.8:									; $08DB = A, recsfx = WMDATA, recsfxpitch = WMDATA, $0779 = WMDATA, ...
	sta.w $08DB
	lda.l WMDATA
	sta.w recsfx
	lda.l WMDATA
	sta.w recsfxpitch
	lda.l WMDATA
	sta.w $0779
	lda.l WMDATA
	sta.w $077B
	lda.l WMDATA
	sta.w recsfx2
	lda.l WMDATA
	sta.w recsfxpitch2
	lda.l WMDATA
	sta.w $077F
	lda.l WMDATA
	sta.w $0781
	lda.l WMDATA
	sta.b d7
	lda.l WMDATA
	sta.b r3
	and.b #$0F
	sta.w PadControlObj
	lda.b r3
	lsr a
	lsr a
	lsr a
	lsr a
	sta.w $05B0
	lda.l WMDATA
	sta.b r3
	and.b #$0F
	sta.w $05B2
	lda.b r3
	lsr a
	lsr a
	lsr a
	lsr a
	sta.w $05B4
	lda.l WMDATA
	sta.b r3
	and.b #$0F
	sta.w $05B6
	lda.b r3
	lsr a
	lsr a
	lsr a
	lsr a
	sta.w $05B8
	lda.l WMDATA
	sta.l $7E24CA
	lda.l WMDATA
	sta.l $7E24CB
	lda.l WMDATA
	sta.w PBnum
	bpl .9
	lda.b #$FF
	bra .10
.9:									; A = $00
	lda.b #$00
.10:								; $1140 = A, A = sflags, if a $20 bit set go to .11, $CB = WMDATA, ...
	sta.w $1140
	lda.w sflags
	bit.b #$20
	bne .11
	lda.l WMDATA
	sta.b $CB
	lda.l WMDATA
	sta.b $CC
	lda.l WMDATA
	sta.b $CD
	lda.l WMDATA
	sta.b $CE
	lda.l WMDATA
	sta.w $06F2
	lda.l WMDATA
	sta.w $06F3
	bra .12
.11:								; A = WMDATA, A = WMDATA, A = WMDATA, A = WMDATA, ...
	lda.l WMDATA
	lda.l WMDATA
	lda.l WMDATA
	lda.l WMDATA
	lda.l WMDATA
	sta.w $06F2
	lda.l WMDATA
	sta.w $06F3
.12:								; A 16-bit, A = recsfx, A and $00FF, if A < $0080 go to .13, ...
	rep #$20
	lda.w recsfx
	and.w #$00FF
	cmp.w #$0080
	bcc .13
	ora.w #$FF00
.13:								; recsfx = A, A = recsfx2, A and $00FF, if A < $0080 go to .14, ...
	sta.w recsfx
	lda.w recsfx2
	and.w #$00FF
	cmp.w #$0080
	bcc .14
	ora.w #$FF00
.14:								; recsfx2 = A, pull A, d1 = A, return
	sta.w recsfx2
	pla
	sta.b d1
	rtl
CODE_C37E57:						; from CODE_C374CF and other segments
	lda.w $2CE1
	sta.b $48
	sta.b $26
	jsl.l CODE_C526E8
	jsl.l CODE_C526FB
	lda.w $0874
	cmp.w $0894
	beq .1
	ldx.w #$2580
	stx.b tmp2
	ldx.w #$2035
	stx.b tmp1
	sta.w $0894
	jsl.l QueueFrameTiles
.1:									; call CODE_C382B8, call PackOAMHigh, TransfersReady + 1, ...
	jsl.l CODE_C382B8
	jsl.l PackOAMHigh
	inc.w TransfersReady
	jsl.l CODE_C38CF5
	jsl.l CODE_C528D5
	ldx.b a3
	rtl
randomd0A:							; from CODE_C37EBF, randomd0s, randomd0sd0 and other segments
	phx
	pha
	cmp.w #$0100
	bcc CODE_C37EAC
	jsl.l RandomWord
	plx
	jsl.l Mul16U
	lda.b $36
	clc
	plx
	rtl
randoma8:							; called from other segments
	phx
	pha
CODE_C37EAC:						; from randomd0A
	jsl.l RandomWord
	and.w #$00FF
	plx
	jsl.l Mul8U
	and.w #$FF00
	xba
	clc
	plx
	rtl
CODE_C37EBF:						; called from other segments
	lda.b d0
	jsl.l randomd0A
	sta.b d0
	rtl
randomd0s:							; called from other segments
	sta.b r3
	asl a
	jsl.l randomd0A
	sec
	sbc.b r3
	clc
	rtl
randomd0sd0:						; called from other segments
	lda.b d0
	asl a
	jsl.l randomd0A
	sec
	sbc.b d0
	sta.b d0
	clc
	rtl
Sroot:								; no caller found (not traced)
	phx
	lda.b $81
	beq .7
	ldx.w #$0100
	ldy.w #$1000
	cmp.w #$0048
	bcs .2
	ldy.w #$087D
	cmp.w #$0016
	bcs .1
	ldy.w #$04B1
	bra .4
.1:									; X = $04B0, go to .4
	ldx.w #$04B0
	bra .4
.2:									; X = $087C, if A >= $0096 go to .3, Y = $0C40, go to .4
	ldx.w #$087C
	cmp.w #$0096
	bcs .3
	ldy.w #$0C40
	bra .4
.3:									; X = $0C3F
	ldx.w #$0C3F
.4:									; p0 = X, p1 = Y
	stx.b p0
	sty.b p1
.loop:								; loop: A = p0, A + p1, if A = p0 go to .6, push A, ...
	lda.b p0
	clc
	adc.b p1
	ror a
	cmp.b p0
	beq .6
	pha
	tax
	jsl.l Mul16U
	lda.b d0
	cmp.b r2
	lda.b $81
	sbc.b $36
	bcs .5
	pla
	sta.b p1
	bra .loop
.5:									; pull A, p0 = A, go to .loop
	pla
	sta.b p0
	bra .loop
.6:									; pull X, d0 = A, return
	plx
	sta.b d0
	rtl
.7:									; p0 = 0, p1 = $00FF
	stz.b p0
	lda.w #$00FF
	sta.b p1
.loop2:								; loop: A = p0, A + p1, if A = p0 go to .9, push A, ...
	lda.b p0
	clc
	adc.b p1
	ror a
	cmp.b p0
	beq .9
	pha
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3884A,x
	cmp.b d0
	bcc .8
	pla
	sta.b p1
	bra .loop2
.8:									; pull A, p0 = A, go to .loop2
	pla
	sta.b p0
	bra .loop2
.9:									; pull X, d0 = A, return
	plx
	sta.b d0
	rtl
vtoa:								; from CODE_C37609 and other segments
	lda.w #$FFFF
	bit.b d0
	bpl .3
	bit.b d1
	bpl .1
	lda.w #$0005
	sta.b d0
	rtl
.1:									; if zero go to .2, d0 = $0007, return
	beq .2
	lda.w #$0007
	sta.b d0
	rtl
.2:									; d0 = $0006, return
	lda.w #$0006
	sta.b d0
	rtl
.3:									; if zero go to .6, if plus go to .4, d0 = $0003, return
	beq .6
	bit.b d1
	bpl .4
	lda.w #$0003
	sta.b d0
	rtl
.4:									; if zero go to .5, d0 = $0001, return
	beq .5
	lda.w #$0001
	sta.b d0
	rtl
.5:									; d0 = $0002, return
	lda.w #$0002
	sta.b d0
	rtl
.6:									; if d1 bits clear go to .8, if plus go to .7, d0 = $0004, return
	bit.b d1
	beq .8
	bpl .7
	lda.w #$0004
	sta.b d0
	rtl
.7:									; A + 1, d0 = A, return
	inc a
	sta.b d0
	rtl
.8:									; d0 = $0008, return
	lda.w #$0008
	sta.b d0
	rtl
SuperAdd:							; no caller found (not traced)
	phx
	lda.l $7E23F8
	clc
	adc.b d0
	sta.l $7E23F8
	bcc .1
	ldx.w #$0002
.loop:								; loop: A = $7E23F8,x, A + 1, $7E23F8,x = A, if not zero go to .1, ...
	lda.l $7E23F8,x
	inc a
	sta.l $7E23F8,x
	bne .1
	inx
	inx
	cpx.w #$0010
	bne .loop
.1:									; pull X, return
	plx
	clc
	rtl

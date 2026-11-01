; Segment bankC4_5000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C44F20
FallDown:							; player a2 falls or stumbles from a hit: the crowd excitement + 15, then
									; the fall or stumble animation by the hit
	lda.w CwdExciteLvl
	clc
	adc.w #$000F
	bmi .1
	sta.w CwdExciteLvl
.1:									; if a2 >= $0018 go to .rtl, if SPA,y = $2708 go to .rtl, ...
	ldy.b a2
	cpy.w #$0018
	bcs .rtl
	lda.w SPA,y
	cmp.w #$2708
	beq .rtl
	cmp.w #$25D2
	beq .rtl
	cmp.w #$2376
	beq .rtl
	cmp.w #$2448
	beq .rtl
	cmp.w #$2588
	beq .rtl
	lda.w #$25D2
	sta.b d1
	lda.w gmclock
	bne .2
	lda.w stickhand,y
	cmp.w #$000C
	bcc .2
	lda.w nopuckb,y
	bne .2
	lda.w seed
	and.w #$000F
	adc.w #$000A
	sta.b d0
	sec
	sbc.w impact,y
	bmi .2
	lda.w #$003C
	sta.w nopuckb,y
	jmp.w .26
.rtl:								; return
	rtl
.2:									; if position,x = 0 go to .4, a0 = 0, if pfteam,x = 0 go to .3, a0 = $0002
	lda.w position,x
	beq .4
	stz.b a0
	lda.w pfteam,x
	beq .3
	lda.w #$0002
	sta.b a0
.3:									; if gmclock is not 0 go to .4, Y = a0, A = $12D7,y, A + 1, ...
	lda.w gmclock
	bne .4
	ldy.b a0
	lda.w $12D7,y
	inc a
	sta.w $12D7,y
.4:									; Y = a2, nopuck,y = $0078, A = Xpos,x, A - Xpos,y, ...
	ldy.b a2
	lda.w #$0078
	sta.w nopuck,y
	lda.w Xpos,x
	sec
	sbc.w Xpos,y
	sta.b d0
	lda.w Ypos,x
	sec
	sbc.w Ypos,y
	sta.b d1
	jsl.l vtoa
	lda.w Xpos,y
	cmp.w #$007B
	bpl .9
	cmp.w #$FF85
	bmi .12
	lda.w Ypos,y
	cmp.w #$011E
	bpl .7
	cmp.w #$FEE2
	bmi .6
.5:									; go to .24
	jmp.w .24
.6:									; go to .21
	jmp.w .21
.7:									; go to .19
	jmp.w .19
.8:									; go to .39
	jmp.w .39
.9:									; if Ypos,y - $00F0 >= 0 go to .8, if Ypos,y - $FF0A < 0 go to .8, ...
	lda.w Ypos,y
	cmp.w #$00F0
	bpl .8
	cmp.w #$FF0A
	bmi .8
	lda.b d0
	cmp.w #$0005
	bcc .5
	lda.w #$008F
	sta.w Xpos,y
	lda.w #$0000
	sta.w Xvel,y
.10:								; A = attribute,y, if a $0800 bit set go to .14
	lda.w attribute,y
	bit.w #$0800
	bne .14
.11:								; A = $29EA, go to .15
	lda.w #$29EA
	bra .15
.12:								; if Ypos,y - $00F0 >= 0 go to .8, if Ypos,y - $FF0A < 0 go to .8, ...
	lda.w Ypos,y
	cmp.w #$00F0
	bpl .8
	cmp.w #$FF0A
	bmi .8
	lda.b d0
	dec a
	cmp.w #$0003
	bcs .5
	lda.w #$FF71
	sta.w Xpos,y
	lda.w #$0000
	sta.w Xvel,y
	lda.w Ypos,y
	cmp.w #$006C
	bpl .13
	cmp.w #$FF94
	bpl .18
.13:								; A = attribute,y, if a $0800 bit set go to .11
	lda.w attribute,y
	bit.w #$0800
	bne .11
.14:								; A = $2A64
	lda.w #$2A64
.15:								; X = a2, pfalock,x = A, call SetSPAUpdate, A = CwdExciteLvl, ...
	ldx.b a2
	sta.w pfalock,x
	jsl.l SetSPAUpdate
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi .16
	sta.w CwdExciteLvl
.16:								; $06EC = 0, Y = a2, if pfteam,y = 0 go to .17, A = $0002
	stz.w $06EC
	ldy.b a2
	lda.w pfteam,y
	beq .17
	lda.w #$0002
.17:								; A + $0006, call CODE_C382B6, $06EE = $0002, X = a3, ...
	clc
	adc.w #$0006
	jsl.l CODE_C382B6
	lda.w #$0002
	sta.w $06EE
	ldx.b a3
	ldy.b a2
	jmp.w .29
.18:								; go to .37
	jmp.w .37
.19:								; if Xpos,y - $0050 >= 0 go to .23, if Xpos,y - $FFB0 < 0 go to .23, ...
	lda.w Xpos,y
	cmp.w #$0050
	bpl .23
	cmp.w #$FFB0
	bmi .23
	lda.b d0
	inc a
	inc a
	and.w #$0007
	cmp.w #$0005
	bcc .24
	lda.w #$0132
	sta.w Ypos,y
	lda.w #$0000
	sta.w Yvel,y
.20:								; A = $28F6, go to .15
	lda.w #$28F6
	bra .15
.21:								; if Xpos,y - $0050 >= 0 go to .23, if Xpos,y - $FFB0 < 0 go to .23, ...
	lda.w Xpos,y
	cmp.w #$0050
	bpl .23
	cmp.w #$FFB0
	bmi .23
	lda.b d0
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs .24
	lda.w #$FECE
	sta.w Ypos,y
	lda.w #$0000
	sta.w Yvel,y
.22:								; A = $2970, go to .15
	lda.w #$2970
	jmp.w .15
.23:								; go to .39
	jmp.w .39
.24:								; Y = a3, if pfteam,y = 0 go to .25, A = $0002
	ldy.b a3
	lda.w pfteam,y
	beq .25
	lda.w #$0002
.25:								; A + 1, A + 1, call CODE_C382B6, $06EE = $0002, ...
	inc a
	inc a
	jsl.l CODE_C382B6
	lda.w #$0002
	sta.w $06EE
	lda.w #$2448
	sta.b d1
	ldy.b a2
	lda.b d0
	sec
	sbc.w facedir,y
	inc a
	and.w #$0007
	cmp.w #$0003
	bcc .26
	lda.w #$2376
	sta.b d1
	lda.w facedir,y
	and.w #$0003
	bne .26
	lda.w checking,x
	sec
	sbc.w #$000A
	bmi .26
	cpx.w #$0018
	bcs .26
	lda.w #$2588
	sta.b d1
.26:								; X = a2, pfalock,x = $0001, call SetSPA, X = a3, ...
	ldx.b a2
	lda.w #$0001
	sta.w pfalock,x
	jsl.l SetSPA
	ldx.b a3
	lda.w position,x
	bne .29
	cpx.w #$0018
	bcs .29
	bra .29
.27:								; go to CollisionSfx
	jmp.w CollisionSfx
.28:								; go to .34
	jmp.w .34
.29:								; A = $7E24CA, A + $012C, $7E24CA = A, crowdhold = $002D, ...
	lda.l $7E24CA
	clc
	adc.w #$012C
	sta.l $7E24CA
	lda.w #$002D
	sta.b crowdhold
	lda.w puckc
	sta.b d0
	bmi .27
	cpy.b d0
	bne .27
	lda.w gmode
	bit.w #$0010
	bne .28
	lda.w $1864
	cmp.w #$0001
	beq .28
	lda.w position,x
	beq .28
	lda.w SPA,y
	cmp.w #$2448
	bne .28
	lda.w facedir,y
	and.w #$0003
	bne .28
	lda.w pflags,y
	bit.w #$4000
	bne .28
	lda.w #$0190
	jsl.l randoma8
	asl a
	ldy.b a2
	sec
	sbc.w impact,y
	bpl .28
	lda.w gmclock
	bne .28
	lda.w position,y
	bmi .34
	beq .34
	lda.w #$FFFF
	sta.w puckc
	stz.w $06EC
	ldy.b a2
	lda.w pfteam,y
	beq .30
	lda.w #$0002
.30:								; A + $0006, call CODE_C382B6, X = a2, pfalock,x = $2708, ...
	clc
	adc.w #$0006
	jsl.l CODE_C382B6
	ldx.b a2
	lda.w #$2708
	sta.w pfalock,x
	jsl.l SetSPAFromA
	ldx.b a3
	lda.w Xvel,x
	eor.w #$FFFF
	inc a
	cmp.w #$8000
	ror a
	sta.w Xvel,x
	lda.w Yvel,x
	eor.w #$FFFF
	inc a
	cmp.w #$8000
	ror a
	sta.w Yvel,x
	jsl.l setInjuryType
	lda.w #$0004
	sta.w $1141
	lda.w #$0016
	sta.b d0
	lda.w CwdExciteLvl
	clc
	adc.w #$001E
	bmi .31
	sta.w CwdExciteLvl
.31:								; if position,x is not 0 go to .32, go to AddPenalty2
	lda.w position,x
	bne .32
	jmp.w AddPenalty2
.32:								; if OptPen is not 0 go to .33, go to AddPenalty2
	lda.w OptPen
	bne .33
	jmp.w AddPenalty2
.33:								; d0 = $0014, call AddPenalty2, go to Stop4Pen
	lda.w #$0014
	sta.b d0
	jsl.l AddPenalty2
	jmp.w Stop4Pen
.34:								; Y = a2, if SPA,y = $25D2 go to .35, puckc = $FFFF
	ldy.b a2
	lda.w SPA,y
	cmp.w #$25D2
	beq .35
	lda.w #$FFFF
	sta.w puckc
.35:								; Y = a2, if pfteam,y is not 0 go to .36, A = $0004, call StartSound, ...
	ldy.b a2
	lda.w pfteam,y
	bne .36
	lda.w #$0004
	jsl.l StartSound
	rtl
.36:								; A = $7E24CA, A + $0258, $7E24CA = A, crowdhold = $002D, ...
	lda.l $7E24CA
	clc
	adc.w #$0258
	sta.l $7E24CA
	lda.w #$002D
	sta.b crowdhold
	rtl
.37:								; A = CwdExciteLvl, A + $000A, if the result < 0 go to .38, ...
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi .38
	sta.w CwdExciteLvl
.38:								; X = a2, Xpos,x = $FF65, Xvel,x = 0, A = attribute,x, ...
	ldx.b a2
	lda.w #$FF65
	sta.w Xpos,x
	stz.w Xvel,x
	lda.w attribute,x
	ora.w #$0800
	sta.w attribute,x
	lda.w #$2ADE
	sta.w pfalock,x
	jsl.l SetSPAFromA
	ldx.b a3
	ldy.b a2
	jmp.w .29
.39:								; d5 = d0, d2 = Xpos,y, d3 = Ypos,y, X = $0048, ...
	lda.b d0
	sta.b d5
	lda.w Xpos,y
	sta.b d2
	lda.w Ypos,y
	sta.b d3
	ldx.w #$0048
	ldy.w #$00EA
	lda.b d2
	bpl .40
	ldx.w #$FFB8
.40:								; if d3 >= 0 go to .41, Y = $FF16
	lda.b d3
	bpl .41
	ldy.w #$FF16
.41:								; $81 = X, $85 = Y, A = d2, A - $81, ...
	stx.b $81
	sty.b $85
	lda.b d2
	sec
	sbc.b $81
	sta.b d0
	lda.b d3
	sec
	sbc.b $85
	sta.b d1
	ldy.b d0
	jsl.l ApproxLength
	ldy.b a2
	sta.b d4
	cmp.w #$0014
	bcs .42
	ldx.b a3
	jmp.w .24
.42:								; A = d0, X = A, A = d4, call DivX8S, ...
	lda.b d0
	xba
	tax
	lda.b d4
	jsl.l DivX8S
	lsr a
	lsr a
	bit.w #$2000
	beq .43
	ora.w #$C000
.43:								; d0 = A, if $8000 bits clear go to .44, A xor $FFFF, A + 1
	sta.b d0
	bit.w #$8000
	beq .44
	eor.w #$FFFF
	inc a
.44:								; $89 = A, A = d1, X = A, A = d4, ...
	sta.b $89
	lda.b d1
	xba
	tax
	lda.b d4
	jsl.l DivX8S
	ldx.b a3
	lsr a
	lsr a
	bit.w #$2000
	beq .45
	ora.w #$C000
.45:								; d1 = A, if $8000 bits clear go to .46, A xor $FFFF, A + 1
	sta.b d1
	bit.w #$8000
	beq .46
	eor.w #$FFFF
	inc a
.46:								; if A >= $89 go to .49, if $81 >= 0 go to .48, A = d5, A - 1, ...
	cmp.b $89
	bcs .49
	lda.b $81
	bpl .48
	lda.b d5
	dec a
	cmp.w #$0003
	bcs .47
	lda.b d0
	clc
	adc.w #$0006
	clc
	adc.b $81
	sta.w Xpos,y
	lda.b d1
	clc
	adc.b $85
	sta.w Ypos,y
	lda.w #$0000
	sta.w Xvel,y
	sta.w Yvel,y
	jmp.w .13
.47:								; go to .24
	jmp.w .24
.48:								; if d5 < $0005 go to .47, A = d0, A - $0006, A + $81, ...
	lda.b d5
	cmp.w #$0005
	bcc .47
	lda.b d0
	sec
	sbc.w #$0006
	clc
	adc.b $81
	sta.w Xpos,y
	lda.b d1
	clc
	adc.b $85
	sta.w Ypos,y
	lda.w #$0000
	sta.w Xvel,y
	sta.w Yvel,y
	jmp.w .10
.49:								; if $85 >= 0 go to .50, A = d5, A + 1, A and $0007, ...
	lda.b $85
	bpl .50
	lda.b d5
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs .47
	lda.b d0
	clc
	adc.b $81
	sta.w Xpos,y
	lda.b d1
	clc
	adc.b $85
	sta.w Ypos,y
	lda.w #$0000
	sta.w Xvel,y
	sta.w Yvel,y
	jmp.w .22
.50:								; A = d5, A + 1, A + 1, A and $0007, ...
	lda.b d5
	inc a
	inc a
	and.w #$0007
	cmp.w #$0005
	bcc .47
	lda.b d0
	clc
	adc.b $81
	sta.w Xpos,y
	lda.b d1
	clc
	adc.b $85
	sta.w Ypos,y
	lda.w #$0000
	sta.w Xvel,y
	sta.w Yvel,y
	jmp.w .20
checkcheck:							; called from other segments
	pei ($8F)
	pei ($6B)
	pei ($6F)
	jsl.l CODE_C453E6
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	jsl.l CODE_C453E6
	pla
	sta.b a3
	pla
	sta.b a2
	pla
	sta.b d4
	ldx.b a3
CODE_C453E2:						; from CODE_C453E6
	rtl
CODE_C453E3:						; from CODE_C453E6
	jmp.w holdcheck
CODE_C453E6:						; from checkcheck and other segments
	ldy.b a2
	lda.w SPA,y
	cmp.w #$224E
	beq CODE_C453E3
	cmp.w #$2684
	beq CODE_C453E3
	cmp.w #$2082
	bne .1
	jmp.w CODE_C47C8C
.1:									; if SPA,x is not $21BC go to CODE_C453E2, if gmclock = 0 go to .2, ...
	lda.w SPA,x
	cmp.w #$21BC
	bne CODE_C453E2
	lda.w gmclock
	beq .2
	lda.w #$0100
	sta.w impact,x
	sta.w impact,y
.2:									; A = Xpos,y, A - Xpos,x, d0 = A, A = Ypos,y, ...
	lda.w Xpos,y
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w Ypos,y
	sec
	sbc.w Ypos,x
	sta.b d1
	jsl.l vtoa
	lda.b d0
	sec
	sbc.w facedir,x
	and.w #$0007
	asl a
	tay
	lda.w #DATA8_C45519>>16
	sta.b $65
	lda.w #DATA8_C45519
	sta.b a0
	sta.w pf2aip,x
	cpy.w #$0000
	bne .5
	lda.w Xpos,x
	cmp.w #$0050
	bpl .3
	cmp.w #$FFB0
	bmi .3
	lda.w Ypos,x
	cmp.w #$00FE
	bpl .3
	cmp.w #$FF02
	bpl .3
	lda.w seed
	and.w #$00F0
	beq .5
	bra .4
.3:									; A = seed, if the result = 0 go to .5
	lda.w seed
	and.w #$0030
	beq .5
.4:									; Y + 1, Y + 1, d0 = Y
	iny
	iny
	sty.b d0
.5:									; A = [a0],y, call SetSPAFromA, Y = a2, if position,y = 0 go to .rtl, ...
	lda.b [a0],y
	jsl.l SetSPAFromA
	ldy.b a2
	lda.w position,y
	beq .rtl
	lda.b d4
	sec
	sbc.w #$0020
	bmi .rtl
	lda.w #$0078
	sta.b d0
	lda.b d0
	sec
	sbc.w $0DE0,x
	clc
	adc.w $0DE0,y
	lsr a
	sec
	sbc.w impact,y
	beq .6
	bmi .6
	sta.b d0
	jsl.l randomd0
	lda.b d0
	sec
	sbc.w checking,x
	bmi .6
	jsl.l checkagr
	lda.b d0
	cmp.w #$0001
	bcs .rtl
	lda.w gmode
	bit.w #$0010
	bne .rtl
	lda.w $04B1
	and.w #$0002
	clc
	adc.w #$0018
	sta.b d0
	jmp.w AddPenalty
.rtl:								; return
	rtl
.6:									; call checkagr, if d0 >= $0001 go to .7, A = gmode, ...
	jsl.l checkagr
	lda.b d0
	cmp.w #$0001
	bcs .7
	lda.w gmode
	bit.w #$0010
	bne .7
	lda.w $04B1
	and.w #$0002
	clc
	adc.w #$001C
	sta.b d0
	jsl.l AddPenalty
.7:									; call PenShotChk, if zero go to .8, if BA_Sktr_SCnum >= 0 go to .8, ...
	jsl.l PenShotChk
	beq .8
	lda.w BA_Sktr_SCnum
	bpl .8
	ldy.b a2
	sty.w BA_Sktr_SCnum
	lda.w playerpad,y
	sta.w $18B6
	lda.w #$0024
	sta.b d0
	jsl.l AddPenalty
.8:									; go to FallDown
	jmp.w FallDown
DATA8_C45519:						; not traced: a table read by CODE_C453E6
	db $30,$20,$26,$21,$8A,$21,$8A,$21,$8A,$21,$58,$21,$58,$21,$F4,$20
check4check:						; called from other segments
	lda.w #$0014
	sec
	sbc.w checking,x
	sta.b d0
	lda.w OptPen
	beq .1
	asl.b d0
.1:									; A = d0, call randomd0A, if A < $0004 go to .2, A = d0, ...
	lda.b d0
	jsl.l randomd0A
	cmp.w #$0004
	bcc .2
	lda.b d0
	jsl.l randomd0A
	cmp.w #$0004
	bcs .rtl
.2:									; d2 = $0005, Y = $0000, if X >= $000C go to .loop, Y = $000C
	lda.w #$0005
	sta.b d2
	ldy.w #$0000
	cpx.w #$000C
	bcs .loop
	ldy.w #$000C
.loop:								; loop: a0 = Y, if position,y = 0 go to .4, if SPA,y < $2280 go to .3, ...
	sty.b a0
	lda.w position,y
	beq .4
	lda.w SPA,y
	cmp.w #$2280
	bcc .3
	cmp.w #$2345
	bcc .5
.3:									; if pfalock,y = 0 go to .5
	lda.w pfalock,y
	beq .5
.4:									; Y = a0, Y + 1, Y + 1, d2 - 1, ...
	ldy.b a0
	iny
	iny
	dec.b d2
	bpl .loop
.rtl:								; return
	rtl
.5:									; A = Xpos,y, A - Xpos,x, d0 = A, if A - $FFDE < 0 go to .4, ...
	lda.w Xpos,y
	sec
	sbc.w Xpos,x
	sta.b d0
	cmp.w #$FFDE
	bmi .4
	cmp.w #$0022
	bpl .4
	lda.w Ypos,y
	sec
	sbc.w Ypos,x
	sta.b d1
	cmp.w #$FFDE
	bmi .4
	cmp.w #$0022
	bpl .4
	jsl.l vtoa
	lda.b d0
	cmp.w facedir,x
	bne .4
	lda.w Xpos,x
	cmp.w #$004A
	bpl .10
	cmp.w #$FFB6
	bmi .10
	lda.w pfgoal,x
	bne .9
	lda.w Ypos,x
	cmp.w #$005C
	bmi .10
	cmp.w #$010E
	bpl .10
.6:									; if SPA,y < $2280 go to .7, if SPA,y < $2345 go to .11
	lda.w SPA,y
	cmp.w #$2280
	bcc .7
	cmp.w #$2345
	bcc .11
.7:									; A = $04B1, if the result = 0 go to .11
	lda.w $04B1
	and.w #$0007
	beq .11
.8:									; go to Acheck
	jml.l Acheck
.9:									; if Ypos,x - $FFA4 >= 0 go to .10, if Ypos,x - $FEF2 >= 0 go to .6
	lda.w Ypos,x
	cmp.w #$FFA4
	bpl .10
	cmp.w #$FEF2
	bpl .6
.10:								; A = $04B1, if the result is not 0 go to .11, go to .8
	lda.w $04B1
	and.w #$0007
	bne .11
	jmp.w .8
.11:								; go to CODE_C42D10
	jml.l CODE_C42D10
CODE_C45606:						; called from other segments
	lda.w #$2082
	sta.w pf2aip,x
	jml.l SetSPAFromA
Holdplayer:							; called from other segments
	lda.w position,x
	beq .rtl
	lda.w pfalock,x
	beq .1
	lda.w SPA,x
	cmp.w #$21BC
	bne .1
.rtl:								; return
	rtl
.1:									; d3 = $FFFF, a0 = A, Y = $0000, if X >= $000C go to .2, ...
	lda.w #$FFFF
	sta.b d3
	sta.b a0
	ldy.w #$0000
	cpx.w #$000C
	bcs .2
	ldy.w #$000C
.2:									; d2 = $0006
	lda.w #$0006
	sta.b d2
.loop:								; loop: a2 = Y, if position,y = 0 go to .3, if minus go to .3, ...
	sty.b a2
	lda.w position,y
	beq .3
	bmi .3
	lda.w Xpos,y
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w Ypos,y
	sec
	sbc.w Ypos,x
	sta.b d1
	ldy.b d1
	lda.b d0
	jsl.l ApproxLength
	sta.b d4
	jsl.l vtoa
	lda.b d0
	sec
	sbc.w facedir,x
	and.w #$0007
	cmp.w #$0005
	bcc .3
	eor.w #$FFFF
	adc.w #$0008
.3:									; A * 2, A * 2, A * 2, A * 2, ...
	asl a
	asl a
	asl a
	asl a
	adc.b d4
	cmp.b d3
	bcs .4
	sta.b d3
	lda.b a2
	sta.b a0
.4:									; Y = a2, Y + 1, Y + 1, d2 - 1, ...
	ldy.b a2
	iny
	iny
	dec.b d2
	bne .loop
Acheck:								; from check4check and other segments
	lda.w #$2684
	sta.b d1
	sta.w pfalock,x
	ldy.b a0
	bmi .1
	lda.w facedir,x
	sec
	sbc.w facedir,y
	inc a
	inc a
	and.w #$0007
	cmp.w #$0005
	bcc .1
	lda.w #$224E
	sta.b d1
.1:									; go to SetSPA
	jml.l SetSPA
holdcheck:							; from CODE_C453E3
	lda.w position,x
	beq .rtl
	lda.w pfalock,x
	bne .rtl
	ldy.b a2
	lda.w Xpos,x
	sec
	sbc.w Xpos,y
	sta.b d0
	lda.w Ypos,x
	sec
	sbc.w Ypos,y
	sta.b d1
	jsl.l vtoa
	ldy.b a2
	lda.b d0
	sec
	sbc.w facedir,y
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs .rtl
	lda.w puckc
	cmp.b a3
	bne .1
	lda.w #$0008
	trb.w sflags
	bra .1
.rtl:								; return
	rtl
.1:									; facedir,y = d0, Y = a2, A = Xvel,x, A + Xvel,y, ...
	lda.b d0
	sta.w facedir,y
	ldy.b a2
	lda.w Xvel,x
	clc
	adc.w Xvel,y
	pha
	asl a
	pla
	ror a
	sta.w Xvel,x
	sta.w Xvel,y
	lda.w Yvel,x
	clc
	adc.w Yvel,y
	pha
	asl a
	pla
	ror a
	sta.w Yvel,x
	sta.w Yvel,y
	tya
	sta.w $09E0,x
	lda.w #$2344
	sta.w pfalock,x
	jsl.l SetSPAFromA
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	tya
	sta.w $09E0,x
	lda.w #$2280
	sta.w pfalock,x
	ldy.w SPA,x
	cpy.w #$224E
	beq .2
	lda.w #$22B2
.2:									; call SetSPAFromA, call PenShotChk, if zero go to .3, ...
	jsl.l SetSPAFromA
	jsl.l PenShotChk
	beq .3
	lda.w BA_Sktr_SCnum
	bpl .3
	ldy.b a2
	sty.w BA_Sktr_SCnum
	lda.w playerpad,y
	sta.w $18B6
	lda.w #$0024
	sta.b d0
	jsl.l AddPenalty
	bra .5
.3:									; call checkagr, if d0 >= $0001 go to .5, d0 = $0028, ...
	jsl.l checkagr
	lda.b d0
	cmp.w #$0001
	bcs .5
	lda.w #$0028
	sta.b d0
	lda.w SPA,x
	cmp.w #$2280
	beq .4
	lda.w #$0020
	sta.b d0
.4:									; call AddPenalty
	jsl.l AddPenalty
.5:									; X = a2, a2 = a3, a3 = X, collflag = $FFFF, ...
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	lda.w #$FFFF
	sta.w collflag
	rtl
SetSPA:								; from Acheck, FallDown and other segments
	lda.b d1
	cmp.w SPA,x
	beq .rtl
	sta.w SPA,x
	stz.w SPAnum,x
	lda.w #$FFFF
	sta.w SPAcnt,x
.rtl:								; return
	rtl
SetSPAFromA:						; from CODE_C45606, assstanley, dostop, CODE_C453E6, ...
	cmp.w SPA,x
	beq .rtl
	sta.w SPA,x
	stz.w SPAnum,x
	lda.w #$FFFF
	sta.w SPAcnt,x
.rtl:								; return
	rtl
SetSPAUpdate:						; from FallDown, updateanim and other segments
	cmp.w SPA,x
	beq .rtl
	sta.w SPA,x
	stz.w SPAnum,x
	lda.w #$FFFF
	sta.w SPAcnt,x
	jsl.l updateanim
.rtl:								; return
	rtl
updateanim:							; from SetSPAUpdate and other segments
	lda.w SPA,x
	bne .1
	stz.w pf2aip,x
	stz.w pfalock,x
	rtl
.1:									; push Y, a0 = A, $65 = $00C4, Y = $0010, ...
	phy
	sta.b a0
	lda.w #$00C4
	sta.b $65
	ldy.w #$0010
	lda.b [a0],y
	sta.b d1
	lda.w SPA,x
	cmp.w #$2ADE
	bcs .2
	lda.w attribute,x
	bit.w #$0800
	beq .2
	lda.w #$0000
	sec
	sbc.w facedir,x
	bra .3
.2:									; A = facedir,x
	lda.w facedir,x
.3:									; A and $0007, A * 2, Y = A, a0 = [a0],y, ...
	and.w #$0007
	asl a
	tay
	lda.b [a0],y
	sta.b a0
	ldy.w SPAnum,x
	sty.b d0
	lda.b [a0],y
	sta.b d2
	lda.w SPAcnt,x
	bmi .5
	sec
	sbc.w timestep
	sta.w SPAcnt,x
	bpl .7
	lda.w SPAnum,x
	clc
	adc.w #$0004
	sta.w SPAnum,x
	sta.b d0
	iny
	iny
	lda.b [a0],y
	cmp.w #$0000
	bpl .5
	stz.b d0
	stz.w SPAnum,x
	stz.w pf2aip,x
	stz.w pfalock,x
	lda.w SPA,x
	cmp.w #$2B18
	bcs .4
	cmp.w #$2ADE
	bcs .9
.4:									; if d1 is not 0 go to .5, SPA,x = 0
	lda.b d1
	bne .5
	stz.w SPA,x
.5:									; Y = d0, Y + 1, Y + 1, A = [a0],y, ...
	ldy.b d0
	iny
	iny
	lda.b [a0],y
	bit.w #$8000
	beq .6
	eor.w #$FFFF
	inc a
.6:									; SPAcnt,x = A
	sta.w SPAcnt,x
.7:									; frame,x = d2
	lda.b d2
	sta.w frame,x
.8:									; pull Y, return
	ply
	rtl
.9:									; Xpos,x = $FF65, facedir,x = $0002, pfalock,x = A, A = attribute,x, ...
	lda.w #$FF65
	sta.w Xpos,x
	lda.w #$0002
	sta.w facedir,x
	sta.w pfalock,x
	lda.w attribute,x
	ora.w #$0800
	sta.w attribute,x
	lda.w #$18EC
	jsl.l SetSPAUpdate
	bra .8
dostop:								; called from other segments
	lda.w Xvel,x
	cmp.w #$DFFF
	bmi .1
	cmp.w #$2001
	bpl .1
	lda.w Yvel,x
	cmp.w #$DFFF
	bmi .1
	cmp.w #$2001
	bmi stopna
.1:									; A = $1958, if pfrev,x is not 0 go to .3, if X is not puckc go to .2, ...
	lda.w #$1958
	ldy.w pfrev,x
	bne .3
	cpx.w puckc
	bne .2
	lda.w Xvel,x
	sta.b p0
	lda.w Yvel,x
	sta.b $3A
	lda.w #$000F
	jsl.l StartSound
.2:									; A = $1AEE, pf2aip,x = 0
	lda.w #$1AEE
	stz.w pf2aip,x
.3:									; call SetSPAFromA
	jsl.l SetSPAFromA
stopna:								; from dostop and other segments
	lda.w position,x
	bne .1
	lda.w playerpad,x
	bmi .1
	cpx.w puckc
	beq .1
	lda.w Xvel,x
	cmp.w #$8000
	ror a
	sta.w Xvel,x
	lda.w Yvel,x
	cmp.w #$8000
	ror a
	sta.w Yvel,x
	rtl
.1:									; $16 = X, A = $0070, A + legstr,x, X = d7, ...
	stx.b $16
	lda.w #$0070
	clc
	adc.w legstr,x
	ldx.b d7
	dex
	beq .2
	asl a
.2:									; X = $16, r2 = A, if Xvel,x >= 0 go to .3, A + r2, ...
	ldx.b $16
	sta.b r2
	lda.w Xvel,x
	bpl .3
	clc
	adc.b r2
	sta.w Xvel,x
	bmi .5
	bra .4
.3:									; A - r2, Xvel,x = A, if plus go to .5
	sec
	sbc.b r2
	sta.w Xvel,x
	bpl .5
.4:									; Xvel,x = 0
	stz.w Xvel,x
.5:									; if Yvel,x >= 0 go to .6, A + r2, Yvel,x = A, if minus go to .rtl, ...
	lda.w Yvel,x
	bpl .6
	clc
	adc.b r2
	sta.w Yvel,x
	bmi .rtl
	bra .7
.6:									; A - r2, Yvel,x = A, if plus go to .rtl
	sec
	sbc.b r2
	sta.w Yvel,x
	bpl .rtl
.7:									; Yvel,x = 0
	stz.w Yvel,x
.rtl:								; return
	rtl
skateto:							; called from other segments
	lda.w temp2,x
	sec
	sbc.w timestep
	sta.w temp2,x
	bmi .1
	jmp.w .9
.1:									; A + $000C, temp2,x = A, $81 = d0, $85 = d1, ...
	adc.w #$000C
	sta.w temp2,x
	lda.b d0
	sta.b $81
	lda.b d1
	sta.b $85
	jsl.l CODE_C46BF6
	lda.w Xvel,x
	xba
	and.w #$00FF
	bit.w #$0080
	beq .2
	ora.w #$FF00
.2:									; A xor $FFFF, A + 1, r3 = A, A + d0, ...
	eor.w #$FFFF
	inc a
	sta.b r3
	clc
	adc.b d0
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w Yvel,x
	xba
	and.w #$00FF
	bit.w #$0080
	beq .3
	ora.w #$FF00
.3:									; A xor $FFFF, A + 1, $42 = A, A + d1, ...
	eor.w #$FFFF
	inc a
	sta.b $42
	clc
	adc.b d1
	sec
	sbc.w Ypos,x
	sta.b d1
	lda.w position,x
	bne .4
	lda.w goalieflags,x
	bit.w #$0002
	beq .7
.4:									; Y = Xvel,x, A = Yvel,x, call ApproxLength, push A, ...
	pei ($7F)
	pei ($83)
	ldy.w Xvel,x
	lda.w Yvel,x
	jsl.l ApproxLength
	pha
	lda.b r3
	clc
	adc.b $81
	sec
	sbc.w Xpos,x
	tay
	lda.b $42
	clc
	adc.b $85
	sec
	sbc.w Ypos,x
	jsl.l ApproxLength
	tay
	pla
	sta.b r3
	pla
	sta.b d1
	pla
	sta.b d0
	lda.b r3
	cmp.w #$1000
	bcs .5
	cpy.w #$0005
	bpl .7
	bra .6
.5:									; if Y - $000C >= 0 go to .7
	cpy.w #$000C
	bpl .7
.6:									; d0 = $0009, go to .8
	lda.w #$0009
	sta.b d0
	bra .8
.7:									; call vtoa
	jsl.l vtoa
.8:									; jmlvector+1 = a0, jmlvector+2 = $64, call jmlvector, temp2b,x = d0, ...
	lda.b a0
	sta.w jmlvector+1
	lda.b $64
	sta.w jmlvector+2
	jsl.l jmlvector
	lda.b d0
	sta.w temp2b,x
	cmp.w #$0008
	bcc .9
	lda.w Xvel,x
	ora.w Yvel,x
	bne .9
	lda.w $0830
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w pucky
	sec
	sbc.w Ypos,x
	sta.b d1
	jsl.l vtoa
.9:									; d0 = temp2b,x, go to doplayeracc
	lda.w temp2b,x
	sta.b d0
	jml.l doplayeracc
assstanley:							; called from other segments
	lda.w pflags,x
	bit.w #$0002
	beq .2
	and.w #$FFFD
	sta.w pflags,x
	lda.w #$005A
	sta.w temp3,x
	lda.b $CB
	bpl .1
	lda.w #$FFA6
	sta.w temp3,x
.1:									; temp4,x = $CD, pfalock,x = A, call SetSPAFromA
	lda.b $CD
	sta.w temp4,x
	sta.w pfalock,x
	jsl.l SetSPAFromA
.2:									; A = temp3,x, A - Xpos,x, d0 = A, A = temp4,x, ...
	lda.w temp3,x
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w temp4,x
	sec
	sbc.w Ypos,x
	sta.b d1
	jsl.l vtoa
	lda.b d0
	cmp.w #$0008
	bpl .rtl
	lda.b d0
	sta.b d2
	sta.w facedir,x
	lda.w #$0014
	sta.w pfalock,x
	jmp.w playeracc
.rtl:								; return
	rtl
CODE_C45A9F:						; called from other segments
	lda.w #$FFFF
	sta.b d2
.loop:								; loop: d2 + 1, A = a0, A + d2, Y = A, ...
	inc.b d2
	lda.b a0
	clc
	adc.b d2
	tay
	sep #$20
	lda.w tmboxlist,y
	sta.w $13DA,y
	rep #$30
	bit.w #$0080
	beq .loop
	dec.b a0
	rtl
playeracc:							; player X accelerates toward direction d2 (0 up, clockwise): the routine
									; of that direction from PlayerAccOneFrame (d7 = 1) or PlayerAccFrames
	lda.b d2
	asl a
	tax
	lda.b d7
	dec a
	beq .1
	jmp (PlayerAccFrames,x)
.1:									; jump through PlayerAccOneFrame,x
	jmp (PlayerAccOneFrame,x)
PlayerAccOneFrame:					; the acceleration routine of each direction (0 up, clockwise) when d7 is
									; 1: one step
	dw PlayerAccDir0,PlayerAccDir1,PlayerAccDir2,PlayerAccDir3
	dw PlayerAccDir4,PlayerAccDir5,PlayerAccDir6,PlayerAccDir7
PlayerAccFrames:					; the acceleration routine of each direction (0 up, clockwise) when d7 is
									; not 1: the step taken twice
	dw PlayerAccDir0x2,PlayerAccDir1x2,PlayerAccDir2x2,PlayerAccDir3x2
	dw PlayerAccDir4x2,PlayerAccDir5x2,PlayerAccDir6x2,PlayerAccDir7x2
PlayerAccDir0:						; playeracc toward direction 0 (up), one step (PlayerAccOneFrame)
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = Yvel,x, A + $0D80,x
	lda.w Yvel,x
	adc.w $0D80,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w $09A1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .3
	lda.w #$1000
	sta.b d0
.3:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .4
	lda.w playerpad,x
	bmi .4
	lda.w goalieflags,x
	bit.w #$0004
	bne .4
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.4:									; pull A, if carry clear go to .5, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .5
	sta.w Yvel,x
.5:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .6
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.6:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir0x2:					; playeracc toward direction 0 (up), the step taken twice
									; (PlayerAccFrames)
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = $0D80,x, A * 2, A + Yvel,x
	lda.w $0D80,x
	asl a
	clc
	adc.w Yvel,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w $09A1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .3
	lda.w #$1000
	sta.b d0
.3:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .4
	lda.w playerpad,x
	bmi .4
	lda.w goalieflags,x
	bit.w #$0004
	bne .4
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.4:									; pull A, if carry clear go to .5, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .5
	sta.w Yvel,x
.5:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .6
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.6:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
DATA8_C45C7D:						; jump table: the routine for each index
	dw CODE_C45C9D,CODE_C45CA0,CODE_C45CA1,CODE_C45CA3
	dw CODE_C45CA9,CODE_C45CAC,CODE_C45CB3,CODE_C45CBA
	dw CODE_C45CC5,CODE_C45CC9,CODE_C45CD1,CODE_C45CD9
	dw CODE_C45CE5,CODE_C45CED,CODE_C45CF9,CODE_C45D05
CODE_C45C9D:						; from DATA8_C45C7D
	lda.w #$0000
CODE_C45CA0:						; from DATA8_C45C7D
	rts
CODE_C45CA1:						; from DATA8_C45C7D
	asl a
	rts
CODE_C45CA3:						; from DATA8_C45C7D
	sta.b r2
	asl a
	adc.b r2
	rts
CODE_C45CA9:						; from DATA8_C45C7D
	asl a
	asl a
	rts
CODE_C45CAC:						; from DATA8_C45C7D
	sta.b r2
	asl a
	asl a
	adc.b r2
	rts
CODE_C45CB3:						; from DATA8_C45C7D
	asl a
	sta.b r2
	asl a
	adc.b r2
	rts
CODE_C45CBA:						; from DATA8_C45C7D
	sta.b $36
	asl a
	sta.b r2
	asl a
	adc.b r2
	adc.b $36
	rts
CODE_C45CC5:						; from DATA8_C45C7D
	asl a
	asl a
	asl a
	rts
CODE_C45CC9:						; from DATA8_C45C7D
	sta.b r2
	asl a
	asl a
	asl a
	adc.b r2
	rts
CODE_C45CD1:						; from DATA8_C45C7D
	asl a
	sta.b r2
	asl a
	asl a
	adc.b r2
	rts
CODE_C45CD9:						; from DATA8_C45C7D
	sta.b $36
	asl a
	sta.b r2
	asl a
	asl a
	adc.b r2
	adc.b $36
	rts
CODE_C45CE5:						; from DATA8_C45C7D
	asl a
	asl a
	sta.b r2
	asl a
	adc.b r2
	rts
CODE_C45CED:						; from DATA8_C45C7D
	sta.b $36
	asl a
	asl a
	sta.b r2
	asl a
	adc.b r2
	adc.b $36
	rts
CODE_C45CF9:						; from DATA8_C45C7D
	asl a
	sta.b $36
	asl a
	sta.b r2
	asl a
	adc.b r2
	adc.b $36
	rts
CODE_C45D05:						; from DATA8_C45C7D
	sta.b r2
	asl a
	asl a
	asl a
	asl a
	sec
	sbc.b r2
	rts
PlayerAccDir1:						; playeracc toward direction 1 (up-right), one step (PlayerAccOneFrame)
	lda.l DATA8_C4692F,x
	sta.b d0
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = Yvel,x, A + $0DA0,x
	lda.w Yvel,x
	adc.w $0DA0,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w Wallsin,x
	beq .3
	eor.b d0
	bpl .3
	lda.w Xvel,x
	bra .4
.3:									; A = Xvel,x, A + $0DA0,x
	lda.w Xvel,x
	adc.w $0DA0,x
.4:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .5
	lda.w #$1000
	sta.b d0
.5:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .6
	lda.w playerpad,x
	bmi .6
	lda.w goalieflags,x
	bit.w #$0004
	bne .6
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.6:									; pull A, if carry clear go to .7, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .7
	sta.w Yvel,x
.7:									; pull A, if carry clear go to .8, Xvel,x = A
	pla
	bcc .8
	sta.w Xvel,x
.8:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .9
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.9:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir1x2:					; playeracc toward direction 1 (up-right), the step taken twice
									; (PlayerAccFrames)
	lda.l DATA8_C4692F,x
	sta.b d0
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = $0DA0,x, A * 2, A + Yvel,x
	lda.w $0DA0,x
	asl a
	clc
	adc.w Yvel,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w Wallsin,x
	beq .3
	eor.b d0
	bpl .3
	lda.w Xvel,x
	bra .4
.3:									; A = $0DA0,x, A * 2, A + Xvel,x
	lda.w $0DA0,x
	asl a
	clc
	adc.w Xvel,x
.4:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .5
	lda.w #$1000
	sta.b d0
.5:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .6
	lda.w playerpad,x
	bmi .6
	lda.w goalieflags,x
	bit.w #$0004
	bne .6
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.6:									; pull A, if carry clear go to .7, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .7
	sta.w Yvel,x
.7:									; pull A, if carry clear go to .8, Xvel,x = A
	pla
	bcc .8
	sta.w Xvel,x
.8:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .9
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.9:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir2:						; playeracc toward direction 2 (right), one step (PlayerAccOneFrame)
	lda.l DATA8_C4692F,x
	sta.b d0
	ldx.b curobj
	lda.w Wallsin,x
	beq .1
	eor.b d0
	bpl .1
	lda.w Xvel,x
	bra .2
.1:									; A = Xvel,x, A + $0D80,x
	lda.w Xvel,x
	adc.w $0D80,x
.2:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w $09C1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .3
	lda.w #$1000
	sta.b d0
.3:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .4
	lda.w playerpad,x
	bmi .4
	lda.w goalieflags,x
	bit.w #$0004
	bne .4
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.4:									; pull A, if carry clear go to .5, Xvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .5
	sta.w Xvel,x
.5:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .6
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.6:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl

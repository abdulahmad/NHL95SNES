; Segment bankC4_9000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C492F8
CODE_C492F8:						; called from other segments
	lda.w Ypos,x
	cmp.w #$010E
	bpl .3
	cmp.w #$FEF2
	bmi .3
	cpx.w puckc
	bne .1
	stz.b d0
.1:									; if d1 - $0109 < 0 go to .2, d1 = $0109
	lda.b d1
	cmp.w #$0109
	bmi .2
	lda.w #$0109
	sta.b d1
.2:									; if d1 - $FEF7 >= 0 go to .3, d1 = $FEF7
	lda.b d1
	cmp.w #$FEF7
	bpl .3
	lda.w #$FEF7
	sta.b d1
.3:									; A = d1, A - d3, d1 = A
	lda.b d1
	sec
	sbc.b d3
	sta.b d1
CODE_C4932B:						; called from other segments
	rtl
DATA8_C4932C:						; not traced: data between routines
	db $02,$13,$34,$13,$CA,$13,$0C,$14,$66,$13,$98,$13,$2C,$18,$9A,$17
	db $08,$17
AdjustFacingDirection:				; called from other segments
	lda.w facedir,x
	sta.b r3
	lda.w goalieturnwait,x
	bne .1
	lda.b d0
	sec
	sbc.b r3
	beq .1
	eor.w #$FFFF
	inc a
	and.w #$0004
	lsr a
	dec a
	sta.b d0
	clc
	adc.b r3
	and.w #$0007
	sta.w facedir,x
	lda.w #$0006
	sta.w goalieturnwait,x
	rtl
.1:									; if goalieturnwait,x = 0 go to .rtl, A - timestep, ...
	lda.w goalieturnwait,x
	beq .rtl
	sec
	sbc.w timestep
	bpl .2
	lda.w #$0000
.2:									; goalieturnwait,x = A
	sta.w goalieturnwait,x
.rtl:								; return
	rtl
GoaliePuckVector:					; called from other segments
	lda.w puckx
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w pucky
	sec
	sbc.w Ypos,x
	sta.b d1
	bra CODE_C4939D
CODE_C49390:						; no caller found (not traced); it runs on into the next routine
	lda.w puckx
	sta.b d0
	lda.w pucky
	sec
	sbc.b d4
	sta.b d1
CODE_C4939D:						; from GoaliePuckVector
	lda.w Ypos,x
	bpl .3
	cmp.w #$FEF2
	bmi .rts
	lda.w pucky
	cmp.w #$FEF2
	bmi .1
	rts
.1:									; d1 = $0001, return
	lda.w #$0001
	sta.b d1
	rts
.2:									; d1 = $FFFF
	lda.w #$FFFF
	sta.b d1
.rts:								; return
	rts
.3:									; if A - $010E >= 0 go to .rts, if pucky - $010E >= 0 go to .2, return
	cmp.w #$010E
	bpl .rts
	lda.w pucky
	cmp.w #$010E
	bpl .2
	rts
pucknorm:							; assignment (asstab entry 24): the puck most of the time; a new
									; assignment clears its timers, then pucknorm_move
	lda.w #$0002
	trb.w pflags+$1C
	beq pucknorm_move
	stz.w temp1+$1C
	stz.w temp2+$1C
	lda.w #$0078
	sta.w temp2b+$1C
	stz.w pspuckback
pucknorm_move:						; from pucknorm and other segments
	lda.w puckcross+2
	sec
	sbc.b d7
	sta.w puckcross+2
	lda.w puckcross+6
	sec
	sbc.b d7
	sta.w puckcross+6
	lda.w temp1+$1C
	sec
	sbc.b d7
	sta.w temp1+$1C
	bpl .1
	adc.w #$0005
	sta.w temp1+$1C
	jsl.l CODE_C494E6
.1:									; if puckc < 0 go to .4, a2 = A, call a2touchpuck, A = a2, ...
	lda.w puckc
	bmi .4
	sta.b a2
	jsl.l a2touchpuck
	lda.b a2
	jsl.l GetFrameHot
	ldy.b a2
	lda.b d0
	clc
	adc.w Xpos,y
	sec
	sbc.w puckx
	lsr a
	lsr a
	bit.w #$2000
	beq .2
	ora.w #$C000
.2:									; A + puckx, puckx = A, A = d1, A + Ypos,y, ...
	clc
	adc.w puckx
	sta.w puckx
	lda.b d1
	clc
	adc.w Ypos,y
	sec
	sbc.w pucky
	lsr a
	lsr a
	bit.w #$2000
	beq .3
	ora.w #$C000
.3:									; A + pucky, pucky = A, puckvx = Xvel,y, puckvy = Yvel,y
	clc
	adc.w pucky
	sta.w pucky
	lda.w Xvel,y
	sta.w puckvx
	lda.w Yvel,y
	sta.w puckvy
.4:									; call PuckIChk, call ChkOffsides, if gmclock is not 0 go to .13, ...
	jsl.l PuckIChk
	jsl.l ChkOffsides
	lda.w gmclock
	bne .13
	lda.w puckc
	bpl .11
	lda.w PenShotActive
	beq .9
	lda.w gmode
	bit.w #$0002
	bne .5
	lda.w BA_Team
	beq .7
	bra .6
.5:									; if BA_Team is not 0 go to .7
	lda.w BA_Team
	bne .7
.6:									; if puckvy < 0 go to .9, go to .8
	lda.w puckvy
	bmi .9
	bra .8
.7:									; A = puckvy, A - 1, if the result >= 0 go to .9
	lda.w puckvy
	dec a
	bpl .9
.8:									; A = pspuckback, A + 1, pspuckback = A, if A < $0030 go to .10, ...
	lda.w pspuckback
	inc a
	sta.w pspuckback
	cmp.w #$0030
	bcc .10
	jsl.l EndPenaltyShot
.9:									; pspuckback = 0
	stz.w pspuckback
.10:								; if puckx is not OldXpos+$1C go to .12, ...
	lda.w puckx
	cmp.w OldXpos+$1C
	bne .12
	lda.w pucky
	cmp.w OldYpos+$1C
	bne .12
	lda.w #$0006
	sta.b d0
	dec.w temp2b+$1C
	bpl .13
	jsl.l AddPenalty2
	bra .13
.11:								; pspuckback = 0
	stz.w pspuckback
.12:								; temp2b+$1C = $0078
	lda.w #$0078
	sta.w temp2b+$1C
.13:								; A = puckvz, A and $FF00, if the result = 0 go to .14, ...
	lda.w puckvz
	and.w #$FF00
	ora.w puckz
	beq .14
	jmp.w checkpuckcoll
.14:								; call pucknothing, go to checkpuckcoll
	jsl.l pucknothing
	jmp.w checkpuckcoll
CODE_C494E6:						; from pucknorm_move and other segments
	phx
	lda.w #$010E
	sta.b d4
	ldy.w #$0000
	jsl.l CODE_C49504
	lda.w #$FEF2
	sta.b d4
	ldy.w #$0004
	jsl.l CODE_C49504
	plx
	rtl
CODE_C49501:						; from CODE_C49504
	jmp.w CODE_C4956B
CODE_C49504:						; from CODE_C494E6 and other segments
	lda.b d4
	sec
	sbc.w pucky
	sta.b d0
	lda.w puckvy
	beq CODE_C49501
	eor.b d0
	bmi CODE_C49501
	lda.b d0
	stz.b r2
	lsr a
	ror.b r2
	lsr a
	ror.b r2
	lsr a
	ror.b r2
	lsr a
	ror.b r2
	bit.w #$0800
	beq .1
	ora.w #$F000
.1:									; $36 = A, r1 = puckvy, call Div32S, puckcross+2,y = r0, ...
	sta.b $36
	lda.w puckvy
	sta.b r1
	jsl.l Div32S
	lda.b r0
	sta.w puckcross+2,y
	lda.b r0
	asl a
	asl a
	asl a
	asl a
	ldx.w puckvx
	jsl.l Mul16XS
	adc.w puckx
	sta.b d0
	cmp.w #$009B
	bmi .2
	lda.w #$009B
	sta.b d0
.2:									; if d0 - $FF65 >= 0 go to .3, d0 = $FF65
	lda.b d0
	cmp.w #$FF65
	bpl .3
	lda.w #$FF65
	sta.b d0
.3:									; puckcross,y = d0, return
	lda.b d0
	sta.w puckcross,y
	rtl
CODE_C4956B:						; from CODE_C49501
	lda.w #$FFFF
	sta.w puckcross+2,y
	rtl
puckflip:							; called from other segments
	lda.b d0
	and.w #$0001
	sta.b d0
	eor.w $0C5C
	and.w #$0003
	sta.w $0C5C
	lda.w #$FFFF
	sta.w $0CDC
	phx
	ldx.w #$001C
	lda.w #$191A
	jsl.l SetSPAFromA
	plx
	rtl
pucknothing:						; from pucknorm_move and other segments
	lda.w $0CBC
	cmp.w #$0008
	bcc .1
	cmp.w #$0018
	bcs .1
	lda.w $0C5C
	eor.w #$0002
	sta.w $0C5C
.1:									; A = $0004, $0CBC = 0, $0CDC = $FFFF, return
	lda.w #$0004
	tsb.w $0C5C
	stz.w $0CBC
	lda.w #$FFFF
	sta.w $0CDC
	rtl
skatetopuckinit:					; called from other segments
	lda.w puckvx
	xba
	lsr a
	and.w #$007F
	bit.w #$0040
	beq .1
	ora.w #$FF80
.1:									; A + puckx, d0 = A, A = puckvy, A / 2, ...
	clc
	adc.w puckx
	sta.b d0
	lda.w puckvy
	xba
	lsr a
	and.w #$007F
	bit.w #$0040
	beq .2
	ora.w #$FF80
.2:									; A + pucky, d1 = A, return
	clc
	adc.w pucky
	sta.b d1
	rtl
chk4shot:							; called from other segments
	lda.w gmclock
	bne .1
	lda.w gameclock
	cmp.w #$0005
	bcs .1
	jmp.w CompShoot
.1:									; if PenShotActive is not 0 go to .2, call CODE_C42D98, ...
	lda.w PenShotActive
	bne .2
	jsl.l CODE_C42D98
	bne .2
	lda.w $07EE
	beq .2
	lda.w Ypos,x
	cmp.w #$FF0D
	bmi .2
	cmp.w #$00F3
	bpl .2
	lda.w seed
	and.w #$0003
	bne .2
	jmp.w CODE_C4A4AB
.2:									; A = $0020, A - spodds,x, A * 2, A * 2, ...
	lda.w #$0020
	sec
	sbc.w spodds,x
	asl a
	asl a
	asl a
	asl a
	sta.b d4
	ldy.w #$010E
	lda.w pfgoal,x
	bne .3
	ldy.w #$FEF2
.3:									; d1 = Y, A = Y, A - pucky, d1 = A, ...
	sty.b d1
	tya
	sec
	sbc.w pucky
	sta.b d1
	cmp.w #$0064
	bpl .5
	cmp.w #$FF9C
	bmi .5
	lda.w puckx
	cmp.w #$0064
	bpl .5
	cmp.w #$FF9C
	bmi .8
	eor.w #$FFFF
	inc a
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	lda.b d1
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b tmp0
	ldx.b curobj
	cmp.w #$2711
	lsr.b d4
	lsr.b d4
	lsr.b d4
	lsr.b d4
	jsl.l vtoa
	sta.b d5
	lda.w #$0005
	sta.b d3
	ldy.w #$0000
	cpx.w #$000C
	bcs .4
	ldy.w #$000C
.4:									; if position,y = 0 go to .6, A = puckdir,y, A - $0004, A and $0007, ...
	lda.w position,y
	beq .6
	lda.w puckdir,y
	sec
	sbc.w #$0004
	and.w #$0007
	cmp.b d5
	bne .7
	asl.b d4
	bra .7
.5:									; go to .8
	bra .8
.6:									; if pf2aip,y = 0 go to .7, d3 = 0, d4 = $0001
	lda.w pf2aip,y
	beq .7
	stz.b d3
	lda.w #$0001
	sta.b d4
.7:									; Y + 1, Y + 1, d3 - 1, if the result >= 0 go to .4
	iny
	iny
	dec.b d3
	bpl .4
.8:									; A = d4, call randomd0A, if A >= $0009 go to .rtl, d0 = pucky, ...
	lda.b d4
	jsl.l randomd0A
	cmp.w #$0009
	bcs .rtl
	lda.w pucky
	sta.b d0
	lda.w pfgoal,x
	bne .9
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.9:									; if d0 < 0 go to .rtl, A = $010E, A - d0, ...
	lda.b d0
	bmi .rtl
	lda.w #$010E
	sec
	sbc.b d0
	bmi .rtl
	lda.w PenShotActive
	beq .10
	lda.w #$00B2
	lsr a
	lsr a
	clc
	adc.w #$005C
	sec
	sbc.b d0
	bpl .rtl
.10:								; A = sflags, if a $8000 bit set go to .rtl, go to CompShoot
	lda.w sflags
	bit.w #$8000
	bne .rtl
	jmp.w CompShoot
.rtl:								; return
	rtl
shotdiradj:							; from doshot and other segments
	lda.w playerpad,x
	bmi .1
	jmp.w .rtl
.1:									; d0 = $0008, d1 = $0005, Y = $0000, if pfteam,x is not 0 go to .loop, ...
	lda.w #$0008
	sta.b d0
	lda.w #$0005
	sta.b d1
	ldy.w #$0000
	lda.w pfteam,x
	bne .loop
	ldy.w #$000C
.loop:								; loop: if position,y = 0 go to .2, Y + 1, Y + 1, d1 - 1, ...
	lda.w position,y
	beq .2
	iny
	iny
	dec.b d1
	bpl .loop
	jmp.w .7
.2:									; A = $09A1,y, A and $00FF, if $0080 bits clear go to .3, A or $FF00
	lda.w $09A1,y
	and.w #$00FF
	bit.w #$0080
	beq .3
	ora.w #$FF00
.3:									; push A, A * 2, pull A, A + Xpos,y, ...
	pha
	asl a
	pla
	ror a
	clc
	adc.w Xpos,y
	sec
	sbc.w puckx
	sta.b d0
	lda.w $09C1,y
	and.w #$00FF
	bit.w #$0080
	beq .4
	ora.w #$FF00
.4:									; push A, A * 2, pull A, A + Ypos,y, ...
	pha
	asl a
	pla
	ror a
	clc
	adc.w Ypos,y
	sec
	sbc.w pucky
	sta.b d1
	ldy.b d0
	jsl.l ApproxLength
	sta.b d2
	lda.w #$0012
	sta.b d3
	ldy.w #$010E
	lda.w pfgoal,x
	bne .5
	ldy.w #$FEF2
.5:									; d4 = Y, A = Y, push A, call CalcAngleOffset, ...
	sty.b d4
	tya
	pha
	pei ($8B)
	jsr.w CalcAngleOffset
	lda.b d4
	sta.b d5
	pla
	eor.w #$FFFF
	inc a
	sta.b d3
	pla
	sta.b d4
	jsr.w CalcAngleOffset
	lda.b d4
	clc
	adc.b d5
	sta.b d4
	ldx.b a3
	stz.b d0
	lda.b d4
	cmp.w #$FFD3
	bmi .7
	cmp.w #$002D
	bpl .7
	lda.w pfgoal,x
	beq .6
	lda.w #$0000
	sec
	sbc.b d4
	sta.b d4
.6:									; call RandomWord, A and $0003, A + 1, d0 = A, ...
	jsl.l RandomWord
	and.w #$0003
	inc a
	sta.b d0
	lda.b d4
	bpl .7
	lda.b d0
	clc
	adc.w #$0004
	sta.b d0
.7:									; passdir = d0
	lda.b d0
	sta.w passdir
.rtl:								; return
	rtl
CalcAngleOffset:					; from shotdiradj
	lda.b d3
	sec
	sbc.w puckx
	sta.b d3
	lda.b d4
	sec
	sbc.w pucky
	ldx.b d0
	jsl.l Mul16S
	lda.b $36
	sta.b $91
	lda.b r2
	sta.b d4
	lda.b d1
	ldx.b d3
	jsl.l Mul16S
	lda.b d4
	sec
	sbc.b r2
	sta.b r2
	lda.b $91
	sbc.b $36
	sta.b $36
	lda.b d2
	sta.b r1
	jsl.l Div32S
	lda.b r0
	sta.b d4
	rts
CompShoot:							; from chk4shot and other segments
	pla
	sep #$20
	pla
	rep #$30
	lda.w pucky
	sta.b d0
	lda.w pfgoal,x
	bne .1
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.1:									; A = $010E, A - d0, A / 2, A / 2, ...
	lda.w #$010E
	sec
	sbc.b d0
	lsr a
	lsr a
	lsr a
	cmp.w #$0015
	bcc .2
	lda.w #$0014
.2:									; d1 = A, temp2,x = 0, temp2b,x = d1, d0 = $0013, ...
	sta.b d1
	stz.w temp2,x
	lda.b d1
	sta.w temp2b,x
	lda.w #$0013
	sta.b d0
	jmp.w assreplace
SetShotMode:						; from assshoot and other segments
	lda.w #$0008
	sta.w passdir
	lda.w #$0008
	tsb.w sflags
	stz.b d0
	lda.w #$0128
	sta.b d1
	lda.w pfgoal,x
	bne .1
	lda.w #$FED8
	sta.b d1
.1:									; A = d0, A - Xpos,x, d0 = A, A = d1, ...
	lda.b d0
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.b d1
	sec
	sbc.w Ypos,x
	sta.b d1
	jsl.l vtoa
	lda.w #$000F
	sta.w passspeed
	ldy.w #$1C24
	jsl.l Findhittype
	beq .2
	ldy.w #$1D36
.2:									; d1 = Y, go to SetSPA
	sty.b d1
	jml.l SetSPA
assshoot:							; assignment (asstab entry 19): computer shooting, wind up then shoot
	lda.w pflags,x
	bit.w #$0002
	beq .1
	and.w #$FFFD
	sta.w pflags,x
	bra SetShotMode
.1:									; A = sflags, if a $0008 bit set go to .2, go to assexit
	lda.w sflags
	bit.w #$0008
	bne .2
	jmp.w assexit
.2:									; d0 = temp1,x, d2 = 0, A = temp2b,x, A - d7, ...
	lda.w temp1,x
	sta.b d0
	stz.b d2
	lda.w temp2b,x
	sec
	sbc.b d7
	sta.w temp2b,x
	bpl CODE_C498D3
	lda.w #$0080
	tsb.b d2
CODE_C498D3:						; from assshoot and other segments
	cpx.w puckc
	bne .2
	lda.w SPA,x
	cmp.w #$1C24
	bcc .2
	cmp.w #$1EFB
	bcs .2
	lda.w SPAnum,x
	cmp.w #$0018
	bcs doshot
	lda.b d0
	bit.w #$0008
	bne .1
	and.w #$0007
	sta.w passdir
.1:									; if SPAnum,x >= $0010 go to .rtl, A = passspeed, A + d7, ...
	lda.w SPAnum,x
	cmp.w #$0010
	bcs .rtl
	lda.w passspeed
	clc
	adc.b d7
	sta.w passspeed
	lda.b d2
	bit.w #$0080
	beq .rtl
	lda.w #$001C
	sec
	sbc.w SPAnum,x
	sta.w SPAnum,x
	cmp.w #$0018
	bcc .rtl
	lda.w #$0018
	sta.w SPAnum,x
	bra doshot
.2:									; A = $0008
	lda.w #$0008
	trb.w sflags
.rtl:								; return
	rtl
doshot:								; from CODE_C498D3, CODE_C49E91, ...
	jsl.l shotdiradj
	pea.w $000D
	lda.w passspeed
	lsr a
	adc.w passspeed
	sta.w passspeed
	lda.w #$0008
	trb.w sflags
	sta.w pfalock,x
	stx.w $07EA
	cpx.w puckc
	beq .1
	jmp.w .15
.1:									; $01,s = $000E, A = $1000, if SPA,x is not $1D36 go to .2, $01,s = $000E
	lda.w #$000E
	sta.b $01,s
	lda.w #$1000
	tsb.w sflags
	lda.w SPA,x
	cmp.w #$1D36
	bne .2
	lda.w #$000E
	sta.b $01,s
.2:									; $068E = passspeed, if passspeed < $001E go to .3, $01,s = $0010
	lda.w passspeed
	sta.w $068E
	cmp.w #$001E
	bcc .3
	lda.w #$0010
	sta.b $01,s
.3:									; A = $0E80,x, a0 = X, call makepde, A + $0014, ...
	lda.w $0E80,x
	stx.b a0
	jsl.l makepde
	adc.w #$0014
	tax
	lda.w passspeed
	jsl.l Mul16x8U
	ldx.b r2
	lda.w #$2570
	jsl.l Mul16U
	lda.b $36
	sta.w passspeed
	lda.w breakaway
	beq .4
	jsl.l CheckBreakaway
	lda.w IsBreakaway
	sta.w breakaway
.4:									; X = curobj, puckc = $FFFF, nopuck,x = $000C, A = X, ...
	ldx.b curobj
	lda.w #$FFFF
	sta.w puckc
	lda.w #$000C
	sta.w nopuck,x
	txa
	lsr a
	sta.w lastplayer
	ldy.w #$010E
	lda.w pfgoal,x
	bne .5
	ldy.w #$FEF2
.5:									; d1 = Y, A = passdir, A * 2, A * 2, ...
	sty.b d1
	lda.w passdir
	asl a
	asl a
	tay
	lda.w #$9B35
	sta.b a0
	lda.w #$00C4
	sta.b $65
	lda.b [a0],y
	sec
	sbc.w puckx
	sta.b d0
	iny
	iny
	lda.b [a0],y
	sta.b d2
	pha
	lda.b d1
	sec
	sbc.w pucky
	sta.b d1
	pha
	lda.b d0
	pha
	ldy.b d1
	jsl.l ApproxLength
	cmp.w #$0000
	bne .6
	inc a
.6:									; d3 = A, A = gmode, if $0010 bits clear go to .7, go to .13
	sta.b d3
	lda.w gmode
	bit.w #$0010
	beq .7
	jmp.w .13
.7:									; if d3 >= $00C9 go to .8, A = $0010, A + shotacc,x, call randoma8, ...
	lda.b d3
	cmp.w #$00C9
	bcs .8
	lda.w #$0010
	adc.w shotacc,x
	jsl.l randoma8
	cmp.w #$000F
	bcs .13
.8:									; A = passspeed, A / 2, A / 2, A / 2, ...
	lda.w passspeed
	lsr a
	lsr a
	lsr a
	sec
	sbc.w shotacc,x
	clc
	adc.w #$0010
	ldx.b d3
	jsl.l Mul16U
	lda.b r2
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	ldx.b d3
	cpx.w #$012D
	bcs .9
	lsr a
.9:									; if A < $009B go to .10, A = $009B
	cmp.w #$009B
	bcc .10
	lda.w #$009B
.10:								; push A, call randomd0s, A + $03,s, $03,s = A, ...
	pha
	jsl.l randomd0s
	adc.b $03,s
	sta.b $03,s
	lda.b $01,s
	cmp.w #$003D
	bcc .11
	lda.w #$003C
	sta.b $01,s
.11:								; d0 = A, if $05,s >= 0 go to .12, d0 / 2
	sta.b d0
	lda.b $05,s
	bpl .12
	lsr.b d0
.12:								; call randomd0sd0, A + $05,s, $05,s = A, pull A, ...
	jsl.l randomd0sd0
	adc.b $05,s
	sta.b $05,s
	pla
	lsr a
	jsl.l randomd0A
	adc.b $05,s
	sta.b $05,s
.13:								; X = passspeed, A = $0044, call Mul16x8XS, A = r2, ...
	ldx.w passspeed
	lda.w #$0044
	jsl.l Mul16x8XS
	lda.b r2
	plx
	pha
	jsl.l Mul16S
	lda.b d3
	sta.b r1
	jsl.l Div32S
	lda.b r0
	asl a
	sta.w puckvx
	pla
	plx
	jsl.l Mul16S
	lda.b d3
	sta.b r1
	jsl.l Div32S
	lda.b r0
	asl a
	sta.w puckvy
	ldx.b curobj
	pla
	beq .15
	tax
	lda.w passspeed
	jsl.l Mul16U
	ldx.b r2
	lda.w #$0044
	jsl.l Mul16x8U
	lda.b d3
	sta.b r1
	jsl.l Div32U
	lda.b r0
	asl a
	sta.b d1
	lda.w #$0B33
	ldx.b d3
	jsl.l Mul16U
	lda.w passspeed
	sta.b r1
	jsl.l Div32U
	ldx.b curobj
	lda.b r0
	lsr a
	adc.b d1
	cmp.w #$1801
	bcc .14
	lda.w #$1800
.14:								; puckvz = A
	sta.w puckvz
.15:								; pull A, call StartSound, X = a3, Y = $010E, ...
	pla
	jsl.l StartSound
	ldx.b a3
	ldy.w #$010E
	lda.w pfgoal,x
	bne .16
	ldy.w #$FEF2
.16:								; tmp0 = Y, A = Y, A - pucky, if the result >= 0 go to .17, ...
	sty.b tmp0
	tya
	sec
	sbc.w pucky
	eor.w puckvy
	bpl .17
	lda.w #$0000
	sec
	sbc.w puckvy
	sta.w puckvy
.17:								; if PenShotActive = 0 go to .rtl, d0 = $0012, call assreplace
	lda.w PenShotActive
	beq .rtl
	lda.w #$0012
	sta.b d0
	jsl.l assreplace
.rtl:								; return
	rtl
DATA8_C49B35:						; not traced: data between routines
	db $00,$00,$0C,$00,$0F,$00,$0C,$00,$0F,$00,$06,$00,$0F,$00,$00,$00
	db $00,$00,$00,$00,$F1,$FF,$00,$00,$F1,$FF,$06,$00,$F1,$FF,$0C,$00
	db $00,$00,$06,$00
assbreakaway:						; assignment (asstab entry 16): the puck carrier on a breakaway; others
									; and pad players leave through assexit
	cpx.w puckc
	bne .1
	lda.w playerpad,x
	bmi CODE_C49B74
.1:									; go to assexit
	jmp.w assexit
DATA8_C49B66:						; an rtl no traced code reaches
	db $6B
CODE_C49B67:						; from CODE_C49B74
	jsl.l GlideBack
	lda.w #$003C
	sta.w nopuck,x
	jmp.w donothing
CODE_C49B74:						; from assbreakaway
	lda.w gmclock
	bne CODE_C49B67
	lda.w Ypos,x
	sta.b d0
	ldy.w pfgoal,x
	bne .1
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.1:									; A = pflags,x, if $0002 bits clear go to .2, A and $FFFD, ...
	lda.w pflags,x
	bit.w #$0002
	beq .2
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
	stz.w $18CA
	lda.w seed
	and.w #$0003
	sta.w temp3,x
	jsr.w CODE_C49CDB
.2:									; if $18C8 < 0 go to .5, if d0 - $18C8 < 0 go to .3, call CODE_C49C88, ...
	lda.w $18C8
	bmi .5
	lda.b d0
	cmp.w $18C8
	bmi .3
	jsr.w CODE_C49C88
	lda.w facedir,x
	sta.w $18CE
.3:									; d0 = $18C4, d1 = $18C6, if pfgoal,x is not 0 go to .4, A = $0000, ...
	lda.w $18C4
	sta.b d0
	lda.w $18C6
	sta.b d1
	lda.w pfgoal,x
	bne .4
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
.4:									; $65 = DATA8_C49C87>>16, a0 = DATA8_C49C87, A = temp2,x, ...
	lda.w #DATA8_C49C87>>16
	sta.b $65
	lda.w #DATA8_C49C87
	sta.b a0
	lda.w temp2,x
	sec
	sbc.w impactstep
	sta.w temp2,x
	jml.l skateto
.5:									; A = facedir,x, A - $18CE, if the result = 0 go to .3, A + 1, ...
	lda.w facedir,x
	sec
	sbc.w $18CE
	beq .3
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs .6
	jsl.l RandomWord
	and.w #$0F80
	bne .3
	bra .7
.6:									; call RandomWord, if the result is not 0 go to .3
	jsl.l RandomWord
	and.w #$0600
	bne .3
.7:									; call RandomWord, A and $0001, A + 1, A + 1, ...
	jsl.l RandomWord
	and.w #$0001
	inc a
	inc a
	sta.b d0
	ldy.w $18CC
	bpl .8
	lda.b d0
	clc
	adc.w #$0003
	sta.b d0
.8:									; passdir = d0, passspeed = $0014, A = $0000, A - Xpos,x, ...
	lda.b d0
	sta.w passdir
	lda.w #$0014
	sta.w passspeed
	lda.w #$0000
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w pfgoal,x
	bne .9
	lda.w #$FEF2
	sec
	sbc.w Ypos,x
	sta.b d1
	bra .10
.9:									; A = $010E, A - Ypos,x, d1 = A
	lda.w #$010E
	sec
	sbc.w Ypos,x
	sta.b d1
.10:								; call vtoa, call Findhittype, if zero go to .11, A = $1EFA, ...
	jsl.l vtoa
	jsl.l Findhittype
	beq .11
	lda.w #$1EFA
	bra .12
.11:								; A = $1E48
	lda.w #$1E48
.12:								; call SetSPAFromA, call updateanim, SPAcnt,x = $0002, go to doshot
	jsl.l SetSPAFromA
	jsl.l updateanim
	lda.w #$0002
	sta.w SPAcnt,x
	jml.l doshot
DATA8_C49C87:						; not traced: a table read by CODE_C49B74
	db $6B
CODE_C49C88:						; from CODE_C49B74
	lda.w $18CA
	asl a
	adc.w $18CA
	asl a
	tay
	lda.w #DATA8_C49CC3>>16
	sta.b $65
	lda.w #DATA8_C49CC3
	sta.b a0
	lda.b [a0],y
	sta.b d0
	lda.w $18CC
	bpl .1
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.1:									; $18C4 = d0, Y + 1, Y + 1, $18C6 = [a0],y, ...
	lda.b d0
	sta.w $18C4
	iny
	iny
	lda.b [a0],y
	sta.w $18C6
	iny
	iny
	lda.b [a0],y
	sta.w $18C8
	inc.w $18CA
	rts
DATA8_C49CC3:						; not traced: a table read by CODE_C49C88
	db $28,$00,$78,$00,$50,$00,$EA,$FF,$97,$00,$8C,$00,$EA,$FF,$E6,$00
	db $B7,$00,$2C,$00,$E9,$00,$FF,$FF
CODE_C49CDB:						; from CODE_C49B74
	lda.b d0
	cmp.w #$002E
	bpl .6
	jsl.l RandomWord
	and.w #$00C0
	beq .1
	lda.w attribute,x
	bit.w #$0800
	bne .2
	bra .3
.1:									; call RandomWord, A and $00F0, d0 = A, A = $007F, ...
	jsl.l RandomWord
	and.w #$00F0
	sta.b d0
	lda.w #$007F
	sec
	sbc.b d0
	bmi .3
.2:									; A = $0033, go to .4
	lda.w #$0033
	bra .4
.3:									; A = $FFCD
	lda.w #$FFCD
.4:									; if pfgoal,x is not 0 go to .5, A xor $FFFF, A + 1
	ldy.w pfgoal,x
	bne .5
	eor.w #$FFFF
	inc a
.5:									; $18CC = A, $18C4 = A, $18C6 = $0028, $18C8 = $001E, ...
	sta.w $18CC
	sta.w $18C4
	lda.w #$0028
	sta.w $18C6
	lda.w #$001E
	sta.w $18C8
	rts
.6:									; if Xpos,x - $0020 >= 0 go to .13, if Xpos,x - $FFE0 < 0 go to .13, ...
	lda.w Xpos,x
	cmp.w #$0020
	bpl .13
	cmp.w #$FFE0
	bmi .13
	jsl.l RandomWord
	and.w #$00C0
	beq .7
	lda.w attribute,x
	bit.w #$0800
	bne .8
	bra .9
.7:									; call RandomWord, A and $00F0, d0 = A, A = $007F, ...
	jsl.l RandomWord
	and.w #$00F0
	sta.b d0
	lda.w #$007F
	sec
	sbc.b d0
	bmi .9
.8:									; A = $002C, go to .10
	lda.w #$002C
	bra .10
.9:									; A = $FFD4
	lda.w #$FFD4
.10:								; if pfgoal,x is not 0 go to .11, A xor $FFFF, A + 1
	ldy.w pfgoal,x
	bne .11
	eor.w #$FFFF
	inc a
.11:								; $18CC = A, $18C4 = A
	sta.w $18CC
	sta.w $18C4
.12:								; $18CA = $0002, $18C6 = $0097, $18C8 = $008C, return
	lda.w #$0002
	sta.w $18CA
	lda.w #$0097
	sta.w $18C6
	lda.w #$008C
	sta.w $18C8
	rts
.13:								; $18CC = A, $18C4 = 0, go to .12
	sta.w $18CC
	stz.w $18C4
	bra .12
Findhittype:						; from SetShotMode, CODE_C4A20F, CODE_C49E91, ...
	lda.b d0
	eor.w #$FFFF
	inc a
	clc
	adc.w facedir,x
	and.w #$0007
	sta.b d0
	lda.w attribute,x
	bit.w #$0800
	beq .1
	phx
	ldx.b d0
	lda.l DATA8_C49DBC,x
	plx
	and.w #$00FF
	rtl
.1:									; push X, X = d0, A = DATA8_C49DBF,x, pull X, ...
	phx
	ldx.b d0
	lda.l DATA8_C49DBF,x
	plx
	and.w #$00FF
	rtl
DATA8_C49DBC:						; not traced: a table read by Findhittype
	db $00,$00,$00
DATA8_C49DBF:						; not traced: a table read by Findhittype
	db $00,$01,$01,$01,$01,$00,$00,$00
setpassmode:						; called from other segments
	lda.w position,x
	bne .2
	lda.w puckx
	cmp.w #$FFF0
	bmi .2
	cmp.w #$0010
	bpl .2
	lda.w pucky
	cmp.w #$010E
	bpl .1
	cmp.w #$FEF2
	bpl .2
.1:									; if A < $0116 go to .rtl
	cmp.w #$0116
	bcc .rtl
.2:									; A = facedir,x, A and $0007, passdir = A, A = $0004, ...
	lda.w facedir,x
	and.w #$0007
	sta.w passdir
	lda.w #$0004
	tsb.w sflags
.rtl:								; return
	rtl
asspassrec:							; called from other segments
	lda.w pflags,x
	bit.w #$0002
	beq .1
	and.w #$FFFD
	ora.w #$0001
	sta.w pflags,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
.1:									; $0676,x - 1, if the result < 0 go to CODE_C49E78, ...
	dec.w $0676,x
	bmi CODE_C49E78
	lda.w puckc
	bpl CODE_C49E78
	lda.w onetimerreq
	bne CODE_C49E91
	ldy.w playerpad,x
	bmi CODE_C49E42
	lda.w padnew,y
	bit.w #$8000
	bne CODE_C49E78
	bit.w #$0080
	beq CODE_C49E42
	inc.w onetimerreq
	lda.w #$7FFF
	sta.w $0674
	bra CODE_C49E91
DATA8_C49E41:						; an rtl no traced code reaches
	db $6B
CODE_C49E42:						; from asspassrec
	ldy.b a2
	lda.w teampads,y
	bne .3
	lda.w pfgoal,x
	bne .2
	lda.w Ypos,x
	cmp.w #$FFA4
	bpl .3
.1:									; call RandomWord, if the result is not 0 go to .3, onetimerreq + 1, ...
	jsl.l RandomWord
	and.w #$0080
	bne .3
	inc.w onetimerreq
	lda.w #$7FFF
	sta.w $0674
	jmp.w CODE_C49E91
.2:									; if Ypos,x - $005C >= 0 go to .1
	lda.w Ypos,x
	cmp.w #$005C
	bpl .1
.3:									; if puckc < 0 go to CODE_C49E90
	lda.w puckc
	bmi CODE_C49E90
CODE_C49E78:						; from asspassrec, CODE_C49E91
	lda.w #$FFFF
	sta.w passReceiverPlayerNum
	stz.w pfalock,x
	stz.w onetimerreq
	lda.w pflags,x
	and.w #$FFFE
	sta.w pflags,x
	jmp.w assexit
CODE_C49E90:						; from CODE_C49E42, CODE_C49E91
	rtl
CODE_C49E91:						; from asspassrec, CODE_C49E42
	lda.w SPA,x
	cmp.w #$1E48
	beq .7
	cmp.w #$1EFA
	beq .7
	phy
	ldy.w #$0000
	cpx.w #$000C
	bmi .1
	ldy.w #$0002
.1:									; A = $12F3,y, A + 1, $12F3,y = A, pull Y, ...
	lda.w $12F3,y
	inc a
	sta.w $12F3,y
	ply
	lda.w #$0000
	sec
	sbc.w $066E
	sta.b d0
	lda.w pfgoal,x
	bne .2
	lda.w #$FEF2
	sec
	sbc.w passtargety
	sta.b d1
	bra .3
.2:									; A = $010E, A - passtargety, d1 = A
	lda.w #$010E
	sec
	sbc.w passtargety
	sta.b d1
.3:									; call vtoa, call Findhittype, if zero go to .4, A = $1EFA, ...
	jsl.l vtoa
	jsl.l Findhittype
	beq .4
	lda.w #$1EFA
	bra .5
.4:									; A = $1E48
	lda.w #$1E48
.5:									; call SetSPAFromA, go to CODE_C49E90
	jsl.l SetSPAFromA
	jmp.w CODE_C49E90
.6:									; go to CODE_C49E78
	jmp.w CODE_C49E78
.7:									; nopuck,x = $000A, if SPAnum,x >= $0010 go to .6, if minus go to .6, ...
	lda.w #$000A
	sta.w nopuck,x
	lda.w SPAnum,x
	cmp.w #$0010
	bcs .6
	bit.w $0674
	bmi .6
	txa
	jsl.l GetFrameHot
	lda.w Xpos,x
	clc
	adc.b d0
	sec
	sbc.w puckx
	tay
	lda.w Ypos,x
	clc
	adc.b d1
	sec
	sbc.w pucky
	jsl.l ApproxLength
	cmp.w $0674
	sta.w $0674
	bcs .8
	jmp.w .14
.8:									; A = Xpos,x, A - puckx, Y = A, A = Ypos,x, ...
	lda.w Xpos,x
	sec
	sbc.w puckx
	tay
	lda.w Ypos,x
	sec
	sbc.w pucky
	jsl.l ApproxLength
	cmp.w #$001C
	bcs .14
	lda.w #$FFFF
	sta.w $0674
	stz.w puckvx
	stz.w puckvy
	stz.w SPAcnt,x
	stx.w puckc
	ldy.w playerpad,x
	bmi .9
	lda.w paddir,y
	sta.w passdir
	bra .10
.9:									; passdir = $0008
	lda.w #$0008
	sta.w passdir
.10:								; passspeed = $0024, pfalock,x = A, if gmclock is not 0 go to .12, ...
	lda.w #$0024
	sta.w passspeed
	sta.w pfalock,x
	lda.w gmclock
	bne .12
	phy
	ldy.w #$0000
	cpx.w #$000C
	bmi .11
	ldy.w #$0002
.11:								; A = $12F7,y, A + 1, $12F7,y = A, pull Y
	lda.w $12F7,y
	inc a
	sta.w $12F7,y
	ply
.12:								; onetimer = $0001, A = CwdExciteLvl, A + $000A, ...
	lda.w #$0001
	sta.w onetimer
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi .13
	sta.w CwdExciteLvl
.13:								; a2 = X, call a2touchpuck, pull A, a2 = A, ...
	pei ($6B)
	stx.b a2
	jsl.l a2touchpuck
	pla
	sta.b a2
	jsl.l doshot
	jmp.w CODE_C49E78
.14:								; if puckc < 0 go to .rtl, if X = puckc go to .rtl, go to CODE_C49E78
	lda.w puckc
	bmi .rtl
	cpx.w puckc
	beq .rtl
	jmp.w CODE_C49E78
.rtl:								; return
	rtl

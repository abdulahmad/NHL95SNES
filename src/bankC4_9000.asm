; Segment bankC4_9000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C492F8
CODE_C492F8:						; called from other segments
	lda.w Ypos,x
	cmp.w #$010E
	bpl CODE_C49324
	cmp.w #$FEF2
	bmi CODE_C49324
	cpx.w puckc
	bne CODE_C4930C
	stz.b d0
CODE_C4930C:						; from CODE_C492F8
	lda.b d1
	cmp.w #$0109
	bmi CODE_C49318
	lda.w #$0109
	sta.b d1
CODE_C49318:						; from CODE_C4930C
	lda.b d1
	cmp.w #$FEF7
	bpl CODE_C49324
	lda.w #$FEF7
	sta.b d1
CODE_C49324:						; from CODE_C492F8, CODE_C49318
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
	bne CODE_C4936A
	lda.b d0
	sec
	sbc.b r3
	beq CODE_C4936A
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
CODE_C4936A:						; from AdjustFacingDirection
	lda.w goalieturnwait,x
	beq CODE_C4937B
	sec
	sbc.w timestep
	bpl CODE_C49378
	lda.w #$0000
CODE_C49378:						; from CODE_C4936A
	sta.w goalieturnwait,x
CODE_C4937B:						; from CODE_C4936A
	rtl
GoaliePuckVector:					; called from other segments
	lda.w $0830
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w pucky
	sec
	sbc.w Ypos,x
	sta.b d1
	bra CODE_C4939D
CODE_C49390:						; no caller found (not traced); it runs on into the next routine
	lda.w $0830
	sta.b d0
	lda.w pucky
	sec
	sbc.b d4
	sta.b d1
CODE_C4939D:						; from GoaliePuckVector
	lda.w Ypos,x
	bpl CODE_C493BC
	cmp.w #$FEF2
	bmi CODE_C493BB
	lda.w pucky
	cmp.w #$FEF2
	bmi CODE_C493B0
	rts
CODE_C493B0:						; from CODE_C4939D
	lda.w #$0001
	sta.b d1
	rts
CODE_C493B6:						; from CODE_C493BC
	lda.w #$FFFF
	sta.b d1
CODE_C493BB:						; from CODE_C4939D, CODE_C493BC
	rts
CODE_C493BC:						; from CODE_C4939D
	cmp.w #$010E
	bpl CODE_C493BB
	lda.w pucky
	cmp.w #$010E
	bpl CODE_C493B6
	rts
CODE_C493CA:						; called from other segments
	lda.w #$0002
	trb.w $0D7C
	beq pucknorm_move
	stz.w $0AFC
	stz.w $0B1C
	lda.w #$0078
	sta.w $0B9C
	stz.w $234E
pucknorm_move:						; from CODE_C493CA and other segments
	lda.w $07DA
	sec
	sbc.b d7
	sta.w $07DA
	lda.w $07DE
	sec
	sbc.b d7
	sta.w $07DE
	lda.w $0AFC
	sec
	sbc.b d7
	sta.w $0AFC
	bpl CODE_C49408
	adc.w #$0005
	sta.w $0AFC
	jsl.l CODE_C494E6
CODE_C49408:						; from pucknorm_move
	lda.w puckc
	bmi CODE_C4945D
	sta.b a2
	jsl.l a2touchpuck
	lda.b a2
	jsl.l CODE_C37FE2
	ldy.b a2
	lda.b d0
	clc
	adc.w Xpos,y
	sec
	sbc.w $0830
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C4942F
	ora.w #$C000
CODE_C4942F:						; from CODE_C49408
	clc
	adc.w $0830
	sta.w $0830
	lda.b d1
	clc
	adc.w Ypos,y
	sec
	sbc.w pucky
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C4944A
	ora.w #$C000
CODE_C4944A:						; from CODE_C4942F
	clc
	adc.w pucky
	sta.w pucky
	lda.w Xvel,y
	sta.w puckvx
	lda.w Yvel,y
	sta.w puckvy
CODE_C4945D:						; from CODE_C49408
	jsl.l PuckIChk
	jsl.l CODE_C4AED5
	lda.w gmclock
	bne CODE_C494D1
	lda.w puckc
	bpl CODE_C494C8
	lda.w PenShotActive
	beq CODE_C494A5
	lda.w gmode
	bit.w #$0002
	bne CODE_C49483
	lda.w BA_Team
	beq CODE_C4948F
	bra CODE_C49488
CODE_C49483:						; from CODE_C4945D
	lda.w BA_Team
	bne CODE_C4948F
CODE_C49488:						; from CODE_C4945D
	lda.w puckvy
	bmi CODE_C494A5
	bra CODE_C49495
CODE_C4948F:						; from CODE_C4945D, CODE_C49483
	lda.w puckvy
	dec a
	bpl CODE_C494A5
CODE_C49495:						; from CODE_C49488
	lda.w $234E
	inc a
	sta.w $234E
	cmp.w #$0030
	bcc CODE_C494A8
	jsl.l EndPenaltyShot
CODE_C494A5:						; from CODE_C4945D, CODE_C49488, CODE_C4948F
	stz.w $234E
CODE_C494A8:						; from CODE_C49495
	lda.w $0830
	cmp.w $093C
	bne CODE_C494CB
	lda.w pucky
	cmp.w $097C
	bne CODE_C494CB
	lda.w #$0006
	sta.b d0
	dec.w $0B9C
	bpl CODE_C494D1
	jsl.l AddPenalty2
	bra CODE_C494D1
CODE_C494C8:						; from CODE_C4945D
	stz.w $234E
CODE_C494CB:						; from CODE_C494A8
	lda.w #$0078
	sta.w $0B9C
CODE_C494D1:						; from CODE_C4945D, CODE_C494A8
	lda.w puckvz
	and.w #$FF00
	ora.w puckz
	beq CODE_C494DF
	jmp.w checkpuckcoll
CODE_C494DF:						; from CODE_C494D1
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
	beq CODE_C4952D
	ora.w #$F000
CODE_C4952D:						; from CODE_C49504
	sta.b $36
	lda.w puckvy
	sta.b r1
	jsl.l Div32S
	lda.b r0
	sta.w $07DA,y
	lda.b r0
	asl a
	asl a
	asl a
	asl a
	ldx.w puckvx
	jsl.l Mul16XS
	adc.w $0830
	sta.b d0
	cmp.w #$009B
	bmi CODE_C49559
	lda.w #$009B
	sta.b d0
CODE_C49559:						; from CODE_C4952D
	lda.b d0
	cmp.w #$FF65
	bpl CODE_C49565
	lda.w #$FF65
	sta.b d0
CODE_C49565:						; from CODE_C49559
	lda.b d0
	sta.w $07D8,y
	rtl
CODE_C4956B:						; from CODE_C49501
	lda.w #$FFFF
	sta.w $07DA,y
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
pucknothing:						; from CODE_C494DF and other segments
	lda.w $0CBC
	cmp.w #$0008
	bcc CODE_C495AB
	cmp.w #$0018
	bcs CODE_C495AB
	lda.w $0C5C
	eor.w #$0002
	sta.w $0C5C
CODE_C495AB:						; from pucknothing
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
	beq CODE_C495CB
	ora.w #$FF80
CODE_C495CB:						; from skatetopuckinit
	clc
	adc.w $0830
	sta.b d0
	lda.w puckvy
	xba
	lsr a
	and.w #$007F
	bit.w #$0040
	beq CODE_C495E1
	ora.w #$FF80
CODE_C495E1:						; from CODE_C495CB
	clc
	adc.w pucky
	sta.b d1
	rtl
chk4shot:							; called from other segments
	lda.w gmclock
	bne CODE_C495F8
	lda.w gameclock
	cmp.w #$0005
	bcs CODE_C495F8
	jmp.w CompShoot
CODE_C495F8:						; from chk4shot
	lda.w PenShotActive
	bne CODE_C49620
	jsl.l CODE_C42D98
	bne CODE_C49620
	lda.w $07EE
	beq CODE_C49620
	lda.w Ypos,x
	cmp.w #$FF0D
	bmi CODE_C49620
	cmp.w #$00F3
	bpl CODE_C49620
	lda.w seed
	and.w #$0003
	bne CODE_C49620
	jmp.w CODE_C4A4AB
CODE_C49620:						; from CODE_C495F8
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
	bne CODE_C49638
	ldy.w #$FEF2
CODE_C49638:						; from CODE_C49620
	sty.b d1
	tya
	sec
	sbc.w pucky
	sta.b d1
	cmp.w #$0064
	bpl CODE_C496AE
	cmp.w #$FF9C
	bmi CODE_C496AE
	lda.w $0830
	cmp.w #$0064
	bpl CODE_C496AE
	cmp.w #$FF9C
	bmi CODE_C496C2
	eor.w #$FFFF
	inc a
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	lda.b d1
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
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
	bcs CODE_C49697
	ldy.w #$000C
CODE_C49697:						; from CODE_C49638, CODE_C496BC
	lda.w position,y
	beq CODE_C496B0
	lda.w puckdir,y
	sec
	sbc.w #$0004
	and.w #$0007
	cmp.b d5
	bne CODE_C496BC
	asl.b d4
	bra CODE_C496BC
CODE_C496AE:						; from CODE_C49638
	bra CODE_C496C2
CODE_C496B0:						; from CODE_C49697
	lda.w pf2aip,y
	beq CODE_C496BC
	stz.b d3
	lda.w #$0001
	sta.b d4
CODE_C496BC:						; from CODE_C49697, CODE_C496B0
	iny
	iny
	dec.b d3
	bpl CODE_C49697
CODE_C496C2:						; from CODE_C49638, CODE_C496AE
	lda.b d4
	jsl.l randomd0A
	cmp.w #$0009
	bcs CODE_C49709
	lda.w pucky
	sta.b d0
	lda.w pfgoal,x
	bne CODE_C496DF
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
CODE_C496DF:						; from CODE_C496C2
	lda.b d0
	bmi CODE_C49709
	lda.w #$010E
	sec
	sbc.b d0
	bmi CODE_C49709
	lda.w PenShotActive
	beq CODE_C496FE
	lda.w #$00B2
	lsr a
	lsr a
	clc
	adc.w #$005C
	sec
	sbc.b d0
	bpl CODE_C49709
CODE_C496FE:						; from CODE_C496DF
	lda.w sflags
	bit.w #$8000
	bne CODE_C49709
	jmp.w CompShoot
CODE_C49709:						; from CODE_C496C2, CODE_C496DF, CODE_C496FE
	rtl
shotdiradj:							; from doshot and other segments
	lda.w playerpad,x
	bmi CODE_C49712
	jmp.w CODE_C497DE
CODE_C49712:						; from shotdiradj
	lda.w #$0008
	sta.b d0
	lda.w #$0005
	sta.b d1
	ldy.w #$0000
	lda.w pfteam,x
	bne CODE_C49727
	ldy.w #$000C
CODE_C49727:						; from CODE_C49712, CODE_C49727
	lda.w position,y
	beq CODE_C49735
	iny
	iny
	dec.b d1
	bpl CODE_C49727
	jmp.w CODE_C497D9
CODE_C49735:						; from CODE_C49727
	lda.w $09A1,y
	and.w #$00FF
	bit.w #$0080
	beq CODE_C49743
	ora.w #$FF00
CODE_C49743:						; from CODE_C49735
	pha
	asl a
	pla
	ror a
	clc
	adc.w Xpos,y
	sec
	sbc.w $0830
	sta.b d0
	lda.w $09C1,y
	and.w #$00FF
	bit.w #$0080
	beq CODE_C4975F
	ora.w #$FF00
CODE_C4975F:						; from CODE_C49743
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
	bne CODE_C49785
	ldy.w #$FEF2
CODE_C49785:						; from CODE_C4975F
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
	bmi CODE_C497D9
	cmp.w #$002D
	bpl CODE_C497D9
	lda.w pfgoal,x
	beq CODE_C497C3
	lda.w #$0000
	sec
	sbc.b d4
	sta.b d4
CODE_C497C3:						; from CODE_C49785
	jsl.l RandomWord
	and.w #$0003
	inc a
	sta.b d0
	lda.b d4
	bpl CODE_C497D9
	lda.b d0
	clc
	adc.w #$0004
	sta.b d0
CODE_C497D9:						; from CODE_C49727, CODE_C49785, CODE_C497C3
	lda.b d0
	sta.w passdir
CODE_C497DE:						; from shotdiradj
	rtl
CalcAngleOffset:					; from CODE_C49785
	lda.b d3
	sec
	sbc.w $0830
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
CompShoot:							; from chk4shot, CODE_C496FE and other segments
	pla
	sep #$20
	pla
	rep #$30
	lda.w pucky
	sta.b d0
	lda.w pfgoal,x
	bne CODE_C49835
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
CODE_C49835:						; from CompShoot
	lda.w #$010E
	sec
	sbc.b d0
	lsr a
	lsr a
	lsr a
	cmp.w #$0015
	bcc CODE_C49846
	lda.w #$0014
CODE_C49846:						; from CODE_C49835
	sta.b d1
	stz.w temp2,x
	lda.b d1
	sta.w temp2b,x
	lda.w #$0013
	sta.b d0
	jmp.w assreplace
SetShotMode:						; from CODE_C498A1 and other segments
	lda.w #$0008
	sta.w passdir
	lda.w #$0008
	tsb.w sflags
	stz.b d0
	lda.w #$0128
	sta.b d1
	lda.w pfgoal,x
	bne CODE_C49875
	lda.w #$FED8
	sta.b d1
CODE_C49875:						; from SetShotMode
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
	beq CODE_C4989B
	ldy.w #$1D36
CODE_C4989B:						; from CODE_C49875
	sty.b d1
	jml.l SetSPA
CODE_C498A1:						; called from other segments
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C498B1
	and.w #$FFFD
	sta.w pflags,x
	bra SetShotMode
CODE_C498B1:						; from CODE_C498A1
	lda.w sflags
	bit.w #$0008
	bne CODE_C498BC
	jmp.w assexit
CODE_C498BC:						; from CODE_C498B1
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
CODE_C498D3:						; from CODE_C498BC and other segments
	cpx.w puckc
	bne CODE_C49929
	lda.w SPA,x
	cmp.w #$1C24
	bcc CODE_C49929
	cmp.w #$1EFB
	bcs CODE_C49929
	lda.w SPAnum,x
	cmp.w #$0018
	bcs doshot
	lda.b d0
	bit.w #$0008
	bne CODE_C498FA
	and.w #$0007
	sta.w passdir
CODE_C498FA:						; from CODE_C498D3
	lda.w SPAnum,x
	cmp.w #$0010
	bcs CODE_C4992F
	lda.w passspeed
	clc
	adc.b d7
	sta.w passspeed
	lda.b d2
	bit.w #$0080
	beq CODE_C4992F
	lda.w #$001C
	sec
	sbc.w SPAnum,x
	sta.w SPAnum,x
	cmp.w #$0018
	bcc CODE_C4992F
	lda.w #$0018
	sta.w SPAnum,x
	bra doshot
CODE_C49929:						; from CODE_C498D3
	lda.w #$0008
	trb.w sflags
CODE_C4992F:						; from CODE_C498FA
	rtl
doshot:								; from CODE_C498D3, CODE_C498FA, CODE_C49F9D, ...
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
	beq CODE_C49955
	jmp.w CODE_C49AFE
CODE_C49955:						; from doshot
	lda.w #$000E
	sta.b $01,s
	lda.w #$1000
	tsb.w sflags
	lda.w SPA,x
	cmp.w #$1D36
	bne CODE_C4996D
	lda.w #$000E
	sta.b $01,s
CODE_C4996D:						; from CODE_C49955
	lda.w passspeed
	sta.w $068E
	cmp.w #$001E
	bcc CODE_C4997D
	lda.w #$0010
	sta.b $01,s
CODE_C4997D:						; from CODE_C4996D
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
	beq CODE_C499AE
	jsl.l CheckBreakaway
	lda.w IsBreakaway
	sta.w breakaway
CODE_C499AE:						; from CODE_C4997D
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
	bne CODE_C499CC
	ldy.w #$FEF2
CODE_C499CC:						; from CODE_C499AE
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
	sbc.w $0830
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
	bne CODE_C49A05
	inc a
CODE_C49A05:						; from CODE_C499CC
	sta.b d3
	lda.w gmode
	bit.w #$0010
	beq CODE_C49A12
	jmp.w CODE_C49A83
CODE_C49A12:						; from CODE_C49A05
	lda.b d3
	cmp.w #$00C9
	bcs CODE_C49A28
	lda.w #$0010
	adc.w shotacc,x
	jsl.l randoma8
	cmp.w #$000F
	bcs CODE_C49A83
CODE_C49A28:						; from CODE_C49A12
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
	bcs CODE_C49A4C
	lsr a
CODE_C49A4C:						; from CODE_C49A28
	cmp.w #$009B
	bcc CODE_C49A54
	lda.w #$009B
CODE_C49A54:						; from CODE_C49A4C
	pha
	jsl.l randomd0s
	adc.b $03,s
	sta.b $03,s
	lda.b $01,s
	cmp.w #$003D
	bcc CODE_C49A69
	lda.w #$003C
	sta.b $01,s
CODE_C49A69:						; from CODE_C49A54
	sta.b d0
	lda.b $05,s
	bpl CODE_C49A71
	lsr.b d0
CODE_C49A71:						; from CODE_C49A69
	jsl.l randomd0sd0
	adc.b $05,s
	sta.b $05,s
	pla
	lsr a
	jsl.l randomd0A
	adc.b $05,s
	sta.b $05,s
CODE_C49A83:						; from CODE_C49A05, CODE_C49A12
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
	beq CODE_C49AFE
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
	bcc CODE_C49AFB
	lda.w #$1800
CODE_C49AFB:						; from CODE_C49A83
	sta.w puckvz
CODE_C49AFE:						; from doshot, CODE_C49A83
	pla
	jsl.l CODE_CF040B
	ldx.b a3
	ldy.w #$010E
	lda.w pfgoal,x
	bne CODE_C49B10
	ldy.w #$FEF2
CODE_C49B10:						; from CODE_C49AFE
	sty.b tmp0
	tya
	sec
	sbc.w pucky
	eor.w puckvy
	bpl CODE_C49B26
	lda.w #$0000
	sec
	sbc.w puckvy
	sta.w puckvy
CODE_C49B26:						; from CODE_C49B10
	lda.w PenShotActive
	beq CODE_C49B34
	lda.w #$0012
	sta.b d0
	jsl.l assreplace
CODE_C49B34:						; from CODE_C49B26
	rtl
DATA8_C49B35:						; not traced: data between routines
	db $00,$00,$0C,$00,$0F,$00,$0C,$00,$0F,$00,$06,$00,$0F,$00,$00,$00
	db $00,$00,$00,$00,$F1,$FF,$00,$00,$F1,$FF,$06,$00,$F1,$FF,$0C,$00
	db $00,$00,$06,$00
CODE_C49B59:						; called from other segments
	cpx.w puckc
	bne CODE_C49B63
	lda.w playerpad,x
	bmi CODE_C49B74
CODE_C49B63:						; from CODE_C49B59
	jmp.w assexit
DATA8_C49B66:						; an rtl no traced code reaches
	db $6B
CODE_C49B67:						; from CODE_C49B74
	jsl.l CODE_C42B18
	lda.w #$003C
	sta.w nopuck,x
	jmp.w donothing
CODE_C49B74:						; from CODE_C49B59
	lda.w gmclock
	bne CODE_C49B67
	lda.w Ypos,x
	sta.b d0
	ldy.w pfgoal,x
	bne CODE_C49B8B
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
CODE_C49B8B:						; from CODE_C49B74
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C49BB4
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
CODE_C49BB4:						; from CODE_C49B8B
	lda.w $18C8
	bmi CODE_C49BF8
	lda.b d0
	cmp.w $18C8
	bmi CODE_C49BC9
	jsr.w CODE_C49C88
	lda.w facedir,x
	sta.w $18CE
CODE_C49BC9:						; from CODE_C49BB4, CODE_C49BF8, CODE_C49C15
	lda.w $18C4
	sta.b d0
	lda.w $18C6
	sta.b d1
	lda.w pfgoal,x
	bne CODE_C49BE0
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
CODE_C49BE0:						; from CODE_C49BC9
	lda.w #DATA8_C49C87>>16
	sta.b $65
	lda.w #DATA8_C49C87
	sta.b a0
	lda.w temp2,x
	sec
	sbc.w $07A4
	sta.w temp2,x
	jml.l skateto
CODE_C49BF8:						; from CODE_C49BB4
	lda.w facedir,x
	sec
	sbc.w $18CE
	beq CODE_C49BC9
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs CODE_C49C15
	jsl.l RandomWord
	and.w #$0F80
	bne CODE_C49BC9
	bra CODE_C49C1E
CODE_C49C15:						; from CODE_C49BF8
	jsl.l RandomWord
	and.w #$0600
	bne CODE_C49BC9
CODE_C49C1E:						; from CODE_C49BF8
	jsl.l RandomWord
	and.w #$0001
	inc a
	inc a
	sta.b d0
	ldy.w $18CC
	bpl CODE_C49C36
	lda.b d0
	clc
	adc.w #$0003
	sta.b d0
CODE_C49C36:						; from CODE_C49C1E
	lda.b d0
	sta.w passdir
	lda.w #$0014
	sta.w passspeed
	lda.w #$0000
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w pfgoal,x
	bne CODE_C49C5A
	lda.w #$FEF2
	sec
	sbc.w Ypos,x
	sta.b d1
	bra CODE_C49C63
CODE_C49C5A:						; from CODE_C49C36
	lda.w #$010E
	sec
	sbc.w Ypos,x
	sta.b d1
CODE_C49C63:						; from CODE_C49C36
	jsl.l vtoa
	jsl.l Findhittype
	beq CODE_C49C72
	lda.w #$1EFA
	bra CODE_C49C75
CODE_C49C72:						; from CODE_C49C63
	lda.w #$1E48
CODE_C49C75:						; from CODE_C49C63
	jsl.l SetSPAFromA
	jsl.l updateanim
	lda.w #$0002
	sta.w SPAcnt,x
	jml.l doshot
DATA8_C49C87:						; not traced: a table read by CODE_C49BE0
	db $6B
CODE_C49C88:						; from CODE_C49BB4
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
	bpl CODE_C49CAC
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
CODE_C49CAC:						; from CODE_C49C88
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
CODE_C49CDB:						; from CODE_C49B8B
	lda.b d0
	cmp.w #$002E
	bpl CODE_C49D2A
	jsl.l RandomWord
	and.w #$00C0
	beq CODE_C49CF5
	lda.w attribute,x
	bit.w #$0800
	bne CODE_C49D06
	bra CODE_C49D0B
CODE_C49CF5:						; from CODE_C49CDB
	jsl.l RandomWord
	and.w #$00F0
	sta.b d0
	lda.w #$007F
	sec
	sbc.b d0
	bmi CODE_C49D0B
CODE_C49D06:						; from CODE_C49CDB
	lda.w #$0033
	bra CODE_C49D0E
CODE_C49D0B:						; from CODE_C49CDB, CODE_C49CF5
	lda.w #$FFCD
CODE_C49D0E:						; from CODE_C49D06
	ldy.w pfgoal,x
	bne CODE_C49D17
	eor.w #$FFFF
	inc a
CODE_C49D17:						; from CODE_C49D0E
	sta.w $18CC
	sta.w $18C4
	lda.w #$0028
	sta.w $18C6
	lda.w #$001E
	sta.w $18C8
	rts
CODE_C49D2A:						; from CODE_C49CDB
	lda.w Xpos,x
	cmp.w #$0020
	bpl CODE_C49D85
	cmp.w #$FFE0
	bmi CODE_C49D85
	jsl.l RandomWord
	and.w #$00C0
	beq CODE_C49D4A
	lda.w attribute,x
	bit.w #$0800
	bne CODE_C49D5B
	bra CODE_C49D60
CODE_C49D4A:						; from CODE_C49D2A
	jsl.l RandomWord
	and.w #$00F0
	sta.b d0
	lda.w #$007F
	sec
	sbc.b d0
	bmi CODE_C49D60
CODE_C49D5B:						; from CODE_C49D2A
	lda.w #$002C
	bra CODE_C49D63
CODE_C49D60:						; from CODE_C49D2A, CODE_C49D4A
	lda.w #$FFD4
CODE_C49D63:						; from CODE_C49D5B
	ldy.w pfgoal,x
	bne CODE_C49D6C
	eor.w #$FFFF
	inc a
CODE_C49D6C:						; from CODE_C49D63
	sta.w $18CC
	sta.w $18C4
CODE_C49D72:						; from CODE_C49D85
	lda.w #$0002
	sta.w $18CA
	lda.w #$0097
	sta.w $18C6
	lda.w #$008C
	sta.w $18C8
	rts
CODE_C49D85:						; from CODE_C49D2A
	sta.w $18CC
	stz.w $18C4
	bra CODE_C49D72
Findhittype:						; from CODE_C49875, CODE_C4A20F, CODE_C49ED4, ...
	lda.b d0
	eor.w #$FFFF
	inc a
	clc
	adc.w facedir,x
	and.w #$0007
	sta.b d0
	lda.w attribute,x
	bit.w #$0800
	beq CODE_C49DB0
	phx
	ldx.b d0
	lda.l DATA8_C49DBC,x
	plx
	and.w #$00FF
	rtl
CODE_C49DB0:						; from Findhittype
	phx
	ldx.b d0
	lda.l DATA8_C49DBF,x
	plx
	and.w #$00FF
	rtl
DATA8_C49DBC:						; not traced: a table read by Findhittype
	db $00,$00,$00
DATA8_C49DBF:						; not traced: a table read by CODE_C49DB0
	db $00,$01,$01,$01,$01,$00,$00,$00
setpassmode:						; called from other segments
	lda.w position,x
	bne CODE_C49DEB
	lda.w $0830
	cmp.w #$FFF0
	bmi CODE_C49DEB
	cmp.w #$0010
	bpl CODE_C49DEB
	lda.w pucky
	cmp.w #$010E
	bpl CODE_C49DE6
	cmp.w #$FEF2
	bpl CODE_C49DEB
CODE_C49DE6:						; from setpassmode
	cmp.w #$0116
	bcc CODE_C49DFA
CODE_C49DEB:						; from setpassmode
	lda.w facedir,x
	and.w #$0007
	sta.w passdir
	lda.w #$0004
	tsb.w sflags
CODE_C49DFA:						; from CODE_C49DE6
	rtl
asspassrec:							; called from other segments
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C49E15
	and.w #$FFFD
	ora.w #$0001
	sta.w pflags,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
CODE_C49E15:						; from asspassrec
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
CODE_C49E42:						; from CODE_C49E15
	ldy.b a2
	lda.w teampads,y
	bne CODE_C49E73
	lda.w pfgoal,x
	bne CODE_C49E6B
	lda.w Ypos,x
	cmp.w #$FFA4
	bpl CODE_C49E73
CODE_C49E56:						; from CODE_C49E6B
	jsl.l RandomWord
	and.w #$0080
	bne CODE_C49E73
	inc.w onetimerreq
	lda.w #$7FFF
	sta.w $0674
	jmp.w CODE_C49E91
CODE_C49E6B:						; from CODE_C49E42
	lda.w Ypos,x
	cmp.w #$005C
	bpl CODE_C49E56
CODE_C49E73:						; from CODE_C49E42, CODE_C49E56
	lda.w puckc
	bmi CODE_C49E90
CODE_C49E78:						; from CODE_C49E15, CODE_C49EED, CODE_C49FAF, CODE_C49F9D
	lda.w #$FFFF
	sta.w passReceiverPlayerNum
	stz.w pfalock,x
	stz.w onetimerreq
	lda.w pflags,x
	and.w #$FFFE
	sta.w pflags,x
	jmp.w assexit
CODE_C49E90:						; from CODE_C49E73, CODE_C49EE6
	rtl
CODE_C49E91:						; from CODE_C49E15, CODE_C49E56
	lda.w SPA,x
	cmp.w #$1E48
	beq CODE_C49EF0
	cmp.w #$1EFA
	beq CODE_C49EF0
	phy
	ldy.w #$0000
	cpx.w #$000C
	bmi CODE_C49EAA
	ldy.w #$0002
CODE_C49EAA:						; from CODE_C49E91
	lda.w $12F3,y
	inc a
	sta.w $12F3,y
	ply
	lda.w #$0000
	sec
	sbc.w $066E
	sta.b d0
	lda.w pfgoal,x
	bne CODE_C49ECB
	lda.w #$FEF2
	sec
	sbc.w passtargety
	sta.b d1
	bra CODE_C49ED4
CODE_C49ECB:						; from CODE_C49EAA
	lda.w #$010E
	sec
	sbc.w passtargety
	sta.b d1
CODE_C49ED4:						; from CODE_C49EAA
	jsl.l vtoa
	jsl.l Findhittype
	beq CODE_C49EE3
	lda.w #$1EFA
	bra CODE_C49EE6
CODE_C49EE3:						; from CODE_C49ED4
	lda.w #$1E48
CODE_C49EE6:						; from CODE_C49ED4
	jsl.l SetSPAFromA
	jmp.w CODE_C49E90
CODE_C49EED:						; from CODE_C49EF0
	jmp.w CODE_C49E78
CODE_C49EF0:						; from CODE_C49E91
	lda.w #$000A
	sta.w nopuck,x
	lda.w SPAnum,x
	cmp.w #$0010
	bcs CODE_C49EED
	bit.w $0674
	bmi CODE_C49EED
	txa
	jsl.l CODE_C37FE2
	lda.w Xpos,x
	clc
	adc.b d0
	sec
	sbc.w $0830
	tay
	lda.w Ypos,x
	clc
	adc.b d1
	sec
	sbc.w pucky
	jsl.l ApproxLength
	cmp.w $0674
	sta.w $0674
	bcs CODE_C49F2C
	jmp.w CODE_C49FAF
CODE_C49F2C:						; from CODE_C49EF0
	lda.w Xpos,x
	sec
	sbc.w $0830
	tay
	lda.w Ypos,x
	sec
	sbc.w pucky
	jsl.l ApproxLength
	cmp.w #$001C
	bcs CODE_C49FAF
	lda.w #$FFFF
	sta.w $0674
	stz.w puckvx
	stz.w puckvy
	stz.w SPAcnt,x
	stx.w puckc
	ldy.w playerpad,x
	bmi CODE_C49F63
	lda.w paddir,y
	sta.w passdir
	bra CODE_C49F69
CODE_C49F63:						; from CODE_C49F2C
	lda.w #$0008
	sta.w passdir
CODE_C49F69:						; from CODE_C49F2C
	lda.w #$0024
	sta.w passspeed
	sta.w pfalock,x
	lda.w gmclock
	bne CODE_C49F8B
	phy
	ldy.w #$0000
	cpx.w #$000C
	bmi CODE_C49F83
	ldy.w #$0002
CODE_C49F83:						; from CODE_C49F69
	lda.w $12F7,y
	inc a
	sta.w $12F7,y
	ply
CODE_C49F8B:						; from CODE_C49F69
	lda.w #$0001
	sta.w onetimer
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi CODE_C49F9D
	sta.w CwdExciteLvl
CODE_C49F9D:						; from CODE_C49F8B
	pei ($6B)
	stx.b a2
	jsl.l a2touchpuck
	pla
	sta.b a2
	jsl.l doshot
	jmp.w CODE_C49E78
CODE_C49FAF:						; from CODE_C49EF0, CODE_C49F2C
	lda.w puckc
	bmi CODE_C49FBC
	cpx.w puckc
	beq CODE_C49FBC
	jmp.w CODE_C49E78
CODE_C49FBC:						; from CODE_C49FAF
	rtl

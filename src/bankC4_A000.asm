; Segment bankC4_A000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C49FBD
chk4pass:							; called from other segments
	lda.w $07EE
	bne CODE_C49FD2
	lda.w #$0010
	clc
	adc.w spodds,x
	jsl.l CODE_C37EAA
	cmp.w #$0009
	bcs CODE_C4A00B
CODE_C49FD2:						; from chk4pass
	lda.w #$0006
	jsl.l CODE_C37EAA
	sta.b d0
	cpx.w #$000C
	bcc CODE_C49FE6
	clc
	adc.w #$0006
	sta.b d0
CODE_C49FE6:						; from CODE_C49FD2
	lda.w position,x
	beq CODE_C4A005
	lda.w $0830
	cmp.w #$FFD7
	bmi CODE_C4A005
	cmp.w #$0029
	bpl CODE_C4A005
	lda.w pucky
	cmp.w #$FF2D
	bmi CODE_C4A00B
	cmp.w #$00D3
	bpl CODE_C4A00B
CODE_C4A005:						; from CODE_C49FE6
	asl.b d0
	cpx.b d0
	bne CODE_C4A00C
CODE_C4A00B:						; from chk4pass, CODE_C49FE6, CODE_C4A00C, CODE_C4A041
	rtl
CODE_C4A00C:						; from CODE_C4A005
	ldy.b d0
	sty.b a0
	lda.w position,y
	beq CODE_C4A00B
	bmi CODE_C4A00B
	lda.w pflags,y
	and.w #$1000
	ora.w pfalock,y
	bne CODE_C4A00B
	lda.w Ypos,y
	sta.b d0
	lda.w Ypos,x
	sta.b d1
	lda.w pfgoal,x
	bne CODE_C4A041
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
CODE_C4A041:						; from CODE_C4A00C
	lda.w gmode
	bit.w #$0020
	beq CODE_C4A05B
	lda.b d0
	sec
	sbc.w #$005C
	sta.b tmp0
	lda.b d1
	sec
	sbc.w #$005C
	eor.b tmp0
	bmi CODE_C4A00B
CODE_C4A05B:						; from CODE_C4A041
	lda.b d0
	cmp.w #$005C
	bpl CODE_C4A06E
	lda.b d0
	sec
	sbc.b d1
	sta.b d0
	cmp.w #$FFF1
	bmi CODE_C4A0C0
CODE_C4A06E:						; from CODE_C4A05B
	lda.w puckdir,y
	sec
	sbc.w #$0004
	and.w #$0007
	sta.w passdir
	lda.w $05E4,y
	sta.b d2
	lda.w #$0005
	sta.b d3
	ldy.w #$0000
	stz.b a1
	cpx.w #$000C
	bcs CODE_C4A092
	ldy.w #$000C
CODE_C4A092:						; from CODE_C4A06E, CODE_C4A0A8
	lda.b d2
	cmp.w $05E4,y
	bcc CODE_C4A0A8
	lda.w puckdir,y
	sec
	sbc.w #$0004
	and.w #$0007
	cmp.w passdir
	beq CODE_C4A0C0
CODE_C4A0A8:						; from CODE_C4A092
	iny
	iny
	dec.b d3
	bpl CODE_C4A092
	jsl.l dopass
	lda.w position,x
	beq CODE_C4A0C0
	pla
	sep #$20
	pla
	rep #$30
	jmp.w assexit
CODE_C4A0C0:						; from CODE_C4A05B, CODE_C4A092, CODE_C4A0A8
	rtl
CODE_C4A0C1:						; called from other segments
	lda.b d2
	bit.w #$8000
	bne dopass
	lda.b d0
	bit.w #$0008
	bne CODE_C4A0DC
	and.w #$0007
	sta.w passdir
	ora.w #$0008
	sta.b d0
	bra dopass
CODE_C4A0DC:						; from CODE_C4A0C1
	rtl
dopass:								; from CODE_C4A0C1, CODE_C4A0A8 and other segments
	stz.w onetimerreq
	lda.w #$0004
	trb.w sflags
	lda.w #$FFFF
	sta.w puckc
	lda.w #$0010
	sta.w nopuck,x
	txa
	lsr a
	sta.w lastplayer
	lda.w #$0007
	sta.b d0
	lda.w position,x
	beq CODE_C4A106
	lda.w passacc,x
	sta.b d0
CODE_C4A106:						; from dopass
	lda.b d0
	asl a
	asl a
	adc.w #$00C8
	cmp.w #$0100
	bcc CODE_C4A115
	lda.w #$00FF
CODE_C4A115:						; from CODE_C4A106
	sta.w passspeed
	lda.w #$FFFF
	sta.b d4
	lda.w #$0005
	sta.b d3
	stz.b a1
	cpx.w #$000C
	bcc CODE_C4A12E
	lda.w #$000C
	sta.b a1
CODE_C4A12E:						; from CODE_C4A115, CODE_C4A176
	cpx.b a1
	beq CODE_C4A176
	ldy.b a1
	lda.w position,y
	bmi CODE_C4A176
	beq CODE_C4A176
	lda.w pflags,y
	bit.w #$1000
	bne CODE_C4A176
	lda.w puckdir,y
	sec
	sbc.w passdir
	sec
	sbc.w #$0004
	stz.b r0
	and.w #$0007
	beq CODE_C4A164
	cmp.w #$0001
	beq CODE_C4A15F
	cmp.w #$0007
	bne CODE_C4A176
CODE_C4A15F:						; from CODE_C4A12E
	lda.w #$1000
	sta.b r0
CODE_C4A164:						; from CODE_C4A12E
	lda.b r0
	clc
	adc.w $05E4,y
	bcs CODE_C4A176
	cmp.b d4
	bcs CODE_C4A176
	sta.b d4
	lda.b a1
	sta.b a0
CODE_C4A176:						; from CODE_C4A12E, CODE_C4A164
	inc.b a1
	inc.b a1
	dec.b d3
	bmi CODE_C4A181
	jmp.w CODE_C4A12E
CODE_C4A181:						; from CODE_C4A176
	ldx.b a3
	lda.b d4
	bmi CODE_C4A195
	jsl.l dopass_count
	lda.w #$000B
	jsl.l CODE_CF040B
	jmp.w dopass_swing
CODE_C4A195:						; from CODE_C4A181
	lda.w passdir
	asl a
	asl a
	adc.w #$9C06
	sta.b a0
	lda.w #$00C0
	sta.b $65
	lda.b [a0]
	cmp.w #$8000
	ror a
	tax
	lda.w #$0050
	jsl.l Mul8XS
	asl a
	sta.b r3
	ldx.b curobj
	lda.w Yvel,x
	cmp.w #$8000
	ror a
	clc
	adc.b r3
	sta.w puckvy
	dec.b a0
	dec.b a0
	lda.b [a0]
	cmp.w #$8000
	ror a
	tax
	lda.w #$0050
	jsl.l Mul8XS
	asl a
	sta.b r3
	ldx.b curobj
	lda.w Xvel,x
	cmp.w #$8000
	ror a
	clc
	adc.b r3
	sta.w puckvx
	jsl.l RandomWord
	and.w #$0FFF
	sta.w puckvz
dopass_swing:						; from CODE_C4A181, CODE_C4A599
	lda.w position,x
	bne CODE_C4A20F
	lda.w pfgoal,x
	beq CODE_C4A203
	lda.w puckvy
	bmi CODE_C4A208
	bra CODE_C4A20F
CODE_C4A203:						; from dopass_swing
	lda.w puckvy
	bmi CODE_C4A20F
CODE_C4A208:						; from dopass_swing
	eor.w #$FFFF
	inc a
	sta.w puckvy
CODE_C4A20F:						; from dopass_swing, CODE_C4A203
	lda.w puckvx
	sta.b d0
	lda.w puckvy
	sta.b d1
	jsl.l vtoa
	ldy.w #$144E
	lda.w position,x
	beq CODE_C4A231
	ldy.w #$1B40
	jsl.l Findhittype
	beq CODE_C4A231
	ldy.w #$1BB2
CODE_C4A231:						; from CODE_C4A20F
	sty.b d1
	jsl.l SetSPA
	lda.w #$0001
	sta.w pfalock,x
	lda.w position,x
	bne CODE_C4A253
	lda.w playerpad,x
	bmi CODE_C4A253
	stz.w Xvel,x
	stz.w Yvel,x
	sta.b d4
	jsl.l findpc
CODE_C4A253:						; from CODE_C4A231
	rtl
dopass_count:						; from CODE_C4A181 and other segments
	jsl.l loadTeamStruct
	lda.w gmclock
	bne CODE_C4A266
	ldy.b a2
	lda.w $12DF,y
	inc a
	sta.w $12DF,y
CODE_C4A266:						; from dopass_count
	ldx.w $0664,y
	lda.w aidef,x
	lsr a
	clc
	adc.w #$0001
	adc.w temp1,x
	sta.w temp1,x
	lda.b a0
	sta.w passReceiverPlayerNum
	ldx.b a0
	lda.w #$0015
	sta.b d0
	jsl.l CODE_C43734
	ldx.b a3
	ldy.b a0
	lda.w frame,y
	pha
	lda.w attribute,y
	bit.w #$0800
	beq CODE_C4A2A0
	lda.w #$0000
	sec
	sbc.w facedir,y
	bra CODE_C4A2A3
CODE_C4A2A0:						; from CODE_C4A266
	lda.w facedir,y
CODE_C4A2A3:						; from CODE_C4A266
	and.w #$0007
	asl a
	tax
	lda.l DATA8_C41E48,x
	tax
	lda.l $C40000,x
	ldx.b a3
	ldy.b a0
	sta.w frame,y
	lda.b a0
	jsl.l CODE_C37FE2
	ldy.b a0
	pla
	sta.w frame,y
	lda.b d1
	clc
	adc.w Ypos,y
	sec
	sbc.w pucky
	sta.b d1
	lda.b d0
	clc
	adc.w Xpos,y
	sec
	sbc.w $0830
	sta.b d0
	lda.w #$0018
	sta.b d6
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldy.b a0
	ldx.w Xvel,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b d0
	sta.b d2
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldx.w Yvel,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b d1
	sta.b d3
	ldy.b d2
	jsl.l ApproxLength
	sta.b d4
	asl a
	tax
	lda.w #$0003
	jsl.l DivX8U
	cmp.w #$0040
	bcc CODE_C4A336
	cmp.w #$0050
	bcc CODE_C4A373
	ldx.b d4
	lda.w #$0005
	jsl.l DivX8U
	sta.b d6
	lda.w #$0050
	bra CODE_C4A33F
CODE_C4A336:						; from CODE_C4A2A3
	lda.b d4
	lsr a
	lsr a
	sta.b d6
	lda.w #$0040
CODE_C4A33F:						; from CODE_C4A2A3
	pha
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldy.b a0
	ldx.w Xvel,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b d0
	sta.b d2
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldx.w Yvel,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b d1
	sta.b d3
	ldy.b d2
	jsl.l ApproxLength
	sta.b d4
	pla
CODE_C4A373:						; from CODE_C4A2A3
	sta.b d5
	sta.w passspeed
	ldx.b curobj
	lda.w #$0010
	sec
	sbc.w passacc,x
	jsl.l randomd0s
	clc
	adc.b d5
	sta.b d5
	ldx.b d2
	jsl.l Mul16x8XS
	lda.b d4
	sta.b r1
	jsl.l Div32S
	lda.b r0
	xba
	and.w #$FF00
	sta.w puckvx
	lda.b d5
	ldx.b d3
	jsl.l Mul16x8XS
	lda.b d4
	sta.b r1
	jsl.l Div32S
	lda.b r0
	xba
	and.w #$FF00
	sta.w puckvy
	lda.b d2
	clc
	adc.w $0830
	sta.w $066E
	lda.b d3
	clc
	adc.w pucky
	sta.w passtargety
	lda.b d4
	asl a
	asl a
	asl a
	sta.w puckvz
	lda.w #$000A
	sta.w $0CFC
	ldy.b a0
	lda.b d6
	clc
	adc.w #$0006
	sta.w $0676,y
	ldx.b curobj
	lda.b d6
	sta.w nopuck,x
	ldy.b a2
	lda.w playerpad,x
	sta.w $05C8,y
	lda.w position,x
	bne CODE_C4A41B
	lda.w playerpad,x
	bmi CODE_C4A41B
	stz.w Xvel,x
	stz.w Yvel,x
	lda.w playerpad,x
	sta.b d4
	lda.w passReceiverPlayerNum
	sta.b d0
	jsl.l CODE_C5376A
	lda.w playerpad,x
	bmi CODE_C4A41B
	jsl.l findpc
CODE_C4A41B:						; from CODE_C4A373
	rtl
DumpInTarget:						; from assdumpin and other segments
	stx.w $066A
	lda.w position,x
	beq CODE_C4A493
	lda.w pfgoal,x
	bne CODE_C4A45E
	lda.w Ypos,x
	cmp.w #$FFA4
	bmi CODE_C4A44A
	lda.w #$0004
	sta.w passdir
	lda.w Xpos,x
	bmi CODE_C4A443
	lda.w #$000A
	sta.w dumpintarget
	rtl
CODE_C4A443:						; from DumpInTarget
	lda.w #$0006
	sta.w dumpintarget
	rtl
CODE_C4A44A:						; from DumpInTarget
	lda.w $063E
	sec
	sbc.w #$0004
	and.w #$0007
	sta.w passdir
	lda.w #$0008
	sta.w dumpintarget
	rtl
CODE_C4A45E:						; from DumpInTarget
	lda.w Ypos,x
	cmp.w #$005C
	bpl CODE_C4A47F
	lda.w #$0000
	sta.w passdir
	lda.w Xpos,x
	bmi CODE_C4A478
	lda.w #$0016
	sta.w dumpintarget
	rtl
CODE_C4A478:						; from CODE_C4A45E
	lda.w #$0012
	sta.w dumpintarget
	rtl
CODE_C4A47F:						; from CODE_C4A45E
	lda.w $063C
	sec
	sbc.w #$0004
	and.w #$0007
	sta.w passdir
	lda.w #$0014
	sta.w dumpintarget
	rtl
CODE_C4A493:						; from DumpInTarget
	stz.w dumpintarget
	stz.w passdir
	lda.w pfgoal,x
	bne CODE_C4A4AA
	lda.w #$000C
	sta.w dumpintarget
	lda.w #$0004
	sta.w passdir
CODE_C4A4AA:						; from CODE_C4A493
	rtl
CODE_C4A4AB:						; called from other segments
	lda.w #$0014
	sta.b d0
	jmp.w assreplace
assdumpin:							; called from other segments
	cpx.w puckc
	bne CODE_C4A4E3
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C4A4E6
	jsl.l DumpInTarget
	lda.w pflags,x
	and.w #$FFFD
	sta.w pflags,x
	lda.w playerpad,x
	bpl CODE_C4A4E6
	lda.w dumpintarget
	cmp.w #$0014
	beq CODE_C4A4E0
	cmp.w #$0008
	beq CODE_C4A4E0
	rtl
CODE_C4A4E0:						; from assdumpin
	jmp.w CompShoot
CODE_C4A4E3:						; from assdumpin
	jmp.w assexit
CODE_C4A4E6:						; from assdumpin
	ldy.w #$0000
	lda.w passdir
	cmp.w facedir,x
	beq CODE_C4A510
	iny
	dec a
	and.w #$0007
	cmp.w facedir,x
	beq CODE_C4A510
	iny
	inc a
	inc a
	and.w #$0007
	cmp.w facedir,x
	beq CODE_C4A510
	lda.w passdir
	sta.b d0
	jsl.l AdjustFacingDirection
	rtl
CODE_C4A510:						; from CODE_C4A4E6
	lda.w position,x
	bne CODE_C4A523
	tya
	asl a
	adc.w dumpintarget
	sta.w dumpintarget
	lda.w facedir,x
	sta.w passdir
CODE_C4A523:						; from CODE_C4A510
	jsl.l CODE_C4A52A
	jmp.w assexit
CODE_C4A52A:						; from CODE_C4A523 and other segments
	txy
	lda.w #$000F
	sec
	sbc.w passacc,y
	asl a
	sta.b d4
	ldx.w dumpintarget
	lda.l DATA8_C4A5FD,x
	clc
	adc.b d4
	jsl.l randomd0s
	clc
	adc.l DATA8_C4A62D,x
	sec
	sbc.w $0830
	sta.b d0
	lda.l DATA8_C4A615,x
	clc
	adc.b d4
	jsl.l randomd0s
	clc
	adc.l DATA8_C4A645,x
	sec
	sbc.w pucky
	sta.b d1
	ldy.b d0
	jsl.l ApproxLength
	sta.b d2
	asl a
	asl a
	asl a
	asl a
	tax
	lda.w #$0078
	jsl.l DivX8U
	cmp.w #$0061
	bcc CODE_C4A580
	lda.w #$0060
CODE_C4A580:						; from CODE_C4A52A
	ldx.b curobj
	ldy.w position,x
	beq CODE_C4A591
	cmp.w #$0010
	bcs CODE_C4A58F
	lda.w #$0010
CODE_C4A58F:						; from CODE_C4A580
	bra CODE_C4A599
CODE_C4A591:						; from CODE_C4A580
	cmp.w #$0020
	bcs CODE_C4A599
	lda.w #$0020
CODE_C4A599:						; from CODE_C4A58F, CODE_C4A591
	sta.b d3
	ldx.b d0
	jsl.l Mul16x8XS
	lda.b d2
	sta.b r1
	jsl.l Div32S
	lda.b r0
	xba
	and.w #$FF00
	sta.w puckvx
	lda.b d3
	ldx.b d1
	jsl.l Mul16x8XS
	lda.b d2
	sta.b r1
	jsl.l Div32S
	lda.b r0
	xba
	and.w #$FF00
	sta.w puckvy
	asl a
	asl a
	asl a
	asl a
	lda.w #$03C0
	sec
	sbc.b d4
	jsl.l randomd0A
	clc
	adc.w #$10E0
	sta.w puckvz
	jsl.l puckflip
	ldx.b curobj
	lda.w #$FFFF
	sta.w $066A
	sta.w puckc
	lda.w #$001E
	sta.w nopuck,x
	txa
	lsr a
	sta.w lastplayer
	jmp.w dopass_swing
DATA8_C4A5FD:						; not traced: a table read by CODE_C4A52A
	db $19,$00,$19,$00,$19,$00,$19,$00,$14,$00,$19,$00,$19,$00,$19,$00
	db $19,$00,$19,$00,$14,$00,$19,$00
DATA8_C4A615:						; not traced: a table read by CODE_C4A52A
	db $14,$00,$19,$00,$19,$00,$46,$00,$14,$00,$46,$00,$14,$00,$19,$00
	db $19,$00,$46,$00,$14,$00,$46,$00
DATA8_C4A62D:						; not traced: a table read by CODE_C4A52A
	db $00,$00,$B0,$FF,$50,$00,$B0,$FF,$00,$00,$50,$00,$00,$00,$50,$00
	db $B0,$FF,$B0,$FF,$00,$00,$50,$00
DATA8_C4A645:						; not traced: a table read by CODE_C4A52A
	db $97,$FF,$8D,$FF,$8D,$FF,$4C,$FF,$29,$FF,$4C,$FF,$69,$00,$73,$00
	db $73,$00,$B4,$00,$D7,$00,$B4,$00
CODE_C4A65D:						; called from other segments
	lda.w $0874
	cmp.w $0894
	beq CODE_C4A680
	phx
CODE_C4A666:						; from CODE_C4A666
	ldx.w TransfersReady
	bne CODE_C4A666
	ldx.w #$2580
	stx.b tmp2
	ldx.w #$2035
	stx.b tmp1
	sta.w $0894
	jsl.l CODE_C5F368
	plx
	lda.w $0874
CODE_C4A680:						; from CODE_C4A65D
	cmp.w #$01B3
	bne CODE_C4A693
	lda.w $0830
	sta.w $0832
	lda.w pucky
	inc a
	sta.w $08B4
	rtl
CODE_C4A693:						; from CODE_C4A680
	tay
	beq CODE_C4A6B0
	lda.w #$0030
	sta.w $0832
	lda.w #$0133
	bit.w pucky
	bpl CODE_C4A6AD
	lda.w #$8000
	sta.w $08FE
	lda.w #$FEAF
CODE_C4A6AD:						; from CODE_C4A693
	sta.w $08B4
CODE_C4A6B0:						; from CODE_C4A693
	rtl
puckbody:							; called from other segments
	lda.w puckz
	cmp.w #$0008
	bpl CODE_C4A6C3
	lda.b d0
	and.w #$000F
	beq CODE_C4A6C3
	jmp.w puckstick
CODE_C4A6C3:						; from puckbody
	jsl.l a2touchpuck
	lda.w puckvx
	ldy.w puckvy
	jsl.l ApproxLength
	and.w #$7F00
	sta.b tmp0
	xba
	tsb.b tmp0
	ldy.w puckz
	cmp.w #$000E
	bmi CODE_C4A6E6
	lda.w #$000D
	bra CODE_C4A6E9
CODE_C4A6E6:						; from CODE_C4A6C3
	lda.w #$0011
CODE_C4A6E9:						; from CODE_C4A6C3
	jsl.l CODE_CF0418
	stz.w puckvz
	ldy.b a2
	lda.w #$0008
	sta.w nopuck,y
	lda.w Xpos,x
	sec
	sbc.w Xpos,y
	sta.b d0
	lda.w Ypos,x
	sec
	sbc.w Ypos,y
	sta.b d1
	bne CODE_C4A711
	tya
	jsl.l CODE_C37FE2
CODE_C4A711:						; from CODE_C4A6E9
	lda.w Xvel,x
	sta.b d2
	lda.w Yvel,x
	sta.b d3
	sep #$20
	lda.b d0
	sta.w $09A1,x
	lda.b d1
	sta.w $09C1,x
	rep #$30
	jsl.l puckflip
	lda.w puckz
	cmp.w #$0008
	bmi CODE_C4A76A
	lda.b d2
	tax
	jsl.l Mul16S
	lda.b $36
	sta.b $89
	lda.b r2
	sta.b d2
	lda.b d3
	tax
	jsl.l Mul16S
	ldx.b a3
	lda.b r2
	clc
	adc.b d2
	sta.b d2
	lda.b $36
	adc.b $89
	sta.b $89
	cmp.w #$0900
	bcc CODE_C4A76B
	lda.w puckz
	cmp.w #$000C
	bmi CODE_C4A76A
	jmp.w CODE_C44F20
CODE_C4A76A:						; from CODE_C4A711, CODE_C4A76B
	rtl
CODE_C4A76B:						; from CODE_C4A711
	ldy.b a2
	lda.w pfalock,y
	bne CODE_C4A76A
	inc a
	sta.w pf2aip,y
	lda.w #$26B6
	ldx.b a2
	jsl.l SetSPAFromA
	ldx.b a3
	rtl
puckgoalie:							; called from other segments
	lda.w gmode
	bit.w #$0010
	beq CODE_C4A78D
	jmp.w CODE_C4A91E
CODE_C4A78D:						; from puckgoalie
	stz.b d2
	lda.w puckz
	cmp.w #$0008
	bpl CODE_C4A79B
	inc.b d2
	inc.b d2
CODE_C4A79B:						; from CODE_C4A78D
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
	jsl.l vtoa
	ldy.b a2
	lda.b d0
	sec
	sbc.w facedir,y
	and.w #$0007
	sta.b d0
	and.w #$0003
	sta.b d1
	bne CODE_C4A7C8
	lda.w seed
	sta.b d0
CODE_C4A7C8:						; from CODE_C4A79B
	lda.b d0
	and.w #$0004
	lsr a
	lsr a
	eor.w #$0001
	clc
	adc.b d2
	asl a
	sta.b d2
	lda.w $0F60,y
	sta.b d1
	lda.b d2
	beq CODE_C4A7FE
	lda.w passacc,y
	sta.b d1
	lda.b d2
	cmp.w #$0002
	beq CODE_C4A7FE
	lda.w spodds,y
	sta.b d1
	lda.b d2
	cmp.w #$0004
	beq CODE_C4A7FE
	lda.w $0F40,y
	sta.b d1
CODE_C4A7FE:						; from CODE_C4A7C8
	lda.b d1
	clc
	adc.w #$000F
	sta.b d1
	lda.w attribute,y
	bit.w #$0800
	beq CODE_C4A815
	lda.b d2
	eor.w #$0002
	sta.b d2
CODE_C4A815:						; from CODE_C4A7FE
	lda.w frame,y
	sec
	sbc.w #$0286
	cmp.w #$0018
	bcs CODE_C4A82C
	lda.w puckz
	cmp.w #$0005
	bmi CODE_C4A82C
	jmp.w CODE_C4A91E
CODE_C4A82C:						; from CODE_C4A815
	jsl.l ChkShotStat
	jsl.l a2touchpuck
	lda.w puckvy
	bit.w #$8000
	beq CODE_C4A840
	eor.w #$FFFF
	inc a
CODE_C4A840:						; from CODE_C4A82C
	and.w #$7F00
	sta.b tmp0
	xba
	tsb.b tmp0
	lda.w #$0011
	jsl.l CODE_CF0418
	lda.w puckvy
	cmp.w #$3000
	bpl CODE_C4A85C
	cmp.w #$D000
	bpl CODE_C4A889
CODE_C4A85C:						; from CODE_C4A840
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi CODE_C4A868
	sta.w CwdExciteLvl
CODE_C4A868:						; from CODE_C4A85C
	ldy.b a2
	lda.w pfteam,y
	beq CODE_C4A878
	lda.w #$000A
	jsl.l CODE_CF040B
	bra CODE_C4A889
CODE_C4A878:						; from CODE_C4A868
	lda.l $7E24CA
	clc
	adc.w #$0258
	sta.l $7E24CA
	lda.w #$003C
	sta.b crowdhold
CODE_C4A889:						; from CODE_C4A840, CODE_C4A868
	lda.w puckc
	bmi CODE_C4A88F
	lsr a
CODE_C4A88F:						; from CODE_C4A889
	sta.b d2
	bpl CODE_C4A896
	jmp.w CODE_C4A922
CODE_C4A896:						; from CODE_C4A88F
	cpx.w puckc
	bne CODE_C4A89E
	jmp.w CODE_C4A922
CODE_C4A89E:						; from CODE_C4A896
	lda.w #$FF00
	tsb.w puckc
	asl.b d2
	lda.b d2
	sta.b a0
	tay
	lda.w #$0014
	sta.w nopuck,y
	tya
	lsr a
	sta.w lastplayer
	lda.w #$000C
	trb.w sflags
CODE_C4A8BC:						; from CODE_C4A91F
	stz.w puckvz
	ldy.b a2
	lda.w #$000A
	sta.w nopuck,y
	lda.w #$0004
	sta.w temp4,y
	lda.w Xpos,x
	sec
	sbc.w Xpos,y
	sta.b d0
	lda.w Ypos,x
	sec
	sbc.w Ypos,y
	sta.b d1
	bne CODE_C4A8E7
	lda.b a2
	jsl.l CODE_C37FE2
CODE_C4A8E7:						; from CODE_C4A8BC
	lda.b d1
	and.w #$00FF
	bit.w #$0080
	beq CODE_C4A8F4
	ora.w #$FF00
CODE_C4A8F4:						; from CODE_C4A8E7
	sta.b d1
	lda.b d1
	beq CODE_C4A8FC
	inc.b d1
CODE_C4A8FC:						; from CODE_C4A8F4
	ldy.b a2
	lda.w Yvel,y
	eor.b d1
	bmi CODE_C4A90D
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
CODE_C4A90D:						; from CODE_C4A8FC
	sep #$20
	lda.b d0
	sta.w $09A1,x
	lda.b d1
	sta.w $09C1,x
	rep #$20
	jmp.w puckflip
CODE_C4A91E:						; from puckgoalie, CODE_C4A815
	rtl
CODE_C4A91F:						; from CODE_C4A922
	jmp.w CODE_C4A8BC
CODE_C4A922:						; from CODE_C4A88F, CODE_C4A896
	lda.w #$0002
	clc
	adc.w $0E80,y
	xba
	and.w #$FF00
	asl a
	jsl.l randomd0A
	adc.w #$2000
	sta.b d0
	cmp.w puckvx
	bmi CODE_C4A91F
	lda.b d0
	cmp.w puckvy
	bmi CODE_C4A91F
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	cmp.w puckvx
	bpl CODE_C4A91F
	lda.b d0
	cmp.w puckvy
	bpl CODE_C4A91F
	ldy.b a2
	lda.w pflags,y
	bit.w #$1000
	bne CODE_C4A91F
	stz.w puckvz
	jmp.w CODE_C44E0A
ChkShotStat:						; from CODE_C4A82C, CODE_C4AAA3 and other segments
	lda.w #$1000
	trb.w sflags
	bne CODE_C4A972
	jmp.w CODE_C4AA64
CODE_C4A972:						; from ChkShotStat
	lda.w gmclock
	beq CODE_C4A97A
	jmp.w CODE_C4AA64
CODE_C4A97A:						; from CODE_C4A972
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	pei ($7F)
	pei ($81)
	phx
	ldx.w $07EA
	stx.b a3
	stz.b a2
	lda.w #$0002
	sta.b a1
	txa
	cmp.w #$000C
	bmi CODE_C4A9A4
	lda.w #$0002
	sta.b a2
	stz.b a1
CODE_C4A9A4:						; from CODE_C4A97A
	ldy.w #$1297
	lda.w pfteam,x
	beq CODE_C4A9AE
	iny
	iny
CODE_C4A9AE:						; from CODE_C4A9A4
	lda.w $0000,y
	inc a
	sta.w $0000,y
	ldy.b a2
	bne CODE_C4A9D6
	lda.w tmap
	sec
	sbc.w $12C9
	beq CODE_C4A9F1
	bmi CODE_C4A9CD
	lda.w tmPPShots
	inc a
	sta.w tmPPShots
	bra CODE_C4A9F1
CODE_C4A9CD:						; from CODE_C4A9AE
	lda.w tmSHShots
	inc a
	sta.w tmSHShots
	bra CODE_C4A9F1
CODE_C4A9D6:						; from CODE_C4A9AE
	lda.w $12C9
	sec
	sbc.w tmap
	beq CODE_C4A9F1
	bmi CODE_C4A9EA
	lda.w $1279
	inc a
	sta.w $1279
	bra CODE_C4A9F1
CODE_C4A9EA:						; from CODE_C4A9D6
	lda.w $127D
	inc a
	sta.w $127D
CODE_C4A9F1:						; from CODE_C4A9AE, CODE_C4A9D6, CODE_C4A9CD
	lda.w gsp
	asl a
	asl a
	tax
	lda.b a2
	beq CODE_C4A9FD
	inx
	inx
CODE_C4A9FD:						; from CODE_C4A9F1
	lda.w $1287,x
	inc a
	sta.w $1287,x
	ldx.b a3
	lda.w pnum,x
	sta.b d0
	lda.b a2
	beq CODE_C4AA12
	lda.w #$001A
CODE_C4AA12:						; from CODE_C4A9FD
	clc
	adc.b d0
	ldx.b a2
	cmp.w tmgoalie,x
	beq CODE_C4AA24
	tax
	sep #$20
	inc.w $147B,x
	rep #$20
CODE_C4AA24:						; from CODE_C4AA12
	ldx.b a1
	lda.w tmgoalie,x
	sta.b d0
	bmi CODE_C4AA3F
	lda.b a1
	beq CODE_C4AA34
	lda.w #$001A
CODE_C4AA34:						; from CODE_C4AA24
	clc
	adc.b d0
	tax
	sep #$20
	inc.w $147B,x
	rep #$20
CODE_C4AA3F:						; from CODE_C4AA24
	plx
	pla
	sta.b $81
	pla
	sta.b d0
	pla
	sta.b $71
	pla
	sta.b a3
	pla
	sta.b $6D
	pla
	sta.b a2
	pla
	sta.b $69
	pla
	sta.b a1
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi CODE_C4AA64
	sta.w CwdExciteLvl
CODE_C4AA64:						; from ChkShotStat, CODE_C4A972, CODE_C4AA3F
	rtl
Goal:								; called from other segments
	lda.w gmclock
	beq CODE_C4AA74
	stz.w puckvz
	stz.w puckvx
	stz.w puckvy
	rtl
CODE_C4AA74:						; from Goal
	lda.w PenShotActive
	beq CODE_C4AAA3
	lda.w pucky
	bpl CODE_C4AA88
	lda.w gmode
	bit.w #$0002
	beq CODE_C4AA9E
	bra CODE_C4AA92
CODE_C4AA88:						; from CODE_C4AA74
	lda.w gmode
	bit.w #$0002
	beq CODE_C4AA92
	bra CODE_C4AA9E
CODE_C4AA92:						; from CODE_C4AA74, CODE_C4AA88
	lda.w BA_Team
	beq CODE_C4AAA3
CODE_C4AA97:						; from CODE_C4AA9E
	jsl.l EndPenaltyShot
	jmp.w CODE_C4AD25
CODE_C4AA9E:						; from CODE_C4AA74, CODE_C4AA88
	lda.w BA_Team
	beq CODE_C4AA97
CODE_C4AAA3:						; from CODE_C4AA74, CODE_C4AA92
	jsl.l ChkShotStat
	jsl.l freezewindow
	lda.w #$001E
	sta.w replaydelay
	stz.b a2
	lda.w #$0002
	sta.b a1
	lda.w pucky
	bpl CODE_C4AAC4
	stz.b a1
	lda.w #$0002
	sta.b a2
CODE_C4AAC4:						; from CODE_C4AAA3
	lda.w gmode
	bit.w #$0002
	beq CODE_C4AAD5
	lda.b a1
	sta.b a2
	eor.w #$0002
	sta.b a1
CODE_C4AAD5:						; from CODE_C4AAC4
	ldy.b a2
	lda.w tmscore,y
	inc a
	sta.w tmscore,y
	lda.w tmap
	sec
	sbc.w $12C9
	beq CODE_C4AAFA
	bmi CODE_C4AAEF
	ldy.b a2
	beq CODE_C4AAFA
	bra CODE_C4AAF3
CODE_C4AAEF:						; from CODE_C4AAD5
	ldy.b a2
	bne CODE_C4AAFA
CODE_C4AAF3:						; from CODE_C4AAD5
	lda.w $127F,y
	inc a
	sta.w $127F,y
CODE_C4AAFA:						; from CODE_C4AAD5, CODE_C4AAEF
	lda.w penshot
	bne CODE_C4AB0F
	lda.w breakaway
	beq CODE_C4AB18
	ldy.b a2
	lda.w $12E7,y
	inc a
	sta.w $12E7,y
	bra CODE_C4AB18
CODE_C4AB0F:						; from CODE_C4AAFA
	ldy.b a2
	lda.w $12EF,y
	inc a
	sta.w $12EF,y
CODE_C4AB18:						; from CODE_C4AAFA
	lda.w onetimer
	beq CODE_C4AB26
	ldy.b a2
	lda.w $12FB,y
	inc a
	sta.w $12FB,y
CODE_C4AB26:						; from CODE_C4AB18
	lda.w #$0009
	jsl.l CODE_CF00E3
	lda.w #$00A2
	jsl.l CODE_CF040B
	stz.w $06EC
	ldy.b a2
	beq CODE_C4AB55
	lda.w #$0004
	jsl.l CODE_C382B6
	lda.l $7E24CA
	sec
	sbc.w #$0300
	bpl CODE_C4AB4F
	lda.w #$0000
CODE_C4AB4F:						; from CODE_C4AB26
	sta.l $7E24CA
	bra CODE_C4AB73
CODE_C4AB55:						; from CODE_C4AB26
	inc a
	inc a
	jsl.l CODE_C382B6
	lda.l $7E24CA
	clc
	adc.w #$01F4
	sta.l $7E24CA
	lda.w #$0078
	sta.b crowdhold
	lda.w #$0003
	jsl.l CODE_CF0485
CODE_C4AB73:						; from CODE_C4AB4F
	lda.b Vcount
	sta.w $07EC
	jsl.l EndPenaltyShot
	stz.w breakaway
	stz.w onetimer
	phx
	lda.w gsp
	asl a
	asl a
	tax
	lda.w CwdExciteLvl
	clc
	adc.w #$001E
	bmi CODE_C4AB95
	sta.w CwdExciteLvl
CODE_C4AB95:						; from CODE_C4AB73
	lda.b a2
	beq CODE_C4ABA7
	inx
	inx
	lda.w CwdExciteLvl
	clc
	adc.w #$FFCE
	bmi CODE_C4ABA7
	sta.w CwdExciteLvl
CODE_C4ABA7:						; from CODE_C4AB95
	lda.w $129B,x
	inc a
	sta.w $129B,x
	plx
	lda.w $2038
	cmp.w #$0258
	bne CODE_C4ABBE
	sec
	sbc.w #$0006
	sta.w $2038
CODE_C4ABBE:						; from CODE_C4ABA7
	lda.w #$007E
	sta.b $65
	lda.w #$203A
	clc
	adc.w $2038
	sta.b a0
	lda.w $2038
	adc.w #$0006
	sta.w $2038
	jsl.l GetPeriodTimeRemaining
	lda.b d0
	sta.b [a0]
	inc.b a0
	inc.b a0
	lda.w #$0002
	clc
	ldy.b a2
	adc.w tmap,y
	ldy.b a1
	sec
	sbc.w tmap,y
	ldy.b a2
	beq CODE_C4ABF7
	ora.w #$0080
CODE_C4ABF7:						; from CODE_C4ABBE
	sta.b [a0]
	inc.b a0
	lda.w tmtouch1,y
	sta.b d0
	sta.b [a0]
	inc.b a0
	lda.w #$FFFF
	sta.b [a0]
	ldx.b a2
	lda.w tmgoalie,x
	cmp.b d0
	beq CODE_C4AC24
	lda.b a2
	beq CODE_C4AC19
	lda.w #$001A
CODE_C4AC19:						; from CODE_C4ABF7
	clc
	adc.b d0
	tax
	sep #$20
	inc.w $1413,x
	rep #$20
CODE_C4AC24:						; from CODE_C4ABF7
	ldy.b a2
	lda.w tmtouch2,y
	sta.b d0
	bmi CODE_C4AC66
	sep #$20
	sta.b [a0]
	rep #$20
	lda.b a2
	beq CODE_C4AC3A
	lda.w #$001A
CODE_C4AC3A:						; from CODE_C4AC24
	clc
	adc.b d0
	tax
	sep #$20
	inc.w $1447,x
	rep #$20
	inc.b a0
	lda.w tmtouch3,y
	sta.b d0
	bmi CODE_C4AC66
	sep #$20
	sta.b [a0]
	rep #$20
	lda.b a2
	beq CODE_C4AC5B
	lda.w #$001A
CODE_C4AC5B:						; from CODE_C4AC3A
	clc
	adc.b d0
	tax
	sep #$20
	inc.w $1447,x
	rep #$20
CODE_C4AC66:						; from CODE_C4AC24, CODE_C4AC3A
	ldy.b a1
	lda.w tmgoalie,y
	sta.b d0
	bmi CODE_C4AC7D
	lda.b a1
	beq CODE_C4AC76
	lda.w #$001A
CODE_C4AC76:						; from CODE_C4AC66
	clc
	adc.b d0
	tax
	inc.w $1413,x
CODE_C4AC7D:						; from CODE_C4AC66
	jsl.l PenGoalStuff
	jsl.l CODE_C539D7
	ldx.b a3
	lda.w #$0008
	sta.b d0
	jsl.l CODE_C4AD04
	lda.b a2
	bne CODE_C4ACA2
	lda.w $12AD
	sec
	sbc.w tmscore
	bmi CODE_C4ACA2
	cmp.w #$0003
	bcs CODE_C4ACA2
CODE_C4ACA2:						; from CODE_C4AC7D
	stz.w collflag
	stz.w puckvx
	stz.w puckvy
	ldy.w #$0006
	lda.w $0830
	bpl CODE_C4ACB6
	ldy.w #$FFFA
CODE_C4ACB6:						; from CODE_C4ACA2
	sty.w $0830
	ldy.w #$0116
	lda.w pucky
	bpl CODE_C4ACC4
	ldy.w #$FEEA
CODE_C4ACC4:						; from CODE_C4ACB6
	sty.w pucky
	lda.w #$0600
	sta.w puckvz
	stz.w puckz
	lda.w #$FFFF
	sta.w $07DA
	sta.w $07DE
	sta.w $109C
	lda.w #$001A
	sta.b d0
	jsl.l assreplace
	inx
	inx
	lda.w #$253E
	jsl.l SetSPAFromA
	ldy.b a2
	ldx.w tmsort,y
	stx.b a3
	lda.w #$000E
	sta.b d0
	jsl.l AddPenalty2
	ldx.w #$001C
	stx.b a3
	rtl
CODE_C4AD04:						; from CODE_C4AC7D and other segments
	phx
	ldy.b a2
	lda.w tmsort,y
	tax
	lda.w #$0005
	sta.b d3
CODE_C4AD10:						; from CODE_C4AD1E
	lda.w position,x
	bmi CODE_C4AD1E
	beq CODE_C4AD1E
	stz.w pfnc,x
	jsl.l CODE_C43734
CODE_C4AD1E:						; from CODE_C4AD10
	inx
	inx
	dec.b d3
	bpl CODE_C4AD10
	plx
CODE_C4AD25:						; from CODE_C4AA97
	rtl
puckstick:							; from puckbody and other segments
	ldy.b a2
	lda.w position,y
	bne CODE_C4AD36
	lda.w gmode
	bit.w #$0010
	beq CODE_C4AD36
CODE_C4AD35:						; from CODE_C4AD47
	rtl
CODE_C4AD36:						; from puckstick
	lda.w pflags,y
	and.w #$FFFE
	sta.w pflags,y
	ldy.w puckc
	bpl CODE_C4AD47
	jmp.w CODE_C4ADE5
CODE_C4AD47:						; from CODE_C4AD36
	lda.w pfteam,y
	ldy.b a2
	cmp.w pfteam,y
	beq CODE_C4AD35
	lda.b d0
	cmp.w #$0025
	bcs CODE_C4AD35
	lda.w position,y
	beq CODE_C4AD97
	ldy.b a0
	lda.w position,y
	beq CODE_C4AD35
	lda.w stickhand,y
	jsl.l makepde
	pei ($7F)
	lda.b a0
	ldy.b a2
	sty.b a0
	sta.b a2
	lda.w stickhand,y
	sta.b d0
	jsl.l makepde
	lda.b a0
	ldy.b a2
	sty.b a0
	sta.b a2
	pla
	sec
	sbc.b d0
	clc
	adc.w #$0024
	jsl.l randomd0A
	cmp.w #$0003
	bcs CODE_C4AD35
CODE_C4AD97:						; from CODE_C4AD47
	ldy.b a0
	lda.w stickhand,y
	jsl.l makepde
	lda.b d0
	adc.w #$0014
	ldy.b a0
	sta.w nopuck,y
	lda.b a0
	ldy.b a2
	sty.b a0
	sta.b a2
	lda.w stickhand,y
	jsl.l makepde
	lda.b d0
	adc.w #$0014
	ldy.b a0
	sta.w nopuck,y
	lda.b a0
	ldy.b a2
	sty.b a0
	sta.b a2
	tya
	lsr a
	sta.w lastplayer
	lda.w #$000C
	trb.w sflags
CODE_C4ADD6:						; from CODE_C4AE5F
	lda.w #$000D
	jsl.l CODE_CF040B
	jsl.l a2touchpuck
	jmp.w deflect
CODE_C4ADE4:						; from CODE_C4AE3F
	rtl
CODE_C4ADE5:						; from CODE_C4AD36
	lda.b d0
	sta.b d2
	lda.w puckvx
	phx
	tax
	jsl.l Mul16S
	lda.b $36
	sta.b $81
	lda.b r2
	sta.b d0
	lda.w puckvy
	tax
	jsl.l Mul16S
	plx
	lda.b r2
	clc
	adc.b d0
	sta.b d0
	lda.b $36
	adc.b $81
	sta.b $81
	stz.b d1
	lda.w sflags
	bit.w #$1000
	bne CODE_C4AE2C
	ldy.b a2
	lda.w stickhand,y
	phx
	ldx.w #$02BC
	jsl.l Mul16x8U
	lda.b r2
	sta.b d1
	plx
CODE_C4AE2C:						; from CODE_C4ADE5
	lda.b d1
	clc
	adc.w #$2710
	ldy.w position,x
	beq CODE_C4AE3C
	cpx.w passReceiverPlayerNum
	bne CODE_C4AE3F
CODE_C4AE3C:						; from CODE_C4AE2C
	adc.w #$0BB8
CODE_C4AE3F:						; from CODE_C4AE2C
	phx
	tax
	jsl.l Mul16U
	plx
	lda.b r2
	cmp.b d0
	lda.b $36
	sbc.b $81
	bcs CODE_C4AE6A
	lda.w position,x
	beq CODE_C4AE5F
	lda.b d2
	cmp.w #$0025
	bcc CODE_C4AE5F
	jmp.w CODE_C4ADE4
CODE_C4AE5F:						; from CODE_C4AE3F
	ldy.b a2
	lda.w #$0008
	sta.w nopuck,y
	jmp.w CODE_C4ADD6
CODE_C4AE6A:						; from CODE_C4AE3F
	jmp.w CODE_C44E0A
deflect:							; from CODE_C4ADD6
	lda.w #$FFFF
	sta.w puckc
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w puckvy
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w puckvx
	jsl.l RandomWord
	and.w #$0FFF
	sta.w puckvz
	jmp.w puckflip
PuckIChk:							; called from other segments
	lda.w iflags
	bit.w #$0004
	beq CODE_C4AEC4
	bit.w #$0001
	bne CODE_C4AEC4
	lda.w puckc
	bpl CODE_C4AEC4
	lda.w #$010E
	sta.b d0
	lda.w iflags
	bit.w #$0002
	bne CODE_C4AEC5
	lda.w #$FEF2
	sec
	sbc.w pucky
	bpl CODE_C4AECE
CODE_C4AEC4:						; from PuckIChk, CODE_C4AEC5
	rtl
CODE_C4AEC5:						; from PuckIChk
	lda.w #$010E
	sec
	sbc.w pucky
	bpl CODE_C4AEC4
CODE_C4AECE:						; from PuckIChk
	lda.w #$0001
	tsb.w iflags
	rtl
CODE_C4AED5:						; called from other segments
	stz.b a1
	lda.w #$0002
	sta.b a2
	jsl.l ClearOffsidesIfAllPlayers
	stz.b a2
	lda.w #$0002
	sta.b a1
	jsl.l ClearOffsidesIfAllPlayers
	lda.w #$0058
	sta.b d0
	lda.w pucky
	bpl CODE_C4AEF8
	jmp.w ChkOffsides_other
CODE_C4AEF8:						; from CODE_C4AED5
	lda.b d0
	sec
	sbc.w pucky
	bmi CODE_C4AF0A
	lda.b d0
	sec
	sbc.w $097C
	bpl CODE_C4AF74
	bra CODE_C4AF12
CODE_C4AF0A:						; from CODE_C4AEF8
	lda.b d0
	sec
	sbc.w $097C
	bmi CODE_C4AF74
CODE_C4AF12:						; from CODE_C4AEF8
	jsl.l StartBreakaway
	lda.w gmode
	bit.w #$0020
	bne CODE_C4AF21
	jmp.w CODE_C4AF74
CODE_C4AF21:						; from CODE_C4AF12
	lda.w #$0062
	sta.b d0
	lda.w gmode
	bit.w #$0002
	beq CODE_C4AF36
	lda.b a2
	ldy.b a1
	sty.b a2
	sta.b a1
CODE_C4AF36:						; from CODE_C4AF21
	lda.w puckc
	bpl CODE_C4AF3F
	lda.w lastplayer
	asl a
CODE_C4AF3F:						; from CODE_C4AF36
	cmp.w #$000C
	bpl CODE_C4AF4A
	lda.b a2
	beq CODE_C4AF4E
	bra CODE_C4AF74
CODE_C4AF4A:						; from CODE_C4AF3F
	lda.b a2
	beq CODE_C4AF74
CODE_C4AF4E:						; from CODE_C4AF3F
	lda.w #$0005
	sta.b d2
	ldy.b a2
	lda.w tmsort,y
	sta.b a0
CODE_C4AF5A:						; from CODE_C4AF75
	ldy.b a0
	lda.w position,y
	bmi CODE_C4AF75
	lda.b d0
	sec
	sbc.w Ypos,y
	bpl CODE_C4AF75
	ldy.b a2
	lda.w tmflags,y
	ora.w #$0010
	sta.w tmflags,y
CODE_C4AF74:						; from ClearOffsidesIfAllPlayers, CODE_C4AEF8, ChkOffsides_other, ...
	rtl
CODE_C4AF75:						; from CODE_C4AF5A
	inc.b a0
	inc.b a0
	dec.b d2
	bpl CODE_C4AF5A
	rtl
ChkOffsides_other:					; from CODE_C4AED5
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.b d0
	sec
	sbc.w pucky
	bmi CODE_C4AF98
	lda.b d0
	sec
	sbc.w $097C
	bpl CODE_C4AF74
	bra CODE_C4AFA0
CODE_C4AF98:						; from ChkOffsides_other
	lda.b d0
	sec
	sbc.w $097C
	bmi CODE_C4AF74
CODE_C4AFA0:						; from ChkOffsides_other
	jsl.l StartBreakaway
	lda.w gmode
	bit.w #$0020
	bne CODE_C4AFAF
	jmp.w CODE_C4AF74
CODE_C4AFAF:						; from CODE_C4AFA0
	lda.b d0
	sec
	sbc.w #$000A
	sta.b d0
	lda.w gmode
	bit.w #$0002
	bne CODE_C4AFC7
	lda.b a2
	ldy.b a1
	sty.b a2
	sta.b a1
CODE_C4AFC7:						; from CODE_C4AFAF
	lda.w puckc
	bpl CODE_C4AFD0
	lda.w lastplayer
	asl a
CODE_C4AFD0:						; from CODE_C4AFC7
	cmp.w #$000C
	bpl CODE_C4AFDB
	lda.b a2
	beq CODE_C4AFDF
	bra CODE_C4AF74
CODE_C4AFDB:						; from CODE_C4AFD0
	lda.b a2
	beq CODE_C4AF74
CODE_C4AFDF:						; from CODE_C4AFD0
	lda.w #$0005
	sta.b d2
	ldy.b a2
	lda.w tmsort,y
	sta.b a0
CODE_C4AFEB:						; from CODE_C4B006
	ldy.b a0
	lda.w position,y
	bmi CODE_C4B006
	lda.b d0
	sec
	sbc.w Ypos,y
	bmi CODE_C4B006
	ldy.b a2
	lda.w tmflags,y
	ora.w #$0010
	sta.w tmflags,y
	rtl
CODE_C4B006:						; from CODE_C4AFEB
	inc.b a0
	inc.b a0
	dec.b d2
	bpl CODE_C4AFEB
	rtl

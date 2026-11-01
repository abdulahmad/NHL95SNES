; Segment bankC5_0000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C50000
Opening:							; the cold start that Reset_Fast jumps to (94S Opening)
	pea.w $7E7E
	plb
	plb
	sep #$20
	ldx.w #$000C
CODE_C5000A:						; from CODE_C5000A
	lda.l InitHooks,x
	sta.w FrameHook,x
	dex
	bpl CODE_C5000A
	lda.b #$81
	sta.l NMITIMEN
	rep #$20
	lda.w #$005C
	sta.w $1850
	jsl.l forceblack
	jsl.l CODE_C36F3D
	jsl.l CODE_CF0000
	jsl.l CODE_C4B09F
	jsl.l CODE_C4B97E
	jsl.l CODE_C4D657
	jsl.l CODE_C4D193
	jsl.l forceblack
	jsl.l CODE_C36C2C
	jsl.l CODE_C370AC
	jsl.l CODE_C36B83
CODE_C5004E:						; called from other segments
	jsl.l CODE_C370AC
	jsl.l FadeOutWait
CODE_C50056:						; from CODE_C50056, CODE_C50B7C, CODE_C50E86 and other segments
	rep #$30
	lda.w #$1FFF
	tcs
	stz.w $24C4
	jsl.l CODE_CF04B6
	lda.w #$445C
	sta.w $1850
	lda.w #$C08B
	sta.w $1852
	jsl.l CODE_C36C2C
	jsl.l CODE_C58D32
	lda.w #$007E
	sta.b $71
	stz.w $189C
	lda.w $1864
	cmp.w #$0004
	bne CODE_C5008D
	jsl.l CODE_C092B3
	bra CODE_C50056
CODE_C5008D:						; from CODE_C50056
	jsl.l Create_HotCold_Table
	jsr.w CODE_C52CC1
	jsl.l CODE_C4E12C
	jsr.w CODE_C53984
CODE_C5009B:						; called from other segments
	jsl.l FadeOutWait
	ldx.w #$059E
CODE_C500A2:						; from CODE_C500A2
	stz.b $00,x
	inx
	inx
	cpx.w #$1543
	bcc CODE_C500A2
	lda.w #$0000
	ldx.w #$2000
CODE_C500B1:						; from CODE_C500B1
	sta.w $0000,x
	inx
	inx
	cpx.w #$2375
	bcc CODE_C500B1
	inc.w $2378
	stz.w gmode
	stz.w gsp
	lda.w $186C
	cmp.w #$0001
	bne CODE_C500D2
	lda.w #$0020
	tsb.w gmode
CODE_C500D2:						; from CODE_C500B1
	jsl.l CODE_C53574
	jsl.l restoreteams
	jsl.l CODE_C5362C
	lda.w #$007F
	sta.w $07E2
	stz.w recbpr
	lda.w #$0010
	trb.w sflags
	stz.b a2
	jsl.l CODE_C532C5
	lda.w #$0002
	sta.b a2
	jsl.l CODE_C532C5
	lda.w $1870
	sta.w $17C1
	sta.w $17C3
	lda.w #$0001
	sta.w $1303
	sta.w $1305
	sta.l $7E234C
	stz.w penshot
	stz.w $18C0
	stz.w $1876
	stz.w teampads
	stz.w $14F7
	ldx.w #$0008
CODE_C50124:						; from CODE_C50139
	lda.w cont1team,x
	cmp.w #$0001
	bne CODE_C50131
	inc.w teampads
	bra CODE_C50139
CODE_C50131:						; from CODE_C50124
	cmp.w #$0002
	bne CODE_C50139
	inc.w $14F7
CODE_C50139:						; from CODE_C50124, CODE_C50131
	dec a
	asl a
	sta.w $1525,x
	dex
	dex
	bpl CODE_C50124
	jsl.l CODE_C52037
	stz.w $17D1
	ldx.w #$0008
CODE_C5014C:						; from CODE_C5014C
	lda.w cont1team,x
	bne CODE_C5015B
	dex
	dex
	bpl CODE_C5014C
	jsl.l CODE_CF0427
	bra CODE_C50161
CODE_C5015B:						; from CODE_C5014C
	lda.w #$0001
	sta.w $17D1
CODE_C50161:						; from CODE_C5014C
	lda.w #$FFFF
	sta.w BA_Sktr_SCnum
	lda.w $189C
	beq CODE_C5016D
	rtl
CODE_C5016D:						; from CODE_C50B5D, CODE_C50161 and other segments
	lda.w $189C
	bne CODE_C50176
	lda.w #$1FFF
	tcs
CODE_C50176:						; from CODE_C5016D
	stz.b a2
	jsl.l CODE_C54AEF
	lda.w #$0002
	sta.b a2
	jsl.l CODE_C54AEF
	jsl.l CODE_C52227
	jsl.l CODE_C53535
	jsl.l CODE_C3718D
	lda.w #$FFFF
	sta.w $0591
	lda.w cont1team
	ora.w $17B7
	ora.w $17B9
	ora.w cont4team
	ora.w cont5team
	bne CODE_C501AC
	jsl.l CODE_CF03D0
CODE_C501AC:						; from CODE_C50176
	lda.w $17D1
	beq CODE_C501BC
	ldy.w #$5800
	jsl.l CODE_C589B0
	jsl.l CODE_C50D18
CODE_C501BC:						; from CODE_C501AC
	stz.w $2034
	stz.w $2036
	ldx.w #$001C
	stx.b a3
	lda.w #$001B
	sta.b d0
	jsl.l assreplace
	jsl.l CODE_C5897B
	lda.w #$0400
	tsb.w sflags
	lda.w #$FFFF
	sta.w recsfx
	sta.w recsfx2
	sta.w $078A
	lda.w $1864
	cmp.w #$0004
	beq CODE_C501FF
	lda.w #$0010
	trb.w sflags
	lda.w #$007F
	sta.w $07E2
	stz.w recbpr
	bra CODE_C50202
CODE_C501FF:						; from CODE_C501BC
	stz.w $078A
CODE_C50202:						; from CODE_C501BC
	lda.w #$FFFF
	sta.w $079C
	stz.w $079E
	stz.b Vcount
	stz.b $5F
	stz.w $07F6
	stz.w $07C6
	lda.w $189C
	beq CODE_C5021B
	rtl
CODE_C5021B:						; from CODE_C50202, CODE_C5033A and other segments
	lda.b $26
	lsr a
	lda.w #$E000
	bcs CODE_C50226
	lda.w #$F000
CODE_C50226:						; from CODE_C5021B
	sta.b $D7
	lda.b Vcount
	tax
	sec
	sbc.w $07C6
	bne CODE_C50233
	inc a
	inx
CODE_C50233:						; from CODE_C50226
	phx
	pha
	lda.w #$003C
	ldx.b $48
	inx
	stx.b $48
	stx.b $26
	jsl.l Mul16x8U
	lda.w FrameCount
	sta.b r1
	jsl.l Div32U
	lda.b r0
	sta.w $0563
	lda.w gsp
	cmp.w #$0002
	bne CODE_C50269
	jsl.l RandomWord
	and.w #$03FF
	bne CODE_C50269
	lda.w #$0005
	jsl.l CODE_CF048A
CODE_C50269:						; from CODE_C50233
	pla
	plx
	sta.b d7
	sta.w timestep
	asl a
	sta.w $07A4
	asl a
	asl a
	asl a
	sta.w $07A6
	asl a
	sta.w $07A8
	asl a
	adc.w $07A8
	sta.w $07A8
	stx.w $07F6
	stx.w $07C6
	jsl.l CODE_C36CBF
	lda.w sflags
	bit.w #$0001
	bne CODE_C502EB
	lda.w gmclock
	bne CODE_C502EB
	lda.w $189C
	bne CODE_C502E0
	lda.w PenShotActive
	beq CODE_C502E0
	lda.w $18C2
	ldx.b d7
	dex
	beq CODE_C502B1
	sec
	sbc.b d7
CODE_C502B1:						; from CODE_C50269
	sec
	sbc.b d7
	sta.w $18C2
	bpl CODE_C502BF
	jsl.l EndPenaltyShot
	bra CODE_C502EB
CODE_C502BF:						; from CODE_C502B1
	sta.b r2
	lda.w #$001E
	sta.b r1
	jsl.l Div16x8U
	lda.b r0
	sta.b d0
	jsl.l CODE_C516C2
	ldx.w #$007E
	lda.b a1
	ldy.w #$5B23
	jsl.l QueueVRAMDMALen
	bra CODE_C502EB
CODE_C502E0:						; from CODE_C50269
	ldx.b d7
	dex
	beq CODE_C502E8
	jsr.w CODE_C50E9B
CODE_C502E8:						; from CODE_C502E0
	jsr.w CODE_C50E9B
CODE_C502EB:						; from CODE_C50269, CODE_C502B1, CODE_C502BF
	lda.w $07AE
	beq CODE_C50308
	lda.b Vcount
	sec
	sbc.w $07B0
	cmp.w #$0096
	bcc CODE_C50308
	dec.w $07AE
	lda.w $07B0
	clc
	adc.w #$0096
	sta.w $07B0
CODE_C50308:						; from CODE_C502EB
	jsl.l CODE_C5033D
	jsl.l demoread
	lda.w sflags
	bit.w #$0001
	bne CODE_C5032B
	lda.w mp5warning
	beq CODE_C5032F
	lda.w gmode
	bit.w #$0010
	bne CODE_C5032F
	lda.w #$0001
	tsb.w sflags
CODE_C5032B:						; from CODE_C50308
	jsl.l CODE_C50D29
CODE_C5032F:						; from CODE_C50308
	lda.w $189C
	beq CODE_C5033A
	lda.w $18A2
	beq CODE_C5033A
	rtl
CODE_C5033A:						; from CODE_C5032F
	jmp.w CODE_C5021B
CODE_C5033D:						; from CODE_C50308 and other segments
	jsl.l CODE_C382B7
	jsl.l periodicevents
	jsl.l CODE_C50393
	jsl.l checkwindow
	jsl.l updatereplay
CODE_C50351:						; from CODE_C50351
	lda.w TransfersReady
	bne CODE_C50351
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jml.l CODE_C52295
periodicevents:						; from CODE_C5033D and other segments
	jsl.l CODE_C471F0
	jsl.l CODE_C371AB
	jsl.l clockcont
	lda.w lldisp
	sec
	sbc.b d7
	sta.w lldisp
	bpl CODE_C50392
	clc
	adc.w #$0018
	sta.w lldisp
	jsl.l ChkGoalies
	jsl.l RestoreBenchEnergy
	jsl.l CODE_C48241
	jsl.l updatepwrplay
CODE_C50392:						; from periodicevents
	rtl
CODE_C50393:						; from CODE_C5033D and other segments
	lda.w #$FFFF
	sta.w $0664
	sta.w $0666
	sta.w $12CF
	sta.w $12D1
	sta.w $12D3
	sta.w $12D5
	lda.w puckz
	sta.w $08DC
	ldx.w #$001E
CODE_C503B1:						; from CODE_C50798
	stx.b curobj
	lda.w Xpos,x
	sta.w $0920,x
	lda.w $0836,x
	sta.w $0940,x
	lda.w Ypos,x
	sta.w $0960,x
	lda.w $08B8,x
	sta.w $0980,x
	cpx.w #$0018
	beq CODE_C503D5
	cpx.w #$001A
	bne CODE_C503D8
CODE_C503D5:						; from CODE_C503B1
	jmp.w CODE_C50472
CODE_C503D8:						; from CODE_C503B1
	lda.w position,x
	bpl CODE_C503E0
	jmp.w CODE_C506F0
CODE_C503E0:						; from CODE_C503D8
	bne CODE_C503EF
	lda.w Ypos,x
	bpl CODE_C503EC
	stx.w $0666
	bra CODE_C503EF
CODE_C503EC:						; from CODE_C503E0
	stx.w $0664
CODE_C503EF:						; from CODE_C503E0
	jsl.l updateanim
	lda.w nopuck,x
	sec
	sbc.w timestep
	bpl CODE_C503FF
	lda.w #$0000
CODE_C503FF:						; from CODE_C503EF
	sta.w nopuck,x
	lda.w $0D00,x
	sec
	sbc.w timestep
	bpl CODE_C5040E
	lda.w #$0000
CODE_C5040E:						; from CODE_C503FF
	sta.w $0D00,x
	lda.w sflags3
	bit.w #$0020
	beq CODE_C50434
	lda.w pnum,x
	and.w #$00FF
	cmp.w #$0080
	bcc CODE_C50427
	ora.w #$FF00
CODE_C50427:						; from CODE_C5040E
	sta.b d0
	cmp.w #$0000
	bmi CODE_C50434
	asl.b d0
	jsl.l loadTeamStruct
CODE_C50434:						; from CODE_C5040E, CODE_C50427
	lda.w $06B4,x
	beq CODE_C50445
	sec
	sbc.w timestep
	bpl CODE_C50442
	lda.w #$0000
CODE_C50442:						; from CODE_C50434
	sta.w $06B4,x
CODE_C50445:						; from CODE_C50434
	cpx.w passReceiverPlayerNum
	bne CODE_C50452
	lda.w onetimer
	beq CODE_C50452
	jmp.w CODE_C50577
CODE_C50452:						; from CODE_C50445
	lda.w SPA,x
	cmp.w #$2708
	bne CODE_C5045D
	jmp.w CODE_C506F0
CODE_C5045D:						; from CODE_C50452
	cmp.w #$28F6
	bcc CODE_C50465
	jmp.w CODE_C506F0
CODE_C50465:						; from CODE_C5045D
	cpx.w #$001C
	bne CODE_C50472
	lda.w puckz
	beq CODE_C50472
	jmp.w CODE_C50577
CODE_C50472:						; from CODE_C503D5, CODE_C50465
	ldy.w #$FFFF
	lda.w pflags,x
	bit.w #$0001
	beq CODE_C504DF
	lda.w Xvel,x
	bpl CODE_C50498
	sty.b r2
	sta.b $35
	sec
	lda.b r2
	sbc.b $35
	sta.b r2
	bcc CODE_C50491
	inc.b $36
CODE_C50491:						; from CODE_C50472
	lda.b $35
	sta.w Xvel,x
	bra CODE_C504AC
CODE_C50498:						; from CODE_C50472
	stz.b r2
	sta.b $35
	sec
	lda.b r2
	sbc.b $35
	sta.b r2
	bcs CODE_C504A7
	dec.b $36
CODE_C504A7:						; from CODE_C50498
	lda.b $35
	sta.w Xvel,x
CODE_C504AC:						; from CODE_C50491
	lda.w Yvel,x
	bpl CODE_C504C8
	sty.b r2
	sta.b $35
	sec
	lda.b r2
	sbc.b $35
	sta.b r2
	bcc CODE_C504C0
	inc.b $36
CODE_C504C0:						; from CODE_C504AC
	lda.b $35
	sta.w Yvel,x
	jmp.w CODE_C50577
CODE_C504C8:						; from CODE_C504AC
	stz.b r2
	sta.b $35
	sec
	lda.b r2
	sbc.b $35
	sta.b r2
	bcs CODE_C504D7
	dec.b $36
CODE_C504D7:						; from CODE_C504C8
	lda.b $35
	sta.w Yvel,x
	jmp.w CODE_C50577
CODE_C504DF:						; from CODE_C50472
	lda.b d7
	dec a
	beq CODE_C50503
	lda.w #$00F8
	txy
	ldx.w Xvel,y
	jsl.l Mul16x8HiXS
	sta.w Xvel,y
	lda.w #$00F8
	ldx.w Yvel,y
	jsl.l Mul16x8HiXS
	sta.w Yvel,y
	tyx
	jmp.w CODE_C50577
CODE_C50503:						; from CODE_C504DF
	lda.w Xvel,x
	bpl CODE_C50524
	sty.b r2
	sta.b $35
	asl a
	clc
	adc.b $35
	sta.b r0
	sec
	lda.b r2
	sbc.b r0
	sta.b r2
	bcc CODE_C5051D
	inc.b $36
CODE_C5051D:						; from CODE_C50503
	lda.b $35
	sta.w Xvel,x
	bra CODE_C5053D
CODE_C50524:						; from CODE_C50503
	stz.b r2
	sta.b $35
	asl a
	adc.b $35
	sta.b r0
	sec
	lda.b r2
	sbc.b r0
	sta.b r2
	bcs CODE_C50538
	dec.b $36
CODE_C50538:						; from CODE_C50524
	lda.b $35
	sta.w Xvel,x
CODE_C5053D:						; from CODE_C5051D
	lda.w Yvel,x
	bpl CODE_C5055E
	sty.b r2
	sta.b $35
	asl a
	clc
	adc.b $35
	sta.b r0
	sec
	lda.b r2
	sbc.b r0
	sta.b r2
	bcc CODE_C50557
	inc.b $36
CODE_C50557:						; from CODE_C5053D
	lda.b $35
	sta.w Yvel,x
	bra CODE_C50577
CODE_C5055E:						; from CODE_C5053D
	stz.b r2
	sta.b $35
	asl a
	adc.b $35
	sta.b r0
	sec
	lda.b r2
	sbc.b r0
	sta.b r2
	bcs CODE_C50572
	dec.b $36
CODE_C50572:						; from CODE_C5055E
	lda.b $35
	sta.w Yvel,x
CODE_C50577:						; from CODE_C504DF, CODE_C504C0, CODE_C50445, CODE_C504D7, ...
	ldy.w #$FFFF
	lda.b d7
	dec a
	bne CODE_C50582
	jmp.w CODE_C50612
CODE_C50582:						; from CODE_C50577
	lda.w Xvel,x
	bmi CODE_C505A8
	stz.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	adc.w $0836,x
	sta.w $0836,x
	lda.w Xpos,x
	adc.b $36
	sta.w Xpos,x
	bra CODE_C505C8
CODE_C505A8:						; from CODE_C50582
	sty.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	clc
	adc.w $0836,x
	sta.w $0836,x
	lda.w Xpos,x
	adc.b $36
	sta.w Xpos,x
CODE_C505C8:						; from CODE_C50582
	lda.w Yvel,x
	bmi CODE_C505EF
	stz.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	adc.w $08B8,x
	sta.w $08B8,x
	lda.w Ypos,x
	adc.b $36
	sta.w Ypos,x
	jmp.w CODE_C50692
CODE_C505EF:						; from CODE_C505C8
	sty.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	clc
	adc.w $08B8,x
	sta.w $08B8,x
	lda.w Ypos,x
	adc.b $36
	sta.w Ypos,x
	jmp.w CODE_C50692
CODE_C50612:						; from CODE_C50577
	lda.w Xvel,x
	bmi CODE_C50635
	stz.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	adc.w $0836,x
	sta.w $0836,x
	lda.w Xpos,x
	adc.b $36
	sta.w Xpos,x
	bra CODE_C50652
CODE_C50635:						; from CODE_C50612
	sty.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	clc
	adc.w $0836,x
	sta.w $0836,x
	lda.w Xpos,x
	adc.b $36
	sta.w Xpos,x
CODE_C50652:						; from CODE_C50612
	lda.w Yvel,x
	bmi CODE_C50675
	stz.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	adc.w $08B8,x
	sta.w $08B8,x
	lda.w Ypos,x
	adc.b $36
	sta.w Ypos,x
	bra CODE_C50692
CODE_C50675:						; from CODE_C50652
	sty.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	clc
	adc.w $08B8,x
	sta.w $08B8,x
	lda.w Ypos,x
	adc.b $36
	sta.w Ypos,x
CODE_C50692:						; from CODE_C505C8, CODE_C50652, CODE_C505EF
	cpx.w #$001C
	bne CODE_C506F0
	lda.w puckz
	bmi CODE_C506F0
	bne CODE_C506A3
	lda.w puckvz
	beq CODE_C506F0
CODE_C506A3:						; from CODE_C50692
	lda.w puckvz
	sec
	sbc.w $07A8
	sta.w puckvz
	tax
	lda.w $07A6
	jsl.l Mul16x8XS
	ldx.b curobj
	lda.b r2
	clc
	adc.w shadowz
	sta.w shadowz
	lda.b $36
	adc.w puckz
	sta.w puckz
	bpl CODE_C506F0
	stz.w puckz
	stz.w shadowz
	lda.w puckvz
	eor.w #$FFFF
	inc a
	lsr a
	sta.w puckvz
	cmp.w #$0200
	bmi CODE_C506F0
	asl a
	and.w #$FF00
	sta.b tmp0
	xba
	tsb.b tmp0
	lda.w #$000D
	jsl.l CODE_CF0418
CODE_C506F0:						; from CODE_C503D8, CODE_C50452, CODE_C5045D, CODE_C50692, ...
	sec
	lda.w $0830
	sbc.w Xpos,x
	sta.b d0
	bpl CODE_C50700
	eor.w #$FFFF
	inc a
	sec
CODE_C50700:						; from CODE_C506F0
	sta.b r3
	lda.w pucky
	sbc.w Ypos,x
	sta.b d1
	bpl CODE_C50710
	eor.w #$FFFF
	inc a
CODE_C50710:						; from CODE_C50700
	cmp.b r3
	bcc CODE_C50717
	lsr.b r3
	asl a
CODE_C50717:						; from CODE_C50710
	lsr a
	adc.b r3
	sta.w $05E4,x
	cpx.w #$0018
	bcs CODE_C50755
	sta.b r3
	lda.w position,x
	bmi CODE_C50755
	beq CODE_C50755
	lda.w pflags,x
	and.w #$1000
	ora.w pfalock,x
	bne CODE_C50755
	lda.b r3
	cpx.w #$000C
	bcs CODE_C5074A
	cmp.w $12CF
	bcs CODE_C50755
	sta.w $12CF
	stx.w $12D3
	bra CODE_C50755
CODE_C5074A:						; from CODE_C50717
	cmp.w $12D1
	bcs CODE_C50755
	sta.w $12D1
	stx.w $12D5
CODE_C50755:						; from CODE_C50717, CODE_C5074A
	cpx.w #$0018
	bcs CODE_C50798
	cmp.w #$001E
	bcs CODE_C50798
	lda.w iflags
	bit.w #$0004
	beq CODE_C50798
	bit.w #$0001
	bne CODE_C50798
	and.w #$0002
	beq CODE_C50778
	lda.w pfgoal,x
	bne CODE_C50798
	bra CODE_C5077D
CODE_C50778:						; from CODE_C50755
	lda.w pfgoal,x
	beq CODE_C50798
CODE_C5077D:						; from CODE_C50755
	lda.w puckz
	cmp.w #$000D
	bcs CODE_C50798
	lda.w puckvy
	cmp.w #$2400
	bcs CODE_C50798
	cmp.w #$DC00
	bmi CODE_C50798
	lda.w #$0005
	trb.w iflags
CODE_C50798:						; from CODE_C50755, CODE_C50778, CODE_C5077D
	jsl.l vtoa
	sta.w puckdir,x
	dex
	dex
	bmi CODE_C507A6
	jmp.w CODE_C503B1
CODE_C507A6:						; from CODE_C50798
	lda.w $08AE
	cmp.w #$012E
	bmi CODE_C507B1
	lda.w #$012E
CODE_C507B1:						; from CODE_C507A6
	sta.w $08AE
	lda.w $08B0
	cmp.w #$FED2
	bpl CODE_C507BF
	lda.w #$FED2
CODE_C507BF:						; from CODE_C507B1
	sta.w $08B0
	lda.w #$000F
	sta.w PadControlObj
	sta.w $05B0
	sta.w $05B2
	sta.w $05B4
	sta.w $05B6
	sta.w $05B8
	sta.w $05BA
	stz.w $05A4
	stz.w $05A6
	stz.w $05A8
	stz.w $05AA
	stz.w $05AC
	stz.b $BD
	lda.w #$0002
	sta.b $BF
	ldx.w #$0000
CODE_C507F3:						; from CODE_C50979
	stx.b a3
	stx.b curobj
	cpx.w #$000C
	bne CODE_C50803
	lda.w #$0002
	sta.b $BD
	stz.b $BF
CODE_C50803:						; from CODE_C507F3
	lda.w #$FFFF
	sta.b $B9
	lda.w position,x
	bpl CODE_C50810
	jmp.w CODE_C50979
CODE_C50810:						; from CODE_C50803
	txa
	lsr a
	sta.b d6
	cpx.w puckc
	bne CODE_C5081F
	stz.b d4
	jsl.l setpads
CODE_C5081F:						; from CODE_C50810
	cpx.w #$0018
	bcs CODE_C50851
	lda.w playerpad,x
	bmi CODE_C50851
	tay
	lda.w $05A4,y
	bne CODE_C50851
	lda.w #$0001
	sta.w $05A4,y
	lda.w PadRaw1,y
	sta.b d3
	lda.w $0579,y
	sta.b d2
	lda.w padnew,y
	sta.b d1
	lda.w paddir,y
	sta.b d0
	iny
	iny
	sty.b d4
	jsl.l doinput
CODE_C50851:						; from CODE_C5081F
	lda.w pfalock,x
	bne CODE_C50874
	lda.w asscur,x
	asl a
	asl a
	tax
	lda.l asstab,x
	sta.w $1851
	lda.l $C09A25,x
	sta.w $1852
	ldx.b curobj
	jsl.l loadTeamStruct
	jsl.l $001850
CODE_C50874:						; from CODE_C50851
	lda.w position,x
	ora.w gmclock
	bne CODE_C508E3
	cpx.w #$0018
	bcs CODE_C508E3
	cpx.w puckc
	beq CODE_C508E3
	lda.w goalieflags,x
	bit.w #$0001
	bne CODE_C508E3
	lda.w Xpos,x
	cmp.w #$FFD5
	bpl CODE_C508A3
	cmp.w #$FFCF
	bmi CODE_C508B3
	lda.w #$FFD5
	stz.w Xvel,x
	bra CODE_C508B3
CODE_C508A3:						; from CODE_C50874
	cmp.w #$002C
	bmi CODE_C508B3
	cmp.w #$0031
	bpl CODE_C508B3
	lda.w #$002B
	stz.w Xvel,x
CODE_C508B3:						; from CODE_C50874, CODE_C508A3
	sta.w Xpos,x
	lda.w Ypos,x
	bpl CODE_C508D0
	cmp.w #$FF15
	bmi CODE_C508E3
	cmp.w #$FF1A
	bpl CODE_C508E3
	lda.w #$FF14
	sta.w Ypos,x
	stz.w Yvel,x
	bra CODE_C508E3
CODE_C508D0:						; from CODE_C508B3
	cmp.w #$00EC
	bpl CODE_C508E3
	cmp.w #$00E7
	bmi CODE_C508E3
	lda.w #$00EC
	sta.w Ypos,x
	stz.w Yvel,x
CODE_C508E3:						; from CODE_C50874, CODE_C508B3, CODE_C508D0
	stz.w Wallcos,x
	stz.w Wallsin,x
	lda.w Ypos,x
	sta.b d3
	lda.w Xpos,x
	sta.b d2
	cmp.w $0920,x
	bne CODE_C50902
	lda.b d3
	cmp.w $0960,x
	bne CODE_C50902
	jmp.w CODE_C5096D
CODE_C50902:						; from CODE_C508E3
	jsl.l CODE_C43FC8
	cpx.w #$0018
	bcs CODE_C5096D
	lda.w position,x
	beq CODE_C5096D
	lda.w pflags,x
	and.w #$8000
	bne CODE_C5096D
	lda.w Xpos,x
	cmp.w #$FFE7
	bmi CODE_C5096D
	cmp.w #$0019
	bpl CODE_C5096D
	lda.w Ypos,x
	bit.w #$8000
	beq CODE_C50931
	eor.w #$FFFF
	inc a
CODE_C50931:						; from CODE_C50902
	sec
	sbc.w #$0113
	sta.b r0
	lda.w $0960,x
	bit.w #$8000
	beq CODE_C50943
	eor.w #$FFFF
	inc a
CODE_C50943:						; from CODE_C50931
	sec
	sbc.w #$0113
	eor.b r0
	bmi CODE_C50961
	lda.w Ypos,x
	bit.w #$8000
	beq CODE_C50957
	eor.w #$FFFF
	inc a
CODE_C50957:						; from CODE_C50943
	cmp.w #$0109
	bcc CODE_C5096D
	cmp.w #$011D
	bcs CODE_C5096D
CODE_C50961:						; from CODE_C50943
	lda.w $0920,x
	sta.w Xpos,x
	lda.w $0960,x
	sta.w Ypos,x
CODE_C5096D:						; from CODE_C508E3, CODE_C50902, CODE_C50957
	lda.w $0A00,x
	sec
	sbc.w $07A4
	bpl CODE_C50979
	lda.w #$0000
CODE_C50979:						; from CODE_C50803, CODE_C5096D
	sta.w $0A00,x
	inx
	inx
	cpx.w #$0020
	beq CODE_C50986
	jmp.w CODE_C507F3
CODE_C50986:						; from CODE_C50979
	lda.w puckz
	cmp.w #$0018
	bcs CODE_C509C0
	lda.w $0830
	cmp.w #$FF65
	bpl CODE_C509A7
	lda.w #$FF65
	sta.w $0830
	ldx.w $0872
	cpx.w #$01B3
	bne CODE_C509A7
	sta.w $0832
CODE_C509A7:						; from CODE_C50986
	lda.w $0830
	cmp.w #$009B
	bmi CODE_C509C0
	lda.w #$009B
	sta.w $0830
	ldx.w $0872
	cpx.w #$01B3
	bne CODE_C509C0
	sta.w $0832
CODE_C509C0:						; from CODE_C50986, CODE_C509A7
	lda.w puckz
	bne CODE_C509F4
	lda.w pucky
	cmp.w #$FEAE
	bmi CODE_C509F4
	cmp.w #$0152
	bpl CODE_C509F4
	lda.w pucky
	cmp.w #$FEC7
	bpl CODE_C509E3
	lda.w #$FEC7
	sta.w pucky
	sta.w $08B4
CODE_C509E3:						; from CODE_C509C0
	lda.w pucky
	cmp.w #$013E
	bmi CODE_C509F4
	lda.w #$013E
	sta.w pucky
	sta.w $08B4
CODE_C509F4:						; from CODE_C509C0, CODE_C509E3
	lda.w puckc
	bmi CODE_C509FF
	lda.w pucky
	sta.w $2000
CODE_C509FF:						; from CODE_C509F4
	rtl
DATA8_C50A00:						; not traced: data between routines
	db $FD,$FA,$F7,$F4,$F1,$EE,$EB,$E8,$E6,$E3,$FF,$FF,$FE,$FE,$FE,$FD
	db $FD,$FD,$FC,$FC
clockcont_0:						; called from other segments
	ldx.w #$001C
	stx.b a3
	lda.w #$0018
	sta.b d0
	jsl.l CODE_C43734
	lda.w #$0007
	jsl.l CODE_CF040B
	stz.b p0
	lda.w gsp
	cmp.w #$0002
	bcs CODE_C50A36
	jmp.w CODE_C50AC3
CODE_C50A36:						; from clockcont_0
	lda.w #$0008
	sta.b d0
	ldx.w #$0000
	stx.b a3
	lda.w #$0005
	sta.b d2
	lda.w tmscore
	cmp.w $12AD
	beq CODE_C50AC3
	bpl CODE_C50A54
	ldx.w #$000C
	stx.b a3
CODE_C50A54:						; from CODE_C50A36, CODE_C50A64
	lda.w position,x
	beq CODE_C50A64
	bmi CODE_C50A64
	jsl.l CODE_C43734
	lda.w #$0008
	sta.b d0
CODE_C50A64:						; from CODE_C50A54
	inx
	inx
	stx.b a3
	dec.b d2
	bpl CODE_C50A54
CODE_C50A6C:						; from CODE_C50AC3
	jsl.l CODE_C4818C
	lda.l $7E24CA
	clc
	adc.w #$03E8
	sta.l $7E24CA
	lda.w #$003C
	sta.b crowdhold
	lda.w #$0040
	sta.w gmclock
	tsb.w gmode
	lda.w tmscore
	cmp.w $12AD
	bmi CODE_C50AA8
	lda.w #$0000
	sta.l $7E24CA
	lda.w #$0003
	sta.w $07AE
	lda.b Vcount
	sec
	sbc.w #$0096
	sta.w $07B0
CODE_C50AA8:						; from CODE_C50A6C
	jsl.l CODE_C380D1
	lda.w #$0004
	sta.b d0
	jsl.l AddPenalty2
	lda.b p0
	beq CODE_C50AC2
	lda.w #$0032
	sta.b d0
	jsl.l AddPenalty2
CODE_C50AC2:						; from CODE_C50AA8
	rtl
CODE_C50AC3:						; from clockcont_0, CODE_C50A36
	lda.w gsp
	cmp.w #$0003
	bne CODE_C50AD0
	lda.w $1864
	beq CODE_C50A6C
CODE_C50AD0:						; from CODE_C50AC3
	jsl.l EndPenaltyShot
	lda.w #$0002
	sta.b d0
	jml.l ShootoutWonBy
CODE_C50ADD:						; called from other segments
	jsl.l CODE_C50E94
	jsl.l forceblack
	lda.w gmode
	eor.w #$0002
	sta.w gmode
	ldy.w #$0000
CODE_C50AF1:						; from CODE_C50AFF
	lda.w tmpdst,y
	cmp.w #$FFFD
	bne CODE_C50AFF
	lda.w #$FFFE
	sta.w tmpdst,y
CODE_C50AFF:						; from CODE_C50AF1
	iny
	iny
	cpy.w #$0068
	bcc CODE_C50AF1
	jsl.l CODE_C5226A
	jsl.l CODE_C52295
	inc.w gsp
	lda.w gsp
	cmp.w #$0003
	beq CODE_C50B2F
	bcc CODE_C50B3D
	lda.w #$0003
	sta.w gsp
	lda.w $1864
	cmp.w #$0003
	beq CODE_C50B2F
	lda.w #$0004
	sta.w gsp
CODE_C50B2F:						; from CODE_C50AFF
	lda.w tmscore
	cmp.w $12AD
	beq CODE_C50B3D
	lda.w #$0004
	sta.w gsp
CODE_C50B3D:						; from CODE_C50AFF, CODE_C50B2F
	jsl.l CODE_C53535
	lda.w gsp
	cmp.w #$0004
	bne CODE_C50B5D
	jsl.l CODE_C5D5CD
	lda.w $1864
	cmp.w #$0003
	beq CODE_C50B5A
	cmp.w #$0002
	bne CODE_C50B5D
CODE_C50B5A:						; from CODE_C50B3D
	jsr.w CODE_C5DD47
CODE_C50B5D:						; from CODE_C50B3D
	jsl.l CODE_C51523
	lda.w gsp
	cmp.w #$0004
	beq CODE_C50B7C
	lda.w gsp
	sta.w $1876
	jsl.l CODE_C50E94
	lda.w #$FFFF
	sta.w BA_Sktr_SCnum
	jmp.w CODE_C5016D
CODE_C50B7C:						; from CODE_C50B5D
	lda.w $1864
	cmp.w #$0003
	beq CODE_C50B8C
	cmp.w #$0002
	beq CODE_C50B8C
	jmp.w CODE_C50056
CODE_C50B8C:						; from CODE_C50B7C
	jsr.w CODE_C5E49A
	jsr.w CODE_C50BEC
	jsr.w CODE_C5DE9B
	lda.w $1864
	cmp.w #$0003
	beq CODE_C50BA5
	jsr.w CODE_C5DDF0
	jsr.w CODE_C5E17C
	bra CODE_C50BA8
CODE_C50BA5:						; from CODE_C50B8C
	jsr.w CODE_C5E4D2
CODE_C50BA8:						; from CODE_C50B8C
	pea.w $C57E
	plb
	pea.w $007B
	pea.w $9677
	ldx.w $2C42
	lda.l $306051
CODE_C50BB9:						; from CODE_C50BB9
	lsr a
	bcc CODE_C50BE5
	dex
	bne CODE_C50BB9
	lda.w $1864
	cmp.w #$0003
	bne CODE_C50BCB
	jml.l CODE_C40296
CODE_C50BCB:						; from CODE_C50BB9
	lda.l $306050
	inc a
	sta.l $306050
	lda.w #$0000
	sta.l $306051
	dec a
	sta.b tmp0
	jsl.l CODE_CF04B6
	jmp.w CODE_C5ADDC
CODE_C50BE5:						; from CODE_C50BB9
	pea.w $7E7F
	plb
	jmp.w CODE_C5AF07
CODE_C50BEC:						; from CODE_C50B8C
	ldy.w #$0000
	tyx
	clc
	bra CODE_C50BF9
CODE_C50BF3:						; from CODE_C50BF9
	iny
	txa
	adc.w #$010A
	tax
CODE_C50BF9:						; from CODE_C50BEC
	lda.l $7F8EF8,x
	beq CODE_C50BF3
	stx.b tmp1
	tya
	asl a
	tax
	lda.l $306051
	ora.l BitMaskTable,x
	sta.l $306051
	ldx.b tmp1
	lda.w tmscore
	sta.l $7F8F02,x
	sta.l $7F8F1A,x
	sta.l $7F8F16,x
	sta.b tmp0
	lda.w $12AD
	sta.l $7F8F00,x
	sta.l $7F8F04,x
	sta.l $7F8F2C,x
	xba
	tsb.b tmp0
	lda.w $1297
	sta.l $7F8F1C,x
	sta.l $7F8F18,x
	lda.w $1299
	sta.l $7F8F06,x
	sta.l $7F8F2E,x
	lda.w $12D7
	sta.l $7F8F1E,x
	lda.w $12D9
	sta.l $7F8F08,x
	lda.w $1263
	sta.l $7F8F20,x
	lda.w $1265
	sta.l $7F8F0A,x
	lda.w $125F
	sta.l $7F8F22,x
	lda.w $1261
	sta.l $7F8F0C,x
	lda.w tmSHShots
	sta.l $7F8F24,x
	lda.w $127D
	sta.l $7F8F0E,x
	lda.w $127F
	sta.l $7F8F26,x
	lda.w $1281
	sta.l $7F8F10,x
	lda.w $12FB
	sta.l $7F8F28,x
	lda.w $12FD
	sta.l $7F8F12,x
	lda.w $12F3
	sta.l $7F8F2A,x
	lda.w $12F5
	sta.l $7F8F14,x
	lda.w #$0000
	sta.l $7F8EF8,x
	dec a
	sta.l $7F8EFE,x
	tya
	asl a
	tax
	lda.b tmp0
	sta.l $306053,x
	clc
	lda.b tmp1
	adc.w #$8F32
	tay
	ldx.w #$1413
	lda.w #$00CF
	phb
	mvn $7F,$00
	plb
	lda.w $1864
	cmp.w #$0003
	beq CODE_C50D02
	pea.w $7E7F
	plb
	lda.b tmp1
	clc
	adc.w #$8EF8
	tay
	jsr.w CODE_C5DE1F
	tyx
	lda.w $0002,y
	jsr.w CODE_C5E20B
	tya
	clc
	adc.w #$0016
	tax
	lda.w $0004,y
	jsr.w CODE_C5E20B
	plb
	jsl.l CODE_C40A6D
CODE_C50D02:						; from CODE_C50BF9
	rts
CODE_C50D03:						; no caller found (not traced)
	cmp.w $079C
	bcs CODE_C50D0B
	sta.w $079C
CODE_C50D0B:						; from CODE_C50D03
	rtl
CODE_C50D0C:						; no caller found (not traced)
	cmp.w $079E
	bcc CODE_C50D14
	sta.w $079E
CODE_C50D14:						; from CODE_C50D0C
	rtl
startpause:							; from CODE_C50E62
	stz.w $0591
CODE_C50D18:						; from CODE_C501AC, PauseFromPad and other segments
	lda.w $2CF5
	bne CODE_C50D23
	lda.w #$0001
	tsb.w sflags
CODE_C50D23:						; from CODE_C50D18
	rtl
PauseFromPad:						; from CODE_C50E42 and other segments
	sta.w $0591
	bra CODE_C50D18
CODE_C50D29:						; from CODE_C5032B and other segments
	lda.w $2CF5
	pha
	jsl.l CODE_C5226A
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	pei ($8F)
	pei ($91)
	pei ($93)
	pei ($95)
	pei ($97)
	pei ($99)
	pei ($9B)
	pei ($9D)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	pei ($73)
	pei ($75)
	pei ($77)
	pei ($79)
	pei ($7B)
	pei ($7D)
	jsl.l CODE_C54E6D
	pla
	sta.b $7D
	pla
	sta.b $7B
	pla
	sta.b $79
	pla
	sta.b $77
	pla
	sta.b $75
	pla
	sta.b a4
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
	pla
	sta.b $65
	pla
	sta.b a0
	pla
	sta.b $9D
	pla
	sta.b d7
	pla
	sta.b $99
	pla
	sta.b d6
	pla
	sta.b $95
	pla
	sta.b d5
	pla
	sta.b $91
	pla
	sta.b d4
	pla
	sta.b $8D
	pla
	sta.b d3
	pla
	sta.b $89
	pla
	sta.b d2
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
	jsl.l CODE_C558CC
	jsl.l CODE_C5589E
	pla
	sta.w $2CF5
	bne CODE_C50DDD
	jsl.l CODE_C52264
CODE_C50DDD:						; from CODE_C50D29
	stz.b Vcount
	stz.w $07C6
	jsl.l CODE_C4CEDB
	stz.w $2372
	stz.w $1857
	jsl.l forceblack
	stz.w $079C
	lda.w #$0001
	trb.w sflags
	lda.w $17D1
	bne CODE_C50E02
	jsl.l ScreenOn
CODE_C50E02:						; from CODE_C50DDD
	stz.w $17D1
	lda.w #$0006
	jsl.l CODE_CF040B
	jsl.l CODE_CF038E
	jsl.l CODE_CF03D0
	lda.w #$FFFF
	sta.w recsfx
	sta.w recsfx2
	lda.b Vcount
	sta.w $07F6
	sta.w $07C6
	rtl
demoread:							; from CODE_C50308 and other segments
	lda.w $1864
	cmp.w #$0004
	bne CODE_C50E62
	lda.w cont1team
	ora.w $17B7
	ora.w $17B9
	ora.w cont4team
	ora.w cont5team
	beq CODE_C50E62
	ldx.w #$0000
CODE_C50E42:						; from CODE_C50E59
	phx
	lda.w cont1team,x
	beq CODE_C50E59
	txa
	lsr a
	jsl.l ReadjoyA
	lda.b d3
	bit.w #$1000
	beq CODE_C50E59
	pla
	jmp.w PauseFromPad
CODE_C50E59:						; from CODE_C50E42
	plx
	inx
	inx
	cpx.w #$000A
	bcc CODE_C50E42
	rtl
CODE_C50E62:						; from demoread
	lda.w cont1team
	ora.w $17B7
	ora.w $17B9
	ora.w cont4team
	ora.w cont5team
	bne CODE_C50E85
	jsl.l ReadJoy1
	lda.b d1
	bit.w #$1000
	beq CODE_C50E81
	jmp.w startpause
CODE_C50E81:						; from CODE_C50E62
	lda.b d1
	bne CODE_C50E86
CODE_C50E85:						; from CODE_C50E62
	rtl
CODE_C50E86:						; from CODE_C50E81
	stz.w fadestep
	jml.l CODE_C50056
CODE_C50E8D:						; no caller found (not traced)
	lda.w #$0005
	sta.w fadestep
	rtl
CODE_C50E94:						; from CODE_C50ADD, CODE_C50B5D and other segments
	lda.w #$FFFF
	sta.w fadestep
	rtl
CODE_C50E9B:						; from CODE_C502E0, CODE_C502E8
	lda.w gameclock
	beq CODE_C50ED7
	lda.w $114F
	sec
	sbc.w #$0AAA
	sta.w $114F
	bcs CODE_C50ED7
	dec.w gameclock
	sep #$29
	lda.w $1151
	sbc.b #$01
	bcs CODE_C50EC2
	lda.w $1152
	sbc.b #$00
	sta.w $1152
	lda.b #$59
CODE_C50EC2:						; from CODE_C50E9B
	sta.w $1151
	rep #$28
	jsl.l CODE_C51397
	lda.w CwdExciteLvl
	clc
	adc.w #$FFFD
	bmi CODE_C50ED7
	sta.w CwdExciteLvl
CODE_C50ED7:						; from CODE_C50E9B, CODE_C50EC2
	rts
UpdateScores:						; no caller found (not traced)
	jsl.l GetShifter
	lda.b d1
	sta.w TickerNum
	asl a
	sta.b a0
CODE_C50EE4:						; from CODE_C50EFF
	lda.b d1
	cmp.w $24C6
	beq CODE_C50EFF
	ldx.b a0
	lda.w $2488,x
	and.w #$FFFD
	sta.w $2488,x
	bit.w #$0004
	bne CODE_C50EFF
	jsl.l CODE_C511B8
CODE_C50EFF:						; from CODE_C50EE4
	dec.b a0
	dec.b a0
	dec.b d1
	bpl CODE_C50EE4
	rtl
CODE_C50F08:						; called from other segments
	rtl
CalcAttrib:							; no caller found (not traced)
	lda.b d0
	asl a
	adc.b d0
	asl a
	asl a
	sta.b r0
	stz.b $81
	ldy.b a2
	beq CODE_C50F20
	lda.b r0
	clc
	adc.w #$0138
	sta.b r0
CODE_C50F20:						; from CalcAttrib
	lda.w #$00C3
	sta.b $65
	lda.w $17D3,y
	sta.b a0
	clc
	lda.b [a0]
	and.w #$07FF
	sta.b a0
	lda.b d0
	asl a
	adc.b a0
	sta.b a0
	lda.b [a0]
	and.w #$3FFF
	sta.b a0
	lda.b [a0]
	clc
	adc.b a0
	sta.b a0
	stz.b d0
	stz.b d1
	phx
	lda.w #$0000
CODE_C50F4F:						; from CODE_C51033
	sta.b d2
	asl a
	tax
	lda.l BitMaskTable2,x
	bit.b $91
	bne CODE_C50F5E
	jmp.w CODE_C51033
CODE_C50F5E:						; from CODE_C50F4F
	cpx.w #$000C
	beq CODE_C50F68
	cpx.w #$001A
	bne CODE_C50F6A
CODE_C50F68:						; from CODE_C50F5E
	inc.b $81
CODE_C50F6A:						; from CODE_C50F5E
	lda.w #$000F
	sec
	sbc.b d2
	sta.b p1
	lsr a
	clc
	adc.b a0
	sta.b p0
	lda.b $65
	sta.b $3A
	lda.b [p0]
	sta.b d3
	lda.b d2
	lsr a
	bcc CODE_C50F8D
	lda.b d3
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b d3
CODE_C50F8D:						; from CODE_C50F6A
	lda.b d3
	and.w #$000F
	sta.b d3
	lda.b p1
	dec a
	dec a
	dec a
	cmp.w #$0006
	bcc CODE_C50F9F
	dec a
CODE_C50F9F:						; from CODE_C50F8D
	clc
	adc.b r0
	tax
	lda.l $7E24DC
	beq CODE_C50FAF
	lda.w $1543,x
	and.w #$00FF
CODE_C50FAF:						; from CODE_C50F9F
	sta.b $42
	cmp.w #$0080
	bcc CODE_C50FBB
	lda.w #$0100
	sbc.b $42
CODE_C50FBB:						; from CODE_C50FAF
	sta.b r3
	asl a
	clc
	adc.b r3
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C50FCB
	ora.w #$C000
CODE_C50FCB:						; from CODE_C50FBB
	sta.b r3
	lda.b $42
	bit.w #$0080
	beq CODE_C50FDC
	lda.w #$0000
	sec
	sbc.b r3
	sta.b r3
CODE_C50FDC:						; from CODE_C50FCB
	lda.b $91
	bmi CODE_C51012
	ldx.b p1
	lda.l DATA8_C510CF,x
	and.w #$00FF
	beq CODE_C5100A
	lda.w #$0012
	ldx.b d3
	jsl.l Mul8U
	clc
	adc.b r3
	bpl CODE_C50FFC
	lda.w #$0000
CODE_C50FFC:						; from CODE_C50FDC
	cmp.w #$0065
	bcc CODE_C51004
	lda.w #$0064
CODE_C51004:						; from CODE_C50FFC
	sta.b d0
	plx
	jmp.w CODE_C51094
CODE_C5100A:						; from CODE_C50FDC
	lda.b d3
	sta.b d0
	plx
	jmp.w CODE_C51094
CODE_C51012:						; from CODE_C50FDC
	lda.b p1
	clc
	adc.b r2
	tax
	lda.l DATA8_C510AF,x
	ldx.b d3
	jsl.l Mul8U
	clc
	adc.b d0
	sta.b d0
	lda.b r3
	ldy.b r2
	beq CODE_C5102E
	asl a
CODE_C5102E:						; from CODE_C51012
	clc
	adc.b d1
	sta.b d1
CODE_C51033:						; from CODE_C50F4F
	lda.b d2
	inc a
	cmp.w #$000F
	bpl CODE_C5103E
	jmp.w CODE_C50F4F
CODE_C5103E:						; from CODE_C51033
	lda.b d1
	bpl CODE_C5106B
	eor.w #$FFFF
	inc a
	ldx.b r2
	bne CODE_C51050
	tax
	lda.w #$000A
	bra CODE_C51054
CODE_C51050:						; from CODE_C5103E
	tax
	lda.w #$0007
CODE_C51054:						; from CODE_C5103E
	jsl.l DivX8U
	sec
	eor.w #$FFFF
	adc.b d0
	sta.b d0
	lda.b d0
	bpl CODE_C5108B
	stz.b d0
	lda.w #$0000
	bra CODE_C5108B
CODE_C5106B:						; from CODE_C5103E
	ldx.b r2
	bne CODE_C51075
	tax
	lda.w #$000A
	bra CODE_C51079
CODE_C51075:						; from CODE_C5106B
	tax
	lda.w #$0007
CODE_C51079:						; from CODE_C5106B
	jsl.l DivX8U
	clc
	adc.b d0
	sta.b d0
	lda.b d0
	bpl CODE_C5108B
	stz.b d0
	lda.w #$0000
CODE_C5108B:						; from CODE_C51054, CODE_C51079
	sta.b d0
	plx
	lda.b r2
	beq CODE_C51094
	lsr.b d0
CODE_C51094:						; from CODE_C51004, CODE_C5100A, CODE_C5108B
	lda.b $81
	bne CODE_C510AE
	lda.b d0
	cmp.w #$0065
	bcc CODE_C510A2
	lda.w #$0064
CODE_C510A2:						; from CODE_C51094
	cmp.w #$0032
	bcs CODE_C510AC
	lsr a
	clc
	adc.w #$0019
CODE_C510AC:						; from CODE_C510A2
	sta.b d0
CODE_C510AE:						; from CODE_C51094
	rtl
DATA8_C510AF:						; not traced: a table read by CODE_C51012
	db $00,$00,$01,$02,$03,$03,$02,$01,$02,$01,$03,$02,$01,$01,$01,$01
	db $00,$00,$00,$09,$02,$02,$09,$09,$02,$02,$02,$02,$02,$02,$02,$02
DATA8_C510CF:						; not traced: a table read by CODE_C50FDC
	db $00,$00,$00,$01,$01,$01,$01,$01,$01,$00,$01,$01,$01,$01,$01,$01
GetPeriodTimeRemaining:				; called from other segments
	lda.w gsp
	xba
	and.w #$FF00
	asl a
	asl a
	asl a
	asl a
	asl a
	asl a
	ora.w $17B3
	sec
	sbc.w gameclock
	sta.b d0
	rtl

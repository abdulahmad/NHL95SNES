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
	beq CODE_C3707C
	stz.w repeatdelayframes
	sta.w $0565
CODE_C3707C:						; from CODE_C37065
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
CODE_C370A5:						; from CODE_C37065, CODE_C37611, CODE_C376CE and other segments
	lda.w $0591
	lsr a
	jmp.w ReadjoyA
CODE_C370AC:						; called from other segments
	lda.w $058D
	sta.b d1
	rtl
ProcessInputWithRepeat:				; called from other segments
	lda.b d3
	beq CODE_C370C9
	lda.b d2
	bne CODE_C370CA
	dec.w repeatdelayframes
	bpl CODE_C370C9
	lda.w #$0006
	sta.w repeatdelayframes
	lda.b d3
	sta.b d1
CODE_C370C9:						; from ProcessInputWithRepeat
	rtl
CODE_C370CA:						; from ProcessInputWithRepeat
	lda.w #$0014
	sta.w repeatdelayframes
	rtl
RemapTiles:							; no caller found (not traced)
	lda.w #$000E
	sta.b $A4
	sta.b $A4
CODE_C370D8:						; from CODE_C3710D
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
CODE_C370F2:						; from CODE_C3710D
	ldy.b #$00
	asl.b $A2
	bcc CODE_C370FA
	ldy.b #$08
CODE_C370FA:						; from CODE_C370F2
	asl.b tmp1
	bcc CODE_C37102
	iny
	iny
	iny
	iny
CODE_C37102:						; from CODE_C370FA
	asl.b $A0
	bcc CODE_C37108
	iny
	iny
CODE_C37108:						; from CODE_C37102
	asl.b tmp0
	bcc CODE_C3710D
	iny
CODE_C3710D:						; from CODE_C37108
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
	bpl CODE_C370F2
	dec.b $A4
	dec.b $A4
	bpl CODE_C370D8
	rep #$30
	ldx.w #$0000
CODE_C3712E:						; from CODE_C3712E
	lda.w RemapOut,x
	sta.l VMDATAL
	inx
	inx
	cpx.w #$0020
	bne CODE_C3712E
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
	ldx.w $0591
CODE_C3714E:						; from CODE_C3714E
	lda.b PadRaw1,x
	bne CODE_C3714E
	pla
	plx
	rtl
CODE_C37155:						; no caller found (not traced)
	phx
	pha
CODE_C37157:						; from CODE_C3715A
	ldx.w #$0008
CODE_C3715A:						; from CODE_C37166
	lda.b PadRaw1,x
	bit.w #$000F
	bne CODE_C37166
	and.w #$FFF0
	bne CODE_C37157
CODE_C37166:						; from CODE_C3715A
	dex
	dex
	bpl CODE_C3715A
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
	jsl.l CODE_C5F3DB
	inc.b $26
	jml.l CODE_C4CEDB
CODE_C3718D:						; called from other segments
	lda.w gsp
	cmp.w #$0003
	beq CODE_C371AA
	stz.b r0
	lda.w $1864
	cmp.w #$0003
	bne CODE_C371A1
	inc.b r0
CODE_C371A1:						; from CODE_C3718D
	lda.b r0
	asl a
	asl a
	asl a
	asl a
	sta.w CwdExciteLvl
CODE_C371AA:						; from CODE_C3718D
	rtl
CODE_C371AB:						; called from other segments
	lda.w $1EA5
	beq CODE_C371C6
	lda.b crowdhold
	beq CODE_C371C7
	cmp.w #$003D
	bcc CODE_C371BC
	lda.w #$003C
CODE_C371BC:						; from CODE_C371AB
	sec
	sbc.b d7
	bpl CODE_C371C4
	lda.w #$0000
CODE_C371C4:						; from CODE_C371BC
	sta.b crowdhold
CODE_C371C6:						; from CODE_C371AB
	rtl
CODE_C371C7:						; from CODE_C371AB
	ldx.w #$0002
	lda.w $48BA,x
	and.w #$00FF
	tax
	lda.w $24CA
	cmp.w #$0481
	bcc CODE_C371DC
	lda.w #$0480
CODE_C371DC:						; from CODE_C371C7
	sec
	sbc.w $07A4
	bpl CODE_C371E5
	lda.w #$0000
CODE_C371E5:						; from CODE_C371DC
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
	jml.l CODE_CF00E3
updatereplay:						; called from other segments
	lda.w gmode
	bit.w #$0010
	bne CODE_C37209
	lda.w replaydelay
	beq CODE_C3720F
	dec a
	bne CODE_C3720C
CODE_C37209:						; from updatereplay
	jmp.w CODE_C3736A
CODE_C3720C:						; from updatereplay
	sta.w replaydelay
CODE_C3720F:						; from updatereplay
	lda.w sflags
	bit.w #$0400
	bne CODE_C37242
	lda.w recbpr
	clc
	adc.w #$007A
	sta.w recbpr
	bcc CODE_C37226
	inc.w $07E2
CODE_C37226:						; from CODE_C3720F
	cmp.w #$8EF8
	bne CODE_C37242
	lda.w $07E2
	cmp.w #$007F
	bne CODE_C37242
	lda.w #$0010
	tsb.w sflags
	lda.w #$007F
	sta.w $07E2
	stz.w recbpr
CODE_C37242:						; from CODE_C3720F, CODE_C37226
	phd
	lda.w #$2100
	tcd
	lda.w recbpr
	sta.b $81
	sep #$20
	lda.w $07E2
	sta.b d1
	lda.b #$0F
	sta.w d2
	ldx.w #$0000
	ldy.w #$0001
CODE_C3725E:						; from CODE_C3725E
	lda.w Xpos,x
	sta.b $80
	lda.w $0815,x
	and.b #$0F
	sta.w r3
	lda.w $0897,x
	asl a
	asl a
	asl a
	asl a
	ora.w r3
	sta.b $80
	lda.w Ypos,x
	sta.b $80
	lda.w frame,x
	sta.b $80
	lda.w $0857,x
	and.b #$3F
	sta.w r3
	lda.w $08E1,x
	and.b #$18
	asl a
	asl a
	asl a
	ora.w r3
	sta.b $80
	inx
	inx
	dec.w d2
	bpl CODE_C3725E
	lda.b #$05
	sta.w d2
	ldx.w #$0000
CODE_C372A5:						; from CODE_C372C2
	lda.w rostnum,x
	sta.b $80
	lda.w $0EE2,x
	sta.b $80
	lda.w position,x
	bpl CODE_C372B6
	lda.b #$FF
CODE_C372B6:						; from CODE_C372A5
	and.b #$0F
	sta.w r3
	lda.w $0A22,x
	bpl CODE_C372C2
	lda.b #$FF
CODE_C372C2:						; from CODE_C372B6
	asl a
	asl a
	asl a
	asl a
	ora.w r3
	sta.b $80
	inx
	inx
	inx
	inx
	dec.w d2
	bpl CODE_C372A5
	lda.w puckz
	sta.b $80
	lda.w shadowz
	sta.b $80
	lda.w recsfx
	sta.b $80
	lda.w recsfxpitch
	sta.b $80
	lda.w $0779
	sta.b $80
	lda.w $077B
	sta.b $80
	lda.w recsfx2
	sta.b $80
	lda.w recsfxpitch2
	sta.b $80
	lda.w $077F
	sta.b $80
	lda.w $0781
	sta.b $80
	lda.w d7
	sta.b $80
	lda.w $05B0
	asl a
	asl a
	asl a
	asl a
	ora.w PadControlObj
	sta.b $80
	lda.w $05B4
	asl a
	asl a
	asl a
	asl a
	ora.w $05B2
	sta.b $80
	lda.w $05B8
	asl a
	asl a
	asl a
	asl a
	ora.w $05B6
	sta.b $80
	lda.l $7E24CA
	sta.b $80
	lda.l $7E24CB
	sta.b $80
	lda.w PBnum
	sta.b $80
	lda.w $00CB
	sta.b $80
	lda.w $00CC
	sta.b $80
	lda.w $00CD
	sta.b $80
	lda.w $00CE
	sta.b $80
	lda.w $06F2
	sta.b $80
	lda.w $06F3
	sta.b $80
	rep #$20
	lda.w #$FFFF
	sta.w recsfx
	sta.w recsfx2
	pld
CODE_C3736A:						; from CODE_C37209
	rtl
CODE_C3736B:						; called from other segments
	bit.w $0591
	bpl CODE_C37373
	stz.w $0591
CODE_C37373:						; from CODE_C3736B
	lda.b $48
	sta.w $2CDF
	stz.w $2CE1
	lda.w #$0000
	sta.l $7E24CA
	lda.w #$0800
	tsb.w sflags
	jsl.l CODE_C52264
	jsl.l CODE_C5897B
	jsl.l CODE_C4CEDB
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
	ldx.w #$00C1
	lda.w #$D778
	jsl.l CODE_C5881C
	ldx.b $08
	ldy.w #$00DF
	clc
CODE_C373D4:						; from CODE_C373D4
	lda.l $7E0000,x
	adc.w #$3E4B
	sta.l $7E0000,x
	inx
	inx
	dey
	bpl CODE_C373D4
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
	bcs CODE_C37451
CODE_C37448:						; from CODE_C37451
	lda.w #$007F
	sta.w $07E2
	stz.w recbpr
CODE_C37451:						; from CODE_C373D4
	lda.w #$8EF8
	cmp.w recbpr
	lda.w #$007F
	sbc.w $07E2
	bcc CODE_C37448
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
	bne CODE_C37448
	lda.w $07E2
	sta.b $75
	lda.w recbpr
	sta.b a4
	pea.w $0000
CODE_C3748A:						; from CODE_C3748A
	dec.w $2CE1
	jsl.l suba4
	pla
	inc a
	pha
	lda.b d7
	bne CODE_C3748A
	pla
	lsr a
	pha
CODE_C3749B:						; from CODE_C3749B
	lda.b $01,s
	beq CODE_C374AB
	inc.w $2CE1
	jsl.l adda4
	pla
	dec a
	pha
	bra CODE_C3749B
CODE_C374AB:						; from CODE_C3749B
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
CODE_C374CF:						; from CODE_C376AA, CODE_C377A2, CODE_C378C3, CODE_C378DC
	lda.w $0774
	bpl CODE_C374D7
	jmp.w CODE_C37560
CODE_C374D7:						; from CODE_C374CF
	tax
	lda.w Xpos,x
	sta.w $0834
	cmp.w $0786
	bpl CODE_C374F4
	lda.w $0786
	sec
	sbc.w #$0004
	cmp.w $0834
	bpl CODE_C374F2
	lda.w $0834
CODE_C374F2:						; from CODE_C374D7
	bra CODE_C37503
CODE_C374F4:						; from CODE_C374D7
	lda.w $0786
	clc
	adc.w #$0004
	cmp.w $0834
	bmi CODE_C37503
	lda.w $0834
CODE_C37503:						; from CODE_C374F2, CODE_C374F4
	cmp.w #$FFC8
	bpl CODE_C3750B
	lda.w #$FFC8
CODE_C3750B:						; from CODE_C37503
	cmp.w #$0038
	bmi CODE_C37513
	lda.w #$0038
CODE_C37513:						; from CODE_C3750B
	sta.b $CB
	sta.w $0786
	lda.w Ypos,x
	sta.w $08B6
	cmp.w $0788
	bpl CODE_C37534
	lda.w $0788
	sec
	sbc.w #$0004
	cmp.w $08B6
	bpl CODE_C37532
	lda.w $08B6
CODE_C37532:						; from CODE_C37513
	bra CODE_C37543
CODE_C37534:						; from CODE_C37513
	lda.w $0788
	clc
	adc.w #$0004
	cmp.w $08B6
	bmi CODE_C37543
	lda.w $08B6
CODE_C37543:						; from CODE_C37532, CODE_C37534
	cmp.w #$FF39
	bpl CODE_C3754B
	lda.w #$FF39
CODE_C3754B:						; from CODE_C37543
	cmp.w #$0100
	bmi CODE_C37553
	lda.w #$0100
CODE_C37553:						; from CODE_C3754B
	sta.b $CD
	sta.w $0788
	txa
	lsr a
	sta.w $05BA
	jmp.w CODE_C375EB
CODE_C37560:						; from CODE_C374CF
	cmp.w #$FFFF
	beq CODE_C375E1
	lda.w $0834
	cmp.w $0786
	bpl CODE_C3757E
	lda.w $0786
	sec
	sbc.w #$0002
	cmp.w $0834
	bpl CODE_C3757C
	lda.w $0834
CODE_C3757C:						; from CODE_C37560
	bra CODE_C3758D
CODE_C3757E:						; from CODE_C37560
	lda.w $0786
	clc
	adc.w #$0002
	cmp.w $0834
	bmi CODE_C3758D
	lda.w $0834
CODE_C3758D:						; from CODE_C3757C, CODE_C3757E
	cmp.w #$FFC8
	bpl CODE_C37595
	lda.w #$FFC8
CODE_C37595:						; from CODE_C3758D
	cmp.w #$0038
	bmi CODE_C3759D
	lda.w #$0038
CODE_C3759D:						; from CODE_C37595
	sta.b $CB
	sta.w $0786
	lda.w $08B6
	cmp.w $0788
	bpl CODE_C375BB
	lda.w $0788
	sec
	sbc.w #$0002
	cmp.w $08B6
	bpl CODE_C375B9
	lda.w $08B6
CODE_C375B9:						; from CODE_C3759D
	bra CODE_C375CA
CODE_C375BB:						; from CODE_C3759D
	lda.w $0788
	clc
	adc.w #$0002
	cmp.w $08B6
	bmi CODE_C375CA
	lda.w $08B6
CODE_C375CA:						; from CODE_C375B9, CODE_C375BB
	cmp.w #$FF39
	bpl CODE_C375D2
	lda.w #$FF39
CODE_C375D2:						; from CODE_C375CA
	cmp.w #$0100
	bmi CODE_C375DA
	lda.w #$0100
CODE_C375DA:						; from CODE_C375D2
	sta.b $CD
	sta.w $0788
	bra CODE_C375EB
CODE_C375E1:						; from CODE_C37560
	lda.b $CB
	sta.w $0786
	lda.b $CD
	sta.w $0788
CODE_C375EB:						; from CODE_C37553, CODE_C375DA
	lda.b d7
	sta.w timestep
	jsl.l SprSort
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l CODE_C37E57
	jsl.l CODE_C4CEDB
	stz.w $0782
CODE_C37609:						; from CODE_C37892, CODE_C378D1
	inc.w $2CE1
	ldx.b d7
	bne CODE_C37611
	inx
CODE_C37611:						; from CODE_C37609
	jsl.l CODE_C36CBF
	jsl.l CODE_C370A5
	lda.w #$0001
	sta.b d7
	bit.w $0774
	bmi CODE_C37634
	lda.b d2
	bit.w #$0F00
	bne CODE_C37634
	lda.b d0
	and.w #$FFF8
	ora.w #$0008
	sta.b d0
CODE_C37634:						; from CODE_C37611
	lda.b d0
	bit.w #$0008
	beq CODE_C3763E
	jmp.w CODE_C377DB
CODE_C3763E:						; from CODE_C37634
	sta.b d5
	lda.w #$FFFF
	sta.b d4
	sta.b $91
	sta.w $0774
	lda.w #$0016
	sta.b a0
CODE_C3764F:						; from CODE_C376AA
	ldy.b a0
	lda.w position,y
	bmi CODE_C376AA
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
	beq CODE_C376AA
	sec
	sbc.b d5
	beq CODE_C37684
	cmp.w #$0001
	beq CODE_C37684
	cmp.w #$0007
	bne CODE_C376AA
CODE_C37684:						; from CODE_C3764F
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
	bcs CODE_C376AA
	sta.b $91
	lda.b a0
	sta.b d4
CODE_C376AA:						; from CODE_C3764F, CODE_C37684
	dec.b a0
	dec.b a0
	bpl CODE_C3764F
	lda.b d4
	bmi CODE_C376CE
	lda.b $91
	cmp.w #$0002
	bcs CODE_C376CE
	lda.b d4
	sta.w $0774
	lda.w #$001E
	sta.b d7
	lda.w #$0020
	trb.w sflags
	jmp.w CODE_C374CF
CODE_C376CE:						; from CODE_C376AA
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
	beq CODE_C377A2
	lda.w Xvel,y
	bpl CODE_C3774F
	bit.w #$0080
	beq CODE_C37758
	sec
	sbc.w #$0100
	bra CODE_C37758
CODE_C3774F:						; from CODE_C376CE
	bit.w #$0080
	beq CODE_C37758
	clc
	adc.w #$0100
CODE_C37758:						; from CODE_C376CE, CODE_C3774F
	and.w #$FF00
	clc
	adc.b $03,s
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C3776A
	ora.w #$FF00
CODE_C3776A:						; from CODE_C37758
	clc
	adc.b d2
	sta.b d2
	lda.w Yvel,y
	bit.w #$0080
	bpl CODE_C37782
	bit.w #$0080
	beq CODE_C3778B
	sec
	sbc.w #$0100
	bra CODE_C3778B
CODE_C37782:						; from CODE_C3776A
	bit.w #$0080
	beq CODE_C3778B
	clc
	adc.w #$0100
CODE_C3778B:						; from CODE_C3776A, CODE_C37782
	and.w #$FF00
	clc
	adc.b $01,s
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C3779D
	ora.w #$FF00
CODE_C3779D:						; from CODE_C3778B
	clc
	adc.b d3
	sta.b d3
CODE_C377A2:						; from CODE_C376CE
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
DATA8_C377BB:						; not traced: a table read by CODE_C376CE
	db $00,$00
DATA8_C377BD:						; not traced: a table read by CODE_C376CE
	db $02,$00,$00,$00,$02,$00,$02,$00,$00,$00,$02,$00,$00,$00,$00,$00
	db $FE,$FF,$00,$00,$FE,$FF,$FE,$FF,$00,$00,$FE,$FF,$00,$00
CODE_C377DB:						; from CODE_C37634
	lda.w $0774
	cmp.w #$FFFF
	bne CODE_C37833
	lda.w PadControlObj
	cmp.w #$000F
	beq CODE_C37801
	asl a
	tax
	lda.w #$000F
	sta.w $05BA
	lda.w Xpos,x
	sta.w $0834
	lda.w Ypos,x
	sta.w $08B6
	bra CODE_C37833
CODE_C37801:						; from CODE_C377DB
	lda.w #$000F
	sta.w $05BA
	lda.w $0830
	cmp.w #$FF65
	bpl CODE_C37812
	lda.w #$FF65
CODE_C37812:						; from CODE_C37801
	cmp.w #$009B
	bmi CODE_C3781A
	lda.w #$009B
CODE_C3781A:						; from CODE_C37812
	sta.w $0834
	lda.w pucky
	cmp.w #$FED4
	bpl CODE_C37828
	lda.w #$FED4
CODE_C37828:						; from CODE_C3781A
	cmp.w #$012C
	bmi CODE_C37830
	lda.w #$012C
CODE_C37830:						; from CODE_C37828
	sta.w $08B6
CODE_C37833:						; from CODE_C377DB
	lda.b d1
	bit.w #$8000
	beq CODE_C37858
	lda.l $7E24DA
	beq CODE_C3784F
	jsl.l CODE_C5897B
	jsl.l CODE_C4CEDB
	lda.w #$0000
	sta.l $7E24DA
CODE_C3784F:						; from CODE_C37833
	lda.w sflags3
	eor.w #$0002
	sta.w sflags3
CODE_C37858:						; from CODE_C37833
	lda.b d3
	bit.w #$0020
	bne CODE_C37886
	bit.w #$0050
	bne CODE_C378AB
	lda.b d1
	bit.w #$2000
	bne CODE_C37892
	bit.w #$1000
	bne CODE_C3788F
	lda.b d3
	bit.w #$0080
	bne CODE_C378A1
	bit.w #$4000
	beq CODE_C378D1
	jsl.l suba4
	jsl.l suba4
	bra CODE_C378C3
CODE_C37886:						; from CODE_C37858
	jsl.l suba4
	ldx.w #$0003
	bra CODE_C378BC
CODE_C3788F:						; from CODE_C37858
	jmp.w CODE_C378E7
CODE_C37892:						; from CODE_C37858
	lda.w #$FFFF
	sta.w $0774
	lda.w #$0020
	trb.w sflags
	jmp.w CODE_C37609
CODE_C378A1:						; from CODE_C37858
	jsl.l adda4
	jsl.l adda4
	bra CODE_C378C3
CODE_C378AB:						; from CODE_C37858
	jsl.l adda4
	ldx.w #$0003
	lda.b d3
	bit.w #$0010
	bne CODE_C378BC
	ldx.w #$0006
CODE_C378BC:						; from CODE_C37886, CODE_C378AB
	ldy.w #$0000
	jsl.l WaitFrames_Inc
CODE_C378C3:						; from CODE_C37858, CODE_C378A1, CODE_C378DC
	lda.w #$0001
	sta.b d7
	lda.w #$0002
	trb.w sflags3
	jmp.w CODE_C374CF
CODE_C378D1:						; from CODE_C37858
	lda.w sflags3
	bit.w #$0002
	bne CODE_C378DC
	jmp.w CODE_C37609
CODE_C378DC:						; from CODE_C378D1
	jsl.l adda4
	lda.b d7
	beq CODE_C378C3
	jmp.w CODE_C374CF
CODE_C378E7:						; from CODE_C3788F
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
	bne CODE_C37949
	lda.w $0784
	beq CODE_C37949
	lda.w $1864
	beq CODE_C37949
	cmp.w #$0004
	beq CODE_C37949
	lda.w $24C4
	cmp.w #$0002
	bcc CODE_C37949
	jmp.w CODE_C37949
CODE_C37949:						; from CODE_C378E7
	lda.w $2CDF
	sta.b $48
	rtl
suba4:								; from CODE_C3748A, CODE_C37858, CODE_C37886 and other segments
	lda.b a4
	cmp.w #$0000
	bne CODE_C3796F
	lda.b $75
	cmp.w #$007F
	bne CODE_C3796F
	lda.w sflags
	bit.w #$0010
	beq CODE_C379B6
	lda.w #$007F
	sta.b $75
	lda.w #$8EF8
	sta.b a4
CODE_C3796F:						; from suba4
	lda.b a4
	sec
	sbc.w #$007A
	sta.b a4
	lda.b $75
	sbc.w #$0000
	sta.b $75
	lda.b a4
	cmp.w recbpr
	beq CODE_C37989
	jml.l RestoreReplayFrame
CODE_C37989:						; from CODE_C3796F
	lda.b $75
	cmp.w $07E2
	beq CODE_C37994
	jml.l RestoreReplayFrame
CODE_C37994:						; from CODE_C37989
	lda.b a4
	clc
	adc.w #$007A
	sta.b a4
	bcc CODE_C379A0
	inc.b $75
CODE_C379A0:						; from CODE_C37994
	cmp.w #$8EF8
	bne CODE_C379B3
	lda.b $75
	cmp.w #$007F
	bne CODE_C379B3
	lda.w #$007F
	sta.b $75
	stz.b a4
CODE_C379B3:						; from CODE_C379A0
	stz.b d7
	rtl
CODE_C379B6:						; from suba4
	jsl.l RestoreReplayFrame
	stz.b d7
	rtl
adda4:								; from CODE_C3749B, CODE_C378AB, CODE_C378A1, ...
	stz.b d7
	lda.w sflags
	bit.w #$0400
	beq CODE_C379EC
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
	bne CODE_C379EC
	lda.b tmp1
	cmp.w $07E2
	bne CODE_C379EC
	rtl
CODE_C379EC:						; from adda4
	lda.b a4
	cmp.w recbpr
	bne CODE_C379FB
	lda.b $75
	cmp.w $07E2
	bne CODE_C379FB
	rtl
CODE_C379FB:						; from CODE_C379EC
	jsl.l RestoreReplayFrame
adda43:								; from adda4 and other segments
	lda.b a4
	clc
	adc.w #$007A
	sta.b a4
	bcc CODE_C37A0B
	inc.b $75
CODE_C37A0B:						; from adda43
	cmp.w #$8EF8
	bne CODE_C37A1E
	lda.b $75
	cmp.w #$007F
	bne CODE_C37A1E
	lda.w #$007F
	sta.b $75
	stz.b a4
CODE_C37A1E:						; from CODE_C37A0B
	rtl
CODE_C37A1F:						; no caller found (not traced)
	lda.b $80
	sta.w Xpos,x
	lda.b $80
	sta.w r3
	and.w #$000F
	bit.w #$0008
	beq CODE_C37A34
	ora.w #$00F0
CODE_C37A34:						; from CODE_C37A1F
	sta.w $0815,x
	lda.b $80
	sta.w Ypos,x
	lda.w r3
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0008
	beq CODE_C37A4B
	ora.w #$00F0
CODE_C37A4B:						; from CODE_C37A34
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
	bpl CODE_C37A1F
	lda.b $80
	sta.w $0818,x
	lda.b $80
	sta.w r3
	and.w #$000F
	bit.w #$0008
	beq CODE_C37A90
	ora.w #$00F0
CODE_C37A90:						; from CODE_C37A4B
	sta.w $0819,x
	lda.b $80
	sta.w $089A,x
	lda.w r3
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0008
	beq CODE_C37AA7
	ora.w #$00F0
CODE_C37AA7:						; from CODE_C37A90
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
CODE_C37AD5:						; from CODE_C37B01
	lda.b $80
	sta.w $082C,x
	lda.b $80
	sta.w r3
	and.w #$000F
	bit.w #$0008
	beq CODE_C37AEA
	ora.w #$00F0
CODE_C37AEA:						; from CODE_C37AD5
	sta.w $082D,x
	lda.b $80
	sta.w $08AE,x
	lda.w r3
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0008
	beq CODE_C37B01
	ora.w #$00F0
CODE_C37B01:						; from CODE_C37AEA
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
	bcc CODE_C37AD5
	ldx.w tmp0
	ldy.w #$0002
CODE_C37B39:						; from CODE_C37B74
	lda.b $80
	sta.w rostnum,x
	lda.b $80
	sta.w $0EE2,x
	stz.w $0A21,x
	lda.b $80
	sta.w r3
	and.w #$000F
	cmp.w #$000F
	bne CODE_C37B59
	lda.w #$FFFF
	sta.w $0A21,x
CODE_C37B59:						; from CODE_C37B39
	sta.w position,x
	stz.w $0A23,x
	lda.w r3
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$000F
	cmp.w #$000F
	bne CODE_C37B74
	lda.w #$FFFF
	sta.w $0A23,x
CODE_C37B74:						; from CODE_C37B59
	sta.w $0A22,x
	inx
	inx
	inx
	inx
	dey
	bpl CODE_C37B39
	lda.b $80
	sta.w puckz
	bpl CODE_C37B8A
	lda.w #$FFFF
	bra CODE_C37B8D
CODE_C37B8A:						; from CODE_C37B74
	lda.w #$0000
CODE_C37B8D:						; from CODE_C37B74
	sta.w $08D9
	lda.b $80
	sta.w shadowz
	bpl CODE_C37B9C
	lda.w #$FFFF
	bra CODE_C37B9F
CODE_C37B9C:						; from CODE_C37B8D
	lda.w #$0000
CODE_C37B9F:						; from CODE_C37B8D
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
	bpl CODE_C37C26
	lda.w #$FFFF
	bra CODE_C37C29
CODE_C37C26:						; from CODE_C37B9F
	lda.w #$0000
CODE_C37C29:						; from CODE_C37B9F
	sta.w $1140
	lda.w sflags
	bit.w #$0020
	bne CODE_C37C50
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
CODE_C37C50:						; from CODE_C37C29
	lda.b $80
	lda.b $80
	lda.b $80
	lda.b $80
	lda.b $80
	sta.w $06F2
	lda.b $80
	sta.w $06F3
RestoreReplayFrame:					; from CODE_C3796F, CODE_C379B6, CODE_C37989, CODE_C379FB, ...
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
CODE_C37C7C:						; from CODE_C37CA7
	lda.l WMDATA
	sta.w Xpos,x
	lda.l WMDATA
	sta.b r3
	and.b #$0F
	bit.b #$08
	beq CODE_C37C91
	ora.b #$F0
CODE_C37C91:						; from CODE_C37C7C
	sta.w $0815,x
	lda.l WMDATA
	sta.w Ypos,x
	lda.b r3
	lsr a
	lsr a
	lsr a
	lsr a
	bit.b #$08
	beq CODE_C37CA7
	ora.b #$F0
CODE_C37CA7:						; from CODE_C37C91
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
	bpl CODE_C37C7C
	lda.b #$05
	sta.b d1
	ldx.w #$0000
CODE_C37CDE:						; from CODE_C37D17
	lda.l WMDATA
	sta.w rostnum,x
	lda.l WMDATA
	sta.w $0EE2,x
	stz.w $0A21,x
	lda.l WMDATA
	sta.b r3
	and.b #$0F
	cmp.b #$0F
	bne CODE_C37D00
	lda.b #$FF
	sta.w $0A21,x
CODE_C37D00:						; from CODE_C37CDE
	sta.w position,x
	stz.w $0A23,x
	lda.b r3
	lsr a
	lsr a
	lsr a
	lsr a
	and.b #$0F
	cmp.b #$0F
	bne CODE_C37D17
	lda.b #$FF
	sta.w $0A23,x
CODE_C37D17:						; from CODE_C37D00
	sta.w $0A22,x
	inx
	inx
	inx
	inx
	dec.b d1
	bpl CODE_C37CDE
	lda.l WMDATA
	sta.w puckz
	bpl CODE_C37D2F
	lda.b #$FF
	bra CODE_C37D31
CODE_C37D2F:						; from CODE_C37D17
	lda.b #$00
CODE_C37D31:						; from CODE_C37D17
	sta.w $08D9
	lda.l WMDATA
	sta.w shadowz
	bpl CODE_C37D41
	lda.b #$FF
	bra CODE_C37D43
CODE_C37D41:						; from CODE_C37D31
	lda.b #$00
CODE_C37D43:						; from CODE_C37D31
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
	bpl CODE_C37DDD
	lda.b #$FF
	bra CODE_C37DDF
CODE_C37DDD:						; from CODE_C37D43
	lda.b #$00
CODE_C37DDF:						; from CODE_C37D43
	sta.w $1140
	lda.w sflags
	bit.b #$20
	bne CODE_C37E11
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
	bra CODE_C37E2F
CODE_C37E11:						; from CODE_C37DDF
	lda.l WMDATA
	lda.l WMDATA
	lda.l WMDATA
	lda.l WMDATA
	lda.l WMDATA
	sta.w $06F2
	lda.l WMDATA
	sta.w $06F3
CODE_C37E2F:						; from CODE_C37DDF
	rep #$20
	lda.w recsfx
	and.w #$00FF
	cmp.w #$0080
	bcc CODE_C37E3F
	ora.w #$FF00
CODE_C37E3F:						; from CODE_C37E2F
	sta.w recsfx
	lda.w recsfx2
	and.w #$00FF
	cmp.w #$0080
	bcc CODE_C37E50
	ora.w #$FF00
CODE_C37E50:						; from CODE_C37E3F
	sta.w recsfx2
	pla
	sta.b d1
	rtl
CODE_C37E57:						; from CODE_C375EB and other segments
	lda.w $2CE1
	sta.b $48
	sta.b $26
	jsl.l CODE_C526E8
	jsl.l CODE_C526FB
	lda.w $0874
	cmp.w $0894
	beq CODE_C37E7F
	ldx.w #$2580
	stx.b tmp2
	ldx.w #$2035
	stx.b tmp1
	sta.w $0894
	jsl.l CODE_C5F368
CODE_C37E7F:						; from CODE_C37E57
	jsl.l CODE_C382B8
	jsl.l CODE_C5F3DB
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
	beq CODE_C37F40
	ldx.w #$0100
	ldy.w #$1000
	cmp.w #$0048
	bcs CODE_C37F04
	ldy.w #$087D
	cmp.w #$0016
	bcs CODE_C37EFF
	ldy.w #$04B1
	bra CODE_C37F14
CODE_C37EFF:						; from Sroot
	ldx.w #$04B0
	bra CODE_C37F14
CODE_C37F04:						; from Sroot
	ldx.w #$087C
	cmp.w #$0096
	bcs CODE_C37F11
	ldy.w #$0C40
	bra CODE_C37F14
CODE_C37F11:						; from CODE_C37F04
	ldx.w #$0C3F
CODE_C37F14:						; from Sroot, CODE_C37F04, CODE_C37EFF
	stx.b p0
	sty.b p1
CODE_C37F18:						; from CODE_C37F18, CODE_C37F37
	lda.b p0
	clc
	adc.b p1
	ror a
	cmp.b p0
	beq CODE_C37F3C
	pha
	tax
	jsl.l Mul16U
	lda.b d0
	cmp.b r2
	lda.b $81
	sbc.b $36
	bcs CODE_C37F37
	pla
	sta.b p1
	bra CODE_C37F18
CODE_C37F37:						; from CODE_C37F18
	pla
	sta.b p0
	bra CODE_C37F18
CODE_C37F3C:						; from CODE_C37F18
	plx
	sta.b d0
	rtl
CODE_C37F40:						; from Sroot
	stz.b p0
	lda.w #$00FF
	sta.b p1
CODE_C37F47:						; from CODE_C37F47, CODE_C37F64
	lda.b p0
	clc
	adc.b p1
	ror a
	cmp.b p0
	beq CODE_C37F69
	pha
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3884A,x
	cmp.b d0
	bcc CODE_C37F64
	pla
	sta.b p1
	bra CODE_C37F47
CODE_C37F64:						; from CODE_C37F47
	pla
	sta.b p0
	bra CODE_C37F47
CODE_C37F69:						; from CODE_C37F47
	plx
	sta.b d0
	rtl
vtoa:								; from CODE_C3764F and other segments
	lda.w #$FFFF
	bit.b d0
	bpl CODE_C37F8C
	bit.b d1
	bpl CODE_C37F7E
	lda.w #$0005
	sta.b d0
	rtl
CODE_C37F7E:						; from vtoa
	beq CODE_C37F86
	lda.w #$0007
	sta.b d0
	rtl
CODE_C37F86:						; from CODE_C37F7E
	lda.w #$0006
	sta.b d0
	rtl
CODE_C37F8C:						; from vtoa
	beq CODE_C37FA6
	bit.b d1
	bpl CODE_C37F98
	lda.w #$0003
	sta.b d0
	rtl
CODE_C37F98:						; from CODE_C37F8C
	beq CODE_C37FA0
	lda.w #$0001
	sta.b d0
	rtl
CODE_C37FA0:						; from CODE_C37F98
	lda.w #$0002
	sta.b d0
	rtl
CODE_C37FA6:						; from CODE_C37F8C
	bit.b d1
	beq CODE_C37FB6
	bpl CODE_C37FB2
	lda.w #$0004
	sta.b d0
	rtl
CODE_C37FB2:						; from CODE_C37FA6
	inc a
	sta.b d0
	rtl
CODE_C37FB6:						; from CODE_C37FA6
	lda.w #$0008
	sta.b d0
	rtl
SuperAdd:							; no caller found (not traced)
	phx
	lda.l $7E23F8
	clc
	adc.b d0
	sta.l $7E23F8
	bcc CODE_C37FDF
	ldx.w #$0002
CODE_C37FCD:						; from CODE_C37FCD
	lda.l $7E23F8,x
	inc a
	sta.l $7E23F8,x
	bne CODE_C37FDF
	inx
	inx
	cpx.w #$0010
	bne CODE_C37FCD
CODE_C37FDF:						; from SuperAdd, CODE_C37FCD
	plx
	clc
	rtl

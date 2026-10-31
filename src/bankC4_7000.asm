; Segment bankC4_7000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4702E
CODE_C4702E:						; called from other segments
	jsl.l CODE_C495BB
	lda.w $0B00,x
	sec
	sbc.b $9B
	sta.w $0B00,x
	bmi CODE_C47040
	jmp.w CODE_C470E7
CODE_C47040:						; from CODE_C4702E
	adc.w #$0005
	sta.w $0B00,x
	jsl.l CODE_C46BF6
	pei ($83)
	pei ($7F)
	txa
	jsl.l $C37FE2
	lda.b $7F
	eor.w #$FFFF
	inc a
	sec
	sbc.w $09A1,x
	and.w #$00FF
	bit.w #$0080
	beq CODE_C47068
	ora.w #$FF00
CODE_C47068:						; from CODE_C47040
	clc
	adc.b $01,s
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.b $83
	eor.w #$FFFF
	inc a
	sec
	sbc.w $09C1,x
	and.w #$00FF
	bit.w #$0080
	beq CODE_C47086
	ora.w #$FF00
CODE_C47086:						; from CODE_C47068
	clc
	adc.b $03,s
	sec
	sbc.w $0896,x
	sta.b $83
	pla
	pla
	jsl.l $C37F6D
	lda.b $7F
	sta.w $0B80,x
	lda.w $0A20,x
	beq CODE_C470E7
	lda.w $09BC
	sta.b $7F
	lda.w $09DC
	sta.b $83
	jsl.l $C37F6D
	lda.b $7F
	cmp.w #$0008
	beq CODE_C470BC
	eor.w #$0004
	cmp.w $0C40,x
	beq CODE_C470E7
CODE_C470BC:						; from CODE_C47086
	lda.w $08B2
	sec
	sbc.w $0896,x
	sta.b $83
	pha
	lda.w $0830
	sec
	sbc.w $0814,x
	sta.b $7F
	pha
	jsl.l $C37F6D
	lda.b $7F
	sta.b $9F
	pla
	sta.b $7F
	sta.b $2C
	pla
	sta.b $83
	lda.w $0C40,x
	cmp.b $9F
	beq CODE_C470F0
CODE_C470E7:						; from CODE_C4702E, CODE_C47086, CODE_C470F0, CODE_C47120
	lda.w $0B80,x
	sta.b $7F
	jml.l CODE_C4694F
CODE_C470F0:						; from CODE_C470BC
	lda.w $05A0
	bmi CODE_C470E7
	lda.b $2C
	lsr a
	lsr a
	and.w #$01FE
	tax
	lda.l $C38A4A,x
	sta.b $7F
	lda.b $83
	and.w #$07F8
	lsr a
	lsr a
	tax
	lda.l $C38A4A,x
	ldx.b $6F
	adc.b $7F
	cmp.w #$000E
	bcc CODE_C470E7
	cmp.w #$0028
	bcs CODE_C47120
	jmp.w CODE_C45606
CODE_C47120:						; from CODE_C470F0
	bra CODE_C470E7
CODE_C47122:						; called from other segments
	lda.w $10F1
	bit.w #$0040
	beq CODE_C47132
	lda.b $6B
	inc a
	inc a
	jsl.l $C382B6
CODE_C47132:						; from CODE_C47122
	ldy.w $14F9,x
	bmi CODE_C47140
	lda.w $00C1,y
	and.w #$FFF0
	beq CODE_C47140
	rtl
CODE_C47140:						; from CODE_C47132
	lda.w $09A0,x
	tax
	lda.w #$00C0
	jsl.l Mul16x8XS
	ldx.b $6F
	lda.b $35
	sta.w $09A0,x
	lda.w $09C0,x
	tax
	lda.w #$00C0
	jsl.l Mul16x8XS
	ldx.b $6F
	lda.b $35
	sta.w $09C0,x
	txa
	lsr a
	cmp.w $05A0
	bne CODE_C47177
	lda.w #$FFFF
	sta.w $05A0
	lda.w #$0708
	sta.w $0CE0,x
CODE_C47177:						; from CODE_C47140
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C471A7
	and.w #$FFFD
	sta.w $0D60,x
	jsl.l CODE_C471E2
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
	lda.w #$005A
	sta.w $0B20,x
	lda.b $CB
	bpl CODE_C471A2
	lda.w #$FFA6
	sta.w $0B20,x
CODE_C471A2:						; from CODE_C47177
	lda.b $CD
	sta.w $0B40,x
CODE_C471A7:						; from CODE_C47177
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b $63
	lda.w $0B20,x
	sta.b $7F
	lda.w $0B40,x
	sta.b $83
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bpl CODE_C471ED
	lda.w #$2824
	sta.b $83
	sta.w $1000,x
	cpx.w $07EA
	bne CODE_C471DE
	lda.w #$27B2
	sta.b $83
	lda.w #$FFFF
	sta.w $07EA
CODE_C471DE:						; from CODE_C471A7
	jsl.l CODE_C457A1
CODE_C471E2:						; from CODE_C47177 and other segments
	lda.w #$0078
	jsl.l $C37EAA
	sta.w $0AE0,x
	rtl
CODE_C471ED:						; from CODE_C471A7
	jmp.w CODE_C45950
CODE_C471F0:						; called from other segments
	jsl.l CODE_C47FB5
	jsl.l CODE_C4724D
	jsl.l CODE_C4740D
	jml.l $C38C4A
CODE_C47200:						; from CODE_C47FD4 and other segments
	stz.b $83
	lda.w $08B2
	sec
	sbc.w #$005C
	bpl CODE_C47218
	inc.b $83
	inc.b $83
	lda.w $08B2
	sec
	sbc.w #$FFA4
	bpl CODE_C47230
CODE_C47218:						; from CODE_C47200
	lda.w $10F1
	bit.w #$0002
	beq CODE_C47227
	lda.b $83
	eor.w #$0002
	sta.b $83
CODE_C47227:						; from CODE_C47218
	ldy.b $83
	lda.w $126F,y
	inc a
	sta.w $126F,y
CODE_C47230:						; from CODE_C47200
	rtl
CODE_C47231:						; from CODE_C47FD4 and other segments
	stz.b $83
	lda.w $12C7
	sec
	sbc.w $12C9
	beq CODE_C4724C
	bpl CODE_C47243
	lda.w #$0002
	sta.b $83
CODE_C47243:						; from CODE_C47231
	ldy.b $83
	lda.w $1273,y
	inc a
	sta.w $1273,y
CODE_C4724C:						; from CODE_C47231
	rtl
CODE_C4724D:						; from CODE_C471F0 and other segments
	lda.w $2CF5
	beq CODE_C47255
	jmp.w CODE_C4730E
CODE_C47255:						; from CODE_C4724D
	lda.w #$10F9
	sta.b $63
CODE_C4725A:						; from CODE_C4725A, CODE_C472B9, CODE_C4730F, CODE_C4730B
	lda.b ($63)
	inc.b $63
	inc.b $63
	and.w #$00FF
	cmp.w #$0034
	beq CODE_C4725A
	tay
	bne CODE_C4726E
	jmp.w CODE_C4730E
CODE_C4726E:						; from CODE_C4725A
	lda.w $10F1
	bit.w #$0004
	bne CODE_C472B9
	sty.b $7F
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b $67
	lda.b [$67],y
	clc
	adc.b $67
	sta.b $67
	lda.b [$67]
	and.w #$00FF
	beq CODE_C472B5
	lda.w $05A0
	bmi CODE_C4730F
	lsr a
	sec
	sbc.w #$0006
	sta.b $7F
	dec.b $63
	lda.b ($63)
	inc.b $63
	and.w #$00FF
	bit.w #$0080
	beq CODE_C472AD
	ora.w #$FF00
CODE_C472AD:						; from CODE_C4726E
	sec
	sbc.w #$0006
	eor.b $7F
	bmi CODE_C4730F
CODE_C472B5:						; from CODE_C4726E
	jsl.l CODE_C47323
CODE_C472B9:						; from CODE_C4726E
	dec.b $63
	lda.b ($63)
	tay
	ora.w #$0080
	sta.b ($63)
	inc.b $63
	tya
	bit.w #$0080
	beq CODE_C472CE
	jmp.w CODE_C4725A
CODE_C472CE:						; from CODE_C472B9
	dec.b $63
	dec.b $63
	lda.b ($63)
	inc.b $63
	inc.b $63
	and.w #$00FF
	sta.b $7F
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b $67
	lda.b [$67],y
	clc
	adc.b $67
	sta.b $67
	ldy.w #$0001
	lda.b [$67],y
	and.w #$00FF
	asl a
	asl a
	asl a
	asl a
	asl a
	sta.b $83
	sec
	sbc.w $113B
	beq CODE_C4730B
	bmi CODE_C4730B
	lda.b $83
	sta.w $113B
CODE_C4730B:						; from CODE_C4730F, CODE_C472CE
	jmp.w CODE_C4725A
CODE_C4730E:						; from CODE_C4724D, CODE_C4725A
	rtl
CODE_C4730F:						; from CODE_C4726E, CODE_C472AD
	lda.w #$0008
	tsb.w $10F1
	bne CODE_C4730B
	lda.w #$0030
	sta.b $7F
	jsl.l $C38C6D
	jmp.w CODE_C4725A
CODE_C47323:						; from CODE_C472B5 and other segments
	lda.w #$FFFF
	tsb.w $10F3
	beq CODE_C4732E
	jmp.w CODE_C473DE
CODE_C4732E:						; from CODE_C47323
	stz.b $7F
	stz.b $83
	dec.b $63
	dec.b $63
	lda.b ($63)
	inc.b $63
	inc.b $63
	and.w #$00FF
	cmp.w #$000E
	beq CODE_C4737E
	pha
	lda.w $2004
	sta.b $7F
	lda.w $2006
	sta.b $83
	pla
	cmp.w #$0006
	beq CODE_C4737E
	ldy.w $0830
	sty.b $7F
	ldy.w $08B2
	sty.b $83
	cmp.w #$000C
	bne CODE_C4737E
	dec.b $63
	lda.b ($63)
	inc.b $63
	and.w #$00FF
	asl a
	tay
	lda.w #$0258
	sta.b $83
	lda.w $0FE0,y
	beq CODE_C4737E
	lda.w #$FDA8
	sta.b $83
CODE_C4737E:						; from CODE_C4732E
	lda.b $7F
	sta.b $9F
	sec
	sbc.w #$0050
	bmi CODE_C4738D
	lda.w #$0050
	sta.b $7F
CODE_C4738D:						; from CODE_C4737E
	lda.b $7F
	sec
	sbc.w #$FFB0
	bpl CODE_C4739A
	lda.w #$FFB0
	sta.b $7F
CODE_C4739A:						; from CODE_C4738D
	lda.b $83
	sec
	sbc.w #$00AC
	bmi CODE_C473B5
	lda.w #$00D4
	sta.b $83
	lda.w #$0050
	sta.b $7F
	lda.b $9F
	bpl CODE_C473B5
	lda.w #$FFB0
	sta.b $7F
CODE_C473B5:						; from CODE_C4739A
	lda.b $83
	sec
	sbc.w #$FF54
	bpl CODE_C473D0
	lda.w #$FF2C
	sta.b $83
	lda.w #$0050
	sta.b $7F
	lda.b $9F
	bpl CODE_C473D0
	lda.w #$FFB0
	sta.b $7F
CODE_C473D0:						; from CODE_C473B5
	lda.b $7F
	sta.w $2034
	lda.b $83
	sta.w $2036
	jsl.l CODE_C51F7C
CODE_C473DE:						; from CODE_C47323
	lda.b $5D
	sec
	sbc.w $07EC
	cmp.w #$003C
	bcc CODE_C473E9
CODE_C473E9:						; from CODE_C473DE
	lda.w $0772
	bne CODE_C473F4
	lda.w #$001E
	sta.w $0772
CODE_C473F4:						; from CODE_C473E9
	lda.w #$0012
	jsl.l $CF040B
	stz.w $113B
	lda.w #$0004
	tsb.w $10F1
	lda.w #$000A
	sta.b $7F
	jml.l $C38C6D
CODE_C4740D:						; from CODE_C471F0 and other segments
	lda.w $10F1
	bit.w #$0004
	bne CODE_C47416
CODE_C47415:						; from CODE_C4741E, CODE_C47431
	rtl
CODE_C47416:						; from CODE_C4740D
	lda.w $113B
	bpl CODE_C4741E
	jmp.w CODE_C474C4
CODE_C4741E:						; from CODE_C47416
	sec
	sbc.b $9B
	sta.w $113B
	bpl CODE_C47415
	lda.w #$0008
	trb.w $10F1
	lda.w #$10F9
	sta.b $63
CODE_C47431:						; from CODE_C47431
	lda.b ($63)
	inc.b $63
	inc.b $63
	and.w #$00FF
	cmp.w #$0034
	beq CODE_C47431
	tay
	beq CODE_C47415
	dec.b $63
	dec.b $63
	lda.b ($63)
	inc.b $63
	inc.b $63
	and.w #$00FF
	sta.b $7F
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b $67
	clc
	adc.b [$67],y
	sta.b $67
	lda.b [$67]
	and.w #$00FF
	beq CODE_C47431
	cmp.w #$0001
	beq CODE_C47431
	lda.w #$0400
	tsb.w $10F5
	jsl.l FadeOutWait
	jsl.l CODE_C5226A
	lda.w #$0038
	sta.b $CB
	stz.b $CD
	jsl.l CODE_C52284
	lda.w #$FF00
	tsb.w $05A0
	ldx.w #$001C
	stx.b $6F
	lda.w #$001A
	sta.b $7F
	jsl.l CODE_C43734
	ldx.b $6F
	lda.w #$1C20
	sta.w $0AE0,x
	lda.w #$FF00
	tsb.w $1147
	stz.w $1145
	jsl.l $C38C4A
	lda.w #$0032
	sta.w $1145
	stz.b $7F
	stz.w $009F
	phx
	jsl.l $C38CFC
	plx
	stz.w fadestep
	rtl
CODE_C474C4:						; from CODE_C47416
	jsl.l CODE_C47F7A
	lda.w $1145
	bmi CODE_C474D0
	jmp.w CODE_C47748
CODE_C474D0:						; from CODE_C474C4
	lda.w $1147
	bmi CODE_C474D8
	jmp.w CODE_C47748
CODE_C474D8:						; from CODE_C474D0
	pei ($7F)
	pei ($81)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
CODE_C474EC:						; from CODE_C476E5
	lda.w #$10F9
	sta.b $63
CODE_C474F1:						; from CODE_C474F1
	lda.b ($63)
	inc.b $63
	inc.b $63
	and.w #$00FF
	cmp.w #$0034
	beq CODE_C474F1
	cmp.w #$0000
	bne CODE_C47507
	jmp.w CODE_C476F8
CODE_C47507:						; from CODE_C474F1, CODE_C47507
	lda.b ($63)
	inc.b $63
	inc.b $63
	cmp.w #$0000
	bne CODE_C47507
	dec.b $63
	dec.b $63
	dec.b $63
	dec.b $63
	lda.b ($63)
	pha
	and.w #$7FFF
	sta.b ($63)
	pla
	bmi CODE_C4753F
	lda.b ($63)
	xba
	and.w #$00FF
	asl a
	sta.b $83
	tay
	lda.w $0A20,y
	bmi CODE_C47537
	jmp.w CODE_C4770C
CODE_C47537:						; from CODE_C47507
	lda.w #$0000
	sta.b ($63)
	jmp.w CODE_C4770C
CODE_C4753F:						; from CODE_C47507
	lda.b ($63)
	and.w #$00FF
	sta.b $7F
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b $67
	lda.b [$67],y
	clc
	adc.b $67
	sta.b $67
	cmp.w #$455B
	bne CODE_C47560
	jmp.w CODE_C476E1
CODE_C47560:						; from CODE_C4753F
	lda.b [$67]
	and.w #$00FF
	sta.b $87
	bne CODE_C4756C
	jmp.w CODE_C476E5
CODE_C4756C:						; from CODE_C47560
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	pei ($73)
	pei ($75)
	jsl.l CODE_C510DF
	lda.b ($63)
	xba
	and.w #$00FF
	asl a
	sta.b $83
	tax
	stx.b $6F
	stz.b $7F
	stz.b $6B
	lda.w #$0002
	sta.b $67
	lda.w $1020,x
	beq CODE_C475BA
	lda.w #$8000
	sta.b $7F
	stz.b $67
	lda.w #$0002
	sta.b $6B
	lda.w $14E3
	clc
	adc.w #$0014
	bmi CODE_C475BA
	sta.w $14E3
CODE_C475BA:						; from CODE_C4756C
	ldy.b $6B
	lda.w $1267,y
	inc a
	sta.w $1267,y
	lda.w $126B,y
	clc
	adc.b $87
	sta.w $126B,y
	lda.w $0DC0,x
	and.w #$00FF
	ora.b $7F
	sta.w $1153
	lda.w $0DC0,x
	sta.b $7F
	lda.b $6B
	beq CODE_C475E3
	lda.w #$001A
CODE_C475E3:						; from CODE_C475BA
	phx
	clc
	adc.b $7F
	tax
	sep #$20
	lda.w $14AF,x
	rep #$20
	and.w #$00FF
	clc
	adc.b $87
	sep #$20
	sta.w $14AF,x
	rep #$20
	plx
	lda.w $1159
	cmp.w #$0041
	bcs CODE_C47635
	asl a
	asl a
	tay
	jsl.l CODE_C510DF
	lda.b $7F
	sta.w $115B,y
	iny
	iny
	lda.w $1153
	cmp.w #$0080
	bmi CODE_C4761E
	ora.w #$0080
CODE_C4761E:						; from CODE_C475E3
	sep #$20
	sta.w $115B,y
	rep #$20
	iny
	lda.b ($63)
	and.w #$00FF
	sep #$20
	sta.w $115B,y
	rep #$20
	inc.w $1159
CODE_C47635:						; from CODE_C475E3
	lda.w $1153
	and.w #$00FF
	bit.w #$0080
	beq CODE_C47643
	ora.w #$FF00
CODE_C47643:						; from CODE_C47635
	asl a
	sta.b $7F
	phx
	ldx.w #$003C
	lda.b $87
	and.w #$00FF
	jsl.l Mul8U
	ora.w #$2000
	sta.b $87
	plx
	lda.b $6B
	beq CODE_C47660
	lda.w #$0034
CODE_C47660:						; from CODE_C47643
	clc
	adc.b $7F
	tay
	lda.w $1373,y
	bmi CODE_C4766E
	and.w #$1000
	tsb.b $87
CODE_C4766E:						; from CODE_C47660
	lda.b $87
	sta.w $1373,y
	lda.w #$1000
	trb.b $87
	pei ($65)
	pei ($63)
	lda.b $6B
	beq CODE_C47683
	lda.w #$001A
CODE_C47683:						; from CODE_C4766E
	sta.b $63
	lda.w #$0018
	sta.b $83
CODE_C4768A:						; from CODE_C4768A
	ldy.b $63
	inc.b $63
	lda.w $13DB,y
	bit.w #$0080
	bne CODE_C4769A
	dec.b $83
	bpl CODE_C4768A
CODE_C4769A:						; from CODE_C4768A
	lda.b $7F
	ora.w #$FF00
	sta.w $13DB,y
	pla
	sta.b $63
	pla
	sta.b $65
	lda.w #$000D
	sta.b $7F
	jsl.l CODE_C4373E
	pla
	sta.b $75
	pla
	sta.b $73
	pla
	sta.b $71
	pla
	sta.b $6F
	pla
	sta.b $6D
	pla
	sta.b $6B
	pla
	sta.b $69
	pla
	sta.b $67
	pla
	sta.b $85
	pla
	sta.b $83
	pla
	sta.b $81
	pla
	sta.b $7F
	ldx.b $6F
	jsl.l $C38C6D
	jsl.l CODE_C513F4
	bra CODE_C4770C
CODE_C476E1:						; from CODE_C4753F
	jsl.l CODE_C4866D
CODE_C476E5:						; from CODE_C47560
	lda.w #$0000
	sta.b ($63)
	lda.w $2CF5
	beq CODE_C476F2
	jmp.w CODE_C474EC
CODE_C476F2:						; from CODE_C476E5
	jsl.l $C38C6D
	bra CODE_C4770C
CODE_C476F8:						; from CODE_C474F1
	lda.w #$0004
	trb.w $10F1
	ldx.w #$001C
	stx.b $6F
	lda.w #$001B
	sta.b $7F
	jsl.l CODE_C4373E
CODE_C4770C:						; from CODE_C47507, CODE_C47537, CODE_C4769A, CODE_C476F2
	lda.w $1864
	cmp.w #$0001
	beq CODE_C47728
	lda.w $18BE
	bne CODE_C47728
	stz.b $6B
	jsl.l CODE_C47749
	lda.w #$0002
	sta.b $6B
	jsl.l CODE_C47749
CODE_C47728:						; from CODE_C4770C
	pla
	sta.b $71
	pla
	sta.b $6F
	pla
	sta.b $6D
	pla
	sta.b $6B
	pla
	sta.b $69
	pla
	sta.b $67
	pla
	sta.b $65
	pla
	sta.b $63
	pla
	sta.b $81
	pla
	sta.b $7F
	ldx.b $6F
CODE_C47748:						; from CODE_C474C4, CODE_C474D0
	rtl
CODE_C47749:						; from CODE_C4770C and other segments
	lda.w #$0006
	sta.b $83
	lda.w #$0032
	sta.b $7F
CODE_C47753:						; from CODE_C47779
	lda.b $6B
	beq CODE_C4775A
	lda.w #$0034
CODE_C4775A:						; from CODE_C47753
	clc
	adc.b $7F
	tay
	lda.w $1373,y
	bmi CODE_C47779
	beq CODE_C47779
	and.w #$DFFF
	sta.w $1373,y
	bit.w #$5000
	bne CODE_C47779
	lda.b $83
	cmp.w #$0004
	beq CODE_C47779
	dec.b $83
CODE_C47779:						; from CODE_C4775A
	dec.b $7F
	dec.b $7F
	bpl CODE_C47753
	ldy.b $6B
	lda.b $83
	sta.w $12C7,y
	rtl
CODE_C47787:						; called from other segments
	lda.w $1864
	cmp.w #$0001
	beq CODE_C477BA
	stz.b $6B
	lda.w #$0002
	sta.b $6F
	lda.w $12C7
	sec
	sbc.w $12C9
	sta.b $7F
	bne CODE_C477A4
	jmp.w CODE_C47856
CODE_C477A4:						; from CODE_C47787
	bpl CODE_C477BB
	lda.w $10F5
	bit.w #$4000
	bne CODE_C477D5
	jsl.l CODE_C47856
	lda.w #$4000
	tsb.w $10F5
	bra CODE_C477D5
CODE_C477BA:						; from CODE_C47787
	rtl
CODE_C477BB:						; from CODE_C477A4
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
	lda.w $10F5
	bit.w #$4000
	beq CODE_C477D5
	jsl.l CODE_C47856
	lda.w #$4000
	trb.w $10F5
CODE_C477D5:						; from CODE_C477A4, CODE_C477BB
	lda.w #$2000
	tsb.w $10F5
	bne CODE_C477E6
	jsl.l CODE_C53A29
	ldx.b $6F
	inc.w $1263,x
CODE_C477E6:						; from CODE_C477D5
	lda.w #$0005
	jsl.l $C4C561
	tax
	lda.w #$0004
	sta.w $0000,x
	lda.w #$9C9B
	sta.w $0001,x
	lda.w #$9E9D
	sta.w $0003,x
	txa
	ldx.w #$007E
	ldy.w #$5B04
	jsl.l QueueVRAMDMALen
	jsl.l CODE_C47BFA
	lda.w $10F3
	bne CODE_C4782C
	lda.b $7F
	cmp.w #$0005
	bcs CODE_C4782C
	cmp.w #$0001
	beq CODE_C47825
	lda.w #$0001
	bra CODE_C47828
CODE_C47825:						; from CODE_C477E6
	lda.w #$0001
CODE_C47828:						; from CODE_C477E6
	jsl.l $CF040B
CODE_C4782C:						; from CODE_C477E6
	jsl.l CODE_C516C2
	lda.b $67
	ldx.w #$007E
	ldy.w #$5AE5
	jsl.l QueueVRAMDMALen
	lda.w $10F5
	ldx.w $17C9
	bit.w #$4000
	beq CODE_C4784A
	ldx.w $17CB
CODE_C4784A:						; from CODE_C4782C
	txa
	jsl.l CODE_C53A71
	ldy.w #$5AE1
	jml.l QueueVRAMDMALen
CODE_C47856:						; from CODE_C47787, CODE_C477A4, CODE_C477BB and other segments
	lda.w #$2000
	trb.w $10F5
	beq CODE_C4789C
CODE_C4785E:						; called from other segments
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.l DATA8_C58942
	sta.w $3E4E
	ldx.w #$3E4E
	ldy.w #$3E50
	lda.w #$0013
	mvn $7E,$7E
	clc
	lda.w #$5AA0
	ldy.w #$0002
CODE_C47880:						; from CODE_C47880
	pea.w $0016
	pha
	pea.w $007E
	pea.w $3E4E
	adc.w #$0020
	dey
	bpl CODE_C47880
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jml.l CODE_C53A29
CODE_C4789C:						; from CODE_C47856
	rtl
CODE_C4789D:						; from CODE_C47AE9, CODE_C47CB6, CODE_C47D0B and other segments
	lda.w $10F3
	bne CODE_C478C2
	lda.w $1157
	bne CODE_C478C2
	lda.b $7F
	cmp.w #$000C
	beq CODE_C478C3
	lda.w $186C
	beq CODE_C478C2
	lda.w $10F1
	bit.w #$0020
	bne CODE_C478C3
	lda.b $7F
	cmp.w #$0012
	bne CODE_C478C3
CODE_C478C2:						; from CODE_C4789D
	rtl
CODE_C478C3:						; from CODE_C4789D and other segments
	lda.w $2CF5
	beq CODE_C478CB
	jmp.w CODE_C47979
CODE_C478CB:						; from CODE_C478C3
	pei ($83)
	pei ($85)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	lda.b $7F
	cmp.w #$000E
	bne CODE_C478DE
CODE_C478DE:						; from CODE_C478CB
	sec
	sbc.w #$000E
	bmi CODE_C4790B
	lda.l $7E24CA
	clc
	adc.w #$00C8
	sta.l $7E24CA
	lda.w #$002D
	sta.b $5B
	lda.w $1020,x
	beq CODE_C4790B
	lda.l $7E24CA
	sec
	sbc.w #$00C8
	bcs CODE_C47907
	lda.w #$0000
CODE_C47907:						; from CODE_C478DE
	sta.l $7E24CA
CODE_C4790B:						; from CODE_C478DE
	lda.w #$10F9
	sta.b $67
	lda.w #$001F
	sta.b $83
CODE_C47915:						; from CODE_C47915
	lda.b ($67)
	inc.b $67
	inc.b $67
	and.w #$00FF
	cmp.w #$0034
	beq CODE_C47915
	tay
	beq CODE_C4792C
	dec.b $83
	bpl CODE_C47915
	bra CODE_C47967
CODE_C4792C:						; from CODE_C47915
	dec.b $67
	dec.b $67
	txa
	lsr a
	xba
	and.w #$FF00
	ora.b $7F
	sta.b ($67)
	lda.w #$00C3
	sta.b $65
	lda.w #$4499
	sta.b $63
	ldy.b $7F
	clc
	adc.b [$63],y
	sta.b $63
	lda.b [$63]
	and.w #$00FF
	beq CODE_C47967
	lda.w $0D60,x
	pha
	ora.w #$4000
	sta.w $0D60,x
	pla
	bit.w #$4000
	beq CODE_C47967
	lda.w #$0000
	sta.b ($67)
CODE_C47967:						; from CODE_C47915, CODE_C4792C
	pla
	sta.b $69
	pla
	sta.b $67
	pla
	sta.b $65
	pla
	sta.b $63
	pla
	sta.b $85
	pla
	sta.b $83
CODE_C47979:						; from CODE_C478C3
	rtl
CODE_C4797A:						; called from other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($63)
	pei ($65)
	jsl.l CODE_C54BAF
	lda.w $114B
	cmp.w #$0003
	beq CODE_C479FB
	lda.w #$10F9
	sta.b $63
CODE_C4799B:						; from CODE_C4799B, CODE_C479E6, CODE_C479EC
	lda.b ($63)
	inc.b $63
	inc.b $63
	and.w #$00FF
	cmp.w #$0034
	beq CODE_C4799B
	cmp.w #$0000
	bne CODE_C479B1
	jmp.w CODE_C479FF
CODE_C479B1:						; from CODE_C4799B
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b $67
	lda.b [$67],y
	clc
	adc.b $67
	sta.b $67
	lda.b [$67]
	and.w #$00FF
	beq CODE_C479EC
	dec.b $63
	dec.b $63
	lda.w #$0000
	sta.b $7F
	lda.b ($63)
	inc.b $63
	inc.b $63
	and.w #$FF00
	cmp.w #$0600
	bcc CODE_C479E6
	lda.w #$0002
	sta.b $7F
CODE_C479E6:						; from CODE_C479B1
	lda.b $6B
	cmp.b $7F
	beq CODE_C4799B
CODE_C479EC:						; from CODE_C479B1
	dec.b $63
	dec.b $63
	lda.w #$0034
	sta.b ($63)
	inc.b $63
	inc.b $63
	bra CODE_C4799B
CODE_C479FB:						; from CODE_C4797A
	jsl.l CODE_C4818C
CODE_C479FF:						; from CODE_C4799B
	ldy.b $6B
	lda.w $12C7,y
	ldy.b $67
	sec
	sbc.w $12C7,y
	beq CODE_C47A63
	bmi CODE_C47A63
	lda.b $67
	beq CODE_C47A15
	lda.w #$001A
CODE_C47A15:						; from CODE_C479FF
	sta.b $63
CODE_C47A17:						; from CODE_C47A2F
	ldy.b $63
	lda.w $13DB,y
	inc.b $63
	and.w #$00FF
	sta.b $87
	bit.w #$0080
	bne CODE_C47A63
	lda.b $67
	beq CODE_C47A2F
	lda.w #$0034
CODE_C47A2F:						; from CODE_C47A17
	clc
	adc.b $87
	tay
	lda.w $1373,y
	bit.w #$4000
	bne CODE_C47A17
	lda.w #$0000
	sta.w $1373,y
	jsl.l CODE_C45A9F
	ldy.b $67
	lda.w $12C7,y
	inc a
	sta.w $12C7,y
	jsr.w CODE_C47A7C
	ldy.b $6B
	lda.w $125F,y
	inc a
	sta.w $125F,y
	lda.w #$0001
	tsb.w $12FF
	tsb.w $1301
CODE_C47A63:						; from CODE_C479FF, CODE_C47A17
	pla
	sta.b $65
	pla
	sta.b $63
	pla
	sta.b $89
	pla
	sta.b $87
	pla
	sta.b $85
	pla
	sta.b $83
	pla
	sta.b $81
	pla
	sta.b $7F
	rtl
CODE_C47A7C:						; from CODE_C47A2F
	phx
	tyx
	lda.w $14F5,x
	cmp.w #$0004
	bcc CODE_C47AB2
	ldy.w $05C0,x
CODE_C47A89:						; from CODE_C47A93
	iny
	iny
	cpy.w #$000A
	bne CODE_C47A93
	ldy.w #$0000
CODE_C47A93:						; from CODE_C47A89
	lda.w $1525,y
	bpl CODE_C47A89
	and.w #$00FF
	cmp.b $67
	bne CODE_C47A89
	sta.w $1525,y
	inc a
	inc a
	lsr a
	sta.w $17B5,y
	ldx.b $B7
	tya
	sta.w $14F9,x
	txa
	sta.w $1511,y
CODE_C47AB2:						; from CODE_C47A7C
	plx
	rts
CODE_C47AB4:						; called from other segments
	jsl.l CODE_C47ACD
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
	jsl.l CODE_C47ACD
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
CODE_C47ACC:						; from CODE_C47ACD, CODE_C47AE9
	rtl
CODE_C47ACD:						; from CODE_C47AB4 and other segments
	ldy.b $6B
	lda.w $0A20,y
	bne CODE_C47ACC
	lda.w $10F3
	bne CODE_C47ACC
	lda.w $05A0
	cmp.b $6F
	beq CODE_C47AE9
	lda.w $0A00,x
	sec
	sbc.w #$001A
	bmi CODE_C47ACC
CODE_C47AE9:						; from CODE_C47ACD
	lda.w $0A00,x
	sec
	sbc.w #$0003
	bmi CODE_C47ACC
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
	jsl.l CODE_C44F20
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
	lda.w $0A00,y
	sec
	sbc.w #$001F
	bmi CODE_C47ACC
	lda.w $0D60,x
	bit.w #$4000
	bne CODE_C47ACC
	lda.w #$0014
	sec
	sbc.w $0F60,x
	jsl.l $C37EAA
	cmp.w #$0002
	bcs CODE_C47ACC
	lda.w $10F1
	bit.w #$0010
	bne CODE_C47ACC
	lda.w $05CC,y
	and.w #$0004
	bne CODE_C47ACC
	lda.w #$0026
	sta.b $7F
	jmp.w CODE_C4789D
CODE_C47B3F:						; called from other segments
	lda.w $08E0,x
	and.w #$F7FF
	sta.w $08E0,x
	lda.w $0D60,x
	bit.w #$0002
	bne CODE_C47B53
	jmp.w CODE_C47B8F
CODE_C47B53:						; from CODE_C47B3F
	and.w #$FFFD
	sta.w $0D60,x
	ldy.w #$0010
	lda.w $1020,x
	beq CODE_C47B64
	ldy.w #$0001
CODE_C47B64:						; from CODE_C47B53
	sty.b $7F
	lda.w $113F
	sec
	sbc.b $7F
	sta.w $113F
	stz.w $09A0,x
	stz.w $09C0,x
	lda.w #$009B
	sta.w $0814,x
	lda.w #$0002
	sta.w $0C40,x
	sta.w $1000,x
	lda.w #$18EC
	jsl.l CODE_C457B5
	jml.l $C384FC
CODE_C47B8F:						; from CODE_C47B3F
	lda.w #$0004
	sta.w $0C40,x
	lda.w #$FFFF
	sta.w $0D40,x
	sta.w $0D20,x
	lda.w $0D60,x
	and.w #$6FF7
	sta.w $0D60,x
	stz.w $1080,x
	lda.w #$F000
	sta.w $09A0,x
	lda.w $0FC0,x
	bne CODE_C47BBE
	lda.w $08E0,x
	ora.w #$0800
	sta.w $08E0,x
CODE_C47BBE:						; from CODE_C47B8F
	ldx.b $6B
	lda.w $14F5,x
	cmp.w #$0004
	bcc CODE_C47BF4
	ldy.w $05C0,x
CODE_C47BCB:						; from CODE_C47BD5
	iny
	iny
	cpy.w #$000A
	bne CODE_C47BD5
	ldy.w #$0000
CODE_C47BD5:						; from CODE_C47BCB
	lda.w $1525,y
	bpl CODE_C47BCB
	and.w #$00FF
	cmp.b $6B
	bne CODE_C47BCB
	sta.w $1525,y
	inc a
	inc a
	lsr a
	sta.w $17B5,y
	ldx.b $B7
	tya
	sta.w $14F9,x
	txa
	sta.w $1511,y
CODE_C47BF4:						; from CODE_C47BBE
	ldx.b $B7
	jml.l CODE_C4370C
CODE_C47BFA:						; from CODE_C477E6 and other segments
	stz.b $7F
	stz.b $8B
	lda.b $6B
	beq CODE_C47C05
	lda.w #$001A
CODE_C47C05:						; from CODE_C47BFA
	sta.b $63
CODE_C47C07:						; from CODE_C47C1F
	ldy.b $63
	inc.b $63
	lda.w $13DB,y
	and.w #$00FF
	sta.b $87
	bit.w #$0080
	bne CODE_C47C3F
	lda.b $6B
	beq CODE_C47C1F
	lda.w #$0034
CODE_C47C1F:						; from CODE_C47C07
	clc
	adc.b $87
	tay
	lda.w $1373,y
	sta.b $87
	bit.w #$4000
	bne CODE_C47C07
	lda.b $87
	sec
	sbc.b $8B
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
	lda.b $87
	sta.b $8B
	bra CODE_C47C07
CODE_C47C3F:						; from CODE_C47C07
	ldy.b $6F
	lda.w $12C7,y
	cmp.w #$0006
	beq CODE_C47C8B
	lda.b $7F
	sec
	sbc.b $8B
	sta.b $7F
	lda.b $6F
	beq CODE_C47C57
	lda.w #$001A
CODE_C47C57:						; from CODE_C47C3F
	sta.b $63
CODE_C47C59:						; from CODE_C47C71
	ldy.b $63
	lda.w $13DB,y
	inc.b $63
	and.w #$00FF
	sta.b $87
	bit.w #$0080
	bne CODE_C47C8B
	lda.b $6F
	beq CODE_C47C71
	lda.w #$0034
CODE_C47C71:						; from CODE_C47C59
	clc
	adc.b $87
	tay
	lda.w $1373,y
	bit.w #$4000
	bne CODE_C47C59
	lda.b $7F
	cmp.w $1373,y
	bmi CODE_C47C8B
	lda.b $7F
	clc
	adc.b $8B
	sta.b $7F
CODE_C47C8B:						; from CODE_C47C3F, CODE_C47C59, CODE_C47C71
	rtl
CODE_C47C8C:						; called from other segments
	ldy.b $6B
	lda.w $1000,x
	bne CODE_C47D0A
	lda.w $0A20,x
	beq CODE_C47D0A
	lda.w $186C
	bne CODE_C47CB6
	lda.w $14F9,y
	bmi CODE_C47CB6
	lda.w #$0010
	clc
	adc.w $0FA0,y
	sec
	sbc.w $0E00,x
	jsl.l $C37EAA
	cmp.w #$000C
	bcc CODE_C47D0A
CODE_C47CB6:						; from CODE_C47C8C
	lda.w $0814,x
	sec
	sbc.w $0814,y
	sta.b $7F
	lda.w $0896,x
	sec
	sbc.w $0896,y
	sta.b $83
	jsl.l $C37F6D
	ldy.b $6B
	lda.b $7F
	sec
	sbc.w $0C40,y
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs CODE_C47D0A
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
	jsl.l CODE_C44F20
	jsl.l CODE_C480B5
	beq CODE_C47D0B
	lda.w $18B0
	bpl CODE_C47D0B
	ldy.b $6B
	sty.w $18B0
	lda.w $14F9,y
	sta.w $18B6
	lda.w #$0024
	sta.b $7F
	jsl.l CODE_C4789D
	bra CODE_C47D1F
CODE_C47D0A:						; from CODE_C47C8C, CODE_C47CB6
	rtl
CODE_C47D0B:						; from CODE_C47CB6
	jsl.l CODE_C48199
	lda.b $7F
	cmp.w #$0005
	bcs CODE_C47D1F
	lda.w #$0022
	sta.b $7F
	jsl.l CODE_C4789D
CODE_C47D1F:						; from CODE_C47CB6, CODE_C47D0B
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
	lda.w #$FFFF
	sta.w $07A2
	rtl
CODE_C47D2E:						; called from other segments
	lda.w $0D60,x
	bit.w #$0002
	bne CODE_C47D39
	jmp.w CODE_C47D81
CODE_C47D39:						; from CODE_C47D2E
	jsl.l CODE_C47E65
	lda.w $0D60,x
	and.w #$FFF9
	ora.w #$1000
	sta.w $0D60,x
	stz.b $8F
	jsl.l $C38043
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
	jsl.l CODE_C47F0E
	lda.b $34
	sta.b $83
	sta.w $0B40,x
	lda.w #$009B
	sta.w $0B20,x
	stz.w $0AE0,x
	lda.w $0D60,x
	ora.w #$8000
	sta.w $0D60,x
	stz.w $0BE0,x
	stz.w $0C00,x
	lda.w #$0384
	sta.w $0B60,x
CODE_C47D81:						; from CODE_C47D2E
	lda.w $0B60,x
	sec
	sbc.w $05A2
	sta.w $0B60,x
	bpl CODE_C47DA9
	jmp.w CODE_C47E2D
CODE_C47D90:						; from CODE_C47DA9
	rtl
CODE_C47D91:						; from CODE_C47DA9
	lda.w $0B20,x
	sta.b $7F
	lda.w $0B40,x
	sta.b $83
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b $63
	jml.l CODE_C45950
CODE_C47DA9:						; from CODE_C47D81
	lda.w $0896,x
	sec
	sbc.w $0B40,x
	cmp.w #$FFF3
	bmi CODE_C47D91
	cmp.w #$000D
	bpl CODE_C47D91
	lda.w $0814,x
	sec
	sbc.w $0B20,x
	sta.b $7F
	sec
	sbc.w #$FFE8
	bmi CODE_C47D91
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bpl CODE_C47D90
	adc.w #$0008
	sta.w $0AE0,x
	cpx.w $05A0
	bne CODE_C47DEB
	lda.w #$FFFF
	sta.w $05A0
	lda.w #$003C
	sta.w $0CE0,x
CODE_C47DEB:						; from CODE_C47DA9
	lda.w #$1958
	sta.w $1080,x
	jsl.l CODE_C457B5
	lda.w #$0006
	sta.b $87
	lda.w $0FC0,x
	beq CODE_C47E04
	lda.w #$0002
	sta.b $87
CODE_C47E04:						; from CODE_C47DEB
	lda.w $0C40,x
	cmp.b $87
	beq CODE_C47E12
	inc a
	and.w #$0007
	sta.w $0C40,x
CODE_C47E12:						; from CODE_C47E04
	stz.w $09C0,x
	lda.w #$1000
	sta.w $09A0,x
	lda.b $7F
	sec
	sbc.w #$FFF8
	bmi CODE_C47E64
	stz.w $09A0,x
	lda.w $0C40,x
	cmp.b $87
	bne CODE_C47E64
CODE_C47E2D:						; from CODE_C47D81
	lda.w $0B40,x
	sta.w $0896,x
	lda.w #$009B
	sta.w $0814,x
	lda.w $08E0,x
	and.w #$F7FF
	sta.w $08E0,x
	lda.w #$0002
	sta.w $0C40,x
	sta.w $1000,x
	lda.w #$18BE
	jsl.l CODE_C457B5
	lda.w $0D60,x
	and.w #$BFFF
	sta.w $0D60,x
	lda.w #$000E
	sta.b $7F
	jml.l CODE_C4373E
CODE_C47E64:						; from CODE_C47E91, CODE_C47E12
	rtl
CODE_C47E65:						; from CODE_C47D39 and other segments
	ldy.b $6B
	lda.w $14F5,y
	cmp.w #$0004
	bcc CODE_C47E91
	sta.b $83
	lda.w #$0006
	sta.b $7F
	lda.w $1283,y
	tax
	ldy.w #$0000
CODE_C47E7D:						; from CODE_C47E85
	lda.w $0A20,x
	bmi CODE_C47E85
	beq CODE_C47E85
	iny
CODE_C47E85:						; from CODE_C47E7D
	inx
	inx
	dec.b $7F
	bne CODE_C47E7D
	cpy.b $83
	beq CODE_C47EA2
	bcc CODE_C47EA2
CODE_C47E91:						; from CODE_C47E65, CODE_C47EFA
	ldx.b $B7
	lda.w $14F9,x
	bpl CODE_C47E9B
	jmp.w CODE_C47E64
CODE_C47E9B:						; from CODE_C47E91
	sta.b $8F
	jsl.l CODE_C538DE
	rtl
CODE_C47EA2:						; from CODE_C47E85
	cpy.w #$0003
	bne CODE_C47ECB
	ldx.b $6B
	ldy.w $05C0,x
CODE_C47EAC:						; from CODE_C47EB6
	iny
	iny
	cpy.w #$000A
	bne CODE_C47EB6
	ldy.w #$0000
CODE_C47EB6:						; from CODE_C47EAC
	lda.w $1525,y
	bpl CODE_C47EAC
	and.w #$00FF
	cmp.b $6B
	bne CODE_C47EAC
	sta.w $1525,y
	inc a
	inc a
	lsr a
	sta.w $17B5,y
CODE_C47ECB:						; from CODE_C47EA2
	ldx.b $6B
	ldy.w $05C0,x
	bra CODE_C47EDC
CODE_C47ED2:						; from CODE_C47EDC
	iny
	iny
	cpy.w #$000A
	bne CODE_C47EDC
	ldy.w #$0000
CODE_C47EDC:						; from CODE_C47ECB, CODE_C47ED2
	lda.w $1525,y
	cmp.b $6B
	bne CODE_C47ED2
	ora.w #$FF00
	sta.w $1525,y
	lda.w #$0000
	sta.w $17B5,y
	phy
	iny
	iny
	cpy.w #$000A
	bne CODE_C47EFA
	ldy.w #$0000
CODE_C47EFA:						; from CODE_C47EDC
	tya
	sta.w $05C0,x
	ply
	ldx.w $1511,y
	lda.w #$FFFF
	sta.w $1511,y
	sta.w $14F9,x
	jmp.w CODE_C47E91
CODE_C47F0E:						; from CODE_C47F94, CODE_C47D39 and other segments
	lda.w #$000B
	sta.b $7F
	lda.w $113F
	sta.b $83
	lda.w $1020,x
	bne CODE_C47F2A
	lda.b $83
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b $83
	lda.w #$FFF5
	sta.b $7F
CODE_C47F2A:						; from CODE_C47F0E
	lda.b $83
	and.w #$000F
	sta.b $83
	cmp.w #$0003
	bcc CODE_C47F3B
	lda.w #$0002
	sta.b $83
CODE_C47F3B:						; from CODE_C47F2A
	inc.b $83
	inc.b $83
	inc.b $83
	phx
	lda.b $7F
	ldx.b $83
	jsl.l Mul16S
	plx
	rtl
CODE_C47F4C:						; from CODE_C47F94 and other segments
	lda.w #$0010
	sta.b $7F
	lda.w $1020,x
	beq CODE_C47F5B
	lda.w #$0001
	sta.b $7F
CODE_C47F5B:						; from CODE_C47F4C
	lda.w $113F
	clc
	adc.b $7F
	sta.w $113F
	lda.w #$FFFF
	sta.w $0A20,x
	lda.w $08E0,x
	and.w #$F7FF
	sta.w $08E0,x
	lda.w #$02A4
	sta.w $0856,x
	rtl
CODE_C47F7A:						; from CODE_C474C4 and other segments
	lda.w $1864
	cmp.w #$0001
	beq CODE_C47FB4
	lda.w $18BE
	ora.w $1157
	ora.w $189C
	bne CODE_C47FB4
	phx
	stz.w $113F
	ldx.w #$0000
CODE_C47F94:						; from CODE_C47FAC
	lda.w $0A20,x
	bpl CODE_C47FAC
	jsl.l CODE_C47F0E
	lda.b $34
	sta.w $0896,x
	lda.w #$009B
	sta.w $0814,x
	jsl.l CODE_C47F4C
CODE_C47FAC:						; from CODE_C47F94
	inx
	inx
	cpx.w #$0018
	bcc CODE_C47F94
	plx
CODE_C47FB4:						; from CODE_C47F7A
	rtl

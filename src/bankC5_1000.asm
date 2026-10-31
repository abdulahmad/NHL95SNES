; Segment bankC5_1000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C510F6
CODE_C510F6:						; called from other segments
	phx
	lda.w $186A
	asl a
	tax
	lda.l DATA8_C51112,x
	sta.b $9F
	lda.l DATA8_C5110A,x
	sta.b $7F
	plx
	rtl
DATA8_C5110A:						; not traced: a table read by CODE_C510F6
	db $2C,$01,$58,$02,$B0,$04,$1E,$00
DATA8_C51112:						; not traced: a table read by CODE_C510F6
	db $00,$05,$00,$10,$00,$20,$30,$00
CODE_C5111A:						; from CODE_C51DEA and other segments
	ldx.b $6F
	rtl
CODE_C5111D:						; no caller found (not traced)
	lda.w $114B
	sta.b $7F
	cmp.w #$0004
	bne CODE_C5112C
	dec.w $07D4
	inc.b $7F
CODE_C5112C:						; from CODE_C5111D
	lda.w #$00C0
	sta.b $65
	lda.w #$9B54
	sta.b $63
CODE_C51136:						; from CODE_C51136
	lda.b $65
	sta.b $69
	lda.b $63
	sta.b $67
	lda.b [$63]
	clc
	adc.b $63
	sta.b $63
	dec.b $7F
	bpl CODE_C51136
	jsl.l CODE_C528D3
	ldy.b $6B
	lda.w $12AB,y
	sta.b $7F
	jsl.l CODE_C511A8
	stz.b $69
	lda.w #$04F5
	sta.b $67
	lda.w #$0004
	sta.b [$67]
	lda.w #$0020
	sta.w $04F7
	lda.b $7F
	sta.b $34
	lda.w #$000A
	sta.b $30
	phx
	jsl.l Div16x8U
	plx
	lda.b $2C
	beq CODE_C51183
	adc.w #$0030
	sta.w $04F7
CODE_C51183:						; from CODE_C51136
	lda.l RDMPYL
	adc.w #$0030
	sta.w $04F8
	rtl
CODE_C5118E:						; no caller found (not traced)
	ldy.w #$0002
CODE_C51191:						; from CODE_C511A1
	dec.w $07D4
	lda.b [$67],y
	and.w #$00FF
	cmp.w #$0031
	beq CODE_C511A1
	dec.w $07D4
CODE_C511A1:						; from CODE_C51191
	iny
	tya
	cmp.b [$67]
	bcc CODE_C51191
	rtl
CODE_C511A8:						; from CODE_C51136 and other segments
	lda.b $7F
CODE_C511AA:						; from CODE_C511AA
	cmp.w #$0064
	bcc CODE_C511B4
	sbc.w #$0064
	bra CODE_C511AA
CODE_C511B4:						; from CODE_C511AA
	sta.b $7F
	rtl
DATA8_C511B7:						; not traced: data between routines
	db $6B
CODE_C511B8:						; called from other segments
	phx
	ldx.b $63
	lda.w $2458,x
	cmp.w #$0004
	bcc CODE_C511C6
	jmp.w CODE_C5126F
CODE_C511C6:						; from CODE_C511B8
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	ldx.b $63
	lda.w $2458,x
	cmp.w #$0003
	bne CODE_C51222
	lda.w #$0005
	sta.w $2458,x
	lda.w $2468,x
	sec
	sbc.w $2478,x
	bit.w #$8000
	beq CODE_C511F6
	eor.w #$FFFF
	inc a
CODE_C511F6:						; from CODE_C511C6
	cmp.w #$0002
	bcs CODE_C51257
	lda.w $114B
	cmp.w #$0004
	bne CODE_C51211
	lda.w $2468,x
	cmp.w $2478,x
	bne CODE_C51257
	inc a
	sta.w $2468,x
	bra CODE_C51257
CODE_C51211:						; from CODE_C511F6
	lda.w #$0003
	sta.w $2458,x
	lda.w $2488,x
	ora.w #$0002
	sta.w $2488,x
	bra CODE_C51257
CODE_C51222:						; from CODE_C511C6
	inc.w $2458,x
	lda.w $2418,x
	sta.b $7F
	lda.w $2428,x
	sta.b $83
	jsl.l CODE_C512B1
	ldx.b $63
	lda.w $2468,x
	clc
	adc.b $7F
	sta.w $2468,x
	lda.w $2428,x
	sta.b $7F
	lda.w $2418,x
	sta.b $83
	jsl.l CODE_C512B1
	ldx.b $63
	lda.w $2478,x
	clc
	adc.b $7F
	sta.w $2478,x
CODE_C51257:						; from CODE_C511F6, CODE_C51211
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
	pla
	sta.b $81
	pla
	sta.b $7F
CODE_C5126F:						; from CODE_C511B8
	plx
	rtl
DATA8_C51271:						; not traced: data between routines
	db $2B,$00,$1E,$00,$17,$00,$04,$00,$27,$00,$20,$00,$18,$00,$05,$00
	db $23,$00,$21,$00,$1A,$00,$06,$00,$1E,$00,$22,$00,$1E,$00,$06,$00
	db $1A,$00,$24,$00,$1E,$00,$08,$00,$16,$00,$25,$00,$1F,$00,$0A,$00
	db $13,$00,$26,$00,$1F,$00,$0C,$00,$0F,$00,$26,$00,$20,$00,$0F,$00
CODE_C512B1:						; from CODE_C51222 and other segments
	asl.b $7F
	lda.w #$00C3
	sta.b $69
	stz.b $67
	ldy.b $7F
	lda.b [$67],y
	sta.b $67
	ldy.w #$0006
	adc.b [$67],y
	sta.b $67
	lda.b [$67]
	and.w #$0070
	lsr a
	adc.w #$1271
	sta.b $67
	lda.w #$00C5
	sta.b $69
	lda.b [$67]
	sta.w $07BE
	ldy.w #$0002
	lda.b [$67],y
	sta.w $07C0
	ldy.w #$0004
	lda.b [$67],y
	sta.w $07C2
	ldy.w #$0006
	lda.b [$67],y
	sta.w $07C4
	asl.b $83
	lda.w #$00C3
	sta.b $69
	stz.b $67
	ldy.b $83
	lda.b [$67],y
	sta.b $67
	ldy.w #$0006
	adc.b [$67],y
	sta.b $67
	lda.b [$67]
	and.w #$0007
	asl a
	asl a
	asl a
	adc.w #$1271
	sta.b $67
	lda.w #$00C5
	sta.b $69
	lda.b [$67]
	adc.w $07BE
	sta.w $07BE
	ldy.w #$0002
	lda.b [$67],y
	adc.w $07C0
	sta.w $07C0
	ldy.w #$0004
	lda.b [$67],y
	adc.w $07C2
	sta.w $07C2
	ldy.w #$0006
	lda.b [$67],y
	adc.w $07C4
	sta.w $07C4
	lda.w #$0004
	sta.b $7F
	pei ($85)
	pei ($83)
	pei ($69)
	pei ($67)
	stz.b $69
	lda.w #$07BE
	sta.b $67
	stz.b $83
	bra CODE_C51368
CODE_C5135D:						; from CODE_C51368
	lda.b $83
	clc
	adc.b [$67]
	sta.b $83
	inc.b $67
	inc.b $67
CODE_C51368:						; from CODE_C512B1
	dec.b $7F
	bpl CODE_C5135D
	lda.b $83
	sta.b $7F
	jsl.l $C37EBF
CODE_C51374:						; from CODE_C51374
	dec.b $67
	dec.b $67
	lda.b $7F
	sec
	sbc.b [$67]
	sta.b $7F
	bpl CODE_C51374
	lda.b $67
	sec
	sbc.w #$07BE
	lsr a
	sta.b $7F
	pla
	sta.b $67
	pla
	sta.b $69
	pla
	sta.b $83
	pla
	sta.b $85
	rtl
CODE_C51397:						; called from other segments
	lda.w #$A0A0
	sta.l $7E2CD0
	sta.l $7E2CD5
	lda.w #$A005
	sta.l $7E2CCF
	sep #$21
	lda.b #$BA
	sta.l $7E2CD2
	lda.w $1152
	tay
	and.b #$F0
	beq CODE_C513C4
	lsr a
	lsr a
	lsr a
	lsr a
	adc.b #$B0
	sta.l $7E2CD0
	sec
CODE_C513C4:						; from CODE_C51397
	tya
	and.b #$0F
	adc.b #$AF
	sta.l $7E2CD1
	lda.w $1151
	tay
	lsr a
	lsr a
	lsr a
	lsr a
	clc
	adc.b #$B0
	sta.l $7E2CD3
	tya
	and.b #$0F
	adc.b #$B0
	sta.l $7E2CD4
	rep #$30
	ldy.w #$5B24
	lda.w #$2CCF
	ldx.w #$007E
	jml.l QueueVRAMDMALen
CODE_C513F4:						; called from other segments
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
	stz.b $6B
	jsl.l CODE_C5147E
	lda.w #$0002
	sta.b $6B
	jsl.l CODE_C5147E
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
	sta.b $9D
	pla
	sta.b $9B
	pla
	sta.b $99
	pla
	sta.b $97
	pla
	sta.b $95
	pla
	sta.b $93
	pla
	sta.b $91
	pla
	sta.b $8F
	pla
	sta.b $8D
	pla
	sta.b $8B
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
	ldx.b $6F
CODE_C5147D:						; from CODE_C514E4, CODE_C514BA
	rtl
CODE_C5147E:						; from CODE_C513F4 and other segments
	lda.b $6B
	beq CODE_C51485
	lda.w #$001A
CODE_C51485:						; from CODE_C5147E
	sta.b $63
CODE_C51487:						; from CODE_C5149F
	ldy.b $63
	lda.w $13DB,y
	inc.b $63
	and.w #$00FF
	sta.b $7F
	bit.w #$0080
	bne CODE_C514B1
	lda.b $6B
	beq CODE_C5149F
	lda.w #$0034
CODE_C5149F:						; from CODE_C51487
	clc
	adc.b $7F
	tay
	lda.w $1373,y
	bit.w #$4000
	bne CODE_C51487
	jsl.l CODE_C514E4
	bra CODE_C51487
CODE_C514B1:						; from CODE_C51487
	lda.b $6B
	beq CODE_C514B8
	lda.w #$001A
CODE_C514B8:						; from CODE_C514B1
	sta.b $63
CODE_C514BA:						; from CODE_C514D2
	ldy.b $63
	lda.w $13DB,y
	inc.b $63
	and.w #$00FF
	sta.b $7F
	bit.w #$0080
	bne CODE_C5147D
	lda.b $6B
	beq CODE_C514D2
	lda.w #$0034
CODE_C514D2:						; from CODE_C514BA
	clc
	adc.b $7F
	tay
	lda.w $1373,y
	bit.w #$4000
	beq CODE_C514BA
	jsl.l CODE_C514E4
	bra CODE_C514BA
CODE_C514E4:						; from CODE_C5149F, CODE_C514D2 and other segments
	lda.w $07D6
	cmp.w #$000B
	bcs CODE_C5147D
	lda.b $6B
	beq CODE_C514F3
	lda.w #$0034
CODE_C514F3:						; from CODE_C514E4
	adc.b $7F
	tay
	lda.w $1373,y
	and.w #$07FF
	sta.b $87
	lda.w #$00C3
	sta.b $69
	ldy.b $6B
	lda.w $17D3,y
	sta.b $67
	lda.b [$67]
	and.w #$07FF
	clc
	adc.b $7F
	sta.b $67
	lda.b [$67]
	and.w #$3FFF
	sta.b $67
	lda.b [$67]
	and.w #$00FF
	sta.b $7F
	rtl
CODE_C51523:						; called from other segments
	jsl.l CODE_C54DDF
	lda.w #$0000
	ldy.w #$001E
CODE_C5152D:						; from CODE_C5152D
	sta.w $0814,y
	dey
	dey
	bpl CODE_C5152D
	lda.b $5D
	ldy.b $5F
	sta.w $0810
	sty.w $0812
	lda.w #$0001
	trb.w $10F5
	lda.w $114B
	cmp.w #$0004
	beq CODE_C5154E
	bra CODE_C5154E
CODE_C5154E:						; from CODE_C5152D
	lda.w #$0708
	sta.w $07AA
	lda.w #$0001
	sta.w $07F0
	lda.b $5D
	sec
	sbc.w #$0150
	sta.w $07F4
	jsl.l CODE_C51668
	lda.w $07F2
	sta.w $24C8
	lda.w #$FFFF
	sta.w $0591
	ldy.w #$0000
	tyx
CODE_C51577:						; from CODE_C51577
	lda.w $17B5,y
	bne CODE_C51586
	inx
	inx
	cpx.w #$0008
	bne CODE_C51577
	lda.w #$0001
CODE_C51586:						; from CODE_C51577
	eor.w #$FFFF
	inc a
	sta.w $0591
	lda.w $17B5
	ora.w $17B7
	ora.w $17B9
	ora.w $17BB
	ora.w $17BD
	bne CODE_C515A1
	stz.w $0591
CODE_C515A1:						; from CODE_C51586
	lda.w #$0001
	sta.w $153F
	lda.w $23BA
	beq CODE_C515AF
	jmp.w CODE_C51659
CODE_C515AF:						; from CODE_C515A1
	jsl.l CODE_C40A02
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
	sta.b $65
	pla
	sta.b $63
	pla
	sta.b $9D
	pla
	sta.b $9B
	pla
	sta.b $99
	pla
	sta.b $97
	pla
	sta.b $95
	pla
	sta.b $93
	pla
	sta.b $91
	pla
	sta.b $8F
	pla
	sta.b $8D
	pla
	sta.b $8B
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
	jsl.l CODE_C558CC
	jsl.l CODE_C5589E
	jsl.l $CF03D0
CODE_C51659:						; from CODE_C515A1
	stz.b $5D
	stz.w $07C6
	stz.w $2372
	stz.w $153F
	stz.w $07F0
CODE_C51667:						; from CODE_C51672
	rtl
CODE_C51668:						; from CODE_C5154E and other segments
	lda.w $07F2
	bmi CODE_C51672
	ora.w $24C6
	bne CODE_C5167D
CODE_C51672:						; from CODE_C51668
	jsl.l CODE_C4075F
	lda.b $83
	sta.w $07F2
	bmi CODE_C51667
CODE_C5167D:						; from CODE_C51668
	jmp.w CODE_C51752
CODE_C51680:						; no caller found (not traced)
	lda.w $07F0
	beq CODE_C516A6
	lda.b $5D
	sec
	sbc.w $07F4
	cmp.w #$0150
	bcc CODE_C516A6
	jsl.l CODE_C516AA
	lda.w $24C8
	cmp.w $07F2
	bne CODE_C51680
	jsl.l CODE_C51811
	lda.w #$0008
	trb.w $10F7
CODE_C516A6:						; from CODE_C51680, CODE_C516B4
	lda.w #$0000
	rtl
CODE_C516AA:						; from CODE_C51680 and other segments
	lda.w $07F2
	bmi CODE_C516B4
	ora.w $24C6
	bne CODE_C516BF
CODE_C516B4:						; from CODE_C516AA
	jsl.l CODE_C4075F
	lda.b $83
	sta.w $07F2
	bmi CODE_C516A6
CODE_C516BF:						; from CODE_C516AA
	jmp.w CODE_C51752
CODE_C516C2:						; called from other segments
	lda.w #$0020
	jsl.l $C4C561
	clc
	adc.w #$001F
	sta.b $67
	pha
	lda.b $7F
	sta.b $34
	lda.w #$000A
	sta.b $30
	jsl.l Div16x8U
	dec.b $67
	sep #$20
	lda.l RDMPYL
	clc
	adc.b #$B0
	sta.b ($67)
	rep #$30
	lda.b $2C
	sta.b $34
	lda.w #$0006
	sta.b $30
	jsl.l Div16x8U
	dec.b $67
	sep #$20
	lda.l RDMPYL
	clc
	adc.b #$B0
	sta.b ($67)
	rep #$20
	dec.b $67
	sep #$20
	lda.b #$BA
	sta.b ($67)
	rep #$30
	lda.b $2C
	sta.b $34
	lda.w #$000A
	sta.b $30
	jsl.l Div16x8U
	dec.b $67
	sep #$20
	lda.l RDMPYL
	clc
	adc.b #$B0
	sta.b ($67)
	rep #$31
	lda.b $2C
	beq CODE_C5173C
	dec.b $67
	sep #$20
	adc.b #$B0
	sta.b ($67)
	rep #$30
CODE_C5173C:						; from CODE_C516C2
	dec.b $67
	pla
	clc
	sbc.b $67
	sep #$20
	sta.b ($67)
	rep #$20
	rtl
CODE_C51749:						; no caller found (not traced)
	lda.w $114D
	cmp.w #$01E1
	bcc CODE_C51752
	rtl
CODE_C51752:						; from CODE_C5167D, CODE_C516BF, CODE_C51749, CODE_C51752, ...
	lda.w $07F2
	sta.b $8B
	bmi CODE_C51765
	dec.w $07F2
	lda.b $8B
	cmp.w $24C6
	beq CODE_C51752
	bra CODE_C51766
CODE_C51765:						; from CODE_C51752
	rtl
CODE_C51766:						; from CODE_C51752
	lda.b $8B
	asl a
	sta.b $63
	tax
	lda.w $2488,x
	bit.w #$0006
	bne CODE_C51752
	lda.w $10F5
	bit.w #$0001
	bne CODE_C5177C
CODE_C5177C:						; from CODE_C51766
	lda.w $07D6
	sec
	sbc.w #$0005
	sta.w $07D6
	lda.w #$001C
	sta.b $7F
	lda.w #$0005
	sta.b $83
	lda.b $5D
	sta.w $07F4
	inc.w $07D4
	lda.w $07D6
	sec
	sbc.w #$0004
	sta.w $07D6
	lda.w $07D4
	pha
	jsl.l CODE_C4075F
	lda.w #$2400
	sta.w $07D2
	lda.b $01,s
	sta.w $07D4
	lda.w $24C4
	inc a
	sta.b $7F
	lda.w $1864
	bne CODE_C517C2
	stz.b $7F
CODE_C517C2:						; from CODE_C5177C
	pla
	rtl
CODE_C517C4:						; no caller found (not traced)
	phx
	pei ($7F)
CODE_C517C7:						; from CODE_C517F1
	ldx.w #$0000
CODE_C517CA:						; from CODE_C517DB
	txa
	asl a
	tay
	lda.w $17B5,y
	beq CODE_C517DB
	txa
	jsl.l $C3704D
	lda.b $8B
	bne CODE_C517FE
CODE_C517DB:						; from CODE_C517CA
	inx
	cpx.w #$0005
	bcc CODE_C517CA
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l CODE_C52295
	lda.b $5D
CODE_C517F1:						; from CODE_C517F1
	cmp.b $5D
	beq CODE_C517F1
	jsl.l $C36CBF
	pla
	dec a
	pha
	bpl CODE_C517C7
CODE_C517FE:						; from CODE_C517CA
	pla
	plx
	rtl
CODE_C51801:						; called from other segments
	lda.w $10F3
	ora.w $114D
	bne CODE_C51810
	jsl.l CODE_C52284
	jmp.w CODE_C50A14
CODE_C51810:						; from CODE_C51801
	rtl
CODE_C51811:						; from CODE_C51680 and other segments
	rtl
CODE_C51812:						; no caller found (not traced)
	lda.w #$0013
	sta.b $7F
	lda.w #$0009
	sta.b $83
	lda.w $24C0
	sta.b $87
	jml.l CODE_C528D4
CODE_C51825:						; called from other segments
	pei ($6D)
	pei ($6B)
	pei ($71)
	pei ($6F)
	inc.w $18AA
	lda.w #$FFFF
	sta.w $184C
	sta.w $184E
	jsl.l CODE_C54BAF
	lda.w $2038
	sec
	sbc.w #$0006
	sta.b $6D
	tax
	ldy.w #$0004
	lda.w $203E,x
	bit.w #$0080
	bne CODE_C5185D
	iny
	iny
	lda.w $203F,x
	bit.w #$0080
	bne CODE_C5185D
	iny
CODE_C5185D:						; from CODE_C51825
	ldx.w #$0013
	lda.w #$584C
	jsl.l CODE_C58C36
	ldy.w #$0000
	ldx.b $6D
	lda.w $203C,x
	bit.w #$0080
	beq CODE_C51877
	ldy.w #$001A
CODE_C51877:						; from CODE_C5185D
	sty.b $6B
	lda.w $203D,x
	and.w #$00FF
	clc
	adc.b $6B
	tay
	lda.w #$2DC9
	ldx.b $6B
	beq CODE_C5188D
	lda.w #$3207
CODE_C5188D:						; from CODE_C51877
	sta.b $6B
	lda.w $1413,y
	and.w #$00FF
	cmp.w #$0003
	bne CODE_C518A9
	ldx.w #$00C3
	lda.w #$5A26
	ldy.w #$5870
	jsl.l QueueVRAMDMALen
	bra CODE_C518B6
CODE_C518A9:						; from CODE_C5188D
	ldx.w #$00C3
	lda.w #$5A31
	ldy.w #$5872
	jsl.l QueueVRAMDMALen
CODE_C518B6:						; from CODE_C5188D
	lda.w #$58AD
	sta.b $6F
	lda.b $6B
	clc
	adc.w #$0110
	sta.b $6B
	ldx.b $6D
	lda.w $203D,x
	and.w #$00FF
	jsr.w CODE_C51911
	ldx.b $6D
	lda.w $203E,x
	bit.w #$0080
	bne CODE_C51903
	pha
	lda.b $6F
	tay
	clc
	adc.w #$0020
	sta.b $6F
	ldx.w #$00C3
	lda.w #$5A36
	jsl.l QueueVRAMDMALen
	pla
	and.w #$00FF
	jsr.w CODE_C51911
	ldx.b $6D
	lda.w $203F,x
	bit.w #$0080
	bne CODE_C51903
	and.w #$00FF
	jsr.w CODE_C51911
CODE_C51903:						; from CODE_C518B6
	pla
	sta.b $6F
	tax
	pla
	sta.b $71
	pla
	sta.b $6B
	pla
	sta.b $6D
	rtl
CODE_C51911:						; from CODE_C518B6
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $6B
	sta.b $71
	tax
	lda.w $0000,x
	and.w #$00FF
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	lda.w #$0020
	sta.w $04F5,x
	txa
	sec
	adc.w #$04F5
	tay
	lda.b $71
	clc
	adc.w #$0008
	tax
	lda.w #$000D
	jsr.w CODE_C55F22
	ldx.w #$04F5
	jsr.w CODE_C56262
	jsl.l $C4C47E
	txa
	ldx.w #$007E
	ldy.b $6F
	jsl.l QueueVRAMDMALen
	lda.b $6F
	clc
	adc.w #$0020
	sta.b $6F
	rts
DATA8_C5195D:						; not traced: data between routines
	db $00,$01,$02,$03,$04,$05,$06,$00,$00,$01,$05,$03,$04,$02,$00,$00
	db $00,$03,$05,$01,$04,$00,$00,$00,$00,$04,$04,$04,$04,$04,$04,$00
	db $00,$00,$06,$FF,$DD,$FF,$CE,$FF,$23,$00,$CE,$FF,$CE,$FF,$F6,$FF
	db $00,$00,$F1,$FF,$32,$00,$F6,$FF,$00,$00,$C4,$FF
CODE_C51999:						; called from other segments
	lda.w $0AE0,x
	beq CODE_C519E2
	clc
	adc.w #$0006
	lsr a
	lsr a
	lsr a
	sta.b $7F
	cmp.w #$0003
	bpl CODE_C519E1
	lda.w $18BE
	bne CODE_C519D2
	lda.w $1864
	cmp.w #$0001
	beq CODE_C519D2
	phx
	phy
	lda.w $2014
	inc a
	sta.w $2014
	lsr a
	lsr a
	cmp.w #$0004
	bcc CODE_C519CC
	lda.w #$0003
CODE_C519CC:						; from CODE_C51999
	jsl.l CODE_C52008
	ply
	plx
CODE_C519D2:						; from CODE_C51999
	lda.b $7F
	eor.w #$FFFF
	inc a
	clc
	adc.w #$000A
	sta.b $7F
	sta.w $2030
CODE_C519E1:						; from CODE_C51999
	rtl
CODE_C519E2:						; from CODE_C51999
	phx
	jsl.l CODE_C58944
	phy
	pha
	lda.w $18BE
	bne CODE_C51A0A
	lda.w $1864
	cmp.w #$0001
	beq CODE_C51A0A
	ldx.w $2020
	jsl.l CODE_C5E596
	ldx.w $2022
	jsl.l CODE_C5E596
	lda.w $2024
	sta.w $18E0
CODE_C51A0A:						; from CODE_C519E2
	pla
	ply
	plx
	stz.w FrameCount
	stz.b $48
	rtl
CODE_C51A13:						; called from other segments
	jsr.w CODE_C51A4E
	lda.w $2034
	sta.w $0830
	lda.w $2036
	sta.w $08B2
	stz.b $8F
	jsr.w CODE_C51A30
	lda.w #$0002
	sta.b $8F
	jsr.w CODE_C51A30
	rtl
CODE_C51A30:						; from CODE_C51A13
	ldy.w #$0008
CODE_C51A33:						; from CODE_C51A3C
	lda.w $1525,y
	bmi CODE_C51A3C
	cmp.b $8F
	beq CODE_C51A42
CODE_C51A3C:						; from CODE_C51A33, CODE_C51A42
	dey
	dey
	bpl CODE_C51A33
	bra CODE_C51A4D
CODE_C51A42:						; from CODE_C51A33
	lda.w $1511,y
	bpl CODE_C51A3C
	sty.b $8F
	jsl.l CODE_C538FE
CODE_C51A4D:						; from CODE_C51A3C
	rts
CODE_C51A4E:						; from CODE_C51A13, CODE_C51A61
	stz.w $0830
	stz.w $08B2
	stz.w $08D8
	stz.w $09BC
	stz.w $09DC
	stz.w $08DE
	rts
CODE_C51A61:						; called from other segments
	jsr.w CODE_C51A4E
	phx
	ldx.w #$0000
	lda.w #$0002
	sta.b $8F
	lda.w $18B4
	beq CODE_C51A7A
	ldx.w #$000C
	lda.w #$0000
	sta.b $8F
CODE_C51A7A:						; from CODE_C51A61
	lda.w #$0010
	sta.b $7F
	jsl.l $C38824
	jsl.l $C38824
	jsl.l $C38824
	jsl.l $C38824
	jsl.l $C38824
	jsl.l $C38824
	ldx.b $8F
	lda.w $14F5,x
	beq CODE_C51ABE
	lda.w $17C1,x
	beq CODE_C51ABE
	ldy.w #$0000
CODE_C51AA6:						; from CODE_C51AAF
	lda.w $1525,y
	bmi CODE_C51AAF
	cmp.b $8F
	beq CODE_C51AB8
CODE_C51AAF:						; from CODE_C51AA6
	iny
	iny
	cpy.w #$000A
	bcc CODE_C51AA6
	bra CODE_C51ABE
CODE_C51AB8:						; from CODE_C51AA6
	sty.b $8F
	jsl.l CODE_C538FE
CODE_C51ABE:						; from CODE_C51A7A, CODE_C51AAF
	plx
	ldy.w $18B4
	lda.w #$FFFF
	sta.w $12BB,y
	sta.w $12BF,y
	sta.w $12C3,y
	lda.w $14E3
	clc
	adc.w #$0014
	bmi CODE_C51ADA
	sta.w $14E3
CODE_C51ADA:						; from CODE_C51ABE
	lda.w $18B0
	sta.w $05A0
	tay
	lda.w $18B6
	bmi CODE_C51AE9
	sta.w $14F9,y
CODE_C51AE9:						; from CODE_C51ADA
	stz.w $1157
	inc.w $1157
	lda.w #$0001
	sta.w $18C0
	lda.w #$0384
	sta.w $18C2
	jml.l CODE_C4818C
CODE_C51AFF:						; called from other segments
	lda.w #$000D
	jsl.l $CF040B
	lda.w #$0100
	trb.w $10F5
	stz.w $2016
	lda.w #$0400
	trb.w $10F5
	stz.w $0772
	stz.w $10F3
	lda.w #$0010
	tsb.w $10F7
	lda.w $2018
	sta.b $8B
	lda.w #$0800
	sta.b $8F
	stz.b $67
	lda.w #$0010
	sta.b $87
	ldx.w $2028
	lda.l $C51C51,x
	and.w #$00FF
	bit.w #$0080
	beq CODE_C51B44
	ora.w #$FF00
CODE_C51B44:						; from CODE_C51AFF
	eor.w #$FFFF
	inc a
	clc
	adc.b $87
	sta.b $87
	ldx.w $202C
	lda.l $C51C51,x
	and.w #$00FF
	bit.w #$0080
	beq CODE_C51B5F
	ora.w #$FF00
CODE_C51B5F:						; from CODE_C51B44
	clc
	adc.b $87
	sta.b $87
	jsl.l RandomWord
	and.w #$001F
	inc a
	cmp.b $87
	bcs CODE_C51B75
	lda.w #$0004
	sta.b $67
CODE_C51B75:						; from CODE_C51B5F
	ldx.b $67
	lda.w $202A,x
	bit.w #$0800
	beq CODE_C51B89
	lda.w $201A
	sta.b $8B
	lda.w #$F800
	sta.b $8F
CODE_C51B89:						; from CODE_C51B75
	lda.b $8B
	bit.w #$0008
	bne CODE_C51B9D
	and.w #$0007
	sta.b $7F
	lda.w $04B0
	and.w #$0003
	bne CODE_C51BB6
CODE_C51B9D:						; from CODE_C51B89
	lda.w #$0005
	jsl.l $C37EAA
	dec a
	dec a
	and.w #$0007
	sta.b $7F
	lda.b $8F
	bmi CODE_C51BB6
	lda.b $7F
	eor.w #$0004
	sta.b $7F
CODE_C51BB6:						; from CODE_C51B89, CODE_C51B9D
	asl.b $7F
	asl.b $7F
	ldx.b $7F
	lda.l DATA8_C09C04,x
	asl a
	asl a
	asl a
	asl a
	asl a
	ldx.b $6F
	sta.w $09A0,x
	ldx.b $7F
	lda.l $C09C06,x
	asl a
	asl a
	asl a
	asl a
	asl a
	clc
	adc.b $8F
	ldx.b $6F
	sta.w $09C0,x
	lda.w #$0004
	ldy.w #$0000
	jsr.w CODE_C51C39
	bmi CODE_C51C0C
	lda.w $09DC
	bpl CODE_C51BFF
	lda.w $0FE0,y
	bne CODE_C51C04
CODE_C51BF2:						; from CODE_C51BFF
	lda.w #$0004
	ldy.w #$000C
	jsr.w CODE_C51C39
	bmi CODE_C51C0C
	bra CODE_C51C04
CODE_C51BFF:						; from CODE_C51BB6
	lda.w $0FE0,y
	bne CODE_C51BF2
CODE_C51C04:						; from CODE_C51BB6, CODE_C51BF2
	sty.b $6B
	ldx.b $6F
	jsl.l CODE_C4843B
CODE_C51C0C:						; from CODE_C51BB6, CODE_C51BF2
	lda.w $12FF
	and.w #$FFFB
	sta.w $12FF
	lda.w $1301
	and.w #$FFFB
	sta.w $1301
	ldx.b $6F
	jsl.l RandomWord
	and.w #$07FF
	sta.w $08DE
	stz.w $08D8
	stz.w $1080,x
	lda.w #$0018
	sta.b $7F
	jml.l CODE_C4373E
CODE_C51C39:						; from CODE_C51BB6, CODE_C51BF2
	pha
	lda.w #$0006
	sta.b $7F
	pla
CODE_C51C40:						; from CODE_C51C40
	cmp.w $0A20,y
	beq CODE_C51C4E
	iny
	iny
	dec.b $7F
	bne CODE_C51C40
	ldy.w #$FFFF
CODE_C51C4E:						; from CODE_C51C40
	cpy.w #$0000
	rts
DATA8_C51C52:						; not traced: data between routines
	db $00,$08,$10,$00,$08,$10
CODE_C51C58:						; called from other segments
	lda.w $0644,x
	cmp.w #$0017
	bne CODE_C51C8F
	lda.w $0FE0,x
	beq CODE_C51C90
	lda.b $7F
	sta.w $201A
	lda.w $1060,x
	bne CODE_C51C8F
	lda.b $83
	bit.w #$8000
	beq CODE_C51CBA
	sta.w $1060,x
	lda.w $1864
	cmp.w #$0001
	beq CODE_C51C86
	ldx.w $2020
	stz.b $30,x
CODE_C51C86:						; from CODE_C51C58
	ldx.b $6F
	lda.w #$24FA
	jml.l CODE_C457B5
CODE_C51C8F:						; from CODE_C51C58, CODE_C51C90
	rtl
CODE_C51C90:						; from CODE_C51C58
	lda.b $7F
	sta.w $2018
	lda.w $1060,x
	bne CODE_C51C8F
	lda.b $83
	bit.w #$8000
	beq CODE_C51CBA
	sta.w $1060,x
	lda.w $1864
	cmp.w #$0001
	beq CODE_C51CB1
	ldx.w $2022
	stz.b $30,x
CODE_C51CB1:						; from CODE_C51C90
	ldx.b $6F
	lda.w #$24FA
	jml.l CODE_C457B5
CODE_C51CBA:						; from CODE_C51C58, CODE_C51C90
	lda.w #$2524
	jml.l CODE_C457B5
CODE_C51CC1:						; asstab entry 27: an assignment routine
	stz.w $14E5
	lda.w $189C
	beq CODE_C51CD2
	lda.w $189E
	beq CODE_C51CD2
	inc.w $18A2
	rtl
CODE_C51CD2:						; from CODE_C51CC1
	lda.w #$FFFF
	sta.w $05A0
	jsl.l $C493E1
	lda.w $0D60,x
	bit.w #$0002
	bne CODE_C51CE7
	jmp.w CODE_C51E81
CODE_C51CE7:						; from CODE_C51CD2
	and.w #$FFFD
	sta.w $0D60,x
	lda.w $114D
	bne CODE_C51CF6
	jml.l CODE_C50ADD
CODE_C51CF6:						; from CODE_C51CE7
	lda.w $10F1
	bit.w #$0040
	beq CODE_C51D02
	jml.l CODE_C50ADD
CODE_C51D02:						; from CODE_C51CF6
	lda.w $114B
	cmp.w #$0003
	bne CODE_C51D16
	lda.w $12AB
	cmp.w $12AD
	beq CODE_C51D16
	jml.l CODE_C50A14
CODE_C51D16:						; from CODE_C51D02
	lda.w $10F1
	bit.w #$0008
	beq CODE_C51D22
	jml.l CODE_C47323
CODE_C51D22:						; from CODE_C51D16
	jsl.l CODE_C48840
	lda.w #$FFFF
	sta.w $0AE0,x
	sta.w $0B00,x
	lda.w $186E
	bne CODE_C51D37
	jmp.w CODE_C51E81
CODE_C51D37:						; from CODE_C51D22
	lda.w $18BE
	ora.w $18C0
	beq CODE_C51D42
	jmp.w CODE_C51E81
CODE_C51D42:						; from CODE_C51D37
	lda.w #$FFFF
	sta.w $184C
	sta.w $184E
	stz.w $18E2
	stz.w $18E4
	lda.w #$0008
	trb.w $12FF
	trb.w $1301
	lda.w $17B5
	ora.w $17B7
	ora.w $17B9
	ora.w $17BB
	ora.w $17BD
	beq CODE_C51D7B
	lda.l $7E2CF5
	beq CODE_C51D7B
	lda.w #$0040
	tsb.w $10F5
	jsl.l CODE_C52264
CODE_C51D7B:						; from CODE_C51D42
	lda.w $234C
	bne CODE_C51D90
	lda.w $14F5
	beq CODE_C51D90
	jsl.l CODE_C51F60
	lsr a
	sta.b $7F
	jsl.l CODE_C51DF6
CODE_C51D90:						; from CODE_C51D7B
	lda.w $234C
	bne CODE_C51DA5
	lda.w $14F7
	beq CODE_C51DA5
	jsl.l CODE_C51F6E
	lsr a
	sta.b $7F
	jsl.l CODE_C51E0C
CODE_C51DA5:						; from CODE_C51D90
	stz.w $234C
	stz.b $67
	lda.w #$0002
	sta.b $6B
	sta.b $7F
	jsl.l CODE_C51DB8
	jmp.w CODE_C51E81
CODE_C51DB8:						; from CODE_C51E81, CODE_C51DA5 and other segments
	lda.w $186E
	bne CODE_C51DC0
	jmp.w CODE_C51E80
CODE_C51DC0:						; from CODE_C51DB8
	lda.b $7F
	cmp.w $17B5
	bne CODE_C51DCA
	jmp.w CODE_C51E80
CODE_C51DCA:						; from CODE_C51DC0
	cmp.w $17B7
	bne CODE_C51DD2
	jmp.w CODE_C51E80
CODE_C51DD2:						; from CODE_C51DCA
	cmp.w $17B9
	bne CODE_C51DDA
	jmp.w CODE_C51E80
CODE_C51DDA:						; from CODE_C51DD2
	cmp.w $17BB
	bne CODE_C51DE2
	jmp.w CODE_C51E80
CODE_C51DE2:						; from CODE_C51DDA
	cmp.w $17BD
	bne CODE_C51DEA
	jmp.w CODE_C51E80
CODE_C51DEA:						; from CODE_C51DF6, CODE_C51E0C, CODE_C51DE2
	jsl.l CODE_C547CB
	jsl.l CODE_C541D3
	jml.l CODE_C5111A
CODE_C51DF6:						; from CODE_C51D7B and other segments
	lda.w $186E
	cmp.w #$0002
	bne CODE_C51E1F
	stz.b $6B
	lda.w #$0002
	sta.b $67
	lda.w #$0001
	sta.b $7F
	bra CODE_C51DEA
CODE_C51E0C:						; from CODE_C51D90 and other segments
	lda.w $186E
	cmp.w #$0002
	bne CODE_C51E1F
	stz.b $67
	lda.w #$0002
	sta.b $6B
	sta.b $7F
	bra CODE_C51DEA
CODE_C51E1F:						; from CODE_C51DF6, CODE_C51E0C
	ldy.b $6F
	sty.b $6B
	lda.b $7F
	asl a
	sta.b $7F
	sta.b $6F
	tax
	phy
	ldy.w #$0000
	lda.w $1020,x
	beq CODE_C51E37
	ldy.w #$0002
CODE_C51E37:						; from CODE_C51E1F
	lda.w #$FFFF
	sta.w $184C,y
	jsl.l CODE_C5404A
	ply
	sty.b $6B
	ldx.b $6F
	phy
	ldy.w #$0000
	lda.w $1020,x
	beq CODE_C51E52
	ldy.w #$0002
CODE_C51E52:						; from CODE_C51E37
	lda.w $12FF,y
	ply
	bit.w #$0008
	beq CODE_C51E78
	lda.w $1020,x
	beq CODE_C51E6D
	lda.w #$0168
	sta.w $0B00,y
	txa
	lsr a
	sta.w $0B40,y
	bra CODE_C51E78
CODE_C51E6D:						; from CODE_C51E52
	lda.w #$0258
	sta.w $0AE0,y
	txa
	lsr a
	sta.w $0B20,y
CODE_C51E78:						; from CODE_C51E52
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
CODE_C51E80:						; from CODE_C51DB8, CODE_C51E81, CODE_C51EB8, CODE_C51DC0, ...
	rtl
CODE_C51E81:						; no caller found (not traced)
	stz.w $18C0
	stz.b $7F
	jsl.l CODE_C51EB8
	lda.w #$0020
	sta.b $7F
	jsl.l CODE_C51EB8
	ldx.b $6F
	lda.w $0AE0,x
	bpl CODE_C51E80
	lda.w $0B00,x
	bpl CODE_C51E80
	stz.b $6B
	lda.w #$0001
	sta.b $7F
	inc a
	sta.b $67
	jsl.l CODE_C51DB8
	lda.w #$001C
	sta.b $7F
	ldx.b $6F
	jml.l CODE_C4373E
CODE_C51EB8:						; from CODE_C51E81 and other segments
	lda.b $6F
	clc
	adc.b $7F
	tay
	lda.w $0AE0,y
	bmi CODE_C51E80
	lda.w $0B20,y
	asl a
	sta.b $83
	tay
	stz.b $63
	stz.b $6B
	lda.w $1020,y
	beq CODE_C51ED8
	lda.w #$0002
	sta.b $6B
CODE_C51ED8:						; from CODE_C51EB8
	phy
	ldy.b $6B
	lda.w $12FF,y
	ply
	bit.w #$0008
	bne CODE_C51F08
	phy
	ldy.b $6B
	lda.w $18E2,y
	beq CODE_C51EEF
	ply
	bra CODE_C51F08
CODE_C51EEF:						; from CODE_C51ED8
	inc a
	sta.w $18E2,y
	ply
	lda.b $6F
	clc
	adc.b $7F
	tay
	lda.w $0AE0,y
	ora.w #$FF00
	sta.w $0AE0,y
	ldx.b $6F
	jmp.w CODE_C54070
CODE_C51F08:						; from CODE_C51ED8
	lda.b $6F
	clc
	adc.b $7F
	tay
	lda.w $0AE0,y
	sec
	sbc.b $9B
	sta.w $0AE0,y
	bmi CODE_C51F1C
	jmp.w CODE_C51E80
CODE_C51F1C:						; from CODE_C51F08
	ldx.b $6F
	phx
	ldx.b $83
	stx.b $6F
	phy
	ldy.w #$0000
	lda.w $1020,x
	beq CODE_C51F2F
	ldy.w #$0002
CODE_C51F2F:						; from CODE_C51F1C
	lda.w $12FF,y
	ply
	bit.w #$0008
	beq CODE_C51F44
	stz.b $87
	jsl.l CODE_C54DA4
	bmi CODE_C51F44
	jsl.l CODE_C54070
CODE_C51F44:						; from CODE_C51F2F
	plx
	stx.b $6F
	rtl
CODE_C51F48:						; from CODE_C51F60, CODE_C51F6E and other segments
	ldy.w #$0000
CODE_C51F4B:						; from CODE_C51F4B
	lda.w $1525,y
	cmp.b $6B
	beq CODE_C51F5E
	iny
	iny
	cpy.w #$000A
	bcc CODE_C51F4B
	lda.w #$FFFF
	bra CODE_C51F5F
CODE_C51F5E:						; from CODE_C51F4B
	tya
CODE_C51F5F:						; from CODE_C51F4B
	rtl
CODE_C51F60:						; from CODE_C51D7B and other segments
	lda.w #$0000
	sta.b $6B
	jsl.l CODE_C51F48
	tay
	lda.w $1511,y
	rtl
CODE_C51F6E:						; from CODE_C51D90 and other segments
	lda.w #$0002
	sta.b $6B
	jsl.l CODE_C51F48
	tay
	lda.w $1511,y
	rtl
CODE_C51F7C:						; called from other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	stz.b $65
	lda.w #$10F9
	sta.b $63
CODE_C51F93:						; from CODE_C51F93
	lda.b [$63]
	jsl.l CODE_C51FBA
	inc.b $63
	inc.b $63
	lda.b [$63]
	bne CODE_C51F93
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
	pla
	sta.b $81
	pla
	sta.b $7F
	rtl
CODE_C51FBA:						; from CODE_C51F93 and other segments
	and.w #$00FF
	cmp.w #$0034
	beq CODE_C52007
	lda.b [$63]
	xba
	and.w #$007F
	asl a
	tay
	lda.w #$005C
	sta.b $83
	lda.w $0FE0,y
	bne CODE_C51FE6
	lda.w #$FFA4
	sta.b $83
	cmp.w $2036
	bmi CODE_C52007
	lda.w #$FFBB
	sta.w $2036
	bra CODE_C51FF3
CODE_C51FE6:						; from CODE_C51FBA
	lda.b $83
	cmp.w $2036
	bpl CODE_C52007
	lda.w #$0045
	sta.w $2036
CODE_C51FF3:						; from CODE_C51FBA
	lda.w #$0050
	sta.b $7F
	lda.w $2034
	bpl CODE_C52002
	lda.w #$FFB0
	sta.b $7F
CODE_C52002:						; from CODE_C51FF3
	lda.b $7F
	sta.w $2034
CODE_C52007:						; from CODE_C51FBA, CODE_C51FE6
	rtl

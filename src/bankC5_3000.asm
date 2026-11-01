; Segment bankC5_3000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C5308D
CODE_C5308D:						; called from other segments
	cmp.b $0C
	bcc CODE_C53095
	cmp.b $A5
	bcc CODE_C5309F
CODE_C53095:						; from CODE_C5308D
	lda.b $0C
CODE_C53097:						; from CODE_C53097
	jsr.w CODE_C530B3
	bcc CODE_C5309F
	inc a
	bra CODE_C53097
CODE_C5309F:						; from CODE_C5308D, CODE_C53097
	rts
CODE_C530A0:						; called from other segments
	cmp.b $0A
	bcc CODE_C530A8
	cmp.b $0C
	bcc CODE_C530B2
CODE_C530A8:						; from CODE_C530A0
	lda.b $0A
CODE_C530AA:						; from CODE_C530AA
	jsr.w CODE_C530B3
	bcc CODE_C530B2
	inc a
	bra CODE_C530AA
CODE_C530B2:						; from CODE_C530A0, CODE_C530AA
	rts
CODE_C530B3:						; from CODE_C53097, CODE_C530AA
	cmp.w $006D,y
	beq CODE_C530CD
	cmp.w $006E,y
	beq CODE_C530CD
	cmp.w $006F,y
	beq CODE_C530CD
	cmp.w $0070,y
	beq CODE_C530CD
	cmp.w $0071,y
	beq CODE_C530CD
	clc
CODE_C530CD:						; from CODE_C530B3
	rts
CODE_C530CE:						; from CODE_C5324F, CODE_C5328C
	lda.w $0008,x
	pha
	lda.w $003A,x
	pha
	lda.w $0008,y
	sta.w $0008,x
	lda.w $003A,y
	sta.w $003A,x
	pla
	sta.w $003A,y
	pla
	sta.w $0008,y
	rts
CODE_C530EB:						; from CODE_C531EA, CODE_C531F8
	phx
	lda.b ($A1)
	inc a
	sta.b ($A1)
	lda.b $A3
	sta.w $003A,y
	asl a
	tax
	lda.l PlayerList,x
	and.w #$3FFF
	sta.w $0008,y
	iny
	iny
	plx
	rts
CODE_C53106:						; called from other segments
	tax
	lda.l $C30000,x
	and.w #$07FF
	lsr a
	sec
	sbc.w #$001C
	sta.b $A5
	txa
	jsr.w CODE_C5311F
	clc
	adc.b $A5
	sta.b $0A
	rts
CODE_C5311F:						; from CODE_C53106, CODE_C53136
	clc
	adc.l $C30008,x
	tax
	lda.l $C30000,x
	xba
	ldx.w #$0000
CODE_C5312D:						; from CODE_C5312D
	inx
	asl a
	asl a
	asl a
	asl a
	bne CODE_C5312D
	txa
	rts
CODE_C53136:						; no caller found (not traced)
	pha
	tax
	jsr.w CODE_C5311F
	sta.b $A5
	pla
	tax
	lda.l $C30000,x
	and.w #$07FF
	lsr a
	sec
	sbc.w #$001C
	clc
	adc.b $A5
	sta.b $A5
	txa
	clc
	adc.l $C30006,x
	tax
	lda.l $C30003,x
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.b $A5
	sta.b $0A
	rts
CODE_C53167:						; from CODE_C531C7 and other segments
	lda.l $C30000,x
	pha
	and.w #$000F
	sta.w $0432,y
	pla
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	sta.w $0430,y
	lda.l $C30001,x
	pha
	and.w #$000F
	sta.w $0436,y
	pla
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	sta.w $0434,y
	lda.l $C30002,x
	pha
	and.w #$000F
	eor.w #$FFFF
	inc a
	sta.w $043A,y
	pla
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	sta.w $0438,y
	lda.l $C30004,x
	and.w #$00FF
	sta.w $043C,y
	rts
CODE_C531BC:						; called from other segments
	ldy.w #$2DC9
	sta.b $9F
	sty.b $A1
	jsr.w CODE_C531C7
	rtl
CODE_C531C7:						; from CODE_C531BC and other segments
	asl a
	tax
	lda.l $C30000,x
	tax
	adc.l $C30006,x
	tax
	jsr.w CODE_C53167
	tyx
	stz.w $0000,x
	stz.w $0002,x
	stz.w $0004,x
	stz.w $0006,x
	stz.b $A3
	ldx.w #$0000
	ldy.b $A1
CODE_C531EA:						; from CODE_C53214
	lda.l $306A56,x
	and.w #$001F
	cmp.b $9F
	bne CODE_C531F8
	jsr.w CODE_C530EB
CODE_C531F8:						; from CODE_C531EA
	lda.b $A3
	inc a
	cmp.w #$027E
	bcs CODE_C53221
	sta.b $A3
	lda.l $306A57,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$001F
	cmp.b $9F
	bne CODE_C53214
	jsr.w CODE_C530EB
CODE_C53214:						; from CODE_C531F8
	inx
	inx
	inx
	lda.b $A3
	inc a
	sta.b $A3
	cmp.w #$027E
	bcc CODE_C531EA
CODE_C53221:						; from CODE_C531F8
	lda.b ($A1)
	sta.b $A3
	ldy.b $A1
CODE_C53227:						; from CODE_C53261
	lda.w $003A,y
	cmp.w #$026A
	bcc CODE_C53241
	phy
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	ply
	cmp.w #$0000
	bne CODE_C53261
	pea.w $0000
	bra CODE_C5324F
CODE_C53241:						; from CODE_C53227
	asl a
	tax
	lda.l PlayerList,x
	bit.w #$C000
	bne CODE_C53261
	pea.w $0000
CODE_C5324F:						; from CODE_C53227
	ldx.b $A1
	lda.w $0002,x
	inc.w $0002,x
	asl a
	adc.b $A1
	tax
	jsr.w CODE_C530CE
	plx
	bra CODE_C53261
CODE_C53261:						; from CODE_C53227, CODE_C53241, CODE_C5324F
	iny
	iny
	dec.b $A3
	bne CODE_C53227
	lda.b ($A1)
	sta.b $A3
	ldy.b $A1
CODE_C5326D:						; from CODE_C5329F
	lda.w $003A,y
	cmp.w #$026A
	bcc CODE_C53284
	phy
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	ply
	cmp.w #$0003
	bcc CODE_C5329F
	bra CODE_C5328C
CODE_C53284:						; from CODE_C5326D
	asl a
	tax
	lda.l PlayerList,x
	bpl CODE_C5329F
CODE_C5328C:						; from CODE_C5326D
	ldx.b $A1
	lda.w $0004,x
	inc.w $0004,x
	clc
	adc.w $0002,x
	asl a
	adc.b $A1
	tax
	jsr.w CODE_C530CE
CODE_C5329F:						; from CODE_C5326D, CODE_C53284
	iny
	iny
	dec.b $A3
	bne CODE_C5326D
	ldx.b $A1
	lda.w $0000,x
	sec
	sbc.w $0002,x
	sbc.w $0004,x
	sta.w $0006,x
	rts
CODE_C532B5:						; no caller found (not traced)
	ldx.w #$2DC9
	lda.b $6B
	beq CODE_C532BF
	ldx.w #$3207
CODE_C532BF:						; from CODE_C532B5
	lda.w $0004,x
	sta.b $7F
	rtl
CODE_C532C5:						; called from other segments
	pei ($6F)
	pei ($67)
	phx
	phy
	jsl.l GetTeamLines
	pei ($6F)
	lda.w #$2DC9
	ldx.b $6B
	beq CODE_C532DB
	lda.w #$3207
CODE_C532DB:						; from CODE_C532C5
	sta.b $67
	clc
	adc.w #$0008
	tax
	ldy.w #$001C
CODE_C532E5:						; from CODE_C532E5
	lda.w $006C,x
	sta.b ($6F)
	inx
	inx
	inc.b $6F
	inc.b $6F
	dey
	bne CODE_C532E5
	ply
	lda.w $186E
	bne CODE_C53316
	stz.w $18AA
	ldx.b $67
	lda.w $006C,x
	sta.w $0000,y
	lda.w $006E,x
	sta.w $0002,y
	lda.w $0070,x
	sta.w $0004,y
	lda.w $0072,x
	sta.w $0006,y
CODE_C53316:						; from CODE_C532E5
	ply
	plx
	pla
	sta.b $67
	pla
	sta.b $6F
	rtl
CODE_C5331F:						; no caller found (not traced)
	pei ($7F)
	pei ($81)
	pei ($6B)
	pei ($6D)
	stz.b $6B
	lda.w $1153
	sta.b $7F
	bpl CODE_C53339
	and.w #$00FF
	sta.b $7F
	inc.b $6B
	inc.b $6B
CODE_C53339:						; from CODE_C5331F
	jsl.l PlayerShortName
	pla
	sta.b $6D
	pla
	sta.b $6B
	pla
	sta.b $81
	pla
	sta.b $7F
	rtl
PlayerShortName:					; from CODE_C53339 and other segments
	pei ($7F)
	pei ($81)
	pei ($6B)
	pei ($6D)
	pei ($63)
	pei ($65)
	jsl.l CODE_C535EF
	stz.b $69
	lda.w #$04F5
	sta.b $67
	lda.w #$0002
	sta.b [$67]
	inc.b $67
	inc.b $67
	pei ($63)
	pei ($65)
	lda.b $63
	clc
	adc.b [$63]
	sta.b $63
	lda.b [$63]
	and.w #$00FF
	sta.b $7F
	jsl.l PutDigits2
	lda.w #$0020
	sta.b [$67]
	inc.b $67
	pla
	sta.b $65
	pla
	sta.b $63
	lda.b [$63]
	sta.b $7F
	clc
	adc.b $63
	sta.b $6B
	lda.b $65
	sta.b $6D
	inc.b $63
	inc.b $63
	lda.b [$63]
	inc.b $63
	sta.b [$67]
	inc.b $67
	lda.w #$002E
	sta.b [$67]
	inc.b $67
	lda.w #$0020
	sta.b [$67]
	inc.b $67
CODE_C533B4:						; from CODE_C533B4
	lda.b [$63]
	inc.b $63
	and.w #$00FF
	cmp.w #$0020
	bne CODE_C533B4
CODE_C533C0:						; from CODE_C533C0
	lda.b [$63]
	inc.b $63
	sta.b [$67]
	inc.b $67
	lda.b $63
	cmp.b $6B
	bne CODE_C533C0
	pla
	sta.b $65
	pla
	sta.b $63
	pla
	sta.b $6D
	pla
	sta.b $6B
	pla
	sta.b $81
	pla
	sta.b $7F
	rtl
CODE_C533E1:						; called from other segments
	ldx.w #$2DC9
	lda.w $1153
	bpl CODE_C533EF
	and.w #$00FF
	ldx.w #$3207
CODE_C533EF:						; from CODE_C533E1 and other segments
	stx.b $9F
	xba
	lsr a
	lsr a
	lsr a
	adc.b $9F
	tax
	lda.w #$0032
	jsl.l CODE_C4C561
	tay
	phx
	lda.w $0110,x
	and.w #$007F
	jsr.w CODE_C5B67A
	tax
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$00B0
	sta.w $0001,y
	txa
	and.w #$000F
	adc.w #$00B0
	ora.w #$A000
	sta.w $0002,y
	plx
	phy
	sep #$21
	lda.w $0118,x
	cmp.b #$3D
	bne CODE_C53432
	lda.b #$2E
CODE_C53432:						; from CODE_C533EF
	eor.b #$80
	sta.w $0004,y
	lda.b #$AE
	sta.w $0005,y
	lda.b #$A0
	sta.w $0006,y
CODE_C53441:						; from CODE_C53441
	lda.w $0119,x
	inx
	cmp.b #$20
	bne CODE_C53441
CODE_C53449:						; from CODE_C53454
	inx
	iny
	lda.w $0118,x
	cmp.b #$3D
	bne CODE_C53454
	lda.b #$2E
CODE_C53454:						; from CODE_C53449
	eor.b #$80
	sta.w $0006,y
	eor.b #$80
	bne CODE_C53449
	sta.w $0006,y
	rep #$21
	tya
	sbc.b $01,s
	adc.w #$0005
	sep #$20
	ply
	sta.w $0000,y
	rep #$20
	tya
	ldx.w #$007E
	rtl
CODE_C53475:						; no caller found (not traced)
	lda.w #$000B
	sta.b $7F
	lda.w #$0002
	sta.b $83
	lda.w $24C0
	sta.b $87
	jml.l CODE_C528D4
PutDigits2:							; from PlayerShortName and other segments
	lda.w #$2020
	sta.b $9F
	lda.b $7F
	and.w #$00FF
	cmp.w #$000A
	bcc CODE_C534A1
	lsr a
	lsr a
	lsr a
	lsr a
	clc
	adc.w #$0030
	sta.b $9F
CODE_C534A1:						; from PutDigits2
	lda.b $7F
	and.w #$000F
	clc
	adc.w #$0030
	sta.b $A0
	lda.b $9F
	sta.b [$67]
	inc.b $67
	inc.b $67
	rtl
CODE_C534B5:						; no caller found (not traced)
	phx
	stz.b $69
	lda.w #$0513
	sta.b $67
	lda.b $7F
CODE_C534BF:						; from CODE_C534BF
	sta.b $34
	lda.w #$000A
	sta.b $30
	jsl.l Div16x8U
	dec.b $67
	sep #$20
	lda.l RDMPYL
	sta.b [$67]
	rep #$30
	lda.b $2C
	bne CODE_C534BF
	dec.b $67
	dec.b $67
	lda.w #$0513
	sec
	sbc.b $67
	sta.b [$67]
	plx
	rtl
CODE_C534E8:						; called from other segments
	phx
	ldy.b $83
	lda.b $7F
	cpy.w #$0002
	bne CODE_C534FC
CODE_C534F2:						; from CODE_C534F2
	cmp.w #$0064
	bcc CODE_C534FC
	sbc.w #$0064
	bra CODE_C534F2
CODE_C534FC:						; from CODE_C534E8, CODE_C534F2
	iny
	iny
	sty.w $0559
	dey
	ldx.w #$2020
	stx.w $055B
	stx.w $055D
	stx.w $055F
	stx.w $0561
	ldx.w #$000A
	stx.b $30
CODE_C53516:						; from CODE_C53516
	sta.b $34
	jsl.l Div16x8U
	lda.l RDMPYL
	xba
	dey
	sta.w $0559,y
	lda.b $2C
	bne CODE_C53516
	ldx.w #$0559
	stx.b $67
	ldx.w #$0000
	stx.b $69
	plx
	rtl
CODE_C53535:						; called from other segments
	jsl.l CODE_C510F6
	lda.w $189C
	beq CODE_C5354B
	lda.w #$0019
	sta.b $7F
	lda.w #$0025
	sta.w $1151
	bra CODE_C53568
CODE_C5354B:						; from CODE_C53535
	lda.b $9F
	sta.w $1151
	lda.w $114B
	cmp.w #$0003
	bne CODE_C53568
	lda.w $1864
	bne CODE_C53568
	lda.w #$0500
	sta.w $1151
	lda.w #$012C
	sta.b $7F
CODE_C53568:						; from CODE_C53535, CODE_C5354B
	lda.b $7F
	sta.w $114D
	sta.w $17B3
	sta.w $10F3
	rtl
CODE_C53574:						; called from other segments
	lda.w $12CB
	pha
	lda.w $12CD
	pha
	ldx.w #$01AE
CODE_C5357F:						; from CODE_C5357F
	stz.w $125F,x
	dex
	dex
	bpl CODE_C5357F
	pla
	sta.w $12CD
	pla
	sta.w $12CB
	lda.w #$FFFF
	sta.w $13DB
	sta.w $13F5
	stz.w $1283
	lda.w #$000C
	sta.w $1285
	lda.w $17C9
	sta.w $17D7
	asl a
	tax
	lda.l $C30000,x
	sta.w $17D3
	lda.w $17CB
	sta.w $17D9
	asl a
	tax
	lda.l $C30000,x
	sta.w $17D5
	rtl
restoreteams:						; called from other segments
	stz.b $6B
	jsl.l CODE_C535CA
	lda.w #$0002
	sta.b $6B
CODE_C535CA:						; from restoreteams and other segments
	ldy.b $6B
	lda.w #$0006
	sta.w $12C7,y
	lda.w #$0032
	sta.b $7F
CODE_C535D7:						; from CODE_C535DE
	lda.b $6B
	beq CODE_C535DE
	lda.w #$0034
CODE_C535DE:						; from CODE_C535D7
	clc
	adc.b $7F
	tay
	lda.w #$FFFE
	sta.w $1373,y
	dec.b $7F
	dec.b $7F
	bpl CODE_C535D7
	rtl
CODE_C535EF:						; from PlayerShortName and other segments
	ldy.b $6B
	lda.w #$00C3
	sta.b $65
	lda.w $17D3,y
	sta.b $63
	lda.b [$63]
	and.w #$07FF
	sta.b $63
	lda.b $7F
	asl a
	tay
	lda.b [$63],y
	and.w #$3FFF
	sta.b $63
	adc.b $63
	sta.b $63
	lda.b [$63]
	sta.b $63
	rtl
loadTeamStruct:						; from CODE_C5404A and other segments
	lda.w $1020,x
	beq CODE_C53623
	stz.b $67
	lda.w #$0002
	sta.b $6B
	rtl
CODE_C53623:						; from loadTeamStruct
	lda.w #$0002
	sta.b $67
	stz.b $6B
	rtl
DATA8_C5362B:						; not traced: data between routines
	db $6B
CODE_C5362C:						; called from other segments
	rtl
DATA8_C5362D:						; not traced: data between routines
	db $6B
CODE_C5362E:						; called from other segments
	ldy.w #$2DC9
	lda.b $6B
	beq CODE_C53638
	ldy.w #$3207
CODE_C53638:						; from CODE_C5362E
	lda.w $0000,y
	sta.b $7F
	rtl
CODE_C5363E:						; no caller found (not traced)
	ldy.b $83
	lda.w $1020,x
	beq CODE_C53647
	iny
	iny
CODE_C53647:						; from CODE_C5363E
	lda.w $0000,y
	clc
	adc.b $7F
	sta.w $0000,y
	rtl
CODE_C53651:						; called from other segments
	jsl.l CODE_C38799
	lda.w $1864
	cmp.w #$0001
	beq CODE_C53683
	lda.w $18BE
	bne CODE_C53683
	ldy.w #$0008
CODE_C53665:						; from CODE_C5367F
	lda.w $1525,y
	and.w #$FF00
	cmp.w #$8000
	bne CODE_C5367F
	lda.w $1525,y
	and.w #$00FF
	sta.w $1525,y
	inc a
	inc a
	lsr a
	sta.w $17B5,y
CODE_C5367F:						; from CODE_C53665
	dey
	dey
	bpl CODE_C53665
CODE_C53683:						; from CODE_C53651
	stz.w $06EC
	ldx.w #$0016
	lda.w #$FFFF
CODE_C5368C:						; from CODE_C5368C
	sta.w $14F9,x
	stz.w $05CC,x
	stz.w $0694,x
	stz.w $06B4,x
	stz.w $06D4,x
	dex
	dex
	bpl CODE_C5368C
	sta.w $066A
	ldx.w #$0008
CODE_C536A5:						; from CODE_C536A5
	sta.w $1511,x
	dex
	dex
	bpl CODE_C536A5
	lda.w $14F5
	beq CODE_C536E6
	lda.w #$0005
	sta.b $38
	ldx.w $05BC
	lda.w #$FFFF
	sta.w $05BC
	dex
	dex
	bpl CODE_C536C6
	ldx.w #$0008
CODE_C536C6:						; from CODE_C536A5, CODE_C536E2
	lda.w $1525,x
	bne CODE_C536DB
	stx.b $8F
	phx
	lda.w $05BC
	bpl CODE_C536D6
	stx.w $05BC
CODE_C536D6:						; from CODE_C536C6
	jsl.l findpc
	plx
CODE_C536DB:						; from CODE_C536C6
	dex
	dex
	bpl CODE_C536E2
	ldx.w #$0008
CODE_C536E2:						; from CODE_C536DB
	dec.b $38
	bne CODE_C536C6
CODE_C536E6:						; from CODE_C536A5
	lda.w $14F7
	beq CODE_C53723
	lda.w #$0005
	sta.b $38
	ldx.w $05BE
	lda.w #$FFFF
	sta.w $05BE
	dex
	dex
	bpl CODE_C53700
	ldx.w #$0008
CODE_C53700:						; from CODE_C536E6, CODE_C5371F
	lda.w $1525,x
	cmp.w #$0002
	bne CODE_C53718
	stx.b $8F
	phx
	lda.w $05BE
	bpl CODE_C53713
	stx.w $05BE
CODE_C53713:						; from CODE_C53700
	jsl.l findpc
	plx
CODE_C53718:						; from CODE_C53700
	dex
	dex
	bpl CODE_C5371F
	ldx.w #$0008
CODE_C5371F:						; from CODE_C53718
	dec.b $38
	bne CODE_C53700
CODE_C53723:						; from CODE_C536E6
	rtl
CODE_C53724:						; called from other segments
	ldy.b $7F
	lda.w $14F9,y
	bpl CODE_C53769
	phx
	ldx.w #$0000
	cpy.w #$000C
	bcc CODE_C53737
	ldx.w #$0002
CODE_C53737:						; from CODE_C53724
	lda.w $14F5,x
	beq CODE_C5375B
	ldy.w $05C4,x
	dey
	dey
	bpl CODE_C53746
	ldy.w #$0008
CODE_C53746:						; from CODE_C53737
	lda.w #$0005
	sta.b $40
	txa
CODE_C5374C:						; from CODE_C53764
	cmp.w $1525,y
	bne CODE_C5375D
	sty.b $8F
	tya
	sta.w $05C4,x
	jsl.l AssignPadPlayer
CODE_C5375B:						; from CODE_C53737
	plx
	rtl
CODE_C5375D:						; from CODE_C5374C
	dey
	dey
	bpl CODE_C53764
	ldy.w #$0008
CODE_C53764:						; from CODE_C5375D
	dec.b $40
	bne CODE_C5374C
	plx
CODE_C53769:						; from CODE_C53724
	rtl
CODE_C5376A:						; called from other segments
	ldy.b $7F
	lda.w $14F9,y
	bpl CODE_C53775
	jsl.l AssignPadPlayer
CODE_C53775:						; from CODE_C5376A
	rtl
AssignPadPlayer:					; from CODE_C5374C, CODE_C5376A, CODE_C53964, ...
	lda.w #$FFFF
	sta.w $066A
	ldy.b $8F
	lda.w $1511,y
	cmp.b $7F
	beq CODE_C537C3
	tay
	cpy.w #$0018
	bcs CODE_C537A8
	lda.w $0D60,y
	and.w #$FFF7
	ora.w #$0002
	sta.w $0D60,y
	lda.w #$FFFF
	sta.w $14F9,y
	lda.w $0A20,y
	bne CODE_C537A8
	lda.w #$0000
	sta.w $05CC,y
CODE_C537A8:						; from AssignPadPlayer
	ldy.b $7F
	cpy.w #$0018
	bcs CODE_C537C3
	lda.w $0D60,y
	ora.w #$0008
	sta.w $0D60,y
	lda.b $8F
	sta.w $14F9,y
	tay
	lda.b $7F
	sta.w $1511,y
CODE_C537C3:						; from AssignPadPlayer, CODE_C537A8
	rtl
findpc:								; from CODE_C536D6, CODE_C53713 and other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	lda.w #$0008
	sta.b $2C
	ldy.w $05A0
	bra CODE_C53813
CODE_C537DE:						; no caller found (not traced)
	lda.w $0A20,x
	beq CODE_C537F8
	lda.w $14F9,x
	bmi CODE_C537F8
	lda.w $1000,x
	bne CODE_C537F8
	lda.w $05E4,x
	cmp.w #$0028
	bcs CODE_C537F8
	jmp.w CODE_C53882
CODE_C537F8:						; from CODE_C537DE
	lda.w $14F9,y
	bmi CODE_C53806
	tay
	lda.w $1525,y
	cmp.w $1525,x
	beq CODE_C53813
CODE_C53806:						; from CODE_C537F8
	ldy.w #$0000
	lda.w $0FE0,x
	bne CODE_C53811
	ldy.w #$0004
CODE_C53811:						; from CODE_C53806
	sty.b $2C
CODE_C53813:						; from findpc, CODE_C537F8
	lda.w #$0006
	sta.b $83
	ldy.b $8F
	lda.w #$FFFF
	sta.b $87
	ldx.w #$0000
	lda.w $17B5,y
	cmp.w #$0001
	beq CODE_C5382D
	ldx.w #$000C
CODE_C5382D:						; from CODE_C53813, CODE_C5386A
	lda.w $0A20,x
	bmi CODE_C5386A
	beq CODE_C5386A
	lda.w $0D60,x
	bit.w #$1000
	bne CODE_C5386A
	lda.w $0C80,x
	cmp.w #$2030
	bcc CODE_C53849
	cmp.w #$21BD
	bcc CODE_C53854
CODE_C53849:						; from CODE_C5382D
	lda.w $0D60,x
	and.w #$1000
	ora.w $1000,x
	bne CODE_C5386A
CODE_C53854:						; from CODE_C5382D
	lda.w $14F9,x
	bmi CODE_C5385D
	cmp.b $8F
	bne CODE_C5386A
CODE_C5385D:						; from CODE_C53854
	stz.b $40
	lda.w $05E4,x
	cmp.b $87
	bcs CODE_C5386A
	stx.b $8B
	sta.b $87
CODE_C5386A:						; from CODE_C5382D, CODE_C53849, CODE_C53854, CODE_C5385D
	inx
	inx
	dec.b $83
	bne CODE_C5382D
	ldx.b $6F
	lda.b $87
	cmp.w #$FFFF
	beq CODE_C538C5
	ldy.b $8F
	lda.b $8B
	cmp.w $1511,y
	bne CODE_C538BF
CODE_C53882:						; from CODE_C537DE
	lda.w $1000,x
	bne CODE_C538C5
	pei ($8F)
	pei ($91)
	pei ($93)
	pei ($95)
	pei ($97)
	pei ($99)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	jsl.l CODE_C45606
	pla
	sta.b $69
	pla
	sta.b $67
	pla
	sta.b $65
	pla
	sta.b $63
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
	bra CODE_C538C5
CODE_C538BF:						; from CODE_C5386A
	sta.b $7F
	jsl.l AssignPadPlayer
CODE_C538C5:						; from CODE_C5386A, CODE_C53882
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
	rtl
CODE_C538DE:						; called from other segments
	ldy.w #$0000
	cpx.w #$000C
	bcc CODE_C538E9
	ldy.w #$000C
CODE_C538E9:						; from CODE_C538DE, CODE_C538F3
	lda.w $14F9,y
	bpl CODE_C538F3
	lda.w $0A20,y
	bpl CODE_C538F7
CODE_C538F3:						; from CODE_C538E9
	iny
	iny
	bra CODE_C538E9
CODE_C538F7:						; from CODE_C538E9
	phx
	jsl.l PadTakePosition
	plx
	rtl
CODE_C538FE:						; called from other segments
	lda.w #$0000
	bra PadTakePosition
CODE_C53903:						; called from other segments
	ldy.w #$0000
	cpx.w #$000C
	bcc CODE_C5390E
	ldy.w #$0002
CODE_C5390E:						; from CODE_C53903
	lda.w $17C5,y
	bne CODE_C53914
	rtl
CODE_C53914:						; from CODE_C5390E
	lda.w #$0002
	ldy.w $0FE0,x
	bne PadTakePosition
	lda.w #$0001
	bra PadTakePosition
CODE_C53921:						; called from other segments
	ldy.w #$0000
	cpx.w #$000C
	bcc CODE_C5392C
	ldy.w #$0002
CODE_C5392C:						; from CODE_C53921
	lda.w $17C5,y
	bne CODE_C53932
	rtl
CODE_C53932:						; from CODE_C5392C
	lda.w #$0001
	ldy.w $0FE0,x
	bne PadTakePosition
	lda.w #$0002
PadTakePosition:					; from CODE_C538FE, CODE_C538F7, CODE_C53914, ...
	sta.b $83
	phx
	ldy.b $8F
	ldx.w #$0000
	lda.w $17B5,y
	cmp.w #$0001
	beq CODE_C53950
	ldx.w #$000C
CODE_C53950:						; from PadTakePosition
	lda.w #$0005
	sta.b $7F
CODE_C53955:						; from CODE_C53955
	lda.w $0A20,x
	cmp.b $83
	beq CODE_C53964
	inx
	inx
	dec.b $7F
	bpl CODE_C53955
	bra CODE_C5397E
CODE_C53964:						; from CODE_C53955
	lda.w $14F9,x
	bpl CODE_C5397E
	lda.w $0D60,x
	bit.w #$1000
	bne CODE_C5397E
	lda.w $05A4,y
	inc a
	sta.w $05A4,y
	stx.b $7F
	jsl.l AssignPadPlayer
CODE_C5397E:						; from CODE_C53955, CODE_C53964
	plx
	rtl
CODE_C53980:						; called from other segments
	jsr.w CODE_C53984
	rtl
CODE_C53984:						; from CODE_C53980 and other segments
	jsl.l CODE_C5E50E
	stz.b $20
	stz.b $1E
	lda.w #$001D
	jsl.l CreateSpriteSharePal
	lda.w #$FFFF
	sta.b $0A,x
	lda.w #$0056
	sta.b $1A,x
	sta.w $1B0A
	lda.w #$0045
	sta.b $1C,x
	sta.w $1B0C
	lda.w $17C9
	asl a
	adc.w #$0081
	sta.w $17CD
	jsl.l CODE_C5EE6C
	lda.w $17CB
	asl a
	adc.w #$0080
	sta.w $17CF
	jsl.l CODE_C5EE6C
	lda.w #$00B8
	jsl.l CODE_C5EE6C
	lda.w #$00B9
	jsl.l CODE_C5EE6C
	jsl.l CODE_C4C530
	rts
CODE_C539D7:						; called from other segments
	ldx.w #$0009
	ldy.w #$0003
	lda.w #$5AF7
	jsl.l CODE_C58C36
	lda.w $17CB
	jsr.w CODE_C53A75
	ldy.w #$5B18
	jsl.l QueueVRAMDMALen
	lda.w $17C9
	jsr.w CODE_C53A75
	ldy.w #$5B1C
	jsl.l QueueVRAMDMALen
	lda.w $12AD
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldx.w #$04F5
	jsr.w CODE_C53A90
	ldy.w #$5B38
	jsl.l QueueVRAMDMALen
	lda.w $12AB
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldx.w #$04F5
	jsr.w CODE_C53A90
	ldy.w #$5B3C
	jmp.w QueueVRAMDMALen
CODE_C53A29:						; called from other segments
	jsl.l CODE_C51397
	lda.w $114B
	asl a
	asl a
	adc.w #$3A61
	ldx.w #$00C5
	ldy.w #$5B21
	jsl.l QueueVRAMDMALen
	lda.w $10F5
	bit.w #$2000
	bne CODE_C53A54
	ldx.w #$000A
	ldy.w #$0002
	lda.w #$5B00
	jml.l CODE_C58C36
CODE_C53A54:						; from CODE_C53A29
	ldx.w #$000A
	ldy.w #$0004
	lda.w #$5AC0
	jml.l CODE_C58C36
DATA8_C53A61:						; not traced: data between routines
	db $03,$B1,$F3,$F4,$03,$B2,$EE,$E4,$03,$B3,$F2,$E4,$03,$CF,$D4,$A0
CODE_C53A71:						; called from other segments
	jsr.w CODE_C53A75
	rtl
CODE_C53A75:						; from CODE_C539D7, CODE_C53A71
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l CODE_C4C3BA
	ldx.b $16
	lda.b $0A
	beq CODE_C53A8C
	inx
CODE_C53A8C:						; from CODE_C53A75
	jsl.l CODE_C4C3BA
CODE_C53A90:						; from CODE_C539D7
	lda.w #$0004
	jsl.l CODE_C4C561
	pha
	tay
	sep #$20
CODE_C53A9B:						; from CODE_C53A9B
	lda.w $0000,x
	beq CODE_C53AA9
	eor.b #$80
	sta.w $0001,y
	inx
	iny
	bra CODE_C53A9B
CODE_C53AA9:						; from CODE_C53A9B
	rep #$20
	sec
	tya
	sbc.b $01,s
	plx
	sep #$20
	sta.w $0000,x
	rep #$20
	txa
	ldx.w #$007E
	rts
CODE_C53ABC:						; called from other segments
	stz.b $6B
	ldx.w $0591
	bpl CODE_C53AD5
	txa
	eor.w #$FFFF
	inc a
	ldx.w #$0008
CODE_C53ACB:						; from CODE_C53ACB
	cmp.w $17B5,x
	beq CODE_C53AD5
	dex
	dex
	bpl CODE_C53ACB
	rtl
CODE_C53AD5:						; from CODE_C53ABC, CODE_C53ACB
	lda.w #$0002
	cmp.w $17B5,x
	bne CODE_C53ADF
	sta.b $6B
CODE_C53ADF:						; from CODE_C53AD5
	rtl
ResetBench:							; called from other segments
	stz.w $113F
	lda.w #$0010
	sta.b $83
	stz.b $63
	jsl.l CODE_C53AF8
	lda.w #$0001
	sta.b $83
	lda.w #$0002
	sta.b $63
CODE_C53AF8:						; from ResetBench and other segments
	lda.w #$0032
	sta.b $7F
CODE_C53AFD:						; from CODE_C53B4A
	lda.w $113F
	clc
	adc.b $83
	sta.w $113F
	lda.b $63
	beq CODE_C53B0D
	lda.w #$0034
CODE_C53B0D:						; from CODE_C53AFD
	adc.b $7F
	tay
	lda.w $1373,y
	bmi CODE_C53B2E
	beq CODE_C53B2E
	bit.w #$1000
	beq CODE_C53B4A
	and.w #$07FF
	sta.b $87
	bne CODE_C53B4A
	lda.w $113F
	sec
	sbc.b $83
	sta.w $113F
	bra CODE_C53B4A
CODE_C53B2E:						; from CODE_C53B0D
	lda.w $113F
	sec
	sbc.b $83
	sta.w $113F
	lda.w $1373,y
	cmp.w #$FFFD
	beq CODE_C53B4A
	cmp.w #$FFFC
	beq CODE_C53B4A
	lda.w #$FFFE
	sta.w $1373,y
CODE_C53B4A:						; from CODE_C53B0D, CODE_C53B2E
	dec.b $7F
	dec.b $7F
	bpl CODE_C53AFD
	rtl
CODE_C53B51:						; called from other segments
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
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	ldy.b $6B
	lda.w $1283,y
	sta.b $6F
	lda.w #$0005
	sta.b $8F
CODE_C53B81:						; from CODE_C53BD4
	ldx.b $6F
	lda.w $0D20,x
	and.w #$00FF
	bit.w #$0080
	beq CODE_C53B91
	ora.w #$FF00
CODE_C53B91:						; from CODE_C53B81
	sta.b $7F
	sta.w $0A20,x
	cmp.w #$0000
	bmi CODE_C53BD4
	jsl.l Setplass
	ldx.b $6F
	lda.w $0A20,x
	cmp.w #$0004
	bne CODE_C53BB2
	lda.w #$0012
	sta.b $7F
	jsl.l CODE_C43734
CODE_C53BB2:						; from CODE_C53B91
	ldx.b $6F
	lda.w $0D40,x
	and.w #$00FF
	asl a
	sta.b $8B
	lda.b $6B
	beq CODE_C53BC4
	lda.w #$0034
CODE_C53BC4:						; from CODE_C53BB2
	clc
	adc.b $8B
	tay
	lda.w #$FFFF
	sta.w $1373,y
	lsr.b $8B
	jsl.l setplayer
CODE_C53BD4:						; from CODE_C53B91
	ldx.b $6F
	lda.w #$FFFF
	sta.w $0D40,x
	sta.w $0D20,x
	inc.b $6F
	inc.b $6F
	dec.b $8F
	bpl CODE_C53B81
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
	rtl
Setplass:							; from CODE_C53B91 and other segments
	lda.w $0A20,x
	sta.b $7F
	bmi CODE_C53C3E
	lda.w #$00C5
	sta.b $65
	lda.w #$3C3F
	sta.b $63
	ldy.b $7F
	lda.b [$63],y
	and.w #$00FF
	sta.b $7F
	jml.l assreplace
CODE_C53C3E:						; from Setplass
	rtl
DATA8_C53C3F:						; not traced: data between routines
	db $07,$02,$02,$03,$05,$03,$05
setplayer:							; from CODE_C53BC4 and other segments
	phx
	phy
	lda.w $0D60,x
	and.w #$FFFB
	sta.w $0D60,x
	ldy.w #$0000
	lda.w $1020,x
	beq CODE_C53C5C
	ldy.w #$0002
CODE_C53C5C:						; from setplayer
	sty.b $63
	lda.b $8B
	and.w #$00FF
	sta.w $0DC0,x
	asl a
	sta.b $8B
	lda.w #$000B
	sta.b $7F
	lda.b $63
	beq CODE_C53C75
	lda.w #$0034
CODE_C53C75:						; from CODE_C53C5C
	adc.b $8B
	tay
	lda.w $1373,y
	sta.b $83
	tya
	sta.b $40
	asl a
	adc.b $40
	asl a
	sta.b $40
	lda.b $83
	bpl CODE_C53C96
	lda.w #$000A
	sta.b $7F
	lda.b $83
	cmp.w #$FFFE
	bne CODE_C53CA0
CODE_C53C96:						; from CODE_C53C75
	jsl.l CODE_C43734
	stz.w $1000,x
	stz.w $0C80,x
CODE_C53CA0:						; from CODE_C53C75
	lda.b $63
	beq CODE_C53CA7
	lda.w #$0034
CODE_C53CA7:						; from CODE_C53CA0
	clc
	adc.b $8B
	tay
	lda.w #$FFFF
	sta.w $1373,y
	lsr.b $8B
	ldy.w #$2DC9
	lda.b $63
	beq CODE_C53CBD
	ldy.w #$3207
CODE_C53CBD:						; from CODE_C53CA7
	sty.b $63
	stz.w $07D0
	stz.w $07CE
	stz.w $07AC
	stz.w $07B4
	lda.w $0A20,x
	bne CODE_C53CD3
	jmp.w CODE_C53D3C
CODE_C53CD3:						; from CODE_C53CBD
	lda.w $10F5
	bit.w #$2000
	beq CODE_C53CEF
	jsl.l chkpk2
	beq CODE_C53CE9
	lda.w $0436,y
	sta.w $07D0
	bra CODE_C53CEF
CODE_C53CE9:						; from CODE_C53CD3
	lda.w $0434,y
	sta.w $07CE
CODE_C53CEF:						; from CODE_C53CD3
	lda.w $043A,y
	sta.w $07B4
	lda.w $1020,x
	bne CODE_C53D00
	lda.w $0430,y
	sta.w $07B4
CODE_C53D00:						; from CODE_C53CEF
	lda.w $114B
	sec
	sbc.w #$0002
	bmi CODE_C53D3C
	bne CODE_C53D1A
	jsl.l CODE_C510F6
	lda.b $7F
	lsr a
	sec
	sbc.w $114D
	beq CODE_C53D1A
	bpl CODE_C53D3C
CODE_C53D1A:						; from CODE_C53D00
	lda.w $12AB
	sec
	sbc.w $12AD
	sta.b $9F
	beq CODE_C53D36
	lda.w $1020,x
	beq CODE_C53D32
	lda.w #$0000
	sec
	sbc.b $9F
	sta.b $9F
CODE_C53D32:						; from CODE_C53D1A
	lda.b $9F
	bpl CODE_C53D3C
CODE_C53D36:						; from CODE_C53D1A
	lda.w #$0002
	sta.w $07AC
CODE_C53D3C:						; from CODE_C53CBD, CODE_C53D00, CODE_C53D32
	lda.b $8B
	xba
	lsr a
	lsr a
	lsr a
	adc.b $63
	tay
	lda.w $0110,y
	and.w #$007F
	phx
	tax
	lda.l BCDTable,x
	and.w #$00FF
	plx
	sta.w $0EE0,x
	lda.w $0111,y
	and.w #$00F0
	lsr a
	sta.w $0DE0,x
	sty.b $63
	lda.w $0111,y
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	ldy.w #$0000
	jsr.w CODE_C53F66
	sta.w $0E00,x
	ldy.b $63
	lda.w $0112,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	ldy.w #$0001
	jsr.w CODE_C53F66
	sta.w $0E20,x
	ldy.b $63
	lda.w $0112,y
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	clc
	adc.w $07D0
	clc
	adc.w $07CE
	clc
	adc.w $07B4
	clc
	adc.w $07AC
	ldy.w #$0002
	jsr.w CODE_C53F66
	eor.w #$000F
	clc
	adc.w #$000F
	lsr a
	sta.w $0E40,x
	ldy.b $63
	lda.w $0113,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	clc
	adc.w $07B4
	ldy.w #$0003
	jsr.w CODE_C53F66
	pha
	lda.w $0A20,x
	beq CODE_C53DF6
	pla
	eor.w #$000F
	clc
	adc.w #$0007
	sta.w $0E60,x
	bra CODE_C53E02
CODE_C53DF6:						; from CODE_C53D3C
	pla
	eor.w #$000F
	clc
	adc.w #$000F
	lsr a
	sta.w $0E60,x
CODE_C53E02:						; from CODE_C53D3C
	ldy.b $63
	lda.w $0113,y
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	ldy.w #$0004
	jsr.w CODE_C53F66
	sta.w $0E80,x
	ldy.b $63
	lda.w $0114,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	clc
	adc.w $07AC
	ldy.w #$0005
	jsr.w CODE_C53F66
	sta.w $0FA0,x
	ldy.b $63
	lda.w $0114,y
	and.w #$0001
	eor.w #$0001
	sta.w $0FC0,x
	lda.w $08E0,x
	ora.w #$0800
	sta.w $08E0,x
	lda.w $0114,y
	and.w #$000E
	sta.w $0F80,x
	lda.w $0115,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	clc
	adc.w $07D0
	clc
	adc.w $07CE
	clc
	adc.w $07B4
	ldy.w #$0006
	jsr.w CODE_C53F66
	sta.w $0F20,x
	ldy.b $63
	lda.w $0115,y
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	clc
	adc.w $07D0
	clc
	adc.w $07CE
	clc
	adc.w $07B4
	ldy.w #$0007
	jsr.w CODE_C53F66
	sta.w $0EA0,x
	ldy.b $63
	lda.w $0116,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	ldy.w #$0008
	jsr.w CODE_C53F66
	sta.w $0F40,x
	ldy.b $63
	lda.w $0116,y
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	clc
	adc.w $07AC
	clc
	adc.w $07AC
	ldy.w #$0009
	jsr.w CODE_C53F66
	sta.w $0F00,x
	ldy.b $63
	lda.w $0117,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	clc
	adc.w $07D0
	clc
	adc.w $07B4
	ldy.w #$000A
	jsr.w CODE_C53F66
	sta.w $0EC0,x
	ldy.b $63
	lda.w $0117,y
	and.w #$0007
	sta.b $2C
	asl a
	asl a
	adc.b $2C
	lsr a
	ldy.w #$000B
	jsr.w CODE_C53F66
	sta.w $0F60,x
	txy
	lda.w $0DE0,x
	lsr a
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0020
	clc
	adc.w $0E00,x
	sta.b $40
	lda.w $0E00,x
	lsr a
	adc.b $40
	sta.b $40
	lda.w $0A20,x
	bne CODE_C53F49
	lda.w $0E00,x
	asl a
	adc.b $40
	adc.w #$0008
	sta.b $40
CODE_C53F49:						; from CODE_C53E02
	lda.b $40
	ldx.w #$0007
	jsl.l Mul8U
	asl a
	sta.w $0D80,y
	lda.b $40
	ldx.w #$0004
	jsl.l Mul8U
	asl a
	sta.w $0DA0,y
	ply
	plx
	rtl
CODE_C53F66:						; from CODE_C53D3C, CODE_C53E02
	sta.b $42
	tya
	clc
	adc.b $40
	tay
	sep #$20
	lda.w $1543,y
	lsr a
	lsr a
	bit.b #$00
	beq CODE_C53F7A
	ora.b #$00
CODE_C53F7A:						; from CODE_C53F66
	clc
	adc.b $42
	bpl CODE_C53F81
	lda.b #$00
CODE_C53F81:						; from CODE_C53F7A
	cmp.b #$0F
	bcc CODE_C53F87
	lda.b #$0F
CODE_C53F87:						; from CODE_C53F81
	rep #$20
	and.w #$00FF
	rts
CODE_C53F8D:						; called from other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	stz.b $6B
	jsl.l CODE_C53FE5
	lda.w #$0002
	sta.b $6B
	jsl.l CODE_C53FE5
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
	rtl

; Segment bankC5_D000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C5D00D
CODE_C5D00D:						; called from other segments
	stz.b $7F
	stz.b $81
	stz.b $83
	stz.b $30
	lda.w #$0000
CODE_C5D018:						; from CODE_C5D070
	sta.b $91
	tay
	lda.b ($87),y
	bit.w #$0001
	beq CODE_C5D070
	tya
	ldx.b $73
	stz.w $24DC
	cmp.w $0002,x
	bcc CODE_C5D03D
	sbc.w $0002,x
	cmp.w $0004,x
	bcc CODE_C5D039
	inc.b $83
	bra CODE_C5D045
CODE_C5D039:						; from CODE_C5D018
	inc.b $81
	bra CODE_C5D045
CODE_C5D03D:						; from CODE_C5D018
	inc.b $7F
	ldx.w #$0010
	stx.w $24DC
CODE_C5D045:						; from CODE_C5D018, CODE_C5D039
	tya
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $73
	tax
	lda.w $0110,x
	sta.w $04F5
	lda.w $0112,x
	sta.w $04F7
	lda.w $0114,x
	sta.w $04F9
	lda.w $0116,x
	sta.w $04FB
	jsr.w CODE_C5C6B7
	clc
	adc.b ($A1)
	sta.b ($A1)
	inc.b $30
CODE_C5D070:						; from CODE_C5D018
	lda.b $91
	inc a
	cmp.b $A3
	bne CODE_C5D018
	lda.b $30
	beq CODE_C5D08B
	lda.b ($A1)
	sta.b $34
	jsl.l Div16U
	lda.b $2C
	clc
	adc.b ($A1)
	lsr a
	sta.b ($A1)
CODE_C5D08B:						; from CODE_C5D070
	rts
CODE_C5D08C:						; called from other segments
	lda.b $7B
	sta.b $9F
	ldx.w #$2DC9
	ldy.w #$364E
	lda.w $17CB
	jsr.w CODE_C5D0A9
	lda.b $7D
	sta.b $9F
	ldx.w #$3207
	ldy.w #$36B2
	lda.w $17C9
CODE_C5D0A9:						; from CODE_C5D08C
	stx.b $A3
	sty.b $A1
	sta.b $A5
	asl a
	asl a
	asl a
	asl a
	sta.b $0A
	ldy.w #$0000
CODE_C5D0B8:						; from CODE_C5D0EF
	lda.b ($A1),y
	bit.w #$0001
	beq CODE_C5D0EF
	tya
	asl a
	adc.b $A3
	tax
	lda.w $003A,x
	sta.b $0C
	lsr a
	bcc CODE_C5D0DF
	clc
	adc.b $0C
	tax
	lda.l $306A56,x
	and.w #$FE0F
	ora.b $0A
	sta.l $306A56,x
	bra CODE_C5D0EF
CODE_C5D0DF:						; from CODE_C5D0B8
	adc.b $0C
	tax
	lda.l $306A56,x
	and.w #$FFE0
	ora.b $A5
	sta.l $306A56,x
CODE_C5D0EF:						; from CODE_C5D0B8
	iny
	cpy.b $9F
	bne CODE_C5D0B8
	rts
CODE_C5D0F5:						; called from other segments
	lda.w #$FFFF
	sta.w $4688
	sta.w $468A
	lda.w $1864
	cmp.w #$0001
	beq CODE_C5D132
	lda.w $1904
	beq CODE_C5D132
	jsr.w CODE_C5D1C5
	ldy.w #$0000
CODE_C5D111:						; from CODE_C5D111
	lda.w $17B5,y
	cmp.w #$0001
	beq CODE_C5D133
	iny
	iny
	cpy.w #$000A
	bne CODE_C5D111
CODE_C5D120:						; from CODE_C5D133
	ldy.w #$0000
CODE_C5D123:						; from CODE_C5D123
	lda.w $17B5,y
	cmp.w #$0002
	beq CODE_C5D145
	iny
	iny
	cpy.w #$000A
	bne CODE_C5D123
CODE_C5D132:						; from CODE_C5D0F5
	rts
CODE_C5D133:						; from CODE_C5D111
	lda.w $17C9
	sta.b $6B
	sty.w $0591
	jsr.w CODE_C5D156
	lda.b $65
	sta.w $4688
	bra CODE_C5D120
CODE_C5D145:						; from CODE_C5D123
	lda.w $17CB
	sta.b $6B
	sty.w $0591
	jsr.w CODE_C5D156
	lda.b $65
	sta.w $468A
	rts
CODE_C5D156:						; from CODE_C5D133, CODE_C5D145
	jsl.l FadeOutWait
	jsr.w CODE_C5D1EF
	stz.w fadestep
CODE_C5D160:						; from CODE_C5D160, CODE_C5D1B1, CODE_C5D1BF
	inc.w TransfersReady
	wai
	jsl.l $C37065
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C5D160
	lda.w $058D
	bit.w #$8000
	beq CODE_C5D192
	jsr.w CODE_C5D36F
	bra CODE_C5D160
CODE_C5D192:						; from CODE_C5D160
	bit.w #$0400
	beq CODE_C5D1A4
	lda.b $65
	inc a
	cmp.w #$0008
	bcc CODE_C5D1B1
	lda.w #$0000
	bra CODE_C5D1B1
CODE_C5D1A4:						; from CODE_C5D192
	bit.w #$0800
	beq CODE_C5D1BF
	lda.b $65
	dec a
	bpl CODE_C5D1B1
	lda.w #$0007
CODE_C5D1B1:						; from CODE_C5D192, CODE_C5D1A4
	sta.b $65
	asl a
	asl a
	asl a
	adc.w #$0036
	ldx.b $63
	sta.b $08,x
	bra CODE_C5D160
CODE_C5D1BF:						; from CODE_C5D1A4
	bit.w #$1000
	beq CODE_C5D160
	rts
CODE_C5D1C5:						; from CODE_C5D0F5
	jsl.l FadeOutWait
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$0008
CODE_C5D1D2:						; from CODE_C5D1D2
	phy
	ldx.b $73,y
	jsl.l CODE_C5E596
	ply
	dey
	dey
	bpl CODE_C5D1D2
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $63
	lda.w #$0003
	jsl.l CODE_C5ECBD
	rts
CODE_C5D1EF:						; from CODE_C5D156
	stz.b $65
	ldx.b $63
	lda.w #$0010
	sta.b $05,x
	lda.w #$0036
	sta.b $08,x
	lda.b $D3
	ldy.w #$0700
	jsl.l CODE_C58B11
	ldy.w #$5000
	jsl.l CODE_C589B0
	ldy.w #$2801
	lda.b $6B
	cmp.w $17C9
	beq CODE_C5D21A
	ldy.w #$2C01
CODE_C5D21A:						; from CODE_C5D1EF
	ldx.w #$5115
	jsl.l $C387D8
	ldx.b $9B
	ldy.b $9D
	lda.b $6B
	cmp.w $17C9
	beq CODE_C5D22F
	txy
	ldx.b $9D
CODE_C5D22F:						; from CODE_C5D21A
	lda.w #$00D0
	sta.b $05,x
	lda.w #$0028
	sta.b $08,x
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	lda.w $0022,y
	and.w #$FFFE
	sta.w $0022,y
	lda.w #$542B
	jsl.l $C4BB5A
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $6B
	asl a
	tax
	lda.l $C3585C,x
	tax
	ldy.w #$0009
	jsl.l $C4BCAA
	lda.w #$0000
CODE_C5D26D:						; from CODE_C5D2A8
	pha
	inc a
	jsr.w $5EC7
	lda.w #$003D
	sta.w $04F5,x
	lda.w #$0014
	sta.b $CF
	lda.b $01,s
	clc
	adc.w #$0006
	tay
	ldx.w #$04F5
	jsl.l $C4BC08
	lda.b $01,s
	jsr.w CODE_C5D2B4
	cpx.w #$0000
	beq CODE_C5D2A8
	lda.w #$0020
	sta.b $CF
	lda.b $01,s
	clc
	adc.w #$0006
	tay
	ldx.w #$04F5
	jsl.l $C4BC08
CODE_C5D2A8:						; from CODE_C5D26D
	pla
	inc a
	cmp.w #$0008
	bne CODE_C5D26D
	jsl.l $C4C2AA
	rts
CODE_C5D2B4:						; from CODE_C5D26D, CODE_C5D431
	asl a
	asl a
	sta.b $9F
	asl a
	asl a
	asl a
	asl a
	sec
	sbc.b $9F
	tay
	ldx.w #$0000
CODE_C5D2C3:						; from CODE_C5D2D8
	jsr.w CODE_C5D2E2
	cmp.w #$001B
	bne CODE_C5D2D0
	lda.w #$0020
	bra CODE_C5D2D8
CODE_C5D2D0:						; from CODE_C5D2C3
	cmp.w #$001F
	beq CODE_C5D2E1
	adc.w #$0040
CODE_C5D2D8:						; from CODE_C5D2C3
	sta.w $04F5,x
	inx
	cpx.w #$000C
	bne CODE_C5D2C3
CODE_C5D2E1:						; from CODE_C5D2D0
	rts
CODE_C5D2E2:						; from CODE_C5D2C3
	phx
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	sta.b $9F
	tya
	clc
	adc.w #$0005
	tay
	lda.l $3070D6,x
CODE_C5D2F8:						; from CODE_C5D2F8
	lsr a
	dec.b $9F
	bpl CODE_C5D2F8
	rol a
	and.w #$001F
	plx
	rts
CODE_C5D303:						; from CODE_C5D43D
	asl a
	asl a
	sta.b $9F
	asl a
	asl a
	asl a
	asl a
	sec
	sbc.b $9F
	tay
	ldx.w #$0000
CODE_C5D312:						; from CODE_C5D330
	lda.w $04F5,x
	and.w #$00FF
	cmp.w #$0020
	bne CODE_C5D322
	lda.w #$001B
	bra CODE_C5D330
CODE_C5D322:						; from CODE_C5D312
	cmp.w #$003E
	beq CODE_C5D32D
	sec
	sbc.w #$0040
	bra CODE_C5D330
CODE_C5D32D:						; from CODE_C5D322
	lda.w #$001F
CODE_C5D330:						; from CODE_C5D312, CODE_C5D322
	jsr.w CODE_C5D33A
	inx
	cpx.w #$000C
	bne CODE_C5D312
	rts
CODE_C5D33A:						; from CODE_C5D330
	phx
	and.w #$001F
	sta.b $9F
	lda.w #$001F
	sta.b $A1
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
CODE_C5D34E:						; from CODE_C5D34E
	asl.b $A1
	asl.b $9F
	dec a
	bpl CODE_C5D34E
	ror.b $9F
	lda.b $A1
	lsr a
	eor.w #$FFFF
	and.l $3070D6,x
	ora.b $9F
	sta.l $3070D6,x
	tya
	clc
	adc.w #$0005
	tay
	plx
	rts
CODE_C5D36F:						; from CODE_C5D160
	jsr.w CODE_C5D4D5
CODE_C5D372:						; from CODE_C5D372, CODE_C5D42E
	inc.w TransfersReady
	wai
	jsl.l $C37065
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C5D372
	lda.w $058D
	bit.w #$0200
	beq CODE_C5D3AB
	jsr.w CODE_C5D56C
	dec.b $67
	bpl CODE_C5D3EC
	lda.w #$001A
	bra CODE_C5D3EA
CODE_C5D3AB:						; from CODE_C5D372
	bit.w #$0100
	beq CODE_C5D3BF
	jsr.w CODE_C5D56C
	lda.b $67
	inc a
	cmp.w #$001B
	bcc CODE_C5D3EA
	stz.b $67
	bra CODE_C5D3EC
CODE_C5D3BF:						; from CODE_C5D3AB
	bit.w #$0800
	beq CODE_C5D3D4
	jsr.w CODE_C5D56C
	lda.b $67
	sec
	sbc.w #$0009
	bpl CODE_C5D3EA
	adc.w #$001B
	bra CODE_C5D3EA
CODE_C5D3D4:						; from CODE_C5D3BF
	bit.w #$0400
	beq CODE_C5D3F1
	jsr.w CODE_C5D56C
	lda.b $67
	clc
	adc.w #$0009
	cmp.w #$001B
	bcc CODE_C5D3EA
	sbc.w #$001B
CODE_C5D3EA:						; from CODE_C5D372, CODE_C5D3AB, CODE_C5D3BF, CODE_C5D3D4
	sta.b $67
CODE_C5D3EC:						; from CODE_C5D372, CODE_C5D3AB
	jsr.w CODE_C5D54B
	bra CODE_C5D42E
CODE_C5D3F1:						; from CODE_C5D3D4
	bit.w #$8080
	beq CODE_C5D415
	ldx.b $67
	lda.l DATA8_C598FA,x
	ldy.b $69
	sep #$20
	cmp.b #$3D
	bne CODE_C5D406
	lda.b #$20
CODE_C5D406:						; from CODE_C5D3F1
	sta.w $04F5,y
	rep #$20
	iny
	cpy.w #$000C
	bcs CODE_C5D427
	sty.b $69
	bra CODE_C5D427
CODE_C5D415:						; from CODE_C5D3F1
	bit.w #$4000
	beq CODE_C5D431
	ldx.b $69
	beq CODE_C5D41F
	dex
CODE_C5D41F:						; from CODE_C5D415
	lda.w #$3E3E
	sta.w $04F5,x
	stx.b $69
CODE_C5D427:						; from CODE_C5D406
	jsr.w CODE_C5D5A5
	jsl.l $C4C2AA
CODE_C5D42E:						; from CODE_C5D3EC, CODE_C5D43D
	jmp.w CODE_C5D372
CODE_C5D431:						; from CODE_C5D415
	bit.w #$0040
	beq CODE_C5D43D
	lda.b $65
	jsr.w CODE_C5D2B4
	bra CODE_C5D447
CODE_C5D43D:						; from CODE_C5D431
	bit.w #$1000
	beq CODE_C5D42E
	lda.b $65
	jsr.w CODE_C5D303
CODE_C5D447:						; from CODE_C5D431
	ldx.w #$FFFF
	sep #$20
CODE_C5D44C:						; from CODE_C5D44C
	inx
	lda.w $04F5,x
	cmp.b #$3E
	bne CODE_C5D44C
	stz.w $04F5,x
	rep #$20
	lda.b $65
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$0188
	ldy.w #$0020
	jsl.l CODE_C58B11
	lda.w $04F5
	and.w #$00FF
	beq CODE_C5D485
	lda.b $65
	clc
	adc.w #$0006
	tay
	lda.w #$0020
	sta.b $CF
	ldx.w #$04F5
	jsl.l $C4BC08
CODE_C5D485:						; from CODE_C5D44C
	lda.b $D3
	clc
	adc.w #$0380
	ldy.w #$0380
	jsl.l CODE_C58B11
	lda.w #$0010
	sta.b $CF
	ldx.w #$4F40
	ldy.w #$0019
	jsl.l $C4BBFC
	ldx.w #$4F4A
	ldy.w #$001A
	jsl.l $C4BBFC
	jsl.l $C4C2AA
	ldx.b $63
	lda.w #$0003
	jsl.l CODE_C5ECBD
	lda.w #$0010
	sta.b $05,x
	lda.b $65
	asl a
	asl a
	asl a
	adc.w #$0036
	sta.b $08,x
	lda.w $058D
	bit.w #$0040
	bne CODE_C5D4D4
	lda.b $65
	jsr.w CODE_C5D77F
CODE_C5D4D4:						; from CODE_C5D485
	rts
CODE_C5D4D5:						; from CODE_C5D36F
	lda.b $D3
	clc
	adc.w #$0380
	ldy.w #$0380
	jsl.l CODE_C58B11
	lda.w #$0018
	sta.b $CF
	lda.w #$2C00
	sta.b $D5
	lda.w #$001A
	ldy.w #$000F
	ldx.w #$490D
	jsl.l $C4BC2C
	lda.w #$001A
	ldy.w #$0012
	ldx.w #$4914
	jsl.l $C4BC2C
	lda.w #$001A
	ldy.w #$0015
	ldx.w #$4922
	jsl.l $C4BC2C
	lda.w #$2000
	sta.b $D5
	lda.w #$543D
	jsl.l $C4BB5A
	ldx.w #$0000
	stx.b $69
	cpx.w #$000C
	bne CODE_C5D52B
	dec.b $69
CODE_C5D52B:						; from CODE_C5D4D5
	lda.w #$003E
CODE_C5D52E:						; from CODE_C5D52E
	cpx.w #$000C
	beq CODE_C5D539
	sta.w $04F5,x
	inx
	bra CODE_C5D52E
CODE_C5D539:						; from CODE_C5D52E
	jsr.w CODE_C5D5A5
	ldx.b $63
	lda.w #$0000
	jsl.l CODE_C5ECBD
	stz.b $67
	jsr.w CODE_C5D54B
	rts
CODE_C5D54B:						; from CODE_C5D3EC, CODE_C5D539
	jsr.w CODE_C5D567
	ldy.b $63
	lda.b $67
	asl a
	tax
	lda.l DATA8_C5A225,x
	sta.w $0005,y
	lda.l DATA8_C5A25B,x
	clc
	adc.w #$0018
	sta.w $0008,y
	rts
CODE_C5D567:						; from CODE_C5D54B
	lda.w #$0000
	bra CODE_C5D56F
CODE_C5D56C:						; from CODE_C5D372, CODE_C5D3AB, CODE_C5D3BF, CODE_C5D3D4
	lda.w #$0C00
CODE_C5D56F:						; from CODE_C5D567
	sta.b $9F
	lda.b $67
	asl a
	tax
	lda.b $D3
	adc.l DATA8_C5A1D7,x
	adc.w #$00C0
	tay
	jsr.w CODE_C5D599
	iny
	iny
	jsr.w CODE_C5D599
	tya
	adc.w #$003E
	tay
	jsr.w CODE_C5D599
	iny
	iny
	jsr.w CODE_C5D599
	jsl.l $C4C2AA
	rts
CODE_C5D599:						; from CODE_C5D56F
	lda.w $0000,y
	and.w #$E3FF
	ora.b $9F
	sta.w $0000,y
	rts
CODE_C5D5A5:						; from CODE_C5D539, CODE_C5D427
	lda.b $65
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$0188
	ldy.w #$0020
	jsl.l CODE_C58B11
	lda.w #$0020
	sta.b $CF
	lda.b $65
	clc
	adc.w #$0006
	tay
	ldx.w #$04F5
	lda.w #$000A
	jsl.l $C4BC68
	rts
CODE_C5D5CD:						; called from other segments
	lda.w $1864
	cmp.w #$0001
	beq CODE_C5D5FC
	lda.w $1904
	beq CODE_C5D5FC
	lda.w $17C9
	sta.w $12AF
	lda.w $17CB
	sta.w $12B1
	lda.w $4688
	bmi CODE_C5D5F1
	ldx.w #$0000
	jsr.w CODE_C5D5FD
CODE_C5D5F1:						; from CODE_C5D5CD
	lda.w $468A
	bmi CODE_C5D5FC
	ldx.w #$0002
	jsr.w CODE_C5D5FD
CODE_C5D5FC:						; from CODE_C5D5CD, CODE_C5D5F1
	rtl
CODE_C5D5FD:						; from CODE_C5D5CD, CODE_C5D5F1
	pha
	jsr.w CODE_C5D6F5
	txa
	eor.w #$0002
	tay
	lda.w $12AB,x
	cmp.w $12AB,y
	beq CODE_C5D614
	bcs CODE_C5D618
	inc.b $8F
	bra CODE_C5D648
CODE_C5D614:						; from CODE_C5D5FD
	inc.b $8D
	bra CODE_C5D648
CODE_C5D618:						; from CODE_C5D5FD
	inc.b $8B
	lda.w $1297,y
	sec
	sbc.w $12AB,y
	cmp.b $85
	bcc CODE_C5D633
	beq CODE_C5D633
	sta.b $85
	lda.w $12AF,x
	sta.b $87
	lda.w $12AF,y
	sta.b $89
CODE_C5D633:						; from CODE_C5D618
	lda.w $12AB,x
	cmp.b $7F
	bcc CODE_C5D648
	beq CODE_C5D648
	sta.b $7F
	lda.w $12AF,x
	sta.b $81
	lda.w $12AF,y
	sta.b $83
CODE_C5D648:						; from CODE_C5D5FD, CODE_C5D614, CODE_C5D633
	pla
CODE_C5D649:						; from CODE_C5D77F
	sta.b $6F
	asl a
	adc.b $6F
	sta.b $71
	asl a
	sec
	sbc.b $6F
	tax
	lsr a
	lsr a
	lsr a
	sta.b $73
	txa
	and.w #$0007
	sta.b $75
	lda.w #$0030
	sta.b $79
	ldx.w #$7112
	lda.b $7F
	jsr.w CODE_C5D6AA
	ldx.w #$711E
	lda.b $81
	jsr.w CODE_C5D6D0
	ldx.w #$7123
	lda.b $83
	jsr.w CODE_C5D6D0
	ldx.w #$7128
	lda.b $85
	jsr.w CODE_C5D6AA
	ldx.w #$7134
	lda.b $87
	jsr.w CODE_C5D6D0
	ldx.w #$7139
	lda.b $89
	jsr.w CODE_C5D6D0
	ldx.w #$713E
	lda.b $8B
	jsr.w CODE_C5D6AA
	ldx.w #$714A
	lda.b $8F
	jsr.w CODE_C5D6AA
	ldx.w #$7156
	lda.b $8D
CODE_C5D6AA:						; from CODE_C5D649
	stx.b $77
	tax
	lda.b $71
	lsr a
	tay
	bcc CODE_C5D6C4
	txa
	asl a
	asl a
	asl a
	asl a
	sta.b $7D
	lda.b [$77],y
	and.w #$000F
	ora.b $7D
	sta.b [$77],y
	rts
CODE_C5D6C4:						; from CODE_C5D6AA
	stx.b $7D
	lda.b [$77],y
	and.w #$F000
	ora.b $7D
	sta.b [$77],y
	rts
CODE_C5D6D0:						; from CODE_C5D649
	stx.b $77
	ldx.w #$001F
	stx.b $7B
	ldy.b $73
	ldx.b $75
CODE_C5D6DB:						; from CODE_C5D6DB
	asl.b $7B
	asl a
	dex
	bpl CODE_C5D6DB
	lsr a
	sta.b $7D
	lda.b $7B
	lsr a
	eor.w #$FFFF
	sta.b $7B
	lda.b [$77],y
	and.b $7B
	ora.b $7D
	sta.b [$77],y
	rts
CODE_C5D6F5:						; from CODE_C5D5FD
	phx
	sta.b $63
	asl a
	adc.b $63
	sta.b $65
	asl a
	sec
	sbc.b $63
	tax
	lsr a
	lsr a
	lsr a
	sta.b $67
	txa
	and.w #$0007
	sta.b $69
	lda.w #$0030
	sta.b $6D
	ldx.w #$7112
	jsr.w CODE_C5D75C
	sta.b $7F
	ldx.w #$711E
	jsr.w CODE_C5D76E
	sta.b $81
	ldx.w #$7123
	jsr.w CODE_C5D76E
	sta.b $83
	ldx.w #$7128
	jsr.w CODE_C5D75C
	sta.b $85
	ldx.w #$7134
	jsr.w CODE_C5D76E
	sta.b $87
	ldx.w #$7139
	jsr.w CODE_C5D76E
	sta.b $89
	ldx.w #$713E
	jsr.w CODE_C5D75C
	sta.b $8B
	ldx.w #$714A
	jsr.w CODE_C5D75C
	sta.b $8F
	ldx.w #$7156
	jsr.w CODE_C5D75C
	sta.b $8D
	plx
	rts
CODE_C5D75C:						; from CODE_C5D6F5
	stx.b $6B
	lda.b $65
	lsr a
	tay
	lda.b [$6B],y
	bcc CODE_C5D76A
	lsr a
	lsr a
	lsr a
	lsr a
CODE_C5D76A:						; from CODE_C5D75C
	and.w #$0FFF
	rts
CODE_C5D76E:						; from CODE_C5D6F5
	stx.b $6B
	ldy.b $67
	ldx.b $69
	lda.b [$6B],y
CODE_C5D776:						; from CODE_C5D776
	lsr a
	dex
	bpl CODE_C5D776
	rol a
	and.w #$001F
	rts
CODE_C5D77F:						; from CODE_C5D485
	stz.b $7F
	stz.b $81
	stz.b $83
	stz.b $85
	stz.b $87
	stz.b $89
	stz.b $8B
	stz.b $8F
	stz.b $8D
	jmp.w CODE_C5D649
CODE_C5D794:						; called from other segments
	ldx.w #$0000
	txy
CODE_C5D798:						; from CODE_C5D7C2
	lda.l $306A56,x
	and.w #$001F
	cmp.w #$001A
	bne CODE_C5D7A8
	dec.b $65
	bmi CODE_C5D7CB
CODE_C5D7A8:						; from CODE_C5D798
	iny
	cpy.w #$027E
	bcs CODE_C5D7CB
	lda.l $306A57,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$001F
	cmp.w #$001A
	bne CODE_C5D7C2
	dec.b $65
	bmi CODE_C5D7CB
CODE_C5D7C2:						; from CODE_C5D7A8
	inx
	inx
	inx
	iny
	cpy.w #$027E
	bcc CODE_C5D798
CODE_C5D7CB:						; from CODE_C5D798, CODE_C5D7A8
	tya
	rts
CODE_C5D7CD:						; called from other segments
	sec
	sbc.w #$026A
	tay
	pha
	asl a
	adc.b $01,s
	sta.b $01,s
	tya
	asl a
	asl a
	adc.b $01,s
	asl a
	asl a
	sta.b $01,s
	tya
	xba
	lsr a
	adc.b $01,s
	ply
	tay
	rts
CODE_C5D7E9:						; called from other segments
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	pha
	iny
	iny
	iny
	lda.l $307162,x
	plx
CODE_C5D7FB:						; from CODE_C5D7FB
	lsr a
	dex
	bpl CODE_C5D7FB
	rol a
	and.w #$0007
	rts
CODE_C5D804:						; called from other segments
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	pha
	iny
	iny
	iny
	iny
	iny
	lda.l $307162,x
	plx
CODE_C5D818:						; from CODE_C5D818
	lsr a
	dex
	bpl CODE_C5D818
	rol a
	and.w #$001F
	rts
CODE_C5D821:						; called from other segments
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	pha
	tya
	clc
	adc.w #$0007
	tay
	lda.l $307162,x
	plx
CODE_C5D836:						; from CODE_C5D836
	lsr a
	dex
	bpl CODE_C5D836
	rol a
	and.w #$007F
	rts
CODE_C5D83F:						; called from other segments
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	pha
	tya
	clc
	adc.w #$0008
	tay
	lda.l $307162,x
	plx
CODE_C5D854:						; from CODE_C5D854
	lsr a
	dex
	bpl CODE_C5D854
	rol a
	and.w #$00FF
	rts
CODE_C5D85D:						; called from other segments
	ldx.b $D3
	stz.w $019C,x
	stz.w $019E,x
	stz.w $01A0,x
	stz.w $01DC,x
	stz.w $01DE,x
	stz.w $01E0,x
	stz.w $021C,x
	stz.w $021E,x
	stz.w $0220,x
	stz.w $025C,x
	stz.w $025E,x
	stz.w $0260,x
	lda.w #$0070
	sta.b $CF
	ldx.b $7F
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w $5EC7
	ldx.w #$04F5
	ldy.w #$0006
	jsl.l $C4BC08
	ldx.b $83
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w $5EC7
	ldx.w #$04F5
	ldy.w #$0007
	jsl.l $C4BC08
	ldx.b $81
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w $5EC7
	ldx.w #$04F5
	ldy.w #$0008
	jsl.l $C4BC08
	lda.b $7F
	clc
	adc.b $83
	adc.b $81
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w $5EC7
	ldx.w #$04F5
	ldy.w #$0009
	jsl.l $C4BC08
	rts
CODE_C5D8E7:						; called from other segments
	sta.b $8F
	stz.b $77
	stz.b $79
	stz.b $6B
	jsl.l $C4CEDB
	ldx.w #$0060
	jsl.l SetupHDMA
	db $00,$2C,$4E,$3E,$7E,$00		; inline parameters
	ldx.w #$0013
	ldy.w #$0017
	lda.b $6F
	dec a
	asl a
	asl a
	asl a
	sta.w $3E4E
	sty.w $3E4F
	lda.w #$0008
	sta.w $3E50
	stx.w $3E51
	lda.b $67
	asl a
	asl a
	asl a
	sta.w $3E52
	sty.w $3E53
	lda.w #$0008
	sta.w $3E54
	stx.w $3E55
	lda.b $71
	clc
	sbc.b $6F
	sbc.b $67
	dec a
	asl a
	asl a
	asl a
	sta.w $3E56
	sty.w $3E57
	lda.w #$0008
	sta.w $3E58
	stx.w $3E59
	lda.b $69
	asl a
	asl a
	asl a
	sta.w $3E5A
	sty.w $3E5B
	lda.w #$0008
	sta.w $3E5C
	stx.w $3E5D
	lda.w #$0001
	sta.w $3E5E
	sty.w $3E5F
	stz.w $3E60
	ldy.w #$FFFF
	lda.b $6F
	dec a
	asl a
	asl a
	asl a
	sta.w $3F4E
	sty.w $3F4F
	lda.b $67
	inc a
	inc a
	asl a
	asl a
	asl a
	sta.w $3F51
	sty.w $3F52
	lda.b $71
	clc
	sbc.b $6F
	sbc.b $67
	dec a
	asl a
	asl a
	asl a
	sta.w $3F54
	sty.w $3F55
	lda.b $69
	inc a
	inc a
	asl a
	asl a
	asl a
	sta.w $3F57
	sty.w $3F58
	lda.w #$0001
	sta.w $3F5A
	sty.w $3F5B
	stz.w $3F5D
	ldx.w #$0050
	jsl.l SetupHDMA
	db $02,$12,$4E,$3F,$7E,$7E		; inline parameters
	lda.w #$E000
	sta.w DMAEnShadow
	lda.w #$0010
	sta.b $18
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $8B
	lda.w #$0001
	jsl.l CODE_C5ECBD
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $8D
	lda.w #$0002
	jsl.l CODE_C5ECBD
	lda.b $77
	sta.b $91
	lda.b $73
	sta.b $87
	ldy.b $6F
	ldx.b $7B
	lda.b $67
	jsr.w CODE_C5DAAF
	lda.b $79
	sta.b $91
	lda.b $75
	sta.b $87
	ldy.b $71
	ldx.b $7D
	lda.b $69
	jsr.w CODE_C5DAAF
CODE_C5DA09:						; called from other segments
	ldy.b $6B
	ldx.b $8B
	lda.w $006F,y
	asl a
	asl a
	asl a
	sec
	sbc.w #$0004
	sta.b $08,x
	lda.w $0077,y
	beq CODE_C5DA25
	lda.b $22,x
	ora.w #$0001
	bra CODE_C5DA2A
CODE_C5DA25:						; from CODE_C5DA09
	lda.b $22,x
	and.w #$FFFE
CODE_C5DA2A:						; from CODE_C5DA09
	sta.b $22,x
	ldx.b $8D
	lda.w $006F,y
	clc
	adc.w $0067,y
	asl a
	asl a
	asl a
	adc.w #$0004
	sta.b $08,x
	lda.w $0077,y
	clc
	adc.w $0067,y
	cmp.w $007B,y
	bcs CODE_C5DA50
	lda.b $22,x
	ora.w #$0001
	bra CODE_C5DA55
CODE_C5DA50:						; from CODE_C5DA2A
	lda.b $22,x
	and.w #$FFFE
CODE_C5DA55:						; from CODE_C5DA2A
	sta.b $22,x
	rts
CODE_C5DA58:						; called from other segments
	lda.b $77
	sta.b $91
	lda.b $73
	sta.b $87
	ldy.b $6F
	ldx.b $7B
	lda.b $67
	jsr.w CODE_C5DAAF
	lda.b $79
	sta.b $91
	lda.b $75
	sta.b $87
	ldy.b $71
	ldx.b $7D
	lda.b $69
	jsr.w CODE_C5DAAF
	ldy.w #$0003
	lda.w #$0000
	jsr.w CODE_C5DC54
	lda.b $71
	clc
	sbc.b $6F
	sbc.b $67
	dec a
	asl a
	asl a
	asl a
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	lda.w #$0002
	jsr.w CODE_C5DC54
	lda.w #$0001
	sta.w $3F4E,y
	dec a
	sta.w $3F51,y
	dec a
	sta.w $3F4F,y
	rts
CODE_C5DAAF:						; from CODE_C5D8E7, CODE_C5DA58
	phy
	phx
	tay
	inc a
	sta.b $A1
	inc a
	sta.b $A3
	tya
	sec
	adc.b $91
	pha
	lda.b $91
	beq CODE_C5DAC2
	dec a
CODE_C5DAC2:						; from CODE_C5DAAF, CODE_C5DAE2
	cmp.b $01,s
	bcs CODE_C5DAEF
	cmp.b $03,s
	bcs CODE_C5DAEF
	sta.b $91
CODE_C5DACC:						; from CODE_C5DACC
	cmp.b $A1
	bcc CODE_C5DAD4
	sbc.b $A3
	bpl CODE_C5DACC
CODE_C5DAD4:						; from CODE_C5DACC
	clc
	adc.b $05,s
	sta.b $6D
	jsr.w $5D73
	pea.w CODE_C5DAE2-1
	jmp ($008F)
CODE_C5DAE2:						; from CODE_C5DAD4
	jsl.l $C4CEDB
	jsl.l $C4C536
	lda.b $91
	inc a
	bra CODE_C5DAC2
CODE_C5DAEF:						; from CODE_C5DAC2
	pla
	pla
	pla
	rts
CODE_C5DAF3:						; called from other segments
	ldx.b $6B
	lda.b $73,x
	sta.b $87
	lda.b $67,x
	inc a
	sta.b $A1
	inc a
	sta.b $A3
	lda.b $71
	clc
	sbc.b $6F
	sbc.b $67
	dec a
	asl a
	asl a
	asl a
	pha
	lda.b $77,x
	beq CODE_C5DB36
	phx
	dec a
	sta.b $77,x
	dec a
	bmi CODE_C5DB38
	sta.b $91
CODE_C5DB1A:						; from CODE_C5DB1A
	cmp.b $A1
	bcc CODE_C5DB22
	sbc.b $A3
	bpl CODE_C5DB1A
CODE_C5DB22:						; from CODE_C5DB1A
	clc
	adc.b $6F,x
	sta.b $6D
	jsr.w $5D73
	pea.w CODE_C5DB30-1
	jmp ($008F)
CODE_C5DB30:						; from CODE_C5DB22
	jsl.l $C4C2AA
	bra CODE_C5DB38
CODE_C5DB36:						; from CODE_C5DAF3
	pla
	rts
CODE_C5DB38:						; from CODE_C5DAF3, CODE_C5DB30
	lda.w #$0007
CODE_C5DB3B:						; from CODE_C5DB92
	pha
	ldy.w #$0003
	wai
	lda.b $03,s
	bne CODE_C5DB6D
	jsr.w CODE_C5DCEE
	lda.b $05,s
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	lda.b $03,s
	eor.w #$0002
	jsr.w CODE_C5DC54
	lda.w #$0001
	sta.w $3F4E,y
	dec a
	sta.w $3F51,y
	dec a
	sta.w $3F4F,y
	bra CODE_C5DB92
CODE_C5DB6D:						; from CODE_C5DB3B
	eor.w #$0002
	jsr.w CODE_C5DC54
	lda.b $05,s
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	jsr.w CODE_C5DCEE
	lda.w #$0001
	sta.w $3F4E,y
	dec a
	sta.w $3F51,y
	dec a
	sta.w $3F4F,y
CODE_C5DB92:						; from CODE_C5DB3B
	pla
	dec a
	bpl CODE_C5DB3B
	pla
	pla
	stz.w $0565
	stz.w $058F
	rts
CODE_C5DB9F:						; called from other segments
	ldx.b $6B
	lda.b $73,x
	sta.b $87
	lda.b $67,x
	inc a
	sta.b $A1
	inc a
	sta.b $A3
	lda.b $71
	clc
	sbc.b $6F
	sbc.b $67
	dec a
	asl a
	asl a
	asl a
	pha
	lda.b $77,x
	clc
	adc.b $67,x
	cmp.b $7B,x
	bcs CODE_C5DBE6
	phx
	inc a
	cmp.b $7B,x
	bcs CODE_C5DBE8
	sta.b $91
CODE_C5DBCA:						; from CODE_C5DBCA
	cmp.b $A1
	bcc CODE_C5DBD2
	sbc.b $A3
	bpl CODE_C5DBCA
CODE_C5DBD2:						; from CODE_C5DBCA
	clc
	adc.b $6F,x
	sta.b $6D
	jsr.w $5D73
	pea.w CODE_C5DBE0-1
	jmp ($008F)
CODE_C5DBE0:						; from CODE_C5DBD2
	jsl.l $C4C2AA
	bra CODE_C5DBE8
CODE_C5DBE6:						; from CODE_C5DB9F
	pla
	rts
CODE_C5DBE8:						; from CODE_C5DB9F, CODE_C5DBE0
	lda.b $01,s
	tax
	inc.b $77,x
	lda.w #$0007
CODE_C5DBF0:						; from CODE_C5DC47
	pha
	ldy.w #$0003
	wai
	lda.b $03,s
	bne CODE_C5DC22
	jsr.w CODE_C5DCA7
	lda.b $05,s
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	lda.b $03,s
	eor.w #$0002
	jsr.w CODE_C5DC54
	lda.w #$0001
	sta.w $3F4E,y
	dec a
	sta.w $3F51,y
	dec a
	sta.w $3F4F,y
	bra CODE_C5DC47
CODE_C5DC22:						; from CODE_C5DBF0
	eor.w #$0002
	jsr.w CODE_C5DC54
	lda.b $05,s
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	jsr.w CODE_C5DCA7
	lda.w #$0001
	sta.w $3F4E,y
	dec a
	sta.w $3F51,y
	dec a
	sta.w $3F4F,y
CODE_C5DC47:						; from CODE_C5DBF0
	pla
	dec a
	bpl CODE_C5DBF0
	pla
	pla
	stz.w $0565
	stz.w $058F
	rts
CODE_C5DC54:						; from CODE_C5DA58, CODE_C5DB3B, CODE_C5DBF0, CODE_C5DB6D, ...
	tax
	lda.b $67,x
	inc a
	inc a
	sta.b $A5
	lda.b $77,x
CODE_C5DC5D:						; from CODE_C5DC5D
	cmp.b $A5
	bcc CODE_C5DC65
	sbc.b $A5
	bpl CODE_C5DC5D
CODE_C5DC65:						; from CODE_C5DC5D
	cmp.w #$0000
	bne CODE_C5DC7C
	lda.b $A5
	asl a
	asl a
	asl a
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	rts
CODE_C5DC7C:						; from CODE_C5DC65
	asl a
	asl a
	asl a
	sta.w $3F51,y
	tax
	lda.b $A5
	asl a
	asl a
	asl a
	sec
	sbc.w $3F51,y
	sta.w $3F4E,y
	txa
	dec a
	sta.w $3F4F,y
	lda.w $3F4E,y
	and.w #$00FF
	eor.w #$FFFF
	sta.w $3F52,y
	tya
	clc
	adc.w #$0006
	tay
	rts
CODE_C5DCA7:						; from CODE_C5DBF0, CODE_C5DC22
	lda.w $3F4F,y
	inc a
	sta.w $3F4F,y
	sep #$20
	lda.w $3F4E,y
	dec a
	sta.w $3F4E,y
	bne CODE_C5DCCD
	lda.b $A3
	asl a
	asl a
	asl a
	sta.w $3F4E,y
	rep #$20
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	rts
CODE_C5DCCD:						; from CODE_C5DCA7
	lda.b $A3
	asl a
	asl a
	asl a
	sec
	sbc.w $3F4E,y
	sta.w $3F51,y
	rep #$20
	lda.w $3F4E,y
	and.w #$00FF
	eor.w #$FFFF
	sta.w $3F52,y
	tya
	clc
	adc.w #$0006
	tay
	rts
CODE_C5DCEE:						; from CODE_C5DB3B, CODE_C5DB6D
	sep #$20
	lda.b $A3
	asl a
	asl a
	asl a
	cmp.w $3F4E,y
	bne CODE_C5DD1D
	dec a
	sta.w $3F51,y
	lda.b #$01
	sta.w $3F4E,y
	rep #$20
	lda.w $3F4F,y
	dec a
	sta.w $3F52,y
	lda.b $A3
	asl a
	asl a
	asl a
	dec a
	dec a
	sta.w $3F4F,y
CODE_C5DD16:						; from CODE_C5DD1D
	tya
	clc
	adc.w #$0006
	tay
	rts
CODE_C5DD1D:						; from CODE_C5DCEE
	lda.w $3F4E,y
	inc a
	sta.w $3F4E,y
	lda.w $3F51,y
	dec a
	sta.w $3F51,y
	rep #$20
	lda.w $3F4F,y
	dec a
	sta.w $3F4F,y
	lda.w $3F52,y
	dec a
	sta.w $3F52,y
	lda.w $3F51,y
	and.w #$00FF
	bne CODE_C5DD16
	iny
	iny
	iny
	rts
CODE_C5DD47:						; called from other segments
	lda.w $2C42
	sta.b $9F
	ldx.w #$8EF8
CODE_C5DD4F:						; from CODE_C5DDB5
	lda.l $7F0000,x
	bne CODE_C5DDB5
	lda.l $7F0006,x
	bmi CODE_C5DDB5
	lda.l $7F0002,x
	txy
	jsr.w CODE_C5DDC0
	sec
	sbc.l $7F0008,x
	bcc CODE_C5DD79
	beq CODE_C5DD79
	jsl.l CODE_C58CCD
	clc
	adc.l $7F0008,x
	sta.l $7F0008,x
CODE_C5DD79:						; from CODE_C5DD4F
	lda.l $7F0004,x
	jsr.w CODE_C5DDC0
	inc a
	sec
	sbc.l $7F000A,x
	bcc CODE_C5DD97
	beq CODE_C5DD97
	jsl.l CODE_C58CCD
	clc
	adc.l $7F000A,x
	sta.l $7F000A,x
CODE_C5DD97:						; from CODE_C5DD79
	lda.w #$FFFF
	sta.l $7F0006,x
	lda.w $1864
	cmp.w #$0003
	bne CODE_C5DDB5
	lda.l $7F000A,x
	cmp.l $7F0008,x
	bne CODE_C5DDB5
	inc a
	sta.l $7F000A,x
CODE_C5DDB5:						; from CODE_C5DD4F, CODE_C5DD97
	clc
	txa
	adc.w #$010A
	tax
	dec.b $9F
	bne CODE_C5DD4F
	rts
CODE_C5DDC0:						; from CODE_C5DD4F, CODE_C5DD79
	asl a
	tax
	lda.l $C30000,x
	tax
	adc.l $C30006,x
	tax
	lda.l $C30004,x
	and.w #$00FF
	jsl.l CODE_C58CCD
	sta.l WRDIVL
	lda.w #$000A
	sta.l WRDIVB
	inx
	inx
	inx
	inx
	clc
	tyx
	lda.l RDDIVL
	adc.w #$0004
	rts
CODE_C5DDF0:						; called from other segments
	pea.w $7E7F
	lda.w $2C42
	sta.b $9F
	lda.l $306051
	sta.b $A3
	plb
	ldy.w #$8EF8
CODE_C5DE02:						; from CODE_C5DE09
	lsr.b $A3
	bcs CODE_C5DE09
	jsr.w CODE_C5DE1F
CODE_C5DE09:						; from CODE_C5DE02
	tya
	clc
	adc.w #$010A
	tay
	dec.b $9F
	bne CODE_C5DE02
	plb
	rts
CODE_C5DE15:						; from CODE_C5DE38
	ldx.w #$0002
	bra CODE_C5DE3F
CODE_C5DE1A:						; from CODE_C5DE38
	ldx.w #$0003
	bra CODE_C5DE3F
CODE_C5DE1F:						; from CODE_C5DE02 and other segments
	lda.w $0008,y
	cmp.w $000A,y
	php
	lda.w $0002,y
	plp
	jsr.w CODE_C5DE38
	lda.w $000A,y
	cmp.w $0008,y
	php
	lda.w $0004,y
	plp
CODE_C5DE38:						; from CODE_C5DE1F
	bcc CODE_C5DE15
	beq CODE_C5DE1A
	ldx.w #$0001
CODE_C5DE3F:						; from CODE_C5DE15, CODE_C5DE1A
	stx.b $A1
	ldx.w #$0015
	phy
	jsl.l Mul8U
	ply
	tax
	sep #$20
CODE_C5DE4D:						; from CODE_C5DE95
	lda.l $30606D,x
	bit.b #$03
	bne CODE_C5DE5D
	ora.b $A1
	sta.l $30606D,x
	bra CODE_C5DE98
CODE_C5DE5D:						; from CODE_C5DE4D
	bit.b #$0C
	bne CODE_C5DE6D
	asl.b $A1
	asl.b $A1
	ora.b $A1
	sta.l $30606D,x
	bra CODE_C5DE98
CODE_C5DE6D:						; from CODE_C5DE5D
	bit.b #$30
	bne CODE_C5DE81
	lda.b $A1
	asl a
	asl a
	asl a
	asl a
	ora.l $30606D,x
	sta.l $30606D,x
	bra CODE_C5DE98
CODE_C5DE81:						; from CODE_C5DE6D
	bit.b #$C0
	bne CODE_C5DE95
	lda.b $A1
	clc
	ror a
	ror a
	ror a
	ora.l $30606D,x
	sta.l $30606D,x
	bra CODE_C5DE98
CODE_C5DE95:						; from CODE_C5DE81
	inx
	bra CODE_C5DE4D
CODE_C5DE98:						; from CODE_C5DE4D, CODE_C5DE5D, CODE_C5DE6D, CODE_C5DE81
	rep #$20
	rts
CODE_C5DE9B:						; called from other segments
	pea.w $7E7F
	lda.w $2C42
	sta.b $9F
	lda.l $306051
	sta.b $A3
	plb
	ldy.w #$8EF8
CODE_C5DEAD:						; from CODE_C5DF50
	lsr.b $A3
	bcc CODE_C5DEB4
	jmp.w CODE_C5DF50
CODE_C5DEB4:						; from CODE_C5DEAD
	lda.w $0000,y
	beq CODE_C5DEBC
	jmp.w CODE_C5DF50
CODE_C5DEBC:						; from CODE_C5DEB4
	tyx
	lda.w $0008,y
	sta.w $0034,y
	jsr.w CODE_C5E123
	tya
	clc
	adc.w #$0016
	tax
	lda.w $000A,y
	sta.w $001E,y
	jsr.w CODE_C5E123
	lda.w $0024,y
	sta.w $0020,y
	lda.w $000E,y
	sta.w $0036,y
	phy
	lda.w $0002,y
	sta.l $0017CB
	lda.w $0004,y
	sta.l $0017C9
	pei ($9F)
	pei ($A1)
	pei ($A3)
	pea.w $7F7E
	plb
	jsl.l $C4C536
	jsr.w CODE_C52CC1
	ldy.w #$2DC9
	jsl.l $C4EFD8
	ldy.w #$3207
	jsl.l $C4EFD8
	plb
	pla
	sta.b $A3
	pla
	sta.b $A1
	pla
	sta.b $9F
	lda.b $01,s
	clc
	adc.w #$003A
	tax
	inc a
	tay
	stz.w $0000,x
	lda.w #$00CE
	mvn $7F,$7F
	lda.w #$3207
	sta.b $38
	lda.w #$007E
	sta.b $3A
	lda.b $01,s
	tay
	adc.w #$001A
	tax
	jsr.w CODE_C5DF5F
	lda.w #$2DC9
	sta.b $38
	lda.b $01,s
	clc
	tax
	adc.w #$0016
	tay
	jsr.w CODE_C5DF5F
	ply
CODE_C5DF50:						; from CODE_C5DEAD, CODE_C5DEB4
	clc
	tya
	adc.w #$010A
	tay
	dec.b $9F
	beq CODE_C5DF5D
	jmp.w CODE_C5DEAD
CODE_C5DF5D:						; from CODE_C5DF50
	plb
	rts

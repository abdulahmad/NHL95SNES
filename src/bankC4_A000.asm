; Segment bankC4_A000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C49FBD
CODE_C49FBD:						; called from other segments
	lda.w $07EE
	bne CODE_C49FD2
	lda.w #$0010
	clc
	adc.w $0F00,x
	jsl.l CODE_C37EAA
	cmp.w #$0009
	bcs CODE_C4A00B
CODE_C49FD2:						; from CODE_C49FBD
	lda.w #$0006
	jsl.l CODE_C37EAA
	sta.b $7F
	cpx.w #$000C
	bcc CODE_C49FE6
	clc
	adc.w #$0006
	sta.b $7F
CODE_C49FE6:						; from CODE_C49FD2
	lda.w $0A20,x
	beq CODE_C4A005
	lda.w $0830
	cmp.w #$FFD7
	bmi CODE_C4A005
	cmp.w #$0029
	bpl CODE_C4A005
	lda.w $08B2
	cmp.w #$FF2D
	bmi CODE_C4A00B
	cmp.w #$00D3
	bpl CODE_C4A00B
CODE_C4A005:						; from CODE_C49FE6
	asl.b $7F
	cpx.b $7F
	bne CODE_C4A00C
CODE_C4A00B:						; from CODE_C49FBD, CODE_C49FE6, CODE_C4A00C, CODE_C4A041
	rtl
CODE_C4A00C:						; from CODE_C4A005
	ldy.b $7F
	sty.b $63
	lda.w $0A20,y
	beq CODE_C4A00B
	bmi CODE_C4A00B
	lda.w $0D60,y
	and.w #$1000
	ora.w $1000,y
	bne CODE_C4A00B
	lda.w $0896,y
	sta.b $7F
	lda.w $0896,x
	sta.b $83
	lda.w $0FE0,x
	bne CODE_C4A041
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
CODE_C4A041:						; from CODE_C4A00C
	lda.w $10F1
	bit.w #$0020
	beq CODE_C4A05B
	lda.b $7F
	sec
	sbc.w #$005C
	sta.b $9F
	lda.b $83
	sec
	sbc.w #$005C
	eor.b $9F
	bmi CODE_C4A00B
CODE_C4A05B:						; from CODE_C4A041
	lda.b $7F
	cmp.w #$005C
	bpl CODE_C4A06E
	lda.b $7F
	sec
	sbc.b $83
	sta.b $7F
	cmp.w #$FFF1
	bmi CODE_C4A0C0
CODE_C4A06E:						; from CODE_C4A05B
	lda.w $0624,y
	sec
	sbc.w #$0004
	and.w #$0007
	sta.w $07C8
	lda.w $05E4,y
	sta.b $87
	lda.w #$0005
	sta.b $8B
	ldy.w #$0000
	stz.b $67
	cpx.w #$000C
	bcs CODE_C4A092
	ldy.w #$000C
CODE_C4A092:						; from CODE_C4A06E, CODE_C4A0A8
	lda.b $87
	cmp.w $05E4,y
	bcc CODE_C4A0A8
	lda.w $0624,y
	sec
	sbc.w #$0004
	and.w #$0007
	cmp.w $07C8
	beq CODE_C4A0C0
CODE_C4A0A8:						; from CODE_C4A092
	iny
	iny
	dec.b $8B
	bpl CODE_C4A092
	jsl.l CODE_C4A0DD
	lda.w $0A20,x
	beq CODE_C4A0C0
	pla
	sep #$20
	pla
	rep #$30
	jmp.w CODE_C4370C
CODE_C4A0C0:						; from CODE_C4A05B, CODE_C4A092, CODE_C4A0A8
	rtl
CODE_C4A0C1:						; called from other segments
	lda.b $87
	bit.w #$8000
	bne CODE_C4A0DD
	lda.b $7F
	bit.w #$0008
	bne CODE_C4A0DC
	and.w #$0007
	sta.w $07C8
	ora.w #$0008
	sta.b $7F
	bra CODE_C4A0DD
CODE_C4A0DC:						; from CODE_C4A0C1
	rtl
CODE_C4A0DD:						; from CODE_C4A0C1, CODE_C4A0A8 and other segments
	stz.w $0672
	lda.w #$0004
	trb.w $10F5
	lda.w #$FFFF
	sta.w $05A0
	lda.w #$0010
	sta.w $0CE0,x
	txa
	lsr a
	sta.w $07B8
	lda.w #$0007
	sta.b $7F
	lda.w $0A20,x
	beq CODE_C4A106
	lda.w $0EC0,x
	sta.b $7F
CODE_C4A106:						; from CODE_C4A0DD
	lda.b $7F
	asl a
	asl a
	adc.w #$00C8
	cmp.w #$0100
	bcc CODE_C4A115
	lda.w #$00FF
CODE_C4A115:						; from CODE_C4A106
	sta.w $07CA
	lda.w #$FFFF
	sta.b $8F
	lda.w #$0005
	sta.b $8B
	stz.b $67
	cpx.w #$000C
	bcc CODE_C4A12E
	lda.w #$000C
	sta.b $67
CODE_C4A12E:						; from CODE_C4A115, CODE_C4A176
	cpx.b $67
	beq CODE_C4A176
	ldy.b $67
	lda.w $0A20,y
	bmi CODE_C4A176
	beq CODE_C4A176
	lda.w $0D60,y
	bit.w #$1000
	bne CODE_C4A176
	lda.w $0624,y
	sec
	sbc.w $07C8
	sec
	sbc.w #$0004
	stz.b $2C
	and.w #$0007
	beq CODE_C4A164
	cmp.w #$0001
	beq CODE_C4A15F
	cmp.w #$0007
	bne CODE_C4A176
CODE_C4A15F:						; from CODE_C4A12E
	lda.w #$1000
	sta.b $2C
CODE_C4A164:						; from CODE_C4A12E
	lda.b $2C
	clc
	adc.w $05E4,y
	bcs CODE_C4A176
	cmp.b $8F
	bcs CODE_C4A176
	sta.b $8F
	lda.b $67
	sta.b $63
CODE_C4A176:						; from CODE_C4A12E, CODE_C4A164
	inc.b $67
	inc.b $67
	dec.b $8B
	bmi CODE_C4A181
	jmp.w CODE_C4A12E
CODE_C4A181:						; from CODE_C4A176
	ldx.b $6F
	lda.b $8F
	bmi CODE_C4A195
	jsl.l CODE_C4A254
	lda.w #$000B
	jsl.l $CF040B
	jmp.w CODE_C4A1F2
CODE_C4A195:						; from CODE_C4A181
	lda.w $07C8
	asl a
	asl a
	adc.w #$9C06
	sta.b $63
	lda.w #$00C0
	sta.b $65
	lda.b [$63]
	cmp.w #$8000
	ror a
	tax
	lda.w #$0050
	jsl.l Mul8XS
	asl a
	sta.b $40
	ldx.b $B7
	lda.w $09C0,x
	cmp.w #$8000
	ror a
	clc
	adc.b $40
	sta.w $09DC
	dec.b $63
	dec.b $63
	lda.b [$63]
	cmp.w #$8000
	ror a
	tax
	lda.w #$0050
	jsl.l Mul8XS
	asl a
	sta.b $40
	ldx.b $B7
	lda.w $09A0,x
	cmp.w #$8000
	ror a
	clc
	adc.b $40
	sta.w $09BC
	jsl.l RandomWord
	and.w #$0FFF
	sta.w $08DE
CODE_C4A1F2:						; from CODE_C4A181, CODE_C4A599
	lda.w $0A20,x
	bne CODE_C4A20F
	lda.w $0FE0,x
	beq CODE_C4A203
	lda.w $09DC
	bmi CODE_C4A208
	bra CODE_C4A20F
CODE_C4A203:						; from CODE_C4A1F2
	lda.w $09DC
	bmi CODE_C4A20F
CODE_C4A208:						; from CODE_C4A1F2
	eor.w #$FFFF
	inc a
	sta.w $09DC
CODE_C4A20F:						; from CODE_C4A1F2, CODE_C4A203
	lda.w $09BC
	sta.b $7F
	lda.w $09DC
	sta.b $83
	jsl.l CODE_C37F6D
	ldy.w #$144E
	lda.w $0A20,x
	beq CODE_C4A231
	ldy.w #$1B40
	jsl.l CODE_C49D8D
	beq CODE_C4A231
	ldy.w #$1BB2
CODE_C4A231:						; from CODE_C4A20F
	sty.b $83
	jsl.l CODE_C457A1
	lda.w #$0001
	sta.w $1000,x
	lda.w $0A20,x
	bne CODE_C4A253
	lda.w $14F9,x
	bmi CODE_C4A253
	stz.w $09A0,x
	stz.w $09C0,x
	sta.b $8F
	jsl.l CODE_C537C4
CODE_C4A253:						; from CODE_C4A231
	rtl
CODE_C4A254:						; from CODE_C4A181 and other segments
	jsl.l CODE_C53616
	lda.w $10F3
	bne CODE_C4A266
	ldy.b $6B
	lda.w $12DF,y
	inc a
	sta.w $12DF,y
CODE_C4A266:						; from CODE_C4A254
	ldx.w $0664,y
	lda.w $0E60,x
	lsr a
	clc
	adc.w #$0001
	adc.w $0AE0,x
	sta.w $0AE0,x
	lda.b $63
	sta.w $07CC
	ldx.b $63
	lda.w #$0015
	sta.b $7F
	jsl.l CODE_C43734
	ldx.b $6F
	ldy.b $63
	lda.w $0856,y
	pha
	lda.w $08E0,y
	bit.w #$0800
	beq CODE_C4A2A0
	lda.w #$0000
	sec
	sbc.w $0C40,y
	bra CODE_C4A2A3
CODE_C4A2A0:						; from CODE_C4A266
	lda.w $0C40,y
CODE_C4A2A3:						; from CODE_C4A266
	and.w #$0007
	asl a
	tax
	lda.l DATA8_C41E48,x
	tax
	lda.l $C40000,x
	ldx.b $6F
	ldy.b $63
	sta.w $0856,y
	lda.b $63
	jsl.l CODE_C37FE2
	ldy.b $63
	pla
	sta.w $0856,y
	lda.b $83
	clc
	adc.w $0896,y
	sec
	sbc.w $08B2
	sta.b $83
	lda.b $7F
	clc
	adc.w $0814,y
	sec
	sbc.w $0830
	sta.b $7F
	lda.w #$0018
	sta.b $97
	lda.b $97
	asl a
	asl a
	asl a
	asl a
	ldy.b $63
	ldx.w $09A0,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b $7F
	sta.b $87
	lda.b $97
	asl a
	asl a
	asl a
	asl a
	ldx.w $09C0,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b $83
	sta.b $8B
	ldy.b $87
	jsl.l CODE_C38778
	sta.b $8F
	asl a
	tax
	lda.w #$0003
	jsl.l DivX8U
	cmp.w #$0040
	bcc CODE_C4A336
	cmp.w #$0050
	bcc CODE_C4A373
	ldx.b $8F
	lda.w #$0005
	jsl.l DivX8U
	sta.b $97
	lda.w #$0050
	bra CODE_C4A33F
CODE_C4A336:						; from CODE_C4A2A3
	lda.b $8F
	lsr a
	lsr a
	sta.b $97
	lda.w #$0040
CODE_C4A33F:						; from CODE_C4A2A3
	pha
	lda.b $97
	asl a
	asl a
	asl a
	asl a
	ldy.b $63
	ldx.w $09A0,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b $7F
	sta.b $87
	lda.b $97
	asl a
	asl a
	asl a
	asl a
	ldx.w $09C0,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b $83
	sta.b $8B
	ldy.b $87
	jsl.l CODE_C38778
	sta.b $8F
	pla
CODE_C4A373:						; from CODE_C4A2A3
	sta.b $93
	sta.w $07CA
	ldx.b $B7
	lda.w #$0010
	sec
	sbc.w $0EC0,x
	jsl.l CODE_C37EC8
	clc
	adc.b $93
	sta.b $93
	ldx.b $87
	jsl.l Mul16x8XS
	lda.b $8F
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	xba
	and.w #$FF00
	sta.w $09BC
	lda.b $93
	ldx.b $8B
	jsl.l Mul16x8XS
	lda.b $8F
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	xba
	and.w #$FF00
	sta.w $09DC
	lda.b $87
	clc
	adc.w $0830
	sta.w $066E
	lda.b $8B
	clc
	adc.w $08B2
	sta.w $0670
	lda.b $8F
	asl a
	asl a
	asl a
	sta.w $08DE
	lda.w #$000A
	sta.w $0CFC
	ldy.b $63
	lda.b $97
	clc
	adc.w #$0006
	sta.w $0676,y
	ldx.b $B7
	lda.b $97
	sta.w $0CE0,x
	ldy.b $6B
	lda.w $14F9,x
	sta.w $05C8,y
	lda.w $0A20,x
	bne CODE_C4A41B
	lda.w $14F9,x
	bmi CODE_C4A41B
	stz.w $09A0,x
	stz.w $09C0,x
	lda.w $14F9,x
	sta.b $8F
	lda.w $07CC
	sta.b $7F
	jsl.l CODE_C5376A
	lda.w $14F9,x
	bmi CODE_C4A41B
	jsl.l CODE_C537C4
CODE_C4A41B:						; from CODE_C4A373
	rtl
CODE_C4A41C:						; from CODE_C4A4B3 and other segments
	stx.w $066A
	lda.w $0A20,x
	beq CODE_C4A493
	lda.w $0FE0,x
	bne CODE_C4A45E
	lda.w $0896,x
	cmp.w #$FFA4
	bmi CODE_C4A44A
	lda.w #$0004
	sta.w $07C8
	lda.w $0814,x
	bmi CODE_C4A443
	lda.w #$000A
	sta.w $066C
	rtl
CODE_C4A443:						; from CODE_C4A41C
	lda.w #$0006
	sta.w $066C
	rtl
CODE_C4A44A:						; from CODE_C4A41C
	lda.w $063E
	sec
	sbc.w #$0004
	and.w #$0007
	sta.w $07C8
	lda.w #$0008
	sta.w $066C
	rtl
CODE_C4A45E:						; from CODE_C4A41C
	lda.w $0896,x
	cmp.w #$005C
	bpl CODE_C4A47F
	lda.w #$0000
	sta.w $07C8
	lda.w $0814,x
	bmi CODE_C4A478
	lda.w #$0016
	sta.w $066C
	rtl
CODE_C4A478:						; from CODE_C4A45E
	lda.w #$0012
	sta.w $066C
	rtl
CODE_C4A47F:						; from CODE_C4A45E
	lda.w $063C
	sec
	sbc.w #$0004
	and.w #$0007
	sta.w $07C8
	lda.w #$0014
	sta.w $066C
	rtl
CODE_C4A493:						; from CODE_C4A41C
	stz.w $066C
	stz.w $07C8
	lda.w $0FE0,x
	bne CODE_C4A4AA
	lda.w #$000C
	sta.w $066C
	lda.w #$0004
	sta.w $07C8
CODE_C4A4AA:						; from CODE_C4A493
	rtl
CODE_C4A4AB:						; called from other segments
	lda.w #$0014
	sta.b $7F
	jmp.w CODE_C4373E
CODE_C4A4B3:						; called from other segments
	cpx.w $05A0
	bne CODE_C4A4E3
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C4A4E6
	jsl.l CODE_C4A41C
	lda.w $0D60,x
	and.w #$FFFD
	sta.w $0D60,x
	lda.w $14F9,x
	bpl CODE_C4A4E6
	lda.w $066C
	cmp.w #$0014
	beq CODE_C4A4E0
	cmp.w #$0008
	beq CODE_C4A4E0
	rtl
CODE_C4A4E0:						; from CODE_C4A4B3
	jmp.w CODE_C4981D
CODE_C4A4E3:						; from CODE_C4A4B3
	jmp.w CODE_C4370C
CODE_C4A4E6:						; from CODE_C4A4B3
	ldy.w #$0000
	lda.w $07C8
	cmp.w $0C40,x
	beq CODE_C4A510
	iny
	dec a
	and.w #$0007
	cmp.w $0C40,x
	beq CODE_C4A510
	iny
	inc a
	inc a
	and.w #$0007
	cmp.w $0C40,x
	beq CODE_C4A510
	lda.w $07C8
	sta.b $7F
	jsl.l CODE_C4933E
	rtl
CODE_C4A510:						; from CODE_C4A4E6
	lda.w $0A20,x
	bne CODE_C4A523
	tya
	asl a
	adc.w $066C
	sta.w $066C
	lda.w $0C40,x
	sta.w $07C8
CODE_C4A523:						; from CODE_C4A510
	jsl.l CODE_C4A52A
	jmp.w CODE_C4370C
CODE_C4A52A:						; from CODE_C4A523 and other segments
	txy
	lda.w #$000F
	sec
	sbc.w $0EC0,y
	asl a
	sta.b $8F
	ldx.w $066C
	lda.l DATA8_C4A5FD,x
	clc
	adc.b $8F
	jsl.l CODE_C37EC8
	clc
	adc.l DATA8_C4A62D,x
	sec
	sbc.w $0830
	sta.b $7F
	lda.l DATA8_C4A615,x
	clc
	adc.b $8F
	jsl.l CODE_C37EC8
	clc
	adc.l DATA8_C4A645,x
	sec
	sbc.w $08B2
	sta.b $83
	ldy.b $7F
	jsl.l CODE_C38778
	sta.b $87
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
	ldx.b $B7
	ldy.w $0A20,x
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
	sta.b $8B
	ldx.b $7F
	jsl.l Mul16x8XS
	lda.b $87
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	xba
	and.w #$FF00
	sta.w $09BC
	lda.b $8B
	ldx.b $83
	jsl.l Mul16x8XS
	lda.b $87
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	xba
	and.w #$FF00
	sta.w $09DC
	asl a
	asl a
	asl a
	asl a
	lda.w #$03C0
	sec
	sbc.b $8F
	jsl.l CODE_C37E95
	clc
	adc.w #$10E0
	sta.w $08DE
	jsl.l CODE_C49572
	ldx.b $B7
	lda.w #$FFFF
	sta.w $066A
	sta.w $05A0
	lda.w #$001E
	sta.w $0CE0,x
	txa
	lsr a
	sta.w $07B8
	jmp.w CODE_C4A1F2
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
	stx.b $A3
	ldx.w #$2035
	stx.b $A1
	sta.w $0894
	jsl.l CODE_C5F368
	plx
	lda.w $0874
CODE_C4A680:						; from CODE_C4A65D
	cmp.w #$01B3
	bne CODE_C4A693
	lda.w $0830
	sta.w $0832
	lda.w $08B2
	inc a
	sta.w $08B4
	rtl
CODE_C4A693:						; from CODE_C4A680
	tay
	beq CODE_C4A6B0
	lda.w #$0030
	sta.w $0832
	lda.w #$0133
	bit.w $08B2
	bpl CODE_C4A6AD
	lda.w #$8000
	sta.w $08FE
	lda.w #$FEAF
CODE_C4A6AD:						; from CODE_C4A693
	sta.w $08B4
CODE_C4A6B0:						; from CODE_C4A693
	rtl
CODE_C4A6B1:						; called from other segments
	lda.w $08D8
	cmp.w #$0008
	bpl CODE_C4A6C3
	lda.b $7F
	and.w #$000F
	beq CODE_C4A6C3
	jmp.w CODE_C4AD26
CODE_C4A6C3:						; from CODE_C4A6B1
	jsl.l CODE_C4843B
	lda.w $09BC
	ldy.w $09DC
	jsl.l CODE_C38778
	and.w #$7F00
	sta.b $9F
	xba
	tsb.b $9F
	ldy.w $08D8
	cmp.w #$000E
	bmi CODE_C4A6E6
	lda.w #$000D
	bra CODE_C4A6E9
CODE_C4A6E6:						; from CODE_C4A6C3
	lda.w #$0011
CODE_C4A6E9:						; from CODE_C4A6C3
	jsl.l $CF0418
	stz.w $08DE
	ldy.b $6B
	lda.w #$0008
	sta.w $0CE0,y
	lda.w $0814,x
	sec
	sbc.w $0814,y
	sta.b $7F
	lda.w $0896,x
	sec
	sbc.w $0896,y
	sta.b $83
	bne CODE_C4A711
	tya
	jsl.l CODE_C37FE2
CODE_C4A711:						; from CODE_C4A6E9
	lda.w $09A0,x
	sta.b $87
	lda.w $09C0,x
	sta.b $8B
	sep #$20
	lda.b $7F
	sta.w $09A1,x
	lda.b $83
	sta.w $09C1,x
	rep #$30
	jsl.l CODE_C49572
	lda.w $08D8
	cmp.w #$0008
	bmi CODE_C4A76A
	lda.b $87
	tax
	jsl.l Mul16S
	lda.b $36
	sta.b $89
	lda.b $34
	sta.b $87
	lda.b $8B
	tax
	jsl.l Mul16S
	ldx.b $6F
	lda.b $34
	clc
	adc.b $87
	sta.b $87
	lda.b $36
	adc.b $89
	sta.b $89
	cmp.w #$0900
	bcc CODE_C4A76B
	lda.w $08D8
	cmp.w #$000C
	bmi CODE_C4A76A
	jmp.w CODE_C44F20
CODE_C4A76A:						; from CODE_C4A711, CODE_C4A76B
	rtl
CODE_C4A76B:						; from CODE_C4A711
	ldy.b $6B
	lda.w $1000,y
	bne CODE_C4A76A
	inc a
	sta.w $1060,y
	lda.w #$26B6
	ldx.b $6B
	jsl.l CODE_C457B5
	ldx.b $6F
	rtl
CODE_C4A782:						; called from other segments
	lda.w $10F1
	bit.w #$0010
	beq CODE_C4A78D
	jmp.w CODE_C4A91E
CODE_C4A78D:						; from CODE_C4A782
	stz.b $87
	lda.w $08D8
	cmp.w #$0008
	bpl CODE_C4A79B
	inc.b $87
	inc.b $87
CODE_C4A79B:						; from CODE_C4A78D
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
	jsl.l CODE_C37F6D
	ldy.b $6B
	lda.b $7F
	sec
	sbc.w $0C40,y
	and.w #$0007
	sta.b $7F
	and.w #$0003
	sta.b $83
	bne CODE_C4A7C8
	lda.w $04B0
	sta.b $7F
CODE_C4A7C8:						; from CODE_C4A79B
	lda.b $7F
	and.w #$0004
	lsr a
	lsr a
	eor.w #$0001
	clc
	adc.b $87
	asl a
	sta.b $87
	lda.w $0F60,y
	sta.b $83
	lda.b $87
	beq CODE_C4A7FE
	lda.w $0EC0,y
	sta.b $83
	lda.b $87
	cmp.w #$0002
	beq CODE_C4A7FE
	lda.w $0F00,y
	sta.b $83
	lda.b $87
	cmp.w #$0004
	beq CODE_C4A7FE
	lda.w $0F40,y
	sta.b $83
CODE_C4A7FE:						; from CODE_C4A7C8
	lda.b $83
	clc
	adc.w #$000F
	sta.b $83
	lda.w $08E0,y
	bit.w #$0800
	beq CODE_C4A815
	lda.b $87
	eor.w #$0002
	sta.b $87
CODE_C4A815:						; from CODE_C4A7FE
	lda.w $0856,y
	sec
	sbc.w #$0286
	cmp.w #$0018
	bcs CODE_C4A82C
	lda.w $08D8
	cmp.w #$0005
	bmi CODE_C4A82C
	jmp.w CODE_C4A91E
CODE_C4A82C:						; from CODE_C4A815
	jsl.l CODE_C4A967
	jsl.l CODE_C4843B
	lda.w $09DC
	bit.w #$8000
	beq CODE_C4A840
	eor.w #$FFFF
	inc a
CODE_C4A840:						; from CODE_C4A82C
	and.w #$7F00
	sta.b $9F
	xba
	tsb.b $9F
	lda.w #$0011
	jsl.l $CF0418
	lda.w $09DC
	cmp.w #$3000
	bpl CODE_C4A85C
	cmp.w #$D000
	bpl CODE_C4A889
CODE_C4A85C:						; from CODE_C4A840
	lda.w $14E3
	clc
	adc.w #$000A
	bmi CODE_C4A868
	sta.w $14E3
CODE_C4A868:						; from CODE_C4A85C
	ldy.b $6B
	lda.w $1020,y
	beq CODE_C4A878
	lda.w #$000A
	jsl.l $CF040B
	bra CODE_C4A889
CODE_C4A878:						; from CODE_C4A868
	lda.l $7E24CA
	clc
	adc.w #$0258
	sta.l $7E24CA
	lda.w #$003C
	sta.b $5B
CODE_C4A889:						; from CODE_C4A840, CODE_C4A868
	lda.w $05A0
	bmi CODE_C4A88F
	lsr a
CODE_C4A88F:						; from CODE_C4A889
	sta.b $87
	bpl CODE_C4A896
	jmp.w CODE_C4A922
CODE_C4A896:						; from CODE_C4A88F
	cpx.w $05A0
	bne CODE_C4A89E
	jmp.w CODE_C4A922
CODE_C4A89E:						; from CODE_C4A896
	lda.w #$FF00
	tsb.w $05A0
	asl.b $87
	lda.b $87
	sta.b $63
	tay
	lda.w #$0014
	sta.w $0CE0,y
	tya
	lsr a
	sta.w $07B8
	lda.w #$000C
	trb.w $10F5
CODE_C4A8BC:						; from CODE_C4A91F
	stz.w $08DE
	ldy.b $6B
	lda.w #$000A
	sta.w $0CE0,y
	lda.w #$0004
	sta.w $0B40,y
	lda.w $0814,x
	sec
	sbc.w $0814,y
	sta.b $7F
	lda.w $0896,x
	sec
	sbc.w $0896,y
	sta.b $83
	bne CODE_C4A8E7
	lda.b $6B
	jsl.l CODE_C37FE2
CODE_C4A8E7:						; from CODE_C4A8BC
	lda.b $83
	and.w #$00FF
	bit.w #$0080
	beq CODE_C4A8F4
	ora.w #$FF00
CODE_C4A8F4:						; from CODE_C4A8E7
	sta.b $83
	lda.b $83
	beq CODE_C4A8FC
	inc.b $83
CODE_C4A8FC:						; from CODE_C4A8F4
	ldy.b $6B
	lda.w $09C0,y
	eor.b $83
	bmi CODE_C4A90D
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
CODE_C4A90D:						; from CODE_C4A8FC
	sep #$20
	lda.b $7F
	sta.w $09A1,x
	lda.b $83
	sta.w $09C1,x
	rep #$20
	jmp.w CODE_C49572
CODE_C4A91E:						; from CODE_C4A782, CODE_C4A815
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
	jsl.l CODE_C37E95
	adc.w #$2000
	sta.b $7F
	cmp.w $09BC
	bmi CODE_C4A91F
	lda.b $7F
	cmp.w $09DC
	bmi CODE_C4A91F
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	cmp.w $09BC
	bpl CODE_C4A91F
	lda.b $7F
	cmp.w $09DC
	bpl CODE_C4A91F
	ldy.b $6B
	lda.w $0D60,y
	bit.w #$1000
	bne CODE_C4A91F
	stz.w $08DE
	jmp.w CODE_C44E0A
CODE_C4A967:						; from CODE_C4A82C, CODE_C4AAA3 and other segments
	lda.w #$1000
	trb.w $10F5
	bne CODE_C4A972
	jmp.w CODE_C4AA64
CODE_C4A972:						; from CODE_C4A967
	lda.w $10F3
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
	stx.b $6F
	stz.b $6B
	lda.w #$0002
	sta.b $67
	txa
	cmp.w #$000C
	bmi CODE_C4A9A4
	lda.w #$0002
	sta.b $6B
	stz.b $67
CODE_C4A9A4:						; from CODE_C4A97A
	ldy.w #$1297
	lda.w $1020,x
	beq CODE_C4A9AE
	iny
	iny
CODE_C4A9AE:						; from CODE_C4A9A4
	lda.w $0000,y
	inc a
	sta.w $0000,y
	ldy.b $6B
	bne CODE_C4A9D6
	lda.w $12C7
	sec
	sbc.w $12C9
	beq CODE_C4A9F1
	bmi CODE_C4A9CD
	lda.w $1277
	inc a
	sta.w $1277
	bra CODE_C4A9F1
CODE_C4A9CD:						; from CODE_C4A9AE
	lda.w $127B
	inc a
	sta.w $127B
	bra CODE_C4A9F1
CODE_C4A9D6:						; from CODE_C4A9AE
	lda.w $12C9
	sec
	sbc.w $12C7
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
	lda.w $114B
	asl a
	asl a
	tax
	lda.b $6B
	beq CODE_C4A9FD
	inx
	inx
CODE_C4A9FD:						; from CODE_C4A9F1
	lda.w $1287,x
	inc a
	sta.w $1287,x
	ldx.b $6F
	lda.w $0DC0,x
	sta.b $7F
	lda.b $6B
	beq CODE_C4AA12
	lda.w #$001A
CODE_C4AA12:						; from CODE_C4A9FD
	clc
	adc.b $7F
	ldx.b $6B
	cmp.w $12CB,x
	beq CODE_C4AA24
	tax
	sep #$20
	inc.w $147B,x
	rep #$20
CODE_C4AA24:						; from CODE_C4AA12
	ldx.b $67
	lda.w $12CB,x
	sta.b $7F
	bmi CODE_C4AA3F
	lda.b $67
	beq CODE_C4AA34
	lda.w #$001A
CODE_C4AA34:						; from CODE_C4AA24
	clc
	adc.b $7F
	tax
	sep #$20
	inc.w $147B,x
	rep #$20
CODE_C4AA3F:						; from CODE_C4AA24
	plx
	pla
	sta.b $81
	pla
	sta.b $7F
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
	lda.w $14E3
	clc
	adc.w #$000A
	bmi CODE_C4AA64
	sta.w $14E3
CODE_C4AA64:						; from CODE_C4A967, CODE_C4A972, CODE_C4AA3F
	rtl
CODE_C4AA65:						; called from other segments
	lda.w $10F3
	beq CODE_C4AA74
	stz.w $08DE
	stz.w $09BC
	stz.w $09DC
	rtl
CODE_C4AA74:						; from CODE_C4AA65
	lda.w $1157
	beq CODE_C4AAA3
	lda.w $08B2
	bpl CODE_C4AA88
	lda.w $10F1
	bit.w #$0002
	beq CODE_C4AA9E
	bra CODE_C4AA92
CODE_C4AA88:						; from CODE_C4AA74
	lda.w $10F1
	bit.w #$0002
	beq CODE_C4AA92
	bra CODE_C4AA9E
CODE_C4AA92:						; from CODE_C4AA74, CODE_C4AA88
	lda.w $18B4
	beq CODE_C4AAA3
CODE_C4AA97:						; from CODE_C4AA9E
	jsl.l CODE_C486C7
	jmp.w CODE_C4AD25
CODE_C4AA9E:						; from CODE_C4AA74, CODE_C4AA88
	lda.w $18B4
	beq CODE_C4AA97
CODE_C4AAA3:						; from CODE_C4AA74, CODE_C4AA92
	jsl.l CODE_C4A967
	jsl.l CODE_C52284
	lda.w #$001E
	sta.w $0772
	stz.b $6B
	lda.w #$0002
	sta.b $67
	lda.w $08B2
	bpl CODE_C4AAC4
	stz.b $67
	lda.w #$0002
	sta.b $6B
CODE_C4AAC4:						; from CODE_C4AAA3
	lda.w $10F1
	bit.w #$0002
	beq CODE_C4AAD5
	lda.b $67
	sta.b $6B
	eor.w #$0002
	sta.b $67
CODE_C4AAD5:						; from CODE_C4AAC4
	ldy.b $6B
	lda.w $12AB,y
	inc a
	sta.w $12AB,y
	lda.w $12C7
	sec
	sbc.w $12C9
	beq CODE_C4AAFA
	bmi CODE_C4AAEF
	ldy.b $6B
	beq CODE_C4AAFA
	bra CODE_C4AAF3
CODE_C4AAEF:						; from CODE_C4AAD5
	ldy.b $6B
	bne CODE_C4AAFA
CODE_C4AAF3:						; from CODE_C4AAD5
	lda.w $127F,y
	inc a
	sta.w $127F,y
CODE_C4AAFA:						; from CODE_C4AAD5, CODE_C4AAEF
	lda.w $18BE
	bne CODE_C4AB0F
	lda.w $18AE
	beq CODE_C4AB18
	ldy.b $6B
	lda.w $12E7,y
	inc a
	sta.w $12E7,y
	bra CODE_C4AB18
CODE_C4AB0F:						; from CODE_C4AAFA
	ldy.b $6B
	lda.w $12EF,y
	inc a
	sta.w $12EF,y
CODE_C4AB18:						; from CODE_C4AAFA
	lda.w $18AC
	beq CODE_C4AB26
	ldy.b $6B
	lda.w $12FB,y
	inc a
	sta.w $12FB,y
CODE_C4AB26:						; from CODE_C4AB18
	lda.w #$0009
	jsl.l $CF00E3
	lda.w #$00A2
	jsl.l $CF040B
	stz.w $06EC
	ldy.b $6B
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
	sta.b $5B
	lda.w #$0003
	jsl.l $CF0485
CODE_C4AB73:						; from CODE_C4AB4F
	lda.b $5D
	sta.w $07EC
	jsl.l CODE_C486C7
	stz.w $18AE
	stz.w $18AC
	phx
	lda.w $114B
	asl a
	asl a
	tax
	lda.w $14E3
	clc
	adc.w #$001E
	bmi CODE_C4AB95
	sta.w $14E3
CODE_C4AB95:						; from CODE_C4AB73
	lda.b $6B
	beq CODE_C4ABA7
	inx
	inx
	lda.w $14E3
	clc
	adc.w #$FFCE
	bmi CODE_C4ABA7
	sta.w $14E3
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
	sta.b $63
	lda.w $2038
	adc.w #$0006
	sta.w $2038
	jsl.l CODE_C510DF
	lda.b $7F
	sta.b [$63]
	inc.b $63
	inc.b $63
	lda.w #$0002
	clc
	ldy.b $6B
	adc.w $12C7,y
	ldy.b $67
	sec
	sbc.w $12C7,y
	ldy.b $6B
	beq CODE_C4ABF7
	ora.w #$0080
CODE_C4ABF7:						; from CODE_C4ABBE
	sta.b [$63]
	inc.b $63
	lda.w $12BB,y
	sta.b $7F
	sta.b [$63]
	inc.b $63
	lda.w #$FFFF
	sta.b [$63]
	ldx.b $6B
	lda.w $12CB,x
	cmp.b $7F
	beq CODE_C4AC24
	lda.b $6B
	beq CODE_C4AC19
	lda.w #$001A
CODE_C4AC19:						; from CODE_C4ABF7
	clc
	adc.b $7F
	tax
	sep #$20
	inc.w $1413,x
	rep #$20
CODE_C4AC24:						; from CODE_C4ABF7
	ldy.b $6B
	lda.w $12BF,y
	sta.b $7F
	bmi CODE_C4AC66
	sep #$20
	sta.b [$63]
	rep #$20
	lda.b $6B
	beq CODE_C4AC3A
	lda.w #$001A
CODE_C4AC3A:						; from CODE_C4AC24
	clc
	adc.b $7F
	tax
	sep #$20
	inc.w $1447,x
	rep #$20
	inc.b $63
	lda.w $12C3,y
	sta.b $7F
	bmi CODE_C4AC66
	sep #$20
	sta.b [$63]
	rep #$20
	lda.b $6B
	beq CODE_C4AC5B
	lda.w #$001A
CODE_C4AC5B:						; from CODE_C4AC3A
	clc
	adc.b $7F
	tax
	sep #$20
	inc.w $1447,x
	rep #$20
CODE_C4AC66:						; from CODE_C4AC24, CODE_C4AC3A
	ldy.b $67
	lda.w $12CB,y
	sta.b $7F
	bmi CODE_C4AC7D
	lda.b $67
	beq CODE_C4AC76
	lda.w #$001A
CODE_C4AC76:						; from CODE_C4AC66
	clc
	adc.b $7F
	tax
	inc.w $1413,x
CODE_C4AC7D:						; from CODE_C4AC66
	jsl.l CODE_C4797A
	jsl.l CODE_C539D7
	ldx.b $6F
	lda.w #$0008
	sta.b $7F
	jsl.l CODE_C4AD04
	lda.b $6B
	bne CODE_C4ACA2
	lda.w $12AD
	sec
	sbc.w $12AB
	bmi CODE_C4ACA2
	cmp.w #$0003
	bcs CODE_C4ACA2
CODE_C4ACA2:						; from CODE_C4AC7D
	stz.w $07A2
	stz.w $09BC
	stz.w $09DC
	ldy.w #$0006
	lda.w $0830
	bpl CODE_C4ACB6
	ldy.w #$FFFA
CODE_C4ACB6:						; from CODE_C4ACA2
	sty.w $0830
	ldy.w #$0116
	lda.w $08B2
	bpl CODE_C4ACC4
	ldy.w #$FEEA
CODE_C4ACC4:						; from CODE_C4ACB6
	sty.w $08B2
	lda.w #$0600
	sta.w $08DE
	stz.w $08D8
	lda.w #$FFFF
	sta.w $07DA
	sta.w $07DE
	sta.w $109C
	lda.w #$001A
	sta.b $7F
	jsl.l CODE_C4373E
	inx
	inx
	lda.w #$253E
	jsl.l CODE_C457B5
	ldy.b $6B
	ldx.w $1283,y
	stx.b $6F
	lda.w #$000E
	sta.b $7F
	jsl.l CODE_C478C3
	ldx.w #$001C
	stx.b $6F
	rtl
CODE_C4AD04:						; from CODE_C4AC7D and other segments
	phx
	ldy.b $6B
	lda.w $1283,y
	tax
	lda.w #$0005
	sta.b $8B
CODE_C4AD10:						; from CODE_C4AD1E
	lda.w $0A20,x
	bmi CODE_C4AD1E
	beq CODE_C4AD1E
	stz.w $1080,x
	jsl.l CODE_C43734
CODE_C4AD1E:						; from CODE_C4AD10
	inx
	inx
	dec.b $8B
	bpl CODE_C4AD10
	plx
CODE_C4AD25:						; from CODE_C4AA97
	rtl
CODE_C4AD26:						; from CODE_C4A6B1 and other segments
	ldy.b $6B
	lda.w $0A20,y
	bne CODE_C4AD36
	lda.w $10F1
	bit.w #$0010
	beq CODE_C4AD36
CODE_C4AD35:						; from CODE_C4AD47
	rtl
CODE_C4AD36:						; from CODE_C4AD26
	lda.w $0D60,y
	and.w #$FFFE
	sta.w $0D60,y
	ldy.w $05A0
	bpl CODE_C4AD47
	jmp.w CODE_C4ADE5
CODE_C4AD47:						; from CODE_C4AD36
	lda.w $1020,y
	ldy.b $6B
	cmp.w $1020,y
	beq CODE_C4AD35
	lda.b $7F
	cmp.w #$0025
	bcs CODE_C4AD35
	lda.w $0A20,y
	beq CODE_C4AD97
	ldy.b $63
	lda.w $0A20,y
	beq CODE_C4AD35
	lda.w $0F20,y
	jsl.l CODE_C54A47
	pei ($7F)
	lda.b $63
	ldy.b $6B
	sty.b $63
	sta.b $6B
	lda.w $0F20,y
	sta.b $7F
	jsl.l CODE_C54A47
	lda.b $63
	ldy.b $6B
	sty.b $63
	sta.b $6B
	pla
	sec
	sbc.b $7F
	clc
	adc.w #$0024
	jsl.l CODE_C37E95
	cmp.w #$0003
	bcs CODE_C4AD35
CODE_C4AD97:						; from CODE_C4AD47
	ldy.b $63
	lda.w $0F20,y
	jsl.l CODE_C54A47
	lda.b $7F
	adc.w #$0014
	ldy.b $63
	sta.w $0CE0,y
	lda.b $63
	ldy.b $6B
	sty.b $63
	sta.b $6B
	lda.w $0F20,y
	jsl.l CODE_C54A47
	lda.b $7F
	adc.w #$0014
	ldy.b $63
	sta.w $0CE0,y
	lda.b $63
	ldy.b $6B
	sty.b $63
	sta.b $6B
	tya
	lsr a
	sta.w $07B8
	lda.w #$000C
	trb.w $10F5
CODE_C4ADD6:						; from CODE_C4AE5F
	lda.w #$000D
	jsl.l $CF040B
	jsl.l CODE_C4843B
	jmp.w CODE_C4AE6D
CODE_C4ADE4:						; from CODE_C4AE3F
	rtl
CODE_C4ADE5:						; from CODE_C4AD36
	lda.b $7F
	sta.b $87
	lda.w $09BC
	phx
	tax
	jsl.l Mul16S
	lda.b $36
	sta.b $81
	lda.b $34
	sta.b $7F
	lda.w $09DC
	tax
	jsl.l Mul16S
	plx
	lda.b $34
	clc
	adc.b $7F
	sta.b $7F
	lda.b $36
	adc.b $81
	sta.b $81
	stz.b $83
	lda.w $10F5
	bit.w #$1000
	bne CODE_C4AE2C
	ldy.b $6B
	lda.w $0F20,y
	phx
	ldx.w #$02BC
	jsl.l Mul16x8U
	lda.b $34
	sta.b $83
	plx
CODE_C4AE2C:						; from CODE_C4ADE5
	lda.b $83
	clc
	adc.w #$2710
	ldy.w $0A20,x
	beq CODE_C4AE3C
	cpx.w $07CC
	bne CODE_C4AE3F
CODE_C4AE3C:						; from CODE_C4AE2C
	adc.w #$0BB8
CODE_C4AE3F:						; from CODE_C4AE2C
	phx
	tax
	jsl.l Mul16U
	plx
	lda.b $34
	cmp.b $7F
	lda.b $36
	sbc.b $81
	bcs CODE_C4AE6A
	lda.w $0A20,x
	beq CODE_C4AE5F
	lda.b $87
	cmp.w #$0025
	bcc CODE_C4AE5F
	jmp.w CODE_C4ADE4
CODE_C4AE5F:						; from CODE_C4AE3F
	ldy.b $6B
	lda.w #$0008
	sta.w $0CE0,y
	jmp.w CODE_C4ADD6
CODE_C4AE6A:						; from CODE_C4AE3F
	jmp.w CODE_C44E0A
CODE_C4AE6D:						; from CODE_C4ADD6
	lda.w #$FFFF
	sta.w $05A0
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w $09DC
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w $09BC
	jsl.l RandomWord
	and.w #$0FFF
	sta.w $08DE
	jmp.w CODE_C49572
CODE_C4AE9C:						; called from other segments
	lda.w $07B6
	bit.w #$0004
	beq CODE_C4AEC4
	bit.w #$0001
	bne CODE_C4AEC4
	lda.w $05A0
	bpl CODE_C4AEC4
	lda.w #$010E
	sta.b $7F
	lda.w $07B6
	bit.w #$0002
	bne CODE_C4AEC5
	lda.w #$FEF2
	sec
	sbc.w $08B2
	bpl CODE_C4AECE
CODE_C4AEC4:						; from CODE_C4AE9C, CODE_C4AEC5
	rtl
CODE_C4AEC5:						; from CODE_C4AE9C
	lda.w #$010E
	sec
	sbc.w $08B2
	bpl CODE_C4AEC4
CODE_C4AECE:						; from CODE_C4AE9C
	lda.w #$0001
	tsb.w $07B6
	rtl
CODE_C4AED5:						; called from other segments
	stz.b $67
	lda.w #$0002
	sta.b $6B
	jsl.l CODE_C4B00F
	stz.b $6B
	lda.w #$0002
	sta.b $67
	jsl.l CODE_C4B00F
	lda.w #$0058
	sta.b $7F
	lda.w $08B2
	bpl CODE_C4AEF8
	jmp.w CODE_C4AF7E
CODE_C4AEF8:						; from CODE_C4AED5
	lda.b $7F
	sec
	sbc.w $08B2
	bmi CODE_C4AF0A
	lda.b $7F
	sec
	sbc.w $097C
	bpl CODE_C4AF74
	bra CODE_C4AF12
CODE_C4AF0A:						; from CODE_C4AEF8
	lda.b $7F
	sec
	sbc.w $097C
	bmi CODE_C4AF74
CODE_C4AF12:						; from CODE_C4AEF8
	jsl.l CODE_C4862C
	lda.w $10F1
	bit.w #$0020
	bne CODE_C4AF21
	jmp.w CODE_C4AF74
CODE_C4AF21:						; from CODE_C4AF12
	lda.w #$0062
	sta.b $7F
	lda.w $10F1
	bit.w #$0002
	beq CODE_C4AF36
	lda.b $6B
	ldy.b $67
	sty.b $6B
	sta.b $67
CODE_C4AF36:						; from CODE_C4AF21
	lda.w $05A0
	bpl CODE_C4AF3F
	lda.w $07B8
	asl a
CODE_C4AF3F:						; from CODE_C4AF36
	cmp.w #$000C
	bpl CODE_C4AF4A
	lda.b $6B
	beq CODE_C4AF4E
	bra CODE_C4AF74
CODE_C4AF4A:						; from CODE_C4AF3F
	lda.b $6B
	beq CODE_C4AF74
CODE_C4AF4E:						; from CODE_C4AF3F
	lda.w #$0005
	sta.b $87
	ldy.b $6B
	lda.w $1283,y
	sta.b $63
CODE_C4AF5A:						; from CODE_C4AF75
	ldy.b $63
	lda.w $0A20,y
	bmi CODE_C4AF75
	lda.b $7F
	sec
	sbc.w $0896,y
	bpl CODE_C4AF75
	ldy.b $6B
	lda.w $12FF,y
	ora.w #$0010
	sta.w $12FF,y
CODE_C4AF74:						; from CODE_C4B00F, CODE_C4AEF8, CODE_C4AF7E, CODE_C4B03F, ...
	rtl
CODE_C4AF75:						; from CODE_C4AF5A
	inc.b $63
	inc.b $63
	dec.b $87
	bpl CODE_C4AF5A
	rtl
CODE_C4AF7E:						; from CODE_C4AED5
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	lda.b $7F
	sec
	sbc.w $08B2
	bmi CODE_C4AF98
	lda.b $7F
	sec
	sbc.w $097C
	bpl CODE_C4AF74
	bra CODE_C4AFA0
CODE_C4AF98:						; from CODE_C4AF7E
	lda.b $7F
	sec
	sbc.w $097C
	bmi CODE_C4AF74
CODE_C4AFA0:						; from CODE_C4AF7E
	jsl.l CODE_C4862C
	lda.w $10F1
	bit.w #$0020
	bne CODE_C4AFAF
	jmp.w CODE_C4AF74
CODE_C4AFAF:						; from CODE_C4AFA0
	lda.b $7F
	sec
	sbc.w #$000A
	sta.b $7F
	lda.w $10F1
	bit.w #$0002
	bne CODE_C4AFC7
	lda.b $6B
	ldy.b $67
	sty.b $6B
	sta.b $67
CODE_C4AFC7:						; from CODE_C4AFAF
	lda.w $05A0
	bpl CODE_C4AFD0
	lda.w $07B8
	asl a
CODE_C4AFD0:						; from CODE_C4AFC7
	cmp.w #$000C
	bpl CODE_C4AFDB
	lda.b $6B
	beq CODE_C4AFDF
	bra CODE_C4AF74
CODE_C4AFDB:						; from CODE_C4AFD0
	lda.b $6B
	beq CODE_C4AF74
CODE_C4AFDF:						; from CODE_C4AFD0
	lda.w #$0005
	sta.b $87
	ldy.b $6B
	lda.w $1283,y
	sta.b $63
CODE_C4AFEB:						; from CODE_C4B006
	ldy.b $63
	lda.w $0A20,y
	bmi CODE_C4B006
	lda.b $7F
	sec
	sbc.w $0896,y
	bmi CODE_C4B006
	ldy.b $6B
	lda.w $12FF,y
	ora.w #$0010
	sta.w $12FF,y
	rtl
CODE_C4B006:						; from CODE_C4AFEB
	inc.b $63
	inc.b $63
	dec.b $87
	bpl CODE_C4AFEB
	rtl

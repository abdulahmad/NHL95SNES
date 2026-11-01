; Segment bankC4_5000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C44F20
CODE_C44F20:						; from CODE_C45516 and other segments
	lda.w $14E3
	clc
	adc.w #$000F
	bmi CODE_C44F2C
	sta.w $14E3
CODE_C44F2C:						; from CODE_C44F20
	ldy.b $6B
	cpy.w #$0018
	bcs CODE_C44F80
	lda.w $0C80,y
	cmp.w #$2708
	beq CODE_C44F80
	cmp.w #$25D2
	beq CODE_C44F80
	cmp.w #$2376
	beq CODE_C44F80
	cmp.w #$2448
	beq CODE_C44F80
	cmp.w #$2588
	beq CODE_C44F80
	lda.w #$25D2
	sta.b $83
	lda.w $10F3
	bne CODE_C44F81
	lda.w $0F20,y
	cmp.w #$000C
	bcc CODE_C44F81
	lda.w $0D00,y
	bne CODE_C44F81
	lda.w $04B0
	and.w #$000F
	adc.w #$000A
	sta.b $7F
	sec
	sbc.w $0A00,y
	bmi CODE_C44F81
	lda.w #$003C
	sta.w $0D00,y
	jmp.w CODE_C45127
CODE_C44F80:						; from CODE_C44F2C
	rtl
CODE_C44F81:						; from CODE_C44F2C
	lda.w $0A20,x
	beq CODE_C44FA0
	stz.b $63
	lda.w $1020,x
	beq CODE_C44F92
	lda.w #$0002
	sta.b $63
CODE_C44F92:						; from CODE_C44F81
	lda.w $10F3
	bne CODE_C44FA0
	ldy.b $63
	lda.w $12D7,y
	inc a
	sta.w $12D7,y
CODE_C44FA0:						; from CODE_C44F81, CODE_C44F92
	ldy.b $6B
	lda.w #$0078
	sta.w $0CE0,y
	lda.w $0814,x
	sec
	sbc.w $0814,y
	sta.b $7F
	lda.w $0896,x
	sec
	sbc.w $0896,y
	sta.b $83
	jsl.l CODE_C37F6D
	lda.w $0814,y
	cmp.w #$007B
	bpl CODE_C44FE4
	cmp.w #$FF85
	bmi CODE_C45011
	lda.w $0896,y
	cmp.w #$011E
	bpl CODE_C44FDE
	cmp.w #$FEE2
	bmi CODE_C44FDB
CODE_C44FD8:						; from CODE_C44FE4, CODE_C45011
	jmp.w CODE_C450DB
CODE_C44FDB:						; from CODE_C44FA0
	jmp.w CODE_C450AE
CODE_C44FDE:						; from CODE_C44FA0
	jmp.w CODE_C45084
CODE_C44FE1:						; from CODE_C44FE4, CODE_C45011
	jmp.w CODE_C4528A
CODE_C44FE4:						; from CODE_C44FA0
	lda.w $0896,y
	cmp.w #$00F0
	bpl CODE_C44FE1
	cmp.w #$FF0A
	bmi CODE_C44FE1
	lda.b $7F
	cmp.w #$0005
	bcc CODE_C44FD8
	lda.w #$008F
	sta.w $0814,y
	lda.w #$0000
	sta.w $09A0,y
CODE_C45004:						; from CODE_C45347
	lda.w $08E0,y
	bit.w #$0800
	bne CODE_C45047
CODE_C4500C:						; from CODE_C4503F
	lda.w #$29EA
	bra CODE_C4504A
CODE_C45011:						; from CODE_C44FA0
	lda.w $0896,y
	cmp.w #$00F0
	bpl CODE_C44FE1
	cmp.w #$FF0A
	bmi CODE_C44FE1
	lda.b $7F
	dec a
	cmp.w #$0003
	bcs CODE_C44FD8
	lda.w #$FF71
	sta.w $0814,y
	lda.w #$0000
	sta.w $09A0,y
	lda.w $0896,y
	cmp.w #$006C
	bpl CODE_C4503F
	cmp.w #$FF94
	bpl CODE_C45081
CODE_C4503F:						; from CODE_C45011, CODE_C45314
	lda.w $08E0,y
	bit.w #$0800
	bne CODE_C4500C
CODE_C45047:						; from CODE_C45004
	lda.w #$2A64
CODE_C4504A:						; from CODE_C4500C, CODE_C450A9, CODE_C450D2
	ldx.b $6B
	sta.w $1000,x
	jsl.l CODE_C457C7
	lda.w $14E3
	clc
	adc.w #$000A
	bmi CODE_C4505F
	sta.w $14E3
CODE_C4505F:						; from CODE_C4504A
	stz.w $06EC
	ldy.b $6B
	lda.w $1020,y
	beq CODE_C4506C
	lda.w #$0002
CODE_C4506C:						; from CODE_C4505F
	clc
	adc.w #$0006
	jsl.l $C382B6
	lda.w #$0002
	sta.w $06EE
	ldx.b $6F
	ldy.b $6B
	jmp.w CODE_C45147
CODE_C45081:						; from CODE_C45011
	jmp.w CODE_C45259
CODE_C45084:						; from CODE_C44FDE
	lda.w $0814,y
	cmp.w #$0050
	bpl CODE_C450D8
	cmp.w #$FFB0
	bmi CODE_C450D8
	lda.b $7F
	inc a
	inc a
	and.w #$0007
	cmp.w #$0005
	bcc CODE_C450DB
	lda.w #$0132
	sta.w $0896,y
	lda.w #$0000
	sta.w $09C0,y
CODE_C450A9:						; from CODE_C45399
	lda.w #$28F6
	bra CODE_C4504A
CODE_C450AE:						; from CODE_C44FDB
	lda.w $0814,y
	cmp.w #$0050
	bpl CODE_C450D8
	cmp.w #$FFB0
	bmi CODE_C450D8
	lda.b $7F
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs CODE_C450DB
	lda.w #$FECE
	sta.w $0896,y
	lda.w #$0000
	sta.w $09C0,y
CODE_C450D2:						; from CODE_C4536E
	lda.w #$2970
	jmp.w CODE_C4504A
CODE_C450D8:						; from CODE_C45084, CODE_C450AE
	jmp.w CODE_C4528A
CODE_C450DB:						; from CODE_C44FD8, CODE_C45084, CODE_C450AE, CODE_C452AC, ...
	ldy.b $6F
	lda.w $1020,y
	beq CODE_C450E5
	lda.w #$0002
CODE_C450E5:						; from CODE_C450DB
	inc a
	inc a
	jsl.l $C382B6
	lda.w #$0002
	sta.w $06EE
	lda.w #$2448
	sta.b $83
	ldy.b $6B
	lda.b $7F
	sec
	sbc.w $0C40,y
	inc a
	and.w #$0007
	cmp.w #$0003
	bcc CODE_C45127
	lda.w #$2376
	sta.b $83
	lda.w $0C40,y
	and.w #$0003
	bne CODE_C45127
	lda.w $0FA0,x
	sec
	sbc.w #$000A
	bmi CODE_C45127
	cpx.w #$0018
	bcs CODE_C45127
	lda.w #$2588
	sta.b $83
CODE_C45127:						; from CODE_C44F2C, CODE_C450E5
	ldx.b $6B
	lda.w #$0001
	sta.w $1000,x
	jsl.l CODE_C457A1
	ldx.b $6F
	lda.w $0A20,x
	bne CODE_C45147
	cpx.w #$0018
	bcs CODE_C45147
	bra CODE_C45147
CODE_C45141:						; from CODE_C45147
	jmp.w CODE_C44EE1
CODE_C45144:						; from CODE_C45147
	jmp.w CODE_C45228
CODE_C45147:						; from CODE_C45127, CODE_C4506C, CODE_C45265
	lda.l $7E24CA
	clc
	adc.w #$012C
	sta.l $7E24CA
	lda.w #$002D
	sta.b $5B
	lda.w $05A0
	sta.b $7F
	bmi CODE_C45141
	cpy.b $7F
	bne CODE_C45141
	lda.w $10F1
	bit.w #$0010
	bne CODE_C45144
	lda.w $1864
	cmp.w #$0001
	beq CODE_C45144
	lda.w $0A20,x
	beq CODE_C45144
	lda.w $0C80,y
	cmp.w #$2448
	bne CODE_C45144
	lda.w $0C40,y
	and.w #$0003
	bne CODE_C45144
	lda.w $0D60,y
	bit.w #$4000
	bne CODE_C45144
	lda.w #$0190
	jsl.l CODE_C37EAA
	asl a
	ldy.b $6B
	sec
	sbc.w $0A00,y
	bpl CODE_C45144
	lda.w $10F3
	bne CODE_C45144
	lda.w $0A20,y
	bmi CODE_C45228
	beq CODE_C45228
	lda.w #$FFFF
	sta.w $05A0
	stz.w $06EC
	ldy.b $6B
	lda.w $1020,y
	beq CODE_C451BF
	lda.w #$0002
CODE_C451BF:						; from CODE_C45147
	clc
	adc.w #$0006
	jsl.l $C382B6
	ldx.b $6B
	lda.w #$2708
	sta.w $1000,x
	jsl.l CODE_C457B5
	ldx.b $6F
	lda.w $09A0,x
	eor.w #$FFFF
	inc a
	cmp.w #$8000
	ror a
	sta.w $09A0,x
	lda.w $09C0,x
	eor.w #$FFFF
	inc a
	cmp.w #$8000
	ror a
	sta.w $09C0,x
	jsl.l CODE_C4824A
	lda.w #$0004
	sta.w $1141
	lda.w #$0016
	sta.b $7F
	lda.w $14E3
	clc
	adc.w #$001E
	bmi CODE_C4520C
	sta.w $14E3
CODE_C4520C:						; from CODE_C451BF
	lda.w $0A20,x
	bne CODE_C45214
	jmp.w CODE_C478C3
CODE_C45214:						; from CODE_C4520C
	lda.w $186C
	bne CODE_C4521C
	jmp.w CODE_C478C3
CODE_C4521C:						; from CODE_C45214
	lda.w #$0014
	sta.b $7F
	jsl.l CODE_C478C3
	jmp.w CODE_C47323
CODE_C45228:						; from CODE_C45147, CODE_C45144
	ldy.b $6B
	lda.w $0C80,y
	cmp.w #$25D2
	beq CODE_C45238
	lda.w #$FFFF
	sta.w $05A0
CODE_C45238:						; from CODE_C45228
	ldy.b $6B
	lda.w $1020,y
	bne CODE_C45247
	lda.w #$0004
	jsl.l $CF040B
	rtl
CODE_C45247:						; from CODE_C45238
	lda.l $7E24CA
	clc
	adc.w #$0258
	sta.l $7E24CA
	lda.w #$002D
	sta.b $5B
	rtl
CODE_C45259:						; from CODE_C45081
	lda.w $14E3
	clc
	adc.w #$000A
	bmi CODE_C45265
	sta.w $14E3
CODE_C45265:						; from CODE_C45259
	ldx.b $6B
	lda.w #$FF65
	sta.w $0814,x
	stz.w $09A0,x
	lda.w $08E0,x
	ora.w #$0800
	sta.w $08E0,x
	lda.w #$2ADE
	sta.w $1000,x
	jsl.l CODE_C457B5
	ldx.b $6F
	ldy.b $6B
	jmp.w CODE_C45147
CODE_C4528A:						; from CODE_C44FE1, CODE_C450D8
	lda.b $7F
	sta.b $93
	lda.w $0814,y
	sta.b $87
	lda.w $0896,y
	sta.b $8B
	ldx.w #$0048
	ldy.w #$00EA
	lda.b $87
	bpl CODE_C452A5
	ldx.w #$FFB8
CODE_C452A5:						; from CODE_C4528A
	lda.b $8B
	bpl CODE_C452AC
	ldy.w #$FF16
CODE_C452AC:						; from CODE_C452A5
	stx.b $81
	sty.b $85
	lda.b $87
	sec
	sbc.b $81
	sta.b $7F
	lda.b $8B
	sec
	sbc.b $85
	sta.b $83
	ldy.b $7F
	jsl.l $C38778
	ldy.b $6B
	sta.b $8F
	cmp.w #$0014
	bcs CODE_C452D2
	ldx.b $6F
	jmp.w CODE_C450DB
CODE_C452D2:						; from CODE_C452AC
	lda.b $7F
	xba
	tax
	lda.b $8F
	jsl.l DivX8S
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C452E6
	ora.w #$C000
CODE_C452E6:						; from CODE_C452D2
	sta.b $7F
	bit.w #$8000
	beq CODE_C452F1
	eor.w #$FFFF
	inc a
CODE_C452F1:						; from CODE_C452E6
	sta.b $89
	lda.b $83
	xba
	tax
	lda.b $8F
	jsl.l DivX8S
	ldx.b $6F
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C45309
	ora.w #$C000
CODE_C45309:						; from CODE_C452F1
	sta.b $83
	bit.w #$8000
	beq CODE_C45314
	eor.w #$FFFF
	inc a
CODE_C45314:						; from CODE_C45309
	cmp.b $89
	bcs CODE_C4536E
	lda.b $81
	bpl CODE_C45347
	lda.b $93
	dec a
	cmp.w #$0003
	bcs CODE_C45344
	lda.b $7F
	clc
	adc.w #$0006
	clc
	adc.b $81
	sta.w $0814,y
	lda.b $83
	clc
	adc.b $85
	sta.w $0896,y
	lda.w #$0000
	sta.w $09A0,y
	sta.w $09C0,y
	jmp.w CODE_C4503F
CODE_C45344:						; from CODE_C45314, CODE_C4536E, CODE_C45347, CODE_C45399
	jmp.w CODE_C450DB
CODE_C45347:						; from CODE_C45314
	lda.b $93
	cmp.w #$0005
	bcc CODE_C45344
	lda.b $7F
	sec
	sbc.w #$0006
	clc
	adc.b $81
	sta.w $0814,y
	lda.b $83
	clc
	adc.b $85
	sta.w $0896,y
	lda.w #$0000
	sta.w $09A0,y
	sta.w $09C0,y
	jmp.w CODE_C45004
CODE_C4536E:						; from CODE_C45314
	lda.b $85
	bpl CODE_C45399
	lda.b $93
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs CODE_C45344
	lda.b $7F
	clc
	adc.b $81
	sta.w $0814,y
	lda.b $83
	clc
	adc.b $85
	sta.w $0896,y
	lda.w #$0000
	sta.w $09A0,y
	sta.w $09C0,y
	jmp.w CODE_C450D2
CODE_C45399:						; from CODE_C4536E
	lda.b $93
	inc a
	inc a
	and.w #$0007
	cmp.w #$0005
	bcc CODE_C45344
	lda.b $7F
	clc
	adc.b $81
	sta.w $0814,y
	lda.b $83
	clc
	adc.b $85
	sta.w $0896,y
	lda.w #$0000
	sta.w $09A0,y
	sta.w $09C0,y
	jmp.w CODE_C450A9
CODE_C453C1:						; called from other segments
	pei ($8F)
	pei ($6B)
	pei ($6F)
	jsl.l CODE_C453E6
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
	jsl.l CODE_C453E6
	pla
	sta.b $6F
	pla
	sta.b $6B
	pla
	sta.b $8F
	ldx.b $6F
CODE_C453E2:						; from CODE_C453FD
	rtl
CODE_C453E3:						; from CODE_C453E6
	jmp.w CODE_C456B5
CODE_C453E6:						; from CODE_C453C1 and other segments
	ldy.b $6B
	lda.w $0C80,y
	cmp.w #$224E
	beq CODE_C453E3
	cmp.w #$2684
	beq CODE_C453E3
	cmp.w #$2082
	bne CODE_C453FD
	jmp.w CODE_C47C8C
CODE_C453FD:						; from CODE_C453E6
	lda.w $0C80,x
	cmp.w #$21BC
	bne CODE_C453E2
	lda.w $10F3
	beq CODE_C45413
	lda.w #$0100
	sta.w $0A00,x
	sta.w $0A00,y
CODE_C45413:						; from CODE_C453FD
	lda.w $0814,y
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.w $0896,y
	sec
	sbc.w $0896,x
	sta.b $83
	jsl.l CODE_C37F6D
	lda.b $7F
	sec
	sbc.w $0C40,x
	and.w #$0007
	asl a
	tay
	lda.w #DATA8_C45519>>16
	sta.b $65
	lda.w #DATA8_C45519
	sta.b $63
	sta.w $1060,x
	cpy.w #$0000
	bne CODE_C45476
	lda.w $0814,x
	cmp.w #$0050
	bpl CODE_C4546A
	cmp.w #$FFB0
	bmi CODE_C4546A
	lda.w $0896,x
	cmp.w #$00FE
	bpl CODE_C4546A
	cmp.w #$FF02
	bpl CODE_C4546A
	lda.w $04B0
	and.w #$00F0
	beq CODE_C45476
	bra CODE_C45472
CODE_C4546A:						; from CODE_C45413
	lda.w $04B0
	and.w #$0030
	beq CODE_C45476
CODE_C45472:						; from CODE_C45413
	iny
	iny
	sty.b $7F
CODE_C45476:						; from CODE_C45413, CODE_C4546A
	lda.b [$63],y
	jsl.l CODE_C457B5
	ldy.b $6B
	lda.w $0A20,y
	beq CODE_C454D3
	lda.b $8F
	sec
	sbc.w #$0020
	bmi CODE_C454D3
	lda.w #$0078
	sta.b $7F
	lda.b $7F
	sec
	sbc.w $0DE0,x
	clc
	adc.w $0DE0,y
	lsr a
	sec
	sbc.w $0A00,y
	beq CODE_C454D4
	bmi CODE_C454D4
	sta.b $7F
	jsl.l CODE_C37EBF
	lda.b $7F
	sec
	sbc.w $0FA0,x
	bmi CODE_C454D4
	jsl.l CODE_C48199
	lda.b $7F
	cmp.w #$0001
	bcs CODE_C454D3
	lda.w $10F1
	bit.w #$0010
	bne CODE_C454D3
	lda.w $04B1
	and.w #$0002
	clc
	adc.w #$0018
	sta.b $7F
	jmp.w CODE_C4789D
CODE_C454D3:						; from CODE_C45476
	rtl
CODE_C454D4:						; from CODE_C45476
	jsl.l CODE_C48199
	lda.b $7F
	cmp.w #$0001
	bcs CODE_C454F7
	lda.w $10F1
	bit.w #$0010
	bne CODE_C454F7
	lda.w $04B1
	and.w #$0002
	clc
	adc.w #$001C
	sta.b $7F
	jsl.l CODE_C4789D
CODE_C454F7:						; from CODE_C454D4
	jsl.l CODE_C480B5
	beq CODE_C45516
	lda.w $18B0
	bpl CODE_C45516
	ldy.b $6B
	sty.w $18B0
	lda.w $14F9,y
	sta.w $18B6
	lda.w #$0024
	sta.b $7F
	jsl.l CODE_C4789D
CODE_C45516:						; from CODE_C454F7
	jmp.w CODE_C44F20
DATA8_C45519:						; not traced: a table read by CODE_C45413
	db $30,$20,$26,$21,$8A,$21,$8A,$21,$8A,$21,$58,$21,$58,$21,$F4,$20
CODE_C45529:						; called from other segments
	lda.w #$0014
	sec
	sbc.w $0FA0,x
	sta.b $7F
	lda.w $186C
	beq CODE_C45539
	asl.b $7F
CODE_C45539:						; from CODE_C45529
	lda.b $7F
	jsl.l CODE_C37E95
	cmp.w #$0004
	bcc CODE_C4554F
	lda.b $7F
	jsl.l CODE_C37E95
	cmp.w #$0004
	bcs CODE_C45580
CODE_C4554F:						; from CODE_C45539
	lda.w #$0005
	sta.b $87
	ldy.w #$0000
	cpx.w #$000C
	bcs CODE_C4555F
	ldy.w #$000C
CODE_C4555F:						; from CODE_C4554F, CODE_C45578
	sty.b $63
	lda.w $0A20,y
	beq CODE_C45578
	lda.w $0C80,y
	cmp.w #$2280
	bcc CODE_C45573
	cmp.w #$2345
	bcc CODE_C45581
CODE_C45573:						; from CODE_C4555F
	lda.w $1000,y
	beq CODE_C45581
CODE_C45578:						; from CODE_C4555F, CODE_C45581
	ldy.b $63
	iny
	iny
	dec.b $87
	bpl CODE_C4555F
CODE_C45580:						; from CODE_C45539
	rtl
CODE_C45581:						; from CODE_C4555F, CODE_C45573
	lda.w $0814,y
	sec
	sbc.w $0814,x
	sta.b $7F
	cmp.w #$FFDE
	bmi CODE_C45578
	cmp.w #$0022
	bpl CODE_C45578
	lda.w $0896,y
	sec
	sbc.w $0896,x
	sta.b $83
	cmp.w #$FFDE
	bmi CODE_C45578
	cmp.w #$0022
	bpl CODE_C45578
	jsl.l CODE_C37F6D
	lda.b $7F
	cmp.w $0C40,x
	bne CODE_C45578
	lda.w $0814,x
	cmp.w #$004A
	bpl CODE_C455F7
	cmp.w #$FFB6
	bmi CODE_C455F7
	lda.w $0FE0,x
	bne CODE_C455EA
	lda.w $0896,x
	cmp.w #$005C
	bmi CODE_C455F7
	cmp.w #$010E
	bpl CODE_C455F7
CODE_C455D1:						; from CODE_C455EA
	lda.w $0C80,y
	cmp.w #$2280
	bcc CODE_C455DE
	cmp.w #$2345
	bcc CODE_C45602
CODE_C455DE:						; from CODE_C455D1
	lda.w $04B1
	and.w #$0007
	beq CODE_C45602
CODE_C455E6:						; from CODE_C455F7
	jml.l CODE_C4568F
CODE_C455EA:						; from CODE_C45581
	lda.w $0896,x
	cmp.w #$FFA4
	bpl CODE_C455F7
	cmp.w #$FEF2
	bpl CODE_C455D1
CODE_C455F7:						; from CODE_C45581, CODE_C455EA
	lda.w $04B1
	and.w #$0007
	bne CODE_C45602
	jmp.w CODE_C455E6
CODE_C45602:						; from CODE_C455D1, CODE_C455DE, CODE_C455F7
	jml.l CODE_C42D10
CODE_C45606:						; called from other segments
	lda.w #$2082
	sta.w $1060,x
	jml.l CODE_C457B5
CODE_C45610:						; called from other segments
	lda.w $0A20,x
	beq CODE_C45622
	lda.w $1000,x
	beq CODE_C45623
	lda.w $0C80,x
	cmp.w #$21BC
	bne CODE_C45623
CODE_C45622:						; from CODE_C45610
	rtl
CODE_C45623:						; from CODE_C45610
	lda.w #$FFFF
	sta.b $8B
	sta.b $63
	ldy.w #$0000
	cpx.w #$000C
	bcs CODE_C45635
	ldy.w #$000C
CODE_C45635:						; from CODE_C45623
	lda.w #$0006
	sta.b $87
CODE_C4563A:						; from CODE_C45687
	sty.b $6B
	lda.w $0A20,y
	beq CODE_C45677
	bmi CODE_C45677
	lda.w $0814,y
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.w $0896,y
	sec
	sbc.w $0896,x
	sta.b $83
	ldy.b $83
	lda.b $7F
	jsl.l $C38778
	sta.b $8F
	jsl.l CODE_C37F6D
	lda.b $7F
	sec
	sbc.w $0C40,x
	and.w #$0007
	cmp.w #$0005
	bcc CODE_C45677
	eor.w #$FFFF
	adc.w #$0008
CODE_C45677:						; from CODE_C4563A
	asl a
	asl a
	asl a
	asl a
	adc.b $8F
	cmp.b $8B
	bcs CODE_C45687
	sta.b $8B
	lda.b $6B
	sta.b $63
CODE_C45687:						; from CODE_C45677
	ldy.b $6B
	iny
	iny
	dec.b $87
	bne CODE_C4563A
CODE_C4568F:						; from CODE_C455E6 and other segments
	lda.w #$2684
	sta.b $83
	sta.w $1000,x
	ldy.b $63
	bmi CODE_C456B1
	lda.w $0C40,x
	sec
	sbc.w $0C40,y
	inc a
	inc a
	and.w #$0007
	cmp.w #$0005
	bcc CODE_C456B1
	lda.w #$224E
	sta.b $83
CODE_C456B1:						; from CODE_C4568F
	jml.l CODE_C457A1
CODE_C456B5:						; from CODE_C453E3
	lda.w $0A20,x
	beq CODE_C456F7
	lda.w $1000,x
	bne CODE_C456F7
	ldy.b $6B
	lda.w $0814,x
	sec
	sbc.w $0814,y
	sta.b $7F
	lda.w $0896,x
	sec
	sbc.w $0896,y
	sta.b $83
	jsl.l CODE_C37F6D
	ldy.b $6B
	lda.b $7F
	sec
	sbc.w $0C40,y
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs CODE_C456F7
	lda.w $05A0
	cmp.b $6F
	bne CODE_C456F8
	lda.w #$0008
	trb.w $10F5
	bra CODE_C456F8
CODE_C456F7:						; from CODE_C456B5
	rtl
CODE_C456F8:						; from CODE_C456B5
	lda.b $7F
	sta.w $0C40,y
	ldy.b $6B
	lda.w $09A0,x
	clc
	adc.w $09A0,y
	pha
	asl a
	pla
	ror a
	sta.w $09A0,x
	sta.w $09A0,y
	lda.w $09C0,x
	clc
	adc.w $09C0,y
	pha
	asl a
	pla
	ror a
	sta.w $09C0,x
	sta.w $09C0,y
	tya
	sta.w $09E0,x
	lda.w #$2344
	sta.w $1000,x
	jsl.l CODE_C457B5
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
	tya
	sta.w $09E0,x
	lda.w #$2280
	sta.w $1000,x
	ldy.w $0C80,x
	cpy.w #$224E
	beq CODE_C4574C
	lda.w #$22B2
CODE_C4574C:						; from CODE_C456F8
	jsl.l CODE_C457B5
	jsl.l CODE_C480B5
	beq CODE_C45771
	lda.w $18B0
	bpl CODE_C45771
	ldy.b $6B
	sty.w $18B0
	lda.w $14F9,y
	sta.w $18B6
	lda.w #$0024
	sta.b $7F
	jsl.l CODE_C4789D
	bra CODE_C45792
CODE_C45771:						; from CODE_C4574C
	jsl.l CODE_C48199
	lda.b $7F
	cmp.w #$0001
	bcs CODE_C45792
	lda.w #$0028
	sta.b $7F
	lda.w $0C80,x
	cmp.w #$2280
	beq CODE_C4578E
	lda.w #$0020
	sta.b $7F
CODE_C4578E:						; from CODE_C45771
	jsl.l CODE_C4789D
CODE_C45792:						; from CODE_C4574C, CODE_C45771
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
	lda.w #$FFFF
	sta.w $07A2
	rtl
CODE_C457A1:						; from CODE_C456B1, CODE_C45127 and other segments
	lda.b $83
	cmp.w $0C80,x
	beq CODE_C457B4
	sta.w $0C80,x
	stz.w $0CA0,x
	lda.w #$FFFF
	sta.w $0CC0,x
CODE_C457B4:						; from CODE_C457A1
	rtl
CODE_C457B5:						; from CODE_C45606, CODE_C45A65, CODE_C458E0, CODE_C45476, ...
	cmp.w $0C80,x
	beq CODE_C457C6
	sta.w $0C80,x
	stz.w $0CA0,x
	lda.w #$FFFF
	sta.w $0CC0,x
CODE_C457C6:						; from CODE_C457B5
	rtl
CODE_C457C7:						; from CODE_C4504A, CODE_C45881 and other segments
	cmp.w $0C80,x
	beq CODE_C457DC
	sta.w $0C80,x
	stz.w $0CA0,x
	lda.w #$FFFF
	sta.w $0CC0,x
	jsl.l CODE_C457DD
CODE_C457DC:						; from CODE_C457C7
	rtl
CODE_C457DD:						; from CODE_C457C7 and other segments
	lda.w $0C80,x
	bne CODE_C457E9
	stz.w $1060,x
	stz.w $1000,x
	rtl
CODE_C457E9:						; from CODE_C457DD
	phy
	sta.b $63
	lda.w #$00C4
	sta.b $65
	ldy.w #$0010
	lda.b [$63],y
	sta.b $83
	lda.w $0C80,x
	cmp.w #$2ADE
	bcs CODE_C45811
	lda.w $08E0,x
	bit.w #$0800
	beq CODE_C45811
	lda.w #$0000
	sec
	sbc.w $0C40,x
	bra CODE_C45814
CODE_C45811:						; from CODE_C457E9
	lda.w $0C40,x
CODE_C45814:						; from CODE_C457E9
	and.w #$0007
	asl a
	tay
	lda.b [$63],y
	sta.b $63
	ldy.w $0CA0,x
	sty.b $7F
	lda.b [$63],y
	sta.b $87
	lda.w $0CC0,x
	bmi CODE_C45868
	sec
	sbc.w $05A2
	sta.w $0CC0,x
	bpl CODE_C4587A
	lda.w $0CA0,x
	clc
	adc.w #$0004
	sta.w $0CA0,x
	sta.b $7F
	iny
	iny
	lda.b [$63],y
	cmp.w #$0000
	bpl CODE_C45868
	stz.b $7F
	stz.w $0CA0,x
	stz.w $1060,x
	stz.w $1000,x
	lda.w $0C80,x
	cmp.w #$2B18
	bcs CODE_C45861
	cmp.w #$2ADE
	bcs CODE_C45881
CODE_C45861:						; from CODE_C45814
	lda.b $83
	bne CODE_C45868
	stz.w $0C80,x
CODE_C45868:						; from CODE_C45814, CODE_C45861
	ldy.b $7F
	iny
	iny
	lda.b [$63],y
	bit.w #$8000
	beq CODE_C45877
	eor.w #$FFFF
	inc a
CODE_C45877:						; from CODE_C45868
	sta.w $0CC0,x
CODE_C4587A:						; from CODE_C45814
	lda.b $87
	sta.w $0856,x
CODE_C4587F:						; from CODE_C45881
	ply
	rtl
CODE_C45881:						; from CODE_C45814
	lda.w #$FF65
	sta.w $0814,x
	lda.w #$0002
	sta.w $0C40,x
	sta.w $1000,x
	lda.w $08E0,x
	ora.w #$0800
	sta.w $08E0,x
	lda.w #$18EC
	jsl.l CODE_C457C7
	bra CODE_C4587F
CODE_C458A2:						; called from other segments
	lda.w $09A0,x
	cmp.w #$DFFF
	bmi CODE_C458BC
	cmp.w #$2001
	bpl CODE_C458BC
	lda.w $09C0,x
	cmp.w #$DFFF
	bmi CODE_C458BC
	cmp.w #$2001
	bmi CODE_C458E4
CODE_C458BC:						; from CODE_C458A2
	lda.w #$1958
	ldy.w $1040,x
	bne CODE_C458E0
	cpx.w $05A0
	bne CODE_C458DA
	lda.w $09A0,x
	sta.b $38
	lda.w $09C0,x
	sta.b $3A
	lda.w #$000F
	jsl.l $CF040B
CODE_C458DA:						; from CODE_C458BC
	lda.w #$1AEE
	stz.w $1060,x
CODE_C458E0:						; from CODE_C458BC
	jsl.l CODE_C457B5
CODE_C458E4:						; from CODE_C458A2 and other segments
	lda.w $0A20,x
	bne CODE_C45908
	lda.w $14F9,x
	bmi CODE_C45908
	cpx.w $05A0
	beq CODE_C45908
	lda.w $09A0,x
	cmp.w #$8000
	ror a
	sta.w $09A0,x
	lda.w $09C0,x
	cmp.w #$8000
	ror a
	sta.w $09C0,x
	rtl
CODE_C45908:						; from CODE_C458E4
	stx.b $16
	lda.w #$0070
	clc
	adc.w $0E00,x
	ldx.b $9B
	dex
	beq CODE_C45917
	asl a
CODE_C45917:						; from CODE_C45908
	ldx.b $16
	sta.b $34
	lda.w $09A0,x
	bpl CODE_C4592A
	clc
	adc.b $34
	sta.w $09A0,x
	bmi CODE_C45935
	bra CODE_C45932
CODE_C4592A:						; from CODE_C45917
	sec
	sbc.b $34
	sta.w $09A0,x
	bpl CODE_C45935
CODE_C45932:						; from CODE_C45917
	stz.w $09A0,x
CODE_C45935:						; from CODE_C45917, CODE_C4592A
	lda.w $09C0,x
	bpl CODE_C45944
	clc
	adc.b $34
	sta.w $09C0,x
	bmi CODE_C4594F
	bra CODE_C4594C
CODE_C45944:						; from CODE_C45935
	sec
	sbc.b $34
	sta.w $09C0,x
	bpl CODE_C4594F
CODE_C4594C:						; from CODE_C45935
	stz.w $09C0,x
CODE_C4594F:						; from CODE_C45935, CODE_C45944
	rtl
CODE_C45950:						; called from other segments
	lda.w $0B00,x
	sec
	sbc.w $05A2
	sta.w $0B00,x
	bmi CODE_C4595F
	jmp.w CODE_C45A3E
CODE_C4595F:						; from CODE_C45950
	adc.w #$000C
	sta.w $0B00,x
	lda.b $7F
	sta.b $81
	lda.b $83
	sta.b $85
	jsl.l CODE_C46BF6
	lda.w $09A0,x
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C45980
	ora.w #$FF00
CODE_C45980:						; from CODE_C4595F
	eor.w #$FFFF
	inc a
	sta.b $40
	clc
	adc.b $7F
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.w $09C0,x
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C4599E
	ora.w #$FF00
CODE_C4599E:						; from CODE_C45980
	eor.w #$FFFF
	inc a
	sta.b $42
	clc
	adc.b $83
	sec
	sbc.w $0896,x
	sta.b $83
	lda.w $0A20,x
	bne CODE_C459BA
	lda.w $05CC,x
	bit.w #$0002
	beq CODE_C45A04
CODE_C459BA:						; from CODE_C4599E
	pei ($7F)
	pei ($83)
	ldy.w $09A0,x
	lda.w $09C0,x
	jsl.l $C38778
	pha
	lda.b $40
	clc
	adc.b $81
	sec
	sbc.w $0814,x
	tay
	lda.b $42
	clc
	adc.b $85
	sec
	sbc.w $0896,x
	jsl.l $C38778
	tay
	pla
	sta.b $40
	pla
	sta.b $83
	pla
	sta.b $7F
	lda.b $40
	cmp.w #$1000
	bcs CODE_C459F8
	cpy.w #$0005
	bpl CODE_C45A04
	bra CODE_C459FD
CODE_C459F8:						; from CODE_C459BA
	cpy.w #$000C
	bpl CODE_C45A04
CODE_C459FD:						; from CODE_C459BA
	lda.w #$0009
	sta.b $7F
	bra CODE_C45A08
CODE_C45A04:						; from CODE_C4599E, CODE_C459BA, CODE_C459F8
	jsl.l CODE_C37F6D
CODE_C45A08:						; from CODE_C459FD
	lda.b $63
	sta.w $1851
	lda.b $64
	sta.w $1852
	jsl.l $001850
	lda.b $7F
	sta.w $0B80,x
	cmp.w #$0008
	bcc CODE_C45A3E
	lda.w $09A0,x
	ora.w $09C0,x
	bne CODE_C45A3E
	lda.w $0830
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.w $08B2
	sec
	sbc.w $0896,x
	sta.b $83
	jsl.l CODE_C37F6D
CODE_C45A3E:						; from CODE_C45950, CODE_C45A08
	lda.w $0B80,x
	sta.b $7F
	jml.l CODE_C4694F
CODE_C45A47:						; called from other segments
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C45A71
	and.w #$FFFD
	sta.w $0D60,x
	lda.w #$005A
	sta.w $0B20,x
	lda.b $CB
	bpl CODE_C45A65
	lda.w #$FFA6
	sta.w $0B20,x
CODE_C45A65:						; from CODE_C45A47
	lda.b $CD
	sta.w $0B40,x
	sta.w $1000,x
	jsl.l CODE_C457B5
CODE_C45A71:						; from CODE_C45A47
	lda.w $0B20,x
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.w $0B40,x
	sec
	sbc.w $0896,x
	sta.b $83
	jsl.l CODE_C37F6D
	lda.b $7F
	cmp.w #$0008
	bpl CODE_C45A9E
	lda.b $7F
	sta.b $87
	sta.w $0C40,x
	lda.w #$0014
	sta.w $1000,x
	jmp.w CODE_C45ABE
CODE_C45A9E:						; from CODE_C45A71
	rtl
CODE_C45A9F:						; called from other segments
	lda.w #$FFFF
	sta.b $87
CODE_C45AA4:						; from CODE_C45AA4
	inc.b $87
	lda.b $63
	clc
	adc.b $87
	tay
	sep #$20
	lda.w $13DB,y
	sta.w $13DA,y
	rep #$30
	bit.w #$0080
	beq CODE_C45AA4
	dec.b $63
	rtl
CODE_C45ABE:						; from CODE_C45A71 and other segments
	lda.b $87
	asl a
	tax
	lda.b $9B
	dec a
	beq CODE_C45ACA
	jmp (DATA8_C45ADD,x)
CODE_C45ACA:						; from CODE_C45ABE
	jmp (DATA8_C45ACD,x)
DATA8_C45ACD:						; jump table: the routine for each index
	dw CODE_C45AED,CODE_C45D0F,CODE_C45EE5,CODE_C46075
	dw CODE_C4624F,CODE_C463E3,CODE_C465C1,CODE_C46755
DATA8_C45ADD:						; jump table: the routine for each index
	dw CODE_C45BB4,CODE_C45DF8,CODE_C45FAC,CODE_C4615F
	dw CODE_C46317,CODE_C464CE,CODE_C46689,CODE_C4683F
CODE_C45AED:						; from DATA8_C45ACD
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C45B03
	eor.b $83
	bmi CODE_C45B03
	lda.w $09C0,x
	bra CODE_C45B09
CODE_C45B03:						; from CODE_C45AED
	lda.w $09C0,x
	adc.w $0D80,x
CODE_C45B09:						; from CODE_C45AED
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l $C38A4A,x
	tay
	ldx.b $B7
	lda.w $09A1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l $C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($83)
	jsl.l CODE_C54A0E
	lda.w $186E
	cmp.w #$0002
	bne CODE_C45B3C
	lda.w #$1000
	sta.b $7F
CODE_C45B3C:						; from CODE_C45B09
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C45B7D
	lda.w $14F9,x
	bmi CODE_C45B7D
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C45B7D
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C45B7D:						; from CODE_C45B3C
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C45B87
	sta.w $09C0,x
CODE_C45B87:						; from CODE_C45B7D
	lda.w $186E
	beq CODE_C45BB3
	lda.w $04B0
	and.w #$003F
	bne CODE_C45BB3
	jsl.l CODE_C54A0E
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C45BAF
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C45BAF:						; from CODE_C45B87
	jml.l CODE_C54A2F
CODE_C45BB3:						; from CODE_C45B87
	rtl
CODE_C45BB4:						; from DATA8_C45ADD
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C45BCA
	eor.b $83
	bmi CODE_C45BCA
	lda.w $09C0,x
	bra CODE_C45BD2
CODE_C45BCA:						; from CODE_C45BB4
	lda.w $0D80,x
	asl a
	clc
	adc.w $09C0,x
CODE_C45BD2:						; from CODE_C45BB4
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l $C38A4A,x
	tay
	ldx.b $B7
	lda.w $09A1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l $C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($83)
	jsl.l CODE_C54A0E
	lda.w $186E
	cmp.w #$0002
	bne CODE_C45C05
	lda.w #$1000
	sta.b $7F
CODE_C45C05:						; from CODE_C45BD2
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C45C46
	lda.w $14F9,x
	bmi CODE_C45C46
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C45C46
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C45C46:						; from CODE_C45C05
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C45C50
	sta.w $09C0,x
CODE_C45C50:						; from CODE_C45C46
	lda.w $186E
	beq CODE_C45C7C
	lda.w $04B0
	and.w #$003F
	bne CODE_C45C7C
	jsl.l CODE_C54A0E
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C45C78
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C45C78:						; from CODE_C45C50
	jml.l CODE_C54A2F
CODE_C45C7C:						; from CODE_C45C50
	rtl
DATA8_C45C7D:						; jump table: the routine for each index
	dw CODE_C45C9D,CODE_C45CA0,CODE_C45CA1,CODE_C45CA3
	dw CODE_C45CA9,CODE_C45CAC,CODE_C45CB3,CODE_C45CBA
	dw CODE_C45CC5,CODE_C45CC9,CODE_C45CD1,CODE_C45CD9
	dw CODE_C45CE5,CODE_C45CED,CODE_C45CF9,CODE_C45D05
CODE_C45C9D:						; from DATA8_C45C7D
	lda.w #$0000
CODE_C45CA0:						; from DATA8_C45C7D
	rts
CODE_C45CA1:						; from DATA8_C45C7D
	asl a
	rts
CODE_C45CA3:						; from DATA8_C45C7D
	sta.b $34
	asl a
	adc.b $34
	rts
CODE_C45CA9:						; from DATA8_C45C7D
	asl a
	asl a
	rts
CODE_C45CAC:						; from DATA8_C45C7D
	sta.b $34
	asl a
	asl a
	adc.b $34
	rts
CODE_C45CB3:						; from DATA8_C45C7D
	asl a
	sta.b $34
	asl a
	adc.b $34
	rts
CODE_C45CBA:						; from DATA8_C45C7D
	sta.b $36
	asl a
	sta.b $34
	asl a
	adc.b $34
	adc.b $36
	rts
CODE_C45CC5:						; from DATA8_C45C7D
	asl a
	asl a
	asl a
	rts
CODE_C45CC9:						; from DATA8_C45C7D
	sta.b $34
	asl a
	asl a
	asl a
	adc.b $34
	rts
CODE_C45CD1:						; from DATA8_C45C7D
	asl a
	sta.b $34
	asl a
	asl a
	adc.b $34
	rts
CODE_C45CD9:						; from DATA8_C45C7D
	sta.b $36
	asl a
	sta.b $34
	asl a
	asl a
	adc.b $34
	adc.b $36
	rts
CODE_C45CE5:						; from DATA8_C45C7D
	asl a
	asl a
	sta.b $34
	asl a
	adc.b $34
	rts
CODE_C45CED:						; from DATA8_C45C7D
	sta.b $36
	asl a
	asl a
	sta.b $34
	asl a
	adc.b $34
	adc.b $36
	rts
CODE_C45CF9:						; from DATA8_C45C7D
	asl a
	sta.b $36
	asl a
	sta.b $34
	asl a
	adc.b $34
	adc.b $36
	rts
CODE_C45D05:						; from DATA8_C45C7D
	sta.b $34
	asl a
	asl a
	asl a
	asl a
	sec
	sbc.b $34
	rts
CODE_C45D0F:						; from DATA8_C45ACD
	lda.l DATA8_C4692F,x
	sta.b $7F
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C45D2B
	eor.b $83
	bmi CODE_C45D2B
	lda.w $09C0,x
	bra CODE_C45D31
CODE_C45D2B:						; from CODE_C45D0F
	lda.w $09C0,x
	adc.w $0DA0,x
CODE_C45D31:						; from CODE_C45D0F
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l $C38A4A,x
	tay
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C45D4E
	eor.b $7F
	bpl CODE_C45D4E
	lda.w $09A0,x
	bra CODE_C45D54
CODE_C45D4E:						; from CODE_C45D31
	lda.w $09A0,x
	adc.w $0DA0,x
CODE_C45D54:						; from CODE_C45D31
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l $C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	pei ($83)
	jsl.l CODE_C54A0E
	lda.w $186E
	cmp.w #$0002
	bne CODE_C45D7A
	lda.w #$1000
	sta.b $7F
CODE_C45D7A:						; from CODE_C45D54
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C45DBB
	lda.w $14F9,x
	bmi CODE_C45DBB
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C45DBB
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C45DBB:						; from CODE_C45D7A
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C45DC5
	sta.w $09C0,x
CODE_C45DC5:						; from CODE_C45DBB
	pla
	bcc CODE_C45DCB
	sta.w $09A0,x
CODE_C45DCB:						; from CODE_C45DC5
	lda.w $186E
	beq CODE_C45DF7
	lda.w $04B0
	and.w #$003F
	bne CODE_C45DF7
	jsl.l CODE_C54A0E
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C45DF3
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C45DF3:						; from CODE_C45DCB
	jml.l CODE_C54A2F
CODE_C45DF7:						; from CODE_C45DCB
	rtl
CODE_C45DF8:						; from DATA8_C45ADD
	lda.l DATA8_C4692F,x
	sta.b $7F
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C45E14
	eor.b $83
	bmi CODE_C45E14
	lda.w $09C0,x
	bra CODE_C45E1C
CODE_C45E14:						; from CODE_C45DF8
	lda.w $0DA0,x
	asl a
	clc
	adc.w $09C0,x
CODE_C45E1C:						; from CODE_C45DF8
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l $C38A4A,x
	tay
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C45E39
	eor.b $7F
	bpl CODE_C45E39
	lda.w $09A0,x
	bra CODE_C45E41
CODE_C45E39:						; from CODE_C45E1C
	lda.w $0DA0,x
	asl a
	clc
	adc.w $09A0,x
CODE_C45E41:						; from CODE_C45E1C
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l $C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	pei ($83)
	jsl.l CODE_C54A0E
	lda.w $186E
	cmp.w #$0002
	bne CODE_C45E67
	lda.w #$1000
	sta.b $7F
CODE_C45E67:						; from CODE_C45E41
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C45EA8
	lda.w $14F9,x
	bmi CODE_C45EA8
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C45EA8
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C45EA8:						; from CODE_C45E67
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C45EB2
	sta.w $09C0,x
CODE_C45EB2:						; from CODE_C45EA8
	pla
	bcc CODE_C45EB8
	sta.w $09A0,x
CODE_C45EB8:						; from CODE_C45EB2
	lda.w $186E
	beq CODE_C45EE4
	lda.w $04B0
	and.w #$003F
	bne CODE_C45EE4
	jsl.l CODE_C54A0E
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C45EE0
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C45EE0:						; from CODE_C45EB8
	jml.l CODE_C54A2F
CODE_C45EE4:						; from CODE_C45EB8
	rtl
CODE_C45EE5:						; from DATA8_C45ACD
	lda.l DATA8_C4692F,x
	sta.b $7F
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C45EFB
	eor.b $7F
	bpl CODE_C45EFB
	lda.w $09A0,x
	bra CODE_C45F01
CODE_C45EFB:						; from CODE_C45EE5
	lda.w $09A0,x
	adc.w $0D80,x
CODE_C45F01:						; from CODE_C45EE5
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	lda.l $C38A4A,x
	tay
	ldx.b $B7
	lda.w $09C1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l $C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	jsl.l CODE_C54A0E
	lda.w $186E
	cmp.w #$0002
	bne CODE_C45F34
	lda.w #$1000
	sta.b $7F
CODE_C45F34:						; from CODE_C45F01
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C45F75
	lda.w $14F9,x
	bmi CODE_C45F75
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C45F75
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C45F75:						; from CODE_C45F34
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C45F7F
	sta.w $09A0,x
CODE_C45F7F:						; from CODE_C45F75
	lda.w $186E
	beq CODE_C45FAB
	lda.w $04B0
	and.w #$003F
	bne CODE_C45FAB
	jsl.l CODE_C54A0E
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C45FA7
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C45FA7:						; from CODE_C45F7F
	jml.l CODE_C54A2F
CODE_C45FAB:						; from CODE_C45F7F
	rtl

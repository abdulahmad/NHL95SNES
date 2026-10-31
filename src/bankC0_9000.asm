; Segment bankC0_9000: the rest of the engine's math as in 94S (the Mul16x8Hi signed forms, Mul16, the
; divides), then game code (menus and lists) that keeps its address as a name until it is traced, with the
; cross references on each label.
org $C09005
Mul16x8HiXS:						; X * A (low byte) / 256 into r2+1, X signed
	phy
	tay
	beq Mul16x8Hi_Zero
Mul16x8HiXS_TestX:					; entry used by the routines after it
	txa
	beq Mul16x8Hi_Zero
	bpl Mul16x8HiU_Go
	eor.w #$FFFF
	inc a
Mul16x8HiXS_Neg:					; entry used by the routines after it
	jsl.l Mul16x8HiU_Pre
	eor.w #$FFFF
	inc a
	sta.b r2+1
	ply
	rtl
Mul16x8HiS:							; X * A / 256 into r2+1, both signed
	phy
	tay
	beq Mul16x8Hi_Zero
	bpl Mul16x8HiXS_TestX
	eor.w #$FFFF
	inc a
	tay
	txa
	beq Mul16x8Hi_Zero
	bpl Mul16x8HiXS_Neg
	eor.w #$FFFF
	inc a
	jmp.w Mul16x8HiU_Go
Mul16S:								; A * X into r2 (4 bytes), both signed
	phy
	tay
	beq Mul16_Zero
	bpl Mul16XS_TestX
	eor.w #$FFFF
	inc a
	tay
	sta.b r0
	txa
	beq Mul16_Zero
	bpl Mul16XS_Neg
	eor.w #$FFFF
	inc a
	bra Mul16U_Go
Mul16_Zero:							; product 0 into r2
	stz.b r2
	stz.b r2+2
	ply
	rtl
Mul16XS:							; A * X into r2 (4 bytes), X signed
	phy
	tay
	beq Mul16_Zero
Mul16XS_TestX:						; entry used by the routines after it
	sta.b r0
	txa
	beq Mul16_Zero
	bpl Mul16U_Go
	eor.w #$FFFF
	inc a
Mul16XS_Neg:						; entry used by the routines after it
	jsl.l Mul16U_Pre
	jmp.w Mul16x8XS_negres
Mul16U_Pre:							; Mul16U from its second step, with Y saved
	phy
	bra Mul16U_Go
Mul16U:								; A * X into r2 (4 bytes), unsigned
	phy
	tay
	beq Mul16_Zero
	sta.b r0
	txa
	beq Mul16_Zero
Mul16U_Go:							; entry used by the routines after it
	sep #$20
	sta.l WRMPYA
	tya
	sta.l WRMPYB
	stz.b r2
	ldy.b r0+1
	lda.l RDMPYL
	sta.b r1
	lda.l RDMPYH
	sta.b r1+1
	tya
	sta.l WRMPYB
	stz.b r2+3
	nop
	lda.l RDMPYL
	sta.b r2+1
	lda.l RDMPYH
	sta.b r2+2
	xba
	sta.l WRMPYA
	tya
	sta.l WRMPYB
	ldy.b r0
	nop
	lda.l RDMPYL
	sta.b r1+2
	lda.l RDMPYH
	sta.b r1+3
	tya
	sta.l WRMPYB
	rep #$20
	lda.b r2+1
	clc
	adc.l RDMPYL
	sta.b r2+1
	bcc .1
	inc.b r2+3
	clc
.1:									; add the partial products
	lda.b r1
	adc.b r2
	sta.b r2
	lda.b r1+2
	adc.b r2+2
	sta.b r2+2
	ply
	rtl
Div16S:								; r2 / r1 into r0, signed
	lda.b r1
	bmi .divneg
	lda.b r2
	bmi .dividendneg
	jmp.w Div16U
.divneg:							; divisor negative
	eor.w #$FFFF
	inc a
	sta.b r1
	lda.b r2
	bpl .negate
	lda.w #$0000
	sec
	sbc.b r2
	sta.b r2
	jmp.w Div16U
.dividendneg:						; dividend negative
	eor.w #$FFFF
	inc a
	sta.b r2
.negate:							; one of them negative: negate the quotient
	jsl.l Div16U
	lda.w #$0000
	sec
	sbc.b r0
	sta.b r0
	rtl
Div32x32U:							; r2 (4 bytes) / r1 (4 bytes) into r0, remainder in r2, unsigned
	phx
	phy
	stz.b r0
	stz.b r0+2
	ldy.w #$0000
	lda.b r1+2
	bmi .loop
.norm:								; shift the divisor up to bit 31
	iny
	asl.b r1
	rol.b r1+2
	bpl .norm
.loop:								; one quotient bit
	lda.b r2
	sec
	sbc.b r1
	tax
	lda.b r2+2
	sbc.b r1+2
	bcc .bit
	stx.b r2
	sta.b r2+2
.bit:								; the bit into r0
	rol.b r0
	rol.b r0+2
	lsr.b r1+2
	ror.b r1
	dey
	bpl .loop
	ply
	plx
	rtl
Div32S:								; r2 (4 bytes) / r1 into r0, signed; $7FFF if it does not fit
	lda.b r1
	bmi .divneg
	lda.b r2+2
	bmi .dividendneg
	jmp.w Div32U
.divneg:							; divisor negative
	eor.w #$FFFF
	inc a
	sta.b r1
	lda.b r2+2
	bpl .negate
	lda.w #$0000
	sec
	sbc.b r2
	sta.b r2
	lda.w #$0000
	sbc.b r2+2
	sta.b r2+2
	jmp.w Div32U
.dividendneg:						; dividend negative
	lda.w #$0000
	sec
	sbc.b r2
	sta.b r2
	lda.w #$0000
	sbc.b r2+2
	sta.b r2+2
.negate:							; one of them negative: negate the quotient
	jsl.l Div32U
	lda.w #$0000
	sec
	sbc.b r0
	sta.b r0
	rtl
Div32U:								; r2 (4 bytes) / r1 into r0, unsigned; $7FFF if it does not fit
	sep #$20
	lda.b r2+3
	beq .hi0
	cmp.b r1+1
	bcc .go
	jmp.w Div_Overflow
.go:								; 16 quotient bits
	rep #$20
	lda.b r2+2
	ldx.w #$0010
.loop:								; one quotient bit
	asl.b r2
	rol a
	bcs .sub
	cmp.b r1
	bcc .bit
.sub:								; subtract
	sbc.b r1
	sec
.bit:								; the bit into r0
	rol.b r0
	dex
	bne .loop
	rtl
	sep #$20
.hi0:								; top byte 0
	lda.b r1+1
	beq Div32U_ByteDivisor
	lda.b r2+2
	beq Div16U_Go
	cmp.b r1+1
	bcc Div_8Bits
	rep #$20
	lda.b r2+2
	and.w #$00FF
	ldx.w #$0010
.loop2:								; one quotient bit
	asl.b r2
	rol a
	bcs .sub2
	cmp.b r1
	bcc .bit2
.sub2:								; subtract
	sbc.b r1
	sec
.bit2:								; the bit into r0
	rol.b r0
	dex
	bne .loop2
	rtl
Div_8Bits:							; r2+1 (with r2) / r1 when the quotient fits in 8 bits
	stz.b r0
	rep #$20
	lda.b r2+1
	ldx.w #$0008
.loop:								; one quotient bit
	asl.b r1+3
	rol a
	bcs .sub
	cmp.b r1
	bcc .bit
.sub:								; subtract
	sbc.b r1
	sec
.bit:								; the bit into r0
	rol.b r0
	dex
	bne .loop
	rtl
Div16U:								; r2 / r1 into r0, unsigned
	sep #$20
Div16U_Go:							; entry used by the routines after it
	lda.b r1+1
	beq Div16x8U_Go
	stz.b r2+2
	lda.b r2+1
	cmp.b r1+1
	bcs Div_8Bits
	rep #$20
	stz.b r0
	rtl
Div_Overflow:						; quotient $7FFF
	rep #$20
	lda.w #$7FFF
	sta.b r0
	rtl
	sep #$20
Div32U_ByteDivisor:					; entry used by the routines after it
	lda.b r2+2
	beq Div16x8U_Go
	cmp.b r1
	bcs Div_Overflow
	lda.b r2+1
	sta.l WRDIVL
	lda.b r2+2
	sta.l WRDIVH
	lda.b r1
	sta.l WRDIVB
	phx
	plx
	xba
	lda.l RDDIVL
	sta.b r0+1
	lda.l RDMPYL
	sta.b r2+1
	lda.b r2
	sta.l WRDIVL
	lda.b r2+1
	sta.l WRDIVH
	lda.b r1
	sta.l WRDIVB
	phx
	plx
	xba
	lda.l RDDIVL
	sta.b r0
	rep #$20
	rtl
Div16x8U:							; r2 / r1 (8 bits) into r0 with the hardware divider; $7FFF when r1 is 0
	sep #$20
Div16x8U_Go:						; entry used by the routines after it
	lda.b r2+1
	sta.l WRDIVH
	xba
	lda.b r2
	sta.l WRDIVL
	tax
	lda.b r1
	beq Div_Overflow
	sta.l WRDIVB
	rep #$20
	phx
	plx
	lda.l RDDIVL
	sta.b r0
	rtl
DivX8U:								; X / A (8 bits) into A with the hardware divider
	pha
	txa
	sta.l WRDIVL
	pla
	sep #$20
	sta.l WRDIVB
	rep #$20
	phx
	plx
	lda.l RDDIVL
	rtl
DivX8S:								; X / A (8 bits) into A, X signed
	cpx.w #$0000
	bpl DivX8U
	phy
	tay
	txa
	eor.w #$FFFF
	inc a
	sta.l WRDIVL
	sep #$20
	tya
	sta.l WRDIVB
	rep #$20
	ply
	lda.w #$0000
	sec
	sbc.l RDDIVL
	rtl
CODE_C092B3:						; called from $C50087; the first game routine after the math
	lda.w #$0001
	sta.w $189C
	lda.w $186E
	pha
	stz.w $186E
	lda.w $186C
	pha
	stz.w $186C
	jsl.l CODE_C54E27
	jsl.l CODE_C52CA3
	jsl.l CODE_C53980
	stz.b $6B
	jsr.w CODE_C09681
	lda.w #$0002
	sta.b $6B
	jsr.w CODE_C09681
	jsl.l CODE_C5009B
	jsl.l CODE_C5016D
	lda.w #$0001
	sta.w $18A0
	stz.b $83
CODE_C092F0:						; from CODE_C0930C
	stz.w $18A4
	lda.w #$0002
	sta.b $6B
	stz.b $67
	jsl.l CODE_C09336
	lda.w $18A0
	cmp.w #$0005
	bmi CODE_C0930C
	lda.w #$0001
	sta.w $18A4
CODE_C0930C:						; from CODE_C092F0
	stz.b $6B
	lda.w #$0002
	sta.b $67
	jsl.l CODE_C09336
	inc.w $18A0
	lda.w $18A0
	cmp.w #$0006
	bmi CODE_C092F0
	lda.w $12AB
	cmp.w $12AD
	beq CODE_C092F0
	stz.w $189C
	pla
	sta.w $186C
	pla
	sta.w $186E
	rtl
CODE_C09336:						; called from CODE_C092F0, CODE_C0930C
	stz.w $189E
	stz.w $18A2
	pei ($6B)
	jsl.l $C4818C
	stz.w $10F1
	lda.b $6B
	beq CODE_C0934F
	lda.w #$0002
	sta.w $10F1
CODE_C0934F:						; from CODE_C09336
	jsl.l CODE_C5016D
	pla
	sta.b $6B
	stz.w $18B0
	lda.b $6B
	beq CODE_C09363
	lda.w #$000C
	sta.w $18B0
CODE_C09363:						; from CODE_C0934F
	ldy.w #$0000
CODE_C09366:						; loop
	lda.w $1525,y
	cmp.b $6B
	beq CODE_C0937C
	iny
	iny
	cpy.w #$000A
	bcc CODE_C09366
	lda.w #$FFFF
	sta.w $18B6
	bra CODE_C0937F
CODE_C0937C:						; from CODE_C09366
	sty.w $18B6
CODE_C0937F:						; from CODE_C09366
	jsl.l $C4866D
	lda.b $6B
	beq CODE_C093B2
	lda.w $18A0
CODE_C0938A:						; loop
	cmp.w #$0006
	bmi CODE_C09395
	sec
	sbc.w #$0005
	bra CODE_C0938A
CODE_C09395:						; from CODE_C0938A
	tay
	sep #$20
	lda.w $1894,y
	rep #$20
	and.w #$00FF
	dec a
	sta.w $18B2
	lda.w #$000C
	sta.w $18B0
	lda.w #$0002
	sta.w $18B4
	bra CODE_C093D8
CODE_C093B2:						; from CODE_C0937F
	lda.w $18A0
CODE_C093B5:						; loop
	cmp.w #$0006
	bmi CODE_C093C0
	sec
	sbc.w #$0005
	bra CODE_C093B5
CODE_C093C0:						; from CODE_C093B5
	tay
	sep #$20
	lda.w $188C,y
	rep #$20
	and.w #$00FF
	dec a
	sta.w $18B2
	lda.w #$0000
	sta.w $18B0
	stz.w $18B4
CODE_C093D8:						; from CODE_C09395
	jsl.l CODE_C5021B
	rtl
CODE_C093DD:						; called from $C442A1, $C486EB, $C50AD9
	jmp.w CODE_C09465
	lda.w $189C
	bne CODE_C093E8
	jmp.w CODE_C09465
CODE_C093E8:						; from CODE_C093DD
	lda.w #$000A
	sta.b $7F
	lda.w $18A4
	bne CODE_C093F5
	jmp.w CODE_C09465
CODE_C093F5:						; from CODE_C093E8
	lda.w $12AB
	sec
	sbc.w $12AD
	bne CODE_C09401
	jmp.w CODE_C09465
CODE_C09401:						; from CODE_C093F5
	phx
	phy
	pei ($83)
	pei ($67)
	lda.w $12AB
	sec
	sbc.w $12AD
	bmi CODE_C09415
	ldy.w #$0000
	bra CODE_C09418
CODE_C09415:						; from CODE_C09401
	ldy.w #$0002
CODE_C09418:						; from CODE_C09401
	phy
	brk #$00						; a brk in the ROM
	lda.w $17C9,y
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l $C4C3BA
	jsl.l CODE_C099F4
	phx
	ldx.w #$0010
	ldy.w #$0004
	lda.w #$5850
	jsl.l CODE_C58C36
	pla
	ldx.w #$007E
	ldy.w #$5871
	jsl.l QueueVRAMDMALen
	lda.w #$5F17
	ldx.w #$00C3
	ldy.w #$5891
	jsl.l QueueVRAMDMALen
	pla
	sta.b $67
	pla
	sta.b $83
	ply
	plx
	lda.w #$0010
	sta.b $7F
CODE_C09465:						; from CODE_C093DD, CODE_C093E8, CODE_C093F5
	jml.l $C478C3
	jsl.l CODE_C53ABC
	lda.w #$0001
	sta.b $7F
	lda.b $6B
	beq CODE_C0947B
	lda.w #$0002
	sta.b $7F
CODE_C0947B:						; from CODE_C09465
	lda.w $17B5
	cmp.b $7F
	beq CODE_C0948C
	lda.w $17B7
	cmp.b $7F
	beq CODE_C0948C
	jmp.w CODE_C094E4
CODE_C0948C:						; from CODE_C0947B
	ldx.b $6B
	lda.w $17C9,x
	sta.w $2352
	lda.w #$FFFF
	sta.w $2350
	jsl.l CODE_C09529
	jsl.l CODE_C0958F
	stz.w $1878
	lda.w #$0001
	sta.w $0802
	stz.w $0806
	jsl.l CODE_C095BF
	lda.w #$0005
	ldx.w #$0050
	jsl.l ScreenOn
CODE_C094BC:						; from CODE_C094E2
	jsl.l WaitFrame
	jsl.l $C36CBF
	jsl.l $C370A5
	jsl.l $C370B2
	lda.b $83
	bit.w #$0800
	bne CODE_C09500
	bit.w #$0400
	bne CODE_C0950E
	bit.w #$8080
	bne CODE_C0951F
	bit.w #$1000
	bne CODE_C094E4
CODE_C094E2:						; from CODE_C09500, CODE_C0950E, CODE_C0951F
	bra CODE_C094BC
CODE_C094E4:						; from CODE_C0947B, CODE_C094BC
	ldy.b $6B
	bne CODE_C094F1
	sep #$20
	lda.w $188C
	rep #$20
	bra CODE_C094F8
CODE_C094F1:						; from CODE_C094E4
	sep #$20
	lda.w $1894
	rep #$20
CODE_C094F8:						; from CODE_C094E4
	and.w #$00FF
	dec a
	sta.w $12CB,y
	rtl
CODE_C09500:						; from CODE_C094BC
	lda.w $1878
	beq CODE_C094E2
	dec.w $1878
	jsl.l CODE_C095BF
	bra CODE_C094E2
CODE_C0950E:						; from CODE_C094BC
	lda.w $1878
	cmp.w #$0005
	bpl CODE_C094E2
	inc.w $1878
	jsl.l CODE_C095BF
	bra CODE_C094E2
CODE_C0951F:						; from CODE_C094BC
	jsl.l CODE_C096C0
	jsl.l CODE_C095BF
	bra CODE_C094E2
CODE_C09529:						; called from CODE_C0948C
	lda.w #$0020
	sta.b $7F
	lda.w #$000D
	sta.b $83
	lda.w $24C0
	sta.b $87
	jsl.l CODE_C528D4
	lda.w #$0800
	sta.w $07D2
	lda.w #$000E
	sta.b $7F
	lda.w #$0003
	sta.b $83
	jsl.l CODE_C0958F
	rtl
CODE_C09551:						; called from CODE_C0958F
	lda.w #$0020
	sta.b $7F
	lda.w #$000D
	sta.b $83
	lda.w $24C0
	sta.b $87
	jsl.l CODE_C528D4
	lda.w #$0800
	sta.w $07D2
	lda.w #$000E
	sta.b $7F
	lda.w #$0003
	sta.b $83
	lda.w #$007F
	sta.b $3A
	stz.b $38
	lda.w #$0020
	lda.w #$001C
	ldx.w #$0000
	ldy.w #$0000
	lda.w $249C
	clc
	adc.w #$0C00
	rtl
CODE_C0958F:						; called from CODE_C0948C, CODE_C09529, CODE_C09678
	lda.w $2364
	beq CODE_C09598
	jsl.l CODE_C09551
CODE_C09598:						; from CODE_C0958F
	ldx.w #$0058
	ldy.w #$0018
	lda.w $17C9
	sta.b $83
	lda.b $6B
	beq CODE_C095AC
	lda.w $17CB
	sta.b $83
CODE_C095AC:						; from CODE_C09598
	lda.w $2364
	beq CODE_C095BE
	jsl.l WaitFrame
	lda.w #$0050
	sta.w $04CB
	stz.w $2364
CODE_C095BE:						; from CODE_C095AC
	rtl
CODE_C095BF:						; called from CODE_C0948C, CODE_C09500, CODE_C0950E, CODE_C0951F
	lda.w #$0020
	sta.b $7F
	lda.w #$0013
	sta.b $83
	lda.w $24C0
	sta.b $87
	jsl.l CODE_C528D4
	jsl.l $C48A41
	lda.b $7F
	dec a
	sta.b $83
	lda.w #CODE_C09681>>16
	sta.b $79
	lda.w #CODE_C09681
	sta.b $77
	lda.w #$00C0
	sta.b $71
	lda.w #$967D
	sta.b $6F
	lda.w $0802
	dec a
	sta.b $7F
	bmi CODE_C09623
	asl a
	asl a
	asl a
	sta.b $7F
	lda.w #$0000
	sta.b $71
	lda.w #$188C
	sta.b $6F
	lda.b $6B
	beq CODE_C09614
	lda.w #$0000
	sta.b $71
	lda.w #$1894
	sta.b $6F
CODE_C09614:						; from CODE_C095BF
	lda.w #CODE_C09681>>16
	sta.b $79
	lda.w #CODE_C09681
	sta.b $77
	lda.w #$0005
	sta.b $83
CODE_C09623:						; from CODE_C095BF, CODE_C09655
	lda.w #$3800
	sta.w $07D2
	lda.w #$0005
	sec
	sbc.b $83
	cmp.w $1878
	bne CODE_C09655
	lda.w #$2000
	sta.w $07D2
	lda.b [$6F]
	and.w #$00FF
	dec a
	sta.w $2358
	phx
	ldx.b $6B
	lda.w $17C9,x
	cmp.w #$0018
	bcc CODE_C09654
	ldx.w #$0000
	lda.w $2358
CODE_C09654:						; from CODE_C09623
	plx
CODE_C09655:						; from CODE_C09623
	lda.w #$0005
	sta.w $07D4
	lda.w #$0008
	sta.w $07D4
	lda.b [$6F]
	and.w #$00FF
	dec a
	sta.b $7F
	inc.b $6F
	inc.w $07D6
	inc.w $07D6
	dec.b $83
	bmi CODE_C09678
	jmp.w CODE_C09623
CODE_C09678:						; from CODE_C09655
	jsl.l CODE_C0958F
	rtl
DATA8_C0967D:						; not traced: 1, 2, 3, 4
	db $01,$02,$03,$04
CODE_C09681:						; from CODE_C092B3; its address is stored as a long pointer
	lda.w #$0000
	sta.b $71
	lda.w #$188C
	sta.b $6F
	lda.w #$2E35
	sta.b $67
	lda.b $6B
	beq CODE_C096A3
	lda.w #$0000
	sta.b $71
	lda.w #$1894
	sta.b $6F
	lda.w #$3273
	sta.b $67
CODE_C096A3:						; from CODE_C09681
	ldy.b $6B
	lda.w #$007E
	sta.b $69
	lda.w #$0007
	sta.b $7F
CODE_C096AF:						; loop
	sep #$20
	lda.b [$67]
	sta.b [$6F]
	rep #$20
	inc.b $67
	inc.b $6F
	dec.b $7F
	bpl CODE_C096AF
	rts
CODE_C096C0:						; called from CODE_C0951F
	lda.w $1878
	bne CODE_C096F7
	jsl.l $C48A41
	lda.w #$0000
	sta.b $69
	lda.w #$188C
	sta.b $67
	lda.b $6B
	beq CODE_C096E1
	lda.w #$0000
	sta.b $69
	lda.w #$1894
	sta.b $67
CODE_C096E1:						; from CODE_C096C0
	lda.b [$67]
	and.w #$00FF
	inc a
	cmp.b $7F
	beq CODE_C096F0
	bmi CODE_C096F0
	lda.w #$0001
CODE_C096F0:						; from CODE_C096E1
	sep #$20
	sta.b [$67]
	rep #$20
	rtl
CODE_C096F7:						; from CODE_C096C0
	lda.w #$0020
	sta.b $7F
	lda.w #$000D
	sta.b $83
	lda.w $24C0
	sta.b $87
	jsl.l CODE_C528D4
	ldx.w #$0001
	ldy.w #$0001
	lda.w $249C
	clc
	adc.w #$0C00
	jsl.l WaitFrame
	lda.w #$0007
	sta.w $04CB
	jsl.l CODE_C5362E
	lda.b $7F
	sta.w $187C
	jsl.l $C48A41
	lda.w $187C
	sec
	sbc.b $7F
	sta.w $187C
	lda.b $7F
	sta.w $1880
	lda.b $7F
	sta.w $1884
	lda.w #$0000
	sta.b $71
	lda.w #$188C
	sta.b $6F
	lda.b $6B
	beq CODE_C09759
	lda.w #$0000
	sta.b $71
	lda.w #$1894
	sta.b $6F
CODE_C09759:						; from CODE_C096F7
	lda.b $6F
	clc
	adc.w $1878
	sta.b $6F
	lda.b [$6F]
	and.w #$00FF
	dec a
	sta.w $1888
	lda.w #$0008
	clc
	adc.w $1884
	sec
	sbc.w $1888
	bpl CODE_C09790
	lda.w $1888
	sec
	sbc.w #$0008
	sec
	sbc.w $1884
	bmi CODE_C0978B
	clc
	adc.w $1884
	sta.w $1884
CODE_C0978B:						; from CODE_C09759
	lda.w #$0000
	bra CODE_C0979B
CODE_C09790:						; from CODE_C09759
	lda.w $1884
	clc
	adc.w #$0008
	sec
	sbc.w $1888
CODE_C0979B:						; from CODE_C0978B
	sta.w $1888
	jsl.l CODE_C09855
CODE_C097A2:						; from CODE_C097DD, CODE_C097EF, CODE_C097FF, CODE_C0980F, ...
	jsl.l WaitFrame
	jsl.l $C36CBF
	jsl.l $C370A5
	jsl.l $C370B2
	lda.b $83
	bit.w #$1000
	bne CODE_C097D6
	bit.w #$0800
	bne CODE_C0980F
	bit.w #$0400
	bne CODE_C097FF
	bit.w #$0100
	bne CODE_C097DD
	bit.w #$0200
	bne CODE_C097EF
	bit.w #$8080
	beq CODE_C097A2
	jsl.l CODE_C0998F
CODE_C097D6:						; from CODE_C097A2
	lda.w #$0001
	sta.w $2364
	rtl
CODE_C097DD:						; from CODE_C097A2
	lda.w $0806
	inc a
	cmp.w #$0010
	bpl CODE_C097A2
	sta.w $0806
	jsl.l CODE_C09855
	bra CODE_C097A2
CODE_C097EF:						; from CODE_C097A2
	lda.w $0806
	dec a
	bmi CODE_C097A2
	sta.w $0806
	jsl.l CODE_C09855
	jmp.w CODE_C097A2
CODE_C097FF:						; from CODE_C097A2
	lda.w $1888
	dec a
	bmi CODE_C09822
	sta.w $1888
	jsl.l CODE_C09855
	jmp.w CODE_C097A2
CODE_C0980F:						; from CODE_C097A2
	lda.w $1888
	inc a
	cmp.w #$0009
	bpl CODE_C0983F
	sta.w $1888
	jsl.l CODE_C09855
	jmp.w CODE_C097A2
CODE_C09822:						; from CODE_C097FF
	lda.w $1884
	sec
	sbc.w $1880
	clc
	adc.w #$0009
	cmp.w $187C
	bmi CODE_C09835
	jmp.w CODE_C097A2
CODE_C09835:						; from CODE_C09822
	inc.w $1884
	jsl.l CODE_C09855
	jmp.w CODE_C097A2
CODE_C0983F:						; from CODE_C0980F
	lda.w $1884
	dec a
	cmp.w $1880
	bpl CODE_C0984B
	jmp.w CODE_C097A2
CODE_C0984B:						; from CODE_C0983F
	dec.w $1884
	jsl.l CODE_C09855
	jmp.w CODE_C097A2
CODE_C09855:						; called from CODE_C0979B, CODE_C097DD, CODE_C097EF, CODE_C097FF, ...
	lda.w #$0020
	sta.b $7F
	lda.w #$000D
	sta.b $83
	lda.w $24C0
	sta.b $87
	jsl.l CODE_C528D4
	lda.w #$0011
	sta.w $07D4
	lda.w #$0002
	sta.w $07D6
CODE_C09874:						; from CODE_C09897
	lda.w #DATA8_C098CE>>16
	sta.b $69
	lda.w #DATA8_C098CE
	sta.b $67
	lda.w $0806
	sta.b $7F
	bra CODE_C0988F
CODE_C09885:						; from CODE_C0988F
	lda.b $67
	clc
	adc.b [$67]
	adc.w #$0004
	sta.b $67
CODE_C0988F:						; from CODE_C09874
	lda.b [$67]
	bmi CODE_C09897
	dec.b $7F
	bpl CODE_C09885
CODE_C09897:						; from CODE_C0988F
	lda.b [$67]
	bpl CODE_C098A0
	dec.w $0806
	bra CODE_C09874
CODE_C098A0:						; from CODE_C09897
	lda.w #$3800
	sta.w $07D2
	lda.b [$67]
	sta.b $91
	ldy.w #$0002
	lda.b [$67],y
	sta.b $8F
	lda.w $1884
	cmp.w $1880
	beq CODE_C098B9
CODE_C098B9:						; from CODE_C098A0
	lda.w $1884
	sec
	sbc.w $1880
	clc
	adc.w #$0009
	cmp.w $187C
	bpl CODE_C098C9
CODE_C098C9:						; from CODE_C098B9
	jsl.l CODE_C09910
	rtl
DATA8_C098CE:						; not traced: records CODE_C09855 walks, $FFFF ends them
	incbin "../Extracted/segments/bankC0_9000.bin":$8CE..$910
CODE_C09910:						; called from CODE_C098C9
	lda.w $0802
	dec a
	asl a
	asl a
	asl a
	sta.b $7F
	ldy.b $6B
	lda.w $1884
	inc a
	sta.b $6F
	lda.w #DATA8_C09BC4>>16
	sta.b $79
	lda.w #DATA8_C09BC4
	sta.b $77
	lda.w #$0008
	sta.b $83
	lda.w $0802
	sec
	sbc.w #$0005
	beq CODE_C09943
	bmi CODE_C0993F
	bvc CODE_C09941
	bra CODE_C09943
CODE_C0993F:						; from CODE_C09910
	bvc CODE_C09943
CODE_C09941:						; from CODE_C09910
	dec.b $83
CODE_C09943:						; from CODE_C09910, CODE_C0993F, CODE_C09977
	lda.w #$3800
	sta.w $07D2
	lda.b $83
	cmp.w $1888
	bne CODE_C09956
	lda.w #$2000
	sta.w $07D2
CODE_C09956:						; from CODE_C09943
	lda.w #$0002
	sta.w $07D4
	lda.b $6F
	and.w #$00FF
	dec a
	sta.b $7F
	sta.b r1
	stz.b r2
	jsl.l $C48A41
	lda.b r1
	cmp.b $7F
	bpl CODE_C09977
	lda.w #$0010
	sta.b r2
CODE_C09977:						; from CODE_C09956
	lda.b r1
	sta.b $7F
	jsl.l CODE_C50F08
	inc.b $6F
	inc.w $07D6
	dec.b $83
	bpl CODE_C09943
	lda.w #$2000
	sta.w $07D2
	rtl
CODE_C0998F:						; called from CODE_C097A2
	ldy.b $83
	phy
	lda.w #$0009
	sec
	sbc.w $1888
	clc
	adc.w $1884
	and.w #$00FF
	sta.b $7F
	lda.w #$0000
	sta.b $69
	lda.w #$188C
	sta.b $67
	lda.b $6B
	beq CODE_C099BA
	lda.w #$0000
	sta.b $69
	lda.w #$1894
	sta.b $67
CODE_C099BA:						; from CODE_C0998F
	ldy.w $1878
	sep #$20
	lda.b [$67],y
	rep #$20
	and.w #$00FF
	sta.b $83
	lda.b $7F
	ldy.w #$0001
CODE_C099CD:						; loop
	sep #$20
	cmp.b [$67],y
	rep #$20
	beq CODE_C099DD
	iny
	cpy.w #$0007
	bmi CODE_C099CD
	bra CODE_C099E5
CODE_C099DD:						; from CODE_C099CD
	lda.b $83
	sep #$20
	sta.b [$67],y
	rep #$20
CODE_C099E5:						; from CODE_C099CD
	ldy.w $1878
	lda.b $7F
	sep #$20
	sta.b [$67],y
	rep #$20
	pla
	sta.b $83
	rtl
CODE_C099F4:						; called from CODE_C09418
	phy
	phx
	sep #$20
	ldy.w #$0000
	dex
CODE_C099FC:						; loop
	iny
	inx
	lda.w $0000,x
	bne CODE_C099FC
	rep #$20
	tya
	jsl.l $C4C561
	tax
	tya
	sta.w $0000,x
	ply
	pha
	sep #$20
CODE_C09A13:						; loop
	lda.w $0000,y
	sta.w $0001,x
	beq CODE_C09A1F
	iny
	inx
	bra CODE_C09A13
CODE_C09A1F:						; from CODE_C09A13
	rep #$20
	plx
	ply
	rtl

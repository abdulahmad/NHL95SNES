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
CODE_C092B3:						; called from CODE_C50056; the first game routine after the math
	lda.w #$0001
	sta.w $189C
	lda.w $186E
	pha
	stz.w $186E
	lda.w $186C
	pha
	stz.w $186C
	jsl.l Create_HotCold_Table
	jsl.l CODE_C52CA3
	jsl.l CODE_C53980
	stz.b a2
	jsr.w CODE_C09681
	lda.w #$0002
	sta.b a2
	jsr.w CODE_C09681
	jsl.l CODE_C5009B
	jsl.l CODE_C5016D
	lda.w #$0001
	sta.w $18A0
	stz.b d1
.loop:								; loop: $18A4 = 0, a2 = $0002, a1 = 0, call CODE_C09336, ...
	stz.w $18A4
	lda.w #$0002
	sta.b a2
	stz.b a1
	jsl.l CODE_C09336
	lda.w $18A0
	cmp.w #$0005
	bmi .1
	lda.w #$0001
	sta.w $18A4
.1:									; a2 = 0, a1 = $0002, call CODE_C09336, $18A0 + 1, ...
	stz.b a2
	lda.w #$0002
	sta.b a1
	jsl.l CODE_C09336
	inc.w $18A0
	lda.w $18A0
	cmp.w #$0006
	bmi .loop
	lda.w tmscore
	cmp.w $12AD
	beq .loop
	stz.w $189C
	pla
	sta.w $186C
	pla
	sta.w $186E
	rtl
CODE_C09336:						; called from CODE_C092B3
	stz.w $189E
	stz.w $18A2
	pei ($6B)
	jsl.l CODE_C4818C
	stz.w gmode
	lda.b a2
	beq .1
	lda.w #$0002
	sta.w gmode
.1:									; call CODE_C5016D, pull A, a2 = A, BA_Sktr_SCnum = 0, ...
	jsl.l CODE_C5016D
	pla
	sta.b a2
	stz.w BA_Sktr_SCnum
	lda.b a2
	beq .2
	lda.w #$000C
	sta.w BA_Sktr_SCnum
.2:									; Y = $0000
	ldy.w #$0000
.loop:								; loop: A = $1525,y, if A = a2 go to .3, Y + 1, Y + 1, ...
	lda.w $1525,y
	cmp.b a2
	beq .3
	iny
	iny
	cpy.w #$000A
	bcc .loop
	lda.w #$FFFF
	sta.w $18B6
	bra .4
.3:									; $18B6 = Y
	sty.w $18B6
.4:									; call StartPenaltyShot, if a2 = 0 go to .6, A = $18A0
	jsl.l StartPenaltyShot
	lda.b a2
	beq .6
	lda.w $18A0
.loop2:								; loop: if minus go to .5, A - $0005, go to .loop2
	cmp.w #$0006
	bmi .5
	sec
	sbc.w #$0005
	bra .loop2
.5:									; Y = A, A 8-bit, A = $1894,y, A 16-bit, ...
	tay
	sep #$20
	lda.w $1894,y
	rep #$20
	and.w #$00FF
	dec a
	sta.w $18B2
	lda.w #$000C
	sta.w BA_Sktr_SCnum
	lda.w #$0002
	sta.w BA_Team
	bra .8
.6:									; A = $18A0
	lda.w $18A0
.loop3:								; loop: if minus go to .7, A - $0005, go to .loop3
	cmp.w #$0006
	bmi .7
	sec
	sbc.w #$0005
	bra .loop3
.7:									; Y = A, A 8-bit, A = $188C,y, A 16-bit, ...
	tay
	sep #$20
	lda.w $188C,y
	rep #$20
	and.w #$00FF
	dec a
	sta.w $18B2
	lda.w #$0000
	sta.w BA_Sktr_SCnum
	stz.w BA_Team
.8:									; call CODE_C5021B, return
	jsl.l CODE_C5021B
	rtl
ShootoutWonBy:						; jumps to its end at once: the shootout check after it is not reached
	jmp.w .6
	lda.w $189C
	bne .1
	jmp.w .6
.1:									; d0 = $000A, if $18A4 is not 0 go to .2, go to .6
	lda.w #$000A
	sta.b d0
	lda.w $18A4
	bne .2
	jmp.w .6
.2:									; A = tmscore, A - $12AD, if the result is not 0 go to .3, go to .6
	lda.w tmscore
	sec
	sbc.w $12AD
	bne .3
	jmp.w .6
.3:									; push X, push Y, A = tmscore, A - $12AD, ...
	phx
	phy
	pei ($83)
	pei ($67)
	lda.w tmscore
	sec
	sbc.w $12AD
	bmi .4
	ldy.w #$0000
	bra .5
.4:									; Y = $0002
	ldy.w #$0002
.5:									; push Y, A = $17C9,y, A * 2, X = A, ...
	phy
	brk #$00						; a brk in the ROM
	lda.w $17C9,y
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l CODE_C4C3BA
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
	sta.b a1
	pla
	sta.b d1
	ply
	plx
	lda.w #$0010
	sta.b d0
.6:									; go to AddPenalty2
	jml.l AddPenalty2
	jsl.l CODE_C53ABC
	lda.w #$0001
	sta.b d0
	lda.b a2
	beq .7
	lda.w #$0002
	sta.b d0
.7:									; A = cont1team, if A = d0 go to .8, A = $17B7, if A = d0 go to .8, ...
	lda.w cont1team
	cmp.b d0
	beq .8
	lda.w $17B7
	cmp.b d0
	beq .8
	jmp.w .10
.8:									; X = a2, $2352 = $17C9,x, $2350 = $FFFF, call CODE_C09529, ...
	ldx.b a2
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
.loop:								; loop: call WaitFrame, call CODE_C36CBF, call CODE_C370A5, ...
	jsl.l WaitFrame
	jsl.l CODE_C36CBF
	jsl.l CODE_C370A5
	jsl.l ProcessInputWithRepeat
	lda.b d1
	bit.w #$0800
	bne .13
	bit.w #$0400
	bne .14
	bit.w #$8080
	bne .15
	bit.w #$1000
	bne .10
.9:									; go to .loop
	bra .loop
.10:								; if a2 is not 0 go to .11, A 8-bit, A = $188C, A 16-bit, ...
	ldy.b a2
	bne .11
	sep #$20
	lda.w $188C
	rep #$20
	bra .12
.11:								; A 8-bit, A = $1894, A 16-bit
	sep #$20
	lda.w $1894
	rep #$20
.12:								; A and $00FF, A - 1, tmgoalie,y = A, return
	and.w #$00FF
	dec a
	sta.w tmgoalie,y
	rtl
.13:								; if $1878 = 0 go to .9, $1878 - 1, call CODE_C095BF, go to .9
	lda.w $1878
	beq .9
	dec.w $1878
	jsl.l CODE_C095BF
	bra .9
.14:								; A = $1878, if plus go to .9, $1878 + 1, call CODE_C095BF, ...
	lda.w $1878
	cmp.w #$0005
	bpl .9
	inc.w $1878
	jsl.l CODE_C095BF
	bra .9
.15:								; call CODE_C096C0, call CODE_C095BF, go to .9
	jsl.l CODE_C096C0
	jsl.l CODE_C095BF
	bra .9
CODE_C09529:						; called from ShootoutWonBy
	lda.w #$0020
	sta.b d0
	lda.w #$000D
	sta.b d1
	lda.w $24C0
	sta.b d2
	jsl.l CODE_C528D4
	lda.w #$0800
	sta.w $07D2
	lda.w #$000E
	sta.b d0
	lda.w #$0003
	sta.b d1
	jsl.l CODE_C0958F
	rtl
CODE_C09551:						; called from CODE_C0958F
	lda.w #$0020
	sta.b d0
	lda.w #$000D
	sta.b d1
	lda.w $24C0
	sta.b d2
	jsl.l CODE_C528D4
	lda.w #$0800
	sta.w $07D2
	lda.w #$000E
	sta.b d0
	lda.w #$0003
	sta.b d1
	lda.w #$007F
	sta.b $3A
	stz.b p0
	lda.w #$0020
	lda.w #$001C
	ldx.w #$0000
	ldy.w #$0000
	lda.w $249C
	clc
	adc.w #$0C00
	rtl
CODE_C0958F:						; called from ShootoutWonBy, CODE_C09529, CODE_C095BF
	lda.w $2364
	beq .1
	jsl.l CODE_C09551
.1:									; X = $0058, Y = $0018, d1 = $17C9, if a2 = 0 go to .2, ...
	ldx.w #$0058
	ldy.w #$0018
	lda.w $17C9
	sta.b d1
	lda.b a2
	beq .2
	lda.w $17CB
	sta.b d1
.2:									; if $2364 = 0 go to .rtl, call WaitFrame, irqline2 = $0050, $2364 = 0
	lda.w $2364
	beq .rtl
	jsl.l WaitFrame
	lda.w #$0050
	sta.w irqline2
	stz.w $2364
.rtl:								; return
	rtl
CODE_C095BF:						; called from ShootoutWonBy
	lda.w #$0020
	sta.b d0
	lda.w #$0013
	sta.b d1
	lda.w $24C0
	sta.b d2
	jsl.l CODE_C528D4
	jsl.l CODE_C48A41
	lda.b d0
	dec a
	sta.b d1
	lda.w #CODE_C09681>>16
	sta.b $79
	lda.w #CODE_C09681
	sta.b $77
	lda.w #$00C0
	sta.b $71
	lda.w #$967D
	sta.b a3
	lda.w $0802
	dec a
	sta.b d0
	bmi .loop
	asl a
	asl a
	asl a
	sta.b d0
	lda.w #$0000
	sta.b $71
	lda.w #$188C
	sta.b a3
	lda.b a2
	beq .1
	lda.w #$0000
	sta.b $71
	lda.w #$1894
	sta.b a3
.1:									; $79 = CODE_C09681>>16, $77 = CODE_C09681, d1 = $0005
	lda.w #CODE_C09681>>16
	sta.b $79
	lda.w #CODE_C09681
	sta.b $77
	lda.w #$0005
	sta.b d1
.loop:								; loop: $07D2 = $3800, A = $0005, A - d1, if A is not $1878 go to .3, ...
	lda.w #$3800
	sta.w $07D2
	lda.w #$0005
	sec
	sbc.b d1
	cmp.w $1878
	bne .3
	lda.w #$2000
	sta.w $07D2
	lda.b [a3]
	and.w #$00FF
	dec a
	sta.w $2358
	phx
	ldx.b a2
	lda.w $17C9,x
	cmp.w #$0018
	bcc .2
	ldx.w #$0000
	lda.w $2358
.2:									; pull X
	plx
.3:									; $07D4 = $0005, $07D4 = $0008, A = [a3], A and $00FF, ...
	lda.w #$0005
	sta.w $07D4
	lda.w #$0008
	sta.w $07D4
	lda.b [a3]
	and.w #$00FF
	dec a
	sta.b d0
	inc.b a3
	inc.w $07D6
	inc.w $07D6
	dec.b d1
	bmi .4
	jmp.w .loop
.4:									; call CODE_C0958F, return
	jsl.l CODE_C0958F
	rtl
DATA8_C0967D:						; not traced: 1, 2, 3, 4
	db $01,$02,$03,$04
CODE_C09681:						; from CODE_C092B3; its address is stored as a long pointer
	lda.w #$0000
	sta.b $71
	lda.w #$188C
	sta.b a3
	lda.w #$2E35
	sta.b a1
	lda.b a2
	beq .1
	lda.w #$0000
	sta.b $71
	lda.w #$1894
	sta.b a3
	lda.w #$3273
	sta.b a1
.1:									; Y = a2, $69 = $007E, d0 = $0007
	ldy.b a2
	lda.w #$007E
	sta.b $69
	lda.w #$0007
	sta.b d0
.loop:								; loop: A 8-bit, [a3] = [a1], A 16-bit, a1 + 1, ...
	sep #$20
	lda.b [a1]
	sta.b [a3]
	rep #$20
	inc.b a1
	inc.b a3
	dec.b d0
	bpl .loop
	rts
CODE_C096C0:						; called from ShootoutWonBy
	lda.w $1878
	bne .3
	jsl.l CODE_C48A41
	lda.w #$0000
	sta.b $69
	lda.w #$188C
	sta.b a1
	lda.b a2
	beq .1
	lda.w #$0000
	sta.b $69
	lda.w #$1894
	sta.b a1
.1:									; A = [a1], A and $00FF, A + 1, if A = d0 go to .2, ...
	lda.b [a1]
	and.w #$00FF
	inc a
	cmp.b d0
	beq .2
	bmi .2
	lda.w #$0001
.2:									; A 8-bit, [a1] = A, A 16-bit, return
	sep #$20
	sta.b [a1]
	rep #$20
	rtl
.3:									; d0 = $0020, d1 = $000D, d2 = $24C0, call CODE_C528D4, ...
	lda.w #$0020
	sta.b d0
	lda.w #$000D
	sta.b d1
	lda.w $24C0
	sta.b d2
	jsl.l CODE_C528D4
	ldx.w #$0001
	ldy.w #$0001
	lda.w $249C
	clc
	adc.w #$0C00
	jsl.l WaitFrame
	lda.w #$0007
	sta.w irqline2
	jsl.l CODE_C5362E
	lda.b d0
	sta.w $187C
	jsl.l CODE_C48A41
	lda.w $187C
	sec
	sbc.b d0
	sta.w $187C
	lda.b d0
	sta.w $1880
	lda.b d0
	sta.w $1884
	lda.w #$0000
	sta.b $71
	lda.w #$188C
	sta.b a3
	lda.b a2
	beq .4
	lda.w #$0000
	sta.b $71
	lda.w #$1894
	sta.b a3
.4:									; A = a3, A + $1878, a3 = A, A = [a3], ...
	lda.b a3
	clc
	adc.w $1878
	sta.b a3
	lda.b [a3]
	and.w #$00FF
	dec a
	sta.w $1888
	lda.w #$0008
	clc
	adc.w $1884
	sec
	sbc.w $1888
	bpl .6
	lda.w $1888
	sec
	sbc.w #$0008
	sec
	sbc.w $1884
	bmi .5
	clc
	adc.w $1884
	sta.w $1884
.5:									; A = $0000, go to .7
	lda.w #$0000
	bra .7
.6:									; A = $1884, A + $0008, A - $1888
	lda.w $1884
	clc
	adc.w #$0008
	sec
	sbc.w $1888
.7:									; $1888 = A, call CODE_C09855
	sta.w $1888
	jsl.l CODE_C09855
.loop:								; loop: call WaitFrame, call CODE_C36CBF, call CODE_C370A5, ...
	jsl.l WaitFrame
	jsl.l CODE_C36CBF
	jsl.l CODE_C370A5
	jsl.l ProcessInputWithRepeat
	lda.b d1
	bit.w #$1000
	bne .8
	bit.w #$0800
	bne .12
	bit.w #$0400
	bne .11
	bit.w #$0100
	bne .9
	bit.w #$0200
	bne .10
	bit.w #$8080
	beq .loop
	jsl.l CODE_C0998F
.8:									; $2364 = $0001, return
	lda.w #$0001
	sta.w $2364
	rtl
.9:									; A = $0806, A + 1, if plus go to .loop, $0806 = A, ...
	lda.w $0806
	inc a
	cmp.w #$0010
	bpl .loop
	sta.w $0806
	jsl.l CODE_C09855
	bra .loop
.10:								; A = $0806, A - 1, if the result < 0 go to .loop, $0806 = A, ...
	lda.w $0806
	dec a
	bmi .loop
	sta.w $0806
	jsl.l CODE_C09855
	jmp.w .loop
.11:								; A = $1888, A - 1, if the result < 0 go to .13, $1888 = A, ...
	lda.w $1888
	dec a
	bmi .13
	sta.w $1888
	jsl.l CODE_C09855
	jmp.w .loop
.12:								; A = $1888, A + 1, if plus go to .15, $1888 = A, ...
	lda.w $1888
	inc a
	cmp.w #$0009
	bpl .15
	sta.w $1888
	jsl.l CODE_C09855
	jmp.w .loop
.13:								; A = $1884, A - $1880, A + $0009, if minus go to .14, ...
	lda.w $1884
	sec
	sbc.w $1880
	clc
	adc.w #$0009
	cmp.w $187C
	bmi .14
	jmp.w .loop
.14:								; $1884 + 1, call CODE_C09855, go to .loop
	inc.w $1884
	jsl.l CODE_C09855
	jmp.w .loop
.15:								; A = $1884, A - 1, if plus go to .16, go to .loop
	lda.w $1884
	dec a
	cmp.w $1880
	bpl .16
	jmp.w .loop
.16:								; $1884 - 1, call CODE_C09855, go to .loop
	dec.w $1884
	jsl.l CODE_C09855
	jmp.w .loop
CODE_C09855:						; called from CODE_C096C0, CODE_C096C0, ...
	lda.w #$0020
	sta.b d0
	lda.w #$000D
	sta.b d1
	lda.w $24C0
	sta.b d2
	jsl.l CODE_C528D4
	lda.w #$0011
	sta.w $07D4
	lda.w #$0002
	sta.w $07D6
.1:									; $69 = DATA8_C098CE>>16, a1 = DATA8_C098CE, d0 = $0806, go to .2
	lda.w #DATA8_C098CE>>16
	sta.b $69
	lda.w #DATA8_C098CE
	sta.b a1
	lda.w $0806
	sta.b d0
	bra .2
.loop:								; loop: A = a1, A + [a1], A + $0004, a1 = A
	lda.b a1
	clc
	adc.b [a1]
	adc.w #$0004
	sta.b a1
.2:									; if [a1] < 0 go to .3, d0 - 1, if the result >= 0 go to .loop
	lda.b [a1]
	bmi .3
	dec.b d0
	bpl .loop
.3:									; if [a1] >= 0 go to .4, $0806 - 1, go to .1
	lda.b [a1]
	bpl .4
	dec.w $0806
	bra .1
.4:									; $07D2 = $3800, $91 = [a1], Y = $0002, d4 = [a1],y, ...
	lda.w #$3800
	sta.w $07D2
	lda.b [a1]
	sta.b $91
	ldy.w #$0002
	lda.b [a1],y
	sta.b d4
	lda.w $1884
	cmp.w $1880
	beq .5
.5:									; A = $1884, A - $1880, A + $0009, if plus go to .6
	lda.w $1884
	sec
	sbc.w $1880
	clc
	adc.w #$0009
	cmp.w $187C
	bpl .6
.6:									; call CODE_C09910, return
	jsl.l CODE_C09910
	rtl
DATA8_C098CE:						; not traced: records CODE_C09855 walks, $FFFF ends them
	incbin "../Extracted/segments/bankC0_9000.bin":$8CE..$910
CODE_C09910:						; called from CODE_C09855
	lda.w $0802
	dec a
	asl a
	asl a
	asl a
	sta.b d0
	ldy.b a2
	lda.w $1884
	inc a
	sta.b a3
	lda.w #DATA8_C09BC4>>16
	sta.b $79
	lda.w #DATA8_C09BC4
	sta.b $77
	lda.w #$0008
	sta.b d1
	lda.w $0802
	sec
	sbc.w #$0005
	beq .loop
	bmi .1
	bvc .2
	bra .loop
.1:									; if overflow clear go to .loop
	bvc .loop
.2:									; d1 - 1
	dec.b d1
.loop:								; loop: $07D2 = $3800, A = d1, if A is not $1888 go to .3, $07D2 = $2000
	lda.w #$3800
	sta.w $07D2
	lda.b d1
	cmp.w $1888
	bne .3
	lda.w #$2000
	sta.w $07D2
.3:									; $07D4 = $0002, A = a3, A and $00FF, A - 1, ...
	lda.w #$0002
	sta.w $07D4
	lda.b a3
	and.w #$00FF
	dec a
	sta.b d0
	sta.b r1
	stz.b r2
	jsl.l CODE_C48A41
	lda.b r1
	cmp.b d0
	bpl .4
	lda.w #$0010
	sta.b r2
.4:									; d0 = r1, call CODE_C50F08, a3 + 1, $07D6 + 1, ...
	lda.b r1
	sta.b d0
	jsl.l CODE_C50F08
	inc.b a3
	inc.w $07D6
	dec.b d1
	bpl .loop
	lda.w #$2000
	sta.w $07D2
	rtl
CODE_C0998F:						; called from CODE_C096C0
	ldy.b d1
	phy
	lda.w #$0009
	sec
	sbc.w $1888
	clc
	adc.w $1884
	and.w #$00FF
	sta.b d0
	lda.w #$0000
	sta.b $69
	lda.w #$188C
	sta.b a1
	lda.b a2
	beq .1
	lda.w #$0000
	sta.b $69
	lda.w #$1894
	sta.b a1
.1:									; Y = $1878, A 8-bit, A = [a1],y, A 16-bit, ...
	ldy.w $1878
	sep #$20
	lda.b [a1],y
	rep #$20
	and.w #$00FF
	sta.b d1
	lda.b d0
	ldy.w #$0001
.loop:								; loop: A 8-bit, A 16-bit, if zero go to .2, Y + 1, ...
	sep #$20
	cmp.b [a1],y
	rep #$20
	beq .2
	iny
	cpy.w #$0007
	bmi .loop
	bra .3
.2:									; A = d1, A 8-bit, [a1],y = A, A 16-bit
	lda.b d1
	sep #$20
	sta.b [a1],y
	rep #$20
.3:									; Y = $1878, A = d0, A 8-bit, [a1],y = A, ...
	ldy.w $1878
	lda.b d0
	sep #$20
	sta.b [a1],y
	rep #$20
	pla
	sta.b d1
	rtl
CODE_C099F4:						; called from ShootoutWonBy
	phy
	phx
	sep #$20
	ldy.w #$0000
	dex
.loop:								; loop: Y + 1, X + 1, if $0000,x is not 0 go to .loop, A 16-bit, ...
	iny
	inx
	lda.w $0000,x
	bne .loop
	rep #$20
	tya
	jsl.l CODE_C4C561
	tax
	tya
	sta.w $0000,x
	ply
	pha
	sep #$20
.loop2:								; loop: $0001,x = $0000,y, if $0000,y = 0 go to .1, Y + 1, X + 1, ...
	lda.w $0000,y
	sta.w $0001,x
	beq .1
	iny
	inx
	bra .loop2
.1:									; A 16-bit, pull X, pull Y, return
	rep #$20
	plx
	ply
	rtl

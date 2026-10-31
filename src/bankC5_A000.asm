; Segment bankC5_A000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), two jump tables and the data tables the code reads with long addresses.
org $C59F79
CODE_C59F79:						; called from other segments
	stz.w $04F5
	stz.w $04F7
	stz.w $04F9
	stz.w $04FB
	lda.b $7F
	bne CODE_C59FDA
	lda.w #$0010
	sta.w $24DC
	lda.w $0527
	jsr.w CODE_C5A083
	tsb.w $04F7
	lda.w $0529
	jsr.w CODE_C5A07A
	tsb.w $04F6
	lda.w $052B
	jsr.w CODE_C5A083
	tsb.w $04F8
	lda.w $052D
	jsr.w CODE_C5A07A
	tsb.w $04F8
	lda.w $052F
	jsr.w CODE_C5A07A
	tsb.w $04FB
	lda.w $0531
	jsr.w CODE_C5A083
	tsb.w $04FB
	lda.w $0533
	jsr.w CODE_C5A07A
	tsb.w $04FC
	lda.w $0535
	jsr.w CODE_C5A083
	tsb.w $04FC
	jmp.w CODE_C5A040
CODE_C59FDA:						; from CODE_C59F79
	stz.w $24DC
	lda.w $0527
	jsr.w CODE_C5A083
	tsb.w $04F7
	lda.w $0529
	jsr.w CODE_C5A07A
	tsb.w $04F6
	lda.w $052B
	jsr.w CODE_C5A083
	tsb.w $04FB
	lda.w $052D
	jsr.w CODE_C5A07A
	tsb.w $04F7
	lda.w $052F
	jsr.w CODE_C5A083
	tsb.w $04F8
	lda.w $0531
	jsr.w CODE_C5A083
	tsb.w $04FA
	lda.w $0533
	jsr.w CODE_C5A07A
	tsb.w $04F8
	lda.w $0535
	jsr.w CODE_C5A07A
	tsb.w $04FA
	lda.w $0537
	jsr.w CODE_C5A083
	tsb.w $04FC
	lda.w $0539
	jsr.w CODE_C5A07A
	tsb.w $04FC
	lda.w $053B
	jsr.w CODE_C5A083
	tsb.w $04F9
CODE_C5A040:						; from CODE_C59F79
	jsr.w CODE_C5C6B7
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldy.w #$0015
	jsr.w CODE_C5A05A
	lda.b $87
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldy.w #$0016
CODE_C5A05A:						; from CODE_C5A040
	lda.w $04F9
	sta.w $04FB
	lda.w $04F7
	sta.w $04F9
	lda.w $04F5
	sta.w $04F7
	lda.w #$2020
	sta.w $04F5
	ldx.w #$04F6
	jsl.l $C4BC1A
	rts
CODE_C5A07A:						; from CODE_C59F79, CODE_C59FDA, CODE_C5A083 and other segments
	tax
	lda.l DATA8_C5A08B,x
	and.w #$00FF
	rts
CODE_C5A083:						; from CODE_C59F79, CODE_C59FDA
	jsr.w CODE_C5A07A
	asl a
	asl a
	asl a
	asl a
	rts
DATA8_C5A08B:						; not traced: a table read by CODE_C5A07A
	db $00,$00,$01,$01,$02,$02,$03,$03,$03,$03,$04,$04,$04,$05,$05,$06
CODE_C5A09B:						; called from other segments
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l CODE_C589E4
	lda.w #$FFFF
	sta.w $04C6
	ldy.w #$5C00
	jsl.l CODE_C589B0
	ldx.b $9B
	jsl.l CODE_C5E596
	ldx.b $9D
	jsl.l CODE_C5E596
	ldx.b $73
	jsl.l CODE_C5E596
	ldx.b $75
	jsl.l CODE_C5E596
	jsl.l $C4C530
	jsl.l $C4BAF6
	lda.w #$5714
	jsl.l $C4BB5A
	sec
	lda.b $CF
	sbc.w #$0008
	sta.b $CF
	lda.w #$2C00
	sta.b $D5
	lda.w #$001A
	ldy.w #$000C
	ldx.w #$490D
	jsl.l $C4BC2C
	lda.w #$001A
	ldy.w #$000F
	ldx.w #$4914
	jsl.l $C4BC2C
	lda.w #$001A
	ldy.w #$0012
	ldx.w #$491B
	jsl.l $C4BC2C
	lda.w #$2000
	sta.b $D5
	lda.w #$3E3E
	sta.w $04F5
	sta.w $04F7
	sta.w $04F9
	sta.w $04FB
	sta.w $04FD
	stz.w $04FF
	lda.w #$0078
	sta.b $CF
	lda.w #$000F
	ldy.w #$0008
	ldx.w #$04F5
	jsl.l $C4BC46
	stz.w $04FD
	lda.w #$000F
	ldy.w #$0006
	ldx.w #$04F5
	jsl.l $C4BC46
	jsl.l $C4C2AA
	lda.w #$0006
	sta.b $71
	lda.w #$0008
	sta.b $69
	stz.b $99
	stz.b $6F
	stz.b $97
	jsr.w CODE_C5A20D
	rts
CODE_C5A164:						; called from other segments
	lda.w #$006A
	ldx.b $63
	sta.b $05,x
	lda.b $97
	beq CODE_C5A175
	lda.w #$009F
	sta.b $08,x
	rts
CODE_C5A175:						; from CODE_C5A164
	lda.w #$0087
	sta.b $08,x
	rts
CODE_C5A17B:						; called from other segments
	lda.b $97
	asl a
	tax
	lda.b $D3
	adc.l DATA8_C5A1D7,x
	tay
	jsr.w CODE_C5A198
	iny
	iny
	jsr.w CODE_C5A198
	tya
	adc.w #$003E
	tay
	jsr.w CODE_C5A198
	iny
	iny
CODE_C5A198:						; from CODE_C5A17B
	lda.w $0000,y
	and.w #$E3FF
	ora.w #$0C00
	sta.w $0000,y
	rts
CODE_C5A1A5:						; from CODE_C5A20D
	lda.b $97
	asl a
	tax
	lda.b $D3
	adc.l DATA8_C5A1D7,x
	tay
	jsr.w CODE_C5A1CA
	iny
	iny
	jsr.w CODE_C5A1CA
	tya
	adc.w #$003E
	tay
	jsr.w CODE_C5A1CA
	iny
	iny
	jsr.w CODE_C5A1CA
	jsl.l $C4C2AA
	rts
CODE_C5A1CA:						; from CODE_C5A1A5
	lda.w $0000,y
	and.w #$E3FF
	ora.w #$0000
	sta.w $0000,y
	rts
DATA8_C5A1D7:						; not traced: a table read by CODE_C5A17B, CODE_C5A1A5
	db $06,$03,$0C,$03,$12,$03,$18,$03,$1E,$03,$24,$03,$2A,$03,$30,$03
	db $36,$03,$C6,$03,$CC,$03,$D2,$03,$D8,$03,$DE,$03,$E4,$03,$EA,$03
	db $F0,$03,$F6,$03,$86,$04,$8C,$04,$92,$04,$98,$04,$9E,$04,$A4,$04
	db $AA,$04,$B0,$04,$B6,$04
CODE_C5A20D:						; from CODE_C5A09B and other segments
	jsr.w CODE_C5A1A5
	ldy.b $63
	lda.b $97
	asl a
	tax
	lda.l DATA8_C5A25B,x
	sta.w $0008,y
	lda.l DATA8_C5A225,x
	sta.w $0005,y
	rts
DATA8_C5A225:						; not traced: a table read by CODE_C5A20D
	db $14,$00,$2C,$00,$44,$00,$5C,$00,$74,$00,$8C,$00,$A4,$00,$BC,$00
	db $D4,$00,$14,$00,$2C,$00,$44,$00,$5C,$00,$74,$00,$8C,$00,$A4,$00
	db $BC,$00,$D4,$00,$14,$00,$2C,$00,$44,$00,$5C,$00,$74,$00,$8C,$00
	db $A4,$00,$BC,$00,$D4,$00
DATA8_C5A25B:						; not traced: a table read by CODE_C5A20D
	db $70,$00,$70,$00,$70,$00,$70,$00,$70,$00,$70,$00,$70,$00,$70,$00
	db $70,$00,$88,$00,$88,$00,$88,$00,$88,$00,$88,$00,$88,$00,$88,$00
	db $88,$00,$88,$00,$A0,$00,$A0,$00,$A0,$00,$A0,$00,$A0,$00,$A0,$00
	db $A0,$00,$A0,$00,$A0,$00
CODE_C5A291:						; called from other segments
	lda.w #$0008
	jsr.w CODE_C5A304
	lda.b $7F
	asl a
	tax
	lda.l DATA8_C5A2A8,x
	tax
	ldy.w #$0008
	jsl.l $C4BC26
	rts
DATA8_C5A2A8:						; not traced: a table read by CODE_C5A291
	db $B8,$49,$BD,$49,$C7,$49,$D7,$49,$D2,$49,$E0,$49
CODE_C5A2B4:						; called from other segments
	lda.w #$000B
	jsr.w CODE_C5A304
	lda.b $81
	asl a
	asl a
	asl a
	adc.w #$008C
	jsr.w CODE_C5B67A
	jsr.w CODE_C5A321
	ldx.w #$04F6
	ldy.w #$000B
	jsl.l $C4BC9E
	rts
CODE_C5A2D3:						; called from other segments
	lda.w #$000E
	jsr.w CODE_C5A304
	lda.b $83
	jsr.w CODE_C5B67A
	jsr.w CODE_C5A321
	ldx.w #$04F7
	ldy.w #$000E
	jsl.l $C4BC9E
	rts
CODE_C5A2EC:						; called from other segments
	lda.w #$0011
	jsr.w CODE_C5A304
	ldx.w #$49ED
	lda.b $85
	beq CODE_C5A2FC
	ldx.w #$49E9
CODE_C5A2FC:						; from CODE_C5A2EC
	ldy.w #$0011
	jsl.l $C4BC26
	rts
CODE_C5A304:						; from CODE_C5A291, CODE_C5A2B4, CODE_C5A2D3, CODE_C5A2EC
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$0020
	pha
	ldy.w #$0020
	jsl.l CODE_C58B11
	pla
	clc
	adc.w #$0040
	ldy.w #$0020
	jsl.l CODE_C58B11
	rts
CODE_C5A321:						; from CODE_C5A2B4, CODE_C5A2D3
	tax
	xba
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w $04F5
	txa
	xba
	and.w #$000F
	adc.w #$0030
	sta.w $04F6
	txa
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w $04F7
	txa
	and.w #$000F
	adc.w #$0030
	sta.w $04F8
	rts
DATA8_C5A354:						; a pointer to CODE_C5A359 (its reader is not traced)
	dw CODE_C5A359
CODE_C5A356:						; after the pointer word DATA8_C5A354; no caller found (not traced)
	jmp.w CODE_C5A3C1
CODE_C5A359:						; DATA8_C5A354 points here; no caller found (not traced)
	lda.w $17CB
	cmp.w #$001A
	bcc CODE_C5A36E
	beq CODE_C5A368
	lda.w #$0019
	bra CODE_C5A36B
CODE_C5A368:						; from CODE_C5A359
	lda.w #$0000
CODE_C5A36B:						; from CODE_C5A359
	sta.w $17CB
CODE_C5A36E:						; from CODE_C5A359
	cmp.w $17C9
	bne CODE_C5A397
	lda.w $058D
	bit.w #$0200
	beq CODE_C5A389
	lda.w $17CB
	dec a
	bpl CODE_C5A384
	lda.w #$0019
CODE_C5A384:						; from CODE_C5A36E, CODE_C5A389
	sta.w $17CB
	bra CODE_C5A397
CODE_C5A389:						; from CODE_C5A36E
	lda.w $17CB
	inc a
	cmp.w #$001A
	bcc CODE_C5A384
	lda.w #$0000
	bra CODE_C5A384
CODE_C5A397:						; from CODE_C5A36E, CODE_C5A384
	lda.w $1872
	bne CODE_C5A3A4
	lda.w $1864
	beq CODE_C5A3BE
	dec a
	beq CODE_C5A3BE
CODE_C5A3A4:						; from CODE_C5A397
	lda.w $17CB
	cmp.w #$001A
	bne CODE_C5A3B4
	lda.w #$0000
CODE_C5A3AF:						; from CODE_C5A3B4
	sta.w $17CB
	bra CODE_C5A3BE
CODE_C5A3B4:						; from CODE_C5A3A4
	cmp.w #$001B
	bne CODE_C5A3BE
	lda.w #$0019
	bra CODE_C5A3AF
CODE_C5A3BE:						; from CODE_C5A397, CODE_C5A3AF, CODE_C5A3B4
	rts
DATA8_C5A3BF:						; a pointer to CODE_C5A397 (its reader is not traced)
	dw CODE_C5A397
CODE_C5A3C1:						; from CODE_C5A356 and other segments
	lda.w $17CB
	sta.l $306043
	jsl.l $C4CEDB
	pei ($CF)
	pei ($D1)
	lda.w #$0340
	jsr.w CODE_C5A3E6
	lda.w #$0020
	sta.b $CF
	lda.w #$0068
	sta.b $D1
	lda.w $17CB
	jmp.w CODE_C5A48C
CODE_C5A3E6:						; from CODE_C5A3C1, CODE_C5A46A
	clc
	adc.b $D3
	ldy.w #$0020
	pha
	phy
	jsl.l CODE_C58B11
	ply
	pla
	clc
	adc.w #$0040
	jsl.l CODE_C58B11
	rts
DATA8_C5A3FD:						; a pointer to CODE_C5A402 (its reader is not traced)
	dw CODE_C5A402
CODE_C5A3FF:						; after the pointer word DATA8_C5A3FD; no caller found (not traced)
	jmp.w CODE_C5A46A
CODE_C5A402:						; DATA8_C5A3FD points here; no caller found (not traced)
	lda.w $17C9
	cmp.w #$001A
	bcc CODE_C5A417
	beq CODE_C5A411
	lda.w #$0019
	bra CODE_C5A414
CODE_C5A411:						; from CODE_C5A402
	lda.w #$0000
CODE_C5A414:						; from CODE_C5A402
	sta.w $17C9
CODE_C5A417:						; from CODE_C5A402
	cmp.w $17CB
	bne CODE_C5A440
	lda.w $058D
	bit.w #$0200
	beq CODE_C5A432
	lda.w $17C9
	dec a
	bpl CODE_C5A42D
	lda.w #$0019
CODE_C5A42D:						; from CODE_C5A417, CODE_C5A432
	sta.w $17C9
	bra CODE_C5A440
CODE_C5A432:						; from CODE_C5A417
	lda.w $17C9
	inc a
	cmp.w #$001A
	bcc CODE_C5A42D
	lda.w #$0000
	bra CODE_C5A42D
CODE_C5A440:						; from CODE_C5A417, CODE_C5A42D
	lda.w $1872
	bne CODE_C5A44D
	lda.w $1864
	beq CODE_C5A467
	dec a
	beq CODE_C5A467
CODE_C5A44D:						; from CODE_C5A440
	lda.w $17C9
	cmp.w #$001A
	bne CODE_C5A45D
	lda.w #$0000
CODE_C5A458:						; from CODE_C5A45D
	sta.w $17C9
	bra CODE_C5A467
CODE_C5A45D:						; from CODE_C5A44D
	cmp.w #$001B
	bne CODE_C5A467
	lda.w #$0019
	bra CODE_C5A458
CODE_C5A467:						; from CODE_C5A440, CODE_C5A458, CODE_C5A45D
	rts
DATA8_C5A468:						; a pointer to CODE_C5A440 (its reader is not traced)
	dw CODE_C5A440
CODE_C5A46A:						; from CODE_C5A3FF and other segments
	lda.w $17C9
	sta.l $306041
	jsl.l $C4CEDB
	pei ($CF)
	pei ($D1)
	lda.w #$0360
	jsr.w CODE_C5A3E6
	lda.w #$00A0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	lda.w $17C9
CODE_C5A48C:						; from CODE_C5A3C1
	ldy.w #$000D
CODE_C5A48F:						; from CODE_C5A4A5
	asl a
	tax
	lda.l $C3585C,x
	tax
	jsl.l $C4BCAA
	jsl.l $C4C2AA
	pla
	sta.b $D1
	pla
	sta.b $CF
	rts
CODE_C5A4A5:						; called from other segments
	pei ($CF)
	pei ($D1)
	ldx.w #$0020
	stx.b $CF
	ldx.w #$0068
	stx.b $D1
	bra CODE_C5A48F
CODE_C5A4B5:						; called from other segments
	jsr.w CODE_C5A4B9
	rtl
CODE_C5A4B9:						; from CODE_C5A4B5 and other segments
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	pea.w $0020
	pea.w $007F
	lda.w $17C9
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$D80A
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	rts
CODE_C5A4DE:						; called from other segments
	jsr.w CODE_C5A4E2
	rtl
CODE_C5A4E2:						; from CODE_C5A4DE and other segments
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	pea.w $0030
	pea.w $007F
	lda.w $17CB
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$D80A
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	rts
CODE_C5A507:						; called from other segments
	jsr.w CODE_C5A50B
	rtl
CODE_C5A50B:						; from CODE_C5A507, CODE_C5A556 and other segments
	ldx.b $73
	jsl.l CODE_C5E596
	stz.b $73
	ldx.b $75
	jsl.l CODE_C5E596
	stz.b $75
	rts
CODE_C5A51C:						; from CODE_C5A633, CODE_C5A5EB, CODE_C5A7C5, CODE_C5AB1C, ...
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l CODE_C589E4
	ldy.w #$5C00
	jsl.l CODE_C589E4
	lda.w #$FFFF
	sta.w $04C6
	jsl.l $C4CEDB
	lda.w #$0002
	sta.w $1864
	lda.l $306050
	and.w #$00FF
	asl a
	tax
	lda.l $C35F60,x
	bne CODE_C5A556
	jsl.l $C40D96
	inc.w $1864
CODE_C5A556:						; from CODE_C5A51C
	ldx.b $9B
	jsl.l CODE_C5E596
	ldx.b $9D
	jsl.l CODE_C5E596
	jsr.w CODE_C5A50B
	jsl.l $C4C530
	jsl.l $C4BAF6
	lda.w #$56A4
	jsl.l $C4BB5A
	clc
	lda.b $D3
	adc.w #$0240
	tax
	ldy.w #$01DF
CODE_C5A57E:						; from CODE_C5A57E
	lda.w $0000,x
	and.w #$E3FF
	ora.w #$0C00
	sta.w $0000,x
	inx
	inx
	dey
	bpl CODE_C5A57E
	stz.b $97
	lda.w #$0006
	sta.b $99
	stz.w fadestep
CODE_C5A599:						; from CODE_C5AC4F, CODE_C5AC67
	ldx.b $63
	lda.w #$0030
	sta.b $05,x
	lda.b $97
	asl a
	asl a
	asl a
	sta.b $9F
	asl a
	adc.b $9F
	adc.w #$003E
	sta.b $08,x
	rts
CODE_C5A5B0:						; called from other segments
	jsr.w CODE_C55BE8
	lda.w $058F
	beq CODE_C5A5C3
	cmp.w #$0014
	bcc CODE_C5A5EA
	lda.w #$0013
	sta.w $058F
CODE_C5A5C3:						; from CODE_C5A5B0
	lda.w $058D
	bit.w #$3000
	bne CODE_C5A5EB
	bit.w #$0800
	beq CODE_C5A5D3
	jmp.w CODE_C55CE6
CODE_C5A5D3:						; from CODE_C5A5C3
	bit.w #$0400
	beq CODE_C5A5DB
	jmp.w CODE_C55C58
CODE_C5A5DB:						; from CODE_C5A5D3
	bit.w #$0200
	bne CODE_C5A5FE
	bit.w #$0100
	bne CODE_C5A608
	bit.w #$8000
	bne CODE_C5A617
CODE_C5A5EA:						; from CODE_C5A5B0
	rts
CODE_C5A5EB:						; from CODE_C5A5C3
	jsl.l FadeOutWait
	ldx.b $77
	jsl.l CODE_C5E596
	ldx.b $79
	jsl.l CODE_C5E596
	jmp.w CODE_C5A51C
CODE_C5A5FE:						; from CODE_C5A5DB
	lda.b $83
	dec a
	bpl CODE_C5A613
	lda.w #$0002
	bra CODE_C5A613
CODE_C5A608:						; from CODE_C5A5DB
	lda.b $83
	inc a
	cmp.w #$0003
	bcc CODE_C5A613
	lda.w #$0000
CODE_C5A613:						; from CODE_C5A5FE, CODE_C5A608
	pha
	jmp.w CODE_C5AFCC
CODE_C5A617:						; from CODE_C5A5DB
	pei ($83)
	lda.b $85
	eor.w #$0001
	sta.b $85
	jmp.w CODE_C5AFCC
CODE_C5A623:						; called from other segments
	lda.w $058F
	beq CODE_C5A633
	cmp.w #$0014
	bcc CODE_C5A64C
	lda.w #$0013
	sta.w $058F
CODE_C5A633:						; from CODE_C5A623
	lda.w $058D
	bit.w #$0100
	bne CODE_C5A64D
	bit.w #$0200
	bne CODE_C5A65F
	bit.w #$3000
	beq CODE_C5A64C
	jsl.l FadeOutWait
	jmp.w CODE_C5A51C
CODE_C5A64C:						; from CODE_C5A623, CODE_C5A633
	rts
CODE_C5A64D:						; from CODE_C5A633
	lda.w $17C9
	inc a
	cmp.w #$001A
	bcc CODE_C5A659
	lda.w #$0000
CODE_C5A659:						; from CODE_C5A64D
	sta.w $17C9
	jmp.w CODE_C5B7F1
CODE_C5A65F:						; from CODE_C5A633
	lda.w $17C9
	dec a
	bpl CODE_C5A668
	lda.w #$0019
CODE_C5A668:						; from CODE_C5A65F
	sta.w $17C9
	jmp.w CODE_C5B7F1
CODE_C5A66E:						; called from other segments
	jsr.w CODE_C55BE8
	lda.w $058F
	beq CODE_C5A681
	cmp.w #$0014
	bcc CODE_C5A6A8
	lda.w #$0014
	sta.w $058F
CODE_C5A681:						; from CODE_C5A66E
	lda.w $058D
	bit.w #$8000
	bne CODE_C5A6CA
	bit.w #$0100
	bne CODE_C5A6BC
	bit.w #$0200
	bne CODE_C5A6D9
	bit.w #$0400
	beq CODE_C5A69B
	jmp.w CODE_C55C58
CODE_C5A69B:						; from CODE_C5A681
	bit.w #$0800
	beq CODE_C5A6A3
	jmp.w CODE_C55CE6
CODE_C5A6A3:						; from CODE_C5A69B
	bit.w #$3000
	bne CODE_C5A6A9
CODE_C5A6A8:						; from CODE_C5A66E
	rts
CODE_C5A6A9:						; from CODE_C5A6A3
	jsl.l FadeOutWait
	ldx.b $77
	jsl.l CODE_C5E596
	ldx.b $79
	jsl.l CODE_C5E596
	jmp.w CODE_C5A51C
CODE_C5A6BC:						; from CODE_C5A681
	lda.w $17C9
	inc a
	cmp.w #$001A
	bcc CODE_C5A6C8
	lda.w #$0000
CODE_C5A6C8:						; from CODE_C5A6BC
	bra CODE_C5A6E2
CODE_C5A6CA:						; from CODE_C5A681
	jsr.w CODE_C5A72D
	lda.b $7F
	bne CODE_C5A6D5
	dec.b $7F
	bra CODE_C5A6E5
CODE_C5A6D5:						; from CODE_C5A6CA
	stz.b $7F
	bra CODE_C5A6E5
CODE_C5A6D9:						; from CODE_C5A681
	lda.w $17C9
	dec a
	bpl CODE_C5A6E2
	lda.w #$0019
CODE_C5A6E2:						; from CODE_C5A6C8, CODE_C5A6D9
	sta.w $17C9
CODE_C5A6E5:						; from CODE_C5A6CA, CODE_C5A6D5
	ldx.b $77
	jsl.l CODE_C5E596
	ldx.b $79
	jsl.l CODE_C5E596
	lda.b $D3
	clc
	adc.w #$0280
	ldy.w #$0380
	jsl.l CODE_C58B11
	jsl.l $C4C2AA
	jsr.w CODE_C5BCD9
	jsr.w CODE_C52CC1
	lda.w $2DCB
	sta.b $67
	lda.b $7F
	bne CODE_C5A71A
	sec
	lda.w $2DC9
	sbc.w $2DCB
	sta.b $67
CODE_C5A71A:						; from CODE_C5A6E5
	stz.b $69
	lda.w #CODE_C5BBDD
	ldx.w #$000C
	ldy.w #$000B
	jsr.w CODE_C55ABC
	jsl.l $C4C2AA
	rts
CODE_C5A72D:						; from CODE_C5A6CA
	pea.w $559D
	pea.w $55BD
	lda.b $7F
	bne CODE_C5A73F
	pla
	pla
	pea.w $55AD
	pea.w $55D7
CODE_C5A73F:						; from CODE_C5A72D
	clc
	lda.w #$0240
	adc.b $D3
	ldy.w #$0040
	jsl.l CODE_C58B11
	clc
	lda.w #$0600
	adc.b $D3
	ldy.w #$0040
	jsl.l CODE_C58B11
	lda.w #$0018
	sta.b $CF
	ldy.w #$0009
	plx
	jsl.l $C4BBFC
	ldy.w #$0018
	plx
	jsl.l $C4BBFC
	jsl.l $C4CEDB
	rts
CODE_C5A773:						; called from other segments
	jsr.w CODE_C55BE8
	lda.w $058F
	beq CODE_C5A786
	cmp.w #$0014
	bcc CODE_C5A7A2
	lda.w #$0014
	sta.w $058F
CODE_C5A786:						; from CODE_C5A773
	lda.w $058D
	bit.w #$0400
	bne CODE_C5A7A3
	bit.w #$0800
	bne CODE_C5A7BB
	bit.w #$0200
	bne CODE_C5A7D8
	bit.w #$0100
	bne CODE_C5A7E1
	bit.w #$3000
	bne CODE_C5A7C5
CODE_C5A7A2:						; from CODE_C5A773
	rts
CODE_C5A7A3:						; from CODE_C5A786
	lda.b $83
	inc a
	cmp.w #$0004
	bcc CODE_C5A7AE
	lda.w #$0000
CODE_C5A7AE:						; from CODE_C5A7A3, CODE_C5A7BB
	sta.b $83
	ldy.w #$03F0
	lda.w #$0200
	jsr.w CODE_C5A80E
	bra CODE_C5A7F4
CODE_C5A7BB:						; from CODE_C5A786
	lda.b $83
	dec a
	bpl CODE_C5A7AE
	lda.w #$0003
	bra CODE_C5A7AE
CODE_C5A7C5:						; from CODE_C5A786
	jsl.l FadeOutWait
	ldx.b $77
	jsl.l CODE_C5E596
	ldx.b $79
	jsl.l CODE_C5E596
	jmp.w CODE_C5A51C
CODE_C5A7D8:						; from CODE_C5A786
	dec.b $7F
	bpl CODE_C5A7EE
	lda.w #$0007
	bra CODE_C5A7EC
CODE_C5A7E1:						; from CODE_C5A786
	lda.b $7F
	inc a
	cmp.w #$0008
	bcc CODE_C5A7EC
	lda.w #$0000
CODE_C5A7EC:						; from CODE_C5A7D8, CODE_C5A7E1
	sta.b $7F
CODE_C5A7EE:						; from CODE_C5A7D8
	ldy.w #$0270
	jsr.w CODE_C5A80B
CODE_C5A7F4:						; from CODE_C5A7AE
	ldx.b $77
	jsl.l CODE_C5E596
	ldx.b $79
	jsl.l CODE_C5E596
	jsl.l $C4C2AA
	jsl.l $C4CEDB
	jmp.w CODE_C5B1AF
CODE_C5A80B:						; from CODE_C5A7EE
	lda.w #$01D0
CODE_C5A80E:						; from CODE_C5A7AE
	clc
	adc.b $D3
	jsl.l CODE_C58B11
	rts
CODE_C5A816:						; called from other segments
	ldx.b $89
	jmp (DATA8_C5A81B,x)
DATA8_C5A81B:						; jump table: the routine for each index
	dw CODE_C5A821,CODE_C5A95A,CODE_C5A9FB
CODE_C5A821:						; from DATA8_C5A81B
	lda.w $058F
	beq CODE_C5A831
	cmp.w #$0014
	bcc CODE_C5A85C
	lda.w #$0010
	sta.w $058F
CODE_C5A831:						; from CODE_C5A821
	lda.w $058D
	bit.w #$0200
	bne CODE_C5A89D
	bit.w #$0100
	bne CODE_C5A8B0
	bit.w #$0800
	bne CODE_C5A8C2
	bit.w #$0400
	beq CODE_C5A84B
	jmp.w CODE_C5A90A
CODE_C5A84B:						; from CODE_C5A831
	bit.w #$8000
	bne CODE_C5A85D
	bit.w #$3000
	beq CODE_C5A85C
	jsl.l FadeOutWait
	jmp.w CODE_C5A51C
CODE_C5A85C:						; from CODE_C5A821, CODE_C5A89D, CODE_C5A8B0, CODE_C5A8C2, ...
	rts
CODE_C5A85D:						; from CODE_C5A84B
	lda.l $306050
	and.w #$00FF
	cmp.b $7F
	beq CODE_C5A86A
	bcs CODE_C5A85C
CODE_C5A86A:						; from CODE_C5A85D
	bne CODE_C5A878
	ldx.b $85
	lda.l $306051
CODE_C5A872:						; from CODE_C5A872
	lsr a
	dex
	bpl CODE_C5A872
	bcs CODE_C5A85C
CODE_C5A878:						; from CODE_C5A86A
	lda.b $8F
	clc
	adc.b $85
	pha
	and.w #$0007
	tax
	lda.l $C4C4A6,x
	and.w #$00FF
	sta.b $9F
	pla
	lsr a
	lsr a
	lsr a
	tax
	lda.l $307884,x
	eor.b $9F
	sta.l $307884,x
	jmp.w CODE_C5B38F
CODE_C5A89D:						; from CODE_C5A831
	lda.l $306050
	and.w #$00FF
	cmp.b $7F
	bcs CODE_C5A85C
	dec.b $7F
	jsr.w CODE_C5B22D
	jmp.w CODE_C5AAF0
CODE_C5A8B0:						; from CODE_C5A831
	lda.b $7F
	asl a
	tax
	lda.l $C35F62,x
	beq CODE_C5A85C
	inc.b $7F
	jsr.w CODE_C5B22D
	jmp.w CODE_C5AAF0
CODE_C5A8C2:						; from CODE_C5A831
	lda.b $85
	beq CODE_C5A85C
	dec a
	sta.b $85
	bne CODE_C5A8D4
	ldx.b $73
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
CODE_C5A8D4:						; from CODE_C5A8C2
	sec
	lda.b $8B
	sbc.w #$00E0
	and.w #$03FF
	sta.b $8B
	ldx.b $63
	lda.b $08,x
	cmp.w #$0060
	beq CODE_C5A8EE
	lda.w #$0060
	sta.b $08,x
	rts
CODE_C5A8EE:						; from CODE_C5A8D4
	ldx.b $75
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	jsr.w CODE_C5AA94
	lda.b $81
	dec a
	bpl CODE_C5A902
	lda.w #$0002
CODE_C5A902:						; from CODE_C5A8EE
	sta.b $81
	lda.w #$0002
	sta.b $89
CODE_C5A909:						; from CODE_C5A90A
	rts
CODE_C5A90A:						; from CODE_C5A831
	lda.b $85
	inc a
	cmp.b $87
	bcs CODE_C5A909
	sta.b $85
	inc a
	cmp.b $87
	bcc CODE_C5A922
	ldx.b $75
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	clc
CODE_C5A922:						; from CODE_C5A90A
	lda.b $8B
	adc.w #$00E0
	and.w #$03FF
	sta.b $8B
	ldx.b $63
	lda.b $08,x
	cmp.w #$0098
	beq CODE_C5A93B
	lda.w #$0098
	sta.b $08,x
	rts
CODE_C5A93B:						; from CODE_C5A922
	ldx.b $73
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	jsr.w CODE_C5AA94
	lda.b $81
	inc a
	cmp.w #$0003
	bcc CODE_C5A952
	lda.w #$0000
CODE_C5A952:						; from CODE_C5A93B
	sta.b $81
	lda.w #$0004
	sta.b $89
	rts
CODE_C5A95A:						; from DATA8_C5A81B
	jsr.w CODE_C5A95D
CODE_C5A95D:						; from CODE_C5A95A
	dec.w $04C2
	lda.w $468F
	and.w #$00FF
	cmp.w #$0038
	bne CODE_C5A996
	lda.w $0102
	dec a
	sta.w $0104
	lda.w $0100
	dec a
	sta.w $0102
	clc
	lda.w $0110
	adc.w #$00A7
	sta.w $0100
	sep #$20
	lda.b #$01
	sta.w $468F
	lda.b #$38
	sta.w $4692
	dec a
	sta.w $4695
	rep #$20
	rts
CODE_C5A996:						; from CODE_C5A95D
	dec.w $0100
	dec.w $0102
	dec.w $0104
	cmp.w #$0028
	bne CODE_C5A9B9
	pha
	lda.b $85
	lsr a
	ldx.w #$0020
	bcc CODE_C5A9B0
	ldx.w #$0040
CODE_C5A9B0:						; from CODE_C5A996
	lda.b $8D
	and.w #$00FF
	jsr.w CODE_C5B369
	pla
CODE_C5A9B9:						; from CODE_C5A996
	cmp.w #$0010
	bne CODE_C5A9D3
	pha
	lda.b $85
	lsr a
	ldx.w #$0030
	bcc CODE_C5A9CA
	ldx.w #$0050
CODE_C5A9CA:						; from CODE_C5A9B9
	lda.b $8E
	and.w #$00FF
	jsr.w CODE_C5B369
	pla
CODE_C5A9D3:						; from CODE_C5A9B9
	sep #$20
	inc a
	sta.w $468F
	lda.w $4695
	dec a
	bne CODE_C5A9F5
	lda.b #$37
	sta.w $4692
	rep #$20
	lda.w $0104
	sta.w $0110
	lda.w $0102
	sta.w $0104
	stz.b $89
	rts
CODE_C5A9F5:						; from CODE_C5A9D3
	sta.w $4695
	rep #$20
	rts
CODE_C5A9FB:						; from DATA8_C5A81B
	jsr.w CODE_C5A9FE
CODE_C5A9FE:						; from CODE_C5A9FB
	inc.w $04C2
	sep #$20
	lda.w $468F
	dec a
	beq CODE_C5AA66
	sta.w $468F
	cmp.b #$28
	bne CODE_C5AA29
	rep #$20
	lda.b $85
	lsr a
	ldx.w #$0020
	bcc CODE_C5AA1D
	ldx.w #$0040
CODE_C5AA1D:						; from CODE_C5A9FE
	lda.b $8D
	and.w #$00FF
	jsr.w CODE_C5B369
	sep #$20
	bra CODE_C5AA44
CODE_C5AA29:						; from CODE_C5A9FE
	cmp.b #$10
	bne CODE_C5AA44
	rep #$20
	lda.b $85
	lsr a
	ldx.w #$0030
	bcc CODE_C5AA3A
	ldx.w #$0050
CODE_C5AA3A:						; from CODE_C5AA29
	lda.b $8E
	and.w #$00FF
	jsr.w CODE_C5B369
	sep #$20
CODE_C5AA44:						; from CODE_C5AA1D, CODE_C5AA29
	lda.b #$38
	cmp.w $4692
	beq CODE_C5AA50
	sta.w $4692
	bra CODE_C5AA53
CODE_C5AA50:						; from CODE_C5AA44
	inc.w $4695
CODE_C5AA53:						; from CODE_C5AA44
	rep #$20
	lda.w $0110
	inc a
	sta.w $0104
	sta.w $0110
	inc.w $0100
	inc.w $0102
	rts
CODE_C5AA66:						; from CODE_C5A9FE
	lda.b #$38
	sta.w $468F
	dec a
	sta.w $4692
	lda.b #$01
	sta.w $4695
	rep #$20
	sec
	lda.w $0100
	sbc.w #$00A7
	sta.w $0110
	lda.w $0102
	inc a
	sta.w $0100
	lda.w $0104
	inc a
	sta.w $0102
	sta.w $0104
	stz.b $89
	rts
CODE_C5AA94:						; from CODE_C5A8EE, CODE_C5A93B
	jsr.w CODE_C5B38F
	ldx.w #$0058
	stx.b $CF
	ldx.w #$00A0
	stx.b $D1
	lda.b $85
	asl a
	adc.b $83
	tax
	lda.l $C30001,x
	sta.b $8D
	lda.b $81
	asl a
	tax
	phx
	lda.l DATA8_C5B35D,x
	adc.b $D3
	ldy.w #$01C0
	jsl.l CODE_C58B11
	plx
	lda.l DATA8_C5B363,x
	tay
	lda.b $8D
	and.w #$00FF
	asl a
	tax
	lda.l $C3585C,x
	tax
	phy
	jsl.l $C4BCAA
	lda.b $8E
	and.w #$00FF
	asl a
	tax
	lda.l $C3585C,x
	tax
	pla
	adc.w #$0003
	tay
	jsl.l $C4BCAA
	jsl.l $C4C2AA
	rts
CODE_C5AAF0:						; from CODE_C5A89D, CODE_C5A8B0, CODE_C5ACBE
	lda.b $D3
	clc
	adc.w #$0140
	ldy.w #$0080
	jsl.l CODE_C58B11
	lda.b $7F
	jsr.w CODE_C56168
	lda.w #$0030
	sta.b $CF
	ldx.w #$04F5
	ldy.w #$0005
	jsl.l $C4BC9E
	jsl.l $C4C2AA
	rts
CODE_C5AB16:						; called from other segments
	lda.w $058F
	beq CODE_C5AB1C
CODE_C5AB1B:						; from CODE_C5AB1C
	rts
CODE_C5AB1C:						; from CODE_C5AB16
	lda.w $058D
	bit.w #$3000
	beq CODE_C5AB1B
	jmp.w CODE_C5A51C
CODE_C5AB27:						; called from other segments
	lda.w $058F
	beq CODE_C5AB2D
	rts
CODE_C5AB2D:						; from CODE_C5AB27
	lda.w $058D
	bit.w #$3000
	bne CODE_C5AB69
	bit.w #$0800
	bne CODE_C5AB40
	bit.w #$0400
	bne CODE_C5AB58
	rts
CODE_C5AB40:						; from CODE_C5AB2D
	lda.w #$0015
	jsr.w CODE_C590BB
	lda.w #$0018
	jsr.w CODE_C5909D
	lda.w #$00B5
CODE_C5AB4F:						; from CODE_C5AB58
	ldx.b $63
	sta.b $08,x
	jsl.l $C4C2AA
	rts
CODE_C5AB58:						; from CODE_C5AB2D
	lda.w #$0015
	jsr.w CODE_C5909D
	lda.w #$0018
	jsr.w CODE_C590BB
	lda.w #$00CD
	bra CODE_C5AB4F
CODE_C5AB69:						; from CODE_C5AB2D
	ldx.b $63
	ply
	lda.b $08,x
	cmp.w #$00B5
	bne CODE_C5AB76
	jmp.w CODE_C5963A
CODE_C5AB76:						; from CODE_C5AB69
	ldx.b $63
	lda.w #$0008
	sta.b $05,x
	lda.w #$008C
	sta.b $08,x
	jsr.w CODE_C5ABAE
	lda.w #$0007
	sta.w $1864
	jsr.w CODE_C5ABC4
	lda.w #$C000
	sta.w DMAEnShadow
	jsr.w CODE_C59217
	lda.w #$5CC1
	jsl.l CODE_C59308
	jmp.w $8D44
CODE_C5ABA1:						; called from other segments
	lda.w #$0002
	sta.w $1864
	jsl.l $C4CFF5
	jmp.w CODE_C5963A
CODE_C5ABAE:						; from CODE_C5AB76
	clc
	lda.w #$0400
	adc.b $D3
	ldy.w #$0280
	jsl.l CODE_C58B11
	jsl.l $C4C2AA
	jsl.l $C4CEDB
	rts
CODE_C5ABC4:						; from CODE_C5AB76 and other segments
	lda.w #$001B
	ldx.w #$48E2
	ldy.w #$468C
	mvn $7E,$C0
	lda.w #$FFFF
	sta.w $0100
	sta.w $0102
	sta.w $0104
	sta.w $0106
	sta.w $0108
	sta.w $0110
	stz.w $04BC
	stz.w $04C0
	stz.w $04C4
	sta.w $04BE
	sta.w $04C6
	lda.w #$FFFA
	sta.w $04C2
	lda.w #$FF90
	sta.w $010A
	lda.w #$0010
	sta.w $010E
	rts
CODE_C5AC07:						; called from other segments
	lda.w $058F
	beq CODE_C5AC17
	cmp.w #$0014
	bcc CODE_C5AC2E
	lda.w #$000C
	sta.w $058F
CODE_C5AC17:						; from CODE_C5AC07
	lda.w $058D
	bit.w #$0800
	bne CODE_C5AC43
	bit.w #$0400
	bne CODE_C5AC59
	bit.w #$B000
	bne CODE_C5AC2F
	bit.w #$0040
	bne CODE_C5AC36
CODE_C5AC2E:						; from CODE_C5AC07
	rts
CODE_C5AC2F:						; from CODE_C5AC17
	lda.b $97
	asl a
	tax
	jmp (DATA8_C5AC73,x)
CODE_C5AC36:						; from CODE_C5AC17
	jsl.l FadeOutWait
	lda.w #$0002
	sta.w $1864
	jmp.w CODE_C50056
CODE_C5AC43:						; from CODE_C5AC17
	jsr.w CODE_C5AC7F
	dec.b $97
	bpl CODE_C5AC4F
	lda.w #$0005
	sta.b $97
CODE_C5AC4F:						; from CODE_C5AC43
	jsr.w CODE_C5ACA3
	jsl.l $C4C2AA
	jmp.w CODE_C5A599
CODE_C5AC59:						; from CODE_C5AC17
	jsr.w CODE_C5AC7F
	lda.b $97
	inc a
	cmp.w #$0006
	bcc CODE_C5AC67
	lda.w #$0000
CODE_C5AC67:						; from CODE_C5AC59
	sta.b $97
	jsr.w CODE_C5ACA3
	jsl.l $C4C2AA
	jmp.w CODE_C5A599
DATA8_C5AC73:						; jump table: the routine for each index
	dw CODE_C5AE48,$B17A,CODE_C5ACAA,$AFB6
	dw $B07C,$B0EA
CODE_C5AC7F:						; from CODE_C5AC43, CODE_C5AC59
	lda.w #$0C00
	sta.b $9F
CODE_C5AC84:						; from CODE_C5ACA3
	lda.b $97
	asl a
	adc.b $97
	xba
	lsr a
	lsr a
	adc.b $D3
	tax
	ldy.w #$003F
CODE_C5AC92:						; from CODE_C5AC92
	lda.w $0180,x
	and.w #$E3FF
	ora.b $9F
	sta.w $0180,x
	inx
	inx
	dey
	bpl CODE_C5AC92
	rts
CODE_C5ACA3:						; from CODE_C5AC4F, CODE_C5AC67
	lda.w #$0000
	sta.b $9F
	bra CODE_C5AC84
CODE_C5ACAA:						; from DATA8_C5AC73
	jsl.l FadeOutWait
	jsl.l $C4CEDB
	lda.w $1864
	cmp.w #$0003
	bne CODE_C5ACBE
	jml.l $C40000
CODE_C5ACBE:						; from CODE_C5ACAA
	lda.w #$3CF9
	ldx.w #$00C0
	jsl.l DecompressUnpackbuf
	ldy.w #$5C00
	jsl.l CODE_C589E4
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0600
	pea.w $0130
	pea.w $007E
	pea.w $50DC
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0070
	pea.w $00C0
	pea.w $3EE2
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l $C4CEDB
	ldx.w #$0060
	jsl.l SetupHDMA
	db $40,$2C,$35,$4A,$C0,$7E		; inline parameters
	ldx.w #$0050
	jsl.l SetupHDMA
	db $42,$12,$8C,$46,$7E,$7E		; inline parameters
	ldx.w #$0040
	jsl.l SetupHDMA
	db $42,$10,$14,$49,$C0,$00		; inline parameters
	lda.w #$0015
	sta.w $364E
	lda.w #$0011
	sta.w $3650
	sta.w $3652
	lda.w #$001B
	ldx.w #$48FE
	ldy.w #$468C
	mvn $7E,$C0
	lda.w #$FFFF
	sta.w $0100
	sta.w $0102
	sta.w $0104
	sta.w $0110
	lda.w #$FF2F
	sta.w $0108
	lda.w #$FF4F
	sta.w $010A
	lda.w #$FF2F
	sta.w $0106
	lda.w #$F000
	sta.w DMAEnShadow
	lda.w #$00A7
	sta.b $18
	lda.w #$0046
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $73
	lda.w #$0001
	jsl.l CODE_C5ECBD
	lda.w #$00A4
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $75
	inc.b $38,x
	lda.w #$0002
	jsl.l CODE_C5ECBD
	ldx.b $63
	lda.w #$002D
	sta.b $05,x
	jsl.l $C4C530
	jsl.l $C4BAF6
	lda.w #$568E
	jsl.l $C4BB5A
	jsl.l $C4CEDB
	lda.l $306050
	and.w #$00FF
	sta.b $7F
	lda.w #$0002
	sta.b $81
	stz.b $89
	jsr.w CODE_C5B22D
	jsr.w CODE_C5AAF0
	lda.w #$0007
	sta.b $99
	stz.w fadestep
	rts
CODE_C5ADD8:						; called from other segments
	bit.b $9F
	bpl CODE_C5ADE3
CODE_C5ADDC:						; from CODE_C5AF50, CODE_C5AE56 and other segments
	pla
	jsr.w CODE_C590DA
	jmp.w CODE_C5963A
CODE_C5ADE3:						; from CODE_C5ADD8
	lda.b $D3
	clc
	adc.w #$0180
	ldy.w #$0580
	jsl.l CODE_C58B11
	jsl.l $C4C2AA
	jsl.l $C4CEDB
	lda.w #$2C00
	sta.b $D5
	lda.w #$0032
	sta.b $CF
	ldx.w #$47A1
	ldy.w #$0008
	jsl.l $C4BC26
	ldy.w #$000A
	ldx.w #$47AB
	jsl.l $C4BC26
	lda.w #$2000
	sta.b $D5
	lda.w #$006E
	sta.b $CF
	ldy.w #$000E
	ldx.w #$47B3
	jsl.l $C4BC26
	jsl.l $C4C2AA
	ldx.b $63
	lda.w #$0064
	sta.b $05,x
	lda.w #$007E
	sta.b $08,x
	lda.w #$000C
	sta.b $99
	rts
DATA8_C5AE40:						; not traced: data between routines
	db $FF,$FE,$FC,$F8,$F0,$E0,$C0,$80
CODE_C5AE48:						; from DATA8_C5AC73, CODE_C5AF6E
	stz.b $9F
	lda.w $1864
	cmp.w #$0003
	bne CODE_C5AE56
	jml.l $C401E5
CODE_C5AE56:						; from CODE_C5AE48
	lda.l $306050
	and.w #$00FF
	sta.b $7F
	jsr.w CODE_C5B20E
	lda.b $8F
	and.w #$0007
	tax
	lda.b $8F
	lsr a
	lsr a
	lsr a
	tay
	lda.w #$0002
	sta.w $1864
	lda.l $306050
	and.w #$00FF
	asl a
	tax
	lda.l $C35F60,x
	bne CODE_C5AE8D
	jsl.l $C40D96
	inc.w $1864
	jmp.w CODE_C5ADDC
CODE_C5AE8D:						; from CODE_C5AE56
	lda.b $7F
	asl a
	tax
	lda.l $C360D4,x
	tax
	lda.l $C30000,x
	and.w #$00FF
	sta.w $2C42
	sta.b $9F
	pea.w $7E7F
	plb
	ldy.w #$8EF8
CODE_C5AEA9:						; from CODE_C5AEEB
	lda.l $C30001,x
	and.w #$00FF
	sta.w $0002,y
	lda.l $C30002,x
	and.w #$00FF
	sta.w $0004,y
	lda.w #$0000
	sta.w $0006,y
	sta.w $0008,y
	sta.w $000A,y
	phx
	lda.b $8F
	and.w #$0007
	tax
	lda.l $C4C4A6,x
	and.w #$00FF
	sta.b $A1
	lda.b $8F
	lsr a
	lsr a
	lsr a
	tax
	lda.l $307884,x
	ldx.w #$0000
	and.b $A1
	beq CODE_C5AEEB
	inx
CODE_C5AEEB:						; from CODE_C5AEA9
	txa
	sta.w $0000,y
	plx
	inc.b $8F
	inx
	inx
	tya
	clc
	adc.w #$010A
	tay
	dec.b $9F
	bne CODE_C5AEA9
	lda.l $306051
	beq CODE_C5AF07
	jsr.w CODE_C5E336
CODE_C5AF07:						; from CODE_C5AEEB and other segments
	lda.l $7E2C42
	sta.b $9F
	lda.w #$8EF8
	clc
CODE_C5AF11:						; from CODE_C5AF11
	tax
	lda.w $0000,x
	bne CODE_C5AF71
	txa
	adc.w #$010A
	dec.b $9F
	bne CODE_C5AF11
	plb
	jsr.w CODE_C5E49A
	jsr.w CODE_C5DD47
	jsr.w CODE_C5DE9B
	jsl.l $C4C530
	lda.w #$0001
	sta.w $190E
	stz.w $1910
	jsl.l CODE_C5E50E
	jsr.w $7A7D
	stz.w $190E
	jsl.l $C4C574
	lda.w $1864
	cmp.w #$0003
	bne CODE_C5AF50
	jml.l $C40296
CODE_C5AF50:						; from CODE_C5AF11
	jsr.w CODE_C5DDF0
	jsr.w CODE_C5E17C
	lda.l $306050
	inc a
	sta.l $306050
	lda.w #$0000
	sta.l $306051
	bit.w $1910
	bpl CODE_C5AF6E
	jmp.w CODE_C5ADDC
CODE_C5AF6E:						; from CODE_C5AF50
	jmp.w CODE_C5AE48
CODE_C5AF71:						; from CODE_C5AF11
	lda.w $0004,x
	sta.l $0017C9
	lda.w $0002,x
	plb
	sta.w $17CB
	stx.w $2C44
	jsl.l $C4C574
	jsl.l $C4C530
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	wai
	jsr.w CODE_C55951
	jsl.l CODE_C5E50E
	lda.w #$FFFA
	sta.w $04C2
	jsr.w CODE_C5C0BE
	sep #$20
	lda.b #$17
	sta.l TM
	rep #$20
	stz.b $63
	stz.b $73
	stz.b $75
	pla
	jmp.w CODE_C593B1

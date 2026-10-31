; Segment bankC5_B000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C5AFB6
CODE_C5AFB6:						; called from other segments
	jsl.l FadeOutWait
	ldx.b $63
	lda.w #$FC18
	sta.b $05,x
	sta.b $08,x
	stz.b $77
	stz.b $79
	stz.b $85
	pea.w $0000
CODE_C5AFCC:						; called from other segments
	ldx.b $77
	jsl.l CODE_C5E596
	ldx.b $79
	jsl.l CODE_C5E596
	ldy.w #$5C00
	jsl.l CODE_C589B0
	jsl.l $C4C530
	jsl.l $C4BAF6
	jsl.l $C4CEDB
	pla
	jsr.w CODE_C5B631
	ldx.w #$559D
	lda.b $85
	lsr a
	bcc CODE_C5AFFA
	ldx.w #$55AD
CODE_C5AFFA:						; from CODE_C5AFCC
	ldy.w #$0018
	sty.b $CF
	jsl.l $C4BBFC
	lda.w #$027E
	sta.b $9F
CODE_C5B008:						; from CODE_C5B008
	lda.b $9F
	dec a
	sta.b $9F
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	jsr.w CODE_C5D804
	beq CODE_C5B008
	lda.w #$0010
	jsl.l $C4C547
	sta.b $7F
	sta.b $81
	tay
	lda.b $9F
	jsr.w CODE_C5B4C2
	dec.b $9F
CODE_C5B02B:						; from CODE_C5B02B
	jsr.w CODE_C5B558
	dec.b $9F
	bpl CODE_C5B02B
	jsl.l $C4C541
	lda.b $81
	ldy.w #$FFFE
CODE_C5B03B:						; from CODE_C5B049
	tax
	lda.w $0006,x
	eor.b $85
	bne CODE_C5B049
	iny
	iny
	txa
	sta.w $3E4E,y
CODE_C5B049:						; from CODE_C5B03B
	lda.w $0002,x
	bne CODE_C5B03B
	tya
	lsr a
	sta.b $67
	lda.w #$556D
	jsl.l $C4BB5A
	jsl.l $C4CEDB
	stz.b $69
	lda.w #CODE_C5B6A1
	ldx.w #$000D
	ldy.w #$0009
	jsr.w $5ABC
	jsl.l $C4C2AA
	jsl.l $C4CEDB
	lda.w #$0008
	sta.b $99
	stz.w fadestep
	rts
CODE_C5B07C:						; called from other segments
	jsl.l FadeOutWait
	ldx.b $63
	lda.w #$FC18
	sta.b $05,x
	sta.b $08,x
	lda.w #$8000
	sta.w DMAEnShadow
	lda.w #$FFFA
	sta.w $04C2
	ldy.w #$5C00
	jsl.l CODE_C589B0
	jsl.l $C4CEDB
	sep #$20
	lda.b #$11
	sta.l TM
	rep #$20
	jsl.l $C4C530
	jsl.l $C4BAF6
	lda.w #$55F1
	jsl.l $C4BB5A
	jsl.l $C4CEDB
	ldy.w #$2801
	ldx.w #$50A8
	jsl.l $C387D8
	stz.w $17C9
	stz.b $9B
	jsr.w CODE_C5B7F1
	jsl.l $C4C2AA
	jsl.l $C4CEDB
	sep #$20
	lda.b #$17
	sta.l TM
	rep #$20
	lda.w #$0009
	sta.b $99
	stz.w fadestep
	rts
CODE_C5B0EA:						; called from other segments
	jsl.l FadeOutWait
	stz.b $7F
	ldx.b $63
	lda.w #$FC18
	sta.b $05,x
	sta.b $08,x
	lda.w #$8000
	sta.w DMAEnShadow
	lda.w #$FFFA
	sta.w $04C2
	ldy.w #$5C00
	jsl.l CODE_C589B0
	jsl.l $C4CEDB
	sep #$20
	lda.b #$11
	sta.l TM
	rep #$20
	jsl.l $C4C530
	jsl.l $C4BAF6
	lda.w #$5583
	jsl.l $C4BB5A
	jsl.l $C4CEDB
	ldy.w #$2801
	ldx.w #$50A8
	jsl.l $C387D8
	lda.w #$0002
	sta.w $1864
	stz.w $17C9
	jsr.w $2CC1
	sec
	lda.w $2DC9
	sbc.w $2DCB
	sta.b $67
	stz.b $69
	lda.w #CODE_C5BBDD
	ldx.w #$000C
	ldy.w #$000B
	jsr.w $5ABC
	stz.b $9B
	jsr.w CODE_C5BCD9
	jsl.l $C4C2AA
	jsl.l $C4CEDB
	sep #$20
	lda.b #$17
	sta.l TM
	rep #$20
	lda.w #$000A
	sta.b $99
	stz.w fadestep
	rts
CODE_C5B17A:						; called from other segments
	jsl.l FadeOutWait
	ldx.b $63
	lda.w #$FC18
	sta.b $05,x
	sta.b $08,x
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5C00
	jsl.l CODE_C589B0
	jsl.l $C4C530
	jsl.l $C4BAF6
	lda.w #$5553
	jsl.l $C4BB5A
	jsl.l $C4CEDB
	stz.b $7F
	jsl.l CODE_C5E37E
	stz.b $83
CODE_C5B1AF:						; called from other segments
	jsr.w CODE_C5C029
	jsr.w CODE_C5BFE0
	stz.b $69
	lda.w #CODE_C5BE72
	ldx.w #$000D
	ldy.w #$0009
	jsr.w $5ABC
	lda.b $7F
	asl a
	tax
	lda.l DATA8_C5B1FE,x
	tax
	ldy.w #$0007
	lda.w #$00F0
	sta.b $D1
	jsl.l $C4BC0E
	lda.w #$0010
	sta.b $CF
	lda.b $83
	asl a
	tax
	lda.l $C04CB7,x
	tax
	ldy.w #$0013
	jsl.l $C4BCA4
	jsl.l $C4C2AA
	jsl.l $C4CEDB
	lda.w #$000B
	sta.b $99
	stz.w fadestep
	rts
DATA8_C5B1FE:						; not traced: a table read by CODE_C5B1AF
	db $2E,$56,$75,$4B,$3D,$56,$4C,$56,$5C,$56,$6B,$56,$76,$56,$83,$56
CODE_C5B20E:						; from CODE_C5B22D and other segments
	stz.b $8F
	lda.b $7F
	asl a
	tax
	bra CODE_C5B228
CODE_C5B216:						; from CODE_C5B228
	txy
	lda.l $C360D4,x
	tax
	lda.l $C30000,x
	and.w #$00FF
	tyx
	adc.b $8F
	sta.b $8F
CODE_C5B228:						; from CODE_C5B20E
	dex
	dex
	bpl CODE_C5B216
	rts
CODE_C5B22D:						; called from other segments
	jsr.w CODE_C5B20E
	lda.w #$FFFA
	sta.w $04C2
	lda.w #$00EB
	sta.b $8B
	asl a
	adc.b $D3
	ldy.w #$0540
	jsl.l CODE_C58B11
	jsl.l $C4C2AA
	ldy.w #$5000
	jsl.l CODE_C589E4
	jsl.l $C4CEDB
	lda.w #$0011
	sta.w $3652
	ldx.b $63
	lda.w #$0060
	sta.b $08,x
	lda.w #$0058
	sta.b $CF
	lda.w #$00A0
	sta.b $D1
	lda.b $7F
	asl a
	tax
	lda.l $C360D4,x
	sta.b $83
	stz.b $85
	tax
	lda.l $C30000,x
	and.w #$00FF
	sta.b $87
	jsr.w CODE_C5B33C
	pha
	ldx.b $83
	lda.l $C30001,x
	pha
	and.w #$00FF
	ldx.w #$0020
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l $C3585C,x
	tax
	jsl.l $C4BCAA
	pla
	xba
	and.w #$00FF
	ldx.w #$0030
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l $C3585C,x
	tax
	pla
	adc.w #$0003
	tay
	jsl.l $C4BCAA
	jsr.w CODE_C5B38F
	sec
	jsr.w CODE_C5B33C
	ldx.b $87
	dex
	beq CODE_C5B315
	pha
	ldx.b $83
	lda.l $C30003,x
	pha
	and.w #$00FF
	ldx.w #$0040
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l $C3585C,x
	tax
	jsl.l $C4BCAA
	clc
	pei ($8B)
	lda.b $8B
	adc.w #$00E0
	and.w #$03FF
	sta.b $8B
	inc.b $85
	jsr.w CODE_C5B38F
	dec.b $85
	pla
	sta.b $8B
	pla
	xba
	and.w #$00FF
	ldx.w #$0050
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l $C3585C,x
	tax
	pla
	adc.w #$0003
	tay
	jsl.l $C4BCAA
CODE_C5B315:						; from CODE_C5B22D
	jsl.l $C4CEDB
	lda.w #$0017
	sta.w $3652
	ldx.b $73
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	ldx.b $75
	lda.b $22,x
	and.w #$FFFE
	ldy.b $87
	cpy.w #$0003
	bcc CODE_C5B339
	ora.w #$0001
CODE_C5B339:						; from CODE_C5B315
	sta.b $22,x
	rts
CODE_C5B33C:						; from CODE_C5B22D
	lda.b $81
	sbc.w #$0001
	bcs CODE_C5B346
	adc.w #$0003
CODE_C5B346:						; from CODE_C5B33C
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
	rts
DATA8_C5B35D:						; not traced: a table read by CODE_C5B346
	db $00,$02,$C0,$03,$80,$05
DATA8_C5B363:						; not traced: a table read by CODE_C5B346
	db $09,$00,$10,$00,$17,$00
CODE_C5B369:						; from CODE_C5B22D and other segments
	sta.b $A1
	dec.b QueueBusy
	tsc
	sta.b $9F
	lda.b $04
	tcs
	pea.w $0020
	phx
	pea.w $007F
	lda.b $A1
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$D80A
	pha
	tsc
	sta.b $04
	lda.b $9F
	tcs
	stz.b QueueBusy
	lda.b $A1
	rts
CODE_C5B38F:						; from CODE_C5B22D and other segments
	jsl.l $C4CEDB
	phd
	lda.b $85
	lsr a
	ldx.w #$2801
	bcc CODE_C5B39F
	ldx.w #$3001
CODE_C5B39F:						; from CODE_C5B38F
	lda.b $8B
	ora.w #$5000
	tay
	lda.w #$2100
	tcd
	lda.w #$0080
	sta.b $15
	jsr.w CODE_C5B4B6
	jsr.w CODE_C5B4A1
	jsr.w CODE_C5B4A1
	jsr.w CODE_C5B4B6
	txa
	clc
	adc.w #$0400
	and.w #$FC00
	ora.w #$0001
	tax
	jsr.w CODE_C5B4A1
	jsr.w CODE_C5B4A1
	jsr.w CODE_C5B4B6
	tya
	sec
	sbc.w #$00E4
	and.w #$03FF
	ora.w #$5000
	tay
	lda.w $008F
	clc
	adc.w $0085
	pha
	and.w #$0007
	tax
	lda.l $C4C4A6,x
	and.w #$00FF
	sta.w $009F
	pla
	lsr a
	lsr a
	lsr a
	tax
	lda.l $306050
	and.w #$00FF
	cmp.w $007F
	beq CODE_C5B43E
	bcc CODE_C5B464
	lda.l $307884,x
	ldx.w #$3C33
	and.w $009F
	beq CODE_C5B427
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B4AE
	pld
	rts
CODE_C5B427:						; from CODE_C5B39F
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	pld
	rts
CODE_C5B43E:						; from CODE_C5B39F
	phx
	ldx.w $0085
	lda.l $306051
CODE_C5B446:						; from CODE_C5B446
	lsr a
	dex
	bpl CODE_C5B446
	plx
	bcc CODE_C5B464
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	pld
	rts
CODE_C5B464:						; from CODE_C5B39F, CODE_C5B446
	lda.l $307884,x
	ldx.w #$3C13
	and.w $009F
	bne CODE_C5B473
	ldx.w #$3C23
CODE_C5B473:						; from CODE_C5B464
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	pld
	rts
CODE_C5B48A:						; from CODE_C5B4B6, CODE_C5B4A1, CODE_C5B4AE, CODE_C5B499
	sty.b $16
	tya
	clc
	adc.w #$0020
	and.w #$03FF
	ora.w #$5000
	tay
	rts
CODE_C5B499:						; from CODE_C5B39F, CODE_C5B473, CODE_C5B427
	jsr.w CODE_C5B48A
	lda.w #$0003
	bra CODE_C5B4A7
CODE_C5B4A1:						; from CODE_C5B39F
	jsr.w CODE_C5B48A
	lda.w #$0008
CODE_C5B4A7:						; from CODE_C5B4A7, CODE_C5B499
	stx.b $18
	inx
	dec a
	bpl CODE_C5B4A7
	rts
CODE_C5B4AE:						; from CODE_C5B39F, CODE_C5B446, CODE_C5B473, CODE_C5B427
	jsr.w CODE_C5B48A
	lda.w #$0003
	bra CODE_C5B4BC
CODE_C5B4B6:						; from CODE_C5B39F
	jsr.w CODE_C5B48A
	lda.w #$0008
CODE_C5B4BC:						; from CODE_C5B4BC, CODE_C5B4AE
	stz.b $18
	dec a
	bpl CODE_C5B4BC
	rts
CODE_C5B4C2:						; from CODE_C5B008, CODE_C5B558
	pha
	sta.w $0004,y
	jsr.w CODE_C5B5EE
	sta.w $000E,y
	lda.b $01,s
	jsr.w CODE_C5B53D
	bcc CODE_C5B4F7
	lda.b $01,s
	jsr.w CODE_C5BD56
	sta.w $0008,y
	lda.b $01,s
	jsr.w CODE_C5BD81
	sta.w $000A,y
	clc
	sed
	lda.w $0008,y
	adc.w $000A,y
	sta.w $000C,y
	cld
	tyx
	stz.w $0006,x
	pla
	sta.b $9F
	rts
CODE_C5B4F7:						; from CODE_C5B4C2
	lda.w #$0001
	sta.w $0006,y
	lda.b $01,s
	jsr.w CODE_C5BDAC
	sta.w $0008,y
	pei ($9F)
	pei ($9F)
	lda.b $05,s
	jsr.w CODE_C5BE37
	clc
	sed
	adc.w $0008,y
	sta.w $000A,y
	cld
	plx
	lda.w #$0064
	phy
	jsl.l $C08F5E
	ply
	stz.b $32
	pla
	clc
	adc.b $9F
	sta.b $30
	beq CODE_C5B533
	phy
	jsl.l $C09113
	ply
	lda.b $2C
CODE_C5B533:						; from CODE_C5B4F7
	jsr.w CODE_C5B67A
	sta.w $000C,y
	pla
	sta.b $9F
	rts
CODE_C5B53D:						; from CODE_C5B4C2
	cmp.w #$026A
	bcc CODE_C5B54E
	phy
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	cmp.w #$0001
	ply
	rts
CODE_C5B54E:						; from CODE_C5B53D
	asl a
	tax
	lda.l $C30038,x
	cmp.w #$4000
	rts
CODE_C5B558:						; from CODE_C5B02B
	lda.w #$0010
	jsl.l $C4C558
	tay
	lda.b $9F
	jsr.w CODE_C5B4C2
	lda.b $83
	asl a
	tax
	jmp (DATA8_C5B56C,x)
DATA8_C5B56C:						; jump table: the routine for each index
	dw CODE_C5B59E,CODE_C5B572,CODE_C5B588
CODE_C5B572:						; called from other segments
	lda.w $000A,y
	sta.b $A1
	lda.b $7F
CODE_C5B579:						; from CODE_C5B579
	tax
	lda.w $000A,x
	cmp.b $A1
	bcs CODE_C5B5D7
	lda.w $0000,x
	bne CODE_C5B579
	bra CODE_C5B5B2
CODE_C5B588:						; called from other segments
	lda.w $000C,y
	sta.b $A1
	lda.b $7F
CODE_C5B58F:						; from CODE_C5B58F
	tax
	lda.w $000C,x
	cmp.b $A1
	bcs CODE_C5B5D7
	lda.w $0000,x
	bne CODE_C5B58F
	bra CODE_C5B5B2
CODE_C5B59E:						; called from other segments
	lda.w $0008,y
	sta.b $A1
	lda.b $7F
CODE_C5B5A5:						; from CODE_C5B5A5
	tax
	lda.w $0008,x
	cmp.b $A1
	bcs CODE_C5B5D7
	lda.w $0000,x
	bne CODE_C5B5A5
CODE_C5B5B2:						; from CODE_C5B579, CODE_C5B58F
	sty.b $81
	tya
	sta.w $0000,x
	txa
	tyx
	stz.w $0000,x
	sta.w $0002,y
	rts
CODE_C5B5C1:						; from CODE_C5B5D7
	lda.w $0002,x
	sta.w $0002,y
	sta.b $A3
	txa
	sta.w $0000,y
	tya
	sta.w $0002,x
	ldx.b $A3
	sta.w $0000,x
	rts
CODE_C5B5D7:						; from CODE_C5B5A5, CODE_C5B579, CODE_C5B58F
	cpx.b $7F
	bne CODE_C5B5C1
	sty.b $7F
	txa
	sta.w $0000,y
	tya
	sta.w $0002,x
	tyx
	stz.w $0002,x
	rts
CODE_C5B5EA:						; called from other segments
	jsr.w CODE_C5B5EE
	rtl
CODE_C5B5EE:						; from CODE_C5B5EA, CODE_C5B4C2
	sta.b $A1
	asl a
	adc.b $A1
	lsr a
	tax
	lda.l $306A56,x
	sta.b $A1
	bcc CODE_C5B618
	xba
	lsr a
	and.w #$007F
	tax
	lda.l $C08C75,x
	and.w #$FF00
	pha
	lda.b $A1
	and.w #$01F0
	lsr a
	lsr a
	lsr a
	lsr a
	ora.b $01,s
	plx
	rts
CODE_C5B618:						; from CODE_C5B5EE
	asl a
	asl a
	asl a
	xba
	and.w #$007F
	tax
	lda.l $C08C75,x
	and.w #$FF00
	pha
	lda.b $A1
	and.w #$001F
	ora.b $01,s
	plx
	rts
CODE_C5B631:						; from CODE_C5AFCC
	sta.b $83
	asl a
	tax
	lda.b $85
	lsr a
	lda.l DATA8_C5B66A,x
	bcc CODE_C5B642
	lda.l DATA8_C5B670,x
CODE_C5B642:						; from CODE_C5B631
	pha
	lda.b $D3
	clc
	adc.w #$01AA
	pha
	ldy.w #$0016
	phy
	jsl.l CODE_C58B11
	ply
	pla
	clc
	adc.w #$0040
	jsl.l CODE_C58B11
	plx
	ldy.w #$0007
	lda.w #$00F6
	sta.b $D1
	jsl.l $C4BC0E
	rts
DATA8_C5B66A:						; not traced: a table read by CODE_C5B631
	db $6A,$4B,$6F,$4B,$75,$4B
DATA8_C5B670:						; not traced: a table read by CODE_C5B631
	db $7A,$4B,$9E,$4B,$5C,$56
CODE_C5B676:						; called from other segments
	jsr.w CODE_C5B67A
	rtl
CODE_C5B67A:						; from CODE_C5B676, CODE_C5B6A1, CODE_C5B7F1, CODE_C5BE72, ...
	pei ($9F)
	stz.b $9F
CODE_C5B67E:						; from CODE_C5B67E
	cmp.w #$0064
	bcc CODE_C5B693
	sbc.w #$0064
	tax
	sed
	lda.b $9F
	adc.w #$0099
	sta.b $9F
	cld
	txa
	bra CODE_C5B67E
CODE_C5B693:						; from CODE_C5B67E
	tax
	lda.l $C08C76,x
	and.w #$00FF
	ora.b $9F
	plx
	stx.b $9F
	rts
CODE_C5B6A1:						; a callback: CODE_C5B049 passes it to a list routine in bankC5_5000
	lda.w #$000A
	sta.b $CF
	lda.b $6F
	inc a
	jsr.w CODE_C5B67A
	jsr.w $5EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l $C4BC08
	lda.w #$0022
	sta.b $CF
	lda.b $6F
	asl a
	tax
	lda.w $3E4E,x
	tax
	lda.w $0004,x
	cmp.w #$026A
	bcs CODE_C5B6D0
	jmp.w CODE_C5B76D
CODE_C5B6D0:						; from CODE_C5B6A1
	phx
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	ldx.w #$0000
	stx.b $A1
CODE_C5B6DC:						; from CODE_C5B6F6
	phx
	jsr.w CODE_C5D804
	plx
	cmp.w #$0000
	beq CODE_C5B706
	cmp.w #$001D
	bne CODE_C5B6F0
	lda.w #$003D
	bra CODE_C5B6F6
CODE_C5B6F0:						; from CODE_C5B6DC
	clc
	adc.w #$0040
	adc.b $A1
CODE_C5B6F6:						; from CODE_C5B6DC
	sta.w $04F5,x
	lda.w #$0020
	sta.b $A1
	inx
	cpx.w #$0008
	bne CODE_C5B6DC
	bra CODE_C5B715
CODE_C5B706:						; from CODE_C5B6DC
	phx
CODE_C5B707:						; from CODE_C5B707
	cpx.w #$0007
	beq CODE_C5B714
	phx
	jsr.w CODE_C5D804
	plx
	inx
	bra CODE_C5B707
CODE_C5B714:						; from CODE_C5B707
	plx
CODE_C5B715:						; from CODE_C5B6F6
	lda.w #$0020
	sta.w $04F5,x
	stz.b $A1
	inx
	phx
CODE_C5B71F:						; from CODE_C5B739
	phx
	jsr.w CODE_C5D804
	plx
	cmp.w #$0000
	beq CODE_C5B74D
	cmp.w #$001D
	bne CODE_C5B733
	lda.w #$003D
	bra CODE_C5B739
CODE_C5B733:						; from CODE_C5B71F
	clc
	adc.w #$0040
	adc.b $A1
CODE_C5B739:						; from CODE_C5B71F
	sta.w $04F5,x
	lda.w #$0020
	sta.b $A1
	inx
	txa
	sec
	sbc.b $01,s
	cmp.w #$000A
	bcc CODE_C5B71F
	bra CODE_C5B75E
CODE_C5B74D:						; from CODE_C5B71F, CODE_C5B74D
	txa
	sec
	sbc.b $01,s
	cmp.w #$0009
	beq CODE_C5B75E
	phx
	jsr.w CODE_C5D804
	plx
	inx
	bra CODE_C5B74D
CODE_C5B75E:						; from CODE_C5B74D, CODE_C5B739
	plx
	sty.b $65
	ldx.w #$04F5
	lda.w #$000C
	jsl.l $C55F8A
	bra CODE_C5B781
CODE_C5B76D:						; from CODE_C5B6A1
	phx
	asl a
	tax
	lda.l $C30038,x
	adc.w #$0008
	and.w #$3FFF
	tax
	lda.w #$000C
	jsr.w $5F98
CODE_C5B781:						; from CODE_C5B75E
	ldy.b $6D
	jsl.l $C4BC08
	plx
	phx
	lda.w #$0094
	sta.b $CF
	lda.w $000F,x
	jsr.w CODE_C5A321
	ldy.b $6D
	ldx.w #$04F7
	jsl.l $C4BC08
	plx
	phx
	lda.w $000E,x
	and.w #$00FF
	cmp.w #$001A
	bcc CODE_C5B7AF
	ldx.w #$484C
	bra CODE_C5B7C6
CODE_C5B7AF:						; from CODE_C5B781
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l $C4C3BA
	ldx.b $16
	lda.b $0A
	beq CODE_C5B7C6
	inx
CODE_C5B7C6:						; from CODE_C5B781, CODE_C5B7AF
	jsl.l $C4C3BA
	lda.w #$00A8
	sta.b $CF
	ldy.b $6D
	jsl.l $C4BC08
	lda.w #$00F0
	sta.b $D1
	lda.b $83
	asl a
	adc.b $01,s
	tax
	lda.w $0008,x
	jsr.w $5EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l $C4BC1A
	plx
	rts
CODE_C5B7F1:						; from CODE_C5B07C and other segments
	lda.w #$00D4
	sta.b $18
	lda.w #$0025
	sta.b $1A
	jsr.w CODE_C5BCE3
	lda.w #$000F
	sta.b $9F
	clc
	lda.b $D3
	adc.w #$022C
	jsr.w CODE_C5B96D
	lda.w #$0001
	sta.b $9F
	clc
	lda.b $D3
	adc.w #$0266
	jsr.w CODE_C5B96D
	jsl.l $C4C2AA
	jsl.l $C4CEDB
	lda.w #$00F8
	sta.b $D1
	lda.w $17C9
	jsr.w CODE_C5B983
	phy
	lda.w $0004,y
	jsr.w CODE_C5B67A
	jsr.w $5EC7
	lda.w #$003E
	sta.w $04F5,x
	inx
	lda.w $0006,y
	phx
	jsr.w CODE_C5B67A
	plx
	jsr.w $5ECA
	lda.w #$003E
	sta.w $04F5,x
	inx
	lda.w $0008,y
	phx
	jsr.w CODE_C5B67A
	plx
	jsr.w $5ECA
	ldx.w #$04F5
	ldy.w #$0009
	jsl.l $C4BC20
	ply
	phy
	lda.w $0010,y
	jsr.w CODE_C5B67A
	sta.b $34
	xba
	and.w #$00FF
	jsr.w $5EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b $34
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w $5ECA
	lda.b $34
	and.w #$000F
	jsr.w $5ECA
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l $C4BC20
	ply
	phy
	lda.w $0012,y
	jsr.w CODE_C5B67A
	sta.b $34
	xba
	and.w #$00FF
	jsr.w $5EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b $34
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w $5ECA
	lda.b $34
	and.w #$000F
	jsr.w $5ECA
	ldx.w #$04F5
	ldy.w #$000D
	jsl.l $C4BC20
	ply
	phy
	lda.w $0014,y
	jsr.w CODE_C5B67A
	jsr.w $5EC7
	ldx.w #$04F5
	ldy.w #$000F
	jsl.l $C4BC20
	ply
	phy
	lda.w $0016,y
	jsr.w CODE_C5B67A
	jsr.w $5EC7
	ldx.w #$04F5
	ldy.w #$0011
	jsl.l $C4BC20
	ply
	phy
	lda.w $001A,y
	jsr.w CODE_C5B67A
	sta.b $34
	xba
	and.w #$00FF
	jsr.w $5EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b $34
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w $5ECA
	lda.b $34
	and.w #$000F
	jsr.w $5ECA
	ldx.w #$04F5
	ldy.w #$0013
	jsl.l $C4BC20
	ply
	phy
	lda.w $0030,y
	jsr.w CODE_C5B67A
	sta.b $34
	xba
	and.w #$00FF
	jsr.w $5EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b $34
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w $5ECA
	lda.b $34
	and.w #$000F
CODE_C5B95A:						; called from other segments
	jsr.w $5ECA
	ldx.w #$04F5
	ldy.w #$0015
	jsl.l $C4BC20
	ply
	jsl.l $C4C2AA
	rts
CODE_C5B96D:						; from CODE_C5B7F1, CODE_C5B96D
	pha
	ldy.w #$0014
	jsl.l CODE_C58B11
	pla
	clc
	adc.w #$0040
	dec.b $9F
	bpl CODE_C5B96D
	rts
CODE_C5B97F:						; called from other segments
	jsr.w CODE_C5B983
	rtl
CODE_C5B983:						; from CODE_C5B7F1, CODE_C5B97F and other segments
	tax
	lda.w #$0032
	jsl.l $C4C558
	tay
	txa
	sta.w $000C,y
	phy
	ldx.w #$0083
	jsl.l $C0906C
	ply
	lda.w #$000C
	jsr.w CODE_C5BB46
	sta.w $000E,y
	lda.w #$000D
	jsr.w CODE_C5BB46
	sta.w $0018,y
	lda.w #$000E
	jsr.w CODE_C5BB46
	sta.w $001C,y
	lda.w #$000B
	jsr.w CODE_C5BB46
	sta.w $001E,y
	lda.w #$000B
	jsr.w CODE_C5BB46
	sta.w $0020,y
	lda.w #$000B
	jsr.w CODE_C5BB46
	sta.w $0022,y
	lda.w #$000B
	jsr.w CODE_C5BB46
	sta.w $0024,y
	lda.w #$000B
	jsr.w CODE_C5BB46
	sta.w $0026,y
	lda.w #$000B
	jsr.w CODE_C5BB46
	sta.w $0028,y
	lda.w #$000C
	jsr.w CODE_C5BB46
	sta.w $002A,y
	lda.w #$000E
	jsr.w CODE_C5BB46
	sta.w $002E,y
	lda.w $000C,y
	ldx.w #$0015
	phy
	jsl.l Mul8U
	plx
	tay
	stz.b $2C
	stz.b $2E
	lda.w #$0014
	sta.b $30
	phx
	sep #$20
	phb
	lda.b #$30
	pha
	plb
CODE_C5BA1A:						; from CODE_C5BA1A
	lda.w $606D,y
	sta.b $32
	and.b #$03
	tax
	inc.b $2C,x
	lda.b $32
	lsr a
	lsr a
	sta.b $32
	and.b #$03
	tax
	inc.b $2C,x
	lda.b $32
	lsr a
	lsr a
	sta.b $32
	and.b #$03
	tax
	inc.b $2C,x
	lda.b $32
	lsr a
	lsr a
	tax
	inc.b $2C,x
	iny
	dex
	dec.b $30
	bpl CODE_C5BA1A
	rep #$20
	plb
	ply
	lda.b $2D
	and.w #$00FF
	sta.w $0004,y
	lda.b $2E
	and.w #$00FF
	sta.w $0006,y
	lda.b $2F
	and.w #$00FF
	sta.w $0008,y
	lda.w $0004,y
	asl a
	adc.w $0008,y
	sta.w $000A,y
	lda.w #$0054
	sec
	stz.b $2D
	sbc.b $2C
	sta.w $002C,y
	ldx.w $000E,y
	lda.w #$0064
	phy
	jsl.l $C08F5E
	ply
	phy
	stz.b $32
	lda.w $002C,y
	sta.b $30
	beq CODE_C5BA94
	jsl.l $C09113
	lda.b $2C
CODE_C5BA94:						; from CODE_C5BA1A
	ply
	sta.w $0010,y
	ldx.w $002A,y
	lda.w #$0064
	phy
	jsl.l $C08F5E
	ply
	phy
	stz.b $32
	lda.w $002C,y
	sta.b $30
	beq CODE_C5BAB4
	jsl.l $C09113
	lda.b $2C
CODE_C5BAB4:						; from CODE_C5BA94
	ply
	sta.w $0012,y
	sec
	lda.w $002E,y
	sbc.w $002A,y
	tax
	lda.w #$0064
	phy
	jsl.l $C08F5E
	ply
	phy
	stz.b $32
	lda.w $002E,y
	sta.b $30
	beq CODE_C5BAD9
	jsl.l $C09113
	lda.b $2C
CODE_C5BAD9:						; from CODE_C5BAB4
	ply
	sta.w $0014,y
	sec
	ldx.w $000E,y
	lda.w #$0064
	phy
	jsl.l $C08F5E
	ply
	phy
	stz.b $32
	lda.w $0018,y
	sta.b $30
	beq CODE_C5BAFA
	jsl.l $C09113
	lda.b $2C
CODE_C5BAFA:						; from CODE_C5BAD9
	ply
	sta.w $0016,y
	ldx.w $0018,y
	lda.w #$0064
	phy
	jsl.l $C08F5E
	ply
	phy
	stz.b $32
	lda.w $002C,y
	sta.b $30
	beq CODE_C5BB1A
	jsl.l $C09113
	lda.b $2C
CODE_C5BB1A:						; from CODE_C5BAFA
	ply
	sta.w $001A,y
	ldx.w $002E,y
	lda.w #$0064
	phy
	jsl.l $C08F5E
	ply
	phy
	stz.b $32
	lda.w $002C,y
	sta.b $30
	beq CODE_C5BB3A
	jsl.l $C09113
	lda.b $2C
CODE_C5BB3A:						; from CODE_C5BB1A
	ply
	sta.w $0030,y
	tyx
	stz.w $0000,x
	stz.w $0002,x
	rts
CODE_C5BB46:						; from CODE_C5B983
	sta.b $30
	lda.b $34
	lsr a
	lsr a
	lsr a
	tax
	lda.l $306E43,x
	sta.b $2C
	lda.l $306E45,x
	sta.b $2E
	lda.b $34
	and.w #$0007
	asl a
	tax
	lda.b $30
	adc.b $34
	sta.b $34
	lda.b $2E
	jmp (DATA8_C5BB6C,x)
DATA8_C5BB6C:						; jump table: the routine for each index
	dw CODE_C5BB91,CODE_C5BB8E,CODE_C5BB8B,CODE_C5BB88
	dw CODE_C5BB85,CODE_C5BB82,CODE_C5BB7F,CODE_C5BB7C
CODE_C5BB7C:						; called from other segments
	lsr a
	ror.b $2C
CODE_C5BB7F:						; called from other segments
	lsr a
	ror.b $2C
CODE_C5BB82:						; called from other segments
	lsr a
	ror.b $2C
CODE_C5BB85:						; called from other segments
	lsr a
	ror.b $2C
CODE_C5BB88:						; called from other segments
	lsr a
	ror.b $2C
CODE_C5BB8B:						; called from other segments
	lsr a
	ror.b $2C
CODE_C5BB8E:						; called from other segments
	lsr a
	ror.b $2C
CODE_C5BB91:						; called from other segments
	lda.b $30
	asl a
	tax
	lda.b $2C
	and.l DATA8_C5BB9C-2,x
	rts
DATA8_C5BB9C:						; not traced: a table read by CODE_C5BB91
	db $01,$00,$03,$00,$07,$00,$0F,$00,$1F,$00,$3F,$00,$7F,$00,$FF,$00
	db $FF,$01,$FF,$03,$FF,$07,$FF,$0F,$FF,$1F,$FF,$3F,$FF,$7F,$FF,$FF
CODE_C5BBBC:						; called from other segments
	jsr.w CODE_C5BBC0
	rtl
CODE_C5BBC0:						; from CODE_C5BBBC, CODE_C5BCE3 and other segments
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	jsl.l $C4CEDB
	rts
CODE_C5BBDD:						; a callback: CODE_C5A71A, CODE_C5B0EA pass it to a bankC5_5000 routine
	lda.w #$000C
	sta.b $CF
	lda.b $7F
	bne CODE_C5BBE9
	jmp.w CODE_C5BC6C
CODE_C5BBE9:						; from CODE_C5BBDD
	clc
	lda.b $6F
	asl a
	tax
	phx
	asl a
	asl a
	asl a
	asl a
	adc.w #$2EE1
	tax
	lda.w #$000C
	jsl.l $C55F8A
	ldy.b $6D
	jsl.l $C4BC08
	plx
	lda.w $2E03,x
	pha
	jsr.w CODE_C5BD30
	jsr.w CODE_C5A321
	lda.w #$0072
	sta.b $CF
	ldx.w #$04F7
	ldy.b $6D
	jsl.l $C4BC08
	lda.w #$0093
	sta.b $CF
	lda.b $01,s
	jsr.w CODE_C5BDAC
	pei ($9F)
	pha
	jsr.w CODE_C5BCCC
	lda.w #$00B5
	sta.b $CF
	lda.b $05,s
	jsr.w CODE_C5BE37
	pei ($9F)
	clc
	sed
	adc.b $03,s
	cld
	jsr.w CODE_C5BCCC
	lda.w #$00D7
	sta.b $CF
	clc
	lda.b $05,s
	tax
	lda.w #$0064
	jsl.l $C08F5E
	stz.b $32
	clc
	lda.b $05,s
	adc.b $01,s
	sta.b $30
	beq CODE_C5BC62
	jsl.l $C09113
	lda.b $2C
CODE_C5BC62:						; from CODE_C5BBE9
	jsr.w CODE_C5B67A
	plx
	plx
	plx
	plx
	jmp.w CODE_C5BCCC
CODE_C5BC6C:						; from CODE_C5BBDD
	clc
	lda.w $2DCB
	adc.b $6F
	asl a
	tax
	phx
	asl a
	asl a
	asl a
	asl a
	adc.w #$2EE1
	tax
	lda.w #$000C
	jsl.l $C55F8A
	ldy.b $6D
	jsl.l $C4BC08
	plx
	lda.w $2E03,x
	pha
	jsr.w CODE_C5BD30
	jsr.w CODE_C5A321
	lda.w #$0072
	sta.b $CF
	ldx.w #$04F7
	ldy.b $6D
	jsl.l $C4BC08
	lda.w #$0093
	sta.b $CF
	lda.b $01,s
	jsr.w CODE_C5BD56
	pha
	jsr.w CODE_C5BCCC
	lda.w #$00B5
	sta.b $CF
	lda.b $03,s
	jsr.w CODE_C5BD81
	pha
	jsr.w CODE_C5BCCC
	lda.w #$00D7
	sta.b $CF
	clc
	sed
	pla
	adc.b $01,s
	cld
	plx
	plx
CODE_C5BCCC:						; from CODE_C5BBE9, CODE_C5BC62, CODE_C5BC6C
	jsr.w $5EC7
	ldx.w #$04F5
	ldy.b $6D
	jsl.l $C4BC08
	rts
CODE_C5BCD9:						; from CODE_C5B0EA and other segments
	lda.w #$00DE
	sta.b $18
	lda.w #$0025
	sta.b $1A
CODE_C5BCE3:						; from CODE_C5B7F1
	ldx.b $9B
	jsl.l CODE_C5E596
	stz.b $9B
	jsr.w CODE_C5A4B9
	lda.w $17C9
	jsl.l CreateSprite
	stx.b $9B
	lda.w #$0001
	sta.b $26
	jsr.w CODE_C5BBC0
	lda.w #$0040
	sta.b $CF
	lda.w #$0088
	sta.b $D1
	clc
	lda.b $D3
	adc.w #$0180
	ldy.w #$0080
	jsl.l CODE_C58B11
	jsl.l $C4C2AA
	lda.w $17C9
	asl a
	tax
	lda.l $C3585C,x
	tax
	ldy.w #$0006
	jsl.l $C4BCAA
	jsl.l $C4CEDB
	rts
CODE_C5BD30:						; from CODE_C5BBE9, CODE_C5BC6C and other segments
	sta.b $9F
	asl a
	adc.b $9F
	lsr a
	tax
	lda.l $306A56,x
	bcc CODE_C5BD40
	lsr a
	bra CODE_C5BD43
CODE_C5BD40:						; from CODE_C5BD30
	asl a
	asl a
	asl a
CODE_C5BD43:						; from CODE_C5BD30
	xba
	and.w #$007F
	sta.b $9F
	tax
	lda.l $C08C76,x
	and.w #$00FF
	rts
CODE_C5BD52:						; called from other segments
	jsr.w CODE_C5BD56
	rtl
CODE_C5BD56:						; from CODE_C5BD52, CODE_C5B4C2, CODE_C5BC6C
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b $9F
	lda.l $30628F,x
CODE_C5BD6F:						; from CODE_C5BD6F
	lsr a
	dec.b $9F
	bpl CODE_C5BD6F
	rol a
	and.w #$01FF
	sta.b $9F
	jmp.w CODE_C5B67A
CODE_C5BD7D:						; called from other segments
	jsr.w CODE_C5BD81
	rtl
CODE_C5BD81:						; from CODE_C5BD7D, CODE_C5B4C2, CODE_C5BC6C
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b $9F
	lda.l $306724,x
CODE_C5BD9A:						; from CODE_C5BD9A
	lsr a
	dec.b $9F
	bpl CODE_C5BD9A
	rol a
	and.w #$01FF
	sta.b $9F
	jmp.w CODE_C5B67A
CODE_C5BDA8:						; called from other segments
	jsr.w CODE_C5BDAC
	rtl
CODE_C5BDAC:						; from CODE_C5BDA8, CODE_C5BBE9, CODE_C5B4F7
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b $9F
	lda.l $30628F,x
CODE_C5BDC5:						; from CODE_C5BDC5
	lsr a
	dec.b $9F
	bpl CODE_C5BDC5
	rol a
	and.w #$007F
	sta.b $9F
	asl a
	adc.b $9F
	lsr a
	tax
	lda.l $306FED,x
	bcc CODE_C5BDDF
	lsr a
	lsr a
	lsr a
	lsr a
CODE_C5BDDF:						; from CODE_C5BDC5
	and.w #$0FFF
	sta.b $9F
	jmp.w CODE_C5B67A
CODE_C5BDE7:						; called from other segments
	jsr.w CODE_C5BDEB
	rtl
CODE_C5BDEB:						; from CODE_C5BDE7
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b $9F
	lda.l $30628F,x
CODE_C5BE04:						; from CODE_C5BE04
	lsr a
	dec.b $9F
	bpl CODE_C5BE04
	rol a
	and.w #$007F
	sta.b $9F
	asl a
	adc.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b $9F
	lda.l $307080,x
	ldx.b $9F
CODE_C5BE26:						; from CODE_C5BE26
	lsr a
	dex
	bpl CODE_C5BE26
	rol a
	and.w #$007F
	sta.b $9F
	jmp.w CODE_C5B67A
CODE_C5BE33:						; called from other segments
	jsr.w CODE_C5BE37
	rtl
CODE_C5BE37:						; from CODE_C5BE33, CODE_C5BBE9, CODE_C5B4F7
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b $9F
	lda.l $30628F,x
	sta.b $A1
	lda.l $306724,x
CODE_C5BE56:						; from CODE_C5BE56
	lsr.b $A1
	lsr a
	dec.b $9F
	bpl CODE_C5BE56
	rol a
	and.w #$01FF
	sta.b $9F
	lda.b $A1
	and.w #$00C0
	asl a
	asl a
	asl a
	ora.b $9F
	sta.b $9F
	jmp.w CODE_C5B67A
CODE_C5BE72:						; a callback: CODE_C5B1AF passes it to a list routine in bankC5_5000
	lda.w #$000A
	sta.b $CF
	lda.b $6F
	inc a
	jsr.w CODE_C5B67A
	jsr.w $5EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l $C4BC08
	lda.w #$0028
	sta.b $CF
	lda.b $6F
	asl a
	tax
	lda.w $3E4E,x
	tax
	lda.w $000C,x
	phx
	pha
	asl a
	tax
	lda.l $C3585C,x
	tax
	ldy.b $6D
	jsl.l $C4BBFC
	pla
	cmp.w #$000D
	bne CODE_C5BEB3
	ldx.w #$469F
	bra CODE_C5BEBB
CODE_C5BEB3:						; from CODE_C5BE72
	cmp.w #$000E
	bne CODE_C5BEC6
	ldx.w #$46A6
CODE_C5BEBB:						; from CODE_C5BE72
	lda.w #$006E
	sta.b $CF
	ldy.b $6D
	jsl.l $C4BBFC
CODE_C5BEC6:						; from CODE_C5BEB3
	ply
	lda.w #$00E8
	sta.b $D1
	lda.b $7F
	asl a
	tax
	jsr (DATA8_C5BEDD,x)
	ldy.b $6D
	ldx.w #$04F5
	jsl.l $C4BC1A
	rts
DATA8_C5BEDD:						; jump table: the routine for each index
	dw CODE_C5BEED,CODE_C5BF1D,CODE_C5BF26,CODE_C5BF50
	dw CODE_C5BF7A,CODE_C5BF83,CODE_C5BF8C,CODE_C5BFB6
CODE_C5BEED:						; called from other segments
	phy
	lda.w $0004,y
	jsr.w CODE_C5B67A
	jsr.w $5EC7
	lda.w #$003E
	sta.w $04F5,x
	inx
	lda.w $0006,y
	phx
	jsr.w CODE_C5B67A
	plx
	jsr.w $5ECA
	lda.w #$003E
	sta.w $04F5,x
	inx
	lda.w $0008,y
	phx
	jsr.w CODE_C5B67A
	plx
	jsr.w $5ECA
	ply
	rts
CODE_C5BF1D:						; called from other segments
	lda.w $000A,y
	jsr.w CODE_C5B67A
	jmp.w $5EC7
CODE_C5BF26:						; called from other segments
	lda.w $0010,y
	jsr.w CODE_C5B67A
	sta.b $34
	xba
	and.w #$00FF
	jsr.w $5EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b $34
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w $5ECA
	lda.b $34
	and.w #$000F
	jmp.w $5ECA
CODE_C5BF50:						; called from other segments
	lda.w $0012,y
	jsr.w CODE_C5B67A
	sta.b $34
	xba
	and.w #$00FF
	jsr.w $5EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b $34
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w $5ECA
	lda.b $34
	and.w #$000F
	jmp.w $5ECA
CODE_C5BF7A:						; called from other segments
	lda.w $0014,y
	jsr.w CODE_C5B67A
	jmp.w $5EC7
CODE_C5BF83:						; called from other segments
	lda.w $0016,y
	jsr.w CODE_C5B67A
	jmp.w $5EC7
CODE_C5BF8C:						; called from other segments
	lda.w $001A,y
	jsr.w CODE_C5B67A
	sta.b $34
	xba
	and.w #$00FF
	jsr.w $5EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b $34
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w $5ECA
	lda.b $34
	and.w #$000F
	jmp.w $5ECA
CODE_C5BFB6:						; called from other segments
	lda.w $0030,y
	jsr.w CODE_C5B67A
	sta.b $34
	xba
	and.w #$00FF
	jsr.w $5EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b $34
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w $5ECA
	lda.b $34
	and.w #$000F
	jmp.w $5ECA

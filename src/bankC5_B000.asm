; Segment bankC5_B000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C5AFB6
CODE_C5AFB6:						; called from other segments
	jsl.l FadeOutWait
	ldx.b a0
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
	jsl.l CODE_C4C530
	jsl.l CODE_C4BAF6
	jsl.l CODE_C4CEDB
	pla
	jsr.w CODE_C5B631
	ldx.w #$559D
	lda.b $85
	lsr a
	bcc .1
	ldx.w #$55AD
.1:									; $CF = $0018, call CODE_C4BBFC, tmp0 = $027E
	ldy.w #$0018
	sty.b $CF
	jsl.l CODE_C4BBFC
	lda.w #$027E
	sta.b tmp0
.loop:								; loop: A = tmp0, A - 1, tmp0 = A, call CODE_C5D7CD, ...
	lda.b tmp0
	dec a
	sta.b tmp0
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	jsr.w CODE_C5D804
	beq .loop
	lda.w #$0010
	jsl.l CODE_C4C547
	sta.b d0
	sta.b $81
	tay
	lda.b tmp0
	jsr.w CODE_C5B4C2
	dec.b tmp0
.loop2:								; loop: call CODE_C5B558, tmp0 - 1, if the result >= 0 go to .loop2, ...
	jsr.w CODE_C5B558
	dec.b tmp0
	bpl .loop2
	jsl.l CODE_C4C541
	lda.b $81
	ldy.w #$FFFE
.loop3:								; loop: X = A, A = QueueBusy,x, if the result is not 0 go to .2, ...
	tax
	lda.w QueueBusy,x
	eor.b $85
	bne .2
	iny
	iny
	txa
	sta.w $3E4E,y
.2:									; if $0002,x is not 0 go to .loop3, A = Y, A / 2, a1 = A, ...
	lda.w $0002,x
	bne .loop3
	tya
	lsr a
	sta.b a1
	lda.w #$556D
	jsl.l CODE_C4BB5A
	jsl.l CODE_C4CEDB
	stz.b $69
	lda.w #CODE_C5B6A1
	ldx.w #$000D
	ldy.w #$0009
	jsr.w CODE_C55ABC
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	lda.w #$0008
	sta.b $99
	stz.w fadestep
	rts
CODE_C5B07C:						; called from other segments
	jsl.l FadeOutWait
	ldx.b a0
	lda.w #$FC18
	sta.b $05,x
	sta.b $08,x
	lda.w #$8000
	sta.w DMAEnShadow
	lda.w #$FFFA
	sta.w BG2VScroll
	ldy.w #$5C00
	jsl.l CODE_C589B0
	jsl.l CODE_C4CEDB
	sep #$20
	lda.b #$11
	sta.l TM
	rep #$20
	jsl.l CODE_C4C530
	jsl.l CODE_C4BAF6
	lda.w #$55F1
	jsl.l CODE_C4BB5A
	jsl.l CODE_C4CEDB
	ldy.w #$2801
	ldx.w #$50A8
	jsl.l CODE_C387D8
	stz.w $17C9
	stz.b d7
	jsr.w CODE_C5B7F1
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
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
	stz.b d0
	ldx.b a0
	lda.w #$FC18
	sta.b $05,x
	sta.b $08,x
	lda.w #$8000
	sta.w DMAEnShadow
	lda.w #$FFFA
	sta.w BG2VScroll
	ldy.w #$5C00
	jsl.l CODE_C589B0
	jsl.l CODE_C4CEDB
	sep #$20
	lda.b #$11
	sta.l TM
	rep #$20
	jsl.l CODE_C4C530
	jsl.l CODE_C4BAF6
	lda.w #$5583
	jsl.l CODE_C4BB5A
	jsl.l CODE_C4CEDB
	ldy.w #$2801
	ldx.w #$50A8
	jsl.l CODE_C387D8
	lda.w #$0002
	sta.w $1864
	stz.w $17C9
	jsr.w CODE_C52CC1
	sec
	lda.w $2DC9
	sbc.w $2DCB
	sta.b a1
	stz.b $69
	lda.w #CODE_C5BBDD
	ldx.w #$000C
	ldy.w #$000B
	jsr.w CODE_C55ABC
	stz.b d7
	jsr.w CODE_C5BCD9
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
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
	ldx.b a0
	lda.w #$FC18
	sta.b $05,x
	sta.b $08,x
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5C00
	jsl.l CODE_C589B0
	jsl.l CODE_C4C530
	jsl.l CODE_C4BAF6
	lda.w #$5553
	jsl.l CODE_C4BB5A
	jsl.l CODE_C4CEDB
	stz.b d0
	jsl.l CODE_C5E37E
	stz.b d1
CODE_C5B1AF:						; called from other segments
	jsr.w CODE_C5C029
	jsr.w CODE_C5BFE0
	stz.b $69
	lda.w #CODE_C5BE72
	ldx.w #$000D
	ldy.w #$0009
	jsr.w CODE_C55ABC
	lda.b d0
	asl a
	tax
	lda.l DATA8_C5B1FE,x
	tax
	ldy.w #$0007
	lda.w #$00F0
	sta.b $D1
	jsl.l CODE_C4BC0E
	lda.w #$0010
	sta.b $CF
	lda.b d1
	asl a
	tax
	lda.l DATA8_C04CB7,x
	tax
	ldy.w #$0013
	jsl.l CODE_C4BCA4
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	lda.w #$000B
	sta.b $99
	stz.w fadestep
	rts
DATA8_C5B1FE:						; not traced: a table read by CODE_C5B1AF
	db $2E,$56,$75,$4B,$3D,$56,$4C,$56,$5C,$56,$6B,$56,$76,$56,$83,$56
CODE_C5B20E:						; from CODE_C5B22D and other segments
	stz.b d4
	lda.b d0
	asl a
	tax
	bra .1
.loop:								; loop: Y = X, A = DATA8_C360D4,x, X = A, A = $C30000,x, ...
	txy
	lda.l DATA8_C360D4,x
	tax
	lda.l $C30000,x
	and.w #$00FF
	tyx
	adc.b d4
	sta.b d4
.1:									; X - 1, X - 1, if the result >= 0 go to .loop, return
	dex
	dex
	bpl .loop
	rts
CODE_C5B22D:						; called from other segments
	jsr.w CODE_C5B20E
	lda.w #$FFFA
	sta.w BG2VScroll
	lda.w #$00EB
	sta.b d3
	asl a
	adc.b $D3
	ldy.w #$0540
	jsl.l CODE_C58B11
	jsl.l CODE_C4C2AA
	ldy.w #$5000
	jsl.l CODE_C589E4
	jsl.l CODE_C4CEDB
	lda.w #$0011
	sta.w $3652
	ldx.b a0
	lda.w #$0060
	sta.b $08,x
	lda.w #$0058
	sta.b $CF
	lda.w #$00A0
	sta.b $D1
	lda.b d0
	asl a
	tax
	lda.l DATA8_C360D4,x
	sta.b d1
	stz.b $85
	tax
	lda.l $C30000,x
	and.w #$00FF
	sta.b d2
	jsr.w CODE_C5B33C
	pha
	ldx.b d1
	lda.l $C30001,x
	pha
	and.w #$00FF
	ldx.w #$0020
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	jsl.l CODE_C4BCAA
	pla
	xba
	and.w #$00FF
	ldx.w #$0030
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	pla
	adc.w #$0003
	tay
	jsl.l CODE_C4BCAA
	jsr.w CODE_C5B38F
	sec
	jsr.w CODE_C5B33C
	ldx.b d2
	dex
	beq .1
	pha
	ldx.b d1
	lda.l $C30003,x
	pha
	and.w #$00FF
	ldx.w #$0040
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	jsl.l CODE_C4BCAA
	clc
	pei ($8B)
	lda.b d3
	adc.w #$00E0
	and.w #$03FF
	sta.b d3
	inc.b $85
	jsr.w CODE_C5B38F
	dec.b $85
	pla
	sta.b d3
	pla
	xba
	and.w #$00FF
	ldx.w #$0050
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	pla
	adc.w #$0003
	tay
	jsl.l CODE_C4BCAA
.1:									; call CODE_C4CEDB, $3652 = $0017, X = a4, A = $22,x, ...
	jsl.l CODE_C4CEDB
	lda.w #$0017
	sta.w $3652
	ldx.b a4
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	ldx.b $75
	lda.b $22,x
	and.w #$FFFE
	ldy.b d2
	cpy.w #$0003
	bcc .2
	ora.w #$0001
.2:									; $22,x = A, return
	sta.b $22,x
	rts
CODE_C5B33C:						; from CODE_C5B22D
	lda.b $81
	sbc.w #$0001
	bcs .1
	adc.w #$0003
.1:									; A * 2, X = A, push X, A = DATA8_C5B35D,x, ...
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
DATA8_C5B35D:						; not traced: a table read by CODE_C5B33C
	db $00,$02,$C0,$03,$80,$05
DATA8_C5B363:						; not traced: a table read by CODE_C5B33C
	db $09,$00,$10,$00,$17,$00
CODE_C5B369:						; from CODE_C5B22D and other segments
	sta.b tmp1
	dec.b QueueBusy
	tsc
	sta.b tmp0
	lda.b $04
	tcs
	pea.w $0020
	phx
	pea.w $007F
	lda.b tmp1
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$D80A
	pha
	tsc
	sta.b $04
	lda.b tmp0
	tcs
	stz.b QueueBusy
	lda.b tmp1
	rts
CODE_C5B38F:						; from CODE_C5B22D and other segments
	jsl.l CODE_C4CEDB
	phd
	lda.b $85
	lsr a
	ldx.w #$2801
	bcc .1
	ldx.w #$3001
.1:									; A = d3, A or $5000, Y = A, A = $2100, ...
	lda.b d3
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
	lda.w d4
	clc
	adc.w $0085
	pha
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	sta.w tmp0
	pla
	lsr a
	lsr a
	lsr a
	tax
	lda.l $306050
	and.w #$00FF
	cmp.w d0
	beq .3
	bcc .4
	lda.l $307884,x
	ldx.w #$3C33
	and.w tmp0
	beq .2
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B4AE
	pld
	rts
.2:									; call CODE_C5B4AE, call CODE_C5B499, call CODE_C5B499, ...
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	pld
	rts
.3:									; push X, X = $0085, A = $306051
	phx
	ldx.w $0085
	lda.l $306051
.loop:								; loop: A / 2, X - 1, if the result >= 0 go to .loop, pull X, ...
	lsr a
	dex
	bpl .loop
	plx
	bcc .4
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	pld
	rts
.4:									; A = $307884,x, X = $3C13, if the result is not 0 go to .5, X = $3C23
	lda.l $307884,x
	ldx.w #$3C13
	and.w tmp0
	bne .5
	ldx.w #$3C23
.5:									; call CODE_C5B4AE, call CODE_C5B499, call CODE_C5B499, ...
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
CODE_C5B499:						; from CODE_C5B38F
	jsr.w CODE_C5B48A
	lda.w #$0003
	bra CODE_C5B4A7
CODE_C5B4A1:						; from CODE_C5B38F
	jsr.w CODE_C5B48A
	lda.w #$0008
CODE_C5B4A7:						; from CODE_C5B4A7, CODE_C5B499
	stx.b $18
	inx
	dec a
	bpl CODE_C5B4A7
	rts
CODE_C5B4AE:						; from CODE_C5B38F
	jsr.w CODE_C5B48A
	lda.w #$0003
	bra CODE_C5B4BC
CODE_C5B4B6:						; from CODE_C5B38F
	jsr.w CODE_C5B48A
	lda.w #$0008
CODE_C5B4BC:						; from CODE_C5B4BC, CODE_C5B4AE
	stz.b $18
	dec a
	bpl CODE_C5B4BC
	rts
CODE_C5B4C2:						; from CODE_C5AFCC, CODE_C5B558
	pha
	sta.w $0004,y
	jsr.w CODE_C5B5EE
	sta.w $000E,y
	lda.b $01,s
	jsr.w CODE_C5B53D
	bcc .1
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
	stz.w QueueBusy,x
	pla
	sta.b tmp0
	rts
.1:									; QueueBusy,y = $0001, A = $01,s, call CODE_C5BDAC, $0008,y = A, ...
	lda.w #$0001
	sta.w QueueBusy,y
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
	jsl.l Mul16x8U
	ply
	stz.b $32
	pla
	clc
	adc.b tmp0
	sta.b r1
	beq .2
	phy
	jsl.l Div32x32U
	ply
	lda.b r0
.2:									; call CODE_C5B67A, $000C,y = A, pull A, tmp0 = A, ...
	jsr.w CODE_C5B67A
	sta.w $000C,y
	pla
	sta.b tmp0
	rts
CODE_C5B53D:						; from CODE_C5B4C2
	cmp.w #$026A
	bcc .1
	phy
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	cmp.w #$0001
	ply
	rts
.1:									; A * 2, X = A, return
	asl a
	tax
	lda.l PlayerList,x
	cmp.w #$4000
	rts
CODE_C5B558:						; from CODE_C5AFCC
	lda.w #$0010
	jsl.l CODE_C4C558
	tay
	lda.b tmp0
	jsr.w CODE_C5B4C2
	lda.b d1
	asl a
	tax
	jmp (DATA8_C5B56C,x)
DATA8_C5B56C:						; jump table: the routine for each index
	dw CODE_C5B59E,CODE_C5B572,CODE_C5B588
CODE_C5B572:						; from DATA8_C5B56C
	lda.w $000A,y
	sta.b tmp1
	lda.b d0
.loop:								; loop: X = A, if $000A,x >= tmp1 go to CODE_C5B5D7, ...
	tax
	lda.w $000A,x
	cmp.b tmp1
	bcs CODE_C5B5D7
	lda.w $0000,x
	bne .loop
	bra CODE_C5B5B2
CODE_C5B588:						; from DATA8_C5B56C
	lda.w $000C,y
	sta.b tmp1
	lda.b d0
.loop:								; loop: X = A, if $000C,x >= tmp1 go to CODE_C5B5D7, ...
	tax
	lda.w $000C,x
	cmp.b tmp1
	bcs CODE_C5B5D7
	lda.w $0000,x
	bne .loop
	bra CODE_C5B5B2
CODE_C5B59E:						; from DATA8_C5B56C
	lda.w $0008,y
	sta.b tmp1
	lda.b d0
.loop:								; loop: X = A, if $0008,x >= tmp1 go to CODE_C5B5D7, ...
	tax
	lda.w $0008,x
	cmp.b tmp1
	bcs CODE_C5B5D7
	lda.w $0000,x
	bne .loop
CODE_C5B5B2:						; from CODE_C5B572, CODE_C5B588
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
	sta.b tmp2
	txa
	sta.w $0000,y
	tya
	sta.w $0002,x
	ldx.b tmp2
	sta.w $0000,x
	rts
CODE_C5B5D7:						; from CODE_C5B59E, CODE_C5B572, CODE_C5B588
	cpx.b d0
	bne CODE_C5B5C1
	sty.b d0
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
	sta.b tmp1
	asl a
	adc.b tmp1
	lsr a
	tax
	lda.l $306A56,x
	sta.b tmp1
	bcc .1
	xba
	lsr a
	and.w #$007F
	tax
	lda.l $C08C75,x
	and.w #$FF00
	pha
	lda.b tmp1
	and.w #$01F0
	lsr a
	lsr a
	lsr a
	lsr a
	ora.b $01,s
	plx
	rts
.1:									; A * 2, A * 2, A * 2, A and $007F, ...
	asl a
	asl a
	asl a
	xba
	and.w #$007F
	tax
	lda.l $C08C75,x
	and.w #$FF00
	pha
	lda.b tmp1
	and.w #$001F
	ora.b $01,s
	plx
	rts
CODE_C5B631:						; from CODE_C5AFCC
	sta.b d1
	asl a
	tax
	lda.b $85
	lsr a
	lda.l DATA8_C5B66A,x
	bcc .1
	lda.l DATA8_C5B670,x
.1:									; push A, A = $D3, A + $01AA, push A, ...
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
	jsl.l CODE_C4BC0E
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
	stz.b tmp0
.loop:								; loop: if A < $0064 go to .1, A - $0064, X = A, A = tmp0, ...
	cmp.w #$0064
	bcc .1
	sbc.w #$0064
	tax
	sed
	lda.b tmp0
	adc.w #$0099
	sta.b tmp0
	cld
	txa
	bra .loop
.1:									; X = A, A = BCDTable,x, A and $00FF, A or tmp0, ...
	tax
	lda.l BCDTable,x
	and.w #$00FF
	ora.b tmp0
	plx
	stx.b tmp0
	rts
CODE_C5B6A1:						; a callback: CODE_C5AFCC passes it to CODE_C55ABC
	lda.w #$000A
	sta.b $CF
	lda.b a3
	inc a
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l CODE_C4BC08
	lda.w #$0022
	sta.b $CF
	lda.b a3
	asl a
	tax
	lda.w $3E4E,x
	tax
	lda.w $0004,x
	cmp.w #$026A
	bcs .1
	jmp.w .12
.1:									; push X, call CODE_C5D7CD, call CODE_C5D7E9, tmp1 = $0000
	phx
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	ldx.w #$0000
	stx.b tmp1
.2:									; push X, call CODE_C5D804, pull X, if A = $0000 go to .5, ...
	phx
	jsr.w CODE_C5D804
	plx
	cmp.w #$0000
	beq .5
	cmp.w #$001D
	bne .3
	lda.w #$003D
	bra .4
.3:									; A + $0040, A + tmp1
	clc
	adc.w #$0040
	adc.b tmp1
.4:									; $04F5,x = A, tmp1 = $0020, X + 1, if X is not $0008 go to .2, ...
	sta.w $04F5,x
	lda.w #$0020
	sta.b tmp1
	inx
	cpx.w #$0008
	bne .2
	bra .7
.5:									; push X
	phx
.loop:								; loop: if X = $0007 go to .6, push X, call CODE_C5D804, pull X, ...
	cpx.w #$0007
	beq .6
	phx
	jsr.w CODE_C5D804
	plx
	inx
	bra .loop
.6:									; pull X
	plx
.7:									; $04F5,x = $0020, tmp1 = 0, X + 1, push X
	lda.w #$0020
	sta.w $04F5,x
	stz.b tmp1
	inx
	phx
.8:									; push X, call CODE_C5D804, pull X, if A = $0000 go to .loop2, ...
	phx
	jsr.w CODE_C5D804
	plx
	cmp.w #$0000
	beq .loop2
	cmp.w #$001D
	bne .9
	lda.w #$003D
	bra .10
.9:									; A + $0040, A + tmp1
	clc
	adc.w #$0040
	adc.b tmp1
.10:								; $04F5,x = A, tmp1 = $0020, X + 1, A = X, ...
	sta.w $04F5,x
	lda.w #$0020
	sta.b tmp1
	inx
	txa
	sec
	sbc.b $01,s
	cmp.w #$000A
	bcc .8
	bra .11
.loop2:								; loop: A = X, A - $01,s, if A = $0009 go to .11, push X, ...
	txa
	sec
	sbc.b $01,s
	cmp.w #$0009
	beq .11
	phx
	jsr.w CODE_C5D804
	plx
	inx
	bra .loop2
.11:								; pull X, $65 = Y, X = $04F5, A = $000C, ...
	plx
	sty.b $65
	ldx.w #$04F5
	lda.w #$000C
	jsl.l CODE_C55F8A
	bra .13
.12:								; push X, A * 2, X = A, A = PlayerList,x, ...
	phx
	asl a
	tax
	lda.l PlayerList,x
	adc.w #$0008
	and.w #$3FFF
	tax
	lda.w #$000C
	jsr.w CODE_C55F98
.13:								; Y = $6D, call CODE_C4BC08, pull X, push X, ...
	ldy.b $6D
	jsl.l CODE_C4BC08
	plx
	phx
	lda.w #$0094
	sta.b $CF
	lda.w $000F,x
	jsr.w CODE_C5A321
	ldy.b $6D
	ldx.w #$04F7
	jsl.l CODE_C4BC08
	plx
	phx
	lda.w $000E,x
	and.w #$00FF
	cmp.w #$001A
	bcc .14
	ldx.w #$484C
	bra .15
.14:								; A * 2, X = A, A = $C30000,x, X = A, ...
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l CODE_C4C3BA
	ldx.b $16
	lda.b $0A
	beq .15
	inx
.15:								; call CODE_C4C3BA, $CF = $00A8, Y = $6D, call CODE_C4BC08, ...
	jsl.l CODE_C4C3BA
	lda.w #$00A8
	sta.b $CF
	ldy.b $6D
	jsl.l CODE_C4BC08
	lda.w #$00F0
	sta.b $D1
	lda.b d1
	asl a
	adc.b $01,s
	tax
	lda.w $0008,x
	jsr.w CODE_C55EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l CODE_C4BC1A
	plx
	rts
CODE_C5B7F1:						; from CODE_C5B07C and other segments
	lda.w #$00D4
	sta.b $18
	lda.w #$0025
	sta.b $1A
	jsr.w CODE_C5BCE3
	lda.w #$000F
	sta.b tmp0
	clc
	lda.b $D3
	adc.w #$022C
	jsr.w CODE_C5B96D
	lda.w #$0001
	sta.b tmp0
	clc
	lda.b $D3
	adc.w #$0266
	jsr.w CODE_C5B96D
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	lda.w #$00F8
	sta.b $D1
	lda.w $17C9
	jsr.w CODE_C5B983
	phy
	lda.w $0004,y
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	lda.w #$003E
	sta.w $04F5,x
	inx
	lda.w QueueBusy,y
	phx
	jsr.w CODE_C5B67A
	plx
	jsr.w CODE_C55ECA
	lda.w #$003E
	sta.w $04F5,x
	inx
	lda.w $0008,y
	phx
	jsr.w CODE_C5B67A
	plx
	jsr.w CODE_C55ECA
	ldx.w #$04F5
	ldy.w #$0009
	jsl.l CODE_C4BC20
	ply
	phy
	lda.w $0010,y
	jsr.w CODE_C5B67A
	sta.b r2
	xba
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w CODE_C55ECA
	lda.b r2
	and.w #$000F
	jsr.w CODE_C55ECA
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l CODE_C4BC20
	ply
	phy
	lda.w $0012,y
	jsr.w CODE_C5B67A
	sta.b r2
	xba
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w CODE_C55ECA
	lda.b r2
	and.w #$000F
	jsr.w CODE_C55ECA
	ldx.w #$04F5
	ldy.w #$000D
	jsl.l CODE_C4BC20
	ply
	phy
	lda.w $0014,y
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldx.w #$04F5
	ldy.w #$000F
	jsl.l CODE_C4BC20
	ply
	phy
	lda.w $0016,y
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldx.w #$04F5
	ldy.w #$0011
	jsl.l CODE_C4BC20
	ply
	phy
	lda.w $001A,y
	jsr.w CODE_C5B67A
	sta.b r2
	xba
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w CODE_C55ECA
	lda.b r2
	and.w #$000F
	jsr.w CODE_C55ECA
	ldx.w #$04F5
	ldy.w #$0013
	jsl.l CODE_C4BC20
	ply
	phy
	lda.w r1,y
	jsr.w CODE_C5B67A
	sta.b r2
	xba
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w CODE_C55ECA
	lda.b r2
	and.w #$000F
CODE_C5B95A:						; called from other segments
	jsr.w CODE_C55ECA
	ldx.w #$04F5
	ldy.w #$0015
	jsl.l CODE_C4BC20
	ply
	jsl.l CODE_C4C2AA
	rts
CODE_C5B96D:						; from CODE_C5B7F1, CODE_C5B96D
	pha
	ldy.w #$0014
	jsl.l CODE_C58B11
	pla
	clc
	adc.w #$0040
	dec.b tmp0
	bpl CODE_C5B96D
	rts
CODE_C5B97F:						; called from other segments
	jsr.w CODE_C5B983
	rtl
CODE_C5B983:						; from CODE_C5B7F1, CODE_C5B97F and other segments
	tax
	lda.w #$0032
	jsl.l CODE_C4C558
	tay
	txa
	sta.w $000C,y
	phy
	ldx.w #$0083
	jsl.l Mul16U
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
	stz.b r0
	stz.b $2E
	lda.w #$0014
	sta.b r1
	phx
	sep #$20
	phb
	lda.b #$30
	pha
	plb
.loop:								; loop: $32 = $606D,y, A and $03, X = A, r0,x + 1, ...
	lda.w $606D,y
	sta.b $32
	and.b #$03
	tax
	inc.b r0,x
	lda.b $32
	lsr a
	lsr a
	sta.b $32
	and.b #$03
	tax
	inc.b r0,x
	lda.b $32
	lsr a
	lsr a
	sta.b $32
	and.b #$03
	tax
	inc.b r0,x
	lda.b $32
	lsr a
	lsr a
	tax
	inc.b r0,x
	iny
	dex
	dec.b r1
	bpl .loop
	rep #$20
	plb
	ply
	lda.b $2D
	and.w #$00FF
	sta.w $0004,y
	lda.b $2E
	and.w #$00FF
	sta.w QueueBusy,y
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
	sbc.b r0
	sta.w r0,y
	ldx.w $000E,y
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w r0,y
	sta.b r1
	beq .1
	jsl.l Div32x32U
	lda.b r0
.1:									; pull Y, $0010,y = A, X = $002A,y, A = $0064, ...
	ply
	sta.w $0010,y
	ldx.w $002A,y
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w r0,y
	sta.b r1
	beq .2
	jsl.l Div32x32U
	lda.b r0
.2:									; pull Y, $0012,y = A, A = $002E,y, A - $002A,y, ...
	ply
	sta.w $0012,y
	sec
	lda.w $002E,y
	sbc.w $002A,y
	tax
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w $002E,y
	sta.b r1
	beq .3
	jsl.l Div32x32U
	lda.b r0
.3:									; pull Y, $0014,y = A, X = $000E,y, A = $0064, ...
	ply
	sta.w $0014,y
	sec
	ldx.w $000E,y
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w $0018,y
	sta.b r1
	beq .4
	jsl.l Div32x32U
	lda.b r0
.4:									; pull Y, $0016,y = A, X = $0018,y, A = $0064, ...
	ply
	sta.w $0016,y
	ldx.w $0018,y
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w r0,y
	sta.b r1
	beq .5
	jsl.l Div32x32U
	lda.b r0
.5:									; pull Y, $001A,y = A, X = $002E,y, A = $0064, ...
	ply
	sta.w $001A,y
	ldx.w $002E,y
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w r0,y
	sta.b r1
	beq .6
	jsl.l Div32x32U
	lda.b r0
.6:									; pull Y, r1,y = A, X = Y, $0000,x = 0, ...
	ply
	sta.w r1,y
	tyx
	stz.w $0000,x
	stz.w $0002,x
	rts
CODE_C5BB46:						; from CODE_C5B983
	sta.b r1
	lda.b r2
	lsr a
	lsr a
	lsr a
	tax
	lda.l $306E43,x
	sta.b r0
	lda.l $306E45,x
	sta.b $2E
	lda.b r2
	and.w #$0007
	asl a
	tax
	lda.b r1
	adc.b r2
	sta.b r2
	lda.b $2E
	jmp (DATA8_C5BB6C,x)
DATA8_C5BB6C:						; jump table: the routine for each index
	dw CODE_C5BB91,CODE_C5BB8E,CODE_C5BB8B,CODE_C5BB88
	dw CODE_C5BB85,CODE_C5BB82,CODE_C5BB7F,CODE_C5BB7C
CODE_C5BB7C:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB7F:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB82:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB85:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB88:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB8B:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB8E:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB91:						; from DATA8_C5BB6C
	lda.b r1
	asl a
	tax
	lda.b r0
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
	jsl.l CODE_C4CEDB
	rts
CODE_C5BBDD:						; a callback: CODE_C5A71A, CODE_C5B0EA pass it to CODE_C55ABC
	lda.w #$000C
	sta.b $CF
	lda.b d0
	bne .1
	jmp.w .3
.1:									; A = a3, A * 2, X = A, push X, ...
	clc
	lda.b a3
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
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l CODE_C4BC08
	plx
	lda.w $2E03,x
	pha
	jsr.w CODE_C5BD30
	jsr.w CODE_C5A321
	lda.w #$0072
	sta.b $CF
	ldx.w #$04F7
	ldy.b $6D
	jsl.l CODE_C4BC08
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
	jsl.l Mul16x8U
	stz.b $32
	clc
	lda.b $05,s
	adc.b $01,s
	sta.b r1
	beq .2
	jsl.l Div32x32U
	lda.b r0
.2:									; call CODE_C5B67A, pull X, pull X, pull X, ...
	jsr.w CODE_C5B67A
	plx
	plx
	plx
	plx
	jmp.w CODE_C5BCCC
.3:									; A = $2DCB, A + a3, A * 2, X = A, ...
	clc
	lda.w $2DCB
	adc.b a3
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
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l CODE_C4BC08
	plx
	lda.w $2E03,x
	pha
	jsr.w CODE_C5BD30
	jsr.w CODE_C5A321
	lda.w #$0072
	sta.b $CF
	ldx.w #$04F7
	ldy.b $6D
	jsl.l CODE_C4BC08
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
CODE_C5BCCC:						; from CODE_C5BBDD
	jsr.w CODE_C55EC7
	ldx.w #$04F5
	ldy.b $6D
	jsl.l CODE_C4BC08
	rts
CODE_C5BCD9:						; from CODE_C5B0EA and other segments
	lda.w #$00DE
	sta.b $18
	lda.w #$0025
	sta.b $1A
CODE_C5BCE3:						; from CODE_C5B7F1
	ldx.b d7
	jsl.l CODE_C5E596
	stz.b d7
	jsr.w CODE_C5A4B9
	lda.w $17C9
	jsl.l CreateSprite
	stx.b d7
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
	jsl.l CODE_C4C2AA
	lda.w $17C9
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0006
	jsl.l CODE_C4BCAA
	jsl.l CODE_C4CEDB
	rts
CODE_C5BD30:						; from CODE_C5BBDD and other segments
	sta.b tmp0
	asl a
	adc.b tmp0
	lsr a
	tax
	lda.l $306A56,x
	bcc .1
	lsr a
	bra .2
.1:									; A * 2, A * 2, A * 2
	asl a
	asl a
	asl a
.2:									; A and $007F, tmp0 = A, X = A, A = BCDTable,x, ...
	xba
	and.w #$007F
	sta.b tmp0
	tax
	lda.l BCDTable,x
	and.w #$00FF
	rts
CODE_C5BD52:						; called from other segments
	jsr.w CODE_C5BD56
	rtl
CODE_C5BD56:						; from CODE_C5BD52, CODE_C5B4C2, CODE_C5BBDD
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $30628F,x
.loop:								; loop: A / 2, tmp0 - 1, if the result >= 0 go to .loop, A and $01FF, ...
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$01FF
	sta.b tmp0
	jmp.w CODE_C5B67A
CODE_C5BD7D:						; called from other segments
	jsr.w CODE_C5BD81
	rtl
CODE_C5BD81:						; from CODE_C5BD7D, CODE_C5B4C2, CODE_C5BBDD
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $306724,x
.loop:								; loop: A / 2, tmp0 - 1, if the result >= 0 go to .loop, A and $01FF, ...
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$01FF
	sta.b tmp0
	jmp.w CODE_C5B67A
CODE_C5BDA8:						; called from other segments
	jsr.w CODE_C5BDAC
	rtl
CODE_C5BDAC:						; from CODE_C5BDA8, CODE_C5BBDD, CODE_C5B4C2
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $30628F,x
.loop:								; loop: A / 2, tmp0 - 1, if the result >= 0 go to .loop, A and $007F, ...
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$007F
	sta.b tmp0
	asl a
	adc.b tmp0
	lsr a
	tax
	lda.l $306FED,x
	bcc .1
	lsr a
	lsr a
	lsr a
	lsr a
.1:									; A and $0FFF, tmp0 = A, go to CODE_C5B67A
	and.w #$0FFF
	sta.b tmp0
	jmp.w CODE_C5B67A
CODE_C5BDE7:						; called from other segments
	jsr.w CODE_C5BDEB
	rtl
CODE_C5BDEB:						; from CODE_C5BDE7
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $30628F,x
.loop:								; loop: A / 2, tmp0 - 1, if the result >= 0 go to .loop, A and $007F, ...
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$007F
	sta.b tmp0
	asl a
	adc.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $307080,x
	ldx.b tmp0
.loop2:								; loop: A / 2, X - 1, if the result >= 0 go to .loop2, A and $007F, ...
	lsr a
	dex
	bpl .loop2
	rol a
	and.w #$007F
	sta.b tmp0
	jmp.w CODE_C5B67A
CODE_C5BE33:						; called from other segments
	jsr.w CODE_C5BE37
	rtl
CODE_C5BE37:						; from CODE_C5BE33, CODE_C5BBDD, CODE_C5B4C2
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $30628F,x
	sta.b tmp1
	lda.l $306724,x
.loop:								; loop: tmp1 / 2, A / 2, tmp0 - 1, if the result >= 0 go to .loop, ...
	lsr.b tmp1
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$01FF
	sta.b tmp0
	lda.b tmp1
	and.w #$00C0
	asl a
	asl a
	asl a
	ora.b tmp0
	sta.b tmp0
	jmp.w CODE_C5B67A
CODE_C5BE72:						; a callback: CODE_C5B1AF passes it to CODE_C55ABC
	lda.w #$000A
	sta.b $CF
	lda.b a3
	inc a
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l CODE_C4BC08
	lda.w #$0028
	sta.b $CF
	lda.b a3
	asl a
	tax
	lda.w $3E4E,x
	tax
	lda.w $000C,x
	phx
	pha
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.b $6D
	jsl.l CODE_C4BBFC
	pla
	cmp.w #$000D
	bne .1
	ldx.w #$469F
	bra .2
.1:									; if A is not $000E go to .3, X = $46A6
	cmp.w #$000E
	bne .3
	ldx.w #$46A6
.2:									; $CF = $006E, Y = $6D, call CODE_C4BBFC
	lda.w #$006E
	sta.b $CF
	ldy.b $6D
	jsl.l CODE_C4BBFC
.3:									; pull Y, $D1 = $00E8, A = d0, A * 2, ...
	ply
	lda.w #$00E8
	sta.b $D1
	lda.b d0
	asl a
	tax
	jsr (DATA8_C5BEDD,x)
	ldy.b $6D
	ldx.w #$04F5
	jsl.l CODE_C4BC1A
	rts
DATA8_C5BEDD:						; jump table: the routine for each index
	dw CODE_C5BEED,CODE_C5BF1D,CODE_C5BF26,CODE_C5BF50
	dw CODE_C5BF7A,CODE_C5BF83,CODE_C5BF8C,CODE_C5BFB6
CODE_C5BEED:						; from DATA8_C5BEDD
	phy
	lda.w $0004,y
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	lda.w #$003E
	sta.w $04F5,x
	inx
	lda.w QueueBusy,y
	phx
	jsr.w CODE_C5B67A
	plx
	jsr.w CODE_C55ECA
	lda.w #$003E
	sta.w $04F5,x
	inx
	lda.w $0008,y
	phx
	jsr.w CODE_C5B67A
	plx
	jsr.w CODE_C55ECA
	ply
	rts
CODE_C5BF1D:						; from DATA8_C5BEDD
	lda.w $000A,y
	jsr.w CODE_C5B67A
	jmp.w CODE_C55EC7
CODE_C5BF26:						; from DATA8_C5BEDD
	lda.w $0010,y
	jsr.w CODE_C5B67A
	sta.b r2
	xba
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w CODE_C55ECA
	lda.b r2
	and.w #$000F
	jmp.w CODE_C55ECA
CODE_C5BF50:						; from DATA8_C5BEDD
	lda.w $0012,y
	jsr.w CODE_C5B67A
	sta.b r2
	xba
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w CODE_C55ECA
	lda.b r2
	and.w #$000F
	jmp.w CODE_C55ECA
CODE_C5BF7A:						; from DATA8_C5BEDD
	lda.w $0014,y
	jsr.w CODE_C5B67A
	jmp.w CODE_C55EC7
CODE_C5BF83:						; from DATA8_C5BEDD
	lda.w $0016,y
	jsr.w CODE_C5B67A
	jmp.w CODE_C55EC7
CODE_C5BF8C:						; from DATA8_C5BEDD
	lda.w $001A,y
	jsr.w CODE_C5B67A
	sta.b r2
	xba
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w CODE_C55ECA
	lda.b r2
	and.w #$000F
	jmp.w CODE_C55ECA
CODE_C5BFB6:						; from DATA8_C5BEDD
	lda.w r1,y
	jsr.w CODE_C5B67A
	sta.b r2
	xba
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.w #$003D
	sta.w $04F5,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w CODE_C55ECA
	lda.b r2
	and.w #$000F
	jmp.w CODE_C55ECA

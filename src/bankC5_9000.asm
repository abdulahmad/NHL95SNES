; Segment bankC5_9000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and a few data tables between routines.
org $C58FD8
CODE_C58FD8:						; called from other segments
	lda.b $97
	asl a
	asl a
	asl a
	adc.b $6F
	tax
	phx
	lda.l $C30006,x
	tay
	lda.w $0000,y
	dec a
	bpl CODE_C58FF6
	lda.l $C30004,x
	tax
	lda.l $C30000,x
	dec a
CODE_C58FF6:						; from CODE_C58FD8
	sta.w $0000,y
	plx
	lda.l $C30008,x
	beq CODE_C5900F
	tax
	lda.l $C4FFFE,x
	beq CODE_C5904B
	dex
	phx
	pea.w $904C
	dec a
	pha
	rts
CODE_C5900F:						; from CODE_C58FF6
	jmp.w CODE_C58F75
CODE_C59012:						; called from other segments
	lda.b $97
	asl a
	asl a
	asl a
	adc.b $6F
	tax
	phx
	lda.l $C30006,x
	tay
	lda.l $C30004,x
	tax
	lda.w $0000,y
	inc a
	cmp.l $C30000,x
	bcc CODE_C59032
	lda.w #$0000
CODE_C59032:						; from CODE_C59012
	sta.w $0000,y
	plx
	lda.l $C30008,x
	beq CODE_C5904D
	tax
	lda.l $C4FFFE,x
	beq CODE_C5904B
	dex
	phx
	pea.w $904C
	dec a
	pha
	rts
CODE_C5904B:						; from CODE_C58FF6, CODE_C59032
	dex
	phx
CODE_C5904D:						; from CODE_C59032
	jmp.w CODE_C58F75
DATA8_C59050:						; not reached by the traced code (data or unused code)
	db $68,$60
CODE_C59052:						; called from other segments
	ldx.b $9B
	lda.w $17C9
	cmp.b $24,x
	beq CODE_C59073
	lda.b $05,x
	sta.b $18
	lda.b $08,x
	sta.b $1A
	jsl.l CODE_C5E596
	lda.w $17C9
	jsl.l CreateSprite
	stx.b $9B
	jsr.w CODE_C5A4B9
CODE_C59073:						; from CODE_C59052
	ldx.b $9D
	lda.w $17CB
	cmp.b $24,x
	beq CODE_C59099
	lda.b $05,x
	sta.b $18
	lda.b $08,x
	sta.b $1A
	jsl.l CODE_C5E596
	lda.w $17CB
	jsl.l CreateSprite
	stx.b $9D
	lda.w #$0001
	sta.b $38,x
	jsr.w CODE_C5A4E2
CODE_C59099:						; from CODE_C59073
	rts
CODE_C5909A:						; called from other segments
	lda.w $010E
CODE_C5909D:						; from CODE_C59595, CODE_C596C0, CODE_C596AF, CODE_C59EDA, ...
	xba
	lsr a
	lsr a
	adc.b $D3
	tay
	ldx.w #$003F
CODE_C590A6:						; from CODE_C590A6
	lda.w $0000,y
	and.w #$E3FF
	ora.w #$0C00
	sta.w $0000,y
	iny
	iny
	dex
	bpl CODE_C590A6
	rts
CODE_C590B8:						; from CODE_C59396
	lda.w $010E
CODE_C590BB:						; from CODE_C596C0, CODE_C596AF, CODE_C59E17, CODE_C59E38
	xba
	lsr a
	lsr a
	adc.b $D3
	tay
	ldx.w #$003F
CODE_C590C4:						; from CODE_C590C4
	lda.w $0000,y
	and.w #$E3FF
	ora.w #$0000
	sta.w $0000,y
	iny
	iny
	dex
	bpl CODE_C590C4
	jsl.l CODE_C4C2AA
	rts
CODE_C590DA:						; called from other segments
	jsl.l CODE_C58D05
	jsl.l FadeOutWait
	lda.w #$0001
	sta.w $059E
	jsl.l CODE_C4C574
	jsl.l CODE_C4C530
	lda.w #$007F
	sta.b $2E
	lda.w #$D80A
	sta.b $2C
	lda.w #$0000
	ldx.w #$00C0
	jsl.l Decompress
	ldy.w #$5000
	jsl.l CODE_C589E4
	ldy.w #$0000
	jsl.l CODE_C589E4
	jsl.l CODE_C4CEDB
	lda.w #$083D
	ldx.w #$00C0
	jsl.l DecompressUnpackbuf
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0240
	pea.w $0010
	pea.w $007E
	pea.w $50DC
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	stz.w DMAEnShadow
	jsl.l CODE_C4CEDB
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$1B,$49,$C0,$00		; inline parameters
	ldx.w #$0060
	jsl.l SetupHDMA
	db $42,$12,$8C,$46,$7E,$7E		; inline parameters
	jsr.w CODE_C5ABC4
	lda.w #$0400
	sta.b $A1
	lda.w #$5800
	sta.b $9F
	lda.w #$87F2
	ldx.w #$00C0
	ldy.w #$2000
	jsr.w CODE_C5852B
	sep #$20
	pea.w $7E80
	plb
	lda.b #$17
	sta.w TM
	lda.b #$09
	sta.w BGMODE
	lda.b #$03
	sta.w OBSEL
	plb
	rep #$20
	lda.w #$3100
	sta.b $A3
	lda.w #$3000
	sta.b $A1
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	pea.w $0080
	pea.w $00C0
	pea.w $3F02
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l CODE_C4BAF6
	lda.w #$56CE
	jsl.l CODE_C4BB5A
	jsl.l CODE_C4CEDB
	lda.w #$4A65
	ldx.w #$00C0
	jsl.l SetNMIHook
	jsl.l CODE_C5E50E
	jsr.w CODE_C5C0BE
	lda.w #$0008
	sta.b $18
	lda.w #$008C
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $63
	jsr.w CODE_C59217
	lda.w #$00D7
	sta.b $18
	lda.w #$00D0
	sta.b $1A
	lda.w #$0020
	jsl.l CreateSprite
	jsr.w CODE_C592A9
	jsl.l CODE_C4CEDB
	lda.w #$C000
	sta.w DMAEnShadow
	lda.w #$2C46
	ldy.w #$0078
	jsl.l CODE_C58B11
	jsl.l CODE_C3716D
	rts
CODE_C59217:						; from CODE_C590DA
	lda.w #$0010
	sta.b $18
	lda.w #$0079
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $73
	lda.w #$0001
	jsl.l CODE_C5ECBD
	lda.w #$00C4
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $75
	inc.b $38,x
	lda.w #$0002
	jsl.l CODE_C5ECBD
	rts
DATA8_C59249:						; not reached by the traced code (data or unused code)
	db $00,$00,$AD,$06,$19,$8F,$45,$60,$30,$D0,$23,$AD,$08,$19,$D0,$1E
	db $1A,$8D,$08,$19,$D4,$97,$AD,$0E,$01,$48,$1A,$1A,$8D,$0E,$01,$E6
	db $97,$20,$75,$8F,$20,$9A,$90,$68,$8D,$0E,$01,$68,$85,$97,$60,$00
	db $00,$AD,$08,$19,$8F,$47,$60,$30,$D0,$23,$AD,$06,$19,$D0,$1E,$1A
	db $8D,$06,$19,$D4,$97,$AD,$0E,$01,$48,$3A,$3A,$8D,$0E,$01,$C6,$97
	db $20,$75,$8F,$20,$9A,$90,$68,$8D,$0E,$01,$68,$85,$97,$60,$00,$00
CODE_C592A9:						; from CODE_C590DA
	lda.w $1864
	beq CODE_C592B4
	dec a
	beq CODE_C592B4
	jsr.w CODE_C5E41D
CODE_C592B4:						; from CODE_C592A9
	lda.w $1864
	cmp.w #$0003
	bne CODE_C592D7
	lda.w $17CB
	cmp.w $17C9
	bne CODE_C592D7
	inc a
	cmp.w #$001A
	bcc CODE_C592CD
	lda.w #$0000
CODE_C592CD:						; from CODE_C592B4
	sta.w $17CB
	sta.l $306043
	jsr.w CODE_C5A3C1
CODE_C592D7:						; from CODE_C592B4
	clc
	lda.w #$0480
	adc.b $D3
	ldy.w #$0200
	jsl.l CODE_C58B11
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	lda.w $1864
	asl a
	tax
	lda.l DATA8_C592FA,x
	jsl.l CODE_C59308
	rts
DATA8_C592FA:						; not reached by the traced code (data or unused code)
	db $CD,$5B,$87,$5C,$17,$5C,$51,$5C,$6B,$5C,$6B,$5C,$7D,$5C
CODE_C59308:						; from CODE_C592D7
	tax
	sta.b $6F
	pei ($D5)
	lda.w #$2C00
	sta.b $D5
	lda.l $C30000,x
	sta.b $69
	dec a
	sta.b $9F
	stz.b $97
	stz.b $99
	lda.w #$0003
	cmp.b $9F
	bcs CODE_C59328
	sta.b $9F
CODE_C59328:						; from CODE_C59308
	ldy.w #$0010
CODE_C5932B:						; from CODE_C5936B
	phy
	phx
	lda.w #$0010
	sta.b $CF
	lda.l $C30002,x
	tax
	jsl.l CODE_C4BC26
	plx
	phx
	lda.w #$0094
	sta.b $CF
	lda.l $C30006,x
	tay
	lda.w $0000,y
	inc a
	asl a
	adc.l $C30004,x
	tax
	lda.l $C30000,x
	tax
	lda.b $03,s
	tay
	lda.w $1864
	cmp.w #$0007
	bne CODE_C59367
	jsl.l CODE_C4BCBC
	bra CODE_C5936B
CODE_C59367:						; from CODE_C5932B
	jsl.l CODE_C4BCA4
CODE_C5936B:						; from CODE_C5932B
	plx
	ply
	iny
	iny
	clc
	txa
	adc.w #$0008
	tax
	dec.b $9F
	bpl CODE_C5932B
	pla
	sta.b $D5
	ldx.b $73
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	ldx.b $75
	lda.b $22,x
	and.w #$FFFE
	ldy.b $69
	cpy.w #$0005
	bcc CODE_C59396
	ora.w #$0001
CODE_C59396:						; from CODE_C5936B
	sta.b $22,x
	jsr.w CODE_C590B8
	rtl
DATA8_C5939C:						; not reached by the traced code (data or unused code)
	db $F0
CODE_C5939D:						; called from other segments
	stz.w $186E
	stz.w $186C
	lda.w $1906
	inc a
	sta.b $7F
	lda.w $1908
	inc a
	sta.b $81
	bra CODE_C593B8
CODE_C593B1:						; called from other segments
	lda.w #$0005
	sta.b $7F
	sta.b $81
CODE_C593B8:						; from CODE_C5939D
	stz.b $83
	stz.b $85
	jsr.w CODE_C5951B
CODE_C593BF:						; from CODE_C593BF
	jsl.l CODE_C36CBF
	jsl.l CODE_C4CEDB
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsr.w CODE_C5945E
	jsr.w CODE_C59483
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.l $7E23BA
	bne CODE_C593F2
	lda.b $7D
	bit.w #$3000
	beq CODE_C593BF
CODE_C593F2:						; from CODE_C593BF
	ldy.w #$0008
CODE_C593F5:						; from CODE_C59412
	ldx.b $73,y
	lda.w #$0000
	sta.w $17B5,y
	lda.b $22,x
	lsr a
	bcc CODE_C59412
	lda.b $05,x
	cmp.w #$0080
	beq CODE_C59412
	lda.w #$0002
	bcc CODE_C5940F
	dec a
CODE_C5940F:						; from CODE_C593F5
	sta.w $17B5,y
CODE_C59412:						; from CODE_C593F5
	dey
	dey
	bpl CODE_C593F5
	jsr.w CODE_C5D0F5
	lda.w $1864
	jsl.l $CF039E
	jsl.l FadeOutWait
	jsl.l forceblack
	jsl.l CODE_C5E50E
	lda.w #$0040
	sta.b $20
	lda.w #$0044
	sta.b $1E
	lda.w #$001D
	jsl.l CreateSpriteSharePal
	lda.w #$0081
	sta.w $17CD
	jsl.l CODE_C5EE6C
	lda.w #$0080
	sta.w $17CF
	jsl.l CODE_C5EE6C
	lda.w #$FFFF
	sta.b $0A,x
	stz.b $20
	stz.b $1E
	jml.l CODE_C4C530
CODE_C5945E:						; from CODE_C593BF
	ldy.w #$0004
CODE_C59461:						; from CODE_C5947C
	phy
	lda.w $0595,y
	and.w #$00FF
	dec a
	tax
	tya
	asl a
	tay
	cpx.w #$0001
	ldx.b $73,y
	lda.b $22,x
	ora.w #$0001
	bcc CODE_C5947C
	and.w #$FFFE
CODE_C5947C:						; from CODE_C59461
	sta.b $22,x
	ply
	dey
	bpl CODE_C59461
	rts
CODE_C59483:						; from CODE_C593BF
	stz.b $7D
	lda.w $00C1
	cmp.w $0565
	beq CODE_C59492
	ldx.b $73
	jsr.w CODE_C594C6
CODE_C59492:						; from CODE_C59483
	lda.w $00C3
	cmp.w $0567
	beq CODE_C5949F
	ldx.b $75
	jsr.w CODE_C594C6
CODE_C5949F:						; from CODE_C59492
	lda.w $00C5
	cmp.w $0569
	beq CODE_C594AC
	ldx.b $77
	jsr.w CODE_C594C6
CODE_C594AC:						; from CODE_C5949F
	lda.w $00C7
	cmp.w $056B
	beq CODE_C594B9
	ldx.b $79
	jsr.w CODE_C594C6
CODE_C594B9:						; from CODE_C594AC
	lda.w $00C9
	cmp.w $056D
	beq CODE_C594C5
	ldx.b $7B
	bra CODE_C594C6
CODE_C594C5:						; from CODE_C594B9
	rts
CODE_C594C6:						; from CODE_C59483, CODE_C59492, CODE_C5949F, CODE_C594AC, ...
	tsb.b $7D
	bit.w #$0100
	beq CODE_C594F2
	lda.b $05,x
	cmp.w #$0080
	bcc CODE_C594DE
	lda.b $83
	cmp.b $7F
	bcs CODE_C5951A
	lda.b $05,x
	bra CODE_C594E0
CODE_C594DE:						; from CODE_C594C6
	dec.b $85
CODE_C594E0:						; from CODE_C594C6
	adc.w #$0040
	cmp.w #$00C0
	bne CODE_C594EA
	inc.b $83
CODE_C594EA:						; from CODE_C594E0
	cmp.w #$00C1
	bcs CODE_C5951A
CODE_C594EF:						; from CODE_C59515
	sta.b $05,x
	rts
CODE_C594F2:						; from CODE_C594C6
	bit.w #$0200
	beq CODE_C5951A
	lda.b $05,x
	cmp.w #$0081
	bcc CODE_C59502
	dec.b $83
	bra CODE_C5950B
CODE_C59502:						; from CODE_C594F2
	lda.b $85
	cmp.b $81
	bcs CODE_C5951A
	lda.b $05,x
	sec
CODE_C5950B:						; from CODE_C594F2
	sbc.w #$0040
	cmp.w #$0040
	bne CODE_C59515
	inc.b $85
CODE_C59515:						; from CODE_C5950B
	cmp.w #$003F
	bcs CODE_C594EF
CODE_C5951A:						; from CODE_C594C6, CODE_C594F2, CODE_C594EA, CODE_C59502
	rts
CODE_C5951B:						; from CODE_C593B8
	ldx.b $63
	jsl.l CODE_C5E596
	ldx.b $73
	jsl.l CODE_C5E596
	ldx.b $75
	jsl.l CODE_C5E596
	jsr.w CODE_C5BBC0
	lda.w #$0003
	sta.b $1E
	inc.b $20
	lda.w #$0080
	sta.b $18
	lda.w #$00C8
	sta.b $1A
	ldy.w #$0008
CODE_C59544:						; from CODE_C59544
	phy
	lda.w #$001D
	jsl.l CreateSprite
	ply
	stx.b $73,y
	lda.b $1A
	sbc.w #$000F
	sta.b $1A
	tya
	lsr a
	jsl.l CODE_C5ECBD
	dey
	dey
	bpl CODE_C59544
	stz.b $1E
	stz.b $20
	lda.b $D3
	ldy.w #$0340
	jsl.l CODE_C58B11
	clc
	lda.b $D3
	adc.w #$03C0
	ldy.w #$0340
	jsl.l CODE_C58B11
	lda.w #$57FC
	jsl.l CODE_C4BB5A
	lda.w #$0005
	sta.w fadestep
	rts
CODE_C59588:						; called from other segments
	lda.l $306050
	ora.l $306051
	bne CODE_C59595
	jmp.w CODE_C5963A
CODE_C59595:						; from CODE_C59588
	ldy.w #$0280
	lda.b $D3
	clc
	adc.w #$0400
	jsl.l CODE_C58B11
	jsl.l CODE_C4C2AA
	lda.w #$8000
	sta.w DMAEnShadow
	lda.w #$FFFF
	sta.w $04C6
	jsl.l CODE_C4CEDB
	jsr.w CODE_C5A50B
	jsr.w CODE_C5BBC0
	lda.w #$0005
	sta.w $18DE
	lda.w #$0008
	sta.b $CF
	ldy.w #$0010
	ldx.w #$479B
	jsl.l CODE_C4BC26
	lda.w #$005C
	sta.b $CF
	ldy.w #$0010
	ldx.w #$4724
	jsl.l CODE_C4BBFC
	ldy.w #$0011
	ldx.w #$4735
	jsl.l CODE_C4BBFC
	ldy.w #$0012
	ldx.w #$4743
	jsl.l CODE_C4BBFC
	ldy.w #$0013
	ldx.w #$4753
	jsl.l CODE_C4BBFC
	lda.w #$0009
	sta.w $18DE
	lda.w #$0032
	sta.b $CF
	ldy.w #$0015
	ldx.w #$4764
	jsl.l CODE_C4BC26
	ldy.w #$0018
	ldx.w #$476E
	jsl.l CODE_C4BC26
	ldx.b $63
	lda.w #$0028
	sta.b $05,x
	lda.w #$00B5
	sta.b $08,x
	lda.w #$0018
	jsr.w CODE_C5909D
	jsl.l CODE_C4C2AA
	lda.w #$000D
	sta.b $99
	bra CODE_C59651
CODE_C5963A:						; from CODE_C59588
	jsl.l FadeOutWait
	jsr.w CODE_C5A51C
	bra CODE_C59651
CODE_C59643:						; from CODE_C596D3
	jsl.l FadeOutWait
	jsl.l CODE_C406A8
	jsr.w CODE_C5A09B
	stz.w fadestep
CODE_C59651:						; from CODE_C59651, CODE_C59595, CODE_C5963A
	jsl.l CODE_C4CEDB
	jsl.l CODE_C36C2D
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.b $99
	asl a
	tax
	jsr (DATA8_C5967A,x)
	bra CODE_C59651
DATA8_C5967A:						; jump table: the routine for each index
	dw CODE_C59768,CODE_C59768,CODE_C59696,CODE_C59DAF
	dw CODE_C59930,CODE_C59767,$AC07,$A816
	dw $A5B0,$A623,$A66E,$A773
	dw $AB16,$AB27
CODE_C59696:						; from DATA8_C5967A
	lda.w $058F
	beq CODE_C5969C
	rts
CODE_C5969C:						; from CODE_C59696
	lda.w $058D
	bit.w #$0400
	bne CODE_C596C0
	bit.w #$0800
	bne CODE_C596AF
	bit.w #$1000
	bne CODE_C596D3
	rts
CODE_C596AF:						; from CODE_C5969C, CODE_C5988C
	stz.b $97
	lda.w #$0012
	jsr.w CODE_C5909D
	lda.w #$000F
	jsr.w CODE_C590BB
CODE_C596BD:						; from CODE_C596C0
	jmp.w CODE_C5A164
CODE_C596C0:						; from CODE_C5969C
	lda.w #$0001
	sta.b $97
	lda.w #$000F
	jsr.w CODE_C5909D
	lda.w #$0012
	jsr.w CODE_C590BB
	bra CODE_C596BD
CODE_C596D3:						; from CODE_C5969C
	lda.b $97
	beq CODE_C596DB
	pla
	jmp.w CODE_C59643
CODE_C596DB:						; from CODE_C596D3
	jsl.l FadeOutWait
	inc.b $99
	lda.w $4672
	and.w #$00FF
	dec a
	ldx.w #$4673
	ldy.w #$04F5
	mvn $7E,$7E
	lda.w #$0020
	sta.w $0000,y
	iny
	ldx.w #$467D
	lda.w $467C
	and.w #$00FF
	mvn $7E,$7E
	lda.b $D3
	ldy.w #$0700
	jsl.l CODE_C58B11
	ldy.w #$5C00
	jsl.l CODE_C589E4
	lda.w #$5746
	jsl.l CODE_C4BB5A
	lda.w #$0010
	sta.b $CF
	ldx.w #$04F5
	ldy.w #$0002
	jsl.l CODE_C4BDCA
	jsl.l CODE_C4C2AA
	stz.b $7F
	stz.b $85
	lda.w #$0032
	sta.b $83
	lda.w #$0008
	sta.b $81
	stz.b $97
	lda.w #$0078
	sta.b $CF
	jsr.w CODE_C5A291
	jsr.w CODE_C5A2B4
	jsr.w CODE_C5A2D3
	jsr.w CODE_C5A2EC
	lda.w #$0005
	sta.w fadestep
	lda.w #$000B
	jsr.w CODE_C5909D
	lda.w #$000E
	jsr.w CODE_C5909D
	lda.w #$0011
	jmp.w CODE_C5909D
CODE_C59767:						; from DATA8_C5967A, CODE_C59768
	rts
CODE_C59768:						; from DATA8_C5967A
	lda.w $058F
	beq CODE_C59778
	cmp.w #$0014
	bcc CODE_C59767
	lda.w #$0010
	sta.w $058F
CODE_C59778:						; from CODE_C59768
	lda.w $058D
	bit.w #$0800
	bne CODE_C597C0
	bit.w #$0400
	bne CODE_C597AA
	bit.w #$0200
	bne CODE_C597D3
	bit.w #$0100
	bne CODE_C597DF
	bit.w #$8080
	bne CODE_C5980A
	bit.w #$4030
	bne CODE_C597EE
	bit.w #$1000
	beq CODE_C597A1
	jmp.w CODE_C59837
CODE_C597A1:						; from CODE_C59778
	bit.w #$0040
	beq CODE_C597A9
	jmp.w CODE_C59D3B
CODE_C597A9:						; from CODE_C597A1
	rts
CODE_C597AA:						; from CODE_C59778
	jsr.w CODE_C5A17B
	clc
	lda.b $97
	adc.w #$0009
	cmp.w #$001B
	bcc CODE_C597CE
	sbc.w #$001B
	sta.b $97
	jmp.w CODE_C5A20D
CODE_C597C0:						; from CODE_C59778
	jsr.w CODE_C5A17B
	sec
	lda.b $97
	sbc.w #$0009
	bcs CODE_C597CE
	adc.w #$001B
CODE_C597CE:						; from CODE_C597C0, CODE_C597AA, CODE_C597D3, CODE_C597DF
	sta.b $97
CODE_C597D0:						; from CODE_C597D3, CODE_C597DF
	jmp.w CODE_C5A20D
CODE_C597D3:						; from CODE_C59778
	jsr.w CODE_C5A17B
	dec.b $97
	bpl CODE_C597D0
	lda.w #$001A
	bra CODE_C597CE
CODE_C597DF:						; from CODE_C59778
	jsr.w CODE_C5A17B
	lda.b $97
	inc a
	cmp.w #$001B
	bcc CODE_C597CE
	stz.b $97
	bra CODE_C597D0
CODE_C597EE:						; from CODE_C59778
	sep #$30
	lda.b #$3E
	ldy.b $69
	dey
	cpy.b $6F
	bne CODE_C597FE
	cmp.w $04F5,y
	bne CODE_C59803
CODE_C597FE:						; from CODE_C597EE
	ldy.b $6F
	beq CODE_C59803
	dey
CODE_C59803:						; from CODE_C597EE, CODE_C597FE
	sta.w $04F5,y
	sty.b $6F
	bra CODE_C59824
CODE_C5980A:						; from CODE_C59778
	sep #$30
	ldx.b $97
	lda.l DATA8_C598FA,x
	ldy.b $6F
	beq CODE_C5981A
	lda.l $C59915,x
CODE_C5981A:						; from CODE_C5980A
	sta.w $04F5,y
	iny
	cpy.b $69
	bcs CODE_C59824
	sty.b $6F
CODE_C59824:						; from CODE_C5981A, CODE_C59803
	rep #$30
	lda.w #$000F
	ldy.b $71
	ldx.w #$04F5
	jsl.l CODE_C4BC46
	jsl.l CODE_C4CEDB
	rts
CODE_C59837:						; from CODE_C59778
	lda.b $6F
	bne CODE_C5983C
	rts
CODE_C5983C:						; from CODE_C59837
	lda.b $99
	bne CODE_C5988C
	inc.b $99
	jsr.w CODE_C598C9
	jsr.w CODE_C598EB
	tyx
	stz.w $04F5,x
	tya
	sta.w $4672
	ldx.w #$04F5
	ldy.w #$4673
	mvn $7E,$7E
	ldy.b $71
	ldx.w #$4673
	jsl.l CODE_C4BC9E
	jsl.l CODE_C4C2AA
	lda.w #$3E3E
	sta.w $04F5
	sta.w $04F7
	sta.w $04F9
	sta.w $04FB
	sta.w $04FD
	stz.w $04FF
	lda.w #$0008
	sta.b $71
	lda.w #$000A
	sta.b $69
	stz.b $6F
	jsl.l CODE_C4CEDB
	rts
CODE_C5988C:						; from CODE_C5983C
	jsr.w CODE_C598C9
	jsr.w CODE_C598EB
	tyx
	stz.w $04F5,x
	tya
	sta.w $467C
	ldx.w #$04F5
	ldy.w #$467D
	mvn $7E,$7E
	ldy.b $71
	ldx.w #$467D
	jsl.l CODE_C4BC9E
	ldy.w #$0200
	clc
	lda.b $D3
	adc.w #$0300
	jsl.l CODE_C58B11
	jsl.l CODE_C4CEDB
	lda.w #$56DC
	jsl.l CODE_C4BB5A
	inc.b $99
	jmp.w CODE_C596AF
CODE_C598C9:						; from CODE_C5983C, CODE_C5988C
	lda.b $71
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$001E
	pha
	ldy.w #$0022
	phy
	jsl.l CODE_C58B11
	ply
	pla
	clc
	adc.w #$0040
	jsl.l CODE_C58B11
	jsl.l CODE_C4C2AA
	rts
CODE_C598EB:						; from CODE_C5983C, CODE_C5988C
	sep #$30
	ldy.b $6F
	lda.b #$3E
	cmp.w $04F5,y
	beq CODE_C598F7
	iny
CODE_C598F7:						; from CODE_C598EB
	rep #$30
	rts
DATA8_C598FA:						; not reached by the traced code (data or unused code)
	db $41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50
	db $51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$3D,$61,$62,$63,$64,$65
	db $66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$70,$71,$72,$73,$74,$75
	db $76,$77,$78,$79,$7A,$3D
CODE_C59930:						; from DATA8_C5967A
	jsr.w CODE_C59938
	jsl.l CODE_C4C2AA
	rts
CODE_C59938:						; from CODE_C59930
	lda.b $7F
	beq CODE_C59944
	jsr.w CODE_C59998
	lda.w #$0007
	bra CODE_C5995B
CODE_C59944:						; from CODE_C59938
	ldx.b $63
	lda.b $97
	asl a
	asl a
	asl a
	adc.w #$0046
	sta.b $08,x
	lda.w #$0010
	sta.b $05,x
	jsr.w CODE_C59ADD
	lda.w #$0008
CODE_C5995B:						; from CODE_C59938
	clc
	adc.b $97
	xba
	lsr a
	lsr a
	adc.b $D3
	tax
	ldy.w #$001F
CODE_C59967:						; from CODE_C59967
	lda.l $7E0000,x
	and.w #$E3FF
	sta.l $7E0000,x
	inx
	inx
	dey
	bpl CODE_C59967
	rts
CODE_C59978:						; from CODE_C59ABF, CODE_C59B18, CODE_C59B25, CODE_C59ACC
	clc
	adc.b $97
	xba
	lsr a
	lsr a
	adc.b $D3
	tax
	ldy.w #$001F
CODE_C59984:						; from CODE_C59984
	lda.l $7E0000,x
	and.w #$E3FF
	ora.w #$0C00
	sta.l $7E0000,x
	inx
	inx
	dey
	bpl CODE_C59984
CODE_C59997:						; from CODE_C59998
	rts
CODE_C59998:						; from CODE_C59938
	ldx.b $63
	lda.b $97
	asl a
	asl a
	asl a
	adc.w #$003E
	sta.b $08,x
	lda.w #$0010
	sta.b $05,x
	lda.w $058F
	beq CODE_C599B9
	cmp.w #$0014
	bcc CODE_C59997
	lda.w #$0010
	sta.w $058F
CODE_C599B9:						; from CODE_C59998
	lda.w $058D
	bit.w #$0040
	beq CODE_C599C4
	jmp.w CODE_C59D39
CODE_C599C4:						; from CODE_C599B9
	bit.w #$0800
	beq CODE_C599CC
	jmp.w CODE_C59ABF
CODE_C599CC:						; from CODE_C599C4
	bit.w #$0400
	beq CODE_C599D4
	jmp.w CODE_C59ACC
CODE_C599D4:						; from CODE_C599CC
	bit.w #$0200
	bne CODE_C599E7
	bit.w #$0100
	bne CODE_C59A4B
	bit.w #$1000
	beq CODE_C599E6
	jmp.w CODE_C59B36
CODE_C599E6:						; from CODE_C599D4
	rts
CODE_C599E7:						; from CODE_C59AF8, CODE_C599D4
	lda.b $97
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$01F2
	ldx.b $7F
	bne CODE_C599F8
	adc.w #$0040
CODE_C599F8:						; from CODE_C599E7
	tax
	stz.w $0000,x
	stz.w $0002,x
	stz.w $0004,x
	stz.w $0006,x
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	lda.b $97
	asl a
	tax
	lda.w $0527,x
	dec a
	bpl CODE_C59A22
	sec
	lda.b $87
	sbc.w #$0005
	sta.b $87
	lda.w #$0000
CODE_C59A22:						; from CODE_C599F8
	sta.w $0527,x
	pha
	jsr.w CODE_C59AB0
	pla
	asl a
	tax
	clc
	lda.b $87
	adc.w #$0005
	sta.b $87
	lda.b $97
	clc
	adc.w #$0007
	tay
	lda.b $7F
	bne CODE_C59A40
	iny
CODE_C59A40:						; from CODE_C59A22
	ldx.w #$04F5
	jsl.l CODE_C4BC1A
	jmp.w CODE_C59F79
DATA8_C59A4A:						; not reached by the traced code (data or unused code)
	db $60
CODE_C59A4B:						; from CODE_C59B0A, CODE_C599D4
	lda.b $97
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$01F2
	ldx.b $7F
	bne CODE_C59A5C
	adc.w #$0040
CODE_C59A5C:						; from CODE_C59A4B
	tax
	stz.w $0000,x
	stz.w $0002,x
	stz.w $0004,x
	stz.w $0006,x
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	lda.b $97
	asl a
	tax
	lda.w $0527,x
	cmp.w #$000F
	bcs CODE_C59A90
	asl a
	tax
	lda.b $87
	sec
	sbc.w #$0005
	bmi CODE_C59A90
	sta.b $87
	lda.b $97
	asl a
	tax
	inc.w $0527,x
CODE_C59A90:						; from CODE_C59A5C
	lda.b $97
	asl a
	tax
	lda.w $0527,x
	jsr.w CODE_C59AB0
	lda.b $97
	clc
	adc.w #$0007
	tay
	lda.b $7F
	bne CODE_C59AA6
	iny
CODE_C59AA6:						; from CODE_C59A90
	ldx.w #$04F5
	jsl.l CODE_C4BC1A
	jmp.w CODE_C59F79
CODE_C59AB0:						; from CODE_C59A22, CODE_C59A90
	sta.b $A1
	asl a
	asl a
	adc.b $A1
	adc.w #$0019
	jsr.w CODE_C5B67A
	jmp.w CODE_C55EC7
CODE_C59ABF:						; from CODE_C599C4
	lda.w #$0007
	jsr.w CODE_C59978
	dec.b $97
	bpl CODE_C59ACB
	stz.b $97
CODE_C59ACB:						; from CODE_C59ABF, CODE_C59ACC
	rts
CODE_C59ACC:						; from CODE_C599CC
	lda.w #$0007
	jsr.w CODE_C59978
	lda.b $97
	inc a
	cmp.w #$000B
	bcs CODE_C59ACB
	sta.b $97
CODE_C59ADC:						; from CODE_C59ADD
	rts
CODE_C59ADD:						; from CODE_C59944
	lda.w $058F
	beq CODE_C59AED
	cmp.w #$0014
	bcc CODE_C59ADC
	lda.w #$0010
	sta.w $058F
CODE_C59AED:						; from CODE_C59ADD
	lda.w $058D
	bit.w #$0040
	beq CODE_C59AF8
	jmp.w CODE_C59D39
CODE_C59AF8:						; from CODE_C59AED
	bit.w #$0800
	bne CODE_C59B18
	bit.w #$0400
	bne CODE_C59B25
	bit.w #$0200
	beq CODE_C59B0A
	jmp.w CODE_C599E7
CODE_C59B0A:						; from CODE_C59AF8
	bit.w #$0100
	beq CODE_C59B12
	jmp.w CODE_C59A4B
CODE_C59B12:						; from CODE_C59B0A
	bit.w #$1000
	bne CODE_C59B36
	rts
CODE_C59B18:						; from CODE_C59AF8
	lda.w #$0008
	jsr.w CODE_C59978
	dec.b $97
	bpl CODE_C59B24
	stz.b $97
CODE_C59B24:						; from CODE_C59B18, CODE_C59B25
	rts
CODE_C59B25:						; from CODE_C59AF8
	lda.w #$0008
	jsr.w CODE_C59978
	lda.b $97
	inc a
	cmp.w #$0008
	bcs CODE_C59B24
	sta.b $97
	rts
CODE_C59B36:						; from CODE_C599D4, CODE_C59B12
	lda.w #$026A
	sta.b $A5
	ldy.w #$0003
CODE_C59B3E:						; from CODE_C59B3E
	jsr.w CODE_C59D96
	cmp.w #$0000
	beq CODE_C59B56
	inc.b $A5
	clc
	tya
	adc.w #$009C
	tay
	cpy.w #$0C30
	bcc CODE_C59B3E
	jmp.w CODE_C59D39
CODE_C59B56:						; from CODE_C59B3E
	tya
	sec
	sbc.w #$0003
	tay
	sta.b $A1
	sta.b $34
	lda.w #$000D
	sta.b $30
	jsl.l Div16U
	clc
	lda.b $2C
	adc.w #$1CF8
	sta.b $2C
	lsr a
	lsr a
	lsr a
	tax
	lda.b $83
	xba
	lsr a
	lsr a
	lsr a
	sta.b $9F
	lda.b $2C
	and.w #$0007
	beq CODE_C59B96
	lda.b $83
	xba
	asl a
	sta.b $9F
	lda.l $306A56,x
	and.w #$000F
	ora.w #$01A0
	bra CODE_C59BA0
CODE_C59B96:						; from CODE_C59B56
	lda.l $306A56,x
	and.w #$F000
	ora.w #$001A
CODE_C59BA0:						; from CODE_C59B56
	ora.b $9F
	sta.l $306A56,x
	ldy.b $A1
	lda.b $7F
	sta.b $A3
	jsr.w CODE_C59D4B
	ldx.w #$0000
CODE_C59BB2:						; from CODE_C59BC2
	lda.w $4673,x
	and.w #$00FF
	beq CODE_C59BCF
	cmp.w #$003D
	bne CODE_C59BC2
	lda.w #$001D
CODE_C59BC2:						; from CODE_C59BB2
	phx
	sta.b $A3
	jsr.w CODE_C59D45
	plx
	inx
	cpx.w #$0008
	bcc CODE_C59BB2
CODE_C59BCF:						; from CODE_C59BB2
	cpx.w #$0008
	bcs CODE_C59BD9
	stz.b $A3
	jsr.w CODE_C59D45
CODE_C59BD9:						; from CODE_C59BCF
	clc
	lda.b $A1
	adc.w #$002B
	tay
	ldx.w #$0000
CODE_C59BE3:						; from CODE_C59BF3
	lda.w $467D,x
	and.w #$00FF
	beq CODE_C59C00
	cmp.w #$003D
	bne CODE_C59BF3
	lda.w #$001D
CODE_C59BF3:						; from CODE_C59BE3
	phx
	sta.b $A3
	jsr.w CODE_C59D45
	plx
	inx
	cpx.w #$000A
	bcc CODE_C59BE3
CODE_C59C00:						; from CODE_C59BE3
	cpx.w #$000A
	bcs CODE_C59C0A
	stz.b $A3
	jsr.w CODE_C59D45
CODE_C59C0A:						; from CODE_C59C00
	clc
	lda.b $A1
	adc.w #$005D
	tay
	lda.b $83
	sta.b $A3
	jsr.w CODE_C59D3F
	lda.b $7F
	bne CODE_C59C1F
	jmp.w CODE_C59CC1
CODE_C59C1F:						; from CODE_C59C0A
	lda.w $0529
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.b $81
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $052D
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $0527
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $0533
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $052F
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.b $85
	sta.b $A3
	jsr.w CODE_C59D51
	lda.w $053D
	jsr.w CODE_C5A07A
	lsr a
	sta.b $A3
	jsr.w CODE_C59D4B
	lda.w $053B
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $0535
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $0531
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.b $26
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $052B
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $0539
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $0537
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.b $A5
	jsr.w CODE_C5E447
	jmp.w CODE_C59D39
CODE_C59CC1:						; from CODE_C59C0A
	lda.w $0529
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.b $81
	sta.b $A3
	jsr.w CODE_C59D48
	stz.b $A3
	jsr.w CODE_C59D48
	lda.w $0527
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $052D
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $052B
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.b $85
	sta.b $A3
	jsr.w CODE_C59D48
	stz.b $A3
	jsr.w CODE_C59D48
	stz.b $A3
	jsr.w CODE_C59D48
	jsr.w CODE_C59D48
	lda.w $052F
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $0531
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $0533
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
	lda.w $0535
	jsr.w CODE_C5A07A
	sta.b $A3
	jsr.w CODE_C59D48
CODE_C59D39:						; from CODE_C599B9, CODE_C59AED, CODE_C59B3E, CODE_C59C1F
	pla
CODE_C59D3A:						; from CODE_C59DCE
	pla
CODE_C59D3B:						; from CODE_C597A1
	pla
	jmp.w CODE_C58D32
CODE_C59D3F:						; from CODE_C59C0A
	jsr.w CODE_C59D51
	jsr.w CODE_C59D51
CODE_C59D45:						; from CODE_C59BC2, CODE_C59BCF, CODE_C59BF3, CODE_C59C00
	jsr.w CODE_C59D51
CODE_C59D48:						; from CODE_C59C1F, CODE_C59CC1
	jsr.w CODE_C59D51
CODE_C59D4B:						; from CODE_C59BA0, CODE_C59C1F
	jsr.w CODE_C59D51
	jsr.w CODE_C59D51
CODE_C59D51:						; from CODE_C59D4B, CODE_C59D45, CODE_C59D48, CODE_C59D3F, ...
	lsr.b $A3
	bcs CODE_C59D77
	tya
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	eor.w #$FFFF
	sta.b $9F
	tya
	lsr a
	lsr a
	lsr a
	tax
	lda.l $307162,x
	and.b $9F
	sta.l $307162,x
	iny
	rts
CODE_C59D77:						; from CODE_C59D51
	tya
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	sta.b $9F
	tya
	lsr a
	lsr a
	lsr a
	tax
	lda.l $307162,x
	ora.b $9F
	sta.l $307162,x
	iny
	rts
CODE_C59D96:						; from CODE_C59B3E
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	sta.b $9F
	lda.l $307162,x
CODE_C59DA5:						; from CODE_C59DA5
	lsr a
	dec.b $9F
	bpl CODE_C59DA5
	rol a
	and.w #$001F
	rts
CODE_C59DAF:						; from DATA8_C5967A
	jsr.w CODE_C59DBE
	lda.b $26
	lsr a
	bcs CODE_C59DBB
	jsl.l CODE_C4C2AA
CODE_C59DBB:						; from CODE_C59DAF
	jmp.w CODE_C59F62
CODE_C59DBE:						; from CODE_C59DAF
	lda.w $058F
	beq CODE_C59DCE
	cmp.w #$0014
	bcc CODE_C59E03
	lda.w #$000F
	sta.w $058F
CODE_C59DCE:						; from CODE_C59DBE
	lda.w $058D
	bit.w #$1000
	bne CODE_C59E43
	bit.w #$0800
	bne CODE_C59E04
	bit.w #$0400
	bne CODE_C59E22
	bit.w #$0040
	beq CODE_C59DE8
	jmp.w CODE_C59D3A
CODE_C59DE8:						; from CODE_C59DCE
	bit.w #$0200
	beq CODE_C59DF7
	lda.b $97
	asl a
	tax
	jsr (DATA8_C59EF2,x)
	lda.w $058D
CODE_C59DF7:						; from CODE_C59DE8
	bit.w #$0100
	beq CODE_C59E03
	lda.b $97
	asl a
	tax
	jsr (DATA8_C59EFA,x)
CODE_C59E03:						; from CODE_C59DBE, CODE_C59DF7
	rts
CODE_C59E04:						; from CODE_C59DCE
	lda.b $97
	asl a
	adc.b $97
	adc.w #$0008
	jsr.w CODE_C5909D
	lda.b $97
	dec a
	bpl CODE_C59E17
	lda.w #$0003
CODE_C59E17:						; from CODE_C59E04
	sta.b $97
	asl a
	adc.b $97
	adc.w #$0008
	jmp.w CODE_C590BB
CODE_C59E22:						; from CODE_C59DCE
	lda.b $97
	asl a
	adc.b $97
	adc.w #$0008
	jsr.w CODE_C5909D
	lda.b $97
	inc a
	cmp.w #$0004
	bcc CODE_C59E38
	lda.w #$0000
CODE_C59E38:						; from CODE_C59E22
	sta.b $97
	asl a
	adc.b $97
	adc.w #$0008
	jmp.w CODE_C590BB
CODE_C59E43:						; from CODE_C59DCE
	jsl.l FadeOutWait
	clc
	lda.b $D3
	adc.w #$0180
	ldy.w #$0580
	jsl.l CODE_C58B11
	ldy.w #$5C00
	jsl.l CODE_C589B0
	lda.w #$576C
	ldx.b $7F
	beq CODE_C59E65
	lda.w #$57AE
CODE_C59E65:						; from CODE_C59E43
	jsl.l CODE_C4BB5A
	jsl.l CODE_C4CEDB
	ldx.b $63
	lda.w #$0003
	jsl.l CODE_C5ECBD
	lda.b $36,x
	and.w #$BFFF
	sta.b $36,x
	inc.b $99
	stz.b $97
	lda.w #$0145
	sta.b $87
	lda.w #$0003
	sta.w $0527
	lda.w #$0027
	ldx.w #$0527
	ldy.w #$0529
	mvn $7E,$7E
	lda.w #$00E8
	sta.b $D1
	ldx.w #$0010
	ldy.w #$0008
	lda.b $7F
	beq CODE_C59EAB
	ldx.w #$0016
	dey
CODE_C59EAB:						; from CODE_C59E65
	stx.b $9F
	ldx.w #$0000
CODE_C59EB0:						; from CODE_C59EB0
	lda.w $0527,x
	phx
	phy
	sta.b $A1
	asl a
	asl a
	adc.b $A1
	adc.w #$0019
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldx.w #$04F5
	jsl.l CODE_C4BC1A
	ply
	plx
	iny
	inx
	inx
	cpx.b $9F
	bcc CODE_C59EB0
	jsr.w CODE_C59F79
	lda.w #$0008
CODE_C59EDA:						; from CODE_C59EDA
	pha
	jsr.w CODE_C5909D
	pla
	inc a
	inc a
	cmp.w #$0014
	bcc CODE_C59EDA
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	stz.w fadestep
	rts
DATA8_C59EF2:						; jump table: the routine for each index
	dw CODE_C59F02,CODE_C59F1D,CODE_C59F37,CODE_C59F51
DATA8_C59EFA:						; jump table: the routine for each index
	dw CODE_C59F10,CODE_C59F2A,CODE_C59F44,CODE_C59F51
CODE_C59F02:						; from DATA8_C59EF2
	lda.b $7F
	dec a
	bpl CODE_C59F0A
	lda.w #$0005
CODE_C59F0A:						; from CODE_C59F02, CODE_C59F10
	sta.b $7F
	jmp.w CODE_C5A291
DATA8_C59F0F:						; not reached by the traced code (data or unused code)
	db $60
CODE_C59F10:						; from DATA8_C59EFA
	lda.b $7F
	inc a
	cmp.w #$0006
	bcc CODE_C59F0A
	lda.w #$0000
	bra CODE_C59F0A
CODE_C59F1D:						; from DATA8_C59EF2
	lda.b $81
	dec a
	bpl CODE_C59F25
	lda.w #$000F
CODE_C59F25:						; from CODE_C59F1D, CODE_C59F2A
	sta.b $81
	jmp.w CODE_C5A2B4
CODE_C59F2A:						; from DATA8_C59EFA
	lda.b $81
	inc a
	cmp.w #$0010
	bcc CODE_C59F25
	lda.w #$0000
	bra CODE_C59F25
CODE_C59F37:						; from DATA8_C59EF2
	lda.b $83
	dec a
	bpl CODE_C59F3F
	lda.w #$0063
CODE_C59F3F:						; from CODE_C59F37, CODE_C59F44
	sta.b $83
	jmp.w CODE_C5A2D3
CODE_C59F44:						; from DATA8_C59EFA
	lda.b $83
	inc a
	cmp.w #$0064
	bcc CODE_C59F3F
	lda.w #$0000
	bra CODE_C59F3F
CODE_C59F51:						; from DATA8_C59EF2, DATA8_C59EFA
	lda.b $85
	bne CODE_C59F5D
	lda.w #$0001
	sta.b $85
	jmp.w CODE_C5A2EC
CODE_C59F5D:						; from CODE_C59F51
	stz.b $85
	jmp.w CODE_C5A2EC
CODE_C59F62:						; from CODE_C59DBB
	ldx.b $63
	lda.w #$0073
	sta.b $05,x
	lda.b $97
	asl a
	asl a
	asl a
	sta.b $9F
	asl a
	adc.b $9F
	adc.w #$0050
	sta.b $08,x
	rts

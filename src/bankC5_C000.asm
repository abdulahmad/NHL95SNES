; Segment bankC5_C000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C5BFE0
CODE_C5BFE0:						; called from other segments
	ldx.b $83
	lda.l DATA8_C04CBF,x
	and.w #$00FF
	sta.b $9F
	lda.l DATA8_C04CC3,x
	and.w #$00FF
	sta.b $67
	ldy.w #$0032
CODE_C5BFF7:						; from CODE_C5C00F
	ldx.w $3E4E,y
	lda.w $000C,x
	tax
	lda.l $C40EDA,x
	and.w #$00FF
	cmp.b $9F
	beq CODE_C5C00F
	lda.w #$0000
	sta.w $3E4E,y
CODE_C5C00F:						; from CODE_C5BFF7
	dey
	dey
	bpl CODE_C5BFF7
	ldx.w #$0000
	txy
CODE_C5C017:						; from CODE_C5C021
	lda.w $3E4E,x
	beq CODE_C5C021
	sta.w $3E4E,y
	iny
	iny
CODE_C5C021:						; from CODE_C5C017
	inx
	inx
	cpx.w #$0034
	bcc CODE_C5C017
	rts
CODE_C5C029:						; called from other segments
	ldx.w #$0032
CODE_C5C02C:						; from CODE_C5C02C
	stz.w $3E4E,x
	dex
	dex
	bpl CODE_C5C02C
	lda.b $7F
	asl a
	tax
	lda.l DATA8_C5C0AE,x
	sta.b $9F
	lda.b $81
CODE_C5C03F:						; from CODE_C5C05C
	tax
	stx.b $A1
	ldy.w #$0000
	bra CODE_C5C04A
CODE_C5C047:						; from CODE_C5C068, CODE_C5C072, CODE_C5C07C, CODE_C5C086, ...
	ply
CODE_C5C048:						; from CODE_C5C054
	iny
	iny
CODE_C5C04A:						; from CODE_C5C03F
	lda.w $3E4E,y
	beq CODE_C5C05C
	phy
	tay
	jmp ($009F)
CODE_C5C054:						; from CODE_C5C068, CODE_C5C072, CODE_C5C07C, CODE_C5C086, ...
	txa
	tyx
	ply
	sta.w $3E4E,y
	bra CODE_C5C048
CODE_C5C05C:						; from CODE_C5C04A
	txa
	sta.w $3E4E,y
	ldx.b $A1
	lda.w $0002,x
	bne CODE_C5C03F
	rts
CODE_C5C068:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $000A,y
	cmp.w $000A,x
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C072:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $0010,y
	cmp.w $0010,x
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C07C:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $0012,x
	cmp.w $0012,y
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C086:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $0014,y
	cmp.w $0014,x
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C090:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $0016,y
	cmp.w $0016,x
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C09A:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $001A,y
	cmp.w $001A,x
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C0A4:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $0030,x
	cmp.w $0030,y
	bcc CODE_C5C054
	bra CODE_C5C047
DATA8_C5C0AE:						; the compare routines of the sort in CODE_C5C029 (one per sort key)
	dw CODE_C5C068,CODE_C5C068,CODE_C5C072,CODE_C5C07C
	dw CODE_C5C086,CODE_C5C090,CODE_C5C09A,CODE_C5C0A4
CODE_C5C0BE:						; called from other segments
	stz.b $22
	stz.b $24
	lda.w #$00C0
	sta.b $18
	lda.w #$0040
	sta.b $1A
	jsr.w CODE_C5A4B9
	jsr.w CODE_C5A4E2
	jsl.l $C4CEDB
	ldy.w #$2801
	ldx.w #$5194
	jsl.l $C387D8
	ldy.w #$2C01
	ldx.w #$5184
	jsl.l $C387D8
	lda.w $17C9
	jsl.l CreateSprite
	stx.b $9B
	lda.w #$0040
	sta.b $18
	lda.w $17CB
	jsl.l CreateSprite
	stx.b $9D
	inc.b $38,x
	jsr.w CODE_C5A46A
	jmp.w CODE_C5A3C1
CODE_C5C109:						; called from other segments
	jsl.l $C406DD
	jsl.l FadeOutWait
	jsr.w CODE_C5C1F6
	stz.w fadestep
CODE_C5C117:						; from CODE_C5C117, CODE_C5C162, CODE_C5C179, CODE_C5C174, ...
	inc.w TransfersReady
	wai
	jsl.l $C36C2D
	inc.b $26
	jsr.w CODE_C55BE8
	ldx.b $63
	lda.b $85
	asl a
	asl a
	asl a
	adc.w #$0076
	sta.b $08,x
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C5C117
	lda.w $058D
	bit.w #$1000
	beq CODE_C5C15A
	lda.b $67
	beq CODE_C5C15F
	jmp.w CODE_C5C58A
CODE_C5C15A:						; from CODE_C5C117
	bit.w #$0040
	beq CODE_C5C162
CODE_C5C15F:						; from CODE_C5C117
	jmp.w CODE_C58D32
CODE_C5C162:						; from CODE_C5C15A
	ldx.b $67
	beq CODE_C5C117
	bit.w #$0800
	beq CODE_C5C179
	lda.b $85
	beq CODE_C5C174
	dec a
	sta.b $85
	bra CODE_C5C117
CODE_C5C174:						; from CODE_C5C162
	jsr.w CODE_C55CE6
	bra CODE_C5C117
CODE_C5C179:						; from CODE_C5C162
	bit.w #$0400
	beq CODE_C5C196
	lda.b $85
	cmp.w #$0007
	bcs CODE_C5C190
	sec
	adc.b $69
	cmp.b $67
	beq CODE_C5C117
	inc.b $85
	bra CODE_C5C117
CODE_C5C190:						; from CODE_C5C179
	jsr.w CODE_C55C58
	jmp.w CODE_C5C117
CODE_C5C196:						; from CODE_C5C179
	bit.w #$8000
	beq CODE_C5C1F3
	lda.b $85
	clc
	adc.b $69
	tax
	lda.w $364E,x
	bit.w #$0040
	bne CODE_C5C1B1
	bit.w #$0080
	beq CODE_C5C1B1
	jmp.w CODE_C5C117
CODE_C5C1B1:						; from CODE_C5C196
	eor.w #$0040
	sta.w $364E,x
	bit.w #$0040
	beq CODE_C5C1D2
	and.w #$000F
	bne CODE_C5C1C5
	inc.b $7F
	bra CODE_C5C1E6
CODE_C5C1C5:						; from CODE_C5C1B1
	cmp.w #$0003
	bcs CODE_C5C1CE
	inc.b $83
	bra CODE_C5C1E6
CODE_C5C1CE:						; from CODE_C5C1C5
	inc.b $81
	bra CODE_C5C1E6
CODE_C5C1D2:						; from CODE_C5C1B1
	and.w #$000F
	bne CODE_C5C1DB
	dec.b $7F
	bra CODE_C5C1E6
CODE_C5C1DB:						; from CODE_C5C1D2
	cmp.w #$0003
	bcs CODE_C5C1E4
	dec.b $83
	bra CODE_C5C1E6
CODE_C5C1E4:						; from CODE_C5C1DB
	dec.b $81
CODE_C5C1E6:						; from CODE_C5C1B1, CODE_C5C1D2, CODE_C5C1C5, CODE_C5C1DB, ...
	jsr.w CODE_C5C4FC
	jsr.w CODE_C5D85D
	jsr.w CODE_C55C12
	jsl.l $C4C2AA
CODE_C5C1F3:						; from CODE_C5C196
	jmp.w CODE_C5C117
CODE_C5C1F6:						; from CODE_C5C109
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l CODE_C589E4
	ldy.w #$5C00
	jsl.l CODE_C589B0
	lda.w #$FFFF
	sta.w $04C6
	jsl.l $C4CEDB
CODE_C5C214:						; called from other segments
	ldy.w #$2C01
	ldx.w #$5115
	jsl.l $C387D8
	ldx.b $9B
	jsl.l CODE_C5E596
	stz.b $9B
	ldx.b $73
	jsl.l CODE_C5E596
	ldx.b $75
	jsl.l CODE_C5E596
	ldx.b $9D
	lda.w #$00D0
	sta.b $05,x
	lda.w #$0028
	sta.b $08,x
	ldx.b $63
	lda.w #$0003
	jsl.l CODE_C5ECBD
	jsl.l $C4C530
	jsl.l $C4BAF6
	lda.w #$53AB
	jsl.l $C4BB5A
	lda.w #$0010
	sta.b $CF
	lda.w #$008C
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4F6C
	jsl.l $C4BBE5
	lda.b $D1
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4CD7
	jsl.l $C4BBE5
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4CDE
	jsl.l $C4BBE5
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w $17CB
	asl a
	tax
	lda.l $C3585C,x
	tax
	ldy.w #$0009
	jsl.l $C4BCAA
	lda.w $1864
	pha
	lda.w #$0002
	sta.w $1864
	jsr.w CODE_C52CC1
	pla
	sta.w $1864
	ldx.w #$3207
	lda.w $0002,x
	sta.b $7F
	lda.w $0006,x
	sta.b $83
	lda.w $0004,x
	sta.b $81
	stz.b $67
	stz.b $69
	ldx.w #$0000
	txy
CODE_C5C2D6:						; from CODE_C5C2FC
	lda.l $306A56,x
	and.w #$001F
	cmp.w #$001A
	bne CODE_C5C2E4
	inc.b $67
CODE_C5C2E4:						; from CODE_C5C2D6
	iny
	cpy.w #$027E
	bcs CODE_C5C305
	lda.l $306A57,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$001F
	cmp.w #$001A
	bne CODE_C5C2FC
	inc.b $67
CODE_C5C2FC:						; from CODE_C5C2E4
	inx
	inx
	inx
	iny
	cpy.w #$027E
	bcc CODE_C5C2D6
CODE_C5C305:						; from CODE_C5C2E4
	ldx.b $67
	bne CODE_C5C32D
	lda.w #$2400
	sta.b $D5
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4CE3
	ldy.w #$000E
	jsl.l $C4BBE5
	ldx.b $63
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	bra CODE_C5C344
CODE_C5C32D:						; from CODE_C5C305, CODE_C5C32D
	dex
	stz.w $364E,x
	bne CODE_C5C32D
	jsr.w CODE_C5C4FC
	lda.w #CODE_C5C34C
	ldx.w #$0008
	ldy.w #$000E
	jsr.w CODE_C55ABC
	stz.b $85
CODE_C5C344:						; from CODE_C5C305
	jsr.w CODE_C5D85D
	jsl.l $C4C2AA
	rts
CODE_C5C34C:						; a callback: CODE_C5C32D passes it to a list routine in bankC5_5000
	ldx.b $6F
	stx.b $65
	lda.w $364E,x
	bit.w #$0040
	beq CODE_C5C35D
	ldy.w #$2400
	bra CODE_C5C365
CODE_C5C35D:						; from CODE_C5C34C
	bit.w #$0080
	beq CODE_C5C367
	ldy.w #$2C00
CODE_C5C365:						; from CODE_C5C34C
	sty.b $D5
CODE_C5C367:						; from CODE_C5C35D
	and.w #$000F
	asl a
	tax
	lda.l $C35E5B,x
	tax
	lda.w #$008C
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldy.b $6D
	jsl.l $C4BBE5
	jsr.w CODE_C5D794
	cmp.w #$026A
	bcs CODE_C5C3EB
	asl a
	adc.w #$0038
	tax
	lda.l $C30000,x
	and.w #$3FFF
	pha
	tax
	lda.w #$0010
	sta.b $CF
	lda.l $C30000,x
	and.w #$00FF
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w CODE_C55EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l $C4BC08
	lda.b $01,s
	clc
	adc.w #$0008
	tax
	lda.w #$0024
	sta.b $CF
	jsl.l $C4C3BA
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l $C4BC08
	plx
	ldy.w #$0000
CODE_C5C3D8:						; from CODE_C5C3D8
	lda.l $C30000,x
	sta.w $04F5,y
	inx
	inx
	iny
	iny
	cpy.w #$0008
	bne CODE_C5C3D8
	jmp.w CODE_C5C4C7
CODE_C5C3EB:						; from CODE_C5C367
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	ldx.w #$0000
	stx.b $A5
CODE_C5C3F6:						; from CODE_C5C410
	phx
	jsr.w CODE_C5D804
	plx
	cmp.w #$0000
	beq CODE_C5C420
	cmp.w #$001D
	bne CODE_C5C40A
	lda.w #$003D
	bra CODE_C5C410
CODE_C5C40A:						; from CODE_C5C3F6
	clc
	adc.w #$0040
	adc.b $A5
CODE_C5C410:						; from CODE_C5C3F6
	sta.w $04F5,x
	lda.w #$0020
	sta.b $A5
	inx
	cpx.w #$0008
	bne CODE_C5C3F6
	bra CODE_C5C42F
CODE_C5C420:						; from CODE_C5C3F6
	phx
CODE_C5C421:						; from CODE_C5C421
	cpx.w #$0007
	beq CODE_C5C42E
	phx
	jsr.w CODE_C5D804
	plx
	inx
	bra CODE_C5C421
CODE_C5C42E:						; from CODE_C5C421
	plx
CODE_C5C42F:						; from CODE_C5C410
	lda.w #$0020
	sta.w $04F5,x
	stz.b $A5
	inx
	phx
CODE_C5C439:						; from CODE_C5C453
	phx
	jsr.w CODE_C5D804
	plx
	cmp.w #$0000
	beq CODE_C5C467
	cmp.w #$001D
	bne CODE_C5C44D
	lda.w #$003D
	bra CODE_C5C453
CODE_C5C44D:						; from CODE_C5C439
	clc
	adc.w #$0040
	adc.b $A5
CODE_C5C453:						; from CODE_C5C439
	sta.w $04F5,x
	lda.w #$0020
	sta.b $A5
	inx
	txa
	sec
	sbc.b $01,s
	cmp.w #$000A
	bcc CODE_C5C439
	bra CODE_C5C478
CODE_C5C467:						; from CODE_C5C439, CODE_C5C467
	txa
	sec
	sbc.b $01,s
	cmp.w #$0009
	beq CODE_C5C478
	phx
	jsr.w CODE_C5D804
	plx
	inx
	bra CODE_C5C467
CODE_C5C478:						; from CODE_C5C467, CODE_C5C453
	plx
	sty.b $65
	lda.w #$0024
	sta.b $CF
	ldx.w #$04F5
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l $C4BC08
	ldy.b $65
	jsr.w CODE_C5D821
	sty.b $65
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.w #$0010
	sta.b $CF
	ldy.b $6D
	ldx.w #$04F5
	jsl.l $C4BC08
	ldy.b $65
	ldx.w #$0001
CODE_C5C4B5:						; from CODE_C5C4B5
	phx
	jsr.w CODE_C5D83F
	plx
	sep #$20
	sta.w $04F5,x
	rep #$20
	inx
	cpx.w #$0008
	bne CODE_C5C4B5
CODE_C5C4C7:						; from CODE_C5C3D8
	ldy.w #$0000
	ldx.b $6F
	lda.w $364E,x
	and.w #$000F
	bne CODE_C5C4D7
	ldy.w #$0010
CODE_C5C4D7:						; from CODE_C5C4C7
	sty.w $24DC
	jsr.w CODE_C5C6B7
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	lda.w #$00C8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$04F5
	ldy.b $6D
	jsl.l $C4BBF1
	lda.w #$2000
	sta.b $D5
	rts
CODE_C5C4FC:						; from CODE_C5C32D, CODE_C5C1E6
	ldx.w #$0000
CODE_C5C4FF:						; from CODE_C5C581
	stx.b $6F
	stx.b $65
	jsr.w CODE_C5D794
	cmp.w #$026A
	bcs CODE_C5C530
	stz.b $9F
	asl a
	tax
	lda.l $C30038,x
	bmi CODE_C5C527
	bit.w #$4000
	bne CODE_C5C51E
	ldx.b $6F
	bra CODE_C5C53F
CODE_C5C51E:						; from CODE_C5C4FF
	ldx.b $6F
	lda.w #$0001
	sta.b $9F
	bra CODE_C5C54D
CODE_C5C527:						; from CODE_C5C4FF
	lda.w #$0003
	sta.b $9F
	ldx.b $6F
	bra CODE_C5C556
CODE_C5C530:						; from CODE_C5C4FF
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	sta.b $9F
	ldx.b $6F
	cmp.w #$0000
	bne CODE_C5C548
CODE_C5C53F:						; from CODE_C5C4FF
	lda.b $7F
	cmp.w #$0003
	bcc CODE_C5C56A
	bra CODE_C5C55D
CODE_C5C548:						; from CODE_C5C530
	cmp.w #$0003
	bcs CODE_C5C556
CODE_C5C54D:						; from CODE_C5C51E
	lda.b $83
	cmp.w #$000F
	bcc CODE_C5C56A
	bra CODE_C5C55D
CODE_C5C556:						; from CODE_C5C527, CODE_C5C548
	lda.b $81
	cmp.w #$000F
	bcc CODE_C5C56A
CODE_C5C55D:						; from CODE_C5C53F, CODE_C5C54D, CODE_C5C56A
	lda.w #$0080
	ora.w $364E,x
	ora.b $9F
	sta.w $364E,x
	bra CODE_C5C581
CODE_C5C56A:						; from CODE_C5C53F, CODE_C5C54D, CODE_C5C556
	lda.b $7F
	clc
	adc.b $83
	adc.b $81
	cmp.w #$0019
	bcs CODE_C5C55D
	lda.w $364E,x
	and.w #$FF7F
	ora.b $9F
	sta.w $364E,x
CODE_C5C581:						; from CODE_C5C55D
	inx
	cpx.b $67
	beq CODE_C5C589
	jmp.w CODE_C5C4FF
CODE_C5C589:						; from CODE_C5C581
	rts
CODE_C5C58A:						; from CODE_C5C117
	lda.w $17CB
	asl a
	asl a
	asl a
	asl a
	sta.b $A1
	ldx.b $67
CODE_C5C595:						; from CODE_C5C59B, CODE_C5C616, CODE_C5C637
	dex
	bpl CODE_C5C59B
	jmp.w CODE_C58D32
CODE_C5C59B:						; from CODE_C5C595
	stx.b $67
	stx.b $65
	lda.w $364E,x
	bit.w #$0040
	beq CODE_C5C595
	jsr.w CODE_C5D794
	sta.b $9F
	lsr a
	bcc CODE_C5C5C5
	clc
	adc.b $9F
	tax
	lda.l $306A56,x
	and.w #$000F
	ora.w #$FE00
	ora.b $A1
	sta.l $306A56,x
	bra CODE_C5C5D9
CODE_C5C5C5:						; from CODE_C5C59B
	adc.b $9F
	tax
	lda.l $306A56,x
	and.w #$F000
	ora.w #$0FE0
	ora.w $17CB
	sta.l $306A56,x
CODE_C5C5D9:						; from CODE_C5C59B
	lda.b $9F
	cmp.w #$026A
	bcc CODE_C5C5EE
	jsr.w CODE_C5D7CD
	tya
	clc
	adc.w #$005D
	tay
	jsr.w CODE_C5D821
	bra CODE_C5C602
CODE_C5C5EE:						; from CODE_C5C5D9
	asl a
	adc.w #$0038
	tax
	lda.l $C30000,x
	and.w #$3FFF
	tax
	lda.l $C30000,x
	and.w #$00FF
CODE_C5C602:						; from CODE_C5C5D9, CODE_C5C602
	sta.b $A3
	jsr.w CODE_C5C658
	bcc CODE_C5C616
	lda.b $A3
	inc a
	cmp.w #$0064
	bcc CODE_C5C602
	lda.w #$0000
	bra CODE_C5C602
CODE_C5C616:						; from CODE_C5C602
	lda.b $9F
	lsr a
	bcc CODE_C5C637
	clc
	adc.b $9F
	tax
	lda.b $A3
	xba
	asl a
	sta.b $A3
	lda.l $306A56,x
	and.w #$01FF
	ora.b $A3
	sta.l $306A56,x
	ldx.b $67
	jmp.w CODE_C5C595
CODE_C5C637:						; from CODE_C5C616
	adc.b $9F
	tax
	lda.b $A3
	asl a
	asl a
	asl a
	asl a
	asl a
	sta.b $A3
	lda.l $306A56,x
	and.w #$F01F
	ora.b $A3
	sta.l $306A56,x
	ldx.b $67
	jmp.w CODE_C5C595
DATA8_C5C655:						; not traced: data between routines
	db $4C,$32,$8D
CODE_C5C658:						; from CODE_C5C602
	ldx.w #$0000
	txy
CODE_C5C65C:						; from CODE_C5C695
	lda.l $306A56,x
	and.w #$001F
	cmp.w $17CB
	bne CODE_C5C678
	lda.l $306A56,x
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$007F
	cmp.b $A3
	beq CODE_C5C6A0
CODE_C5C678:						; from CODE_C5C65C
	iny
	cpy.w #$027E
	bcs CODE_C5C69E
	lda.l $306A57,x
	and.w #$01F0
	cmp.b $A1
	bne CODE_C5C695
	lda.l $306A58,x
	lsr a
	and.w #$007F
	cmp.b $A3
	beq CODE_C5C6A0
CODE_C5C695:						; from CODE_C5C678
	inx
	inx
	inx
	iny
	cpy.w #$027E
	bcc CODE_C5C65C
CODE_C5C69E:						; from CODE_C5C678
	clc
	rts
CODE_C5C6A0:						; from CODE_C5C65C, CODE_C5C678
	sec
	rts
CODE_C5C6A2:						; called from other segments
	pei ($9F)
	pei ($A5)
	pei ($0A)
	phy
	jsr.w CODE_C5C6B7
	ply
	plx
	stx.b $0A
	plx
	stx.b $A5
	plx
	stx.b $9F
	rtl
CODE_C5C6B7:						; from CODE_C5C6A2, CODE_C5CCC2, CODE_C5C4D7, CODE_C5C9AC, ...
	ldx.w #$5DF9
	lda.l $7E24DC
	beq CODE_C5C6C3
	ldx.w #$F0C9
CODE_C5C6C3:						; from CODE_C5C6B7
	stx.b $9F
	stz.b $A5
	lda.w #$000F
CODE_C5C6CA:						; from CODE_C5C6FD
	sta.b $0A
	asl a
	tax
	lda.l BitMaskTable2,x
	bit.b $9F
	beq CODE_C5C6FD
	lda.b $0A
	lsr a
	tax
	lda.w $04F5,x
	bcs CODE_C5C6E3
	lsr a
	lsr a
	lsr a
	lsr a
CODE_C5C6E3:						; from CODE_C5C6CA
	and.w #$000F
	tay
	lda.b $0A
	clc
	adc.l $7E24DC
	tax
	lda.l $C57309,x
	tyx
	jsl.l Mul8U
	clc
	adc.b $A5
	sta.b $A5
CODE_C5C6FD:						; from CODE_C5C6CA
	lda.b $0A
	dec a
	bne CODE_C5C6CA
	lda.b $A5
	bpl CODE_C5C709
	lda.w #$0000
CODE_C5C709:						; from CODE_C5C6FD
	ldx.w $24DC
	beq CODE_C5C70F
	lsr a
CODE_C5C70F:						; from CODE_C5C709
	cmp.w #$0065
	bcc CODE_C5C717
	lda.w #$0064
CODE_C5C717:						; from CODE_C5C70F
	cmp.w #$0032
	bcs CODE_C5C721
	lsr a
	clc
	adc.w #$0019
CODE_C5C721:						; from CODE_C5C717
	rts
CODE_C5C722:						; called from other segments
	jsl.l $C406DD
	jsl.l FadeOutWait
	jsr.w CODE_C5C826
	stz.w fadestep
CODE_C5C730:						; from CODE_C5C730, CODE_C5C777, CODE_C5C78A, CODE_C5C785, ...
	inc.w TransfersReady
	wai
	jsl.l $C36C2D
	inc.b $26
	jsr.w CODE_C55BE8
	ldx.b $63
	lda.b $85
	asl a
	asl a
	asl a
	adc.w #$0076
	sta.b $08,x
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C5C730
	lda.w $058D
	bit.w #$1000
	beq CODE_C5C76F
	jmp.w CODE_C5CA27
CODE_C5C76F:						; from CODE_C5C730
	bit.w #$0040
	beq CODE_C5C777
	jmp.w CODE_C58D32
CODE_C5C777:						; from CODE_C5C76F
	bit.w #$0800
	beq CODE_C5C78A
	lda.b $85
	beq CODE_C5C785
	dec a
	sta.b $85
	bra CODE_C5C730
CODE_C5C785:						; from CODE_C5C777
	jsr.w CODE_C55CE6
	bra CODE_C5C730
CODE_C5C78A:						; from CODE_C5C777
	bit.w #$0400
	beq CODE_C5C7A7
	lda.b $85
	cmp.w #$0007
	bcs CODE_C5C7A1
	sec
	adc.b $69
	cmp.b $67
	beq CODE_C5C730
	inc.b $85
	bra CODE_C5C730
CODE_C5C7A1:						; from CODE_C5C78A
	jsr.w CODE_C55C58
	jmp.w CODE_C5C730
CODE_C5C7A7:						; from CODE_C5C78A
	bit.w #$8000
	beq CODE_C5C730
	ldy.w #$3207
	lda.b $69
	clc
	adc.b $85
	tax
	lda.w $364E,x
	bit.w #$0001
	beq CODE_C5C7CB
	txa
	sec
	sbc.w $0002,y
	bmi CODE_C5C7D9
	sbc.w $0004,y
	bmi CODE_C5C7EC
	bra CODE_C5C7FA
CODE_C5C7CB:						; from CODE_C5C7A7
	txa
	sec
	sbc.w $0002,y
	bpl CODE_C5C7E0
	lda.b $7F
	cmp.w #$0003
	bcc CODE_C5C823
CODE_C5C7D9:						; from CODE_C5C7A7
	lda.w #$007F
	sta.b $9F
	bra CODE_C5C7FF
CODE_C5C7E0:						; from CODE_C5C7CB
	sbc.w $0004,y
	bpl CODE_C5C7F3
	lda.b $81
	cmp.w #$000A
	bcc CODE_C5C823
CODE_C5C7EC:						; from CODE_C5C7A7
	lda.w #$0081
	sta.b $9F
	bra CODE_C5C7FF
CODE_C5C7F3:						; from CODE_C5C7E0
	lda.b $83
	cmp.w #$0007
	bcc CODE_C5C823
CODE_C5C7FA:						; from CODE_C5C7A7
	lda.w #$0083
	sta.b $9F
CODE_C5C7FF:						; from CODE_C5C7D9, CODE_C5C7EC
	lda.w $364E,x
	eor.w #$0001
	sta.w $364E,x
	bit.w #$0001
	beq CODE_C5C814
	lda.b ($9F)
	dec a
	sta.b ($9F)
	bra CODE_C5C819
CODE_C5C814:						; from CODE_C5C7FF
	lda.b ($9F)
	inc a
	sta.b ($9F)
CODE_C5C819:						; from CODE_C5C7FF
	jsr.w CODE_C5D85D
	jsr.w CODE_C55C12
	jsl.l $C4C2AA
CODE_C5C823:						; from CODE_C5C7CB, CODE_C5C7E0, CODE_C5C7F3
	jmp.w CODE_C5C730
CODE_C5C826:						; from CODE_C5C722
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l CODE_C589E4
	ldy.w #$5C00
	jsl.l CODE_C589B0
	lda.w #$FFFF
	sta.w $04C6
	jsl.l $C4CEDB
	ldy.w #$2C01
	ldx.w #$5115
	jsl.l $C387D8
	ldx.b $9B
	jsl.l CODE_C5E596
	ldx.b $73
	jsl.l CODE_C5E596
	ldx.b $75
	jsl.l CODE_C5E596
	ldx.b $9D
	lda.w #$00D0
	sta.b $05,x
	lda.w #$0028
	sta.b $08,x
	ldx.b $63
	lda.w #$0003
	jsl.l CODE_C5ECBD
	jsl.l $C4C530
	jsl.l $C4BAF6
	lda.w #$53D5
	jsl.l $C4BB5A
	lda.w #$0010
	sta.b $CF
	lda.w #$008C
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4F6C
	jsl.l $C4BBE5
	lda.b $D1
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4CD7
	jsl.l $C4BBE5
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4CDE
	jsl.l $C4BBE5
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w $17CB
	asl a
	tax
	lda.l $C3585C,x
	tax
	ldy.w #$0009
	jsl.l $C4BCAA
	lda.w $1864
	pha
	lda.w #$0002
	sta.w $1864
	jsr.w CODE_C52CC1
	pla
	sta.w $1864
	ldx.w #$3207
	lda.w $0002,x
	sta.b $7F
	lda.w $0006,x
	sta.b $83
	lda.w $0004,x
	sta.b $81
	clc
	adc.b $83
	adc.b $7F
	sta.b $67
	stz.b $69
	stz.b $85
	ldx.w #$0000
CODE_C5C90A:						; from CODE_C5C90A
	stz.w $364E,x
	inx
	cpx.b $67
	bne CODE_C5C90A
	lda.w #CODE_C5C926
	ldx.w #$0008
	ldy.w #$000E
	jsr.w CODE_C55ABC
	jsr.w CODE_C5D85D
	jsl.l $C4C2AA
	rts
CODE_C5C926:						; a callback: CODE_C5C90A passes it to a list routine in bankC5_5000
	lda.w #$0010
	sta.l $7E24DC
	ldy.w #$3207
	ldx.w #$49B8
	lda.b $6F
	sec
	sbc.w $0002,y
	bpl CODE_C5C944
	lda.b $7F
	cmp.w #$0003
	bne CODE_C5C956
	bra CODE_C5C967
CODE_C5C944:						; from CODE_C5C926
	stz.w $24DC
	ldx.w #$4CF6
	sbc.w $0004,y
	bpl CODE_C5C95D
	lda.b $81
	cmp.w #$000A
	bcs CODE_C5C967
CODE_C5C956:						; from CODE_C5C926, CODE_C5C95D
	lda.w #$2C00
	sta.b $D5
	bra CODE_C5C967
CODE_C5C95D:						; from CODE_C5C944
	ldx.w #$4CF0
	lda.b $83
	cmp.w #$0007
	bcc CODE_C5C956
CODE_C5C967:						; from CODE_C5C926, CODE_C5C944, CODE_C5C956
	ldy.b $6F
	lda.w $364E,y
	bit.w #$0001
	beq CODE_C5C976
	lda.w #$2400
	sta.b $D5
CODE_C5C976:						; from CODE_C5C967
	lda.w #$008C
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldy.b $6D
	jsl.l $C4BBE5
	lda.b $6F
	asl a
	adc.w #$3207
	tax
	lda.w $003A,x
	sta.b $9F
	lsr a
	bcc CODE_C5C9A0
	clc
	adc.b $9F
	tax
	lda.l $306A57,x
	lsr a
	bra CODE_C5C9AC
CODE_C5C9A0:						; from CODE_C5C976
	adc.b $9F
	tax
	lda.l $306A56,x
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
CODE_C5C9AC:						; from CODE_C5C976
	and.w #$007F
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.w #$0010
	sta.b $CF
	ldx.w #$04F5
	ldy.b $6D
	jsl.l $C4BC08
	lda.w #$0024
	sta.b $CF
	lda.b $6F
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.w #$331F
	tax
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l $C4BC08
	lda.b $6F
	asl a
	asl a
	asl a
	asl a
	asl a
	tax
	lda.w $3317,x
	sta.w $04F5
	lda.w $3319,x
	sta.w $04F7
	lda.w $331B,x
	sta.w $04F9
	lda.w $331D,x
	sta.w $04FB
	jsr.w CODE_C5C6B7
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	lda.w #$00C8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$04F5
	ldy.b $6D
	jsl.l $C4BBF1
	lda.w #$2000
	sta.b $D5
	rts
CODE_C5CA27:						; from CODE_C5C730
	ldy.w #$FFFF
CODE_C5CA2A:						; from CODE_C5CA32, CODE_C5CA59
	iny
	cpy.b $67
	bne CODE_C5CA32
	jmp.w CODE_C58D32
CODE_C5CA32:						; from CODE_C5CA2A
	lda.w $364E,y
	bit.w #$0001
	beq CODE_C5CA2A
	tya
	asl a
	tax
	lda.w $3241,x
	sta.b $9F
	lsr a
	bcc CODE_C5CA59
	clc
	adc.b $9F
	tax
	lda.l $306A56,x
	and.w #$FE0F
	ora.w #$01A0
	sta.l $306A56,x
	bra CODE_C5CA2A
CODE_C5CA59:						; from CODE_C5CA32
	adc.b $9F
	tax
	lda.l $306A56,x
	and.w #$FFE0
	ora.w #$001A
	sta.l $306A56,x
	bra CODE_C5CA2A
CODE_C5CA6C:						; from CODE_C5CD7F and other segments
	jsl.l $C406DD
	jsl.l FadeOutWait
	jsr.w CODE_C5CB36
	stz.w fadestep
CODE_C5CA7A:						; from CODE_C5CA9A, CODE_C5CACA, CODE_C5CADD, CODE_C5CAD8, ...
	inc.w TransfersReady
	wai
	jsl.l $C36C2D
	inc.b $26
	jsr.w CODE_C5DA09
	ldx.b $63
	lda.b $85
	asl a
	asl a
	asl a
	ldy.b $6B
	bne CODE_C5CA97
	adc.w #$0046
	bra CODE_C5CA9A
CODE_C5CA97:						; from CODE_C5CA7A
	adc.w #$008E
CODE_C5CA9A:						; from CODE_C5CA7A
	sta.b $08,x
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C5CA7A
	lda.w $058D
	bit.w #$1000
	beq CODE_C5CAC2
	jmp.w CODE_C5CD41
CODE_C5CAC2:						; from CODE_C5CA9A
	bit.w #$0040
	beq CODE_C5CACA
	jmp.w CODE_C58D32
CODE_C5CACA:						; from CODE_C5CAC2
	bit.w #$0800
	beq CODE_C5CADD
	lda.b $85
	beq CODE_C5CAD8
	dec a
	sta.b $85
	bra CODE_C5CA7A
CODE_C5CAD8:						; from CODE_C5CACA
	jsr.w CODE_C5DAF3
	bra CODE_C5CA7A
CODE_C5CADD:						; from CODE_C5CACA
	bit.w #$0400
	beq CODE_C5CAFC
	lda.b $85
	cmp.w #$0004
	bcs CODE_C5CAF6
	ldx.b $6B
	sec
	adc.b $77,x
	cmp.b $7B,x
	beq CODE_C5CA7A
	inc.b $85
	bra CODE_C5CA7A
CODE_C5CAF6:						; from CODE_C5CADD
	jsr.w CODE_C5DB9F
	jmp.w CODE_C5CA7A
CODE_C5CAFC:						; from CODE_C5CADD
	bit.w #$4000
	beq CODE_C5CB0B
	lda.b $6B
	eor.w #$0002
	sta.b $6B
	jmp.w CODE_C5CA7A
CODE_C5CB0B:						; from CODE_C5CAFC
	bit.w #$8000
	beq CODE_C5CB33
	stz.b $9F
	ldx.b $6B
	beq CODE_C5CB1B
	lda.w #$0064
	sta.b $9F
CODE_C5CB1B:						; from CODE_C5CB0B
	lda.b $85
	clc
	adc.b $77,x
	adc.b $9F
	tax
	lda.w $364E,x
	eor.w #$0001
	sta.w $364E,x
	jsr.w CODE_C5DA58
	jsl.l $C4C2AA
CODE_C5CB33:						; from CODE_C5CB0B
	jmp.w CODE_C5CA7A
CODE_C5CB36:						; from CODE_C5CA6C
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l CODE_C589E4
	lda.w #$FFFF
	sta.w $04C6
	jsl.l $C4CEDB
	ldx.b $9B
	jsl.l CODE_C5E596
	ldx.b $9D
	jsl.l CODE_C5E596
	ldx.b $73
	jsl.l CODE_C5E596
	ldx.b $75
	jsl.l CODE_C5E596
	ldx.b $63
	lda.w #$0003
	jsl.l CODE_C5ECBD
	jsl.l $C4C530
	jsl.l $C4BAF6
	lda.w #$56F2
	jsl.l $C4BB5A
	jsl.l $C4CEDB
	ldy.w #$2801
	ldx.w #$5084
	jsl.l $C387D8
	ldy.w #$2C01
	ldx.w #$51A4
	jsl.l $C387D8
	ldy.w #$0005
	lda.w $17C9
	jsr.w CODE_C5A4A5
	ldy.w #$000E
	lda.w $17CB
	jsr.w CODE_C5A4A5
	lda.w #$008C
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldx.w #$4CD7
	ldy.w #$0006
	jsl.l $C4BBE5
	ldx.w #$4CD7
	ldy.w #$000F
	jsl.l $C4BBE5
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4CDE
	ldy.w #$0006
	jsl.l $C4BBE5
	ldx.w #$4CDE
	ldy.w #$000F
	jsl.l $C4BBE5
	lda.w $1864
	pha
	lda.w #$0002
	sta.w $1864
	jsr.w CODE_C52CC1
	pla
	sta.w $1864
	lda.w $2DCB
	clc
	adc.w $2DCD
	adc.w $2DCF
	sta.b $7B
	lda.w $3209
	clc
	adc.w $320B
	adc.w $320D
	sta.b $7D
	ldx.w #$0000
CODE_C5CC0E:						; from CODE_C5CC0E
	stz.w $364E,x
	inx
	cpx.b $7B
	bne CODE_C5CC0E
	ldx.w #$0000
CODE_C5CC19:						; from CODE_C5CC19
	stz.w $36B2,x
	inx
	cpx.b $7D
	bne CODE_C5CC19
	lda.w #$0005
	sta.b $67
	sta.b $69
	lda.w #$0008
	sta.b $6F
	lda.w #$0011
	sta.b $71
	lda.w #$2DC9
	sta.b $73
	lda.w #$3207
	sta.b $75
	lda.w #CODE_C5CC4D
	jsr.w CODE_C5D8E7
	jsl.l $C4C2AA
	jsl.l $C4CEDB
	stz.b $85
	rts
CODE_C5CC4D:						; a callback: CODE_C5CC19 passes it to a routine in bankC5_D000
	ldy.b $87
	lda.w #$0010
	sta.l $7E24DC
	ldx.w #$49B8
	lda.b $91
	sec
	sbc.w $0002,y
	bmi CODE_C5CC6F
	stz.w $24DC
	ldx.w #$4CF6
	sbc.w $0004,y
	bmi CODE_C5CC6F
	ldx.w #$4CF0
CODE_C5CC6F:						; from CODE_C5CC4D
	lda.w #$0000
	ldy.b $87
	cpy.w #$2DC9
	beq CODE_C5CC7C
	lda.w #$0064
CODE_C5CC7C:						; from CODE_C5CC6F
	clc
	adc.b $91
	tay
	lda.w $364E,y
	bit.w #$0001
	beq CODE_C5CC8D
	lda.w #$2400
	sta.b $D5
CODE_C5CC8D:						; from CODE_C5CC7C
	lda.w #$008C
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldy.b $6D
	jsl.l $C4BBE5
	lda.b $91
	asl a
	adc.b $87
	tax
	lda.w $003A,x
	sta.b $9F
	lsr a
	bcc CODE_C5CCB6
	clc
	adc.b $9F
	tax
	lda.l $306A57,x
	lsr a
	bra CODE_C5CCC2
CODE_C5CCB6:						; from CODE_C5CC8D
	adc.b $9F
	tax
	lda.l $306A56,x
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
CODE_C5CCC2:						; from CODE_C5CC8D
	and.w #$007F
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.w #$0010
	sta.b $CF
	ldx.w #$04F5
	ldy.b $6D
	jsl.l $C4BC08
	lda.w #$0024
	sta.b $CF
	lda.b $91
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $87
	adc.w #$0118
	tax
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l $C4BC08
	lda.b $91
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $87
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
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	lda.w #$00C8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$04F5
	ldy.b $6D
	jsl.l $C4BBF1
	lda.w #$2000
	sta.b $D5
	rts
CODE_C5CD41:						; from CODE_C5CA9A
	jsr.w CODE_C5CD90
	stz.w fadestep
CODE_C5CD47:						; from CODE_C5CD47, CODE_C5CD8E
	inc.w TransfersReady
	wai
	jsl.l $C36C2D
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C5CD47
	lda.w $058D
	bit.w #$1000
	beq CODE_C5CD7F
	jsr.w CODE_C5CF11
	bcs CODE_C5CD7C
	jsr.w CODE_C5D08C
CODE_C5CD7C:						; from CODE_C5CD47
	jmp.w CODE_C58D32
CODE_C5CD7F:						; from CODE_C5CD47
	bit.w #$0040
	beq CODE_C5CD8E
	ldx.b $63
	lda.w #$0008
	sta.b $05,x
	jmp.w CODE_C5CA6C
CODE_C5CD8E:						; from CODE_C5CD7F
	bra CODE_C5CD47
CODE_C5CD90:						; from CODE_C5CD41
	jsr.w CODE_C5CF11
	phx
	php
	lda.b $77
	ora.b $79
	bne CODE_C5CDA1
	plp
	pla
	pla
	jmp.w CODE_C58D32
CODE_C5CDA1:						; from CODE_C5CD90
	jsl.l FadeOutWait
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l CODE_C589E4
	jsl.l $C4CEDB
	ldx.b $63
	lda.w #$012C
	sta.b $05,x
	ldx.b $8B
	jsl.l CODE_C5E596
	stz.b $8B
	ldx.b $8D
	jsl.l CODE_C5E596
	stz.b $8D
	jsl.l $C4C530
	jsl.l $C4BAF6
	lda.w #$53FF
	jsl.l $C4BB5A
	jsl.l $C4CEDB
	ldy.w #$2801
	ldx.w #$5084
	jsl.l $C387D8
	ldy.w #$2C01
	ldx.w #$5094
	jsl.l $C387D8
	ldy.w #$0005
	lda.w $17C9
	jsr.w CODE_C5A4A5
	lda.w #$00A0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	lda.w $17CB
	asl a
	tax
	lda.l $C3585C,x
	tax
	ldy.w #$0005
	jsl.l $C4BCAA
	lda.w #$0010
	sta.b $CF
	lda.w #$2DC9
	sta.b $87
	ldy.w #$0008
	ldx.b $7B
	lda.w #$364E
	jsr.w CODE_C5CEA0
	lda.w #$0090
	sta.b $CF
	lda.w #$3207
	sta.b $87
	ldy.w #$0008
	ldx.b $7D
	lda.w #$36B2
	jsr.w CODE_C5CEA0
	lda.w #$0010
	sta.b $CF
	ldy.w #$0012
	plp
	bcs CODE_C5CE5C
	plx
	lda.w #$2400
	sta.b $D5
	ldx.w #$4D53
	jsl.l $C4BC26
	bra CODE_C5CE96
CODE_C5CE5C:						; from CODE_C5CDA1
	lda.w #$2800
	sta.b $D5
	ldx.w #$4D5A
	jsl.l $C4BC26
	lda.w #$2000
	sta.b $D5
	lda.b $01,s
	cmp.b $40
	beq CODE_C5CE78
	ldx.w #$4B7F
	bra CODE_C5CE7B
CODE_C5CE78:						; from CODE_C5CE5C
	ldx.w #$4D61
CODE_C5CE7B:						; from CODE_C5CE5C
	ldy.w #$0014
	jsl.l $C4BBFC
	lda.w #$0061
	sta.b $CF
	pla
	asl a
	tax
	lda.l $C3585C,x
	tax
	ldy.w #$0014
	jsl.l $C4BBFC
CODE_C5CE96:						; from CODE_C5CDA1
	lda.w #$2000
	sta.b $D5
	jsl.l $C4C2AA
	rts
CODE_C5CEA0:						; from CODE_C5CDA1
	sty.b $6D
	stx.b $9F
	sta.b $A1
	ldx.w #$0000
	txy
CODE_C5CEAA:						; from CODE_C5CEB2
	lda.b ($A1),y
	bit.w #$0001
	beq CODE_C5CEB2
	inx
CODE_C5CEB2:						; from CODE_C5CEAA
	iny
	cpy.b $9F
	bne CODE_C5CEAA
	cpx.w #$0000
	bne CODE_C5CEC6
	ldx.w #$4D3F
	ldy.b $6D
	jsl.l $C4BBFC
	rts
CODE_C5CEC6:						; from CODE_C5CEB2
	stx.b $9F
	stz.b $A3
	ldy.w #$0000
CODE_C5CECD:						; from CODE_C5CECD, CODE_C5CEFD
	lda.b ($A1),y
	iny
	bit.w #$0001
	beq CODE_C5CECD
	phy
	dey
	tya
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $87
	adc.w #$0118
	tax
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l $C4BC08
	inc.b $6D
	ply
	lda.b $A3
	inc a
	sta.b $A3
	cmp.b $9F
	bne CODE_C5CEFD
	rts
CODE_C5CEFD:						; from CODE_C5CECD
	cmp.w #$0008
	bne CODE_C5CECD
	inc a
	cmp.b $9F
	beq CODE_C5CECD
	ldx.w #$4D4A
	ldy.b $6D
	jsl.l $C4BBFC
	rts
CODE_C5CF11:						; from CODE_C5CD47, CODE_C5CD90
	lda.w #$0077
	sta.b $A1
	stz.b $77
	lda.b $7B
	sta.b $A3
	lda.w #$364E
	sta.b $87
	lda.w #$2DC9
	sta.b $73
	jsr.w CODE_C5D00D
	lda.b $7F
	sta.b $93
	lda.b $81
	sta.b $95
	lda.b $83
	sta.b $97
	lda.w #$0079
	sta.b $A1
	stz.b $79
	lda.b $7D
	sta.b $A3
	lda.w #$36B2
	sta.b $87
	lda.w #$3207
	sta.b $73
	jsr.w CODE_C5D00D
	ldx.w $17CB
	lda.b $77
	sec
	sbc.b $79
	tay
	bpl CODE_C5CF5C
	eor.w #$FFFF
	inc a
CODE_C5CF5C:						; from CODE_C5CF11
	cmp.w #$0005
	bcc CODE_C5CF6B
	tya
	bpl CODE_C5CF67
	ldx.w $17C9
CODE_C5CF67:						; from CODE_C5CF5C
	stx.b $40
	sec
	rts
CODE_C5CF6B:						; from CODE_C5CF5C
	lda.w $2DCB
	sec
	sbc.b $93
	clc
	adc.b $7F
	cmp.w #$0002
	bcs CODE_C5CF7C
	jmp.w CODE_C5CFFE
CODE_C5CF7C:						; from CODE_C5CF6B
	cmp.w #$0004
	bcs CODE_C5CFFE
	sta.b $40
	lda.w $2DCD
	sec
	sbc.b $95
	clc
	adc.b $81
	cmp.w #$0009
	bcc CODE_C5CFFE
	cmp.w #$0010
	bcs CODE_C5CFFE
	adc.b $40
	sta.b $40
	lda.w $2DCF
	sec
	sbc.b $97
	clc
	adc.b $83
	cmp.w #$0006
	bcc CODE_C5CFFE
	cmp.w #$0010
	bcs CODE_C5CFFE
	adc.b $40
	cmp.w #$001A
	bcs CODE_C5CFFE
	lda.w $3209
	sec
	sbc.b $7F
	clc
	adc.b $93
	cmp.w #$0002
	bcc CODE_C5D003
	cmp.w #$0004
	bcs CODE_C5D003
	sta.b $40
	lda.w $320B
	sec
	sbc.b $81
	clc
	adc.b $95
	cmp.w #$0009
	bcc CODE_C5D003
	cmp.w #$0010
	bcs CODE_C5D003
	adc.b $40
	sta.b $40
	lda.w $320D
	sec
	sbc.b $83
	clc
	adc.b $97
	cmp.w #$0006
	bcc CODE_C5D003
	cmp.w #$0010
	bcs CODE_C5D003
	adc.b $40
	cmp.w #$001A
	bcs CODE_C5D003
	stx.b $40
	clc
	rts
CODE_C5CFFE:						; from CODE_C5CF6B, CODE_C5CF7C
	ldx.w $17C9
	bra CODE_C5D006
CODE_C5D003:						; from CODE_C5CF7C
	ldx.w $17CB
CODE_C5D006:						; from CODE_C5CFFE
	lda.w #$4B7F
	sta.b $40
	sec
	rts

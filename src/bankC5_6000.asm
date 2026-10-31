; Segment bankC5_6000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C56005
CODE_C56005:						; called from other segments
	jsr.w CODE_C56009
	rtl
CODE_C56009:						; from CODE_C56005, CODE_C56F98, CODE_C56FC1
	phy
	phx
	ldy.w #$0000
	sep #$20
CODE_C56010:						; from CODE_C56010
	lda.w $0000,x
	beq CODE_C56019
	iny
	inx
	bra CODE_C56010
CODE_C56019:						; from CODE_C56010
	rep #$20
	lda.b $03,s
	tax
	sep #$20
CODE_C56020:						; from CODE_C56020
	lda.w $0000,x
	beq CODE_C56029
	iny
	inx
	bra CODE_C56020
CODE_C56029:						; from CODE_C56020
	rep #$20
	tya
	inc a
	jsl.l $C4C558
	pha
	tay
	lda.b $03,s
	tax
	sep #$20
CODE_C56038:						; from CODE_C56038
	lda.w $0000,x
	beq CODE_C56044
	sta.w $0000,y
	inx
	iny
	bra CODE_C56038
CODE_C56044:						; from CODE_C56038
	rep #$20
	lda.b $05,s
	tax
	sep #$20
CODE_C5604B:						; from CODE_C5604B
	lda.w $0000,x
	sta.w $0000,y
	beq CODE_C56057
	inx
	iny
	bra CODE_C5604B
CODE_C56057:						; from CODE_C5604B
	rep #$20
	plx
	pla
	pla
	rts
CODE_C5605D:						; from CODE_C56ABB, CODE_C56DA1, CODE_C5711B and other segments
	ldx.w #$0000
	phy
	txy
	sta.b $34
	lda.w #$003C
	sta.b $30
	jsl.l Div16x8U
	tax
	lda.l BCDTable,x
	and.w #$00FF
	tyx
	jsr.w CODE_C55ECA
	lda.w #$003F
	sta.w $04F5,x
	inx
	txy
	lda.l RDMPYL
	tax
	lda.l BCDTable,x
	tyx
	pha
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w $04F5,x
	inx
	pla
	and.w #$000F
	clc
	adc.w #$0030
	sta.w $04F5,x
	inx
	ply
	rts
CODE_C560A8:						; called from other segments
	jsr.w CODE_C5611C
	rtl
CODE_C560AC:						; called from other segments
	phy
	txy
	sta.b $34
	lda.w #$003C
	sta.b $30
	jsl.l Div16x8U
	tax
	lda.l BCDTable,x
	and.w #$00FF
	pha
	lsr a
	lsr a
	lsr a
	lsr a
	tyx
	jsr.w CODE_C55ECA
	pla
	and.w #$000F
	jsr.w CODE_C55ECA
	lda.w #$003F
	sta.w $04F5,x
	inx
	txy
	lda.l RDMPYL
	tax
	lda.l BCDTable,x
	tyx
	pha
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w $04F5,x
	inx
	pla
	and.w #$000F
	clc
	adc.w #$0030
	sta.w $04F5,x
	inx
	ply
	rts
CODE_C56100:						; called from other segments
	jsr.w CODE_C56104
	rtl
CODE_C56104:						; from CODE_C56100, CODE_C56B19, CODE_C56DA1 and other segments
	ldx.w $17C9
	cmp.w #$0000
	beq CODE_C5610F
	ldx.w $17CB
CODE_C5610F:						; from CODE_C56104
	txa
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
CODE_C5611C:						; from CODE_C560A8 and other segments
	ldy.w #$0000
CODE_C5611F:						; from CODE_C5611F, CODE_C5612C
	jsr.w CODE_C56140
	cmp.w #$001D
	bcc CODE_C5612C
	jsr.w CODE_C56138
	bra CODE_C5611F
CODE_C5612C:						; from CODE_C5611F
	cmp.w #$001A
	bne CODE_C5611F
	cpy.w #$0000
	beq CODE_C56137
	inx
CODE_C56137:						; from CODE_C5612C
	rts
CODE_C56138:						; from CODE_C5611F
	pha
	tya
	clc
	adc.w #$0003
	bra CODE_C5614C
CODE_C56140:						; from CODE_C5611F
	jsr.w CODE_C56158
	and.w #$001F
	pha
	tya
	clc
	adc.w #$0005
CODE_C5614C:						; from CODE_C56138
	cmp.w #$0008
	bcc CODE_C56155
	inx
	sbc.w #$0008
CODE_C56155:						; from CODE_C5614C
	tay
	pla
	rts
CODE_C56158:						; from CODE_C56140
	lda.l $C30000,x
	cpy.w #$0000
	beq CODE_C56167
	phy
CODE_C56162:						; from CODE_C56162
	lsr a
	dey
	bne CODE_C56162
	ply
CODE_C56167:						; from CODE_C56158
	rts
CODE_C56168:						; called from other segments
	asl a
	tax
	lda.l $C35F60,x
	tay
	and.w #$001F
	tax
	lda.l BCDTable,x
	jsr.w CODE_C5A321
	lda.w $04F7
	pha
	tya
	and.w #$00E0
	asl a
	asl a
	asl a
	xba
	sta.b $9F
	asl a
	adc.b $9F
	tax
	lda.l DATA8_C561DB,x
	sta.w $04F5
	lda.l DATA8_C561DB+2,x
	sta.w $04F7
	lda.w #$403D
	sta.w $04F8
	lda.w #$0020
	sta.w $04FA
	tya
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C561F0,x
	tax
	ldy.w #$FFFF
	sep #$20
CODE_C561B7:						; from CODE_C561B7
	iny
	inx
	lda.l $C4FFFF,x
	sta.w $04FB,y
	bne CODE_C561B7
	lda.b #$20
	sta.w $04FB,y
	pla
	cmp.b #$30
	beq CODE_C561D0
	sta.w $04FC,y
	iny
CODE_C561D0:						; from CODE_C561B7
	pla
	sta.w $04FC,y
	tyx
	stz.w $04FD,x
	rep #$20
	rts
DATA8_C561DB:						; the day names, 3 letters each, read by CODE_C56168
	db "MonTueWedThrFriSatSun"
DATA8_C561F0:						; a word per month: its name (bank $C5), read by CODE_C56168
	dw MonthJanuary,MonthFebruary,MonthMarch,MonthApril
	dw MonthMay,MonthJune,MonthJuly,MonthAugust
	dw MonthSeptember,MonthOctober,MonthNovember,MonthDecember
MonthJanuary:						; January
	db "January",0
MonthFebruary:						; February
	db "February",0
MonthMarch:							; March
	db "March",0
MonthApril:							; April
	db "April",0
MonthMay:							; May
	db "May",0
MonthJune:							; June
	db "June",0
MonthJuly:							; July
	db "July",0
MonthAugust:						; August
	db "August",0
MonthSeptember:						; September
	db "September",0
MonthOctober:						; October
	db "October",0
MonthNovember:						; November
	db "November",0
MonthDecember:						; December
	db "December",0
CODE_C5625E:						; called from other segments
	jsr.w CODE_C56262
	rtl
CODE_C56262:						; from CODE_C5625E and other segments
	phx
	sep #$20
CODE_C56265:						; from CODE_C56274
	lda.w $0000,x
	beq CODE_C5627A
	cmp.b #$3D
	bne CODE_C56272
	lda.b #$AE
	bra CODE_C56274
CODE_C56272:						; from CODE_C56265
	eor.b #$80
CODE_C56274:						; from CODE_C56265
	sta.w $0000,x
	inx
	bra CODE_C56265
CODE_C5627A:						; from CODE_C56265
	rep #$20
	txa
	sec
	sbc.b $01,s
	beq CODE_C5628A
	pha
	dec a
	txy
	dex
	mvp $7E,$7E
	pla
CODE_C5628A:						; from CODE_C5627A
	sep #$20
	plx
	sta.w $0000,x
	rep #$20
	rts
CODE_C56293:						; called from other segments
	lda.w #$531F
	jsr.w CODE_C55A40
	ldx.w #$5D5F
	lda.w $186C
	bne CODE_C562A4
	ldx.w #$5DD7
CODE_C562A4:						; from CODE_C56293
	lda.l $C30000,x
	and.w #$00FF
	sta.b $67
	inx
	stx.b $63
	ldx.w #$0009
	ldy.w #$000F
	lda.w #CODE_C56310
	jsr.w CODE_C55ABC
	jsl.l $C4C2AA
	stz.w fadestep
CODE_C562C3:						; from CODE_C562C6, CODE_C56301, CODE_C5630B
	inc.w TransfersReady
CODE_C562C6:						; from CODE_C562C6
	lda.w TransfersReady
	bne CODE_C562C6
	jsl.l $C36C2D
	inc.b $26
	jsr.w CODE_C55BE8
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C562C3
	lda.w $058D
	bit.w #$1000
	bne CODE_C5630D
	bit.w #$0800
	beq CODE_C56301
	jsr.w CODE_C55CE6
	bra CODE_C562C3
CODE_C56301:						; from CODE_C562C6
	bit.w #$0400
	beq CODE_C5630B
	jsr.w CODE_C55C58
	bra CODE_C562C3
CODE_C5630B:						; from CODE_C56301
	bra CODE_C562C3
CODE_C5630D:						; from CODE_C562C6
	jmp.w CODE_C55A09
CODE_C56310:						; a callback: CODE_C562A4 passes it to CODE_C55ABC
	lda.b $6F
	asl a
	asl a
	asl a
	sec
	sbc.b $6F
	clc
	adc.b $63
	sta.b $65
	tax
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.l $C30000,x
	tax
	ldy.b $6D
	jsl.l $C4BBE5
	stz.b $6B
	lda.w #$00B8
	sta.b $CF
	lda.w #$00F8
	sta.b $D1
	ldx.b $65
	lda.l $C30002,x
	and.w #$00FF
	tax
	jsr (DATA8_C55D6B,x)
	lda.w #$0002
	sta.b $6B
	lda.w #$0010
	sta.b $CF
	lda.w #$0038
	sta.b $D1
	ldx.b $65
	lda.l $C30002,x
	and.w #$00FF
	tax
	jmp (DATA8_C55D6B,x)
CODE_C56368:						; called from other segments
	lda.w #$532D
	jsr.w CODE_C55A40
	stz.b $7B
	jsr.w CODE_C563D0
	jsl.l $C4C2AA
	stz.w fadestep
CODE_C5637A:						; from CODE_C5637D, CODE_C563C8
	inc.w TransfersReady
CODE_C5637D:						; from CODE_C5637D
	lda.w TransfersReady
	bne CODE_C5637D
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
	bne CODE_C5637A
	lda.w $058D
	bit.w #$8000
	beq CODE_C563C8
	lda.b $D3
	clc
	adc.w #$03C0
	ldy.w #$0340
	jsl.l CODE_C58B11
	lda.b $7B
	eor.w #$0001
	sta.b $7B
	jsr.w CODE_C563D0
	jsl.l $C4C2AA
	bra CODE_C5637A
CODE_C563C8:						; from CODE_C5637D
	bit.w #$1000
	beq CODE_C5637A
	jmp.w CODE_C55A09
CODE_C563D0:						; from CODE_C56368, CODE_C5637D
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w #$0000
	ldy.w #$0013
CODE_C563E0:						; from CODE_C563E0
	pha
	phy
	asl a
	tax
	lda.l $C35E25,x
	tax
	jsl.l $C4BBE5
	ply
	iny
	pla
	cmp.w $1876
	beq CODE_C563F8
	inc a
	bra CODE_C563E0
CODE_C563F8:						; from CODE_C563E0
	ldx.w #$4C1C
	ldy.w #$0018
	jsl.l $C4BBE5
	lda.w #$4EEF
	sta.b $67
	ldy.w #$129B
	ldx.w #$4B6A
	lda.b $7B
	beq CODE_C5641C
	ldy.w #$1287
	ldx.w #$4B9E
	lda.w #$4EE1
	sta.b $67
CODE_C5641C:						; from CODE_C563F8
	sty.b $63
	ldy.w #$000F
	jsl.l $C4BCA4
	ldy.w #$0011
	jsl.l $C4BDE6
	ldx.b $67
	ldy.w #$001A
	jsl.l $C4BBFC
	lda.w #$0090
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	jsr.w CODE_C56453
	lda.w #$0010
	sta.b $CF
	lda.w #$0070
	sta.b $D1
	inc.b $63
	inc.b $63
	jmp.w CODE_C56453
CODE_C56453:						; from CODE_C5641C
	stz.b $9F
	lda.w #$0000
	ldy.w #$0013
CODE_C5645B:						; from CODE_C5645B
	pha
	phy
	asl a
	asl a
	tay
	lda.b ($63),y
	adc.b $9F
	sta.b $9F
	lda.b ($63),y
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w CODE_C55EC7
	lda.b $01,s
	tay
	ldx.w #$04F5
	jsl.l $C4BBF1
	ply
	iny
	pla
	cmp.w $1876
	beq CODE_C56488
	inc a
	bra CODE_C5645B
CODE_C56488:						; from CODE_C5645B
	ldy.w #$0018
	ldx.b $9F
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w CODE_C55EC7
	ldx.w #$04F5
	jsl.l $C4BBF1
	rts
CODE_C5649F:						; called from other segments
	jsl.l FadeOutWait
	jsl.l $C4CEDB
	jsr.w CODE_C55951
	lda.w #$533B
	jsl.l $C4BB5A
	jsl.l CODE_C53ABC
	stz.b $7D
	ldy.w #$2801
	ldx.w #$5135
	jsl.l $C387D8
	stz.w $058D
CODE_C564C4:						; from CODE_C565CB
	lda.w #$00D0
	sta.b $18
	lda.w #$0028
	sta.b $1A
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w $058D
	bit.w #$8000
	bne CODE_C564FE
	clc
	lda.b $D3
	adc.w #$026A
	pha
	ldy.w #$0012
	jsl.l CODE_C58B11
	pla
	clc
	adc.w #$0040
	ldy.w #$0012
	jsl.l CODE_C58B11
	jsl.l $C4C2AA
CODE_C564FE:						; from CODE_C564C4
	jsr.w CODE_C55E57
	ldx.w #$2DC9
	lda.b $6B
	beq CODE_C5650B
	ldx.w #$3207
CODE_C5650B:						; from CODE_C564FE
	lda.b $7D
	cmp.w #$FFFF
	bne CODE_C5651C
	lda.w $0002,x
	sta.b $67
	jsr.w CODE_C566E8
	bra CODE_C56528
CODE_C5651C:						; from CODE_C5650B
	lda.w $0000,x
	sec
	sbc.w $0002,x
	sta.b $67
	jsr.w CODE_C5663A
CODE_C56528:						; from CODE_C5650B
	lda.w #CODE_C56759
	ldx.w #$000B
	ldy.w #$000D
	jsr.w CODE_C55ABC
	jsr.w CODE_C56880
	jsl.l $C4C2AA
	stz.w fadestep
CODE_C5653E:						; from CODE_C56541, CODE_C56575, CODE_C5657F, CODE_C56607
	inc.w TransfersReady
CODE_C56541:						; from CODE_C56541
	lda.w TransfersReady
	bne CODE_C56541
	jsl.l $C36C2D
	inc.b $26
	jsr.w CODE_C55BE8
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C5653E
	lda.w $058D
	bit.w #$1000
	beq CODE_C56575
	jmp.w CODE_C55A09
CODE_C56575:						; from CODE_C56541
	bit.w #$0800
	beq CODE_C5657F
	jsr.w CODE_C55CE6
	bra CODE_C5653E
CODE_C5657F:						; from CODE_C56575
	bit.w #$0400
	beq CODE_C56589
	jsr.w CODE_C55C58
	bra CODE_C5653E
CODE_C56589:						; from CODE_C5657F
	ldx.b $7D
	cpx.w #$FFFF
	beq CODE_C565BF
	bit.w #$0200
	beq CODE_C5659F
	lda.b $7D
	beq CODE_C5659F
	dec a
	dec a
	sta.b $7D
	bra CODE_C565AF
CODE_C5659F:						; from CODE_C56589
	bit.w #$0100
	beq CODE_C565BF
	lda.b $7D
	cmp.w #$0008
	beq CODE_C565BF
	inc a
	inc a
	sta.b $7D
CODE_C565AF:						; from CODE_C56589
	jsr.w CODE_C5660A
	jsr.w CODE_C5663A
	jsr.w CODE_C55C12
	jsr.w CODE_C56880
	jsl.l $C4C2AA
CODE_C565BF:						; from CODE_C56589, CODE_C5659F
	bit.w #$4000
	beq CODE_C565E3
	lda.b $6B
	eor.w #$0002
	sta.b $6B
CODE_C565CB:						; from CODE_C565E3, CODE_C56603
	ldx.b $7B
	jsl.l CODE_C5E596
	ldx.b $77
	jsl.l CODE_C5E596
	ldx.b $79
	jsl.l CODE_C5E596
	jsr.w CODE_C5660A
	jmp.w CODE_C564C4
CODE_C565E3:						; from CODE_C565BF
	bit.w #$8000
	beq CODE_C56607
	lda.b $D3
	clc
	adc.w #$02C0
	ldy.w #$0040
	jsl.l CODE_C58B11
	jsr.w CODE_C5660A
	lda.w #$FFFF
	cmp.b $7D
	beq CODE_C56603
	sta.b $7D
	bra CODE_C565CB
CODE_C56603:						; from CODE_C565E3
	stz.b $7D
	bra CODE_C565CB
CODE_C56607:						; from CODE_C565E3
	jmp.w CODE_C5653E
CODE_C5660A:						; from CODE_C565CB, CODE_C565AF, CODE_C565E3
	lda.w #$0300
	clc
	adc.b $D3
	pha
	ldy.w #$0380
	jsl.l CODE_C58B11
	jsl.l $C4C2AA
	pla
	sec
	sbc.w #$0100
	pha
	ldy.w #$0020
	jsl.l CODE_C58B11
	pla
	clc
	adc.w #$0040
	ldy.w #$0020
	jsl.l CODE_C58B11
	jsl.l $C4CEDB
	rts
CODE_C5663A:						; from CODE_C5651C, CODE_C565AF
	ldx.w #$2DC9
	ldy.w #$0000
	lda.b $6B
	beq CODE_C5664A
	ldx.w #$3207
	ldy.w #$001A
CODE_C5664A:						; from CODE_C5663A
	sty.b $A5
	lda.w $0002,x
	sta.w $364E
	sta.b $0C
	sta.b $A1
	lda.b $67
	dec a
	sta.b $9F
	lda.w #$0002
	sta.b $A3
CODE_C56660:						; from CODE_C56683
	inc.b $A1
	ldy.b $A1
	jsr.w CODE_C566A1
	sta.b $0A
	stz.b $0E
CODE_C5666B:						; from CODE_C5666B
	ldy.b $0E
	lda.w $364E,y
	tay
	jsr.w CODE_C566A1
	cmp.b $0A
	bcc CODE_C56691
	lda.b $0E
	inc a
	inc a
	sta.b $0E
	cmp.b $A3
	bne CODE_C5666B
	tax
CODE_C56683:						; from CODE_C56693
	lda.b $A1
	sta.w $364E,x
	inc.b $A3
	inc.b $A3
	dec.b $9F
	bne CODE_C56660
	rts
CODE_C56691:						; from CODE_C5666B
	ldx.b $A3
CODE_C56693:						; from CODE_C56693
	dex
	dex
	lda.w $364E,x
	sta.w $3650,x
	cpx.b $0E
	bne CODE_C56693
	bra CODE_C56683
CODE_C566A1:						; from CODE_C56660, CODE_C5666B
	tya
	clc
	adc.b $A5
	pha
	ldx.b $7D
	jmp (DATA8_C566DE,x)
CODE_C566AB:						; from DATA8_C566DE
	plx
	lda.w $1413,x
	and.w #$00FF
	rts
CODE_C566B3:						; from DATA8_C566DE
	plx
	lda.w $1447,x
	and.w #$00FF
	rts
CODE_C566BB:						; from DATA8_C566DE
	plx
	lda.w $1447,x
	and.w #$00FF
	pha
	lda.w $1413,x
	and.w #$00FF
	clc
	adc.b $01,s
	plx
	rts
CODE_C566CE:						; from DATA8_C566DE
	plx
	lda.w $147B,x
	and.w #$00FF
	rts
CODE_C566D6:						; from DATA8_C566DE
	plx
	lda.w $14AF,x
	and.w #$00FF
	rts
DATA8_C566DE:						; jump table: the routine for each index
	dw CODE_C566AB,CODE_C566B3,CODE_C566BB,CODE_C566CE
	dw CODE_C566D6
CODE_C566E8:						; from CODE_C5650B
	ldx.w #$2DC9
	ldy.w #$0000
	lda.b $6B
	beq CODE_C566F8
	ldx.w #$3207
	ldy.w #$001A
CODE_C566F8:						; from CODE_C566E8
	sty.b $A5
	stz.w $364E
	stz.b $0C
	stz.b $A1
	lda.w $0002,x
	dec a
	sta.b $9F
	lda.w #$0002
	sta.b $A3
CODE_C5670C:						; from CODE_C5673B
	inc.b $A1
	lda.b $A1
	clc
	adc.b $A5
	tax
	lda.w $1413,x
	and.w #$00FF
	sta.b $0A
	ldy.b $0C
	stz.b $0E
CODE_C56720:						; from CODE_C56720
	tya
	clc
	adc.b $A5
	tax
	lda.w $1413,x
	and.w #$00FF
	cmp.b $0A
	bcc CODE_C56749
	iny
	lda.b $0E
	inc a
	inc a
	sta.b $0E
	cmp.b $A3
	bne CODE_C56720
	tax
CODE_C5673B:						; from CODE_C5674B
	lda.b $A1
	sta.w $364E,x
	inc.b $A3
	inc.b $A3
	dec.b $9F
	bne CODE_C5670C
	rts
CODE_C56749:						; from CODE_C56720
	ldx.b $A3
CODE_C5674B:						; from CODE_C5674B
	dex
	dex
	lda.w $364E,x
	sta.w $3650,x
	cpx.b $0E
	bne CODE_C5674B
	bra CODE_C5673B
CODE_C56759:						; a callback: CODE_C56528 passes it to CODE_C55ABC
	lda.w #$0010
	sta.b $CF
	lda.b $6F
	asl a
	tay
	lda.w $364E,y
	sta.b $65
	lda.w #$2DC9
	ldx.b $6B
	beq CODE_C56771
	lda.w #$3207
CODE_C56771:						; from CODE_C56759
	pha
	lda.b $65
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $01,s
	adc.w #$0118
	plx
	tax
	lda.w #$000E
	jsr.w CODE_C55F1F
	ldy.b $6D
	jsl.l $C4BC08
	lda.b $6B
	beq CODE_C56798
	lda.b $65
	clc
	adc.w #$001A
	sta.b $65
CODE_C56798:						; from CODE_C56771
	lda.w #$0078
	sta.b $CF
	lda.w #$0090
	sta.b $D1
	ldx.b $65
	lda.w $1413,x
	and.w #$00FF
	ldx.w #$0000
	jsr.w CODE_C5680B
	lda.w #$00A8
	sta.b $D1
	ldx.b $65
	lda.b $7D
	cmp.w #$FFFF
	beq CODE_C5683C
	lda.w $1447,x
	and.w #$00FF
	ldx.w #$0002
	jsr.w CODE_C5680B
	lda.w #$00C0
	sta.b $D1
	ldx.b $65
	lda.w $1413,x
	and.w #$00FF
	pha
	lda.w $1447,x
	and.w #$00FF
	clc
	adc.b $01,s
	ply
	ldx.w #$0004
	jsr.w CODE_C5680B
	lda.w #$00D8
	sta.b $D1
	ldx.b $65
	lda.w $147B,x
	and.w #$00FF
	ldx.w #$0006
	jsr.w CODE_C5680B
	lda.w #$00F0
	sta.b $D1
	ldx.b $65
	lda.w $14AF,x
	and.w #$00FF
	ldx.w #$0008
CODE_C5680B:						; from CODE_C56798, CODE_C5683C, CODE_C56873
	cpx.b $7D
	bne CODE_C56814
	ldx.w #$2400
	stx.b $D5
CODE_C56814:						; from CODE_C5680B
	cmp.w #$0064
	bne CODE_C5681E
	lda.w #$0100
	bra CODE_C56826
CODE_C5681E:						; from CODE_C56814
	tax
	lda.l BCDTable,x
	and.w #$00FF
CODE_C56826:						; from CODE_C56814
	jsr.w CODE_C55EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l $C4BBF1
	lda.w #$2000
	sta.b $D5
	lda.b $D1
	sta.b $CF
	rts
CODE_C5683C:						; from CODE_C56798
	lda.w $147B,x
	and.w #$00FF
	ldx.w #$8000
	jsr.w CODE_C5680B
	lda.w #$00E0
	sta.b $D1
	ldx.b $65
	lda.w $1413,x
	and.w #$00FF
	ldx.w #$0064
	jsl.l Mul8U
	sta.b $34
	ldx.b $65
	lda.w $147B,x
	and.w #$00FF
	sta.b $30
	beq CODE_C56870
	jsl.l Div16U
	bra CODE_C56873
CODE_C56870:						; from CODE_C5683C
	lda.w #$0064
CODE_C56873:						; from CODE_C5683C
	eor.w #$FFFF
	sec
	adc.w #$0064
	ldx.w #$8000
	jmp.w CODE_C5680B
CODE_C56880:						; from CODE_C56528, CODE_C565AF
	lda.w #$0010
	sta.b $CF
	lda.w #$0078
	sta.b $D1
	lda.w #$0200
	clc
	adc.b $D3
	ldy.w #$0020
	jsl.l CODE_C58B11
	lda.w #$0240
	clc
	adc.b $D3
	ldy.w #$0020
	jsl.l CODE_C58B11
	ldy.w #$000B
	sty.b $6D
	ldx.b $7D
	cpx.w #$FFFF
	bne CODE_C568B3
	jmp.w CODE_C56938
CODE_C568B3:						; from CODE_C56880
	lda.l DATA8_C56989,x
	tax
	ldy.w #$0008
	jsl.l $C4BC26
	lda.w #$0020
	sta.b $CF
	ldx.w #$4EF6
	ldy.w #$0019
	jsl.l $C4BBFC
	lda.w #$0010
	sta.b $CF
	ldx.w #$4F6C
	lda.w #$8000
	jsr.w CODE_C5691F
	lda.w #$0090
	sta.b $D1
	ldx.w #$4F71
	lda.w #$0000
	jsr.w CODE_C5691F
	lda.w #$00A8
	sta.b $D1
	ldx.w #$4F73
	lda.w #$0002
	jsr.w CODE_C5691F
	lda.w #$00C0
	sta.b $D1
	ldx.w #$4F75
	lda.w #$0004
	jsr.w CODE_C5691F
	lda.w #$00D8
	sta.b $D1
	ldx.w #$4F78
	lda.w #$0006
	jsr.w CODE_C5691F
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4F7B
	lda.w #$0008
CODE_C5691F:						; from CODE_C568B3, CODE_C56938
	cmp.b $7D
	bne CODE_C56928
	lda.w #$2400
	sta.b $D5
CODE_C56928:						; from CODE_C5691F
	ldy.b $6D
	jsl.l $C4BBE5
	lda.w #$2000
	sta.b $D5
	lda.b $D1
	sta.b $CF
	rts
CODE_C56938:						; from CODE_C56880
	ldx.w #$47F8
	ldy.w #$0008
	jsl.l $C4BC26
	lda.w #$0020
	sta.b $CF
	ldx.w #$4EFE
	ldy.w #$0019
	jsl.l $C4BBFC
	lda.w #$0010
	sta.b $CF
	ldx.w #$49B8
	lda.w #$8000
	jsr.w CODE_C5691F
	lda.w #$0090
	sta.b $D1
	ldx.w #$4F7D
	lda.w #$8000
	jsr.w CODE_C5691F
	lda.w #$00A8
	sta.b $D1
	ldx.w #$4F78
	lda.w #$8000
	jsr.w CODE_C5691F
	lda.w #$00E0
	sta.b $D1
	ldx.w #$4F7F
	lda.w #$8000
	jmp.w CODE_C5691F
DATA8_C56989:						; not traced: a table read by CODE_C568B3
	db $6A,$4B,$6F,$4B,$75,$4B,$9E,$4B,$08,$48
CODE_C56993:						; called from other segments
	lda.w #$534D
	jsr.w CODE_C55A40
	lda.w #$0010
	sta.b $CF
	lda.w #$0030
	sta.b $D1
	ldx.w #$4F83
	jsr.w CODE_C56A6B
	lda.w #$0060
	sta.b $D1
	ldx.w #$4F87
	jsr.w CODE_C56A6B
	lda.w #$0080
	sta.b $D1
	ldx.w #$4F8B
	jsr.w CODE_C56A6B
	lda.w #$00E0
	sta.b $D1
	ldx.w #$4F6C
	jsr.w CODE_C56A6B
	lda.w #$00F8
	sta.b $D1
	ldx.w #$4F7B
	jsr.w CODE_C56A6B
	lda.w $1159
	asl a
	adc.w $1159
	bne CODE_C56A00
	sta.b $67
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w #$2400
	sta.b $D5
	ldx.w #$4C2D
	ldy.w #$0011
	jsl.l $C4BBE5
	lda.w #$2000
	sta.b $D5
	bra CODE_C56A0F
CODE_C56A00:						; from CODE_C56993
	dec a
	sta.b $67
	lda.w #CODE_C56A77
	ldx.w #$0006
	ldy.w #$0012
	jsr.w CODE_C55ABC
CODE_C56A0F:						; from CODE_C56993
	jsl.l $C4C2AA
	stz.w fadestep
CODE_C56A16:						; from CODE_C56A2B, CODE_C56A5C, CODE_C56A66
	inc.w TransfersReady
CODE_C56A19:						; from CODE_C56A19
	lda.w TransfersReady
	bne CODE_C56A19
	jsl.l $C36C2D
	inc.b $26
	lda.b $67
	beq CODE_C56A2B
	jsr.w CODE_C55BE8
CODE_C56A2B:						; from CODE_C56A19
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C56A16
	lda.w $058D
	bit.w #$1000
	bne CODE_C56A68
	ldx.b $67
	beq CODE_C56A16
	bit.w #$0800
	beq CODE_C56A5C
	jsr.w CODE_C55CE6
	bra CODE_C56A16
CODE_C56A5C:						; from CODE_C56A2B
	bit.w #$0400
	beq CODE_C56A66
	jsr.w CODE_C55C58
	bra CODE_C56A16
CODE_C56A66:						; from CODE_C56A5C
	bra CODE_C56A16
CODE_C56A68:						; from CODE_C56A2B
	jmp.w CODE_C55A09
CODE_C56A6B:						; from CODE_C56993
	ldy.w #$000F
	jsl.l $C4BBE5
	lda.b $D1
	sta.b $CF
	rts
CODE_C56A77:						; a callback: CODE_C56A00 passes it to CODE_C55ABC
	lda.b $6F
	sta.b $34
	lda.w #$0003
	sta.b $30
	jsl.l Div16x8U
	asl a
	asl a
	sta.b $65
	tax
	lda.l RDMPYL
	beq CODE_C56ABB
	dec a
	beq CODE_C56A93
	rts
CODE_C56A93:						; from CODE_C56A77
	lda.w #$0070
	sta.b $CF
	lda.w #$00E0
	sta.b $D1
	lda.w $115E,x
	and.w #$00FF
	tax
	lda.l $C34499,x
	sec
	adc.w #$4499
	inc a
	ldx.w #$00C3
	jsl.l CODE_C58BB9
	ldy.b $6D
	jsl.l $C4BC1A
	rts
CODE_C56ABB:						; from CODE_C56A77
	lda.w #$2400
	sta.b $D5
	lda.w #$0010
	sta.b $CF
	lda.w #$0030
	sta.b $D1
	lda.w $115C,x
	and.w #$00C0
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	tax
	lda.l $C35E25,x
	tax
	ldy.b $6D
	jsl.l $C4BBE5
	lda.b $D1
	sta.b $CF
	lda.w #$0060
	sta.b $D1
	ldx.b $65
	lda.w $115B,x
	and.w #$0FFF
	jsr.w CODE_C5605D
	ldy.b $6D
	ldx.w #$04F5
	jsl.l $C4BBF1
	lda.b $D1
	sta.b $CF
	lda.w #$0080
	sta.b $D1
	ldx.b $65
	lda.w $115D,x
	and.w #$0080
	beq CODE_C56B16
	pea.w $3207
	bra CODE_C56B19
CODE_C56B16:						; from CODE_C56ABB
	pea.w $2DC9
CODE_C56B19:						; from CODE_C56ABB
	jsr.w CODE_C56104
	ldy.b $6D
	jsl.l $C4BBE5
	lda.b $D1
	sta.b $CF
	lda.w #$00E0
	sta.b $D1
	ldx.b $65
	lda.w $115D,x
	and.w #$007F
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $01,s
	adc.w #$0118
	plx
	tax
	lda.w #$000C
	jsr.w CODE_C55F1F
	ldy.b $6D
	jsl.l $C4BBF1
	lda.b $D1
	sta.b $CF
	lda.w #$00F8
	sta.b $D1
	ldx.b $65
	lda.w $115E,x
	and.w #$00FF
	tax
	lda.l $C34499,x
	tax
	lda.l $C34499,x
	and.w #$00FF
	jsr.w CODE_C55EC7
	ldx.w #$04F5
	ldy.b $6D
	jsl.l $C4BBF1
	lda.w #$2000
	sta.b $D5
	rts
CODE_C56B7B:						; called from other segments
	lda.w #$0002
	bra CODE_C56B83
CODE_C56B80:						; from CODE_C56B90 and other segments
	lda.w #$0003
CODE_C56B83:						; from CODE_C56B7B
	stz.w $18F6
	sta.w $18F2
	jmp.w CODE_C54FA9
CODE_C56B8C:						; called from other segments
	jml.l CODE_C5004E
CODE_C56B90:						; called from other segments
	jsl.l CODE_C53ABC
	ldx.b $6B
	lda.w $1303,x
	beq CODE_C56B80
	dec a
	sta.w $1303,x
	jsl.l CODE_C54AEF
	ldx.w #$5D41
	jsr.w CODE_C552AC
	lda.w #$00C3
	sta.b $2E
	lda.w #$5A08
	sta.b $2C
	lda.w #$0318
	jsr.w CODE_C56C4C
	lda.w #$5A11
	sta.b $2C
	lda.w #$039E
	jsr.w CODE_C56C4C
	lda.w $17C9
	ldx.b $6B
	beq CODE_C56BCE
	lda.w $17CB
CODE_C56BCE:						; from CODE_C56B90
	asl a
	tax
	lda.l $C3585C,x
	tax
	jsl.l $C4C3BA
	lda.w #$007E
	sta.b $2E
	stx.b $2C
	sep #$20
	ldy.w #$0000
CODE_C56BE5:						; from CODE_C56BE5
	iny
	inx
	lda.w $0000,x
	bne CODE_C56BE5
	tya
	pha
CODE_C56BEE:						; from CODE_C56BF8
	dex
	lda.w $0000,x
	cmp.b #$3D
	bne CODE_C56BF8
	lda.b #$2E
CODE_C56BF8:						; from CODE_C56BEE
	eor.b #$80
	sta.w $0001,x
	dey
	bne CODE_C56BEE
	pla
	sta.w $0000,x
	rep #$20
	and.w #$00FF
	eor.w #$FFFF
	sec
	adc.w #$000C
	lsr a
	adc.w #$0000
	asl a
	adc.w #$0414
	jsr.w CODE_C56C4C
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0700
	pea.w $5800
	pea.w $007E
	lda.w $18EE
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsl.l $C4CEDB
	ldx.w #$0096
	ldy.w #$0000
	jsl.l WaitFrames_Inc
	lda.w $18F2
	jmp.w CODE_C54FA9
CODE_C56C4C:						; from CODE_C56B90, CODE_C56BF8
	clc
	adc.w $18EE
	tax
	lda.b [$2C]
	and.w #$00FF
	tay
CODE_C56C57:						; from CODE_C56C57
	inc.b $2C
	lda.b [$2C]
	and.w #$00FF
	ora.w #$3A00
	sta.w $0000,x
	inx
	inx
	dey
	bne CODE_C56C57
	rts
CODE_C56C6A:						; called from other segments
	lda.w #$535B
	jsr.w CODE_C55A40
	lda.w #$0010
	sta.b $CF
	ldx.w #$4F83
	jsr.w CODE_C56D37
	lda.w #$002E
	sta.b $CF
	ldx.w #$4F87
	jsr.w CODE_C56D37
	lda.w #$0054
	sta.b $CF
	ldx.w #$4F8B
	jsr.w CODE_C56D37
	lda.w #$0080
	sta.b $CF
	ldx.w #$4F91
	jsr.w CODE_C56D37
	lda.w #$00E0
	sta.b $CF
	ldx.w #$4F8E
	jsr.w CODE_C56D37
	lda.w $2038
	lsr a
	sta.b $67
	bne CODE_C56CCF
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w #$2400
	sta.b $D5
	ldx.w #$4C43
	ldy.w #$0011
	jsl.l $C4BBE5
	lda.w #$2000
	sta.b $D5
	bra CODE_C56CDB
CODE_C56CCF:						; from CODE_C56C6A
	lda.w #CODE_C56D3F
	ldx.w #$0006
	ldy.w #$0012
	jsr.w CODE_C55ABC
CODE_C56CDB:						; from CODE_C56C6A
	jsl.l $C4C2AA
	stz.w fadestep
CODE_C56CE2:						; from CODE_C56CF7, CODE_C56D28, CODE_C56D32
	inc.w TransfersReady
CODE_C56CE5:						; from CODE_C56CE5
	lda.w TransfersReady
	bne CODE_C56CE5
	jsl.l $C36C2D
	inc.b $26
	lda.b $67
	beq CODE_C56CF7
	jsr.w CODE_C55BE8
CODE_C56CF7:						; from CODE_C56CE5
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C56CE2
	lda.w $058D
	bit.w #$1000
	bne CODE_C56D34
	ldx.b $67
	beq CODE_C56CE2
	bit.w #$0800
	beq CODE_C56D28
	jsr.w CODE_C55CE6
	bra CODE_C56CE2
CODE_C56D28:						; from CODE_C56CF7
	bit.w #$0400
	beq CODE_C56D32
	jsr.w CODE_C55C58
	bra CODE_C56CE2
CODE_C56D32:						; from CODE_C56D28
	bra CODE_C56CE2
CODE_C56D34:						; from CODE_C56CF7
	jmp.w CODE_C55A09
CODE_C56D37:						; from CODE_C56C6A
	ldy.w #$000F
	jsl.l $C4BBFC
	rts
CODE_C56D3F:						; a callback: CODE_C56CCF passes it to CODE_C55ABC
	lda.b $6F
	sta.b $34
	lda.w #$0003
	sta.b $30
	jsl.l Div16x8U
	asl a
	sta.b $65
	asl a
	adc.b $65
	sta.b $65
	tax
	lda.w $203C,x
	and.w #$0080
	beq CODE_C56D62
	pea.w $3207
	bra CODE_C56D65
CODE_C56D62:						; from CODE_C56D3F
	pea.w $2DC9
CODE_C56D65:						; from CODE_C56D3F
	lda.w #$007A
	sta.b $CF
	lda.w #$00E0
	sta.b $D1
	lda.l RDMPYL
	beq CODE_C56DA1
	dec a
	beq CODE_C56D7D
	lda.w $203F,x
	bra CODE_C56D80
CODE_C56D7D:						; from CODE_C56D65
	lda.w $203E,x
CODE_C56D80:						; from CODE_C56D65
	and.w #$00FF
	cmp.w #$00FF
	beq CODE_C56D9F
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $01,s
	adc.w #$0118
	tax
	lda.w #$000C
	jsr.w CODE_C55F1F
	ldy.b $6D
	jsl.l $C4BC08
CODE_C56D9F:						; from CODE_C56D80
	plx
	rts
CODE_C56DA1:						; from CODE_C56D65
	lda.w #$2400
	sta.b $D5
	lda.w #$0009
	sta.b $CF
	lda.w #$0029
	sta.b $D1
	lda.l $7E203B,x
	and.w #$00C0
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	tax
	lda.l $C35E25,x
	tax
	ldy.b $6D
	jsl.l $C4BBE5
	lda.b $D1
	sta.b $CF
	lda.w #$0050
	sta.b $D1
	ldx.b $65
	lda.l $7E203A,x
	and.w #$0FFF
	jsr.w CODE_C5605D
	ldy.b $6D
	ldx.w #$04F5
	jsl.l $C4BBF1
	lda.b $D1
	sta.b $CF
	lda.w #$0068
	sta.b $D1
	ldx.b $65
	lda.l $7E203C,x
	and.w #$0080
	jsr.w CODE_C56104
	ldy.b $6D
	jsl.l $C4BBE5
	lda.w #$0072
	sta.b $CF
	ldx.b $65
	lda.l $7E203D,x
	and.w #$007F
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $01,s
	adc.w #$0118
	plx
	tax
	lda.w #$000D
	jsr.w CODE_C55F1F
	ldy.b $6D
	jsl.l $C4BC08
	lda.w #$00E0
	sta.b $CF
	ldx.b $65
	lda.l $7E203C,x
	and.w #$0007
	cmp.w #$0005
	bcc CODE_C56E3D
	lda.w #$0002
CODE_C56E3D:						; from CODE_C56DA1
	asl a
	tax
	lda.l $C35E2D,x
	cmp.w #$FFFF
	beq CODE_C56E4F
	tax
	ldy.b $6D
	jsl.l $C4BBFC
CODE_C56E4F:						; from CODE_C56E3D
	lda.w #$2000
	sta.b $D5
	rts
CODE_C56E55:						; called from other segments
	jsl.l CODE_C53ABC
	ldx.b $6B
	lda.w $17C1,x
	eor.w #$0001
	sta.w $17C1,x
	lda.w $18F2
	jmp.w CODE_C54FA9
CODE_C56E6A:						; called from other segments
	lda.w #$0001
	sta.w $24DC
	jsl.l FadeOutWait
	jsl.l $C4CEDB
	jsr.w CODE_C55951
	lda.w #$5369
	jsl.l $C4BB5A
	jsl.l CODE_C53ABC
	stz.b $7D
	stz.b $79
	ldy.w #$2801
	ldx.w #$5135
	jsl.l $C387D8
CODE_C56E94:						; from CODE_C56F50
	jsr.w CODE_C56F5C
	lda.w #$00D0
	sta.b $18
	lda.w #$0028
	sta.b $1A
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	jsr.w CODE_C55E57
	stz.w fadestep
CODE_C56EB1:						; from CODE_C56EB4, CODE_C56EFD, CODE_C56EF4, CODE_C56F0A, ...
	inc.w TransfersReady
CODE_C56EB4:						; from CODE_C56EB4
	lda.w TransfersReady
	bne CODE_C56EB4
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
	bne CODE_C56EB1
	lda.w $058D
	bit.w #$1000
	bne CODE_C56F59
	bit.w #$0100
	beq CODE_C56EFD
	lda.b $7D
	ldx.b $79
	bne CODE_C56EF4
	cmp.w #$000B
	bcs CODE_C56EB1
	bra CODE_C56EF9
CODE_C56EF4:						; from CODE_C56EB4
	cmp.w #$000F
	bcs CODE_C56EB1
CODE_C56EF9:						; from CODE_C56EB4
	inc.b $7D
	bra CODE_C56F50
CODE_C56EFD:						; from CODE_C56EB4
	bit.w #$0200
	beq CODE_C56F0A
	lda.b $7D
	beq CODE_C56EB1
	dec.b $7D
	bra CODE_C56F50
CODE_C56F0A:						; from CODE_C56EFD
	bit.w #$0400
	beq CODE_C56F1A
	lda.b $79
	cmp.w #$0007
	bcs CODE_C56EB1
	inc.b $79
	bra CODE_C56F50
CODE_C56F1A:						; from CODE_C56F0A
	bit.w #$0800
	beq CODE_C56F32
	lda.b $79
	beq CODE_C56EB1
	dec.b $79
	bne CODE_C56F50
	lda.w #$000B
	cmp.b $7D
	bcs CODE_C56F50
	sta.b $7D
	bra CODE_C56F50
CODE_C56F32:						; from CODE_C56F1A
	bit.w #$4000
	beq CODE_C56F4D
	lda.w #$0240
	clc
	adc.b $D3
	ldy.w #$0080
	jsl.l CODE_C58B11
	lda.b $6B
	eor.w #$0002
	sta.b $6B
	bra CODE_C56F50
CODE_C56F4D:						; from CODE_C56F32
	jmp.w CODE_C56EB1
CODE_C56F50:						; from CODE_C56EFD, CODE_C56EF9, CODE_C56F0A, CODE_C56F1A, ...
	ldx.b $7B
	jsl.l CODE_C5E596
	jmp.w CODE_C56E94
CODE_C56F59:						; from CODE_C56EB4
	jmp.w CODE_C55A09

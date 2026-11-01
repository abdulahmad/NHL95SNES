; Segment bankC5_4000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C53FE5
CODE_C53FE5:						; called from other segments
	ldy.b $6B
	lda.w $12FF,y
	and.w #$FFEF
	sta.w $12FF,y
	lda.w #$0005
	sta.b $87
	ldx.w $1283,y
	stx.b $6F
CODE_C53FFA:						; from CODE_C5403F
	lda.w $0FC0,x
	beq CODE_C54008
	lda.w $08E0,x
	and.w #$F7FF
	sta.w $08E0,x
CODE_C54008:						; from CODE_C53FFA
	stz.w $1060,x
	lda.w $0D60,x
	and.w #$2FFF
	sta.w $0D60,x
	lda.w $0A20,x
	bmi CODE_C5403F
	bne CODE_C54020
	lda.w #$121E
	bra CODE_C54023
CODE_C54020:						; from CODE_C54008
	lda.w #$1958
CODE_C54023:						; from CODE_C54008
	jsl.l SetSPAFromA
	stz.w $0A00,x
	stz.w $0CE0,x
	lda.w $0D60,x
	and.w #$FFF6
	sta.w $0D60,x
	stz.w $1080,x
	stz.w $1040,x
	stz.w $1000,x
CODE_C5403F:						; from CODE_C54008
	inc.b $6F
	inc.b $6F
	ldx.b $6F
	dec.b $87
	bpl CODE_C53FFA
	rtl
CODE_C5404A:						; called from other segments
	lda.w $186E
	cmp.w #$0001
	bne CODE_C5406F
	jsl.l loadTeamStruct
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0008
	bne CODE_C5406F
	ora.w #$0008
	sta.w $12FF,y
	lda.w #$000C
	trb.w $10F5
	jmp.w CODE_C54070
CODE_C5406F:						; from CODE_C5404A
	rtl
CODE_C54070:						; from CODE_C5404A, CODE_C5454E and other segments
	phx
	jsr.w CODE_C54114
	sta.b $7F
	sty.b $81
	jsl.l CODE_C58C36
	lda.b $6B
	jsr.w CODE_C56104
	jsl.l CODE_C4C3AE
	jsr.w CODE_C56262
	lda.b $7F
	clc
	adc.w #$0027
	tay
	txa
	ldx.w #$007E
	jsl.l QueueVRAMDMALen
	lda.b $81
	dec a
	asl a
	asl a
	asl a
	asl a
	asl a
	sec
	adc.b $7F
	sta.b $7F
	lda.w #$0002
CODE_C540A7:						; from CODE_C54107
	sta.b $81
	jsr.w CODE_C54155
	tax
	bmi CODE_C54107
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0008
	bne CODE_C540C3
	lda.b $81
	cmp.w $1307,y
	bne CODE_C540FF
	ldx.w $12B7,y
CODE_C540C3:						; from CODE_C540A7
	phx
	lda.w #$0006
	jsl.l CODE_C4C561
	tay
	lda.w #$0005
	sta.w $0000,y
	lda.b $81
	asl a
	tax
	lda.l DATA8_C5410E,x
	sta.w $0001,y
	lda.b $01,s
	asl a
	adc.b $01,s
	tax
	lda.l DATA8_C09B3F,x
	sta.w $0003,y
	lda.l $C09B40,x
	sta.w $0004,y
	tya
	ldx.w #$007E
	ldy.b $7F
	jsl.l QueueVRAMDMALen
	pla
	jsr.w CODE_C54D03
CODE_C540FF:						; from CODE_C540A7
	lda.b $7F
	sec
	sbc.w #$0020
	sta.b $7F
CODE_C54107:						; from CODE_C540A7
	lda.b $81
	dec a
	bpl CODE_C540A7
	plx
	rtl
DATA8_C5410E:						; not traced: a table read by CODE_C540C3
	db $D9,$A0,$C2,$A0,$C1,$A0
CODE_C54114:						; from CODE_C54070, CODE_C54B60
	lda.w $10F1
	ldx.b $6B
	beq CODE_C54130
	bit.w #$0002
	beq CODE_C54135
CODE_C54120:						; not traced: data between routines
	db $A0,$B5
CODE_C54122:						; called from other segments
	phy
	lda.w $12C7
	cmp.w $12C9
	beq CODE_C54140
	ldy.w #$5AD5
	bra CODE_C54140
CODE_C54130:						; from CODE_C54114
	bit.w #$0002
	beq CODE_C54120
CODE_C54135:						; from CODE_C54114
	ldy.w #$5855
	lda.w $18AA
	beq CODE_C54140
	ldy.w #$5995
CODE_C54140:						; from CODE_C54122, CODE_C54135
	phy
	lda.w #$0002
	jsr.w CODE_C54155
	ldy.w #$0005
	cmp.w #$FFFF
	bne CODE_C54150
	dey
CODE_C54150:						; from CODE_C54140
	ldx.w #$000B
	pla
	rts
CODE_C54155:						; from CODE_C540A7, CODE_C54DA4, CODE_C54140
	phx
	pha
	lda.b $6B
	tax
	eor.w #$0002
	tay
	lda.w $12C7,y
	sec
	sbc.w $12C7,x
	beq CODE_C54171
	bmi CODE_C5416E
	lda.w #$002A
	bra CODE_C54171
CODE_C5416E:						; from CODE_C54155
	lda.w #$0015
CODE_C54171:						; from CODE_C54155
	clc
	adc.b $01,s
	sta.b $01,s
	ldy.b $6B
	lda.w $12B7,y
	asl a
	adc.w $12B7,y
	adc.b $01,s
	tax
	ply
	lda.l DATA8_C54194,x
	plx
	and.w #$00FF
	bit.w #$0080
	beq CODE_C54193
	ora.w #$FF00
CODE_C54193:						; from CODE_C54171
	rts
DATA8_C54194:						; not traced: a table read by CODE_C54171
	db $00,$01,$02,$01,$02,$00,$02,$00,$01,$00,$01,$02,$00,$01,$02,$00
	db $01,$02,$00,$01,$02,$03,$04,$FF,$03,$04,$FF,$03,$04,$FF,$03,$04
	db $FF,$04,$03,$FF,$03,$04,$FF,$03,$04,$FF,$05,$06,$FF,$05,$06,$FF
	db $05,$06,$FF,$05,$06,$FF,$05,$06,$FF,$05,$06,$FF,$06,$05,$FF
setpersonel:						; from CODE_C54982, CODE_C54DA4 and other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	pei ($8F)
	pei ($91)
	pei ($93)
	pei ($95)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	pei ($73)
	pei ($75)
	ldy.b $6B
	ldx.w $1283,y
	stx.b $6F
	lda.w #$0005
	sta.b $8F
CODE_C5420B:						; from CODE_C5420B
	lda.w #$FFFF
	sta.w $0D20,x
	sta.w $0D40,x
	inx
	inx
	stx.b $6F
	dec.b $8F
	bpl CODE_C5420B
	jsl.l SetPlList
	lda.w #$0005
	sta.b $8F
	lda.w #$007E
	sta.b $75
	lda.w #$2008
	sta.b $73
CODE_C5422F:						; from CODE_C54294
	ldy.b $8F
	lda.b [$73],y
	and.w #$00FF
	sta.b $93
	beq CODE_C54294
	dec.b $93
	lda.w #$0005
	sta.b $8B
	ldy.b $6B
	ldx.w $1283,y
	dex
	dex
CODE_C54248:						; from CODE_C54248
	inx
	inx
	stx.b $6F
	lda.w $0DC0,x
	and.w #$00FF
	sta.b $9F
	lda.b $93
	and.w #$00FF
	cmp.b $9F
	beq CODE_C54263
	dec.b $8B
	bpl CODE_C54248
	bra CODE_C54294
CODE_C54263:						; from CODE_C54248
	lda.b $8F
	clc
	adc.w #$0006
	tay
	lda.b [$73],y
	and.w #$00FF
	bit.w #$0080
	beq CODE_C54277
	ora.w #$FF00
CODE_C54277:						; from CODE_C54263
	sta.w $0D20,x
	lda.b $93
	and.w #$00FF
	bit.w #$0080
	beq CODE_C54287
	ora.w #$FF00
CODE_C54287:						; from CODE_C54277
	sta.w $0D40,x
	ldy.b $8F
	sep #$20
	lda.b #$00
	sta.b [$73],y
	rep #$20
CODE_C54294:						; from CODE_C5422F, CODE_C54248
	dec.b $8F
	bpl CODE_C5422F
	lda.w #$0005
	sta.b $8F
	lda.w #$007E
	sta.b $75
	lda.w #$2008
	sta.b $73
CODE_C542A7:						; from CODE_C54310
	ldy.b $8F
	lda.b [$73],y
	and.w #$00FF
	sta.b $93
	beq CODE_C54310
	dec.b $93
	lda.w #$0005
	sta.b $8B
	ldy.b $6B
	ldx.w $1283,y
	dex
	dex
CODE_C542C0:						; from CODE_C542C0, CODE_C542D4
	inx
	inx
	stx.b $6F
	lda.w $0D40,x
	bit.w #$0080
	bne CODE_C542D2
	dec.b $8B
	bpl CODE_C542C0
	bra CODE_C542D4
CODE_C542D2:						; from CODE_C542C0
	stx.b $63
CODE_C542D4:						; from CODE_C542C0
	lda.w $0A20,x
	bpl CODE_C542DD
	dec.b $8B
	bpl CODE_C542C0
CODE_C542DD:						; from CODE_C542D4
	lda.b $8F
	clc
	adc.w #$0006
	tay
	lda.b [$73],y
	and.w #$00FF
	bit.w #$0080
	beq CODE_C542F1
	ora.w #$FF00
CODE_C542F1:						; from CODE_C542DD
	ldy.b $63
	sta.w $0D20,y
	lda.b $93
	and.w #$00FF
	bit.w #$0080
	beq CODE_C54303
	ora.w #$FF00
CODE_C54303:						; from CODE_C542F1
	sta.w $0D40,y
	ldy.b $8F
	sep #$20
	lda.b #$00
	sta.b [$73],y
	rep #$20
CODE_C54310:						; from CODE_C542A7
	dec.b $8F
	bpl CODE_C542A7
	pla
	sta.b $75
	pla
	sta.b $73
	pla
	sta.b $71
	pla
	sta.b $6F
CODE_C54320:						; called from other segments
	pla
	sta.b $6D
	pla
	sta.b $6B
	pla
	sta.b $69
	pla
	sta.b $67
	pla
	sta.b $65
	pla
	sta.b $63
	pla
	sta.b $95
	pla
	sta.b $93
	pla
	sta.b $91
	pla
	sta.b $8F
	pla
	sta.b $8D
	pla
	sta.b $8B
	pla
	sta.b $89
	pla
	sta.b $87
	pla
	sta.b $85
	pla
	sta.b $83
	pla
	sta.b $81
	pla
	sta.b $7F
	ldx.b $6F
	rtl
SetPlList:							; from CODE_C5420B and other segments
	lda.w #$007E
	sta.b $75
	lda.w #$2008
	sta.b $73
	stz.w $2008
	stz.w $200A
	stz.w $200C
	lda.w #$00C0
	sta.b $65
	lda.w #$9B2A
	sta.b $63
	lda.w $1864
	cmp.w #$0001
	bne CODE_C5438A
	lda.w #$00C0
	sta.b $65
	lda.w #$9B38
	sta.b $63
	bra CODE_C543AD
CODE_C5438A:						; from SetPlList
	lda.w $18BE
	beq CODE_C543A4
	lda.w #$00C0
	sta.b $65
	lda.w #$9B31
	sta.b $63
	lda.b $6B
	cmp.w $18B4
	bne CODE_C543AD
	inc.b $63
	bra CODE_C543AD
CODE_C543A4:						; from CODE_C5438A
	ldy.b $6B
	lda.w $12CB,y
	bpl CODE_C543AD
	inc.b $63
CODE_C543AD:						; from SetPlList, CODE_C5438A, CODE_C543A4
	pei ($71)
	pei ($6F)
	jsl.l GetTeamLines
	lda.b $71
	sta.b $69
	lda.b $6F
	sta.b $67
	pla
	sta.b $6F
	pla
	sta.b $71
	ldy.b $6B
	lda.w $12B7,y
	asl a
	asl a
	asl a
	sta.b $7F
	adc.b $67
	sta.b $67
	lda.w $12C7,y
	sta.b $8F
	bra CODE_C5442C
CODE_C543D8:						; from CODE_C5442C
	ldy.b $8F
	lda.b [$63],y
	and.w #$00FF
	sta.b $93
	tay
	sep #$20
	lda.b [$67],y
	ldy.b $8F
	sta.b [$73],y
	lda.b $93
	beq CODE_C543F9
	lda.w $18BE
	beq CODE_C543F9
	lda.w $18B2
	inc a
	sta.b [$73],y
CODE_C543F9:						; from CODE_C543D8
	iny
	iny
	iny
	iny
	iny
	iny
	lda.b $93
	sta.b [$73],y
	rep #$20
	lda.b $93
	bne CODE_C5442C
	ldy.b $6B
	lda.w $12CB,y
	inc a
	sta.b $8B
	bne CODE_C54422
	lda.w $1864
	cmp.w #$0001
	beq CODE_C54420
	lda.w $18BE
	beq CODE_C54422
CODE_C54420:						; from CODE_C543F9
	inc.b $8B
CODE_C54422:						; from CODE_C543F9
	ldy.b $8F
	sep #$20
	lda.b $8B
	sta.b [$73],y
	rep #$20
CODE_C5442C:						; from CODE_C543AD, CODE_C543F9
	dec.b $8F
	bpl CODE_C543D8
	lda.w #$0005
	sta.b $8F
CODE_C54435:						; from CODE_C544C6
	ldy.b $8F
	lda.b [$73],y
	and.w #$00FF
	sta.b $8B
	bne CODE_C54443
	jmp.w CODE_C544C6
CODE_C54443:						; from CODE_C54435
	and.w #$00FF
	bit.w #$0080
	beq CODE_C5444E
	ora.w #$FF00
CODE_C5444E:						; from CODE_C54443
	dec a
	asl a
	sta.b $8B
	lda.b $6B
	beq CODE_C54459
	lda.w #$0034
CODE_C54459:						; from CODE_C5444E
	clc
	adc.b $8B
	tay
	lda.w $1373,y
	cmp.w #$FFFD
	beq CODE_C54471
	cmp.w #$FFFC
	beq CODE_C54471
	lda.w $1373,y
	bmi CODE_C544C6
	beq CODE_C544C6
CODE_C54471:						; from CODE_C54459
	pei ($71)
	pei ($6F)
	jsl.l GetTeamLines
	lda.b $71
	sta.b $69
	lda.b $6F
	sta.b $67
	pla
	sta.b $6F
	pla
	sta.b $71
	lda.b $8F
	clc
	adc.w #$0006
	tay
	lda.b [$73],y
	and.w #$00FF
	asl a
	sta.b $7F
	lda.w #$00C0
	sta.b $65
	lda.w #$9AC0
	sta.b $63
	ldy.b $7F
	lda.b [$63],y
	clc
	adc.b $63
	sta.b $63
CODE_C544A9:						; from CODE_C544A9
	lda.b [$63]
	inc.b $63
	and.w #$00FF
	sta.b $7F
	bit.w #$0080
	bne CODE_C544CE
	ldy.b $7F
	lda.b [$67],y
	and.w #$00FF
	sta.b $7F
	jsl.l TryAddPlayerToList
	beq CODE_C544A9
CODE_C544C6:						; from CODE_C54435, CODE_C54459, CODE_C544D6
	dec.b $8F
	bmi CODE_C544CD
	jmp.w CODE_C54435
CODE_C544CD:						; from CODE_C544C6
	rtl
CODE_C544CE:						; from CODE_C544A9
	jsl.l CODE_C5362E
	lda.b $7F
	sta.b $8B
CODE_C544D6:						; from CODE_C544D6
	lda.b $8B
	sta.b $7F
	dec.b $8B
	bmi CODE_C544C6
	jsl.l TryAddPlayerToList
	beq CODE_C544D6
	bra CODE_C544C6
TryAddPlayerToList:					; from CODE_C544A9, CODE_C544D6 and other segments
	lda.b $7F
	sta.b $83
	dec.b $7F
	asl.b $7F
	lda.b $6B
	beq CODE_C544F5
	lda.w #$0034
CODE_C544F5:						; from TryAddPlayerToList
	adc.b $7F
	tay
	lda.w $1373,y
	sec
	sbc.w #$0000
	beq CODE_C54503
	bpl CODE_C5453B
CODE_C54503:						; from CODE_C544F5
	lda.w $1373,y
	cmp.w #$FFFD
	beq CODE_C5453B
	cmp.w #$FFFC
	beq CODE_C5453B
	lda.w #$0005
	sta.b $7F
CODE_C54515:						; from CODE_C54515
	ldy.b $7F
	lda.b [$73],y
	and.w #$00FF
	sta.b $9F
	lda.b $83
	and.w #$00FF
	cmp.b $9F
	beq CODE_C5453B
	dec.b $7F
	bpl CODE_C54515
	ldy.b $8F
	sep #$20
	lda.b $83
	sta.b [$73],y
	rep #$20
	lda.b $83
	and.w #$00FF
	rtl
CODE_C5453B:						; from CODE_C544F5, CODE_C54503, CODE_C54515
	lda.w #$0000
	sta.b $83
	rtl
CODE_C54541:						; called from other segments
	pei ($83)
	stz.b $6B
	lda.w $1020,x
	beq CODE_C5454E
	inc.b $6B
	inc.b $6B
CODE_C5454E:						; from CODE_C54541
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0001
	beq CODE_C54568
	and.w #$FFFE
	sta.w $12FF,y
	lda.w #$FFFF
	sta.w $184C,y
	jsl.l CODE_C54070
CODE_C54568:						; from CODE_C5454E
	pla
	sta.b $83
	stz.b $87
	bit.w #$4000
	bne CODE_C545B8
	inc.b $87
	bit.w #$8000
	bne CODE_C545B8
	inc.b $87
	bit.w #$0080
	bne CODE_C545B8
	bit.w #$2000
	bne CODE_C54597
	lda.w $0D60,x
	bit.w #$0008
	beq CODE_C54596
	lda.w $1000,x
	bne CODE_C54596
	jml.l doplayeracc
CODE_C54596:						; from CODE_C54568
	rtl
CODE_C54597:						; from CODE_C54568
	lda.w $0D60,x
	ora.w #$0008
	sta.w $0D60,x
	jsl.l loadTeamStruct
	ldy.b $6B
	lda.w $12FF,y
	and.w #$FFF7
	sta.w $12FF,y
	lda.w #$FFFF
	sta.w $184C,y
	jmp.w CODE_C54B60
CODE_C545B8:						; from CODE_C54568
	jsl.l CODE_C54DA4
	bmi CODE_C545C6
	lda.w $10F3
	bne CODE_C545C6
	jmp.w CODE_C54B60
CODE_C545C6:						; from CODE_C545B8
	rtl
CODE_C545C7:						; asstab entry 12: an assignment routine
	lda.w $0AE0,x
	cmp.w #$0064
	bne CODE_C545D2
	jmp.w CODE_C546D7
CODE_C545D2:						; from CODE_C545C7
	jsl.l check4bench
	lda.w $0D60,x
	bit.w #$4000
	beq CODE_C545E2
	jml.l assexit
CODE_C545E2:						; from CODE_C545D2
	bit.w #$0002
	beq CODE_C54613
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
	lda.w #$0050
	sta.b $7F
	lda.w $1020,x
	bne CODE_C54605
	lda.w #$FFB0
	sta.b $7F
CODE_C54605:						; from CODE_C545E2
	lda.b $7F
	sta.w $0B40,x
	lda.w #$FF5D
	sta.w $0B20,x
	stz.w $0AE0,x
CODE_C54613:						; from CODE_C545E2
	lda.w $0D40,x
	cmp.w $0DC0,x
	bne CODE_C5461E
	jmp.w CODE_C5472B
CODE_C5461E:						; from CODE_C54613
	lda.w $0A20,x
	bne CODE_C5462C
	lda.w $05CC,x
	ora.w #$0003
	sta.w $05CC,x
CODE_C5462C:						; from CODE_C5461E
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bmi CODE_C5463A
	jmp.w CODE_C54706
CODE_C5463A:						; from CODE_C5462C
	lda.w $0AE0,x
	adc.w #$0008
	sta.w $0AE0,x
	lda.w $0896,x
	sec
	sbc.w $0B40,x
	bit.w #$8000
	beq CODE_C54653
	eor.w #$FFFF
	inc a
CODE_C54653:						; from CODE_C5463A
	cmp.w #$0029
	bcc CODE_C5465B
	jmp.w CODE_C54706
CODE_C5465B:						; from CODE_C54653
	lda.w $0814,x
	sec
	sbc.w $0B20,x
	sta.b $7F
	sec
	sbc.w #$0020
	beq CODE_C5466F
	bmi CODE_C5466F
	jmp.w CODE_C54706
CODE_C5466F:						; from CODE_C5465B
	lda.w #$1958
	ldy.w $0A20,x
	bne CODE_C5467A
	lda.w #$121E
CODE_C5467A:						; from CODE_C5466F
	jsl.l SetSPAFromA
	lda.w #$0001
	sta.w $1080,x
	lda.w $0C40,x
	cmp.w #$0004
	beq CODE_C54693
	inc a
	and.w #$0007
	sta.w $0C40,x
CODE_C54693:						; from CODE_C5467A
	stz.w $09C0,x
	lda.w #$F800
	sta.w $09A0,x
	lda.b $7F
	sec
	sbc.w #$0010
	beq CODE_C546A6
	bpl CODE_C546D6
CODE_C546A6:						; from CODE_C54693
	stz.w $09A0,x
	lda.w $0C40,x
	cmp.w #$0004
	bne CODE_C546D6
	lda.w #$FF65
	sta.w $0814,x
	lda.w #$0002
	sta.w $0C40,x
	lda.w $08E0,x
	ora.w #$0800
	sta.w $08E0,x
	lda.w #$18BE
	jsl.l SetSPAFromA
	lda.w #$0064
	sta.w $0AE0,x
	sta.w $1000,x
CODE_C546D6:						; from CODE_C54706, CODE_C54693, CODE_C546A6
	rtl
CODE_C546D7:						; from CODE_C545C7
	lda.w $0DC0,x
	asl a
	sta.b $7F
	stz.b $63
	lda.w $1020,x
	beq CODE_C546E9
	lda.w #$0002
	sta.b $63
CODE_C546E9:						; from CODE_C546D7
	lda.b $63
	beq CODE_C546F0
	lda.w #$0034
CODE_C546F0:						; from CODE_C546E9
	clc
	adc.b $7F
	tay
	lda.w #$FFFE
	sta.w $1373,y
	lda.w $0D40,x
	sta.b $8B
	jsl.l CODE_C54734
	jmp.w CODE_C53C46
CODE_C54706:						; from CODE_C5462C, CODE_C54653, CODE_C5465B
	lda.w $1080,x
	bne CODE_C546D6
	lda.w $0D60,x
	bit.w #$4008
	bne CODE_C546D6
	lda.w $0B20,x
	sta.b $7F
	lda.w $0B40,x
	sta.b $83
	lda.w #$00C4
	sta.b $65
	lda.w #$342A
	sta.b $63
	jml.l CODE_C45950
CODE_C5472B:						; from CODE_C54613
	lda.w $0D60,x
	and.w #$EFFF
	sta.w $0D60,x
CODE_C54734:						; from CODE_C546F0 and other segments
	lda.w $0D20,x
	sta.b $7F
	sta.w $0A20,x
	jsl.l Setplass
	lda.w #$FFFF
	sta.w $0D40,x
	sta.w $0D20,x
	rtl
CODE_C5474A:						; asstab entry 10: an assignment routine
	lda.w $1000,x
	bne CODE_C5479D
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C5479E
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $09A0,x
	stz.w $09C0,x
	stz.w $05CC,x
	txa
	lsr a
	sec
	sbc.w #$0006
	bmi CODE_C5476F
	inc a
CODE_C5476F:						; from CODE_C5474A
	phx
	tax
	lda.w #$000E
	jsl.l Mul16x8XS
	plx
	lda.b $34
	sta.w $0896,x
	lda.w $08E0,x
	ora.w #$0800
	sta.w $08E0,x
	lda.w #$FF65
	sta.w $0814,x
	lda.w #$0002
	sta.w $0C40,x
	sta.w $1000,x
	lda.w #$18EC
	jml.l SetSPAUpdate
CODE_C5479D:						; from CODE_C5474A
	rtl
CODE_C5479E:						; from CODE_C5474A
	lda.w #$0004
	sta.w $0C40,x
	lda.w $0D60,x
	and.w #$6FFF
	sta.w $0D60,x
	stz.w $1080,x
	stz.w $0C80,x
	lda.w #$1000
	sta.w $09A0,x
	lda.w $0FC0,x
	beq CODE_C547C7
	lda.w $08E0,x
	and.w #$F7FF
	sta.w $08E0,x
CODE_C547C7:						; from CODE_C5479E
	jml.l assexit
CODE_C547CB:						; from CODE_C54982 and other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($63)
	pei ($65)
	lda.w #$0003
	sta.b $7F
	ldy.b $6B
	lda.w $12C7,y
	ldy.b $67
	cmp.w $12C7,y
	beq CODE_C54828
	bpl CODE_C547F2
	inc.b $7F
	inc.b $7F
CODE_C547F2:						; from CODE_C547CB
	lda.b $7F
	pha
	inc a
	jsr.w CODE_C54CB9
	sta.b $83
	lda.b $01,s
	jsr.w CODE_C54CB9
	sec
	sbc.b $7F
	bpl CODE_C54809
	pla
	inc a
	bra CODE_C5480A
CODE_C54809:						; from CODE_C547F2
	pla
CODE_C5480A:						; from CODE_C547F2
	ldy.b $6B
	sta.w $12B7,y
CODE_C5480F:						; from CODE_C5490E, CODE_C54878
	pla
	sta.b $65
	pla
	sta.b $63
	pla
	sta.b $89
	pla
	sta.b $87
	pla
	sta.b $85
	pla
	sta.b $83
	pla
	sta.b $81
	pla
	sta.b $7F
	rtl
CODE_C54828:						; from CODE_C547CB
	ldy.b $6B
	beq CODE_C5482F
	jmp.w CODE_C548C1
CODE_C5482F:						; from CODE_C54828
	lda.w $186E
	cmp.w #$0002
	bne CODE_C5483F
	lda.w $1511,y
	bmi CODE_C5483F
	jmp.w CODE_C548C1
CODE_C5483F:						; from CODE_C5482F
	lda.w #$0002
	sta.b $83
	lda.w #$00C5
	sta.b $65
	lda.w #$4897
	sta.b $63
	lda.w $114B
	cmp.w #$0002
	bne CODE_C54878
	lda.w $12AB,y
	ldy.b $67
	cmp.w $12AB,y
	beq CODE_C54878
	php
	lda.w #$00C5
	sta.b $65
	lda.w #$48A5
	sta.b $63
	plp
	bpl CODE_C54878
	lda.w #$00C5
	sta.b $65
	lda.w #$48B3
	sta.b $63
CODE_C54878:						; from CODE_C5483F
	ldy.b $67
	lda.w $12B7,y
	asl a
	sta.b $83
	tay
	lda.b [$63],y
	jsr.w CODE_C54CB9
	cmp.w #$0C01
	bcc CODE_C548C1
	ldy.b $83
	lda.b [$63],y
	ldy.b $6B
	sta.w $12B7,y
	jmp.w CODE_C5480F
DATA8_C54897:						; not traced: data between routines
	db $00,$00,$01,$00,$02,$00,$00,$00,$01,$00,$00,$00,$01,$00,$02,$00
	db $00,$00,$01,$00,$02,$00,$00,$00,$02,$00,$00,$00,$00,$00,$01,$00
	db $00,$00,$00,$00,$01,$00,$00,$00,$01,$00
CODE_C548C1:						; from CODE_C54828, CODE_C5482F, CODE_C54878
	lda.w #$0002
	sta.b $83
	lda.w #$00C5
	sta.b $65
	lda.w #$491C
	sta.b $63
	lda.w $114B
	cmp.w #$0002
	bne CODE_C548FC
	ldy.b $6B
	lda.w $12AB,y
	ldy.b $67
	cmp.w $12AB,y
	beq CODE_C548FC
	php
	lda.w #$00C5
	sta.b $65
	lda.w #$4922
	sta.b $63
	plp
	bpl CODE_C548FC
	lda.w #$00C5
	sta.b $65
	lda.w #$4928
	sta.b $63
CODE_C548FC:						; from CODE_C548C1, CODE_C548FC
	lda.b [$63]
	inc.b $63
	inc.b $63
	jsr.w CODE_C54CB9
	cmp.w #$0F34
	bcs CODE_C5490E
	dec.b $83
	bpl CODE_C548FC
CODE_C5490E:						; from CODE_C548FC
	dec.b $63
	dec.b $63
	ldy.b $6B
	lda.b [$63]
	sta.w $12B7,y
	jmp.w CODE_C5480F
DATA8_C5491C:						; not traced: data between routines
	db $00,$00,$01,$00,$02,$00,$00,$00,$02,$00,$01,$00,$00,$00,$01,$00
	db $00,$00
CODE_C5492E:						; called from other segments
	lda.w $186E
	cmp.w #$0002
	beq CODE_C549A7
	lda.w $08B2
	sta.b $7F
	lda.w $0FE0,x
	bne CODE_C54948
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C54948:						; from CODE_C5492E
	lda.b $7F
	bmi CODE_C549A7
	sec
	sbc.w #$005C
	bpl CODE_C549A7
	lda.w $04B0
	and.w #$0003
	bne CODE_C549A7
	phy
	ldy.w #$0000
	lda.w $1020,x
	beq CODE_C54966
	ldy.w #$0002
CODE_C54966:						; from CODE_C54948
	lda.w $12FF,y
	ply
	bit.w #$0008
	bne CODE_C549A7
	stz.b $6B
	lda.w #$0002
	sta.b $67
	lda.w $1020,x
	beq CODE_C54982
	stz.b $67
	lda.w #$0002
	sta.b $6B
CODE_C54982:						; from CODE_C54966
	jsl.l CODE_C54A73
	lda.b $7F
	cmp.w #$0C01
	bcs CODE_C549A7
	lda.w $1157
	bne CODE_C549A7
	lda.w $186E
	beq CODE_C549A7
	jsl.l CODE_C547CB
	jsl.l setpersonel
	jsl.l CODE_C5111A
	jml.l CompShoot
CODE_C549A7:						; from CODE_C5492E, CODE_C54948, CODE_C54966, CODE_C54982
	rtl
check4bench:						; from CODE_C545D2 and other segments
	lda.w $0D60,x
	bit.w #$4000
	bne CODE_C549EA
	lda.w $0D20,x
	bpl CODE_C549BA
	lda.w $0D40,x
	bmi CODE_C549EA
CODE_C549BA:						; from check4bench
	lda.w $0D40,x
	cmp.w $0DC0,x
	beq CODE_C549EB
	lda.w $0644,x
	cmp.w #$000C
	beq CODE_C549EA
	cpx.w $05A0
	beq CODE_C549EA
	sep #$20
	pla
	rep #$30
	pla
	lda.w $0D60,x
	ora.w #$1000
	sta.w $0D60,x
	stz.w $0AE0,x
	lda.w #$000C
	sta.b $7F
	jml.l assreplace
CODE_C549EA:						; from check4bench, CODE_C549BA
	rtl
CODE_C549EB:						; from CODE_C549BA
	sep #$20
	pla
	rep #$30
	pla
	lda.w $0D60,x
	and.w #$EFFF
	sta.w $0D60,x
	stz.w $1080,x
	lda.w #$FFFF
	sta.w $0D40,x
	sta.w $0D20,x
	lda.w $0A20,x
	sta.b $7F
	jmp.w Setplass
getpde:								; from CODE_C54A47 and other segments
	lda.w $0DC0,x
	and.w #$00FF
	asl a
	sta.b $83
	lda.w $1020,x
	beq CODE_C54A1F
	lda.w #$0002
CODE_C54A1F:						; from getpde
	sta.b $6B
	beq CODE_C54A26
	lda.w #$0034
CODE_C54A26:						; from CODE_C54A1F
	adc.b $83
	tay
	lda.w $130B,y
	sta.b $7F
	rtl
CODE_C54A2F:						; called from other segments
	lda.b $6B
	beq CODE_C54A36
	lda.w #$0034
CODE_C54A36:						; from CODE_C54A2F
	clc
	adc.b $83
	tay
	lda.b $7F
	bpl CODE_C54A43
	lda.w #$0000
	sta.b $7F
CODE_C54A43:						; from CODE_C54A36
	sta.w $130B,y
	rtl
CODE_C54A47:						; called from other segments
	pha
	pei ($83)
	pei ($6B)
	ldx.b $63
	jsl.l getpde
	pla
	sta.b $6B
	pla
	sta.b $83
	pla
	ldx.b $7F
	jsl.l Mul16S
	lda.b $36
	asl.b $34
	rol a
	asl.b $34
	rol a
	asl.b $34
	rol a
	asl.b $34
	rol a
	sta.b $7F
	ldx.b $6F
	clc
	rtl
CODE_C54A73:						; from CODE_C54982 and other segments
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	pei ($63)
	pei ($65)
	stz.b $7F
	stz.b $83
	lda.w #$0005
	sta.b $87
	sta.b $87
	ldy.b $6B
	lda.w $1283,y
	sta.b $63
CODE_C54A95:						; from CODE_C54ABA
	ldy.b $63
	lda.w $0A20,y
	beq CODE_C54ABA
	bmi CODE_C54ABA
	lda.w $0DC0,y
	and.w #$00FF
	asl a
	sta.b $8B
	lda.b $6B
	beq CODE_C54AAE
	lda.w #$0034
CODE_C54AAE:						; from CODE_C54A95
	adc.b $8B
	tay
	lda.w $130B,y
	adc.b $7F
	sta.b $7F
	inc.b $83
CODE_C54ABA:						; from CODE_C54A95
	inc.b $63
	inc.b $63
	dec.b $87
	bpl CODE_C54A95
	lda.b $83
	beq CODE_C54AD6
	sta.b $30
	phx
	lda.b $7F
	sta.b $34
	jsl.l Div16U
	lda.b $2C
	sta.b $7F
	plx
CODE_C54AD6:						; from CODE_C54ABA
	pla
	sta.b $65
	pla
	sta.b $63
	pla
	sta.b $8D
	pla
	sta.b $8B
	pla
	sta.b $89
	pla
	sta.b $87
	pla
	sta.b $85
	pla
	sta.b $83
	rtl
CODE_C54AEF:						; from CODE_C54DFB and other segments
	ldy.w #$0032
	ldx.w #$0019
	lda.b $6B
	beq CODE_C54AFC
	ldy.w #$0066
CODE_C54AFC:						; from CODE_C54AEF, CODE_C54B15
	lda.w #$1000
	sta.w $130B,y
	lda.w $1373,y
	cmp.w #$FFFD
	bne CODE_C54B15
	cmp.w #$FFFC
	bne CODE_C54B15
	lda.w #$FFFE
	sta.w $1373,y
CODE_C54B15:						; from CODE_C54AFC
	dey
	dey
	dex
	bpl CODE_C54AFC
	rtl
RestoreBenchEnergy:					; called from other segments
	lda.w $186E
	beq CODE_C54B5F
	stz.b $6B
	jsl.l CODE_C54B2B
	lda.w #$0002
	sta.b $6B
CODE_C54B2B:						; from RestoreBenchEnergy and other segments
	lda.w #$0032
	sta.b $7F
CODE_C54B30:						; from CODE_C54B59
	lda.b $6B
	beq CODE_C54B37
	lda.w #$0034
CODE_C54B37:						; from CODE_C54B30
	clc
	adc.b $7F
	tay
	lda.w $1373,y
	cmp.w #$FFFE
	bne CODE_C54B59
	lda.w $130B,y
	clc
	adc.w #$000A
	sta.w $130B,y
	sec
	sbc.w #$1000
	bmi CODE_C54B59
	lda.w #$1000
	sta.w $130B,y
CODE_C54B59:						; from CODE_C54B37
	dec.b $7F
	dec.b $7F
	bpl CODE_C54B30
CODE_C54B5F:						; from RestoreBenchEnergy
	rtl
CODE_C54B60:						; from CODE_C54BAF, CODE_C54BCA, CODE_C545B8, ...
	jsr.w CODE_C54114
	pha
	tay
	jsl.l CODE_C4CEDB
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	ldx.w #$0006
CODE_C54B74:						; from CODE_C54B74
	pea.w $000B
	pea.w $0000
	phy
	pea.w $1808
	pea.w $00C5
	pea.w $8942
	tya
	clc
	adc.w #$0020
	tay
	dex
	bne CODE_C54B74
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	jsl.l CODE_C4CEDB
	pla
	cmp.w #$5AB5
	bcc CODE_C54BA3
	jsl.l CODE_C539D7
CODE_C54BA3:						; from CODE_C54B74
	jsl.l CODE_C51397
	jsl.l CODE_C4CEDB
	jml.l CODE_C5111A
CODE_C54BAF:						; called from other segments
	lda.w $186E
	beq CODE_C54BE7
	pei ($6B)
	lda.w $12FF
	bit.w #$0008
	beq CODE_C54BCA
	and.w #$FFF7
	sta.w $12FF
	stz.b $6B
	jsl.l CODE_C54B60
CODE_C54BCA:						; from CODE_C54BAF
	lda.w $1301
	bit.w #$0008
	beq CODE_C54BE1
	and.w #$FFF7
	sta.w $1301
	lda.w #$0002
	sta.b $6B
	jsl.l CODE_C54B60
CODE_C54BE1:						; from CODE_C54BCA
	pla
	sta.b $6B
	inc.w $18AA
CODE_C54BE7:						; from CODE_C54BAF
	rtl
CODE_C54BE8:						; no caller found (not traced)
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	pei ($67)
	pei ($69)
	lda.w #$2000
	sta.w $07D2
	lda.b $7F
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	cmp.w #$0020
	bcc CODE_C54C13
	lda.w #$001F
CODE_C54C13:						; from CODE_C54BE8
	sta.b $7F
	ldy.w #$0002
	lda.w #$0006
	sta.w $04F5
	lda.w #$0003
	sta.b $8B
CODE_C54C23:						; from CODE_C54C45
	lda.w #$FFFF
	sta.b $87
	lda.b $7F
	bmi CODE_C54C38
	sta.b $87
	cmp.w #$0008
	bcc CODE_C54C38
	lda.w #$0007
	sta.b $87
CODE_C54C38:						; from CODE_C54C23
	lda.b $87
	sec
	adc.b $83
	and.w #$00FF
	bne CODE_C54C45
	lda.w #$0020
CODE_C54C45:						; from CODE_C54C38
	sta.w $04F5,y
	iny
	lda.b $7F
	sec
	sbc.w #$0008
	sta.b $7F
	dec.b $8B
	bpl CODE_C54C23
	lda.b $83
	beq CODE_C54C5F
	lda.w #$0C00
	tsb.w $07D2
CODE_C54C5F:						; from CODE_C54C45
	stz.b $69
	lda.w #$04F5
	sta.b $67
	lda.w $07D4
	sec
	sbc.w #$000B
	sta.w $07D4
	lda.w #$4000
	tsb.w $07D2
	stz.b $69
	lda.w #$04F5
	sta.b $67
	sep #$20
	lda.w $04FA
	ldy.w $04F7
	sty.w $04FA
	sta.w $04F7
	rep #$30
	lda.w $04F8
	xba
	sta.w $04F8
	lda.w #$4000
	trb.w $07D2
	pla
	sta.b $69
	pla
	sta.b $67
	pla
	sta.b $8D
	pla
	sta.b $8B
	pla
	sta.b $89
	pla
	sta.b $87
	pla
	sta.b $85
	pla
	sta.b $83
	pla
	sta.b $81
	pla
	sta.b $7F
	rtl
CODE_C54CB9:						; from CODE_C547F2, CODE_C54D03, CODE_C548FC, CODE_C54878
	pei ($8F)
	phx
	inc a
	asl a
	asl a
	asl a
	adc.w #$2DC9
	ldy.b $6B
	beq CODE_C54CCA
	adc.w #$043E
CODE_C54CCA:						; from CODE_C54CB9
	tax
	stz.b $34
	ldy.b $6B
	lda.w $12C7,y
	dec a
	sta.b $30
CODE_C54CD5:						; from CODE_C54CEA
	sta.b $8F
	txa
	clc
	adc.b $8F
	tay
	lda.w $006C,y
	and.w #$00FF
	asl a
	ldy.b $6B
	beq CODE_C54CEA
	adc.w #$0034
CODE_C54CEA:						; from CODE_C54CD5
	tay
	lda.w $1309,y
	clc
	adc.b $34
	sta.b $34
	lda.b $8F
	dec a
	bne CODE_C54CD5
	jsl.l Div16x8U
	lda.b $2C
	plx
	ply
	sty.b $8F
	rts
CODE_C54D03:						; from CODE_C540C3
	jsr.w CODE_C54CB9
	cmp.w #$0100
	bcs CODE_C54D0E
	lda.w #$0100
CODE_C54D0E:						; from CODE_C54D03
	cmp.w #$0FFF
	bcc CODE_C54D16
	lda.w #$0FFF
CODE_C54D16:						; from CODE_C54D0E
	sta.b $85
	asl a
	adc.b $85
	sta.b $85
	xba
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$0003
	jsl.l CODE_C4C561
	pha
	tay
	lda.w #$A0A0
	sta.w $0000,y
	sta.w $0001,y
	jmp (DATA8_C54D3A,x)
DATA8_C54D3A:						; jump table: the routine for each index
	dw CODE_C54D69,CODE_C54D55,CODE_C54D40
CODE_C54D40:						; from DATA8_C54D3A
	lda.w #$8888
	sta.w $0000,y
	lda.w #$0080
	sta.b $83
	lda.b $85
	sec
	sbc.w #$2000
	iny
	iny
	bra CODE_C54D70
CODE_C54D55:						; from DATA8_C54D3A
	lda.w #$0091
	sta.w $0000,y
	lda.w #$0089
	sta.b $83
	lda.b $85
	sec
	sbc.w #$1000
	iny
	bra CODE_C54D70
CODE_C54D69:						; from DATA8_C54D3A
	lda.w #$0092
	sta.b $83
	lda.b $85
CODE_C54D70:						; from CODE_C54D55, CODE_C54D40
	and.w #$FE00
	xba
	lsr a
	adc.b $83
	sep #$20
	sta.w $0000,y
	rep #$20
	ply
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	pea.w $0003
	pea.w $0000
	lda.b $7F
	clc
	adc.w #$0006
	pha
	pea.w $1800
	pea.w $007E
	phy
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	rts
CODE_C54DA4:						; from CODE_C545B8 and other segments
	ldx.b $6F
	ldy.b $6B
	lda.b $87
	sta.w $1307,y
	jsr.w CODE_C54155
	bmi CODE_C54DDE
	sta.b $7F
	lda.w $0D60,x
	ora.w #$0008
	sta.w $0D60,x
	jsl.l loadTeamStruct
	ldy.b $6B
	lda.w $12FF,y
	and.w #$FFF7
	sta.w $12FF,y
	lda.b $7F
	sta.w $12B7,y
	lda.w #$FFFF
	sta.w $184C,y
	jsl.l setpersonel
	lda.w #$0000
CODE_C54DDE:						; from CODE_C54DA4
	rtl
CODE_C54DDF:						; called from other segments
	jsl.l ResetBench
	lda.w #$0001
	sta.w $234C
	stz.b $6B
	lda.w #$0002
	sta.b $6F
	jsl.l CODE_C54DFB
	stz.b $6F
	lda.w #$0002
	sta.b $6B
CODE_C54DFB:						; from CODE_C54DDF and other segments
	jsl.l CODE_C54AEF
	ldx.b $6F
	ldy.b $6B
	stz.w $12B7,x
	lda.w $186E
	beq CODE_C54E26
	lda.w $12C7,x
	sec
	sbc.w $12C7,y
	sta.b $7F
	beq CODE_C54E26
	lda.w #$0003
	sta.w $12B7,x
	lda.b $7F
	bpl CODE_C54E26
	lda.w #$0005
	sta.w $12B7,x
CODE_C54E26:						; from CODE_C54DFB
	rtl
CODE_C54E27:						; called from other segments
	ldx.w #$026F
CODE_C54E2A:						; from CODE_C54E53
	lda.w #$000E
	jsl.l CODE_C37EAA
	cmp.w #$000D
	bcc CODE_C54E39
	lda.w #$000C
CODE_C54E39:						; from CODE_C54E2A
	tay
	lda.w $04B0
	and.w #$0010
	bne CODE_C54E4D
	sep #$20
	tya
	eor.b #$FF
	inc a
	sta.w $1543,x
	bra CODE_C54E53
CODE_C54E4D:						; from CODE_C54E39
	sep #$20
	tya
	sta.w $1543,x
CODE_C54E53:						; from CODE_C54E39
	rep #$20
	dex
	bpl CODE_C54E2A
	rtl
GetTeamLines:						; from CODE_C543AD, CODE_C54471 and other segments
	lda.w #$007E
	sta.b $71
	lda.b $6B
	beq CODE_C54E67
	lda.w #$1813
	bra CODE_C54E6A
CODE_C54E67:						; from GetTeamLines
	lda.w #$17DB
CODE_C54E6A:						; from GetTeamLines
	sta.b $6F
	rtl
CODE_C54E6D:						; called from other segments
	jsl.l CODE_CF039E
	jsl.l FadeOutWait
	stz.w $18F8
	lda.w $17D1
	bne CODE_C54E82
	lda.w $153F
	beq CODE_C54E9A
CODE_C54E82:						; from CODE_C54E6D
	lda.w #$05D7
	ldx.w #$00CF
	jsl.l CODE_CF0134
	lda.w #$00A5
	jsl.l CODE_CF040B
	jsl.l CODE_CF03D0
	dec.w $18F8
CODE_C54E9A:						; from CODE_C54E6D
	jsr.w CODE_C5503C
	ldx.w #$0002
	jsr.w CODE_C54F94
	lda.w #$0001
	sta.w $059E
CODE_C54EA9:						; from CODE_C54EC9
	inc.w TransfersReady
CODE_C54EAC:						; from CODE_C54EAC
	lda.w TransfersReady
	bne CODE_C54EAC
	lda.w $14F5
	ora.w $14F7
	bne CODE_C54EC5
	stz.w $1525
	jsl.l CODE_C36C49
	dec.w $1525
	bra CODE_C54EC9
CODE_C54EC5:						; from CODE_C54EAC
	jsl.l CODE_C36C49
CODE_C54EC9:						; from CODE_C54EAC
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C54EA9
	jsr.w CODE_C54F05
	lda.w $058D
	bit.w #$3000
	beq CODE_C54EA9
	lda.w $18EE
	sta.w $18E0
	sta.b $08
	stz.b $22
	ldx.w $18F0
	jsl.l CODE_C5E596
	jmp.w CODE_C55513

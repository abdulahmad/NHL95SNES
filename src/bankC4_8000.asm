; Segment bankC4_8000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C47FB5
CODE_C47FB5:						; called from other segments
	lda.w #$0020
	trb.w $10F7
	lda.w $10F3
	beq CODE_C47FC3
	jmp.w CODE_C48050
CODE_C47FC3:						; from CODE_C47FB5
	lda.w $1157
	beq CODE_C47FCB
	jmp.w CODE_C48050
CODE_C47FCB:						; from CODE_C47FC3
	lda.w $113D
	ldy.b $9B
	dey
	beq CODE_C47FD4
	dec a
CODE_C47FD4:						; from CODE_C47FCB
	dec a
	sta.w $113D
	bpl CODE_C48050
	clc
	adc.w #$0018
	sta.w $113D
	lda.w #$0020
	tsb.w $10F7
	jsl.l CODE_C47200
	jsl.l CountPowerPlayTime
	stz.b $6B
	jsl.l CODE_C47FFA
	lda.w #$0002
	sta.b $6B
CODE_C47FFA:						; from CODE_C47FD4 and other segments
	lda.b $6B
	beq CODE_C48001
	lda.w #$001A
CODE_C48001:						; from CODE_C47FFA
	sta.b $63
	stz.b $69
	lda.w #$04F5
	sta.b $67
	lda.w #$0002
	sta.b $83
	sta.b $8B
CODE_C48011:						; from CODE_C48029, CODE_C4804E, CODE_C48090
	ldy.b $63
	lda.w $13DB,y
	inc.b $63
	and.w #$00FF
	sta.b $7F
	bit.w #$0080
	bne CODE_C48051
	lda.b $6B
	beq CODE_C48029
	lda.w #$0034
CODE_C48029:						; from CODE_C48011
	clc
	adc.b $7F
	tay
	lda.w $1373,y
	bit.w #$4000
	bne CODE_C48090
	dec.b $83
	bmi CODE_C48011
	lda.b $7F
	sta.b [$67]
	inc.b $67
	inc.b $67
	lda.w $1373,y
	dec a
	sta.w $1373,y
	bne CODE_C4804E
	jsl.l CODE_C45A9F
CODE_C4804E:						; from CODE_C48029
	bra CODE_C48011
CODE_C48050:						; from CODE_C47FB5, CODE_C4807A, CODE_C47FC3, CODE_C47FD4, ...
	rtl
CODE_C48051:						; from CODE_C48011
	lda.w $04F5
	sta.b $7F
	lda.b $83
	cmp.w #$0001
	beq CODE_C48073
	lda.b $83
	bne CODE_C48067
	jsl.l CODE_C48073
	bra CODE_C4806E
CODE_C48067:						; from CODE_C48051
	lda.b $83
	cmp.w #$FFFF
	bne CODE_C48050
CODE_C4806E:						; from CODE_C48051
	lda.w $04F7
	sta.b $7F
CODE_C48073:						; from CODE_C48051 and other segments
	lda.b $6B
	beq CODE_C4807A
	lda.w #$0034
CODE_C4807A:						; from CODE_C48073
	clc
	adc.b $7F
	tay
	lda.w $1373,y
	cmp.w #$0006
	bpl CODE_C48050
	lda.w $1373,y
	bne CODE_C4808F
	jsl.l CODE_C480E4
CODE_C4808F:						; from CODE_C4807A
	rtl
CODE_C48090:						; from CODE_C48029
	dec a
	sta.w $1373,y
	bit.w #$0800
	bne CODE_C4809C
	jmp.w CODE_C48011
CODE_C4809C:						; from CODE_C48090
	bit.w #$1000
	bne CODE_C480AB
	lda.w #$1000
	sta.w $1373,y
	jml.l CODE_C45A9F
CODE_C480AB:						; from CODE_C4809C
	lda.w #$0000
	sta.w $1373,y
	jml.l CODE_C45A9F
PenShotChk:							; called from other segments
	lda.w $10F1
	bit.w #$0010
	bne CODE_C480E0
	lda.b $6B
	cmp.w $05A0
	bne CODE_C480E0
	lda.w $18AE
	bne CODE_C480CC
	jmp.w CODE_C480E0
CODE_C480CC:						; from PenShotChk
	jsl.l CheckBreakaway
	lda.w $1155
	sta.w $18AE
	bne CODE_C480DB
	jmp.w CODE_C480E0
CODE_C480DB:						; from CODE_C480CC
	lda.w #$FFFF
	bra CODE_C480E3
CODE_C480E0:						; from PenShotChk, CODE_C480CC
	lda.w #$0000
CODE_C480E3:						; from CODE_C480DB
	rtl
CODE_C480E4:						; from CODE_C4807A and other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	ldy.b $6B
	ldx.w $1283,y
	dex
	dex
CODE_C4810B:						; from CODE_C4810B
	inx
	inx
	lda.w $0A20,x
	bpl CODE_C4810B
	lda.b $7F
	lsr a
	sta.b $8B
	ldy.b $6B
	lda.w $12C7,y
	sta.b $83
	inc a
	sta.w $12C7,y
	lda.w #$0001
	tsb.w $12FF
	tsb.w $1301
	lda.w #$00C0
	sta.b $65
	lda.w #$9B2A
	sta.b $63
	lda.w $12CB,y
	bpl CODE_C4813C
	inc.b $63
CODE_C4813C:						; from CODE_C4810B
	ldy.b $83
	lda.b [$63],y
	and.w #$00FF
	sta.w $0A20,x
	stx.b $6F
	jsl.l Setplass
	jsl.l CODE_C53C46
	lda.w $0D60,x
	ora.w #$1000
	sta.w $0D60,x
	pla
	sta.b $71
	pla
	sta.b $6F
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
CODE_C4818C:						; called from other segments
	phx
	ldx.w #$003E
CODE_C48190:						; from CODE_C48190
	stz.w $10F9,x
	dex
	dex
	bpl CODE_C48190
	plx
	rtl
checkagr:							; called from other segments
	lda.w #$0014
	sec
	sbc.w $0F60,x
	asl a
	asl a
	asl a
	asl a
	sta.b $7F
	lda.w $14F9,x
	bmi CODE_C481AD
	asl.b $7F
CODE_C481AD:						; from checkagr
	lda.w $0814,x
	sec
	sbc.w $0830
	cmp.w #$FFD7
	bmi CODE_C481D1
	cmp.w #$0029
	bpl CODE_C481D1
	lda.w $0896,x
	sec
	sbc.w $08B2
	cmp.w #$FFD7
	bmi CODE_C481D1
	cmp.w #$0029
	bpl CODE_C481D1
	lsr.b $7F
CODE_C481D1:						; from CODE_C481AD
	jml.l CODE_C37EBF
CODE_C481D5:						; called from other segments
	lda.w $234A
	beq CODE_C481DD
	stz.w $234A
CODE_C481DD:						; from CODE_C481D5
	ldx.b $7F
	bpl CODE_C481E2
	rtl
CODE_C481E2:						; from CODE_C481DD
	lda.l DATA8_C34499,x
	tax
	lda.l DATA8_C3449B,x
	and.w #$00FF
	dec a
	beq CODE_C48240
	phx
	ldx.w $2CF5
	beq CODE_C48218
	jsl.l CODE_C54BAF
	ldx.w #$0012
	ldy.w #$0003
	lda.w #$584A
	jsl.l CODE_C58C36
	jsl.l CODE_C533E1
	ldy.w #$588B
	jsl.l QueueVRAMDMALen
	ldy.w #$586B
	bra CODE_C4822E
CODE_C48218:						; from CODE_C481E2
	tax
	inx
	inx
	inx
	txa
	asl a
	sta.w $1541
	ldy.w #$0002
	lda.w #$5941
	jsl.l CODE_C58C36
	ldy.w #$5962
CODE_C4822E:						; from CODE_C481E2
	pla
	clc
	adc.w #$449B
	ldx.w #$00C3
	jsl.l QueueVRAMDMALen
	lda.w #$0001
	sta.w $234A
CODE_C48240:						; from CODE_C481E2
	rtl
CODE_C48241:						; called from other segments
	dec.w $1141
	bne CODE_C48249
	jmp.w CODE_C482D9
CODE_C48249:						; from CODE_C48241
	rtl
CODE_C4824A:						; called from other segments
	ldy.b $6B
	lda.w $0D60,y
	ora.w #$1000
	sta.w $0D60,y
	lda.l $7E24CA
	clc
	adc.w #$012C
	sta.l $7E24CA
	lda.w #$003C
	sta.b $5B
	lda.w #$000A
	jsl.l CODE_CF040B
	ldy.b $6B
	lda.w $0814,y
	sta.w $080A
	lda.w $0896,y
	sta.w $080C
	lda.w #$0040
	tsb.w $10F5
	stz.b $83
	stz.b $63
	lda.w $1020,y
	beq CODE_C48294
	lda.w #$8000
	sta.b $83
	lda.w #$0002
	sta.b $63
CODE_C48294:						; from CODE_C4824A
	lda.w $0DC0,y
	and.w #$00FF
	ora.b $83
	sta.w $1153
	and.w #$00FF
	bit.w #$0080
	beq CODE_C482AA
	ora.w #$FF00
CODE_C482AA:						; from CODE_C48294
	asl a
	sta.b $83
	lda.b $63
	beq CODE_C482B4
	lda.w #$0034
CODE_C482B4:						; from CODE_C482AA
	adc.b $83
	tay
	lda.w #$FFFD
	sta.w $1373,y
	lda.w #$0007
	jsl.l CODE_C37EAA
	cmp.w #$0000
	bne CODE_C482D8
	lda.w #$FFFC
	sta.w $1373,y
	lda.w $1153
	ora.w #$4000
	sta.w $1153
CODE_C482D8:						; from CODE_C482B4
	rtl
CODE_C482D9:						; from CODE_C48241
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
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
	inc.w $18AA
	lda.w #$58CA
	ldx.w #$0012
	ldy.w #$0004
	jsl.l CODE_C58C36
	lda.w #$5F1D
	ldx.w #$00C3
	ldy.w #$590B
	jsl.l QueueVRAMDMALen
	lda.w #$5F28
	ldx.w #$00C3
	ldy.w #$58EB
	jsl.l QueueVRAMDMALen
	lda.w $1153
	bit.w #$4000
	beq CODE_C4833E
	and.w #$BFFF
	sta.w $1153
	lda.w #$5F37
	ldx.w #$00C3
	ldy.w #$58F3
	jsl.l QueueVRAMDMALen
CODE_C4833E:						; from CODE_C482D9
	jsl.l CODE_C533E1
	ldy.w #$592B
	jsl.l QueueVRAMDMALen
	pla
	sta.b $75
	pla
	sta.b $73
	pla
	sta.b $71
	pla
	sta.b $6F
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
CODE_C4837C:						; called from other segments
	lda.w $10F1
	bit.w #$0020
	bne CODE_C48387
	jmp.w CODE_C48400
CODE_C48387:						; from CODE_C4837C
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($63)
	pei ($65)
	lda.w #$0005
	sta.b $7F
	ldy.w #$0000
	cpx.w #$000C
	bcc CODE_C483A3
	ldy.w #$000C
CODE_C483A3:						; from CODE_C48387
	sty.b $63
	lda.w #$0060
	sta.b $83
	lda.w $0FE0,x
	beq CODE_C483B2
	jmp.w CODE_C4841C
CODE_C483B2:						; from CODE_C483A3
	lda.w #$FFA0
	sta.b $83
	sec
	sbc.w $08B2
	beq CODE_C483BF
	bpl CODE_C483D8
CODE_C483BF:						; from CODE_C483B2, CODE_C483D0
	ldy.b $63
	lda.w $0A20,y
	bmi CODE_C483D0
	lda.b $83
	sec
	sbc.w $0896,y
	beq CODE_C483D0
	bpl CODE_C48401
CODE_C483D0:						; from CODE_C483BF
	inc.b $63
	inc.b $63
	dec.b $7F
	bpl CODE_C483BF
CODE_C483D8:						; from CODE_C483B2, CODE_C4841C, CODE_C48431
	lda.w #$0040
	sta.b $7F
	lda.w #$8000
	trb.w $10F5
	beq CODE_C483EE
	lda.w $2348
	bne CODE_C483EE
	jsl.l CODE_C58944
CODE_C483EE:						; from CODE_C483D8, CODE_C48401
	pla
	sta.b $65
	pla
	sta.b $63
	pla
	sta.b $85
	pla
	sta.b $83
	pla
	sta.b $81
	pla
	sta.b $7F
CODE_C48400:						; from CODE_C4837C
	rtl
CODE_C48401:						; from CODE_C483BF, CODE_C48423
	lda.w #$0014
	sta.w $009F
	lda.w #$8000
	tsb.w $10F5
	bne CODE_C483EE
	lda.w $1145
	bpl CODE_C483EE
	phx
	jsl.l CODE_C38CFC
	plx
	bra CODE_C483EE
CODE_C4841C:						; from CODE_C483A3
	lda.b $83
	cmp.w $08B2
	bmi CODE_C483D8
CODE_C48423:						; from CODE_C48431
	ldy.b $63
	lda.w $0A20,y
	bmi CODE_C48431
	lda.b $83
	cmp.w $0896,y
	bmi CODE_C48401
CODE_C48431:						; from CODE_C48423
	inc.b $63
	inc.b $63
	dec.b $7F
	bpl CODE_C48423
	bra CODE_C483D8
CODE_C4843B:						; called from other segments
	ldy.b $6B
	cpy.w #$0018
	bcc CODE_C48445
	jmp.w CODE_C484EC
CODE_C48445:						; from CODE_C4843B
	lda.w $0814,y
	sta.w $2004
	lda.w $0896,y
	sta.w $2006
	tya
	lsr a
	sta.w $2002
	stz.b $63
	lda.w $1020,y
	beq CODE_C48461
	inc.b $63
	inc.b $63
CODE_C48461:						; from CODE_C48445
	lda.w $0DC0,y
	sta.b $7F
	ldy.b $63
	cmp.w $12BB,y
	beq CODE_C484AA
	lda.w $12FF,y
	bit.w #$0004
	beq CODE_C4848E
	and.w #$FFFB
	sta.w $12FF,y
	cpy.w #$0000
	bne CODE_C4849A
	lda.w $14E3
	clc
	adc.w #$000A
	bmi CODE_C4848C
	sta.w $14E3
CODE_C4848C:						; from CODE_C48461
	bra CODE_C4849A
CODE_C4848E:						; from CODE_C48461
	lda.w $12BF,y
	sta.w $12C3,y
	lda.w $12BB,y
	sta.w $12BF,y
CODE_C4849A:						; from CODE_C48461, CODE_C4848C
	lda.b $7F
	sta.w $12BB,y
	cmp.w $12C3,y
	bne CODE_C484AA
	lda.w #$FFFF
	sta.w $12C3,y
CODE_C484AA:						; from CODE_C48461, CODE_C4849A
	lda.w #$1000
	trb.w $10F5
	jsl.l a2offsides
	ldy.b $6B
	lda.w $07B6
	bit.w #$0004
	beq CODE_C484F2
	bit.w #$0001
	beq CODE_C484F2
	lda.w $0A20,y
	beq CODE_C484F2
	lda.w $07B6
	bit.w #$0002
	bne CODE_C484ED
	lda.w $0FE0,y
	beq CODE_C484F2
CODE_C484D5:						; from CODE_C484ED
	phx
	lda.w $07B7
	and.w #$00FF
	asl a
	sta.b $6F
	tax
	lda.w #$000C
	sta.b $7F
	jsl.l CODE_C4789D
	plx
	stx.b $6F
CODE_C484EC:						; from CODE_C4843B, CODE_C48510, CODE_C4852A
	rtl
CODE_C484ED:						; from CODE_C484AA
	lda.w $0FE0,y
	beq CODE_C484D5
CODE_C484F2:						; from CODE_C484AA
	tya
	lsr a
	xba
	sta.w $07B6
	lda.w $08B2
	sta.b $7F
	lda.w $0FE0,y
	beq CODE_C48510
	lda.w #$0002
	tsb.w $07B6
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C48510:						; from CODE_C484F2
	lda.b $7F
	bmi CODE_C484EC
	lda.w $12C7
	sec
	sbc.w $12C9
	sta.b $7F
	lda.w $1020,y
	beq CODE_C4852A
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C4852A:						; from CODE_C48510
	lda.b $7F
	bmi CODE_C484EC
	lda.w #$0004
	tsb.w $07B6
	rtl
a2offsides:							; from CODE_C484AA and other segments
	ldy.b $6B
	lda.w $10F1
	bit.w #$0020
	beq CODE_C4858F
	lda.w $08B2
	sta.b $7F
	lda.w $0FE0,y
	bne CODE_C48551
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C48551:						; from a2offsides
	lda.b $7F
	cmp.w #$005C
	bmi CODE_C4858F
	stz.b $63
	lda.w $1020,y
	beq CODE_C48564
	lda.w #$0002
	sta.b $63
CODE_C48564:						; from CODE_C48551
	ldy.b $63
	lda.w $12FF,y
	bit.w #$0010
	beq CODE_C4858F
	lda.w $10F1
	bit.w #$0010
	bne CODE_C4858F
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
	lda.w #$0012
	sta.b $7F
	jsl.l CODE_C4789D
	ldx.b $6B
	ldy.b $6F
	sty.b $6B
	stx.b $6F
CODE_C4858F:						; from a2offsides, CODE_C48551, CODE_C48564
	rtl
CheckBreakaway:						; from CODE_C4862C, CODE_C480CC and other segments
	stz.w $1155
	lda.w $05A0
	bpl CODE_C4859B
	jmp.w CODE_C4862B
CODE_C4859B:						; from CheckBreakaway
	lda.w $10F1
	bit.w #$0002
	bne CODE_C485AD
	lda.w $05A0
	cmp.w #$000C
	bmi CODE_C485EF
	bra CODE_C485B7
CODE_C485AD:						; from CODE_C4859B
	lda.w $05A0
	cmp.w #$000C
	bmi CODE_C485B7
	bra CODE_C485EF
CODE_C485B7:						; from CODE_C4859B, CODE_C485AD
	ldy.w $05A0
	lda.w $0896,y
	bpl CODE_C4862B
	sec
	sbc.w #$0004
	sta.b $7F
	ldy.w #$0000
	lda.w $05A0
	cmp.w #$000C
	bpl CODE_C485D3
	ldy.w #$000C
CODE_C485D3:						; from CODE_C485B7
	lda.w #$0006
	sta.b $87
CODE_C485D8:						; from CODE_C485E7
	lda.w $0A20,y
	bmi CODE_C485E7
	beq CODE_C485E7
	lda.b $7F
	sec
	sbc.w $0896,y
	bpl CODE_C4862B
CODE_C485E7:						; from CODE_C485D8
	iny
	iny
	dec.b $87
	bpl CODE_C485D8
	bra CODE_C48625
CODE_C485EF:						; from CODE_C4859B, CODE_C485AD
	ldy.w $05A0
	lda.w $0896,y
	bmi CODE_C4862B
	clc
	adc.w #$0004
	sta.b $7F
	ldy.w #$0000
	lda.w $05A0
	cmp.w #$000C
	bpl CODE_C4860B
	ldy.w #$000C
CODE_C4860B:						; from CODE_C485EF
	lda.w #$0006
	sta.b $87
CODE_C48610:						; from CODE_C4861F
	lda.w $0A20,y
	bmi CODE_C4861F
	beq CODE_C4861F
	lda.b $7F
	sec
	sbc.w $0896,y
	bmi CODE_C4862B
CODE_C4861F:						; from CODE_C48610
	iny
	iny
	dec.b $87
	bpl CODE_C48610
CODE_C48625:						; from CODE_C485E7
	stz.w $1155
	inc.w $1155
CODE_C4862B:						; from CheckBreakaway, CODE_C485EF, CODE_C48610, CODE_C485B7, ...
	rtl
CODE_C4862C:						; called from other segments
	jsl.l CheckBreakaway
	lda.w $1155
	sta.w $18AE
	beq CODE_C4866C
	lda.w $18BE
	bne CODE_C48644
	lda.w #$0001
	jsl.l CODE_CF040B
CODE_C48644:						; from CODE_C4862C
	lda.w $14E3
	clc
	adc.w #$0014
	bmi CODE_C48650
	sta.w $14E3
CODE_C48650:						; from CODE_C48644
	phy
	ldy.w #$0000
	lda.w $05A0
	cmp.w #$000C
	bmi CODE_C4865F
	ldy.w #$0002
CODE_C4865F:						; from CODE_C48650
	lda.w $18BE
	bne CODE_C4866B
	lda.w $12E3,y
	inc a
	sta.w $12E3,y
CODE_C4866B:						; from CODE_C4865F
	ply
CODE_C4866C:						; from CODE_C4862C
	rtl
CODE_C4866D:						; called from other segments
	lda.w $18BE
	bne CODE_C486C6
	lda.w $18B0
	cmp.w #$000C
	bmi CODE_C48685
	lda.w #$0002
	sta.w $18B4
	inc.w $12ED
	bra CODE_C4868B
CODE_C48685:						; from CODE_C4866D
	stz.w $18B4
	inc.w $12EB
CODE_C4868B:						; from CODE_C4866D
	phy
	lda.w $18B4
	eor.w #$0002
	tay
	lda.w #$0001
	sta.w $12C7,y
	ldy.w $18B4
	lda.w #$0001
	sta.w $12C7,y
	ply
	phx
	ldx.w $18B0
	lda.w $0DC0,x
	sta.w $18B2
	plx
	stz.w $18BE
	inc.w $18BE
	lda.w $2034
	sta.w $18BA
	lda.w $2036
	sta.w $18BC
	stz.w $2034
	stz.w $2036
CODE_C486C6:						; from CODE_C4866D
	rtl
CODE_C486C7:						; called from other segments
	lda.w $1157
	beq CODE_C486FC
	lda.w $18BE
	beq CODE_C486FC
	phx
	jsl.l CODE_C4CEDB
	jsl.l CODE_C4785E
	stz.w $1157
	stz.w $18BE
	lda.w #$FFFF
	sta.w $18B0
	lda.w #$000A
	sta.b $7F
	jsl.l CODE_C093DD
	lda.w $18BA
	sta.w $2004
	lda.w $18BC
	sta.w $2006
	plx
CODE_C486FC:						; from CODE_C486C7
	rtl
CODE_C486FD:						; called from other segments
	lda.w #$121E
	sta.b $83
	lda.b $7F
	and.w #$000F
	sta.b $7F
	cmp.w #$0008
	bcc CODE_C4872A
	ldy.w $14F9,x
	bpl CODE_C48718
	cmp.w #$0009
	bne CODE_C48720
CODE_C48718:						; from CODE_C486FD
	lda.w $09A0,x
	ora.w $09C0,x
	bne CODE_C4876D
CODE_C48720:						; from CODE_C486FD
	lda.w $1060,x
	bne CODE_C48729
	jml.l SetSPA
CODE_C48729:						; from CODE_C48720
	rtl
CODE_C4872A:						; from CODE_C486FD
	cpx.w $05A0
	beq CODE_C48770
	lda.w $0644,x
	cmp.w #$000C
	beq CODE_C48770
	lda.w $0896,x
	bit.w #$8000
	beq CODE_C48743
	eor.w #$FFFF
	inc a
CODE_C48743:						; from CODE_C4872A
	cmp.w #$009C
	bcc CODE_C48770
	ldy.w $14F9,x
	bmi CODE_C4875A
	lda.w $0C80,x
	cmp.w #$1552
	bcc CODE_C4875A
	cmp.w #$2708
	bcc CODE_C4876D
CODE_C4875A:						; from CODE_C48743
	lda.b $7F
	cmp.w $0C40,x
	beq CODE_C4879A
	sta.b $87
	lda.w #$121E
	jsl.l SetSPAFromA
	jmp.w CODE_C487C4
CODE_C4876D:						; from CODE_C48718, CODE_C48743
	jmp.w CODE_C458E4
CODE_C48770:						; from CODE_C4872A, CODE_C48743
	lda.w $0694,x
	bne CODE_C4879A
	lda.b $7F
	sec
	sbc.w $0C40,x
	sta.b $7F
	beq CODE_C4879A
	eor.w #$FFFF
	inc a
	and.w #$0004
	lsr a
	dec a
	clc
	adc.w $0C40,x
	and.w #$0007
	sta.b $7F
	sta.w $0C40,x
	lda.w #$0006
	sta.w $0694,x
CODE_C4879A:						; from CODE_C4875A, CODE_C48770
	lda.w $0694,x
	beq CODE_C487AB
	sec
	sbc.w $05A2
	bpl CODE_C487A8
	lda.w #$0000
CODE_C487A8:						; from CODE_C4879A
	sta.w $0694,x
CODE_C487AB:						; from CODE_C4879A
	lda.w $05CC,x
	bit.w #$0002
	bne CODE_C487B8
	lda.w #$121E
	bra CODE_C487BB
CODE_C487B8:						; from CODE_C487AB
	lda.w #$14C0
CODE_C487BB:						; from CODE_C487AB
	jsl.l SetSPAFromA
	lda.w $0C40,x
	sta.b $87
CODE_C487C4:						; from CODE_C4875A
	lda.w $14F9,x
	bmi CODE_C487E7
	lda.w $0E20,x
	pha
	lsr a
	sta.b $9F
	lsr a
	lsr a
	sta.b $A1
	sec
	lda.b $9F
	sbc.b $A1
	sta.w $0E20,x
	phx
	jsl.l CODE_C45ABE
	plx
	pla
	sta.w $0E20,x
	rtl
CODE_C487E7:						; from CODE_C487C4
	jml.l CODE_C45ABE
CODE_C487EB:						; called from other segments
	lda.w $10F3
	bne rtss
	stz.b $6B
	lda.w #$0002
	sta.b $67
	jsl.l CODE_C48802
	stz.b $67
	lda.w #$0002
	sta.b $6B
CODE_C48802:						; from CODE_C487EB and other segments
	ldy.b $6B
	lda.w $12CB,y
	bmi rtss
	ldx.w $1283,y
	ldy.w $05A0
	bmi rtss
	lda.w $1020,y
	cmp.w $1020,x
	bne rtss
	ldy.b $6B
	lda.w $10F1
	bit.w #$0008
	bne CODE_C48832
	lda.w $14F5,y
	bne rtss
	lda.w $08B2
	sta.b $83
	jsl.l CPgoalie
	rtl
CODE_C48832:						; from CODE_C48802
	lda.w $12CB,y
	ora.w #$FF00
	sta.w $12CB,y
	jsl.l CODE_C541D3
rtss:								; an rtl: asstab entry 0 (no assignment), as 94S rtss
	rtl
CODE_C48840:						; called from other segments
	stz.b $6B
	lda.w #$0002
	sta.b $67
	jsl.l CODE_C48852
	stz.b $67
	lda.w #$0002
	sta.b $6B
CODE_C48852:						; from CODE_C48840 and other segments
	ldy.b $6B
	lda.w $12CB,y
	bpl CODE_C48871
	and.w #$00FF
	cmp.w #$000A
	bcs CODE_C48871
	sta.w $12CB,y
	lda.w $14F5,y
	bne CODE_C48871
	lda.w $2036
	sta.b $83
	jmp.w CPgoalie
CODE_C48871:						; from CODE_C48852
	rtl
CPgoalie:							; from CODE_C48802, CODE_C48852 and other segments
	lda.w $114B
	cmp.w #$0002
	bne CODE_C488BA
	ldy.b $67
	lda.w $12AB,y
	ldy.b $6B
	sec
	sbc.w $12AB,y
	bmi CODE_C488BA
	beq CODE_C488BA
	cmp.w #$0003
	bcs CODE_C488BA
	lda.w $114D
	cmp.w #$003D
	bcs CODE_C488BA
	lda.w $1283,y
	tay
	lda.w $0FE0,y
	bne CODE_C488A7
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
CODE_C488A7:						; from CPgoalie
	lda.b $83
	bmi CODE_C488BA
	ldy.b $6B
	lda.w $12CB,y
	ora.w #$FF00
	sta.w $12CB,y
	jml.l CODE_C541D3
CODE_C488BA:						; from CPgoalie, CODE_C488A7
	rtl
CODE_C488BB:						; called from other segments
	lda.w #$0006
	ora.w $05CC,x
	sta.w $05CC,x
	lda.w $0814,x
	cmp.w #$FFD8
	bmi CODE_C488F2
	cmp.w #$0029
	bpl CODE_C488F2
	lda.w $0896,x
	bit.w #$8000
	beq CODE_C488DD
	eor.w #$FFFF
	inc a
CODE_C488DD:						; from CODE_C488BB
	sta.b $2C
	cmp.w #$00EB
	bmi CODE_C488F2
	cmp.w #$010A
	bpl CODE_C488F2
	lda.w #$FFFB
	and.w $05CC,x
	sta.w $05CC,x
CODE_C488F2:						; from CODE_C488BB, CODE_C488DD
	lda.w $0814,x
	cmp.w #$FFD0
	bmi CODE_C48919
	cmp.w #$0031
	bpl CODE_C48919
	lda.w $0896,x
	bit.w #$8000
	beq CODE_C4890B
	eor.w #$FFFF
	inc a
CODE_C4890B:						; from CODE_C488F2
	cmp.w #$00EB
	bmi CODE_C48919
	lda.w #$FFFD
	and.w $05CC,x
	sta.w $05CC,x
CODE_C48919:						; from CODE_C488F2, CODE_C4890B
	lda.w $14F9,x
	bpl CODE_C48956
	lda.w $10F3
	bne CODE_C48956
	jsl.l check4bench
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C4893B
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $0AE0,x
	stz.w $0692
CODE_C4893B:						; from CODE_C48919
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bpl CODE_C4898F
	lda.w $0E60,x
	lsr a
	lsr a
	clc
	adc.w $0AE0,x
	bpl CODE_C48959
	lda.w #$0000
	bra CODE_C48959
CODE_C48956:						; from CODE_C48919, CODE_C48959, CODE_C4896D, CODE_C48985
	jmp.w assexit
CODE_C48959:						; from CODE_C4893B
	sta.w $0AE0,x
	lda.w $05A0
	bpl CODE_C48956
	lda.w $09DC
	ldy.w $0FE0,x
	beq CODE_C4896D
	eor.w #$FFFF
	inc a
CODE_C4896D:						; from CODE_C48959
	cmp.w #$F800
	bmi CODE_C48956
	stz.b $67
	lda.w #$0002
	sta.b $6B
	lda.w $1020,x
	beq CODE_C48985
	stz.b $6B
	lda.w #$0002
	sta.b $67
CODE_C48985:						; from CODE_C4896D
	ldy.b $6B
	lda.w $12CF,y
	cmp.w #$0046
	bcc CODE_C48956
CODE_C4898F:						; from CODE_C4893B
	jsr.w CODE_C4937C
	jsl.l CODE_C37F6D
	jsl.l AdjustFacingDirection
	asl.w $0E00,x
	jsl.l CODE_C489A5
	lsr.w $0E00,x
	rtl
CODE_C489A5:						; from CODE_C4898F and other segments
	lda.w $0B00,x
	sec
	sbc.b $9B
	sta.w $0B00,x
	bmi CODE_C489B3
	jmp.w CODE_C48A38
CODE_C489B3:						; from CODE_C489A5
	adc.w #$0005
	sta.w $0B00,x
	lda.w $09BC
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C489C8
	ora.w #$FF00
CODE_C489C8:						; from CODE_C489B3
	clc
	adc.w $0830
	sta.b $7F
	lda.w $09DC
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C489DD
	ora.w #$FF00
CODE_C489DD:						; from CODE_C489C8
	clc
	adc.w $08B2
	sta.b $83
	jsl.l CODE_C46BF6
	pei ($83)
	lda.b $7F
	pha
	txa
	jsl.l CODE_C37FE2
	lda.b $7F
	eor.w #$FFFF
	inc a
	sec
	sbc.w $09A1,x
	and.w #$00FF
	bit.w #$0080
	beq CODE_C48A06
	ora.w #$FF00
CODE_C48A06:						; from CODE_C489DD
	clc
	adc.b $01,s
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.b $83
	eor.w #$FFFF
	inc a
	sec
	sbc.w $09C1,x
	and.w #$00FF
	bit.w #$0080
	beq CODE_C48A24
	ora.w #$FF00
CODE_C48A24:						; from CODE_C48A06
	clc
	adc.b $03,s
	sec
	sbc.w $0896,x
	sta.b $83
	pla
	pla
	jsl.l CODE_C37F6D
	lda.b $7F
	sta.w $0B80,x
CODE_C48A38:						; from CODE_C489A5
	lda.w $0B80,x
	sta.b $7F
	jml.l CODE_C4694F
CODE_C48A41:						; called from other segments
	ldy.b $6B
	stz.b $7F
	lda.w #$00C3
	sta.b $A1
	lda.w $17D3,y
	sta.b $9F
	ldy.w #$0008
	clc
	adc.b [$9F],y
	sta.b $9F
	lda.b [$9F]
	xba
CODE_C48A5A:						; from CODE_C48A5A
	inc.b $7F
	asl a
	asl a
	asl a
	asl a
	bne CODE_C48A5A
	rtl
CODE_C48A63:						; no caller found (not traced)
	bra CODE_C48A6C
CODE_C48A65:						; from CODE_C48A6C
	lda.b $67
	clc
	adc.b [$67]
	sta.b $67
CODE_C48A6C:						; from CODE_C48A63
	dec.b $7F
	bpl CODE_C48A65
	rtl
CODE_C48A71:						; called from other segments
	lda.w #$0006
	ora.w $05CC,x
	sta.w $05CC,x
	lda.w $0814,x
	cmp.w #$FFD8
	bmi CODE_C48AA8
	cmp.w #$0029
	bpl CODE_C48AA8
	lda.w $0896,x
	bit.w #$8000
	beq CODE_C48A93
	eor.w #$FFFF
	inc a
CODE_C48A93:						; from CODE_C48A71
	sta.b $2C
	cmp.w #$00EB
	bmi CODE_C48AA8
	cmp.w #$010A
	bpl CODE_C48AA8
	lda.w #$FFFB
	and.w $05CC,x
	sta.w $05CC,x
CODE_C48AA8:						; from CODE_C48A71, CODE_C48A93
	lda.w $0814,x
	cmp.w #$FFD0
	bmi CODE_C48AD1
	cmp.w #$0031
	bpl CODE_C48AD1
	lda.w $0896,x
	bit.w #$8000
	beq CODE_C48AC1
	eor.w #$FFFF
	inc a
CODE_C48AC1:						; from CODE_C48AA8
	sta.b $2C
	cmp.w #$00EB
	bmi CODE_C48AD1
	lda.w #$FFFD
	and.w $05CC,x
	sta.w $05CC,x
CODE_C48AD1:						; from CODE_C48AA8, CODE_C48AC1
	jsl.l check4bench
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C48AF5
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $0AE0,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
	lda.w #$FFFF
	sta.w $0B40,x
CODE_C48AF5:						; from CODE_C48AD1
	ldy.w $14F9,x
	bpl CODE_C48B48
	lda.w $0814,x
	cmp.w #$FFCB
	bmi CODE_C48B1D
	cmp.w #$0035
	bpl CODE_C48B1D
	lda.w $0896,x
	bit.w #$8000
	beq CODE_C48B13
	eor.w #$FFFF
	inc a
CODE_C48B13:						; from CODE_C48AF5
	cmp.w #$0115
	bcs CODE_C48B1D
	cmp.w #$00D9
	bcs CODE_C48B5E
CODE_C48B1D:						; from CODE_C48AF5, CODE_C48B13
	lda.w #rtss>>16
	sta.b $65
	lda.w #rtss
	sta.b $63
	ldy.w #$0004
	lda.w $0814,x
	bpl CODE_C48B32
	ldy.w #$FFFC
CODE_C48B32:						; from CODE_C48B1D
	sty.b $7F
	lda.w #$00FA
	sta.b $83
	lda.w $0FE0,x
	beq CODE_C48B43
	lda.w #$FF06
	sta.b $83
CODE_C48B43:						; from CODE_C48B32
	jml.l CODE_C45950
DATA8_C48B47:						; an rtl no traced code reaches
	db $6B
CODE_C48B48:						; from CODE_C48AF5
	lda.w $10F3
	bne CODE_C48B55
	cpx.w $05A0
	beq CODE_C48B55
	jmp.w CODE_C48B8E
CODE_C48B55:						; from CODE_C48B48
	lda.w $05CC,x
	ora.w #$0001
	sta.w $05CC,x
CODE_C48B5E:						; from CODE_C48B13, CODE_C48B8E
	jmp.w CODE_C48BAA
CODE_C48B61:						; from CODE_C48B8E
	lda.w #rtss>>16
	sta.b $65
	lda.w #rtss
	sta.b $63
	ldy.w #$0004
	lda.w $0814,x
	bpl CODE_C48B76
	ldy.w #$FFFC
CODE_C48B76:						; from CODE_C48B61
	sty.b $7F
	lda.w #$00FF
	sta.b $83
	lda.w $0FE0,x
	beq CODE_C48B87
	lda.w #$FF01
	sta.b $83
CODE_C48B87:						; from CODE_C48B76
	stz.w $0B00,x
	jml.l CODE_C45950
CODE_C48B8E:						; from CODE_C48B48
	lda.w $05CC,x
	bit.w #$0001
	bne CODE_C48B5E
	bit.w #$0002
	bne CODE_C48B61
	ldy.w $14F9,x
	lda.w $056F,y
	cmp.w #$0008
	bne CODE_C48BAA
	jsl.l CODE_C458E4
CODE_C48BAA:						; from CODE_C48B5E, CODE_C48B8E
	lda.w $1060,x
	bne CODE_C48BB6
	lda.w #$121E
	jsl.l SetSPAFromA
CODE_C48BB6:						; from CODE_C48BAA
	lda.w $10F3
	bne CODE_C48BDF
	lda.w $0B60,x
	bmi CODE_C48BF4
	cpx.w $05A0
	bne CODE_C48BD7
	lda.w $0896,x
	cmp.w #$00BB
	bpl CODE_C48BE0
	cmp.w #$FF45
	bmi CODE_C48BE0
	stz.w $0B60,x
	bra CODE_C48BE0
CODE_C48BD7:						; from CODE_C48BB6
	lda.w #$FFFF
	sta.w $0B60,x
	bra CODE_C48BF4
CODE_C48BDF:						; from CODE_C48BB6, CODE_C48BF4
	rtl
CODE_C48BE0:						; from CODE_C48BB6
	lda.w $0B60,x
	sec
	sbc.b $9B
	sta.w $0B60,x
	bpl CODE_C48BF4
	lda.w #$0008
	sta.b $7F
	jsl.l CODE_C478C3
CODE_C48BF4:						; from CODE_C48BB6, CODE_C48BD7, CODE_C48BE0
	lda.w $1060,x
	beq CODE_C48BFC
	jmp.w CODE_C48BDF
CODE_C48BFC:						; from CODE_C48BF4
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bmi CODE_C48C0A
	jmp.w CODE_C49259
CODE_C48C0A:						; from CODE_C48BFC
	lda.w $0E60,x
	lsr a
	clc
	adc.w $0AE0,x
	cmp.w #$0000
	bpl CODE_C48C1A
	lda.w #$0000
CODE_C48C1A:						; from CODE_C48C0A
	sta.w $0AE0,x
	lda.w $14F9,x
	bpl CODE_C48C54
	lda.w $08B2
	sta.b $7F
	lda.w $0896,x
	eor.b $7F
	sta.b $83
	bpl CODE_C48C44
	stz.b $7F
	lda.w #$00FA
	sta.b $87
	lda.w $0FE0,x
	beq CODE_C48C41
	lda.w #$FF06
	sta.b $87
CODE_C48C41:						; from CODE_C48C1A
	jmp.w CODE_C4918A
CODE_C48C44:						; from CODE_C48C1A
	dec.w $0B40,x
	bpl CODE_C48C4F
	lda.w #$FFFF
	sta.w $0B40,x
CODE_C48C4F:						; from CODE_C48C44
	cpx.w $05A0
	beq CODE_C48C57
CODE_C48C54:						; from CODE_C48C1A
	jmp.w CODE_C48CE7
CODE_C48C57:						; from CODE_C48C4F
	lda.w $0B60,x
	bpl CODE_C48C62
	lda.w #$005A
	sta.w $0B60,x
CODE_C48C62:						; from CODE_C48C57
	lda.w #$FFFF
	sta.w $0B40,x
	lda.w $0B60,x
	sec
	sbc.w #$005A
	bpl CODE_C48CB4
	jsl.l RandomWord
	cmp.w #$C000
	bcc CODE_C48CB4
	lda.w #$0005
	sta.b $7F
	stz.b $63
	lda.w $1020,x
	bne CODE_C48C8B
	lda.w #$000C
	sta.b $63
CODE_C48C8B:						; from CODE_C48C62, CODE_C48C9D
	ldy.b $63
	lda.w $0D60,y
	bit.w #$1000
	bne CODE_C48C9D
	lda.w $05E4,y
	cmp.w #$0023
	bcc CODE_C48CB7
CODE_C48C9D:						; from CODE_C48C8B
	inc.b $63
	inc.b $63
	dec.b $7F
	bpl CODE_C48C8B
	lda.w #$0001
	sta.w $07EE
	jsl.l CODE_C49FBD
	lda.w $05A0
	bmi CODE_C48CCC
CODE_C48CB4:						; from CODE_C48CE7, CODE_C48C62, CODE_C48CB7
	jmp.w CODE_C48DEE
CODE_C48CB7:						; from CODE_C48C8B
	ldy.w #$0000
	cmp.w #$0014
	bcs CODE_C48CB4
	lda.w #$005A
	sta.w $1060,x
	lda.w #$1636
	jsl.l SetSPAFromA
CODE_C48CCC:						; from CODE_C48C9D
	rtl
CODE_C48CCD:						; from CODE_C48CE7, CODE_C48D39
	jsl.l CODE_C37F6D
	lda.b $7F
CODE_C48CD3:						; from CODE_C48CE7
	sta.w $0C40,x
	sta.w $1000,x
	lda.w #$15C4
	jsl.l SetSPAFromA
	lda.w #$00F0
	sta.w $06B4,x
	rtl
CODE_C48CE7:						; from CODE_C48C54
	ldy.w $14F9,x
	bmi CODE_C48D39
	lda.w $05A4,y
	cmp.w #$0001
	bne CODE_C48D39
	cpx.w $05A0
	beq CODE_C48CB4
	lda.w $0830
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.w $08B2
	sec
	sbc.w $0896,x
	sta.b $83
	lda.w $00C1,y
	bit.w #$4000
	bne CODE_C48D28
	lda.w $0583,y
	bit.w #$0040
	beq CODE_C48CB4
	lda.w $056F,y
	cmp.w #$0008
	beq CODE_C48CCD
	and.w #$0007
	bra CODE_C48CD3
CODE_C48D28:						; from CODE_C48CE7
	lda.w $056F,y
	cmp.w #$0008
	bne CODE_C48D33
	jmp.w CODE_C48DB6
CODE_C48D33:						; from CODE_C48D28
	and.w #$0007
	jmp.w CODE_C48DBC
CODE_C48D39:						; from CODE_C48CE7
	lda.w $0830
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.w $08B2
	sec
	sbc.w $0896,x
	sta.b $83
	lda.w $05A0
	bmi CODE_C48D80
	lsr a
	tay
	lda.w $1020,y
	cmp.w $1020,x
	beq CODE_C48DB3
	lda.w $06B4,x
	bne CODE_C48DB3
	jsl.l RandomWord
	cmp.w #$0A00
	bcs CODE_C48DB3
	lda.w $05E4,x
	cmp.w #$0023
	bcs CODE_C48DEE
	lda.w $08B2
	cmp.w #$FEF1
	bmi CODE_C48DEE
	cmp.w #$010F
	bpl CODE_C48DEE
	jmp.w CODE_C48CCD
CODE_C48D80:						; from CODE_C48D39
	lda.w $0B40,x
	bne CODE_C48DB3
	lda.w $05E4,x
	cmp.w #$002D
	bcs CODE_C48DEE
	lda.w $08B2
	cmp.w #$FEF1
	bmi CODE_C48DEE
	cmp.w #$010F
	bpl CODE_C48DEE
	lda.b $6B
	eor.w #$0002
	tay
	lda.w $12CF,y
	cmp.w #$003C
	bcs CODE_C48DEE
	jsl.l RandomWord
	cmp.w #$0800
	bcs CODE_C48DEE
	bra CODE_C48DB6
CODE_C48DB3:						; from CODE_C48D39, CODE_C48D80
	jmp.w CODE_C48DEE
CODE_C48DB6:						; from CODE_C48D28, CODE_C48D80
	jsl.l CODE_C37F6D
	lda.b $7F
CODE_C48DBC:						; from CODE_C48D33
	sta.w $0C40,x
	ldy.w #$1552
	tya
	jsl.l SetSPAFromA
	lda.w #$0168
	sta.w $06B4,x
	lda.w $14E3
	clc
	adc.w #$000A
	bmi CODE_C48DD9
	sta.w $14E3
CODE_C48DD9:						; from CODE_C48DBC
	lda.w #$0096
	sta.w $1000,x
	clc
	adc.l $7E24CA
	sta.l $7E24CA
	lda.w #$001E
	sta.b $5B
	rtl
CODE_C48DEE:						; from CODE_C48CB4, CODE_C48D39, CODE_C48D80, CODE_C48DB3
	lda.w $0FE0,x
	bne CODE_C48E06
	stz.b $65
	lda.w #$07D8
	sta.b $63
	lda.w #$010A
	sta.b $8B
	lda.w #$010E
	sta.b $8F
	bra CODE_C48E15
CODE_C48E06:						; from CODE_C48DEE
	lda.w #$07DC
	sta.b $63
	lda.w #$FEF6
	sta.b $8B
	lda.w #$FEF2
	sta.b $8F
CODE_C48E15:						; from CODE_C48DEE
	cpx.w $05A0
	beq CODE_C48E27
	jsr.w CODE_C4937C
	jsl.l CODE_C37F6D
	jsl.l AdjustFacingDirection
	bra CODE_C48E3A
CODE_C48E27:						; from CODE_C48E15
	lda.w $14F9,x
	bpl CODE_C48E3A
	lda.w $0FE0,x
	eor.w #$0001
	asl a
	asl a
	sta.b $7F
	jsl.l AdjustFacingDirection
CODE_C48E3A:						; from CODE_C48E15, CODE_C48E27
	lda.w $0896,x
	cmp.w #$FEF5
	bmi CODE_C48E68
	cmp.w #$010B
	bpl CODE_C48E68
CODE_C48E47:						; from CODE_C48E68
	lda.w $0830
	sta.b $7F
	lda.w $08B2
	sta.b $83
	jsl.l CODE_C492F8
	lda.b $83
	cmp.w #$FFD2
	bmi CODE_C48E90
	cmp.w #$002E
	bpl CODE_C48E90
	pei ($83)
	pei ($7F)
	jmp.w CODE_C48F2A
CODE_C48E68:						; from CODE_C48E3A
	lda.w $14F9,x
	bpl CODE_C48E47
	stz.b $87
	stz.b $7F
	lda.w $0814,x
	cmp.w #$FFD3
	bmi CODE_C48E8D
	cmp.w #$002D
	bpl CODE_C48E8D
	lda.w #$009B
	sta.b $7F
	lda.w $0814,x
	bpl CODE_C48E8D
	lda.w #$FF65
	sta.b $7F
CODE_C48E8D:						; from CODE_C48E68
	jmp.w CODE_C4918A
CODE_C48E90:						; from CODE_C48E47
	lda.w $09DC
	xba
	lsr a
	and.w #$007F
	bit.w #$0040
	beq CODE_C48EA0
	ora.w #$FF80
CODE_C48EA0:						; from CODE_C48E90
	sta.b $40
	cmp.w #$8000
	ror a
	adc.b $40
	clc
	adc.w $08B2
	sta.b $83
	lda.b $83
	cmp.w #$00E6
	bpl CODE_C48EBC
	lda.b $83
	cmp.w #$FF1A
	bpl CODE_C48F05
CODE_C48EBC:						; from CODE_C48EA0
	lda.w $07CC
	bpl CODE_C48EED
	lda.w $05A0
	bmi CODE_C48EED
	lda.w $04B0
	and.w #$0180
	beq CODE_C48F0D
CODE_C48ECE:						; from CODE_C48F05
	lda.w $09BC
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C48EDD
	ora.w #$FF00
CODE_C48EDD:						; from CODE_C48ECE
	sta.b $40
	cmp.w #$8000
	ror a
	adc.b $40
	clc
	adc.w $0830
	sta.b $7F
	bra CODE_C48F22
CODE_C48EED:						; from CODE_C48EBC
	lda.w $09BC
	xba
	lsr a
	and.w #$007F
	bit.w #$0040
	beq CODE_C48EFD
	ora.w #$FF80
CODE_C48EFD:						; from CODE_C48EED
	clc
	adc.w $0830
	sta.b $7F
	bra CODE_C48F22
CODE_C48F05:						; from CODE_C48EA0
	lda.w $04B0
	and.w #$0380
	beq CODE_C48ECE
CODE_C48F0D:						; from CODE_C48EBC
	lda.w $09BC
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C48F1C
	ora.w #$FF00
CODE_C48F1C:						; from CODE_C48F0D
	clc
	adc.w $0830
	sta.b $7F
CODE_C48F22:						; from CODE_C48EDD, CODE_C48EFD
	jsl.l CODE_C492F8
	pei ($83)
	pei ($7F)
CODE_C48F2A:						; from CODE_C48E47
	lda.b $7F
	ldy.b $83
	jsl.l CODE_C38778
	sta.b $7F
	cmp.w #$001E
	bcs CODE_C48F41
	pla
	sta.b $7F
	pla
	sta.b $83
	bra CODE_C48F8C
CODE_C48F41:						; from CODE_C48F2A
	lda.b $7F
	inc a
	sta.b $87
	lda.w #$0014
	sta.b $8F
	lda.w $10F5
	bit.w #$0008
	beq CODE_C48F58
	lda.w #$001C
	sta.b $8F
CODE_C48F58:						; from CODE_C48F41
	pla
	sta.b $7F
	pla
	sta.b $83
	tax
	lda.b $8F
	jsl.l Mul16x8XS
	lda.b $87
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	sta.b $83
	lda.b $8F
	adc.w #$0006
	sta.b $8F
	ldx.b $7F
	jsl.l Mul16x8XS
	lda.b $87
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	sta.b $7F
	ldx.b $B7
CODE_C48F8C:						; from CODE_C48F2A
	lda.b $83
	clc
	adc.b $8B
	sta.b $83
	sta.b $87
	ldy.w $14F9,x
	bmi CODE_C48FAA
	cpx.w $05A0
	beq CODE_C48FA7
	lda.w $00C1,y
	bit.w #$0080
	bne CODE_C48FDD
CODE_C48FA7:						; from CODE_C48F8C
	jmp.w CODE_C49165
CODE_C48FAA:						; from CODE_C48F8C
	ldy.w #$0002
	lda.b [$63],y
	cmp.w #$0023
	bcc CODE_C48FB7
	jmp.w CODE_C4918A
CODE_C48FB7:						; from CODE_C48FAA
	lda.b [$63]
	cmp.w #$FFE7
	bmi CODE_C48FDA
	cmp.w #$0019
	bpl CODE_C48FDA
	lda.b [$63],y
	cmp.w #$0013
	bcs CODE_C48FD7
	lda.w $08B2
	cmp.w #$FEF1
	bmi CODE_C48FD7
	cmp.w #$010F
	bmi CODE_C48FDD
CODE_C48FD7:						; from CODE_C48FB7
	jmp.w CODE_C49165
CODE_C48FDA:						; from CODE_C48FB7
	jmp.w CODE_C49276
CODE_C48FDD:						; from CODE_C48F8C, CODE_C48FB7
	lda.w $09A0,x
	cmp.w #$8000
	ror a
	sta.w $09A0,x
	lda.w $09C0,x
	cmp.w #$8000
	ror a
	sta.w $09C0,x
	lda.w $05CC,x
	bit.w #$0002
	beq CODE_C48FFC
	jmp.w CODE_C490CB
CODE_C48FFC:						; from CODE_C48FDD
	lda.w $09BC
	xba
	lsr a
	lsr a
	and.w #$003F
	bit.w #$0020
	beq CODE_C4900D
	ora.w #$FFC0
CODE_C4900D:						; from CODE_C48FFC
	clc
	adc.w $0830
	sec
	sbc.w $0814,x
	sta.b $7F
	sta.b $2E
	bit.w #$8000
	beq CODE_C49022
	eor.w #$FFFF
	inc a
CODE_C49022:						; from CODE_C4900D
	sta.b $2C
	lda.w $09DC
	xba
	lsr a
	lsr a
	and.w #$003F
	bit.w #$0020
	beq CODE_C49035
	ora.w #$FFC0
CODE_C49035:						; from CODE_C49022
	clc
	adc.w $08B2
	sec
	sbc.w $0896,x
	sta.b $83
	bit.w #$8000
	beq CODE_C49048
	eor.w #$FFFF
	inc a
CODE_C49048:						; from CODE_C49035
	sta.b $30
	jsl.l CODE_C37F6D
	lda.b $7F
	cmp.w #$0008
	beq CODE_C49078
	sec
	sbc.w $0C40,x
	and.w #$0007
	sta.b $8B
	beq CODE_C49078
	jmp.w CODE_C490D9
CODE_C49063:						; from CODE_C490D9
	lda.w $09DC
	cmp.w #$0800
	bpl CODE_C49078
	cmp.w #$F800
	bmi CODE_C49078
	lda.w #$0008
	sta.b $7F
	jmp.w CODE_C4913D
CODE_C49078:						; from CODE_C49048, CODE_C490CB, CODE_C49063
	lda.w $0C40,x
	beq CODE_C4909E
	cmp.w #$0004
	beq CODE_C490A7
	cmp.w #$0001
	beq CODE_C490B0
	cmp.w #$0005
	beq CODE_C490B0
	cmp.w #$0007
	beq CODE_C490B8
	cmp.w #$0003
	beq CODE_C490B8
	lda.w $04B0
	and.w #$0001
	bra CODE_C490D9
CODE_C4909E:						; from CODE_C49078
	lda.b $2E
	bpl CODE_C490AB
CODE_C490A2:						; from CODE_C490A7, CODE_C490B0, CODE_C490B8
	lda.w #$0007
	bra CODE_C490D9
CODE_C490A7:						; from CODE_C49078
	lda.b $2E
	bpl CODE_C490A2
CODE_C490AB:						; from CODE_C4909E, CODE_C490B0, CODE_C490B8
	lda.w #$0001
	bra CODE_C490D9
CODE_C490B0:						; from CODE_C49078
	lda.b $2C
	cmp.b $30
	bpl CODE_C490AB
	bra CODE_C490A2
CODE_C490B8:						; from CODE_C49078
	lda.b $30
	cmp.b $2C
	bpl CODE_C490AB
	bra CODE_C490A2
CODE_C490C0:						; from CODE_C490FE
	lda.b $7F
	clc
	adc.w #$0006
	sta.b $7F
	jmp.w CODE_C4913D
CODE_C490CB:						; from CODE_C48FDD
	lda.w $0624,x
	sec
	sbc.w $0C40,x
	and.w #$0007
	sta.b $8B
	beq CODE_C49078
CODE_C490D9:						; from CODE_C49048, CODE_C49078, CODE_C490A2, CODE_C490AB
	cmp.w #$0004
	beq CODE_C49063
	lsr a
	lsr a
	sta.b $7F
	lda.w $08E0,x
	bit.w #$0800
	beq CODE_C490F1
	lda.b $7F
	eor.w #$0001
	sta.b $7F
CODE_C490F1:						; from CODE_C490D9
	lda.b $8B
	cmp.w #$0004
	bcc CODE_C490FE
	eor.w #$FFFF
	adc.w #$0008
CODE_C490FE:						; from CODE_C490F1
	cmp.w #$0002
	bcs CODE_C490C0
	lda.w $08D8
	sec
	sbc.w #$0008
	bpl CODE_C4913D
	lda.w $08DE
	sec
	sbc.w #$0800
	bpl CODE_C4913D
	lda.b $7F
	clc
	adc.w #$0004
	sta.b $7F
	ldy.w #$0002
	lda.b [$63],y
	cmp.w #$0009
	bcc CODE_C4913D
	lda.w $0C40,x
	cmp.w #$0002
	beq CODE_C4913D
	cmp.w #$0006
	beq CODE_C4913D
	lda.w $05A0
	bmi CODE_C4913D
	dec.b $7F
	dec.b $7F
CODE_C4913D:						; from CODE_C490FE, CODE_C49063, CODE_C490C0
	asl.b $7F
	lda.w #$00C4
	sta.b $69
	lda.w #$932C
	sta.b $67
	ldy.b $7F
	lda.b [$67],y
	sta.w $1000,x
	jsl.l SetSPAFromA
	lda.l $7E24CA
	clc
	adc.w #$0096
	sta.l $7E24CA
	lda.w #$001E
	sta.b $5B
CODE_C49165:						; from CODE_C48FA7, CODE_C48FD7
	lda.b [$63]
	sta.b $7F
	lda.w $08B2
	sec
	sbc.w #$0102
	bpl CODE_C4917B
	lda.w $08B2
	sec
	sbc.w #$FEFE
	bpl CODE_C4918A
CODE_C4917B:						; from CODE_C49165
	lda.w #$0018
	sta.b $7F
	lda.w $0830
	bpl CODE_C4918A
	lda.w #$FFE8
	sta.b $7F
CODE_C4918A:						; from CODE_C48C41, CODE_C48E8D, CODE_C48FAA, CODE_C49165, ...
	lda.w $14F9,x
	bmi CODE_C49192
	jmp.w CODE_C4932B
CODE_C49192:						; from CODE_C4918A
	ldy.w $05A0
	bmi CODE_C491DD
	lda.w $1020,x
	cmp.w $1020,y
	beq CODE_C491DD
	lda.w $0C80,y
	cmp.w #$1C24
	bcc CODE_C491DA
	cmp.w #$1EFB
	bcs CODE_C491DA
	lda.w $09C0,y
	bit.w #$8000
	beq CODE_C491B8
	eor.w #$FFFF
	inc a
CODE_C491B8:						; from CODE_C49192
	sta.b $2C
	lda.w $09A0,y
	bit.w #$8000
	beq CODE_C491C6
	eor.w #$FFFF
	inc a
CODE_C491C6:						; from CODE_C491B8
	lsr a
	cmp.b $2C
	bcs CODE_C491DA
	lda.w $0668
	bne CODE_C491DD
	stz.w $09A0,x
	stz.w $09C0,x
	inc.w $0668
	rtl
CODE_C491DA:						; from CODE_C49192, CODE_C491C6
	stz.w $0668
CODE_C491DD:						; from CODE_C49192, CODE_C491C6
	lda.b $87
	sta.b $83
	pha
	pei ($7F)
	lda.w $09A0,x
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C491F3
	ora.w #$FF00
CODE_C491F3:						; from CODE_C491DD
	eor.w #$FFFF
	inc a
	sta.b $7F
	pla
	clc
	adc.b $7F
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.w $09C0,x
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C49212
	ora.w #$FF00
CODE_C49212:						; from CODE_C491F3
	eor.w #$FFFF
	inc a
	sta.b $83
	pla
	clc
	adc.b $83
	sec
	sbc.w $0896,x
	sta.b $83
	lda.w #$0005
	sta.b $9F
	cpx.w $05A0
	bne CODE_C4922E
	asl.b $9F
CODE_C4922E:						; from CODE_C49212
	lda.b $7F
	bit.w #$8000
	beq CODE_C49239
	eor.w #$FFFF
	inc a
CODE_C49239:						; from CODE_C4922E
	cmp.b $9F
	bcs CODE_C49250
	lda.b $83
	bit.w #$8000
	beq CODE_C49248
	eor.w #$FFFF
	inc a
CODE_C49248:						; from CODE_C49239
	cmp.b $9F
	bcs CODE_C49250
	stz.b $7F
	stz.b $83
CODE_C49250:						; from CODE_C49239, CODE_C49248
	jsl.l CODE_C37F6D
	lda.b $7F
	sta.w $0B80,x
CODE_C49259:						; from CODE_C48BFC
	ldy.w $14F9,x
	bpl CODE_C49275
	lda.w $0B80,x
	sta.b $87
	sec
	sbc.w #$0007
	beq CODE_C4926E
	bmi CODE_C4926E
	jmp.w CODE_C458E4
CODE_C4926E:						; from CODE_C49259
	jml.l CODE_C45ABE
CODE_C49272:						; from CODE_C49276, CODE_C4928F, CODE_C492A0, CODE_C492C1
	jmp.w CODE_C4918A
CODE_C49275:						; from CODE_C49259
	rtl
CODE_C49276:						; from CODE_C48FDA
	lda.w $05A0
	bpl CODE_C49272
	lda.w $07B6
	bit.w #$0004
	bne CODE_C49272
	lda.w $0830
	bit.w #$8000
	beq CODE_C4928F
	eor.w #$FFFF
	inc a
CODE_C4928F:						; from CODE_C49276
	cmp.w #$0068
	bmi CODE_C49272
	lda.w $09DC
	bit.w #$8000
	beq CODE_C492A0
	eor.w #$FFFF
	inc a
CODE_C492A0:						; from CODE_C4928F
	cmp.w #$3800
	bmi CODE_C49272
	lda.w $08B2
	cmp.w #$00BE
	bpl CODE_C492B5
	lda.w $08B2
	cmp.w #$FF42
	bpl CODE_C49272
CODE_C492B5:						; from CODE_C492A0
	lda.w $09DC
	ldy.w $0FE0,x
	beq CODE_C492C1
	eor.w #$FFFF
	inc a
CODE_C492C1:						; from CODE_C492B5
	cmp.w #$FC00
	bmi CODE_C49272
	stz.b $67
	lda.w #$0002
	sta.b $6B
	lda.w $1020,x
	beq CODE_C492D9
	stz.b $6B
	lda.w #$0002
	sta.b $67
CODE_C492D9:						; from CODE_C492C1
	ldy.b $67
	lda.w $12CF,y
	cmp.w #$0064
	bcc CODE_C492F5
	ldy.b $6B
	lda.w $12CF,y
	cmp.w #$0064
	bcc CODE_C492F5
	lda.w #$000F
	sta.b $7F
	jmp.w CODE_C43734
CODE_C492F5:						; from CODE_C492D9
	jmp.w CODE_C4918A

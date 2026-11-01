; Segment bankC4_8000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C47FB5
updatepentime:						; called from other segments
	lda.w #$0020
	trb.w sflags3
	lda.w gmclock
	beq CODE_C47FC3
	jmp.w CODE_C48050
CODE_C47FC3:						; from updatepentime
	lda.w PenShotActive
	beq CODE_C47FCB
	jmp.w CODE_C48050
CODE_C47FCB:						; from CODE_C47FC3
	lda.w Penaltytimer
	ldy.b d7
	dey
	beq CODE_C47FD4
	dec a
CODE_C47FD4:						; from CODE_C47FCB
	dec a
	sta.w Penaltytimer
	bpl CODE_C48050
	clc
	adc.w #$0018
	sta.w Penaltytimer
	lda.w #$0020
	tsb.w sflags3
	jsl.l chkatop
	jsl.l CountPowerPlayTime
	stz.b a2
	jsl.l CODE_C47FFA
	lda.w #$0002
	sta.b a2
CODE_C47FFA:						; from CODE_C47FD4 and other segments
	lda.b a2
	beq CODE_C48001
	lda.w #$001A
CODE_C48001:						; from CODE_C47FFA
	sta.b a0
	stz.b $69
	lda.w #$04F5
	sta.b a1
	lda.w #$0002
	sta.b d1
	sta.b d3
CODE_C48011:						; from CODE_C48029, CODE_C4804E, CODE_C48090
	ldy.b a0
	lda.w tmboxlist,y
	inc.b a0
	and.w #$00FF
	sta.b d0
	bit.w #$0080
	bne CODE_C48051
	lda.b a2
	beq CODE_C48029
	lda.w #$0034
CODE_C48029:						; from CODE_C48011
	clc
	adc.b d0
	tay
	lda.w tmpdst,y
	bit.w #$4000
	bne CODE_C48090
	dec.b d1
	bmi CODE_C48011
	lda.b d0
	sta.b [a1]
	inc.b a1
	inc.b a1
	lda.w tmpdst,y
	dec a
	sta.w tmpdst,y
	bne CODE_C4804E
	jsl.l CODE_C45A9F
CODE_C4804E:						; from CODE_C48029
	bra CODE_C48011
CODE_C48050:						; from updatepentime, CODE_C4807A, CODE_C47FC3, CODE_C47FD4, ...
	rtl
CODE_C48051:						; from CODE_C48011
	lda.w $04F5
	sta.b d0
	lda.b d1
	cmp.w #$0001
	beq CODE_C48073
	lda.b d1
	bne CODE_C48067
	jsl.l CODE_C48073
	bra CODE_C4806E
CODE_C48067:						; from CODE_C48051
	lda.b d1
	cmp.w #$FFFF
	bne CODE_C48050
CODE_C4806E:						; from CODE_C48051
	lda.w $04F7
	sta.b d0
CODE_C48073:						; from CODE_C48051 and other segments
	lda.b a2
	beq CODE_C4807A
	lda.w #$0034
CODE_C4807A:						; from CODE_C48073
	clc
	adc.b d0
	tay
	lda.w tmpdst,y
	cmp.w #$0006
	bpl CODE_C48050
	lda.w tmpdst,y
	bne CODE_C4808F
	jsl.l CODE_C480E4
CODE_C4808F:						; from CODE_C4807A
	rtl
CODE_C48090:						; from CODE_C48029
	dec a
	sta.w tmpdst,y
	bit.w #$0800
	bne CODE_C4809C
	jmp.w CODE_C48011
CODE_C4809C:						; from CODE_C48090
	bit.w #$1000
	bne CODE_C480AB
	lda.w #$1000
	sta.w tmpdst,y
	jml.l CODE_C45A9F
CODE_C480AB:						; from CODE_C4809C
	lda.w #$0000
	sta.w tmpdst,y
	jml.l CODE_C45A9F
PenShotChk:							; called from other segments
	lda.w gmode
	bit.w #$0010
	bne CODE_C480E0
	lda.b a2
	cmp.w puckc
	bne CODE_C480E0
	lda.w breakaway
	bne CODE_C480CC
	jmp.w CODE_C480E0
CODE_C480CC:						; from PenShotChk
	jsl.l CheckBreakaway
	lda.w IsBreakaway
	sta.w breakaway
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
	ldy.b a2
	ldx.w tmsort,y
	dex
	dex
CODE_C4810B:						; from CODE_C4810B
	inx
	inx
	lda.w position,x
	bpl CODE_C4810B
	lda.b d0
	lsr a
	sta.b d3
	ldy.b a2
	lda.w tmap,y
	sta.b d1
	inc a
	sta.w tmap,y
	lda.w #$0001
	tsb.w tmflags
	tsb.w $1301
	lda.w #$00C0
	sta.b $65
	lda.w #$9B2A
	sta.b a0
	lda.w tmgoalie,y
	bpl CODE_C4813C
	inc.b a0
CODE_C4813C:						; from CODE_C4810B
	ldy.b d1
	lda.b [a0],y
	and.w #$00FF
	sta.w position,x
	stx.b a3
	jsl.l Setplass
	jsl.l setplayer
	lda.w pflags,x
	ora.w #$1000
	sta.w pflags,x
	pla
	sta.b $71
	pla
	sta.b a3
	pla
	sta.b $6D
	pla
	sta.b a2
	pla
	sta.b $69
	pla
	sta.b a1
	pla
	sta.b $65
	pla
	sta.b a0
	pla
	sta.b $8D
	pla
	sta.b d3
	pla
	sta.b $89
	pla
	sta.b d2
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
	ldx.b a3
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
	sta.b d0
	lda.w playerpad,x
	bmi CODE_C481AD
	asl.b d0
CODE_C481AD:						; from checkagr
	lda.w Xpos,x
	sec
	sbc.w $0830
	cmp.w #$FFD7
	bmi CODE_C481D1
	cmp.w #$0029
	bpl CODE_C481D1
	lda.w Ypos,x
	sec
	sbc.w pucky
	cmp.w #$FFD7
	bmi CODE_C481D1
	cmp.w #$0029
	bpl CODE_C481D1
	lsr.b d0
CODE_C481D1:						; from CODE_C481AD
	jml.l CODE_C37EBF
CODE_C481D5:						; called from other segments
	lda.w $234A
	beq CODE_C481DD
	stz.w $234A
CODE_C481DD:						; from CODE_C481D5
	ldx.b d0
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
setInjuryType:						; called from other segments
	ldy.b a2
	lda.w pflags,y
	ora.w #$1000
	sta.w pflags,y
	lda.l $7E24CA
	clc
	adc.w #$012C
	sta.l $7E24CA
	lda.w #$003C
	sta.b crowdhold
	lda.w #$000A
	jsl.l CODE_CF040B
	ldy.b a2
	lda.w Xpos,y
	sta.w xc1
	lda.w Ypos,y
	sta.w yc1
	lda.w #$0040
	tsb.w sflags
	stz.b d1
	stz.b a0
	lda.w pfteam,y
	beq CODE_C48294
	lda.w #$8000
	sta.b d1
	lda.w #$0002
	sta.b a0
CODE_C48294:						; from setInjuryType
	lda.w pnum,y
	and.w #$00FF
	ora.b d1
	sta.w TempPlOffset
	and.w #$00FF
	bit.w #$0080
	beq CODE_C482AA
	ora.w #$FF00
CODE_C482AA:						; from CODE_C48294
	asl a
	sta.b d1
	lda.b a0
	beq CODE_C482B4
	lda.w #$0034
CODE_C482B4:						; from CODE_C482AA
	adc.b d1
	tay
	lda.w #$FFFD
	sta.w tmpdst,y
	lda.w #$0007
	jsl.l CODE_C37EAA
	cmp.w #$0000
	bne CODE_C482D8
	lda.w #$FFFC
	sta.w tmpdst,y
	lda.w TempPlOffset
	ora.w #$4000
	sta.w TempPlOffset
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
	lda.w TempPlOffset
	bit.w #$4000
	beq CODE_C4833E
	and.w #$BFFF
	sta.w TempPlOffset
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
	sta.b a4
	pla
	sta.b $71
	pla
	sta.b a3
	pla
	sta.b $6D
	pla
	sta.b a2
	pla
	sta.b $69
	pla
	sta.b a1
	pla
	sta.b $65
	pla
	sta.b a0
	pla
	sta.b $89
	pla
	sta.b d2
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
	ldx.b a3
	rtl
CODE_C4837C:						; called from other segments
	lda.w gmode
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
	sta.b d0
	ldy.w #$0000
	cpx.w #$000C
	bcc CODE_C483A3
	ldy.w #$000C
CODE_C483A3:						; from CODE_C48387
	sty.b a0
	lda.w #$0060
	sta.b d1
	lda.w pfgoal,x
	beq CODE_C483B2
	jmp.w CODE_C4841C
CODE_C483B2:						; from CODE_C483A3
	lda.w #$FFA0
	sta.b d1
	sec
	sbc.w pucky
	beq CODE_C483BF
	bpl CODE_C483D8
CODE_C483BF:						; from CODE_C483B2, CODE_C483D0
	ldy.b a0
	lda.w position,y
	bmi CODE_C483D0
	lda.b d1
	sec
	sbc.w Ypos,y
	beq CODE_C483D0
	bpl CODE_C48401
CODE_C483D0:						; from CODE_C483BF
	inc.b a0
	inc.b a0
	dec.b d0
	bpl CODE_C483BF
CODE_C483D8:						; from CODE_C483B2, CODE_C4841C, CODE_C48431
	lda.w #$0040
	sta.b d0
	lda.w #$8000
	trb.w sflags
	beq CODE_C483EE
	lda.w $2348
	bne CODE_C483EE
	jsl.l CODE_C58944
CODE_C483EE:						; from CODE_C483D8, CODE_C48401
	pla
	sta.b $65
	pla
	sta.b a0
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
CODE_C48400:						; from CODE_C4837C
	rtl
CODE_C48401:						; from CODE_C483BF, CODE_C48423
	lda.w #$0014
	sta.w tmp0
	lda.w #$8000
	tsb.w sflags
	bne CODE_C483EE
	lda.w $1145
	bpl CODE_C483EE
	phx
	jsl.l CODE_C38CFC
	plx
	bra CODE_C483EE
CODE_C4841C:						; from CODE_C483A3
	lda.b d1
	cmp.w pucky
	bmi CODE_C483D8
CODE_C48423:						; from CODE_C48431
	ldy.b a0
	lda.w position,y
	bmi CODE_C48431
	lda.b d1
	cmp.w Ypos,y
	bmi CODE_C48401
CODE_C48431:						; from CODE_C48423
	inc.b a0
	inc.b a0
	dec.b d0
	bpl CODE_C48423
	bra CODE_C483D8
a2touchpuck:						; called from other segments
	ldy.b a2
	cpy.w #$0018
	bcc CODE_C48445
	jmp.w CODE_C484EC
CODE_C48445:						; from a2touchpuck
	lda.w Xpos,y
	sta.w $2004
	lda.w Ypos,y
	sta.w $2006
	tya
	lsr a
	sta.w $2002
	stz.b a0
	lda.w pfteam,y
	beq CODE_C48461
	inc.b a0
	inc.b a0
CODE_C48461:						; from CODE_C48445
	lda.w pnum,y
	sta.b d0
	ldy.b a0
	cmp.w tmtouch1,y
	beq CODE_C484AA
	lda.w tmflags,y
	bit.w #$0004
	beq CODE_C4848E
	and.w #$FFFB
	sta.w tmflags,y
	cpy.w #$0000
	bne CODE_C4849A
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi CODE_C4848C
	sta.w CwdExciteLvl
CODE_C4848C:						; from CODE_C48461
	bra CODE_C4849A
CODE_C4848E:						; from CODE_C48461
	lda.w tmtouch2,y
	sta.w tmtouch3,y
	lda.w tmtouch1,y
	sta.w tmtouch2,y
CODE_C4849A:						; from CODE_C48461, CODE_C4848C
	lda.b d0
	sta.w tmtouch1,y
	cmp.w tmtouch3,y
	bne CODE_C484AA
	lda.w #$FFFF
	sta.w tmtouch3,y
CODE_C484AA:						; from CODE_C48461, CODE_C4849A
	lda.w #$1000
	trb.w sflags
	jsl.l a2offsides
	ldy.b a2
	lda.w iflags
	bit.w #$0004
	beq CODE_C484F2
	bit.w #$0001
	beq CODE_C484F2
	lda.w position,y
	beq CODE_C484F2
	lda.w iflags
	bit.w #$0002
	bne CODE_C484ED
	lda.w pfgoal,y
	beq CODE_C484F2
CODE_C484D5:						; from CODE_C484ED
	phx
	lda.w $07B7
	and.w #$00FF
	asl a
	sta.b a3
	tax
	lda.w #$000C
	sta.b d0
	jsl.l AddPenalty
	plx
	stx.b a3
CODE_C484EC:						; from a2touchpuck, CODE_C48510, CODE_C4852A
	rtl
CODE_C484ED:						; from CODE_C484AA
	lda.w pfgoal,y
	beq CODE_C484D5
CODE_C484F2:						; from CODE_C484AA
	tya
	lsr a
	xba
	sta.w iflags
	lda.w pucky
	sta.b d0
	lda.w pfgoal,y
	beq CODE_C48510
	lda.w #$0002
	tsb.w iflags
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
CODE_C48510:						; from CODE_C484F2
	lda.b d0
	bmi CODE_C484EC
	lda.w tmap
	sec
	sbc.w $12C9
	sta.b d0
	lda.w pfteam,y
	beq CODE_C4852A
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
CODE_C4852A:						; from CODE_C48510
	lda.b d0
	bmi CODE_C484EC
	lda.w #$0004
	tsb.w iflags
	rtl
a2offsides:							; from CODE_C484AA and other segments
	ldy.b a2
	lda.w gmode
	bit.w #$0020
	beq CODE_C4858F
	lda.w pucky
	sta.b d0
	lda.w pfgoal,y
	bne CODE_C48551
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
CODE_C48551:						; from a2offsides
	lda.b d0
	cmp.w #$005C
	bmi CODE_C4858F
	stz.b a0
	lda.w pfteam,y
	beq CODE_C48564
	lda.w #$0002
	sta.b a0
CODE_C48564:						; from CODE_C48551
	ldy.b a0
	lda.w tmflags,y
	bit.w #$0010
	beq CODE_C4858F
	lda.w gmode
	bit.w #$0010
	bne CODE_C4858F
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	lda.w #$0012
	sta.b d0
	jsl.l AddPenalty
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
CODE_C4858F:						; from a2offsides, CODE_C48551, CODE_C48564
	rtl
CheckBreakaway:						; from StartBreakaway, CODE_C480CC and other segments
	stz.w IsBreakaway
	lda.w puckc
	bpl CODE_C4859B
	jmp.w CODE_C4862B
CODE_C4859B:						; from CheckBreakaway
	lda.w gmode
	bit.w #$0002
	bne CODE_C485AD
	lda.w puckc
	cmp.w #$000C
	bmi CODE_C485EF
	bra CODE_C485B7
CODE_C485AD:						; from CODE_C4859B
	lda.w puckc
	cmp.w #$000C
	bmi CODE_C485B7
	bra CODE_C485EF
CODE_C485B7:						; from CODE_C4859B, CODE_C485AD
	ldy.w puckc
	lda.w Ypos,y
	bpl CODE_C4862B
	sec
	sbc.w #$0004
	sta.b d0
	ldy.w #$0000
	lda.w puckc
	cmp.w #$000C
	bpl CODE_C485D3
	ldy.w #$000C
CODE_C485D3:						; from CODE_C485B7
	lda.w #$0006
	sta.b d2
CODE_C485D8:						; from CODE_C485E7
	lda.w position,y
	bmi CODE_C485E7
	beq CODE_C485E7
	lda.b d0
	sec
	sbc.w Ypos,y
	bpl CODE_C4862B
CODE_C485E7:						; from CODE_C485D8
	iny
	iny
	dec.b d2
	bpl CODE_C485D8
	bra CODE_C48625
CODE_C485EF:						; from CODE_C4859B, CODE_C485AD
	ldy.w puckc
	lda.w Ypos,y
	bmi CODE_C4862B
	clc
	adc.w #$0004
	sta.b d0
	ldy.w #$0000
	lda.w puckc
	cmp.w #$000C
	bpl CODE_C4860B
	ldy.w #$000C
CODE_C4860B:						; from CODE_C485EF
	lda.w #$0006
	sta.b d2
CODE_C48610:						; from CODE_C4861F
	lda.w position,y
	bmi CODE_C4861F
	beq CODE_C4861F
	lda.b d0
	sec
	sbc.w Ypos,y
	bmi CODE_C4862B
CODE_C4861F:						; from CODE_C48610
	iny
	iny
	dec.b d2
	bpl CODE_C48610
CODE_C48625:						; from CODE_C485E7
	stz.w IsBreakaway
	inc.w IsBreakaway
CODE_C4862B:						; from CheckBreakaway, CODE_C485EF, CODE_C48610, CODE_C485B7, ...
	rtl
StartBreakaway:						; called from other segments
	jsl.l CheckBreakaway
	lda.w IsBreakaway
	sta.w breakaway
	beq CODE_C4866C
	lda.w penshot
	bne CODE_C48644
	lda.w #$0001
	jsl.l CODE_CF040B
CODE_C48644:						; from StartBreakaway
	lda.w CwdExciteLvl
	clc
	adc.w #$0014
	bmi CODE_C48650
	sta.w CwdExciteLvl
CODE_C48650:						; from CODE_C48644
	phy
	ldy.w #$0000
	lda.w puckc
	cmp.w #$000C
	bmi CODE_C4865F
	ldy.w #$0002
CODE_C4865F:						; from CODE_C48650
	lda.w penshot
	bne CODE_C4866B
	lda.w $12E3,y
	inc a
	sta.w $12E3,y
CODE_C4866B:						; from CODE_C4865F
	ply
CODE_C4866C:						; from StartBreakaway
	rtl
CODE_C4866D:						; called from other segments
	lda.w penshot
	bne CODE_C486C6
	lda.w BA_Sktr_SCnum
	cmp.w #$000C
	bmi CODE_C48685
	lda.w #$0002
	sta.w BA_Team
	inc.w $12ED
	bra CODE_C4868B
CODE_C48685:						; from CODE_C4866D
	stz.w BA_Team
	inc.w $12EB
CODE_C4868B:						; from CODE_C4866D
	phy
	lda.w BA_Team
	eor.w #$0002
	tay
	lda.w #$0001
	sta.w tmap,y
	ldy.w BA_Team
	lda.w #$0001
	sta.w tmap,y
	ply
	phx
	ldx.w BA_Sktr_SCnum
	lda.w pnum,x
	sta.w $18B2
	plx
	stz.w penshot
	inc.w penshot
	lda.w $2034
	sta.w $18BA
	lda.w $2036
	sta.w $18BC
	stz.w $2034
	stz.w $2036
CODE_C486C6:						; from CODE_C4866D
	rtl
EndPenaltyShot:						; called from other segments
	lda.w PenShotActive
	beq CODE_C486FC
	lda.w penshot
	beq CODE_C486FC
	phx
	jsl.l CODE_C4CEDB
	jsl.l CODE_C4785E
	stz.w PenShotActive
	stz.w penshot
	lda.w #$FFFF
	sta.w BA_Sktr_SCnum
	lda.w #$000A
	sta.b d0
	jsl.l ShootoutWonBy
	lda.w $18BA
	sta.w $2004
	lda.w $18BC
	sta.w $2006
	plx
CODE_C486FC:						; from EndPenaltyShot
	rtl
goalieacc:							; called from other segments
	lda.w #$121E
	sta.b d1
	lda.b d0
	and.w #$000F
	sta.b d0
	cmp.w #$0008
	bcc CODE_C4872A
	ldy.w playerpad,x
	bpl CODE_C48718
	cmp.w #$0009
	bne CODE_C48720
CODE_C48718:						; from goalieacc
	lda.w Xvel,x
	ora.w Yvel,x
	bne CODE_C4876D
CODE_C48720:						; from goalieacc
	lda.w pf2aip,x
	bne CODE_C48729
	jml.l SetSPA
CODE_C48729:						; from CODE_C48720
	rtl
CODE_C4872A:						; from goalieacc
	cpx.w puckc
	beq CODE_C48770
	lda.w asscur,x
	cmp.w #$000C
	beq CODE_C48770
	lda.w Ypos,x
	bit.w #$8000
	beq CODE_C48743
	eor.w #$FFFF
	inc a
CODE_C48743:						; from CODE_C4872A
	cmp.w #$009C
	bcc CODE_C48770
	ldy.w playerpad,x
	bmi CODE_C4875A
	lda.w SPA,x
	cmp.w #$1552
	bcc CODE_C4875A
	cmp.w #$2708
	bcc CODE_C4876D
CODE_C4875A:						; from CODE_C48743
	lda.b d0
	cmp.w facedir,x
	beq CODE_C4879A
	sta.b d2
	lda.w #$121E
	jsl.l SetSPAFromA
	jmp.w CODE_C487C4
CODE_C4876D:						; from CODE_C48718, CODE_C48743
	jmp.w stopna
CODE_C48770:						; from CODE_C4872A, CODE_C48743
	lda.w goalieturnwait,x
	bne CODE_C4879A
	lda.b d0
	sec
	sbc.w facedir,x
	sta.b d0
	beq CODE_C4879A
	eor.w #$FFFF
	inc a
	and.w #$0004
	lsr a
	dec a
	clc
	adc.w facedir,x
	and.w #$0007
	sta.b d0
	sta.w facedir,x
	lda.w #$0006
	sta.w goalieturnwait,x
CODE_C4879A:						; from CODE_C4875A, CODE_C48770
	lda.w goalieturnwait,x
	beq CODE_C487AB
	sec
	sbc.w timestep
	bpl CODE_C487A8
	lda.w #$0000
CODE_C487A8:						; from CODE_C4879A
	sta.w goalieturnwait,x
CODE_C487AB:						; from CODE_C4879A
	lda.w goalieflags,x
	bit.w #$0002
	bne CODE_C487B8
	lda.w #$121E
	bra CODE_C487BB
CODE_C487B8:						; from CODE_C487AB
	lda.w #$14C0
CODE_C487BB:						; from CODE_C487AB
	jsl.l SetSPAFromA
	lda.w facedir,x
	sta.b d2
CODE_C487C4:						; from CODE_C4875A
	lda.w playerpad,x
	bmi CODE_C487E7
	lda.w $0E20,x
	pha
	lsr a
	sta.b tmp0
	lsr a
	lsr a
	sta.b tmp1
	sec
	lda.b tmp0
	sbc.b tmp1
	sta.w $0E20,x
	phx
	jsl.l CODE_C45ABE
	plx
	pla
	sta.w $0E20,x
	rtl
CODE_C487E7:						; from CODE_C487C4
	jml.l CODE_C45ABE
ChkGoalies:							; called from other segments
	lda.w gmclock
	bne rtss
	stz.b a2
	lda.w #$0002
	sta.b a1
	jsl.l CODE_C48802
	stz.b a1
	lda.w #$0002
	sta.b a2
CODE_C48802:						; from ChkGoalies and other segments
	ldy.b a2
	lda.w tmgoalie,y
	bmi rtss
	ldx.w tmsort,y
	ldy.w puckc
	bmi rtss
	lda.w pfteam,y
	cmp.w pfteam,x
	bne rtss
	ldy.b a2
	lda.w gmode
	bit.w #$0008
	bne CODE_C48832
	lda.w teampads,y
	bne rtss
	lda.w pucky
	sta.b d1
	jsl.l CPgoalie
	rtl
CODE_C48832:						; from CODE_C48802
	lda.w tmgoalie,y
	ora.w #$FF00
	sta.w tmgoalie,y
	jsl.l setpersonel
rtss:								; an rtl: asstab entry 0 (no assignment), as 94S rtss
	rtl
ReturnGoalies:						; called from other segments
	stz.b a2
	lda.w #$0002
	sta.b a1
	jsl.l CODE_C48852
	stz.b a1
	lda.w #$0002
	sta.b a2
CODE_C48852:						; from ReturnGoalies and other segments
	ldy.b a2
	lda.w tmgoalie,y
	bpl CODE_C48871
	and.w #$00FF
	cmp.w #$000A
	bcs CODE_C48871
	sta.w tmgoalie,y
	lda.w teampads,y
	bne CODE_C48871
	lda.w $2036
	sta.b d1
	jmp.w CPgoalie
CODE_C48871:						; from CODE_C48852
	rtl
CPgoalie:							; from CODE_C48802, CODE_C48852 and other segments
	lda.w gsp
	cmp.w #$0002
	bne CODE_C488BA
	ldy.b a1
	lda.w tmscore,y
	ldy.b a2
	sec
	sbc.w tmscore,y
	bmi CODE_C488BA
	beq CODE_C488BA
	cmp.w #$0003
	bcs CODE_C488BA
	lda.w gameclock
	cmp.w #$003D
	bcs CODE_C488BA
	lda.w tmsort,y
	tay
	lda.w pfgoal,y
	bne CODE_C488A7
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
CODE_C488A7:						; from CPgoalie
	lda.b d1
	bmi CODE_C488BA
	ldy.b a2
	lda.w tmgoalie,y
	ora.w #$FF00
	sta.w tmgoalie,y
	jml.l setpersonel
CODE_C488BA:						; from CPgoalie, CODE_C488A7
	rtl
CODE_C488BB:						; called from other segments
	lda.w #$0006
	ora.w goalieflags,x
	sta.w goalieflags,x
	lda.w Xpos,x
	cmp.w #$FFD8
	bmi CODE_C488F2
	cmp.w #$0029
	bpl CODE_C488F2
	lda.w Ypos,x
	bit.w #$8000
	beq CODE_C488DD
	eor.w #$FFFF
	inc a
CODE_C488DD:						; from CODE_C488BB
	sta.b r0
	cmp.w #$00EB
	bmi CODE_C488F2
	cmp.w #$010A
	bpl CODE_C488F2
	lda.w #$FFFB
	and.w goalieflags,x
	sta.w goalieflags,x
CODE_C488F2:						; from CODE_C488BB, CODE_C488DD
	lda.w Xpos,x
	cmp.w #$FFD0
	bmi CODE_C48919
	cmp.w #$0031
	bpl CODE_C48919
	lda.w Ypos,x
	bit.w #$8000
	beq CODE_C4890B
	eor.w #$FFFF
	inc a
CODE_C4890B:						; from CODE_C488F2
	cmp.w #$00EB
	bmi CODE_C48919
	lda.w #$FFFD
	and.w goalieflags,x
	sta.w goalieflags,x
CODE_C48919:						; from CODE_C488F2, CODE_C4890B
	lda.w playerpad,x
	bpl CODE_C48956
	lda.w gmclock
	bne CODE_C48956
	jsl.l check4bench
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C4893B
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w $0692
CODE_C4893B:						; from CODE_C48919
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl CODE_C4898F
	lda.w aidef,x
	lsr a
	lsr a
	clc
	adc.w temp1,x
	bpl CODE_C48959
	lda.w #$0000
	bra CODE_C48959
CODE_C48956:						; from CODE_C48919, CODE_C48959, CODE_C4896D, CODE_C48985
	jmp.w assexit
CODE_C48959:						; from CODE_C4893B
	sta.w temp1,x
	lda.w puckc
	bpl CODE_C48956
	lda.w puckvy
	ldy.w pfgoal,x
	beq CODE_C4896D
	eor.w #$FFFF
	inc a
CODE_C4896D:						; from CODE_C48959
	cmp.w #$F800
	bmi CODE_C48956
	stz.b a1
	lda.w #$0002
	sta.b a2
	lda.w pfteam,x
	beq CODE_C48985
	stz.b a2
	lda.w #$0002
	sta.b a1
CODE_C48985:						; from CODE_C4896D
	ldy.b a2
	lda.w $12CF,y
	cmp.w #$0046
	bcc CODE_C48956
CODE_C4898F:						; from CODE_C4893B
	jsr.w GoaliePuckVector
	jsl.l vtoa
	jsl.l AdjustFacingDirection
	asl.w $0E00,x
	jsl.l CODE_C489A5
	lsr.w $0E00,x
	rtl
CODE_C489A5:						; from CODE_C4898F and other segments
	lda.w temp2,x
	sec
	sbc.b d7
	sta.w temp2,x
	bmi CODE_C489B3
	jmp.w CODE_C48A38
CODE_C489B3:						; from CODE_C489A5
	adc.w #$0005
	sta.w temp2,x
	lda.w puckvx
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C489C8
	ora.w #$FF00
CODE_C489C8:						; from CODE_C489B3
	clc
	adc.w $0830
	sta.b d0
	lda.w puckvy
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C489DD
	ora.w #$FF00
CODE_C489DD:						; from CODE_C489C8
	clc
	adc.w pucky
	sta.b d1
	jsl.l CODE_C46BF6
	pei ($83)
	lda.b d0
	pha
	txa
	jsl.l CODE_C37FE2
	lda.b d0
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
	sbc.w Xpos,x
	sta.b d0
	lda.b d1
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
	sbc.w Ypos,x
	sta.b d1
	pla
	pla
	jsl.l vtoa
	lda.b d0
	sta.w temp2b,x
CODE_C48A38:						; from CODE_C489A5
	lda.w temp2b,x
	sta.b d0
	jml.l doplayeracc
CODE_C48A41:						; called from other segments
	ldy.b a2
	stz.b d0
	lda.w #$00C3
	sta.b tmp1
	lda.w $17D3,y
	sta.b tmp0
	ldy.w #$0008
	clc
	adc.b [tmp0],y
	sta.b tmp0
	lda.b [tmp0]
	xba
CODE_C48A5A:						; from CODE_C48A5A
	inc.b d0
	asl a
	asl a
	asl a
	asl a
	bne CODE_C48A5A
	rtl
AdvanceStringPtr:					; no caller found (not traced)
	bra CODE_C48A6C
CODE_C48A65:						; from CODE_C48A6C
	lda.b a1
	clc
	adc.b [a1]
	sta.b a1
CODE_C48A6C:						; from AdvanceStringPtr
	dec.b d0
	bpl CODE_C48A65
	rtl
CODE_C48A71:						; called from other segments
	lda.w #$0006
	ora.w goalieflags,x
	sta.w goalieflags,x
	lda.w Xpos,x
	cmp.w #$FFD8
	bmi CODE_C48AA8
	cmp.w #$0029
	bpl CODE_C48AA8
	lda.w Ypos,x
	bit.w #$8000
	beq CODE_C48A93
	eor.w #$FFFF
	inc a
CODE_C48A93:						; from CODE_C48A71
	sta.b r0
	cmp.w #$00EB
	bmi CODE_C48AA8
	cmp.w #$010A
	bpl CODE_C48AA8
	lda.w #$FFFB
	and.w goalieflags,x
	sta.w goalieflags,x
CODE_C48AA8:						; from CODE_C48A71, CODE_C48A93
	lda.w Xpos,x
	cmp.w #$FFD0
	bmi CODE_C48AD1
	cmp.w #$0031
	bpl CODE_C48AD1
	lda.w Ypos,x
	bit.w #$8000
	beq CODE_C48AC1
	eor.w #$FFFF
	inc a
CODE_C48AC1:						; from CODE_C48AA8
	sta.b r0
	cmp.w #$00EB
	bmi CODE_C48AD1
	lda.w #$FFFD
	and.w goalieflags,x
	sta.w goalieflags,x
CODE_C48AD1:						; from CODE_C48AA8, CODE_C48AC1
	jsl.l check4bench
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C48AF5
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
	lda.w #$FFFF
	sta.w temp4,x
CODE_C48AF5:						; from CODE_C48AD1
	ldy.w playerpad,x
	bpl CODE_C48B48
	lda.w Xpos,x
	cmp.w #$FFCB
	bmi CODE_C48B1D
	cmp.w #$0035
	bpl CODE_C48B1D
	lda.w Ypos,x
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
	sta.b a0
	ldy.w #$0004
	lda.w Xpos,x
	bpl CODE_C48B32
	ldy.w #$FFFC
CODE_C48B32:						; from CODE_C48B1D
	sty.b d0
	lda.w #$00FA
	sta.b d1
	lda.w pfgoal,x
	beq CODE_C48B43
	lda.w #$FF06
	sta.b d1
CODE_C48B43:						; from CODE_C48B32
	jml.l skateto
DATA8_C48B47:						; an rtl no traced code reaches
	db $6B
CODE_C48B48:						; from CODE_C48AF5
	lda.w gmclock
	bne CODE_C48B55
	cpx.w puckc
	beq CODE_C48B55
	jmp.w CODE_C48B8E
CODE_C48B55:						; from CODE_C48B48
	lda.w goalieflags,x
	ora.w #$0001
	sta.w goalieflags,x
CODE_C48B5E:						; from CODE_C48B13, CODE_C48B8E
	jmp.w CODE_C48BAA
CODE_C48B61:						; from CODE_C48B8E
	lda.w #rtss>>16
	sta.b $65
	lda.w #rtss
	sta.b a0
	ldy.w #$0004
	lda.w Xpos,x
	bpl CODE_C48B76
	ldy.w #$FFFC
CODE_C48B76:						; from CODE_C48B61
	sty.b d0
	lda.w #$00FF
	sta.b d1
	lda.w pfgoal,x
	beq CODE_C48B87
	lda.w #$FF01
	sta.b d1
CODE_C48B87:						; from CODE_C48B76
	stz.w temp2,x
	jml.l skateto
CODE_C48B8E:						; from CODE_C48B48
	lda.w goalieflags,x
	bit.w #$0001
	bne CODE_C48B5E
	bit.w #$0002
	bne CODE_C48B61
	ldy.w playerpad,x
	lda.w paddir,y
	cmp.w #$0008
	bne CODE_C48BAA
	jsl.l stopna
CODE_C48BAA:						; from CODE_C48B5E, CODE_C48B8E
	lda.w pf2aip,x
	bne CODE_C48BB6
	lda.w #$121E
	jsl.l SetSPAFromA
CODE_C48BB6:						; from CODE_C48BAA
	lda.w gmclock
	bne CODE_C48BDF
	lda.w temp5,x
	bmi CODE_C48BF4
	cpx.w puckc
	bne CODE_C48BD7
	lda.w Ypos,x
	cmp.w #$00BB
	bpl CODE_C48BE0
	cmp.w #$FF45
	bmi CODE_C48BE0
	stz.w temp5,x
	bra CODE_C48BE0
CODE_C48BD7:						; from CODE_C48BB6
	lda.w #$FFFF
	sta.w temp5,x
	bra CODE_C48BF4
CODE_C48BDF:						; from CODE_C48BB6, CODE_C48BF4
	rtl
CODE_C48BE0:						; from CODE_C48BB6
	lda.w temp5,x
	sec
	sbc.b d7
	sta.w temp5,x
	bpl CODE_C48BF4
	lda.w #$0008
	sta.b d0
	jsl.l AddPenalty2
CODE_C48BF4:						; from CODE_C48BB6, CODE_C48BD7, CODE_C48BE0
	lda.w pf2aip,x
	beq CODE_C48BFC
	jmp.w CODE_C48BDF
CODE_C48BFC:						; from CODE_C48BF4
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bmi CODE_C48C0A
	jmp.w CODE_C49259
CODE_C48C0A:						; from CODE_C48BFC
	lda.w aidef,x
	lsr a
	clc
	adc.w temp1,x
	cmp.w #$0000
	bpl CODE_C48C1A
	lda.w #$0000
CODE_C48C1A:						; from CODE_C48C0A
	sta.w temp1,x
	lda.w playerpad,x
	bpl CODE_C48C54
	lda.w pucky
	sta.b d0
	lda.w Ypos,x
	eor.b d0
	sta.b d1
	bpl CODE_C48C44
	stz.b d0
	lda.w #$00FA
	sta.b d2
	lda.w pfgoal,x
	beq CODE_C48C41
	lda.w #$FF06
	sta.b d2
CODE_C48C41:						; from CODE_C48C1A
	jmp.w CODE_C4918A
CODE_C48C44:						; from CODE_C48C1A
	dec.w temp4,x
	bpl CODE_C48C4F
	lda.w #$FFFF
	sta.w temp4,x
CODE_C48C4F:						; from CODE_C48C44
	cpx.w puckc
	beq CODE_C48C57
CODE_C48C54:						; from CODE_C48C1A
	jmp.w CODE_C48CE7
CODE_C48C57:						; from CODE_C48C4F
	lda.w temp5,x
	bpl CODE_C48C62
	lda.w #$005A
	sta.w temp5,x
CODE_C48C62:						; from CODE_C48C57
	lda.w #$FFFF
	sta.w temp4,x
	lda.w temp5,x
	sec
	sbc.w #$005A
	bpl CODE_C48CB4
	jsl.l RandomWord
	cmp.w #$C000
	bcc CODE_C48CB4
	lda.w #$0005
	sta.b d0
	stz.b a0
	lda.w pfteam,x
	bne CODE_C48C8B
	lda.w #$000C
	sta.b a0
CODE_C48C8B:						; from CODE_C48C62, CODE_C48C9D
	ldy.b a0
	lda.w pflags,y
	bit.w #$1000
	bne CODE_C48C9D
	lda.w $05E4,y
	cmp.w #$0023
	bcc CODE_C48CB7
CODE_C48C9D:						; from CODE_C48C8B
	inc.b a0
	inc.b a0
	dec.b d0
	bpl CODE_C48C8B
	lda.w #$0001
	sta.w $07EE
	jsl.l chk4pass
	lda.w puckc
	bmi CODE_C48CCC
CODE_C48CB4:						; from CODE_C48CE7, CODE_C48C62, CODE_C48CB7
	jmp.w CODE_C48DEE
CODE_C48CB7:						; from CODE_C48C8B
	ldy.w #$0000
	cmp.w #$0014
	bcs CODE_C48CB4
	lda.w #$005A
	sta.w pf2aip,x
	lda.w #$1636
	jsl.l SetSPAFromA
CODE_C48CCC:						; from CODE_C48C9D
	rtl
CODE_C48CCD:						; from CODE_C48CE7, CODE_C48D39
	jsl.l vtoa
	lda.b d0
CODE_C48CD3:						; from CODE_C48CE7
	sta.w facedir,x
	sta.w pfalock,x
	lda.w #$15C4
	jsl.l SetSPAFromA
	lda.w #$00F0
	sta.w $06B4,x
	rtl
CODE_C48CE7:						; from CODE_C48C54
	ldy.w playerpad,x
	bmi CODE_C48D39
	lda.w $05A4,y
	cmp.w #$0001
	bne CODE_C48D39
	cpx.w puckc
	beq CODE_C48CB4
	lda.w $0830
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w pucky
	sec
	sbc.w Ypos,x
	sta.b d1
	lda.w PadRaw1,y
	bit.w #$4000
	bne CODE_C48D28
	lda.w padnew,y
	bit.w #$0040
	beq CODE_C48CB4
	lda.w paddir,y
	cmp.w #$0008
	beq CODE_C48CCD
	and.w #$0007
	bra CODE_C48CD3
CODE_C48D28:						; from CODE_C48CE7
	lda.w paddir,y
	cmp.w #$0008
	bne CODE_C48D33
	jmp.w CODE_C48DB6
CODE_C48D33:						; from CODE_C48D28
	and.w #$0007
	jmp.w CODE_C48DBC
CODE_C48D39:						; from CODE_C48CE7
	lda.w $0830
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w pucky
	sec
	sbc.w Ypos,x
	sta.b d1
	lda.w puckc
	bmi CODE_C48D80
	lsr a
	tay
	lda.w pfteam,y
	cmp.w pfteam,x
	beq CODE_C48DB3
	lda.w $06B4,x
	bne CODE_C48DB3
	jsl.l RandomWord
	cmp.w #$0A00
	bcs CODE_C48DB3
	lda.w $05E4,x
	cmp.w #$0023
	bcs CODE_C48DEE
	lda.w pucky
	cmp.w #$FEF1
	bmi CODE_C48DEE
	cmp.w #$010F
	bpl CODE_C48DEE
	jmp.w CODE_C48CCD
CODE_C48D80:						; from CODE_C48D39
	lda.w temp4,x
	bne CODE_C48DB3
	lda.w $05E4,x
	cmp.w #$002D
	bcs CODE_C48DEE
	lda.w pucky
	cmp.w #$FEF1
	bmi CODE_C48DEE
	cmp.w #$010F
	bpl CODE_C48DEE
	lda.b a2
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
	jsl.l vtoa
	lda.b d0
CODE_C48DBC:						; from CODE_C48D33
	sta.w facedir,x
	ldy.w #$1552
	tya
	jsl.l SetSPAFromA
	lda.w #$0168
	sta.w $06B4,x
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi CODE_C48DD9
	sta.w CwdExciteLvl
CODE_C48DD9:						; from CODE_C48DBC
	lda.w #$0096
	sta.w pfalock,x
	clc
	adc.l $7E24CA
	sta.l $7E24CA
	lda.w #$001E
	sta.b crowdhold
	rtl
CODE_C48DEE:						; from CODE_C48CB4, CODE_C48D39, CODE_C48D80, CODE_C48DB3
	lda.w pfgoal,x
	bne CODE_C48E06
	stz.b $65
	lda.w #$07D8
	sta.b a0
	lda.w #$010A
	sta.b d3
	lda.w #$010E
	sta.b d4
	bra CODE_C48E15
CODE_C48E06:						; from CODE_C48DEE
	lda.w #$07DC
	sta.b a0
	lda.w #$FEF6
	sta.b d3
	lda.w #$FEF2
	sta.b d4
CODE_C48E15:						; from CODE_C48DEE
	cpx.w puckc
	beq CODE_C48E27
	jsr.w GoaliePuckVector
	jsl.l vtoa
	jsl.l AdjustFacingDirection
	bra CODE_C48E3A
CODE_C48E27:						; from CODE_C48E15
	lda.w playerpad,x
	bpl CODE_C48E3A
	lda.w pfgoal,x
	eor.w #$0001
	asl a
	asl a
	sta.b d0
	jsl.l AdjustFacingDirection
CODE_C48E3A:						; from CODE_C48E15, CODE_C48E27
	lda.w Ypos,x
	cmp.w #$FEF5
	bmi CODE_C48E68
	cmp.w #$010B
	bpl CODE_C48E68
CODE_C48E47:						; from CODE_C48E68
	lda.w $0830
	sta.b d0
	lda.w pucky
	sta.b d1
	jsl.l CODE_C492F8
	lda.b d1
	cmp.w #$FFD2
	bmi CODE_C48E90
	cmp.w #$002E
	bpl CODE_C48E90
	pei ($83)
	pei ($7F)
	jmp.w CODE_C48F2A
CODE_C48E68:						; from CODE_C48E3A
	lda.w playerpad,x
	bpl CODE_C48E47
	stz.b d2
	stz.b d0
	lda.w Xpos,x
	cmp.w #$FFD3
	bmi CODE_C48E8D
	cmp.w #$002D
	bpl CODE_C48E8D
	lda.w #$009B
	sta.b d0
	lda.w Xpos,x
	bpl CODE_C48E8D
	lda.w #$FF65
	sta.b d0
CODE_C48E8D:						; from CODE_C48E68
	jmp.w CODE_C4918A
CODE_C48E90:						; from CODE_C48E47
	lda.w puckvy
	xba
	lsr a
	and.w #$007F
	bit.w #$0040
	beq CODE_C48EA0
	ora.w #$FF80
CODE_C48EA0:						; from CODE_C48E90
	sta.b r3
	cmp.w #$8000
	ror a
	adc.b r3
	clc
	adc.w pucky
	sta.b d1
	lda.b d1
	cmp.w #$00E6
	bpl CODE_C48EBC
	lda.b d1
	cmp.w #$FF1A
	bpl CODE_C48F05
CODE_C48EBC:						; from CODE_C48EA0
	lda.w passReceiverPlayerNum
	bpl CODE_C48EED
	lda.w puckc
	bmi CODE_C48EED
	lda.w seed
	and.w #$0180
	beq CODE_C48F0D
CODE_C48ECE:						; from CODE_C48F05
	lda.w puckvx
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C48EDD
	ora.w #$FF00
CODE_C48EDD:						; from CODE_C48ECE
	sta.b r3
	cmp.w #$8000
	ror a
	adc.b r3
	clc
	adc.w $0830
	sta.b d0
	bra CODE_C48F22
CODE_C48EED:						; from CODE_C48EBC
	lda.w puckvx
	xba
	lsr a
	and.w #$007F
	bit.w #$0040
	beq CODE_C48EFD
	ora.w #$FF80
CODE_C48EFD:						; from CODE_C48EED
	clc
	adc.w $0830
	sta.b d0
	bra CODE_C48F22
CODE_C48F05:						; from CODE_C48EA0
	lda.w seed
	and.w #$0380
	beq CODE_C48ECE
CODE_C48F0D:						; from CODE_C48EBC
	lda.w puckvx
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C48F1C
	ora.w #$FF00
CODE_C48F1C:						; from CODE_C48F0D
	clc
	adc.w $0830
	sta.b d0
CODE_C48F22:						; from CODE_C48EDD, CODE_C48EFD
	jsl.l CODE_C492F8
	pei ($83)
	pei ($7F)
CODE_C48F2A:						; from CODE_C48E47
	lda.b d0
	ldy.b d1
	jsl.l ApproxLength
	sta.b d0
	cmp.w #$001E
	bcs CODE_C48F41
	pla
	sta.b d0
	pla
	sta.b d1
	bra CODE_C48F8C
CODE_C48F41:						; from CODE_C48F2A
	lda.b d0
	inc a
	sta.b d2
	lda.w #$0014
	sta.b d4
	lda.w sflags
	bit.w #$0008
	beq CODE_C48F58
	lda.w #$001C
	sta.b d4
CODE_C48F58:						; from CODE_C48F41
	pla
	sta.b d0
	pla
	sta.b d1
	tax
	lda.b d4
	jsl.l Mul16x8XS
	lda.b d2
	sta.b r1
	jsl.l Div32S
	lda.b r0
	sta.b d1
	lda.b d4
	adc.w #$0006
	sta.b d4
	ldx.b d0
	jsl.l Mul16x8XS
	lda.b d2
	sta.b r1
	jsl.l Div32S
	lda.b r0
	sta.b d0
	ldx.b curobj
CODE_C48F8C:						; from CODE_C48F2A
	lda.b d1
	clc
	adc.b d3
	sta.b d1
	sta.b d2
	ldy.w playerpad,x
	bmi CODE_C48FAA
	cpx.w puckc
	beq CODE_C48FA7
	lda.w PadRaw1,y
	bit.w #$0080
	bne CODE_C48FDD
CODE_C48FA7:						; from CODE_C48F8C
	jmp.w CODE_C49165
CODE_C48FAA:						; from CODE_C48F8C
	ldy.w #$0002
	lda.b [a0],y
	cmp.w #$0023
	bcc CODE_C48FB7
	jmp.w CODE_C4918A
CODE_C48FB7:						; from CODE_C48FAA
	lda.b [a0]
	cmp.w #$FFE7
	bmi CODE_C48FDA
	cmp.w #$0019
	bpl CODE_C48FDA
	lda.b [a0],y
	cmp.w #$0013
	bcs CODE_C48FD7
	lda.w pucky
	cmp.w #$FEF1
	bmi CODE_C48FD7
	cmp.w #$010F
	bmi CODE_C48FDD
CODE_C48FD7:						; from CODE_C48FB7
	jmp.w CODE_C49165
CODE_C48FDA:						; from CODE_C48FB7
	jmp.w CODE_C49276
CODE_C48FDD:						; from CODE_C48F8C, CODE_C48FB7
	lda.w Xvel,x
	cmp.w #$8000
	ror a
	sta.w Xvel,x
	lda.w Yvel,x
	cmp.w #$8000
	ror a
	sta.w Yvel,x
	lda.w goalieflags,x
	bit.w #$0002
	beq CODE_C48FFC
	jmp.w CODE_C490CB
CODE_C48FFC:						; from CODE_C48FDD
	lda.w puckvx
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
	sbc.w Xpos,x
	sta.b d0
	sta.b $2E
	bit.w #$8000
	beq CODE_C49022
	eor.w #$FFFF
	inc a
CODE_C49022:						; from CODE_C4900D
	sta.b r0
	lda.w puckvy
	xba
	lsr a
	lsr a
	and.w #$003F
	bit.w #$0020
	beq CODE_C49035
	ora.w #$FFC0
CODE_C49035:						; from CODE_C49022
	clc
	adc.w pucky
	sec
	sbc.w Ypos,x
	sta.b d1
	bit.w #$8000
	beq CODE_C49048
	eor.w #$FFFF
	inc a
CODE_C49048:						; from CODE_C49035
	sta.b r1
	jsl.l vtoa
	lda.b d0
	cmp.w #$0008
	beq CODE_C49078
	sec
	sbc.w facedir,x
	and.w #$0007
	sta.b d3
	beq CODE_C49078
	jmp.w CODE_C490D9
CODE_C49063:						; from CODE_C490D9
	lda.w puckvy
	cmp.w #$0800
	bpl CODE_C49078
	cmp.w #$F800
	bmi CODE_C49078
	lda.w #$0008
	sta.b d0
	jmp.w CODE_C4913D
CODE_C49078:						; from CODE_C49048, CODE_C490CB, CODE_C49063
	lda.w facedir,x
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
	lda.w seed
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
	lda.b r0
	cmp.b r1
	bpl CODE_C490AB
	bra CODE_C490A2
CODE_C490B8:						; from CODE_C49078
	lda.b r1
	cmp.b r0
	bpl CODE_C490AB
	bra CODE_C490A2
CODE_C490C0:						; from CODE_C490FE
	lda.b d0
	clc
	adc.w #$0006
	sta.b d0
	jmp.w CODE_C4913D
CODE_C490CB:						; from CODE_C48FDD
	lda.w puckdir,x
	sec
	sbc.w facedir,x
	and.w #$0007
	sta.b d3
	beq CODE_C49078
CODE_C490D9:						; from CODE_C49048, CODE_C49078, CODE_C490A2, CODE_C490AB
	cmp.w #$0004
	beq CODE_C49063
	lsr a
	lsr a
	sta.b d0
	lda.w attribute,x
	bit.w #$0800
	beq CODE_C490F1
	lda.b d0
	eor.w #$0001
	sta.b d0
CODE_C490F1:						; from CODE_C490D9
	lda.b d3
	cmp.w #$0004
	bcc CODE_C490FE
	eor.w #$FFFF
	adc.w #$0008
CODE_C490FE:						; from CODE_C490F1
	cmp.w #$0002
	bcs CODE_C490C0
	lda.w puckz
	sec
	sbc.w #$0008
	bpl CODE_C4913D
	lda.w puckvz
	sec
	sbc.w #$0800
	bpl CODE_C4913D
	lda.b d0
	clc
	adc.w #$0004
	sta.b d0
	ldy.w #$0002
	lda.b [a0],y
	cmp.w #$0009
	bcc CODE_C4913D
	lda.w facedir,x
	cmp.w #$0002
	beq CODE_C4913D
	cmp.w #$0006
	beq CODE_C4913D
	lda.w puckc
	bmi CODE_C4913D
	dec.b d0
	dec.b d0
CODE_C4913D:						; from CODE_C490FE, CODE_C49063, CODE_C490C0
	asl.b d0
	lda.w #$00C4
	sta.b $69
	lda.w #$932C
	sta.b a1
	ldy.b d0
	lda.b [a1],y
	sta.w pfalock,x
	jsl.l SetSPAFromA
	lda.l $7E24CA
	clc
	adc.w #$0096
	sta.l $7E24CA
	lda.w #$001E
	sta.b crowdhold
CODE_C49165:						; from CODE_C48FA7, CODE_C48FD7
	lda.b [a0]
	sta.b d0
	lda.w pucky
	sec
	sbc.w #$0102
	bpl CODE_C4917B
	lda.w pucky
	sec
	sbc.w #$FEFE
	bpl CODE_C4918A
CODE_C4917B:						; from CODE_C49165
	lda.w #$0018
	sta.b d0
	lda.w $0830
	bpl CODE_C4918A
	lda.w #$FFE8
	sta.b d0
CODE_C4918A:						; from CODE_C48C41, CODE_C48E8D, CODE_C48FAA, CODE_C49165, ...
	lda.w playerpad,x
	bmi CODE_C49192
	jmp.w CODE_C4932B
CODE_C49192:						; from CODE_C4918A
	ldy.w puckc
	bmi CODE_C491DD
	lda.w pfteam,x
	cmp.w pfteam,y
	beq CODE_C491DD
	lda.w SPA,y
	cmp.w #$1C24
	bcc CODE_C491DA
	cmp.w #$1EFB
	bcs CODE_C491DA
	lda.w Yvel,y
	bit.w #$8000
	beq CODE_C491B8
	eor.w #$FFFF
	inc a
CODE_C491B8:						; from CODE_C49192
	sta.b r0
	lda.w Xvel,y
	bit.w #$8000
	beq CODE_C491C6
	eor.w #$FFFF
	inc a
CODE_C491C6:						; from CODE_C491B8
	lsr a
	cmp.b r0
	bcs CODE_C491DA
	lda.w $0668
	bne CODE_C491DD
	stz.w Xvel,x
	stz.w Yvel,x
	inc.w $0668
	rtl
CODE_C491DA:						; from CODE_C49192, CODE_C491C6
	stz.w $0668
CODE_C491DD:						; from CODE_C49192, CODE_C491C6
	lda.b d2
	sta.b d1
	pha
	pei ($7F)
	lda.w Xvel,x
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C491F3
	ora.w #$FF00
CODE_C491F3:						; from CODE_C491DD
	eor.w #$FFFF
	inc a
	sta.b d0
	pla
	clc
	adc.b d0
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w Yvel,x
	xba
	and.w #$00FF
	bit.w #$0080
	beq CODE_C49212
	ora.w #$FF00
CODE_C49212:						; from CODE_C491F3
	eor.w #$FFFF
	inc a
	sta.b d1
	pla
	clc
	adc.b d1
	sec
	sbc.w Ypos,x
	sta.b d1
	lda.w #$0005
	sta.b tmp0
	cpx.w puckc
	bne CODE_C4922E
	asl.b tmp0
CODE_C4922E:						; from CODE_C49212
	lda.b d0
	bit.w #$8000
	beq CODE_C49239
	eor.w #$FFFF
	inc a
CODE_C49239:						; from CODE_C4922E
	cmp.b tmp0
	bcs CODE_C49250
	lda.b d1
	bit.w #$8000
	beq CODE_C49248
	eor.w #$FFFF
	inc a
CODE_C49248:						; from CODE_C49239
	cmp.b tmp0
	bcs CODE_C49250
	stz.b d0
	stz.b d1
CODE_C49250:						; from CODE_C49239, CODE_C49248
	jsl.l vtoa
	lda.b d0
	sta.w temp2b,x
CODE_C49259:						; from CODE_C48BFC
	ldy.w playerpad,x
	bpl CODE_C49275
	lda.w temp2b,x
	sta.b d2
	sec
	sbc.w #$0007
	beq CODE_C4926E
	bmi CODE_C4926E
	jmp.w stopna
CODE_C4926E:						; from CODE_C49259
	jml.l CODE_C45ABE
CODE_C49272:						; from CODE_C49276, CODE_C4928F, CODE_C492A0, CODE_C492C1
	jmp.w CODE_C4918A
CODE_C49275:						; from CODE_C49259
	rtl
CODE_C49276:						; from CODE_C48FDA
	lda.w puckc
	bpl CODE_C49272
	lda.w iflags
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
	lda.w puckvy
	bit.w #$8000
	beq CODE_C492A0
	eor.w #$FFFF
	inc a
CODE_C492A0:						; from CODE_C4928F
	cmp.w #$3800
	bmi CODE_C49272
	lda.w pucky
	cmp.w #$00BE
	bpl CODE_C492B5
	lda.w pucky
	cmp.w #$FF42
	bpl CODE_C49272
CODE_C492B5:						; from CODE_C492A0
	lda.w puckvy
	ldy.w pfgoal,x
	beq CODE_C492C1
	eor.w #$FFFF
	inc a
CODE_C492C1:						; from CODE_C492B5
	cmp.w #$FC00
	bmi CODE_C49272
	stz.b a1
	lda.w #$0002
	sta.b a2
	lda.w pfteam,x
	beq CODE_C492D9
	stz.b a2
	lda.w #$0002
	sta.b a1
CODE_C492D9:						; from CODE_C492C1
	ldy.b a1
	lda.w $12CF,y
	cmp.w #$0064
	bcc CODE_C492F5
	ldy.b a2
	lda.w $12CF,y
	cmp.w #$0064
	bcc CODE_C492F5
	lda.w #$000F
	sta.b d0
	jmp.w CODE_C43734
CODE_C492F5:						; from CODE_C492D9
	jmp.w CODE_C4918A

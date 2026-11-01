; Segment bankC4_7000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4702E
skatetopuck:						; called from other segments
	jsl.l skatetopuckinit
	lda.w temp2,x
	sec
	sbc.b d7
	sta.w temp2,x
	bmi CODE_C47040
	jmp.w CODE_C470E7
CODE_C47040:						; from skatetopuck
	adc.w #$0005
	sta.w temp2,x
	jsl.l CODE_C46BF6
	pei ($83)
	pei ($7F)
	txa
	jsl.l CODE_C37FE2
	lda.b d0
	eor.w #$FFFF
	inc a
	sec
	sbc.w $09A1,x
	and.w #$00FF
	bit.w #$0080
	beq CODE_C47068
	ora.w #$FF00
CODE_C47068:						; from CODE_C47040
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
	beq CODE_C47086
	ora.w #$FF00
CODE_C47086:						; from CODE_C47068
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
	lda.w position,x
	beq CODE_C470E7
	lda.w puckvx
	sta.b d0
	lda.w puckvy
	sta.b d1
	jsl.l vtoa
	lda.b d0
	cmp.w #$0008
	beq CODE_C470BC
	eor.w #$0004
	cmp.w facedir,x
	beq CODE_C470E7
CODE_C470BC:						; from CODE_C47086
	lda.w pucky
	sec
	sbc.w Ypos,x
	sta.b d1
	pha
	lda.w $0830
	sec
	sbc.w Xpos,x
	sta.b d0
	pha
	jsl.l vtoa
	lda.b d0
	sta.b tmp0
	pla
	sta.b d0
	sta.b r0
	pla
	sta.b d1
	lda.w facedir,x
	cmp.b tmp0
	beq CODE_C470F0
CODE_C470E7:						; from skatetopuck, CODE_C47086, CODE_C470F0, CODE_C47120
	lda.w temp2b,x
	sta.b d0
	jml.l doplayeracc
CODE_C470F0:						; from CODE_C470BC
	lda.w puckc
	bmi CODE_C470E7
	lda.b r0
	lsr a
	lsr a
	and.w #$01FE
	tax
	lda.l DATA8_C38A4A,x
	sta.b d0
	lda.b d1
	and.w #$07F8
	lsr a
	lsr a
	tax
	lda.l DATA8_C38A4A,x
	ldx.b a3
	adc.b d0
	cmp.w #$000E
	bcc CODE_C470E7
	cmp.w #$0028
	bcs CODE_C47120
	jmp.w CODE_C45606
CODE_C47120:						; from CODE_C470F0
	bra CODE_C470E7
CODE_C47122:						; called from other segments
	lda.w gmode
	bit.w #$0040
	beq CODE_C47132
	lda.b a2
	inc a
	inc a
	jsl.l CODE_C382B6
CODE_C47132:						; from CODE_C47122
	ldy.w playerpad,x
	bmi CODE_C47140
	lda.w PadRaw1,y
	and.w #$FFF0
	beq CODE_C47140
	rtl
CODE_C47140:						; from CODE_C47132
	lda.w Xvel,x
	tax
	lda.w #$00C0
	jsl.l Mul16x8XS
	ldx.b a3
	lda.b $35
	sta.w Xvel,x
	lda.w Yvel,x
	tax
	lda.w #$00C0
	jsl.l Mul16x8XS
	ldx.b a3
	lda.b $35
	sta.w Yvel,x
	txa
	lsr a
	cmp.w puckc
	bne CODE_C47177
	lda.w #$FFFF
	sta.w puckc
	lda.w #$0708
	sta.w nopuck,x
CODE_C47177:						; from CODE_C47140
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C471A7
	and.w #$FFFD
	sta.w pflags,x
	jsl.l CODE_C471E2
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
	lda.w #$005A
	sta.w temp3,x
	lda.b $CB
	bpl CODE_C471A2
	lda.w #$FFA6
	sta.w temp3,x
CODE_C471A2:						; from CODE_C47177
	lda.b $CD
	sta.w temp4,x
CODE_C471A7:						; from CODE_C47177
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b a0
	lda.w temp3,x
	sta.b d0
	lda.w temp4,x
	sta.b d1
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl CODE_C471ED
	lda.w #$2824
	sta.b d1
	sta.w pfalock,x
	cpx.w $07EA
	bne CODE_C471DE
	lda.w #$27B2
	sta.b d1
	lda.w #$FFFF
	sta.w $07EA
CODE_C471DE:						; from CODE_C471A7
	jsl.l SetSPA
CODE_C471E2:						; from CODE_C47177 and other segments
	lda.w #$0078
	jsl.l randoma8
	sta.w temp1,x
	rtl
CODE_C471ED:						; from CODE_C471A7
	jmp.w skateto
CODE_C471F0:						; called from other segments
	jsl.l updatepentime
	jsl.l checkfornewpen
	jsl.l chkprogress
	jml.l CODE_C38C4A
chkatop:							; from CODE_C47FD4 and other segments
	stz.b d1
	lda.w pucky
	sec
	sbc.w #$005C
	bpl CODE_C47218
	inc.b d1
	inc.b d1
	lda.w pucky
	sec
	sbc.w #$FFA4
	bpl CODE_C47230
CODE_C47218:						; from chkatop
	lda.w gmode
	bit.w #$0002
	beq CODE_C47227
	lda.b d1
	eor.w #$0002
	sta.b d1
CODE_C47227:						; from CODE_C47218
	ldy.b d1
	lda.w $126F,y
	inc a
	sta.w $126F,y
CODE_C47230:						; from chkatop
	rtl
CountPowerPlayTime:					; from CODE_C47FD4 and other segments
	stz.b d1
	lda.w tmap
	sec
	sbc.w $12C9
	beq CODE_C4724C
	bpl CODE_C47243
	lda.w #$0002
	sta.b d1
CODE_C47243:						; from CountPowerPlayTime
	ldy.b d1
	lda.w $1273,y
	inc a
	sta.w $1273,y
CODE_C4724C:						; from CountPowerPlayTime
	rtl
checkfornewpen:						; from CODE_C471F0 and other segments
	lda.w $2CF5
	beq CODE_C47255
	jmp.w CODE_C4730E
CODE_C47255:						; from checkfornewpen
	lda.w #$10F9
	sta.b a0
CODE_C4725A:						; from CODE_C4725A, CODE_C472B9, CODE_C4730F, CODE_C4730B
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	cmp.w #$0034
	beq CODE_C4725A
	tay
	bne CODE_C4726E
	jmp.w CODE_C4730E
CODE_C4726E:						; from CODE_C4725A
	lda.w gmode
	bit.w #$0004
	bne CODE_C472B9
	sty.b d0
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b a1
	lda.b [a1],y
	clc
	adc.b a1
	sta.b a1
	lda.b [a1]
	and.w #$00FF
	beq CODE_C472B5
	lda.w puckc
	bmi CODE_C4730F
	lsr a
	sec
	sbc.w #$0006
	sta.b d0
	dec.b a0
	lda.b (a0)
	inc.b a0
	and.w #$00FF
	bit.w #$0080
	beq CODE_C472AD
	ora.w #$FF00
CODE_C472AD:						; from CODE_C4726E
	sec
	sbc.w #$0006
	eor.b d0
	bmi CODE_C4730F
CODE_C472B5:						; from CODE_C4726E
	jsl.l Stop4Pen
CODE_C472B9:						; from CODE_C4726E
	dec.b a0
	lda.b (a0)
	tay
	ora.w #$0080
	sta.b (a0)
	inc.b a0
	tya
	bit.w #$0080
	beq CODE_C472CE
	jmp.w CODE_C4725A
CODE_C472CE:						; from CODE_C472B9
	dec.b a0
	dec.b a0
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	sta.b d0
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b a1
	lda.b [a1],y
	clc
	adc.b a1
	sta.b a1
	ldy.w #$0001
	lda.b [a1],y
	and.w #$00FF
	asl a
	asl a
	asl a
	asl a
	asl a
	sta.b d1
	sec
	sbc.w PenCntDwn
	beq CODE_C4730B
	bmi CODE_C4730B
	lda.b d1
	sta.w PenCntDwn
CODE_C4730B:						; from CODE_C4730F, CODE_C472CE
	jmp.w CODE_C4725A
CODE_C4730E:						; from checkfornewpen, CODE_C4725A
	rtl
CODE_C4730F:						; from CODE_C4726E, CODE_C472AD
	lda.w #$0008
	tsb.w gmode
	bne CODE_C4730B
	lda.w #$0030
	sta.b d0
	jsl.l CODE_C38C6D
	jmp.w CODE_C4725A
Stop4Pen:							; from CODE_C472B5 and other segments
	lda.w #$FFFF
	tsb.w gmclock
	beq CODE_C4732E
	jmp.w CODE_C473DE
CODE_C4732E:						; from Stop4Pen
	stz.b d0
	stz.b d1
	dec.b a0
	dec.b a0
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	cmp.w #$000E
	beq CODE_C4737E
	pha
	lda.w $2004
	sta.b d0
	lda.w $2006
	sta.b d1
	pla
	cmp.w #$0006
	beq CODE_C4737E
	ldy.w $0830
	sty.b d0
	ldy.w pucky
	sty.b d1
	cmp.w #$000C
	bne CODE_C4737E
	dec.b a0
	lda.b (a0)
	inc.b a0
	and.w #$00FF
	asl a
	tay
	lda.w #$0258
	sta.b d1
	lda.w pfgoal,y
	beq CODE_C4737E
	lda.w #$FDA8
	sta.b d1
CODE_C4737E:						; from CODE_C4732E
	lda.b d0
	sta.b tmp0
	sec
	sbc.w #$0050
	bmi CODE_C4738D
	lda.w #$0050
	sta.b d0
CODE_C4738D:						; from CODE_C4737E
	lda.b d0
	sec
	sbc.w #$FFB0
	bpl CODE_C4739A
	lda.w #$FFB0
	sta.b d0
CODE_C4739A:						; from CODE_C4738D
	lda.b d1
	sec
	sbc.w #$00AC
	bmi CODE_C473B5
	lda.w #$00D4
	sta.b d1
	lda.w #$0050
	sta.b d0
	lda.b tmp0
	bpl CODE_C473B5
	lda.w #$FFB0
	sta.b d0
CODE_C473B5:						; from CODE_C4739A
	lda.b d1
	sec
	sbc.w #$FF54
	bpl CODE_C473D0
	lda.w #$FF2C
	sta.b d1
	lda.w #$0050
	sta.b d0
	lda.b tmp0
	bpl CODE_C473D0
	lda.w #$FFB0
	sta.b d0
CODE_C473D0:						; from CODE_C473B5
	lda.b d0
	sta.w $2034
	lda.b d1
	sta.w $2036
	jsl.l CODE_C51F7C
CODE_C473DE:						; from Stop4Pen
	lda.b Vcount
	sec
	sbc.w $07EC
	cmp.w #$003C
	bcc CODE_C473E9
CODE_C473E9:						; from CODE_C473DE
	lda.w replaydelay
	bne CODE_C473F4
	lda.w #$001E
	sta.w replaydelay
CODE_C473F4:						; from CODE_C473E9
	lda.w #$0012
	jsl.l CODE_CF040B
	stz.w PenCntDwn
	lda.w #$0004
	tsb.w gmode
	lda.w #$000A
	sta.b d0
	jml.l CODE_C38C6D
chkprogress:						; from CODE_C471F0 and other segments
	lda.w gmode
	bit.w #$0004
	bne CODE_C47416
CODE_C47415:						; from CODE_C4741E, CODE_C47431
	rtl
CODE_C47416:						; from chkprogress
	lda.w PenCntDwn
	bpl CODE_C4741E
	jmp.w CODE_C474C4
CODE_C4741E:						; from CODE_C47416
	sec
	sbc.b d7
	sta.w PenCntDwn
	bpl CODE_C47415
	lda.w #$0008
	trb.w gmode
	lda.w #$10F9
	sta.b a0
CODE_C47431:						; from CODE_C47431
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	cmp.w #$0034
	beq CODE_C47431
	tay
	beq CODE_C47415
	dec.b a0
	dec.b a0
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	sta.b d0
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b a1
	clc
	adc.b [a1],y
	sta.b a1
	lda.b [a1]
	and.w #$00FF
	beq CODE_C47431
	cmp.w #$0001
	beq CODE_C47431
	lda.w #$0400
	tsb.w sflags
	jsl.l FadeOutWait
	jsl.l CODE_C5226A
	lda.w #$0038
	sta.b $CB
	stz.b $CD
	jsl.l freezewindow
	lda.w #$FF00
	tsb.w puckc
	ldx.w #$001C
	stx.b a3
	lda.w #$001A
	sta.b d0
	jsl.l CODE_C43734
	ldx.b a3
	lda.w #$1C20
	sta.w temp1,x
	lda.w #$FF00
	tsb.w $1147
	stz.w RefCnt
	jsl.l CODE_C38C4A
	lda.w #$0032
	sta.w RefCnt
	stz.b d0
	stz.w tmp0
	phx
	jsl.l CODE_C38CFC
	plx
	stz.w fadestep
	rtl
CODE_C474C4:						; from CODE_C47416
	jsl.l SeatPenaltyBox
	lda.w RefCnt
	bmi CODE_C474D0
	jmp.w CODE_C47748
CODE_C474D0:						; from CODE_C474C4
	lda.w $1147
	bmi CODE_C474D8
	jmp.w CODE_C47748
CODE_C474D8:						; from CODE_C474D0
	pei ($7F)
	pei ($81)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
CODE_C474EC:						; from CODE_C476E5
	lda.w #$10F9
	sta.b a0
CODE_C474F1:						; from CODE_C474F1
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	cmp.w #$0034
	beq CODE_C474F1
	cmp.w #$0000
	bne CODE_C47507
	jmp.w CODE_C476F8
CODE_C47507:						; from CODE_C474F1, CODE_C47507
	lda.b (a0)
	inc.b a0
	inc.b a0
	cmp.w #$0000
	bne CODE_C47507
	dec.b a0
	dec.b a0
	dec.b a0
	dec.b a0
	lda.b (a0)
	pha
	and.w #$7FFF
	sta.b (a0)
	pla
	bmi CODE_C4753F
	lda.b (a0)
	xba
	and.w #$00FF
	asl a
	sta.b d1
	tay
	lda.w position,y
	bmi CODE_C47537
	jmp.w CODE_C4770C
CODE_C47537:						; from CODE_C47507
	lda.w #$0000
	sta.b (a0)
	jmp.w CODE_C4770C
CODE_C4753F:						; from CODE_C47507
	lda.b (a0)
	and.w #$00FF
	sta.b d0
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b a1
	lda.b [a1],y
	clc
	adc.b a1
	sta.b a1
	cmp.w #$455B
	bne CODE_C47560
	jmp.w CODE_C476E1
CODE_C47560:						; from CODE_C4753F
	lda.b [a1]
	and.w #$00FF
	sta.b d2
	bne CODE_C4756C
	jmp.w CODE_C476E5
CODE_C4756C:						; from CODE_C47560
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	pei ($73)
	pei ($75)
	jsl.l GetPeriodTimeRemaining
	lda.b (a0)
	xba
	and.w #$00FF
	asl a
	sta.b d1
	tax
	stx.b a3
	stz.b d0
	stz.b a2
	lda.w #$0002
	sta.b a1
	lda.w pfteam,x
	beq CODE_C475BA
	lda.w #$8000
	sta.b d0
	stz.b a1
	lda.w #$0002
	sta.b a2
	lda.w CwdExciteLvl
	clc
	adc.w #$0014
	bmi CODE_C475BA
	sta.w CwdExciteLvl
CODE_C475BA:						; from CODE_C4756C
	ldy.b a2
	lda.w $1267,y
	inc a
	sta.w $1267,y
	lda.w $126B,y
	clc
	adc.b d2
	sta.w $126B,y
	lda.w pnum,x
	and.w #$00FF
	ora.b d0
	sta.w TempPlOffset
	lda.w pnum,x
	sta.b d0
	lda.b a2
	beq CODE_C475E3
	lda.w #$001A
CODE_C475E3:						; from CODE_C475BA
	phx
	clc
	adc.b d0
	tax
	sep #$20
	lda.w $14AF,x
	rep #$20
	and.w #$00FF
	clc
	adc.b d2
	sep #$20
	sta.w $14AF,x
	rep #$20
	plx
	lda.w $1159
	cmp.w #$0041
	bcs CODE_C47635
	asl a
	asl a
	tay
	jsl.l GetPeriodTimeRemaining
	lda.b d0
	sta.w $115B,y
	iny
	iny
	lda.w TempPlOffset
	cmp.w #$0080
	bmi CODE_C4761E
	ora.w #$0080
CODE_C4761E:						; from CODE_C475E3
	sep #$20
	sta.w $115B,y
	rep #$20
	iny
	lda.b (a0)
	and.w #$00FF
	sep #$20
	sta.w $115B,y
	rep #$20
	inc.w $1159
CODE_C47635:						; from CODE_C475E3
	lda.w TempPlOffset
	and.w #$00FF
	bit.w #$0080
	beq CODE_C47643
	ora.w #$FF00
CODE_C47643:						; from CODE_C47635
	asl a
	sta.b d0
	phx
	ldx.w #$003C
	lda.b d2
	and.w #$00FF
	jsl.l Mul8U
	ora.w #$2000
	sta.b d2
	plx
	lda.b a2
	beq CODE_C47660
	lda.w #$0034
CODE_C47660:						; from CODE_C47643
	clc
	adc.b d0
	tay
	lda.w tmpdst,y
	bmi CODE_C4766E
	and.w #$1000
	tsb.b d2
CODE_C4766E:						; from CODE_C47660
	lda.b d2
	sta.w tmpdst,y
	lda.w #$1000
	trb.b d2
	pei ($65)
	pei ($63)
	lda.b a2
	beq CODE_C47683
	lda.w #$001A
CODE_C47683:						; from CODE_C4766E
	sta.b a0
	lda.w #$0018
	sta.b d1
CODE_C4768A:						; from CODE_C4768A
	ldy.b a0
	inc.b a0
	lda.w tmboxlist,y
	bit.w #$0080
	bne CODE_C4769A
	dec.b d1
	bpl CODE_C4768A
CODE_C4769A:						; from CODE_C4768A
	lda.b d0
	ora.w #$FF00
	sta.w tmboxlist,y
	pla
	sta.b a0
	pla
	sta.b $65
	lda.w #$000D
	sta.b d0
	jsl.l assreplace
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
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
	ldx.b a3
	jsl.l CODE_C38C6D
	jsl.l CODE_C513F4
	bra CODE_C4770C
CODE_C476E1:						; from CODE_C4753F
	jsl.l StartPenaltyShot
CODE_C476E5:						; from CODE_C47560
	lda.w #$0000
	sta.b (a0)
	lda.w $2CF5
	beq CODE_C476F2
	jmp.w CODE_C474EC
CODE_C476F2:						; from CODE_C476E5
	jsl.l CODE_C38C6D
	bra CODE_C4770C
CODE_C476F8:						; from CODE_C474F1
	lda.w #$0004
	trb.w gmode
	ldx.w #$001C
	stx.b a3
	lda.w #$001B
	sta.b d0
	jsl.l assreplace
CODE_C4770C:						; from CODE_C47507, CODE_C47537, CODE_C4769A, CODE_C476F2
	lda.w $1864
	cmp.w #$0001
	beq CODE_C47728
	lda.w penshot
	bne CODE_C47728
	stz.b a2
	jsl.l InProgress_ap
	lda.w #$0002
	sta.b a2
	jsl.l InProgress_ap
CODE_C47728:						; from CODE_C4770C
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
	sta.b $81
	pla
	sta.b d0
	ldx.b a3
CODE_C47748:						; from CODE_C474C4, CODE_C474D0
	rtl
InProgress_ap:						; from CODE_C4770C and other segments
	lda.w #$0006
	sta.b d1
	lda.w #$0032
	sta.b d0
CODE_C47753:						; from CODE_C47779
	lda.b a2
	beq CODE_C4775A
	lda.w #$0034
CODE_C4775A:						; from CODE_C47753
	clc
	adc.b d0
	tay
	lda.w tmpdst,y
	bmi CODE_C47779
	beq CODE_C47779
	and.w #$DFFF
	sta.w tmpdst,y
	bit.w #$5000
	bne CODE_C47779
	lda.b d1
	cmp.w #$0004
	beq CODE_C47779
	dec.b d1
CODE_C47779:						; from CODE_C4775A
	dec.b d0
	dec.b d0
	bpl CODE_C47753
	ldy.b a2
	lda.b d1
	sta.w tmap,y
	rtl
updatepwrplay:						; called from other segments
	lda.w $1864
	cmp.w #$0001
	beq CODE_C477BA
	stz.b a2
	lda.w #$0002
	sta.b a3
	lda.w tmap
	sec
	sbc.w $12C9
	sta.b d0
	bne CODE_C477A4
	jmp.w updatepwrplay_clr
CODE_C477A4:						; from updatepwrplay
	bpl CODE_C477BB
	lda.w sflags
	bit.w #$4000
	bne CODE_C477D5
	jsl.l updatepwrplay_clr
	lda.w #$4000
	tsb.w sflags
	bra CODE_C477D5
CODE_C477BA:						; from updatepwrplay
	rtl
CODE_C477BB:						; from CODE_C477A4
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	lda.w sflags
	bit.w #$4000
	beq CODE_C477D5
	jsl.l updatepwrplay_clr
	lda.w #$4000
	trb.w sflags
CODE_C477D5:						; from CODE_C477A4, CODE_C477BB
	lda.w #$2000
	tsb.w sflags
	bne CODE_C477E6
	jsl.l CODE_C53A29
	ldx.b a3
	inc.w $1263,x
CODE_C477E6:						; from CODE_C477D5
	lda.w #$0005
	jsl.l CODE_C4C561
	tax
	lda.w #$0004
	sta.w $0000,x
	lda.w #$9C9B
	sta.w $0001,x
	lda.w #$9E9D
	sta.w $0003,x
	txa
	ldx.w #$007E
	ldy.w #$5B04
	jsl.l QueueVRAMDMALen
	jsl.l GetLowestPen
	lda.w gmclock
	bne CODE_C4782C
	lda.b d0
	cmp.w #$0005
	bcs CODE_C4782C
	cmp.w #$0001
	beq CODE_C47825
	lda.w #$0001
	bra CODE_C47828
CODE_C47825:						; from CODE_C477E6
	lda.w #$0001
CODE_C47828:						; from CODE_C477E6
	jsl.l CODE_CF040B
CODE_C4782C:						; from CODE_C477E6
	jsl.l CODE_C516C2
	lda.b a1
	ldx.w #$007E
	ldy.w #$5AE5
	jsl.l QueueVRAMDMALen
	lda.w sflags
	ldx.w $17C9
	bit.w #$4000
	beq CODE_C4784A
	ldx.w $17CB
CODE_C4784A:						; from CODE_C4782C
	txa
	jsl.l CODE_C53A71
	ldy.w #$5AE1
	jml.l QueueVRAMDMALen
updatepwrplay_clr:					; from updatepwrplay, CODE_C477A4, CODE_C477BB and other segments
	lda.w #$2000
	trb.w sflags
	beq CODE_C4789C
CODE_C4785E:						; called from other segments
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.l DATA8_C58942
	sta.w $3E4E
	ldx.w #$3E4E
	ldy.w #$3E50
	lda.w #$0013
	mvn $7E,$7E
	clc
	lda.w #$5AA0
	ldy.w #$0002
CODE_C47880:						; from CODE_C47880
	pea.w $0016
	pha
	pea.w $007E
	pea.w $3E4E
	adc.w #$0020
	dey
	bpl CODE_C47880
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jml.l CODE_C53A29
CODE_C4789C:						; from updatepwrplay_clr
	rtl
AddPenalty:							; from CODE_C47AE9, CODE_C47CB6, CODE_C47D0B and other segments
	lda.w gmclock
	bne CODE_C478C2
	lda.w PenShotActive
	bne CODE_C478C2
	lda.b d0
	cmp.w #$000C
	beq AddPenalty2
	lda.w $186C
	beq CODE_C478C2
	lda.w gmode
	bit.w #$0020
	bne AddPenalty2
	lda.b d0
	cmp.w #$0012
	bne AddPenalty2
CODE_C478C2:						; from AddPenalty
	rtl
AddPenalty2:						; from AddPenalty and other segments
	lda.w $2CF5
	beq CODE_C478CB
	jmp.w CODE_C47979
CODE_C478CB:						; from AddPenalty2
	pei ($83)
	pei ($85)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	lda.b d0
	cmp.w #$000E
	bne CODE_C478DE
CODE_C478DE:						; from CODE_C478CB
	sec
	sbc.w #$000E
	bmi CODE_C4790B
	lda.l $7E24CA
	clc
	adc.w #$00C8
	sta.l $7E24CA
	lda.w #$002D
	sta.b crowdhold
	lda.w pfteam,x
	beq CODE_C4790B
	lda.l $7E24CA
	sec
	sbc.w #$00C8
	bcs CODE_C47907
	lda.w #$0000
CODE_C47907:						; from CODE_C478DE
	sta.l $7E24CA
CODE_C4790B:						; from CODE_C478DE
	lda.w #$10F9
	sta.b a1
	lda.w #$001F
	sta.b d1
CODE_C47915:						; from CODE_C47915
	lda.b (a1)
	inc.b a1
	inc.b a1
	and.w #$00FF
	cmp.w #$0034
	beq CODE_C47915
	tay
	beq CODE_C4792C
	dec.b d1
	bpl CODE_C47915
	bra CODE_C47967
CODE_C4792C:						; from CODE_C47915
	dec.b a1
	dec.b a1
	txa
	lsr a
	xba
	and.w #$FF00
	ora.b d0
	sta.b (a1)
	lda.w #$00C3
	sta.b $65
	lda.w #$4499
	sta.b a0
	ldy.b d0
	clc
	adc.b [a0],y
	sta.b a0
	lda.b [a0]
	and.w #$00FF
	beq CODE_C47967
	lda.w pflags,x
	pha
	ora.w #$4000
	sta.w pflags,x
	pla
	bit.w #$4000
	beq CODE_C47967
	lda.w #$0000
	sta.b (a1)
CODE_C47967:						; from CODE_C47915, CODE_C4792C
	pla
	sta.b $69
	pla
	sta.b a1
	pla
	sta.b $65
	pla
	sta.b a0
	pla
	sta.b $85
	pla
	sta.b d1
CODE_C47979:						; from AddPenalty2
	rtl
PenGoalStuff:						; called from other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($63)
	pei ($65)
	jsl.l CODE_C54BAF
	lda.w gsp
	cmp.w #$0003
	beq CODE_C479FB
	lda.w #$10F9
	sta.b a0
CODE_C4799B:						; from CODE_C4799B, CODE_C479E6, CODE_C479EC
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	cmp.w #$0034
	beq CODE_C4799B
	cmp.w #$0000
	bne CODE_C479B1
	jmp.w CODE_C479FF
CODE_C479B1:						; from CODE_C4799B
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b a1
	lda.b [a1],y
	clc
	adc.b a1
	sta.b a1
	lda.b [a1]
	and.w #$00FF
	beq CODE_C479EC
	dec.b a0
	dec.b a0
	lda.w #$0000
	sta.b d0
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$FF00
	cmp.w #$0600
	bcc CODE_C479E6
	lda.w #$0002
	sta.b d0
CODE_C479E6:						; from CODE_C479B1
	lda.b a2
	cmp.b d0
	beq CODE_C4799B
CODE_C479EC:						; from CODE_C479B1
	dec.b a0
	dec.b a0
	lda.w #$0034
	sta.b (a0)
	inc.b a0
	inc.b a0
	bra CODE_C4799B
CODE_C479FB:						; from PenGoalStuff
	jsl.l CODE_C4818C
CODE_C479FF:						; from CODE_C4799B
	ldy.b a2
	lda.w tmap,y
	ldy.b a1
	sec
	sbc.w tmap,y
	beq CODE_C47A63
	bmi CODE_C47A63
	lda.b a1
	beq CODE_C47A15
	lda.w #$001A
CODE_C47A15:						; from CODE_C479FF
	sta.b a0
CODE_C47A17:						; from CODE_C47A2F
	ldy.b a0
	lda.w tmboxlist,y
	inc.b a0
	and.w #$00FF
	sta.b d2
	bit.w #$0080
	bne CODE_C47A63
	lda.b a1
	beq CODE_C47A2F
	lda.w #$0034
CODE_C47A2F:						; from CODE_C47A17
	clc
	adc.b d2
	tay
	lda.w tmpdst,y
	bit.w #$4000
	bne CODE_C47A17
	lda.w #$0000
	sta.w tmpdst,y
	jsl.l CODE_C45A9F
	ldy.b a1
	lda.w tmap,y
	inc a
	sta.w tmap,y
	jsr.w CODE_C47A7C
	ldy.b a2
	lda.w $125F,y
	inc a
	sta.w $125F,y
	lda.w #$0001
	tsb.w tmflags
	tsb.w $1301
CODE_C47A63:						; from CODE_C479FF, CODE_C47A17
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
	rtl
CODE_C47A7C:						; from CODE_C47A2F
	phx
	tyx
	lda.w teampads,x
	cmp.w #$0004
	bcc CODE_C47AB2
	ldy.w $05C0,x
CODE_C47A89:						; from CODE_C47A93
	iny
	iny
	cpy.w #$000A
	bne CODE_C47A93
	ldy.w #$0000
CODE_C47A93:						; from CODE_C47A89
	lda.w $1525,y
	bpl CODE_C47A89
	and.w #$00FF
	cmp.b a1
	bne CODE_C47A89
	sta.w $1525,y
	inc a
	inc a
	lsr a
	sta.w cont1team,y
	ldx.b curobj
	tya
	sta.w playerpad,x
	txa
	sta.w c1playernum,y
CODE_C47AB2:						; from CODE_C47A7C
	plx
	rts
checkint:							; called from other segments
	jsl.l CODE_C47ACD
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	jsl.l CODE_C47ACD
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
CODE_C47ACC:						; from CODE_C47ACD, CODE_C47AE9
	rtl
CODE_C47ACD:						; from checkint and other segments
	ldy.b a2
	lda.w position,y
	bne CODE_C47ACC
	lda.w gmclock
	bne CODE_C47ACC
	lda.w puckc
	cmp.b a3
	beq CODE_C47AE9
	lda.w $0A00,x
	sec
	sbc.w #$001A
	bmi CODE_C47ACC
CODE_C47AE9:						; from CODE_C47ACD
	lda.w $0A00,x
	sec
	sbc.w #$0003
	bmi CODE_C47ACC
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	jsl.l CODE_C44F20
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	lda.w $0A00,y
	sec
	sbc.w #$001F
	bmi CODE_C47ACC
	lda.w pflags,x
	bit.w #$4000
	bne CODE_C47ACC
	lda.w #$0014
	sec
	sbc.w $0F60,x
	jsl.l randoma8
	cmp.w #$0002
	bcs CODE_C47ACC
	lda.w gmode
	bit.w #$0010
	bne CODE_C47ACC
	lda.w goalieflags,y
	and.w #$0004
	bne CODE_C47ACC
	lda.w #$0026
	sta.b d0
	jmp.w AddPenalty
CODE_C47B3F:						; called from other segments
	lda.w attribute,x
	and.w #$F7FF
	sta.w attribute,x
	lda.w pflags,x
	bit.w #$0002
	bne CODE_C47B53
	jmp.w CODE_C47B8F
CODE_C47B53:						; from CODE_C47B3F
	and.w #$FFFD
	sta.w pflags,x
	ldy.w #$0010
	lda.w pfteam,x
	beq CODE_C47B64
	ldy.w #$0001
CODE_C47B64:						; from CODE_C47B53
	sty.b d0
	lda.w PBnum
	sec
	sbc.b d0
	sta.w PBnum
	stz.w Xvel,x
	stz.w Yvel,x
	lda.w #$009B
	sta.w Xpos,x
	lda.w #$0002
	sta.w facedir,x
	sta.w pfalock,x
	lda.w #$18EC
	jsl.l SetSPAFromA
	jml.l SprSort
CODE_C47B8F:						; from CODE_C47B3F
	lda.w #$0004
	sta.w facedir,x
	lda.w #$FFFF
	sta.w newpnum,x
	sta.w newpos,x
	lda.w pflags,x
	and.w #$6FF7
	sta.w pflags,x
	stz.w pfnc,x
	lda.w #$F000
	sta.w Xvel,x
	lda.w handed,x
	bne CODE_C47BBE
	lda.w attribute,x
	ora.w #$0800
	sta.w attribute,x
CODE_C47BBE:						; from CODE_C47B8F
	ldx.b a2
	lda.w teampads,x
	cmp.w #$0004
	bcc CODE_C47BF4
	ldy.w $05C0,x
CODE_C47BCB:						; from CODE_C47BD5
	iny
	iny
	cpy.w #$000A
	bne CODE_C47BD5
	ldy.w #$0000
CODE_C47BD5:						; from CODE_C47BCB
	lda.w $1525,y
	bpl CODE_C47BCB
	and.w #$00FF
	cmp.b a2
	bne CODE_C47BCB
	sta.w $1525,y
	inc a
	inc a
	lsr a
	sta.w cont1team,y
	ldx.b curobj
	tya
	sta.w playerpad,x
	txa
	sta.w c1playernum,y
CODE_C47BF4:						; from CODE_C47BBE
	ldx.b curobj
	jml.l assexit
GetLowestPen:						; from CODE_C477E6 and other segments
	stz.b d0
	stz.b d3
	lda.b a2
	beq CODE_C47C05
	lda.w #$001A
CODE_C47C05:						; from GetLowestPen
	sta.b a0
CODE_C47C07:						; from CODE_C47C1F
	ldy.b a0
	inc.b a0
	lda.w tmboxlist,y
	and.w #$00FF
	sta.b d2
	bit.w #$0080
	bne CODE_C47C3F
	lda.b a2
	beq CODE_C47C1F
	lda.w #$0034
CODE_C47C1F:						; from CODE_C47C07
	clc
	adc.b d2
	tay
	lda.w tmpdst,y
	sta.b d2
	bit.w #$4000
	bne CODE_C47C07
	lda.b d2
	sec
	sbc.b d3
	sta.b d2
	clc
	adc.b d0
	sta.b d0
	lda.b d2
	sta.b d3
	bra CODE_C47C07
CODE_C47C3F:						; from CODE_C47C07
	ldy.b a3
	lda.w tmap,y
	cmp.w #$0006
	beq CODE_C47C8B
	lda.b d0
	sec
	sbc.b d3
	sta.b d0
	lda.b a3
	beq CODE_C47C57
	lda.w #$001A
CODE_C47C57:						; from CODE_C47C3F
	sta.b a0
CODE_C47C59:						; from CODE_C47C71
	ldy.b a0
	lda.w tmboxlist,y
	inc.b a0
	and.w #$00FF
	sta.b d2
	bit.w #$0080
	bne CODE_C47C8B
	lda.b a3
	beq CODE_C47C71
	lda.w #$0034
CODE_C47C71:						; from CODE_C47C59
	clc
	adc.b d2
	tay
	lda.w tmpdst,y
	bit.w #$4000
	bne CODE_C47C59
	lda.b d0
	cmp.w tmpdst,y
	bmi CODE_C47C8B
	lda.b d0
	clc
	adc.b d3
	sta.b d0
CODE_C47C8B:						; from CODE_C47C3F, CODE_C47C59, CODE_C47C71
	rtl
CODE_C47C8C:						; called from other segments
	ldy.b a2
	lda.w pfalock,x
	bne CODE_C47D0A
	lda.w position,x
	beq CODE_C47D0A
	lda.w $186C
	bne CODE_C47CB6
	lda.w playerpad,y
	bmi CODE_C47CB6
	lda.w #$0010
	clc
	adc.w checking,y
	sec
	sbc.w legstr,x
	jsl.l randoma8
	cmp.w #$000C
	bcc CODE_C47D0A
CODE_C47CB6:						; from CODE_C47C8C
	lda.w Xpos,x
	sec
	sbc.w Xpos,y
	sta.b d0
	lda.w Ypos,x
	sec
	sbc.w Ypos,y
	sta.b d1
	jsl.l vtoa
	ldy.b a2
	lda.b d0
	sec
	sbc.w facedir,y
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs CODE_C47D0A
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	jsl.l CODE_C44F20
	jsl.l PenShotChk
	beq CODE_C47D0B
	lda.w BA_Sktr_SCnum
	bpl CODE_C47D0B
	ldy.b a2
	sty.w BA_Sktr_SCnum
	lda.w playerpad,y
	sta.w $18B6
	lda.w #$0024
	sta.b d0
	jsl.l AddPenalty
	bra CODE_C47D1F
CODE_C47D0A:						; from CODE_C47C8C, CODE_C47CB6
	rtl
CODE_C47D0B:						; from CODE_C47CB6
	jsl.l checkagr
	lda.b d0
	cmp.w #$0005
	bcs CODE_C47D1F
	lda.w #$0022
	sta.b d0
	jsl.l AddPenalty
CODE_C47D1F:						; from CODE_C47CB6, CODE_C47D0B
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	lda.w #$FFFF
	sta.w collflag
	rtl
asspenalty:							; called from other segments
	lda.w pflags,x
	bit.w #$0002
	bne CODE_C47D39
	jmp.w CODE_C47D81
CODE_C47D39:						; from asspenalty
	jsl.l CODE_C47E65
	lda.w pflags,x
	and.w #$FFF9
	ora.w #$1000
	sta.w pflags,x
	stz.b d4
	jsl.l setpads
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
	jsl.l PenBoxSpot
	lda.b r2
	sta.b d1
	sta.w temp4,x
	lda.w #$009B
	sta.w temp3,x
	stz.w temp1,x
	lda.w pflags,x
	ora.w #$8000
	sta.w pflags,x
	stz.w Wallcos,x
	stz.w Wallsin,x
	lda.w #$0384
	sta.w temp5,x
CODE_C47D81:						; from asspenalty
	lda.w temp5,x
	sec
	sbc.w timestep
	sta.w temp5,x
	bpl CODE_C47DA9
	jmp.w CODE_C47E2D
CODE_C47D90:						; from CODE_C47DA9
	rtl
CODE_C47D91:						; from CODE_C47DA9
	lda.w temp3,x
	sta.b d0
	lda.w temp4,x
	sta.b d1
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b a0
	jml.l skateto
CODE_C47DA9:						; from CODE_C47D81
	lda.w Ypos,x
	sec
	sbc.w temp4,x
	cmp.w #$FFF3
	bmi CODE_C47D91
	cmp.w #$000D
	bpl CODE_C47D91
	lda.w Xpos,x
	sec
	sbc.w temp3,x
	sta.b d0
	sec
	sbc.w #$FFE8
	bmi CODE_C47D91
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl CODE_C47D90
	adc.w #$0008
	sta.w temp1,x
	cpx.w puckc
	bne CODE_C47DEB
	lda.w #$FFFF
	sta.w puckc
	lda.w #$003C
	sta.w nopuck,x
CODE_C47DEB:						; from CODE_C47DA9
	lda.w #$1958
	sta.w pfnc,x
	jsl.l SetSPAFromA
	lda.w #$0006
	sta.b d2
	lda.w handed,x
	beq CODE_C47E04
	lda.w #$0002
	sta.b d2
CODE_C47E04:						; from CODE_C47DEB
	lda.w facedir,x
	cmp.b d2
	beq CODE_C47E12
	inc a
	and.w #$0007
	sta.w facedir,x
CODE_C47E12:						; from CODE_C47E04
	stz.w Yvel,x
	lda.w #$1000
	sta.w Xvel,x
	lda.b d0
	sec
	sbc.w #$FFF8
	bmi CODE_C47E64
	stz.w Xvel,x
	lda.w facedir,x
	cmp.b d2
	bne CODE_C47E64
CODE_C47E2D:						; from CODE_C47D81
	lda.w temp4,x
	sta.w Ypos,x
	lda.w #$009B
	sta.w Xpos,x
	lda.w attribute,x
	and.w #$F7FF
	sta.w attribute,x
	lda.w #$0002
	sta.w facedir,x
	sta.w pfalock,x
	lda.w #$18BE
	jsl.l SetSPAFromA
	lda.w pflags,x
	and.w #$BFFF
	sta.w pflags,x
	lda.w #$000E
	sta.b d0
	jml.l assreplace
CODE_C47E64:						; from CODE_C47E91, CODE_C47E12
	rtl
CODE_C47E65:						; from CODE_C47D39 and other segments
	ldy.b a2
	lda.w teampads,y
	cmp.w #$0004
	bcc CODE_C47E91
	sta.b d1
	lda.w #$0006
	sta.b d0
	lda.w tmsort,y
	tax
	ldy.w #$0000
CODE_C47E7D:						; from CODE_C47E85
	lda.w position,x
	bmi CODE_C47E85
	beq CODE_C47E85
	iny
CODE_C47E85:						; from CODE_C47E7D
	inx
	inx
	dec.b d0
	bne CODE_C47E7D
	cpy.b d1
	beq CODE_C47EA2
	bcc CODE_C47EA2
CODE_C47E91:						; from CODE_C47E65, CODE_C47EFA
	ldx.b curobj
	lda.w playerpad,x
	bpl CODE_C47E9B
	jmp.w CODE_C47E64
CODE_C47E9B:						; from CODE_C47E91
	sta.b d4
	jsl.l PassPadToTeammate
	rtl
CODE_C47EA2:						; from CODE_C47E85
	cpy.w #$0003
	bne CODE_C47ECB
	ldx.b a2
	ldy.w $05C0,x
CODE_C47EAC:						; from CODE_C47EB6
	iny
	iny
	cpy.w #$000A
	bne CODE_C47EB6
	ldy.w #$0000
CODE_C47EB6:						; from CODE_C47EAC
	lda.w $1525,y
	bpl CODE_C47EAC
	and.w #$00FF
	cmp.b a2
	bne CODE_C47EAC
	sta.w $1525,y
	inc a
	inc a
	lsr a
	sta.w cont1team,y
CODE_C47ECB:						; from CODE_C47EA2
	ldx.b a2
	ldy.w $05C0,x
	bra CODE_C47EDC
CODE_C47ED2:						; from CODE_C47EDC
	iny
	iny
	cpy.w #$000A
	bne CODE_C47EDC
	ldy.w #$0000
CODE_C47EDC:						; from CODE_C47ECB, CODE_C47ED2
	lda.w $1525,y
	cmp.b a2
	bne CODE_C47ED2
	ora.w #$FF00
	sta.w $1525,y
	lda.w #$0000
	sta.w cont1team,y
	phy
	iny
	iny
	cpy.w #$000A
	bne CODE_C47EFA
	ldy.w #$0000
CODE_C47EFA:						; from CODE_C47EDC
	tya
	sta.w $05C0,x
	ply
	ldx.w c1playernum,y
	lda.w #$FFFF
	sta.w c1playernum,y
	sta.w playerpad,x
	jmp.w CODE_C47E91
PenBoxSpot:							; from CODE_C47F94, CODE_C47D39 and other segments
	lda.w #$000B
	sta.b d0
	lda.w PBnum
	sta.b d1
	lda.w pfteam,x
	bne CODE_C47F2A
	lda.b d1
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b d1
	lda.w #$FFF5
	sta.b d0
CODE_C47F2A:						; from PenBoxSpot
	lda.b d1
	and.w #$000F
	sta.b d1
	cmp.w #$0003
	bcc CODE_C47F3B
	lda.w #$0002
	sta.b d1
CODE_C47F3B:						; from CODE_C47F2A
	inc.b d1
	inc.b d1
	inc.b d1
	phx
	lda.b d0
	ldx.b d1
	jsl.l Mul16S
	plx
	rtl
assdopen:							; from CODE_C47F94 and other segments
	lda.w #$0010
	sta.b d0
	lda.w pfteam,x
	beq CODE_C47F5B
	lda.w #$0001
	sta.b d0
CODE_C47F5B:						; from assdopen
	lda.w PBnum
	clc
	adc.b d0
	sta.w PBnum
	lda.w #$FFFF
	sta.w position,x
	lda.w attribute,x
	and.w #$F7FF
	sta.w attribute,x
	lda.w #$02A4
	sta.w frame,x
	rtl
SeatPenaltyBox:						; from CODE_C474C4 and other segments
	lda.w $1864
	cmp.w #$0001
	beq CODE_C47FB4
	lda.w penshot
	ora.w PenShotActive
	ora.w $189C
	bne CODE_C47FB4
	phx
	stz.w PBnum
	ldx.w #$0000
CODE_C47F94:						; from CODE_C47FAC
	lda.w position,x
	bpl CODE_C47FAC
	jsl.l PenBoxSpot
	lda.b r2
	sta.w Ypos,x
	lda.w #$009B
	sta.w Xpos,x
	jsl.l assdopen
CODE_C47FAC:						; from CODE_C47F94
	inx
	inx
	cpx.w #$0018
	bcc CODE_C47F94
	plx
CODE_C47FB4:						; from SeatPenaltyBox
	rtl

; Segment bankC4_4000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C43FC8
CODE_C43FC8:						; called from other segments
	stz.w collflag
	lda.w pfnc,x
	bne CODE_C4402C
	pei ($8B)
	pei ($87)
	lda.w Xpos,x
	sta.b d2
	lda.w Ypos,x
	sta.b d3
	lda.w $0BA0,x
	sta.w $07FA
	lda.w $0BC0,x
	sta.w wcradiusy
	jsl.l checkwallcoll
	lda.w Wallcos,x
	ora.w Wallsin,x
	bne CODE_C4401D
	cpx.w #$0018
	bcs CODE_C4401D
	txa
	jsl.l CODE_C37FE2
	lda.w Xpos,x
	clc
	adc.b d0
	sta.b d2
	lda.w Ypos,x
	clc
	adc.b d1
	sta.b d3
	lda.w #$0001
	sta.w $07FA
	sta.w wcradiusy
	jsl.l checkwallcoll
CODE_C4401D:						; from CODE_C43FC8
	pla
	sta.b d2
	pla
	sta.b d3
	lda.w position,x
	bmi CODE_C4402C
	jsl.l checkplcoll
CODE_C4402C:						; from CODE_C43FC8, CODE_C4401D
	lda.w collflag
	beq CODE_C44034
	jmp.w CODE_C440AD
CODE_C44034:						; from CODE_C4402C
	lda.w OOlistpos,x
	sta.b d1
CODE_C44039:						; from CODE_C44039
	ldy.b d1
	cpy.w #$000F
	beq CODE_C44070
	lda.w $10E1,y
	and.w #$00FF
	sta.b d4
	tay
	lda.b d3
	sec
	sbc.w Ylist,y
	beq CODE_C44070
	bmi CODE_C44070
	inc.w OOlistpos,x
	lda.w OOlistpos,y
	dec a
	sta.w OOlistpos,y
	sep #$30
	ldy.b d1
	lda.b d4
	sta.w OOlist,y
	txa
	sta.w $10E1,y
	rep #$30
	inc.b d1
	bra CODE_C44039
CODE_C44070:						; from CODE_C44039
	lda.w OOlistpos,x
	beq CODE_C440A7
	sta.b d1
CODE_C44077:						; from CODE_C44077
	ldy.b d1
	lda.w $10DF,y
	and.w #$00FF
	sta.b d4
	tay
	lda.b d3
	sec
	sbc.w Ylist,y
	bpl CODE_C440A7
	dec.w OOlistpos,x
	lda.w OOlistpos,y
	inc a
	sta.w OOlistpos,y
	sep #$30
	ldy.b d1
	lda.b d4
	sta.w OOlist,y
	txa
	sta.w $10DF,y
	rep #$30
	dec.b d1
	bne CODE_C44077
CODE_C440A7:						; from CODE_C44070, CODE_C44077
	lda.b d3
	sta.w Ylist,x
	rtl
CODE_C440AD:						; from CODE_C4402C
	lda.w SPA,x
	cmp.w #$28F6
	bcs CODE_C440C1
	lda.w $0920,x
	sta.w Xpos,x
	lda.w $0960,x
	sta.w Ypos,x
CODE_C440C1:						; from CODE_C440AD
	rtl
checkwallcoll:						; from CODE_C43FC8 and other segments
	lda.w #$013E
	sec
	sbc.w wcradiusy
	pha
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0052
	sta.b d5
	lda.w #$009B
	sec
	sbc.w $07FA
	pha
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0052
	sta.b d4
	lda.b d3
	pha
	ldy.b d2
	phy
	dec a
	cmp.b d5
	bpl CODE_C4410F
	lda.b d2
	cmp.b d4
	bmi CODE_C44139
	lda.w #$0000
	sec
	sbc.b d4
	sta.b d4
	cmp.b d2
	bmi CODE_C44139
	lda.w #$001A
	sta.b a2
	jsl.l checkgoal
	jmp.w CODE_C441BE
CODE_C4410F:						; from checkwallcoll
	lda.w #$0000
	sec
	sbc.b d5
	sta.b d5
	cmp.b d3
	bpl CODE_C44136
	lda.b d2
	cmp.b d4
	bmi CODE_C44139
	lda.w #$0000
	sec
	sbc.b d4
	sta.b d4
	cmp.b d2
	bmi CODE_C44139
	lda.w #$0018
	sta.b a2
	jsl.l checkgoal
CODE_C44136:						; from CODE_C4410F
	jmp.w CODE_C441BE
CODE_C44139:						; from checkwallcoll, CODE_C4410F
	lda.b d2
	sec
	sbc.b d4
	sta.b d2
	eor.w #$FFFF
	inc a
	sta.b d1
	bit.w #$8000
	beq CODE_C4414F
CODE_C4414B:						; called from other segments
	eor.w #$FFFF
	inc a
CODE_C4414F:						; from CODE_C44139
	sta.b tmp4
	lda.b d3
	sec
	sbc.b d5
	sta.b d0
	bit.w #$8000
	beq CODE_C44161
	eor.w #$FFFF
	inc a
CODE_C44161:						; from CODE_C4414F
	sta.b $B1
	cmp.b tmp4
	bcc CODE_C4416F
	lda.b tmp4
	lsr a
	lsr a
	adc.b $B1
	bra CODE_C44173
CODE_C4416F:						; from CODE_C44161
	lsr a
	lsr a
	adc.b tmp4
CODE_C44173:						; from CODE_C44161
	cmp.w #$0053
	bcc CODE_C441BE
	sta.b d3
	lda.b d0
	xba
	and.w #$FF00
	tax
	lda.b d3
	jsl.l DivX8S
	cmp.w #$FF01
	bpl CODE_C4418F
	lda.w #$FF01
CODE_C4418F:						; from CODE_C44173
	cmp.w #$00FF
	bmi CODE_C44197
	lda.w #$00FF
CODE_C44197:						; from CODE_C4418F
	sta.b d0
	lda.b d1
	xba
	and.w #$FF00
	tax
	lda.b d3
	jsl.l DivX8S
	ldx.b a3
	cmp.w #$FF01
	bpl CODE_C441B0
	lda.w #$FF01
CODE_C441B0:						; from CODE_C44197
	cmp.w #$00FF
	bmi CODE_C441B8
	lda.w #$00FF
CODE_C441B8:						; from CODE_C441B0
	sta.b d1
	jsl.l wallcollb
CODE_C441BE:						; from checkwallcoll, CODE_C44136, CODE_C44173
	pla
	sta.b d2
	pla
	sta.b d3
	pla
	sta.b d4
	pla
	sta.b d5
	lda.w Wallcos,x
	ora.w Wallsin,x
	bne CODE_C4420E
	stz.b d1
	lda.w #$00FF
	sta.b d0
	lda.b d3
	dec a
	cmp.b d5
	bpl wallcollb
	lda.w #$FF01
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d5
	dec a
	cmp.b d3
	bpl wallcollb
	stz.b d0
	lda.w #$FF01
	sta.b d1
	lda.b d2
	dec a
	cmp.b d4
	bpl wallcollb
	lda.w #$00FF
	sta.b d1
	lda.w #$0000
	sec
	sbc.b d4
	dec a
	cmp.b d2
	bpl wallcollb
CODE_C4420E:						; from CODE_C441BE
	rtl
CODE_C4420F:						; from wallcollb
	jmp.w wallcoll
CODE_C44212:						; from wallcollb
	jmp.w wallcollb_out
wallcollb:							; from CODE_C441BE, CODE_C441B8 and other segments
	cpx.w #$001C
	bne CODE_C4420F
	lda.w puckz
	cmp.w #$0021
	bpl CODE_C44212
	lda.w puckz
	cmp.w #$0016
	bcc CODE_C4420F
	lda.w pucky
	cmp.w #$012F
	bmi CODE_C44212
	lda.w $0830
	cmp.w #$000D
	bmi CODE_C4420F
	lda.w $0830
	cmp.w #$0010
	bpl CODE_C4420F
	lda.w puckvy
	cmp.w #$0FA0
	bmi CODE_C4420F
	phx
	lda.w puckvy
	pha
	asl a
	pla
	ror a
	sta.w puckvy
	inx
	inx
	stx.b a3
	plx
	stx.b a3
	lda.l $7E24CA
	clc
	adc.w #$0258
	sta.l $7E24CA
	lda.w #$005A
	sta.b crowdhold
	lda.w CwdExciteLvl
	clc
	adc.w #$000F
	bmi wallcollb_out
	sta.w CwdExciteLvl
wallcollb_out:						; from wallcollb, CODE_C44212
	lda.w #$0040
	tsb.w sflags
	sta.w $109C
	lda.w pucky
	bpl CODE_C4428D
	lda.w #$8000
	tsb.w $08FC
CODE_C4428D:						; from wallcollb_out
	stz.w $0874
	lda.w gmclock
	bne CODE_C442AA
	lda.w $2002
	asl a
	sta.b a3
	tax
	lda.w #$0006
	sta.b d0
	jsl.l ShootoutWonBy
	ldx.w #$001C
	stx.b a3
CODE_C442AA:						; from CODE_C4428D
	jsl.l EndPenaltyShot
	stz.w breakaway
	stz.w onetimer
	rtl
wallcoll:							; from CODE_C4420F, CODE_C44766, CODE_C4468C, ...
	lda.b d0
	sta.w Wallcos,x
	lda.b d1
	sta.w Wallsin,x
	pei ($87)
	pei ($8B)
	pei ($83)
	lda.b d0
	pha
	txy
	ldx.w Yvel,y
	jsl.l Mul16x8S
	lda.b $35
	sta.b d0
	ldx.w Xvel,y
	lda.b d1
	jsl.l Mul16x8S
	lda.b d0
	sec
	sbc.b $35
	eor.w #$FFFF
	inc a
	sta.b d2
	ldx.w Xvel,y
	lda.b $01,s
	jsl.l Mul16x8S
	lda.b $35
	sta.b d0
	ldx.w Yvel,y
	lda.b d1
	jsl.l Mul16x8S
	lda.b $35
	clc
	adc.b d0
	sta.b d3
	tyx
	cpx.w #$001C
	beq CODE_C4430E
	jmp.w CODE_C443A1
CODE_C4430E:						; from wallcoll
	lda.w #$1000
	trb.w sflags
	lda.b d2
	bmi CODE_C4431B
	jmp.w CODE_C44428
CODE_C4431B:						; from CODE_C4430E
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C44325
	ora.w #$C000
CODE_C44325:						; from CODE_C4431B
	sta.b d2
	sec
	sbc.w #$FC00
	bpl CODE_C4437A
	jsl.l RandomWord
	and.w #$07FF
	eor.w #$FFFF
	inc a
	sta.w puckvz
	sta.b d0
	jsl.l puckflip
	lda.w puckvx
	ldy.w puckvy
	jsl.l ApproxLength
	and.w #$7F00
	sta.b tmp0
	xba
	tsb.b tmp0
	bit.w $0830
	bpl CODE_C44360
	sep #$20
	lsr a
	lsr a
	sta.b $A0
	bra CODE_C44366
CODE_C44360:						; from CODE_C44325
	sep #$20
	lsr a
	lsr a
	sta.b tmp0
CODE_C44366:						; from CODE_C44325
	rep #$20
	lda.w #$0003
	ldy.w puckz
	cpy.w #$000B
	bcs CODE_C44376
	lda.w #$0003
CODE_C44376:						; from CODE_C44366
	jsl.l CODE_CF0418
CODE_C4437A:						; from CODE_C44325
	lda.b d3
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0200
	beq CODE_C4438A
	ora.w #$FC00
CODE_C4438A:						; from CODE_C4437A
	sta.b d0
	pha
	asl a
	pla
	ror a
	sta.b $81
	lda.b d3
	sec
	sbc.b d0
	sec
	sbc.b $81
	sta.b d3
	bra CODE_C443E4
CODE_C4439E:						; from CODE_C443A1
	jmp.w CODE_C44428
CODE_C443A1:						; from wallcoll
	lda.b d2
	sec
	sbc.w #$03E8
	bpl CODE_C4439E
	lda.b d2
	sec
	sbc.w #$F000
	bpl CODE_C443CB
	lda.w $0A00,x
	sec
	sbc.w #$000A
	bmi CODE_C443CB
	lda.w Xvel,x
	sta.b p0
	lda.w Yvel,x
	sta.b $3A
	lda.w #$0003
	jsl.l CODE_CF040B
CODE_C443CB:						; from CODE_C443A1
	lda.b d2
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C443D7
	ora.w #$C000
CODE_C443D7:						; from CODE_C443CB
	sta.b d2
	sec
	sbc.w #$FC7C
	bmi CODE_C443E4
	lda.w #$FC18
	sta.b d2
CODE_C443E4:						; from CODE_C443D7, CODE_C4438A
	lda.b $01,s
	ldx.b d3
	jsl.l Mul16x8S
	lda.b $35
	sta.b tmp0
	lda.b $03,s
	ldx.b d2
	jsl.l Mul16x8S
	lda.b tmp0
	sec
	sbc.b $35
	ldx.b a3
	sta.w Xvel,x
	lda.b $03,s
	ldx.b d3
	jsl.l Mul16x8S
	lda.b $35
	sta.b d3
	lda.b $01,s
	ldx.b d2
	jsl.l Mul16x8S
	lda.b $35
	clc
	adc.b d3
	ldx.b a3
	sta.w Yvel,x
	lda.w puckvz
	bmi CODE_C44428
	stz.w puckvz
CODE_C44428:						; from CODE_C4430E, CODE_C443E4, CODE_C4439E
	pla
	pla
	pla
	sta.b d3
	pla
	sta.b d2
	cpx.w #$001C
	bne CODE_C44444
	lda.w puckc
	bpl CODE_C44444
	jsl.l EndPenaltyShot
	stz.w breakaway
	stz.w onetimer
CODE_C44444:						; from CODE_C44428
	rtl
checkgoal:							; from checkwallcoll, CODE_C4410F and other segments
	cpx.w #$001C
	beq CODE_C4444D
	jmp.w checkgoalp
CODE_C4444D:						; from checkgoal
	ldy.w puckc
	bmi CODE_C44457
	lda.w position,y
	beq CODE_C444AD
CODE_C44457:						; from CODE_C4444D
	lda.w puckz
	cmp.w #$000D
	bpl CODE_C444AD
	ldy.b a2
	lda.b d2
	sec
	sbc.w Xpos,y
	sta.b d2
	cmp.w #$0017
	bpl CODE_C444AD
	lda.b d2
	cmp.w #$FFEA
	bmi CODE_C444AD
	lda.w #$0009
	sta.b d5
	lda.b d3
	sec
	sbc.w Ypos,y
	sta.b d3
	cmp.w #$000A
	bpl CODE_C444AD
	lda.w #$0000
	sec
	sbc.b d5
	sta.b d5
	lda.b d3
	cmp.w #$FFF7
	bmi CODE_C444AD
	lda.w #$FFFF
	sta.w collflag
	lda.w $08DC
	cmp.w #$000D
	bmi CODE_C444AE
	lda.w $08DC
	sta.w puckz
	jmp.w CODE_C44645
CODE_C444AD:						; from CODE_C4444D, CODE_C44457
	rtl
CODE_C444AE:						; from CODE_C44457
	stz.w $0FFC
	lda.w puckc
	bmi CODE_C444DF
	tay
	lda.w #$FFFF
	sta.w puckc
	lda.w #$0008
	sta.w nopuck,y
	lda.w pucky
	sta.b d1
	lda.w pfgoal,y
	bne CODE_C444D5
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
CODE_C444D5:						; from CODE_C444AE
	lda.b d1
	bpl CODE_C444DF
	lda.w #$0001
	sta.w $0FFC
CODE_C444DF:						; from CODE_C444AE, CODE_C444D5
	lda.w #$FF01
	sta.b d0
	lda.w #$FF01
	sta.b p0
	lda.w $08B8,x
	sec
	sbc.w $0980,x
	sta.b d1
	lda.w Ypos,x
	sbc.w $0960,x
	sta.b $85
	lda.b $84
	sta.b d1
	cmp.w #$0000
	beq CODE_C44580
	bmi CODE_C4451D
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b p0
	sta.b p0
	lda.w #$0000
	sec
	sbc.b d5
	sta.b d5
CODE_C4451D:						; from CODE_C444DF
	lda.b d5
	clc
	adc.b d3
	sta.b d5
	sta.b r2
	lda.w $0836,x
	sec
	sbc.w $0940,x
	sta.b d3
	lda.w Xpos,x
	sbc.w $0920,x
	sta.b $8D
	lda.b $8C
	sta.b d3
	ldx.b r2
	jsl.l Mul16S
	ldx.b a3
	lda.b d1
	bit.w #$8000
	beq CODE_C4454E
	eor.w #$FFFF
	inc a
CODE_C4454E:						; from CODE_C4451D
	sta.b r1
	lda.b $36
	bit.w #$8000
	beq CODE_C4455B
	eor.w #$FFFF
	inc a
CODE_C4455B:						; from CODE_C4454E
	cmp.b r1
	bcs CODE_C44580
	lda.b d1
	sta.b r1
	jsl.l Div32S
	lda.b r0
	sta.b d5
	ldx.b a3
	lda.b d2
	sec
	sbc.b d5
	sta.b d2
	cmp.w #$FFEA
	bmi CODE_C44580
	lda.b d2
	cmp.w #$0017
	bmi CODE_C445A9
CODE_C44580:						; from CODE_C444DF, CODE_C4455B
	jmp.w CODE_C44655
CODE_C44583:						; from CODE_C445A9
	lda.w puckvy
	cmp.w #$0800
	bpl CODE_C445A3
	cmp.w #$F800
	bmi CODE_C445A3
	cmp.w #$0000
	bpl CODE_C4459D
	lda.w #$F800
	sta.w puckvy
	bra CODE_C445A3
CODE_C4459D:						; from CODE_C44583
	lda.w #$0800
	sta.w puckvy
CODE_C445A3:						; from CODE_C44583
	jmp.w wallcoll
CODE_C445A6:						; from CODE_C445A9
	jmp.w Goal
CODE_C445A9:						; from CODE_C4455B
	stz.b d1
	lda.w pucky
	eor.b p0
	bmi CODE_C44583
	lda.w #$0000
	sec
	sbc.b p0
	sta.b p0
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w $0FFC
	bne CODE_C44583
	lda.w puckz
	cmp.w #$000D
	beq CODE_C445DD
	lda.b d2
	cmp.w #$0012
	bpl CODE_C445DD
	lda.b d2
	cmp.w #$FFEF
	bpl CODE_C445A6
CODE_C445DD:						; from CODE_C445A9
	jsl.l ChkShotStat
	stz.w breakaway
	stz.w onetimer
	lda.w #$000C
	jsl.l CODE_CF040B
	lda.l $7E24CA
	clc
	adc.w #$012C
	sta.l $7E24CA
	lda.w #$003C
	sta.b crowdhold
	lda.w CwdExciteLvl
	clc
	adc.w #$0028
	bmi CODE_C4460B
	sta.w CwdExciteLvl
CODE_C4460B:						; from CODE_C445DD
	jsl.l RandomWord
	and.w #$0FFF
	sta.b d0
	lda.w pucky
	bmi CODE_C44621
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
CODE_C44621:						; from CODE_C4460B
	lda.b d0
	sta.w puckvy
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w puckvx
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w puckvz
	jmp.w puckflip
CODE_C44645:						; from CODE_C44457
	lda.w puckvz
	bit.w #$8000
	beq CODE_C44651
	eor.w #$FFFF
	inc a
CODE_C44651:						; from CODE_C44645
	sta.w puckvz
	rtl
CODE_C44655:						; from CODE_C44580
	lda.w puckvx
	cmp.w #$0800
	bpl CODE_C44675
	cmp.w #$F800
	bmi CODE_C44675
	cmp.w #$0000
	bpl CODE_C4466F
	lda.w #$F800
	sta.w puckvx
	bra CODE_C44675
CODE_C4466F:						; from CODE_C44655
	lda.w #$0800
	sta.w puckvx
CODE_C44675:						; from CODE_C44655
	stz.b d0
	lda.w #$00FF
	sta.b d1
	lda.w $0830
	sec
	sbc.w $093C
	sta.b d2
	bmi CODE_C4468C
	lda.w #$FF01
	sta.b d1
CODE_C4468C:						; from CODE_C44675
	jmp.w wallcoll
checkgoalp:							; from checkgoal
	lda.w pflags,x
	bit.w #$8000
	bne CODE_C4469C
	cpx.w #$0017
	bcc CODE_C4469D
CODE_C4469C:						; from checkgoalp, CODE_C4469D, CODE_C446B1, CODE_C446C7
	rtl
CODE_C4469D:						; from checkgoalp
	ldy.b a2
	cpy.w #$0018
	beq CODE_C446B1
	lda.b d3
	sec
	sbc.w wcradiusy
	cmp.w #$FF10
	bpl CODE_C4469C
	bra CODE_C446BC
CODE_C446B1:						; from CODE_C4469D
	lda.b d3
	clc
	adc.w wcradiusy
	cmp.w #$00F0
	bmi CODE_C4469C
CODE_C446BC:						; from CODE_C4469D
	lda.b d2
	bit.w #$8000
	beq CODE_C446C7
	eor.w #$FFFF
	inc a
CODE_C446C7:						; from CODE_C446BC
	sec
	sbc.w $07FA
	cmp.w #$0040
	bpl CODE_C4469C
	lda.b d3
	pha
	sec
	sbc.w Ypos,y
	sta.b d3
	eor.w #$FFFF
	inc a
	sta.b d0
	lda.b d2
	pha
	sec
	sbc.w Xpos,y
	sta.b d1
	sta.b r1
	tax
	jsl.l Mul8S
	sta.b r2
	ldx.b a3
	lsr a
	lsr a
	cmp.w #$0101
	bcs CODE_C44710
	sta.b d2
	lda.b d3
	sta.b $32
	tax
	jsl.l Mul8S
	asl a
	sta.b $36
	ldx.b a3
	clc
	adc.b d2
	cmp.w #$0101
CODE_C44710:						; from CODE_C446C7
	bcs CODE_C4476E
	pla
	sta.b d2
	pla
	sta.b d3
	jsr.w CODE_C44775
	pei ($8B)
	pei ($87)
	lda.b r1
	ldy.b $32
	jsl.l ApproxLength
	inc a
	sta.b d2
	lda.b d0
	xba
	and.w #$FF00
	tax
	lda.b d2
	jsl.l DivX8S
	cmp.w #$00FF
	bmi CODE_C4473F
	lda.w #$00FF
CODE_C4473F:						; from CODE_C44710
	cmp.w #$FF01
	bpl CODE_C44747
	lda.w #$FF01
CODE_C44747:						; from CODE_C4473F
	sta.b d0
	lda.b d1
	xba
	and.w #$FF00
	tax
	lda.b d2
	jsl.l DivX8S
	cmp.w #$00FF
	bmi CODE_C4475E
	lda.w #$00FF
CODE_C4475E:						; from CODE_C44747
	cmp.w #$FF01
	bpl CODE_C44766
	lda.w #$FF01
CODE_C44766:						; from CODE_C4475E
	sta.b d1
	ldx.b a3
	jsl.l wallcoll
CODE_C4476E:						; from CODE_C44710
	pla
	sta.b d2
	pla
	sta.b d3
	rtl
CODE_C44775:						; from CODE_C44710
	pei ($7F)
	pei ($83)
	lda.w seed
	and.w #$01C0
	bne CODE_C447BC
	lda.w SPA,x
	cmp.w #$21BC
	bne CODE_C447BC
	ldy.b a2
	lda.w pucky
	sec
	sbc.w Ypos,y
	cmp.w #$FF80
	bmi CODE_C447BC
	cmp.w #$0080
	bpl CODE_C447BC
	lda.w Xvel,x
	sta.b d0
	lda.w Yvel,x
	sta.b d1
	cmp.w #$DFFF
	bmi CODE_C447C3
	cmp.w #$2001
	bpl CODE_C447C3
	lda.b d0
	cmp.w #$DFFF
	bmi CODE_C447C3
	cmp.w #$2001
	bpl CODE_C447C3
CODE_C447BC:						; from CODE_C44775
	pla
	sta.b d1
	pla
	sta.b d0
CODE_C447C2:						; from CODE_C447EF
	rts
CODE_C447C3:						; from CODE_C44775
	pla
	pla
	lda.b d0
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq CODE_C447D2
	ora.w #$E000
CODE_C447D2:						; from CODE_C447C3
	sta.b d0
	cmp.w #$8000
	ror a
	clc
	adc.b d0
	sta.b d0
	ldy.b a2
	sta.w Xvel,y
	lda.b d1
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq CODE_C447EF
	ora.w #$E000
CODE_C447EF:						; from CODE_C447D2
	sta.b d1
	cmp.w #$8000
	ror a
	clc
	adc.b d1
	sta.b d1
	sta.w Yvel,y
	stz.w Xvel,x
	stz.w Yvel,x
	lda.w #$0040
	tsb.w sflags
	lda.w gmclock
	bne CODE_C447C2
	pla
	lda.w #$0008
	sta.b d0
	jmp.w AddPenalty2
checkplcoll:						; from CODE_C4401D and other segments
	lda.w pflags,x
	bit.w #$8000
	bne CODE_C44824
	cpx.w #$0018
	bcc CODE_C44825
CODE_C44824:						; from checkplcoll
	rtl
CODE_C44825:						; from checkplcoll
	lda.w OOlistpos,x
	sta.b d1
CODE_C4482A:						; from CODE_C4486D
	ldy.b d1
	cpy.w #$000F
	beq CODE_C44871
	lda.w $10E1,y
	and.w #$00FF
	tay
	lda.w Ylist,y
	sec
	sbc.b d3
	sec
	sbc.w #$000E
	bpl CODE_C44871
	lda.w position,y
	bmi CODE_C4486D
	lda.w Xpos,y
	sec
	sbc.b d2
	cmp.w #$FFF1
	bmi CODE_C4486D
	cmp.w #$000F
	bpl CODE_C4486D
	lda.w pflags,y
	and.w #$8000
	ora.w pfnc,y
	bne CODE_C4486D
	cpy.w #$0018
	bcs CODE_C4486D
	jsl.l CODE_C448BB
CODE_C4486D:						; from CODE_C4482A
	inc.b d1
	bra CODE_C4482A
CODE_C44871:						; from CODE_C4482A
	lda.w OOlistpos,x
	beq CODE_C448BA
	sta.b d1
CODE_C44878:						; from CODE_C448B6
	ldy.b d1
	lda.w $10DF,y
	and.w #$00FF
	tay
	lda.b d3
	sec
	sbc.w Ylist,y
	sec
	sbc.w #$000E
	bpl CODE_C448BA
	lda.w position,y
	bmi CODE_C448B6
	lda.w Xpos,y
	sec
	sbc.b d2
	cmp.w #$FFF1
	bmi CODE_C448B6
	cmp.w #$000F
	bpl CODE_C448B6
	lda.w pflags,y
	and.w #$8000
	ora.w pfnc,y
	bne CODE_C448B6
	cpy.w #$0018
	bcs CODE_C448B6
	jsl.l CODE_C448BB
CODE_C448B6:						; from CODE_C44878
	dec.b d1
	bne CODE_C44878
CODE_C448BA:						; from CODE_C44871, CODE_C44878
	rtl
CODE_C448BB:						; from CODE_C4482A, CODE_C44878 and other segments
	pei ($7F)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($8B)
	pei ($8F)
	pei ($93)
	sty.b a2
	lda.w Xpos,y
	sec
	sbc.w Xpos,x
	sta.b d2
	lda.w Ypos,y
	sec
	sbc.w Ypos,x
	sta.b d3
	ldy.b d2
	jsl.l ApproxLength
	cmp.w #$0010
	bmi CODE_C448EB
	jmp.w CODE_C44AF5
CODE_C448EB:						; from CODE_C448BB
	ldy.b a2
	lda.w Xvel,x
	sec
	sbc.w Xvel,y
	sta.b d0
	lda.w Yvel,x
	sec
	sbc.w Yvel,y
	sta.b d1
	lda.b d0
	ora.b d1
	bne CODE_C44908
	jmp.w CODE_C44AF5
CODE_C44908:						; from CODE_C448EB
	pei ($83)
	pei ($7F)
	lda.b d3
	ldx.b d1
	jsl.l Mul16x8S
	lda.b $36
	sta.b $85
	lda.b r2
	sta.b d1
	lda.b d2
	ldx.b d0
	jsl.l Mul16x8S
	ldx.b a3
	lda.b r2
	clc
	adc.b d1
	sta.b d1
	lda.b $36
	adc.b $85
	sta.b $85
	bpl CODE_C44938
	jmp.w CODE_C44B0B
CODE_C44938:						; from CODE_C44908
	lda.w SPA,x
	cmp.w #$2280
	bcc CODE_C44966
	cmp.w #$2345
	bcs CODE_C44966
	stz.w pfalock,x
	stz.w pf2aip,x
	ldy.w $09E0,x
	lda.w SPA,y
	cmp.w #$2280
	bcc CODE_C44964
	cmp.w #$2345
	bcs CODE_C44964
	lda.w #$0000
	sta.w pfalock,y
	sta.w pf2aip,y
CODE_C44964:						; from CODE_C44938
	ldy.b a2
CODE_C44966:						; from CODE_C44938
	lda.w SPA,y
	cmp.w #$2280
	bcc CODE_C44994
	cmp.w #$2345
	bcs CODE_C44994
	lda.w #$0000
	sta.w pfalock,y
	sta.w pf2aip,y
	ldx.w $09E0,y
	lda.w SPA,x
	cmp.w #$2280
	bcc CODE_C44992
	cmp.w #$2345
	bcs CODE_C44992
	stz.w pfalock,x
	stz.w pf2aip,x
CODE_C44992:						; from CODE_C44966
	ldx.b a3
CODE_C44994:						; from CODE_C44966
	lda.b $84
	sta.b d1
	lda.w pfteam,x
	cmp.w pfteam,y
	beq CODE_C44A19
	lda.b d1
	lsr a
	lsr a
	lsr a
	lsr a
	cmp.w #$0005
	bcs CODE_C449AE
	lda.w #$0005
CODE_C449AE:						; from CODE_C44994
	sta.b d4
	lda.w SPA,x
	cmp.w #$2082
	bcc CODE_C449C6
	cmp.w #$21BD
	bcs CODE_C449C6
CODE_C449BD:						; from CODE_C449C6
	lda.b d4
	lsr a
	adc.b d4
	sta.b d4
	bra CODE_C449D3
CODE_C449C6:						; from CODE_C449AE
	lda.w SPA,y
	cmp.w #$2082
	bcc CODE_C449D3
	cmp.w #$21BD
	bcc CODE_C449BD
CODE_C449D3:						; from CODE_C449BD, CODE_C449C6
	lda.b d4
	clc
	adc.w $0A00,x
	sta.w $0A00,x
	lda.b d4
	clc
	adc.w $0A00,y
	sta.w $0A00,y
	txa
	sta.w $09E0,y
	tya
	sta.w $09E0,x
	lda.b d4
	cmp.w #$0014
	bcc CODE_C44A02
	cpx.w puckc
	beq CODE_C449FE
	cpy.w puckc
	bne CODE_C44A02
CODE_C449FE:						; from CODE_C449D3
	jsl.l CODE_C44EE1
CODE_C44A02:						; from CODE_C449D3
	pei ($83)
	pei ($87)
	pei ($8B)
	jsl.l checkint
	jsl.l checkcheck
	pla
	sta.b d3
	pla
	sta.b d2
	pla
	sta.b d1
CODE_C44A19:						; from CODE_C44994
	lda.b d1
	sta.b d4
	pla
	sta.b d0
	pla
	sta.b d1
	lda.w collflag
	bpl CODE_C44A2B
	jmp.w CODE_C44AF5
CODE_C44A2B:						; from CODE_C44A19
	lda.b d2
	ldx.b d1
	jsl.l Mul16x8S
	lda.b $36
	sta.b $85
	lda.b r2
	sta.b d1
	lda.b d3
	ldx.b d0
	jsl.l Mul16x8S
	lda.b r2
	sec
	sbc.b d1
	sta.b d1
	lda.b $36
	sbc.b $85
	sta.b $85
	lda.b $84
	sta.b d5
	ldx.b a3
	lda.w $0DE0,x
	clc
	adc.w #$008C
	sta.b d0
	ldy.b a2
	lda.w $0DE0,y
	clc
	adc.w #$008C
	sta.b d1
	lda.b d1
	clc
	adc.b d0
	sta.b d1
	lda.b d0
	ldx.b d4
	jsl.l Mul16x8XS
	lda.b d1
	sta.b r1
	jsl.l Div32S
	lda.b r0
	sta.b d0
	sta.b d1
	lda.b d3
	ldx.b d5
	jsl.l Mul16x8S
	lda.b r2
	sta.b tmp0
	lda.b d2
	ldx.b d0
	jsl.l Mul16x8S
	lda.b r2
	clc
	adc.b tmp0
	ldx.b a3
	clc
	adc.w Xvel,y
	sta.w Xvel,x
	lda.b d2
	ldx.b d5
	jsl.l Mul16x8S
	lda.b r2
	sta.b tmp0
	lda.b d3
	ldx.b d0
	jsl.l Mul16x8S
	lda.b r2
	sec
	sbc.b tmp0
	ldx.b a3
	clc
	adc.w Yvel,y
	sta.w Yvel,x
	lda.b d2
	ldx.b d1
	jsl.l Mul16x8S
	lda.b r2
	clc
	adc.w Xvel,y
	sta.w Xvel,y
	lda.b d3
	ldx.b d1
	jsl.l Mul16x8S
	lda.b r2
	clc
	adc.w Yvel,y
	sta.w Yvel,y
	ldx.b a3
	lda.w #$FFFF
	sta.w collflag
CODE_C44AF5:						; from CODE_C448BB, CODE_C448EB, CODE_C44B0B, CODE_C44A19
	pla
	sta.b d5
	pla
	sta.b d4
	pla
	sta.b d3
	pla
	sta.b d2
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b d0
	rtl
CODE_C44B0B:						; from CODE_C44908
	pla
	pla
	bra CODE_C44AF5
checkpuckcoll:						; called from other segments
	lda.w puckz
	sec
	sbc.w #$0010
	bpl CODE_C44B63
	ldy.w $10DC
CODE_C44B1B:						; from CODE_C44B1B
	sty.b d1
	cpy.w #$000F
	beq CODE_C44B3F
	lda.w $10E1,y
	and.w #$00FF
	tay
	lda.w Ylist,y
	sec
	sbc.w pucky
	sec
	sbc.w #$0028
	bpl CODE_C44B3F
	jsl.l CODE_C44B64
	ldy.b d1
	iny
	bra CODE_C44B1B
CODE_C44B3F:						; from CODE_C44B1B
	ldy.w $10DC
	beq CODE_C44B63
CODE_C44B44:						; from CODE_C44B44
	sty.b d1
	lda.w $10DF,y
	and.w #$00FF
	tay
	lda.w pucky
	sec
	sbc.w Ylist,y
	sec
	sbc.w #$0028
	bpl CODE_C44B63
	jsl.l CODE_C44B64
	ldy.b d1
	dey
	bne CODE_C44B44
CODE_C44B63:						; from checkpuckcoll, CODE_C44B3F, CODE_C44B44
	rtl
CODE_C44B64:						; from CODE_C44B1B, CODE_C44B44 and other segments
	sty.b a2
	cpy.w puckc
	beq CODE_C44B7D
	cpy.w #$0018
	bcs CODE_C44B7D
	lda.w position,y
	bmi CODE_C44B7D
	lda.w pfnc,y
	ora.w nopuck,y
	beq CODE_C44B84
CODE_C44B7D:						; from CODE_C44B64
	rtl
CODE_C44B7E:						; from CODE_C44B84
	jmp.w CODE_C44C2E
CODE_C44B81:						; from CODE_C44B84
	jmp.w CODE_C44D3D
CODE_C44B84:						; from CODE_C44B64
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
	pei ($97)
	pei ($99)
	lda.w pflags,y
	bit.w #$1000
	bne CODE_C44B7E
	lda.w position,y
	beq CODE_C44B81
	lda.w puckz
	cmp.w #$0005
	bpl CODE_C44B7E
	lda.w puckvz
	cmp.w #$0100
	bpl CODE_C44B7E
	tya
	jsl.l CODE_C37FE2
	ldy.b a2
	lda.b d0
	clc
	adc.w Xpos,y
	sec
	sbc.w $0830
	bit.w #$8000
	beq CODE_C44BD7
	eor.w #$FFFF
	inc a
CODE_C44BD7:						; from CODE_C44B84
	cmp.w #$000F
	bcs CODE_C44C2E
	sta.b d0
	lda.b d1
	clc
	adc.w Ypos,y
	sec
	sbc.w pucky
	bit.w #$8000
	beq CODE_C44BF1
	eor.w #$FFFF
	inc a
CODE_C44BF1:						; from CODE_C44BD7
	cmp.w #$000F
	bcs CODE_C44C2E
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3884A,x
	sta.b d1
	lda.b d0
	and.w #$00FF
	asl a
	tax
	lda.b d1
	adc.l DATA8_C3884A,x
	sta.b d0
	ldx.b curobj
	lda.w #$00C4
	sta.b d1
	lda.w $0CFC
	bmi CODE_C44C22
	beq CODE_C44C22
	lsr.b d1
	lsr.b d1
CODE_C44C22:						; from CODE_C44BF1
	lda.b d1
	cmp.b d0
	bcc CODE_C44C2E
	jsl.l puckstick
	bra CODE_C44C86
CODE_C44C2E:						; from CODE_C44BD7, CODE_C44BF1, CODE_C44C22, CODE_C44B7E
	lda.w position,y
	bne CODE_C44C36
	jmp.w CODE_C44CB1
CODE_C44C36:						; from CODE_C44C2E
	lda.w Xpos,y
	sec
	sbc.w $0830
	bit.w #$8000
	beq CODE_C44C46
	eor.w #$FFFF
	inc a
CODE_C44C46:						; from CODE_C44C36
	cmp.w #$000D
	bcs CODE_C44C86
	sta.b d0
	lda.w Ypos,y
	sec
	sbc.w pucky
	bit.w #$8000
	beq CODE_C44C5D
	eor.w #$FFFF
	inc a
CODE_C44C5D:						; from CODE_C44C46
	cmp.w #$000D
	bcs CODE_C44C86
	and.w #$00FF
	asl a
	sta.b d1
	lda.b d0
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3884A,x
	ldx.b d1
	adc.l DATA8_C3884A,x
	sta.b d0
	ldx.b a3
	cmp.w #$0091
	bcs CODE_C44C86
	jsl.l puckbody
CODE_C44C86:						; from CODE_C44C22, CODE_C44C46, CODE_C44C5D, CODE_C44CB1
	pla
	sta.b $99
	pla
	sta.b d6
	pla
	sta.b $95
	pla
	sta.b d5
	pla
	sta.b $91
	pla
	sta.b d4
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
	rtl
CODE_C44CB1:						; from CODE_C44C2E, CODE_C44DC4, CODE_C44E07
	lda.w Xpos,y
	sec
	sbc.w $0830
	sta.b d0
	cmp.w #$FFF5
	bmi CODE_C44C86
	cmp.w #$000B
	bpl CODE_C44C86
	lda.w Ypos,y
	sec
	sbc.w pucky
	sta.b d1
	cmp.w #$FFF5
	bmi CODE_C44C86
	cmp.w #$000B
	bpl CODE_C44C86
	jsl.l puckgoalie
	bra CODE_C44C86
DATA8_C44CDD:						; not traced: a table read by CODE_C44D4D, CODE_C44D62
	db $00,$00,$01,$00,$01,$00,$02,$00,$03,$00,$03,$00,$04,$00,$05,$00
	db $05,$00,$06,$00,$07,$00,$07,$00,$08,$00,$09,$00,$09,$00,$0A,$00
	db $0B,$00,$0B,$00,$0C,$00,$0D,$00,$0D,$00,$0E,$00,$0F,$00,$0F,$00
	db $10,$00,$11,$00,$11,$00,$12,$00,$13,$00,$13,$00,$14,$00,$15,$00
	db $15,$00,$16,$00,$17,$00,$17,$00,$18,$00,$19,$00,$19,$00,$1A,$00
	db $1B,$00,$1B,$00,$1C,$00,$1D,$00,$1D,$00,$1E,$00,$1F,$00,$1F,$00
CODE_C44D3D:						; from CODE_C44B81
	tya
	jsl.l CODE_C37FE2
	lda.b d0
	bit.w #$8000
	beq CODE_C44D4D
	eor.w #$FFFF
	inc a
CODE_C44D4D:						; from CODE_C44D3D
	sta.b d2
	asl a
	tax
	lda.l DATA8_C44CDD,x
	sta.b d4
	lda.b d1
	bit.w #$8000
	beq CODE_C44D62
	eor.w #$FFFF
	inc a
CODE_C44D62:						; from CODE_C44D4D
	asl a
	tax
	lda.l DATA8_C44CDD,x
	sta.b d3
	ldx.b curobj
	lda.b a2
	jsl.l CODE_C37FE2
	ldy.b a2
	lda.b d0
	clc
	adc.w Xpos,y
	sec
	sbc.w $0830
	bit.w #$8000
	beq CODE_C44D87
	eor.w #$FFFF
	inc a
CODE_C44D87:						; from CODE_C44D62
	cmp.b d2
	bcs CODE_C44DC4
	sta.b d0
	lda.b d1
	clc
	adc.w Ypos,y
	sec
	sbc.w pucky
	bit.w #$8000
	beq CODE_C44DA0
	eor.w #$FFFF
	inc a
CODE_C44DA0:						; from CODE_C44D87
	cmp.b d2
	bcs CODE_C44DC4
	sta.b d1
	lda.b d3
	clc
	adc.b d4
	cmp.w #$0005
	bpl CODE_C44DB3
	lda.w #$0005
CODE_C44DB3:						; from CODE_C44DA0
	cmp.w puckz
	bcc CODE_C44DC4
	lda.b d3
	sec
	sbc.b d4
	bmi CODE_C44DC7
	cmp.w puckz
	bcc CODE_C44DC7
CODE_C44DC4:						; from CODE_C44D87, CODE_C44DA0, CODE_C44DB3
	jmp.w CODE_C44CB1
CODE_C44DC7:						; from CODE_C44DB3
	lda.b d0
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3884A,x
	sta.b d0
	lda.b d1
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3884A,x
	adc.b d0
	sta.b d0
	lda.b d2
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3884A,x
	ldx.b curobj
	sta.b d1
	lda.w $0CFC
	bmi CODE_C44DFD
	beq CODE_C44DFD
	lsr.b d1
	lsr.b d1
CODE_C44DFD:						; from CODE_C44DC7
	lda.b d1
	cmp.b d0
	bcc CODE_C44E07
	jsl.l puckstick
CODE_C44E07:						; from CODE_C44DFD
	jmp.w CODE_C44CB1
CODE_C44E0A:						; called from other segments
	ldy.b a2
	cpy.w puckc
	beq CODE_C44E1B
	jsl.l EndPenaltyShot
	stz.w breakaway
	stz.w onetimer
CODE_C44E1B:						; from CODE_C44E0A
	ldy.b a2
	sty.w puckc
	stz.w puckvz
	stz.w puckz
	lda.w SPA,y
	cmp.w #$224E
	bcc CODE_C44E39
	cmp.w #$22B3
	bcs CODE_C44E39
	lda.w #$FFFF
	sta.w puckc
CODE_C44E39:						; from CODE_C44E1B
	sty.b d0
	stz.b a0
	lda.w #$0002
	sta.b a1
	lda.w pfteam,y
	bne CODE_C44E4E
	stz.b a1
	lda.w #$0002
	sta.b a0
CODE_C44E4E:						; from CODE_C44E39
	ldy.b a0
	lda.w #$FFFF
	sta.w tmtouch2,y
	sta.w tmtouch3,y
	lda.w tmflags,y
	ora.w #$0004
	sta.w tmflags,y
	lda.w #$0010
	trb.w sflags3
	beq CODE_C44E84
	ldy.b a1
	lda.w $12B3,y
	inc a
	sta.w $12B3,y
	lda.l $7E24CA
	clc
	adc.w #$00C8
	sta.l $7E24CA
	lda.w #$0014
	sta.b crowdhold
CODE_C44E84:						; from CODE_C44E4E
	lda.w gmclock
	bne CODE_C44E99
	lda.b a2
	cmp.w passReceiverPlayerNum
	bne CODE_C44E99
	ldy.b a1
	lda.w $12DB,y
	inc a
	sta.w $12DB,y
CODE_C44E99:						; from CODE_C44E84
	lda.w #$000C
	trb.w sflags
	ldy.b a2
	lda.w position,y
	bne CODE_C44EC0
	jsl.l ChkShotStat
	ldy.b a2
	lda.w #$008C
	sta.w temp5,y
	lda.w SPA,y
	cmp.w #$1552
	bne CODE_C44EC0
	lda.w #$0005
	sta.w temp5,y
CODE_C44EC0:						; from CODE_C44E99
	lda.b a2
	cmp.w passReceiverPlayerNum
	bne CODE_C44ED6
	ldy.b a1
	lda.w $05C8,y
	sta.b d4
	bmi CODE_C44ED6
	jsl.l CODE_C5376A
	bra CODE_C44EDA
CODE_C44ED6:						; from CODE_C44EC0
	jsl.l PuckCarrierPad
CODE_C44EDA:						; from CODE_C44EC0
	lda.w #$FFFF
	sta.w passReceiverPlayerNum
	rtl
CODE_C44EE1:						; from CODE_C45141, CODE_C449FE and other segments
	phx
	phy
	sec
	lda.w Xvel,x
	sbc.w Xvel,y
	pha
	sec
	lda.w Yvel,x
	sbc.w Yvel,y
	tay
	pla
	jsl.l ApproxLength
	xba
	and.w #$00F0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	lsr a
	tsb.b tmp0
	lda.w #$0014
	jsl.l CODE_C58CCD
	sec
	sbc.w #$000A
	xba
	ora.b tmp0
	tay
	ldx.w #$0008
	lda.w #$0004
	jsl.l CODE_CF00E3
	ply
	plx
	rtl

; Segment bankC4_4000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C43FC8
CODE_C43FC8:						; called from other segments
	stz.w $07A2
	lda.w $1080,x
	bne CODE_C4402C
	pei ($8B)
	pei ($87)
	lda.w $0814,x
	sta.b $87
	lda.w $0896,x
	sta.b $8B
	lda.w $0BA0,x
	sta.w $07FA
	lda.w $0BC0,x
	sta.w $07FC
	jsl.l checkwallcoll
	lda.w $0BE0,x
	ora.w $0C00,x
	bne CODE_C4401D
	cpx.w #$0018
	bcs CODE_C4401D
	txa
	jsl.l CODE_C37FE2
	lda.w $0814,x
	clc
	adc.b $7F
	sta.b $87
	lda.w $0896,x
	clc
	adc.b $83
	sta.b $8B
	lda.w #$0001
	sta.w $07FA
	sta.w $07FC
	jsl.l checkwallcoll
CODE_C4401D:						; from CODE_C43FC8
	pla
	sta.b $87
	pla
	sta.b $8B
	lda.w $0A20,x
	bmi CODE_C4402C
	jsl.l CODE_C44817
CODE_C4402C:						; from CODE_C43FC8, CODE_C4401D
	lda.w $07A2
	beq CODE_C44034
	jmp.w CODE_C440AD
CODE_C44034:						; from CODE_C4402C
	lda.w $10C0,x
	sta.b $83
CODE_C44039:						; from CODE_C44039
	ldy.b $83
	cpy.w #$000F
	beq CODE_C44070
	lda.w $10E1,y
	and.w #$00FF
	sta.b $8F
	tay
	lda.b $8B
	sec
	sbc.w $10A0,y
	beq CODE_C44070
	bmi CODE_C44070
	inc.w $10C0,x
	lda.w $10C0,y
	dec a
	sta.w $10C0,y
	sep #$30
	ldy.b $83
	lda.b $8F
	sta.w $10E0,y
	txa
	sta.w $10E1,y
	rep #$30
	inc.b $83
	bra CODE_C44039
CODE_C44070:						; from CODE_C44039
	lda.w $10C0,x
	beq CODE_C440A7
	sta.b $83
CODE_C44077:						; from CODE_C44077
	ldy.b $83
	lda.w $10DF,y
	and.w #$00FF
	sta.b $8F
	tay
	lda.b $8B
	sec
	sbc.w $10A0,y
	bpl CODE_C440A7
	dec.w $10C0,x
	lda.w $10C0,y
	inc a
	sta.w $10C0,y
	sep #$30
	ldy.b $83
	lda.b $8F
	sta.w $10E0,y
	txa
	sta.w $10DF,y
	rep #$30
	dec.b $83
	bne CODE_C44077
CODE_C440A7:						; from CODE_C44070, CODE_C44077
	lda.b $8B
	sta.w $10A0,x
	rtl
CODE_C440AD:						; from CODE_C4402C
	lda.w $0C80,x
	cmp.w #$28F6
	bcs CODE_C440C1
	lda.w $0920,x
	sta.w $0814,x
	lda.w $0960,x
	sta.w $0896,x
CODE_C440C1:						; from CODE_C440AD
	rtl
checkwallcoll:						; from CODE_C43FC8 and other segments
	lda.w #$013E
	sec
	sbc.w $07FC
	pha
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0052
	sta.b $93
	lda.w #$009B
	sec
	sbc.w $07FA
	pha
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0052
	sta.b $8F
	lda.b $8B
	pha
	ldy.b $87
	phy
	dec a
	cmp.b $93
	bpl CODE_C4410F
	lda.b $87
	cmp.b $8F
	bmi CODE_C44139
	lda.w #$0000
	sec
	sbc.b $8F
	sta.b $8F
	cmp.b $87
	bmi CODE_C44139
	lda.w #$001A
	sta.b $6B
	jsl.l checkgoal
	jmp.w CODE_C441BE
CODE_C4410F:						; from checkwallcoll
	lda.w #$0000
	sec
	sbc.b $93
	sta.b $93
	cmp.b $8B
	bpl CODE_C44136
	lda.b $87
	cmp.b $8F
	bmi CODE_C44139
	lda.w #$0000
	sec
	sbc.b $8F
	sta.b $8F
	cmp.b $87
	bmi CODE_C44139
	lda.w #$0018
	sta.b $6B
	jsl.l checkgoal
CODE_C44136:						; from CODE_C4410F
	jmp.w CODE_C441BE
CODE_C44139:						; from checkwallcoll, CODE_C4410F
	lda.b $87
	sec
	sbc.b $8F
	sta.b $87
	eor.w #$FFFF
	inc a
	sta.b $83
	bit.w #$8000
	beq CODE_C4414F
CODE_C4414B:						; called from other segments
	eor.w #$FFFF
	inc a
CODE_C4414F:						; from CODE_C44139
	sta.b $A7
	lda.b $8B
	sec
	sbc.b $93
	sta.b $7F
	bit.w #$8000
	beq CODE_C44161
	eor.w #$FFFF
	inc a
CODE_C44161:						; from CODE_C4414F
	sta.b $B1
	cmp.b $A7
	bcc CODE_C4416F
	lda.b $A7
	lsr a
	lsr a
	adc.b $B1
	bra CODE_C44173
CODE_C4416F:						; from CODE_C44161
	lsr a
	lsr a
	adc.b $A7
CODE_C44173:						; from CODE_C44161
	cmp.w #$0053
	bcc CODE_C441BE
	sta.b $8B
	lda.b $7F
	xba
	and.w #$FF00
	tax
	lda.b $8B
	jsl.l DivX8S
	cmp.w #$FF01
	bpl CODE_C4418F
	lda.w #$FF01
CODE_C4418F:						; from CODE_C44173
	cmp.w #$00FF
	bmi CODE_C44197
	lda.w #$00FF
CODE_C44197:						; from CODE_C4418F
	sta.b $7F
	lda.b $83
	xba
	and.w #$FF00
	tax
	lda.b $8B
	jsl.l DivX8S
	ldx.b $6F
	cmp.w #$FF01
	bpl CODE_C441B0
	lda.w #$FF01
CODE_C441B0:						; from CODE_C44197
	cmp.w #$00FF
	bmi CODE_C441B8
	lda.w #$00FF
CODE_C441B8:						; from CODE_C441B0
	sta.b $83
	jsl.l wallcollb
CODE_C441BE:						; from checkwallcoll, CODE_C44136, CODE_C44173
	pla
	sta.b $87
	pla
	sta.b $8B
	pla
	sta.b $8F
	pla
	sta.b $93
	lda.w $0BE0,x
	ora.w $0C00,x
	bne CODE_C4420E
	stz.b $83
	lda.w #$00FF
	sta.b $7F
	lda.b $8B
	dec a
	cmp.b $93
	bpl wallcollb
	lda.w #$FF01
	sta.b $7F
	lda.w #$0000
	sec
	sbc.b $93
	dec a
	cmp.b $8B
	bpl wallcollb
	stz.b $7F
	lda.w #$FF01
	sta.b $83
	lda.b $87
	dec a
	cmp.b $8F
	bpl wallcollb
	lda.w #$00FF
	sta.b $83
	lda.w #$0000
	sec
	sbc.b $8F
	dec a
	cmp.b $87
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
	lda.w $08D8
	cmp.w #$0021
	bpl CODE_C44212
	lda.w $08D8
	cmp.w #$0016
	bcc CODE_C4420F
	lda.w $08B2
	cmp.w #$012F
	bmi CODE_C44212
	lda.w $0830
	cmp.w #$000D
	bmi CODE_C4420F
	lda.w $0830
	cmp.w #$0010
	bpl CODE_C4420F
	lda.w $09DC
	cmp.w #$0FA0
	bmi CODE_C4420F
	phx
	lda.w $09DC
	pha
	asl a
	pla
	ror a
	sta.w $09DC
	inx
	inx
	stx.b $6F
	plx
	stx.b $6F
	lda.l $7E24CA
	clc
	adc.w #$0258
	sta.l $7E24CA
	lda.w #$005A
	sta.b $5B
	lda.w $14E3
	clc
	adc.w #$000F
	bmi wallcollb_out
	sta.w $14E3
wallcollb_out:						; from wallcollb, CODE_C44212
	lda.w #$0040
	tsb.w $10F5
	sta.w $109C
	lda.w $08B2
	bpl CODE_C4428D
	lda.w #$8000
	tsb.w $08FC
CODE_C4428D:						; from wallcollb_out
	stz.w $0874
	lda.w $10F3
	bne CODE_C442AA
	lda.w $2002
	asl a
	sta.b $6F
	tax
	lda.w #$0006
	sta.b $7F
	jsl.l ShootoutWonBy
	ldx.w #$001C
	stx.b $6F
CODE_C442AA:						; from CODE_C4428D
	jsl.l EndPenaltyShot
	stz.w $18AE
	stz.w $18AC
	rtl
wallcoll:							; from CODE_C4420F, CODE_C44766, CODE_C4468C, ...
	lda.b $7F
	sta.w $0BE0,x
	lda.b $83
	sta.w $0C00,x
	pei ($87)
	pei ($8B)
	pei ($83)
	lda.b $7F
	pha
	txy
	ldx.w $09C0,y
	jsl.l Mul16x8S
	lda.b $35
	sta.b $7F
	ldx.w $09A0,y
	lda.b $83
	jsl.l Mul16x8S
	lda.b $7F
	sec
	sbc.b $35
	eor.w #$FFFF
	inc a
	sta.b $87
	ldx.w $09A0,y
	lda.b $01,s
	jsl.l Mul16x8S
	lda.b $35
	sta.b $7F
	ldx.w $09C0,y
	lda.b $83
	jsl.l Mul16x8S
	lda.b $35
	clc
	adc.b $7F
	sta.b $8B
	tyx
	cpx.w #$001C
	beq CODE_C4430E
	jmp.w CODE_C443A1
CODE_C4430E:						; from wallcoll
	lda.w #$1000
	trb.w $10F5
	lda.b $87
	bmi CODE_C4431B
	jmp.w CODE_C44428
CODE_C4431B:						; from CODE_C4430E
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C44325
	ora.w #$C000
CODE_C44325:						; from CODE_C4431B
	sta.b $87
	sec
	sbc.w #$FC00
	bpl CODE_C4437A
	jsl.l RandomWord
	and.w #$07FF
	eor.w #$FFFF
	inc a
	sta.w $08DE
	sta.b $7F
	jsl.l puckflip
	lda.w $09BC
	ldy.w $09DC
	jsl.l ApproxLength
	and.w #$7F00
	sta.b $9F
	xba
	tsb.b $9F
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
	sta.b $9F
CODE_C44366:						; from CODE_C44325
	rep #$20
	lda.w #$0003
	ldy.w $08D8
	cpy.w #$000B
	bcs CODE_C44376
	lda.w #$0003
CODE_C44376:						; from CODE_C44366
	jsl.l CODE_CF0418
CODE_C4437A:						; from CODE_C44325
	lda.b $8B
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
	sta.b $7F
	pha
	asl a
	pla
	ror a
	sta.b $81
	lda.b $8B
	sec
	sbc.b $7F
	sec
	sbc.b $81
	sta.b $8B
	bra CODE_C443E4
CODE_C4439E:						; from CODE_C443A1
	jmp.w CODE_C44428
CODE_C443A1:						; from wallcoll
	lda.b $87
	sec
	sbc.w #$03E8
	bpl CODE_C4439E
	lda.b $87
	sec
	sbc.w #$F000
	bpl CODE_C443CB
	lda.w $0A00,x
	sec
	sbc.w #$000A
	bmi CODE_C443CB
	lda.w $09A0,x
	sta.b $38
	lda.w $09C0,x
	sta.b $3A
	lda.w #$0003
	jsl.l CODE_CF040B
CODE_C443CB:						; from CODE_C443A1
	lda.b $87
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C443D7
	ora.w #$C000
CODE_C443D7:						; from CODE_C443CB
	sta.b $87
	sec
	sbc.w #$FC7C
	bmi CODE_C443E4
	lda.w #$FC18
	sta.b $87
CODE_C443E4:						; from CODE_C443D7, CODE_C4438A
	lda.b $01,s
	ldx.b $8B
	jsl.l Mul16x8S
	lda.b $35
	sta.b $9F
	lda.b $03,s
	ldx.b $87
	jsl.l Mul16x8S
	lda.b $9F
	sec
	sbc.b $35
	ldx.b $6F
	sta.w $09A0,x
	lda.b $03,s
	ldx.b $8B
	jsl.l Mul16x8S
	lda.b $35
	sta.b $8B
	lda.b $01,s
	ldx.b $87
	jsl.l Mul16x8S
	lda.b $35
	clc
	adc.b $8B
	ldx.b $6F
	sta.w $09C0,x
	lda.w $08DE
	bmi CODE_C44428
	stz.w $08DE
CODE_C44428:						; from CODE_C4430E, CODE_C443E4, CODE_C4439E
	pla
	pla
	pla
	sta.b $8B
	pla
	sta.b $87
	cpx.w #$001C
	bne CODE_C44444
	lda.w $05A0
	bpl CODE_C44444
	jsl.l EndPenaltyShot
	stz.w $18AE
	stz.w $18AC
CODE_C44444:						; from CODE_C44428
	rtl
checkgoal:							; from checkwallcoll, CODE_C4410F and other segments
	cpx.w #$001C
	beq CODE_C4444D
	jmp.w checkgoalp
CODE_C4444D:						; from checkgoal
	ldy.w $05A0
	bmi CODE_C44457
	lda.w $0A20,y
	beq CODE_C444AD
CODE_C44457:						; from CODE_C4444D
	lda.w $08D8
	cmp.w #$000D
	bpl CODE_C444AD
	ldy.b $6B
	lda.b $87
	sec
	sbc.w $0814,y
	sta.b $87
	cmp.w #$0017
	bpl CODE_C444AD
	lda.b $87
	cmp.w #$FFEA
	bmi CODE_C444AD
	lda.w #$0009
	sta.b $93
	lda.b $8B
	sec
	sbc.w $0896,y
	sta.b $8B
	cmp.w #$000A
	bpl CODE_C444AD
	lda.w #$0000
	sec
	sbc.b $93
	sta.b $93
	lda.b $8B
	cmp.w #$FFF7
	bmi CODE_C444AD
	lda.w #$FFFF
	sta.w $07A2
	lda.w $08DC
	cmp.w #$000D
	bmi CODE_C444AE
	lda.w $08DC
	sta.w $08D8
	jmp.w CODE_C44645
CODE_C444AD:						; from CODE_C4444D, CODE_C44457
	rtl
CODE_C444AE:						; from CODE_C44457
	stz.w $0FFC
	lda.w $05A0
	bmi CODE_C444DF
	tay
	lda.w #$FFFF
	sta.w $05A0
	lda.w #$0008
	sta.w $0CE0,y
	lda.w $08B2
	sta.b $83
	lda.w $0FE0,y
	bne CODE_C444D5
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
CODE_C444D5:						; from CODE_C444AE
	lda.b $83
	bpl CODE_C444DF
	lda.w #$0001
	sta.w $0FFC
CODE_C444DF:						; from CODE_C444AE, CODE_C444D5
	lda.w #$FF01
	sta.b $7F
	lda.w #$FF01
	sta.b $38
	lda.w $08B8,x
	sec
	sbc.w $0980,x
	sta.b $83
	lda.w $0896,x
	sbc.w $0960,x
	sta.b $85
	lda.b $84
	sta.b $83
	cmp.w #$0000
	beq CODE_C44580
	bmi CODE_C4451D
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	lda.w #$0000
	sec
	sbc.b $38
	sta.b $38
	lda.w #$0000
	sec
	sbc.b $93
	sta.b $93
CODE_C4451D:						; from CODE_C444DF
	lda.b $93
	clc
	adc.b $8B
	sta.b $93
	sta.b $34
	lda.w $0836,x
	sec
	sbc.w $0940,x
	sta.b $8B
	lda.w $0814,x
	sbc.w $0920,x
	sta.b $8D
	lda.b $8C
	sta.b $8B
	ldx.b $34
	jsl.l Mul16S
	ldx.b $6F
	lda.b $83
	bit.w #$8000
	beq CODE_C4454E
	eor.w #$FFFF
	inc a
CODE_C4454E:						; from CODE_C4451D
	sta.b $30
	lda.b $36
	bit.w #$8000
	beq CODE_C4455B
	eor.w #$FFFF
	inc a
CODE_C4455B:						; from CODE_C4454E
	cmp.b $30
	bcs CODE_C44580
	lda.b $83
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	sta.b $93
	ldx.b $6F
	lda.b $87
	sec
	sbc.b $93
	sta.b $87
	cmp.w #$FFEA
	bmi CODE_C44580
	lda.b $87
	cmp.w #$0017
	bmi CODE_C445A9
CODE_C44580:						; from CODE_C444DF, CODE_C4455B
	jmp.w CODE_C44655
CODE_C44583:						; from CODE_C445A9
	lda.w $09DC
	cmp.w #$0800
	bpl CODE_C445A3
	cmp.w #$F800
	bmi CODE_C445A3
	cmp.w #$0000
	bpl CODE_C4459D
	lda.w #$F800
	sta.w $09DC
	bra CODE_C445A3
CODE_C4459D:						; from CODE_C44583
	lda.w #$0800
	sta.w $09DC
CODE_C445A3:						; from CODE_C44583
	jmp.w wallcoll
CODE_C445A6:						; from CODE_C445A9
	jmp.w CODE_C4AA65
CODE_C445A9:						; from CODE_C4455B
	stz.b $83
	lda.w $08B2
	eor.b $38
	bmi CODE_C44583
	lda.w #$0000
	sec
	sbc.b $38
	sta.b $38
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	lda.w $0FFC
	bne CODE_C44583
	lda.w $08D8
	cmp.w #$000D
	beq CODE_C445DD
	lda.b $87
	cmp.w #$0012
	bpl CODE_C445DD
	lda.b $87
	cmp.w #$FFEF
	bpl CODE_C445A6
CODE_C445DD:						; from CODE_C445A9
	jsl.l ChkShotStat
	stz.w $18AE
	stz.w $18AC
	lda.w #$000C
	jsl.l CODE_CF040B
	lda.l $7E24CA
	clc
	adc.w #$012C
	sta.l $7E24CA
	lda.w #$003C
	sta.b $5B
	lda.w $14E3
	clc
	adc.w #$0028
	bmi CODE_C4460B
	sta.w $14E3
CODE_C4460B:						; from CODE_C445DD
	jsl.l RandomWord
	and.w #$0FFF
	sta.b $7F
	lda.w $08B2
	bmi CODE_C44621
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C44621:						; from CODE_C4460B
	lda.b $7F
	sta.w $09DC
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w $09BC
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w $08DE
	jmp.w puckflip
CODE_C44645:						; from CODE_C44457
	lda.w $08DE
	bit.w #$8000
	beq CODE_C44651
	eor.w #$FFFF
	inc a
CODE_C44651:						; from CODE_C44645
	sta.w $08DE
	rtl
CODE_C44655:						; from CODE_C44580
	lda.w $09BC
	cmp.w #$0800
	bpl CODE_C44675
	cmp.w #$F800
	bmi CODE_C44675
	cmp.w #$0000
	bpl CODE_C4466F
	lda.w #$F800
	sta.w $09BC
	bra CODE_C44675
CODE_C4466F:						; from CODE_C44655
	lda.w #$0800
	sta.w $09BC
CODE_C44675:						; from CODE_C44655
	stz.b $7F
	lda.w #$00FF
	sta.b $83
	lda.w $0830
	sec
	sbc.w $093C
	sta.b $87
	bmi CODE_C4468C
	lda.w #$FF01
	sta.b $83
CODE_C4468C:						; from CODE_C44675
	jmp.w wallcoll
checkgoalp:							; from checkgoal
	lda.w $0D60,x
	bit.w #$8000
	bne CODE_C4469C
	cpx.w #$0017
	bcc CODE_C4469D
CODE_C4469C:						; from checkgoalp, CODE_C4469D, CODE_C446B1, CODE_C446C7
	rtl
CODE_C4469D:						; from checkgoalp
	ldy.b $6B
	cpy.w #$0018
	beq CODE_C446B1
	lda.b $8B
	sec
	sbc.w $07FC
	cmp.w #$FF10
	bpl CODE_C4469C
	bra CODE_C446BC
CODE_C446B1:						; from CODE_C4469D
	lda.b $8B
	clc
	adc.w $07FC
	cmp.w #$00F0
	bmi CODE_C4469C
CODE_C446BC:						; from CODE_C4469D
	lda.b $87
	bit.w #$8000
	beq CODE_C446C7
	eor.w #$FFFF
	inc a
CODE_C446C7:						; from CODE_C446BC
	sec
	sbc.w $07FA
	cmp.w #$0040
	bpl CODE_C4469C
	lda.b $8B
	pha
	sec
	sbc.w $0896,y
	sta.b $8B
	eor.w #$FFFF
	inc a
	sta.b $7F
	lda.b $87
	pha
	sec
	sbc.w $0814,y
	sta.b $83
	sta.b $30
	tax
	jsl.l Mul8S
	sta.b $34
	ldx.b $6F
	lsr a
	lsr a
	cmp.w #$0101
	bcs CODE_C44710
	sta.b $87
	lda.b $8B
	sta.b $32
	tax
	jsl.l Mul8S
	asl a
	sta.b $36
	ldx.b $6F
	clc
	adc.b $87
	cmp.w #$0101
CODE_C44710:						; from CODE_C446C7
	bcs CODE_C4476E
	pla
	sta.b $87
	pla
	sta.b $8B
	jsr.w CODE_C44775
	pei ($8B)
	pei ($87)
	lda.b $30
	ldy.b $32
	jsl.l ApproxLength
	inc a
	sta.b $87
	lda.b $7F
	xba
	and.w #$FF00
	tax
	lda.b $87
	jsl.l DivX8S
	cmp.w #$00FF
	bmi CODE_C4473F
	lda.w #$00FF
CODE_C4473F:						; from CODE_C44710
	cmp.w #$FF01
	bpl CODE_C44747
	lda.w #$FF01
CODE_C44747:						; from CODE_C4473F
	sta.b $7F
	lda.b $83
	xba
	and.w #$FF00
	tax
	lda.b $87
	jsl.l DivX8S
	cmp.w #$00FF
	bmi CODE_C4475E
	lda.w #$00FF
CODE_C4475E:						; from CODE_C44747
	cmp.w #$FF01
	bpl CODE_C44766
	lda.w #$FF01
CODE_C44766:						; from CODE_C4475E
	sta.b $83
	ldx.b $6F
	jsl.l wallcoll
CODE_C4476E:						; from CODE_C44710
	pla
	sta.b $87
	pla
	sta.b $8B
	rtl
CODE_C44775:						; from CODE_C44710
	pei ($7F)
	pei ($83)
	lda.w $04B0
	and.w #$01C0
	bne CODE_C447BC
	lda.w $0C80,x
	cmp.w #$21BC
	bne CODE_C447BC
	ldy.b $6B
	lda.w $08B2
	sec
	sbc.w $0896,y
	cmp.w #$FF80
	bmi CODE_C447BC
	cmp.w #$0080
	bpl CODE_C447BC
	lda.w $09A0,x
	sta.b $7F
	lda.w $09C0,x
	sta.b $83
	cmp.w #$DFFF
	bmi CODE_C447C3
	cmp.w #$2001
	bpl CODE_C447C3
	lda.b $7F
	cmp.w #$DFFF
	bmi CODE_C447C3
	cmp.w #$2001
	bpl CODE_C447C3
CODE_C447BC:						; from CODE_C44775
	pla
	sta.b $83
	pla
	sta.b $7F
CODE_C447C2:						; from CODE_C447EF
	rts
CODE_C447C3:						; from CODE_C44775
	pla
	pla
	lda.b $7F
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq CODE_C447D2
	ora.w #$E000
CODE_C447D2:						; from CODE_C447C3
	sta.b $7F
	cmp.w #$8000
	ror a
	clc
	adc.b $7F
	sta.b $7F
	ldy.b $6B
	sta.w $09A0,y
	lda.b $83
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq CODE_C447EF
	ora.w #$E000
CODE_C447EF:						; from CODE_C447D2
	sta.b $83
	cmp.w #$8000
	ror a
	clc
	adc.b $83
	sta.b $83
	sta.w $09C0,y
	stz.w $09A0,x
	stz.w $09C0,x
	lda.w #$0040
	tsb.w $10F5
	lda.w $10F3
	bne CODE_C447C2
	pla
	lda.w #$0008
	sta.b $7F
	jmp.w AddPenalty2
CODE_C44817:						; from CODE_C4401D and other segments
	lda.w $0D60,x
	bit.w #$8000
	bne CODE_C44824
	cpx.w #$0018
	bcc CODE_C44825
CODE_C44824:						; from CODE_C44817
	rtl
CODE_C44825:						; from CODE_C44817
	lda.w $10C0,x
	sta.b $83
CODE_C4482A:						; from CODE_C4486D
	ldy.b $83
	cpy.w #$000F
	beq CODE_C44871
	lda.w $10E1,y
	and.w #$00FF
	tay
	lda.w $10A0,y
	sec
	sbc.b $8B
	sec
	sbc.w #$000E
	bpl CODE_C44871
	lda.w $0A20,y
	bmi CODE_C4486D
	lda.w $0814,y
	sec
	sbc.b $87
	cmp.w #$FFF1
	bmi CODE_C4486D
	cmp.w #$000F
	bpl CODE_C4486D
	lda.w $0D60,y
	and.w #$8000
	ora.w $1080,y
	bne CODE_C4486D
	cpy.w #$0018
	bcs CODE_C4486D
	jsl.l CODE_C448BB
CODE_C4486D:						; from CODE_C4482A
	inc.b $83
	bra CODE_C4482A
CODE_C44871:						; from CODE_C4482A
	lda.w $10C0,x
	beq CODE_C448BA
	sta.b $83
CODE_C44878:						; from CODE_C448B6
	ldy.b $83
	lda.w $10DF,y
	and.w #$00FF
	tay
	lda.b $8B
	sec
	sbc.w $10A0,y
	sec
	sbc.w #$000E
	bpl CODE_C448BA
	lda.w $0A20,y
	bmi CODE_C448B6
	lda.w $0814,y
	sec
	sbc.b $87
	cmp.w #$FFF1
	bmi CODE_C448B6
	cmp.w #$000F
	bpl CODE_C448B6
	lda.w $0D60,y
	and.w #$8000
	ora.w $1080,y
	bne CODE_C448B6
	cpy.w #$0018
	bcs CODE_C448B6
	jsl.l CODE_C448BB
CODE_C448B6:						; from CODE_C44878
	dec.b $83
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
	sty.b $6B
	lda.w $0814,y
	sec
	sbc.w $0814,x
	sta.b $87
	lda.w $0896,y
	sec
	sbc.w $0896,x
	sta.b $8B
	ldy.b $87
	jsl.l ApproxLength
	cmp.w #$0010
	bmi CODE_C448EB
	jmp.w CODE_C44AF5
CODE_C448EB:						; from CODE_C448BB
	ldy.b $6B
	lda.w $09A0,x
	sec
	sbc.w $09A0,y
	sta.b $7F
	lda.w $09C0,x
	sec
	sbc.w $09C0,y
	sta.b $83
	lda.b $7F
	ora.b $83
	bne CODE_C44908
	jmp.w CODE_C44AF5
CODE_C44908:						; from CODE_C448EB
	pei ($83)
	pei ($7F)
	lda.b $8B
	ldx.b $83
	jsl.l Mul16x8S
	lda.b $36
	sta.b $85
	lda.b $34
	sta.b $83
	lda.b $87
	ldx.b $7F
	jsl.l Mul16x8S
	ldx.b $6F
	lda.b $34
	clc
	adc.b $83
	sta.b $83
	lda.b $36
	adc.b $85
	sta.b $85
	bpl CODE_C44938
	jmp.w CODE_C44B0B
CODE_C44938:						; from CODE_C44908
	lda.w $0C80,x
	cmp.w #$2280
	bcc CODE_C44966
	cmp.w #$2345
	bcs CODE_C44966
	stz.w $1000,x
	stz.w $1060,x
	ldy.w $09E0,x
	lda.w $0C80,y
	cmp.w #$2280
	bcc CODE_C44964
	cmp.w #$2345
	bcs CODE_C44964
	lda.w #$0000
	sta.w $1000,y
	sta.w $1060,y
CODE_C44964:						; from CODE_C44938
	ldy.b $6B
CODE_C44966:						; from CODE_C44938
	lda.w $0C80,y
	cmp.w #$2280
	bcc CODE_C44994
	cmp.w #$2345
	bcs CODE_C44994
	lda.w #$0000
	sta.w $1000,y
	sta.w $1060,y
	ldx.w $09E0,y
	lda.w $0C80,x
	cmp.w #$2280
	bcc CODE_C44992
	cmp.w #$2345
	bcs CODE_C44992
	stz.w $1000,x
	stz.w $1060,x
CODE_C44992:						; from CODE_C44966
	ldx.b $6F
CODE_C44994:						; from CODE_C44966
	lda.b $84
	sta.b $83
	lda.w $1020,x
	cmp.w $1020,y
	beq CODE_C44A19
	lda.b $83
	lsr a
	lsr a
	lsr a
	lsr a
	cmp.w #$0005
	bcs CODE_C449AE
	lda.w #$0005
CODE_C449AE:						; from CODE_C44994
	sta.b $8F
	lda.w $0C80,x
	cmp.w #$2082
	bcc CODE_C449C6
	cmp.w #$21BD
	bcs CODE_C449C6
CODE_C449BD:						; from CODE_C449C6
	lda.b $8F
	lsr a
	adc.b $8F
	sta.b $8F
	bra CODE_C449D3
CODE_C449C6:						; from CODE_C449AE
	lda.w $0C80,y
	cmp.w #$2082
	bcc CODE_C449D3
	cmp.w #$21BD
	bcc CODE_C449BD
CODE_C449D3:						; from CODE_C449BD, CODE_C449C6
	lda.b $8F
	clc
	adc.w $0A00,x
	sta.w $0A00,x
	lda.b $8F
	clc
	adc.w $0A00,y
	sta.w $0A00,y
	txa
	sta.w $09E0,y
	tya
	sta.w $09E0,x
	lda.b $8F
	cmp.w #$0014
	bcc CODE_C44A02
	cpx.w $05A0
	beq CODE_C449FE
	cpy.w $05A0
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
	sta.b $8B
	pla
	sta.b $87
	pla
	sta.b $83
CODE_C44A19:						; from CODE_C44994
	lda.b $83
	sta.b $8F
	pla
	sta.b $7F
	pla
	sta.b $83
	lda.w $07A2
	bpl CODE_C44A2B
	jmp.w CODE_C44AF5
CODE_C44A2B:						; from CODE_C44A19
	lda.b $87
	ldx.b $83
	jsl.l Mul16x8S
	lda.b $36
	sta.b $85
	lda.b $34
	sta.b $83
	lda.b $8B
	ldx.b $7F
	jsl.l Mul16x8S
	lda.b $34
	sec
	sbc.b $83
	sta.b $83
	lda.b $36
	sbc.b $85
	sta.b $85
	lda.b $84
	sta.b $93
	ldx.b $6F
	lda.w $0DE0,x
	clc
	adc.w #$008C
	sta.b $7F
	ldy.b $6B
	lda.w $0DE0,y
	clc
	adc.w #$008C
	sta.b $83
	lda.b $83
	clc
	adc.b $7F
	sta.b $83
	lda.b $7F
	ldx.b $8F
	jsl.l Mul16x8XS
	lda.b $83
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	sta.b $7F
	sta.b $83
	lda.b $8B
	ldx.b $93
	jsl.l Mul16x8S
	lda.b $34
	sta.b $9F
	lda.b $87
	ldx.b $7F
	jsl.l Mul16x8S
	lda.b $34
	clc
	adc.b $9F
	ldx.b $6F
	clc
	adc.w $09A0,y
	sta.w $09A0,x
	lda.b $87
	ldx.b $93
	jsl.l Mul16x8S
	lda.b $34
	sta.b $9F
	lda.b $8B
	ldx.b $7F
	jsl.l Mul16x8S
	lda.b $34
	sec
	sbc.b $9F
	ldx.b $6F
	clc
	adc.w $09C0,y
	sta.w $09C0,x
	lda.b $87
	ldx.b $83
	jsl.l Mul16x8S
	lda.b $34
	clc
	adc.w $09A0,y
	sta.w $09A0,y
	lda.b $8B
	ldx.b $83
	jsl.l Mul16x8S
	lda.b $34
	clc
	adc.w $09C0,y
	sta.w $09C0,y
	ldx.b $6F
	lda.w #$FFFF
	sta.w $07A2
CODE_C44AF5:						; from CODE_C448BB, CODE_C448EB, CODE_C44B0B, CODE_C44A19
	pla
	sta.b $93
	pla
	sta.b $8F
	pla
	sta.b $8B
	pla
	sta.b $87
	pla
	sta.b $85
	pla
	sta.b $83
	pla
	sta.b $7F
	rtl
CODE_C44B0B:						; from CODE_C44908
	pla
	pla
	bra CODE_C44AF5
CODE_C44B0F:						; called from other segments
	lda.w $08D8
	sec
	sbc.w #$0010
	bpl CODE_C44B63
	ldy.w $10DC
CODE_C44B1B:						; from CODE_C44B1B
	sty.b $83
	cpy.w #$000F
	beq CODE_C44B3F
	lda.w $10E1,y
	and.w #$00FF
	tay
	lda.w $10A0,y
	sec
	sbc.w $08B2
	sec
	sbc.w #$0028
	bpl CODE_C44B3F
	jsl.l CODE_C44B64
	ldy.b $83
	iny
	bra CODE_C44B1B
CODE_C44B3F:						; from CODE_C44B1B
	ldy.w $10DC
	beq CODE_C44B63
CODE_C44B44:						; from CODE_C44B44
	sty.b $83
	lda.w $10DF,y
	and.w #$00FF
	tay
	lda.w $08B2
	sec
	sbc.w $10A0,y
	sec
	sbc.w #$0028
	bpl CODE_C44B63
	jsl.l CODE_C44B64
	ldy.b $83
	dey
	bne CODE_C44B44
CODE_C44B63:						; from CODE_C44B0F, CODE_C44B3F, CODE_C44B44
	rtl
CODE_C44B64:						; from CODE_C44B1B, CODE_C44B44 and other segments
	sty.b $6B
	cpy.w $05A0
	beq CODE_C44B7D
	cpy.w #$0018
	bcs CODE_C44B7D
	lda.w $0A20,y
	bmi CODE_C44B7D
	lda.w $1080,y
	ora.w $0CE0,y
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
	lda.w $0D60,y
	bit.w #$1000
	bne CODE_C44B7E
	lda.w $0A20,y
	beq CODE_C44B81
	lda.w $08D8
	cmp.w #$0005
	bpl CODE_C44B7E
	lda.w $08DE
	cmp.w #$0100
	bpl CODE_C44B7E
	tya
	jsl.l CODE_C37FE2
	ldy.b $6B
	lda.b $7F
	clc
	adc.w $0814,y
	sec
	sbc.w $0830
	bit.w #$8000
	beq CODE_C44BD7
	eor.w #$FFFF
	inc a
CODE_C44BD7:						; from CODE_C44B84
	cmp.w #$000F
	bcs CODE_C44C2E
	sta.b $7F
	lda.b $83
	clc
	adc.w $0896,y
	sec
	sbc.w $08B2
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
	sta.b $83
	lda.b $7F
	and.w #$00FF
	asl a
	tax
	lda.b $83
	adc.l DATA8_C3884A,x
	sta.b $7F
	ldx.b $B7
	lda.w #$00C4
	sta.b $83
	lda.w $0CFC
	bmi CODE_C44C22
	beq CODE_C44C22
	lsr.b $83
	lsr.b $83
CODE_C44C22:						; from CODE_C44BF1
	lda.b $83
	cmp.b $7F
	bcc CODE_C44C2E
	jsl.l puckstick
	bra CODE_C44C86
CODE_C44C2E:						; from CODE_C44BD7, CODE_C44BF1, CODE_C44C22, CODE_C44B7E
	lda.w $0A20,y
	bne CODE_C44C36
	jmp.w CODE_C44CB1
CODE_C44C36:						; from CODE_C44C2E
	lda.w $0814,y
	sec
	sbc.w $0830
	bit.w #$8000
	beq CODE_C44C46
	eor.w #$FFFF
	inc a
CODE_C44C46:						; from CODE_C44C36
	cmp.w #$000D
	bcs CODE_C44C86
	sta.b $7F
	lda.w $0896,y
	sec
	sbc.w $08B2
	bit.w #$8000
	beq CODE_C44C5D
	eor.w #$FFFF
	inc a
CODE_C44C5D:						; from CODE_C44C46
	cmp.w #$000D
	bcs CODE_C44C86
	and.w #$00FF
	asl a
	sta.b $83
	lda.b $7F
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3884A,x
	ldx.b $83
	adc.l DATA8_C3884A,x
	sta.b $7F
	ldx.b $6F
	cmp.w #$0091
	bcs CODE_C44C86
	jsl.l CODE_C4A6B1
CODE_C44C86:						; from CODE_C44C22, CODE_C44C46, CODE_C44C5D, CODE_C44CB1
	pla
	sta.b $99
	pla
	sta.b $97
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
	rtl
CODE_C44CB1:						; from CODE_C44C2E, CODE_C44DC4, CODE_C44E07
	lda.w $0814,y
	sec
	sbc.w $0830
	sta.b $7F
	cmp.w #$FFF5
	bmi CODE_C44C86
	cmp.w #$000B
	bpl CODE_C44C86
	lda.w $0896,y
	sec
	sbc.w $08B2
	sta.b $83
	cmp.w #$FFF5
	bmi CODE_C44C86
	cmp.w #$000B
	bpl CODE_C44C86
	jsl.l CODE_C4A782
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
	lda.b $7F
	bit.w #$8000
	beq CODE_C44D4D
	eor.w #$FFFF
	inc a
CODE_C44D4D:						; from CODE_C44D3D
	sta.b $87
	asl a
	tax
	lda.l DATA8_C44CDD,x
	sta.b $8F
	lda.b $83
	bit.w #$8000
	beq CODE_C44D62
	eor.w #$FFFF
	inc a
CODE_C44D62:						; from CODE_C44D4D
	asl a
	tax
	lda.l DATA8_C44CDD,x
	sta.b $8B
	ldx.b $B7
	lda.b $6B
	jsl.l CODE_C37FE2
	ldy.b $6B
	lda.b $7F
	clc
	adc.w $0814,y
	sec
	sbc.w $0830
	bit.w #$8000
	beq CODE_C44D87
	eor.w #$FFFF
	inc a
CODE_C44D87:						; from CODE_C44D62
	cmp.b $87
	bcs CODE_C44DC4
	sta.b $7F
	lda.b $83
	clc
	adc.w $0896,y
	sec
	sbc.w $08B2
	bit.w #$8000
	beq CODE_C44DA0
	eor.w #$FFFF
	inc a
CODE_C44DA0:						; from CODE_C44D87
	cmp.b $87
	bcs CODE_C44DC4
	sta.b $83
	lda.b $8B
	clc
	adc.b $8F
	cmp.w #$0005
	bpl CODE_C44DB3
	lda.w #$0005
CODE_C44DB3:						; from CODE_C44DA0
	cmp.w $08D8
	bcc CODE_C44DC4
	lda.b $8B
	sec
	sbc.b $8F
	bmi CODE_C44DC7
	cmp.w $08D8
	bcc CODE_C44DC7
CODE_C44DC4:						; from CODE_C44D87, CODE_C44DA0, CODE_C44DB3
	jmp.w CODE_C44CB1
CODE_C44DC7:						; from CODE_C44DB3
	lda.b $7F
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3884A,x
	sta.b $7F
	lda.b $83
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3884A,x
	adc.b $7F
	sta.b $7F
	lda.b $87
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3884A,x
	ldx.b $B7
	sta.b $83
	lda.w $0CFC
	bmi CODE_C44DFD
	beq CODE_C44DFD
	lsr.b $83
	lsr.b $83
CODE_C44DFD:						; from CODE_C44DC7
	lda.b $83
	cmp.b $7F
	bcc CODE_C44E07
	jsl.l puckstick
CODE_C44E07:						; from CODE_C44DFD
	jmp.w CODE_C44CB1
CODE_C44E0A:						; called from other segments
	ldy.b $6B
	cpy.w $05A0
	beq CODE_C44E1B
	jsl.l EndPenaltyShot
	stz.w $18AE
	stz.w $18AC
CODE_C44E1B:						; from CODE_C44E0A
	ldy.b $6B
	sty.w $05A0
	stz.w $08DE
	stz.w $08D8
	lda.w $0C80,y
	cmp.w #$224E
	bcc CODE_C44E39
	cmp.w #$22B3
	bcs CODE_C44E39
	lda.w #$FFFF
	sta.w $05A0
CODE_C44E39:						; from CODE_C44E1B
	sty.b $7F
	stz.b $63
	lda.w #$0002
	sta.b $67
	lda.w $1020,y
	bne CODE_C44E4E
	stz.b $67
	lda.w #$0002
	sta.b $63
CODE_C44E4E:						; from CODE_C44E39
	ldy.b $63
	lda.w #$FFFF
	sta.w $12BF,y
	sta.w $12C3,y
	lda.w $12FF,y
	ora.w #$0004
	sta.w $12FF,y
	lda.w #$0010
	trb.w $10F7
	beq CODE_C44E84
	ldy.b $67
	lda.w $12B3,y
	inc a
	sta.w $12B3,y
	lda.l $7E24CA
	clc
	adc.w #$00C8
	sta.l $7E24CA
	lda.w #$0014
	sta.b $5B
CODE_C44E84:						; from CODE_C44E4E
	lda.w $10F3
	bne CODE_C44E99
	lda.b $6B
	cmp.w $07CC
	bne CODE_C44E99
	ldy.b $67
	lda.w $12DB,y
	inc a
	sta.w $12DB,y
CODE_C44E99:						; from CODE_C44E84
	lda.w #$000C
	trb.w $10F5
	ldy.b $6B
	lda.w $0A20,y
	bne CODE_C44EC0
	jsl.l ChkShotStat
	ldy.b $6B
	lda.w #$008C
	sta.w $0B60,y
	lda.w $0C80,y
	cmp.w #$1552
	bne CODE_C44EC0
	lda.w #$0005
	sta.w $0B60,y
CODE_C44EC0:						; from CODE_C44E99
	lda.b $6B
	cmp.w $07CC
	bne CODE_C44ED6
	ldy.b $67
	lda.w $05C8,y
	sta.b $8F
	bmi CODE_C44ED6
	jsl.l CODE_C5376A
	bra CODE_C44EDA
CODE_C44ED6:						; from CODE_C44EC0
	jsl.l CODE_C53724
CODE_C44EDA:						; from CODE_C44EC0
	lda.w #$FFFF
	sta.w $07CC
	rtl
CODE_C44EE1:						; from CODE_C45141, CODE_C449FE and other segments
	phx
	phy
	sec
	lda.w $09A0,x
	sbc.w $09A0,y
	pha
	sec
	lda.w $09C0,x
	sbc.w $09C0,y
	tay
	pla
	jsl.l ApproxLength
	xba
	and.w #$00F0
	sta.b $9F
	lsr a
	lsr a
	lsr a
	lsr a
	tsb.b $9F
	lda.w #$0014
	jsl.l CODE_C58CCD
	sec
	sbc.w #$000A
	xba
	ora.b $9F
	tay
	ldx.w #$0008
	lda.w #$0004
	jsl.l CODE_CF00E3
	ply
	plx
	rtl

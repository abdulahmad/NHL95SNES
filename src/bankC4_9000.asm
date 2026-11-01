; Segment bankC4_9000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C492F8
CODE_C492F8:						; called from other segments
	lda.w $0896,x
	cmp.w #$010E
	bpl CODE_C49324
	cmp.w #$FEF2
	bmi CODE_C49324
	cpx.w $05A0
	bne CODE_C4930C
	stz.b $7F
CODE_C4930C:						; from CODE_C492F8
	lda.b $83
	cmp.w #$0109
	bmi CODE_C49318
	lda.w #$0109
	sta.b $83
CODE_C49318:						; from CODE_C4930C
	lda.b $83
	cmp.w #$FEF7
	bpl CODE_C49324
	lda.w #$FEF7
	sta.b $83
CODE_C49324:						; from CODE_C492F8, CODE_C49318
	lda.b $83
	sec
	sbc.b $8B
	sta.b $83
CODE_C4932B:						; called from other segments
	rtl
DATA8_C4932C:						; not traced: data between routines
	db $02,$13,$34,$13,$CA,$13,$0C,$14,$66,$13,$98,$13,$2C,$18,$9A,$17
	db $08,$17
AdjustFacingDirection:				; called from other segments
	lda.w $0C40,x
	sta.b $40
	lda.w $0694,x
	bne CODE_C4936A
	lda.b $7F
	sec
	sbc.b $40
	beq CODE_C4936A
	eor.w #$FFFF
	inc a
	and.w #$0004
	lsr a
	dec a
	sta.b $7F
	clc
	adc.b $40
	and.w #$0007
	sta.w $0C40,x
	lda.w #$0006
	sta.w $0694,x
	rtl
CODE_C4936A:						; from AdjustFacingDirection
	lda.w $0694,x
	beq CODE_C4937B
	sec
	sbc.w $05A2
	bpl CODE_C49378
	lda.w #$0000
CODE_C49378:						; from CODE_C4936A
	sta.w $0694,x
CODE_C4937B:						; from CODE_C4936A
	rtl
GoaliePuckVector:					; called from other segments
	lda.w $0830
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.w $08B2
	sec
	sbc.w $0896,x
	sta.b $83
	bra CODE_C4939D
CODE_C49390:						; no caller found (not traced); it runs on into the next routine
	lda.w $0830
	sta.b $7F
	lda.w $08B2
	sec
	sbc.b $8F
	sta.b $83
CODE_C4939D:						; from GoaliePuckVector
	lda.w $0896,x
	bpl CODE_C493BC
	cmp.w #$FEF2
	bmi CODE_C493BB
	lda.w $08B2
	cmp.w #$FEF2
	bmi CODE_C493B0
	rts
CODE_C493B0:						; from CODE_C4939D
	lda.w #$0001
	sta.b $83
	rts
CODE_C493B6:						; from CODE_C493BC
	lda.w #$FFFF
	sta.b $83
CODE_C493BB:						; from CODE_C4939D, CODE_C493BC
	rts
CODE_C493BC:						; from CODE_C4939D
	cmp.w #$010E
	bpl CODE_C493BB
	lda.w $08B2
	cmp.w #$010E
	bpl CODE_C493B6
	rts
CODE_C493CA:						; called from other segments
	lda.w #$0002
	trb.w $0D7C
	beq CODE_C493E1
	stz.w $0AFC
	stz.w $0B1C
	lda.w #$0078
	sta.w $0B9C
	stz.w $234E
CODE_C493E1:						; from CODE_C493CA and other segments
	lda.w $07DA
	sec
	sbc.b $9B
	sta.w $07DA
	lda.w $07DE
	sec
	sbc.b $9B
	sta.w $07DE
	lda.w $0AFC
	sec
	sbc.b $9B
	sta.w $0AFC
	bpl CODE_C49408
	adc.w #$0005
	sta.w $0AFC
	jsl.l CODE_C494E6
CODE_C49408:						; from CODE_C493E1
	lda.w $05A0
	bmi CODE_C4945D
	sta.b $6B
	jsl.l a2touchpuck
	lda.b $6B
	jsl.l CODE_C37FE2
	ldy.b $6B
	lda.b $7F
	clc
	adc.w $0814,y
	sec
	sbc.w $0830
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C4942F
	ora.w #$C000
CODE_C4942F:						; from CODE_C49408
	clc
	adc.w $0830
	sta.w $0830
	lda.b $83
	clc
	adc.w $0896,y
	sec
	sbc.w $08B2
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C4944A
	ora.w #$C000
CODE_C4944A:						; from CODE_C4942F
	clc
	adc.w $08B2
	sta.w $08B2
	lda.w $09A0,y
	sta.w $09BC
	lda.w $09C0,y
	sta.w $09DC
CODE_C4945D:						; from CODE_C49408
	jsl.l PuckIChk
	jsl.l CODE_C4AED5
	lda.w $10F3
	bne CODE_C494D1
	lda.w $05A0
	bpl CODE_C494C8
	lda.w $1157
	beq CODE_C494A5
	lda.w $10F1
	bit.w #$0002
	bne CODE_C49483
	lda.w $18B4
	beq CODE_C4948F
	bra CODE_C49488
CODE_C49483:						; from CODE_C4945D
	lda.w $18B4
	bne CODE_C4948F
CODE_C49488:						; from CODE_C4945D
	lda.w $09DC
	bmi CODE_C494A5
	bra CODE_C49495
CODE_C4948F:						; from CODE_C4945D, CODE_C49483
	lda.w $09DC
	dec a
	bpl CODE_C494A5
CODE_C49495:						; from CODE_C49488
	lda.w $234E
	inc a
	sta.w $234E
	cmp.w #$0030
	bcc CODE_C494A8
	jsl.l EndPenaltyShot
CODE_C494A5:						; from CODE_C4945D, CODE_C49488, CODE_C4948F
	stz.w $234E
CODE_C494A8:						; from CODE_C49495
	lda.w $0830
	cmp.w $093C
	bne CODE_C494CB
	lda.w $08B2
	cmp.w $097C
	bne CODE_C494CB
	lda.w #$0006
	sta.b $7F
	dec.w $0B9C
	bpl CODE_C494D1
	jsl.l AddPenalty2
	bra CODE_C494D1
CODE_C494C8:						; from CODE_C4945D
	stz.w $234E
CODE_C494CB:						; from CODE_C494A8
	lda.w #$0078
	sta.w $0B9C
CODE_C494D1:						; from CODE_C4945D, CODE_C494A8
	lda.w $08DE
	and.w #$FF00
	ora.w $08D8
	beq CODE_C494DF
	jmp.w checkpuckcoll
CODE_C494DF:						; from CODE_C494D1
	jsl.l pucknothing
	jmp.w checkpuckcoll
CODE_C494E6:						; from CODE_C493E1 and other segments
	phx
	lda.w #$010E
	sta.b $8F
	ldy.w #$0000
	jsl.l CODE_C49504
	lda.w #$FEF2
	sta.b $8F
	ldy.w #$0004
	jsl.l CODE_C49504
	plx
	rtl
CODE_C49501:						; from CODE_C49504
	jmp.w CODE_C4956B
CODE_C49504:						; from CODE_C494E6 and other segments
	lda.b $8F
	sec
	sbc.w $08B2
	sta.b $7F
	lda.w $09DC
	beq CODE_C49501
	eor.b $7F
	bmi CODE_C49501
	lda.b $7F
	stz.b $34
	lsr a
	ror.b $34
	lsr a
	ror.b $34
	lsr a
	ror.b $34
	lsr a
	ror.b $34
	bit.w #$0800
	beq CODE_C4952D
	ora.w #$F000
CODE_C4952D:						; from CODE_C49504
	sta.b $36
	lda.w $09DC
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	sta.w $07DA,y
	lda.b $2C
	asl a
	asl a
	asl a
	asl a
	ldx.w $09BC
	jsl.l Mul16XS
	adc.w $0830
	sta.b $7F
	cmp.w #$009B
	bmi CODE_C49559
	lda.w #$009B
	sta.b $7F
CODE_C49559:						; from CODE_C4952D
	lda.b $7F
	cmp.w #$FF65
	bpl CODE_C49565
	lda.w #$FF65
	sta.b $7F
CODE_C49565:						; from CODE_C49559
	lda.b $7F
	sta.w $07D8,y
	rtl
CODE_C4956B:						; from CODE_C49501
	lda.w #$FFFF
	sta.w $07DA,y
	rtl
puckflip:							; called from other segments
	lda.b $7F
	and.w #$0001
	sta.b $7F
	eor.w $0C5C
	and.w #$0003
	sta.w $0C5C
	lda.w #$FFFF
	sta.w $0CDC
	phx
	ldx.w #$001C
	lda.w #$191A
	jsl.l SetSPAFromA
	plx
	rtl
pucknothing:						; from CODE_C494DF and other segments
	lda.w $0CBC
	cmp.w #$0008
	bcc CODE_C495AB
	cmp.w #$0018
	bcs CODE_C495AB
	lda.w $0C5C
	eor.w #$0002
	sta.w $0C5C
CODE_C495AB:						; from pucknothing
	lda.w #$0004
	tsb.w $0C5C
	stz.w $0CBC
	lda.w #$FFFF
	sta.w $0CDC
	rtl
skatetopuckinit:					; called from other segments
	lda.w $09BC
	xba
	lsr a
	and.w #$007F
	bit.w #$0040
	beq CODE_C495CB
	ora.w #$FF80
CODE_C495CB:						; from skatetopuckinit
	clc
	adc.w $0830
	sta.b $7F
	lda.w $09DC
	xba
	lsr a
	and.w #$007F
	bit.w #$0040
	beq CODE_C495E1
	ora.w #$FF80
CODE_C495E1:						; from CODE_C495CB
	clc
	adc.w $08B2
	sta.b $83
	rtl
chk4shot:							; called from other segments
	lda.w $10F3
	bne CODE_C495F8
	lda.w $114D
	cmp.w #$0005
	bcs CODE_C495F8
	jmp.w CompShoot
CODE_C495F8:						; from chk4shot
	lda.w $1157
	bne CODE_C49620
	jsl.l CODE_C42D98
	bne CODE_C49620
	lda.w $07EE
	beq CODE_C49620
	lda.w $0896,x
	cmp.w #$FF0D
	bmi CODE_C49620
	cmp.w #$00F3
	bpl CODE_C49620
	lda.w $04B0
	and.w #$0003
	bne CODE_C49620
	jmp.w CODE_C4A4AB
CODE_C49620:						; from CODE_C495F8
	lda.w #$0020
	sec
	sbc.w $0F00,x
	asl a
	asl a
	asl a
	asl a
	sta.b $8F
	ldy.w #$010E
	lda.w $0FE0,x
	bne CODE_C49638
	ldy.w #$FEF2
CODE_C49638:						; from CODE_C49620
	sty.b $83
	tya
	sec
	sbc.w $08B2
	sta.b $83
	cmp.w #$0064
	bpl CODE_C496AE
	cmp.w #$FF9C
	bmi CODE_C496AE
	lda.w $0830
	cmp.w #$0064
	bpl CODE_C496AE
	cmp.w #$FF9C
	bmi CODE_C496C2
	eor.w #$FFFF
	inc a
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	lda.b $83
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $9F
	ldx.b $B7
	cmp.w #$2711
	lsr.b $8F
	lsr.b $8F
	lsr.b $8F
	lsr.b $8F
	jsl.l vtoa
	sta.b $93
	lda.w #$0005
	sta.b $8B
	ldy.w #$0000
	cpx.w #$000C
	bcs CODE_C49697
	ldy.w #$000C
CODE_C49697:						; from CODE_C49638, CODE_C496BC
	lda.w $0A20,y
	beq CODE_C496B0
	lda.w $0624,y
	sec
	sbc.w #$0004
	and.w #$0007
	cmp.b $93
	bne CODE_C496BC
	asl.b $8F
	bra CODE_C496BC
CODE_C496AE:						; from CODE_C49638
	bra CODE_C496C2
CODE_C496B0:						; from CODE_C49697
	lda.w $1060,y
	beq CODE_C496BC
	stz.b $8B
	lda.w #$0001
	sta.b $8F
CODE_C496BC:						; from CODE_C49697, CODE_C496B0
	iny
	iny
	dec.b $8B
	bpl CODE_C49697
CODE_C496C2:						; from CODE_C49638, CODE_C496AE
	lda.b $8F
	jsl.l randomd0A
	cmp.w #$0009
	bcs CODE_C49709
	lda.w $08B2
	sta.b $7F
	lda.w $0FE0,x
	bne CODE_C496DF
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C496DF:						; from CODE_C496C2
	lda.b $7F
	bmi CODE_C49709
	lda.w #$010E
	sec
	sbc.b $7F
	bmi CODE_C49709
	lda.w $1157
	beq CODE_C496FE
	lda.w #$00B2
	lsr a
	lsr a
	clc
	adc.w #$005C
	sec
	sbc.b $7F
	bpl CODE_C49709
CODE_C496FE:						; from CODE_C496DF
	lda.w $10F5
	bit.w #$8000
	bne CODE_C49709
	jmp.w CompShoot
CODE_C49709:						; from CODE_C496C2, CODE_C496DF, CODE_C496FE
	rtl
shotdiradj:							; from doshot and other segments
	lda.w $14F9,x
	bmi CODE_C49712
	jmp.w CODE_C497DE
CODE_C49712:						; from shotdiradj
	lda.w #$0008
	sta.b $7F
	lda.w #$0005
	sta.b $83
	ldy.w #$0000
	lda.w $1020,x
	bne CODE_C49727
	ldy.w #$000C
CODE_C49727:						; from CODE_C49712, CODE_C49727
	lda.w $0A20,y
	beq CODE_C49735
	iny
	iny
	dec.b $83
	bpl CODE_C49727
	jmp.w CODE_C497D9
CODE_C49735:						; from CODE_C49727
	lda.w $09A1,y
	and.w #$00FF
	bit.w #$0080
	beq CODE_C49743
	ora.w #$FF00
CODE_C49743:						; from CODE_C49735
	pha
	asl a
	pla
	ror a
	clc
	adc.w $0814,y
	sec
	sbc.w $0830
	sta.b $7F
	lda.w $09C1,y
	and.w #$00FF
	bit.w #$0080
	beq CODE_C4975F
	ora.w #$FF00
CODE_C4975F:						; from CODE_C49743
	pha
	asl a
	pla
	ror a
	clc
	adc.w $0896,y
	sec
	sbc.w $08B2
	sta.b $83
	ldy.b $7F
	jsl.l ApproxLength
	sta.b $87
	lda.w #$0012
	sta.b $8B
	ldy.w #$010E
	lda.w $0FE0,x
	bne CODE_C49785
	ldy.w #$FEF2
CODE_C49785:						; from CODE_C4975F
	sty.b $8F
	tya
	pha
	pei ($8B)
	jsr.w CalcAngleOffset
	lda.b $8F
	sta.b $93
	pla
	eor.w #$FFFF
	inc a
	sta.b $8B
	pla
	sta.b $8F
	jsr.w CalcAngleOffset
	lda.b $8F
	clc
	adc.b $93
	sta.b $8F
	ldx.b $6F
	stz.b $7F
	lda.b $8F
	cmp.w #$FFD3
	bmi CODE_C497D9
	cmp.w #$002D
	bpl CODE_C497D9
	lda.w $0FE0,x
	beq CODE_C497C3
	lda.w #$0000
	sec
	sbc.b $8F
	sta.b $8F
CODE_C497C3:						; from CODE_C49785
	jsl.l RandomWord
	and.w #$0003
	inc a
	sta.b $7F
	lda.b $8F
	bpl CODE_C497D9
	lda.b $7F
	clc
	adc.w #$0004
	sta.b $7F
CODE_C497D9:						; from CODE_C49727, CODE_C49785, CODE_C497C3
	lda.b $7F
	sta.w $07C8
CODE_C497DE:						; from shotdiradj
	rtl
CalcAngleOffset:					; from CODE_C49785
	lda.b $8B
	sec
	sbc.w $0830
	sta.b $8B
	lda.b $8F
	sec
	sbc.w $08B2
	ldx.b $7F
	jsl.l Mul16S
	lda.b $36
	sta.b $91
	lda.b $34
	sta.b $8F
	lda.b $83
	ldx.b $8B
	jsl.l Mul16S
	lda.b $8F
	sec
	sbc.b $34
	sta.b $34
	lda.b $91
	sbc.b $36
	sta.b $36
	lda.b $87
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	sta.b $8F
	rts
CompShoot:							; from chk4shot, CODE_C496FE and other segments
	pla
	sep #$20
	pla
	rep #$30
	lda.w $08B2
	sta.b $7F
	lda.w $0FE0,x
	bne CODE_C49835
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C49835:						; from CompShoot
	lda.w #$010E
	sec
	sbc.b $7F
	lsr a
	lsr a
	lsr a
	cmp.w #$0015
	bcc CODE_C49846
	lda.w #$0014
CODE_C49846:						; from CODE_C49835
	sta.b $83
	stz.w $0B00,x
	lda.b $83
	sta.w $0B80,x
	lda.w #$0013
	sta.b $7F
	jmp.w assreplace
SetShotMode:						; from CODE_C498A1 and other segments
	lda.w #$0008
	sta.w $07C8
	lda.w #$0008
	tsb.w $10F5
	stz.b $7F
	lda.w #$0128
	sta.b $83
	lda.w $0FE0,x
	bne CODE_C49875
	lda.w #$FED8
	sta.b $83
CODE_C49875:						; from SetShotMode
	lda.b $7F
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.b $83
	sec
	sbc.w $0896,x
	sta.b $83
	jsl.l vtoa
	lda.w #$000F
	sta.w $07CA
	ldy.w #$1C24
	jsl.l Findhittype
	beq CODE_C4989B
	ldy.w #$1D36
CODE_C4989B:						; from CODE_C49875
	sty.b $83
	jml.l SetSPA
CODE_C498A1:						; called from other segments
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C498B1
	and.w #$FFFD
	sta.w $0D60,x
	bra SetShotMode
CODE_C498B1:						; from CODE_C498A1
	lda.w $10F5
	bit.w #$0008
	bne CODE_C498BC
	jmp.w assexit
CODE_C498BC:						; from CODE_C498B1
	lda.w $0AE0,x
	sta.b $7F
	stz.b $87
	lda.w $0B80,x
	sec
	sbc.b $9B
	sta.w $0B80,x
	bpl CODE_C498D3
	lda.w #$0080
	tsb.b $87
CODE_C498D3:						; from CODE_C498BC and other segments
	cpx.w $05A0
	bne CODE_C49929
	lda.w $0C80,x
	cmp.w #$1C24
	bcc CODE_C49929
	cmp.w #$1EFB
	bcs CODE_C49929
	lda.w $0CA0,x
	cmp.w #$0018
	bcs doshot
	lda.b $7F
	bit.w #$0008
	bne CODE_C498FA
	and.w #$0007
	sta.w $07C8
CODE_C498FA:						; from CODE_C498D3
	lda.w $0CA0,x
	cmp.w #$0010
	bcs CODE_C4992F
	lda.w $07CA
	clc
	adc.b $9B
	sta.w $07CA
	lda.b $87
	bit.w #$0080
	beq CODE_C4992F
	lda.w #$001C
	sec
	sbc.w $0CA0,x
	sta.w $0CA0,x
	cmp.w #$0018
	bcc CODE_C4992F
	lda.w #$0018
	sta.w $0CA0,x
	bra doshot
CODE_C49929:						; from CODE_C498D3
	lda.w #$0008
	trb.w $10F5
CODE_C4992F:						; from CODE_C498FA
	rtl
doshot:								; from CODE_C498D3, CODE_C498FA, CODE_C49F9D, ...
	jsl.l shotdiradj
	pea.w $000D
	lda.w $07CA
	lsr a
	adc.w $07CA
	sta.w $07CA
	lda.w #$0008
	trb.w $10F5
	sta.w $1000,x
	stx.w $07EA
	cpx.w $05A0
	beq CODE_C49955
	jmp.w CODE_C49AFE
CODE_C49955:						; from doshot
	lda.w #$000E
	sta.b $01,s
	lda.w #$1000
	tsb.w $10F5
	lda.w $0C80,x
	cmp.w #$1D36
	bne CODE_C4996D
	lda.w #$000E
	sta.b $01,s
CODE_C4996D:						; from CODE_C49955
	lda.w $07CA
	sta.w $068E
	cmp.w #$001E
	bcc CODE_C4997D
	lda.w #$0010
	sta.b $01,s
CODE_C4997D:						; from CODE_C4996D
	lda.w $0E80,x
	stx.b $63
	jsl.l makepde
	adc.w #$0014
	tax
	lda.w $07CA
	jsl.l Mul16x8U
	ldx.b $34
	lda.w #$2570
	jsl.l Mul16U
	lda.b $36
	sta.w $07CA
	lda.w $18AE
	beq CODE_C499AE
	jsl.l CheckBreakaway
	lda.w $1155
	sta.w $18AE
CODE_C499AE:						; from CODE_C4997D
	ldx.b $B7
	lda.w #$FFFF
	sta.w $05A0
	lda.w #$000C
	sta.w $0CE0,x
	txa
	lsr a
	sta.w $07B8
	ldy.w #$010E
	lda.w $0FE0,x
	bne CODE_C499CC
	ldy.w #$FEF2
CODE_C499CC:						; from CODE_C499AE
	sty.b $83
	lda.w $07C8
	asl a
	asl a
	tay
	lda.w #$9B35
	sta.b $63
	lda.w #$00C4
	sta.b $65
	lda.b [$63],y
	sec
	sbc.w $0830
	sta.b $7F
	iny
	iny
	lda.b [$63],y
	sta.b $87
	pha
	lda.b $83
	sec
	sbc.w $08B2
	sta.b $83
	pha
	lda.b $7F
	pha
	ldy.b $83
	jsl.l ApproxLength
	cmp.w #$0000
	bne CODE_C49A05
	inc a
CODE_C49A05:						; from CODE_C499CC
	sta.b $8B
	lda.w $10F1
	bit.w #$0010
	beq CODE_C49A12
	jmp.w CODE_C49A83
CODE_C49A12:						; from CODE_C49A05
	lda.b $8B
	cmp.w #$00C9
	bcs CODE_C49A28
	lda.w #$0010
	adc.w $0EA0,x
	jsl.l CODE_C37EAA
	cmp.w #$000F
	bcs CODE_C49A83
CODE_C49A28:						; from CODE_C49A12
	lda.w $07CA
	lsr a
	lsr a
	lsr a
	sec
	sbc.w $0EA0,x
	clc
	adc.w #$0010
	ldx.b $8B
	jsl.l Mul16U
	lda.b $34
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	ldx.b $8B
	cpx.w #$012D
	bcs CODE_C49A4C
	lsr a
CODE_C49A4C:						; from CODE_C49A28
	cmp.w #$009B
	bcc CODE_C49A54
	lda.w #$009B
CODE_C49A54:						; from CODE_C49A4C
	pha
	jsl.l randomd0s
	adc.b $03,s
	sta.b $03,s
	lda.b $01,s
	cmp.w #$003D
	bcc CODE_C49A69
	lda.w #$003C
	sta.b $01,s
CODE_C49A69:						; from CODE_C49A54
	sta.b $7F
	lda.b $05,s
	bpl CODE_C49A71
	lsr.b $7F
CODE_C49A71:						; from CODE_C49A69
	jsl.l randomd0sd0
	adc.b $05,s
	sta.b $05,s
	pla
	lsr a
	jsl.l randomd0A
	adc.b $05,s
	sta.b $05,s
CODE_C49A83:						; from CODE_C49A05, CODE_C49A12
	ldx.w $07CA
	lda.w #$0044
	jsl.l Mul16x8XS
	lda.b $34
	plx
	pha
	jsl.l Mul16S
	lda.b $8B
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	asl a
	sta.w $09BC
	pla
	plx
	jsl.l Mul16S
	lda.b $8B
	sta.b $30
	jsl.l Div32S
	lda.b $2C
	asl a
	sta.w $09DC
	ldx.b $B7
	pla
	beq CODE_C49AFE
	tax
	lda.w $07CA
	jsl.l Mul16U
	ldx.b $34
	lda.w #$0044
	jsl.l Mul16x8U
	lda.b $8B
	sta.b $30
	jsl.l Div32U
	lda.b $2C
	asl a
	sta.b $83
	lda.w #$0B33
	ldx.b $8B
	jsl.l Mul16U
	lda.w $07CA
	sta.b $30
	jsl.l Div32U
	ldx.b $B7
	lda.b $2C
	lsr a
	adc.b $83
	cmp.w #$1801
	bcc CODE_C49AFB
	lda.w #$1800
CODE_C49AFB:						; from CODE_C49A83
	sta.w $08DE
CODE_C49AFE:						; from doshot, CODE_C49A83
	pla
	jsl.l CODE_CF040B
	ldx.b $6F
	ldy.w #$010E
	lda.w $0FE0,x
	bne CODE_C49B10
	ldy.w #$FEF2
CODE_C49B10:						; from CODE_C49AFE
	sty.b $9F
	tya
	sec
	sbc.w $08B2
	eor.w $09DC
	bpl CODE_C49B26
	lda.w #$0000
	sec
	sbc.w $09DC
	sta.w $09DC
CODE_C49B26:						; from CODE_C49B10
	lda.w $1157
	beq CODE_C49B34
	lda.w #$0012
	sta.b $7F
	jsl.l assreplace
CODE_C49B34:						; from CODE_C49B26
	rtl
DATA8_C49B35:						; not traced: data between routines
	db $00,$00,$0C,$00,$0F,$00,$0C,$00,$0F,$00,$06,$00,$0F,$00,$00,$00
	db $00,$00,$00,$00,$F1,$FF,$00,$00,$F1,$FF,$06,$00,$F1,$FF,$0C,$00
	db $00,$00,$06,$00
CODE_C49B59:						; called from other segments
	cpx.w $05A0
	bne CODE_C49B63
	lda.w $14F9,x
	bmi CODE_C49B74
CODE_C49B63:						; from CODE_C49B59
	jmp.w assexit
DATA8_C49B66:						; an rtl no traced code reaches
	db $6B
CODE_C49B67:						; from CODE_C49B74
	jsl.l CODE_C42B18
	lda.w #$003C
	sta.w $0CE0,x
	jmp.w donothing
CODE_C49B74:						; from CODE_C49B59
	lda.w $10F3
	bne CODE_C49B67
	lda.w $0896,x
	sta.b $7F
	ldy.w $0FE0,x
	bne CODE_C49B8B
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C49B8B:						; from CODE_C49B74
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C49BB4
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $0AE0,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
	stz.w $18CA
	lda.w $04B0
	and.w #$0003
	sta.w $0B20,x
	jsr.w CODE_C49CDB
CODE_C49BB4:						; from CODE_C49B8B
	lda.w $18C8
	bmi CODE_C49BF8
	lda.b $7F
	cmp.w $18C8
	bmi CODE_C49BC9
	jsr.w CODE_C49C88
	lda.w $0C40,x
	sta.w $18CE
CODE_C49BC9:						; from CODE_C49BB4, CODE_C49BF8, CODE_C49C15
	lda.w $18C4
	sta.b $7F
	lda.w $18C6
	sta.b $83
	lda.w $0FE0,x
	bne CODE_C49BE0
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
CODE_C49BE0:						; from CODE_C49BC9
	lda.w #DATA8_C49C87>>16
	sta.b $65
	lda.w #DATA8_C49C87
	sta.b $63
	lda.w $0B00,x
	sec
	sbc.w $07A4
	sta.w $0B00,x
	jml.l skateto
CODE_C49BF8:						; from CODE_C49BB4
	lda.w $0C40,x
	sec
	sbc.w $18CE
	beq CODE_C49BC9
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs CODE_C49C15
	jsl.l RandomWord
	and.w #$0F80
	bne CODE_C49BC9
	bra CODE_C49C1E
CODE_C49C15:						; from CODE_C49BF8
	jsl.l RandomWord
	and.w #$0600
	bne CODE_C49BC9
CODE_C49C1E:						; from CODE_C49BF8
	jsl.l RandomWord
	and.w #$0001
	inc a
	inc a
	sta.b $7F
	ldy.w $18CC
	bpl CODE_C49C36
	lda.b $7F
	clc
	adc.w #$0003
	sta.b $7F
CODE_C49C36:						; from CODE_C49C1E
	lda.b $7F
	sta.w $07C8
	lda.w #$0014
	sta.w $07CA
	lda.w #$0000
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.w $0FE0,x
	bne CODE_C49C5A
	lda.w #$FEF2
	sec
	sbc.w $0896,x
	sta.b $83
	bra CODE_C49C63
CODE_C49C5A:						; from CODE_C49C36
	lda.w #$010E
	sec
	sbc.w $0896,x
	sta.b $83
CODE_C49C63:						; from CODE_C49C36
	jsl.l vtoa
	jsl.l Findhittype
	beq CODE_C49C72
	lda.w #$1EFA
	bra CODE_C49C75
CODE_C49C72:						; from CODE_C49C63
	lda.w #$1E48
CODE_C49C75:						; from CODE_C49C63
	jsl.l SetSPAFromA
	jsl.l updateanim
	lda.w #$0002
	sta.w $0CC0,x
	jml.l doshot
DATA8_C49C87:						; not traced: a table read by CODE_C49BE0
	db $6B
CODE_C49C88:						; from CODE_C49BB4
	lda.w $18CA
	asl a
	adc.w $18CA
	asl a
	tay
	lda.w #DATA8_C49CC3>>16
	sta.b $65
	lda.w #DATA8_C49CC3
	sta.b $63
	lda.b [$63],y
	sta.b $7F
	lda.w $18CC
	bpl CODE_C49CAC
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C49CAC:						; from CODE_C49C88
	lda.b $7F
	sta.w $18C4
	iny
	iny
	lda.b [$63],y
	sta.w $18C6
	iny
	iny
	lda.b [$63],y
	sta.w $18C8
	inc.w $18CA
	rts
DATA8_C49CC3:						; not traced: a table read by CODE_C49C88
	db $28,$00,$78,$00,$50,$00,$EA,$FF,$97,$00,$8C,$00,$EA,$FF,$E6,$00
	db $B7,$00,$2C,$00,$E9,$00,$FF,$FF
CODE_C49CDB:						; from CODE_C49B8B
	lda.b $7F
	cmp.w #$002E
	bpl CODE_C49D2A
	jsl.l RandomWord
	and.w #$00C0
	beq CODE_C49CF5
	lda.w $08E0,x
	bit.w #$0800
	bne CODE_C49D06
	bra CODE_C49D0B
CODE_C49CF5:						; from CODE_C49CDB
	jsl.l RandomWord
	and.w #$00F0
	sta.b $7F
	lda.w #$007F
	sec
	sbc.b $7F
	bmi CODE_C49D0B
CODE_C49D06:						; from CODE_C49CDB
	lda.w #$0033
	bra CODE_C49D0E
CODE_C49D0B:						; from CODE_C49CDB, CODE_C49CF5
	lda.w #$FFCD
CODE_C49D0E:						; from CODE_C49D06
	ldy.w $0FE0,x
	bne CODE_C49D17
	eor.w #$FFFF
	inc a
CODE_C49D17:						; from CODE_C49D0E
	sta.w $18CC
	sta.w $18C4
	lda.w #$0028
	sta.w $18C6
	lda.w #$001E
	sta.w $18C8
	rts
CODE_C49D2A:						; from CODE_C49CDB
	lda.w $0814,x
	cmp.w #$0020
	bpl CODE_C49D85
	cmp.w #$FFE0
	bmi CODE_C49D85
	jsl.l RandomWord
	and.w #$00C0
	beq CODE_C49D4A
	lda.w $08E0,x
	bit.w #$0800
	bne CODE_C49D5B
	bra CODE_C49D60
CODE_C49D4A:						; from CODE_C49D2A
	jsl.l RandomWord
	and.w #$00F0
	sta.b $7F
	lda.w #$007F
	sec
	sbc.b $7F
	bmi CODE_C49D60
CODE_C49D5B:						; from CODE_C49D2A
	lda.w #$002C
	bra CODE_C49D63
CODE_C49D60:						; from CODE_C49D2A, CODE_C49D4A
	lda.w #$FFD4
CODE_C49D63:						; from CODE_C49D5B
	ldy.w $0FE0,x
	bne CODE_C49D6C
	eor.w #$FFFF
	inc a
CODE_C49D6C:						; from CODE_C49D63
	sta.w $18CC
	sta.w $18C4
CODE_C49D72:						; from CODE_C49D85
	lda.w #$0002
	sta.w $18CA
	lda.w #$0097
	sta.w $18C6
	lda.w #$008C
	sta.w $18C8
	rts
CODE_C49D85:						; from CODE_C49D2A
	sta.w $18CC
	stz.w $18C4
	bra CODE_C49D72
Findhittype:						; from CODE_C49875, CODE_C4A20F, CODE_C49ED4, ...
	lda.b $7F
	eor.w #$FFFF
	inc a
	clc
	adc.w $0C40,x
	and.w #$0007
	sta.b $7F
	lda.w $08E0,x
	bit.w #$0800
	beq CODE_C49DB0
	phx
	ldx.b $7F
	lda.l DATA8_C49DBC,x
	plx
	and.w #$00FF
	rtl
CODE_C49DB0:						; from Findhittype
	phx
	ldx.b $7F
	lda.l DATA8_C49DBF,x
	plx
	and.w #$00FF
	rtl
DATA8_C49DBC:						; not traced: a table read by Findhittype
	db $00,$00,$00
DATA8_C49DBF:						; not traced: a table read by CODE_C49DB0
	db $00,$01,$01,$01,$01,$00,$00,$00
setpassmode:						; called from other segments
	lda.w $0A20,x
	bne CODE_C49DEB
	lda.w $0830
	cmp.w #$FFF0
	bmi CODE_C49DEB
	cmp.w #$0010
	bpl CODE_C49DEB
	lda.w $08B2
	cmp.w #$010E
	bpl CODE_C49DE6
	cmp.w #$FEF2
	bpl CODE_C49DEB
CODE_C49DE6:						; from setpassmode
	cmp.w #$0116
	bcc CODE_C49DFA
CODE_C49DEB:						; from setpassmode
	lda.w $0C40,x
	and.w #$0007
	sta.w $07C8
	lda.w #$0004
	tsb.w $10F5
CODE_C49DFA:						; from CODE_C49DE6
	rtl
asspassrec:							; called from other segments
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C49E15
	and.w #$FFFD
	ora.w #$0001
	sta.w $0D60,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
CODE_C49E15:						; from asspassrec
	dec.w $0676,x
	bmi CODE_C49E78
	lda.w $05A0
	bpl CODE_C49E78
	lda.w $0672
	bne CODE_C49E91
	ldy.w $14F9,x
	bmi CODE_C49E42
	lda.w $0583,y
	bit.w #$8000
	bne CODE_C49E78
	bit.w #$0080
	beq CODE_C49E42
	inc.w $0672
	lda.w #$7FFF
	sta.w $0674
	bra CODE_C49E91
DATA8_C49E41:						; an rtl no traced code reaches
	db $6B
CODE_C49E42:						; from CODE_C49E15
	ldy.b $6B
	lda.w $14F5,y
	bne CODE_C49E73
	lda.w $0FE0,x
	bne CODE_C49E6B
	lda.w $0896,x
	cmp.w #$FFA4
	bpl CODE_C49E73
CODE_C49E56:						; from CODE_C49E6B
	jsl.l RandomWord
	and.w #$0080
	bne CODE_C49E73
	inc.w $0672
	lda.w #$7FFF
	sta.w $0674
	jmp.w CODE_C49E91
CODE_C49E6B:						; from CODE_C49E42
	lda.w $0896,x
	cmp.w #$005C
	bpl CODE_C49E56
CODE_C49E73:						; from CODE_C49E42, CODE_C49E56
	lda.w $05A0
	bmi CODE_C49E90
CODE_C49E78:						; from CODE_C49E15, CODE_C49EED, CODE_C49FAF, CODE_C49F9D
	lda.w #$FFFF
	sta.w $07CC
	stz.w $1000,x
	stz.w $0672
	lda.w $0D60,x
	and.w #$FFFE
	sta.w $0D60,x
	jmp.w assexit
CODE_C49E90:						; from CODE_C49E73, CODE_C49EE6
	rtl
CODE_C49E91:						; from CODE_C49E15, CODE_C49E56
	lda.w $0C80,x
	cmp.w #$1E48
	beq CODE_C49EF0
	cmp.w #$1EFA
	beq CODE_C49EF0
	phy
	ldy.w #$0000
	cpx.w #$000C
	bmi CODE_C49EAA
	ldy.w #$0002
CODE_C49EAA:						; from CODE_C49E91
	lda.w $12F3,y
	inc a
	sta.w $12F3,y
	ply
	lda.w #$0000
	sec
	sbc.w $066E
	sta.b $7F
	lda.w $0FE0,x
	bne CODE_C49ECB
	lda.w #$FEF2
	sec
	sbc.w $0670
	sta.b $83
	bra CODE_C49ED4
CODE_C49ECB:						; from CODE_C49EAA
	lda.w #$010E
	sec
	sbc.w $0670
	sta.b $83
CODE_C49ED4:						; from CODE_C49EAA
	jsl.l vtoa
	jsl.l Findhittype
	beq CODE_C49EE3
	lda.w #$1EFA
	bra CODE_C49EE6
CODE_C49EE3:						; from CODE_C49ED4
	lda.w #$1E48
CODE_C49EE6:						; from CODE_C49ED4
	jsl.l SetSPAFromA
	jmp.w CODE_C49E90
CODE_C49EED:						; from CODE_C49EF0
	jmp.w CODE_C49E78
CODE_C49EF0:						; from CODE_C49E91
	lda.w #$000A
	sta.w $0CE0,x
	lda.w $0CA0,x
	cmp.w #$0010
	bcs CODE_C49EED
	bit.w $0674
	bmi CODE_C49EED
	txa
	jsl.l CODE_C37FE2
	lda.w $0814,x
	clc
	adc.b $7F
	sec
	sbc.w $0830
	tay
	lda.w $0896,x
	clc
	adc.b $83
	sec
	sbc.w $08B2
	jsl.l ApproxLength
	cmp.w $0674
	sta.w $0674
	bcs CODE_C49F2C
	jmp.w CODE_C49FAF
CODE_C49F2C:						; from CODE_C49EF0
	lda.w $0814,x
	sec
	sbc.w $0830
	tay
	lda.w $0896,x
	sec
	sbc.w $08B2
	jsl.l ApproxLength
	cmp.w #$001C
	bcs CODE_C49FAF
	lda.w #$FFFF
	sta.w $0674
	stz.w $09BC
	stz.w $09DC
	stz.w $0CC0,x
	stx.w $05A0
	ldy.w $14F9,x
	bmi CODE_C49F63
	lda.w $056F,y
	sta.w $07C8
	bra CODE_C49F69
CODE_C49F63:						; from CODE_C49F2C
	lda.w #$0008
	sta.w $07C8
CODE_C49F69:						; from CODE_C49F2C
	lda.w #$0024
	sta.w $07CA
	sta.w $1000,x
	lda.w $10F3
	bne CODE_C49F8B
	phy
	ldy.w #$0000
	cpx.w #$000C
	bmi CODE_C49F83
	ldy.w #$0002
CODE_C49F83:						; from CODE_C49F69
	lda.w $12F7,y
	inc a
	sta.w $12F7,y
	ply
CODE_C49F8B:						; from CODE_C49F69
	lda.w #$0001
	sta.w $18AC
	lda.w $14E3
	clc
	adc.w #$000A
	bmi CODE_C49F9D
	sta.w $14E3
CODE_C49F9D:						; from CODE_C49F8B
	pei ($6B)
	stx.b $6B
	jsl.l a2touchpuck
	pla
	sta.b $6B
	jsl.l doshot
	jmp.w CODE_C49E78
CODE_C49FAF:						; from CODE_C49EF0, CODE_C49F2C
	lda.w $05A0
	bmi CODE_C49FBC
	cpx.w $05A0
	beq CODE_C49FBC
	jmp.w CODE_C49E78
CODE_C49FBC:						; from CODE_C49FAF
	rtl

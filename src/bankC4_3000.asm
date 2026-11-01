; Segment bankC4_3000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4313E
assdefd:							; called from other segments
	ldy.w puckc
	bmi CODE_C43157
	lda.w pfteam,x
	cmp.w pfteam,y
	bne CODE_C43157
	lda.w #$0001
	sta.b d0
	jmp.w assreplace
CODE_C43153:						; from CODE_C43157
	rtl
CODE_C43154:						; from CODE_C43157
	jmp.w donothing
CODE_C43157:						; from assdefd
	lda.w gmclock
	bne CODE_C43154
	jsl.l check4bench
	lda.w playerpad,x
	bpl CODE_C43153
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C4317F
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
CODE_C4317F:						; from CODE_C43157
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bmi CODE_C4318D
	jmp.w CODE_C4330F
CODE_C4318D:						; from CODE_C4317F
	clc
	adc.w aidef,x
	bpl CODE_C43196
	lda.w #$0000
CODE_C43196:						; from CODE_C4318D
	sta.w temp1,x
	lda.w pucky
	sta.b d1
	lda.w puckvy
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0200
	beq CODE_C431AF
	ora.w #$FC00
CODE_C431AF:						; from CODE_C43196
	sta.b d3
	lda.w pfgoal,x
	bne CODE_C431C6
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
	lda.w #$0000
	sec
	sbc.b d3
	sta.b d3
CODE_C431C6:						; from CODE_C431AF
	lda.b d3
	bpl CODE_C431CC
	stz.b d3
CODE_C431CC:						; from CODE_C431C6
	lda.b d3
	clc
	adc.b d1
	sta.b d3
	sec
	sbc.w #$005C
	bmi CODE_C43207
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne CODE_C43207
	lda.w puckc
	bmi CODE_C431E9
	lsr a
CODE_C431E9:						; from CODE_C431CC
	sta.b d1
	bmi CODE_C43207
	jsl.l CODE_C42D98
	beq CODE_C43207
	lda.b d1
	sec
	sbc.w #$0006
	sta.b d1
	txa
	lsr a
	sec
	sbc.w #$0006
	sta.b d2
	eor.b d1
	sta.b d1
CODE_C43207:						; from CODE_C431CC, CODE_C431E9
	lda.w #$0041
	sta.w temp3,x
	lda.w position,x
	cmp.w #$0002
	beq CODE_C4321B
	lda.w #$FFBF
	sta.w temp3,x
CODE_C4321B:						; from CODE_C43207
	ldy.w #$0000
	cpx.w #$000C
	bcs CODE_C43226
	ldy.w #$000C
CODE_C43226:						; from CODE_C4321B
	lda.w #$0006
	sta.b d2
	lda.w #$FC18
	sta.b d0
	lda.w pfgoal,x
	beq CODE_C432A1
	lda.w #$03E8
	sta.b d0
CODE_C4323A:						; from CODE_C4326D
	sty.b a0
	lda.w pflags,y
	bit.w #$1000
	bne CODE_C4326D
	lda.w position,y
	bmi CODE_C4326D
	lda.w Yvel,y
	bmi CODE_C43251
	lda.w #$0000
CODE_C43251:						; from CODE_C4323A
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0400
	beq CODE_C4325E
	ora.w #$F800
CODE_C4325E:						; from CODE_C43251
	clc
	adc.w Ypos,y
	sta.b d1
	sec
	sbc.b d0
	bpl CODE_C4326D
	lda.b d1
	sta.b d0
CODE_C4326D:						; from CODE_C4323A, CODE_C4325E
	ldy.b a0
	iny
	iny
	dec.b d2
	bne CODE_C4323A
	lda.b d0
	sec
	sbc.w #$0028
	sta.b d0
	sec
	sbc.w #$FF42
	bpl CODE_C43288
	lda.w #$FF24
	sta.b d0
CODE_C43288:						; from CODE_C4326D
	lda.b d0
	sta.w temp4,x
	lda.w $0830
	sta.b d0
	lda.w temp3,x
	eor.b d0
	sta.b d1
	bpl CODE_C4330F
	stz.w temp3,x
	bra CODE_C4330F
DATA8_C432A0:						; an rtl no traced code reaches
	db $6B
CODE_C432A1:						; from CODE_C43226, CODE_C432D4
	sty.b a0
	lda.w pflags,y
	bit.w #$1000
	bne CODE_C432D4
	lda.w position,y
	bmi CODE_C432D4
	lda.w Yvel,y
	bpl CODE_C432B8
	lda.w #$0000
CODE_C432B8:						; from CODE_C432A1
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0400
	beq CODE_C432C5
	ora.w #$F800
CODE_C432C5:						; from CODE_C432B8
	clc
	adc.w Ypos,y
	sta.b d1
	sec
	sbc.b d0
	bmi CODE_C432D4
	lda.b d1
	sta.b d0
CODE_C432D4:						; from CODE_C432A1, CODE_C432C5
	ldy.b a0
	iny
	iny
	dec.b d2
	bne CODE_C432A1
	lda.b d0
	clc
	adc.w #$0028
	sta.b d0
	sec
	sbc.w #$00BE
	bmi CODE_C432EF
	lda.w #$00DC
	sta.b d0
CODE_C432EF:						; from CODE_C432D4
	lda.b d0
	sta.w temp4,x
	lda.w #$0000
	sec
	sbc.w temp3,x
	sta.w temp3,x
	lda.w $0830
	sta.b d0
	lda.w temp3,x
	eor.b d0
	sta.b d1
	bpl CODE_C4330F
	stz.w temp3,x
CODE_C4330F:						; from CODE_C4317F, CODE_C43288, CODE_C432EF
	lda.w temp3,x
	sta.b d0
	lda.w temp4,x
	sta.b d1
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b a0
	jsl.l skateto
	jmp.w check4check
assdefo:							; called from other segments
	cpx.w puckc
	beq CODE_C43348
	ldy.w puckc
	bmi CODE_C43350
	lda.w pfteam,x
	cmp.w pfteam,y
	beq CODE_C43350
	lda.w #$0002
	sta.b d0
	jmp.w assreplace
CODE_C43344:						; from CODE_C43358
	rtl
DATA8_C43345:						; not traced: data between routines
	db $4C,$FD,$36
CODE_C43348:						; from assdefo
	lda.w #$0011
	sta.b d0
	jmp.w CODE_C43734
CODE_C43350:						; from assdefo
	lda.w gmclock
	beq CODE_C43358
	jmp.w donothing
CODE_C43358:						; from CODE_C43350
	jsl.l check4bench
	lda.w playerpad,x
	bpl CODE_C43344
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C4337B
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
CODE_C4337B:						; from CODE_C43358
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl CODE_C43392
	clc
	adc.w aioff,x
	bpl CODE_C4338F
	lda.w #$0000
CODE_C4338F:						; from CODE_C4337B
	sta.w temp1,x
CODE_C43392:						; from CODE_C4337B
	lda.w #EvadePC>>16
	sta.b $65
	lda.w #EvadePC
	sta.b a0
	ldy.w #$0050
	lda.w position,x
	cmp.w #$0002
	beq CODE_C433AA
	ldy.w #$FFB0
CODE_C433AA:						; from CODE_C43392
	lda.w pfgoal,x
	bne CODE_C433B5
	tya
	eor.w #$FFFF
	inc a
	tay
CODE_C433B5:						; from CODE_C433AA
	sty.b d0
	lda.w $0830
	eor.b d0
	bmi CODE_C433C4
	lda.w $0830
	bra CODE_C433CE
DATA8_C433C3:						; an rtl no traced code reaches
	db $6B
CODE_C433C4:						; from CODE_C433B5
	lda.w $0830
	pha
	asl a
	pla
	ror a
	clc
	adc.b d0
CODE_C433CE:						; from CODE_C433B5
	sta.b d0
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne CODE_C4341B
	lda.w pucky
	sta.b d2
	lda.w pfgoal,x
	bne CODE_C433EC
	lda.w #$0000
	sec
	sbc.b d2
	sta.b d2
CODE_C433EC:						; from CODE_C433CE
	lda.b d2
	cmp.w #$FFA4
	bmi CODE_C43406
	cmp.w #$005C
	bmi CODE_C433FF
	lda.w #$0066
	sta.b d1
	bra CODE_C4340B
CODE_C433FF:						; from CODE_C433EC
	lda.w #$FFAE
	sta.b d1
	bra CODE_C4340B
CODE_C43406:						; from CODE_C433EC
	lda.w #$FF24
	sta.b d1
CODE_C4340B:						; from CODE_C433EC, CODE_C433FF
	lda.w pfgoal,x
	bne CODE_C43418
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
CODE_C43418:						; from CODE_C43426, CODE_C4340B
	jmp.w skateto
CODE_C4341B:						; from CODE_C433CE
	ldy.w #$0066
	lda.w pfgoal,x
	beq CODE_C43426
	ldy.w #$FF9A
CODE_C43426:						; from CODE_C4341B
	sty.b d1
	bra CODE_C43418
EvadePC:							; passed as a long pointer (lda #bank, lda #low) to skateto
	lda.w puckc
	bmi CODE_C4348D
	lda.w $09A1,x
	sec
	sbc.w $09BD
	and.w #$00FF
	bit.w #$0080
	beq CODE_C43441
	ora.w #$FF00
CODE_C43441:						; from EvadePC
	clc
	adc.w Xpos,x
	sec
	sbc.w $0830
	cmp.w #$FFD7
	bmi CODE_C4348D
	cmp.w #$0029
	bpl CODE_C4348D
	lda.w $09C1,x
	sec
	sbc.w $09DD
	and.w #$00FF
	bit.w #$0080
	beq CODE_C43465
	ora.w #$FF00
CODE_C43465:						; from CODE_C43441
	clc
	adc.w Ypos,x
	sec
	sbc.w pucky
	cmp.w #$FFD7
	bmi CODE_C4348D
	cmp.w #$0029
	bpl CODE_C4348D
	lda.w Xpos,x
	sec
	sbc.w $0830
	sta.b d0
	lda.w Ypos,x
	sec
	sbc.w pucky
	sta.b d1
	jml.l vtoa
CODE_C4348D:						; from EvadePC, CODE_C43441, CODE_C43465
	rtl
asswingd:							; called from other segments
	ldy.w puckc
	bmi CODE_C434A7
	lda.w pfteam,x
	cmp.w pfteam,y
	bne CODE_C434A7
	lda.w #$0004
	sta.b d0
	jmp.w assreplace
CODE_C434A3:						; from CODE_C434A7
	rtl
CODE_C434A4:						; from CODE_C434A7
	jmp.w donothing
CODE_C434A7:						; from asswingd
	lda.w gmclock
	bne CODE_C434A4
	jsl.l check4bench
	lda.w playerpad,x
	bpl CODE_C434A3
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C434CF
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
CODE_C434CF:						; from CODE_C434A7
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl CODE_C434E6
	clc
	adc.w aidef,x
	bpl CODE_C434E3
	lda.w #$0000
CODE_C434E3:						; from CODE_C434CF
	sta.w temp1,x
CODE_C434E6:						; from CODE_C434CF
	lda.w #$0064
	sta.b d0
	lda.w position,x
	cmp.w #$0005
	bne CODE_C434F8
	lda.w #$FF9C
	sta.b d0
CODE_C434F8:						; from CODE_C434E6
	ldy.w puckc
	lda.w pfgoal,x
	beq CODE_C4353E
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$FF5E
	sta.b d1
	lda.w #$FFAE
	sta.b d2
	lda.w position,y
	beq CODE_C43571
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne CODE_C43571
	lda.b d2
	sec
	sbc.w pucky
	bpl CODE_C43531
	lda.w pucky
	sta.b d1
	bra CODE_C43575
DATA8_C43530:						; an rtl no traced code reaches
	db $6B
CODE_C43531:						; from CODE_C434F8
	lda.w #$FEF2
	sta.b d2
	sec
	sbc.w pucky
	bmi CODE_C43575
	bra CODE_C43571
CODE_C4353E:						; from CODE_C434F8
	lda.w #$00A2
	sta.b d1
	lda.w #$0052
	sta.b d2
	lda.w position,y
	beq CODE_C43571
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne CODE_C43571
	lda.b d2
	sec
	sbc.w pucky
	bmi CODE_C43566
	lda.w pucky
	sta.b d1
	bra CODE_C43575
CODE_C43566:						; from CODE_C4353E
	lda.w #$010E
	sta.b d2
	sec
	sbc.w pucky
	bpl CODE_C43575
CODE_C43571:						; from CODE_C434F8, CODE_C4353E, CODE_C43531
	lda.b d2
	sta.b d1
CODE_C43575:						; from CODE_C434F8, CODE_C4353E, CODE_C43531, CODE_C43566
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b a0
	lda.w $0830
	eor.b d0
	sta.b d2
	bmi CODE_C4358D
	lda.w $0830
	sta.b d0
CODE_C4358D:						; from CODE_C43575
	jmp.w skateto
asswingo:							; called from other segments
	cpx.w puckc
	beq CODE_C435AE
	ldy.w puckc
	bmi CODE_C435B6
	lda.w pfteam,x
	cmp.w pfteam,y
	beq CODE_C435B6
	lda.w #$0003
	sta.b d0
	jmp.w assreplace
CODE_C435AA:						; from CODE_C435B6
	rtl
CODE_C435AB:						; from CODE_C435B6
	jmp.w donothing
CODE_C435AE:						; from asswingo
	lda.w #$0011
	sta.b d0
	jmp.w CODE_C43734
CODE_C435B6:						; from asswingo
	lda.w gmclock
	bne CODE_C435AB
	jsl.l check4bench
	lda.w playerpad,x
	bpl CODE_C435AA
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C435E4
	and.w #$FFFD
	sta.w pflags,x
	lda.w #$FFFF
	sta.w temp5,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
CODE_C435E4:						; from CODE_C435B6
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bmi CODE_C435F2
	jmp.w CODE_C4369F
CODE_C435F2:						; from CODE_C435E4
	clc
	adc.w aidef,x
	bpl CODE_C435FB
	lda.w #$0000
CODE_C435FB:						; from CODE_C435F2
	sta.w temp1,x
	lda.w pucky
	sta.b d0
	lda.w puckvy
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0200
	beq CODE_C43614
	ora.w #$FC00
CODE_C43614:						; from CODE_C435FB
	clc
	adc.b d0
	sta.b d3
	lda.w pfgoal,x
	bne CODE_C4362E
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d3
	sta.b d3
CODE_C4362E:						; from CODE_C43614
	stz.b d2
	lda.b d3
	sec
	sbc.w #$FFA4
	bmi CODE_C4365E
	lda.w #$0008
	sta.b d2
	lda.b d0
	sec
	sbc.w #$005C
	bmi CODE_C4365E
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne CODE_C4365E
	asl.b d2
	lda.b d3
	sec
	sbc.w #$010E
	bmi CODE_C4365E
	lda.w #$0018
	sta.b d2
CODE_C4365E:						; from CODE_C4362E
	lda.b d2
	cmp.w temp5,x
	bne CODE_C4366D
	lda.w seed
	cmp.w #$0200
	bcs CODE_C4369F
CODE_C4366D:						; from CODE_C4365E
	lda.b d2
	sta.w temp5,x
	tay
	lda.w #DATA8_C436DD>>16
	sta.b $65
	lda.w #DATA8_C436DD
	sta.b a0
	iny
	iny
	lda.b [a0],y
	dey
	dey
	jsl.l randomd0s
	adc.b [a0],y
	sta.w temp3,x
	tya
	clc
	adc.w #$0006
	tay
	lda.b [a0],y
	dey
	dey
	jsl.l randomd0s
	adc.b [a0],y
	sta.w temp4,x
CODE_C4369F:						; from CODE_C435E4, CODE_C4365E
	lda.w temp3,x
	sta.b d0
	lda.w position,x
	cmp.w #$0005
	beq CODE_C436B4
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
CODE_C436B4:						; from CODE_C4369F
	lda.w temp4,x
	sta.b d1
	lda.w pfgoal,x
	bne CODE_C436CE
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
CODE_C436CE:						; from CODE_C436B4
	lda.w #EvadePC>>16
	sta.b $65
	lda.w #EvadePC
	sta.b a0
	jml.l skateto
DATA8_C436DC:						; an rtl no traced code reaches
	db $6B
DATA8_C436DD:						; not traced: a table read by CODE_C4366D
	db $50,$00,$14,$00,$BA,$FF,$0A,$00,$64,$00,$14,$00,$3C,$00,$0A,$00
	db $3C,$00,$32,$00,$E6,$00,$14,$00,$50,$00,$1E,$00,$FA,$00,$14,$00
donothing:							; from CODE_C43350, CODE_C43154, CODE_C434A4, ...
	lda.w playerpad,x
	bpl CODE_C4370B
	lda.w #$0008
	sta.b d0
	jml.l doplayeracc
CODE_C4370B:						; from donothing
	rtl
assexit:							; from CODE_C43769, CODE_C437F7 and other segments
	lda.w assnum,x
	inc a
	and.w #$0007
	sta.w assnum,x
	phx
	phy
	txa
	asl a
	asl a
	adc.w assnum,x
	tay
	lda.w $0A60,y
	and.w #$00FF
	ply
	plx
	sta.w asscur,x
	lda.w pflags,x
	ora.w #$0002
	sta.w pflags,x
	rtl
CODE_C43734:						; from CODE_C43348, CODE_C435AE, CODE_C43A96 and other segments
	lda.w assnum,x
	dec a
	and.w #$0007
	sta.w assnum,x
assreplace:							; from assdefd, assdefo, asswingd, ...
	lda.w pflags,x
	ora.w #$0002
	sta.w pflags,x
	txa
	asl a
	asl a
	adc.w assnum,x
	tay
	sep #$20
	lda.b d0
	sta.w $0A60,y
	rep #$30
	sta.w asscur,x
	rtl
CODE_C4375B:						; called from other segments
	lda.w pfalock,x
	bne CODE_C43768
	lda.w sflags
	bit.w #$0100
	beq CODE_C43769
CODE_C43768:						; from CODE_C4375B
	rtl
CODE_C43769:						; from CODE_C4375B
	stz.w $18AA
	jmp.w assexit
CODE_C4376F:						; called from other segments
	lda.w pfalock,x
	beq CODE_C43777
	jmp.w CODE_C43825
CODE_C43777:						; from CODE_C4376F
	lda.w sflags
	bit.w #$0100
	beq CODE_C437F7
	lda.w pflags,x
	bit.w #$0002
	beq CODE_C43790
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
CODE_C43790:						; from CODE_C43777
	lda.w #$007E
	sta.b $65
	lda.w #$2028
	sta.b a0
	lda.w pfteam,x
	beq CODE_C437A4
	lda.w #$202C
	sta.b a0
CODE_C437A4:						; from CODE_C43790
	lda.w SPAnum,x
	lsr a
	lsr a
	inc a
	sta.b d0
	lda.w $0FC0,x
	bne CODE_C437B7
	inc.b d0
	inc.b d0
	inc.b d0
CODE_C437B7:						; from CODE_C437A4
	lda.b d0
	sta.b [a0]
	lda.w playerpad,x
	bpl CODE_C43825
	lda.w pf2aip,x
	pha
	lda.w #$0001
	sta.w pf2aip,x
	pla
	cmp.w #$0000
	bne CODE_C43825
	lda.w #$24FA
	sta.b d1
	lda.w $0AFC
	cmp.w #$0011
	bcc CODE_C43803
	jsl.l RandomWord
	and.w #$0007
	sta.b d0
	beq CODE_C43803
	lda.w #$2524
	sta.b d1
	lda.w #$0001
	sta.w pf2aip,x
	jml.l SetSPA
CODE_C437F7:						; from CODE_C43777
	stz.w $18AA
	lda.w #$0014
	sta.w nopuck,x
	jmp.w assexit
CODE_C43803:						; from CODE_C437B7
	lda.w pfgoal,x
	lsr a
	ldx.w $2022
	bcc CODE_C4380F
	ldx.w $2020
CODE_C4380F:						; from CODE_C43803
	lda.w $1864
	cmp.w #$0001
	beq CODE_C43819
	stz.b r1,x
CODE_C43819:						; from CODE_C4380F
	ldx.b a3
	lda.w #$0001
	sta.w pf2aip,x
	jml.l SetSPA
CODE_C43825:						; from CODE_C4376F, CODE_C437B7
	rtl
CODE_C43826:						; called from other segments
	lda.w pflags,x
	bit.w #$0002
	bne CODE_C43831
	jmp.w CODE_C43EC6
CODE_C43831:						; from CODE_C43826
	and.w #$FFFD
	sta.w pflags,x
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
	pei ($9B)
	pei ($9D)
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
	pei ($77)
	pei ($79)
	pei ($7B)
	pei ($7D)
	lda.w #$0006
	jsl.l CODE_CF040B
	jsl.l CODE_CF038E
	lda.w #$FFFF
	sta.w recsfx
	sta.w recsfx2
	stz.w $2346
	lda.l $7E24CA
	cmp.w #$0258
	bcc CODE_C4389A
	lda.w #$0258
	sta.l $7E24CA
CODE_C4389A:						; from CODE_C43831
	jsl.l FadeOutWait
	lda.w #$001E
	sta.w fadestep
	jsl.l CODE_C4CEDB
	jsl.l CODE_C539D7
	lda.w PBnum
	beq CODE_C438D5
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b r3
	lda.w PBnum
	and.w #$000F
	cmp.b r3
	beq CODE_C438D5
	bcs CODE_C438CC
	lda.w #$0004
	jsl.l CODE_CF048A
	bra CODE_C438FD
CODE_C438CC:						; from CODE_C4389A
	lda.w #$0001
	jsl.l CODE_CF048A
	bra CODE_C438FD
CODE_C438D5:						; from CODE_C4389A
	ldy.w $078A
	bne CODE_C438EB
	lda.w $1864
	cmp.w #$0004
	beq CODE_C438FD
	jsl.l RandomWord
	and.w #$0003
	bne CODE_C438FD
CODE_C438EB:						; from CODE_C438D5
	lda.w #$0000
	ldy.w $078A
	bne CODE_C438F6
	lda.w #$0002
CODE_C438F6:						; from CODE_C438EB
	jsl.l CODE_CF048A
	stz.w $078A
CODE_C438FD:						; from CODE_C4389A, CODE_C438D5, CODE_C438CC
	lda.w #$000D
	trb.w sflags
	lda.w #$0001
	trb.w sflags3
	stz.w iflags
	stz.w replaydelay
	lda.w #$FFFF
	sta.w $1145
	sta.w $07DA
	sta.w $07DE
	sta.w puckz
	sta.w passReceiverPlayerNum
	asl a
	sta.w puckc
	lda.w #$8200
	trb.w sflags
	stz.w $2348
	stz.w $234A
	lda.w #$0500
	tsb.w sflags
	jsl.l CODE_C52264
	lda.w #$0008
	tsb.w tmflags
	tsb.w $1301
	jsl.l CODE_C54BAF
	lda.w #$0008
	trb.w tmflags
	trb.w $1301
	stz.b $CD
	stz.b $CB
	lda.w $2034
	sta.w $0830
	lda.w $2036
	sta.w pucky
	stz.w puckvx
	stz.w puckvy
	stz.w puckvz
	stz.w $09B8
	stz.w $09D8
	stz.w $082C
	lda.w #$0117
	sta.w $08AE
	stz.w $09BA
	stz.w $09DA
	stz.w $082E
	lda.w #$FEE8
	sta.w $08B0
	lda.w #$01B3
	sta.w $0874
	stz.w $0C9E
	stz.w $08FE
	stz.w $08FC
	lda.w #$0040
	trb.w sflags
	lda.w #$0064
	sta.b d4
CODE_C439A2:						; from CODE_C439A2
	jsl.l checkwindow
	dec.b d4
	bpl CODE_C439A2
	lda.w #$003C
	sta.w yleader
	lda.w $1864
	cmp.w #$0001
	bne CODE_C439C6
	lda.w $1906
	inc a
	sta.w tmap
	lda.w $1908
	inc a
	sta.w $12C9
CODE_C439C6:						; from CODE_C439A2
	jsl.l ResetBench
	stz.b a2
	jsl.l setpersonel
	jsl.l CODE_C53B51
	inc.b a2
	inc.b a2
	jsl.l setpersonel
	jsl.l CODE_C53B51
	jsl.l CODE_C53F8D
	lda.w #$FFFF
	sta.w tmtouch2
	sta.w tmtouch3
	sta.w $12C1
	sta.w $12C5
	pei ($71)
	pei ($6F)
	stz.b a3
	lda.w #$000B
	sta.b d2
	pha
CODE_C439FF:						; from CODE_C43BB7
	ldx.b a3
	cpx.w #$0018
	bcs CODE_C43A17
	lda.w pfteam,x
	lsr a
	eor.w gmode
	and.w #$0002
	lsr a
	eor.w #$0001
	sta.w pfgoal,x
CODE_C43A17:						; from CODE_C439FF
	lda.w pnum,x
	asl a
	cpx.w #$000C
	bcc CODE_C43A24
	clc
	adc.w #$0034
CODE_C43A24:						; from CODE_C43A17
	tax
	lda.w tmpdst,x
	bmi CODE_C43A32
	bit.w #$1000
	bne CODE_C43A32
	jmp.w CODE_C43BB7
CODE_C43A32:						; from CODE_C43A24
	ldx.b a3
	lda.w #$FF10
	sta.w Xpos,x
	stz.w Ypos,x
	lda.w #$0001
	sta.w frame,x
	lda.w position,x
	sta.b d1
	bpl CODE_C43A4D
	jmp.w CODE_C43BB7
CODE_C43A4D:						; from CODE_C43A32
	beq CODE_C43A9A
	lda.w penshot
	beq CODE_C43A69
	phx
	ldx.w #$0008
	lda.w BA_Team
	beq CODE_C43A60
	ldx.w #$0014
CODE_C43A60:						; from CODE_C43A4D
	lda.w $18B2
	sta.w pnum,x
	sta.b d3
	plx
CODE_C43A69:						; from CODE_C43A4D
	lda.w #$0016
	sta.b d0
	lda.b d1
	cmp.w #$0004
	bne CODE_C43A96
	stz.b a2
	lda.w pfteam,x
	beq CODE_C43A80
	inc.b a2
	inc.b a2
CODE_C43A80:						; from CODE_C43A69
	ldy.b a2
	lda.w pnum,x
	and.w #$00FF
	sta.w tmtouch1,y
	lda.w #$0004
	sta.w tmflags,y
	lda.w #$0017
	sta.b d0
CODE_C43A96:						; from CODE_C43A69
	jsl.l CODE_C43734
CODE_C43A9A:						; from CODE_C43A4D
	lda.w tmap
	sta.b d4
	ldx.b a3
	lda.w pfteam,x
	beq CODE_C43AAB
	lda.w $12C9
	sta.b d4
CODE_C43AAB:						; from CODE_C43A9A
	lda.b d4
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0006
	asl a
	asl a
	asl a
	sta.b d4
	lda.w $1864
	cmp.w #$0001
	bne CODE_C43AC4
	stz.b d4
CODE_C43AC4:						; from CODE_C43AAB
	lda.w #$00C5
	sta.b $69
	lda.w #$195D
	clc
	adc.b d4
	sta.b a1
	lda.w penshot
	beq CODE_C43AE0
	lda.w #$00C5
	sta.b $69
	lda.w #$1975
	sta.b a1
CODE_C43AE0:						; from CODE_C43AC4
	ldy.b d1
	lda.b [a1],y
	and.w #$00FF
	asl a
	asl a
	sta.b d4
	lda.w #$00C5
	sta.b $69
	lda.w #$197D
	sta.b a1
	ldy.b d4
	lda.b [a1],y
	sta.b d0
	iny
	iny
	lda.b [a1],y
	sta.b d1
	lda.w pfgoal,x
	bne CODE_C43B16
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
CODE_C43B16:						; from CODE_C43AE0
	lda.w position,x
	beq CODE_C43B66
	lda.b d4
	cmp.w #$0009
	bpl CODE_C43B56
	lda.w $2034
	eor.b d0
	bpl CODE_C43B40
	lda.w $2036
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq CODE_C43B37
	ora.w #$E000
CODE_C43B37:						; from CODE_C43B16
	eor.w #$FFFF
	inc a
	clc
	adc.b d1
	sta.b d1
CODE_C43B40:						; from CODE_C43B16
	lda.w $2034
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C43B4D
	ora.w #$C000
CODE_C43B4D:						; from CODE_C43B40
	sta.b d3
	lda.b d0
	sec
	sbc.b d3
	sta.b d0
CODE_C43B56:						; from CODE_C43B16
	lda.b d0
	clc
	adc.w $2034
	sta.b d0
	lda.b d1
	clc
	adc.w $2036
	sta.b d1
CODE_C43B66:						; from CODE_C43B16
	lda.b d0
	sta.w Xpos,x
	sec
	sbc.w $0830
	eor.w #$FFFF
	inc a
	sta.b d0
	lda.b d1
	sta.w Ypos,x
	sec
	sbc.w pucky
	eor.w #$FFFF
	inc a
	sta.b d1
	stz.w Xvel,x
	stz.w Yvel,x
	jsl.l vtoa
	lda.b d0
	sta.w facedir,x
	lda.w pflags,x
	and.w #$EFFF
	sta.w pflags,x
	stz.w pfalock,x
	stz.w SPA,x
	lda.w position,x
	bne CODE_C43BAC
	lda.w #$121E
	bra CODE_C43BAF
CODE_C43BAC:						; from CODE_C43B66
	lda.w #$1958
CODE_C43BAF:						; from CODE_C43B66
	jsl.l SetSPAFromA
	jsl.l updateanim
CODE_C43BB7:						; from CODE_C43A24, CODE_C43A32
	inc.b a3
	inc.b a3
	pla
	dec a
	sta.b d2
	bmi CODE_C43BC5
	pha
	jmp.w CODE_C439FF
CODE_C43BC5:						; from CODE_C43BB7
	jsl.l SprSort
	pla
	sta.b a3
	pla
	sta.b $71
	lda.w penshot
	beq CODE_C43C34
	ldx.w #$0008
CODE_C43BD7:						; from CODE_C43BED
	lda.w $1525,x
	cmp.w BA_Team
	bne CODE_C43BED
	cpx.w $18B6
	beq CODE_C43BED
	ora.w #$8000
	sta.w $1525,x
	stz.w cont1team,x
CODE_C43BED:						; from CODE_C43BD7
	dex
	dex
	bpl CODE_C43BD7
	lda.w BA_Team
	eor.w #$0002
	sta.b d0
	tax
	lda.w teampads,x
	beq CODE_C43C34
	ldy.w $05C4,x
CODE_C43C02:						; from CODE_C43C0C
	iny
	iny
	cpy.w #$000A
	bne CODE_C43C0C
	ldy.w #$0000
CODE_C43C0C:						; from CODE_C43C02
	lda.w $1525,y
	cmp.b d0
	bne CODE_C43C02
	sty.b d1
	tya
	sta.w $05C4,x
	ldx.w #$0008
CODE_C43C1C:						; from CODE_C43C30
	lda.w $1525,x
	cmp.b d0
	bne CODE_C43C30
	cpx.b d1
	beq CODE_C43C30
	ora.w #$8000
	sta.w $1525,x
	stz.w cont1team,x
CODE_C43C30:						; from CODE_C43C1C
	dex
	dex
	bpl CODE_C43C1C
CODE_C43C34:						; from CODE_C43BC5, CODE_C43BED
	ldx.b a3
	jsl.l CODE_C53651
	phx
	phy
	jsl.l CODE_C58944
	inc.w TransfersReady
	ldy.w #$0036
	lda.w $2034
	bpl CODE_C43C4E
	ldy.w #$00BE
CODE_C43C4E:						; from CODE_C43C34
	sty.b d0
	tya
	sta.w $201C
	sec
	sbc.w #$002E
	lsr a
	lsr a
	lsr a
	clc
	adc.w #$5860
	sta.w $2026
	lda.w #$005C
	sta.w $201E
	jsl.l SeatPenaltyBox
	lda.w penshot
	beq CODE_C43C74
	jmp.w CODE_C43F0D
CODE_C43C74:						; from CODE_C43C4E
	lda.w $1864
	cmp.w #$0001
	bne CODE_C43C7F
	jmp.w CODE_C43FC1
CODE_C43C7F:						; from CODE_C43C74
	lda.w #$0001
	sta.w $2016
	jsl.l CODE_C4CEDB
	jsl.l CODE_C4C536
	lda.w #$0A00
	jsl.l CODE_C4C558
	sta.w $2024
	sta.b r1
	jsl.l CODE_C4C541
	lda.w #$007E
	sta.b $32
	lda.w #$CFE2
	ldx.w #$00C1
	jsl.l CODE_C5881C
	lda.w $2024
	tax
	ldy.w #$04FF
	clc
CODE_C43CB4:						; from CODE_C43CB4
	lda.l $7E0000,x
	adc.w #$3E32
	sta.l $7E0000,x
	inx
	inx
	dey
	bpl CODE_C43CB4
	lda.w #$0000
	sta.w $2014
	jsl.l CODE_C52008
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $09C0
	pea.w $4320
	pea.w $007E
	clc
	lda.w $2024
	adc.w #$0A00
	pha
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0070
	pea.w $007E
	adc.w #$09C0
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l CODE_C4CEDB
	lda.w $201E
	clc
	adc.w #$0005
	sta.b $1A
	lda.w $201C
	sec
	sbc.w #$002B
	sta.b $18
	lda.w #$001E
	jsl.l CreateSpriteSharePal
	stx.w $2020
	clc
	lda.b $18
	adc.w #$0059
	sta.b $18
	lda.w gsp
	lsr a
	lda.w $17CD
	bcc CODE_C43D3A
	lda.w $17CF
CODE_C43D3A:						; from CODE_C43CB4
	jsl.l CODE_C5EE6C
	lda.w #$001E
	jsl.l CreateSpriteSharePal
	stx.w $2022
	lda.b $36,x
	eor.w #$4000
	sta.b $36,x
	inc.b p0,x
	lda.w #$0001
	jsl.l CODE_C5ECBD
	lda.w gsp
	lsr a
	lda.w $17CF
	bcc CODE_C43D64
	lda.w $17CD
CODE_C43D64:						; from CODE_C43D3A
	jsl.l CODE_C5EE6C
	jsl.l CODE_C53A29
CODE_C43D6C:						; from CODE_C43F55, CODE_C43FC1
	ply
	plx
	ldx.b a3
	lda.w $186E
	beq CODE_C43D7D
	lda.w penshot
	ora.w $18C0
	beq CODE_C43D80
CODE_C43D7D:						; from CODE_C43D6C
	jmp.w CODE_C43E01
CODE_C43D80:						; from CODE_C43D6C
	lda.w #$59A1
	ldx.w $2034
	bpl CODE_C43D8B
	lda.w #$59B2
CODE_C43D8B:						; from CODE_C43D80
	pha
	ldx.w #$000C
	ldy.w #$0002
	jsl.l CODE_C58C36
	ldx.w tmline
	ldy.w $12B9
	lda.w gmode
	bit.w #$0002
	beq CODE_C43DA8
	txy
	ldx.w $12B9
CODE_C43DA8:						; from CODE_C43D8B
	stx.b d0
	sty.b d1
	lda.w #$000B
	jsl.l CODE_C4C558
	tay
	jsl.l CODE_C4C541
	lda.w #$000A
	sta.w $0000,y
	lda.b d0
	asl a
	adc.b d0
	tax
	lda.l DATA8_C09B3F,x
	sta.w $0001,y
	lda.l $C09B40,x
	sta.w $0002,y
	lda.w #$A0A0
	sta.w $0004,y
	lda.w #$A0A0
	sta.w QueueBusy,y
	lda.b d1
	asl a
	adc.b d1
	tax
	lda.l DATA8_C09B3F,x
	sta.w $0008,y
	lda.l $C09B40,x
	sta.w $0009,y
	pla
	clc
	adc.w #$0021
	tax
	tya
	txy
	ldx.w #$007E
	jsl.l QueueVRAMDMALen
CODE_C43E01:						; from CODE_C43D7D
	jsl.l RandomWord
	and.w #$007F
	adc.w #$00B4
	sta.b d0
	ldx.b a3
	sta.w temp1,x
	lda.w $1864
	cmp.w #$0001
	bne CODE_C43E20
	lda.w #$003C
	sta.w temp1,x
CODE_C43E20:						; from CODE_C43E01
	lda.w penshot
	beq CODE_C43E2B
	lda.w #$00B4
	sta.w temp1,x
CODE_C43E2B:						; from CODE_C43E20
	lda.w #$0001
	sta.w $2028
	lda.w #$8000
	sta.w $202A
	sta.w $2032
	lda.w #$0004
	sta.w $202C
	lda.w #$A800
	sta.w $202E
	lda.w #$0007
	sta.w $2030
	lda.w gmode
	bit.w #$0002
	bne CODE_C43E60
	lda.w #$8800
	sta.w $202A
	lda.w #$A000
	sta.w $202E
CODE_C43E60:						; from CODE_C43E2B
	lda.w #$FFFF
	sta.w $2018
	sta.w $201A
	pla
	sta.b $7D
	pla
	sta.b $7B
	pla
	sta.b $79
	pla
	sta.b $77
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
	sta.b $9D
	pla
	sta.b d7
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
	ldx.b a3
	rtl
CODE_C43EC6:						; from CODE_C43826
	lda.b d7
	sta.b tmp0
	cmp.w temp1,x
	bmi CODE_C43ED4
	lda.w #$0001
	sta.b tmp0
CODE_C43ED4:						; from CODE_C43EC6
	lda.w temp1,x
	sec
	sbc.b tmp0
	sta.w temp1,x
	bmi CODE_C43EE3
	jml.l CODE_C51999
CODE_C43EE3:						; from CODE_C43ED4
	lda.w $1864
	cmp.w #$0001
	bne CODE_C43EF3
	jsl.l CODE_C51AFF
	jml.l CODE_C51A13
CODE_C43EF3:						; from CODE_C43EE3
	lda.w penshot
	beq CODE_C43F00
	jsl.l CODE_C51AFF
	jml.l CODE_C51A61
CODE_C43F00:						; from CODE_C43EF3
	stz.w PenShotActive
	lda.w #$FFFF
	sta.w BA_Sktr_SCnum
	jml.l CODE_C51AFF
CODE_C43F0D:						; from CODE_C43C4E
	jsl.l CODE_C4CEDB
	ldx.w #$0014
	ldy.w #$0008
	lda.w #$5846
	jsl.l CODE_C58C36
	ldx.w #$2DC9
	ldy.w BA_Team
	beq CODE_C43F29
	ldx.w #$3207
CODE_C43F29:						; from CODE_C43F0D
	lda.w $18B2
	jsl.l CODE_C533EF
	jsr.w CODE_C43FAD
	adc.w #$58A6
	tay
	lda.b r0
	jsl.l QueueVRAMDMALen
	ldy.w #$58EF
	ldx.w #$00C3
	lda.w #$5F13
	jsl.l QueueVRAMDMALen
	ldx.w #$3207
	ldy.w BA_Team
	beq CODE_C43F55
	ldx.w #$2DC9
CODE_C43F55:						; from CODE_C43F29
	tya
	eor.w #$0002
	tay
	lda.w tmgoalie,y
	jsl.l CODE_C533EF
	jsr.w CODE_C43FAD
	adc.w #$5926
	tay
	lda.b r0
	jsl.l QueueVRAMDMALen
	ldy.w #$5867
	lda.w #$5F40
	ldx.w #$00C3
	jsl.l QueueVRAMDMALen
	ldx.w #$000A
	ldy.w #$0003
	lda.w #$5AE0
	jsl.l CODE_C58C36
	lda.w #$5F4A
	ldx.w #$00C3
	ldy.w #$5B01
	jsl.l QueueVRAMDMALen
	lda.w #$001E
	sta.b d0
	jsl.l CODE_C516C2
	ldx.w #$007E
	lda.b a1
	ldy.w #$5B23
	jsl.l QueueVRAMDMALen
	jmp.w CODE_C43D6C
CODE_C43FAD:						; from CODE_C43F29, CODE_C43F55
	sta.b r0
	stx.b $2E
	lda.b [r0]
	and.w #$00FF
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0014
	lsr a
	clc
	rts
CODE_C43FC1:						; from CODE_C43C74
	jsl.l CODE_C53A29
	jmp.w CODE_C43D6C

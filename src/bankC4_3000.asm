; Segment bankC4_3000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4313E
CODE_C4313E:						; called from other segments
	ldy.w $05A0
	bmi CODE_C43157
	lda.w $1020,x
	cmp.w $1020,y
	bne CODE_C43157
	lda.w #$0001
	sta.b $7F
	jmp.w CODE_C4373E
CODE_C43153:						; from CODE_C43157
	rtl
CODE_C43154:						; from CODE_C43157
	jmp.w CODE_C436FD
CODE_C43157:						; from CODE_C4313E
	lda.w $10F3
	bne CODE_C43154
	jsl.l CODE_C549A8
	lda.w $14F9,x
	bpl CODE_C43153
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C4317F
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $0AE0,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
CODE_C4317F:						; from CODE_C43157
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bmi CODE_C4318D
	jmp.w CODE_C4330F
CODE_C4318D:						; from CODE_C4317F
	clc
	adc.w $0E60,x
	bpl CODE_C43196
	lda.w #$0000
CODE_C43196:						; from CODE_C4318D
	sta.w $0AE0,x
	lda.w $08B2
	sta.b $83
	lda.w $09DC
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
	sta.b $8B
	lda.w $0FE0,x
	bne CODE_C431C6
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
	lda.w #$0000
	sec
	sbc.b $8B
	sta.b $8B
CODE_C431C6:						; from CODE_C431AF
	lda.b $8B
	bpl CODE_C431CC
	stz.b $8B
CODE_C431CC:						; from CODE_C431C6
	lda.b $8B
	clc
	adc.b $83
	sta.b $8B
	sec
	sbc.w #$005C
	bmi CODE_C43207
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0010
	bne CODE_C43207
	lda.w $05A0
	bmi CODE_C431E9
	lsr a
CODE_C431E9:						; from CODE_C431CC
	sta.b $83
	bmi CODE_C43207
	jsl.l CODE_C42D98
	beq CODE_C43207
	lda.b $83
	sec
	sbc.w #$0006
	sta.b $83
	txa
	lsr a
	sec
	sbc.w #$0006
	sta.b $87
	eor.b $83
	sta.b $83
CODE_C43207:						; from CODE_C431CC, CODE_C431E9
	lda.w #$0041
	sta.w $0B20,x
	lda.w $0A20,x
	cmp.w #$0002
	beq CODE_C4321B
	lda.w #$FFBF
	sta.w $0B20,x
CODE_C4321B:						; from CODE_C43207
	ldy.w #$0000
	cpx.w #$000C
	bcs CODE_C43226
	ldy.w #$000C
CODE_C43226:						; from CODE_C4321B
	lda.w #$0006
	sta.b $87
	lda.w #$FC18
	sta.b $7F
	lda.w $0FE0,x
	beq CODE_C432A1
	lda.w #$03E8
	sta.b $7F
CODE_C4323A:						; from CODE_C4326D
	sty.b $63
	lda.w $0D60,y
	bit.w #$1000
	bne CODE_C4326D
	lda.w $0A20,y
	bmi CODE_C4326D
	lda.w $09C0,y
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
	adc.w $0896,y
	sta.b $83
	sec
	sbc.b $7F
	bpl CODE_C4326D
	lda.b $83
	sta.b $7F
CODE_C4326D:						; from CODE_C4323A, CODE_C4325E
	ldy.b $63
	iny
	iny
	dec.b $87
	bne CODE_C4323A
	lda.b $7F
	sec
	sbc.w #$0028
	sta.b $7F
	sec
	sbc.w #$FF42
	bpl CODE_C43288
	lda.w #$FF24
	sta.b $7F
CODE_C43288:						; from CODE_C4326D
	lda.b $7F
	sta.w $0B40,x
	lda.w $0830
	sta.b $7F
	lda.w $0B20,x
	eor.b $7F
	sta.b $83
	bpl CODE_C4330F
	stz.w $0B20,x
	bra CODE_C4330F
DATA8_C432A0:						; an rtl no traced code reaches
	db $6B
CODE_C432A1:						; from CODE_C43226, CODE_C432D4
	sty.b $63
	lda.w $0D60,y
	bit.w #$1000
	bne CODE_C432D4
	lda.w $0A20,y
	bmi CODE_C432D4
	lda.w $09C0,y
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
	adc.w $0896,y
	sta.b $83
	sec
	sbc.b $7F
	bmi CODE_C432D4
	lda.b $83
	sta.b $7F
CODE_C432D4:						; from CODE_C432A1, CODE_C432C5
	ldy.b $63
	iny
	iny
	dec.b $87
	bne CODE_C432A1
	lda.b $7F
	clc
	adc.w #$0028
	sta.b $7F
	sec
	sbc.w #$00BE
	bmi CODE_C432EF
	lda.w #$00DC
	sta.b $7F
CODE_C432EF:						; from CODE_C432D4
	lda.b $7F
	sta.w $0B40,x
	lda.w #$0000
	sec
	sbc.w $0B20,x
	sta.w $0B20,x
	lda.w $0830
	sta.b $7F
	lda.w $0B20,x
	eor.b $7F
	sta.b $83
	bpl CODE_C4330F
	stz.w $0B20,x
CODE_C4330F:						; from CODE_C4317F, CODE_C43288, CODE_C432EF
	lda.w $0B20,x
	sta.b $7F
	lda.w $0B40,x
	sta.b $83
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b $63
	jsl.l CODE_C45950
	jmp.w CODE_C45529
CODE_C4332A:						; called from other segments
	cpx.w $05A0
	beq CODE_C43348
	ldy.w $05A0
	bmi CODE_C43350
	lda.w $1020,x
	cmp.w $1020,y
	beq CODE_C43350
	lda.w #$0002
	sta.b $7F
	jmp.w CODE_C4373E
CODE_C43344:						; from CODE_C43358
	rtl
DATA8_C43345:						; not traced: data between routines
	db $4C,$FD,$36
CODE_C43348:						; from CODE_C4332A
	lda.w #$0011
	sta.b $7F
	jmp.w CODE_C43734
CODE_C43350:						; from CODE_C4332A
	lda.w $10F3
	beq CODE_C43358
	jmp.w CODE_C436FD
CODE_C43358:						; from CODE_C43350
	jsl.l CODE_C549A8
	lda.w $14F9,x
	bpl CODE_C43344
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C4337B
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $0AE0,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
CODE_C4337B:						; from CODE_C43358
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bpl CODE_C43392
	clc
	adc.w $0E40,x
	bpl CODE_C4338F
	lda.w #$0000
CODE_C4338F:						; from CODE_C4337B
	sta.w $0AE0,x
CODE_C43392:						; from CODE_C4337B
	lda.w #CODE_C4342A>>16
	sta.b $65
	lda.w #CODE_C4342A
	sta.b $63
	ldy.w #$0050
	lda.w $0A20,x
	cmp.w #$0002
	beq CODE_C433AA
	ldy.w #$FFB0
CODE_C433AA:						; from CODE_C43392
	lda.w $0FE0,x
	bne CODE_C433B5
	tya
	eor.w #$FFFF
	inc a
	tay
CODE_C433B5:						; from CODE_C433AA
	sty.b $7F
	lda.w $0830
	eor.b $7F
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
	adc.b $7F
CODE_C433CE:						; from CODE_C433B5
	sta.b $7F
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0010
	bne CODE_C4341B
	lda.w $08B2
	sta.b $87
	lda.w $0FE0,x
	bne CODE_C433EC
	lda.w #$0000
	sec
	sbc.b $87
	sta.b $87
CODE_C433EC:						; from CODE_C433CE
	lda.b $87
	cmp.w #$FFA4
	bmi CODE_C43406
	cmp.w #$005C
	bmi CODE_C433FF
	lda.w #$0066
	sta.b $83
	bra CODE_C4340B
CODE_C433FF:						; from CODE_C433EC
	lda.w #$FFAE
	sta.b $83
	bra CODE_C4340B
CODE_C43406:						; from CODE_C433EC
	lda.w #$FF24
	sta.b $83
CODE_C4340B:						; from CODE_C433EC, CODE_C433FF
	lda.w $0FE0,x
	bne CODE_C43418
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
CODE_C43418:						; from CODE_C43426, CODE_C4340B
	jmp.w CODE_C45950
CODE_C4341B:						; from CODE_C433CE
	ldy.w #$0066
	lda.w $0FE0,x
	beq CODE_C43426
	ldy.w #$FF9A
CODE_C43426:						; from CODE_C4341B
	sty.b $83
	bra CODE_C43418
CODE_C4342A:						; passed as a long pointer (lda #bank, lda #low) to CODE_C45950
	lda.w $05A0
	bmi CODE_C4348D
	lda.w $09A1,x
	sec
	sbc.w $09BD
	and.w #$00FF
	bit.w #$0080
	beq CODE_C43441
	ora.w #$FF00
CODE_C43441:						; from CODE_C4342A
	clc
	adc.w $0814,x
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
	adc.w $0896,x
	sec
	sbc.w $08B2
	cmp.w #$FFD7
	bmi CODE_C4348D
	cmp.w #$0029
	bpl CODE_C4348D
	lda.w $0814,x
	sec
	sbc.w $0830
	sta.b $7F
	lda.w $0896,x
	sec
	sbc.w $08B2
	sta.b $83
	jml.l $C37F6D
CODE_C4348D:						; from CODE_C4342A, CODE_C43441, CODE_C43465
	rtl
CODE_C4348E:						; called from other segments
	ldy.w $05A0
	bmi CODE_C434A7
	lda.w $1020,x
	cmp.w $1020,y
	bne CODE_C434A7
	lda.w #$0004
	sta.b $7F
	jmp.w CODE_C4373E
CODE_C434A3:						; from CODE_C434A7
	rtl
CODE_C434A4:						; from CODE_C434A7
	jmp.w CODE_C436FD
CODE_C434A7:						; from CODE_C4348E
	lda.w $10F3
	bne CODE_C434A4
	jsl.l CODE_C549A8
	lda.w $14F9,x
	bpl CODE_C434A3
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C434CF
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $0AE0,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
CODE_C434CF:						; from CODE_C434A7
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bpl CODE_C434E6
	clc
	adc.w $0E60,x
	bpl CODE_C434E3
	lda.w #$0000
CODE_C434E3:						; from CODE_C434CF
	sta.w $0AE0,x
CODE_C434E6:						; from CODE_C434CF
	lda.w #$0064
	sta.b $7F
	lda.w $0A20,x
	cmp.w #$0005
	bne CODE_C434F8
	lda.w #$FF9C
	sta.b $7F
CODE_C434F8:						; from CODE_C434E6
	ldy.w $05A0
	lda.w $0FE0,x
	beq CODE_C4353E
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	lda.w #$FF5E
	sta.b $83
	lda.w #$FFAE
	sta.b $87
	lda.w $0A20,y
	beq CODE_C43571
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0010
	bne CODE_C43571
	lda.b $87
	sec
	sbc.w $08B2
	bpl CODE_C43531
	lda.w $08B2
	sta.b $83
	bra CODE_C43575
DATA8_C43530:						; an rtl no traced code reaches
	db $6B
CODE_C43531:						; from CODE_C434F8
	lda.w #$FEF2
	sta.b $87
	sec
	sbc.w $08B2
	bmi CODE_C43575
	bra CODE_C43571
CODE_C4353E:						; from CODE_C434F8
	lda.w #$00A2
	sta.b $83
	lda.w #$0052
	sta.b $87
	lda.w $0A20,y
	beq CODE_C43571
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0010
	bne CODE_C43571
	lda.b $87
	sec
	sbc.w $08B2
	bmi CODE_C43566
	lda.w $08B2
	sta.b $83
	bra CODE_C43575
CODE_C43566:						; from CODE_C4353E
	lda.w #$010E
	sta.b $87
	sec
	sbc.w $08B2
	bpl CODE_C43575
CODE_C43571:						; from CODE_C434F8, CODE_C4353E, CODE_C43531
	lda.b $87
	sta.b $83
CODE_C43575:						; from CODE_C434F8, CODE_C4353E, CODE_C43531, CODE_C43566
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b $63
	lda.w $0830
	eor.b $7F
	sta.b $87
	bmi CODE_C4358D
	lda.w $0830
	sta.b $7F
CODE_C4358D:						; from CODE_C43575
	jmp.w CODE_C45950
CODE_C43590:						; called from other segments
	cpx.w $05A0
	beq CODE_C435AE
	ldy.w $05A0
	bmi CODE_C435B6
	lda.w $1020,x
	cmp.w $1020,y
	beq CODE_C435B6
	lda.w #$0003
	sta.b $7F
	jmp.w CODE_C4373E
CODE_C435AA:						; from CODE_C435B6
	rtl
CODE_C435AB:						; from CODE_C435B6
	jmp.w CODE_C436FD
CODE_C435AE:						; from CODE_C43590
	lda.w #$0011
	sta.b $7F
	jmp.w CODE_C43734
CODE_C435B6:						; from CODE_C43590
	lda.w $10F3
	bne CODE_C435AB
	jsl.l CODE_C549A8
	lda.w $14F9,x
	bpl CODE_C435AA
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C435E4
	and.w #$FFFD
	sta.w $0D60,x
	lda.w #$FFFF
	sta.w $0B60,x
	stz.w $0AE0,x
	stz.w $0B00,x
	lda.w #$0008
	sta.w $0B80,x
CODE_C435E4:						; from CODE_C435B6
	lda.w $0AE0,x
	sec
	sbc.b $9B
	sta.w $0AE0,x
	bmi CODE_C435F2
	jmp.w CODE_C4369F
CODE_C435F2:						; from CODE_C435E4
	clc
	adc.w $0E60,x
	bpl CODE_C435FB
	lda.w #$0000
CODE_C435FB:						; from CODE_C435F2
	sta.w $0AE0,x
	lda.w $08B2
	sta.b $7F
	lda.w $09DC
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
	adc.b $7F
	sta.b $8B
	lda.w $0FE0,x
	bne CODE_C4362E
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	lda.w #$0000
	sec
	sbc.b $8B
	sta.b $8B
CODE_C4362E:						; from CODE_C43614
	stz.b $87
	lda.b $8B
	sec
	sbc.w #$FFA4
	bmi CODE_C4365E
	lda.w #$0008
	sta.b $87
	lda.b $7F
	sec
	sbc.w #$005C
	bmi CODE_C4365E
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0010
	bne CODE_C4365E
	asl.b $87
	lda.b $8B
	sec
	sbc.w #$010E
	bmi CODE_C4365E
	lda.w #$0018
	sta.b $87
CODE_C4365E:						; from CODE_C4362E
	lda.b $87
	cmp.w $0B60,x
	bne CODE_C4366D
	lda.w $04B0
	cmp.w #$0200
	bcs CODE_C4369F
CODE_C4366D:						; from CODE_C4365E
	lda.b $87
	sta.w $0B60,x
	tay
	lda.w #DATA8_C436DD>>16
	sta.b $65
	lda.w #DATA8_C436DD
	sta.b $63
	iny
	iny
	lda.b [$63],y
	dey
	dey
	jsl.l $C37EC8
	adc.b [$63],y
	sta.w $0B20,x
	tya
	clc
	adc.w #$0006
	tay
	lda.b [$63],y
	dey
	dey
	jsl.l $C37EC8
	adc.b [$63],y
	sta.w $0B40,x
CODE_C4369F:						; from CODE_C435E4, CODE_C4365E
	lda.w $0B20,x
	sta.b $7F
	lda.w $0A20,x
	cmp.w #$0005
	beq CODE_C436B4
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C436B4:						; from CODE_C4369F
	lda.w $0B40,x
	sta.b $83
	lda.w $0FE0,x
	bne CODE_C436CE
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
CODE_C436CE:						; from CODE_C436B4
	lda.w #CODE_C4342A>>16
	sta.b $65
	lda.w #CODE_C4342A
	sta.b $63
	jml.l CODE_C45950
DATA8_C436DC:						; an rtl no traced code reaches
	db $6B
DATA8_C436DD:						; not traced: a table read by CODE_C4366D
	db $50,$00,$14,$00,$BA,$FF,$0A,$00,$64,$00,$14,$00,$3C,$00,$0A,$00
	db $3C,$00,$32,$00,$E6,$00,$14,$00,$50,$00,$1E,$00,$FA,$00,$14,$00
CODE_C436FD:						; from CODE_C43350, CODE_C43154, CODE_C434A4, ...
	lda.w $14F9,x
	bpl CODE_C4370B
	lda.w #$0008
	sta.b $7F
	jml.l CODE_C4694F
CODE_C4370B:						; from CODE_C436FD
	rtl
CODE_C4370C:						; from CODE_C43769, CODE_C437F7 and other segments
	lda.w $0A40,x
	inc a
	and.w #$0007
	sta.w $0A40,x
	phx
	phy
	txa
	asl a
	asl a
	adc.w $0A40,x
	tay
	lda.w $0A60,y
	and.w #$00FF
	ply
	plx
	sta.w $0644,x
	lda.w $0D60,x
	ora.w #$0002
	sta.w $0D60,x
	rtl
CODE_C43734:						; from CODE_C43348, CODE_C435AE, CODE_C43A96 and other segments
	lda.w $0A40,x
	dec a
	and.w #$0007
	sta.w $0A40,x
CODE_C4373E:						; from CODE_C4313E, CODE_C4332A, CODE_C4348E, ...
	lda.w $0D60,x
	ora.w #$0002
	sta.w $0D60,x
	txa
	asl a
	asl a
	adc.w $0A40,x
	tay
	sep #$20
	lda.b $7F
	sta.w $0A60,y
	rep #$30
	sta.w $0644,x
	rtl
CODE_C4375B:						; called from other segments
	lda.w $1000,x
	bne CODE_C43768
	lda.w $10F5
	bit.w #$0100
	beq CODE_C43769
CODE_C43768:						; from CODE_C4375B
	rtl
CODE_C43769:						; from CODE_C4375B
	stz.w $18AA
	jmp.w CODE_C4370C
CODE_C4376F:						; called from other segments
	lda.w $1000,x
	beq CODE_C43777
	jmp.w CODE_C43825
CODE_C43777:						; from CODE_C4376F
	lda.w $10F5
	bit.w #$0100
	beq CODE_C437F7
	lda.w $0D60,x
	bit.w #$0002
	beq CODE_C43790
	and.w #$FFFD
	sta.w $0D60,x
	stz.w $0AE0,x
CODE_C43790:						; from CODE_C43777
	lda.w #$007E
	sta.b $65
	lda.w #$2028
	sta.b $63
	lda.w $1020,x
	beq CODE_C437A4
	lda.w #$202C
	sta.b $63
CODE_C437A4:						; from CODE_C43790
	lda.w $0CA0,x
	lsr a
	lsr a
	inc a
	sta.b $7F
	lda.w $0FC0,x
	bne CODE_C437B7
	inc.b $7F
	inc.b $7F
	inc.b $7F
CODE_C437B7:						; from CODE_C437A4
	lda.b $7F
	sta.b [$63]
	lda.w $14F9,x
	bpl CODE_C43825
	lda.w $1060,x
	pha
	lda.w #$0001
	sta.w $1060,x
	pla
	cmp.w #$0000
	bne CODE_C43825
	lda.w #$24FA
	sta.b $83
	lda.w $0AFC
	cmp.w #$0011
	bcc CODE_C43803
	jsl.l RandomWord
	and.w #$0007
	sta.b $7F
	beq CODE_C43803
	lda.w #$2524
	sta.b $83
	lda.w #$0001
	sta.w $1060,x
	jml.l CODE_C457A1
CODE_C437F7:						; from CODE_C43777
	stz.w $18AA
	lda.w #$0014
	sta.w $0CE0,x
	jmp.w CODE_C4370C
CODE_C43803:						; from CODE_C437B7
	lda.w $0FE0,x
	lsr a
	ldx.w $2022
	bcc CODE_C4380F
	ldx.w $2020
CODE_C4380F:						; from CODE_C43803
	lda.w $1864
	cmp.w #$0001
	beq CODE_C43819
	stz.b $30,x
CODE_C43819:						; from CODE_C4380F
	ldx.b $6F
	lda.w #$0001
	sta.w $1060,x
	jml.l CODE_C457A1
CODE_C43825:						; from CODE_C4376F, CODE_C437B7
	rtl
CODE_C43826:						; called from other segments
	lda.w $0D60,x
	bit.w #$0002
	bne CODE_C43831
	jmp.w CODE_C43EC6
CODE_C43831:						; from CODE_C43826
	and.w #$FFFD
	sta.w $0D60,x
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
	jsl.l $CF040B
	jsl.l $CF038E
	lda.w #$FFFF
	sta.w $0776
	sta.w $077C
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
	jsl.l $C4CEDB
	jsl.l CODE_C539D7
	lda.w $113F
	beq CODE_C438D5
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b $40
	lda.w $113F
	and.w #$000F
	cmp.b $40
	beq CODE_C438D5
	bcs CODE_C438CC
	lda.w #$0004
	jsl.l $CF048A
	bra CODE_C438FD
CODE_C438CC:						; from CODE_C4389A
	lda.w #$0001
	jsl.l $CF048A
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
	jsl.l $CF048A
	stz.w $078A
CODE_C438FD:						; from CODE_C4389A, CODE_C438D5, CODE_C438CC
	lda.w #$000D
	trb.w $10F5
	lda.w #$0001
	trb.w $10F7
	stz.w $07B6
	stz.w $0772
	lda.w #$FFFF
	sta.w $1145
	sta.w $07DA
	sta.w $07DE
	sta.w $08D8
	sta.w $07CC
	asl a
	sta.w $05A0
	lda.w #$8200
	trb.w $10F5
	stz.w $2348
	stz.w $234A
	lda.w #$0500
	tsb.w $10F5
	jsl.l CODE_C52264
	lda.w #$0008
	tsb.w $12FF
	tsb.w $1301
	jsl.l CODE_C54BAF
	lda.w #$0008
	trb.w $12FF
	trb.w $1301
	stz.b $CD
	stz.b $CB
	lda.w $2034
	sta.w $0830
	lda.w $2036
	sta.w $08B2
	stz.w $09BC
	stz.w $09DC
	stz.w $08DE
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
	trb.w $10F5
	lda.w #$0064
	sta.b $8F
CODE_C439A2:						; from CODE_C439A2
	jsl.l CODE_C529D7
	dec.b $8F
	bpl CODE_C439A2
	lda.w #$003C
	sta.w $080E
	lda.w $1864
	cmp.w #$0001
	bne CODE_C439C6
	lda.w $1906
	inc a
	sta.w $12C7
	lda.w $1908
	inc a
	sta.w $12C9
CODE_C439C6:						; from CODE_C439A2
	jsl.l CODE_C53AE0
	stz.b $6B
	jsl.l CODE_C541D3
	jsl.l CODE_C53B51
	inc.b $6B
	inc.b $6B
	jsl.l CODE_C541D3
	jsl.l CODE_C53B51
	jsl.l CODE_C53F8D
	lda.w #$FFFF
	sta.w $12BF
	sta.w $12C3
	sta.w $12C1
	sta.w $12C5
	pei ($71)
	pei ($6F)
	stz.b $6F
	lda.w #$000B
	sta.b $87
	pha
CODE_C439FF:						; from CODE_C43BB7
	ldx.b $6F
	cpx.w #$0018
	bcs CODE_C43A17
	lda.w $1020,x
	lsr a
	eor.w $10F1
	and.w #$0002
	lsr a
	eor.w #$0001
	sta.w $0FE0,x
CODE_C43A17:						; from CODE_C439FF
	lda.w $0DC0,x
	asl a
	cpx.w #$000C
	bcc CODE_C43A24
	clc
	adc.w #$0034
CODE_C43A24:						; from CODE_C43A17
	tax
	lda.w $1373,x
	bmi CODE_C43A32
	bit.w #$1000
	bne CODE_C43A32
	jmp.w CODE_C43BB7
CODE_C43A32:						; from CODE_C43A24
	ldx.b $6F
	lda.w #$FF10
	sta.w $0814,x
	stz.w $0896,x
	lda.w #$0001
	sta.w $0856,x
	lda.w $0A20,x
	sta.b $83
	bpl CODE_C43A4D
	jmp.w CODE_C43BB7
CODE_C43A4D:						; from CODE_C43A32
	beq CODE_C43A9A
	lda.w $18BE
	beq CODE_C43A69
	phx
	ldx.w #$0008
	lda.w $18B4
	beq CODE_C43A60
	ldx.w #$0014
CODE_C43A60:						; from CODE_C43A4D
	lda.w $18B2
	sta.w $0DC0,x
	sta.b $8B
	plx
CODE_C43A69:						; from CODE_C43A4D
	lda.w #$0016
	sta.b $7F
	lda.b $83
	cmp.w #$0004
	bne CODE_C43A96
	stz.b $6B
	lda.w $1020,x
	beq CODE_C43A80
	inc.b $6B
	inc.b $6B
CODE_C43A80:						; from CODE_C43A69
	ldy.b $6B
	lda.w $0DC0,x
	and.w #$00FF
	sta.w $12BB,y
	lda.w #$0004
	sta.w $12FF,y
	lda.w #$0017
	sta.b $7F
CODE_C43A96:						; from CODE_C43A69
	jsl.l CODE_C43734
CODE_C43A9A:						; from CODE_C43A4D
	lda.w $12C7
	sta.b $8F
	ldx.b $6F
	lda.w $1020,x
	beq CODE_C43AAB
	lda.w $12C9
	sta.b $8F
CODE_C43AAB:						; from CODE_C43A9A
	lda.b $8F
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0006
	asl a
	asl a
	asl a
	sta.b $8F
	lda.w $1864
	cmp.w #$0001
	bne CODE_C43AC4
	stz.b $8F
CODE_C43AC4:						; from CODE_C43AAB
	lda.w #$00C5
	sta.b $69
	lda.w #$195D
	clc
	adc.b $8F
	sta.b $67
	lda.w $18BE
	beq CODE_C43AE0
	lda.w #$00C5
	sta.b $69
	lda.w #$1975
	sta.b $67
CODE_C43AE0:						; from CODE_C43AC4
	ldy.b $83
	lda.b [$67],y
	and.w #$00FF
	asl a
	asl a
	sta.b $8F
	lda.w #$00C5
	sta.b $69
	lda.w #$197D
	sta.b $67
	ldy.b $8F
	lda.b [$67],y
	sta.b $7F
	iny
	iny
	lda.b [$67],y
	sta.b $83
	lda.w $0FE0,x
	bne CODE_C43B16
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
CODE_C43B16:						; from CODE_C43AE0
	lda.w $0A20,x
	beq CODE_C43B66
	lda.b $8F
	cmp.w #$0009
	bpl CODE_C43B56
	lda.w $2034
	eor.b $7F
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
	adc.b $83
	sta.b $83
CODE_C43B40:						; from CODE_C43B16
	lda.w $2034
	lsr a
	lsr a
	bit.w #$2000
	beq CODE_C43B4D
	ora.w #$C000
CODE_C43B4D:						; from CODE_C43B40
	sta.b $8B
	lda.b $7F
	sec
	sbc.b $8B
	sta.b $7F
CODE_C43B56:						; from CODE_C43B16
	lda.b $7F
	clc
	adc.w $2034
	sta.b $7F
	lda.b $83
	clc
	adc.w $2036
	sta.b $83
CODE_C43B66:						; from CODE_C43B16
	lda.b $7F
	sta.w $0814,x
	sec
	sbc.w $0830
	eor.w #$FFFF
	inc a
	sta.b $7F
	lda.b $83
	sta.w $0896,x
	sec
	sbc.w $08B2
	eor.w #$FFFF
	inc a
	sta.b $83
	stz.w $09A0,x
	stz.w $09C0,x
	jsl.l $C37F6D
	lda.b $7F
	sta.w $0C40,x
	lda.w $0D60,x
	and.w #$EFFF
	sta.w $0D60,x
	stz.w $1000,x
	stz.w $0C80,x
	lda.w $0A20,x
	bne CODE_C43BAC
	lda.w #$121E
	bra CODE_C43BAF
CODE_C43BAC:						; from CODE_C43B66
	lda.w #$1958
CODE_C43BAF:						; from CODE_C43B66
	jsl.l CODE_C457B5
	jsl.l CODE_C457DD
CODE_C43BB7:						; from CODE_C43A24, CODE_C43A32
	inc.b $6F
	inc.b $6F
	pla
	dec a
	sta.b $87
	bmi CODE_C43BC5
	pha
	jmp.w CODE_C439FF
CODE_C43BC5:						; from CODE_C43BB7
	jsl.l $C384FC
	pla
	sta.b $6F
	pla
	sta.b $71
	lda.w $18BE
	beq CODE_C43C34
	ldx.w #$0008
CODE_C43BD7:						; from CODE_C43BED
	lda.w $1525,x
	cmp.w $18B4
	bne CODE_C43BED
	cpx.w $18B6
	beq CODE_C43BED
	ora.w #$8000
	sta.w $1525,x
	stz.w $17B5,x
CODE_C43BED:						; from CODE_C43BD7
	dex
	dex
	bpl CODE_C43BD7
	lda.w $18B4
	eor.w #$0002
	sta.b $7F
	tax
	lda.w $14F5,x
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
	cmp.b $7F
	bne CODE_C43C02
	sty.b $83
	tya
	sta.w $05C4,x
	ldx.w #$0008
CODE_C43C1C:						; from CODE_C43C30
	lda.w $1525,x
	cmp.b $7F
	bne CODE_C43C30
	cpx.b $83
	beq CODE_C43C30
	ora.w #$8000
	sta.w $1525,x
	stz.w $17B5,x
CODE_C43C30:						; from CODE_C43C1C
	dex
	dex
	bpl CODE_C43C1C
CODE_C43C34:						; from CODE_C43BC5, CODE_C43BED
	ldx.b $6F
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
	sty.b $7F
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
	jsl.l $C47F7A
	lda.w $18BE
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
	jsl.l $C4CEDB
	jsl.l $C4C536
	lda.w #$0A00
	jsl.l $C4C558
	sta.w $2024
	sta.b $30
	jsl.l $C4C541
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
	jsl.l $C4CEDB
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
	lda.w $114B
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
	inc.b $38,x
	lda.w #$0001
	jsl.l CODE_C5ECBD
	lda.w $114B
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
	ldx.b $6F
	lda.w $186E
	beq CODE_C43D7D
	lda.w $18BE
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
	ldx.w $12B7
	ldy.w $12B9
	lda.w $10F1
	bit.w #$0002
	beq CODE_C43DA8
	txy
	ldx.w $12B9
CODE_C43DA8:						; from CODE_C43D8B
	stx.b $7F
	sty.b $83
	lda.w #$000B
	jsl.l $C4C558
	tay
	jsl.l $C4C541
	lda.w #$000A
	sta.w $0000,y
	lda.b $7F
	asl a
	adc.b $7F
	tax
	lda.l DATA8_C09B3F,x
	sta.w $0001,y
	lda.l $C09B40,x
	sta.w $0002,y
	lda.w #$A0A0
	sta.w $0004,y
	lda.w #$A0A0
	sta.w $0006,y
	lda.b $83
	asl a
	adc.b $83
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
	sta.b $7F
	ldx.b $6F
	sta.w $0AE0,x
	lda.w $1864
	cmp.w #$0001
	bne CODE_C43E20
	lda.w #$003C
	sta.w $0AE0,x
CODE_C43E20:						; from CODE_C43E01
	lda.w $18BE
	beq CODE_C43E2B
	lda.w #$00B4
	sta.w $0AE0,x
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
	lda.w $10F1
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
	sta.b $9D
	pla
	sta.b $9B
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
	ldx.b $6F
	rtl
CODE_C43EC6:						; from CODE_C43826
	lda.b $9B
	sta.b $9F
	cmp.w $0AE0,x
	bmi CODE_C43ED4
	lda.w #$0001
	sta.b $9F
CODE_C43ED4:						; from CODE_C43EC6
	lda.w $0AE0,x
	sec
	sbc.b $9F
	sta.w $0AE0,x
	bmi CODE_C43EE3
	jml.l CODE_C51999
CODE_C43EE3:						; from CODE_C43ED4
	lda.w $1864
	cmp.w #$0001
	bne CODE_C43EF3
	jsl.l CODE_C51AFF
	jml.l CODE_C51A13
CODE_C43EF3:						; from CODE_C43EE3
	lda.w $18BE
	beq CODE_C43F00
	jsl.l CODE_C51AFF
	jml.l CODE_C51A61
CODE_C43F00:						; from CODE_C43EF3
	stz.w $1157
	lda.w #$FFFF
	sta.w $18B0
	jml.l CODE_C51AFF
CODE_C43F0D:						; from CODE_C43C4E
	jsl.l $C4CEDB
	ldx.w #$0014
	ldy.w #$0008
	lda.w #$5846
	jsl.l CODE_C58C36
	ldx.w #$2DC9
	ldy.w $18B4
	beq CODE_C43F29
	ldx.w #$3207
CODE_C43F29:						; from CODE_C43F0D
	lda.w $18B2
	jsl.l CODE_C533EF
	jsr.w CODE_C43FAD
	adc.w #$58A6
	tay
	lda.b $2C
	jsl.l QueueVRAMDMALen
	ldy.w #$58EF
	ldx.w #$00C3
	lda.w #$5F13
	jsl.l QueueVRAMDMALen
	ldx.w #$3207
	ldy.w $18B4
	beq CODE_C43F55
	ldx.w #$2DC9
CODE_C43F55:						; from CODE_C43F29
	tya
	eor.w #$0002
	tay
	lda.w $12CB,y
	jsl.l CODE_C533EF
	jsr.w CODE_C43FAD
	adc.w #$5926
	tay
	lda.b $2C
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
	sta.b $7F
	jsl.l CODE_C516C2
	ldx.w #$007E
	lda.b $67
	ldy.w #$5B23
	jsl.l QueueVRAMDMALen
	jmp.w CODE_C43D6C
CODE_C43FAD:						; from CODE_C43F29, CODE_C43F55
	sta.b $2C
	stx.b $2E
	lda.b [$2C]
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

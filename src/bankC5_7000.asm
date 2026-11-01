; Segment bankC5_7000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C56F5C
CODE_C56F5C:						; called from other segments
	lda.w #$02C0
	clc
	adc.b $D3
	pha
	ldy.w #$0300
	jsl.l CODE_C58B11
	sec
	pla
	sbc.w #$0040
	ldy.w #$0028
	jsl.l CODE_C58B11
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $79
	bne CODE_C56F91
	ldx.w #$47F8
	bra CODE_C56F98
CODE_C56F91:						; from CODE_C56F5C
	asl a
	tax
	lda.l DATA8_C35E37,x
	tax
CODE_C56F98:						; from CODE_C56F5C
	jsl.l CODE_C4C3BA
	phx
	ldx.w #$4E7D
	jsl.l CODE_C4C3BA
	ply
	jsr.w CODE_C56009
	ldy.w #$000A
	jsl.l CODE_C4BC08
	lda.b $7D
	asl a
	tax
	lda.b $79
	bne CODE_C56FBD
	lda.l DATA8_C35E87,x
	bra CODE_C56FC1
CODE_C56FBD:						; from CODE_C56F98
	lda.l DATA8_C35E67,x
CODE_C56FC1:						; from CODE_C56F98
	tax
	jsl.l CODE_C4C3BA
	phx
	ldx.w #$4EC1
	jsl.l CODE_C4C3BA
	ply
	jsr.w CODE_C56009
	ldy.w #$000B
	jsl.l CODE_C4BC08
	lda.w #$000D
	sta.b $6D
	stz.b $6F
	ldx.w #$2DC9
	lda.b $6B
	beq CODE_C56FEA
	ldx.w #$3207
CODE_C56FEA:						; from CODE_C56FC1
	stx.b $63
	lda.b $79
	bne CODE_C5705C
	lda.w #$0010
	sta.b $91
CODE_C56FF5:						; from CODE_C5704D
	lda.w #$0010
	sta.b $CF
	lda.w #$0028
	sta.b $D1
	ldx.w #$4F71
	ldy.b $6D
	jsl.l CODE_C4BBE5
	lda.b $D1
	sta.b $CF
	lda.w #$00D0
	sta.b $D1
	lda.b $6F
	sta.b $7F
	asl a
	adc.b $63
	tax
	lda.w $0008,x
	sta.b $81
	lda.b $6F
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $63
	adc.w #$0118
	tax
	ldy.b $6D
	jsl.l CODE_C4BC08
	lda.w #$00D0
	sta.b $CF
	lda.b $7D
	asl a
	asl a
	tax
	txy
	lda.l DATA8_C09B94,x
	sta.b $8F
	lda.l $C09B96,x
	tax
	pea.w CODE_C5704D-1
	jmp (DATA8_C570E8,x)
CODE_C5704D:						; from CODE_C56FF5
	inc.b $6D
	lda.b $6F
	inc a
	sta.b $6F
	ldx.b $63
	cmp.w $0002,x
	bne CODE_C56FF5
	rts
CODE_C5705C:						; from CODE_C56FEA
	stz.b $91
CODE_C5705E:						; from CODE_C570E5
	lda.w #$0010
	sta.b $CF
	lda.w #$0028
	sta.b $D1
	lda.b $6F
	asl a
	tax
	lda.l DATA8_C35E47,x
	tax
	ldy.b $6D
	jsl.l CODE_C4BBE5
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $79
	asl a
	asl a
	asl a
	adc.b $6F
	adc.b $63
	inc a
	tax
	lda.w $006C,x
	and.w #$00FF
	dec a
	sta.b $7F
	asl a
	adc.b $63
	tax
	lda.w $0008,x
	sta.b $81
	lda.b $7F
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $63
	adc.w #$0118
	tax
	ldy.b $6D
	jsl.l CODE_C4BC08
	lda.w #$00D0
	sta.b $CF
	lda.b $7D
	asl a
	asl a
	tax
	txy
	lda.l DATA8_C09B54,x
	sta.b $8F
	lda.l $C09B56,x
	tax
	pea.w CODE_C570CC-1
	jmp (DATA8_C570E8,x)
CODE_C570CC:						; from CODE_C5705E
	inc.b $6D
	lda.b $6F
	inc a
	sta.b $6F
	cmp.w #$0005
	bcs CODE_C570E4
	ldx.b $79
	cpx.w #$0006
	bcc CODE_C570E5
	cmp.w #$0004
	bcc CODE_C570E5
CODE_C570E4:						; from CODE_C570CC
	rts
CODE_C570E5:						; from CODE_C570CC
	jmp.w CODE_C5705E
DATA8_C570E8:						; jump table: the routine for each index
	dw CODE_C570F4,CODE_C57149,CODE_C57187,CODE_C5719B
	dw $0000,CODE_C571B4
CODE_C570F4:						; from DATA8_C570E8
	lda.b $7F
	asl a
	ldx.b $6B
	beq CODE_C570FE
	adc.w #$0034
CODE_C570FE:						; from CODE_C570F4
	tay
	lda.w $1373,y
	bpl CODE_C57111
	eor.w #$FFFF
	cmp.w #$0004
	bcc CODE_C5713B
	lda.w #$0001
	bra CODE_C5713B
CODE_C57111:						; from CODE_C570FE
	bit.w #$1000
	beq CODE_C5711B
	lda.w #$0003
	bra CODE_C5713B
CODE_C5711B:						; from CODE_C57111
	pha
	and.w #$0FFF
	jsr.w CODE_C5605D
	pla
	bit.w #$4000
	beq CODE_C57131
	lda.w #$2043
	sta.w $04F5,x
	stz.w $04F7,x
CODE_C57131:						; from CODE_C5711B
	ldx.w #$04F5
	ldy.b $6D
	jsl.l CODE_C4BBF1
	rts
CODE_C5713B:						; from CODE_C570FE, CODE_C57111
	asl a
	tax
	lda.l DATA8_C35E9F,x
	tax
	ldy.b $6D
	jsl.l CODE_C4BBE5
	rts
CODE_C57149:						; from DATA8_C570E8
	lda.b $7F
	asl a
	ldx.b $6B
	beq CODE_C57153
	adc.w #$0034
CODE_C57153:						; from CODE_C57149
	tay
	lda.w $130B,y
	ldx.w $186E
	cpx.w #$0002
	bne CODE_C57162
	lda.w #$1000
CODE_C57162:						; from CODE_C57153
	sta.b $34
	lda.w #$0028
	sta.b $30
	jsl.l Div16x8U
	lda.b $2C
	cmp.w #$0065
	bcc CODE_C57177
	lda.w #$0064
CODE_C57177:						; from CODE_C57162
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l CODE_C4BBF1
	rts
CODE_C57187:						; from DATA8_C570E8
	jsr.w CODE_C571CB
	and.w #$0001
	asl a
	tax
	lda.l PhotoPaletteTable-4,x
	tax
	ldy.b $6D
	jsl.l CODE_C4BBE5
	rts
CODE_C5719B:						; from DATA8_C570E8
	jsr.w CODE_C571CB
	asl a
	asl a
	asl a
	adc.w #$008C
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l CODE_C4BBF1
	rts
CODE_C571B4:						; from DATA8_C570E8
	jsr.w CODE_C571CB
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l CODE_C4BBF1
	rts
CODE_C571C7:						; called from other segments
	jsr.w CODE_C571CB
	rtl
CODE_C571CB:						; from CODE_C571C7, CODE_C57187, CODE_C5719B, CODE_C571B4
	stz.b $81
	ldx.w #$2DC9
	lda.b $7F
	asl a
	adc.b $7F
	asl a
	asl a
	ldy.b $6B
	beq CODE_C571E1
	adc.w #$0138
	ldx.w #$3207
CODE_C571E1:						; from CODE_C571CB
	sta.b $89
	stz.b $83
	stz.b $85
	lda.b $7F
	asl a
	asl a
	asl a
	asl a
	asl a
	stx.b $7F
	adc.b $7F
	sta.b $7F
	lda.w #$000F
CODE_C571F7:						; from CODE_C572BF
	sta.b $87
	asl a
	tax
	lda.l BitMaskTable2,x
	bit.b $8F
	bne CODE_C57206
	jmp.w CODE_C572BF
CODE_C57206:						; from CODE_C571F7
	cmp.w #$0004
	beq CODE_C57210
	cmp.w #$0200
	bne CODE_C57212
CODE_C57210:						; from CODE_C57206
	inc.b $81
CODE_C57212:						; from CODE_C57206
	lda.b $87
	lsr a
	php
	clc
	adc.b $7F
	tax
	lda.w $0110,x
	plp
	bcs CODE_C57224
	lsr a
	lsr a
	lsr a
	lsr a
CODE_C57224:						; from CODE_C57212
	and.w #$000F
	sta.b $8B
	lda.w $24DC
	beq CODE_C57263
	lda.b $87
	dec a
	dec a
	dec a
	cmp.w #$0006
	bcc CODE_C57239
	dec a
CODE_C57239:						; from CODE_C57224
	clc
	adc.b $89
	tax
	lda.w $1543,x
	and.w #$00FF
	tay
	sta.b $8D
	cmp.w #$0080
	bcc CODE_C57252
	lda.w #$0100
	sbc.b $8D
	sta.b $8D
CODE_C57252:						; from CODE_C57239
	asl a
	adc.b $8D
	lsr a
	lsr a
	sta.b $8D
	cpy.w #$0080
	bcc CODE_C57263
	lda.w #$0000
	sbc.b $8D
CODE_C57263:						; from CODE_C57224, CODE_C57252
	sta.b $8D
	lda.b $8F
	bit.w #$0001
	bne CODE_C5729E
	ldx.b $8B
	lda.b $87
	cmp.w #$0002
	beq CODE_C5729C
	cmp.w #$0009
	beq CODE_C5729C
	lda.w #$0012
	jsl.l Mul8U
	clc
	adc.b $8D
	bpl CODE_C57289
	lda.w #$0000
CODE_C57289:						; from CODE_C57263, CODE_C57307
	cmp.w #$0065
	bcc CODE_C57291
	lda.w #$0064
CODE_C57291:						; from CODE_C57289
	cmp.w #$0032
	bcs CODE_C5729B
	lsr a
	clc
	adc.w #$0019
CODE_C5729B:						; from CODE_C57291
	rts
CODE_C5729C:						; from CODE_C57263
	txa
	rts
CODE_C5729E:						; from CODE_C57263
	lda.b $87
	clc
	adc.b $91
	tax
	lda.l DATA8_C57309,x
	ldx.b $8B
	jsl.l Mul8U
	clc
	adc.b $83
	sta.b $83
	lda.b $8D
	ldy.b $91
	beq CODE_C572BA
	asl a
CODE_C572BA:						; from CODE_C5729E
	clc
	adc.b $85
	sta.b $85
CODE_C572BF:						; from CODE_C571F7
	lda.b $87
	dec a
	beq CODE_C572C7
	jmp.w CODE_C571F7
CODE_C572C7:						; from CODE_C572BF
	lda.b $85
	bpl CODE_C572EB
	eor.w #$FFFF
	inc a
	tax
	lda.w #$000A
	ldy.b $91
	beq CODE_C572DA
	lda.w #$0007
CODE_C572DA:						; from CODE_C572C7
	jsl.l DivX8U
	eor.w #$FFFF
	sec
	adc.b $83
	bpl CODE_C57302
	lda.w #$0000
	bra CODE_C57302
CODE_C572EB:						; from CODE_C572C7
	tax
	lda.w #$000A
	ldy.b $91
	beq CODE_C572F6
	lda.w #$0007
CODE_C572F6:						; from CODE_C572EB
	jsl.l DivX8U
	clc
	adc.b $83
	bpl CODE_C57302
	lda.w #$0000
CODE_C57302:						; from CODE_C572DA, CODE_C572F6
	ldx.b $91
	beq CODE_C57307
	lsr a
CODE_C57307:						; from CODE_C57302
	bra CODE_C57289
DATA8_C57309:						; not traced: a table read by CODE_C5729E
	db $00,$00,$01,$02,$03,$03,$02,$01,$02,$01,$03,$02,$01,$01,$01,$01
	db $00,$00,$00,$09,$02,$02,$09,$09,$02,$02,$02,$02,$02,$02,$02,$02
CODE_C57329:						; called from other segments
	jsl.l FadeOutWait
	lda.w $18EE
	sta.w $18E0
	sta.b $08
	stz.b $22
	ldx.w $18F0
	jsl.l CODE_C5E596
	jsl.l CODE_C558D7
	jsl.l CODE_C55513
	pei ($9B)
	lda.b $5F
	dec a
	dec a
	sta.w $0812
	lda.w $17D1
	bne CODE_C57358
	jsl.l CODE_C3736B
CODE_C57358:						; from CODE_C57329
	pla
	sta.b $9B
	sta.b $A2
	pla
	jmp.w $4EF1
CODE_C57361:						; called from other segments
	jsl.l FadeOutWait
	jsl.l CODE_C4CEDB
	jsr.w CODE_C55951
	jsl.l CODE_C53ABC
	ldy.w #$2801
	ldx.w #$5135
	jsl.l $C387D8
	lda.w #$00D0
	sta.b $18
	lda.w #$0028
	sta.b $1A
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	jsr.w CODE_C55E57
	stz.b $69
	stz.b $79
	ldx.w #$0000
	lda.w $186E
	beq CODE_C573A0
	ldx.w #$0006
CODE_C573A0:						; from CODE_C57361
	stx.b $7B
CODE_C573A2:						; from CODE_C57493
	ldx.b $7B
	cpx.w #$0000
	beq CODE_C573B8
	lda.w #$0010
	sta.b $CF
	ldy.w #$0018
	ldx.w #$4F06
	jsl.l CODE_C4BBFC
CODE_C573B8:						; from CODE_C573A2
	lda.w #$537F
	jsl.l CODE_C4BB5A
	ldx.w #$2DC9
	ldy.w #$17DB
	lda.b $6B
	beq CODE_C573CF
	ldx.w #$3207
	ldy.w #$1813
CODE_C573CF:						; from CODE_C573B8
	stx.b $63
	sty.b $65
CODE_C573D3:						; from CODE_C5746B
	jsr.w CODE_C574A4
CODE_C573D6:						; from CODE_C57429
	jsl.l CODE_C4C2AA
	stz.w fadestep
CODE_C573DD:						; from CODE_C573E0, CODE_C57411, CODE_C5741D, CODE_C5744A, ...
	inc.w TransfersReady
CODE_C573E0:						; from CODE_C573E0
	lda.w TransfersReady
	bne CODE_C573E0
	jsl.l CODE_C36C2D
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C573DD
	lda.w $058D
	bit.w #$1000
	beq CODE_C57411
	jmp.w CODE_C574A1
CODE_C57411:						; from CODE_C573E0
	bit.w #$0800
	beq CODE_C5741D
	lda.b $69
	beq CODE_C573DD
	dec a
	bra CODE_C57429
CODE_C5741D:						; from CODE_C57411
	bit.w #$0400
	beq CODE_C5744A
	lda.b $69
	cmp.b $67
	bcs CODE_C573DD
	inc a
CODE_C57429:						; from CODE_C57411
	ldx.b $69
	sta.b $69
	lda.w #$2000
	sta.b $7F
	txa
	clc
	adc.w #$000D
	jsr.w CODE_C5755C
	lda.w #$2400
	sta.b $7F
	lda.b $69
	clc
	adc.w #$000D
	jsr.w CODE_C5755C
	bra CODE_C573D6
CODE_C5744A:						; from CODE_C5741D
	bit.w #$0200
	beq CODE_C57458
	lda.b $79
	beq CODE_C573DD
	dec a
	sta.b $79
	bra CODE_C57466
CODE_C57458:						; from CODE_C5744A
	bit.w #$0100
	beq CODE_C57493
	lda.b $79
	cmp.b $7B
	beq CODE_C5749E
	inc a
	sta.b $79
CODE_C57466:						; from CODE_C5744A
	ldx.b $D3
	ldy.w #$0014
CODE_C5746B:						; from CODE_C5746B
	stz.w $0200,x
	stz.w $0240,x
	stz.w $0280,x
	inx
	inx
	dey
	bpl CODE_C5746B
	lda.b $D3
	clc
	adc.w #$0300
	ldy.w #$02C0
	jsl.l CODE_C58B11
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	stz.b $69
	jmp.w CODE_C573D3
CODE_C57493:						; from CODE_C57458
	bit.w #$8000
	beq CODE_C5749E
	jsr.w CODE_C57578
	jmp.w CODE_C573A2
CODE_C5749E:						; from CODE_C57458, CODE_C57493
	jmp.w CODE_C573DD
CODE_C574A1:						; from CODE_C573E0
	jmp.w CODE_C55A09
CODE_C574A4:						; from CODE_C573D3
	lda.w #$0020
	sta.b $CF
	lda.w #$00A8
	sta.b $D1
	lda.w $186E
	bne CODE_C574B8
	ldx.w #$4C74
	bra CODE_C574C2
CODE_C574B8:						; from CODE_C574A4
	lda.b $79
	inc a
	asl a
	tax
	lda.l DATA8_C35E37,x
	tax
CODE_C574C2:						; from CODE_C574A4
	ldy.w #$0008
	jsl.l CODE_C4BC26
	ldy.w #$000A
	jsl.l CODE_C4BDE6
	lda.w #$000D
	sta.b $6D
	stz.b $6F
CODE_C574D7:						; from CODE_C574E3
	ldx.w #$2400
	lda.b $6F
	cmp.b $69
	beq CODE_C574E3
	ldx.w #$2000
CODE_C574E3:						; from CODE_C574D7
	stx.b $D5
	jsr.w CODE_C57509
	inc.b $6D
	lda.b $6F
	inc a
	sta.b $6F
	cmp.w #$0005
	bcs CODE_C57500
	ldx.b $79
	cpx.w #$0005
	bcc CODE_C574D7
	cmp.w #$0004
	bcc CODE_C574D7
CODE_C57500:						; from CODE_C574E3
	dec a
	sta.b $67
	lda.w #$2000
	sta.b $D5
	rts
CODE_C57509:						; from CODE_C574E3
	lda.w #$0020
	sta.b $CF
	lda.w #$0040
	sta.b $D1
	lda.b $6F
	asl a
	tax
	lda.l DATA8_C35E47,x
	tax
	ldy.b $6D
	jsl.l CODE_C4BBE5
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $79
	asl a
	asl a
	asl a
	adc.b $6F
	adc.b $65
	inc a
	tax
	lda.w $0000,x
	and.w #$00FF
	dec a
	sta.b $7F
	asl a
	adc.b $63
	tax
	lda.w $0008,x
	sta.b $81
	lda.b $7F
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $63
	adc.w #$0118
	tax
	ldy.b $6D
	jsl.l CODE_C4BC08
	rts
CODE_C5755C:						; from CODE_C57429, CODE_C5778E, CODE_C577A3
	xba
	lsr a
	lsr a
	adc.b $D3
	tax
	ldy.w #$0020
CODE_C57565:						; from CODE_C57572
	lda.w $0000,x
	and.w #$E3FF
	beq CODE_C57572
	ora.b $7F
	sta.w $0000,x
CODE_C57572:						; from CODE_C57565
	inx
	inx
	dey
	bne CODE_C57565
	rts
CODE_C57578:						; from CODE_C57493
	pei ($7B)
	pei ($65)
	pei ($79)
	pei ($69)
	lda.b $D3
	clc
	adc.w #$0300
	ldy.w #$0400
	jsl.l CODE_C58B11
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	stz.b $7D
	stz.b $7B
	stz.b $91
	lda.w #$0001
	sta.w $24DC
	ldx.b $63
	lda.b $69
	cmp.w #$0002
	bcs CODE_C575BA
	lda.w $0002,x
	clc
	adc.w $0004,x
	sta.b $65
	lda.w $0006,x
	sta.b $67
	bra CODE_C575C4
CODE_C575BA:						; from CODE_C57578
	lda.w $0002,x
	sta.b $65
	lda.w $0004,x
	sta.b $67
CODE_C575C4:						; from CODE_C57578
	lda.w #CODE_C576FD
	ldx.w #$000A
	ldy.w #$000E
	jsr.w CODE_C55ABC
	jsr.w CODE_C577C3
	jsl.l CODE_C4C2AA
CODE_C575D7:						; from CODE_C575DA, CODE_C57631, CODE_C57636, CODE_C57644, ...
	inc.w TransfersReady
CODE_C575DA:						; from CODE_C575DA
	lda.w TransfersReady
	bne CODE_C575DA
	jsl.l CODE_C36C2D
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
	bne CODE_C575D7
	lda.w $058D
	bit.w #$1000
	bne CODE_C5767D
	bit.w #$0800
	beq CODE_C5761E
	lda.b $7B
	pha
	beq CODE_C57618
	dec a
	sta.b $7B
CODE_C57618:						; from CODE_C575DA
	jsr.w CODE_C55CE6
	pla
	bra CODE_C57631
CODE_C5761E:						; from CODE_C575DA
	bit.w #$0400
	beq CODE_C57636
	lda.b $7B
	pha
	inc a
	cmp.b $67
	bcs CODE_C5762D
	sta.b $7B
CODE_C5762D:						; from CODE_C5761E
	jsr.w CODE_C55C58
	pla
CODE_C57631:						; from CODE_C57618
	jsr.w CODE_C57779
	bra CODE_C575D7
CODE_C57636:						; from CODE_C5761E
	bit.w #$0200
	beq CODE_C57644
	lda.b $7D
	beq CODE_C575D7
	dec a
	sta.b $7D
	bra CODE_C57653
CODE_C57644:						; from CODE_C57636
	bit.w #$0100
	beq CODE_C57660
	lda.b $7D
	cmp.w #$000F
	bcs CODE_C575D7
	inc a
	sta.b $7D
CODE_C57653:						; from CODE_C57636
	jsr.w CODE_C576CC
	jsr.w CODE_C577C3
	jsr.w CODE_C55C12
	jsl.l CODE_C4C2AA
CODE_C57660:						; from CODE_C57644
	bit.w #$8000
	beq CODE_C5767A
	lda.b $65
	clc
	adc.b $7B
	sta.b $7B
	lda.b $05,s
	sta.b $65
	lda.b $03,s
	tax
	lda.b $01,s
	jsr.w CODE_C577F7
	bra CODE_C5767D
CODE_C5767A:						; from CODE_C57660
	jmp.w CODE_C575D7
CODE_C5767D:						; from CODE_C575DA, CODE_C57660
	ldx.b $77
	jsl.l CODE_C5E596
	ldx.b $79
	jsl.l CODE_C5E596
	jsr.w CODE_C5BBC0
	pla
	sta.b $69
	pla
	sta.b $79
	pla
	sta.b $65
	pla
	sta.b $7B
	jsl.l CODE_C4CEDB
	lda.b $D3
	clc
	adc.w #$0300
	ldy.w #$0400
	jsl.l CODE_C58B11
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	lda.w #$8000
	sta.w DMAEnShadow
	sep #$20
	lda.b #$1F
	sta.l TM
	lda.b #$FF
	sta.l $002112
	sta.l $002112
	rep #$20
	rts
CODE_C576CC:						; from CODE_C57653
	lda.b $D3
	clc
	adc.w #$0320
	pha
	ldy.w #$0020
	jsl.l CODE_C58B11
	pla
	clc
	adc.w #$004C
	ldx.w #$000B
CODE_C576E2:						; from CODE_C576E2
	phx
	pha
	ldy.w #$0014
	jsl.l CODE_C58B11
	pla
	clc
	adc.w #$0040
	plx
	dex
	bpl CODE_C576E2
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	rts
CODE_C576FD:						; a callback: CODE_C575C4 passes it to CODE_C55ABC
	ldx.w #$2000
	lda.b $6F
	cmp.b $7B
	bne CODE_C57709
	ldx.w #$2400
CODE_C57709:						; from CODE_C576FD
	stx.b $D5
	ldx.w #$0010
	stx.b $CF
	ldx.w #$00D0
	stx.b $D1
	clc
	adc.b $65
	sta.b $7F
	asl a
	adc.b $63
	tax
	lda.w $0008,x
	sta.b $81
	lda.b $7F
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $63
	adc.w #$0118
	tax
	phx
	lda.l $7DFFF8,x
	and.w #$00FF
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldy.b $6D
	ldx.w #$04F5
	jsl.l CODE_C4BC08
	lda.w #$0022
	sta.b $CF
	plx
	ldy.b $6D
	jsl.l CODE_C4BC08
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $7D
	asl a
	asl a
	tax
	txy
	lda.l DATA8_C09B54,x
	sta.b $8F
	lda.l $C09B56,x
	tax
	pea.w CODE_C57773-1
	jmp (DATA8_C570E8,x)
CODE_C57773:						; from CODE_C57709
	lda.w #$2000
	sta.b $D5
	rts
CODE_C57779:						; from CODE_C57631
	ldx.b $71
	inx
	stx.b $A1
	inx
	stx.b $A3
	ldx.w #$2000
	stx.b $7F
CODE_C57786:						; from CODE_C57786
	cmp.b $A1
	bcc CODE_C5778E
	sbc.b $A3
	bpl CODE_C57786
CODE_C5778E:						; from CODE_C57786
	clc
	adc.b $73
	jsr.w CODE_C5755C
	lda.w #$2400
	sta.b $7F
	lda.b $7B
CODE_C5779B:						; from CODE_C5779B
	cmp.b $A1
	bcc CODE_C577A3
	sbc.b $A3
	bpl CODE_C5779B
CODE_C577A3:						; from CODE_C5779B
	clc
	adc.b $73
	jsr.w CODE_C5755C
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	ldx.w #$0000
	lda.w $0565
	beq CODE_C577C2
CODE_C577B9:						; from CODE_C577B9
	dex
	bne CODE_C577B9
	stz.w $058F
	stz.w $058D
CODE_C577C2:						; from CODE_C577A3
	rts
CODE_C577C3:						; from CODE_C575C4, CODE_C57653
	lda.w #$000C
	sta.b $6D
	jsr.w CODE_C55D73
	lda.w #$001E
	sta.b $CF
	lda.w #$00D0
	sta.b $D1
	ldx.w #$4F6C
	ldy.b $6D
	jsl.l CODE_C4BBFC
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $7D
	asl a
	tax
	lda.l DATA8_C35E67,x
	tax
	ldy.b $6D
	jsl.l CODE_C4BC0E
	rts
CODE_C577F7:						; from CODE_C57660
	stx.b $A1
	inc.b $7B
	asl a
	tax
	lda.l DATA8_C57810,x
	sta.b $9F
	lda.b $A1
	asl a
	asl a
	asl a
	adc.b $65
	tax
	sep #$20
	jmp ($009F)
DATA8_C57810:						; the routines CODE_C577F7 jumps to through a pointer, by index
	dw CODE_C5781A,CODE_C5782F,CODE_C57844,CODE_C57868
	dw CODE_C5788C
CODE_C5781A:						; from DATA8_C57810
	lda.w $0002,x
	cmp.b $7B
	bne CODE_C57827
	lda.w $0001,x
	sta.w $0002,x
CODE_C57827:						; from CODE_C5781A
	lda.b $7B
	sta.w $0001,x
	rep #$20
	rts
CODE_C5782F:						; from DATA8_C57810
	lda.w $0001,x
	cmp.b $7B
	bne CODE_C5783C
	lda.w $0002,x
	sta.w $0001,x
CODE_C5783C:						; from CODE_C5782F
	lda.b $7B
	sta.w $0002,x
	rep #$20
	rts
CODE_C57844:						; from DATA8_C57810
	lda.w $0005,x
	cmp.b $7B
	bne CODE_C57859
	lda.w $0003,x
	sta.w $0005,x
CODE_C57851:						; from CODE_C57859
	lda.b $7B
	sta.w $0003,x
	rep #$20
	rts
CODE_C57859:						; from CODE_C57844
	lda.w $0004,x
	cmp.b $7B
	bne CODE_C57851
	lda.w $0003,x
	sta.w $0004,x
	bra CODE_C57851
CODE_C57868:						; from DATA8_C57810
	lda.w $0003,x
	cmp.b $7B
	bne CODE_C5787D
	lda.w $0004,x
	sta.w $0003,x
CODE_C57875:						; from CODE_C5787D
	lda.b $7B
	sta.w $0004,x
	rep #$20
	rts
CODE_C5787D:						; from CODE_C57868
	lda.w $0005,x
	cmp.b $7B
	bne CODE_C57875
	lda.w $0004,x
	sta.w $0005,x
	bra CODE_C57875
CODE_C5788C:						; from DATA8_C57810
	lda.w $0003,x
	cmp.b $7B
	bne CODE_C578A1
	lda.w $0005,x
	sta.w $0003,x
CODE_C57899:						; from CODE_C578A1
	lda.b $7B
	sta.w $0005,x
	rep #$20
	rts
CODE_C578A1:						; from CODE_C5788C
	lda.w $0004,x
	cmp.b $7B
	bne CODE_C57899
	lda.w $0005,x
	sta.w $0004,x
	bra CODE_C57899
CODE_C578B0:						; called from other segments
	jsl.l FadeOutWait
	jsl.l CODE_C4CEDB
	jsr.w CODE_C55951
	lda.w #$5395
	jsl.l CODE_C4BB5A
	jsl.l CODE_C53ABC
	ldy.w #$2801
	ldx.w #$5135
	jsl.l $C387D8
	lda.w #$00D0
	sta.b $18
	lda.w #$0028
	sta.b $1A
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	jsr.w CODE_C55E57
	stz.b $7D
	ldx.w #$2DC9
	lda.b $6B
	beq CODE_C578F3
	ldx.w #$3207
CODE_C578F3:						; from CODE_C578B0
	stx.b $63
	lda.w $0002,x
	sta.b $67
	ldx.b $6B
	lda.w $12CB,x
	bpl CODE_C57903
	lda.b $67
CODE_C57903:						; from CODE_C578F3
	sta.b $69
CODE_C57905:						; from CODE_C57912, CODE_C5794E, CODE_C5795E, CODE_C5796C
	jsr.w CODE_C57997
	jsl.l CODE_C4C2AA
	stz.w fadestep
CODE_C5790F:						; from CODE_C57912, CODE_C5794E, CODE_C5795E, CODE_C5796C, ...
	inc.w TransfersReady
CODE_C57912:						; from CODE_C57912
	lda.w TransfersReady
	bne CODE_C57912
	jsl.l CODE_C36C2D
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C5790F
	lda.w $058D
	bit.w #$1000
	bne CODE_C57994
	bit.w #$0800
	beq CODE_C5794E
	lda.b $69
	beq CODE_C5790F
	dec a
	sta.b $69
	bra CODE_C57905
CODE_C5794E:						; from CODE_C57912
	bit.w #$0400
	beq CODE_C5795E
	lda.b $69
	cmp.b $67
	beq CODE_C5790F
	inc a
	sta.b $69
	bra CODE_C57905
CODE_C5795E:						; from CODE_C5794E
	bit.w #$0200
	beq CODE_C5796C
	lda.b $7D
	beq CODE_C5790F
	dec a
	sta.b $7D
	bra CODE_C57905
CODE_C5796C:						; from CODE_C5795E
	bit.w #$0100
	beq CODE_C5797D
	lda.b $7D
	cmp.w #$000B
	bcs CODE_C5790F
	inc a
	sta.b $7D
	bra CODE_C57905
CODE_C5797D:						; from CODE_C5796C
	bit.w #$8000
	beq CODE_C5790F
	lda.b $69
	cmp.b $67
	bne CODE_C5798B
	lda.w #$FFFF
CODE_C5798B:						; from CODE_C5797D
	ldx.b $6B
	sta.w $12CB,x
	jsl.l CODE_C541D3
CODE_C57994:						; from CODE_C57912
	jmp.w CODE_C55A09
CODE_C57997:						; from CODE_C57905
	lda.w #$0300
	clc
	adc.b $D3
	ldy.w #$0280
	jsl.l CODE_C58B11
	lda.w #$000C
	sta.b $6D
	lda.w #$0010
	sta.b $CF
	lda.w #$00D0
	sta.b $D1
	ldx.w #$4F6C
	ldy.b $6D
	jsl.l CODE_C4BBFC
	ldy.b $6D
	iny
	jsl.l CODE_C4BDE6
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $7D
	asl a
	tax
	lda.l DATA8_C35E87,x
	tax
	ldy.b $6D
	jsl.l CODE_C4BC0E
	ldy.b $6D
	iny
	jsl.l CODE_C4BDE6
	stz.b $6F
	lda.w #$000E
	sta.b $6D
	lda.w #$0010
	sta.b $91
	lda.w #$0001
	sta.w $24DC
CODE_C579F4:						; from CODE_C57A4D
	jsr.w CODE_C55D73
	lda.b $6F
	ldx.w #$2000
	sta.b $7F
	cmp.b $69
	bne CODE_C57A05
	ldx.w #$2400
CODE_C57A05:						; from CODE_C579F4
	stx.b $D5
	ldx.w #$0010
	stx.b $CF
	ldx.w #$00D0
	stx.b $D1
	asl a
	adc.b $63
	tax
	lda.w $0008,x
	sta.b $81
	lda.b $7F
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $63
	adc.w #$0118
	tax
	ldy.b $6D
	jsl.l CODE_C4BC08
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $7D
	asl a
	asl a
	tax
	txy
	lda.l DATA8_C09B94,x
	sta.b $8F
	lda.l $C09B96,x
	tax
	pea.w CODE_C57A4D-1
	jmp (DATA8_C570E8,x)
CODE_C57A4D:						; from CODE_C57A05
	inc.b $6D
	lda.b $6F
	inc a
	sta.b $6F
	cmp.b $67
	bne CODE_C579F4
	ldx.w #$2000
	cmp.b $69
	bne CODE_C57A62
	ldx.w #$2400
CODE_C57A62:						; from CODE_C57A4D
	stx.b $D5
	lda.w #$0010
	sta.b $CF
	lda.w #$00D0
	sta.b $D1
	ldx.w #$4C86
	ldy.b $6D
	jsl.l CODE_C4BBFC
	lda.w #$2000
	sta.b $D5
	rts
CODE_C57A7D:						; called from other segments
	jsl.l FadeOutWait
	jsl.l CODE_C4CEDB
	jsr.w CODE_C55951
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4C95
	ldy.w #$0002
	jsl.l CODE_C4BDAE
	lda.l $306050
	and.w #$00FF
	tay
	asl a
	tax
	lda.l DATA8_C35F60,x
	bne CODE_C57AD2
	lda.w #$000D
	ldx.w #$5F52
	ldy.w #$04F5
	mvn $7E,$C3
	tya
	sec
	sbc.w #$04F5
	pha
	lda.l $3075B4
	inc a
	and.w #$00FF
	jsr.w CODE_C5B67A
	plx
	jsr.w CODE_C55ECA
	stz.w $04F5,x
	bra CODE_C57AD6
CODE_C57AD2:						; from CODE_C57A7D
	tya
	jsr.w CODE_C56168
CODE_C57AD6:						; from CODE_C57A7D
	ldx.w #$04F5
	ldy.w #$0007
	jsl.l CODE_C4BCB0
	ldy.w #$0009
	jsl.l CODE_C4BDE6
	lda.w $190E
	beq CODE_C57AF6
	ldx.w #$4717
	ldy.w #$0019
	jsl.l CODE_C4BBFC
CODE_C57AF6:						; from CODE_C57AD6
	lda.w $2C42
	sta.b $7F
	ldx.w #$0000
	txy
CODE_C57AFF:						; from CODE_C57B06
	lda.l $7F8EF8,x
	bne CODE_C57B06
	iny
CODE_C57B06:						; from CODE_C57AFF
	txa
	clc
	adc.w #$010A
	tax
	dec.b $7F
	bne CODE_C57AFF
	sty.b $7F
	tya
	asl a
	adc.b $7F
	bne CODE_C57B1D
	pea.w CODE_C54F37
	bra CODE_C57B21
CODE_C57B1D:						; from CODE_C57B06
	dec a
	pea.w CODE_C57B8A
CODE_C57B21:						; from CODE_C57B06
	sta.b $67
	stz.b $69
	pla
	ldx.w #$000B
	ldy.w #$000B
	jsr.w CODE_C55ABC
	jsl.l CODE_C4C2AA
	stz.w fadestep
CODE_C57B36:						; from CODE_C57B36, CODE_C57B7F, CODE_C57B7D
	inc.w TransfersReady
	wai
	jsl.l CODE_C36C2D
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
	bne CODE_C57B36
	lda.w $058D
	bit.w #$0040
	bne CODE_C57B7F
	bit.w #$1000
	bne CODE_C57B87
	bit.w #$0800
	beq CODE_C57B75
	jsr.w CODE_C55CE6
	bra CODE_C57B36
CODE_C57B75:						; from CODE_C57B36
	bit.w #$0400
	beq CODE_C57B7D
	jsr.w CODE_C55C58
CODE_C57B7D:						; from CODE_C57B75
	bra CODE_C57B36
CODE_C57B7F:						; from CODE_C57B36
	lda.w $190E
	beq CODE_C57B36
	dec.w $1910
CODE_C57B87:						; from CODE_C57B36
	jmp.w CODE_C55A09
CODE_C57B8A:						; a callback: pushed (pea), then passed to CODE_C55ABC
	lda.w #$0010
	sta.b $CF
	lda.w #$00C4
	sta.b $D1
	lda.b $6F
	sta.b $34
	lda.w #$0003
	sta.b $30
	jsl.l Div16x8U
	tay
	ldx.w #$0000
CODE_C57BA5:						; from CODE_C57BB1
	lda.l $7F8EF8,x
	bne CODE_C57BB1
	cpy.w #$0000
	beq CODE_C57BB9
	dey
CODE_C57BB1:						; from CODE_C57BA5
	txa
	clc
	adc.w #$010A
	tax
	bra CODE_C57BA5
CODE_C57BB9:						; from CODE_C57BA5
	lda.l RDMPYL
	beq CODE_C57BC3
	dec a
	beq CODE_C57BEA
	rts
CODE_C57BC3:						; from CODE_C57BB9
	phx
	lda.l $7F8EFA,x
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.b $6D
	jsl.l CODE_C4BBFC
	plx
	lda.l $7F8F00,x
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldx.w #$04F5
	ldy.b $6D
	jsl.l CODE_C4BC1A
	rts
CODE_C57BEA:						; from CODE_C57BB9
	phx
	lda.l $7F8EFC,x
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.b $6D
	jsl.l CODE_C4BBFC
	lda.b $01,s
	tax
	lda.l $7F8F02,x
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldx.w #$04F5
	ldy.b $6D
	jsl.l CODE_C4BC1A
	lda.w #$00C8
	sta.b $CF
	plx
	ldy.b $6D
	lda.l $7F8EFE,x
	bmi CODE_C57C2C
	asl a
	tax
	lda.l DATA8_C35E25,x
	tax
	jsl.l CODE_C4BBFC
	rts
CODE_C57C2C:						; from CODE_C57BEA
	ldx.w #$4F67
	jsl.l CODE_C4BBFC
	rts
CODE_C57C34:						; called from other segments
	jsl.l FadeOutWait
	jsl.l CODE_C4CEDB
	jsr.w CODE_C55951
	stz.b $7D
	lda.w #$0000
	tax
CODE_C57C45:						; from CODE_C57CD5
	stx.b $73
	pha
	sta.w $364E,x
	jsr.w CODE_C5D2B4
	cpx.w #$0000
	beq CODE_C57C74
	ldy.w #$0000
	ldx.b $73
CODE_C57C58:						; from CODE_C57C58
	lda.w $04F5,y
	and.w #$00FF
	sta.w $3660,x
	inx
	iny
	cpy.w #$000C
	bne CODE_C57C58
	lda.b $01,s
	jsr.w CODE_C5D6F5
	lda.b $8F
	clc
	adc.b $8D
	adc.b $8B
CODE_C57C74:						; from CODE_C57C45
	beq CODE_C57CD3
	ldx.b $73
	lda.b $7F
	sta.w $3650,x
	lda.b $85
	sta.w $3654,x
	sep #$20
	lda.b $81
	sta.w $3652,x
	lda.b $83
	sta.w $3653,x
	lda.b $87
	sta.w $3656,x
	lda.b $89
	sta.w $3657,x
	rep #$20
	lda.b $8F
	sta.w $365C,x
	lda.b $8D
	sta.w $365A,x
	lda.b $8B
	sta.w $3658,x
	ldx.w #$0064
	jsl.l Mul16x8U
	lda.b $8F
	clc
	adc.b $8D
	bne CODE_C57CBC
	lda.w #$0064
	bra CODE_C57CC6
CODE_C57CBC:						; from CODE_C57C74
	adc.b $8B
	sta.b $30
	jsl.l $C091AE
	lda.b $2C
CODE_C57CC6:						; from CODE_C57C74
	ldx.b $73
	sta.w $365E,x
	txa
	clc
	adc.w #$0020
	tax
	bra CODE_C57CD5
CODE_C57CD3:						; from CODE_C57C74
	ldx.b $73
CODE_C57CD5:						; from CODE_C57CC6
	pla
	inc a
	cmp.w #$0008
	beq CODE_C57CDF
	jmp.w CODE_C57C45
CODE_C57CDF:						; from CODE_C57CD5
	txa
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b $67
	lda.b $67
	sta.b $9F
	beq CODE_C57D20
	lda.w #$FFFF
	sta.w $3E4E
	lda.w #$002D
	ldx.w #$3E4E
	ldy.w #$3E50
	mvn $7E,$7E
	ldx.w #$0000
CODE_C57D02:						; from CODE_C57D02
	stx.b $A1
	lda.w $365E,x
	jsr.w CODE_C57DD3
	lda.w $3650,x
	jsr.w CODE_C57DFF
	lda.w $3654,x
	jsr.w CODE_C57E2B
	txa
	clc
	adc.w #$0020
	tax
	dec.b $9F
	bne CODE_C57D02
CODE_C57D20:						; from CODE_C57CDF
	lda.w #$545F
	jsl.l CODE_C4BB5A
CODE_C57D27:						; from CODE_C57DB8
	lda.b $67
	bne CODE_C57D4B
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w #$2400
	sta.b $D5
	ldx.w #$4D98
	ldy.w #$0006
	jsl.l CODE_C4BBE5
	lda.w #$2000
	sta.b $D5
	bra CODE_C57D65
CODE_C57D4B:						; from CODE_C57D27
	lda.b $D3
	clc
	adc.w #$0180
	ldy.w #$02C0
	jsl.l CODE_C58B11
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	ldx.b $7D
	jsr (DATA8_C57DCD,x)
CODE_C57D65:						; from CODE_C57D27
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	stz.w fadestep
CODE_C57D70:						; from CODE_C57D70, CODE_C57DA3, CODE_C57DBD
	inc.w TransfersReady
	wai
	jsl.l CODE_C36C2D
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
	bne CODE_C57D70
	lda.w $058D
	bit.w #$1000
	beq CODE_C57DA3
	jmp.w CODE_C55A09
CODE_C57DA3:						; from CODE_C57D70
	ldx.b $67
	beq CODE_C57D70
	bit.w #$0100
	beq CODE_C57DBD
	lda.b $7D
	inc a
	inc a
	cmp.w #$0006
	bcc CODE_C57DB8
	lda.w #$0000
CODE_C57DB8:						; from CODE_C57DA3, CODE_C57DBD
	sta.b $7D
	jmp.w CODE_C57D27
CODE_C57DBD:						; from CODE_C57DA3
	bit.w #$0200
	beq CODE_C57D70
	lda.b $7D
	dec a
	dec a
	bpl CODE_C57DB8
	lda.w #$0004
	bra CODE_C57DB8
DATA8_C57DCD:						; jump table: the routine for each index
	dw CODE_C57E57,CODE_C57F05,CODE_C57FD8
CODE_C57DD3:						; from CODE_C57D02
	ldy.w #$0000
CODE_C57DD6:						; from CODE_C57DD6
	ldx.w $3E4E,y
	bmi CODE_C57DF8
	cmp.w $365E,x
	bcs CODE_C57DE7
	iny
	iny
	cpy.w #$000E
	bcc CODE_C57DD6
CODE_C57DE7:						; from CODE_C57DD6
	phy
	ldy.w #$3E5D
	ldx.w #$3E5B
	sec
	lda.w #$000D
	sbc.b $01,s
	mvp $7E,$7E
	ply
CODE_C57DF8:						; from CODE_C57DD6
	lda.b $A1
	sta.w $3E4E,y
	tax
	rts
CODE_C57DFF:						; from CODE_C57D02
	ldy.w #$0000
CODE_C57E02:						; from CODE_C57E02
	ldx.w $3E5E,y
	bmi CODE_C57E24
	cmp.w $3650,x
	bcs CODE_C57E13
	iny
	iny
	cpy.w #$000E
	bcc CODE_C57E02
CODE_C57E13:						; from CODE_C57E02
	phy
	ldy.w #$3E6D
	ldx.w #$3E6B
	sec
	lda.w #$000D
	sbc.b $01,s
	mvp $7E,$7E
	ply
CODE_C57E24:						; from CODE_C57E02
	lda.b $A1
	sta.w $3E5E,y
	tax
	rts
CODE_C57E2B:						; from CODE_C57D02
	ldy.w #$0000
CODE_C57E2E:						; from CODE_C57E2E
	ldx.w $3E6E,y
	bmi CODE_C57E50
	cmp.w $3654,x
	bcs CODE_C57E3F
	iny
	iny
	cpy.w #$000E
	bcc CODE_C57E2E
CODE_C57E3F:						; from CODE_C57E2E
	phy
	ldy.w #$3E7D
	ldx.w #$3E7B
	sec
	lda.w #$000D
	sbc.b $01,s
	mvp $7E,$7E
	ply
CODE_C57E50:						; from CODE_C57E2E
	lda.b $A1
	sta.w $3E6E,y
	tax
	rts
CODE_C57E57:						; from DATA8_C57DCD
	lda.w #$0010
	sta.b $CF
	lda.w #$0060
	sta.b $D1
	ldx.w #$4DA4
	jsr.w CODE_C580AB
	lda.w #$0088
	sta.b $D1
	ldx.w #$4DA8
	jsr.w CODE_C580AB
	lda.w #$00A8
	sta.b $D1
	ldx.w #$4DAD
	jsr.w CODE_C580AB
	lda.w #$00C8
	sta.b $D1
	ldx.w #$4DB1
	jsr.w CODE_C580AB
	lda.w #$00E8
	sta.b $D1
	ldx.w #$4DB5
	jsr.w CODE_C580AB
	lda.w #$0008
	sta.b $6D
	lda.w #$0000
CODE_C57E9B:						; from CODE_C57E9B
	sta.b $65
	jsr.w CODE_C57EAA
	inc.b $6D
	lda.b $65
	inc a
	cmp.b $67
	bne CODE_C57E9B
	rts
CODE_C57EAA:						; from CODE_C57E9B
	ldx.w #$0010
	stx.b $CF
	ldx.w #$0060
	stx.b $D1
	asl a
	tax
	lda.w $3E4E,x
	sta.b $6F
	adc.w #$3660
	tax
	ldy.b $6D
	jsr.w CODE_C57EFA
	ldx.b $6F
	lda.w #$0088
	sta.b $D1
	lda.w $365E,x
	jsr.w CODE_C57EEF
	lda.w #$00A8
	sta.b $D1
	lda.w $3658,x
	jsr.w CODE_C57EEF
	lda.w #$00C8
	sta.b $D1
	lda.w $365C,x
	jsr.w CODE_C57EEF
	lda.w #$00E8
	sta.b $D1
	lda.w $365A,x
CODE_C57EEF:						; from CODE_C57EAA
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	ldx.w #$04F5
	ldy.b $6D
CODE_C57EFA:						; from CODE_C57EAA
	jsl.l CODE_C4BBF1
	lda.b $D1
	sta.b $CF
	ldx.b $6F
	rts
CODE_C57F05:						; from DATA8_C57DCD
	lda.w #$0010
	sta.b $CF
	lda.w #$0060
	sta.b $D1
	ldx.w #$4DA4
	jsr.w CODE_C580AB
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4B6A
	jsr.w CODE_C580AB
	lda.w #$0008
	sta.b $6D
	lda.w #$0000
CODE_C57F28:						; from CODE_C57F28
	sta.b $65
	jsr.w CODE_C57F39
	inc.b $6D
	lda.b $65
	inc a
	cmp.b $67
	bne CODE_C57F28
CODE_C57F36:						; from CODE_C57F39
	dec.b $6D
	rts
CODE_C57F39:						; from CODE_C57F28
	asl a
	tax
	lda.w $3E5E,x
	sta.b $6F
	tax
	ldy.w $3658,x
	beq CODE_C57F36
	ldx.w #$0010
	stx.b $CF
	ldx.w #$0060
	stx.b $D1
	adc.w #$3660
	tax
	ldy.b $6D
	jsr.w CODE_C57FBE
	lda.w #$00F0
	sta.b $D1
	ldx.b $6F
	lda.w $3650,x
	jsr.w CODE_C5B67A
	jsr.w CODE_C55EC7
	lda.w #$6220
	sta.w $04F5,x
	inx
	inx
	lda.w #$2079
	sta.w $04F5,x
	inx
	inx
	phx
	ldy.b $6F
	lda.w $3652,y
	and.w #$00FF
	tax
	jsr.w CODE_C580B7
	jsl.l CODE_C4C3BA
	ply
	jsr.w CODE_C57FC7
	lda.w #$7620
	sta.w $04F5,y
	iny
	iny
	lda.w #$2073
	sta.w $04F5,y
	iny
	iny
	phy
	ldy.b $6F
	lda.w $3653,y
	and.w #$00FF
	tax
	jsr.w CODE_C580B7
	jsl.l CODE_C4C3BA
	ply
	jsr.w CODE_C57FC7
	lda.w #$0000
	sta.w $04F5,y
	ldx.w #$04F5
	ldy.b $6D
CODE_C57FBE:						; from CODE_C57F39
	jsl.l CODE_C4BBF1
	lda.b $D1
	sta.b $CF
	rts
CODE_C57FC7:						; from CODE_C57F39
	sep #$20
CODE_C57FC9:						; from CODE_C57FC9
	lda.w $0000,x
	beq CODE_C57FD5
	sta.w $04F5,y
	inx
	iny
	bra CODE_C57FC9
CODE_C57FD5:						; from CODE_C57FC9
	rep #$20
	rts
CODE_C57FD8:						; from DATA8_C57DCD
	lda.w #$0010
	sta.b $CF
	lda.w #$0060
	sta.b $D1
	ldx.w #$4DA4
	jsr.w CODE_C580AB
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4B7A
	jsr.w CODE_C580AB
	lda.w #$0008
	sta.b $6D
	lda.w #$0000
CODE_C57FFB:						; from CODE_C57FFB
	sta.b $65
	jsr.w CODE_C5800C
	inc.b $6D
	lda.b $65
	inc a
	cmp.b $67
	bne CODE_C57FFB
	dec.b $6D
	rts

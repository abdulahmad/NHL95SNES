; Segment bankC4_F000: game code (routines keep their address as a name, with their callers), then sound
; sample 2 and zeros to the end of the bank.
org $C4F01E
CODE_C4F01E:						; from CODE_C4F2B6, CODE_C4F2D1 and other segments
	sty.b $9F
	stz.w $24DC
	lda.w $0000,y
	sta.b $A1
CODE_C4F028:						; from CODE_C4F028
	beq CODE_C4F05C
	dec a
	sta.b $A1
	asl a
	tay
	asl a
	asl a
	asl a
	asl a
	adc.b $9F
	tax
	lda.w $0110,x
	sta.w $04F5
	lda.w $0112,x
	sta.w $04F7
	lda.w $0114,x
	sta.w $04F9
	lda.w $0116,x
	sta.w $04FB
	jsl.l CODE_C5C6A2
	sta.w $364E,y
	lda.b $A1
	sta.w $368E,y
	bra CODE_C4F028
CODE_C4F05C:						; from CODE_C4F028
	lda.w #$FFFF
	sta.w $36CE
	ldx.w #$36CE
	ldy.w #$36D0
	lda.w #$00FD
	mvn $7E,$7E
	ldy.b $9F
	clc
	lda.w $0002,y
	adc.w $0004,y
	dec a
	asl a
	tax
	lda.w $0004,y
	sta.b $A1
	sta.b $A5
CODE_C4F081:						; from CODE_C4F081
	jsr.w CODE_C4F201
	dex
	dex
	dec.b $A1
	bne CODE_C4F081
	ldy.b $9F
	lda.w $0000,y
	dec a
	asl a
	tax
	lda.w $0006,y
	sta.b $A1
	sta.b $0A
CODE_C4F099:						; from CODE_C4F099
	jsr.w CODE_C4F240
	dex
	dex
	dec.b $A1
	bne CODE_C4F099
	lda.w #$0001
	sta.w $37CE
	lda.w $374E
	sta.w $37CF
	lda.w $3750
	sta.w $37D0
	lda.w $36D0
	sta.w $37D1
	lda.w $36CE
	sta.w $37D2
	lda.w $36D2
	sta.w $37D3
	lda.w $36D4
	sta.w $37D4
	stz.w $37D5
	lda.w #$0007
	ldx.w #$37CE
	ldy.w #$37D6
	mvn $7E,$7E
	stz.b $2C
	stz.b $2E
	lda.w #$0005
	sta.b $A1
	ldx.w #$37D6
	stx.b $14
	lda.w $0000,x
	and.w #$00FF
	jsr.w CODE_C4F1F8
	lda.w $0001,x
	and.w #$00FF
	jsr.w CODE_C4F1F8
	lda.w $0002,x
	and.w #$00FF
	jsr.w CODE_C4F1EF
	lda.w $0003,x
	and.w #$00FF
	jsr.w CODE_C4F1EF
	lda.w $0004,x
	and.w #$00FF
	jsr.w CODE_C4F1EF
	lda.w $0005,x
	and.w #$00FF
	jsr.w CODE_C4F1EF
CODE_C4F11F:						; from CODE_C4F128
	lda.b $14
	clc
	adc.w #$0008
	tax
	stx.b $14
CODE_C4F128:						; from CODE_C4F128
	stz.b $A3
	sep #$20
	jsr.w CODE_C4F197
	bcs CODE_C4F128
	sta.w $0001,x
	jsr.w CODE_C4F1F8
	stz.b $A3
	jsr.w CODE_C4F197
	bcs CODE_C4F128
	sta.w $0002,x
	jsr.w CODE_C4F1F8
	stz.b $A3
	jsr.w CODE_C4F1B4
	bcs CODE_C4F128
	sta.w $0003,x
	jsr.w CODE_C4F1EF
	stz.b $A3
	jsr.w CODE_C4F1B4
	bcs CODE_C4F128
	sta.w $0004,x
	jsr.w CODE_C4F1EF
	stz.b $A3
	jsr.w CODE_C4F1B4
	bcs CODE_C4F128
	sta.w $0005,x
	jsr.w CODE_C4F1EF
	stz.b $A3
	jsr.w CODE_C4F1B4
	bcs CODE_C4F128
	sta.w $0006,x
	jsr.w CODE_C4F1EF
	rep #$20
	lda.b $14
	dec.b $A1
	bpl CODE_C4F11F
	clc
	lda.b $9F
	adc.w #$006C
	tay
	ldx.w #$37CE
	lda.w #$003F
	mvn $7E,$7E
	rts
CODE_C4F191:						; from CODE_C4F197
	stz.b $2E
	ldx.b $14
	sec
	rts
CODE_C4F197:						; from CODE_C4F128, CODE_C4F197
	rep #$20
	lda.b $A3
	cmp.b $0A
	beq CODE_C4F191
	asl a
	tay
	sep #$20
	lda.w $374E,y
	jsr.w CODE_C4F1CB
	bcs CODE_C4F197
	ldx.b $14
	rts
CODE_C4F1AE:						; from CODE_C4F1B4
	stz.b $2C
	ldx.b $14
	sec
	rts
CODE_C4F1B4:						; from CODE_C4F128, CODE_C4F1B4
	rep #$20
	lda.b $A3
	cmp.b $A5
	beq CODE_C4F1AE
	asl a
	tay
	sep #$20
	lda.w $36CE,y
	jsr.w CODE_C4F1DE
	bcs CODE_C4F1B4
	ldx.b $14
	rts
CODE_C4F1CB:						; from CODE_C4F197
	inc.b $A3
	ldx.b $2E
	dex
	bmi CODE_C4F1DA
CODE_C4F1D2:						; from CODE_C4F1D2
	cmp.w $384E,x
	beq CODE_C4F1DC
	dex
	bpl CODE_C4F1D2
CODE_C4F1DA:						; from CODE_C4F1CB, CODE_C4F1DE
	clc
	rts
CODE_C4F1DC:						; from CODE_C4F1D2, CODE_C4F1E5
	sec
	rts
CODE_C4F1DE:						; from CODE_C4F1B4
	inc.b $A3
	ldx.b $2C
	dex
	bmi CODE_C4F1DA
CODE_C4F1E5:						; from CODE_C4F1E5
	cmp.w $380E,x
	beq CODE_C4F1DC
	dex
	bpl CODE_C4F1E5
	clc
	rts
CODE_C4F1EF:						; from CODE_C4F099, CODE_C4F128
	ldy.b $2C
	sta.w $380E,y
	iny
	sty.b $2C
	rts
CODE_C4F1F8:						; from CODE_C4F099, CODE_C4F128
	ldy.b $2E
	sta.w $384E,y
	iny
	sty.b $2E
	rts
CODE_C4F201:						; from CODE_C4F081
	ldy.w #$0000
CODE_C4F204:						; from CODE_C4F204
	lda.w $370E,y
	bmi CODE_C4F232
	cmp.w $364E,x
	bcc CODE_C4F212
	iny
	iny
	bra CODE_C4F204
CODE_C4F212:						; from CODE_C4F204
	phy
	phx
	sty.b $A3
	sec
	lda.w #$001D
	sbc.b $A3
	pha
	ldx.w #$372A
	ldy.w #$372C
	mvp $7E,$7E
	pla
	ldx.w #$36EA
	ldy.w #$36EC
	mvp $7E,$7E
	plx
	ply
CODE_C4F232:						; from CODE_C4F204
	lda.w $364E,x
	sta.w $370E,y
	lda.w $368E,x
	inc a
	sta.w $36CE,y
	rts
CODE_C4F240:						; from CODE_C4F099
	ldy.w #$0000
CODE_C4F243:						; from CODE_C4F243
	lda.w $378E,y
	bmi CODE_C4F271
	cmp.w $364E,x
	bcc CODE_C4F251
	iny
	iny
	bra CODE_C4F243
CODE_C4F251:						; from CODE_C4F243
	phy
	phx
	sty.b $A3
	sec
	lda.w #$001D
	sbc.b $A3
	pha
	ldx.w #$37AA
	ldy.w #$37AC
	mvp $7E,$7E
	pla
	ldx.w #$376A
	ldy.w #$376C
	mvp $7E,$7E
	plx
	ply
CODE_C4F271:						; from CODE_C4F243
	lda.w $364E,x
	sta.w $378E,y
	lda.w $368E,x
	inc a
	sta.w $374E,y
	rts
CODE_C4F27F:						; from CODE_C4F2B6, CODE_C4F2D1
	lda.w $0002,x
	cmp.w $0002,y
	bne CODE_C4F2AC
	lda.w $0004,x
	cmp.w $0004,y
	bne CODE_C4F2AC
	lda.w $0000,x
	cmp.w $0000,y
	bne CODE_C4F2AC
	dec a
	sta.b $9F
CODE_C4F29A:						; from CODE_C4F29A
	lda.w $003A,x
	cmp.w $003A,y
	bne CODE_C4F2AC
	inx
	inx
	iny
	iny
	dec.b $9F
	bpl CODE_C4F29A
	clc
	rts
CODE_C4F2AC:						; from CODE_C4F27F, CODE_C4F29A
	sec
	rts
CODE_C4F2AE:						; called from other segments
	lda.w $1864
	cmp.w #$0002
	bcc CODE_C4F2EE
CODE_C4F2B6:						; from CODE_C4F2F6
	lda.w $17C9
	ldy.w #$364E
	jsl.l CODE_C52CA7
	ldy.w #$2DC9
	ldx.w #$364E
	jsr.w CODE_C4F27F
	bcc CODE_C4F2D1
	ldy.w #$2DC9
	jsr.w CODE_C4F01E
CODE_C4F2D1:						; from CODE_C4F2B6
	lda.w $17CB
	ldy.w #$364E
	jsl.l CODE_C52CA7
	ldy.w #$3207
	ldx.w #$364E
	jsr.w CODE_C4F27F
	bcc CODE_C4F2FB
	ldy.w #$3207
	jsr.w CODE_C4F01E
	bra CODE_C4F2FB
CODE_C4F2EE:						; from CODE_C4F2AE
	lda.w $1864
	beq CODE_C4F2F6
	dec a
	bne CODE_C4F2FB
CODE_C4F2F6:						; from CODE_C4F2EE
	lda.w $1872
	bne CODE_C4F2B6
CODE_C4F2FB:						; from CODE_C4F2D1, CODE_C4F2EE
	rts
Sample02:							; sound sample 2 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC4_F000.bin":$2FC..$A58
	padbyte $00						; unused to the end of the bank
	pad $C50000

; Segment bankC3_8000: the rest of bank $C3's game code (routines keep their address as a name, with their
; callers) and the data tables it reads; the sound samples start after it.
org $C37FE2
CODE_C37FE2:						; called from other segments
	phx
	tay
	lda.w $0856,y
	asl a
	tax
	lda.l DATA8_CE0192,x
	eor.w #$FFFF
	inc a
	sta.b $83
	lda.w $08E0,y
	bit.w #$0800
	beq CODE_C38007
	lda.l DATA8_CDF94A,x
	eor.w #$FFFF
	inc a
	sta.b $7F
	plx
	rtl
CODE_C38007:						; from CODE_C37FE2
	lda.l DATA8_CDF94A,x
	sta.b $7F
	plx
	rtl
CODE_C3800F:						; no caller found (not traced)
	lda.b $7F
	sec
	sbc.b $CB
	sta.b $7F
	lda.b $83
	sec
	sbc.b $CD
	sta.b $83
	lda.b $7F
	clc
	adc.w #$0080
	sta.b $7F
	lda.b $87
	asl a
	clc
	adc.b $87
	pha
	asl a
	pla
	ror a
	clc
	adc.b $83
	sta.b $83
	lda.w #$005E
	sec
	sbc.b $83
	sta.b $83
	rtl
DATA8_C3803D:						; not traced: data between routines
	db $A9,$20,$4E,$85,$83,$6B
CODE_C38043:						; called from other segments
	txa
	lsr a
	ldy.b $8F
	sta.w $05AE,y
	rtl
DATA8_C3804B:						; not traced: data between routines
	db $6B,$6B
CODE_C3804D:						; no caller found (not traced)
	sta.w $04C9
	stx.w $04CB
	sty.w $04CD
	lda.w #$FFFF
	sta.w $04CF
	sta.w $04D1
	sta.w $04D3
	lda.w #$00C4
	sta.w $04BA
	lda.w #$8075
	ldx.w #$00C3
	ldy.w $04C9
	jml.l SetIRQ
DATA8_C38075:						; not traced: data between routines
	db $E2,$20,$AD,$CF,$04,$8F,$0E,$21,$00,$AD,$D0,$04,$8F,$0E,$21,$00
	db $C2,$20,$A9,$98,$80,$8D,$AD,$04,$AD,$CB,$04,$8F,$09,$42,$00,$A9
	db $FF,$FF,$6B,$E2,$20,$AD,$D1,$04,$8F,$0E,$21,$00,$AD,$D2,$04,$8F
	db $0E,$21,$00,$C2,$20,$A9,$B8,$80,$8D,$AD,$04,$AD,$CD,$04,$8F,$09
	db $42,$00,$6B,$E2,$20,$AD,$D3,$04,$8F,$0E,$21,$00,$AD,$D4,$04,$8F
	db $0E,$21,$00,$C2,$20,$A9,$75,$80,$8D,$AD,$04,$6B
CODE_C380D1:						; called from other segments
	lda.w $1864
	cmp.w #$0001
	bne CODE_C380DA
	rtl
CODE_C380DA:						; from CODE_C380D1
	phx
	phy
	pei ($81)
	pei ($7F)
	pei ($65)
	pei ($63)
	pei ($69)
	pei ($67)
	pei ($6D)
	pei ($6B)
	lda.w #$FFFF
	sta.w $2CE3
	sta.w $2CE5
	sta.w $2CE7
	jsr.w CODE_C381D5
	ldy.w $114B
	lda.w #$584C
	cpy.w #$0003
	bne CODE_C3810E
	ldy.w $114D
	beq CODE_C3810E
	lda.w #$59AC
CODE_C3810E:						; from CODE_C380DA
	ldx.w #$0013
	ldy.w #$0005
	jsl.l CODE_C58C36
	lda.w $114B
	ldy.w #$586D
	cmp.w #$0003
	bne CODE_C3812B
	lda.w $114D
	beq CODE_C3812B
	ldy.w #$59CD
CODE_C3812B:						; from CODE_C3810E
	ldx.w #$00C3
	lda.w #$5A14
	jsl.l QueueVRAMDMALen
	lda.w #$588D
	ldy.w $114B
	cpy.w #$0003
	bne CODE_C38148
	ldy.w $114D
	beq CODE_C38148
	lda.w #$59ED
CODE_C38148:						; from CODE_C3812B
	sta.b $63
	ldx.w $2CE3
	bmi CODE_C38162
	jsr.w CODE_C3817D
	ldx.w $2CE5
	bmi CODE_C38162
	jsr.w CODE_C3817D
	ldx.w $2CE7
	bmi CODE_C38162
	jsr.w CODE_C3817D
CODE_C38162:						; from CODE_C38148
	pla
	sta.b $6B
	pla
	sta.b $6D
	pla
	sta.b $67
	pla
	sta.b $69
	pla
	sta.b $63
	pla
	sta.b $65
	pla
	sta.b $7F
	pla
	sta.b $81
	ply
	plx
	rtl
CODE_C3817D:						; from CODE_C38148
	stx.b $65
	lda.w #$0000
	cpx.w #$001A
	bcc CODE_C38188
	inc a
CODE_C38188:						; from CODE_C3817D
	jsl.l CODE_C56100
	jsl.l CODE_C4C3AE
	jsl.l CODE_C5625E
	txa
	ldx.w #$007E
	ldy.b $63
	jsl.l QueueVRAMDMALen
	lda.b $65
	asl a
	asl a
	asl a
	asl a
	asl a
	cmp.w #$0340
	bcc CODE_C381AF
	adc.w #$2FDE
	bra CODE_C381B2
CODE_C381AF:						; from CODE_C38188
	adc.w #$2EE1
CODE_C381B2:						; from CODE_C38188
	tax
	lda.w #$000D
	jsl.l CODE_C55F8A
	jsl.l CODE_C5625E
	txa
	ldx.w #$007E
	ldy.b $63
	iny
	iny
	iny
	iny
	jsl.l QueueVRAMDMALen
	lda.b $63
	clc
	adc.w #$0020
	sta.b $63
	rts
CODE_C381D5:						; from CODE_C380DA
	ldx.w $2DC9
CODE_C381D8:						; from CODE_C381D8
	dex
	txa
	jsr.w CODE_C381F4
	cpx.w $2DCB
	bcs CODE_C381D8
	ldx.w $3207
CODE_C381E5:						; from CODE_C381E5
	dex
	txa
	clc
	adc.w #$001A
	jsr.w CODE_C381F4
	cpx.w $3209
	bcs CODE_C381E5
	rts
CODE_C381F4:						; from CODE_C381D8, CODE_C381E5
	tay
	lda.w $1413,y
	and.w #$00FF
	sta.b $9F
	lda.w $1447,y
	and.w #$00FF
	sta.b $A1
	clc
	adc.b $9F
	sta.b $A3
	lda.w $2CE3
	bmi CODE_C38256
	clc
	lda.w $2CE9
	adc.w $2CEB
	cmp.b $A3
	bcc CODE_C38256
	bne CODE_C38223
	lda.w $2CE9
	cmp.b $9F
	bcc CODE_C38256
CODE_C38223:						; from CODE_C381F4
	lda.w $2CE5
	bmi CODE_C38288
	clc
	lda.w $2CED
	adc.w $2CEF
	cmp.b $A3
	bcc CODE_C38288
	bne CODE_C3823C
	lda.w $2CED
	cmp.b $9F
	bcc CODE_C38288
CODE_C3823C:						; from CODE_C38223
	lda.w $2CE7
	bmi CODE_C382A8
	clc
	lda.w $2CF1
	adc.w $2CF3
	cmp.b $A3
	bcc CODE_C382A8
	bne CODE_C38255
	lda.w $2CF1
	cmp.b $9F
	bcc CODE_C382A8
CODE_C38255:						; from CODE_C3823C
	rts
CODE_C38256:						; from CODE_C381F4
	lda.w $2CE5
	sta.w $2CE7
	lda.w $2CE3
	sta.w $2CE5
	lda.w $2CED
	sta.w $2CF1
	lda.w $2CE9
	sta.w $2CED
	lda.w $2CEF
	sta.w $2CF3
	lda.w $2CEB
	sta.w $2CEF
	sty.w $2CE3
	lda.b $9F
	sta.w $2CE9
	lda.b $A1
	sta.w $2CEB
	rts
CODE_C38288:						; from CODE_C38223
	lda.w $2CE5
	sta.w $2CE7
	lda.w $2CED
	sta.w $2CF1
	lda.w $2CEF
	sta.w $2CF3
	sty.w $2CE5
	lda.b $9F
	sta.w $2CED
	lda.b $A1
	sta.w $2CEF
	rts
CODE_C382A8:						; from CODE_C3823C
	sty.w $2CE7
	lda.b $9F
	sta.w $2CF1
	lda.b $A1
	sta.w $2CF3
	rts
CODE_C382B6:						; called from other segments
	rtl
CODE_C382B7:						; called from other segments
	rtl
CODE_C382B8:						; called from other segments
	lda.b $48
	lsr a
	bcc CODE_C382C0
	jmp.w CODE_C38359
CODE_C382C0:						; from CODE_C382B8
	lda.w $0862
	cmp.w $0882
	beq CODE_C382D9
	ldx.w #$2100
	stx.b $A3
	ldx.w #$2018
	stx.b $A1
	sta.w $0882
	jsl.l CODE_C5F368
CODE_C382D9:						; from CODE_C382C0
	lda.w $0864
	cmp.w $0884
	beq CODE_C382F2
	ldx.w #$2108
	stx.b $A3
	ldx.w #$201C
	stx.b $A1
	sta.w $0884
	jsl.l CODE_C5F368
CODE_C382F2:						; from CODE_C382D9
	lda.w $0866
	cmp.w $0886
	beq CODE_C3830B
	ldx.w #$2120
	stx.b $A3
	ldx.w #$2020
	stx.b $A1
	sta.w $0886
	jsl.l CODE_C5F368
CODE_C3830B:						; from CODE_C382F2
	lda.w $0868
	cmp.w $0888
	beq CODE_C38324
	ldx.w #$2128
	stx.b $A3
	ldx.w #$2024
	stx.b $A1
	sta.w $0888
	jsl.l CODE_C5F368
CODE_C38324:						; from CODE_C3830B
	lda.w $086A
	cmp.w $088A
	beq CODE_C3833D
	ldx.w #$2140
	stx.b $A3
	ldx.w #$2028
	stx.b $A1
	sta.w $088A
	jsl.l CODE_C5F368
CODE_C3833D:						; from CODE_C38324
	lda.w $086C
	cmp.w $088C
	beq CODE_C38356
	ldx.w #$2148
	stx.b $A3
	ldx.w #$202C
	stx.b $A1
	sta.w $088C
	jsl.l CODE_C5F368
CODE_C38356:						; from CODE_C3833D
	jmp.w CODE_C383EF
CODE_C38359:						; from CODE_C382B8
	lda.w $0856
	cmp.w $0876
	beq CODE_C38372
	ldx.w #$20A0
	stx.b $A3
	ldx.w #$2000
	stx.b $A1
	sta.w $0876
	jsl.l CODE_C5F368
CODE_C38372:						; from CODE_C38359
	lda.w $0858
	cmp.w $0878
	beq CODE_C3838B
	ldx.w #$20A8
	stx.b $A3
	ldx.w #$2004
	stx.b $A1
	sta.w $0878
	jsl.l CODE_C5F368
CODE_C3838B:						; from CODE_C38372
	lda.w $085A
	cmp.w $087A
	beq CODE_C383A4
	ldx.w #$20C0
	stx.b $A3
	ldx.w #$2008
	stx.b $A1
	sta.w $087A
	jsl.l CODE_C5F368
CODE_C383A4:						; from CODE_C3838B
	lda.w $085C
	cmp.w $087C
	beq CODE_C383BD
	ldx.w #$20C8
	stx.b $A3
	ldx.w #$200C
	stx.b $A1
	sta.w $087C
	jsl.l CODE_C5F368
CODE_C383BD:						; from CODE_C383A4
	lda.w $085E
	cmp.w $087E
	beq CODE_C383D6
	ldx.w #$20E0
	stx.b $A3
	ldx.w #$2010
	stx.b $A1
	sta.w $087E
	jsl.l CODE_C5F368
CODE_C383D6:						; from CODE_C383BD
	lda.w $0860
	cmp.w $0880
	beq CODE_C383EF
	ldx.w #$20E8
	stx.b $A3
	ldx.w #$2014
	stx.b $A1
	sta.w $0880
	jsl.l CODE_C5F368
CODE_C383EF:						; from CODE_C38356, CODE_C383D6
	lda.w $0872
	cmp.w $0892
	beq CODE_C38403
	ldx.w #$2034
	stx.b $A1
	sta.w $0892
	jsl.l CODE_C5F368
CODE_C38403:						; from CODE_C383EF
	dec.b QueueBusy
	tsc
	sta.b $1C
	lda.b $28
	tcs
	ldy.b $2A
	lda.w #$EE1D
	sta.b $A5
	ldx.w #$000F
CODE_C38415:						; from CODE_C3846C
	lda.w $10E0,x
	stx.b $1A
	and.w #$00FF
	tax
	clc
	lda.w $0814,x
	adc.w #$0080
	sec
	sbc.b $CB
	sta.b $0A
	sec
	lda.b $CD
	sbc.w $0896,x
	clc
	adc.w #$005E
	sta.b $0C
	lda.w $08E0,x
	and.w #$0800
	beq CODE_C38455
	lda.l DATA8_C384BC,x
	sta.b $A1
	lda.l DATA8_C384DC,x
	sta.b $A3
	lda.w $0876,x
	bmi CODE_C3846C
	beq CODE_C3846C
	jml.l CODE_CFEE25
CODE_C38455:						; from CODE_C38415
	lda.l DATA8_C3847C,x
	sta.b $A1
	lda.l DATA8_C3849C,x
	sta.b $A3
	lda.w $0876,x
	bmi CODE_C3846C
	beq CODE_C3846C
	jml.l CODE_CFEE6C
CODE_C3846C:						; from CODE_C38415, CODE_C38455 and other segments
	ldx.b $1A
	dex
	bpl CODE_C38415
	tsc
	sta.b $28
	lda.b $1C
	tcs
	sty.b $2A
	stz.b QueueBusy
	rtl
DATA8_C3847C:						; not traced: a table read by CODE_C38455
	db $00,$20,$04,$20,$08,$20,$0C,$20,$10,$20,$14,$20,$18,$22,$1C,$22
	db $20,$22,$24,$22,$28,$22,$2C,$22,$30,$20,$30,$20,$34,$20,$35,$20
DATA8_C3849C:						; not traced: a table read by CODE_C38455
	db $A0,$20,$A8,$20,$C0,$20,$C8,$20,$E0,$20,$E8,$20,$00,$23,$08,$23
	db $20,$23,$28,$23,$40,$23,$48,$23,$60,$21,$68,$21,$80,$21,$80,$35
DATA8_C384BC:						; not traced: a table read by CODE_C38415
	db $00,$60,$04,$60,$08,$60,$0C,$60,$10,$60,$14,$60,$18,$62,$1C,$62
	db $20,$62,$24,$62,$28,$62,$2C,$62,$30,$60,$30,$60,$34,$60,$35,$60
DATA8_C384DC:						; not traced: a table read by CODE_C38415
	db $A0,$60,$A8,$60,$C0,$60,$C8,$60,$E0,$60,$E8,$60,$00,$63,$08,$63
	db $20,$63,$28,$63,$40,$63,$48,$63,$60,$61,$68,$61,$80,$61,$80,$75
CODE_C384FC:						; from CODE_C3863A and other segments
	phx
	phy
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	ldx.w #$0000
CODE_C3850D:						; from CODE_C3850D
	lda.w $0896,x
	sta.w $10A0,x
	inx
	inx
	cpx.w #$0020
	bne CODE_C3850D
CODE_C3851A:						; from CODE_C3854F
	stz.b $87
	ldx.w #$0000
CODE_C3851F:						; from CODE_C3854F
	lda.w $10E1,x
	and.w #$00FF
	sta.b $83
	lda.w $10E0,x
	and.w #$00FF
	sta.b $7F
	tay
	lda.w $10A0,y
	ldy.b $83
	cmp.w $10A0,y
	bmi CODE_C3854F
	beq CODE_C3854F
	lda.w $10E0,x
	xba
	sta.w $10E0,x
	txa
	sta.w $10C0,y
	inc a
	ldy.b $7F
	sta.w $10C0,y
	inc.b $87
CODE_C3854F:						; from CODE_C3851F
	inx
	cpx.w #$000F
	bne CODE_C3851F
	lda.b $87
	bne CODE_C3851A
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
	ply
	plx
	rtl
CODE_C3856E:						; called from other segments
	ldx.w #$0000
CODE_C38571:						; from CODE_C38571
	stz.w $0814,x
	inx
	inx
	cpx.w #$07CC
	bne CODE_C38571
	stz.b $97
	stz.b $67
	stz.b $6B
	stz.b $6F
	stz.b $73
CODE_C38585:						; from CODE_C38609
	ldx.b $6B
	ldy.b $6F
	lda.b $97
	sta.w $0C20,y
	lda.w #$FFFF
	sta.w $0900,y
	sta.w $0876,y
	sta.w $0DC0,y
	lda.l DATA8_C38658,x
	sta.w $0814,y
	lda.l DATA8_C3865A,x
	sta.w $0896,y
	lda.l DATA8_C3865E,x
	sta.w $0856,y
	lda.l DATA8_C38660,x
	sta.w $08E0,y
	lda.l DATA8_C38662,x
	sta.w $0BA0,y
	lda.l DATA8_C38664,x
	sta.w $0BC0,y
	lda.b $97
	asl a
	asl a
	asl a
	tay
	lda.l DATA8_C38666,x
	sta.w $0A60,y
	ldy.b $6F
	sta.w $0644,y
	lda.l DATA8_C38668,x
	sta.w $0D60,y
	lda.w #$0000
	sta.w $1080,y
	cpy.w #$001E
	bne CODE_C385EE
	lda.w #$0001
	sta.w $1080,y
CODE_C385EE:						; from CODE_C38585
	cpx.w #$006C
	rol a
	inc a
	and.w #$0001
	sta.w $0FE0,y
	cpx.w #$006C
	bcc CODE_C38609
	cpx.w #$00D8
	bcs CODE_C38609
	lda.w #$0034
	sta.w $1020,y
CODE_C38609:						; from CODE_C385EE
	inc.b $6F
	inc.b $6F
	sep #$20
	lda.b $97
	asl a
	ldy.b $67
	sta.w $10E0,y
	inc.b $67
	rep #$30
	ldy.b $73
	lda.b $97
	sta.w $10C0,y
	inc.b $73
	inc.b $73
	inc.b $97
	lda.b $6B
	clc
	adc.w #$0012
	sta.b $6B
	lda.b $97
	cmp.w #$0010
	beq CODE_C3863A
	jmp.w CODE_C38585
CODE_C3863A:						; from CODE_C38609
	lda.w #$FFFF
	sta.w $0A38
	sta.w $0A3A
	lda.w $086E
	sta.w $088E
	lda.w $0870
	sta.w $0890
	lda.w $0874
	sta.w $0894
	jmp.w CODE_C384FC
DATA8_C38658:						; not traced: a table read by CODE_C38585
	db $60,$01
DATA8_C3865A:						; not traced: a table read by CODE_C38585
	db $C0,$00,$00,$00
DATA8_C3865E:						; not traced: a table read by CODE_C38585
	db $01,$00
DATA8_C38660:						; not traced: a table read by CODE_C38585
	db $00,$00
DATA8_C38662:						; not traced: a table read by CODE_C38585
	db $08,$00
DATA8_C38664:						; not traced: a table read by CODE_C38585
	db $04,$00
DATA8_C38666:						; not traced: a table read by CODE_C38585
	db $00,$00
DATA8_C38668:						; not traced: a table read by CODE_C38585
	db $00,$00,$38,$FF,$9C,$FF,$00,$00,$01,$00,$00,$00,$08,$00,$04,$00
	db $00,$00,$00,$00,$38,$FF,$B0,$FF,$00,$00,$01,$00,$00,$00,$08,$00
	db $04,$00,$00,$00,$00,$00,$38,$FF,$C4,$FF,$00,$00,$01,$00,$00,$00
	db $08,$00,$04,$00,$00,$00,$00,$00,$38,$FF,$D8,$FF,$00,$00,$01,$00
	db $00,$00,$08,$00,$04,$00,$00,$00,$00,$00,$38,$FF,$EC,$FF,$00,$00
	db $01,$00,$00,$00,$08,$00,$04,$00,$00,$00,$00,$00,$C0,$00,$C0,$00
	db $00,$00,$01,$00,$01,$00,$08,$00,$04,$00,$00,$00,$00,$00,$38,$FF
	db $28,$00,$00,$00,$01,$00,$01,$00,$08,$00,$04,$00,$00,$00,$00,$00
	db $38,$FF,$3C,$00,$00,$00,$01,$00,$01,$00,$08,$00,$04,$00,$00,$00
	db $00,$00,$38,$FF,$50,$00,$00,$00,$01,$00,$01,$00,$08,$00,$04,$00
	db $00,$00,$00,$00,$38,$FF,$64,$00,$00,$00,$01,$00,$01,$00,$08,$00
	db $04,$00,$00,$00,$00,$00,$38,$FF,$78,$00,$00,$00,$01,$00,$01,$00
	db $08,$00,$04,$00,$00,$00,$00,$00,$00,$00,$17,$01,$00,$00,$BE,$01
	db $00,$00,$16,$00,$0A,$00,$00,$00,$00,$00,$00,$00,$E8,$FE,$00,$00
	db $BF,$01,$00,$00,$17,$00,$0A,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$B4,$01,$00,$00,$05,$00,$05,$00,$18,$00,$01,$00,$00,$00
	db $00,$00,$00,$00,$B3,$01,$00,$00,$03,$00,$03,$00,$19,$00,$00,$00
CODE_C38778:						; called from other segments
	cmp.w #$0000
	bpl CODE_C38781
	eor.w #$FFFF
	inc a
CODE_C38781:						; from CODE_C38778
	sta.b $9F
	tya
	bpl CODE_C3878A
	eor.w #$FFFF
	inc a
CODE_C3878A:						; from CODE_C38781
	cmp.b $9F
	bcs CODE_C38793
	lsr a
	clc
	adc.b $9F
	rtl
CODE_C38793:						; from CODE_C3878A
	lsr.b $9F
	clc
	adc.b $9F
	rtl
CODE_C38799:						; called from other segments
	ldx.w #$0000
CODE_C3879C:						; from CODE_C387C3
	sec
	lda.w $0830
	sbc.w $0814,x
	sta.b $7F
	bpl CODE_C387AC
	eor.w #$FFFF
	inc a
	sec
CODE_C387AC:						; from CODE_C3879C
	sta.b $40
	lda.w $08B2
	sbc.w $0896,x
	sta.b $83
	bpl CODE_C387BC
	eor.w #$FFFF
	inc a
CODE_C387BC:						; from CODE_C387AC
	cmp.b $40
	bcc CODE_C387C3
	lsr.b $40
	asl a
CODE_C387C3:						; from CODE_C387BC
	lsr a
	adc.b $40
	sta.w $05E4,x
	jsl.l CODE_C37F6D
	sta.w $0624,x
	inx
	inx
	cpx.w #$0020
	bcc CODE_C3879C
	rtl
CODE_C387D8:						; called from other segments
	lda.w #$0080
	sta.l VMAIN
	txa
	sta.l VMADDL
	jsl.l CODE_C387F2
	tay
	txa
	clc
	adc.w #$0020
	sta.l VMADDL
CODE_C387F2:						; from CODE_C387D8 and other segments
	tya
	ldy.w #$0008
CODE_C387F6:						; from CODE_C387F6
	sta.l VMDATAL
	inc a
	dey
	bpl CODE_C387F6
	rtl
CODE_C387FF:						; called from other segments
	lda.w #$01FE
	jsl.l CODE_C4C558
	sta.w $3648
	tay
	lda.w #$0210
	jsl.l CODE_C4C558
	lda.w #$01FD
	ldx.w #$1912
	mvn $7E,$7E
	lda.w #$020F
	ldx.w #$46A8
	mvn $7E,$7E
	rtl
CODE_C38824:						; called from other segments
	stx.w $05A0
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	inx
	inx
	rtl
DATA8_C3884A:						; not traced: a table read by CODE_C44BF1, CODE_C44C5D, CODE_C44DC7
	db $00,$00,$01,$00,$04,$00,$09,$00,$10,$00,$19,$00,$24,$00,$31,$00
	db $40,$00,$51,$00,$64,$00,$79,$00,$90,$00,$A9,$00,$C4,$00,$E1,$00
	db $00,$01,$21,$01,$44,$01,$69,$01,$90,$01,$B9,$01,$E4,$01,$11,$02
	db $40,$02,$71,$02,$A4,$02,$D9,$02,$10,$03,$49,$03,$84,$03,$C1,$03
	db $00,$04,$41,$04,$84,$04,$C9,$04,$10,$05,$59,$05,$A4,$05,$F1,$05
	db $40,$06,$91,$06,$E4,$06,$39,$07,$90,$07,$E9,$07,$44,$08,$A1,$08
	db $00,$09,$61,$09,$C4,$09,$29,$0A,$90,$0A,$F9,$0A,$64,$0B,$D1,$0B
	db $40,$0C,$B1,$0C,$24,$0D,$99,$0D,$10,$0E,$89,$0E,$04,$0F,$81,$0F
	db $00,$10,$81,$10,$04,$11,$89,$11,$10,$12,$99,$12,$24,$13,$B1,$13
	db $40,$14,$D1,$14,$64,$15,$F9,$15,$90,$16,$29,$17,$C4,$17,$61,$18
	db $00,$19,$A1,$19,$44,$1A,$E9,$1A,$90,$1B,$39,$1C,$E4,$1C,$91,$1D
	db $40,$1E,$F1,$1E,$A4,$1F,$59,$20,$10,$21,$C9,$21,$84,$22,$41,$23
	db $00,$24,$C1,$24,$84,$25,$49,$26,$10,$27,$D9,$27,$A4,$28,$71,$29
	db $40,$2A,$11,$2B,$E4,$2B,$B9,$2C,$90,$2D,$69,$2E,$44,$2F,$21,$30
	db $00,$31,$E1,$31,$C4,$32,$A9,$33,$90,$34,$79,$35,$64,$36,$51,$37
	db $40,$38,$31,$39,$24,$3A,$19,$3B,$10,$3C,$09,$3D,$04,$3E,$01,$3F
	db $00,$40,$01,$41,$04,$42,$09,$43,$10,$44,$19,$45,$24,$46,$31,$47
	db $40,$48,$51,$49,$64,$4A,$79,$4B,$90,$4C,$A9,$4D,$C4,$4E,$E1,$4F
	db $00,$51,$21,$52,$44,$53,$69,$54,$90,$55,$B9,$56,$E4,$57,$11,$59
	db $40,$5A,$71,$5B,$A4,$5C,$D9,$5D,$10,$5F,$49,$60,$84,$61,$C1,$62
	db $00,$64,$41,$65,$84,$66,$C9,$67,$10,$69,$59,$6A,$A4,$6B,$F1,$6C
	db $40,$6E,$91,$6F,$E4,$70,$39,$72,$90,$73,$E9,$74,$44,$76,$A1,$77
	db $00,$79,$61,$7A,$C4,$7B,$29,$7D,$90,$7E,$F9,$7F,$64,$81,$D1,$82
	db $40,$84,$B1,$85,$24,$87,$99,$88,$10,$8A,$89,$8B,$04,$8D,$81,$8E
	db $00,$90,$81,$91,$04,$93,$89,$94,$10,$96,$99,$97,$24,$99,$B1,$9A
	db $40,$9C,$D1,$9D,$64,$9F,$F9,$A0,$90,$A2,$29,$A4,$C4,$A5,$61,$A7
	db $00,$A9,$A1,$AA,$44,$AC,$E9,$AD,$90,$AF,$39,$B1,$E4,$B2,$91,$B4
	db $40,$B6,$F1,$B7,$A4,$B9,$59,$BB,$10,$BD,$C9,$BE,$84,$C0,$41,$C2
	db $00,$C4,$C1,$C5,$84,$C7,$49,$C9,$10,$CB,$D9,$CC,$A4,$CE,$71,$D0
	db $40,$D2,$11,$D4,$E4,$D5,$B9,$D7,$90,$D9,$69,$DB,$44,$DD,$21,$DF
	db $00,$E1,$E1,$E2,$C4,$E4,$A9,$E6,$90,$E8,$79,$EA,$64,$EC,$51,$EE
	db $40,$F0,$31,$F2,$24,$F4,$19,$F6,$10,$F8,$09,$FA,$04,$FC,$01,$FE
DATA8_C38A4A:						; not traced: a table read by CODE_C37684, CODE_C45BD2, CODE_C45E1C, ...
	db $00,$00,$01,$00,$04,$00,$09,$00,$10,$00,$19,$00,$24,$00,$31,$00
	db $40,$00,$51,$00,$64,$00,$79,$00,$90,$00,$A9,$00,$C4,$00,$E1,$00
	db $00,$01,$21,$01,$44,$01,$69,$01,$90,$01,$B9,$01,$E4,$01,$11,$02
	db $40,$02,$71,$02,$A4,$02,$D9,$02,$10,$03,$49,$03,$84,$03,$C1,$03
	db $00,$04,$41,$04,$84,$04,$C9,$04,$10,$05,$59,$05,$A4,$05,$F1,$05
	db $40,$06,$91,$06,$E4,$06,$39,$07,$90,$07,$E9,$07,$44,$08,$A1,$08
	db $00,$09,$61,$09,$C4,$09,$29,$0A,$90,$0A,$F9,$0A,$64,$0B,$D1,$0B
	db $40,$0C,$B1,$0C,$24,$0D,$99,$0D,$10,$0E,$89,$0E,$04,$0F,$81,$0F
	db $00,$10,$81,$10,$04,$11,$89,$11,$10,$12,$99,$12,$24,$13,$B1,$13
	db $40,$14,$D1,$14,$64,$15,$F9,$15,$90,$16,$29,$17,$C4,$17,$61,$18
	db $00,$19,$A1,$19,$44,$1A,$E9,$1A,$90,$1B,$39,$1C,$E4,$1C,$91,$1D
	db $40,$1E,$F1,$1E,$A4,$1F,$59,$20,$10,$21,$C9,$21,$84,$22,$41,$23
	db $00,$24,$C1,$24,$84,$25,$49,$26,$10,$27,$D9,$27,$A4,$28,$71,$29
	db $40,$2A,$11,$2B,$E4,$2B,$B9,$2C,$90,$2D,$69,$2E,$44,$2F,$21,$30
	db $00,$31,$E1,$31,$C4,$32,$A9,$33,$90,$34,$79,$35,$64,$36,$51,$37
	db $40,$38,$31,$39,$24,$3A,$19,$3B,$10,$3C,$09,$3D,$04,$3E,$01,$3F
	db $00,$40,$01,$3F,$04,$3E,$09,$3D,$10,$3C,$19,$3B,$24,$3A,$31,$39
	db $40,$38,$51,$37,$64,$36,$79,$35,$90,$34,$A9,$33,$C4,$32,$E1,$31
	db $00,$31,$21,$30,$44,$2F,$69,$2E,$90,$2D,$B9,$2C,$E4,$2B,$11,$2B
	db $40,$2A,$71,$29,$A4,$28,$D9,$27,$10,$27,$49,$26,$84,$25,$C1,$24
	db $00,$24,$41,$23,$84,$22,$C9,$21,$10,$21,$59,$20,$A4,$1F,$F1,$1E
	db $40,$1E,$91,$1D,$E4,$1C,$39,$1C,$90,$1B,$E9,$1A,$44,$1A,$A1,$19
	db $00,$19,$61,$18,$C4,$17,$29,$17,$90,$16,$F9,$15,$64,$15,$D1,$14
	db $40,$14,$B1,$13,$24,$13,$99,$12,$10,$12,$89,$11,$04,$11,$81,$10
	db $00,$10,$81,$0F,$04,$0F,$89,$0E,$10,$0E,$99,$0D,$24,$0D,$B1,$0C
	db $40,$0C,$D1,$0B,$64,$0B,$F9,$0A,$90,$0A,$29,$0A,$C4,$09,$61,$09
	db $00,$09,$A1,$08,$44,$08,$E9,$07,$90,$07,$39,$07,$E4,$06,$91,$06
	db $40,$06,$F1,$05,$A4,$05,$59,$05,$10,$05,$C9,$04,$84,$04,$41,$04
	db $00,$04,$C1,$03,$84,$03,$49,$03,$10,$03,$D9,$02,$A4,$02,$71,$02
	db $40,$02,$11,$02,$E4,$01,$B9,$01,$90,$01,$69,$01,$44,$01,$21,$01
	db $00,$01,$E1,$00,$C4,$00,$A9,$00,$90,$00,$79,$00,$64,$00,$51,$00
	db $40,$00,$31,$00,$24,$00,$19,$00,$10,$00,$09,$00,$04,$00,$01,$00
CODE_C38C4A:						; called from other segments
	lda.w $1145
	bmi CODE_C38C6C
	sec
	sbc.b $9B
	sta.w $1145
	bpl CODE_C38C5B
	jsl.l CODE_C38C95
CODE_C38C5B:						; from CODE_C38C4A
	lda.w $1143
	sec
	sbc.b $9B
	sta.w $1143
	bpl CODE_C38C6C
	lda.w #$7FFF
	sta.w $1143
CODE_C38C6C:						; from CODE_C38C4A, CODE_C38C5B
	rtl
CODE_C38C6D:						; called from other segments
	lda.b $7F
	sta.w $1149
	stz.w $1147
	jsl.l CODE_C481D5
	lda.b $7F
	cmp.w #$000E
	bne CODE_C38C84
	jsl.l CODE_C51825
CODE_C38C84:						; from CODE_C38C6D
	lda.w #$7FFF
	sta.w $1143
	lda.w $2CF5
	beq CODE_C38C95
	lda.w #$003C
	sta.w $1143
CODE_C38C95:						; from CODE_C38C4A, CODE_C38C84 and other segments
	phx
	lda.w $1147
	bpl CODE_C38CAB
	lda.w $189C
	beq CODE_C38CA6
	lda.w #$0001
	sta.w $189E
CODE_C38CA6:						; from CODE_C38C95
	lda.w $1147
	plx
	rtl
CODE_C38CAB:						; from CODE_C38C95
	sta.b $9F
	inc a
	inc a
	sta.w $1147
	ldx.w $1149
	beq CODE_C38CF3
	lda.l DATA8_C34499,x
	tax
	lda.l DATA8_C3449B,x
	and.w #$00FF
	sec
	adc.b $9F
	stx.b $9F
	sec
	adc.b $9F
	tax
	lda.l DATA8_C3449A,x
	bpl CODE_C38CDC
	eor.w #$FFFF
	inc a
	ldx.w #$FFFF
	stx.w $1147
CODE_C38CDC:						; from CODE_C38CAB
	sta.b $9F
	and.w #$00FF
	asl a
	asl a
	asl a
	sta.w $1145
	lda.b $9F
	xba
	and.w #$00FF
	sta.b $9F
	jsl.l CODE_C38CFC
CODE_C38CF3:						; from CODE_C38CAB
	plx
	rtl
CODE_C38CF5:						; called from other segments
	lda.w #$0200
	trb.w $10F5
	rtl
CODE_C38CFC:						; from CODE_C38CDC and other segments
	lda.b $9F
	cmp.w #$0040
	beq CODE_C38D24
	cmp.w #$0014
	beq CODE_C38D0E
	lda.w #$0001
	sta.w $2348
CODE_C38D0E:						; from CODE_C38CFC
	lda.b $9F
	asl a
	tax
	lda.l DATA8_C38D43,x
	tax
	ldy.w #$5842
	jsr.w CODE_C38DAD
	lda.w #$0200
	tsb.w $10F5
	rtl
CODE_C38D24:						; from CODE_C38CFC
	lda.w $234A
	beq CODE_C38D2D
	jsl.l CODE_C38D6D
CODE_C38D2D:						; from CODE_C38D24
	inc.w TransfersReady
	ldx.w #$001C
	ldy.w #$5842
	jsr.w CODE_C38DAD
	lda.w #$0200
	tsb.w $10F5
	stz.w $2348
	rtl
DATA8_C38D43:						; not traced: a table read by CODE_C38D0E
	db $00,$00,$0E,$00,$1C,$00,$2A,$00,$38,$00,$46,$00,$54,$00,$10,$03
	db $1E,$03,$2C,$03,$3A,$03,$48,$03,$56,$03,$64,$03,$20,$06,$2E,$06
	db $3C,$06,$4A,$06,$58,$06,$66,$06,$74,$06
CODE_C38D6D:						; from CODE_C38D24 and other segments
	lda.l DATA8_C58942
	sta.w $364E
	lda.w #$003D
	ldx.w #$364E
	ldy.w #$3650
	mvn $7E,$7E
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	clc
	lda.w $1541
	adc.w #$0002
	tay
	ldx.w #$0002
	lda.w #$5940
CODE_C38D96:						; from CODE_C38D96
	phy
	pha
	adc.w #$0020
	pea.w $007E
	pea.w $364E
	dex
	bpl CODE_C38D96
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rtl
CODE_C38DAD:						; from CODE_C38D0E, CODE_C38D2D
	phd
	pea.w $7E7F
	plb
	lda.w #$2100
	tcd
	lda.w #$0080
	wai
	sta.b $15
	tya
	clc
	sta.b $16
	ldy.w $C6FA,x
	sty.b $18
	ldy.w $C6FC,x
	sty.b $18
	ldy.w $C6FE,x
	sty.b $18
	ldy.w $C700,x
	sty.b $18
	ldy.w $C702,x
	sty.b $18
	ldy.w $C704,x
	sty.b $18
	ldy.w $C706,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C75C,x
	sty.b $18
	ldy.w $C75E,x
	sty.b $18
	ldy.w $C760,x
	sty.b $18
	ldy.w $C762,x
	sty.b $18
	ldy.w $C764,x
	sty.b $18
	ldy.w $C766,x
	sty.b $18
	ldy.w $C768,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C7BE,x
	sty.b $18
	ldy.w $C7C0,x
	sty.b $18
	ldy.w $C7C2,x
	sty.b $18
	ldy.w $C7C4,x
	sty.b $18
	ldy.w $C7C6,x
	sty.b $18
	ldy.w $C7C8,x
	sty.b $18
	ldy.w $C7CA,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C820,x
	sty.b $18
	ldy.w $C822,x
	sty.b $18
	ldy.w $C824,x
	sty.b $18
	ldy.w $C826,x
	sty.b $18
	ldy.w $C828,x
	sty.b $18
	ldy.w $C82A,x
	sty.b $18
	ldy.w $C82C,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C882,x
	sty.b $18
	ldy.w $C884,x
	sty.b $18
	ldy.w $C886,x
	sty.b $18
	ldy.w $C888,x
	sty.b $18
	ldy.w $C88A,x
	sty.b $18
	ldy.w $C88C,x
	sty.b $18
	ldy.w $C88E,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C8E4,x
	sty.b $18
	ldy.w $C8E6,x
	sty.b $18
	ldy.w $C8E8,x
	sty.b $18
	ldy.w $C8EA,x
	sty.b $18
	ldy.w $C8EC,x
	sty.b $18
	ldy.w $C8EE,x
	sty.b $18
	ldy.w $C8F0,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C946,x
	sty.b $18
	ldy.w $C948,x
	sty.b $18
	ldy.w $C94A,x
	sty.b $18
	ldy.w $C94C,x
	sty.b $18
	ldy.w $C94E,x
	sty.b $18
	ldy.w $C950,x
	sty.b $18
	ldy.w $C952,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C9A8,x
	sty.b $18
	ldy.w $C9AA,x
	sty.b $18
	ldy.w $C9AC,x
	sty.b $18
	ldy.w $C9AE,x
	sty.b $18
	ldy.w $C9B0,x
	sty.b $18
	ldy.w $C9B2,x
	sty.b $18
	ldy.w $C9B4,x
	sty.b $18
	plb
	pld
	rts

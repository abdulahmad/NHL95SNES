; Segment bankC5_E000: game code, then the sprite object routines (docs/sprite_objects.md): CreateSprite,
; UploadSpriteFrame, AnimateSprites, CreateSpriteSharePal. Untraced routines keep their address as a name.
org $C5DF5F
CODE_C5DF5F:						; called from other segments
	lda.w $000C,y
	sta.b $A5
	lda.w $0020,y
	sta.b $0A
	lda.w $001E,y
	sta.b $0C
	stx.b $0E
	lda.b $09
	and.w #$FF00
	ldx.w #$0099
	jsl.l Mul16U
	sec
	lda.b $0A
	sbc.b $36
	sta.b $0A
	pei ($36)
	ldy.w #$0002
	lda.b [$38],y
	jsr.w CODE_C5E172
	inc a
	sta.b $30
	lda.b $0A
	sta.b $34
	jsl.l Div16x8U
	sta.w $DB90
	sta.w $DB8E
	sta.w $DB8C
	clc
	adc.l RDMPYL
	adc.b $01,s
	sta.w $DB8A
	pla
	ldy.b $0E
	ldx.w #$0000
CODE_C5DFB1:						; from CODE_C5DFB1
	lda.w $DB8A,x
	sta.w $00A2,y
	inx
	inx
	iny
	dec.b $30
	bne CODE_C5DFB1
	ldy.w #$0002
CODE_C5DFC1:						; from CODE_C5DFC1
	dec.b $0C
	bmi CODE_C5DFD8
	beq CODE_C5DFD8
	lda.b [$38],y
	jsr.w CODE_C5E172
	clc
	adc.b $0E
	tax
	inc.w $003A,x
	inc.w $00A2,x
	bra CODE_C5DFC1
CODE_C5DFD8:						; from CODE_C5DFC1
	lda.b $A5
	bne CODE_C5DFDF
	jmp.w CODE_C5E0B0
CODE_C5DFDF:						; from CODE_C5DFD8
	ldy.w #$0002
	lda.b [$38],y
	sta.w $DBDA
	sta.w $DBE0
	iny
	iny
	clc
	adc.b [$38],y
	sta.w $DBDC
	sta.w $DBE2
	iny
	iny
	adc.b [$38],y
	sta.w $DBDE
	stz.w $DBE4
	lda.b $A4
	and.w #$FF00
	cmp.w #$0100
	bne CODE_C5E00C
	xba
	bra CODE_C5E01D
CODE_C5E00C:						; from CODE_C5DFDF
	ldx.w #$00C0
	jsl.l Mul16U
	lda.b $A5
	sec
	sbc.b $36
	sta.w $DBE4
	lda.b $36
CODE_C5E01D:						; from CODE_C5DFDF
	sta.w $DBE6
	jsr.w CODE_C5E0B1
	lda.w $DBDC
	sta.w $DBE0
	lda.w $DBDE
	sta.w $DBE2
	lda.w $DBE4
	sta.w $DBE6
	jsr.w CODE_C5E0B1
	stz.w $DBE4
	lda.b $A5
	lsr a
	beq CODE_C5E0B0
	sta.b $A5
	xba
	and.w #$FF00
	cmp.w #$0100
	bne CODE_C5E04E
	xba
	bra CODE_C5E05F
CODE_C5E04E:						; from CODE_C5E01D
	ldx.w #$00C0
	jsl.l Mul16U
	lda.b $A5
	sec
	sbc.b $36
	sta.w $DBE4
	lda.b $36
CODE_C5E05F:						; from CODE_C5E01D
	sta.w $DBE6
	lda.w $DBDA
	sta.w $DBE0
	lda.w $DBDC
	sta.w $DBE2
	jsr.w CODE_C5E083
	lda.w $DBDC
	sta.w $DBE0
	lda.w $DBDE
	sta.w $DBE2
	lda.w $DBE4
	sta.w $DBE6
CODE_C5E083:						; from CODE_C5E05F
	lda.w $DBE6
	beq CODE_C5E0B0
	jsr.w CODE_C5E0DF
CODE_C5E08B:						; from CODE_C5E0A1
	lda.w $DBE8
	jsr.w CODE_C5E172
	ldx.w #$0000
CODE_C5E094:						; from CODE_C5E094
	cmp.w $DB8A,x
	bcc CODE_C5E0A1
	beq CODE_C5E0A1
	inx
	inx
	inx
	inx
	bra CODE_C5E094
CODE_C5E0A1:						; from CODE_C5E094
	lda.w $DB8C,x
	clc
	adc.b $0E
	tax
	inc.w $006E,x
	dec.w $DBE6
	bne CODE_C5E08B
CODE_C5E0B0:						; from CODE_C5DFD8, CODE_C5E01D, CODE_C5E083
	rts
CODE_C5E0B1:						; from CODE_C5E01D
	lda.w $DBE6
	beq CODE_C5E0DE
	jsr.w CODE_C5E0DF
CODE_C5E0B9:						; from CODE_C5E0CF
	lda.w $DBE8
	jsr.w CODE_C5E172
	ldx.w #$0000
CODE_C5E0C2:						; from CODE_C5E0C2
	cmp.w $DB8A,x
	bcc CODE_C5E0CF
	beq CODE_C5E0CF
	inx
	inx
	inx
	inx
	bra CODE_C5E0C2
CODE_C5E0CF:						; from CODE_C5E0C2
	lda.w $DB8C,x
	clc
	adc.b $0E
	tax
	inc.w $003A,x
	dec.w $DBE6
	bne CODE_C5E0B9
CODE_C5E0DE:						; from CODE_C5E0B1
	rts
CODE_C5E0DF:						; from CODE_C5E0B1, CODE_C5E083
	stz.w $DBEA
	stz.w $DBE8
	lda.w $DBE0
CODE_C5E0E8:						; from CODE_C5E0FB
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.w #$0112
	tay
	lda.b [$38],y
	and.w #$000F
	tay
	lda.w #$0000
	sec
CODE_C5E0FB:						; from CODE_C5E0FB
	rol a
	dey
	bne CODE_C5E0FB
	ldx.w $DBEA
	clc
	adc.w $DBE8
	sta.w $DBE8
	sta.w $DB8A,x
	lda.w $DBE0
	sta.w $DB8C,x
	inx
	inx
	inx
	inx
	stx.w $DBEA
	inc a
	sta.w $DBE0
	cmp.w $DBE2
	bne CODE_C5E0E8
	rts
CODE_C5E123:						; called from other segments
	sta.b $A1
	sta.w $000C,x
	lda.w #$001E
	jsr.w CODE_C5E172
	adc.w #$000A
	clc
	adc.b $A1
	sta.w $000E,x
	lda.w #$00C8
	jsr.w CODE_C5E172
	sta.w $0010,x
	lda.b $A1
	lsr a
	jsr.w CODE_C5E172
	sta.w $0012,x
	jsr.w CODE_C5E172
	sta.w $0014,x
	lda.b $A1
	lsr a
	jsr.w CODE_C5E172
	sta.w $0016,x
	jsr.w CODE_C5E172
	sta.w $0018,x
	lda.b $A1
	lsr a
	lsr a
	jsr.w CODE_C5E172
	sta.w $001A,x
	jsr.w CODE_C5E172
	adc.w $001A,x
	sta.w $001C,x
	rts
CODE_C5E172:						; from CODE_C5DF5F, CODE_C5DFC1, CODE_C5E123, CODE_C5E0B9, ...
	pea.w $7F7E
	plb
	jsl.l CODE_C58CCD
	plb
	rts
CODE_C5E17C:						; called from other segments
	pea.w $7E7F
	lda.w $2C42
	sta.b $9F
	lda.l $306051
	sta.b $0A
	stz.b $0C
	stz.b $0E
	plb
	ldy.w #$8EF8
CODE_C5E192:						; from CODE_C5E1EB
	tyx
	lsr.b $0A
	bcs CODE_C5E1EB
	lda.w $0000,y
	bne CODE_C5E1EB
	lda.w $0002,y
	jsr.w CODE_C5E20B
	tya
	clc
	adc.w #$0016
	tax
	lda.w $0004,y
	jsr.w CODE_C5E20B
	lda.b $0E
	asl a
	tax
	lda.w $0008,y
	xba
	ora.w $000A,y
	sta.l $306053,x
	phx
	phy
	pei ($9F)
	pei ($A1)
	pei ($A3)
	pei ($A5)
	pei ($0A)
	pei ($0C)
	pei ($0E)
	phb
	jsl.l CODE_C40A6D
	plb
	pla
	sta.b $0E
	pla
	sta.b $0C
	pla
	sta.b $0A
	pla
	sta.b $A5
	pla
	sta.b $A3
	pla
	sta.b $A1
	pla
	sta.b $9F
	ply
	plx
	sec
CODE_C5E1EB:						; from CODE_C5E192
	ror.b $0C
	tya
	adc.w #$010A
	tay
	inc.b $0E
	dec.b $9F
	bne CODE_C5E192
	plb
	lda.w #$0010
	sbc.w $2C42
CODE_C5E1FF:						; from CODE_C5E1FF
	lsr.b $0C
	dec a
	bpl CODE_C5E1FF
	lda.b $0C
	sta.l $306051
	rts
CODE_C5E20B:						; from CODE_C5E192 and other segments
	phy
	phx
	pha
	pea.w $7F7E
	plb
	jsr.w CODE_C5B983
	plb
	pla
	phx
	ldx.w #$0083
	jsl.l Mul16U
	plx
	ply
	clc
	lda.l $7E000E,x
	adc.w $000C,y
	jsr.w CODE_C5E2B0
	clc
	lda.l $7E0018,x
	adc.w $000E,y
	jsr.w CODE_C5E2A6
	clc
	lda.l $7E001C,x
	adc.w $0010,y
	jsr.w CODE_C5E29C
	clc
	lda.l $7E001E,x
	adc.w $0012,y
	jsr.w CODE_C5E2BA
	clc
	lda.l $7E0020,x
	adc.w $0014,y
	jsr.w CODE_C5E2BA
	clc
	lda.l $7E0022,x
	adc.w $0016,y
	jsr.w CODE_C5E2BA
	clc
	lda.l $7E0024,x
	adc.w $0018,y
	jsr.w CODE_C5E2BA
	clc
	lda.l $7E0026,x
	adc.w $001A,y
	jsr.w CODE_C5E2BA
	clc
	lda.l $7E0028,x
	adc.w $001C,y
	jsr.w CODE_C5E2BA
	clc
	lda.l $7E002A,x
	adc.w $001E,y
	jsr.w CODE_C5E2B0
	clc
	lda.l $7E002E,x
	adc.w $0020,y
	jsr.w CODE_C5E29C
	ply
	rts
CODE_C5E29C:						; from CODE_C5E20B
	stx.b $A3
	sta.b $A1
	jsr.w CODE_C5E2C4
	ldx.b $A3
	rts
CODE_C5E2A6:						; from CODE_C5E20B
	stx.b $A3
	sta.b $A1
	jsr.w CODE_C5E2C7
	ldx.b $A3
	rts
CODE_C5E2B0:						; from CODE_C5E20B
	stx.b $A3
	sta.b $A1
	jsr.w CODE_C5E2CA
	ldx.b $A3
	rts
CODE_C5E2BA:						; from CODE_C5E20B
	stx.b $A3
	sta.b $A1
	jsr.w CODE_C5E2CD
	ldx.b $A3
	rts
CODE_C5E2C4:						; from CODE_C5E29C
	jsr.w CODE_C5E2EB
CODE_C5E2C7:						; from CODE_C5E2A6
	jsr.w CODE_C5E2EB
CODE_C5E2CA:						; from CODE_C5E2B0
	jsr.w CODE_C5E2EB
CODE_C5E2CD:						; from CODE_C5E2BA
	jsr.w CODE_C5E2EB
	jsr.w CODE_C5E2EB
	jsr.w CODE_C5E2EB
	jsr.w CODE_C5E2EB
	jsr.w CODE_C5E2EB
	jsr.w CODE_C5E2EB
	jsr.w CODE_C5E2EB
	jsr.w CODE_C5E2EB
	jsr.w CODE_C5E2EB
	jsr.w CODE_C5E2EB
CODE_C5E2EB:						; from CODE_C5E2CA, CODE_C5E2CD, CODE_C5E2C7, CODE_C5E2C4
	lsr.b $A1
	bcs CODE_C5E314
	lda.b $34
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	eor.w #$FFFF
	sta.b $A5
	lda.b $34
	lsr a
	lsr a
	lsr a
	tax
	lda.l $306E43,x
	and.b $A5
	sta.l $306E43,x
	inc.b $34
	rts
CODE_C5E314:						; from CODE_C5E2EB
	lda.b $34
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	sta.b $A5
	lda.b $34
	lsr a
	lsr a
	lsr a
	tax
	lda.l $306E43,x
	ora.b $A5
	sta.l $306E43,x
	inc.b $34
	rts
CODE_C5E336:						; called from other segments
	phb
	lda.l $7E2C42
	sta.b $9F
	lda.l $306051
	sta.b $A1
	pea.w $7E7F
	plb
	ldy.w #$8EF8
	ldx.w #$0000
CODE_C5E34D:						; from CODE_C5E36F
	lsr.b $A1
	bcc CODE_C5E36F
	lda.w #$0000
	sta.w $0000,y
	dec a
	sta.w $0006,y
	lda.l $306053,x
	and.w #$00FF
	sta.w $000A,y
	lda.l $306054,x
	and.w #$00FF
	sta.w $0008,y
CODE_C5E36F:						; from CODE_C5E34D
	inx
	inx
	tya
	clc
	adc.w #$010A
	tay
	dec.b $9F
	bne CODE_C5E34D
	plb
	plb
	rts
CODE_C5E37E:						; called from other segments
	lda.w #$0019
	sta.w $17C9
	jsr.w CODE_C5B983
	stz.w $0000,x
	stx.b $81
CODE_C5E38C:						; from CODE_C5E38C
	phx
	lda.w $17C9
	dec a
	bmi CODE_C5E3A4
	sta.w $17C9
	jsr.w CODE_C5B983
	ply
	tya
	sta.w $0000,x
	txa
	sta.w $0002,y
	bra CODE_C5E38C
CODE_C5E3A4:						; from CODE_C5E38C
	plx
	stz.w $0002,x
	jml.l CODE_C4C541
	brk #$00						; a brk in the ROM, between routines
CODE_C5E3AE:						; no caller found (not traced)
	lda.l $3075B4
	and.w #$00FF
	beq CODE_C5E3B8
	rts
CODE_C5E3B8:						; from CODE_C5E3AE
	sep #$20
	lda.w $190A
	sta.l $30604D
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
CODE_C5E3C6:						; no caller found (not traced)
	sep #$20
	lda.w $186E
	sta.l $30604C
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
CODE_C5E3D4:						; no caller found (not traced)
	sep #$20
	lda.w $186C
	sta.l $30604B
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
CODE_C5E3E2:						; no caller found (not traced)
	sep #$20
	lda.w $186A
	sta.l $306049
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
CODE_C5E3F0:						; no caller found (not traced)
	sep #$20
	lda.w $1870
	sta.l $30604A
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
CODE_C5E3FE:						; no caller found (not traced)
	sep #$20
	lda.w $1904
	sta.l $306040
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
CODE_C5E40C:						; no caller found (not traced)
	sep #$20
	lda.w $1872
	sta.l $30604F
	rep #$20
	lda.w $1872
	bne CODE_C5E41D
CODE_C5E41C:						; from CODE_C5E432
	rts
CODE_C5E41D:						; from CODE_C5E40C and other segments
	lda.w $17C9
	cmp.w #$001A
	bcc CODE_C5E432
	lda.w #$000E
	sta.w $17C9
	sta.l $306041
	jsr.w CODE_C5A46A
CODE_C5E432:						; from CODE_C5E41D
	lda.w $17CB
	cmp.w #$001A
	bcc CODE_C5E41C
	lda.w #$0017
	sta.w $17CB
	sta.l $306043
	jmp.w CODE_C5A3C1
CODE_C5E447:						; from CODE_C5E47C and other segments
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	lsr a
	lsr a
	lsr a
	tax
	lda.b $9F
	and.w #$0007
	tay
	lda.w #$FE00
CODE_C5E460:						; from CODE_C5E460
	dey
	bmi CODE_C5E467
	sec
	rol a
	bra CODE_C5E460
CODE_C5E467:						; from CODE_C5E460
	sta.b $9F
	lda.l $30628F,x
	and.b $9F
	sta.l $30628F,x
	rts
CODE_C5E474:						; called from other segments
	lda.w #$026A
	sta.b $A5
	ldy.w #$0000
CODE_C5E47C:						; from CODE_C5E48B
	jsr.w CODE_C5D7E9
	cmp.w #$0000
	beq CODE_C5E48B
	phy
	lda.b $A5
	jsr.w CODE_C5E447
	ply
CODE_C5E48B:						; from CODE_C5E47C
	inc.b $A5
	clc
	tya
	adc.w #$0099
	tay
	cpy.w #$0C30
	bcc CODE_C5E47C
	rtl
DATA8_C5E499:						; not traced: data between routines
	db $6B
CODE_C5E49A:						; called from other segments
	jsl.l FadeOutWait
	jsl.l CODE_C4CEDB
	stz.w DMAEnShadow
	jsl.l CODE_C5E50E
	jsr.w CODE_C55951
	stz.b $26
	jsr.w CODE_C5BBC0
	stz.b $CF
	lda.w #$0100
	sta.b $D1
	ldx.w #$4692
	ldy.w #$000C
	jsl.l CODE_C4BCA4
	jsl.l CODE_C4C2AA
	stz.w fadestep
	lda.w #$000F
CODE_C5E4CC:						; from CODE_C5E4CC
	cmp.w brightness
	bne CODE_C5E4CC
	rts
CODE_C5E4D2:						; called from other segments
	pea.w $7E7F
	lda.w $2C42
	sta.b $9F
	lda.l $306051
	sta.b $0A
	stz.b $0C
	plb
	ldy.w #$8EF8
CODE_C5E4E6:						; from CODE_C5E4F0
	lsr.b $0A
	bcs CODE_C5E4F0
	lda.w $0000,y
	bne CODE_C5E4F0
	sec
CODE_C5E4F0:						; from CODE_C5E4E6
	ror.b $0C
	tya
	adc.w #$010A
	tay
	dec.b $9F
	bne CODE_C5E4E6
	plb
	lda.w #$0010
	sbc.w $2C42
CODE_C5E502:						; from CODE_C5E502
	lsr.b $0C
	dec a
	bpl CODE_C5E502
	lda.b $0C
	sta.l $306051
	rts
CODE_C5E50E:						; from CODE_C5E49A and other segments
	lda.w #$00A0
	sta.b $E1
	lda.w #$0058
	sta.b $DD
	jsr.w CODE_C5E51C
	rtl
CODE_C5E51C:						; from CODE_C5E50E
	lda.b $E1
	asl a
	asl a
	asl a
	asl a
	adc.w #$6000
	sta.b $DB
	lda.b $E1
	inc a
	sta.b $E3
	lda.b $DD
	inc a
	sta.b $DF
	lda.w #$3000
	sta.b $D9
	stz.w $1B02
	stz.w $1B04
	stz.w $1B06
	stz.w $1B08
	stz.w $1B0A
	stz.w $1B0C
	lda.w #$0000
	sta.l $002102
	lda.w #$FFFF
	ldx.w #$01FE
CODE_C5E555:						; from CODE_C5E555
	sta.w $46B8,x
	dex
	dex
	bpl CODE_C5E555
	sta.w $1B0E
	ldx.w #$0000
	ldy.w #$0007
CODE_C5E565:						; from CODE_C5E565
	sta.w $1AE2,x
	inx
	inx
	dey
	bpl CODE_C5E565
	clc
	lda.w #$1912
	ldx.w #$1AF2
	ldy.w #$0007
CODE_C5E577:						; from CODE_C5E577
	sta.b $00,x
	inx
	inx
	adc.w #$003A
	dey
	bpl CODE_C5E577
	clc
	lda.w #$0007
	ldx.w #$000E
CODE_C5E588:						; from CODE_C5E588
	sta.w $46A8,x
	dex
	dex
	dec a
	bpl CODE_C5E588
	lda.w #$1D8F
	sta.b $28
	rts
CODE_C5E596:						; from CODE_C5EBAE and other segments
	lda.w $1B02
	bne CODE_C5E59C
	rtl
CODE_C5E59C:						; from CODE_C5E596
	dec a
	asl a
	tay
	txa
CODE_C5E5A0:						; from CODE_C5E5A0
	cmp.w $1AE2,y
	beq CODE_C5E5AA
	dey
	dey
	bpl CODE_C5E5A0
	rtl
CODE_C5E5AA:						; from CODE_C5E5A0
	tyx
	tay
	jsr (DATA8_C5E655,x)
	lda.w $0034,y
	and.w #$00FF
	asl a
	tax
	lda.w $46B8,x
	bit.w #$00FF
	bne CODE_C5E5D9
	xba
	ora.w #$FF00
	sta.w $46B8,x
	and.w #$00FF
	ldx.w $1B06
	dex
	dex
	sta.w $46A8,x
	stx.w $1B06
	dec.w $1B08
	bra CODE_C5E5DD
CODE_C5E5D9:						; from CODE_C5E5AA
	dec a
	sta.w $46B8,x
CODE_C5E5DD:						; from CODE_C5E5AA
	ldx.w $1B04
	dex
	dex
	stx.w $1B04
	tya
	sta.w $1AF2,x
	tax
	lda.b $00,x
	bpl CODE_C5E611
	lda.b $02,x
	sta.w $1B0E
	bmi CODE_C5E5FC
	tay
	lda.w #$FFFF
	sta.w $0000,y
CODE_C5E5FC:						; from CODE_C5E5DD
	lda.b $12,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$01FF
	sta.w $1B0A
	lda.b $18,x
	sta.w $1B0C
	dec.w $1B02
	rtl
CODE_C5E611:						; from CODE_C5E5DD
	tay
	lda.b $18,x
	sta.w $0018,y
	lda.b $12,x
	sta.w $0012,y
	lda.b $02,x
	sta.w $0002,y
	tax
	bmi CODE_C5E626
	sty.b $00,x
CODE_C5E626:						; from CODE_C5E611
	dec.w $1B02
	rtl
CODE_C5E62A:						; from DATA8_C5E655
	lda.w $1AE4
	sta.w $1AE2
CODE_C5E630:						; from DATA8_C5E655
	lda.w $1AE6
	sta.w $1AE4
CODE_C5E636:						; from DATA8_C5E655
	lda.w $1AE8
	sta.w $1AE6
CODE_C5E63C:						; from DATA8_C5E655
	lda.w $1AEA
	sta.w $1AE8
CODE_C5E642:						; from DATA8_C5E655
	lda.w $1AEC
	sta.w $1AEA
CODE_C5E648:						; from DATA8_C5E655
	lda.w $1AEE
	sta.w $1AEC
CODE_C5E64E:						; from DATA8_C5E655
	lda.w $1AF0
	sta.w $1AEE
CODE_C5E654:						; from DATA8_C5E655
	rts
DATA8_C5E655:						; jump table: the routine for each index
	dw CODE_C5E62A,CODE_C5E630,CODE_C5E636,CODE_C5E63C
	dw CODE_C5E642,CODE_C5E648,CODE_C5E64E,CODE_C5E654
CreateSprite:						; make a sprite object from record A (carry clear: made, X = the object)
	sta.b $10
	lda.w $1B02
	inc a
	cmp.w #$0009
	bcc CODE_C5E671
	rtl
CODE_C5E671:						; from CreateSprite
	sta.w $1B02
	dec a
	asl a
	tay
	ldx.w $1B04
	lda.w $1AF2,x
	inx
	inx
	stx.w $1B04
	sta.w $1AE2,y
	tax
	lda.b $18
	sta.b $05,x
	lda.b $1A
	sta.b $08,x
	lda.b $10
	sta.b $24,x
	lda.w #$0100
	sta.b $0A,x
	sta.b $0C,x
	sta.b $0E,x
	lda.b $D9
	sta.b $36,x
	stz.b $30,x
	stz.b $1E,x
	stz.b $38,x
	stz.b $20,x
	lda.w #$FFFF
	sta.b $28,x
	sta.b $2A,x
	sta.b $2C,x
	sta.b $00,x
	sta.b $22,x
	lda.b $10
	asl a
	adc.l $008000
	txy
	tax
	lda.b $00,x
	tax
	lda.b $09,x
	and.w #$00FF
	lda.b $00,x
	sta.w $0026,y
	lda.b $04,x
	lda.b $05,x
	lda.b $02,x
	sta.w $002E,y
	stx.b $10
	tax
	lda.b $00,x
	sta.w $0032,y
	ldx.b $10
	lda.b $07,x
	sta.b $10
	lda.b $12,x
	and.w #$00FF
	sta.w $0034,y
	asl a
	tax
	lda.w $46B8,x
	bpl CODE_C5E755
	lda.w $1B08
	cmp.w #$0008
	bcc CODE_C5E6FA
	brk #$00						; a brk in the ROM, between routines
CODE_C5E6FA:						; from CODE_C5E671
	inc a
	sta.w $1B08
	phx
	ldx.w $1B06
	lda.w $46A8,x
	inx
	inx
	stx.w $1B06
	plx
	xba
	sta.w $46B8,x
	ora.w $0034,y
	sta.w $0034,y
	sty.b $12
	tay
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	tya
	xba
	and.w #$00FF
	adc.w #$0008
	asl a
	asl a
	asl a
	asl a
	pha
	lda.l $008004
	pha
	tya
	and.w #$00FF
	xba
	lsr a
	lsr a
	lsr a
	adc.l $008002
	pha
	bcc CODE_C5E749
	lda.b $03,s
	inc a
	sta.b $03,s
CODE_C5E749:						; from CODE_C5E6FA
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	ldy.b $12
	bra CODE_C5E762
CODE_C5E755:						; from CODE_C5E671
	inc a
	sta.w $46B8,x
	and.w #$FF00
	ora.w $0034,y
	sta.w $0034,y
CODE_C5E762:						; from CODE_C5E749
	lda.b $10
	and.w #$00FF
	clc
	adc.b $1E
	sta.w $001A,y
	jsr.w CODE_C5E851
	bcs CODE_C5E791
	lda.b $10
	xba
	and.w #$00FF
	adc.b $20
	sta.w $001C,y
	jsr.w CODE_C5E86F
	bcs CODE_C5E79D
	ldx.w $1B0E
	bmi CODE_C5E789
	sty.b $00,x
CODE_C5E789:						; from CODE_C5E762
	txa
	tyx
	sta.b $02,x
	stx.w $1B0E
	rtl
CODE_C5E791:						; from CODE_C5E762
	lda.b $10
	xba
	and.w #$00FF
	clc
	adc.b $20
	sta.w $001C,y
CODE_C5E79D:						; from CODE_C5E762
	ldx.w $1B0E
	bpl CODE_C5E801
	brk #$00						; a brk in the ROM, between routines
CODE_C5E7A4:						; from CODE_C5E801
	lsr a
	lsr a
	lsr a
	lsr a
	cmp.w $001A,y
	bcc CODE_C5E80F
	lda.b $16,x
	sbc.b $18,x
	cmp.w $001C,y
	bcc CODE_C5E80F
	lda.b $12,x
	sta.w $0010,y
	sta.w $0012,y
	lda.w $001A,y
	asl a
	asl a
	asl a
	asl a
	adc.w $0010,y
	sta.b $12,x
	lda.b $18,x
	sta.w $0016,y
	sta.w $0018,y
	clc
	adc.w $001C,y
	sta.b $18,x
	lda.b $02,x
	sta.w $0002,y
	sty.b $02,x
	txa
	tyx
	sta.w $0000,y
	lda.b $02,x
	bmi CODE_C5E7EE
	tay
	txa
	sta.w $0000,y
	tay
CODE_C5E7EE:						; from CODE_C5E7A4
	lda.b $16,x
	asl a
	tax
	lda.l DATA8_C04AA9,x
	asl a
	asl a
	asl a
	asl a
	adc.b $DB
	tyx
	sta.b $14,x
	clc
	rtl
CODE_C5E801:						; from CODE_C5E79D, CODE_C5E80F
	sec
	lda.b $10,x
	sbc.b $12,x
	bne CODE_C5E7A4
	sec
	lda.b $16,x
	sbc.b $18,x
	bne CODE_C5E7A4
CODE_C5E80F:						; from CODE_C5E7A4
	lda.b $02,x
	tax
	bpl CODE_C5E801
	lda.w $0034,y
	and.w #$00FF
	asl a
	tax
	lda.w $46B8,x
	bit.w #$00FF
	bne CODE_C5E837
	lda.w #$FFFF
	sta.w $46B8,x
	lda.w $1B06
	dec a
	dec a
	sta.w $1B06
	dec.w $1B08
	bra CODE_C5E83B
CODE_C5E837:						; from CODE_C5E80F
	dec a
	sta.w $46B8,x
CODE_C5E83B:						; from CODE_C5E80F
	dec.w $1B04
	dec.w $1B04
	dec.w $1B02
	lda.w $1B02
	asl a
	tax
	lda.w #$FFFF
	sta.w $1AE2,x
	sec
	rtl
CODE_C5E851:						; from CODE_C5EEFF, CODE_C5E762
	clc
	adc.w $1B0A
	cmp.b $E3
	bcc CODE_C5E85A
	rts
CODE_C5E85A:						; from CODE_C5E851
	ldx.w $1B0A
	sta.w $1B0A
	txa
	asl a
	asl a
	asl a
	asl a
	ora.w #$6000
	sta.w $0010,y
	sta.w $0012,y
	rts
CODE_C5E86F:						; from CODE_C5EEFF, CODE_C5E762
	clc
	adc.w $1B0C
	cmp.b $DF
	bcc CODE_C5E888
	lda.w #$FF00
	trb.b $10
	lda.w $1B0A
	sec
	sbc.b $10
	sbc.b $1E
	sta.w $1B0A
	rts
CODE_C5E888:						; from CODE_C5E86F
	ldx.w $1B0C
	sta.w $1B0C
	txa
	sta.w $0016,y
	sta.w $0018,y
	asl a
	tax
	lda.l DATA8_C04AA9,x
	asl a
	asl a
	asl a
	asl a
	adc.b $DB
	sta.w $0014,y
	rts
UploadSpriteFrame:					; queue object X's current frame tiles for VRAM (unpacked if packed)
	txy
	lda.b $28,x
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $00,x
	xba
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	sta.b $A3
	lda.b $00,x
	and.w #$FF00
	lsr a
	lsr a
	sta.b $A5
	lda.b $04,x
	sta.b $9F
	dec.b QueueBusy
	tsc
	sta.b $0A
	lda.b $00
	tcs
	lda.b $A3
	beq CODE_C5E8F9
	pha
	lda.w $0010,y
	pha
	lda.b $9F
	bit.w #$0001
	beq CODE_C5E904
	pea.w $007E
	sty.b $42
	ldy.b $07,x
	sty.b $2E
	sty.b $32
	lda.b $05,x
	phb
	jsr.w UnpackStream0
	plb
	pei ($08)
	sty.b $08
	ldy.b $42
	bra CODE_C5E911
CODE_C5E8F9:						; from UploadSpriteFrame
	lda.b $07,x
	sta.b $2E
	sta.b $32
	lda.b $05,x
	tax
	bra CODE_C5E911
CODE_C5E904:						; from UploadSpriteFrame
	lda.b $07,x
	pha
	sta.b $2E
	sta.b $32
	lda.b $05,x
	pha
	adc.b $A3
	tax
CODE_C5E911:						; from UploadSpriteFrame, CODE_C5E8F9
	lda.b $A5
	bne CODE_C5E918
	jmp.w CODE_C5E9BD
CODE_C5E918:						; from CODE_C5E911
	lda.b $9F
	bit.w #$0002
	beq CODE_C5E958
	bit.w #$0001
	beq CODE_C5E939
	sec
	lda.b $08
	sbc.b $A5
	sta.b $30
	sbc.b $A5
	sta.b $2C
	clc
	lda.w #$007E
	sta.b $2E
	sta.b $32
	bra CODE_C5E95F
CODE_C5E939:						; from CODE_C5E918
	sty.b $42
	ldy.b $2E
	txa
	phb
	jsr.w UnpackStream0
	plb
	lda.w #$007E
	sta.b $2E
	sta.b $32
	lda.b $08
	sta.b $2C
	sty.b $08
	adc.b $A5
	sta.b $30
	ldy.b $42
	bra CODE_C5E95F
CODE_C5E958:						; from CODE_C5E918
	stx.b $2C
	txa
	adc.b $A5
	sta.b $30
CODE_C5E95F:						; from CODE_C5E918, CODE_C5E939
	lda.w $0014,y
	sta.b $0C
CODE_C5E964:						; from CODE_C5E964
	and.w #$00FF
	asl a
	sta.b $0E
	adc.b $A5
	cmp.w #$0201
	bcc CODE_C5E9A9
	lda.w #$0200
	sbc.b $0E
	sta.b $0E
	pha
	pei ($0C)
	pei ($2E)
	pei ($2C)
	pha
	lda.b $0C
	adc.w #$00FF
	pha
	pei ($32)
	pei ($30)
	lda.b $2C
	adc.b $0E
	sta.b $2C
	lda.b $30
	adc.b $0E
	sta.b $30
	sec
	lda.b $A5
	sbc.b $0E
	sta.b $A5
	lda.b $0C
	adc.w #$01FF
	and.w #$FF00
	sta.b $0C
	bra CODE_C5E964
CODE_C5E9A9:						; from CODE_C5E964
	pei ($A5)
	pei ($0C)
	pei ($2E)
	pei ($2C)
	pei ($A5)
	lda.b $0C
	adc.w #$0100
	pha
	pei ($32)
	pei ($30)
CODE_C5E9BD:						; from CODE_C5E911
	tsc
	sta.b $00
	lda.b $0A
	tcs
	stz.b QueueBusy
	tyx
	rts
AnimateSprites:						; the animation tick: step the script of each sprite object
	lda.w $1B02
	bne CODE_C5E9CD
	rtl
CODE_C5E9CD:						; from AnimateSprites
	dec a
	asl a
	tay
	lda.w $18E0
	sta.b $08
CODE_C5E9D5:						; from CODE_C5E9EA
	ldx.w $1AE2,y
	lda.b $26
	eor.b $38,x
	bit.w #$0001
	bne CODE_C5E9EA
	lda.b $0E,x
	clc
	sbc.b $0A,x
	bmi CODE_C5E9EF
	sta.b $0E,x
CODE_C5E9EA:						; from CODE_C5EAA2, CODE_C5EAF6, CODE_C5EB7F, CODE_C5EBAE, ...
	dey
	dey
	bpl CODE_C5E9D5
	rtl
CODE_C5E9EF:						; from CODE_C5E9D5
	sty.b $9F
	lda.b $0C,x
	sta.b $0E,x
	txy
CODE_C5E9F6:						; from CODE_C5EAFF, CODE_C5EB06, CODE_C5EB15, CODE_C5EB36, ...
	lda.b $30,x
	clc
	adc.b $32,x
	tax
	lda.b $00,x
	stx.b $A1
	bit.w #$0080
	beq CODE_C5EA08
	jmp.w CODE_C5EAAF
CODE_C5EA08:						; from CODE_C5E9F6
	tyx
	ldy.b $9F
	and.w #$007F
	cmp.b $28,x
	bne CODE_C5EA17
CODE_C5EA12:						; from CODE_C5EA17
	inc.b $30,x
	clc
	bra CODE_C5E9EA
CODE_C5EA17:						; from CODE_C5EA08
	sta.b $28,x
	lda.w #$FFFF
	sta.b $2A,x
	lda.b $22,x
	bit.w #$2000
	beq CODE_C5EA12
	sty.b $34
	stx.b $36
CODE_C5EA29:						; from CODE_C5EA91
	lda.b $12,x
	cmp.b $10,x
	bne CODE_C5EA3D
	lda.b $18,x
	cmp.b $16,x
	beq CODE_C5EA84
	sta.b $16,x
	lda.b $12,x
	sta.b $10,x
	bra CODE_C5EA43
CODE_C5EA3D:						; from CODE_C5EA29
	sta.b $10,x
	lda.b $18,x
	sta.b $16,x
CODE_C5EA43:						; from CODE_C5EA29
	lda.b $00,x
	bpl CODE_C5EA5E
	lda.b $10,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$01FF
	adc.b $1A,x
	sta.w $1B0A
	lda.b $16,x
	adc.b $1C,x
	sta.w $1B0C
	bra CODE_C5EA72
CODE_C5EA5E:						; from CODE_C5EA43
	tay
	clc
	lda.b $1A,x
	asl a
	asl a
	asl a
	asl a
	adc.b $10,x
	sta.w $0012,y
	lda.b $16,x
	adc.b $1C,x
	sta.w $0018,y
CODE_C5EA72:						; from CODE_C5EA43
	lda.b $16,x
	asl a
	txy
	tax
	lda.l DATA8_C04AA9,x
	asl a
	asl a
	asl a
	asl a
	adc.b $DB
	tyx
	sta.b $14,x
CODE_C5EA84:						; from CODE_C5EA29
	jsr.w UploadSpriteFrame
	ldx.b $36
	inc.b $30,x
	ldy.b $34
	clc
	jmp.w CODE_C5E9EA
CODE_C5EA91:						; no caller found (not traced)
	txy
	tax
	lda.w $0028,y
	sta.b $28,x
	lda.w $002A,y
	sta.b $2A,x
	stx.b $36
	jmp.w CODE_C5EA29
CODE_C5EAA2:						; no caller found (not traced)
	lda.w #$FFFF
	sta.b $28,x
	sta.b $2A,x
	ldy.b $34
	clc
	jmp.w CODE_C5E9EA
CODE_C5EAAF:						; from CODE_C5E9F6
	tyx
	inc.b $30,x
	and.w #$007F
	asl a
	tax
	jmp (DATA8_C5EABA,x)
DATA8_C5EABA:						; jump table: the routine for each index
	dw CODE_C5EAF6,CODE_C5EAFF,CODE_C5EB06,CODE_C5EB15
	dw CODE_C5EB33,CODE_C5EB36,CODE_C5EB44,CODE_C5EB52
	dw CODE_C5EBAE,CODE_C5EBB8,CODE_C5EBE2,CODE_C5EBF2
	dw CODE_C5EBFD,CODE_C5EC13,CODE_C5EC1A,CODE_C5EC31
	dw CODE_C5EC34,CODE_C5EAF6,CODE_C5EAF6,CODE_C5EC52
	dw CODE_C5EC5D,CODE_C5EC68,CODE_C5EC73,CODE_C5EC08
	dw CODE_C5EAF6,CODE_C5EAF6,CODE_C5EAF6,CODE_C5EC7E
	dw CODE_C5EC89,CODE_C5EBD6
CODE_C5EAF6:						; from DATA8_C5EABA, CODE_C5EB33, CODE_C5EC31, CODE_C5EC2E
	tyx
	dec.b $30,x
	ldy.b $9F
	clc
	jmp.w CODE_C5E9EA
CODE_C5EAFF:						; from DATA8_C5EABA
	tyx
	stz.w $0030,x
	jmp.w CODE_C5E9F6
CODE_C5EB06:						; from DATA8_C5EABA
	ldx.b $A1
	lda.w $0030,y
	dec a
	adc.b $01,x
	sta.w $0030,y
	tyx
	jmp.w CODE_C5E9F6
CODE_C5EB15:						; from DATA8_C5EABA
	ldx.b $A1
	lda.b $01,x
	and.w #$00FF
	sta.w $001E,y
	sta.w $0020,y
	asl a
	adc.w $002E,y
	tax
	lda.b $00,x
	tyx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	jmp.w CODE_C5E9F6
CODE_C5EB33:						; from DATA8_C5EABA
	jmp.w CODE_C5EAF6
CODE_C5EB36:						; from DATA8_C5EABA
	ldx.b $A1
	lda.b $01,x
	tyx
	sta.b $0C,x
	inc.b $30,x
	inc.b $30,x
	jmp.w CODE_C5E9F6
CODE_C5EB44:						; from DATA8_C5EABA
	ldx.b $A1
	lda.b $01,x
	tyx
	sta.b $0A,x
	inc.b $30,x
	inc.b $30,x
	jmp.w CODE_C5E9F6
CODE_C5EB52:						; from DATA8_C5EABA
	ldx.b $A1
	lda.b $01,x
	and.w #$00FF
	sta.b $38
	sta.b $3A
	phy
CODE_C5EB5E:						; from CODE_C5EB5E
	lda.b $02,x
	and.w #$00FF
	sta.w $0028,y
	iny
	iny
	inx
	dec.b $38
	bne CODE_C5EB5E
	ora.w #$FFFF
	sta.w $0028,y
	lda.b $3A
	sec
	plx
	adc.b $30,x
	sta.b $30,x
	stx.b $38
	pei ($9F)
CODE_C5EB7F:						; from CODE_C5EBA5
	jsr.w CODE_C5ECF1
	ldx.b $38
	ply
	jmp.w CODE_C5E9EA
CODE_C5EB88:						; no caller found (not traced)
	txy
	tax
	stx.b $38
	lda.w $0028,y
	sta.b $28,x
	inx
	inx
	lda.w $002A,y
	bmi CODE_C5EBA5
	sta.b $28,x
	inx
	inx
	lda.w $002C,y
	bmi CODE_C5EBA5
	sta.b $28,x
	inx
	inx
CODE_C5EBA5:						; from CODE_C5EB88
	lda.w #$FFFF
	sta.b $28,x
	ldx.b $38
	bra CODE_C5EB7F
CODE_C5EBAE:						; from DATA8_C5EABA
	tyx
	jsr.w CODE_C5E596
	ldy.b $9F
	clc
	jmp.w CODE_C5E9EA
CODE_C5EBB8:						; from DATA8_C5EABA
	ldx.b $A1
	lda.b $01,x
	and.w #$00FF
	cmp.w #$0004
	bcc CODE_C5EBC6
	brk #$00						; a brk in the ROM, between routines
CODE_C5EBC6:						; from CODE_C5EBB8
	asl a
	tax
	lda.l CODE_C5ECF1,x
	tax
	inc.w $0000,x
	tyx
	inc.b $30,x
	jmp.w CODE_C5E9F6
CODE_C5EBD6:						; from DATA8_C5EABA
	phy
	ldx.b $A1
	lda.b $01,x
	ply
	tyx
	inc.b $30,x
	jmp.w CODE_C5E9F6
CODE_C5EBE2:						; from DATA8_C5EABA
	phy
	ldx.b $A1
	lda.b $01,x
	and.w #$00FF
	tax
	ply
	tyx
	inc.b $30,x
	jmp.w CODE_C5E9F6
CODE_C5EBF2:						; from DATA8_C5EABA
	tyx
	lda.b $36,x
	eor.w #$4000
	sta.b $36,x
	jmp.w CODE_C5E9F6
CODE_C5EBFD:						; from DATA8_C5EABA
	tyx
	lda.b $36,x
	eor.w #$8000
	sta.b $36,x
	jmp.w CODE_C5E9F6
CODE_C5EC08:						; from DATA8_C5EABA
	tyx
	lda.b $36,x
	eor.w #$C000
	sta.b $36,x
	jmp.w CODE_C5E9F6
CODE_C5EC13:						; from DATA8_C5EABA
	tyx
	ldy.b $9F
	clc
	jmp.w CODE_C5E9EA
CODE_C5EC1A:						; from DATA8_C5EABA
	ldx.b $A1
	lda.b $01,x
	and.w #$00FF
	asl a
	tax
	jsr (CODE_C5ECF1,x)
	bcs CODE_C5EC2E
	tyx
	inc.b $30,x
	jmp.w CODE_C5E9F6
CODE_C5EC2E:						; from CODE_C5EC1A
	jmp.w CODE_C5EAF6
CODE_C5EC31:						; from DATA8_C5EABA
	jmp.w CODE_C5EAF6
CODE_C5EC34:						; from DATA8_C5EABA
	lda.w $0020,y
	sta.w $001E,y
	asl a
	adc.w $002E,y
	tax
	lda.b $00,x
	tyx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	lda.b $22,x
	ora.w #$4000
	sta.b $22,x
	jmp.w CODE_C5E9F6
CODE_C5EC52:						; from DATA8_C5EABA
	tyx
	lda.b $36,x
	ora.w #$4000
	sta.b $36,x
	jmp.w CODE_C5E9F6
CODE_C5EC5D:						; from DATA8_C5EABA
	tyx
	lda.b $36,x
	and.w #$BFFF
	sta.b $36,x
	jmp.w CODE_C5E9F6
CODE_C5EC68:						; from DATA8_C5EABA
	tyx
	lda.b $36,x
	ora.w #$8000
	sta.b $36,x
	jmp.w CODE_C5E9F6
CODE_C5EC73:						; from DATA8_C5EABA
	tyx
	lda.b $36,x
	and.w #$7FFF
	sta.b $36,x
	jmp.w CODE_C5E9F6
CODE_C5EC7E:						; from DATA8_C5EABA
	tyx
	lda.b $22,x
	and.w #$BFFF
	sta.b $22,x
	jmp.w CODE_C5E9F6
CODE_C5EC89:						; from DATA8_C5EABA
	lda.w $0022,y
	bit.w #$4000
	beq CODE_C5EC97
	tyx
	inc.b $30,x
	jmp.w CODE_C5E9F6
CODE_C5EC97:						; from CODE_C5EC89
	ldx.b $A1
	lda.b $01,x
	and.w #$00FF
	sta.w $0030,y
	tyx
	jmp.w CODE_C5E9F6
CODE_C5ECA5:						; no caller found (not traced)
	sta.b $1E,x
	asl a
	adc.b $2E,x
	phx
	tax
	lda.b $00,x
	plx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	lda.b $36,x
	and.w #$7FFF
	sta.b $36,x
	rts
CODE_C5ECBD:						; called from other segments
	cmp.b $1E,x
	beq CODE_C5ECE0
	sta.b $1E,x
	asl a
	adc.b $2E,x
	phx
	tax
	lda.b $00,x
	plx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	lda.b $36,x
	and.w #$7FFF
	sta.b $36,x
	lda.b $22,x
	ora.w #$4000
	sta.b $22,x
CODE_C5ECDF:						; from CODE_C5ECE0
	rtl
CODE_C5ECE0:						; from CODE_C5ECBD
	lda.b $22,x
	bit.w #$4000
	bne CODE_C5ECDF
	ora.w #$4000
	sta.b $22,x
	stz.b $30,x
	stz.b $0E,x
	rtl
CODE_C5ECF1:						; from CODE_C5EB7F, CODE_C5EC1A
	stx.b $18
	txy
	lda.b $10,x
	sta.b $10
	lda.b $14,x
	sta.b $12
	dec.b QueueBusy
	tsc
	sta.b $0A
	lda.b $00
	tcs
	lda.b $28,x
CODE_C5ED06:						; from CODE_C5EE24
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $00,x
	xba
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	sta.b $A3
	lda.b $00,x
	and.w #$FF00
	lsr a
	lsr a
	sta.b $A5
	lda.b $04,x
	sta.b $3C
	lda.b $A3
	beq CODE_C5ED52
	pha
	pei ($10)
	lsr a
	adc.b $10
	sta.b $10
	lda.b $3C
	bit.w #$0001
	beq CODE_C5ED5D
	pea.w $007E
	sty.b $42
	ldy.b $07,x
	sty.b $2E
	sty.b $32
	lda.b $05,x
	phb
	jsr.w UnpackStream0
	plb
	pei ($08)
	sty.b $08
	ldy.b $42
	bra CODE_C5ED6A
CODE_C5ED52:						; from CODE_C5ED06
	lda.b $07,x
	sta.b $2E
	sta.b $32
	lda.b $05,x
	tax
	bra CODE_C5ED6A
CODE_C5ED5D:						; from CODE_C5ED06
	lda.b $07,x
	pha
	sta.b $2E
	sta.b $32
	lda.b $05,x
	pha
	adc.b $A3
	tax
CODE_C5ED6A:						; from CODE_C5ED06, CODE_C5ED52
	lda.b $A5
	bne CODE_C5ED71
	jmp.w CODE_C5EE24
CODE_C5ED71:						; from CODE_C5ED6A
	lda.b $3C
	bit.w #$0002
	beq CODE_C5EDB1
	bit.w #$0001
	beq CODE_C5ED92
	sec
	lda.b $08
	sbc.b $A5
	sta.b $30
	sbc.b $A5
	sta.b $2C
	clc
	lda.w #$007E
	sta.b $2E
	sta.b $32
	bra CODE_C5EDB8
CODE_C5ED92:						; from CODE_C5ED71
	sty.b $42
	ldy.b $2E
	txa
	phb
	jsr.w UnpackStream0
	plb
	lda.w #$007E
	sta.b $2E
	sta.b $32
	lda.b $08
	sta.b $2C
	sty.b $08
	adc.b $A5
	sta.b $30
	ldy.b $42
	bra CODE_C5EDB8
CODE_C5EDB1:						; from CODE_C5ED71
	stx.b $2C
	txa
	adc.b $A5
	sta.b $30
CODE_C5EDB8:						; from CODE_C5ED71, CODE_C5ED92
	lda.b $12
	sta.b $0C
CODE_C5EDBC:						; from CODE_C5EDBC
	and.w #$00FF
	asl a
	sta.b $0E
	adc.b $A5
	cmp.w #$0201
	bcc CODE_C5EE01
	lda.w #$0200
	sbc.b $0E
	sta.b $0E
	pha
	pei ($0C)
	pei ($2E)
	pei ($2C)
	pha
	lda.b $0C
	adc.w #$00FF
	pha
	pei ($32)
	pei ($30)
	lda.b $2C
	adc.b $0E
	sta.b $2C
	lda.b $30
	adc.b $0E
	sta.b $30
	sec
	lda.b $A5
	sbc.b $0E
	sta.b $A5
	lda.b $0C
	adc.w #$01FF
	and.w #$FF00
	sta.b $0C
	bra CODE_C5EDBC
CODE_C5EE01:						; from CODE_C5EDBC
	pei ($A5)
	pei ($0C)
	pei ($2E)
	pei ($2C)
	pei ($A5)
	lda.b $0C
	adc.w #$0100
	pha
	pei ($32)
	pei ($30)
	lda.b $A5
	lsr a
	adc.b $0C
	bit.w #$0100
	beq CODE_C5EE22
	adc.w #$0100
CODE_C5EE22:						; from CODE_C5EE01
	sta.b $12
CODE_C5EE24:						; from CODE_C5ED6A
	iny
	iny
	lda.w $0028,y
	bmi CODE_C5EE30
	ldx.b $18
	jmp.w CODE_C5ED06
CODE_C5EE30:						; from CODE_C5EE24
	tsc
	sta.b $00
	lda.b $0A
	tcs
	stz.b QueueBusy
	ldy.b $18
	tyx
	rts
CODE_C5EE3C:						; no caller found (not traced)
	phx
	lda.b $34,x
	and.w #$00FF
	asl a
	tax
	lda.w $46B8,x
	bit.w #$00FF
	bne CODE_C5EE66
	xba
	ora.w #$FF00
	sta.w $46B8,x
	and.w #$00FF
	ldx.w $1B06
	dex
	dex
	sta.w $46A8,x
	stx.w $1B06
	dec.w $1B08
	plx
	rts
CODE_C5EE66:						; from CODE_C5EE3C
	dec a
	sta.w $46B8,x
	plx
	rts
CODE_C5EE6C:						; called from other segments
	sta.b $34,x
	txy
	asl a
	tax
	lda.w $46B8,x
	bpl CODE_C5EEE6
	lda.w $1B08
	cmp.w #$0008
	bcc CODE_C5EE80
	brk #$00						; a brk in the ROM, between routines
CODE_C5EE80:						; from CODE_C5EE6C
	inc a
	sta.w $1B08
	phx
	ldx.w $1B06
	lda.w $46A8,x
	inx
	inx
	stx.w $1B06
	plx
	xba
	sta.w $46B8,x
	ora.w $0034,y
	sta.w $0034,y
CODE_C5EE9B:						; called from other segments
	phy
	tay
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	tya
	xba
	and.w #$00FF
	adc.w #$0008
	asl a
	asl a
	asl a
	asl a
	pha
	tya
	bit.w #$0080
	bne CODE_C5EECE
	lda.l $808004
	pha
	tya
	and.w #$00FF
	xba
	lsr a
	lsr a
	lsr a
	adc.l $808002
	bra CODE_C5EEDB
CODE_C5EECE:						; from CODE_C5EE9B
	pea.w $00C0
	and.w #$007F
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$3F02
CODE_C5EEDB:						; from CODE_C5EE9B
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	plx
	rtl
CODE_C5EEE6:						; from CODE_C5EE6C
	inc a
	sta.w $46B8,x
	and.w #$FF00
	tyx
	ora.b $34,x
	sta.b $34,x
	rtl
CreateSpriteSharePal:				; CreateSprite, sharing the palette slot of the object in Y
	sta.b $10
	lda.w $1B02
	inc a
	cmp.w #$0009
	bcc CODE_C5EEFF
	rtl
CODE_C5EEFF:						; from CreateSpriteSharePal
	sty.b $1C
	sta.w $1B02
	dec a
	asl a
	tay
	ldx.w $1B04
	lda.w $1AF2,x
	inx
	inx
	stx.w $1B04
	sta.w $1AE2,y
	tax
	lda.b $18
	sta.b $05,x
	lda.b $1A
	sta.b $08,x
	lda.b $10
	sta.b $24,x
	lda.w #$0100
	sta.b $0A,x
	sta.b $0C,x
	sta.b $0E,x
	lda.b $D9
	sta.b $36,x
	stz.b $30,x
	stz.b $1E,x
	stz.b $38,x
	stz.b $20,x
	stz.b $34,x
	lda.w #$FFFF
	sta.b $28,x
	sta.b $2A,x
	sta.b $2C,x
	sta.b $00,x
	sta.b $22,x
	lda.b $10
	asl a
	adc.l $008000
	txy
	tax
	lda.b $00,x
	tax
	lda.b $09,x
	and.w #$00FF
	lda.b $00,x
	sta.w $0026,y
	lda.b $04,x
	lda.b $05,x
	lda.b $02,x
	sta.w $002E,y
	stx.b $10
	tax
	lda.b $00,x
	sta.w $0032,y
	ldx.b $10
	lda.b $07,x
	sta.b $10
	ldx.b $1C
	lda.b $34,x
	sta.w $0034,y
	and.w #$00FF
	asl a
	tax
	inc.w $46B8,x
	lda.b $10
	and.w #$00FF
	clc
	adc.b $1E
	sta.w $001A,y
	jsr.w CODE_C5E851
	bcs CODE_C5EFB1
	lda.b $10
	xba
	and.w #$00FF
	adc.b $20
	sta.w $001C,y
	jsr.w CODE_C5E86F
	bcs CODE_C5EFBD
	ldx.w $1B0E
	bmi CODE_C5EFA9
	sty.b $00,x
CODE_C5EFA9:						; from CODE_C5EEFF
	txa
	tyx
	sta.b $02,x
	stx.w $1B0E
	rtl
CODE_C5EFB1:						; from CODE_C5EEFF
	lda.b $10
	xba
	and.w #$00FF
	clc
	adc.b $20
	sta.w $001C,y
CODE_C5EFBD:						; from CODE_C5EEFF
	ldx.w $1B0E
	bpl CODE_C5F021
	brk #$00						; a brk in the ROM, between routines
CODE_C5EFC4:						; from CODE_C5F021
	lsr a
	lsr a
	lsr a
	lsr a
	cmp.w $001A,y
	bcc CODE_C5F02F
	lda.b $16,x
	sbc.b $18,x
	cmp.w $001C,y
	bcc CODE_C5F02F
	lda.b $12,x
	sta.w $0010,y
	sta.w $0012,y
	lda.w $001A,y
	asl a
	asl a
	asl a
	asl a
	adc.w $0010,y
	sta.b $12,x
	lda.b $18,x
	sta.w $0016,y
	sta.w $0018,y
	clc
	adc.w $001C,y
	sta.b $18,x
	lda.b $02,x
	sta.w $0002,y
	sty.b $02,x
	txa
	tyx
	sta.w $0000,y
	lda.b $02,x
	bmi CODE_C5F00E
	tay
	txa
	sta.w $0000,y
	tay
CODE_C5F00E:						; from CODE_C5EFC4
	lda.b $16,x
	asl a
	tax
	lda.l DATA8_C04AA9,x
	asl a
	asl a
	asl a
	asl a
	adc.b $DB
	tyx
	sta.b $14,x
	clc
	rtl
CODE_C5F021:						; from CODE_C5EFBD, CODE_C5F02F
	sec
	lda.b $10,x
	sbc.b $12,x
	bne CODE_C5EFC4
	sec
	lda.b $16,x
	sbc.b $18,x
	bne CODE_C5EFC4
CODE_C5F02F:						; from CODE_C5EFC4
	lda.b $02,x
	tax
	bpl CODE_C5F021
	lda.w $0034,y
	and.w #$00FF
	asl a
	tax
	lda.w $46B8,x
	bit.w #$00FF
	bne CODE_C5F057
	lda.w #$FFFF
	sta.w $46B8,x
	lda.w $1B06
	dec a
	dec a
	sta.w $1B06
	dec.w $1B08
	bra CODE_C5F05B
CODE_C5F057:						; from CODE_C5F02F
	dec a
	sta.w $46B8,x
CODE_C5F05B:						; from CODE_C5F02F
	dec.w $1B04
	dec.w $1B04
	dec.w $1B02
	lda.w $1B02
	asl a
	tax
	lda.w #$FFFF
	sta.w $1AE2,x
	sec
	rtl

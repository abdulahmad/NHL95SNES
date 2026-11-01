; Segment bankC4_B000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4B00F
CODE_C4B00F:						; called from other segments
	ldy.b $6B
	lda.w $12FF,y
	bit.w #$0010
	bne CODE_C4B01C
	jmp.w CODE_C4AF74
CODE_C4B01C:						; from CODE_C4B00F
	lda.w $1283,y
	sta.b $63
	lda.w #$0005
	sta.b $83
CODE_C4B026:						; from CODE_C4B04E
	ldy.b $63
	lda.w $0A20,y
	bmi CODE_C4B03F
	lda.w $0896,y
	sta.b $7F
	lda.w $0FE0,y
	bne CODE_C4B03F
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
CODE_C4B03F:						; from CODE_C4B026
	inc.b $63
	inc.b $63
	lda.b $7F
	sec
	sbc.w #$005C
	bmi CODE_C4B04E
	jmp.w CODE_C4AF74
CODE_C4B04E:						; from CODE_C4B03F
	dec.b $83
	bpl CODE_C4B026
	ldy.b $6B
	lda.w $12FF,y
	and.w #$FFEF
	sta.w $12FF,y
	rtl
CODE_C4B05E:						; passed as a long pointer (lda # of its bank and address) to SetNMIHook
	sep #$20
	lda.w $18D0
	sta.w $211B
	lda.w $18D1
	sta.w $211B
	lda.w $18D0
	sta.w $211E
	lda.w $18D1
	sta.w $211E
	lda.w $18D2
	sta.w $211F
	lda.w $18D3
	sta.w $211F
	lda.w $18D4
	sta.w $2120
	lda.w $18D5
	sta.w $2120
	lda.w $18D6
	sta.w $211A
	lda.w $18D8
	sta.w TM
	rep #$20
	rtl
CODE_C4B09F:						; called from other segments
	jsl.l CODE_C36D3A
	jsl.l CODE_C36C2D
	ldx.w #$00C0
	lda.w #$7F7B
	jsl.l $CF0134
	lda.w #CODE_C4B05E
	ldx.w #CODE_C4B05E>>16
	jsl.l SetNMIHook
	jsl.l CODE_C4B6EB
	stz.b $81
	lda.b $C1
	jsr.w CODE_C4B1D6
	lda.b $C3
	jsr.w CODE_C4B1D6
	lda.b $C5
	jsr.w CODE_C4B1D6
	lda.b $C7
	jsr.w CODE_C4B1D6
	lda.b $C9
	jsr.w CODE_C4B1D6
	jsl.l CODE_C58B48
	lda.w #$7FFF
	jsl.l CODE_C58B2E
	lda.b $08
	sta.b $65
	lda.w #$0021
	jsl.l CreateSprite
	stx.b $63
	lda.w #$0066
	ldy.w #$0043
	jsr.w CODE_C4B280
	jsl.l AnimateSprites
	jsl.l CODE_C4C541
	lda.b $08
	sta.b $69
	lda.w #$0022
	jsl.l CreateSprite
	stx.b $67
	lda.w #$009F
	ldy.w #$0043
	jsr.w CODE_C4B280
	jsl.l AnimateSprites
	jsl.l CODE_C4C541
	lda.b $08
	sta.b $6D
	lda.w #$0023
	jsl.l CreateSprite
	stx.b $6B
	lda.w #$0080
	ldy.w #$007C
	jsr.w CODE_C4B280
	jsl.l AnimateSprites
	jsl.l CODE_C4C541
	lda.b $08
	sta.b $71
	lda.w #$0024
	jsl.l CreateSprite
	stx.b $6F
	lda.w #$0080
	ldy.w #$0094
	jsr.w CODE_C4B280
	jsl.l AnimateSprites
	jsl.l CODE_C4C541
	lda.w #$0025
	jsl.l CreateSprite
	stx.b $7B
	lda.w #$0080
	ldy.w #$00B4
	jsr.w CODE_C4B280
	jsl.l CODE_C4C541
	lda.w #$0010
	sta.w $18D8
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	jsl.l CODE_C4CEDB
	lda.w #$F254
	sta.b $8B
	ldx.b $63
	ldy.b $65
	jsr.w CODE_C4B36A
	lda.w #CODE_C4B1E4
	ldx.w #CODE_C4B1E4>>16
	ldy.w #$0001
	clc
	jsl.l CODE_C4B743
	jsl.l CODE_C4B738
	lda.w #CODE_C4B66E
	ldx.w #CODE_C4B66E>>16
	ldy.w #$F000
	jsl.l CODE_C4B763
	lda.b $63
	ldx.w #$0001
	jsr.w CODE_C4B299
	stz.w fadestep
CODE_C4B1C9:						; from CODE_C4B1C9
	jsl.l CODE_C4B7D4
	lda.w $2D9D
	beq CODE_C4B1C9
	jml.l ClearNMIHook
CODE_C4B1D6:						; from CODE_C4B09F
	and.w #$F0C0
	cmp.w #$F0C0
	bne CODE_C4B1E3
	lda.w #$8000
	tsb.b $81
CODE_C4B1E3:						; from CODE_C4B1D6
	rts
CODE_C4B1E4:						; passed as a long pointer (lda # of its bank and address) to CODE_C4B743
	lda.w $18D0
	cmp.w #$0100
	beq CODE_C4B1EF
	jmp.w CODE_C4B27F
CODE_C4B1EF:						; from CODE_C4B1E4
	ldx.b $67
	ldy.b $69
	jsr.w CODE_C4B36A
	lda.b $67
	ldx.w #$0001
	jsr.w CODE_C4B299
	ldx.b $83
	lda.w #CODE_C4B206
	sta.w $0002,x
CODE_C4B206:						; a task routine: stored as the next routine of a task
	lda.w $18D0
	cmp.w #$0100
	beq CODE_C4B211
	jmp.w CODE_C4B27F
CODE_C4B211:						; from CODE_C4B206
	ldx.b $6B
	ldy.b $6D
	jsr.w CODE_C4B36A
	lda.b $6B
	ldx.w #$0000
	jsr.w CODE_C4B299
	ldx.b $83
	lda.w #CODE_C4B228
	sta.w $0002,x
CODE_C4B228:						; a task routine: stored as the next routine of a task
	lda.w $18D0
	cmp.w #$0100
	bne CODE_C4B27F
	ldx.b $6F
	ldy.b $71
	jsr.w CODE_C4B36A
	lda.b $6F
	ldx.w #$0000
	jsr.w CODE_C4B299
	ldx.b $83
	lda.w #CODE_C4B247
	sta.w $0002,x
CODE_C4B247:						; a task routine: stored as the next routine of a task
	lda.w $18D0
	cmp.w #$0100
	bne CODE_C4B27F
	ldx.b $83
	stz.w $0008,x
	lda.w #CODE_C4B25A
	sta.w $0002,x
CODE_C4B25A:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$001E
	bne CODE_C4B27F
	ldx.b $7B
	jsr.w CODE_C4B31A
	ldx.b $83
	stz.w $0008,x
	lda.w #CODE_C4B272
	sta.w $0002,x
CODE_C4B272:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$0258
	bne CODE_C4B27F
	lda.w #$8000
	trb.b $85
CODE_C4B27F:						; from CODE_C4B1E4, CODE_C4B206, CODE_C4B228, CODE_C4B247, ...
	rtl
CODE_C4B280:						; from CODE_C4B09F, CODE_C4B10D
	bit.b $81
	bpl CODE_C4B28C
	sec
	sbc.w #$0100
	eor.w #$FFFF
	inc a
CODE_C4B28C:						; from CODE_C4B280
	sta.b $05,x
	tya
	sta.b $08,x
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	rts
CODE_C4B299:						; from CODE_C4B10D, CODE_C4B228, CODE_C4B1EF, CODE_C4B211
	sta.b $7F
	lda.w #$0001
	trb.b $81
	txa
	tsb.b $81
	lda.w #$0011
	sta.w $18D8
	lda.w #$4000
	sta.w $18D0
	lda.w #CODE_C4B2BD
	ldx.w #CODE_C4B2BD>>16
	ldy.w #$1000
	jsl.l CODE_C4B763
	rts
CODE_C4B2BD:						; passed as a long pointer (lda # of its bank and address) to CODE_C4B763
	jsr.w CODE_C4B2F9
	cmp.w #$0280
	bcs CODE_C4B2F8
	lda.w #CODE_C4B2DC
	sta.w $0002,x
	lda.b $81
	lsr a
	bcc CODE_C4B2F8
	lda.w #CODE_C4B32D
	ldx.w #CODE_C4B32D>>16
	ldy.w #$0500
	jmp.w CODE_C4B763
CODE_C4B2DC:						; a task routine: stored as the next routine of a task
	jsr.w CODE_C4B2F9
	cmp.w #$0100
	bcs CODE_C4B2F8
	lda.w #$0100
	sta.w $18D0
	lda.w #$0010
	sta.w $18D8
	ldx.b $7F
	jsr.w CODE_C4B31A
	jmp.w CODE_C4B79E
CODE_C4B2F8:						; from CODE_C4B2BD, CODE_C4B2DC
	rtl
CODE_C4B2F9:						; from CODE_C4B2BD, CODE_C4B2DC
	lda.w $18D0
	lsr a
	lsr a
	cmp.w #$0280
	bcc CODE_C4B306
	lda.w #$0280
CODE_C4B306:						; from CODE_C4B2F9
	cmp.w #$0020
	bcs CODE_C4B30E
	lda.w #$0020
CODE_C4B30E:						; from CODE_C4B306
	sec
	sbc.w $18D0
	eor.w #$FFFF
	inc a
	sta.w $18D0
	rts
CODE_C4B31A:						; from CODE_C4B25A, CODE_C4B2DC
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	bit.b $81
	bpl CODE_C4B32C
	lda.b $36,x
	ora.w #$4000
	sta.b $36,x
CODE_C4B32C:						; from CODE_C4B31A
	rts
CODE_C4B32D:						; passed as a long pointer (lda # of its bank and address) to CODE_C4B763
	and.w #$00FF
	sep #$20
	lda.w $0008,x
	tax
	lda.l DATA8_C4B35D,x
	beq CODE_C4B34E
	sta.l $002132
	lda.b #$01
	sta.l $002131
	dec a
	sta.l $002130
	rep #$20
	rtl
CODE_C4B34E:						; from CODE_C4B32D
	sta.l $002131
	lda.b #$E0
	sta.l $002132
	rep #$20
	jmp.w CODE_C4B79E
DATA8_C4B35D:						; not traced: a table read by CODE_C4B32D
	db $64,$68,$6C,$70,$74,$78,$7C,$7F,$78,$70,$68,$64,$00
CODE_C4B36A:						; from CODE_C4B10D, CODE_C4B228, CODE_C4B1EF, CODE_C4B211
	lda.b $34,x
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0080
	sta.b $79
	jsl.l CODE_C4C536
	phx
	stz.b $73
	lda.b $28,x
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $01,x
	and.w #$00FF
	asl a
	asl a
	sta.b $77
	ldx.b $08
CODE_C4B393:						; from CODE_C4B4B6
	sep #$20
	lda.b #$08
	sta.b $75
CODE_C4B399:						; from CODE_C4B399
	lda.w $0000,y
	and.b #$80
	jsr.w CODE_C4B669
	lda.w $0001,y
	and.b #$80
	jsr.w CODE_C4B668
	lda.w $0010,y
	and.b #$80
	jsr.w CODE_C4B667
	lda.w $0011,y
	and.b #$80
	jsr.w CODE_C4B660
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$40
	jsr.w CODE_C4B668
	lda.w $0001,y
	and.b #$40
	jsr.w CODE_C4B667
	lda.w $0010,y
	and.b #$40
	jsr.w CODE_C4B660
	lda.w $0011,y
	and.b #$40
	jsr.w CODE_C4B661
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$20
	jsr.w CODE_C4B667
	lda.w $0001,y
	and.b #$20
	jsr.w CODE_C4B660
	lda.w $0010,y
	and.b #$20
	jsr.w CODE_C4B661
	lda.w $0011,y
	and.b #$20
	jsr.w CODE_C4B662
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$10
	jsr.w CODE_C4B660
	lda.w $0001,y
	and.b #$10
	jsr.w CODE_C4B661
	lda.w $0010,y
	and.b #$10
	jsr.w CODE_C4B662
	lda.w $0011,y
	and.b #$10
	jsr.w CODE_C4B663
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$08
	jsr.w CODE_C4B661
	lda.w $0001,y
	and.b #$08
	jsr.w CODE_C4B662
	lda.w $0010,y
	and.b #$08
	jsr.w CODE_C4B663
	lda.w $0011,y
	and.b #$08
	tsb.b $73
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$04
	jsr.w CODE_C4B662
	lda.w $0001,y
	and.b #$04
	jsr.w CODE_C4B663
	lda.w $0010,y
	and.b #$04
	tsb.b $73
	lda.w $0011,y
	and.b #$04
	jsr.w CODE_C4B66A
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$02
	jsr.w CODE_C4B663
	lda.w $0001,y
	and.b #$02
	tsb.b $73
	lda.w $0010,y
	and.b #$02
	jsr.w CODE_C4B66A
	lda.w $0011,y
	and.b #$02
	jsr.w CODE_C4B669
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$01
	tsb.b $73
	lda.w $0001,y
	and.b #$01
	jsr.w CODE_C4B66A
	lda.w $0010,y
	and.b #$01
	jsr.w CODE_C4B669
	lda.w $0011,y
	and.b #$01
	jsr.w CODE_C4B668
	jsr.w CODE_C4B653
	iny
	iny
	dec.b $75
	beq CODE_C4B4B6
	jmp.w CODE_C4B399
CODE_C4B4B6:						; from CODE_C4B399
	rep #$20
	tya
	clc
	adc.w #$0010
	tay
	dec.b $77
	beq CODE_C4B4C5
	jmp.w CODE_C4B393
CODE_C4B4C5:						; from CODE_C4B4B6
	plx
	phx
	lda.b $28,x
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $00,x
	and.w #$FF00
	tay
	lda.w #$0040
	sta.b $73
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	lda.w brightness
	cmp.w #$0080
	bne CODE_C4B4EE
	tya
	bra CODE_C4B4FD
CODE_C4B4EE:						; from CODE_C4B4C5, CODE_C4B4FD
	tya
	eor.w #$FFFF
	inc a
	cmp.b $8B
	bcs CODE_C4B4F9
	lda.b $8B
CODE_C4B4F9:						; from CODE_C4B4EE
	eor.w #$FFFF
	inc a
CODE_C4B4FD:						; from CODE_C4B4C5
	pha
	sta.b $75
	pea.w $0080
	pei ($73)
	pea.w $1900
	pea.w $007E
	pei ($08)
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	lda.b $75
	adc.b $73
	sta.b $73
	lda.b $08
	adc.b $75
	sta.b $08
	tya
	sec
	sbc.b $75
	tay
	beq CODE_C4B53B
	inc.w TransfersReady
	wai
	lda.w #$F254
	sta.b $8B
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	bra CODE_C4B4EE
CODE_C4B53B:						; from CODE_C4B4FD
	lda.b $8B
	clc
	adc.b $75
	sta.b $8B
	cmp.w #$FF10
	bcc CODE_C4B54B
	inc.w TransfersReady
	wai
CODE_C4B54B:						; from CODE_C4B53B
	ldx.b $08
	ldy.w #$0E00
CODE_C4B550:						; from CODE_C4B550
	stz.w $0000,x
	inx
	inx
	dey
	bne CODE_C4B550
	ply
	lda.w $0028,y
	asl a
	adc.w $0026,y
	tax
	lda.b $00,x
	tax
	lda.b $02,x
	tax
	lda.l SpritePieces,x
	eor.w #$FFFF
	inc a
	sta.w $18D2
	lda.l SpritePieces+2,x
	eor.w #$FFFF
	inc a
	sta.w $18D4
	lda.w $0005,y
	sec
	sbc.w $18D2
	eor.w #$FFFF
	inc a
	sta.w $04BC
	lda.w $0008,y
	sec
	sbc.w $18D4
	eor.w #$FFFF
	sta.w $04BE
	bit.b $81
	bpl CODE_C4B5BA
	lda.w $0005,y
	sec
	sbc.w #$0100
	eor.w #$FFFF
	inc a
	sec
	sbc.w $18D2
	eor.w #$FFFF
	inc a
	sta.w $04BC
	lda.w #$0001
	tsb.w $18D6
	bra CODE_C4B5C0
CODE_C4B5BA:						; from CODE_C4B550
	lda.w #$0001
	trb.w $18D6
CODE_C4B5C0:						; from CODE_C4B550
	lda.w #$0001
	sta.b $73
	phx
	lda.w $0028,y
	asl a
	adc.w $0026,y
	tax
	lda.b $00,x
	tax
	lda.b $01,x
	and.w #$00FF
	plx
	sta.b $77
	asl a
	inc a
	sta.b $75
CODE_C4B5DD:						; from CODE_C4B5DD
	lda.l SpritePieces+4,x
	and.w #$00FF
	lsr a
	lsr a
	lsr a
	sta.b $79
	lda.l SpritePieces+5,x
	and.w #$00FF
	asl a
	asl a
	asl a
	asl a
	adc.b $79
	adc.b $08
	tay
	sep #$20
	lda.b $73
	sta.w $0000,y
	inc a
	sta.w $0001,y
	inc a
	sta.b $73
	lda.b $75
	sta.w $0080,y
	inc a
	sta.w $0081,y
	inc a
	sta.b $75
	rep #$20
	inx
	inx
	dec.b $77
	bne CODE_C4B5DD
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b $73
	lda.b $08
	clc
	ldx.w #$000A
CODE_C4B62B:						; from CODE_C4B62B
	pea.w $0018
	pea.w $0000
	pei ($73)
	pea.w $1800
	pea.w $007E
	pha
	lda.b $73
	adc.w #$0080
	sta.b $73
	adc.b $08
	dex
	bpl CODE_C4B62B
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	inc.w TransfersReady
	wai
	rts
CODE_C4B653:						; from CODE_C4B399
	lda.b $73
	beq CODE_C4B659
	ora.b $79
CODE_C4B659:						; from CODE_C4B653
	sta.w $0000,x
	inx
	stz.b $73
	rts
CODE_C4B660:						; from CODE_C4B399
	lsr a
CODE_C4B661:						; from CODE_C4B399
	lsr a
CODE_C4B662:						; from CODE_C4B399
	lsr a
CODE_C4B663:						; from CODE_C4B399
	lsr a
	tsb.b $73
	rts
CODE_C4B667:						; from CODE_C4B399
	rol a
CODE_C4B668:						; from CODE_C4B399
	rol a
CODE_C4B669:						; from CODE_C4B399
	rol a
CODE_C4B66A:						; from CODE_C4B399
	rol a
	tsb.b $73
	rts
CODE_C4B66E:						; passed as a long pointer (lda # of its bank and address) to CODE_C4B763
	lda.w $0008,x
	cmp.w #$001E
	bcc CODE_C4B688
	lda.w #CODE_C4B689
	sta.w $0002,x
	lda.w #$0014
	jsl.l $CF040B
	lda.w #$0011
	bra CODE_C4B6CE
CODE_C4B688:						; a task routine: stored as the next routine of a task
	rtl
CODE_C4B689:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$003C
	bcc CODE_C4B688
	lda.w #CODE_C4B6A3
	sta.w $0002,x
	lda.w #$0013
	jsl.l $CF040B
	lda.w #$0010
	bra CODE_C4B6CE
CODE_C4B6A3:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$005A
	bcc CODE_C4B688
	lda.w #CODE_C4B6BD
	sta.w $0002,x
	lda.w #$0016
	jsl.l $CF040B
	lda.w #$0009
	bra CODE_C4B6CE
CODE_C4B6BD:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$0096
	bcc CODE_C4B688
	lda.w #CODE_C4B688
	sta.w $0002,x
	lda.w #$0015
CODE_C4B6CE:						; from CODE_C4B66E, CODE_C4B689, CODE_C4B6A3
	jml.l $CF040B
CODE_C4B6D2:						; passed as a long pointer (lda # of its bank and address) to CODE_C4B763
	lda.w $0008,x
	cmp.w #$0177
	bcc CODE_C4B6EA
	lda.w #$00A4
	jsl.l $CF040B
	stz.w $1EA7
	lda.w #CODE_C4B6EA
	sta.w $0002,x
CODE_C4B6EA:						; a task routine: stored as the next routine of a task
	rtl
CODE_C4B6EB:						; from CODE_C4B09F, CODE_C4B743, CODE_C4B97E and other segments
	ldx.w #$0000
	lda.w #$2CF7
	clc
CODE_C4B6F2:						; from CODE_C4B6F2
	sta.w $2D6F,x
	adc.w #$000C
	inx
	inx
	cpx.w #$0014
	bne CODE_C4B6F2
	stz.w $2D6F,x
	stz.w $2D83
	lda.w #CODE_C4B805
	sta.w $2D87
	sta.w $2D93
	lda.w #CODE_C4B805>>16
	sta.w $2D89
	sta.w $2D95
	stz.w $2D8B
	lda.w #$2D91
	sta.w $2D85
	lda.w #$FFFF
	sta.w $2D97
	stz.w $2D91
	lda.w #$8002
	sta.b $85
	lda.w $2D9D
	sta.w $2D9F
	stz.w $2D9D
	rtl
CODE_C4B738:						; from CODE_C4B10D, CODE_C4B97E and other segments
	lda.w #CODE_C4B828
	ldx.w #CODE_C4B828>>16
	ldy.w #$F000
	bra CODE_C4B763
CODE_C4B743:						; from CODE_C4B10D, CODE_C4B97E and other segments
	pha
	phx
	phy
	php
	jsl.l CODE_C4B6EB
	lda.w #CODE_C4B7F4
	ldx.w #CODE_C4B7F4>>16
	ldy.w #$FFFE
	jsl.l CODE_C4B763
	plp
	bcc CODE_C4B760
	lda.w #$0002
	trb.b $85
CODE_C4B760:						; from CODE_C4B743
	ply
	plx
	pla
CODE_C4B763:						; from CODE_C4B10D, CODE_C4B2BD, CODE_C4B738, CODE_C4B743, ...
	phx
	pha
	ldx.w #$2D85
	phy
	tya
CODE_C4B76A:						; from CODE_C4B76A
	cmp.w $0006,x
	bcc CODE_C4B775
	txy
	ldx.w $0000,y
	bne CODE_C4B76A
CODE_C4B775:						; from CODE_C4B76A
	ldx.w $2D83
	lda.w $2D6F,x
	inx
	inx
	stx.w $2D83
	tax
	pla
	sta.w $0006,x
	stz.w $0008,x
	stz.w $000A,x
	pla
	sta.w $0002,x
	pla
	sta.w $0004,x
	lda.w $0000,y
	sta.w $0000,x
	txa
	sta.w $0000,y
	rtl
CODE_C4B79E:						; from CODE_C4B2DC, CODE_C4B34E
	ldy.b $83
	lda.w $0002,y
	ldx.w $0004,y
	sta.b $87
	stx.b $89
	ldx.w #$2D85
CODE_C4B7AD:						; from CODE_C4B7BB
	cmp.w $0002,x
	bne CODE_C4B7BB
	lda.b $89
	cmp.w $0004,x
	beq CODE_C4B7C1
	lda.b $87
CODE_C4B7BB:						; from CODE_C4B7AD
	txy
	ldx.w $0000,y
	bne CODE_C4B7AD
CODE_C4B7C1:						; from CODE_C4B7AD
	lda.w $0000,x
	sta.w $0000,y
	txa
	ldx.w $2D83
	dex
	dex
	sta.w $2D6F,x
	stx.w $2D83
	rtl
CODE_C4B7D4:						; from CODE_C4B1C9, CODE_C4BA56 and other segments
	ldx.w $2D85
CODE_C4B7D7:						; from CODE_C4B7D7
	stx.b $83
	inc.w $0008,x
	lda.w $0004,x
	sta.w $1853
	lda.w $0002,x
	sta.w $1851
	jsl.l $001850
	ldy.b $83
	ldx.w $0000,y
	bne CODE_C4B7D7
	rtl
CODE_C4B7F4:						; passed as a long pointer (lda # of its bank and address) to CODE_C4B763
	bit.b $85
	bmi CODE_C4B804
	jsl.l FadeOutWait
	lda.w $2D9F
	tax
	inc a
	sta.w $2D9D
CODE_C4B804:						; from CODE_C4B7F4
	rtl
CODE_C4B805:						; stored as a long pointer in RAM by CODE_C4B6F2 (reader not traced)
	lda.b $85
	bit.w #$0002
	beq CODE_C4B81E
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
CODE_C4B81E:						; from CODE_C4B805
	inc.w TransfersReady
	wai
	lda.w #$F254
	sta.b $8B
	rtl
CODE_C4B828:						; passed as a long pointer (lda # of its bank and address) to CODE_C4B6EB
	jsl.l CODE_C36C2D
	lda.w $058F
	bne CODE_C4B843
	lda.w $058D
	bit.w #$1000
	beq CODE_C4B843
	lda.w #$8000
	trb.b $85
	lda.w #$0001
	tsb.b $85
CODE_C4B843:						; from CODE_C4B828
	rtl
CODE_C4B844:						; no caller found (not traced)
	sta.w $2D9D
	lda.w #$1FFC
	tcs
	rtl
CODE_C4B84C:						; called from other segments
	pha
	lda.w #$0010
	sta.b $8B
	pla
CODE_C4B853:						; from CODE_C4B97E, CODE_C4BA75 and other segments
	sta.b $77
	stx.b $79
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	lda.b $8B
	asl a
	pha
	phy
	pei ($79)
	pei ($77)
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	rtl
CODE_C4B871:						; from CODE_C4BA75 and other segments
	tax
	lda.b $8B
	jsr.w CODE_C4B955
	lda.b $8B
	sta.b $77
	ldy.w #$0000
CODE_C4B87E:						; from CODE_C4B87E
	lda.b ($63),y
	xba
	and.w #$00FF
	pha
	lda.b ($65),y
	xba
	and.w #$00FF
	asl a
	asl a
	asl a
	asl a
	asl a
	ora.b $01,s
	sta.b $01,s
	lda.b ($67),y
	and.w #$FF00
	asl a
	asl a
	ora.b $01,s
	sta.b $01,s
	pla
	sta.w $0000,x
	inx
	inx
	iny
	iny
	dec.b $77
	bne CODE_C4B87E
	rtl
CODE_C4B8AC:						; from CODE_C4BA75 and other segments
	lda.b $8B
	jsr.w CODE_C4B955
	ldx.b $8B
	ldy.w #$0000
CODE_C4B8B6:						; from CODE_C4B8B6
	lda.b ($63),y
	clc
	adc.b ($69),y
	sta.b ($63),y
	lda.b ($65),y
	clc
	adc.b ($6B),y
	sta.b ($65),y
	lda.b ($67),y
	clc
	adc.b ($6D),y
	sta.b ($67),y
	iny
	iny
	dex
	bne CODE_C4B8B6
	rtl
CODE_C4B8D1:						; from CODE_C4B97E and other segments
	sta.b $73
	stx.b $75
	lda.b $8B
	jsr.w CODE_C4B955
	ldx.b $8B
	ldy.w #$0000
CODE_C4B8DF:						; from CODE_C4B8DF
	lda.b [$6F],y
	pha
	and.w #$001F
	sta.b $77
	xba
	sta.b ($63),y
	lda.b $01,s
	and.w #$03E0
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b $79
	xba
	sta.b ($65),y
	pla
	and.w #$7C00
	xba
	lsr a
	lsr a
	sta.b $7B
	xba
	sta.b ($67),y
	lda.b [$73],y
	pha
	and.w #$001F
	sec
	sbc.b $77
	jsr.w CODE_C4B93A
	sta.b ($69),y
	lda.b $01,s
	and.w #$03E0
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	sec
	sbc.b $79
	jsr.w CODE_C4B93A
	sta.b ($6B),y
	pla
	and.w #$7C00
	xba
	lsr a
	lsr a
	sec
	sbc.b $7B
	jsr.w CODE_C4B93A
	sta.b ($6D),y
	iny
	iny
	dex
	bne CODE_C4B8DF
	rtl
CODE_C4B93A:						; from CODE_C4B8DF
	phx
	xba
	and.w #$FF00
	php
	bpl CODE_C4B946
	eor.w #$FFFF
	inc a
CODE_C4B946:						; from CODE_C4B93A
	ldx.b $7D
	jsl.l CODE_C58AD9
	plp
	bpl CODE_C4B953
	eor.w #$FFFF
	inc a
CODE_C4B953:						; from CODE_C4B946
	plx
	rts
CODE_C4B955:						; from CODE_C4B871, CODE_C4B8AC, CODE_C4B8D1
	asl a
	sta.b $77
	tya
	sta.b $63
	adc.b $77
	sta.b $65
	adc.b $77
	sta.b $67
	adc.b $77
	sta.b $69
	adc.b $77
	sta.b $6B
	adc.b $77
	sta.b $6D
	rts
CODE_C4B970:						; from CODE_C4B97E and other segments
	tax
	tya
	ldy.b $8B
CODE_C4B974:						; from CODE_C4B974
	sta.l $7E0000,x
	inx
	inx
	dey
	bne CODE_C4B974
	rtl
CODE_C4B97E:						; called from other segments
	jsl.l CODE_C4B6EB
	jsl.l CODE_C58BE4
	jsl.l ResetPPURegs
	jsl.l CODE_C58B2B
	lda.w #$5900
	sta.b $9F
	stz.b $A1
	ldx.w #$00C2
	lda.w #$B14A
	ldy.w #$2000
	jsl.l MapSetToVRAM
	lda.w #$50C0
	sta.b $9F
	lda.w #$0800
	sta.b $A1
	ldx.w #$00C2
	lda.w #$BB69
	ldy.w #$0000
	jsl.l MapSetToVRAM
	sep #$20
	lda.b #$02
	sta.l $002130
	sta.l TS
	dec a
	sta.l $002131
	rep #$20
	lda.w #$003C
	sta.b $7D
	lda.b $08
	sta.b $8F
	clc
	adc.w #$0040
	sta.b $93
	adc.w #$0180
	sta.b $97
	adc.w #$00C0
	sta.b $9B
	adc.w #$0480
	sta.b $08
	jsl.l CODE_C4C541
	lda.w #$0060
	sta.b $8B
	lda.b $97
	ldy.w #$0000
	jsl.l CODE_C4B970
	lda.w #$CBAE
	sta.b $6F
	lda.w #$00C2
	sta.b $71
	lda.b $97
	ldx.w #$007E
	ldy.b $9B
	jsl.l CODE_C4B8D1
	lda.w #$0020
	sta.b $8B
	lda.b $8F
	sta.b $6F
	ldx.w #$007E
	stx.b $71
	ldy.w #$0000
	jsl.l CODE_C4B970
	lda.w #$BB29
	ldx.w #$00C2
	ldy.b $93
	jsl.l CODE_C4B8D1
	lda.b $8F
	ldx.w #$007E
	ldy.w #$0000
	jsl.l CODE_C4B853
	stz.w fadestep
	stz.w fadestep
	lda.w #CODE_C4BA67
	ldx.w #CODE_C4BA67>>16
	ldy.w #$0001
	sec
	jsl.l CODE_C4B743
	jsl.l CODE_C4B738
CODE_C4BA56:						; from CODE_C4BA56
	jsl.l CODE_C4B7D4
	lda.w $2D9D
	beq CODE_C4BA56
	lda.w #$0000
	sta.l $002130
	rtl
CODE_C4BA67:						; passed as a long pointer (lda # of its bank and address) to CODE_C4B743
	lda.w $0008,x
	cmp.w #$00B4
	bne CODE_C4BAD5
	lda.w #CODE_C4BA75
	sta.w $0002,x
CODE_C4BA75:						; a task routine: stored as the next routine of a task
	lda.w #$0060
	sta.b $8B
	ldy.b $9B
	jsl.l CODE_C4B8AC
	lda.b $97
	ldx.w #$007E
	ldy.b $9B
	jsl.l CODE_C4B871
	lda.b $97
	ldx.w #$007E
	ldy.w #$0020
	jsl.l CODE_C4B853
	lda.w #$0020
	sta.b $8B
	ldy.b $93
	jsl.l CODE_C4B8AC
	lda.b $8F
	ldx.w #$007E
	ldy.b $93
	jsl.l CODE_C4B871
	lda.b $8F
	ldx.w #$007E
	ldy.w #$0000
	jsl.l CODE_C4B853
	dec.b $7D
	bne CODE_C4BAD5
	ldx.b $83
	stz.w $0008,x
	lda.w #CODE_C4BAC8
	sta.w $0002,x
CODE_C4BAC8:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$00B4
	bne CODE_C4BAD5
	lda.w #$8000
	trb.b $85
CODE_C4BAD5:						; from CODE_C4BA67, CODE_C4BA75, CODE_C4BAC8
	rtl
DATA8_C4BAD6:						; not traced: data between routines
	db $00,$00,$00,$00,$CE,$39,$FF,$7F,$40,$01,$00,$00,$BF,$02,$FF,$03
	db $40,$01,$00,$00,$0A,$14,$1F,$00,$40,$01,$00,$00,$C6,$18,$EF,$3D
CODE_C4BAF6:						; called from other segments
	ldy.w #$0004
	lda.w #$0800
	jsl.l CODE_C4C547
	sta.b $D3
	jsl.l CODE_C4C541
	lda.w #$2000
	sta.b $D5
	tya
	beq CODE_C4BB2C
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	tya
	asl a
	asl a
	asl a
	pha
	pea.w $0000
	pea.w $00C4
	pea.w $BAD6
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
CODE_C4BB2C:						; from CODE_C4BAF6
	stz.b $CF
	lda.w #$0100
	sta.b $D1
	lda.w #$0009
	sta.w $18DE
	lda.w #$FFFF
	sta.w $18DA
	stz.w $18DC
	rtl
CODE_C4BB43:						; no caller found (not traced)
	tax
	phb
	sep #$20
CODE_C4BB47:						; from CODE_C4BB47
	lda.l $C30000,x
	beq CODE_C4BB54
	sta.w $0000,y
	inx
	iny
	bra CODE_C4BB47
CODE_C4BB54:						; from CODE_C4BB47
	sta.w $0000,y
	rep #$20
	rtl
CODE_C4BB5A:						; called from other segments
	pha
	jsl.l CODE_C4C536
	plx
	phx
	lda.l $C30000,x
	sta.b $CF
	lda.l $C30002,x
	sta.b $D1
	lda.l $C30004,x
	beq CODE_C4BB7E
	pha
	lda.l $C30006,x
	tay
	plx
	jsl.l CODE_C4BDAE
CODE_C4BB7E:						; from CODE_C4BB5A
	plx
CODE_C4BB7F:						; from CODE_C4BBD8
	lda.l $C30008,x
	beq CODE_C4BBDE
	cmp.w #$FFFF
	bne CODE_C4BB92
	lda.l $C3000A,x
	sta.b $CF
	bra CODE_C4BBD8
CODE_C4BB92:						; from CODE_C4BB7F
	phx
	pha
	lda.l $C3000A,x
	plx
	pha
	and.w #$3FFF
	tay
	pla
	bpl CODE_C4BBBD
	bit.w #$2000
	beq CODE_C4BBAC
	jsl.l CODE_C4BC0E
	bra CODE_C4BBD7
CODE_C4BBAC:						; from CODE_C4BB92
	bit.w #$4000
	beq CODE_C4BBB7
	jsl.l CODE_C4BBE5
	bra CODE_C4BBD7
CODE_C4BBB7:						; from CODE_C4BBAC
	jsl.l CODE_C4BBFC
	bra CODE_C4BBD7
CODE_C4BBBD:						; from CODE_C4BB92
	bit.w #$4000
	beq CODE_C4BBC8
	jsl.l CODE_C4BCA4
	bra CODE_C4BBD7
CODE_C4BBC8:						; from CODE_C4BBBD
	bit.w #$2000
	bne CODE_C4BBD3
	jsl.l CODE_C4BC26
	bra CODE_C4BBD7
CODE_C4BBD3:						; from CODE_C4BBC8
	jsl.l CODE_C4BCBC
CODE_C4BBD7:						; from CODE_C4BB92, CODE_C4BBBD, CODE_C4BBAC, CODE_C4BBC8, ...
	plx
CODE_C4BBD8:						; from CODE_C4BB7F
	inx
	inx
	inx
	inx
	bra CODE_C4BB7F
CODE_C4BBDE:						; from CODE_C4BB7F
	jsl.l CODE_C4C2AA
	jmp.w CODE_C4C536
CODE_C4BBE5:						; from CODE_C4BBAC and other segments
	jsl.l CODE_C4BCC2
	bra CODE_C4BBF5
CODE_C4BBEB:						; no caller found (not traced)
	jsl.l CODE_C4BCC2
	bra CODE_C4BBF5
CODE_C4BBF1:						; called from other segments
	jsl.l CODE_C4BCC8
CODE_C4BBF5:						; from CODE_C4BBE5, CODE_C4BBEB, CODE_C4BBFC, CODE_C4BC02, ...
	jsl.l CODE_C4C20C
	jmp.w CODE_C4C270
CODE_C4BBFC:						; from CODE_C4BBB7 and other segments
	jsl.l CODE_C4BCE4
	bra CODE_C4BBF5
CODE_C4BC02:						; no caller found (not traced)
	jsl.l CODE_C4BCF0
	bra CODE_C4BBF5
CODE_C4BC08:						; called from other segments
	jsl.l CODE_C4BCEA
	bra CODE_C4BBF5
CODE_C4BC0E:						; from CODE_C4BB92 and other segments
	jsl.l CODE_C4BD04
	bra CODE_C4BBF5
CODE_C4BC14:						; no caller found (not traced)
	jsl.l CODE_C4BD10
	bra CODE_C4BC44
CODE_C4BC1A:						; called from other segments
	jsl.l CODE_C4BD0A
	bra CODE_C4BBF5
CODE_C4BC20:						; called from other segments
	jsl.l CODE_C4BD8A
	bra CODE_C4BBF5
CODE_C4BC26:						; from CODE_C4BDAE, CODE_C4BBC8 and other segments
	jsl.l CODE_C4BD2B
	bra CODE_C4BBF5
CODE_C4BC2C:						; called from other segments
	sta.b $38
	jsl.l CODE_C4C3BA
CODE_C4BC32:						; from CODE_C4BC46
	lda.w #$4003
	sta.b $0E
	lda.w #$1FF9
	sta.b $0C
	phy
	lda.b $CF
	jsl.l CODE_C4BE34
	ply
CODE_C4BC44:						; from CODE_C4BC14, CODE_C4BC54, CODE_C4BC98, CODE_C4BC9E, ...
	bra CODE_C4BBF5
CODE_C4BC46:						; called from other segments
	sta.b $38
	jsl.l CODE_C4BC70
	bra CODE_C4BC32
CODE_C4BC4E:						; no caller found (not traced)
	sta.b $38
	jsl.l CODE_C4C3BA
CODE_C4BC54:						; from CODE_C4BC68
	lda.w #$4000
	sta.b $0E
	lda.w #$1A39
	sta.b $0C
	phy
	lda.b $CF
	jsl.l CODE_C4BE34
	ply
	bra CODE_C4BC44
CODE_C4BC68:						; called from other segments
	sta.b $38
	jsl.l CODE_C4BC70
	bra CODE_C4BC54
CODE_C4BC70:						; from CODE_C4BC46, CODE_C4BC68, CODE_C4BCC8, CODE_C4BCEA, ...
	phy
	phx
	ldy.w #$0001
	sep #$20
CODE_C4BC77:						; from CODE_C4BC77
	lda.l $7E0000,x
	beq CODE_C4BC81
	inx
	iny
	bra CODE_C4BC77
CODE_C4BC81:						; from CODE_C4BC77
	rep #$20
	tya
	pha
	jsl.l CODE_C4C558
	ply
	plx
	pha
	pha
	txa
	ldx.w #$007E
	jsl.l CODE_C58AF3
	plx
	ply
	rtl
CODE_C4BC98:						; no caller found (not traced)
	jsl.l CODE_C4BD37
	bra CODE_C4BC44
CODE_C4BC9E:						; from CODE_C4BDCA and other segments
	jsl.l CODE_C4BD31
	bra CODE_C4BC44
CODE_C4BCA4:						; from CODE_C4BBBD and other segments
	jsl.l CODE_C4BD67
	bra CODE_C4BC44
CODE_C4BCAA:						; called from other segments
	jsl.l CODE_C4BD4E
	bra CODE_C4BC44
CODE_C4BCB0:						; called from other segments
	jsl.l CODE_C4BD6B
	bra CODE_C4BC44
CODE_C4BCB6:						; no caller found (not traced)
	jsl.l CODE_C4BD71
	bra CODE_C4BC44
CODE_C4BCBC:						; from CODE_C4BBD3 and other segments
	jsl.l CODE_C4BD90
	bra CODE_C4BC44
CODE_C4BCC2:						; from CODE_C4BBE5, CODE_C4BBEB and other segments
	jsl.l CODE_C4C3BA
	bra CODE_C4BCD2
CODE_C4BCC8:						; from CODE_C4BBF1 and other segments
	jsl.l CODE_C4BC70
	bra CODE_C4BCD2
CODE_C4BCCE:						; no caller found (not traced)
	jsl.l CODE_C4C386
CODE_C4BCD2:						; from CODE_C4BCC2, CODE_C4BCC8
	stz.b $0E
	lda.w #$1A39
	sta.b $0C
	phy
	jsl.l CODE_C4C46B
	jsl.l CODE_C4BE34
	ply
	rtl
CODE_C4BCE4:						; from CODE_C4BBFC and other segments
	jsl.l CODE_C4C3BA
	bra CODE_C4BCF4
CODE_C4BCEA:						; from CODE_C4BC08 and other segments
	jsl.l CODE_C4BC70
	bra CODE_C4BCF4
CODE_C4BCF0:						; no caller found (not traced)
	jsl.l CODE_C4C386
CODE_C4BCF4:						; from CODE_C4BCE4, CODE_C4BCEA
	stz.b $0E
	lda.w #$1A39
	sta.b $0C
	phy
	lda.b $CF
	jsl.l CODE_C4BE34
	ply
	rtl
CODE_C4BD04:						; from CODE_C4BC0E and other segments
	jsl.l CODE_C4C3BA
	bra CODE_C4BD14
CODE_C4BD0A:						; from CODE_C4BC1A and other segments
	jsl.l CODE_C4BC70
	bra CODE_C4BD14
CODE_C4BD10:						; no caller found (not traced)
	jsl.l CODE_C4C386
CODE_C4BD14:						; from CODE_C4BD04, CODE_C4BD0A
	stz.b $0E
	lda.w #$1A39
	sta.b $0C
	phy
	jsl.l CODE_C4C31D
	sec
	lda.b $D1
	sbc.b $0A
	jsl.l CODE_C4BE34
	ply
	rtl
CODE_C4BD2B:						; from CODE_C4BC26 and other segments
	jsl.l CODE_C4C3BA
	bra CODE_C4BD3B
CODE_C4BD31:						; from CODE_C4BC9E and other segments
	jsl.l CODE_C4BC70
	bra CODE_C4BD3B
CODE_C4BD37:						; no caller found (not traced)
	jsl.l CODE_C4C386
CODE_C4BD3B:						; from CODE_C4BD2B, CODE_C4BD31
	lda.w #$0003
	sta.b $0E
	lda.w #$1FF9
	sta.b $0C
	phy
	lda.b $CF
	jsl.l CODE_C4BE34
	ply
	rtl
CODE_C4BD4E:						; from CODE_C4BCAA and other segments
	jsl.l CODE_C4C3BA
	lda.w #$0005
	sta.b $0E
	lda.w #$3239
	sta.b $0C
	phy
	jsl.l CODE_C4C46B
	jsl.l CODE_C4BE34
	ply
	rtl
CODE_C4BD67:						; from CODE_C4BCA4 and other segments
	jsl.l CODE_C4C3BA
CODE_C4BD6B:						; from CODE_C4BCB0 and other segments
	jsl.l CODE_C4BC70
	bra CODE_C4BD75
CODE_C4BD71:						; no caller found (not traced)
	jsl.l CODE_C4C386
CODE_C4BD75:						; from CODE_C4BD6B
	lda.w #$0003
	sta.b $0E
	lda.w #$1FF9
	sta.b $0C
	phy
	jsl.l CODE_C4C46B
	jsl.l CODE_C4BE34
	ply
	rtl
CODE_C4BD8A:						; from CODE_C4BC20 and other segments
	jsl.l CODE_C4BC70
	bra CODE_C4BD94
CODE_C4BD90:						; from CODE_C4BCBC and other segments
	jsl.l CODE_C4C3BA
CODE_C4BD94:						; from CODE_C4BD8A
	lda.w #$0003
	sta.b $0E
	lda.w #$1FF9
	sta.b $0C
	phy
	jsl.l CODE_C4C31D
	sec
	lda.b $D1
	sbc.b $0A
	jsl.l CODE_C4BE34
	ply
	rtl
CODE_C4BDAE:						; from CODE_C4BB5A and other segments
	pei ($D5)
	lda.w #$2400
	sta.b $D5
	phy
	jsl.l CODE_C4BC26
	ply
	iny
	iny
	ldx.w #$2800
	stx.b $D5
	jsl.l CODE_C4BDE6
	pla
	sta.b $D5
	rtl
CODE_C4BDCA:						; called from other segments
	pei ($D5)
	lda.w #$2400
	sta.b $D5
	phy
	jsl.l CODE_C4BC9E
	ply
	iny
	iny
	ldx.w #$2800
	stx.b $D5
	jsl.l CODE_C4BDE6
	pla
	sta.b $D5
	rtl
CODE_C4BDE6:						; from CODE_C4BDAE, CODE_C4BDCA and other segments
	phy
	dec a
	dec a
	dec a
	ldx.w #$0003
	jsl.l CODE_C58AD9
	txy
	beq CODE_C4BDF5
	inc a
CODE_C4BDF5:						; from CODE_C4BDE6
	tay
	inc a
	inc a
	inc a
	jsl.l CODE_C4C558
	pha
	tax
	sep #$20
	lda.b #$5B
	jsr.w CODE_C4BE2E
	inc a
CODE_C4BE07:						; from CODE_C4BE07
	jsr.w CODE_C4BE2E
	dey
	bne CODE_C4BE07
	inc a
	jsr.w CODE_C4BE2E
	lda.b #$00
	jsr.w CODE_C4BE2E
	rep #$20
	stz.b $0E
	lda.w #$1A39
	sta.b $0C
	lda.b $12
	plx
	jsl.l CODE_C4BE34
	ply
	jsl.l CODE_C4C20C
	jmp.w CODE_C4C270
CODE_C4BE2E:						; from CODE_C4BDF5, CODE_C4BE07
	sta.l $7E0000,x
	inx
	rts
CODE_C4BE34:						; from CODE_C4BC32, CODE_C4BC54, CODE_C4BCD2, CODE_C4BCF4, ...
	sta.b $12
	sta.b $0A
	cmp.w $18DA
	bcs CODE_C4BE40
	sta.w $18DA
CODE_C4BE40:						; from CODE_C4BE34
	ldy.w #$0400
	lda.b $0E
	lsr a
	bcs CODE_C4BE4B
	ldy.w #$0200
CODE_C4BE4B:						; from CODE_C4BE40
	tya
	jsl.l CODE_C4C547
	sta.b $A5
	phx
CODE_C4BE53:						; from CODE_C4C068
	ply
	lda.w $0000,y
	and.w #$00FF
	bne CODE_C4BE5F
	jmp.w CODE_C4C070
CODE_C4BE5F:						; from CODE_C4BE53
	iny
	phy
	cmp.w #$0020
	bne CODE_C4BE79
	lda.b $0E
	bit.w #$0004
	beq CODE_C4BE73
	lda.w #$0004
	jmp.w CODE_C4C068
CODE_C4BE73:						; from CODE_C4BE5F
	lda.w $18DE
	jmp.w CODE_C4C068
CODE_C4BE79:						; from CODE_C4BE5F
	sec
	sbc.w #$0030
	tax
	cmp.w #$0031
	bcc CODE_C4BE99
	sbc.w #$0020
	tax
	lda.b $0E
	bit.w #$0002
	beq CODE_C4BE99
	txa
	adc.w #$002A
	tax
	lda.l $C4C48B,x
	bra CODE_C4BEB5
CODE_C4BE99:						; from CODE_C4BE79
	lda.b $0E
	bit.w #$0004
	beq CODE_C4BEA6
	lda.l DATA8_C4C4D7,x
	bra CODE_C4BEB5
CODE_C4BEA6:						; from CODE_C4BE99
	bit.w #$0001
	bne CODE_C4BEB1
	lda.l DATA8_C4C502,x
	bra CODE_C4BEB5
CODE_C4BEB1:						; from CODE_C4BEA6
	lda.l DATA8_C4C4B6,x
CODE_C4BEB5:						; from CODE_C4BE79, CODE_C4BE99, CODE_C4BEA6
	and.w #$00FF
	bit.b $0E
	bvc CODE_C4BEBE
	lda.b $38
CODE_C4BEBE:						; from CODE_C4BEB5
	sta.b $38
	txa
	xba
	lsr a
	lsr a
	sta.b $10
	lda.b $0E
	lsr a
	bcs CODE_C4BED1
	lsr.b $10
	bit.b $0E
	bvs CODE_C4BF01
CODE_C4BED1:						; from CODE_C4BEBE
	lda.w #$0080
	trb.b $38
	bne CODE_C4BEF4
	lda.b $0A
	dec a
	dec a
	bmi CODE_C4BF01
	cmp.b $12
	bcc CODE_C4BF01
	sta.b $0A
	jsr.w CODE_C4C08D
	bcc CODE_C4BF01
	inc.b $0A
	jsr.w CODE_C4C08D
	bcc CODE_C4BF01
	inc.b $0A
	bra CODE_C4BF01
CODE_C4BEF4:						; from CODE_C4BED1
	lda.b $38
	cmp.w #$007F
	bne CODE_C4BF01
	lda.w $18DE
	jmp.w CODE_C4C068
CODE_C4BF01:						; from CODE_C4BEBE, CODE_C4BED1, CODE_C4BEF4
	lda.w #$8000
	trb.b $0E
	lda.b $10
	clc
	adc.b $0C
	tax
	adc.w #$0010
	sta.b $3A
	lda.b $0A
	and.w #$FFF8
	asl a
	adc.b $A5
	tay
CODE_C4BF1A:						; from CODE_C4BF01
	phx
	phy
	sep #$20
	lda.l $C00000,x
	sta.b $17
	lda.l $C00010,x
	sta.b $16
	lda.l $C00001,x
	sta.b $15
	lda.l $C00011,x
	sta.b $14
	rep #$20
	lda.b $0A
	and.w #$0007
	asl a
	tax
	lda.l DATA8_C4C07D,x
	pha
	ldx.b $38
	rts

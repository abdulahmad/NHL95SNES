; Segment bankC5_F000: UnpackStream0 and BuildSpriteOAM (docs/sprite_objects.md), then game code; untraced
; routines keep their address as a name, with their callers.
org $C5F071
UnpackStream0:						; unpack a format 0 stream that has no header, into bank $7E
	sta.l A1T1L						; the stream address
	lda.w #DMAP0					; D = the DMA registers, used as scratch and as code
	tcd
	sty.b $14
	sty.b $22
	lda.l $000008
	sta.b $18
	tay
	lda.w #$7E54					; builds mvn (opcode $54) to bank $7E, from the stream bank
	sta.b $20
	lda.w #$004C					; then jmp (opcode $4C) back to the loop
	sta.b $23
	lda.w #CODE_C5F097				; the copy built in the DMA registers ends with jmp here
	sta.b $24
	jml.l CODE_C5F099-$400000		; run the loop from the bank $85 mirror, so jmp DMAP2 reaches
									; the DMA registers
CODE_C5F097:						; the copy built in the DMA registers jumps back here
	stx.b $12
CODE_C5F099:						; the command loop, run through the bank $85 mirror
	lda.b [$12]
	bit.w #$0080
	beq CODE_C5F0BC
	and.w #$007F
	beq CODE_C5F0C5
	sta.b $15
	inc.b $12
	lda.b [$12]
	adc.b $18
	tax
	lda.b $12
	adc.w #$0002
	sta.b $12
	lda.b $15
	mvn $7E,$7E
	bra CODE_C5F099
CODE_C5F0BC:						; from CODE_C5F099
	and.w #$007F
	ldx.b $12
	inx
	jmp.w DMAP2						; run the literal copy built in the DMA registers
CODE_C5F0C5:						; from CODE_C5F099
	ldx.b $12
	inx
	lda.w #$0000
	tcd
	jml.l CODE_C5F0D0
CODE_C5F0D0:						; from CODE_C5F0C5 and other segments
	rts
BuildSpriteOAM:						; build the OAM entries of all sprite objects (frames, SpritePieces)
	lda.w $1B02
	bne CODE_C5F0D7
	rtl
CODE_C5F0D7:						; from BuildSpriteOAM
	dec.b QueueBusy
	tsx
	stx.b $16
	ldx.b $28
	txs
	dec a
	asl a
	tay
CODE_C5F0E2:						; from CODE_C5F0E2, CODE_C5F35C
	ldx.w $1AE2,y
	lda.b $22,x
	lsr a
	bcs CODE_C5F0F7
	dey
	dey
	bpl CODE_C5F0E2
CODE_C5F0EE:						; from CODE_C5F365
	tsc
	sta.b $28
	ldx.b $16
	txs
	stz.b QueueBusy
	rtl
CODE_C5F0F7:						; from CODE_C5F0E2
	stx.b $0E
	stx.b $10
	sty.b $2E
	lda.b $05,x
	sec
	sbc.b $22
	sta.b $12
	lda.b $08,x
	sec
	sbc.b $24
	sta.b $14
	lda.b $28,x
	bpl CODE_C5F112
	jmp.w CODE_C5F35C
CODE_C5F112:						; from CODE_C5F0F7
	lda.b $36,x
	bit.w #$4000
	beq CODE_C5F11C
	jmp.w CODE_C5F234
CODE_C5F11C:						; from CODE_C5F112
	lda.b $10,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$01FF
	sta.b $A3
	lda.b $14,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$01FF
	sta.b $A5
	lda.b $34,x
	and.w #$FF00
	asl a
	ora.b $36,x
	tsb.b $A3
	tsb.b $A5
	lda.b $28,x
CODE_C5F140:						; from CODE_C5F22B
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $00,x
	and.w #$00FF
	sta.b $9F
	lda.b $01,x
	and.w #$00FF
	sta.b $A1
	lda.b $02,x
	tax
	lda.l $C19660,x
	adc.b $12
	sta.b $0A
	clc
	lda.l $C19662,x
	adc.b $14
	sta.b $0C
	dec.b $9F
	bmi CODE_C5F1BE
CODE_C5F16D:						; from CODE_C5F1B6
	pei ($A3)
	ldy.w #$0000
	clc
	lda.l $C19664,x
	and.w #$00FF
	adc.b $0A
	bpl CODE_C5F187
	cmp.w #$FFF9
	bcc CODE_C5F1A1
	iny
	and.w #$00FF
CODE_C5F187:						; from CODE_C5F16D
	cmp.w #$0100
	bcs CODE_C5F1A1
	sta.b $2C
	lda.l $C19665,x
	and.w #$00FF
	adc.b $0C
	bpl CODE_C5F1A4
	cmp.w #$FFF9
	and.w #$00FF
	bcs CODE_C5F1A9
CODE_C5F1A1:						; from CODE_C5F16D, CODE_C5F187, CODE_C5F1A4
	pla
	bra CODE_C5F1B6
CODE_C5F1A4:						; from CODE_C5F187
	cmp.w #$00E0
	bcs CODE_C5F1A1
CODE_C5F1A9:						; from CODE_C5F187
	xba
	ora.b $2C
	pha
	tya
	ldy.b $2A
	sta.w $0000,y
	iny
	sty.b $2A
CODE_C5F1B6:						; from CODE_C5F1A1
	inc.b $A3
	inx
	inx
	dec.b $9F
	bpl CODE_C5F16D
CODE_C5F1BE:						; from CODE_C5F140
	dec.b $A1
	bmi CODE_C5F220
CODE_C5F1C2:						; from CODE_C5F218
	pei ($A5)
	ldy.w #$0002
	clc
	lda.l $C19664,x
	and.w #$00FF
	adc.b $0A
	bpl CODE_C5F1DC
	cmp.w #$FFF1
	bcc CODE_C5F1F6
	iny
	and.w #$00FF
CODE_C5F1DC:						; from CODE_C5F1C2
	cmp.w #$0100
	bcs CODE_C5F1F6
	sta.b $2C
	lda.l $C19665,x
	and.w #$00FF
	adc.b $0C
	bpl CODE_C5F1F9
	cmp.w #$FFF1
	and.w #$00FF
	bcs CODE_C5F1FE
CODE_C5F1F6:						; from CODE_C5F1C2, CODE_C5F1DC, CODE_C5F1F9
	pla
	bra CODE_C5F20B
CODE_C5F1F9:						; from CODE_C5F1DC
	cmp.w #$00E0
	bcs CODE_C5F1F6
CODE_C5F1FE:						; from CODE_C5F1DC
	xba
	ora.b $2C
	pha
	tya
	ldy.b $2A
	sta.w $0000,y
	iny
	sty.b $2A
CODE_C5F20B:						; from CODE_C5F1F6
	lda.b $A5
	inc a
	inc a
	bit.w #$0010
	beq CODE_C5F218
	clc
	adc.w #$0010
CODE_C5F218:						; from CODE_C5F20B
	sta.b $A5
	inx
	inx
	dec.b $A1
	bpl CODE_C5F1C2
CODE_C5F220:						; from CODE_C5F1BE
	rep #$30
	ldx.b $0E
	lda.b $2A,x
	bpl CODE_C5F22B
	jmp.w CODE_C5F35C
CODE_C5F22B:						; from CODE_C5F220
	inx
	inx
	stx.b $0E
	ldx.b $10
	jmp.w CODE_C5F140
CODE_C5F234:						; from CODE_C5F112
	lda.b $10,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$01FF
	sta.b $A3
	lda.b $14,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$01FF
	sta.b $A5
	lda.b $34,x
	and.w #$FF00
	asl a
	ora.b $36,x
	tsb.b $A5
	tsb.b $A3
	lda.b $28,x
CODE_C5F258:						; from CODE_C5F34B
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $00,x
	and.w #$00FF
	sta.b $9F
	lda.b $01,x
	and.w #$00FF
	sta.b $A1
	lda.b $02,x
	tax
	sec
	lda.b $12
	sbc.l $C19660,x
	sec
	sbc.w #$0007
	sta.b $0A
	clc
	lda.l $C19662,x
	adc.b $14
	sta.b $0C
	dec.b $9F
	bmi CODE_C5F2DE
CODE_C5F28A:						; from CODE_C5F2D6
	pei ($A3)
	ldy.w #$0000
	sec
	lda.l $C19664,x
	and.w #$00FF
	eor.w #$FFFF
	adc.b $0A
	bpl CODE_C5F2A7
	cmp.w #$FFF9
	bcc CODE_C5F2C1
	iny
	and.w #$00FF
CODE_C5F2A7:						; from CODE_C5F28A
	cmp.w #$0100
	bcs CODE_C5F2C1
	sta.b $2C
	lda.l $C19665,x
	and.w #$00FF
	adc.b $0C
	bpl CODE_C5F2C4
	cmp.w #$FFF9
	and.w #$00FF
	bcs CODE_C5F2C9
CODE_C5F2C1:						; from CODE_C5F28A, CODE_C5F2A7, CODE_C5F2C4
	pla
	bra CODE_C5F2D6
CODE_C5F2C4:						; from CODE_C5F2A7
	cmp.w #$00E0
	bcs CODE_C5F2C1
CODE_C5F2C9:						; from CODE_C5F2A7
	xba
	ora.b $2C
	pha
	tya
	ldy.b $2A
	sta.w $0000,y
	iny
	sty.b $2A
CODE_C5F2D6:						; from CODE_C5F2C1
	inc.b $A3
	inx
	inx
	dec.b $9F
	bpl CODE_C5F28A
CODE_C5F2DE:						; from CODE_C5F258
	sec
	lda.b $0A
	sbc.w #$0008
	sta.b $0A
	dec.b $A1
	bmi CODE_C5F34B
CODE_C5F2EA:						; from CODE_C5F343
	pei ($A5)
	ldy.w #$0002
	sec
	lda.l $C19664,x
	and.w #$00FF
	eor.w #$FFFF
	adc.b $0A
	bpl CODE_C5F307
	cmp.w #$FFF1
	bcc CODE_C5F321
	iny
	and.w #$00FF
CODE_C5F307:						; from CODE_C5F2EA
	cmp.w #$0100
	bcs CODE_C5F321
	sta.b $2C
	lda.l $C19665,x
	and.w #$00FF
	adc.b $0C
	bpl CODE_C5F324
	cmp.w #$FFF1
	and.w #$00FF
	bcs CODE_C5F329
CODE_C5F321:						; from CODE_C5F2EA, CODE_C5F307, CODE_C5F324
	pla
	bra CODE_C5F336
CODE_C5F324:						; from CODE_C5F307
	cmp.w #$00E0
	bcs CODE_C5F321
CODE_C5F329:						; from CODE_C5F307
	xba
	ora.b $2C
	pha
	tya
	ldy.b $2A
	sta.w $0000,y
	iny
	sty.b $2A
CODE_C5F336:						; from CODE_C5F321
	lda.b $A5
	inc a
	inc a
	bit.w #$0010
	beq CODE_C5F343
	clc
	adc.w #$0010
CODE_C5F343:						; from CODE_C5F336
	sta.b $A5
	inx
	inx
	dec.b $A1
	bpl CODE_C5F2EA
CODE_C5F34B:						; from CODE_C5F2DE
	rep #$31
	ldx.b $0E
	lda.b $2A,x
	bmi CODE_C5F35C
	inx
	inx
	stx.b $0E
	ldx.b $10
	jmp.w CODE_C5F258
CODE_C5F35C:						; from CODE_C5F0F7, CODE_C5F220, CODE_C5F34B
	ldy.b $2E
	dey
	dey
	bmi CODE_C5F365
	jmp.w CODE_C5F0E2
CODE_C5F365:						; from CODE_C5F35C
	jmp.w CODE_C5F0EE
CODE_C5F368:						; called from other segments
	sta.b $9F
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.b $9F
	asl a
	tax
	lda.l $C60000,x
	sta.b $2C
	lda.l $C60848,x
	sta.b $2E
	xba
	and.w #$00FF
	asl a
	tax
	lda.l $CFF27C,x
	sta.b $9F
	and.w #$00FF
	bne CODE_C5F397
	ldx.b $2C
	bra CODE_C5F3BA
CODE_C5F397:						; from CODE_C5F368
	asl a
	pha
	tay
	lda.b $A3
	and.w #$01FF
	asl a
	asl a
	asl a
	asl a
	adc.w #$6000
	pha
	adc.w #$0100
	tax
	pei ($2E)
	lda.b $2C
	pha
	adc.b $07,s
	phy
	phx
	pei ($2E)
	pha
	adc.b $07,s
	tax
CODE_C5F3BA:						; from CODE_C5F368
	lda.b $A0
	and.w #$00FF
	beq CODE_C5F3D2
	pha
	lda.b $A1
	and.w #$01FF
	asl a
	asl a
	asl a
	asl a
	adc.w #$6000
	pha
	pei ($2E)
	phx
CODE_C5F3D2:						; from CODE_C5F3BA
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rtl
CODE_C5F3DB:						; called from other segments
	lda.w #$1E00
	tcd
	sep #$20
	lda.b $00
	asl a
	asl a
	ora.b $01
	asl a
	asl a
	ora.b $02
	asl a
	asl a
	ora.b $03
	sta.w $1DAF
	lda.b $04
	asl a
	asl a
	ora.b $05
	asl a
	asl a
	ora.b QueueBusy
	asl a
	asl a
	ora.b $07
	sta.w $1DAE
	lda.b $08
	asl a
	asl a
	ora.b $09
	asl a
	asl a
	ora.b $0A
	asl a
	asl a
	ora.b $0B
	sta.w $1DAD
	lda.b $0C
	asl a
	asl a
	ora.b $0D
	asl a
	asl a
	ora.b $0E
	asl a
	asl a
	ora.b $0F
	sta.w $1DAC
	lda.b $10
	asl a
	asl a
	ora.b $11
	asl a
	asl a
	ora.b $12
	asl a
	asl a
	ora.b $13
	sta.w $1DAB
	lda.b $14
	asl a
	asl a
	ora.b $15
	asl a
	asl a
	ora.b $16
	asl a
	asl a
	ora.b $17
	sta.w $1DAA
	lda.b $18
	asl a
	asl a
	ora.b $19
	asl a
	asl a
	ora.b $1A
	asl a
	asl a
	ora.b $1B
	sta.w $1DA9
	lda.b $1C
	asl a
	asl a
	ora.b $1D
	asl a
	asl a
	ora.b $1E
	asl a
	asl a
	ora.b $1F
	sta.w $1DA8
	lda.b $20
	asl a
	asl a
	ora.b $21
	asl a
	asl a
	ora.b $22
	asl a
	asl a
	ora.b $23
	sta.w $1DA7
	lda.b $24
	asl a
	asl a
	ora.b $25
	asl a
	asl a
	ora.b $26
	asl a
	asl a
	ora.b $27
	sta.w $1DA6
	lda.b $28
	asl a
	asl a
	ora.b $29
	asl a
	asl a
	ora.b $2A
	asl a
	asl a
	ora.b $2B
	sta.w $1DA5
	lda.b $2C
	asl a
	asl a
	ora.b $2D
	asl a
	asl a
	ora.b $2E
	asl a
	asl a
	ora.b $2F
	sta.w $1DA4
	lda.b $30
	asl a
	asl a
	ora.b $31
	asl a
	asl a
	ora.b $32
	asl a
	asl a
	ora.b $33
	sta.w $1DA3
	lda.b $34
	asl a
	asl a
	ora.b $35
	asl a
	asl a
	ora.b $36
	asl a
	asl a
	ora.b $37
	sta.w $1DA2
	lda.b $38
	asl a
	asl a
	ora.b $39
	asl a
	asl a
	ora.b $3A
	asl a
	asl a
	ora.b $3B
	sta.w $1DA1
	lda.b $3C
	asl a
	asl a
	ora.b $3D
	asl a
	asl a
	ora.b $3E
	asl a
	asl a
	ora.b $3F
	sta.w $1DA0
	lda.b $40
	asl a
	asl a
	ora.b $41
	asl a
	asl a
	ora.b $42
	asl a
	asl a
	ora.b $43
	sta.w $1D9F
	lda.b $44
	asl a
	asl a
	ora.b $45
	asl a
	asl a
	ora.b $46
	asl a
	asl a
	ora.b $47
	sta.w $1D9E
	lda.b $48
	asl a
	asl a
	ora.b $49
	asl a
	asl a
	ora.b $4A
	asl a
	asl a
	ora.b $4B
	sta.w $1D9D
	lda.b $4C
	asl a
	asl a
	ora.b $4D
	asl a
	asl a
	ora.b $4E
	asl a
	asl a
	ora.b $4F
	sta.w $1D9C
	lda.b $50
	asl a
	asl a
	ora.b $51
	asl a
	asl a
	ora.b $52
	asl a
	asl a
	ora.b $53
	sta.w $1D9B
	lda.b $54
	asl a
	asl a
	ora.b $55
	asl a
	asl a
	ora.b $56
	asl a
	asl a
	ora.b $57
	sta.w $1D9A
	lda.b $58
	asl a
	asl a
	ora.b $59
	asl a
	asl a
	ora.b $5A
	asl a
	asl a
	ora.b $5B
	sta.w $1D99
	lda.b $5C
	asl a
	asl a
	ora.b $5D
	asl a
	asl a
	ora.b $5E
	asl a
	asl a
	ora.b $5F
	sta.w $1D98
	lda.b $60
	asl a
	asl a
	ora.b $61
	asl a
	asl a
	ora.b $62
	asl a
	asl a
	ora.b $63
	sta.w $1D97
	lda.b $64
	asl a
	asl a
	ora.b $65
	asl a
	asl a
	ora.b $66
	asl a
	asl a
	ora.b $67
	sta.w $1D96
	lda.b $68
	asl a
	asl a
	ora.b $69
	asl a
	asl a
	ora.b $6A
	asl a
	asl a
	ora.b $6B
	sta.w $1D95
	lda.b $6C
	asl a
	asl a
	ora.b $6D
	asl a
	asl a
	ora.b $6E
	asl a
	asl a
	ora.b $6F
	sta.w $1D94
	lda.b $70
	asl a
	asl a
	ora.b $71
	asl a
	asl a
	ora.b $72
	asl a
	asl a
	ora.b $73
	sta.w $1D93
	lda.b $74
	asl a
	asl a
	ora.b $75
	asl a
	asl a
	ora.b $76
	asl a
	asl a
	ora.b $77
	sta.w $1D92
	lda.b $78
	asl a
	asl a
	ora.b $79
	asl a
	asl a
	ora.b $7A
	asl a
	asl a
	ora.b $7B
	sta.w $1D91
	lda.b $7C
	asl a
	asl a
	ora.b $7D
	asl a
	asl a
	ora.b $7E
	asl a
	asl a
	ora.b $7F
	sta.w $1D90
	rep #$20
	lda.w #$0000
	tcd
	rtl
	padbyte $00						; unused to the end of the bank
	pad $C60000

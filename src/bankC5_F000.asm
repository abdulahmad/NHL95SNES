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
	beq .1
	and.w #$007F
	beq .2
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
.1:									; A and $007F, X = $12, X + 1, go to DMAP2
	and.w #$007F
	ldx.b $12
	inx
	jmp.w DMAP2						; run the literal copy built in the DMA registers
.2:									; X = $12, X + 1, A = $0000, go to .rts
	ldx.b $12
	inx
	lda.w #$0000
	tcd
	jml.l .rts
.rts:								; return
	rts
BuildSpriteOAM:						; build the OAM entries of all sprite objects (frames, SpritePieces)
	lda.w $1B02
	bne .1
	rtl
.1:									; QueueBusy - 1, $16 = X, X = $28, A - 1, ...
	dec.b QueueBusy
	tsx
	stx.b $16
	ldx.b $28
	txs
	dec a
	asl a
	tay
.loop:								; loop: X = $1AE2,y, A = $22,x, A / 2, if carry set go to .3, ...
	ldx.w $1AE2,y
	lda.b $22,x
	lsr a
	bcs .3
	dey
	dey
	bpl .loop
.2:									; $28 = A, X = $16, QueueBusy = 0, return
	tsc
	sta.b $28
	ldx.b $16
	txs
	stz.b QueueBusy
	rtl
.3:									; $0E = X, $10 = X, $2E = Y, A = $05,x, ...
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
	bpl .4
	jmp.w .40
.4:									; A = $36,x, if $4000 bits clear go to .5, go to .23
	lda.b $36,x
	bit.w #$4000
	beq .5
	jmp.w .23
.5:									; A = $10,x, A / 2, A / 2, A / 2, ...
	lda.b $10,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$01FF
	sta.b tmp2
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
	tsb.b tmp2
	tsb.b $A5
	lda.b $28,x
.6:									; A * 2, A + $26,x, X = A, A = $00,x, ...
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $00,x
	and.w #$00FF
	sta.b tmp0
	lda.b $01,x
	and.w #$00FF
	sta.b tmp1
	lda.b $02,x
	tax
	lda.l SpritePieces,x
	adc.b $12
	sta.b $0A
	clc
	lda.l SpritePieces+2,x
	adc.b $14
	sta.b $0C
	dec.b tmp0
	bmi .13
.7:									; Y = $0000, A = SpritePieces+4,x, A and $00FF, A + $0A, ...
	pei ($A3)
	ldy.w #$0000
	clc
	lda.l SpritePieces+4,x
	and.w #$00FF
	adc.b $0A
	bpl .8
	cmp.w #$FFF9
	bcc .9
	iny
	and.w #$00FF
.8:									; if A >= $0100 go to .9, r0 = A, A = SpritePieces+5,x, A and $00FF, ...
	cmp.w #$0100
	bcs .9
	sta.b r0
	lda.l SpritePieces+5,x
	and.w #$00FF
	adc.b $0C
	bpl .10
	cmp.w #$FFF9
	and.w #$00FF
	bcs .11
.9:									; pull A, go to .12
	pla
	bra .12
.10:								; if A >= $00E0 go to .9
	cmp.w #$00E0
	bcs .9
.11:								; A or r0, push A, A = Y, Y = $2A, ...
	xba
	ora.b r0
	pha
	tya
	ldy.b $2A
	sta.w $0000,y
	iny
	sty.b $2A
.12:								; tmp2 + 1, X + 1, X + 1, tmp0 - 1, ...
	inc.b tmp2
	inx
	inx
	dec.b tmp0
	bpl .7
.13:								; tmp1 - 1, if the result < 0 go to .21
	dec.b tmp1
	bmi .21
.14:								; Y = $0002, A = SpritePieces+4,x, A and $00FF, A + $0A, ...
	pei ($A5)
	ldy.w #$0002
	clc
	lda.l SpritePieces+4,x
	and.w #$00FF
	adc.b $0A
	bpl .15
	cmp.w #$FFF1
	bcc .16
	iny
	and.w #$00FF
.15:								; if A >= $0100 go to .16, r0 = A, A = SpritePieces+5,x, A and $00FF, ...
	cmp.w #$0100
	bcs .16
	sta.b r0
	lda.l SpritePieces+5,x
	and.w #$00FF
	adc.b $0C
	bpl .17
	cmp.w #$FFF1
	and.w #$00FF
	bcs .18
.16:								; pull A, go to .19
	pla
	bra .19
.17:								; if A >= $00E0 go to .16
	cmp.w #$00E0
	bcs .16
.18:								; A or r0, push A, A = Y, Y = $2A, ...
	xba
	ora.b r0
	pha
	tya
	ldy.b $2A
	sta.w $0000,y
	iny
	sty.b $2A
.19:								; A = $A5, A + 1, A + 1, if $0010 bits clear go to .20, ...
	lda.b $A5
	inc a
	inc a
	bit.w #$0010
	beq .20
	clc
	adc.w #$0010
.20:								; $A5 = A, X + 1, X + 1, tmp1 - 1, ...
	sta.b $A5
	inx
	inx
	dec.b tmp1
	bpl .14
.21:								; A, X / Y 16-bit, X = $0E, if $2A,x >= 0 go to .22, go to .40
	rep #$30
	ldx.b $0E
	lda.b $2A,x
	bpl .22
	jmp.w .40
.22:								; X + 1, X + 1, $0E = X, X = $10, ...
	inx
	inx
	stx.b $0E
	ldx.b $10
	jmp.w .6
.23:								; A = $10,x, A / 2, A / 2, A / 2, ...
	lda.b $10,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$01FF
	sta.b tmp2
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
	tsb.b tmp2
	lda.b $28,x
.24:								; A * 2, A + $26,x, X = A, A = $00,x, ...
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $00,x
	and.w #$00FF
	sta.b tmp0
	lda.b $01,x
	and.w #$00FF
	sta.b tmp1
	lda.b $02,x
	tax
	sec
	lda.b $12
	sbc.l SpritePieces,x
	sec
	sbc.w #$0007
	sta.b $0A
	clc
	lda.l SpritePieces+2,x
	adc.b $14
	sta.b $0C
	dec.b tmp0
	bmi .31
.25:								; Y = $0000, A = SpritePieces+4,x, A and $00FF, A xor $FFFF, ...
	pei ($A3)
	ldy.w #$0000
	sec
	lda.l SpritePieces+4,x
	and.w #$00FF
	eor.w #$FFFF
	adc.b $0A
	bpl .26
	cmp.w #$FFF9
	bcc .27
	iny
	and.w #$00FF
.26:								; if A >= $0100 go to .27, r0 = A, A = SpritePieces+5,x, A and $00FF, ...
	cmp.w #$0100
	bcs .27
	sta.b r0
	lda.l SpritePieces+5,x
	and.w #$00FF
	adc.b $0C
	bpl .28
	cmp.w #$FFF9
	and.w #$00FF
	bcs .29
.27:								; pull A, go to .30
	pla
	bra .30
.28:								; if A >= $00E0 go to .27
	cmp.w #$00E0
	bcs .27
.29:								; A or r0, push A, A = Y, Y = $2A, ...
	xba
	ora.b r0
	pha
	tya
	ldy.b $2A
	sta.w $0000,y
	iny
	sty.b $2A
.30:								; tmp2 + 1, X + 1, X + 1, tmp0 - 1, ...
	inc.b tmp2
	inx
	inx
	dec.b tmp0
	bpl .25
.31:								; A = $0A, A - $0008, $0A = A, tmp1 - 1, ...
	sec
	lda.b $0A
	sbc.w #$0008
	sta.b $0A
	dec.b tmp1
	bmi .39
.32:								; Y = $0002, A = SpritePieces+4,x, A and $00FF, A xor $FFFF, ...
	pei ($A5)
	ldy.w #$0002
	sec
	lda.l SpritePieces+4,x
	and.w #$00FF
	eor.w #$FFFF
	adc.b $0A
	bpl .33
	cmp.w #$FFF1
	bcc .34
	iny
	and.w #$00FF
.33:								; if A >= $0100 go to .34, r0 = A, A = SpritePieces+5,x, A and $00FF, ...
	cmp.w #$0100
	bcs .34
	sta.b r0
	lda.l SpritePieces+5,x
	and.w #$00FF
	adc.b $0C
	bpl .35
	cmp.w #$FFF1
	and.w #$00FF
	bcs .36
.34:								; pull A, go to .37
	pla
	bra .37
.35:								; if A >= $00E0 go to .34
	cmp.w #$00E0
	bcs .34
.36:								; A or r0, push A, A = Y, Y = $2A, ...
	xba
	ora.b r0
	pha
	tya
	ldy.b $2A
	sta.w $0000,y
	iny
	sty.b $2A
.37:								; A = $A5, A + 1, A + 1, if $0010 bits clear go to .38, ...
	lda.b $A5
	inc a
	inc a
	bit.w #$0010
	beq .38
	clc
	adc.w #$0010
.38:								; $A5 = A, X + 1, X + 1, tmp1 - 1, ...
	sta.b $A5
	inx
	inx
	dec.b tmp1
	bpl .32
.39:								; X = $0E, if $2A,x < 0 go to .40, X + 1, X + 1, ...
	rep #$31
	ldx.b $0E
	lda.b $2A,x
	bmi .40
	inx
	inx
	stx.b $0E
	ldx.b $10
	jmp.w .24
.40:								; Y = $2E, Y - 1, Y - 1, if the result < 0 go to .41, ...
	ldy.b $2E
	dey
	dey
	bmi .41
	jmp.w .loop
.41:								; go to .2
	jmp.w .2
QueueFrameTiles:					; queues the tiles of player frame A for VRAM: its ROM address from
									; DATA8_C60000 / DATA8_C60848, the sizes from DATA8_CFF27C, to the VRAM
									; slots in tmp2 / tmp1
	sta.b tmp0
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.b tmp0
	asl a
	tax
	lda.l DATA8_C60000,x
	sta.b r0
	lda.l DATA8_C60848,x
	sta.b $2E
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_CFF27C,x
	sta.b tmp0
	and.w #$00FF
	bne .1
	ldx.b r0
	bra .2
.1:									; A * 2, push A, Y = A, A = tmp2, ...
	asl a
	pha
	tay
	lda.b tmp2
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
	lda.b r0
	pha
	adc.b $07,s
	phy
	phx
	pei ($2E)
	pha
	adc.b $07,s
	tax
.2:									; A = $A0, if the result = 0 go to .3, push A, A = tmp1, ...
	lda.b $A0
	and.w #$00FF
	beq .3
	pha
	lda.b tmp1
	and.w #$01FF
	asl a
	asl a
	asl a
	asl a
	adc.w #$6000
	pha
	pei ($2E)
	phx
.3:									; A = $00, $00 = X, QueueBusy = 0, return
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rtl
PackOAMHigh:						; packs the 128 size / X bit bytes at $1E00 (BuildSpriteOAM) into the 32
									; byte OAM high table
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
	ora.b $06
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

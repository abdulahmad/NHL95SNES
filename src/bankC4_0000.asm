; Segment bankC4_0000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C40000
CODE_C40000:						; called from other segments
	jsr.w CODE_C40444
CODE_C40003:						; from CODE_C40066
	jsl.l $C4CEDB
	jsl.l $C36C2D
	inc.b $26
	lda.w $058F
	beq CODE_C4001D
	cmp.w #$0012
	bcc CODE_C40066
	lda.w #$0007
	sta.w $058F
CODE_C4001D:						; from CODE_C40003
	lda.w $058D
	sta.b $6B
	bit.w #$0100
	beq CODE_C4002C
	jsr.w CODE_C40085
	lda.b $6B
CODE_C4002C:						; from CODE_C4001D
	bit.w #$0200
	beq CODE_C40036
	jsr.w CODE_C4009A
	lda.b $6B
CODE_C40036:						; from CODE_C4002C
	bit.w #$0800
	beq CODE_C40040
	jsr.w CODE_C400F3
	lda.b $6B
CODE_C40040:						; from CODE_C40036
	bit.w #$0400
	beq CODE_C4004A
	jsr.w CODE_C40122
	lda.b $6B
CODE_C4004A:						; from CODE_C40040
	bit.w #$0F00
	beq CODE_C40054
	jsr.w CODE_C40322
	lda.b $6B
CODE_C40054:						; from CODE_C4004A
	bit.w #$C0F0
	beq CODE_C4005E
	jsr.w CODE_C400AC
	lda.b $6B
CODE_C4005E:						; from CODE_C40054
	bit.w #$3000
	beq CODE_C40066
	jmp.w CODE_C40153
CODE_C40066:						; from CODE_C40003, CODE_C4005E
	jsr.w CODE_C403C2
	jsr.w CODE_C4077C
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	jmp.w CODE_C40003
CODE_C40085:						; from CODE_C4001D
	lda.b $67
	inc a
	cmp.w #$0007
	bcs CODE_C40099
	sta.b $67
	lda.w $3D52
	inc a
	sta.w $3D52
	sta.w $3D5A
CODE_C40099:						; from CODE_C40085, CODE_C4009A
	rts
CODE_C4009A:						; from CODE_C4002C
	lda.b $67
	beq CODE_C40099
	dec a
	sta.b $67
	lda.w $3D52
	dec a
	sta.w $3D52
	sta.w $3D5A
	rts
CODE_C400AC:						; from CODE_C40054
	lda.w $3D52
	asl a
	tax
	lda.l DATA8_C41166,x
	tay
	asl a
	tax
	lda.w $3D5E,x
	ora.w $3D7C,x
	bmi CODE_C400F2
	tyx
	lda.l $307865,x
	and.w #$00FF
	cmp.w #$0040
	bcs CODE_C400F2
	and.w #$000F
	cmp.w #$0004
	bcs CODE_C400F2
	tya
	asl a
	tax
	lda.w $2C46,x
	eor.w #$FFFF
	sta.w $2C46,x
	ldy.w $2C64,x
	phx
	jsr.w CODE_C4097B
	plx
	ldy.w $2C82,x
	jsr.w CODE_C4097B
	jmp.w CODE_C4062A
CODE_C400F2:						; from CODE_C400AC
	rts
CODE_C400F3:						; from CODE_C40036, CODE_C4011C
	lda.b $69
	beq CODE_C40121
	lda.b $67
	asl a
	tax
	jmp (DATA8_C400FE,x)
DATA8_C400FE:						; jump table: the routine for each index
	dw CODE_C4010C,CODE_C4011C,CODE_C40152,CODE_C40152
	dw CODE_C40152,CODE_C4011C,CODE_C4010C
CODE_C4010C:						; from CODE_C4011C, DATA8_C400FE
	sec
	lda.w $3D52
	sbc.w #$0007
	sta.w $3D52
	sta.w $3D5A
	dec.b $69
	rts
CODE_C4011C:						; from DATA8_C400FE
	jsr.w CODE_C4010C
	bra CODE_C400F3
CODE_C40121:						; from CODE_C400F3, CODE_C40122
	rts
CODE_C40122:						; from CODE_C40040, CODE_C4014D
	lda.b $69
	cmp.w #$0003
	bcs CODE_C40121
	lda.b $67
	asl a
	tax
	jmp (DATA8_C40130,x)
DATA8_C40130:						; jump table: the routine for each index
	dw CODE_C4013E,CODE_C4014D,CODE_C40152,CODE_C40152
	dw CODE_C40152,CODE_C4014D,CODE_C4013E
CODE_C4013E:						; from CODE_C4014D, DATA8_C40130
	inc.b $69
	lda.w $3D52
	adc.w #$0007
	sta.w $3D52
	sta.w $3D5A
	rts
CODE_C4014D:						; from DATA8_C40130
	jsr.w CODE_C4013E
	bra CODE_C40122
CODE_C40152:						; from DATA8_C400FE, DATA8_C40130
	rts
CODE_C40153:						; from CODE_C4005E
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	jsl.l $C4CEDB
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$1B,$49,$C0,$00		; inline parameters
	lda.w #$4A65
	ldx.w #$00C0
	jsl.l SetNMIHook
	jsl.l CODE_C5E50E
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $63
	lda.w #$00D7
	sta.b $18
	lda.w #$00D0
	sta.b $1A
	lda.w #$0020
	jsl.l CreateSprite
	phd
	lda.w #$2100
	tcd
	stz.b $23
	stz.b $25
	stz.b $2A
	stz.b $2E
	stz.b $30
	pld
	stz.w $04C0
	ldy.w #$0000
	jsl.l CODE_C589E4
	ldy.w #$5000
	jsl.l CODE_C589B0
	lda.w #$083D
	ldx.w #$00C0
	jsl.l DecompressUnpackbuf
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0240
	pea.w $0010
	pea.w $007E
	pea.w $50DC
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsl.l $C4CEDB
	stz.w fadestep
	jml.l CODE_C5A51C
CODE_C401E5:						; called from other segments
	lda.w #$0000
	sta.l $306051
	jsl.l $C4C530
	jsr.w CODE_C409E3
	pea.w $7E7F
	plb
	ldy.w #$8EF8
	ldx.w #$001E
	stz.b $9F
CODE_C401FF:						; from CODE_C40254
	lda.l $7E3D5E,x
	sta.w $0004,y
	ora.l $7E3D7C,x
	bmi CODE_C40254
	txa
	stx.b $A1
	lsr a
	tax
	sta.w $0038,y
	lda.l $307865,x
	ldx.b $A1
	and.w #$00FF
	cmp.w #$0040
	bcs CODE_C40254
	and.w #$000F
	cmp.w #$0004
	bcs CODE_C40254
	inc.b $9F
	lda.l $7E3D7C,x
	sta.w $0002,y
	lda.w #$0000
	sta.w $0006,y
	sta.w $0008,y
	sta.w $000A,y
	sta.w $0000,y
	lda.l $7E2C46,x
	beq CODE_C4024E
	lda.w #$0001
	sta.w $0000,y
CODE_C4024E:						; from CODE_C401FF
	tya
	clc
	adc.w #$010A
	tay
CODE_C40254:						; from CODE_C401FF
	dex
	dex
	bpl CODE_C401FF
	lda.b $9F
	beq CODE_C40264
	sta.l $7E2C42
	jml.l CODE_C5AF07
CODE_C40264:						; from CODE_C40254
	plb
	lda.w #$0004
	jsr.w CODE_C40280
	pha
	lda.w #$0003
	jsr.w CODE_C40280
	tax
	pla
	jsl.l $C4DFD6
	jsl.l $C4D818
	jml.l Reset
CODE_C40280:						; from CODE_C40264
	sep #$20
	ldx.w #$0010
CODE_C40285:						; from CODE_C40285
	dex
	cmp.l $307874,x
	bne CODE_C40285
	lda.l $3075A4,x
	rep #$20
	and.w #$00FF
	rts
CODE_C40296:						; called from other segments
	lda.w $2C42
	sta.b $9F
	pea.w $7E7F
	plb
	ldy.w #$8EF8
CODE_C402A2:						; from CODE_C402EB
	ldx.w $0038,y
	sep #$20
	lda.l $30604D
	bne CODE_C402B3
	lda.b #$33
	sta.l $307865,x
CODE_C402B3:						; from CODE_C402A2
	rep #$20
	lda.w $000A,y
	cmp.w $0008,y
	lda.w #$0010
	bcc CODE_C402C4
	lda.w #$0001
	clc
CODE_C402C4:						; from CODE_C402B3
	sep #$20
	adc.l $307865,x
	sta.l $307865,x
	rep #$21
	cmp.w #$0040
	bcc CODE_C402DD
	lda.w $0002,y
	jsr.w CODE_C40305
	bra CODE_C402EB
CODE_C402DD:						; from CODE_C402C4
	and.w #$000F
	cmp.w #$0004
	bcc CODE_C402EB
	lda.w $0004,y
	jsr.w CODE_C40305
CODE_C402EB:						; from CODE_C402C4, CODE_C402DD
	tya
	adc.w #$010A
	tay
	dec.b $9F
	bne CODE_C402A2
	plb
	jsr.w CODE_C40CB3
	lda.l $3075B4
	inc a
	sta.l $3075B4
	jml.l CODE_C5ADDC
CODE_C40305:						; from CODE_C402C4, CODE_C402DD
	sep #$20
	ldx.w #$000F
CODE_C4030A:						; from CODE_C4030A
	cmp.l $3075A4,x
	beq CODE_C40316
	dex
	bpl CODE_C4030A
	rep #$21
	rts
CODE_C40316:						; from CODE_C4030A
	lda.l $307874,x
	inc a
	sta.l $307874,x
	rep #$21
	rts
CODE_C40322:						; from CODE_C4004A, CODE_C4061C
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.w $3D52
	asl a
	tax
	lda.l DATA8_C41166,x
	tax
	lda.l $307865,x
	tay
	and.w #$000F
	xba
	lsr a
	lsr a
	adc.w #$02A0
	adc.b $D3
	sta.b $9F
	tya
	and.w #$00F0
	asl a
	asl a
	adc.w #$02A0
	adc.b $D3
	sta.b $A1
	txa
	asl a
	tax
	pea.w $0080
	pea.w $5F00
	pea.w $007E
	lda.b $D3
	adc.w #$0700
	pha
	ldy.w #$000A
	lda.w $3D5E,x
	bpl CODE_C40377
	lda.b $D3
	adc.w #$03E0
	ldy.w #$0014
	bra CODE_C4037C
CODE_C40377:						; from CODE_C40322
	xba
	lsr a
	lsr a
	adc.b $D3
CODE_C4037C:						; from CODE_C40322
	pea.w $0006
	pea.w $5F09
	pea.w $007E
	pei ($9F)
	phy
	pea.w $5F04
	pea.w $007E
	pha
	ldy.w #$000A
	lda.w $3D7C,x
	bpl CODE_C403A1
	lda.b $D3
	adc.w #$03E0
	ldy.w #$0014
	bra CODE_C403A6
CODE_C403A1:						; from CODE_C4037C
	xba
	lsr a
	lsr a
	adc.b $D3
CODE_C403A6:						; from CODE_C4037C
	pea.w $0006
	pea.w $5F29
	pea.w $007E
	pei ($A1)
	phy
	pea.w $5F24
	pea.w $007E
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rts
CODE_C403C2:						; from CODE_C40066
	lda.b $67
	asl a
	tax
	sec
	lda.l DATA8_C40FF8,x
	sbc.b $65
	beq CODE_C403FA
	sta.b $9F
	bpl CODE_C403D7
	eor.w #$FFFF
	inc a
CODE_C403D7:						; from CODE_C403C2
	cmp.w #$0008
	bcs CODE_C403E8
	lda.w #$0001
	bit.b $9F
	bpl CODE_C403F5
	lda.w #$FFFF
	bra CODE_C403F5
CODE_C403E8:						; from CODE_C403D7
	lda.b $9F
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq CODE_C403F5
	ora.w #$E000
CODE_C403F5:						; from CODE_C403D7, CODE_C403E8
	clc
	adc.b $65
	sta.b $65
CODE_C403FA:						; from CODE_C403C2
	lda.w $04C0
	cmp.b $65
	bne CODE_C40402
	rts
CODE_C40402:						; from CODE_C403FA
	and.w #$FFF8
	sta.b $A1
	lda.b $65
	sec
	and.w #$FFF8
	sbc.b $A1
	bpl CODE_C40429
	eor.w #$FFFF
	inc a
	lsr a
	lsr a
	lsr a
	beq CODE_C4043E
	sta.b $A1
CODE_C4041C:						; from CODE_C4041C
	dec.b $63
	stz.b $9F
	jsr.w CODE_C4064B
	dec.b $A1
	bne CODE_C4041C
	bra CODE_C4043E
CODE_C40429:						; from CODE_C40402
	lsr a
	lsr a
	lsr a
	beq CODE_C4043E
	sta.b $A1
CODE_C40430:						; from CODE_C40430
	inc.b $63
	lda.w #$0020
	sta.b $9F
	jsr.w CODE_C4064B
	dec.b $A1
	bne CODE_C40430
CODE_C4043E:						; from CODE_C40402, CODE_C4041C, CODE_C40429
	lda.b $65
	sta.w $04C0
	rts
CODE_C40444:						; from CODE_C40000
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	lda.w #$4A87
	ldx.w #$00C0
	jsl.l SetNMIHook
	wai
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$A8,$49,$C0,$00		; inline parameters
	ldx.w #$0060
	jsl.l SetupHDMA
	db $44,$26,$EA,$0F,$C4,$7E		; inline parameters
	ldx.w #$0050
	jsl.l SetupHDMA
	db $44,$26,$F1,$0F,$C4,$7E		; inline parameters
	ldy.w #$5C00
	jsl.l CODE_C589E4
	ldx.b $63
	jsl.l CODE_C5E596
	stz.b $63
	jsl.l CODE_C5BBBC
	jsl.l $C4C530
	lda.w #$DC7B
	ldx.w #$00C1
	jsl.l CODE_C58812
	ldx.w #$15DE
	clc
CODE_C404A2:						; from CODE_C404A2
	lda.w $50DC,x
	adc.w #$2A30
	sta.l $7F9C7A,x
	dex
	dex
	bpl CODE_C404A2
	stz.w $04C0
	stz.b $65
	stz.b $67
	stz.b $69
	lda.w #$FFFF
	sta.w $04C2
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0D40
	pea.w $2300
	pea.w $007E
	pea.w $66BC
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0020
	pea.w $007E
	pea.w $73FC
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l $C4CEDB
	lda.w #$E9B2
	ldx.w #$00C1
	jsl.l CODE_C58812
	lda.w #$04E0
	jsl.l $C4C558
	jsl.l $C4C541
	ldx.w #$04DE
CODE_C4050D:						; from CODE_C4050D
	lda.w $50DC,x
	ora.w #$3400
	sta.w $50DC,x
	dex
	dex
	bpl CODE_C4050D
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $3980
	pea.w $0000
	pea.w $007E
	pea.w $55BC
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0040
	pea.w $0040
	pea.w $007E
	pea.w $8F3C
	ldx.w #$001E
CODE_C40547:						; from CODE_C40547
	lda.w $8F3C,x
	lsr a
	and.w #$BDEF
	sta.w $8F5C,x
	dex
	dex
	bpl CODE_C40547
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsr.w CODE_C409E3
	stz.b $63
	phd
	lda.w #$2100
	tcd
	stz.b $23
	lda.w #$00A0
	sta.b $25
	stz.b $2A
	lda.w #$1717
	sta.b $2E
	lda.w #$0310
	sta.b $30
	sep #$20
	lda.b #$E8
	sta.b $32
	rep #$20
	pld
	jsl.l $C4BAF6
	ldx.w #$4777
	ldy.w #$0001
	stz.b $CF
	lda.w #$0100
	sta.b $D1
	jsl.l $C4BBE5
	jsl.l $C4C2AA
	jsl.l $C4CEDB
	lda.l $30604D
	and.w #$00FF
	beq CODE_C40604
	lda.w #$001A
	sta.b $9F
CODE_C405AE:						; from CODE_C405C7
	lda.b $9F
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l $C4C3BA
	ldx.b $16
	lda.b $0A
	beq CODE_C405C7
	inx
CODE_C405C7:						; from CODE_C405AE
	jsl.l $C4C3BA
	ldy.b $9F
	jsl.l $C4BC08
	dec.b $9F
	bpl CODE_C405AE
	lda.w #$0080
	sta.b $CF
	lda.w #$000A
	sta.b $9F
	lda.w #$0000
CODE_C405E2:						; from CODE_C405E2
	sta.b $A1
	jsl.l CODE_C55EC3
	ldy.b $9F
	ldx.w #$04F5
	jsl.l $C4BC08
	inc.b $9F
	lda.b $A1
	inc a
	cmp.w #$0005
	bcc CODE_C405E2
	ldy.b $9F
	ldx.w #$4781
	jsl.l $C4BBFC
CODE_C40604:						; from CODE_C40547
	ldx.w #$001C
CODE_C40607:						; from CODE_C4061C
	lda.w $2C46,x
	bpl CODE_C4061C
	ldy.w $2C64,x
	phx
	jsr.w CODE_C4097B
	plx
	ldy.w $2C82,x
	phx
	jsr.w CODE_C4097B
	plx
CODE_C4061C:						; from CODE_C40607
	dex
	dex
	bpl CODE_C40607
	wai
	jsr.w CODE_C4062A
	stz.w fadestep
	jmp.w CODE_C40322
CODE_C4062A:						; from CODE_C4061C, CODE_C400AC
	pei ($63)
	ldx.w #$0003
CODE_C4062F:						; from CODE_C40633
	phx
	ldy.w #$0008
CODE_C40633:						; from CODE_C40633
	phy
	stz.b $9F
	jsr.w CODE_C4064B
	inc.b $63
	ply
	dey
	bpl CODE_C40633
	jsl.l $C4CEDB
	plx
	dex
	bpl CODE_C4062F
	pla
	sta.b $63
	rts
CODE_C4064B:						; from CODE_C40633, CODE_C4041C, CODE_C40430
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	pea.w $0038
	pea.w $0081
	lda.b $63
	clc
	adc.b $9F
	bit.w #$0020
	beq CODE_C4066B
	and.w #$001F
	ora.w #$5400
	bra CODE_C40671
CODE_C4066B:						; from CODE_C4064B
	and.w #$001F
	ora.w #$5000
CODE_C40671:						; from CODE_C4064B
	pha
	pea.w $1801
	pea.w $007E
	lda.w #$0038
	jsl.l $C4C558
	pha
	tay
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	clc
	lda.b $63
	adc.b $9F
	asl a
	tax
	lda.w #$001B
	sta.b $9F
CODE_C40695:						; from CODE_C40695
	lda.l $7F9C7A,x
	sta.w $0000,y
	iny
	iny
	txa
	adc.w #$00C8
	tax
	dec.b $9F
	bpl CODE_C40695
	rts
CODE_C406A8:						; called from other segments
	ldy.w #$0003
CODE_C406AB:						; from CODE_C406AB
	jsr.w CODE_C406C4
	cmp.w #$0000
	beq CODE_C406C3
	clc
	tya
	adc.w #$009C
	tay
	cpy.w #$0C30
	bcc CODE_C406AB
	pea.w $5471
	bra CODE_C406EA
CODE_C406C3:						; from CODE_C406AB
	rtl
CODE_C406C4:						; from CODE_C406AB
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	sta.b $9F
	lda.l $307162,x
CODE_C406D3:						; from CODE_C406D3
	lsr a
	dec.b $9F
	bpl CODE_C406D3
	rol a
	and.w #$001F
	rts
CODE_C406DD:						; called from other segments
	lda.l $3075B4
	and.w #$00FF
	bne CODE_C406E7
	rtl
CODE_C406E7:						; from CODE_C406DD
	pea.w $54B1
CODE_C406EA:						; from CODE_C406AB
	jsl.l FadeOutWait
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l CODE_C589E4
	ldy.w #$5C00
	jsl.l CODE_C589E4
	lda.w #$FFFF
	sta.w $04C6
	jsl.l $C4CEDB
	ldx.b $9B
	jsl.l CODE_C5E596
	stz.b $9B
	ldx.b $9D
	jsl.l CODE_C5E596
	stz.b $9D
	jsl.l CODE_C5A507
	jsl.l $C4C530
	jsl.l $C4BAF6
	pla
	jsl.l $C4BB5A
	ldx.b $63
	lda.w #$FF80
	sta.b $05,x
	sta.b $08,x
	stz.w fadestep
	stz.w $058F
	stz.w $058D
CODE_C4073F:						; from CODE_C4073F
	jsl.l $C3716D
	jsl.l $C36C2D
	lda.w $058F
	bne CODE_C4073F
	lda.w $058D
	bit.w #$3000
	beq CODE_C4073F
	jsl.l FadeOutWait
	phb
	pla
	pla
	jml.l CODE_C58D32
CODE_C4075F:						; called from other segments
	lda.w #$FFF0
	sta.b $87
	lda.w #$0010
	sta.b $83
	lda.w $24C4
	tay
CODE_C4076D:						; from CODE_C4076D
	lda.b $87
	clc
	adc.b $83
	sta.b $87
	lsr.b $83
	dey
	bpl CODE_C4076D
	dec.b $83
	rtl
CODE_C4077C:						; from CODE_C40066
	lda.b $26
	lsr a
	lda.w #$A000
	bcc CODE_C40787
	lda.w #$C000
CODE_C40787:						; from CODE_C4077C
	sta.w DMAEnShadow
	lda.w #$00FF
	sta.w $364E
	sta.w $39CE
	ldx.w #$364E
	ldy.w #$3650
	lda.w #$037D
	bcs CODE_C407A4
	ldx.w #$39CE
	ldy.w #$39D0
CODE_C407A4:						; from CODE_C40787
	mvn $7E,$7E
	ldx.w $3D54
	inx
	inx
	cpx.w #$009E
	bcc CODE_C407B4
	ldx.w #$0000
CODE_C407B4:						; from CODE_C407A4
	stx.w $3D54
	ldy.w $3D52
	jsr.w CODE_C4081B
	lda.l DATA8_C41006,x
	adc.b $9F
	sec
	sbc.w $04C0
	sta.b $9F
	clc
	lda.b $A1
	adc.l DATA8_C41076,x
	sta.b $A1
	ldx.w #$3D4E
	jsr.w CODE_C40840
	ldx.w $3D4E
	ldy.w $3D50
	jsr.w CODE_C408B3
	ldx.w $3D5C
	inx
	inx
	cpx.w #$009E
	bcc CODE_C407EE
	ldx.w #$0000
CODE_C407EE:						; from CODE_C407B4
	stx.w $3D5C
	ldy.w $3D5A
	jsr.w CODE_C4081B
	lda.l DATA8_C4103E,x
	adc.b $9F
	sec
	sbc.w $04C0
	sta.b $9F
	clc
	lda.b $A1
	adc.l DATA8_C410AE,x
	sta.b $A1
	ldx.w #$3D56
	jsr.w CODE_C40840
	ldx.w $3D56
	ldy.w $3D58
	jmp.w CODE_C408B3
CODE_C4081B:						; from CODE_C407B4, CODE_C407EE
	lda.l DATA8_C40EF4,x
	tax
	ora.w #$FF00
	bit.w #$0080
	bne CODE_C4082B
	and.w #$00FF
CODE_C4082B:						; from CODE_C4081B
	sta.b $9F
	txa
	xba
	ora.w #$FF00
	bit.w #$0080
	bne CODE_C4083A
	and.w #$00FF
CODE_C4083A:						; from CODE_C4082B
	sta.b $A1
	tya
	asl a
	tax
	rts
CODE_C40840:						; from CODE_C407B4, CODE_C407EE
	sec
	lda.b $9F
	sbc.w $0000,x
	sta.b $A3
	bpl CODE_C4084E
	eor.w #$FFFF
	inc a
CODE_C4084E:						; from CODE_C40840
	cmp.w #$0010
	bcs CODE_C40865
	cmp.w #$0002
	bcc CODE_C4085B
	lda.w #$0002
CODE_C4085B:						; from CODE_C4084E
	bit.b $A3
	bpl CODE_C40872
	eor.w #$FFFF
	inc a
	bra CODE_C40872
CODE_C40865:						; from CODE_C4084E
	lda.b $A3
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq CODE_C40872
	ora.w #$E000
CODE_C40872:						; from CODE_C4085B, CODE_C40865
	clc
	adc.w $0000,x
	sta.w $0000,x
	sec
	lda.b $A1
	sbc.w $0002,x
	sta.b $A3
	bpl CODE_C40887
	eor.w #$FFFF
	inc a
CODE_C40887:						; from CODE_C40872
	cmp.w #$0010
	bcs CODE_C4089E
	cmp.w #$0002
	bcc CODE_C40894
	lda.w #$0002
CODE_C40894:						; from CODE_C40887
	bit.b $A3
	bpl CODE_C408AB
	eor.w #$FFFF
	inc a
	bra CODE_C408AB
CODE_C4089E:						; from CODE_C40887
	lda.b $A3
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq CODE_C408AB
	ora.w #$E000
CODE_C408AB:						; from CODE_C40894, CODE_C4089E
	clc
	adc.w $0002,x
	sta.w $0002,x
	rts
CODE_C408B3:						; from CODE_C407B4, CODE_C407EE
	stx.b $9F
	lda.b $26
	lsr a
	tya
	bcs CODE_C408BE
	adc.w #$00E0
CODE_C408BE:						; from CODE_C408B3
	asl a
	asl a
	tay
	ldx.w #$0054
CODE_C408C4:						; from CODE_C40947
	lda.w $364E,y
	cmp.w #$00FF
	clc
	beq CODE_C4090B
	lda.l DATA8_C40F94,x
	and.w #$00FF
	adc.b $9F
	bpl CODE_C408DB
	lda.w #$0000
CODE_C408DB:						; from CODE_C408C4
	cmp.w #$0100
	bcs CODE_C40947
	sep #$20
	sta.w $3650,y
	rep #$21
	lda.l DATA8_C40F95,x
	and.w #$00FF
	adc.b $9F
	bpl CODE_C408FA
	lda.w #$00FF
	sta.w $3650,y
	bra CODE_C40947
CODE_C408FA:						; from CODE_C408DB
	cmp.w #$0100
	bcc CODE_C40902
	lda.w #$00FF
CODE_C40902:						; from CODE_C408FA
	sep #$20
	sta.w $3651,y
	rep #$20
	bra CODE_C40947
CODE_C4090B:						; from CODE_C408C4
	lda.l DATA8_C40F94,x
	and.w #$00FF
	adc.b $9F
	bpl CODE_C40919
	lda.w #$0000
CODE_C40919:						; from CODE_C4090B
	cmp.w #$0100
	bcs CODE_C40947
	sep #$20
	sta.w $364E,y
	rep #$21
	lda.l DATA8_C40F95,x
	and.w #$00FF
	adc.b $9F
	bpl CODE_C40938
	lda.w #$00FF
	sta.w $364E,y
	bra CODE_C40947
CODE_C40938:						; from CODE_C40919
	cmp.w #$0100
	bcc CODE_C40940
	lda.w #$00FF
CODE_C40940:						; from CODE_C40938
	sep #$20
	sta.w $364F,y
	rep #$20
CODE_C40947:						; from CODE_C408DB, CODE_C40919, CODE_C40902
	clc
	tya
	adc.w #$0004
	tay
	dex
	dex
	bmi CODE_C40954
	jmp.w CODE_C408C4
CODE_C40954:						; from CODE_C40947
	rts
CODE_C40955:						; from CODE_C409BD
	phb
	sta.b $9F
	asl a
	adc.b $9F
	asl a
	asl a
	asl a
	asl a
	adc.w #$50DC
	tax
	tya
	adc.w #$9C7A
	tay
	lda.w #$0017
	mvn $7F,$7E
	tya
	adc.w #$00B0
	tay
	lda.w #$0017
	mvn $7F,$7E
	plb
	rts
CODE_C4097B:						; from CODE_C40607, CODE_C400AC
	clc
	tyx
	jsr.w CODE_C40985
	txa
	adc.w #$00B0
	tax
CODE_C40985:						; from CODE_C4097B
	ldy.w #$000B
CODE_C40988:						; from CODE_C40988
	lda.l $7F9C7A,x
	eor.w #$0400
	sta.l $7F9C7A,x
	inx
	inx
	dey
	bpl CODE_C40988
	rts
CODE_C40999:						; from CODE_C409E3
	ldx.w #$000F
CODE_C4099C:						; from CODE_C409BD
	lda.l $3075A4,x
	and.w #$00FF
	sta.b $A3
	lda.l $307874,x
	and.w #$00FF
	cmp.w #$0004
	bcc CODE_C409B4
	lda.w #$0003
CODE_C409B4:						; from CODE_C4099C
	sta.b $A5
	txa
	stx.b $A1
	asl a
	asl a
	asl a
	tax
CODE_C409BD:						; from CODE_C409BD
	lda.l $C4119E,x
	asl a
	tay
	lda.b $A3
	sta.w $3D5E,y
	lda.l DATA8_C410E6,x
	sta.w $2C64,y
	tay
	lda.b $A3
	phx
	jsr.w CODE_C40955
	plx
	inx
	inx
	dec.b $A5
	bpl CODE_C409BD
	ldx.b $A1
	dex
	bpl CODE_C4099C
	rts
CODE_C409E3:						; from CODE_C401E5, CODE_C40547
	jsl.l $C4CEDB
	lda.w #$364E
	ldy.w #$1000
	jsl.l CODE_C58B11
	dec.w $3D5E
	lda.w #$0040
	ldx.w #$3D5E
	txy
	iny
	mvn $7E,$7E
	jmp.w CODE_C40999
CODE_C40A02:						; called from other segments
	lda.w $1864
	cmp.w #$0002
	beq CODE_C40A10
	cmp.w #$0003
	beq CODE_C40A10
	rtl
CODE_C40A10:						; from CODE_C40A02
	lda.w $2C42
	sta.b $9F
	pea.w $7E7F
	plb
	ldy.w #$8EF8
CODE_C40A1C:						; from CODE_C40A54
	lda.w $0000,y
	bne CODE_C40A54
	lda.w $0006,y
	bmi CODE_C40A54
	jsr.w CODE_C40A60
	adc.w $000A,y
	sta.w $000A,y
	jsr.w CODE_C40A60
	adc.w $0008,y
	sta.w $0008,y
	jsr.w CODE_C40A60
	cmp.w #$0014
	bcs CODE_C40A54
	cmp.w #$000A
	lda.w $0006,y
	adc.w #$0000
	cmp.w #$0002
	bcc CODE_C40A51
	lda.w #$0002
CODE_C40A51:						; from CODE_C40A1C
	sta.w $0006,y
CODE_C40A54:						; from CODE_C40A1C
	clc
	tya
	adc.w #$010A
	tay
	dec.b $9F
	bne CODE_C40A1C
	plb
	rtl
CODE_C40A60:						; from CODE_C40A1C
	lda.w #$0002
	pea.w $7F7E
	plb
	jsl.l CODE_C58CCD
	plb
	rts
CODE_C40A6D:						; called from other segments
	tyx
	lda.l $7F0004,x
	sta.l $0017C9
	lda.l $7F0002,x
	sta.l $0017CB
	phy
	pea.w $7E7E
	plb
	plb
	jsl.l $C4C536
	jsl.l CODE_C52CA3
	ply
	phy
	ldx.w #$2DC9
	jsr.w CODE_C40AA1
	pla
	clc
	adc.w #$001A
	tay
	ldx.w #$3207
	jsr.w CODE_C40AA1
	rtl
CODE_C40AA1:						; from CODE_C40A6D
	lda.w $0000,x
	sta.b $10
	lda.w $0002,x
	sta.b $A3
	pea.w $7E7F
	plb
CODE_C40AAF:						; from CODE_C40B3C
	lda.l $7E003A,x
	sta.b $A5
	stx.b $0A
	sty.b $0C
	dec.b $A3
	bpl CODE_C40AEF
	jsl.l CODE_C5BD52
	ldy.b $0C
	stx.b $9F
	lda.w $003A,y
	and.w #$00FF
	clc
	adc.b $9F
	tax
	lda.b $A5
	jsr.w CODE_C40B4C
	lda.b $A5
	jsl.l CODE_C5BD7D
	stx.b $9F
	ldy.b $0C
	lda.w $006E,y
	and.w #$00FF
	clc
	adc.b $9F
	tax
	lda.b $A5
	jsr.w CODE_C40B81
	bra CODE_C40B3C
CODE_C40AEF:						; from CODE_C40AAF
	lda.w $003A,y
	ora.w $00A2,y
	and.w #$00FF
	beq CODE_C40B3C
	lda.b $A5
	jsl.l CODE_C5BDE7
	inx
	lda.b $A5
	jsr.w CODE_C40BB6
	lda.b $A5
	jsl.l CODE_C5BE33
	ldy.b $0C
	lda.w $003A,y
	and.w #$00FF
	sta.b $0E
	clc
	txa
	adc.b $0E
	tax
	lda.b $A5
	jsr.w CODE_C40C0B
	lda.b $A5
	jsl.l CODE_C5BDA8
	stx.b $9F
	ldy.b $0C
	lda.w $00A2,y
	and.w #$00FF
	sec
	sbc.b $0E
	clc
	adc.b $9F
	tax
	lda.b $A5
	jsr.w CODE_C40C62
CODE_C40B3C:						; from CODE_C40AAF, CODE_C40AEF
	ldx.b $0A
	ldy.b $0C
	inx
	inx
	iny
	dec.b $10
	beq CODE_C40B4A
	jmp.w CODE_C40AAF
CODE_C40B4A:						; from CODE_C40B3C
	plb
	rts
CODE_C40B4C:						; from CODE_C40AAF
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	txy
	lsr a
	lsr a
	lsr a
	tax
	lda.b $9F
	and.w #$0007
	sty.b $9F
	tay
	lda.w #$FE00
	dey
	bmi CODE_C40B72
CODE_C40B6B:						; from CODE_C40B6B
	asl.b $9F
	sec
	rol a
	dey
	bpl CODE_C40B6B
CODE_C40B72:						; from CODE_C40B4C
	sta.b $16
	lda.l $30628F,x
	and.b $16
	ora.b $9F
	sta.l $30628F,x
	rts
CODE_C40B81:						; from CODE_C40AAF
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	txy
	lsr a
	lsr a
	lsr a
	tax
	lda.b $9F
	and.w #$0007
	sty.b $9F
	tay
	lda.w #$FE00
	dey
	bmi CODE_C40BA7
CODE_C40BA0:						; from CODE_C40BA0
	asl.b $9F
	sec
	rol a
	dey
	bpl CODE_C40BA0
CODE_C40BA7:						; from CODE_C40B81
	sta.b $16
	lda.l $306724,x
	and.b $16
	ora.b $9F
	sta.l $306724,x
	rts
CODE_C40BB6:						; from CODE_C40AEF
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
	stx.b $16
	tax
	lda.w #$FFF8
	trb.b $9F
	lda.l $30628F,x
CODE_C40BD1:						; from CODE_C40BD1
	lsr a
	dec.b $9F
	bpl CODE_C40BD1
	rol a
	and.w #$007F
	sta.b $9F
	asl a
	adc.b $9F
	asl a
	adc.b $9F
	sta.b $9F
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b $9F
	ldy.b $9F
	lda.w #$FF80
	dey
	bmi CODE_C40BFC
CODE_C40BF5:						; from CODE_C40BF5
	asl.b $16
	sec
	rol a
	dey
	bpl CODE_C40BF5
CODE_C40BFC:						; from CODE_C40BD1
	sta.b $9F
	lda.l $307080,x
	and.b $9F
	ora.b $16
	sta.l $307080,x
	rts
CODE_C40C0B:						; from CODE_C40AEF
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
	tay
	txa
	sta.b $14
	and.w #$0600
	lsr a
	lsr a
	sta.b $16
	lda.w #$FE7F
	sta.b $2E
	lda.w #$FE00
	sta.b $2C
	trb.b $14
	lda.w #$FFF8
	trb.b $9F
	tyx
	ldy.b $9F
	dey
	bmi CODE_C40C49
CODE_C40C3C:						; from CODE_C40C3C
	asl.b $16
	asl.b $14
	sec
	rol.b $2C
	sec
	rol.b $2E
	dey
	bpl CODE_C40C3C
CODE_C40C49:						; from CODE_C40C0B
	lda.l $30628F,x
	and.b $2E
	ora.b $16
	sta.l $30628F,x
	lda.l $306724,x
	and.b $2C
	ora.b $14
	sta.l $306724,x
	rts
CODE_C40C62:						; from CODE_C40AEF
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
	txy
	tax
	lda.w #$FFF8
	trb.b $9F
	lda.l $30628F,x
CODE_C40C7C:						; from CODE_C40C7C
	lsr a
	dec.b $9F
	bpl CODE_C40C7C
	rol a
	and.w #$007F
	sta.b $9F
	asl a
	adc.b $9F
	lsr a
	tax
	bcc CODE_C40CA3
	tya
	asl a
	asl a
	asl a
	asl a
	sta.b $9F
	lda.l $306FED,x
	and.w #$000F
	ora.b $9F
	sta.l $306FED,x
	rts
CODE_C40CA3:						; from CODE_C40C7C
	sty.b $9F
	lda.l $306FED,x
	and.w #$F000
	ora.b $9F
	sta.l $306FED,x
	rts
CODE_C40CB3:						; from CODE_C402EB
	lda.w $2C42
	sta.b $9F
	pea.w $7E7F
	plb
	ldy.w #$8EF8
CODE_C40CBF:						; from CODE_C40CBF
	phy
	lda.w $0004,y
	jsr.w CODE_C40CE3
	ply
	phy
	lda.w $0002,y
	tax
	tya
	clc
	adc.w #$001A
	tay
	txa
	jsr.w CODE_C40CE3
	ply
	clc
	tya
	adc.w #$010A
	tay
	dec.b $9F
	bne CODE_C40CBF
	plb
	rts
CODE_C40CE3:						; from CODE_C40CBF
	ldx.w #$000F
	sep #$20
CODE_C40CE8:						; from CODE_C40CE8
	cmp.l $3075A4,x
	beq CODE_C40CF2
	dex
	bpl CODE_C40CE8
	inx
CODE_C40CF2:						; from CODE_C40CE8
	rep #$20
	txa
	asl a
	tax
	lda.l DATA8_C40D76,x
	sta.b $A3
	lda.w #$0018
	sta.b $A1
CODE_C40D02:						; from CODE_C40D3A
	lda.w $003A,y
	and.w #$00FF
	sta.b $A5
	lda.w $006E,y
	and.w #$00FF
	sta.b $0A
	lda.w #$FF80
	sta.b $0C
	eor.w #$FFFF
	sta.b $10
	lda.b $A3
	lsr a
	lsr a
	lsr a
	tax
	lda.b $A3
	and.w #$0007
	sta.b $0E
	dec.b $0E
	bmi CODE_C40D3A
CODE_C40D2D:						; from CODE_C40D2D
	asl.b $A5
	asl.b $0A
	sec
	rol.b $0C
	asl.b $10
	dec.b $0E
	bpl CODE_C40D2D
CODE_C40D3A:						; from CODE_C40D02
	lda.l $3072E8,x
	and.b $10
	clc
	adc.b $A5
	sta.b $A5
	lda.l $3072E8,x
	and.b $0C
	ora.b $A5
	sta.l $3072E8,x
	lda.l $307446,x
	and.b $10
	clc
	adc.b $0A
	sta.b $0A
	lda.l $307446,x
	and.b $0C
	ora.b $0A
	sta.l $307446,x
	clc
	lda.b $A3
	adc.w #$0007
	sta.b $A3
	iny
	dec.b $A1
	bpl CODE_C40D02
	rts
DATA8_C40D76:						; not traced: a table read by CODE_C40CF2
	db $00,$00,$AF,$00,$5E,$01,$0D,$02,$BC,$02,$6B,$03,$1A,$04,$C9,$04
	db $78,$05,$27,$06,$D6,$06,$85,$07,$34,$08,$E3,$08,$92,$09,$41,$0A
CODE_C40D96:						; called from other segments
	lda.l $3075A4
	bne CODE_C40DFA
	lda.w #$2C46
	ldy.w #$0078
	jsl.l CODE_C58B11
	jsl.l $C4C536
	jsl.l CODE_C5E37E
	lda.w #$0002
	sta.b $9F
	jsr.w CODE_C40E45
	jsr.w CODE_C40E3A
	ldx.w #$0004
	bit.w #$0004
	bne CODE_C40DC4
	ldx.w #$0008
CODE_C40DC4:						; from CODE_C40D96
	stx.b $9F
	jsr.w CODE_C40E14
	jsr.w CODE_C40E2D
	lda.w #$75A4
	sta.b $2C
	lda.w #$0030
	sta.b $2E
	jsr.w CODE_C40DFB
	lda.w #$0001
	sta.b $9F
	jsr.w CODE_C40E45
	jsr.w CODE_C40E3A
	ldx.w #$0010
	bit.w #$0010
	bne CODE_C40DEF
	ldx.w #$0020
CODE_C40DEF:						; from CODE_C40DC4
	stx.b $9F
	jsr.w CODE_C40E14
	jsr.w CODE_C40E2D
	jsr.w CODE_C40DFB
CODE_C40DFA:						; from CODE_C40D96
	rtl
CODE_C40DFB:						; from CODE_C40DC4, CODE_C40DEF
	sep #$20
	ldy.w #$000E
CODE_C40E00:						; from CODE_C40E00
	ldx.w $364E,y
	lda.w $000C,x
	sta.b [$2C]
	ldx.b $2C
	inx
	stx.b $2C
	dey
	dey
	bpl CODE_C40E00
	rep #$20
	rts
CODE_C40E14:						; from CODE_C40DC4, CODE_C40DEF
	ldy.w #$000C
CODE_C40E17:						; from CODE_C40E17
	ldx.w $364E,y
	lda.w $000C,x
	tax
	lda.l DATA8_C40EDA,x
	bit.b $9F
	bne CODE_C40E2C
	dey
	dey
	bpl CODE_C40E17
	iny
	iny
CODE_C40E2C:						; from CODE_C40E17
	rts
CODE_C40E2D:						; from CODE_C40DC4, CODE_C40DEF
	lda.w $365A
	ldx.w $364E,y
	sta.w $364E,y
	stx.w $365A
	rts
CODE_C40E3A:						; from CODE_C40D96, CODE_C40DC4
	ldy.w $365C
	ldx.w $000C,y
	lda.l DATA8_C40EDA,x
	rts
CODE_C40E45:						; from CODE_C40D96, CODE_C40DC4
	jsr.w CODE_C40ECA
	ldy.b $81
CODE_C40E4A:						; from CODE_C40E58
	ldx.w $000C,y
	lda.l DATA8_C40EDA,x
	bit.b $9F
	beq CODE_C40E58
	jsr.w CODE_C40E5F
CODE_C40E58:						; from CODE_C40E4A
	lda.w $0002,y
	tay
	bne CODE_C40E4A
	rts
CODE_C40E5F:						; from CODE_C40E4A
	ldx.w #$000E
CODE_C40E62:						; from CODE_C40E86
	lda.w $364E,x
	beq CODE_C40E81
	stx.b $A1
	tax
	jsr.w CODE_C40E8D
	bcs CODE_C40E86
	sty.b $A3
	ldy.w #$364E
	ldx.w #$3650
	lda.b $A1
	inc a
	mvn $7E,$7E
	ldy.b $A3
	ldx.b $A1
CODE_C40E81:						; from CODE_C40E62
	tya
	sta.w $364E,x
	rts
CODE_C40E86:						; from CODE_C40E62
	ldx.b $A1
	dex
	dex
	bpl CODE_C40E62
	rts
CODE_C40E8D:						; from CODE_C40E62
	lda.w $000A,x
	cmp.w $000A,y
	beq CODE_C40E96
	rts
CODE_C40E96:						; from CODE_C40E8D
	lda.w $0004,x
	cmp.w $0004,y
	beq CODE_C40E9F
	rts
CODE_C40E9F:						; from CODE_C40E96
	lda.w $0008,x
	cmp.w $0008,y
	beq CODE_C40EA8
	rts
CODE_C40EA8:						; from CODE_C40E9F
	lda.w $000E,x
	cmp.w $000E,y
	beq CODE_C40EB1
	rts
CODE_C40EB1:						; from CODE_C40EA8
	lda.w $002A,y
	cmp.w $002A,x
	beq CODE_C40EBA
	rts
CODE_C40EBA:						; from CODE_C40EB1
	lda.w $0018,x
	cmp.w $0018,y
	beq CODE_C40EC3
	rts
CODE_C40EC3:						; from CODE_C40EBA
	lda.w $001C,x
	cmp.w $001C,y
	rts
CODE_C40ECA:						; from CODE_C40E45
	stz.w $364E
	ldx.w #$364E
	ldy.w #$3650
	lda.w #$000D
	mvn $7E,$7E
	rts
DATA8_C40EDA:						; not traced: a table read by CODE_C40E4A, CODE_C40E3A, CODE_C40E17
	db $06,$11,$11,$06,$0A,$0A,$0A,$06,$21,$11,$06,$11,$21,$21,$21,$11
	db $21,$11,$11,$06,$0A,$21,$0A,$06,$21,$0A
DATA8_C40EF4:						; not traced: a table read by CODE_C4081B
	db $00,$00,$01,$01,$02,$02,$03,$02,$04,$02,$05,$03,$06,$03,$07,$03
	db $08,$03,$09,$03,$0A,$03,$0B,$03,$0C,$03,$0D,$03,$0E,$03,$0F,$03
	db $10,$02,$11,$02,$12,$02,$13,$01,$14,$00,$13,$FF,$12,$FE,$11,$FE
	db $10,$FE,$0F,$FD,$0E,$FD,$0D,$FD,$0C,$FD,$0B,$FD,$0A,$FD,$09,$FD
	db $08,$FD,$07,$FD,$06,$FD,$05,$FD,$04,$FE,$03,$FE,$02,$FE,$01,$FF
	db $00,$00,$FF,$01,$FE,$02,$FD,$02,$FC,$02,$FB,$03,$FA,$03,$F9,$03
	db $F8,$03,$F7,$03,$F6,$03,$F5,$03,$F4,$03,$F3,$03,$F2,$03,$F1,$03
	db $F0,$02,$EF,$02,$EE,$02,$ED,$01,$EC,$00,$ED,$FF,$EE,$FE,$EF,$FE
	db $F0,$FE,$F1,$FD,$F2,$FD,$F3,$FD,$F4,$FD,$F5,$FD,$F6,$FD,$F7,$FD
	db $F8,$FD,$F9,$FD,$FA,$FD,$FB,$FD,$FC,$FE,$FD,$FE,$FE,$FE,$FF,$FF
DATA8_C40F94:						; not traced: a table read by CODE_C408C4, CODE_C4090B
	db $12
DATA8_C40F95:						; not traced: a table read by CODE_C408DB, CODE_C40919
	db $1A,$0F,$1D,$0C,$20,$0B,$21,$09,$23,$08,$24,$07,$25,$06,$26,$05
	db $27,$05,$27,$04,$28,$03,$29,$03,$29,$03,$29,$02,$2A,$02,$2A,$02
	db $2A,$01,$2B,$01,$2B,$01,$2B,$01,$2B,$01,$2B,$01,$2B,$01,$2B,$01
	db $2B,$01,$2B,$02,$2A,$02,$2A,$02,$2A,$03,$29,$03,$29,$03,$29,$04
	db $28,$05,$27,$05,$27,$06,$26,$07,$25,$08,$24,$09,$23,$0B,$21,$0C
	db $20,$0F,$1D,$12,$1A,$F0,$4E,$36,$F0,$0E,$38,$00,$F0,$CE,$39,$F0
	db $8E,$3B,$00
DATA8_C40FF8:						; not traced: a table read by CODE_C403C2
	db $00,$00,$28,$00,$9E,$00,$11,$01,$82,$01,$FA,$01,$20,$02

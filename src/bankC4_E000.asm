; Segment bankC4_E000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4DFD6
CODE_C4DFD6:						; called from other segments
	sta.b $63
	stx.b $65
	jsr.w CODE_C4D773
	lda.w #$000F
	sta.b $18
	lda.w #$0057
	sta.b $1A
	lda.w #$0027
	jsl.l CreateSprite
	lda.w #$0070
	sta.b $1A
	lda.w #$00E0
	sta.b $18
	lda.b $63
	jsl.l CreateSprite
	inc.b $38,x
	lda.b $08
	sta.b $30
	lda.w #$007E
	sta.b $32
	ldx.w #$00CE
	lda.w #$F3E9
	jsl.l CODE_C5881C
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	ldx.w #$506D
	ldy.b $08
CODE_C4E020:						; from CODE_C4E020
	pea.w $0010
	phx
	pea.w $007E
	phy
	tya
	clc
	adc.w #$0010
	tay
	txa
	clc
	adc.w #$0020
	tax
	cmp.w #$522D
	bne CODE_C4E020
	pea.w $0AE0
	pea.w $0000
	pea.w $007E
	lda.b $08
	clc
	adc.w #$00E0
	pha
	adc.w #$0AE0
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0030
	pea.w $007E
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l CODE_C4CEDB
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w #$2400
	sta.b $D5
	ldx.w #$50A9
	ldy.w #$0012
	jsl.l CODE_C4BCA4
	lda.w #$2000
	sta.b $D5
	lda.b $63
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l CODE_C4C3BA
	phx
	ldx.w #$50B4
	jsl.l CODE_C4C3BA
	txy
	plx
	jsl.l CODE_C56005
	ldy.w #$0015
	jsl.l CODE_C4BBF1
	ldx.w #$50C4
	jsl.l CODE_C4C3BA
	phx
	lda.b $65
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l CODE_C4C3BA
	txy
	plx
	jsl.l CODE_C56005
	phx
	ldx.w #$50CC
	jsl.l CODE_C4C3BA
	txy
	plx
	jsl.l CODE_C56005
	ldy.w #$0016
	jsl.l CODE_C4BBF1
	ldx.w #$50D6
	ldy.w #$0017
	jsl.l CODE_C4BBE5
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	stz.w $04C0
	stz.w fadestep
CODE_C4E0FE:						; from CODE_C4E0FE
	inc.w TransfersReady
	wai
	jsl.l $C36C2D
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C4E0FE
	lda.w $058D
	bit.w #$1000
	beq CODE_C4E0FE
	rtl
CODE_C4E12C:						; called from other segments
	jsl.l CODE_C4C530
	jsl.l CODE_C5E50E
	lda.w $1864
	cmp.w #$0001
	bne CODE_C4E140
	jsr.w CODE_C4F2AE
	rtl
CODE_C4E140:						; from CODE_C4E12C
	lda.w #$0002
	sta.w $04C2
	ldy.w #$5C00
	jsl.l CODE_C589E4
	jsl.l CODE_C4BAF6
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldy.w #$0001
	ldx.w #$4C9F
	jsl.l CODE_C4BDAE
	lda.w #$05D9
	ldx.w #$00CF
	jsl.l $CF0134
	lda.w #$00A6
	jsl.l $CF040B
	jsl.l $CF03D0
	lda.w $17C9
	cmp.w #$001A
	bcc CODE_C4E188
	ldy.w #$2DC9
	jsr.w CODE_C4EF41
CODE_C4E188:						; from CODE_C4E140
	lda.w $17CB
	cmp.w #$001A
	bcc CODE_C4E196
	ldy.w #$3207
	jsr.w CODE_C4EF41
CODE_C4E196:						; from CODE_C4E188
	jsr.w CODE_C4F2AE
	lda.w #$0018
	sta.b $CF
	lda.w #$0060
	sta.b $D1
	lda.w $17CB
	asl a
	tax
	lda.l $C3585C,x
	tax
	ldy.w #$000E
	jsl.l CODE_C4BCAA
	lda.w #$00A0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	lda.w $17C9
	asl a
	tax
	lda.l $C3585C,x
	tax
	ldy.w #$000E
	jsl.l CODE_C4BCAA
	jsl.l CODE_C4C2AA
	stz.b $22
	stz.b $24
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$1B,$49,$C0,$00		; inline parameters
	lda.w #$0400
	sta.b $A1
	lda.w #$5800
	sta.b $9F
	lda.w #$87F2
	ldx.w #$00C0
	ldy.w #$2000
	jsl.l MapSetToVRAM
	ldy.w #$5000
	jsl.l CODE_C589B0
	lda.w #BlueColoursHook
	ldx.w #BlueColoursHook>>16
	jsl.l SetNMIHook
	ldx.w #$50B6
	ldy.w #$3013
	jsr.w CODE_C4EE9D
	ldx.w #$50A4
	ldy.w #$3437
	jsr.w CODE_C4EE9D
	lda.w #$003D
	sta.b $1A
	lda.w #$0038
	sta.b $18
	lda.w $17CB
	jsl.l CreateSprite
	stx.b $9B
	inc.b $38,x
	lda.w #$0025
	sta.b $1A
	lda.w #$0020
	sta.b $18
	lda.w #$0026
	jsl.l CreateSprite
	stx.b $97
	lda.w #$2000
	sta.b $36,x
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	lda.w #$003D
	sta.b $1A
	lda.w #$00C8
	sta.b $18
	lda.w $17C9
	jsl.l CreateSprite
	stx.b $9D
	inc.b $38,x
	lda.w #$0025
	sta.b $1A
	lda.w #$00B0
	sta.b $18
	lda.w #$0026
	jsl.l CreateSprite
	stx.b $99
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	lda.w #$2000
	sta.b $36,x
	ldy.w #$2801
	ldx.w #$51D4
	jsl.l $C387D8
	ldy.w #$2C01
	ldx.w #$51C3
	jsl.l $C387D8
	jsl.l CODE_C5A4B5
	jsl.l CODE_C5A4DE
	jsl.l CODE_C4CEDB
	lda.w #$0006
	sta.w $2DA5
	jsr.w CODE_C4E41B
	jsr.w CODE_C4E885
	jsr.w CODE_C4E9D8
	lda.w #$8000
	sta.w DMAEnShadow
	lda.w #$03E8
	sta.b $67
	lda.w #$0017
	sta.l TM
	stz.w fadestep
	lda.w #$012C
	sta.w $2DA1
	lda.w #$0019
	sta.w $2DA3
	jsr.w CODE_C4E3CB
CODE_C4E2D9:						; from CODE_C4E32B, CODE_C4E35A, CODE_C4E36B, CODE_C4E384
	inc.w TransfersReady
CODE_C4E2DC:						; from CODE_C4E2DC
	lda.w TransfersReady
	bne CODE_C4E2DC
	jsl.l $C36C2D
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $2DA1
	bmi CODE_C4E31C
	dec a
	bne CODE_C4E31C
	jsr.w CODE_C4E39E
	lda.w $2DA3
	sec
	sbc.w #$0005
	bmi CODE_C4E313
	bne CODE_C4E316
CODE_C4E313:						; from CODE_C4E2DC
	lda.w #$0001
CODE_C4E316:						; from CODE_C4E2DC
	sta.w $2DA3
	lda.w #$012C
CODE_C4E31C:						; from CODE_C4E2DC
	sta.w $2DA1
	lda.w $2DA3
	dec a
	bne CODE_C4E32B
	jsr.w CODE_C4EBC8
	lda.w #$0019
CODE_C4E32B:						; from CODE_C4E31C
	sta.w $2DA3
	lda.w $058F
	bne CODE_C4E2D9
	lda.w $058D
	bit.w #$1000
	bne CODE_C4E387
	bit.w #$0400
	beq CODE_C4E34C
	lda.w #$0001
	sta.w $2DA3
	lda.w #$0400
	trb.w $0565
CODE_C4E34C:						; from CODE_C4E32B
	bit.w #$0800
	beq CODE_C4E35A
	inc.w $2DA3
	lda.w #$0800
	trb.w $0565
CODE_C4E35A:						; from CODE_C4E34C
	bit.w #$0080
	beq CODE_C4E36B
	lda.w #$8000
	tsb.w $2DA1
	jsr.w CODE_C4E39E
	jmp.w CODE_C4E2D9
CODE_C4E36B:						; from CODE_C4E35A
	bit.w #$4000
	beq CODE_C4E37C
	lda.w #$8000
	tsb.w $2DA1
	jsr.w CODE_C4E3B0
	jmp.w CODE_C4E2D9
CODE_C4E37C:						; from CODE_C4E36B
	bit.w #$0040
	beq CODE_C4E384
	jsr.w CODE_C4E3BF
CODE_C4E384:						; from CODE_C4E37C
	jmp.w CODE_C4E2D9
CODE_C4E387:						; from CODE_C4E32B, CODE_C4EC4F
	jsl.l $CF039E
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	jsl.l CODE_C4CEDB
	jsl.l ClearNMIHook
	jml.l CODE_C5E50E
CODE_C4E39E:						; from CODE_C4E2DC, CODE_C4E35A
	lda.w $2DA5
	inc a
	cmp.w #$0007
	bcc CODE_C4E3AA
	lda.w #$0000
CODE_C4E3AA:						; from CODE_C4E39E
	sta.w $2DA5
	jmp.w CODE_C4E41B
CODE_C4E3B0:						; from CODE_C4E36B
	lda.w $2DA5
	bne CODE_C4E3B8
	lda.w #$0007
CODE_C4E3B8:						; from CODE_C4E3B0
	dec a
	sta.w $2DA5
	jmp.w CODE_C4E41B
CODE_C4E3BF:						; from CODE_C4E37C
	ldx.b $77
	jsl.l CODE_C5E596
	ldx.b $79
	jsl.l CODE_C5E596
CODE_C4E3CB:						; from CODE_C4E196
	lda.b $7B
	sta.b $7D
	lda.w #$0012
	sta.w $2DC7
	lda.w #$0002
	sta.w $2DC5
	lda.w #$0010
	sta.b $95
	stz.b $93
	stz.b $69
	stz.b $69
	lda.b $D3
	clc
	adc.w #$0440
	ldy.w #$02C0
	jsl.l CODE_C58B11
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	lda.w #$5C11
	ldx.w #$0008
	ldy.w #$0012
	jsl.l CODE_C55AB8
	ldx.b $77
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	ldx.b $79
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	rts
CODE_C4E41B:						; from CODE_C4E196, CODE_C4E3AA, CODE_C4E3B8
	lda.b $D3
	clc
	adc.w #$0140
	ldy.w #$0240
	jsl.l CODE_C58B11
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	ldx.b $9B
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	ldx.b $9D
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	ldx.b $97
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	ldx.b $99
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	jsl.l CODE_C4C541
	ldx.w $2DA5
	cpx.w #$0005
	bcc CODE_C4E468
	beq CODE_C4E465
	jmp.w CODE_C4E79A
CODE_C4E465:						; from CODE_C4E41B
	jmp.w CODE_C4E624
CODE_C4E468:						; from CODE_C4E41B
	lda.w $2E36,x
	and.w #$00FF
	dec a
	asl a
	tay
	lda.w $2EA7,y
	sta.b $63
	and.w #$00FF
	sta.b $6D
	tax
	cmp.w #$00FF
	beq CODE_C4E4CB
	lda.w $2E75,y
	sta.b $6B
	clc
	adc.w #$00C0
	phy
	ldy.b $64
	jsr.w CODE_C4EC88
	tay
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0130
	pea.w $007E
	phy
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0040
	pei ($6D)
	lda.b $63
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	adc.b $6B
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	ply
	bra CODE_C4E4CE
CODE_C4E4CB:						; from CODE_C4E468
	jsr.w CODE_C4EF07
CODE_C4E4CE:						; from CODE_C4E468
	ldx.w $2DA5
	lda.w $3274,x
	and.w #$00FF
	dec a
	asl a
	tay
	lda.w $32E5,y
	sta.b $63
	and.w #$00FF
	sta.b $6D
	tax
	cmp.w #$00FF
	beq CODE_C4E534
	lda.w $32B3,y
	sta.b $6B
	clc
	adc.w #$00C0
	phy
	ldy.b $64
	jsr.w CODE_C4EC88
	tay
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0370
	pea.w $007E
	phy
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0050
	pei ($6D)
	lda.b $63
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	adc.b $6B
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	ply
	bra CODE_C4E537
CODE_C4E534:						; from CODE_C4E4CE
	jsr.w CODE_C4EECD
CODE_C4E537:						; from CODE_C4E4CE
	jsl.l CODE_C5BBBC
	lda.w #$0018
	sta.b $CF
	lda.w #$0050
	sta.b $D1
	lda.w #$0002
	sta.b $6B
	ldx.w $2DA5
	lda.w $3274,x
	and.w #$00FF
	dec a
	sta.b $7F
	pha
	lda.w #$5DF9
	sta.b $8F
	stz.b $91
	lda.w #$0001
	sta.l $7E24DC
	jsl.l CODE_C571C7
	jsl.l CODE_C5B676
	jsl.l CODE_C55EC3
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l CODE_C4BBF1
	jsl.l CODE_C4CEDB
	pla
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.w #$331F
	tax
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.w #$000C
	jsl.l CODE_C4BC08
	jsl.l CODE_C4CEDB
	lda.w #$00B0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	stz.b $6B
	ldx.w $2DA5
	lda.w $2E36,x
	and.w #$00FF
	dec a
	sta.b $7F
	pha
	lda.w #$5DF9
	sta.b $8F
	stz.b $91
	lda.w #$0001
	sta.l $7E24DC
	jsl.l CODE_C571C7
	jsl.l CODE_C5B676
	jsl.l CODE_C55EC3
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l CODE_C4BBF1
	jsl.l CODE_C4CEDB
	pla
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.w #$2EE1
	tax
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.w #$000C
	jsl.l CODE_C4BC1A
	jsl.l CODE_C4CEDB
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w $2DA5
	asl a
	tax
	lda.l $C35E51,x
	tax
	ldy.w #$0007
	jsl.l CODE_C4BBE5
	jsl.l CODE_C4CEDB
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	jsl.l CODE_C4C536
	rts
CODE_C4E624:						; from CODE_C4E465
	lda.w $2EA7
	sta.b $63
	and.w #$00FF
	sta.b $6D
	tax
	cmp.w #$00FF
	beq CODE_C4E67C
	lda.w $2E75
	sta.b $6B
	clc
	adc.w #$00C0
	ldy.b $64
	jsr.w CODE_C4EC88
	tay
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0130
	pea.w $007E
	phy
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0040
	pei ($6D)
	lda.b $63
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	adc.b $6B
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	bra CODE_C4E67F
CODE_C4E67C:						; from CODE_C4E624
	jsr.w CODE_C4EF07
CODE_C4E67F:						; from CODE_C4E624
	lda.w $32E5
	sta.b $63
	and.w #$00FF
	sta.b $6D
	tax
	cmp.w #$00FF
	beq CODE_C4E6D7
	lda.w $32B3
	sta.b $6B
	clc
	adc.w #$00C0
	ldy.b $64
	jsr.w CODE_C4EC88
	tay
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0370
	pea.w $007E
	phy
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0050
	pei ($6D)
	lda.b $63
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	adc.b $6B
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	bra CODE_C4E6DA
CODE_C4E6D7:						; from CODE_C4E67F
	jsr.w CODE_C4EECD
CODE_C4E6DA:						; from CODE_C4E67F
	jsl.l CODE_C5BBBC
	lda.w #$00B0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	stz.b $6B
	stz.b $7F
	lda.w #$F0C9
	sta.b $8F
	lda.w #$0010
	sta.b $91
	lda.w #$0001
	sta.l $7E24DC
	jsl.l CODE_C571C7
	jsl.l CODE_C5B676
	jsl.l CODE_C55EC3
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l CODE_C4BBF1
	ldx.w #$2EE1
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.w #$000C
	jsl.l CODE_C4BC1A
	jsl.l CODE_C4CEDB
	lda.w #$0018
	sta.b $CF
	lda.w #$0050
	sta.b $D1
	lda.w #$0002
	sta.b $6B
	stz.b $7F
	lda.w #$F0C9
	sta.b $8F
	lda.w #$0010
	sta.b $91
	lda.w #$0001
	sta.l $7E24DC
	jsl.l CODE_C571C7
	jsl.l CODE_C5B676
	jsl.l CODE_C55EC3
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l CODE_C4BBF1
	ldx.w #$331F
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.w #$000C
	jsl.l CODE_C4BC08
	jsl.l CODE_C4CEDB
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$49B8
	ldy.w #$0007
	jsl.l CODE_C4BBE5
	jsl.l CODE_C4CEDB
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	jsl.l CODE_C4C536
	rts
CODE_C4E79A:						; from CODE_C4E41B
	stz.w $04F5
	stz.w $364E
	ldx.w #$364E
	ldy.w #$3650
	lda.w #$047D
	mvn $7E,$7E
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0130
	pea.w $007E
	pea.w $364E
	pea.w $0480
	pea.w $0370
	pea.w $007E
	pea.w $364E
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	ldx.b $9B
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	ldx.b $9D
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	ldx.b $97
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	ldx.b $99
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	jsl.l CODE_C5BBBC
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4ECC
	ldy.w #$0008
	jsl.l CODE_C4BBE5
	jsl.l CODE_C4CEDB
	lda.w #$0018
	sta.b $CF
	lda.w #$0050
	sta.b $D1
	lda.w $17CB
	asl a
	tax
	lda.l $C30000,x
	tax
	adc.l $C30006,x
	tax
	lda.l $C30004,x
	and.w #$00FF
	jsl.l CODE_C5B676
	jsl.l CODE_C55EC3
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l CODE_C4BBF1
	jsl.l CODE_C4CEDB
	lda.w #$00B0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	lda.w $17C9
	asl a
	tax
	lda.l $C30000,x
	tax
	adc.l $C30006,x
	tax
	lda.l $C30004,x
	and.w #$00FF
	jsl.l CODE_C5B676
	jsl.l CODE_C55EC3
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l CODE_C4BBF1
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	rts
CODE_C4E885:						; from CODE_C4E196
	stz.b $6B
	ldy.w #$2DA9
	ldx.w #$2DC9
	jsr.w CODE_C4E8CD
	lda.w #$0002
	sta.b $6B
	ldy.w #$2DB7
	ldx.w #$3207
	jsr.w CODE_C4E8CD
	ldx.w $17C9
	lda.w $2DB5
	sec
	sbc.w $2DC3
	bpl CODE_C4E8B1
	ldx.w $17CB
	eor.w #$FFFF
	inc a
CODE_C4E8B1:						; from CODE_C4E885
	stx.w $2DA7
	tax
	lda.w #$8000
	cpx.w #$0008
	bcs CODE_C4E8C9
	cpx.w #$0004
	bcs CODE_C4E8C8
	ldx.w #$FFFF
	stx.w $2DA7
CODE_C4E8C8:						; from CODE_C4E8B1
	asl a
CODE_C4E8C9:						; from CODE_C4E8B1
	tsb.w $2DA7
	rts
CODE_C4E8CD:						; from CODE_C4E885
	stz.w $04F5
	stz.w $04F7
	stz.w $04F9
	lda.w #$FFFF
	sta.w $04FB
	sta.w $04FD
	sta.w $04FF
	inc a
	sta.w $000C,y
	lda.w $0000,x
	sta.b $63
	lda.w #$0000
CODE_C4E8EE:						; from CODE_C4E9C4
	phx
	pha
	phy
	ldy.w #$5DF9
	sty.b $8F
	ldy.w #$0000
	cmp.w $0002,x
	bcs CODE_C4E906
	ldy.w #$F0C9
	sty.b $8F
	ldy.w #$0010
CODE_C4E906:						; from CODE_C4E8EE
	sty.b $91
	sta.b $7F
	stz.w $24DC
	jsl.l CODE_C571C7
	pha
	lda.b $05,s
	sta.b $7F
	inc.w $24DC
	jsl.l CODE_C571C7
	sec
	sbc.b $01,s
	plx
	sta.b $65
	ply
	plx
	bit.w #$8000
	bne CODE_C4E977
	cmp.w $04F9
	bcs CODE_C4E932
	jmp.w CODE_C4E9C4
CODE_C4E932:						; from CODE_C4E906
	cmp.w $04F7
	bcs CODE_C4E942
	sta.w $04F9
	txa
	asl a
	sta.w $0004,y
	jmp.w CODE_C4E9C4
CODE_C4E942:						; from CODE_C4E932
	lda.w $04F7
	sta.w $04F9
	lda.w $0002,y
	sta.w $0004,y
	lda.b $65
	cmp.w $04F5
	bcs CODE_C4E95F
	sta.w $04F7
	txa
	asl a
	sta.w $0002,y
	bra CODE_C4E9C4
CODE_C4E95F:						; from CODE_C4E942
	lda.w $04F5
	sta.w $04F7
	lda.w $0000,y
	sta.w $0002,y
	lda.b $65
	sta.w $04F5
	txa
	asl a
	sta.w $0000,y
	bra CODE_C4E9C4
CODE_C4E977:						; from CODE_C4E906
	cmp.w $04FF
	beq CODE_C4E97E
	bcs CODE_C4E9C4
CODE_C4E97E:						; from CODE_C4E977
	cmp.w $04FD
	bcc CODE_C4E98F
	beq CODE_C4E98F
	sta.w $04FF
	txa
	asl a
	sta.w $000A,y
	bra CODE_C4E9C4
CODE_C4E98F:						; from CODE_C4E97E
	lda.w $04FD
	sta.w $04FF
	lda.w $0008,y
	sta.w $000A,y
	lda.b $65
	cmp.w $04FB
	bcc CODE_C4E9AE
	beq CODE_C4E9AE
	sta.w $04FD
	txa
	asl a
	sta.w $0008,y
	bra CODE_C4E9C4
CODE_C4E9AE:						; from CODE_C4E98F
	lda.w $04FB
	sta.w $04FD
	lda.w $0006,y
	sta.w $0008,y
	lda.b $65
	sta.w $04FB
	txa
	asl a
	sta.w $0006,y
CODE_C4E9C4:						; from CODE_C4E906, CODE_C4E977, CODE_C4E97E, CODE_C4E932, ...
	lda.w $000C,y
	clc
	adc.b $65
	sta.w $000C,y
	txa
	plx
	inc a
	cmp.b $63
	beq CODE_C4E9D7
	jmp.w CODE_C4E8EE
CODE_C4E9D7:						; from CODE_C4E9C4
	rts
CODE_C4E9D8:						; from CODE_C4E196
	jsl.l CODE_C4C541
	stz.b $81
	ldx.w #$4DB9
	jsr.w CODE_C4EB68
	lda.w $17C9
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	phx
	jsl.l CODE_C560A8
	jsl.l CODE_C560A8
	stx.b $7F
	jsl.l CODE_C560A8
	jsr.w CODE_C4EB68
	ldx.w #$4DC8
	jsr.w CODE_C4EB68
	plx
	lda.w $17C9
	beq CODE_C4EA14
	jsr.w CODE_C4EB68
CODE_C4EA14:						; from CODE_C4E9D8
	lda.w #$0020
	sta.w $364E,y
	iny
	sty.b $81
	ldx.b $7F
	jsr.w CODE_C4EB68
	lda.w #$6120
	sta.w $364E,y
	lda.w #$646E
	sta.w $3650,y
	lda.w #$2064
	sta.w $3651,y
	iny
	iny
	iny
	iny
	iny
	sty.b $81
	lda.w $17CB
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	phx
	jsl.l CODE_C560A8
	jsl.l CODE_C560A8
	stx.b $7F
	plx
	lda.w $17CB
	bne CODE_C4EA5E
	ldx.w #$4720
CODE_C4EA5E:						; from CODE_C4EA14
	jsr.w CODE_C4EB68
	lda.w #$0020
	sta.w $364E,y
	iny
	sty.b $81
	ldx.b $7F
	jsr.w CODE_C4EB68
	lda.w #$203D
	sta.w $364E,y
	lda.w #$0039
	sta.w $3650,y
	iny
	iny
	iny
	lda.w $2DA7
	cmp.w #$FFFF
	beq CODE_C4EACE
	sty.b $81
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsr.w CODE_C4EB68
	ldx.w #$4DED
	jsr.w CODE_C4EB68
	lda.w $2DA7
	bpl CODE_C4EAC6
	lda.w #$7865
	sta.w $364E,y
	lda.w #$7274
	sta.w $3650,y
	lda.w #$6D65
	sta.w $3652,y
	lda.w #$6C65
	sta.w $3654,y
	lda.w #$2079
	sta.w $3656,y
	tya
	clc
	adc.w #$000A
	tay
CODE_C4EAC6:						; from CODE_C4EA5E
	sty.b $81
	ldx.w #$4DFA
	jsr.w CODE_C4EB68
CODE_C4EACE:						; from CODE_C4EA5E
	lda.w #$2DC9
	sta.b $7F
	lda.w $17C9
	ldx.w #$2DA9
	jsr.w CODE_C4EB81
	lda.w #$3207
	sta.b $7F
	lda.w $17CB
	cmp.w $17C9
	beq CODE_C4EAEF
	ldx.w #$2DB7
	jsr.w CODE_C4EB81
CODE_C4EAEF:						; from CODE_C4EACE
	ldx.w #$4E27
	jsr.w CODE_C4EB68
	lda.w #$0000
	sta.w $364E,y
	iny
	iny
	sty.b $81
	jsl.l CODE_C4C536
	tya
	jsl.l CODE_C4C558
	sta.b $7B
	tax
	jsl.l CODE_C4C541
	ldy.w #$0000
	sep #$20
CODE_C4EB14:						; from CODE_C4EB14
	lda.w $364E,y
	sta.w $0000,x
	inx
	iny
	cpy.b $81
	bne CODE_C4EB14
	rep #$20
	rts
CODE_C4EB23:						; from CODE_C4EB81
	pha
	tax
	lda.w $0000,x
	jsr.w CODE_C4EB5C
	lda.w #$2040
	sta.w $364E,y
	iny
	iny
	sty.b $81
	lda.b $01,s
	tax
	lda.w $0002,x
	jsr.w CODE_C4EB5C
	lda.w #$2040
	sta.w $364E,y
	lda.w #$6E61
	sta.w $3650,y
	lda.w #$2064
	sta.w $3652,y
	tya
	clc
	adc.w #$0006
	tay
	sty.b $81
	plx
	lda.w $0004,x
CODE_C4EB5C:						; from CODE_C4EB23
	asl a
	asl a
	asl a
	asl a
	adc.b $7F
	adc.w #$0118
	tax
	bra CODE_C4EB6C
CODE_C4EB68:						; from CODE_C4E9D8, CODE_C4EA14, CODE_C4EA5E, CODE_C4EAC6, ...
	jsl.l CODE_C4C3BA
CODE_C4EB6C:						; from CODE_C4EB5C
	ldy.b $81
	sep #$20
CODE_C4EB70:						; from CODE_C4EB70
	lda.w $0000,x
	beq CODE_C4EB7C
	sta.w $364E,y
	inx
	iny
	bra CODE_C4EB70
CODE_C4EB7C:						; from CODE_C4EB70
	rep #$20
	sty.b $81
	rts
CODE_C4EB81:						; from CODE_C4EACE
	phx
	pha
	lda.w #$6F46
	sta.w $364E,y
	lda.w #$2072
	sta.w $3650,y
	iny
	iny
	iny
	iny
	sty.b $81
	pla
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsr.w CODE_C4EB68
	lda.w #$2040
	sta.w $364E,y
	iny
	iny
	sty.b $81
	lda.b $01,s
	jsr.w CODE_C4EB23
	ldx.w #$4E06
	jsr.w CODE_C4EB68
	pla
	clc
	adc.w #$0006
	jsr.w CODE_C4EB23
	ldx.w #$4E17
	jmp.w CODE_C4EB68
CODE_C4EBC8:						; from CODE_C4E31C
	ldx.b $7D
	lda.w $2DC5
	cmp.w #$0021
	bcc CODE_C4EBD5
CODE_C4EBD2:						; from CODE_C4EBD7
	jsr.w CODE_C4EC58
CODE_C4EBD5:						; from CODE_C4EBC8
	sep #$20
CODE_C4EBD7:						; from CODE_C4EBEA
	lda.w $0000,x
	beq CODE_C4EBEE
	inx
	cmp.b #$39
	bne CODE_C4EBEA
	rep #$20
	inc.b $7D
	jsr.w CODE_C4EC58
	bra CODE_C4EBD2
CODE_C4EBEA:						; from CODE_C4EBD7
	cmp.b #$20
	bne CODE_C4EBD7
CODE_C4EBEE:						; from CODE_C4EBD7
	rep #$20
	stx.b $81
	txa
	sec
	sbc.b $7D
	beq CODE_C4EC4F
	sta.b $7F
	clc
	adc.w $2DC5
	sta.w $2DC5
	cmp.w #$0022
	bcc CODE_C4EC12
	jsr.w CODE_C4EC58
	lda.w $2DC5
	clc
	adc.b $7F
	sta.w $2DC5
CODE_C4EC12:						; from CODE_C4EBEE
	ldx.b $7D
	ldy.w #$0000
	sep #$20
CODE_C4EC19:						; from CODE_C4EC19
	lda.w $0000,x
	sta.w $04F5,y
	inx
	iny
	cpy.b $7F
	bne CODE_C4EC19
	lda.b #$00
	sta.w $04F5,y
	rep #$20
	lda.b $95
	sta.b $CF
	ldy.w $2DC7
	ldx.w #$04F5
	jsl.l CODE_C4BC08
	clc
	adc.b $95
	dec a
	dec a
	dec a
	sta.b $95
	ldx.b $81
	stx.b $7D
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
CODE_C4EC4E:						; from CODE_C4EC4F
	rts
CODE_C4EC4F:						; from CODE_C4EBEE
	lda.w $23BA
	beq CODE_C4EC4E
	pla
	jmp.w CODE_C4E387
CODE_C4EC58:						; from CODE_C4EBD2, CODE_C4EBD7, CODE_C4EBEE
	lda.w #$0002
	sta.w $2DC5
	lda.w #$0010
	sta.b $95
	lda.w $2DC7
	inc a
	cmp.w #$001A
	bcc CODE_C4EC6E
	inc.b $93
CODE_C4EC6E:						; from CODE_C4EC58
	cmp.w #$001B
	bcc CODE_C4EC76
	lda.w #$0011
CODE_C4EC76:						; from CODE_C4EC6E
	sta.w $2DC7
	lda.b $93
	beq CODE_C4EC87
	phx
	jsl.l CODE_C55C54
	jsl.l CODE_C4CEDB
	plx
CODE_C4EC87:						; from CODE_C4EC76
	rts
CODE_C4EC88:						; from CODE_C4E468, CODE_C4E4CE, CODE_C4E624, ...
	sty.b $87
	stx.b $36
	sta.b $34
	lda.b [$34]
	sta.b $7F
	jsl.l CODE_C4C558
	pha
	sta.b $2C
	lda.w #$007E
	sta.b $2E
	lda.b $34
	jsl.l Decompress
	lda.b $86
	and.w #$FF00
	sta.b $87
	lsr.b $87
	adc.b $87
	sta.b $87
	asl a
	adc.b $87
	sta.b $87
	adc.b $01,s
	sta.b $2C
	sta.b $01,s
	lda.w #$0480
	sta.b $7F
CODE_C4ECC1:						; from CODE_C4EE81
	ldy.w #$0000
	ldx.w #$364E
CODE_C4ECC7:						; from CODE_C4EE73
	lda.w #$0006
	sta.b $85
CODE_C4ECCC:						; from CODE_C4ECCC
	stz.w $0000,x
	stz.w $0010,x
	sep #$20
	lda.b [$2C],y
	sta.b $81
	and.b #$80
	ora.w $0011,x
	sta.w $0011,x
	lda.b $81
	and.b #$40
	asl a
	ora.w $0010,x
	sta.w $0010,x
	lda.b $81
	and.b #$20
	asl a
	asl a
	ora.w $0001,x
	sta.w $0001,x
	lda.b $81
	and.b #$10
	asl a
	asl a
	asl a
	ora.w $0000,x
	sta.w $0000,x
	lda.b $81
	and.b #$08
	asl a
	asl a
	asl a
	ora.w $0011,x
	sta.w $0011,x
	lda.b $81
	and.b #$04
	asl a
	asl a
	asl a
	asl a
	ora.w $0010,x
	sta.w $0010,x
	lda.b $81
	and.b #$02
	ror a
	ror a
	ror a
	ror a
	ora.w $0001,x
	sta.w $0001,x
	lda.b $81
	and.b #$01
	ror a
	ror a
	ror a
	ora.w $0000,x
	sta.w $0000,x
	iny
	lda.b [$2C],y
	sta.b $81
	and.b #$80
	lsr a
	lsr a
	ora.w $0011,x
	sta.w $0011,x
	lda.b $81
	and.b #$40
	lsr a
	ora.w $0010,x
	sta.w $0010,x
	lda.b $81
	and.b #$20
	ora.w $0001,x
	sta.w $0001,x
	lda.b $81
	and.b #$10
	asl a
	ora.w $0000,x
	sta.w $0000,x
	lda.b $81
	and.b #$08
	asl a
	ora.w $0011,x
	sta.w $0011,x
	lda.b $81
	and.b #$04
	asl a
	asl a
	ora.w $0010,x
	sta.w $0010,x
	lda.b $81
	and.b #$02
	asl a
	asl a
	asl a
	ora.w $0001,x
	sta.w $0001,x
	lda.b $81
	and.b #$01
	asl a
	asl a
	asl a
	asl a
	ora.w $0000,x
	sta.w $0000,x
	iny
	lda.b [$2C],y
	sta.b $81
	and.b #$80
	lsr a
	lsr a
	lsr a
	lsr a
	ora.w $0011,x
	sta.w $0011,x
	lda.b $81
	and.b #$40
	lsr a
	lsr a
	lsr a
	ora.w $0010,x
	sta.w $0010,x
	lda.b $81
	and.b #$20
	lsr a
	lsr a
	ora.w $0001,x
	sta.w $0001,x
	lda.b $81
	and.b #$10
	lsr a
	ora.w $0000,x
	sta.w $0000,x
	lda.b $81
	and.b #$08
	lsr a
	ora.w $0011,x
	sta.w $0011,x
	lda.b $81
	and.b #$04
	ora.w $0010,x
	sta.w $0010,x
	lda.b $81
	and.b #$02
	asl a
	ora.w $0001,x
	sta.w $0001,x
	lda.b $81
	and.b #$01
	asl a
	asl a
	ora.w $0000,x
	sta.w $0000,x
	iny
	lda.b [$2C],y
	sta.b $81
	and.b #$80
	rol a
	rol a
	rol a
	ora.w $0011,x
	sta.w $0011,x
	lda.b $81
	and.b #$40
	rol a
	rol a
	rol a
	rol a
	ora.w $0010,x
	sta.w $0010,x
	lda.b $81
	and.b #$20
	lsr a
	lsr a
	lsr a
	lsr a
	ora.w $0001,x
	sta.w $0001,x
	lda.b $81
	and.b #$10
	lsr a
	lsr a
	lsr a
	ora.w $0000,x
	sta.w $0000,x
	lda.b $81
	and.b #$08
	lsr a
	lsr a
	lsr a
	ora.w $0011,x
	sta.w $0011,x
	lda.b $81
	and.b #$04
	lsr a
	lsr a
	ora.w $0010,x
	sta.w $0010,x
	lda.b $81
	and.b #$02
	lsr a
	ora.w $0001,x
	sta.w $0001,x
	lda.b $81
	and.b #$01
	ora.w $0000,x
	sta.w $0000,x
	rep #$20
	txa
	clc
	adc.w #$0020
	tax
	iny
	dec.b $85
	beq CODE_C4EE73
	jmp.w CODE_C4ECCC
CODE_C4EE73:						; from CODE_C4ECCC
	txa
	sec
	sbc.w #$00BE
	tax
	cpx.w #$365E
	beq CODE_C4EE81
	jmp.w CODE_C4ECC7
CODE_C4EE81:						; from CODE_C4EE73
	ldx.w #$364E
	ldy.b $2C
	lda.w #$00BF
	mvn $7E,$7E
	sty.b $2C
	lda.b $7F
	sec
	sbc.w #$00C0
	sta.b $7F
	beq CODE_C4EE9B
	jmp.w CODE_C4ECC1
CODE_C4EE9B:						; from CODE_C4EE81
	pla
	rts
CODE_C4EE9D:						; from CODE_C4E196 and other segments
	lda.w #$0080
	sta.l VMAIN
	lda.w #$0004
	sta.b $7F
	txa
	sta.l VMADDL
CODE_C4EEAE:						; from CODE_C4EEAE
	jsr.w CODE_C4EEC0
	tay
	txa
	clc
	adc.w #$0020
	tax
	sta.l VMADDL
	dec.b $7F
	bpl CODE_C4EEAE
CODE_C4EEC0:						; from CODE_C4EEAE
	tya
	ldy.w #$0005
CODE_C4EEC4:						; from CODE_C4EEC4
	sta.l VMDATAL
	inc a
	dey
	bpl CODE_C4EEC4
	rts
CODE_C4EECD:						; from CODE_C4E534, CODE_C4E6D7
	stz.w $04F5
	stz.w $364E
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0370
	pea.w $007E
	lda.w #$0480
	jsl.l CODE_C4C547
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	ldx.b $9B
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	ldx.b $97
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	rts
CODE_C4EF07:						; from CODE_C4E4CB, CODE_C4E67C
	stz.w $04F5
	stz.w $364E
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0130
	pea.w $007E
	lda.w #$0480
	jsl.l CODE_C4C547
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	ldx.b $9D
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	ldx.b $99
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	rts
CODE_C4EF41:						; from CODE_C4E140, CODE_C4E188
	cmp.w #$001A
	beq CODE_C4EF8F
	lda.w #$CBDA
	sta.w $00AC,y
	lda.w #$05CE
	sta.w $00DE,y
	lda.w #$BA13
	sta.w $00D4,y
	lda.w #$00CD
	sta.w $0106,y
	lda.w #$9411
	sta.w $00D2,y
	lda.w #$01CD
	sta.w $0104,y
	lda.w #$BA13
	sta.w $00BA,y
	lda.w #$02CD
	sta.w $00EC,y
	lda.w #$5DAC
	sta.w $00B2,y
	lda.w #$03C0
	sta.w $00E4,y
	lda.w #$6E6D
	sta.w $00C2,y
	lda.w #$04C0
	sta.w $00F4,y
	rts
CODE_C4EF8F:						; from CODE_C4EF41
	lda.w #$6D00
	sta.w $00AC,y
	lda.w #$05CE
	sta.w $00DE,y
	lda.w #$5E35
	sta.w $00D4,y
	lda.w #$01CD
	sta.w $0106,y
	lda.w #$6D00
	sta.w $00CE,y
	lda.w #$00CE
	sta.w $0100,y
	lda.w #$B8A0
	sta.w $00B8,y
	lda.w #$03CE
	sta.w $00EA,y
	lda.w #$6D00
	sta.w $00B2,y
	lda.w #$03CE
	sta.w $00E4,y
	lda.w #$6FF6
	sta.w $00CC,y
	lda.w #$04CD
	sta.w $00FE,y
	rts
CODE_C4EFD8:						; called from other segments
	pei ($9F)
	pei ($A1)
	pei ($A3)
	pei ($A5)
	pei ($0A)
	pei ($0C)
	pei ($0E)
	pei ($10)
	pei ($12)
	pei ($14)
	pei ($2C)
	pei ($2E)
	jsr.w CODE_C4F01E
	pla
	sta.w $002E
	pla
	sta.w $002C
	pla
	sta.b $14
	pla
	sta.b $12
	pla
	sta.b $10
	pla
	sta.b $0E
	pla
	sta.b $0C
	pla
	sta.b $0A
	pla
	sta.w $00A5
	pla
	sta.w $00A3
	pla
	sta.w $00A1
	pla
	sta.w $009F
	rtl

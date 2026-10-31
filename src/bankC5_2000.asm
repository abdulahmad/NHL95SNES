; Segment bankC5_2000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C52008
CODE_C52008:						; called from other segments
	asl a
	tax
	lda.l $7E2024
	adc.l DATA8_C5202F,x
	tay
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0280
	lda.w $2026
	pha
	pea.w $007E
	phy
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rtl
DATA8_C5202F:						; not traced: a table read by CODE_C52008
	db $00,$00,$80,$02,$00,$05,$80,$07
CODE_C52037:						; called from other segments
	jsl.l forceblack
	sep #$20
	lda.b #$13
	sta.l TM
	rep #$20
	lda.w #$EEA5
	ldx.w #$00CC
	jsl.l CODE_C58812
	ldx.w #$2A7E
	clc
CODE_C52053:						; from CODE_C52053
	lda.w $50DC,x
	sta.l $7F9C7A,x
	dex
	dex
	bpl CODE_C52053
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $4100
	pea.w $0000
	pea.w $007E
	pea.w $7B5C
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $001E
	pea.w $0001
	pea.w $00C0
	pea.w $0EE7
	pea.w $0002
	pea.w $0000
	pea.w $00C0
	pea.w $4CA9
	pea.w $0040
	pea.w $0010
	pea.w $007E
	pea.w $BC5C
	lda.w $17C9
	pea.w $0020
	pea.w $0040
	pea.w $00C0
	xba
	lsr a
	lsr a
	adc.w #$3F22
	pha
	lda.w $17CB
	pea.w $0020
	pea.w $0030
	pea.w $00C0
	xba
	lsr a
	lsr a
	adc.w #$3F02
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	lda.w #$2030
	sta.b $A1
	lda.w #$2160
	sta.b $A3
	lda.w #$01BE
	jsl.l CODE_C5F368
	lda.w #$2168
	sta.b $A3
	lda.w #$01BF
	jsl.l CODE_C5F368
	lda.w #$2588
	sta.b $A3
	lda.w #$006F
	jsl.l CODE_C5F368
	lda.w #$2035
	sta.b $A1
	lda.w #$01B3
	jsl.l CODE_C5F368
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.w #$01E0
	pha
	jsl.l $C4C558
	pea.w $6360
	ldx.w #$007E
	phx
	stx.b $2E
	pha
	sta.b $2C
	lda.w #$4642
	ldx.w #$00C0
	jsl.l Decompress
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsl.l $C4CEDB
	lda.w #$792B
	ldx.w #$00C2
	jsl.l DecompressUnpackbuf
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0300
	pea.w $2080
	pea.w $007E
	lda.w $17C9
	asl a
	adc.w $17C9
	xba
	adc.w #$50DC
	pha
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0060
	pea.w $00C2
	lda.w $17C9
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.w #$ADCA
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l $C4CEDB
	lda.w #$CC6E
	ldx.w #$00C2
	jsl.l CODE_C58812
	ldx.w #$092E
	clc
CODE_C52195:						; from CODE_C52195
	lda.w $50DC,x
	adc.w #$3420
	sta.l $7FC6FA,x
	dex
	dex
	bpl CODE_C52195
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $18A0
	pea.w $2200
	pea.w $007E
	pea.w $5A0C
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0050
	pea.w $007E
	pea.w $72AC
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l $C4CEDB
	stz.w $07E6
	stz.w $07E4
	lda.w #$FE90
	sta.w $07F8
	ldy.w #$4800
	lda.w #$0976
	ldx.w #$00C0
	jsl.l DecompressToVRAM
	jsl.l CODE_C5897B
	jsl.l $C4CEDB
	lda.w #$FFFF
	sta.w $151B
	sta.w $151D
	sta.w $151F
	sta.w $1521
	sta.w $1523
	lda.w #$D02A
	sta.b $2C
	lda.w #$007F
	sta.b $2E
	lda.w #$4708
	ldx.w #$00C0
	jsl.l Decompress
	jsl.l CODE_C539D7
	jmp.w CODE_C53A29
CODE_C52227:						; called from other segments
	jsl.l forceblack
	lda.w #$03E7
	sta.w $07E4
	lda.w #$0001
	trb.w $10F5
	stz.b $CB
	stz.b $CD
	lda.b $5F
	dec a
	dec a
	sta.w $0812
	jsl.l $C3856E
	lda.w $10F1
	bit.w #$0002
	beq CODE_C5225E
	ldx.w #$0016
CODE_C52251:						; from CODE_C52251
	lda.w $0FE0,x
	eor.w #$0001
	sta.w $0FE0,x
	dex
	dex
	bpl CODE_C52251
CODE_C5225E:						; from CODE_C52227
	stz.w $2CF5
	jmp.w CODE_C539D7
CODE_C52264:						; called from other segments
	stz.w $2CF5
	ldx.b $6F
	rtl
CODE_C5226A:						; called from other segments
	lda.w $09BC
	pha
	asl a
	pla
	ror a
	sta.w $09BC
	lda.w $09DC
	pha
	asl a
	pla
	ror a
	sta.w $09DC
	inc.w $2CF5
	ldx.b $6F
	rtl
CODE_C52284:						; called from other segments
	lda.b $CD
	sta.w $080C
	lda.b $CB
	sta.w $080A
	lda.w #$0040
	tsb.w $10F5
	rtl
CODE_C52295:						; called from other segments
	jsl.l AnimateSprites
	jsl.l CODE_C526E8
	jsl.l CODE_C526FB
	jsl.l $C382B8
	jsl.l CODE_C522BF
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	inc.w TransfersReady
	jsl.l $C38CF5
	jsl.l CODE_C528D5
	ldx.b $6F
	rtl
CODE_C522BF:						; from CODE_C52295 and other segments
	dec.b QueueBusy
	tsc
	sta.b $1C
	lda.b $28
	tcs
	ldy.w $1511
	bmi CODE_C522DF
	ldx.w #$22DF
	bra CODE_C52348
DATA8_C522D1:						; not traced: data between routines
	db $1B,$15,$2A,$D0,$A0,$25,$45,$24,$00,$7A,$00,$7B,$50,$64
CODE_C522DF:						; from CODE_C522BF
	ldy.w $1513
	bmi CODE_C522F7
	ldx.w #$22F7
	bra CODE_C52348
DATA8_C522E9:						; not traced: data between routines
	db $1D,$15,$CA,$D2,$A2,$25,$48,$24,$20,$7A,$20,$7B,$80,$64
CODE_C522F7:						; from CODE_C522DF
	ldy.w $1515
	bmi CODE_C5230F
	ldx.w #$230F
	bra CODE_C52348
DATA8_C52301:						; not traced: data between routines
	db $1F,$15,$6A,$D5,$A4,$25,$4B,$24,$40,$7A,$40,$7B,$B0,$64
CODE_C5230F:						; from CODE_C522F7
	ldy.w $1517
	bmi CODE_C52327
	ldx.w #$2327
	bra CODE_C52348
DATA8_C52319:						; not traced: data between routines
	db $21,$15,$2A,$D0,$A6,$27,$4E,$26,$60,$7A,$60,$7B,$E0,$64
CODE_C52327:						; from CODE_C5230F
	ldy.w $1519
	bmi CODE_C5233F
	ldx.w #$233F
	bra CODE_C52348
DATA8_C52331:						; not traced: data between routines
	db $23,$15,$CA,$D2,$A8,$27,$51,$26,$80,$7A,$80,$7B,$10,$65
CODE_C5233F:						; from CODE_C52327
	tsc
	sta.b $28
	lda.b $1C
	tcs
	stz.b QueueBusy
	rtl
CODE_C52348:						; from CODE_C522BF, CODE_C522DF, CODE_C522F7, CODE_C5230F, ...
	stx.b $A5
	lda.w $0814,y
	clc
	adc.w #$0080
	sec
	sbc.b $CB
	sta.b $0A
	sec
	lda.b $CD
	sbc.w $0896,y
	clc
	adc.w #$005E
	sta.b $0C
	bmi CODE_C5237E
	cmp.w #$00E0
	bcc CODE_C5236C
	jmp.w CODE_C523EE
CODE_C5236C:						; from CODE_C52348
	lda.b $0A
	bpl CODE_C52373
	jmp.w CODE_C524C7
CODE_C52373:						; from CODE_C5236C
	cmp.w #$0100
	bcc CODE_C5237B
	jmp.w CODE_C52464
CODE_C5237B:						; from CODE_C52373
	jmp ($00A5)
CODE_C5237E:						; from CODE_C52348
	lda.l $C4FFF6,x
	sta.b $A3
	lda.l $C4FFF8,x
	sta.b $A1
	lda.b $0A
	bpl CODE_C52391
	jmp.w CODE_C52530
CODE_C52391:						; from CODE_C5237E
	cmp.w #$0100
	bcc CODE_C52399
	jmp.w CODE_C52571
CODE_C52399:						; from CODE_C52391
	lda.l $C4FFF2,x
	tay
	lda.w $0000,y
	beq CODE_C523AC
	lda.w #$0000
	sta.w $0000,y
	jsr.w CODE_C52628
CODE_C523AC:						; from CODE_C52399
	lda.b $0A
	cmp.w #$00E9
	bcc CODE_C523B6
	lda.w #$00E8
CODE_C523B6:						; from CODE_C523AC
	cmp.w #$0009
	bcs CODE_C523BE
	lda.w #$0009
CODE_C523BE:						; from CODE_C523B6
	ora.w #$0800
	sta.b $0A
	clc
	pei ($A3)
	pha
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b $A1
	phy
	lda.b $0A
	adc.w #$0510
	pha
	iny
	phy
	adc.w #$02E8
	pha
	iny
	phy
	adc.w #$080C
	pha
	jmp ($00A5)
CODE_C523EE:						; from CODE_C52348
	lda.l $C4FFF6,x
	ora.w #$8000
	sta.b $A3
	lda.l $C4FFF8,x
	ora.w #$8000
	sta.b $A1
	lda.b $0A
	bpl CODE_C52407
	jmp.w CODE_C525AC
CODE_C52407:						; from CODE_C523EE
	cmp.w #$0100
	bcc CODE_C5240F
	jmp.w CODE_C525ED
CODE_C5240F:						; from CODE_C52407
	lda.l $C4FFF2,x
	tay
	lda.w $0000,y
	beq CODE_C52422
	lda.w #$0000
	sta.w $0000,y
	jsr.w CODE_C52628
CODE_C52422:						; from CODE_C5240F
	lda.b $0A
	cmp.w #$00E9
	bcc CODE_C5242C
	lda.w #$00E8
CODE_C5242C:						; from CODE_C52422
	cmp.w #$0009
	bcs CODE_C52434
	lda.w #$0009
CODE_C52434:						; from CODE_C5242C
	ora.w #$C800
	sta.b $0A
	clc
	pei ($A3)
	pha
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b $A1
	phy
	lda.b $0A
	adc.w #$0310
	pha
	iny
	phy
	adc.w #$FCE8
	pha
	iny
	phy
	adc.w #$F80B
	pha
	jmp ($00A5)
CODE_C52464:						; from CODE_C52373
	lda.l $C4FFF6,x
	sta.b $A3
	lda.l $C4FFF8,x
	sta.b $A1
	lda.l $C4FFF2,x
	tay
	lda.w #$0002
	cmp.w $0000,y
	beq CODE_C52484
	sta.w $0000,y
	clc
	jsr.w CODE_C526A7
CODE_C52484:						; from CODE_C52464
	lda.b $0C
	cmp.w #$0009
	bcs CODE_C5248E
	lda.w #$0009
CODE_C5248E:						; from CODE_C52484
	cmp.w #$00C8
	bcc CODE_C52496
	lda.w #$00C7
CODE_C52496:						; from CODE_C5248E
	xba
	ora.w #$00E8
	sta.b $0C
	clc
	pei ($A3)
	pha
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b $A1
	phy
	lda.b $0C
	adc.w #$F803
	pha
	iny
	phy
	adc.w #$17FF
	pha
	iny
	phy
	adc.w #$F3F5
	pha
	jmp ($00A5)
CODE_C524C7:						; from CODE_C5236C
	lda.l $C4FFF6,x
	ora.w #$4000
	sta.b $A3
	lda.l $C4FFF8,x
	ora.w #$4000
	sta.b $A1
	lda.l $C4FFF2,x
	tay
	lda.w #$0002
	cmp.w $0000,y
	beq CODE_C524ED
	sta.w $0000,y
	clc
	jsr.w CODE_C526A7
CODE_C524ED:						; from CODE_C524C7
	lda.b $0C
	cmp.w #$0009
	bcs CODE_C524F7
	lda.w #$0009
CODE_C524F7:						; from CODE_C524ED
	cmp.w #$00C8
	bcc CODE_C524FF
	lda.w #$00C7
CODE_C524FF:						; from CODE_C524F7
	xba
	ora.w #$0008
	sta.b $0C
	clc
	pei ($A3)
	pha
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b $A1
	phy
	lda.b $0C
	adc.w #$F805
	pha
	iny
	phy
	adc.w #$17FF
	pha
	iny
	phy
	adc.w #$F40B
	pha
	jmp ($00A5)
CODE_C52530:						; from CODE_C5237E
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq CODE_C52544
	sta.w $0000,y
	jsr.w CODE_C52666
CODE_C52544:						; from CODE_C52530
	lda.w #$4000
	tsb.b $A1
	ora.b $A3
	pha
	pea.w $0908
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b $A1
	phy
	pea.w $0418
	iny
	phy
	pea.w $1903
	iny
	phy
	pea.w $1514
	jmp ($00A5)
CODE_C52571:						; from CODE_C52391
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq CODE_C52585
	sta.w $0000,y
	jsr.w CODE_C52666
CODE_C52585:						; from CODE_C52571
	pei ($A3)
	pea.w $09E8
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b $A1
	phy
	pea.w $04E0
	iny
	phy
	pea.w $19F5
	iny
	phy
	pea.w $15E4
	jmp ($00A5)
CODE_C525AC:						; from CODE_C523EE
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq CODE_C525C0
	sta.w $0000,y
	jsr.w CODE_C52666
CODE_C525C0:						; from CODE_C525AC
	lda.w #$4000
	tsb.b $A1
	ora.b $A3
	pha
	pea.w $C708
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b $A1
	phy
	pea.w $D418
	iny
	phy
	pea.w $BF03
	iny
	phy
	pea.w $C314
	jmp ($00A5)
CODE_C525ED:						; from CODE_C52407
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq CODE_C52601
	sta.w $0000,y
	jsr.w CODE_C52666
CODE_C52601:						; from CODE_C525ED
	pei ($A3)
	pea.w $C7E8
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b $A1
	phy
	pea.w $D4E0
	iny
	phy
	pea.w $BFF5
	iny
	phy
	pea.w $C3E4
	jmp ($00A5)
CODE_C52628:						; from CODE_C52399, CODE_C5240F
	tsc
	sta.b $28
	lda.b $00
	tcs
	pea.w $0040
	lda.l $C4FFFA,x
	pha
	pea.w $007F
	lda.l $C4FFF4,x
	pha
	tay
	pea.w $0040
	lda.l $C4FFFC,x
	pha
	pea.w $007F
	tya
	adc.w #$0040
	pha
	adc.w #$0040
	tay
	pea.w $0060
	lda.l $C4FFFE,x
	pha
	pea.w $007F
	phy
	tsc
	sta.b $00
	lda.b $28
	tcs
	rts
CODE_C52666:						; from CODE_C52530, CODE_C525AC, CODE_C52571, CODE_C525ED
	tsc
	sta.b $28
	lda.b $00
	tcs
	pea.w $0040
	lda.l $C4FFFA,x
	pha
	pea.w $007F
	lda.l $C4FFF4,x
	adc.w #$00E0
	pha
	tay
	pea.w $0040
	lda.l $C4FFFC,x
	pha
	pea.w $007F
	tya
	adc.w #$0040
	pha
	adc.w #$0040
	tay
	pea.w $0060
	lda.l $C4FFFE,x
	pha
	pea.w $007F
	phy
	tsc
	sta.b $00
	lda.b $28
	tcs
	rts
CODE_C526A7:						; from CODE_C524C7, CODE_C52464
	tsc
	sta.b $28
	lda.b $00
	tcs
	pea.w $0040
	lda.l $C4FFFA,x
	pha
	pea.w $007F
	lda.l $C4FFF4,x
	adc.w #$01C0
	pha
	tay
	pea.w $0040
	lda.l $C4FFFC,x
	pha
	pea.w $007F
	tya
	adc.w #$0040
	pha
	adc.w #$0040
	tay
	pea.w $0060
	lda.l $C4FFFE,x
	pha
	pea.w $007F
	phy
	tsc
	sta.b $00
	lda.b $28
	tcs
	rts
CODE_C526E8:						; from CODE_C52295 and other segments
	sec
	lda.b $CB
	sbc.w #$0080
	sta.w $07B2
	sec
	lda.w #$FF90
	sbc.b $CD
	sta.w $07F8
	rtl
CODE_C526FB:						; from CODE_C52295 and other segments
	dec.b QueueBusy
	tsc
	sta.b $1C
	lda.b $28
	tcs
	ldy.w #$000C
CODE_C52706:						; from CODE_C52832
	sty.b $10
	lda.w $05AE,y
	cmp.w #$000F
	bne CODE_C52713
	jmp.w CODE_C52832
CODE_C52713:						; from CODE_C52706
	php
	asl a
	tax
	lda.w $0814,x
	adc.w #$0074
	sec
	sbc.b $CB
	sta.b $0A
	sec
	lda.b $CD
	sbc.w $0896,x
	clc
	adc.w #$006A
	sta.b $0C
	plp
	bcc CODE_C52733
	jmp.w CODE_C52842
CODE_C52733:						; from CODE_C52713
	lda.w $0A20,x
	and.w #$0007
	asl a
	sta.b $0E
	bne CODE_C52745
	lda.b $0A
	adc.w #$0004
	sta.b $0A
CODE_C52745:						; from CODE_C52733
	lda.w $0EE0,x
	tax
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$2436
	sta.b $A1
	txa
	and.w #$000F
	adc.w #$2436
	sta.b $A3
	lda.w #CODE_C52766
	sta.b $A5
	jmp.w CODE_C52898
CODE_C52766:						; a continuation: CODE_C52898 jumps back here through a pointer
	clc
	lda.b $0A
	adc.w #$0008
	sta.b $0A
	lda.b $A3
	sta.b $A1
	lda.w #CODE_C5277A
	sta.b $A5
	jmp.w CODE_C52898
CODE_C5277A:						; a continuation: CODE_C52898 jumps back here through a pointer
	clc
	lda.b $0A
	adc.w #$0008
	sta.b $0A
	ldx.b $0E
	beq CODE_C52794
	lda.l DATA8_C5288A,x
	sta.b $A1
	lda.w #CODE_C52794
	sta.b $A5
	jmp.w CODE_C52898
CODE_C52794:						; a continuation: CODE_C52898 jumps back here through a pointer
	sec
	lda.b $0C
	sbc.w #$0014
	sta.b $0C
	sec
	lda.b $0A
	sbc.w #$0004
	ldx.b $0E
	bne CODE_C527A9
	sbc.w #$0004
CODE_C527A9:						; from CODE_C52794
	sta.b $0A
	ldx.b $10
	cpx.w #$000C
	bne CODE_C527B5
	jmp.w CODE_C52852
CODE_C527B5:						; from CODE_C527A9
	lda.l DATA8_C52880,x
	sta.b $A3
	ldy.b $2A
	pei ($A3)
	ldx.w #$0002
	clc
	lda.w #$FFF0
	adc.b $0A
	bpl CODE_C527D3
	cmp.w #$FFF1
	bcc CODE_C527E6
	inx
	and.w #$00FF
CODE_C527D3:						; from CODE_C527B5
	cmp.w #$0100
	bcs CODE_C527E6
	sta.b $9F
	lda.b $0C
	bpl CODE_C527E9
	cmp.w #$FFF1
	and.w #$00FF
	bcs CODE_C527EE
CODE_C527E6:						; from CODE_C527B5, CODE_C527D3, CODE_C527E9
	pla
	bra CODE_C527F5
CODE_C527E9:						; from CODE_C527D3
	cmp.w #$00E0
	bcs CODE_C527E6
CODE_C527EE:						; from CODE_C527D3
	xba
	ora.b $9F
	pha
	stx.b $00,y
	iny
CODE_C527F5:						; from CODE_C527E6
	clc
	lda.b $A3
	adc.w #$4000
	pha
	ldx.w #$0002
	lda.b $0A
	bpl CODE_C5280C
	cmp.w #$FFF1
	bcc CODE_C5281F
	inx
	and.w #$00FF
CODE_C5280C:						; from CODE_C527F5
	cmp.w #$0100
	bcs CODE_C5281F
	sta.b $9F
	lda.b $0C
	bpl CODE_C52822
	cmp.w #$FFF1
	and.w #$00FF
	bcs CODE_C52827
CODE_C5281F:						; from CODE_C527F5, CODE_C5280C, CODE_C52822
	pla
	bra CODE_C5282E
CODE_C52822:						; from CODE_C5280C
	cmp.w #$00E0
	bcs CODE_C5281F
CODE_C52827:						; from CODE_C5280C
	xba
	ora.b $9F
	pha
	stx.b $00,y
	iny
CODE_C5282E:						; from CODE_C5281F
	sty.b $2A
	ldy.b $10
CODE_C52832:						; from CODE_C52706, CODE_C5287A
	dey
	dey
	bmi CODE_C52839
	jmp.w CODE_C52706
CODE_C52839:						; from CODE_C52832
	tsc
	sta.b $28
	lda.b $1C
	tcs
	stz.b QueueBusy
	rtl
CODE_C52842:						; from CODE_C52713
	lda.b $0A
	clc
	adc.w #$000C
	sta.b $0A
	lda.b $0C
	sec
	sbc.w #$0014
	sta.b $0C
CODE_C52852:						; from CODE_C527A9
	lda.w #$2454
	sta.b $A1
	lda.w #$25E0
	sta.b $A3
	lda.b $0A
	clc
	adc.w #$0028
	sta.b $0A
	lda.b $0C
	clc
	adc.w #$0010
	sta.b $0C
	lda.w #$EE21
	sta.b $A5
	ldy.b $2A
	lda.w #$0072
	jml.l $CFEE6C
CODE_C5287A:						; called from other segments
	sty.b $2A
	ldy.b $10
	bra CODE_C52832
DATA8_C52880:						; not traced: a table read by CODE_C527B5
	db $88,$25,$8C,$25,$8E,$25,$8A,$25,$8C,$27
DATA8_C5288A:						; not traced: a table read by CODE_C5277A
	db $8E,$27,$40,$24,$40,$24,$41,$24,$42,$24,$43,$24,$44,$24
CODE_C52898:						; from CODE_C52766, CODE_C5277A, CODE_C52745
	ldy.b $2A
	pei ($A1)
	ldx.w #$0000
	lda.b $0A
	bpl CODE_C528AC
	cmp.w #$FFF9
	bcc CODE_C528BF
	inx
	and.w #$00FF
CODE_C528AC:						; from CODE_C52898
	cmp.w #$0100
	bcs CODE_C528BF
	sta.b $9F
	lda.b $0C
	bpl CODE_C528C2
	cmp.w #$FFF9
	and.w #$00FF
	bcs CODE_C528C7
CODE_C528BF:						; from CODE_C52898, CODE_C528AC, CODE_C528C2
	pla
	bra CODE_C528CE
CODE_C528C2:						; from CODE_C528AC
	cmp.w #$00E0
	bcs CODE_C528BF
CODE_C528C7:						; from CODE_C528AC
	xba
	ora.b $9F
	pha
	stx.b $00,y
	iny
CODE_C528CE:						; from CODE_C528BF
	sty.b $2A
	jmp ($00A5)
CODE_C528D3:						; called from other segments
	rtl
CODE_C528D4:						; called from other segments
	rtl
CODE_C528D5:						; from CODE_C52295 and other segments
	lda.w $07F8
	clc
	adc.w #$0170
	sta.w $04C2
	lsr a
	lsr a
	lsr a
	tax
	sec
	sbc.w $07E4
	bne CODE_C528EC
	jmp.w CODE_C529CC
CODE_C528EC:						; from CODE_C528D5
	bpl CODE_C52926
	eor.w #$FFFF
	inc a
	cmp.w #$0019
	bcs CODE_C52911
	and.w #$001F
	sta.b $A1
	stx.w $07E4
	lda.w $07E6
	sec
	sbc.b $A1
	and.w #$001F
	sta.w $07E6
	sta.b $A3
	stx.b $9F
	bra CODE_C5294E
CODE_C52911:						; from CODE_C528EC, CODE_C52926
	lda.w #$001D
	sta.b $A1
	txa
	and.w #$001F
	sta.w $07E6
	sta.b $A3
	stx.b $9F
	stx.w $07E4
	bra CODE_C5294E
CODE_C52926:						; from CODE_C528EC
	stx.w $07E4
	cmp.w #$0019
	bcs CODE_C52911
	sta.b $A1
	adc.w $07E6
	and.w #$001F
	sta.w $07E6
	adc.w #$001D
	sec
	sbc.b $A1
	and.w #$001F
	sta.b $A3
	txa
	clc
	adc.w #$001D
	sec
	sbc.b $A1
	sta.b $9F
CODE_C5294E:						; from CODE_C528EC, CODE_C52911
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.w #$0020
	sec
	sbc.b $A3
	tax
	sbc.b $A1
	bpl CODE_C5299A
	eor.w #$FFFF
	inc a
	sta.b $A1
	txa
	xba
	lsr a
	lsr a
	pha
	stx.b $A5
	tax
	lda.b $A3
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$5000
	pha
	pea.w $007F
	adc.w #$0400
	tay
	lda.b $9F
	xba
	lsr a
	lsr a
	adc.w #$9C7A
	pha
	phx
	phy
	pea.w $007F
	adc.w #$1540
	pha
	stz.b $A3
	lda.b $9F
	adc.b $A5
	sta.b $9F
CODE_C5299A:						; from CODE_C5294E
	lda.b $A1
	xba
	lsr a
	lsr a
	pha
	tax
	lda.b $A3
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$5000
	pha
	pea.w $007F
	adc.w #$0400
	tay
	lda.b $9F
	xba
	lsr a
	lsr a
	adc.w #$9C7A
	pha
	phx
	phy
	pea.w $007F
	adc.w #$1540
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
CODE_C529CC:						; from CODE_C528D5
	lda.w $07B2
	clc
	adc.w #$00C0
	sta.w $04C0
	rtl
CODE_C529D7:						; called from other segments
	lda.w $080C
	sta.b $87
	lda.w $080A
	sta.b $8B
	lda.w $10F5
	bit.w #$0040
	bne CODE_C52A49
	ldx.w #$001C
	lda.w $05A0
	bmi CODE_C52A22
	tax
	lda.w $0FE0,x
	beq CODE_C52A0D
	lda.w $080E
	adc.w $07A4
	sta.w $080E
	cmp.w #$0020
	bmi CODE_C52A22
	lda.w #$0020
	sta.w $080E
	bra CODE_C52A22
CODE_C52A0D:						; from CODE_C529D7
	lda.w $080E
	sec
	sbc.w $07A4
	sta.w $080E
	cmp.w #$FFE1
	bpl CODE_C52A22
	lda.w #$FFE0
	sta.w $080E
CODE_C52A22:						; from CODE_C529D7, CODE_C52A0D
	lda.w $09C0,x
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0100
	beq CODE_C52A34
	ora.w #$FE00
CODE_C52A34:						; from CODE_C52A22
	clc
	adc.w $0896,x
	clc
	adc.w $080E
	sta.b $87
	sta.w $080C
	lda.w $0814,x
	sta.b $8B
	sta.w $080A
CODE_C52A49:						; from CODE_C529D7
	lda.b $87
	sec
	sbc.b $CD
	sta.b $7F
	cmp.w #$FFF7
	bpl CODE_C52A69
	lda.b $87
	sec
	sbc.w #$FFF6
	sta.b $83
	cmp.w #$FF39
	bpl CODE_C52A82
	lda.w #$FF39
	sta.b $83
	bra CODE_C52A82
CODE_C52A69:						; from CODE_C52A49
	lda.b $7F
	cmp.w #$000B
	bmi CODE_C52AA0
	lda.b $87
	sec
	sbc.w #$000A
	sta.b $83
	cmp.w #$0100
	bmi CODE_C52A82
	lda.w #$0100
	sta.b $83
CODE_C52A82:						; from CODE_C52A49, CODE_C52A69
	lda.b $83
	sec
	sbc.b $CD
	beq CODE_C52AA0
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0800
	beq CODE_C52A95
	ora.w #$F000
CODE_C52A95:						; from CODE_C52A82
	cmp.w #$0000
	bne CODE_C52A9B
	inc a
CODE_C52A9B:						; from CODE_C52A95
	clc
	adc.b $CD
	sta.b $CD
CODE_C52AA0:						; from CODE_C52A69, CODE_C52A82
	lda.b $8B
	sec
	sbc.b $CB
	sta.b $7F
	cmp.w #$FFD8
	bpl CODE_C52AC0
	lda.b $8B
	sec
	sbc.w #$FFD8
	sta.b $83
	cmp.w #$FFC8
	bpl CODE_C52AD9
	lda.w #$FFC8
	sta.b $83
	bra CODE_C52AD9
CODE_C52AC0:						; from CODE_C52AA0
	lda.b $7F
	cmp.w #$0029
	bmi CODE_C52AF7
	lda.b $8B
	sec
	sbc.w #$0028
	sta.b $83
	cmp.w #$0039
	bmi CODE_C52AD9
	lda.w #$0038
	sta.b $83
CODE_C52AD9:						; from CODE_C52AA0, CODE_C52AC0
	lda.b $83
	sec
	sbc.b $CB
	beq CODE_C52AF7
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0800
	beq CODE_C52AEC
	ora.w #$F000
CODE_C52AEC:						; from CODE_C52AD9
	cmp.w #$0000
	bne CODE_C52AF2
	inc a
CODE_C52AF2:						; from CODE_C52AEC
	clc
	adc.b $CB
	sta.b $CB
CODE_C52AF7:						; from CODE_C52AC0, CODE_C52AD9
	rtl
CODE_C52AF8:						; called from other segments
	jsl.l $C38043
	dec.b $8F
	dec.b $8F
	lda.b $8B
	bit.w #$1000
	beq CODE_C52B0D
	lda.b $8F
	jmp.w CODE_C50D24
CODE_C52B0C:						; from CODE_C52B18
	rtl
CODE_C52B0D:						; from CODE_C52AF8
	lda.w $10F5
	bit.w #$0100
	beq CODE_C52B18
	jmp.w CODE_C52B9B
CODE_C52B18:						; from CODE_C52B0D
	lda.w $0644,x
	cmp.w #$7D2E
	beq CODE_C52B0C
	phy
	ldy.w #$0000
	lda.w $1020,x
	beq CODE_C52B2C
	ldy.w #$0002
CODE_C52B2C:						; from CODE_C52B18
	lda.w $184C,y
	ply
	cmp.w #$0000
	bmi CODE_C52B39
	cmp.b $8F
	bne CODE_C52B4E
CODE_C52B39:						; from CODE_C52B2C
	phy
	ldy.w #$0000
	lda.w $1020,x
	beq CODE_C52B45
	ldy.w #$0002
CODE_C52B45:						; from CODE_C52B39
	lda.w $12FF,y
	ply
	bit.w #$0008
	bne CODE_C52B9F
CODE_C52B4E:						; from CODE_C52B2C
	lda.b $83
	bit.w #$2000
	bne CODE_C52BC5
	cpx.w $05A0
	bne CODE_C52B5D
	jmp.w CODE_C52BFA
CODE_C52B5D:						; from CODE_C52B4E
	lda.b $83
	bit.w #$4000
	bne CODE_C52BA3
	lda.w $1000,x
	bne CODE_C52B98
	lda.b $83
	bit.w #$0040
	bne CODE_C52BE6
	bit.w #$8000
	bne CODE_C52BA7
	lda.w $0A20,x
	beq CODE_C52BB3
	lda.b $83
	bit.w #$0020
	bne CODE_C52BAB
	bit.w #$0010
	bne CODE_C52BAF
	lda.w $07CC
	cmp.b $B7
	beq CODE_C52B98
	lda.b $83
	bit.w #$0080
	bne CODE_C52BE2
	jml.l CODE_C4694F
CODE_C52B98:						; from CODE_C52B5D, CODE_C52BFA
	jmp.w CODE_C52C5E
CODE_C52B9B:						; from CODE_C52B0D
	jml.l CODE_C51C58
CODE_C52B9F:						; from CODE_C52B45
	jml.l CODE_C54541
CODE_C52BA3:						; from CODE_C52B5D
	jml.l CODE_C45610
CODE_C52BA7:						; from CODE_C52B5D
	jml.l CODE_C537C4
CODE_C52BAB:						; from CODE_C52B5D
	jml.l CODE_C53921
CODE_C52BAF:						; from CODE_C52B5D
	jml.l CODE_C53903
CODE_C52BB3:						; from CODE_C52B5D, CODE_C52C5A
	lda.w $05CC,x
	bit.w #$0001
	bne CODE_C52BC0
	and.w #$0002
	bne CODE_C52BC4
CODE_C52BC0:						; from CODE_C52BB3
	jml.l CODE_C4694F
CODE_C52BC4:						; from CODE_C52BC5, CODE_C52BD5, CODE_C52BFA, CODE_C52BF1, ...
	rtl
CODE_C52BC5:						; from CODE_C52B4E
	lda.w $10F3
	bne CODE_C52BC4
	ldy.w #$0000
	lda.w $1020,x
	beq CODE_C52BD5
	ldy.w #$0002
CODE_C52BD5:						; from CODE_C52BC5
	lda.w $184C,y
	bpl CODE_C52BC4
	lda.b $8F
	sta.w $184C,y
	jmp.w CODE_C5404A
CODE_C52BE2:						; from CODE_C52B5D
	jml.l CODE_C42D10
CODE_C52BE6:						; from CODE_C52B5D, CODE_C52C5E
	ldy.w #$0000
	cpx.w #$000C
	bmi CODE_C52BF1
	ldy.w #$0002
CODE_C52BF1:						; from CODE_C52BE6
	lda.w $17C1,y
	beq CODE_C52BC4
	jml.l CODE_C538FE
CODE_C52BFA:						; from CODE_C52B4E
	lda.w $1000,x
	bne CODE_C52B98
	jsl.l $C4837C
	lda.w $0A20,x
	bne CODE_C52C0D
	lda.w $1060,x
	bne CODE_C52BC4
CODE_C52C0D:						; from CODE_C52BFA
	lda.w $10F5
	bit.w #$0004
	bne CODE_C52C3D
	bit.w #$0008
	bne CODE_C52C41
	lda.w $066A
	cmp.b $B7
	beq CODE_C52C5D
	lda.b $83
	bit.w #$8000
	bne CODE_C52C4E
	bit.w #$4000
	bne CODE_C52C45
	lda.w $0A20,x
	beq CODE_C52C5A
	lda.b $83
	bit.w #$0080
	bne CODE_C52C56
	jml.l CODE_C4694F
CODE_C52C3D:						; from CODE_C52C0D
	jml.l $C4A0C1
CODE_C52C41:						; from CODE_C52C0D
	jml.l $C498D3
CODE_C52C45:						; from CODE_C52C0D
	lda.w #$0014
	sta.b $7F
	jml.l CODE_C43734
CODE_C52C4E:						; from CODE_C52C0D
	jml.l $C49DC7
CODE_C52C52:						; from CODE_C52C5E
	jml.l CODE_C537C4
CODE_C52C56:						; from CODE_C52C0D
	jml.l $C49858
CODE_C52C5A:						; from CODE_C52C0D
	jmp.w CODE_C52BB3
CODE_C52C5D:						; from CODE_C52C0D, CODE_C52C5E, CODE_C52C72
	rtl
CODE_C52C5E:						; from CODE_C52B98
	cpx.w $05A0
	beq CODE_C52C5D
	lda.b $83
	bit.w #$8000
	bne CODE_C52C52
	bit.w #$0040
	beq CODE_C52C72
	jmp.w CODE_C52BE6
CODE_C52C72:						; from CODE_C52C5E
	bit.w #$0080
	beq CODE_C52C5D
	ldy.w $07CC
	bmi CODE_C52C5D
	lda.w $0D60,y
	and.w #$1000
	ora.w $1000,y
	bne CODE_C52C5D
	lda.w $14F9,y
	bpl CODE_C52C5D
	lda.w $1020,y
	cmp.w $1020,x
	bne CODE_C52C5D
	sty.b $7F
	inc.w $0672
	lda.w #$7FFF
	sta.w $0674
	jml.l CODE_C53776
CODE_C52CA3:						; called from other segments
	jsr.w CODE_C52CC1
	rtl
CODE_C52CA7:						; called from other segments
	ldx.w $1872
	phx
	stz.w $1872
	ldx.w $1864
	phx
	stz.w $1864
	jsr.w CODE_C52CD0
	pla
	sta.w $1864
	pla
	sta.w $1872
	rtl
CODE_C52CC1:						; from CODE_C52CA3 and other segments
	lda.w $17C9
	ldy.w #$2DC9
	jsr.w CODE_C52CD0
	lda.w $17CB
	ldy.w #$3207
CODE_C52CD0:						; from CODE_C52CA7, CODE_C52CC1
	sta.b $9F
	sty.b $A1
	ldx.w $18E0
	phx
	tax
	jsl.l $C4C541
	txa
	ldx.w $1864
	cpx.w #$0003
	beq CODE_C52CEB
	cpx.w #$0002
	bne CODE_C52CF0
CODE_C52CEB:						; from CODE_C52CD0, CODE_C52CF0
	jsr.w CODE_C531C7
	bra CODE_C52D69
CODE_C52CF0:						; from CODE_C52CD0
	ldx.w $1872
	bne CODE_C52CEB
	asl a
	tax
	lda.l $C30000,x
	tax
	phx
	adc.l $C30006,x
	tax
	lda.l $C30003,x
	pha
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	sta.w $0004,y
	pla
	and.w #$000F
	sta.w $0006,y
	jsr.w CODE_C53167
	plx
	lda.l $C30000,x
	sta.b $0E
	and.w #$F800
	xba
	lsr a
	lsr a
	lsr a
	sta.b $10
	sta.w $0000,y
	txa
	clc
	adc.l $C30008,x
	tax
	lda.l $C30000,x
	xba
	ldx.w #$0000
CODE_C52D3D:						; from CODE_C52D3D
	inx
	asl a
	asl a
	asl a
	asl a
	bne CODE_C52D3D
	txa
	sta.w $0002,y
	lda.b $0E
	and.w #$07FF
	tax
CODE_C52D4E:						; from CODE_C52D4E
	lda.l $C30000,x
	and.w #$3FFF
	sta.w $0008,y
	sec
	txa
	sbc.w #$0038
	lsr a
	sta.w $003A,y
	inx
	inx
	iny
	iny
	dec.b $10
	bne CODE_C52D4E
CODE_C52D69:						; from CODE_C52CEB
	ldy.b $A1
	lda.b $9F
	asl a
	tax
	lda.l $C30000,x
	tax
	phx
	clc
	adc.l $C3000A,x
	tax
	sep #$20
	stz.b $A3
CODE_C52D7F:						; from CODE_C52D7F
	lda.l $C30000,x
	sta.w $006C,y
	inx
	iny
	lda.b $A3
	inc a
	sta.b $A3
	cmp.b #$08
	bne CODE_C52D7F
	rep #$20
	plx
	txa
	clc
	adc.l $C30004,x
	tax
	sep #$20
CODE_C52D9D:						; from CODE_C52D9D
	lda.l $C30000,x
	sta.w $006C,y
	inx
	iny
	lda.b $A3
	inc a
	sta.b $A3
	cmp.b #$40
	bne CODE_C52D9D
	rep #$20
	ldy.b $A1
	lda.w $0000,y
	inc a
	sta.b $A5
	lda.w $0002,y
	inc a
	sta.b $0A
	clc
	adc.w $0004,y
	sta.b $0C
	stz.b $A3
CODE_C52DC7:						; from CODE_C52DC7
	sep #$20
	lda.w $006D,y
	jsr.w CODE_C5308D
	sta.w $006D,y
	lda.w $006E,y
	jsr.w CODE_C5308D
	sta.w $006E,y
	lda.w $006F,y
	jsr.w CODE_C530A0
	sta.w $006F,y
	lda.w $0070,y
	jsr.w CODE_C530A0
	sta.w $0070,y
	lda.w $0071,y
	jsr.w CODE_C530A0
	sta.w $0071,y
	rep #$20
	tya
	clc
	adc.w #$0008
	tay
	lda.b $A3
	inc a
	sta.b $A3
	cmp.w #$0007
	bne CODE_C52DC7
	lda.b ($A1)
	sta.b $A3
	ldy.b $A1
CODE_C52E0E:						; from CODE_C52EF9
	lda.w $003A,y
	cmp.w #$026A
	bcc CODE_C52E1C
	pea.w $0000
	jmp.w CODE_C52EC7
CODE_C52E1C:						; from CODE_C52E0E
	ldx.w #$0038
CODE_C52E1F:						; from CODE_C52EF0
	phx
	lda.l $C2FFFE,x
	pha
	jsr.w CODE_C53106
	lda.b $01,s
	tax
	clc
	adc.l $C30006,x
	tax
	lda.l $C30003,x
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.b $0A
	sta.b $0A
	lda.l $C30003,x
	and.w #$000F
	adc.b $0A
	sta.b $0A
	lda.w $003A,y
	cmp.b $A5
	bcs CODE_C52E55
	jmp.w CODE_C52EF0
CODE_C52E55:						; from CODE_C52E1F
	cmp.b $0A
	bcc CODE_C52E5C
	jmp.w CODE_C52EF0
CODE_C52E5C:						; from CODE_C52E55
	lda.b $01,s
	tax
	lda.l $C30000,x
	and.w #$07FF
	tax
	lda.l $C30000,x
	and.w #$3FFF
	cmp.w $0008,y
	bne CODE_C52E79
	pla
	lda.w #$0500
	bra CODE_C52ED6
CODE_C52E79:						; from CODE_C52E5C
	lda.w $003A,y
	sec
	sbc.b $A5
	inc a
	sta.b $A5
	pla
	tax
	sec
	adc.l $C3000A,x
	tax
	sta.b $0A
	lda.l $C30000,x
	and.w #$00FF
	cmp.b $A5
	beq CODE_C52ED2
	inx
	lda.l $C30000,x
	and.w #$00FF
	cmp.b $A5
	beq CODE_C52ED2
	inx
	lda.l $C30000,x
	and.w #$00FF
	cmp.b $A5
	beq CODE_C52ED2
	inx
	lda.l $C30000,x
	and.w #$00FF
	cmp.b $A5
	beq CODE_C52ED2
	inx
	lda.l $C30000,x
	and.w #$00FF
	cmp.b $A5
	beq CODE_C52ED2
CODE_C52EC7:						; from CODE_C52E0E
	lda.w #$FFFF
	sta.w $00AC,y
	sta.w $00DE,y
	bra CODE_C52EF9
CODE_C52ED2:						; from CODE_C52E79
	txa
	sbc.b $0A
	xba
CODE_C52ED6:						; from CODE_C52E5C
	sta.w $00DE,y
	lda.b $01,s
	asl a
	tax
	lda.l $C35EA7,x
	sta.w $00AC,y
	lda.l $C35EA9,x
	ora.w $00DE,y
	sta.w $00DE,y
	bra CODE_C52EF9
CODE_C52EF0:						; from CODE_C52E1F, CODE_C52E55
	pla
	plx
	dex
	dex
	beq CODE_C52EF9
	jmp.w CODE_C52E1F
CODE_C52EF9:						; from CODE_C52EC7, CODE_C52EF0, CODE_C52ED6
	plx
	iny
	iny
	dec.b $A3
	beq CODE_C52F03
	jmp.w CODE_C52E0E
CODE_C52F03:						; from CODE_C52EF9
	stz.b $A3
	lda.b $A3
CODE_C52F07:						; from CODE_C53040
	asl a
	adc.b $A1
	tay
	lda.w $1864
	cmp.w #$0002
	bcs CODE_C52F1B
	lda.w $1872
	bne CODE_C52F1B
	jmp.w CODE_C52FFD
CODE_C52F1B:						; from CODE_C52F07
	lda.w $003A,y
	cmp.w #$026A
	bcs CODE_C52F26
	jmp.w CODE_C52FFD
CODE_C52F26:						; from CODE_C52F1B
	phy
	lda.b $A3
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $A1
	sta.b $A5
	pha
	lda.b $03,s
	tay
	lda.w $003A,y
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	stz.b $0C
	pei ($A5)
CODE_C52F43:						; from CODE_C52F5D
	jsr.w CODE_C5D804
	ldx.b $A5
	cmp.w #$0000
	beq CODE_C52F73
	cmp.w #$001D
	bne CODE_C52F57
	lda.w #$003D
	bra CODE_C52F5D
CODE_C52F57:						; from CODE_C52F43
	clc
	adc.w #$0040
	adc.b $0C
CODE_C52F5D:						; from CODE_C52F43
	sta.w $0118,x
	lda.w #$0020
	sta.b $0C
	inx
	stx.b $A5
	txa
	sec
	sbc.b $01,s
	cmp.w #$0008
	bcc CODE_C52F43
	bra CODE_C52F86
CODE_C52F73:						; from CODE_C52F43
	phx
CODE_C52F74:						; from CODE_C52F74
	txa
	sec
	sbc.b $03,s
	cmp.w #$0007
	beq CODE_C52F85
	phx
	jsr.w CODE_C5D804
	plx
	inx
	bra CODE_C52F74
CODE_C52F85:						; from CODE_C52F74
	plx
CODE_C52F86:						; from CODE_C52F5D
	pla
	lda.w #$0020
	sta.w $0118,x
	stz.b $0C
	inx
	stx.b $A5
	phx
CODE_C52F93:						; from CODE_C52FAD
	jsr.w CODE_C5D804
	ldx.b $A5
	cmp.w #$0000
	beq CODE_C52FC3
	cmp.w #$001D
	bne CODE_C52FA7
	lda.w #$003D
	bra CODE_C52FAD
CODE_C52FA7:						; from CODE_C52F93
	clc
	adc.w #$0040
	adc.b $0C
CODE_C52FAD:						; from CODE_C52F93
	sta.w $0118,x
	lda.w #$0020
	sta.b $0C
	inx
	stx.b $A5
	txa
	sec
	sbc.b $01,s
	cmp.w #$000A
	bcc CODE_C52F93
	bra CODE_C52FD6
CODE_C52FC3:						; from CODE_C52F93, CODE_C52FC3
	txa
	sec
	sbc.b $01,s
	cmp.w #$0009
	beq CODE_C52FD6
	jsr.w CODE_C5D804
	ldx.b $A5
	inx
	stx.b $A5
	bra CODE_C52FC3
CODE_C52FD6:						; from CODE_C52FC3, CODE_C52FAD
	plx
	pla
	sta.b $A5
	jsr.w CODE_C5D821
	ldx.b $A5
	sta.w $0110,x
	lda.w #$0006
	sta.b $0A
CODE_C52FE7:						; from CODE_C52FE7
	jsr.w CODE_C5D83F
	sep #$20
	ldx.b $A5
	inx
	stx.b $A5
	sta.w $0110,x
	rep #$20
	dec.b $0A
	bpl CODE_C52FE7
	ply
	bra CODE_C53040
CODE_C52FFD:						; from CODE_C52F07, CODE_C52F1B
	ldx.w $0008,y
	lda.b $A3
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $A1
	tay
	lda.l $C30000,x
	sta.w $0110,y
	lda.l $C30002,x
	sta.w $0112,y
	lda.l $C30004,x
	sta.w $0114,y
	lda.l $C30006,x
	sta.w $0116,y
	txa
	clc
	adc.w #$0008
	tax
	jsl.l $C4C3BA
	sep #$20
CODE_C53032:						; from CODE_C53032
	lda.w $0000,x
	sta.w $0118,y
	beq CODE_C5303E
	inx
	iny
	bra CODE_C53032
CODE_C5303E:						; from CODE_C53032
	rep #$20
CODE_C53040:						; from CODE_C52FE7
	lda.b $A3
	inc a
	sta.b $A3
	cmp.b ($A1)
	beq CODE_C5304C
	jmp.w CODE_C52F07
CODE_C5304C:						; from CODE_C53040
	lda.w $1872
	bne CODE_C53059
	lda.w $1864
	cmp.w #$0002
	bne CODE_C53084
CODE_C53059:						; from CODE_C5304C
	lda.w #$0000
CODE_C5305C:						; from CODE_C5305C
	sta.b $A3
	asl a
	adc.b $A1
	tay
	lda.w $003A,y
	jsr.w CODE_C5BD30
	lda.b $9F
	tax
	lda.b $A3
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $A1
	tay
	txa
	sep #$20
	sta.w $0110,y
	rep #$20
	lda.b $A3
	inc a
	cmp.b ($A1)
	bcc CODE_C5305C
CODE_C53084:						; from CODE_C5304C
	jsl.l $C4C536
	pla
	sta.w $18E0
	rts

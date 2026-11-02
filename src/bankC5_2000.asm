; Segment bankC5_2000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C52008
QueueFaceoffBox:					; queues face off box frame A to VRAM: $280 bytes from the box buffer
									; ($2024 + DATA8_C5202F by frame) to the box's address ($2026)
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
DATA8_C5202F:						; not traced: a table read by QueueFaceoffBox
	db $00,$00,$80,$02,$00,$05,$80,$07
setupice:							; sets up the rink screen: the rink map set (IceRinkMap), the tiles and
									; the scoreboard
	jsl.l forceblack
	sep #$20
	lda.b #$13
	sta.l TM
	rep #$20
	lda.w #IceRinkMap&$FFFF
	ldx.w #IceRinkMap>>16
	jsl.l MapSetToUnpackbuf
	ldx.w #$2A7E
	clc
.loop:								; loop: $7F9C7A,x = $50DC,x, X - 1, X - 1, ...
	lda.w $50DC,x
	sta.l $7F9C7A,x
	dex
	dex
	bpl .loop
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
	lda.w HomeTeam
	pea.w $0020
	pea.w $0040
	pea.w $00C0
	xba
	lsr a
	lsr a
	adc.w #$3F22
	pha
	lda.w VisTeam
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
	sta.b tmp1
	lda.w #$2160
	sta.b tmp2
	lda.w #$01BE
	jsl.l QueueFrameTiles
	lda.w #$2168
	sta.b tmp2
	lda.w #$01BF
	jsl.l QueueFrameTiles
	lda.w #$2588
	sta.b tmp2
	lda.w #$006F
	jsl.l QueueFrameTiles
	lda.w #$2035
	sta.b tmp1
	lda.w #$01B3
	jsl.l QueueFrameTiles
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.w #$01E0
	pha
	jsl.l AllocWorkBuf
	pea.w $6360
	ldx.w #$007E
	phx
	stx.b $2E
	pha
	sta.b r0
	lda.w #DigitFontTiles&$FFFF
	ldx.w #DigitFontTiles>>16
	jsl.l Decompress
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsl.l WaitTransfers
	lda.w #CenterIceTiles&$FFFF
	ldx.w #CenterIceTiles>>16
	jsl.l DecompressUnpackbuf
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0300
	pea.w $2080
	pea.w $007E
	lda.w HomeTeam
	asl a
	adc.w HomeTeam
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
	lda.w HomeTeam
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
	jsl.l WaitTransfers
	lda.w #RefsMap&$FFFF
	ldx.w #RefsMap>>16
	jsl.l MapSetToUnpackbuf
	ldx.w #$092E
	clc
.loop2:								; loop: A = $50DC,x, A + $3420, $7FC6FA,x = A, X - 1, ...
	lda.w $50DC,x
	adc.w #$3420
	sta.l $7FC6FA,x
	dex
	dex
	bpl .loop2
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
	jsl.l WaitTransfers
	stz.w vramrow
	stz.w Oldrow
	lda.w #$FE90
	sta.w Vscroll
	ldy.w #$4800
	lda.w #MeterFontTiles&$FFFF
	ldx.w #MeterFontTiles>>16
	jsl.l DecompressToVRAM
	jsl.l CODE_C5897B
	jsl.l WaitTransfers
	lda.w #$FFFF
	sta.w $151B
	sta.w $151D
	sta.w $151F
	sta.w $1521
	sta.w $1523
	lda.w #$D02A
	sta.b r0
	lda.w #$007F
	sta.b $2E
	lda.w #LinePieceTiles&$FFFF
	ldx.w #LinePieceTiles>>16
	jsl.l Decompress
	jsl.l CODE_C539D7
	jmp.w CODE_C53A29
setupice_reset:						; resets the rink state: Oldrow $03E7, the pause bit cleared, Hpos / Vpos
									; 0, the sort objects, pfgoal turned with the direction of play, sfhormode
									; 0, then the scoreboard
	jsl.l forceblack
	lda.w #$03E7
	sta.w Oldrow
	lda.w #$0001
	trb.w sflags
	stz.b Hpos
	stz.b Vpos
	lda.b $5F
	dec a
	dec a
	sta.w vcountmark+2
	jsl.l defaultsprites_0
	lda.w gmode
	bit.w #$0002
	beq .1
	ldx.w #$0016
.loop:								; loop: A = pfgoal,x, A xor $0001, pfgoal,x = A, X - 1, ...
	lda.w pfgoal,x
	eor.w #$0001
	sta.w pfgoal,x
	dex
	dex
	bpl .loop
.1:									; sfhormode = 0, go to CODE_C539D7
	stz.w sfhormode
	jmp.w CODE_C539D7
ClrHor:								; what is left of 94S ClrHor: sfhormode = 0; X = a3
	stz.w sfhormode
	ldx.b a3
	rtl
SetHor:								; what is left of 94S SetHor: halves the puck speed and counts sfhormode
									; up; X = a3
	lda.w puckvx
	pha
	asl a
	pla
	ror a
	sta.w puckvx
	lda.w puckvy
	pha
	asl a
	pla
	ror a
	sta.w puckvy
	inc.w sfhormode
	ldx.b a3
	rtl
freezewindow:						; called from other segments
	lda.b Vpos
	sta.w yc1
	lda.b Hpos
	sta.w xc1
	lda.w #$0040
	tsb.w sflags
	rtl
setvideo:							; once per game frame: the sprite table built for the next vblank
									; (BuildSpriteOAM, PackOAMHigh, TransfersReady + 1), the scroll and the
									; rink rows
	jsl.l AnimateSprites
	jsl.l updatescroll
	jsl.l DrawPlayerTags
	jsl.l UpdateGameObjectSprites
	jsl.l DrawPadArrows
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	inc.w TransfersReady
	jsl.l showref
	jsl.l updatescroll_rows
	ldx.b a3
	rtl
DrawPadArrows:						; the arrow sprite over the player each pad controls (c1playernum on), for
									; the five pads in turn, written straight to the OAM buffer
	dec.b QueueBusy
	tsc
	sta.b $1C
	lda.b $28
	tcs
	ldy.w c1playernum
	bmi PadArrow2
	ldx.w #$22DF
	bra DrawPadArrow
DATA8_C522D1:						; not traced: data between routines
	db $1B,$15,$2A,$D0,$A0,$25,$45,$24,$00,$7A,$00,$7B,$50,$64
PadArrow2:							; DrawPadArrows' step for pad 2 ($1513), continuing with PadArrow3
	ldy.w $1513
	bmi PadArrow3
	ldx.w #$22F7
	bra DrawPadArrow
DATA8_C522E9:						; not traced: data between routines
	db $1D,$15,$CA,$D2,$A2,$25,$48,$24,$20,$7A,$20,$7B,$80,$64
PadArrow3:							; DrawPadArrows' step for pad 3 ($1515), continuing with PadArrow4
	ldy.w $1515
	bmi PadArrow4
	ldx.w #$230F
	bra DrawPadArrow
DATA8_C52301:						; not traced: data between routines
	db $1F,$15,$6A,$D5,$A4,$25,$4B,$24,$40,$7A,$40,$7B,$B0,$64
PadArrow4:							; DrawPadArrows' step for pad 4 ($1517), continuing with PadArrow5
	ldy.w $1517
	bmi PadArrow5
	ldx.w #$2327
	bra DrawPadArrow
DATA8_C52319:						; not traced: data between routines
	db $21,$15,$2A,$D0,$A6,$27,$4E,$26,$60,$7A,$60,$7B,$E0,$64
PadArrow5:							; DrawPadArrows' step for pad 5 ($1519), continuing with PadArrowsDone
	ldy.w $1519
	bmi PadArrowsDone
	ldx.w #$233F
	bra DrawPadArrow
DATA8_C52331:						; not traced: data between routines
	db $23,$15,$CA,$D2,$A8,$27,$51,$26,$80,$7A,$80,$7B,$10,$65
PadArrowsDone:						; the end of DrawPadArrows: the OAM pointer ($28) kept, the stack back,
									; QueueBusy cleared
	tsc
	sta.b $28
	lda.b $1C
	tcs
	stz.b QueueBusy
	rtl
DrawPadArrow:						; the arrow for player Y: over him when he is on screen, else at the
									; screen edge pointing at him; then on to the continuation in X
	stx.b $A5
	lda.w Xpos,y
	clc
	adc.w #$0080
	sec
	sbc.b Hpos
	sta.b $0A
	sec
	lda.b Vpos
	sbc.w Ypos,y
	clc
	adc.w #$005E
	sta.b $0C
	bmi .4
	cmp.w #$00E0
	bcc .1
	jmp.w .10
.1:									; if $0A >= 0 go to .2, go to .20
	lda.b $0A
	bpl .2
	jmp.w .20
.2:									; if A < $0100 go to .3, go to .16
	cmp.w #$0100
	bcc .3
	jmp.w .16
.3:									; jump through $00A5
	jmp ($00A5)
.4:									; tmp2 = $C4FFF6,x, tmp1 = $C4FFF8,x, if $0A >= 0 go to .5, go to .24
	lda.l $C4FFF6,x
	sta.b tmp2
	lda.l $C4FFF8,x
	sta.b tmp1
	lda.b $0A
	bpl .5
	jmp.w .24
.5:									; if A < $0100 go to .6, go to .26
	cmp.w #$0100
	bcc .6
	jmp.w .26
.6:									; A = $C4FFF2,x, Y = A, if $0000,y = 0 go to .7, $0000,y = $0000, ...
	lda.l $C4FFF2,x
	tay
	lda.w $0000,y
	beq .7
	lda.w #$0000
	sta.w $0000,y
	jsr.w CODE_C52628
.7:									; if $0A < $00E9 go to .8, A = $00E8
	lda.b $0A
	cmp.w #$00E9
	bcc .8
	lda.w #$00E8
.8:									; if A >= $0009 go to .9, A = $0009
	cmp.w #$0009
	bcs .9
	lda.w #$0009
.9:									; A or $0800, $0A = A, push A, X = $2A, ...
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
	ldy.b tmp1
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
.10:								; A = $C4FFF6,x, A or $8000, tmp2 = A, A = $C4FFF8,x, ...
	lda.l $C4FFF6,x
	ora.w #$8000
	sta.b tmp2
	lda.l $C4FFF8,x
	ora.w #$8000
	sta.b tmp1
	lda.b $0A
	bpl .11
	jmp.w .28
.11:								; if A < $0100 go to .12, go to .30
	cmp.w #$0100
	bcc .12
	jmp.w .30
.12:								; A = $C4FFF2,x, Y = A, if $0000,y = 0 go to .13, $0000,y = $0000, ...
	lda.l $C4FFF2,x
	tay
	lda.w $0000,y
	beq .13
	lda.w #$0000
	sta.w $0000,y
	jsr.w CODE_C52628
.13:								; if $0A < $00E9 go to .14, A = $00E8
	lda.b $0A
	cmp.w #$00E9
	bcc .14
	lda.w #$00E8
.14:								; if A >= $0009 go to .15, A = $0009
	cmp.w #$0009
	bcs .15
	lda.w #$0009
.15:								; A or $C800, $0A = A, push A, X = $2A, ...
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
	ldy.b tmp1
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
.16:								; tmp2 = $C4FFF6,x, tmp1 = $C4FFF8,x, A = $C4FFF2,x, Y = A, ...
	lda.l $C4FFF6,x
	sta.b tmp2
	lda.l $C4FFF8,x
	sta.b tmp1
	lda.l $C4FFF2,x
	tay
	lda.w #$0002
	cmp.w $0000,y
	beq .17
	sta.w $0000,y
	clc
	jsr.w CODE_C526A7
.17:								; if $0C >= $0009 go to .18, A = $0009
	lda.b $0C
	cmp.w #$0009
	bcs .18
	lda.w #$0009
.18:								; if A < $00C8 go to .19, A = $00C7
	cmp.w #$00C8
	bcc .19
	lda.w #$00C7
.19:								; A or $00E8, $0C = A, push A, X = $2A, ...
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
	ldy.b tmp1
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
.20:								; A = $C4FFF6,x, A or $4000, tmp2 = A, A = $C4FFF8,x, ...
	lda.l $C4FFF6,x
	ora.w #$4000
	sta.b tmp2
	lda.l $C4FFF8,x
	ora.w #$4000
	sta.b tmp1
	lda.l $C4FFF2,x
	tay
	lda.w #$0002
	cmp.w $0000,y
	beq .21
	sta.w $0000,y
	clc
	jsr.w CODE_C526A7
.21:								; if $0C >= $0009 go to .22, A = $0009
	lda.b $0C
	cmp.w #$0009
	bcs .22
	lda.w #$0009
.22:								; if A < $00C8 go to .23, A = $00C7
	cmp.w #$00C8
	bcc .23
	lda.w #$00C7
.23:								; A or $0008, $0C = A, push A, X = $2A, ...
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
	ldy.b tmp1
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
.24:								; A = $C4FFF2,x, Y = A, if zero go to .25, $0000,y = A, ...
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq .25
	sta.w $0000,y
	jsr.w CODE_C52666
.25:								; A = $4000, A or tmp2, push A, X = $2A, ...
	lda.w #$4000
	tsb.b tmp1
	ora.b tmp2
	pha
	pea.w $0908
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	pea.w $0418
	iny
	phy
	pea.w $1903
	iny
	phy
	pea.w $1514
	jmp ($00A5)
.26:								; A = $C4FFF2,x, Y = A, if zero go to .27, $0000,y = A, ...
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq .27
	sta.w $0000,y
	jsr.w CODE_C52666
.27:								; X = $2A, $00,x = $0002, $02,x = 0, A = X, ...
	pei ($A3)
	pea.w $09E8
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	pea.w $04E0
	iny
	phy
	pea.w $19F5
	iny
	phy
	pea.w $15E4
	jmp ($00A5)
.28:								; A = $C4FFF2,x, Y = A, if zero go to .29, $0000,y = A, ...
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq .29
	sta.w $0000,y
	jsr.w CODE_C52666
.29:								; A = $4000, A or tmp2, push A, X = $2A, ...
	lda.w #$4000
	tsb.b tmp1
	ora.b tmp2
	pha
	pea.w $C708
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	pea.w $D418
	iny
	phy
	pea.w $BF03
	iny
	phy
	pea.w $C314
	jmp ($00A5)
.30:								; A = $C4FFF2,x, Y = A, if zero go to .31, $0000,y = A, ...
	lda.l $C4FFF2,x
	tay
	lda.w #$0001
	cmp.w $0000,y
	clc
	beq .31
	sta.w $0000,y
	jsr.w CODE_C52666
.31:								; X = $2A, $00,x = $0002, $02,x = 0, A = X, ...
	pei ($A3)
	pea.w $C7E8
	ldx.b $2A
	lda.w #$0002
	sta.b $00,x
	stz.b $02,x
	txa
	adc.w #$0004
	sta.b $2A
	ldy.b tmp1
	phy
	pea.w $D4E0
	iny
	phy
	pea.w $BFF5
	iny
	phy
	pea.w $C3E4
	jmp ($00A5)
CODE_C52628:						; from DrawPadArrow
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
CODE_C52666:						; from DrawPadArrow
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
CODE_C526A7:						; from DrawPadArrow
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
updatescroll:						; sets the rink scroll from the camera position: Hscroll = Hpos - $80,
									; Vscroll = -Vpos - $70
	sec
	lda.b Hpos
	sbc.w #$0080
	sta.w Hscroll
	sec
	lda.w #$FF90
	sbc.b Vpos
	sta.w Vscroll
	rtl
DrawPlayerTags:						; for each pad's controlled player (PadControlObj), sprite tags near him
									; straight into the OAM buffer: his two roster number digits (tiles from
									; $2436) and a marker
	dec.b QueueBusy
	tsc
	sta.b $1C
	lda.b $28
	tcs
	ldy.w #$000C
CODE_C52706:						; from CODE_C52832
	sty.b $10
	lda.w PadControlObj,y
	cmp.w #$000F
	bne .1
	jmp.w CODE_C52832
.1:									; A * 2, X = A, A = Xpos,x, A + $0074, ...
	php
	asl a
	tax
	lda.w Xpos,x
	adc.w #$0074
	sec
	sbc.b Hpos
	sta.b $0A
	sec
	lda.b Vpos
	sbc.w Ypos,x
	clc
	adc.w #$006A
	sta.b $0C
	plp
	bcc .2
	jmp.w CODE_C52842
.2:									; A = position,x, A and $0007, A * 2, $0E = A, ...
	lda.w position,x
	and.w #$0007
	asl a
	sta.b $0E
	bne .3
	lda.b $0A
	adc.w #$0004
	sta.b $0A
.3:									; A = rostnum,x, X = A, A and $00F0, A / 2, ...
	lda.w rostnum,x
	tax
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$2436
	sta.b tmp1
	txa
	and.w #$000F
	adc.w #$2436
	sta.b tmp2
	lda.w #CODE_C52766
	sta.b $A5
	jmp.w PutTagChar
CODE_C52766:						; a continuation: PutTagChar jumps back here through a pointer
	clc
	lda.b $0A
	adc.w #$0008
	sta.b $0A
	lda.b tmp2
	sta.b tmp1
	lda.w #CODE_C5277A
	sta.b $A5
	jmp.w PutTagChar
CODE_C5277A:						; a continuation: PutTagChar jumps back here through a pointer
	clc
	lda.b $0A
	adc.w #$0008
	sta.b $0A
	ldx.b $0E
	beq CODE_C52794
	lda.l DATA8_C5288A,x
	sta.b tmp1
	lda.w #CODE_C52794
	sta.b $A5
	jmp.w PutTagChar
CODE_C52794:						; a continuation: PutTagChar jumps back here through a pointer
	sec
	lda.b $0C
	sbc.w #$0014
	sta.b $0C
	sec
	lda.b $0A
	sbc.w #$0004
	ldx.b $0E
	bne .1
	sbc.w #$0004
.1:									; $0A = A, if $10 is not $000C go to .2, go to CODE_C52852
	sta.b $0A
	ldx.b $10
	cpx.w #$000C
	bne .2
	jmp.w CODE_C52852
.2:									; tmp2 = DATA8_C52880,x, Y = $2A, X = $0002, A = $FFF0, ...
	lda.l DATA8_C52880,x
	sta.b tmp2
	ldy.b $2A
	pei ($A3)
	ldx.w #$0002
	clc
	lda.w #$FFF0
	adc.b $0A
	bpl .3
	cmp.w #$FFF1
	bcc .4
	inx
	and.w #$00FF
.3:									; if A >= $0100 go to .4, tmp0 = A, if $0C >= 0 go to .5, ...
	cmp.w #$0100
	bcs .4
	sta.b tmp0
	lda.b $0C
	bpl .5
	cmp.w #$FFF1
	and.w #$00FF
	bcs .6
.4:									; pull A, go to .7
	pla
	bra .7
.5:									; if A >= $00E0 go to .4
	cmp.w #$00E0
	bcs .4
.6:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.7:									; A = tmp2, A + $4000, push A, X = $0002, ...
	clc
	lda.b tmp2
	adc.w #$4000
	pha
	ldx.w #$0002
	lda.b $0A
	bpl .8
	cmp.w #$FFF1
	bcc .9
	inx
	and.w #$00FF
.8:									; if A >= $0100 go to .9, tmp0 = A, if $0C >= 0 go to .10, ...
	cmp.w #$0100
	bcs .9
	sta.b tmp0
	lda.b $0C
	bpl .10
	cmp.w #$FFF1
	and.w #$00FF
	bcs .11
.9:									; pull A, go to .12
	pla
	bra .12
.10:								; if A >= $00E0 go to .9
	cmp.w #$00E0
	bcs .9
.11:								; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.12:								; $2A = Y, Y = $10
	sty.b $2A
	ldy.b $10
CODE_C52832:						; from CODE_C52706, CODE_C5287A
	dey
	dey
	bmi .1
	jmp.w CODE_C52706
.1:									; $28 = A, A = $1C, QueueBusy = 0, return
	tsc
	sta.b $28
	lda.b $1C
	tcs
	stz.b QueueBusy
	rtl
CODE_C52842:						; from CODE_C52706
	lda.b $0A
	clc
	adc.w #$000C
	sta.b $0A
	lda.b $0C
	sec
	sbc.w #$0014
	sta.b $0C
CODE_C52852:						; from CODE_C52794
	lda.w #$2454
	sta.b tmp1
	lda.w #$25E0
	sta.b tmp2
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
	jml.l CODE_CFEE6C
CODE_C5287A:						; called from other segments
	sty.b $2A
	ldy.b $10
	bra CODE_C52832
DATA8_C52880:						; not traced: a table read by CODE_C52794
	db $88,$25,$8C,$25,$8E,$25,$8A,$25,$8C,$27
DATA8_C5288A:						; not traced: a table read by CODE_C5277A
	db $8E,$27,$40,$24,$40,$24,$41,$24,$42,$24,$43,$24,$44,$24
PutTagChar:							; writes one 8 x 8 tag sprite (tile tmp1) at screen x $0A, y $0C into the
									; OAM buffer (skipped off screen), then on to the continuation in $A5
	ldy.b $2A
	pei ($A1)
	ldx.w #$0000
	lda.b $0A
	bpl .1
	cmp.w #$FFF9
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, if $0C >= 0 go to .3, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $0C
	bpl .3
	cmp.w #$FFF9
	and.w #$00FF
	bcs .4
.2:									; pull A, go to .5
	pla
	bra .5
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
.5:									; $2A = Y, jump through $00A5
	sty.b $2A
	jmp ($00A5)
CODE_C528D3:						; called from other segments
	rtl
eraser:								; a bare rtl where 94S fills a d0 by d1 box of the text map with tile d2
									; (blankchar)
	rtl
updatescroll_rows:					; queues the rink map rows that the vertical scroll brought on screen;
									; BG2VScroll from Vscroll + $170
	lda.w Vscroll
	clc
	adc.w #$0170
	sta.w BG2VScroll
	lsr a
	lsr a
	lsr a
	tax
	sec
	sbc.w Oldrow
	bne .1
	jmp.w .6
.1:									; if plus go to .3, A xor $FFFF, A + 1, if A >= $0019 go to .2, ...
	bpl .3
	eor.w #$FFFF
	inc a
	cmp.w #$0019
	bcs .2
	and.w #$001F
	sta.b tmp1
	stx.w Oldrow
	lda.w vramrow
	sec
	sbc.b tmp1
	and.w #$001F
	sta.w vramrow
	sta.b tmp2
	stx.b tmp0
	bra .4
.2:									; tmp1 = $001D, A = X, A and $001F, vramrow = A, ...
	lda.w #$001D
	sta.b tmp1
	txa
	and.w #$001F
	sta.w vramrow
	sta.b tmp2
	stx.b tmp0
	stx.w Oldrow
	bra .4
.3:									; Oldrow = X, if A >= $0019 go to .2, tmp1 = A, A + vramrow, ...
	stx.w Oldrow
	cmp.w #$0019
	bcs .2
	sta.b tmp1
	adc.w vramrow
	and.w #$001F
	sta.w vramrow
	adc.w #$001D
	sec
	sbc.b tmp1
	and.w #$001F
	sta.b tmp2
	txa
	clc
	adc.w #$001D
	sec
	sbc.b tmp1
	sta.b tmp0
.4:									; QueueBusy - 1, A = $00, $00 = X, A = $0020, ...
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.w #$0020
	sec
	sbc.b tmp2
	tax
	sbc.b tmp1
	bpl .5
	eor.w #$FFFF
	inc a
	sta.b tmp1
	txa
	xba
	lsr a
	lsr a
	pha
	stx.b $A5
	tax
	lda.b tmp2
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$5000
	pha
	pea.w $007F
	adc.w #$0400
	tay
	lda.b tmp0
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
	stz.b tmp2
	lda.b tmp0
	adc.b $A5
	sta.b tmp0
.5:									; A = tmp1, A / 2, A / 2, push A, ...
	lda.b tmp1
	xba
	lsr a
	lsr a
	pha
	tax
	lda.b tmp2
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$5000
	pha
	pea.w $007F
	adc.w #$0400
	tay
	lda.b tmp0
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
.6:									; A = Hscroll, A + $00C0, BG2HScroll = A, return
	lda.w Hscroll
	clc
	adc.w #$00C0
	sta.w BG2HScroll
	rtl
checkwindow:						; called from other segments
	lda.w yc1
	sta.b d2
	lda.w xc1
	sta.b d3
	lda.w sflags
	bit.w #$0040
	bne .4
	ldx.w #$001C
	lda.w puckc
	bmi .2
	tax
	lda.w pfgoal,x
	beq .1
	lda.w yleader
	adc.w impactstep
	sta.w yleader
	cmp.w #$0020
	bmi .2
	lda.w #$0020
	sta.w yleader
	bra .2
.1:									; A = yleader, A - impactstep, yleader = A, ...
	lda.w yleader
	sec
	sbc.w impactstep
	sta.w yleader
	cmp.w #$FFE1
	bpl .2
	lda.w #$FFE0
	sta.w yleader
.2:									; A = Yvel,x, A / 2, A / 2, A / 2, ...
	lda.w Yvel,x
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0100
	beq .3
	ora.w #$FE00
.3:									; A + Ypos,x, A + yleader, d2 = A, yc1 = A, ...
	clc
	adc.w Ypos,x
	clc
	adc.w yleader
	sta.b d2
	sta.w yc1
	lda.w Xpos,x
	sta.b d3
	sta.w xc1
.4:									; A = d2, A - Vpos, d0 = A, if A - $FFF7 >= 0 go to .5, ...
	lda.b d2
	sec
	sbc.b Vpos
	sta.b d0
	cmp.w #$FFF7
	bpl .5
	lda.b d2
	sec
	sbc.w #$FFF6
	sta.b d1
	cmp.w #$FF39
	bpl .6
	lda.w #$FF39
	sta.b d1
	bra .6
.5:									; if d0 - $000B < 0 go to .9, A = d2, A - $000A, d1 = A, ...
	lda.b d0
	cmp.w #$000B
	bmi .9
	lda.b d2
	sec
	sbc.w #$000A
	sta.b d1
	cmp.w #$0100
	bmi .6
	lda.w #$0100
	sta.b d1
.6:									; A = d1, A - Vpos, if the result = 0 go to .9, A / 2, ...
	lda.b d1
	sec
	sbc.b Vpos
	beq .9
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0800
	beq .7
	ora.w #$F000
.7:									; if A is not $0000 go to .8, A + 1
	cmp.w #$0000
	bne .8
	inc a
.8:									; A + Vpos, Vpos = A
	clc
	adc.b Vpos
	sta.b Vpos
.9:									; A = d3, A - Hpos, d0 = A, if A - $FFD8 >= 0 go to .10, ...
	lda.b d3
	sec
	sbc.b Hpos
	sta.b d0
	cmp.w #$FFD8
	bpl .10
	lda.b d3
	sec
	sbc.w #$FFD8
	sta.b d1
	cmp.w #$FFC8
	bpl .11
	lda.w #$FFC8
	sta.b d1
	bra .11
.10:								; if d0 - $0029 < 0 go to .rtl, A = d3, A - $0028, d1 = A, ...
	lda.b d0
	cmp.w #$0029
	bmi .rtl
	lda.b d3
	sec
	sbc.w #$0028
	sta.b d1
	cmp.w #$0039
	bmi .11
	lda.w #$0038
	sta.b d1
.11:								; A = d1, A - Hpos, if the result = 0 go to .rtl, A / 2, ...
	lda.b d1
	sec
	sbc.b Hpos
	beq .rtl
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0800
	beq .12
	ora.w #$F000
.12:								; if A is not $0000 go to .13, A + 1
	cmp.w #$0000
	bne .13
	inc a
.13:								; A + Hpos, Hpos = A
	clc
	adc.b Hpos
	sta.b Hpos
.rtl:								; return
	rtl
doinput:							; called from other segments
	jsl.l setpads
	dec.b d4
	dec.b d4
	lda.b d3
	bit.w #$1000
	beq .1
	lda.b d4
	jmp.w PauseFromPad
.rtl:								; return
	rtl
.1:									; A = sflags, if $0100 bits clear go to .2, go to .9
	lda.w sflags
	bit.w #$0100
	beq .2
	jmp.w .9
.2:									; if asscur,x = $7D2E go to .rtl, push Y, Y = $0000, ...
	lda.w asscur,x
	cmp.w #$7D2E
	beq .rtl
	phy
	ldy.w #$0000
	lda.w pfteam,x
	beq .3
	ldy.w #$0002
.3:									; A = lcpad,y, pull Y, if lcpad,y - $0000 < 0 go to .4, ...
	lda.w lcpad,y
	ply
	cmp.w #$0000
	bmi .4
	cmp.b d4
	bne .6
.4:									; push Y, Y = $0000, if pfteam,x = 0 go to .5, Y = $0002
	phy
	ldy.w #$0000
	lda.w pfteam,x
	beq .5
	ldy.w #$0002
.5:									; A = tmflags,y, pull Y, if a $0008 bit set go to .10
	lda.w tmflags,y
	ply
	bit.w #$0008
	bne .10
.6:									; A = d1, if a $2000 bit set go to .17, if X is not puckc go to .7, ...
	lda.b d1
	bit.w #$2000
	bne .17
	cpx.w puckc
	bne .7
	jmp.w .22
.7:									; A = d1, if a $4000 bit set go to .11, ...
	lda.b d1
	bit.w #$4000
	bne .11
	lda.w pfalock,x
	bne .8
	lda.b d1
	bit.w #$0040
	bne .20
	bit.w #$8000
	bne .12
	lda.w position,x
	beq .15
	lda.b d1
	bit.w #$0020
	bne .13
	bit.w #$0010
	bne .14
	lda.w passReceiverPlayerNum
	cmp.b curobj
	beq .8
	lda.b d1
	bit.w #$0080
	bne .19
	jml.l doplayeracc
.8:									; go to .31
	jmp.w .31
.9:									; go to faceoffinput
	jml.l faceoffinput
.10:								; go to lineinput
	jml.l lineinput
.11:								; go to Holdplayer
	jml.l Holdplayer
.12:								; go to findpc
	jml.l findpc
.13:								; go to PadTakeLeftDefense
	jml.l PadTakeLeftDefense
.14:								; go to PadTakeRightDefense
	jml.l PadTakeRightDefense
.15:								; A = goalieflags,x, if a $0001 bit set go to .16, ...
	lda.w goalieflags,x
	bit.w #$0001
	bne .16
	and.w #$0002
	bne .rtl2
.16:								; go to doplayeracc
	jml.l doplayeracc
.rtl2:								; return
	rtl
.17:								; if gmclock is not 0 go to .rtl2, Y = $0000, ...
	lda.w gmclock
	bne .rtl2
	ldy.w #$0000
	lda.w pfteam,x
	beq .18
	ldy.w #$0002
.18:								; if lcpad,y >= 0 go to .rtl2, lcpad,y = d4, go to SetLCmode
	lda.w lcpad,y
	bpl .rtl2
	lda.b d4
	sta.w lcpad,y
	jmp.w SetLCmode
.19:								; go to burst
	jml.l burst
.20:								; Y = $0000, if X - $000C < 0 go to .21, Y = $0002
	ldy.w #$0000
	cpx.w #$000C
	bmi .21
	ldy.w #$0002
.21:								; if goaliemode1,y = 0 go to .rtl2, go to PadTakeGoalie
	lda.w goaliemode1,y
	beq .rtl2
	jml.l PadTakeGoalie
.22:								; if pfalock,x is not 0 go to .8, call checkob, ...
	lda.w pfalock,x
	bne .8
	jsl.l checkob
	lda.w position,x
	bne .23
	lda.w pf2aip,x
	bne .rtl2
.23:								; A = sflags, if a $0004 bit set go to .24, ...
	lda.w sflags
	bit.w #$0004
	bne .24
	bit.w #$0008
	bne .25
	lda.w dumpinplayer
	cmp.b curobj
	beq .rtl3
	lda.b d1
	bit.w #$8000
	bne .27
	bit.w #$4000
	bne .26
	lda.w position,x
	beq .30
	lda.b d1
	bit.w #$0080
	bne .29
	jml.l doplayeracc
.24:								; go to passmode
	jml.l passmode
.25:								; go to ShotMode
	jml.l ShotMode
.26:								; d0 = $0014, go to assinsert
	lda.w #$0014
	sta.b d0
	jml.l assinsert
.27:								; go to setpassmode
	jml.l setpassmode
.28:								; go to findpc
	jml.l findpc
.29:								; go to SetShotMode
	jml.l SetShotMode
.30:								; go to .15
	jmp.w .15
.rtl3:								; return
	rtl
.31:								; if X = puckc go to .rtl3, A = d1, if a $8000 bit set go to .28, ...
	cpx.w puckc
	beq .rtl3
	lda.b d1
	bit.w #$8000
	bne .28
	bit.w #$0040
	beq .32
	jmp.w .20
.32:								; if $0080 bits clear go to .rtl3, ...
	bit.w #$0080
	beq .rtl3
	ldy.w passReceiverPlayerNum
	bmi .rtl3
	lda.w pflags,y
	and.w #$1000
	ora.w pfalock,y
	bne .rtl3
	lda.w playerpad,y
	bpl .rtl3
	lda.w pfteam,y
	cmp.w pfteam,x
	bne .rtl3
	sty.b d0
	inc.w onetimerreq
	lda.w #$7FFF
	sta.w $0674
	jml.l AssignPadPlayer
LoadGameRostersLong:				; LoadGameRosters for long calls
	jsr.w LoadGameRosters
	rtl
LoadDefaultRoster:					; LoadTeamRoster from the cartridge team data: OptPlayMode and OptRosters
									; cleared around it (long calls)
	ldx.w OptRosters
	phx
	stz.w OptRosters
	ldx.w OptPlayMode
	phx
	stz.w OptPlayMode
	jsr.w LoadTeamRoster
	pla
	sta.w OptPlayMode
	pla
	sta.w OptRosters
	rtl
LoadGameRosters:					; LoadTeamRoster for both teams of the game: HomeTeam into $2DC9, VisTeam
									; into $3207
	lda.w HomeTeam
	ldy.w #$2DC9
	jsr.w LoadTeamRoster
	lda.w VisTeam
	ldy.w #$3207
LoadTeamRoster:						; builds team A's roster table at Y from its team data (from the season
									; data in play modes 2 and 3 or with OptRosters set): the player and
									; goalie counts, the player ids, then the line data at +$6C
	sta.b tmp0
	sty.b tmp1
	ldx.w $18E0
	phx
	tax
	jsl.l MarkWorkBuf
	txa
	ldx.w OptPlayMode
	cpx.w #$0003
	beq .1
	cpx.w #$0002
	bne .2
.1:									; call LoadSeasonRoster, go to .3
	jsr.w LoadSeasonRoster
	bra .3
.2:									; if OptRosters is not 0 go to .1, A * 2, X = A, A = $C30000,x, ...
	ldx.w OptRosters
	bne .1
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
.loop:								; loop: X + 1, A * 2, A * 2, A * 2, ...
	inx
	asl a
	asl a
	asl a
	asl a
	bne .loop
	txa
	sta.w $0002,y
	lda.b $0E
	and.w #$07FF
	tax
.loop2:								; loop: A = $C30000,x, A and $3FFF, $0008,y = A, A = X, ...
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
	bne .loop2
.3:									; Y = tmp1, A = tmp0, A * 2, X = A, ...
	ldy.b tmp1
	lda.b tmp0
	asl a
	tax
	lda.l $C30000,x
	tax
	phx
	clc
	adc.l $C3000A,x
	tax
	sep #$20
	stz.b tmp2
.loop3:								; loop: $006C,y = $C30000,x, X + 1, Y + 1, A = tmp2, ...
	lda.l $C30000,x
	sta.w $006C,y
	inx
	iny
	lda.b tmp2
	inc a
	sta.b tmp2
	cmp.b #$08
	bne .loop3
	rep #$20
	plx
	txa
	clc
	adc.l $C30004,x
	tax
	sep #$20
.loop4:								; loop: $006C,y = $C30000,x, X + 1, Y + 1, A = tmp2, ...
	lda.l $C30000,x
	sta.w $006C,y
	inx
	iny
	lda.b tmp2
	inc a
	sta.b tmp2
	cmp.b #$40
	bne .loop4
	rep #$20
	ldy.b tmp1
	lda.w $0000,y
	inc a
	sta.b $A5
	lda.w $0002,y
	inc a
	sta.b $0A
	clc
	adc.w $0004,y
	sta.b $0C
	stz.b tmp2
.loop5:								; loop: A 8-bit, A = $006D,y, call FixLineForward, $006D,y = A, ...
	sep #$20
	lda.w $006D,y
	jsr.w FixLineForward
	sta.w $006D,y
	lda.w $006E,y
	jsr.w FixLineForward
	sta.w $006E,y
	lda.w $006F,y
	jsr.w FixLineDefence
	sta.w $006F,y
	lda.w $0070,y
	jsr.w FixLineDefence
	sta.w $0070,y
	lda.w $0071,y
	jsr.w FixLineDefence
	sta.w $0071,y
	rep #$20
	tya
	clc
	adc.w #$0008
	tay
	lda.b tmp2
	inc a
	sta.b tmp2
	cmp.w #$0007
	bne .loop5
	lda.b (tmp1)
	sta.b tmp2
	ldy.b tmp1
.4:									; if $003A,y < $026A go to .5, go to .10
	lda.w $003A,y
	cmp.w #$026A
	bcc .5
	pea.w $0000
	jmp.w .10
.5:									; X = $0038
	ldx.w #$0038
.6:									; push X, A = $C2FFFE,x, push A, call CODE_C53106, ...
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
	bcs .7
	jmp.w .13
.7:									; if A < $0A go to .8, go to .13
	cmp.b $0A
	bcc .8
	jmp.w .13
.8:									; A = $01,s, X = A, A = $C30000,x, A and $07FF, ...
	lda.b $01,s
	tax
	lda.l $C30000,x
	and.w #$07FF
	tax
	lda.l $C30000,x
	and.w #$3FFF
	cmp.w $0008,y
	bne .9
	pla
	lda.w #$0500
	bra .12
.9:									; A = $003A,y, A - $A5, A + 1, $A5 = A, ...
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
	beq .11
	inx
	lda.l $C30000,x
	and.w #$00FF
	cmp.b $A5
	beq .11
	inx
	lda.l $C30000,x
	and.w #$00FF
	cmp.b $A5
	beq .11
	inx
	lda.l $C30000,x
	and.w #$00FF
	cmp.b $A5
	beq .11
	inx
	lda.l $C30000,x
	and.w #$00FF
	cmp.b $A5
	beq .11
.10:								; $00AC,y = $FFFF, $00DE,y = A, go to .14
	lda.w #$FFFF
	sta.w $00AC,y
	sta.w $00DE,y
	bra .14
.11:								; A = X, A - $0A
	txa
	sbc.b $0A
	xba
.12:								; $00DE,y = A, A = $01,s, A * 2, X = A, ...
	sta.w $00DE,y
	lda.b $01,s
	asl a
	tax
	lda.l PhotoPaletteTable-4,x
	sta.w $00AC,y
	lda.l PhotoPaletteTable-2,x
	ora.w $00DE,y
	sta.w $00DE,y
	bra .14
.13:								; pull A, pull X, X - 1, X - 1, ...
	pla
	plx
	dex
	dex
	beq .14
	jmp.w .6
.14:								; pull X, Y + 1, Y + 1, tmp2 - 1, ...
	plx
	iny
	iny
	dec.b tmp2
	beq .15
	jmp.w .4
.15:								; tmp2 = 0, A = tmp2
	stz.b tmp2
	lda.b tmp2
.16:								; A * 2, A + tmp1, Y = A, if OptPlayMode >= $0002 go to .17, ...
	asl a
	adc.b tmp1
	tay
	lda.w OptPlayMode
	cmp.w #$0002
	bcs .17
	lda.w OptRosters
	bne .17
	jmp.w .29
.17:								; if $003A,y >= $026A go to .18, go to .29
	lda.w $003A,y
	cmp.w #$026A
	bcs .18
	jmp.w .29
.18:								; push Y, A = tmp2, A * 2, A * 2, ...
	phy
	lda.b tmp2
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b tmp1
	sta.b $A5
	pha
	lda.b $03,s
	tay
	lda.w $003A,y
	jsr.w CreatedPlayerBits
	jsr.w NextSaveBits3
	stz.b $0C
	pei ($A5)
.19:								; call NextSaveBits5, X = $A5, if A = $0000 go to .22, ...
	jsr.w NextSaveBits5
	ldx.b $A5
	cmp.w #$0000
	beq .22
	cmp.w #$001D
	bne .20
	lda.w #$003D
	bra .21
.20:								; A + $0040, A + $0C
	clc
	adc.w #$0040
	adc.b $0C
.21:								; $0118,x = A, $0C = $0020, X + 1, $A5 = X, ...
	sta.w $0118,x
	lda.w #$0020
	sta.b $0C
	inx
	stx.b $A5
	txa
	sec
	sbc.b $01,s
	cmp.w #$0008
	bcc .19
	bra .24
.22:								; push X
	phx
.loop6:								; loop: A = X, A - $03,s, if A = $0007 go to .23, push X, ...
	txa
	sec
	sbc.b $03,s
	cmp.w #$0007
	beq .23
	phx
	jsr.w NextSaveBits5
	plx
	inx
	bra .loop6
.23:								; pull X
	plx
.24:								; pull A, $0118,x = $0020, $0C = 0, X + 1, ...
	pla
	lda.w #$0020
	sta.w $0118,x
	stz.b $0C
	inx
	stx.b $A5
	phx
.25:								; call NextSaveBits5, X = $A5, if A = $0000 go to .loop7, ...
	jsr.w NextSaveBits5
	ldx.b $A5
	cmp.w #$0000
	beq .loop7
	cmp.w #$001D
	bne .26
	lda.w #$003D
	bra .27
.26:								; A + $0040, A + $0C
	clc
	adc.w #$0040
	adc.b $0C
.27:								; $0118,x = A, $0C = $0020, X + 1, $A5 = X, ...
	sta.w $0118,x
	lda.w #$0020
	sta.b $0C
	inx
	stx.b $A5
	txa
	sec
	sbc.b $01,s
	cmp.w #$000A
	bcc .25
	bra .28
.loop7:								; loop: A = X, A - $01,s, if A = $0009 go to .28, call NextSaveBits5, ...
	txa
	sec
	sbc.b $01,s
	cmp.w #$0009
	beq .28
	jsr.w NextSaveBits5
	ldx.b $A5
	inx
	stx.b $A5
	bra .loop7
.28:								; pull X, pull A, $A5 = A, call NextSaveBits7, ...
	plx
	pla
	sta.b $A5
	jsr.w NextSaveBits7
	ldx.b $A5
	sta.w $0110,x
	lda.w #$0006
	sta.b $0A
.loop8:								; loop: call NextSaveBits8, A 8-bit, X = $A5, X + 1, ...
	jsr.w NextSaveBits8
	sep #$20
	ldx.b $A5
	inx
	stx.b $A5
	sta.w $0110,x
	rep #$20
	dec.b $0A
	bpl .loop8
	ply
	bra .31
.29:								; X = $0008,y, A = tmp2, A * 2, A * 2, ...
	ldx.w $0008,y
	lda.b tmp2
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b tmp1
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
	jsl.l UnpackText
	sep #$20
.loop9:								; loop: $0118,y = $0000,x, if $0000,x = 0 go to .30, X + 1, Y + 1, ...
	lda.w $0000,x
	sta.w $0118,y
	beq .30
	inx
	iny
	bra .loop9
.30:								; A 16-bit
	rep #$20
.31:								; A = tmp2, A + 1, tmp2 = A, if A = (tmp1) go to .32, ...
	lda.b tmp2
	inc a
	sta.b tmp2
	cmp.b (tmp1)
	beq .32
	jmp.w .16
.32:								; if OptRosters is not 0 go to .33, if OptPlayMode is not $0002 go to .34
	lda.w OptRosters
	bne .33
	lda.w OptPlayMode
	cmp.w #$0002
	bne .34
.33:								; A = $0000
	lda.w #$0000
.loop10:							; loop: tmp2 = A, A * 2, A + tmp1, Y = A, ...
	sta.b tmp2
	asl a
	adc.b tmp1
	tay
	lda.w $003A,y
	jsr.w PlayerNumberBCD
	lda.b tmp0
	tax
	lda.b tmp2
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b tmp1
	tay
	txa
	sep #$20
	sta.w $0110,y
	rep #$20
	lda.b tmp2
	inc a
	cmp.b (tmp1)
	bcc .loop10
.34:								; call RestoreWorkBuf, pull A, $18E0 = A, return
	jsl.l RestoreWorkBuf
	pla
	sta.w $18E0
	rts

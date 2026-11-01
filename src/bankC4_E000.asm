; Segment bankC4_E000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4DFD6
StanleyCupScreen:					; the Stanley Cup screen: the cup, CONGRATULATIONS, team A wins the
									; stanley cup, defeating team X in the final game of the playoffs, team
									; A's logo sprite; returns on start
	sta.b a0
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
	lda.b a0
	jsl.l CreateSprite
	inc.b $38,x
	lda.b $08
	sta.b r1
	lda.w #$007E
	sta.b $32
	ldx.w #StanleyCupMap>>16
	lda.w #StanleyCupMap&$FFFF
	jsl.l CODE_C5881C
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	ldx.w #$506D
	ldy.b $08
.loop:								; loop: push X, push Y, A = Y, A + $0010, ...
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
	bne .loop
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
	jsl.l PrintItalicCentred
	lda.w #$2000
	sta.b $D5
	lda.b a0
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l UnpackText
	phx
	ldx.w #$50B4
	jsl.l UnpackText
	txy
	plx
	jsl.l CODE_C56005
	ldy.w #$0015
	jsl.l PrintBoldCentredStr
	ldx.w #$50C4
	jsl.l UnpackText
	phx
	lda.b $65
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l UnpackText
	txy
	plx
	jsl.l CODE_C56005
	phx
	ldx.w #$50CC
	jsl.l UnpackText
	txy
	plx
	jsl.l CODE_C56005
	ldy.w #$0016
	jsl.l PrintBoldCentredStr
	ldx.w #$50D6
	ldy.w #$0017
	jsl.l PrintBoldCentred
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	stz.w BG2HScroll
	stz.w fadestep
.loop2:								; loop: TransfersReady + 1, call CODE_C36C2D, $26 + 1, ...
	inc.w TransfersReady
	wai
	jsl.l CODE_C36C2D
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w repeatdelayframes
	bne .loop2
	lda.w $058D
	bit.w #$1000
	beq .loop2
	rtl
ScoutingReport:						; the pregame scouting report: both teams' names and logos, the matchups
									; (ShowMatchups; the next every 300 frames, A next, Y previous) and the
									; commentary (BuildScoutingText) scrolling, X restarts it; start leaves
	jsl.l ResetWorkBuf
	jsl.l CODE_C5E50E
	lda.w $1864
	cmp.w #$0001
	bne .1
	jsr.w CODE_C4F2AE
	rtl
.1:									; BG2VScroll = $0002, Y = $5C00, call CODE_C589E4, call CODE_C4BAF6, ...
	lda.w #$0002
	sta.w BG2VScroll
	ldy.w #$5C00
	jsl.l CODE_C589E4
	jsl.l CODE_C4BAF6
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldy.w #$0001
	ldx.w #$4C9F
	jsl.l PrintTitle
	lda.w #(DATA8_CF05D4+$5)&$FFFF
	ldx.w #(DATA8_CF05D4+$5)>>16
	jsl.l CODE_CF0134
	lda.w #$00A6
	jsl.l CODE_CF040B
	jsl.l CODE_CF03D0
	lda.w $17C9
	cmp.w #$001A
	bcc .2
	ldy.w #$2DC9
	jsr.w CODE_C4EF41
.2:									; if $17CB < $001A go to .3, Y = $3207, call CODE_C4EF41
	lda.w $17CB
	cmp.w #$001A
	bcc .3
	ldy.w #$3207
	jsr.w CODE_C4EF41
.3:									; call CODE_C4F2AE, $CF = $0018, $D1 = $0060, A = $17CB, ...
	jsr.w CODE_C4F2AE
	lda.w #$0018
	sta.b $CF
	lda.w #$0060
	sta.b $D1
	lda.w $17CB
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$000E
	jsl.l PrintThinCentred
	lda.w #$00A0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	lda.w $17C9
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$000E
	jsl.l PrintThinCentred
	jsl.l CODE_C4C2AA
	stz.b $22
	stz.b $24
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$1B,$49,$C0,$00		; inline parameters
	lda.w #$0400
	sta.b tmp1
	lda.w #$5800
	sta.b tmp0
	lda.w #TiledBackMap&$FFFF
	ldx.w #TiledBackMap>>16
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
	stx.b d7
	inc.b $38,x
	lda.w #$0025
	sta.b $1A
	lda.w #$0020
	sta.b $18
	lda.w #$0026
	jsl.l CreateSprite
	stx.b d6
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
	jsl.l CODE_C387D8
	ldy.w #$2C01
	ldx.w #$51C3
	jsl.l CODE_C387D8
	jsl.l CODE_C5A4B5
	jsl.l CODE_C5A4DE
	jsl.l CODE_C4CEDB
	lda.w #$0006
	sta.w $2DA5
	jsr.w ShowMatchups
	jsr.w CODE_C4E885
	jsr.w BuildScoutingText
	lda.w #$8000
	sta.w DMAEnShadow
	lda.w #$03E8
	sta.b a1
	lda.w #$0017
	sta.l TM
	stz.w fadestep
	lda.w #$012C
	sta.w $2DA1
	lda.w #$0019
	sta.w $2DA3
	jsr.w CODE_C4E3CB
.loop:								; loop: TransfersReady + 1
	inc.w TransfersReady
.loop2:								; loop: if TransfersReady is not 0 go to .loop2, call CODE_C36C2D, ...
	lda.w TransfersReady
	bne .loop2
	jsl.l CODE_C36C2D
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $2DA1
	bmi .6
	dec a
	bne .6
	jsr.w NextMatchup
	lda.w $2DA3
	sec
	sbc.w #$0005
	bmi .4
	bne .5
.4:									; A = $0001
	lda.w #$0001
.5:									; $2DA3 = A, A = $012C
	sta.w $2DA3
	lda.w #$012C
.6:									; $2DA1 = A, A = $2DA3, A - 1, if the result is not 0 go to .7, ...
	sta.w $2DA1
	lda.w $2DA3
	dec a
	bne .7
	jsr.w CODE_C4EBC8
	lda.w #$0019
.7:									; $2DA3 = A, if repeatdelayframes is not 0 go to .loop, A = $058D, ...
	sta.w $2DA3
	lda.w repeatdelayframes
	bne .loop
	lda.w $058D
	bit.w #$1000
	bne CODE_C4E387
	bit.w #$0400
	beq .8
	lda.w #$0001
	sta.w $2DA3
	lda.w #$0400
	trb.w $0565
.8:									; if $0800 bits clear go to .9, $2DA3 + 1, A = $0800
	bit.w #$0800
	beq .9
	inc.w $2DA3
	lda.w #$0800
	trb.w $0565
.9:									; if $0080 bits clear go to .10, A = $8000, call NextMatchup, go to .loop
	bit.w #$0080
	beq .10
	lda.w #$8000
	tsb.w $2DA1
	jsr.w NextMatchup
	jmp.w .loop
.10:								; if $4000 bits clear go to .11, A = $8000, call PrevMatchup, go to .loop
	bit.w #$4000
	beq .11
	lda.w #$8000
	tsb.w $2DA1
	jsr.w PrevMatchup
	jmp.w .loop
.11:								; if $0040 bits clear go to .12, call CODE_C4E3BF
	bit.w #$0040
	beq .12
	jsr.w CODE_C4E3BF
.12:								; go to .loop
	jmp.w .loop
CODE_C4E387:						; from ScoutingReport, CODE_C4EBC8
	jsl.l CODE_CF039E
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	jsl.l CODE_C4CEDB
	jsl.l ClearNMIHook
	jml.l CODE_C5E50E
NextMatchup:						; the next matchup of the scouting report (after 6, 0), then ShowMatchups
	lda.w $2DA5
	inc a
	cmp.w #$0007
	bcc .1
	lda.w #$0000
.1:									; $2DA5 = A, go to ShowMatchups
	sta.w $2DA5
	jmp.w ShowMatchups
PrevMatchup:						; the previous matchup of the scouting report (before 0, 6), then
									; ShowMatchups
	lda.w $2DA5
	bne .1
	lda.w #$0007
.1:									; A - 1, $2DA5 = A, go to ShowMatchups
	dec a
	sta.w $2DA5
	jmp.w ShowMatchups
CODE_C4E3BF:						; from ScoutingReport
	ldx.b $77
	jsl.l CODE_C5E596
	ldx.b $79
	jsl.l CODE_C5E596
CODE_C4E3CB:						; from ScoutingReport
	lda.b $7B
	sta.b $7D
	lda.w #$0012
	sta.w $2DC7
	lda.w #$0002
	sta.w $2DC5
	lda.w #$0010
	sta.b $95
	stz.b d5
	stz.b $69
	stz.b $69
	lda.b $D3
	clc
	adc.w #$0440
	ldy.w #$02C0
	jsl.l ClearRAM7E
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
ShowMatchups:						; draws matchup 0-6 of the scouting report (the two players, or the
									; goalies and Overall)
	lda.b $D3
	clc
	adc.w #$0140
	ldy.w #$0240
	jsl.l ClearRAM7E
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	ldx.b d7
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	ldx.b $9D
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	ldx.b d6
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	ldx.b $99
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	jsl.l MarkWorkBuf
	ldx.w $2DA5
	cpx.w #$0005
	bcc .2
	beq .1
	jmp.w .12
.1:									; go to .7
	jmp.w .7
.2:									; A = $2E36,x, A and $00FF, A - 1, A * 2, ...
	lda.w $2E36,x
	and.w #$00FF
	dec a
	asl a
	tay
	lda.w $2EA7,y
	sta.b a0
	and.w #$00FF
	sta.b $6D
	tax
	cmp.w #$00FF
	beq .3
	lda.w $2E75,y
	sta.b a2
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
	lda.b a0
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	adc.b a2
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	ply
	bra .4
.3:									; call CODE_C4EF07
	jsr.w CODE_C4EF07
.4:									; X = $2DA5, A = $3274,x, A and $00FF, A - 1, ...
	ldx.w $2DA5
	lda.w $3274,x
	and.w #$00FF
	dec a
	asl a
	tay
	lda.w $32E5,y
	sta.b a0
	and.w #$00FF
	sta.b $6D
	tax
	cmp.w #$00FF
	beq .5
	lda.w $32B3,y
	sta.b a2
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
	lda.b a0
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	adc.b a2
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	ply
	bra .6
.5:									; call CODE_C4EECD
	jsr.w CODE_C4EECD
.6:									; call CODE_C5BBBC, $CF = $0018, $D1 = $0050, a2 = $0002, ...
	jsl.l CODE_C5BBBC
	lda.w #$0018
	sta.b $CF
	lda.w #$0050
	sta.b $D1
	lda.w #$0002
	sta.b a2
	ldx.w $2DA5
	lda.w $3274,x
	and.w #$00FF
	dec a
	sta.b d0
	pha
	lda.w #$5DF9
	sta.b d4
	stz.b $91
	lda.w #$0001
	sta.l $7E24DC
	jsl.l CODE_C571C7
	jsl.l CODE_C5B676
	jsl.l CODE_C55EC3
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l PrintBoldCentredStr
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
	jsl.l PrintBoldLeftStr
	jsl.l CODE_C4CEDB
	lda.w #$00B0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	stz.b a2
	ldx.w $2DA5
	lda.w $2E36,x
	and.w #$00FF
	dec a
	sta.b d0
	pha
	lda.w #$5DF9
	sta.b d4
	stz.b $91
	lda.w #$0001
	sta.l $7E24DC
	jsl.l CODE_C571C7
	jsl.l CODE_C5B676
	jsl.l CODE_C55EC3
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l PrintBoldCentredStr
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
	jsl.l PrintBoldRightStr
	jsl.l CODE_C4CEDB
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w $2DA5
	asl a
	tax
	lda.l DATA8_C35E51,x
	tax
	ldy.w #$0007
	jsl.l PrintBoldCentred
	jsl.l CODE_C4CEDB
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	jsl.l RestoreWorkBuf
	rts
.7:									; a0 = $2EA7, A and $00FF, $6D = A, X = A, ...
	lda.w $2EA7
	sta.b a0
	and.w #$00FF
	sta.b $6D
	tax
	cmp.w #$00FF
	beq .8
	lda.w $2E75
	sta.b a2
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
	lda.b a0
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	adc.b a2
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	bra .9
.8:									; call CODE_C4EF07
	jsr.w CODE_C4EF07
.9:									; a0 = $32E5, A and $00FF, $6D = A, X = A, ...
	lda.w $32E5
	sta.b a0
	and.w #$00FF
	sta.b $6D
	tax
	cmp.w #$00FF
	beq .10
	lda.w $32B3
	sta.b a2
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
	lda.b a0
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	adc.b a2
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	bra .11
.10:								; call CODE_C4EECD
	jsr.w CODE_C4EECD
.11:								; call CODE_C5BBBC, $CF = $00B0, $D1 = $00E8, a2 = 0, ...
	jsl.l CODE_C5BBBC
	lda.w #$00B0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	stz.b a2
	stz.b d0
	lda.w #$F0C9
	sta.b d4
	lda.w #$0010
	sta.b $91
	lda.w #$0001
	sta.l $7E24DC
	jsl.l CODE_C571C7
	jsl.l CODE_C5B676
	jsl.l CODE_C55EC3
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l PrintBoldCentredStr
	ldx.w #$2EE1
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.w #$000C
	jsl.l PrintBoldRightStr
	jsl.l CODE_C4CEDB
	lda.w #$0018
	sta.b $CF
	lda.w #$0050
	sta.b $D1
	lda.w #$0002
	sta.b a2
	stz.b d0
	lda.w #$F0C9
	sta.b d4
	lda.w #$0010
	sta.b $91
	lda.w #$0001
	sta.l $7E24DC
	jsl.l CODE_C571C7
	jsl.l CODE_C5B676
	jsl.l CODE_C55EC3
	ldx.w #$04F5
	ldy.w #$000B
	jsl.l PrintBoldCentredStr
	ldx.w #$331F
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.w #$000C
	jsl.l PrintBoldLeftStr
	jsl.l CODE_C4CEDB
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$49B8
	ldy.w #$0007
	jsl.l PrintBoldCentred
	jsl.l CODE_C4CEDB
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	jsl.l RestoreWorkBuf
	rts
.12:								; $04F5 = 0, $364E = 0, X = $364E, Y = $3650, ...
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
	ldx.b d7
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	ldx.b $9D
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	ldx.b d6
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
	jsl.l PrintBoldCentred
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
	jsl.l PrintBoldCentredStr
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
	jsl.l PrintBoldCentredStr
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	rts
CODE_C4E885:						; from ScoutingReport
	stz.b a2
	ldy.w #$2DA9
	ldx.w #$2DC9
	jsr.w CODE_C4E8CD
	lda.w #$0002
	sta.b a2
	ldy.w #$2DB7
	ldx.w #$3207
	jsr.w CODE_C4E8CD
	ldx.w $17C9
	lda.w $2DB5
	sec
	sbc.w $2DC3
	bpl .1
	ldx.w $17CB
	eor.w #$FFFF
	inc a
.1:									; $2DA7 = X, X = A, A = $8000, if X >= $0008 go to .3, ...
	stx.w $2DA7
	tax
	lda.w #$8000
	cpx.w #$0008
	bcs .3
	cpx.w #$0004
	bcs .2
	ldx.w #$FFFF
	stx.w $2DA7
.2:									; A * 2
	asl a
.3:									; return
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
	sta.b a0
	lda.w #$0000
.1:									; push X, push A, push Y, d4 = $5DF9, ...
	phx
	pha
	phy
	ldy.w #$5DF9
	sty.b d4
	ldy.w #$0000
	cmp.w $0002,x
	bcs .2
	ldy.w #$F0C9
	sty.b d4
	ldy.w #$0010
.2:									; $91 = Y, d0 = A, $24DC = 0, call CODE_C571C7, ...
	sty.b $91
	sta.b d0
	stz.w $24DC
	jsl.l CODE_C571C7
	pha
	lda.b $05,s
	sta.b d0
	inc.w $24DC
	jsl.l CODE_C571C7
	sec
	sbc.b $01,s
	plx
	sta.b $65
	ply
	plx
	bit.w #$8000
	bne .6
	cmp.w $04F9
	bcs .3
	jmp.w .10
.3:									; if A >= $04F7 go to .4, $04F9 = A, A = X, A * 2, ...
	cmp.w $04F7
	bcs .4
	sta.w $04F9
	txa
	asl a
	sta.w $0004,y
	jmp.w .10
.4:									; $04F9 = $04F7, $0004,y = $0002,y, if $65 >= $04F5 go to .5, ...
	lda.w $04F7
	sta.w $04F9
	lda.w $0002,y
	sta.w $0004,y
	lda.b $65
	cmp.w $04F5
	bcs .5
	sta.w $04F7
	txa
	asl a
	sta.w $0002,y
	bra .10
.5:									; $04F7 = $04F5, $0002,y = $0000,y, $04F5 = $65, A = X, ...
	lda.w $04F5
	sta.w $04F7
	lda.w $0000,y
	sta.w $0002,y
	lda.b $65
	sta.w $04F5
	txa
	asl a
	sta.w $0000,y
	bra .10
.6:									; if A = $04FF go to .7, if carry set go to .10
	cmp.w $04FF
	beq .7
	bcs .10
.7:									; if A < $04FD go to .8, if zero go to .8, $04FF = A, A = X, ...
	cmp.w $04FD
	bcc .8
	beq .8
	sta.w $04FF
	txa
	asl a
	sta.w $000A,y
	bra .10
.8:									; $04FF = $04FD, $000A,y = $0008,y, if $65 < $04FB go to .9, ...
	lda.w $04FD
	sta.w $04FF
	lda.w $0008,y
	sta.w $000A,y
	lda.b $65
	cmp.w $04FB
	bcc .9
	beq .9
	sta.w $04FD
	txa
	asl a
	sta.w $0008,y
	bra .10
.9:									; $04FD = $04FB, $0008,y = $0006,y, $04FB = $65, A = X, ...
	lda.w $04FB
	sta.w $04FD
	lda.w $0006,y
	sta.w $0008,y
	lda.b $65
	sta.w $04FB
	txa
	asl a
	sta.w $0006,y
.10:								; A = $000C,y, A + $65, $000C,y = A, A = X, ...
	lda.w $000C,y
	clc
	adc.b $65
	sta.w $000C,y
	txa
	plx
	inc a
	cmp.b a0
	beq .rts
	jmp.w .1
.rts:								; return
	rts
BuildScoutingText:					; writes the scouting report's commentary into the text buffer: welcome to
									; a sold out ..., tonight's national hockey league game features the ...,
									; the hot and cold players
	jsl.l MarkWorkBuf
	stz.b $81
	ldx.w #$4DB9
	jsr.w AppendScoutText
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
	stx.b d0
	jsl.l CODE_C560A8
	jsr.w AppendScoutText
	ldx.w #$4DC8
	jsr.w AppendScoutText
	plx
	lda.w $17C9
	beq .1
	jsr.w AppendScoutText
.1:									; $364E,y = $0020, Y + 1, $81 = Y, X = d0, ...
	lda.w #$0020
	sta.w $364E,y
	iny
	sty.b $81
	ldx.b d0
	jsr.w AppendScoutText
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
	stx.b d0
	plx
	lda.w $17CB
	bne .2
	ldx.w #$4720
.2:									; call AppendScoutText, $364E,y = $0020, Y + 1, $81 = Y, ...
	jsr.w AppendScoutText
	lda.w #$0020
	sta.w $364E,y
	iny
	sty.b $81
	ldx.b d0
	jsr.w AppendScoutText
	lda.w #$203D
	sta.w $364E,y
	lda.w #$0039
	sta.w $3650,y
	iny
	iny
	iny
	lda.w $2DA7
	cmp.w #$FFFF
	beq .4
	sty.b $81
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsr.w AppendScoutText
	ldx.w #$4DED
	jsr.w AppendScoutText
	lda.w $2DA7
	bpl .3
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
.3:									; $81 = Y, X = $4DFA, call AppendScoutText
	sty.b $81
	ldx.w #$4DFA
	jsr.w AppendScoutText
.4:									; d0 = $2DC9, A = $17C9, X = $2DA9, call CODE_C4EB81, ...
	lda.w #$2DC9
	sta.b d0
	lda.w $17C9
	ldx.w #$2DA9
	jsr.w CODE_C4EB81
	lda.w #$3207
	sta.b d0
	lda.w $17CB
	cmp.w $17C9
	beq .5
	ldx.w #$2DB7
	jsr.w CODE_C4EB81
.5:									; X = $4E27, call AppendScoutText, $364E,y = $0000, Y + 1, ...
	ldx.w #$4E27
	jsr.w AppendScoutText
	lda.w #$0000
	sta.w $364E,y
	iny
	iny
	sty.b $81
	jsl.l RestoreWorkBuf
	tya
	jsl.l AllocWorkBuf
	sta.b $7B
	tax
	jsl.l MarkWorkBuf
	ldy.w #$0000
	sep #$20
.loop:								; loop: $0000,x = $364E,y, X + 1, Y + 1, if Y is not $81 go to .loop, ...
	lda.w $364E,y
	sta.w $0000,x
	inx
	iny
	cpy.b $81
	bne .loop
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
	adc.b d0
	adc.w #$0118
	tax
	bra CODE_C4EB6C
AppendScoutText:					; unpacks text X (UnpackText) and appends it to the scouting report's
									; text buffer
	jsl.l UnpackText
CODE_C4EB6C:						; from CODE_C4EB5C
	ldy.b $81
	sep #$20
.loop:								; loop: if $0000,x = 0 go to .1, $364E,y = A, X + 1, Y + 1, ...
	lda.w $0000,x
	beq .1
	sta.w $364E,y
	inx
	iny
	bra .loop
.1:									; A 16-bit, $81 = Y, return
	rep #$20
	sty.b $81
	rts
CODE_C4EB81:						; from BuildScoutingText
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
	jsr.w AppendScoutText
	lda.w #$2040
	sta.w $364E,y
	iny
	iny
	sty.b $81
	lda.b $01,s
	jsr.w CODE_C4EB23
	ldx.w #$4E06
	jsr.w AppendScoutText
	pla
	clc
	adc.w #$0006
	jsr.w CODE_C4EB23
	ldx.w #$4E17
	jmp.w AppendScoutText
CODE_C4EBC8:						; from ScoutingReport
	ldx.b $7D
	lda.w $2DC5
	cmp.w #$0021
	bcc .1
.loop:								; loop: call CODE_C4EC58
	jsr.w CODE_C4EC58
.1:									; A 8-bit
	sep #$20
.2:									; if $0000,x = 0 go to .4, X + 1, if $0000,x is not $39 go to .3, ...
	lda.w $0000,x
	beq .4
	inx
	cmp.b #$39
	bne .3
	rep #$20
	inc.b $7D
	jsr.w CODE_C4EC58
	bra .loop
.3:									; if A is not $20 go to .2
	cmp.b #$20
	bne .2
.4:									; A 16-bit, $81 = X, A = X, A - $7D, ...
	rep #$20
	stx.b $81
	txa
	sec
	sbc.b $7D
	beq .6
	sta.b d0
	clc
	adc.w $2DC5
	sta.w $2DC5
	cmp.w #$0022
	bcc .5
	jsr.w CODE_C4EC58
	lda.w $2DC5
	clc
	adc.b d0
	sta.w $2DC5
.5:									; X = $7D, Y = $0000, A 8-bit
	ldx.b $7D
	ldy.w #$0000
	sep #$20
.loop2:								; loop: $04F5,y = $0000,x, X + 1, Y + 1, if Y is not d0 go to .loop2, ...
	lda.w $0000,x
	sta.w $04F5,y
	inx
	iny
	cpy.b d0
	bne .loop2
	lda.b #$00
	sta.w $04F5,y
	rep #$20
	lda.b $95
	sta.b $CF
	ldy.w $2DC7
	ldx.w #$04F5
	jsl.l PrintBoldLeftStr
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
.rts:								; return
	rts
.6:									; if $23BA = 0 go to .rts, pull A, go to CODE_C4E387
	lda.w $23BA
	beq .rts
	pla
	jmp.w CODE_C4E387
CODE_C4EC58:						; from CODE_C4EBC8
	lda.w #$0002
	sta.w $2DC5
	lda.w #$0010
	sta.b $95
	lda.w $2DC7
	inc a
	cmp.w #$001A
	bcc .1
	inc.b d5
.1:									; if A < $001B go to .2, A = $0011
	cmp.w #$001B
	bcc .2
	lda.w #$0011
.2:									; $2DC7 = A, if d5 = 0 go to .rts, push X, call CODE_C55C54, ...
	sta.w $2DC7
	lda.b d5
	beq .rts
	phx
	jsl.l CODE_C55C54
	jsl.l CODE_C4CEDB
	plx
.rts:								; return
	rts
CODE_C4EC88:						; from ShowMatchups, ShowMatchups, ...
	sty.b d2
	stx.b $36
	sta.b r2
	lda.b [r2]
	sta.b d0
	jsl.l AllocWorkBuf
	pha
	sta.b r0
	lda.w #$007E
	sta.b $2E
	lda.b r2
	jsl.l Decompress
	lda.b $86
	and.w #$FF00
	sta.b d2
	lsr.b d2
	adc.b d2
	sta.b d2
	asl a
	adc.b d2
	sta.b d2
	adc.b $01,s
	sta.b r0
	sta.b $01,s
	lda.w #$0480
	sta.b d0
.1:									; Y = $0000, X = $364E
	ldy.w #$0000
	ldx.w #$364E
.2:									; $85 = $0006
	lda.w #$0006
	sta.b $85
.loop:								; loop: $0000,x = 0, $0010,x = 0, A 8-bit, $81 = [r0],y, ...
	stz.w $0000,x
	stz.w $0010,x
	sep #$20
	lda.b [r0],y
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
	lda.b [r0],y
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
	lda.b [r0],y
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
	lda.b [r0],y
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
	beq .3
	jmp.w .loop
.3:									; A = X, A - $00BE, X = A, if X = $365E go to .4, ...
	txa
	sec
	sbc.w #$00BE
	tax
	cpx.w #$365E
	beq .4
	jmp.w .2
.4:									; X = $364E, Y = r0, A = $00BF, r0 = Y, ...
	ldx.w #$364E
	ldy.b r0
	lda.w #$00BF
	mvn $7E,$7E
	sty.b r0
	lda.b d0
	sec
	sbc.w #$00C0
	sta.b d0
	beq .5
	jmp.w .1
.5:									; pull A, return
	pla
	rts
CODE_C4EE9D:						; from ScoutingReport and other segments
	lda.w #$0080
	sta.l VMAIN
	lda.w #$0004
	sta.b d0
	txa
	sta.l VMADDL
.loop:								; loop: call CODE_C4EEC0, Y = A, A = X, A + $0020, ...
	jsr.w CODE_C4EEC0
	tay
	txa
	clc
	adc.w #$0020
	tax
	sta.l VMADDL
	dec.b d0
	bpl .loop
CODE_C4EEC0:						; from CODE_C4EE9D
	tya
	ldy.w #$0005
.loop:								; loop: VMDATAL = A, A + 1, Y - 1, if the result >= 0 go to .loop, ...
	sta.l VMDATAL
	inc a
	dey
	bpl .loop
	rts
CODE_C4EECD:						; from ShowMatchups
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
	jsl.l AllocClearWorkBuf
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	ldx.b d7
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	ldx.b d6
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	rts
CODE_C4EF07:						; from ShowMatchups
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
	jsl.l AllocClearWorkBuf
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
CODE_C4EF41:						; from ScoutingReport
	cmp.w #$001A
	beq .1
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
.1:									; $00AC,y = $6D00, $00DE,y = $05CE, $00D4,y = $5E35, $0106,y = $01CD, ...
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
	sta.w r0
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
	sta.w tmp2
	pla
	sta.w tmp1
	pla
	sta.w tmp0
	rtl

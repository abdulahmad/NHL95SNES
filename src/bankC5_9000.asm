; Segment bankC5_9000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and a few data tables between routines.
org $C58FD8
CODE_C58FD8:						; called from other segments
	lda.b d6
	asl a
	asl a
	asl a
	adc.b a3
	tax
	phx
	lda.l $C30006,x
	tay
	lda.w $0000,y
	dec a
	bpl .1
	lda.l $C30004,x
	tax
	lda.l $C30000,x
	dec a
.1:									; $0000,y = A, pull X, if $C30008,x = 0 go to .2, X = A, ...
	sta.w $0000,y
	plx
	lda.l $C30008,x
	beq .2
	tax
	lda.l $C4FFFE,x
	beq CODE_C5904B
	dex
	phx
	pea.w $904C
	dec a
	pha
	rts
.2:									; go to CODE_C58F75
	jmp.w CODE_C58F75
CODE_C59012:						; called from other segments
	lda.b d6
	asl a
	asl a
	asl a
	adc.b a3
	tax
	phx
	lda.l $C30006,x
	tay
	lda.l $C30004,x
	tax
	lda.w $0000,y
	inc a
	cmp.l $C30000,x
	bcc .1
	lda.w #$0000
.1:									; $0000,y = A, pull X, if $C30008,x = 0 go to CODE_C5904D, X = A, ...
	sta.w $0000,y
	plx
	lda.l $C30008,x
	beq CODE_C5904D
	tax
	lda.l $C4FFFE,x
	beq CODE_C5904B
	dex
	phx
	pea.w $904C
	dec a
	pha
	rts
CODE_C5904B:						; from CODE_C58FD8, CODE_C59012
	dex
	phx
CODE_C5904D:						; from CODE_C59012
	jmp.w CODE_C58F75
DATA8_C59050:						; not reached by the traced code (data or unused code)
	db $68,$60
CODE_C59052:						; called from other segments
	ldx.b d7
	lda.w HomeTeam
	cmp.b $24,x
	beq .1
	lda.b $05,x
	sta.b $18
	lda.b $08,x
	sta.b $1A
	jsl.l DeleteSprite
	lda.w HomeTeam
	jsl.l CreateSprite
	stx.b d7
	jsr.w CODE_C5A4B9
.1:									; X = $9D, if VisTeam = $24,x go to .rts, $18 = $05,x, $1A = $08,x, ...
	ldx.b $9D
	lda.w VisTeam
	cmp.b $24,x
	beq .rts
	lda.b $05,x
	sta.b $18
	lda.b $08,x
	sta.b $1A
	jsl.l DeleteSprite
	lda.w VisTeam
	jsl.l CreateSprite
	stx.b $9D
	lda.w #$0001
	sta.b $38,x
	jsr.w CODE_C5A4E2
.rts:								; return
	rts
CODE_C5909A:						; called from other segments
	lda.w $010E
SetRowPalette3:						; sets palette 3 on the 64 text map tiles from row A (two rows of 32)
	xba
	lsr a
	lsr a
	adc.b $D3
	tay
	ldx.w #$003F
.loop:								; loop: A = $0000,y, A and $E3FF, A or $0C00, $0000,y = A, ...
	lda.w $0000,y
	and.w #$E3FF
	ora.w #$0C00
	sta.w $0000,y
	iny
	iny
	dex
	bpl .loop
	rts
CODE_C590B8:						; from CODE_C59308
	lda.w $010E
SetRowPalette0:						; sets palette 0 on the 64 text map tiles from row A (two rows of 32),
									; then SendTextMap
	xba
	lsr a
	lsr a
	adc.b $D3
	tay
	ldx.w #$003F
.loop:								; loop: A = $0000,y, A and $E3FF, A or $0000, $0000,y = A, ...
	lda.w $0000,y
	and.w #$E3FF
	ora.w #$0000
	sta.w $0000,y
	iny
	iny
	dex
	bpl .loop
	jsl.l SendTextMap
	rts
setoptions:							; builds the game setup screen: its graphics and HDMA, then the Game Setup
									; page
	jsl.l CODE_C58D05
	jsl.l FadeOutWait
	lda.w #$0001
	sta.w $059E
	jsl.l ResetTransferQueues
	jsl.l ResetWorkBuf
	lda.w #$007F
	sta.b $2E
	lda.w #$D80A
	sta.b r0
	lda.w #TeamPalettes&$FFFF
	ldx.w #TeamPalettes>>16
	jsl.l Decompress
	ldy.w #$5000
	jsl.l QueueClearVRAM
	ldy.w #$0000
	jsl.l QueueClearVRAM
	jsl.l WaitTransfers
	lda.w #GradientBarTiles&$FFFF
	ldx.w #GradientBarTiles>>16
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
	stz.w DMAEnShadow
	jsl.l WaitTransfers
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$1B,$49,$C0,$00		; inline parameters
	ldx.w #$0060
	jsl.l SetupHDMA
	db $42,$12,$8C,$46,$7E,$7E		; inline parameters
	jsr.w CODE_C5ABC4
	lda.w #$0400
	sta.b tmp1
	lda.w #$5800
	sta.b tmp0
	lda.w #TiledBackMap&$FFFF
	ldx.w #TiledBackMap>>16
	ldy.w #$2000
	jsr.w MapSetToVRAMBody
	sep #$20
	pea.w $7E80
	plb
	lda.b #$17
	sta.w TM
	lda.b #$09
	sta.w BGMODE
	lda.b #$03
	sta.w OBSEL
	plb
	rep #$20
	lda.w #$3100
	sta.b tmp2
	lda.w #$3000
	sta.b tmp1
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	pea.w $0080
	pea.w $00C0
	pea.w $3F02
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l InitTextMap
	lda.w #$56CE
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	lda.w #BlueColoursHook&$FFFF
	ldx.w #BlueColoursHook>>16
	jsl.l SetNMIHook
	jsl.l ResetSprites
	jsr.w CODE_C5C0BE
	lda.w #$0008
	sta.b $18
	lda.w #$008C
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b a0
	jsr.w CODE_C59217
	lda.w #$00D7
	sta.b $18
	lda.w #$00D0
	sta.b $1A
	lda.w #$0020
	jsl.l CreateSprite
	jsr.w CODE_C592A9
	jsl.l WaitTransfers
	lda.w #$C000
	sta.w DMAEnShadow
	lda.w #$2C46
	ldy.w #$0078
	jsl.l ClearRAM7E
	jsl.l UpdateMenuSpritesTwice
	rts
CODE_C59217:						; from setoptions
	lda.w #$0010
	sta.b $18
	lda.w #$0079
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b a4
	lda.w #$0001
	jsl.l SetSpriteAnim
	lda.w #$00C4
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $75
	inc.b $38,x
	lda.w #$0002
	jsl.l SetSpriteAnim
	rts
DATA8_C59249:						; not reached by the traced code (data or unused code)
	db $00,$00,$AD,$06,$19,$8F,$45,$60,$30,$D0,$23,$AD,$08,$19,$D0,$1E
	db $1A,$8D,$08,$19,$D4,$97,$AD,$0E,$01,$48,$1A,$1A,$8D,$0E,$01,$E6
	db $97,$20,$75,$8F,$20,$9A,$90,$68,$8D,$0E,$01,$68,$85,$97,$60,$00
	db $00,$AD,$08,$19,$8F,$47,$60,$30,$D0,$23,$AD,$06,$19,$D0,$1E,$1A
	db $8D,$06,$19,$D4,$97,$AD,$0E,$01,$48,$3A,$3A,$8D,$0E,$01,$C6,$97
	db $20,$75,$8F,$20,$9A,$90,$68,$8D,$0E,$01,$68,$85,$97,$60,$00,$00
CODE_C592A9:						; from setoptions
	lda.w OptPlayMode
	beq .1
	dec a
	beq .1
	jsr.w CODE_C5E41D
.1:									; if OptPlayMode is not $0003 go to .3, ...
	lda.w OptPlayMode
	cmp.w #$0003
	bne .3
	lda.w VisTeam
	cmp.w HomeTeam
	bne .3
	inc a
	cmp.w #$001A
	bcc .2
	lda.w #$0000
.2:									; VisTeam = A, SRVisTeam = A, call CODE_C5A3C1
	sta.w VisTeam
	sta.l SRVisTeam
	jsr.w CODE_C5A3C1
.3:									; A = $0480, A + $D3, Y = $0200, call ClearRAM7E, ...
	clc
	lda.w #$0480
	adc.b $D3
	ldy.w #$0200
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.w OptPlayMode
	asl a
	tax
	lda.l DATA8_C592FA,x
	jsl.l CODE_C59308
	rts
DATA8_C592FA:						; not reached by the traced code (data or unused code)
	db $CD,$5B,$87,$5C,$17,$5C,$51,$5C,$6B,$5C,$6B,$5C,$7D,$5C
CODE_C59308:						; from CODE_C592A9
	tax
	sta.b a3
	pei ($D5)
	lda.w #$2C00
	sta.b $D5
	lda.l $C30000,x
	sta.b $69
	dec a
	sta.b tmp0
	stz.b d6
	stz.b $99
	lda.w #$0003
	cmp.b tmp0
	bcs .1
	sta.b tmp0
.1:									; Y = $0010
	ldy.w #$0010
.2:									; push Y, push X, $CF = $0010, A = $C30002,x, ...
	phy
	phx
	lda.w #$0010
	sta.b $CF
	lda.l $C30002,x
	tax
	jsl.l PrintItalicLeft
	plx
	phx
	lda.w #$0094
	sta.b $CF
	lda.l $C30006,x
	tay
	lda.w $0000,y
	inc a
	asl a
	adc.l $C30004,x
	tax
	lda.l $C30000,x
	tax
	lda.b $03,s
	tay
	lda.w OptPlayMode
	cmp.w #$0007
	bne .3
	jsl.l PrintItalicRight
	bra .4
.3:									; call PrintItalicCentred
	jsl.l PrintItalicCentred
.4:									; pull X, pull Y, Y + 1, Y + 1, ...
	plx
	ply
	iny
	iny
	clc
	txa
	adc.w #$0008
	tax
	dec.b tmp0
	bpl .2
	pla
	sta.b $D5
	ldx.b a4
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	ldx.b $75
	lda.b $22,x
	and.w #$FFFE
	ldy.b $69
	cpy.w #$0005
	bcc .5
	ora.w #$0001
.5:									; $22,x = A, call CODE_C590B8, return
	sta.b $22,x
	jsr.w CODE_C590B8
	rtl
DATA8_C5939C:						; not reached by the traced code (data or unused code)
	db $F0
CODE_C5939D:						; called from other segments
	stz.w OptLine
	stz.w OptPen
	lda.w $1906
	inc a
	sta.b d0
	lda.w $1908
	inc a
	sta.b $81
	bra SetContTeams
CODE_C593B1:						; called from other segments
	lda.w #$0005
	sta.b d0
	sta.b $81
SetContTeams:						; the controller setup: each pad's icon is moved to a team; on start /
									; select its place sets cont1team (0 none, 1, 2)
	stz.b d1
	stz.b $85
	jsr.w ControllerSetupScreen
.loop:								; loop: call ReadPads, call WaitTransfers, $26 + 1, ...
	jsl.l ReadPads
	jsl.l WaitTransfers
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsr.w CODE_C5945E
	jsr.w CODE_C59483
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	lda.l $7E23BA
	bne .1
	lda.b $7D
	bit.w #$3000
	beq .loop
.1:									; Y = $0008
	ldy.w #$0008
.loop2:								; loop: X = $73,y, cont1team,y = $0000, A = $22,x, A / 2, ...
	ldx.b $73,y
	lda.w #$0000
	sta.w cont1team,y
	lda.b $22,x
	lsr a
	bcc .3
	lda.b $05,x
	cmp.w #$0080
	beq .3
	lda.w #$0002
	bcc .2
	dec a
.2:									; cont1team,y = A
	sta.w cont1team,y
.3:									; Y - 1, Y - 1, if the result >= 0 go to .loop2, call UserNameEntry, ...
	dey
	dey
	bpl .loop2
	jsr.w UserNameEntry
	lda.w OptPlayMode
	jsl.l SoundVolumeDown
	jsl.l FadeOutWait
	jsl.l forceblack
	jsl.l ResetSprites
	lda.w #$0040
	sta.b $20
	lda.w #$0044
	sta.b $1E
	lda.w #$001D
	jsl.l CreateSpriteSharePal
	lda.w #$0081
	sta.w $17CD
	jsl.l CODE_C5EE6C
	lda.w #$0080
	sta.w $17CF
	jsl.l CODE_C5EE6C
	lda.w #$FFFF
	sta.b $0A,x
	stz.b $20
	stz.b $1E
	jml.l ResetWorkBuf
CODE_C5945E:						; from SetContTeams
	ldy.w #$0004
.loop:								; loop: push Y, A = mp5padsig,y, A and $00FF, A - 1, ...
	phy
	lda.w mp5padsig,y
	and.w #$00FF
	dec a
	tax
	tya
	asl a
	tay
	cpx.w #$0001
	ldx.b $73,y
	lda.b $22,x
	ora.w #$0001
	bcc .1
	and.w #$FFFE
.1:									; $22,x = A, pull Y, Y - 1, if the result >= 0 go to .loop, ...
	sta.b $22,x
	ply
	dey
	bpl .loop
	rts
CODE_C59483:						; from SetContTeams
	stz.b $7D
	lda.w PadRaw1
	cmp.w padlast
	beq .1
	ldx.b a4
	jsr.w CODE_C594C6
.1:									; if PadRaw2 = $0567 go to .2, X = $75, call CODE_C594C6
	lda.w PadRaw2
	cmp.w $0567
	beq .2
	ldx.b $75
	jsr.w CODE_C594C6
.2:									; if $00C5 = $0569 go to .3, X = $77, call CODE_C594C6
	lda.w $00C5
	cmp.w $0569
	beq .3
	ldx.b $77
	jsr.w CODE_C594C6
.3:									; if $00C7 = $056B go to .4, X = $79, call CODE_C594C6
	lda.w $00C7
	cmp.w $056B
	beq .4
	ldx.b $79
	jsr.w CODE_C594C6
.4:									; if $00C9 = $056D go to .rts, X = $7B, go to CODE_C594C6
	lda.w $00C9
	cmp.w $056D
	beq .rts
	ldx.b $7B
	bra CODE_C594C6
.rts:								; return
	rts
CODE_C594C6:						; from CODE_C59483, CODE_C59483, ...
	tsb.b $7D
	bit.w #$0100
	beq .5
	lda.b $05,x
	cmp.w #$0080
	bcc .1
	lda.b d1
	cmp.b d0
	bcs .rts
	lda.b $05,x
	bra .2
.1:									; $85 - 1
	dec.b $85
.2:									; A + $0040, if A is not $00C0 go to .3, d1 + 1
	adc.w #$0040
	cmp.w #$00C0
	bne .3
	inc.b d1
.3:									; if A >= $00C1 go to .rts
	cmp.w #$00C1
	bcs .rts
.4:									; $05,x = A, return
	sta.b $05,x
	rts
.5:									; if $0200 bits clear go to .rts, if $05,x < $0081 go to .6, d1 - 1, ...
	bit.w #$0200
	beq .rts
	lda.b $05,x
	cmp.w #$0081
	bcc .6
	dec.b d1
	bra .7
.6:									; if $85 >= $81 go to .rts, A = $05,x
	lda.b $85
	cmp.b $81
	bcs .rts
	lda.b $05,x
	sec
.7:									; A - $0040, if A is not $0040 go to .8, $85 + 1
	sbc.w #$0040
	cmp.w #$0040
	bne .8
	inc.b $85
.8:									; if A >= $003F go to .4
	cmp.w #$003F
	bcs .4
.rts:								; return
	rts
ControllerSetupScreen:				; builds the controller setup screen: a sprite for each pad and the
									; Controller Setup page
	ldx.b a0
	jsl.l DeleteSprite
	ldx.b a4
	jsl.l DeleteSprite
	ldx.b $75
	jsl.l DeleteSprite
	jsr.w RefreshSprites
	lda.w #$0003
	sta.b $1E
	inc.b $20
	lda.w #$0080
	sta.b $18
	lda.w #$00C8
	sta.b $1A
	ldy.w #$0008
.loop:								; loop: push Y, A = $001D, call CreateSprite, pull Y, ...
	phy
	lda.w #$001D
	jsl.l CreateSprite
	ply
	stx.b $73,y
	lda.b $1A
	sbc.w #$000F
	sta.b $1A
	tya
	lsr a
	jsl.l SetSpriteAnim
	dey
	dey
	bpl .loop
	stz.b $1E
	stz.b $20
	lda.b $D3
	ldy.w #$0340
	jsl.l ClearRAM7E
	clc
	lda.b $D3
	adc.w #$03C0
	ldy.w #$0340
	jsl.l ClearRAM7E
	lda.w #$57FC
	jsl.l PrintTextPage
	lda.w #$0005
	sta.w fadestep
	rts
StartSeason:						; play mode Season: with a season saved, WARNING A Season is in progress
									; ... Continue Old / Start New (screen state 13); else straight to the
									; League Menu (SeasonOptions)
	lda.l SeasonDay
	ora.l SRDayPlayed
	bne .1
	jmp.w CODE_C5963A
.1:									; Y = $0280, A = $D3, A + $0400, call ClearRAM7E, ...
	ldy.w #$0280
	lda.b $D3
	clc
	adc.w #$0400
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	lda.w #$8000
	sta.w DMAEnShadow
	lda.w #$FFFF
	sta.w BG3VScroll
	jsl.l WaitTransfers
	jsr.w CODE_C5A50B
	jsr.w RefreshSprites
	lda.w #$0005
	sta.w $18DE
	lda.w #$0008
	sta.b $CF
	ldy.w #$0010
	ldx.w #$479B
	jsl.l PrintItalicLeft
	lda.w #$005C
	sta.b $CF
	ldy.w #$0010
	ldx.w #$4724
	jsl.l PrintBoldLeft
	ldy.w #$0011
	ldx.w #$4735
	jsl.l PrintBoldLeft
	ldy.w #$0012
	ldx.w #$4743
	jsl.l PrintBoldLeft
	ldy.w #$0013
	ldx.w #$4753
	jsl.l PrintBoldLeft
	lda.w #$0009
	sta.w $18DE
	lda.w #$0032
	sta.b $CF
	ldy.w #$0015
	ldx.w #$4764
	jsl.l PrintItalicLeft
	ldy.w #$0018
	ldx.w #$476E
	jsl.l PrintItalicLeft
	ldx.b a0
	lda.w #$0028
	sta.b $05,x
	lda.w #$00B5
	sta.b $08,x
	lda.w #$0018
	jsr.w SetRowPalette3
	jsl.l SendTextMap
	lda.w #$000D
	sta.b $99
	bra CODE_C59651
CODE_C5963A:						; from StartSeason
	jsl.l FadeOutWait
	jsr.w SeasonOptions
	bra CODE_C59651
CreatePlayer:						; play mode Make Player: CheckCreateSlots, the Create Player page
									; (DrawNameEntry), then the front end's screen states (NameEntry first)
	jsl.l FadeOutWait
	jsl.l CheckCreateSlots
	jsr.w DrawNameEntry
	stz.w fadestep
CODE_C59651:						; from CODE_C59651, StartSeason, CODE_C5963A
	jsl.l WaitTransfers
	jsl.l ReadMenuPads
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	lda.b $99
	asl a
	tax
	jsr (DATA8_C5967A,x)
	bra CODE_C59651
DATA8_C5967A:						; the front end screen handlers, one per screen state (CODE_C59651 runs
									; the one of the current state each frame)
	dw NameEntry,NameEntry,AskNameOk,EditPlayerInfo
	dw ModifyRatings,CODE_C59767,SeasonOptionsInput,GamesTodayInput
	dw LeagueLeadersInput,SeasonTeamStatsInput,SeasonPlayerStatsInput,StandingsInput
	dw NoGameSelectedInput,StartSeasonInput
AskNameOk:							; Is the player name ok: up / down Yes / No; start: No starts over
									; (CreatePlayer), Yes draws the position, weight, number and hand page
									; (screen state 3)
	lda.w repeatdelayframes
	beq .1
	rts
.1:									; A = padchangeany, if a $0400 bit set go to CODE_C596C0, ...
	lda.w padchangeany
	bit.w #$0400
	bne CODE_C596C0
	bit.w #$0800
	bne CODE_C596AF
	bit.w #$1000
	bne CODE_C596D3
	rts
CODE_C596AF:						; from AskNameOk, NameEntry
	stz.b d6
	lda.w #$0012
	jsr.w SetRowPalette3
	lda.w #$000F
	jsr.w SetRowPalette0
CODE_C596BD:						; from CODE_C596C0
	jmp.w CODE_C5A164
CODE_C596C0:						; from AskNameOk
	lda.w #$0001
	sta.b d6
	lda.w #$000F
	jsr.w SetRowPalette3
	lda.w #$0012
	jsr.w SetRowPalette0
	bra CODE_C596BD
CODE_C596D3:						; from AskNameOk
	lda.b d6
	beq .1
	pla
	jmp.w CreatePlayer
.1:									; call FadeOutWait, $99 + 1, A = $4672, A and $00FF, ...
	jsl.l FadeOutWait
	inc.b $99
	lda.w $4672
	and.w #$00FF
	dec a
	ldx.w #$4673
	ldy.w #mesarea
	mvn $7E,$7E
	lda.w #$0020
	sta.w $0000,y
	iny
	ldx.w #$467D
	lda.w $467C
	and.w #$00FF
	mvn $7E,$7E
	lda.b $D3
	ldy.w #$0700
	jsl.l ClearRAM7E
	ldy.w #$5C00
	jsl.l QueueClearVRAM
	lda.w #$5746
	jsl.l PrintTextPage
	lda.w #$0010
	sta.b $CF
	ldx.w #mesarea
	ldy.w #$0002
	jsl.l PrintTitleStr
	jsl.l SendTextMap
	stz.b d0
	stz.b $85
	lda.w #$0032
	sta.b d1
	lda.w #$0008
	sta.b $81
	stz.b d6
	lda.w #$0078
	sta.b $CF
	jsr.w CODE_C5A291
	jsr.w CODE_C5A2B4
	jsr.w CODE_C5A2D3
	jsr.w CODE_C5A2EC
	lda.w #$0005
	sta.w fadestep
	lda.w #$000B
	jsr.w SetRowPalette3
	lda.w #$000E
	jsr.w SetRowPalette3
	lda.w #$0011
	jmp.w SetRowPalette3
CODE_C59767:						; from DATA8_C5967A, NameEntry
	rts
NameEntry:							; Create Player name entry, screen states 0 and 1 (first and last name):
									; pad to a letter, B to select, Y to go back, start when done, X cancels;
									; after the last name it asks Is the player name ok
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc CODE_C59767
	lda.w #$0010
	sta.w repeatdelayframes
.1:									; A = padchangeany, if a $0800 bit set go to .4, ...
	lda.w padchangeany
	bit.w #$0800
	bne .4
	bit.w #$0400
	bne .3
	bit.w #$0200
	bne .7
	bit.w #$0100
	bne .8
	bit.w #$8080
	bne .12
	bit.w #$4030
	bne .9
	bit.w #$1000
	beq .2
	jmp.w .15
.2:									; if $0040 bits clear go to .rts, go to CODE_C59D3B
	bit.w #$0040
	beq .rts
	jmp.w CODE_C59D3B
.rts:								; return
	rts
.3:									; call CODE_C5A17B, A = d6, A + $0009, if A < $001B go to .5, ...
	jsr.w CODE_C5A17B
	clc
	lda.b d6
	adc.w #$0009
	cmp.w #$001B
	bcc .5
	sbc.w #$001B
	sta.b d6
	jmp.w CODE_C5A20D
.4:									; call CODE_C5A17B, A = d6, A - $0009, if carry set go to .5, ...
	jsr.w CODE_C5A17B
	sec
	lda.b d6
	sbc.w #$0009
	bcs .5
	adc.w #$001B
.5:									; d6 = A
	sta.b d6
.6:									; go to CODE_C5A20D
	jmp.w CODE_C5A20D
.7:									; call CODE_C5A17B, d6 - 1, if the result >= 0 go to .6, A = $001A, ...
	jsr.w CODE_C5A17B
	dec.b d6
	bpl .6
	lda.w #$001A
	bra .5
.8:									; call CODE_C5A17B, A = d6, A + 1, if A < $001B go to .5, ...
	jsr.w CODE_C5A17B
	lda.b d6
	inc a
	cmp.w #$001B
	bcc .5
	stz.b d6
	bra .6
.9:									; A, X / Y 8-bit, A = $3E, Y = $69, Y - 1, ...
	sep #$30
	lda.b #$3E
	ldy.b $69
	dey
	cpy.b a3
	bne .10
	cmp.w mesarea,y
	bne .11
.10:								; if a3 = 0 go to .11, Y - 1
	ldy.b a3
	beq .11
	dey
.11:								; mesarea,y = A, a3 = Y, go to .14
	sta.w mesarea,y
	sty.b a3
	bra .14
.12:								; A, X / Y 8-bit, X = d6, A = DATA8_C598FA,x, if a3 = 0 go to .13, ...
	sep #$30
	ldx.b d6
	lda.l DATA8_C598FA,x
	ldy.b a3
	beq .13
	lda.l $C59915,x
.13:								; mesarea,y = A, Y + 1, if Y >= $69 go to .14, a3 = Y
	sta.w mesarea,y
	iny
	cpy.b $69
	bcs .14
	sty.b a3
.14:								; A, X / Y 16-bit, A = $000F, Y = $71, X = mesarea, ...
	rep #$30
	lda.w #$000F
	ldy.b $71
	ldx.w #mesarea
	jsl.l PrintItalicFixedLeftStr
	jsl.l WaitTransfers
	rts
.15:								; if a3 is not 0 go to .16, return
	lda.b a3
	bne .16
	rts
.16:								; if $99 is not 0 go to .17, $99 + 1, call CODE_C598C9, ...
	lda.b $99
	bne .17
	inc.b $99
	jsr.w CODE_C598C9
	jsr.w CODE_C598EB
	tyx
	stz.w mesarea,x
	tya
	sta.w $4672
	ldx.w #mesarea
	ldy.w #$4673
	mvn $7E,$7E
	ldy.b $71
	ldx.w #$4673
	jsl.l PrintItalicLeftStr
	jsl.l SendTextMap
	lda.w #$3E3E
	sta.w mesarea
	sta.w mesarea+2
	sta.w mesarea+4
	sta.w mesarea+6
	sta.w mesarea+8
	stz.w mesarea+10
	lda.w #$0008
	sta.b $71
	lda.w #$000A
	sta.b $69
	stz.b a3
	jsl.l WaitTransfers
	rts
.17:								; call CODE_C598C9, call CODE_C598EB, X = Y, mesarea,x = 0, ...
	jsr.w CODE_C598C9
	jsr.w CODE_C598EB
	tyx
	stz.w mesarea,x
	tya
	sta.w $467C
	ldx.w #mesarea
	ldy.w #$467D
	mvn $7E,$7E
	ldy.b $71
	ldx.w #$467D
	jsl.l PrintItalicLeftStr
	ldy.w #$0200
	clc
	lda.b $D3
	adc.w #$0300
	jsl.l ClearRAM7E
	jsl.l WaitTransfers
	lda.w #$56DC
	jsl.l PrintTextPage
	inc.b $99
	jmp.w CODE_C596AF
CODE_C598C9:						; from NameEntry
	lda.b $71
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$001E
	pha
	ldy.w #$0022
	phy
	jsl.l ClearRAM7E
	ply
	pla
	clc
	adc.w #$0040
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	rts
CODE_C598EB:						; from NameEntry
	sep #$30
	ldy.b a3
	lda.b #$3E
	cmp.w mesarea,y
	beq .1
	iny
.1:									; A, X / Y 16-bit, return
	rep #$30
	rts
DATA8_C598FA:						; not reached by the traced code (data or unused code)
	db $41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50
	db $51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$3D,$61,$62,$63,$64,$65
	db $66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$70,$71,$72,$73,$74,$75
	db $76,$77,$78,$79,$7A,$3D
ModifyRatings:						; Create Player screen state 4: the goalie or skater ratings (up / down
									; pick, left / right change); start stores the player in save RAM
									; (SaveCreatedPlayer), X cancels
	jsr.w CODE_C59938
	jsl.l SendTextMap
	rts
CODE_C59938:						; from ModifyRatings
	lda.b d0
	beq .1
	jsr.w CODE_C59998
	lda.w #$0007
	bra .2
.1:									; X = a0, A = d6, A * 2, A * 2, ...
	ldx.b a0
	lda.b d6
	asl a
	asl a
	asl a
	adc.w #$0046
	sta.b $08,x
	lda.w #$0010
	sta.b $05,x
	jsr.w CODE_C59ADD
	lda.w #$0008
.2:									; A + d6, A / 2, A / 2, A + $D3, ...
	clc
	adc.b d6
	xba
	lsr a
	lsr a
	adc.b $D3
	tax
	ldy.w #$001F
.loop:								; loop: A = $7E0000,x, A and $E3FF, $7E0000,x = A, X + 1, ...
	lda.l $7E0000,x
	and.w #$E3FF
	sta.l $7E0000,x
	inx
	inx
	dey
	bpl .loop
	rts
CODE_C59978:						; from CODE_C59ABF, CODE_C59ADD, CODE_C59ACC
	clc
	adc.b d6
	xba
	lsr a
	lsr a
	adc.b $D3
	tax
	ldy.w #$001F
.loop:								; loop: A = $7E0000,x, A and $E3FF, A or $0C00, $7E0000,x = A, ...
	lda.l $7E0000,x
	and.w #$E3FF
	ora.w #$0C00
	sta.l $7E0000,x
	inx
	inx
	dey
	bpl .loop
CODE_C59997:						; from CODE_C59998
	rts
CODE_C59998:						; from CODE_C59938
	ldx.b a0
	lda.b d6
	asl a
	asl a
	asl a
	adc.w #$003E
	sta.b $08,x
	lda.w #$0010
	sta.b $05,x
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc CODE_C59997
	lda.w #$0010
	sta.w repeatdelayframes
.1:									; A = padchangeany, if $0040 bits clear go to .2, go to CODE_C59D39
	lda.w padchangeany
	bit.w #$0040
	beq .2
	jmp.w CODE_C59D39
.2:									; if $0800 bits clear go to .3, go to CODE_C59ABF
	bit.w #$0800
	beq .3
	jmp.w CODE_C59ABF
.3:									; if $0400 bits clear go to .4, go to CODE_C59ACC
	bit.w #$0400
	beq .4
	jmp.w CODE_C59ACC
.4:									; if a $0200 bit set go to CODE_C599E7, ...
	bit.w #$0200
	bne CODE_C599E7
	bit.w #$0100
	bne CODE_C59A4B
	bit.w #$1000
	beq .rts
	jmp.w SaveCreatedPlayer
.rts:								; return
	rts
CODE_C599E7:						; from CODE_C59ADD, CODE_C59998
	lda.b d6
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$01F2
	ldx.b d0
	bne .1
	adc.w #$0040
.1:									; X = A, $0000,x = 0, $0002,x = 0, $0004,x = 0, ...
	tax
	stz.w $0000,x
	stz.w $0002,x
	stz.w $0004,x
	stz.w $0006,x
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.b d6
	asl a
	tax
	lda.w $0527,x
	dec a
	bpl .2
	sec
	lda.b d2
	sbc.w #$0005
	sta.b d2
	lda.w #$0000
.2:									; $0527,x = A, push A, call CODE_C59AB0, pull A, ...
	sta.w $0527,x
	pha
	jsr.w CODE_C59AB0
	pla
	asl a
	tax
	clc
	lda.b d2
	adc.w #$0005
	sta.b d2
	lda.b d6
	clc
	adc.w #$0007
	tay
	lda.b d0
	bne .3
	iny
.3:									; X = mesarea, call PrintBoldRightStr, go to PrintCreatedOverall
	ldx.w #mesarea
	jsl.l PrintBoldRightStr
	jmp.w PrintCreatedOverall
DATA8_C59A4A:						; not reached by the traced code (data or unused code)
	db $60
CODE_C59A4B:						; from CODE_C59ADD, CODE_C59998
	lda.b d6
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$01F2
	ldx.b d0
	bne .1
	adc.w #$0040
.1:									; X = A, $0000,x = 0, $0002,x = 0, $0004,x = 0, ...
	tax
	stz.w $0000,x
	stz.w $0002,x
	stz.w $0004,x
	stz.w $0006,x
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.b d6
	asl a
	tax
	lda.w $0527,x
	cmp.w #$000F
	bcs .2
	asl a
	tax
	lda.b d2
	sec
	sbc.w #$0005
	bmi .2
	sta.b d2
	lda.b d6
	asl a
	tax
	inc.w $0527,x
.2:									; A = d6, A * 2, X = A, A = $0527,x, ...
	lda.b d6
	asl a
	tax
	lda.w $0527,x
	jsr.w CODE_C59AB0
	lda.b d6
	clc
	adc.w #$0007
	tay
	lda.b d0
	bne .3
	iny
.3:									; X = mesarea, call PrintBoldRightStr, go to PrintCreatedOverall
	ldx.w #mesarea
	jsl.l PrintBoldRightStr
	jmp.w PrintCreatedOverall
CODE_C59AB0:						; from CODE_C599E7, CODE_C59A4B
	sta.b tmp1
	asl a
	asl a
	adc.b tmp1
	adc.w #$0019
	jsr.w BinToBCD
	jmp.w BCDText
CODE_C59ABF:						; from CODE_C59998
	lda.w #$0007
	jsr.w CODE_C59978
	dec.b d6
	bpl CODE_C59ACB
	stz.b d6
CODE_C59ACB:						; from CODE_C59ABF, CODE_C59ACC
	rts
CODE_C59ACC:						; from CODE_C59998
	lda.w #$0007
	jsr.w CODE_C59978
	lda.b d6
	inc a
	cmp.w #$000B
	bcs CODE_C59ACB
	sta.b d6
CODE_C59ADC:						; from CODE_C59ADD
	rts
CODE_C59ADD:						; from CODE_C59938
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc CODE_C59ADC
	lda.w #$0010
	sta.w repeatdelayframes
.1:									; A = padchangeany, if $0040 bits clear go to .2, go to CODE_C59D39
	lda.w padchangeany
	bit.w #$0040
	beq .2
	jmp.w CODE_C59D39
.2:									; if a $0800 bit set go to .5, if a $0400 bit set go to .6, ...
	bit.w #$0800
	bne .5
	bit.w #$0400
	bne .6
	bit.w #$0200
	beq .3
	jmp.w CODE_C599E7
.3:									; if $0100 bits clear go to .4, go to CODE_C59A4B
	bit.w #$0100
	beq .4
	jmp.w CODE_C59A4B
.4:									; if a $1000 bit set go to SaveCreatedPlayer, return
	bit.w #$1000
	bne SaveCreatedPlayer
	rts
.5:									; A = $0008, call CODE_C59978, d6 - 1, if the result >= 0 go to .rts, ...
	lda.w #$0008
	jsr.w CODE_C59978
	dec.b d6
	bpl .rts
	stz.b d6
.rts:								; return
	rts
.6:									; A = $0008, call CODE_C59978, A = d6, A + 1, ...
	lda.w #$0008
	jsr.w CODE_C59978
	lda.b d6
	inc a
	cmp.w #$0008
	bcs .rts
	sta.b d6
	rts
SaveCreatedPlayer:					; saves the created player in the first free one of 20 save RAM slots ($9C
									; bits each, free when the first letter is 0): its entry at SRPlayerTeams,
									; both names at 5 bits a letter, the ratings, then GameSetUp
	lda.w #$026A
	sta.b $A5
	ldy.w #$0003
.loop:								; loop: call ReadSaveBits5, if A = $0000 go to .1, $A5 + 1, A = Y, ...
	jsr.w ReadSaveBits5
	cmp.w #$0000
	beq .1
	inc.b $A5
	clc
	tya
	adc.w #$009C
	tay
	cpy.w #$0C30
	bcc .loop
	jmp.w CODE_C59D39
.1:									; A = Y, A - $0003, Y = A, tmp1 = A, ...
	tya
	sec
	sbc.w #$0003
	tay
	sta.b tmp1
	sta.b r2
	lda.w #$000D
	sta.b r1
	jsl.l Div16U
	clc
	lda.b r0
	adc.w #$1CF8
	sta.b r0
	lsr a
	lsr a
	lsr a
	tax
	lda.b d1
	xba
	lsr a
	lsr a
	lsr a
	sta.b tmp0
	lda.b r0
	and.w #$0007
	beq .2
	lda.b d1
	xba
	asl a
	sta.b tmp0
	lda.l SRPlayerTeams,x
	and.w #$000F
	ora.w #$01A0
	bra .3
.2:									; A = SRPlayerTeams,x, A and $F000, A or $001A
	lda.l SRPlayerTeams,x
	and.w #$F000
	ora.w #$001A
.3:									; A or tmp0, SRPlayerTeams,x = A, Y = tmp1, tmp2 = d0, ...
	ora.b tmp0
	sta.l SRPlayerTeams,x
	ldy.b tmp1
	lda.b d0
	sta.b tmp2
	jsr.w WriteSaveBits3
	ldx.w #$0000
.loop2:								; loop: A = $4673,x, if the result = 0 go to .5, ...
	lda.w $4673,x
	and.w #$00FF
	beq .5
	cmp.w #$003D
	bne .4
	lda.w #$001D
.4:									; push X, tmp2 = A, call WriteSaveBits5, pull X, ...
	phx
	sta.b tmp2
	jsr.w WriteSaveBits5
	plx
	inx
	cpx.w #$0008
	bcc .loop2
.5:									; if X >= $0008 go to .6, tmp2 = 0, call WriteSaveBits5
	cpx.w #$0008
	bcs .6
	stz.b tmp2
	jsr.w WriteSaveBits5
.6:									; A = tmp1, A + $002B, Y = A, X = $0000
	clc
	lda.b tmp1
	adc.w #$002B
	tay
	ldx.w #$0000
.loop3:								; loop: A = $467D,x, if the result = 0 go to .8, ...
	lda.w $467D,x
	and.w #$00FF
	beq .8
	cmp.w #$003D
	bne .7
	lda.w #$001D
.7:									; push X, tmp2 = A, call WriteSaveBits5, pull X, ...
	phx
	sta.b tmp2
	jsr.w WriteSaveBits5
	plx
	inx
	cpx.w #$000A
	bcc .loop3
.8:									; if X >= $000A go to .9, tmp2 = 0, call WriteSaveBits5
	cpx.w #$000A
	bcs .9
	stz.b tmp2
	jsr.w WriteSaveBits5
.9:									; A = tmp1, A + $005D, Y = A, tmp2 = d1, ...
	clc
	lda.b tmp1
	adc.w #$005D
	tay
	lda.b d1
	sta.b tmp2
	jsr.w WriteSaveBits7
	lda.b d0
	bne .10
	jmp.w .11
.10:								; A = $0529, call RatingNibble, tmp2 = A, call WriteSaveBits4, ...
	lda.w $0529
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.b $81
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $052D
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $0527
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $0533
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $052F
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.b $85
	sta.b tmp2
	jsr.w WriteSaveBit
	lda.w $053D
	jsr.w RatingNibble
	lsr a
	sta.b tmp2
	jsr.w WriteSaveBits3
	lda.w $053B
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $0535
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $0531
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.b $26
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $052B
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $0539
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $0537
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.b $A5
	jsr.w CODE_C5E447
	jmp.w CODE_C59D39
.11:								; A = $0529, call RatingNibble, tmp2 = A, call WriteSaveBits4, ...
	lda.w $0529
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.b $81
	sta.b tmp2
	jsr.w WriteSaveBits4
	stz.b tmp2
	jsr.w WriteSaveBits4
	lda.w $0527
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $052D
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $052B
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.b $85
	sta.b tmp2
	jsr.w WriteSaveBits4
	stz.b tmp2
	jsr.w WriteSaveBits4
	stz.b tmp2
	jsr.w WriteSaveBits4
	jsr.w WriteSaveBits4
	lda.w $052F
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $0531
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $0533
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
	lda.w $0535
	jsr.w RatingNibble
	sta.b tmp2
	jsr.w WriteSaveBits4
CODE_C59D39:						; from CODE_C59998, CODE_C59ADD, SaveCreatedPlayer
	pla
CODE_C59D3A:						; from CODE_C59DBE
	pla
CODE_C59D3B:						; from NameEntry
	pla
	jmp.w GameSetUp
WriteSaveBits7:						; writes the low 7 bits of tmp2 from bit Y on (WriteSaveBit seven times)
	jsr.w WriteSaveBit
	jsr.w WriteSaveBit
WriteSaveBits5:						; writes the low 5 bits of tmp2 from bit Y on (WriteSaveBit five times)
	jsr.w WriteSaveBit
WriteSaveBits4:						; writes the low 4 bits of tmp2 from bit Y on (WriteSaveBit four times)
	jsr.w WriteSaveBit
WriteSaveBits3:						; writes the low 3 bits of tmp2 from bit Y on (WriteSaveBit three times)
	jsr.w WriteSaveBit
	jsr.w WriteSaveBit
WriteSaveBit:						; writes bit 0 of tmp2 to bit Y of the save RAM bit array at
									; SRCreatedPlayers (masks DATA8_C4C4A6); tmp2 / 2, Y + 1
	lsr.b tmp2
	bcs .1
	tya
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	eor.w #$FFFF
	sta.b tmp0
	tya
	lsr a
	lsr a
	lsr a
	tax
	lda.l SRCreatedPlayers,x
	and.b tmp0
	sta.l SRCreatedPlayers,x
	iny
	rts
.1:									; A = Y, A and $0007, X = A, A = DATA8_C4C4A6,x, ...
	tya
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	sta.b tmp0
	tya
	lsr a
	lsr a
	lsr a
	tax
	lda.l SRCreatedPlayers,x
	ora.b tmp0
	sta.l SRCreatedPlayers,x
	iny
	rts
ReadSaveBits5:						; A = the 5 bits at bit Y of the save RAM bit array at SRCreatedPlayers
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	sta.b tmp0
	lda.l SRCreatedPlayers,x
.loop:								; loop: A / 2, tmp0 - 1, if the result >= 0 go to .loop, A and $001F, ...
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$001F
	rts
EditPlayerInfo:						; Create Player screen state 3: position, weight, number, hand (up / down
									; pick, left / right change); start goes on to the ratings page
									; (ModifyRatings), X cancels
	jsr.w CODE_C59DBE
	lda.b $26
	lsr a
	bcs .1
	jsl.l SendTextMap
.1:									; go to CODE_C59F62
	jmp.w CODE_C59F62
CODE_C59DBE:						; from EditPlayerInfo
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$000F
	sta.w repeatdelayframes
.1:									; A = padchangeany, if a $1000 bit set go to .8, ...
	lda.w padchangeany
	bit.w #$1000
	bne .8
	bit.w #$0800
	bne .4
	bit.w #$0400
	bne .6
	bit.w #$0040
	beq .2
	jmp.w CODE_C59D3A
.2:									; if $0200 bits clear go to .3, A = d6, A * 2, X = A, ...
	bit.w #$0200
	beq .3
	lda.b d6
	asl a
	tax
	jsr (DATA8_C59EF2,x)
	lda.w padchangeany
.3:									; if $0100 bits clear go to .rts, A = d6, A * 2, X = A, ...
	bit.w #$0100
	beq .rts
	lda.b d6
	asl a
	tax
	jsr (DATA8_C59EFA,x)
.rts:								; return
	rts
.4:									; A = d6, A * 2, A + d6, A + $0008, ...
	lda.b d6
	asl a
	adc.b d6
	adc.w #$0008
	jsr.w SetRowPalette3
	lda.b d6
	dec a
	bpl .5
	lda.w #$0003
.5:									; d6 = A, A * 2, A + d6, A + $0008, ...
	sta.b d6
	asl a
	adc.b d6
	adc.w #$0008
	jmp.w SetRowPalette0
.6:									; A = d6, A * 2, A + d6, A + $0008, ...
	lda.b d6
	asl a
	adc.b d6
	adc.w #$0008
	jsr.w SetRowPalette3
	lda.b d6
	inc a
	cmp.w #$0004
	bcc .7
	lda.w #$0000
.7:									; d6 = A, A * 2, A + d6, A + $0008, ...
	sta.b d6
	asl a
	adc.b d6
	adc.w #$0008
	jmp.w SetRowPalette0
.8:									; call FadeOutWait, A = $D3, A + $0180, Y = $0580, ...
	jsl.l FadeOutWait
	clc
	lda.b $D3
	adc.w #$0180
	ldy.w #$0580
	jsl.l ClearRAM7E
	ldy.w #$5C00
	jsl.l ClearVRAM
	lda.w #$576C
	ldx.b d0
	beq .9
	lda.w #$57AE
.9:									; call PrintTextPage, call WaitTransfers, X = a0, A = $0003, ...
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	ldx.b a0
	lda.w #$0003
	jsl.l SetSpriteAnim
	lda.b $36,x
	and.w #$BFFF
	sta.b $36,x
	inc.b $99
	stz.b d6
	lda.w #$0145
	sta.b d2
	lda.w #$0003
	sta.w $0527
	lda.w #$0027
	ldx.w #$0527
	ldy.w #$0529
	mvn $7E,$7E
	lda.w #$00E8
	sta.b $D1
	ldx.w #$0010
	ldy.w #$0008
	lda.b d0
	beq .10
	ldx.w #$0016
	dey
.10:								; tmp0 = X, X = $0000
	stx.b tmp0
	ldx.w #$0000
.loop:								; loop: A = $0527,x, push X, push Y, tmp1 = A, ...
	lda.w $0527,x
	phx
	phy
	sta.b tmp1
	asl a
	asl a
	adc.b tmp1
	adc.w #$0019
	jsr.w BinToBCD
	jsr.w BCDText
	ldx.w #mesarea
	jsl.l PrintBoldRightStr
	ply
	plx
	iny
	inx
	inx
	cpx.b tmp0
	bcc .loop
	jsr.w PrintCreatedOverall
	lda.w #$0008
.loop2:								; loop: push A, call SetRowPalette3, pull A, A + 1, ...
	pha
	jsr.w SetRowPalette3
	pla
	inc a
	inc a
	cmp.w #$0014
	bcc .loop2
	jsl.l SendTextMap
	jsl.l WaitTransfers
	stz.w fadestep
	rts
DATA8_C59EF2:						; jump table: the routine for each index
	dw CODE_C59F02,CODE_C59F1D,CODE_C59F37,CODE_C59F51
DATA8_C59EFA:						; jump table: the routine for each index
	dw CODE_C59F10,CODE_C59F2A,CODE_C59F44,CODE_C59F51
CODE_C59F02:						; from DATA8_C59EF2
	lda.b d0
	dec a
	bpl CODE_C59F0A
	lda.w #$0005
CODE_C59F0A:						; from CODE_C59F02, CODE_C59F10
	sta.b d0
	jmp.w CODE_C5A291
DATA8_C59F0F:						; not reached by the traced code (data or unused code)
	db $60
CODE_C59F10:						; from DATA8_C59EFA
	lda.b d0
	inc a
	cmp.w #$0006
	bcc CODE_C59F0A
	lda.w #$0000
	bra CODE_C59F0A
CODE_C59F1D:						; from DATA8_C59EF2
	lda.b $81
	dec a
	bpl CODE_C59F25
	lda.w #$000F
CODE_C59F25:						; from CODE_C59F1D, CODE_C59F2A
	sta.b $81
	jmp.w CODE_C5A2B4
CODE_C59F2A:						; from DATA8_C59EFA
	lda.b $81
	inc a
	cmp.w #$0010
	bcc CODE_C59F25
	lda.w #$0000
	bra CODE_C59F25
CODE_C59F37:						; from DATA8_C59EF2
	lda.b d1
	dec a
	bpl CODE_C59F3F
	lda.w #$0063
CODE_C59F3F:						; from CODE_C59F37, CODE_C59F44
	sta.b d1
	jmp.w CODE_C5A2D3
CODE_C59F44:						; from DATA8_C59EFA
	lda.b d1
	inc a
	cmp.w #$0064
	bcc CODE_C59F3F
	lda.w #$0000
	bra CODE_C59F3F
CODE_C59F51:						; from DATA8_C59EF2, DATA8_C59EFA
	lda.b $85
	bne .1
	lda.w #$0001
	sta.b $85
	jmp.w CODE_C5A2EC
.1:									; $85 = 0, go to CODE_C5A2EC
	stz.b $85
	jmp.w CODE_C5A2EC
CODE_C59F62:						; from EditPlayerInfo
	ldx.b a0
	lda.w #$0073
	sta.b $05,x
	lda.b d6
	asl a
	asl a
	asl a
	sta.b tmp0
	asl a
	adc.b tmp0
	adc.w #$0050
	sta.b $08,x
	rts

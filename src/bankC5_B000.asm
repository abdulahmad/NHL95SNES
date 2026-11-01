; Segment bankC5_B000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C5AFB6
LeagueLeadersScreen:				; League Menu League Leaders: the players leading a stat category (the pad
									; changes the stat); DrawLeagueLeaders redraws it
	jsl.l FadeOutWait
	ldx.b a0
	lda.w #$FC18
	sta.b $05,x
	sta.b $08,x
	stz.b $77
	stz.b $79
	stz.b $85
	pea.w $0000
DrawLeagueLeaders:					; draws the League Leaders page for the current category and starts its
									; scrolling list (DrawLeaderRow); screen state 8
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	ldy.w #$5C00
	jsl.l ClearVRAM
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	jsl.l WaitTransfers
	pla
	jsr.w PrintPlayerCategory
	ldx.w #$559D
	lda.b $85
	lsr a
	bcc .1
	ldx.w #$55AD
.1:									; $CF = $0018, call PrintBoldLeft, tmp0 = $027E
	ldy.w #$0018
	sty.b $CF
	jsl.l PrintBoldLeft
	lda.w #$027E
	sta.b tmp0
.loop:								; loop: A = tmp0, A - 1, tmp0 = A, call CreatedPlayerBits, ...
	lda.b tmp0
	dec a
	sta.b tmp0
	jsr.w CreatedPlayerBits
	jsr.w NextSaveBits3
	jsr.w NextSaveBits5
	beq .loop
	lda.w #$0010
	jsl.l AllocClearWorkBuf
	sta.b d0
	sta.b $81
	tay
	lda.b tmp0
	jsr.w FillLeaderEntry
	dec.b tmp0
.loop2:								; loop: call AddLeaderEntry, tmp0 - 1, ...
	jsr.w AddLeaderEntry
	dec.b tmp0
	bpl .loop2
	jsl.l MarkWorkBuf
	lda.b $81
	ldy.w #$FFFE
.loop3:								; loop: X = A, A = $0006,x, if the result is not 0 go to .2, Y + 1, ...
	tax
	lda.w $0006,x
	eor.b $85
	bne .2
	iny
	iny
	txa
	sta.w $3E4E,y
.2:									; if $0002,x is not 0 go to .loop3, A = Y, A / 2, a1 = A, ...
	lda.w $0002,x
	bne .loop3
	tya
	lsr a
	sta.b a1
	lda.w #$556D
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	stz.b $69
	lda.w #DrawLeaderRow
	ldx.w #$000D
	ldy.w #$0009
	jsr.w StartScrollList
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.w #$0008
	sta.b $99
	stz.w fadestep
	rts
SeasonTeamStats:					; League Menu Team Stats: the season stats of a team (record, goals, save
									; and shooting percentages, shots); the pad switches teams
	jsl.l FadeOutWait
	ldx.b a0
	lda.w #$FC18
	sta.b $05,x
	sta.b $08,x
	lda.w #$8000
	sta.w DMAEnShadow
	lda.w #$FFFA
	sta.w BG2VScroll
	ldy.w #$5C00
	jsl.l ClearVRAM
	jsl.l WaitTransfers
	sep #$20
	lda.b #$11
	sta.l TM
	rep #$20
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$55F1
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	ldy.w #$2801
	ldx.w #$50A8
	jsl.l MapTileBlock
	stz.w $17C9
	stz.b d7
	jsr.w DrawSeasonTeamStats
	jsl.l SendTextMap
	jsl.l WaitTransfers
	sep #$20
	lda.b #$17
	sta.l TM
	rep #$20
	lda.w #$0009
	sta.b $99
	stz.w fadestep
	rts
SeasonPlayerStats:					; League Menu Player Stats: the season goals, assists and points of a
									; team's players (B switches to the goalies, the pad switches teams)
	jsl.l FadeOutWait
	stz.b d0
	ldx.b a0
	lda.w #$FC18
	sta.b $05,x
	sta.b $08,x
	lda.w #$8000
	sta.w DMAEnShadow
	lda.w #$FFFA
	sta.w BG2VScroll
	ldy.w #$5C00
	jsl.l ClearVRAM
	jsl.l WaitTransfers
	sep #$20
	lda.b #$11
	sta.l TM
	rep #$20
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$5583
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	ldy.w #$2801
	ldx.w #$50A8
	jsl.l MapTileBlock
	lda.w #$0002
	sta.w OptPlayMode
	stz.w $17C9
	jsr.w CODE_C52CC1
	sec
	lda.w $2DC9
	sbc.w $2DCB
	sta.b a1
	stz.b $69
	lda.w #DrawSeasonPlayerRow
	ldx.w #$000C
	ldy.w #$000B
	jsr.w StartScrollList
	stz.b d7
	jsr.w CODE_C5BCD9
	jsl.l SendTextMap
	jsl.l WaitTransfers
	sep #$20
	lda.b #$17
	sta.l TM
	rep #$20
	lda.w #$000A
	sta.b $99
	stz.w fadestep
	rts
StandingsScreen:					; League Menu NHL Standings: the teams of a division (pad up / down
									; changes the division, left / right the stat)
	jsl.l FadeOutWait
	ldx.b a0
	lda.w #$FC18
	sta.b $05,x
	sta.b $08,x
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5C00
	jsl.l ClearVRAM
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$5553
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	stz.b d0
	jsl.l CODE_C5E37E
	stz.b d1
DrawStandings:						; draws the standings page: the teams of division d1 sorted by stat d0 as
									; a scrolling list (DrawStandingsRow a row), the stat's title and the
									; division's name; screen state 11
	jsr.w CODE_C5C029
	jsr.w CODE_C5BFE0
	stz.b $69
	lda.w #DrawStandingsRow
	ldx.w #$000D
	ldy.w #$0009
	jsr.w StartScrollList
	lda.b d0
	asl a
	tax
	lda.l StandingsStatTitles,x
	tax
	ldy.w #$0007
	lda.w #$00F0
	sta.b $D1
	jsl.l PrintBoldRight
	lda.w #$0010
	sta.b $CF
	lda.b d1
	asl a
	tax
	lda.l DivisionNames,x
	tax
	ldy.w #$0013
	jsl.l PrintItalicCentred
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.w #$000B
	sta.b $99
	stz.w fadestep
	rts
StandingsStatTitles:				; the packed text of each standings stat title: Wins / Losses / Ties,
									; Points, Goals Scored Avg., Goals Allowed Avg., Save %, Shooting Pct.,
									; Shots Per Game, Shots Allowed
	db $2E,$56,$75,$4B,$3D,$56,$4C,$56,$5C,$56,$6B,$56,$76,$56,$83,$56
CODE_C5B20E:						; from CODE_C5B22D and other segments
	stz.b d4
	lda.b d0
	asl a
	tax
	bra .1
.loop:								; loop: Y = X, A = DATA8_C360D4,x, X = A, A = $C30000,x, ...
	txy
	lda.l DATA8_C360D4,x
	tax
	lda.l $C30000,x
	and.w #$00FF
	tyx
	adc.b d4
	sta.b d4
.1:									; X - 1, X - 1, if the result >= 0 go to .loop, return
	dex
	dex
	bpl .loop
	rts
CODE_C5B22D:						; called from other segments
	jsr.w CODE_C5B20E
	lda.w #$FFFA
	sta.w BG2VScroll
	lda.w #$00EB
	sta.b d3
	asl a
	adc.b $D3
	ldy.w #$0540
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	ldy.w #$5000
	jsl.l QueueClearVRAM
	jsl.l WaitTransfers
	lda.w #$0011
	sta.w $3652
	ldx.b a0
	lda.w #$0060
	sta.b $08,x
	lda.w #$0058
	sta.b $CF
	lda.w #$00A0
	sta.b $D1
	lda.b d0
	asl a
	tax
	lda.l DATA8_C360D4,x
	sta.b d1
	stz.b $85
	tax
	lda.l $C30000,x
	and.w #$00FF
	sta.b d2
	jsr.w CODE_C5B33C
	pha
	ldx.b d1
	lda.l $C30001,x
	pha
	and.w #$00FF
	ldx.w #$0020
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	jsl.l PrintThinCentred
	pla
	xba
	and.w #$00FF
	ldx.w #$0030
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	pla
	adc.w #$0003
	tay
	jsl.l PrintThinCentred
	jsr.w CODE_C5B38F
	sec
	jsr.w CODE_C5B33C
	ldx.b d2
	dex
	beq .1
	pha
	ldx.b d1
	lda.l $C30003,x
	pha
	and.w #$00FF
	ldx.w #$0040
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	jsl.l PrintThinCentred
	clc
	pei ($8B)
	lda.b d3
	adc.w #$00E0
	and.w #$03FF
	sta.b d3
	inc.b $85
	jsr.w CODE_C5B38F
	dec.b $85
	pla
	sta.b d3
	pla
	xba
	and.w #$00FF
	ldx.w #$0050
	jsr.w CODE_C5B369
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	pla
	adc.w #$0003
	tay
	jsl.l PrintThinCentred
.1:									; call WaitTransfers, $3652 = $0017, X = a4, A = $22,x, ...
	jsl.l WaitTransfers
	lda.w #$0017
	sta.w $3652
	ldx.b a4
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	ldx.b $75
	lda.b $22,x
	and.w #$FFFE
	ldy.b d2
	cpy.w #$0003
	bcc .2
	ora.w #$0001
.2:									; $22,x = A, return
	sta.b $22,x
	rts
CODE_C5B33C:						; from CODE_C5B22D
	lda.b $81
	sbc.w #$0001
	bcs .1
	adc.w #$0003
.1:									; A * 2, X = A, push X, A = DATA8_C5B35D,x, ...
	asl a
	tax
	phx
	lda.l DATA8_C5B35D,x
	adc.b $D3
	ldy.w #$01C0
	jsl.l ClearRAM7E
	plx
	lda.l DATA8_C5B363,x
	tay
	rts
DATA8_C5B35D:						; not traced: a table read by CODE_C5B33C
	db $00,$02,$C0,$03,$80,$05
DATA8_C5B363:						; not traced: a table read by CODE_C5B33C
	db $09,$00,$10,$00,$17,$00
CODE_C5B369:						; from CODE_C5B22D and other segments
	sta.b tmp1
	dec.b QueueBusy
	tsc
	sta.b tmp0
	lda.b $04
	tcs
	pea.w $0020
	phx
	pea.w $007F
	lda.b tmp1
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$D80A
	pha
	tsc
	sta.b $04
	lda.b tmp0
	tcs
	stz.b QueueBusy
	lda.b tmp1
	rts
CODE_C5B38F:						; from CODE_C5B22D and other segments
	jsl.l WaitTransfers
	phd
	lda.b $85
	lsr a
	ldx.w #$2801
	bcc .1
	ldx.w #$3001
.1:									; A = d3, A or $5000, Y = A, A = $2100, ...
	lda.b d3
	ora.w #$5000
	tay
	lda.w #$2100
	tcd
	lda.w #$0080
	sta.b VMAIN&$FF
	jsr.w CODE_C5B4B6
	jsr.w CODE_C5B4A1
	jsr.w CODE_C5B4A1
	jsr.w CODE_C5B4B6
	txa
	clc
	adc.w #$0400
	and.w #$FC00
	ora.w #$0001
	tax
	jsr.w CODE_C5B4A1
	jsr.w CODE_C5B4A1
	jsr.w CODE_C5B4B6
	tya
	sec
	sbc.w #$00E4
	and.w #$03FF
	ora.w #$5000
	tay
	lda.w d4
	clc
	adc.w $0085
	pha
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	sta.w tmp0
	pla
	lsr a
	lsr a
	lsr a
	tax
	lda.l $306050
	and.w #$00FF
	cmp.w d0
	beq .3
	bcc .4
	lda.l $307884,x
	ldx.w #$3C33
	and.w tmp0
	beq .2
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B4AE
	pld
	rts
.2:									; call CODE_C5B4AE, call CODE_C5B499, call CODE_C5B499, ...
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	pld
	rts
.3:									; push X, X = $0085, A = $306051
	phx
	ldx.w $0085
	lda.l $306051
.loop:								; loop: A / 2, X - 1, if the result >= 0 go to .loop, pull X, ...
	lsr a
	dex
	bpl .loop
	plx
	bcc .4
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	pld
	rts
.4:									; A = $307884,x, X = $3C13, if the result is not 0 go to .5, X = $3C23
	lda.l $307884,x
	ldx.w #$3C13
	and.w tmp0
	bne .5
	ldx.w #$3C23
.5:									; call CODE_C5B4AE, call CODE_C5B499, call CODE_C5B499, ...
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B499
	jsr.w CODE_C5B4AE
	jsr.w CODE_C5B4AE
	pld
	rts
CODE_C5B48A:						; from CODE_C5B4B6, CODE_C5B4A1, CODE_C5B4AE, CODE_C5B499
	sty.b $16
	tya
	clc
	adc.w #$0020
	and.w #$03FF
	ora.w #$5000
	tay
	rts
CODE_C5B499:						; from CODE_C5B38F
	jsr.w CODE_C5B48A
	lda.w #$0003
	bra CODE_C5B4A7
CODE_C5B4A1:						; from CODE_C5B38F
	jsr.w CODE_C5B48A
	lda.w #$0008
CODE_C5B4A7:						; from CODE_C5B4A7, CODE_C5B499
	stx.b $18
	inx
	dec a
	bpl CODE_C5B4A7
	rts
CODE_C5B4AE:						; from CODE_C5B38F
	jsr.w CODE_C5B48A
	lda.w #$0003
	bra CODE_C5B4BC
CODE_C5B4B6:						; from CODE_C5B38F
	jsr.w CODE_C5B48A
	lda.w #$0008
CODE_C5B4BC:						; from CODE_C5B4BC, CODE_C5B4AE
	stz.b $18
	dec a
	bpl CODE_C5B4BC
	rts
FillLeaderEntry:					; fills the leader entry at Y for player A: number and team, then goals /
									; assists / points or, for a goalie, saves / shots / save percentage
	pha
	sta.w $0004,y
	jsr.w PlayerNumberTeam
	sta.w $000E,y
	lda.b $01,s
	jsr.w CODE_C5B53D
	bcc .1
	lda.b $01,s
	jsr.w SeasonGoals
	sta.w $0008,y
	lda.b $01,s
	jsr.w SeasonAssists
	sta.w $000A,y
	clc
	sed
	lda.w $0008,y
	adc.w $000A,y
	sta.w $000C,y
	cld
	tyx
	stz.w $0006,x
	pla
	sta.b tmp0
	rts
.1:									; $0006,y = $0001, A = $01,s, call SeasonSaves, $0008,y = A, ...
	lda.w #$0001
	sta.w $0006,y
	lda.b $01,s
	jsr.w SeasonSaves
	sta.w $0008,y
	pei ($9F)
	pei ($9F)
	lda.b $05,s
	jsr.w SeasonGoalsAgainst
	clc
	sed
	adc.w $0008,y
	sta.w $000A,y
	cld
	plx
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	stz.b $32
	pla
	clc
	adc.b tmp0
	sta.b r1
	beq .2
	phy
	jsl.l Div32x32U
	ply
	lda.b r0
.2:									; call BinToBCD, $000C,y = A, pull A, tmp0 = A, ...
	jsr.w BinToBCD
	sta.w $000C,y
	pla
	sta.b tmp0
	rts
CODE_C5B53D:						; from FillLeaderEntry
	cmp.w #$026A
	bcc .1
	phy
	jsr.w CreatedPlayerBits
	jsr.w NextSaveBits3
	cmp.w #$0001
	ply
	rts
.1:									; A * 2, X = A, return
	asl a
	tax
	lda.l PlayerList,x
	cmp.w #$4000
	rts
AddLeaderEntry:						; adds player tmp0 to the League Leaders list at d0: a 16-byte entry
									; (FillLeaderEntry) linked in sorted by category d1
	lda.w #$0010
	jsl.l AllocWorkBuf
	tay
	lda.b tmp0
	jsr.w FillLeaderEntry
	lda.b d1
	asl a
	tax
	jmp (DATA8_C5B56C,x)
DATA8_C5B56C:						; jump table: the routine for each index
	dw CODE_C5B59E,CODE_C5B572,CODE_C5B588
CODE_C5B572:						; from DATA8_C5B56C
	lda.w $000A,y
	sta.b tmp1
	lda.b d0
.loop:								; loop: X = A, if $000A,x >= tmp1 go to CODE_C5B5D7, ...
	tax
	lda.w $000A,x
	cmp.b tmp1
	bcs CODE_C5B5D7
	lda.w $0000,x
	bne .loop
	bra CODE_C5B5B2
CODE_C5B588:						; from DATA8_C5B56C
	lda.w $000C,y
	sta.b tmp1
	lda.b d0
.loop:								; loop: X = A, if $000C,x >= tmp1 go to CODE_C5B5D7, ...
	tax
	lda.w $000C,x
	cmp.b tmp1
	bcs CODE_C5B5D7
	lda.w $0000,x
	bne .loop
	bra CODE_C5B5B2
CODE_C5B59E:						; from DATA8_C5B56C
	lda.w $0008,y
	sta.b tmp1
	lda.b d0
.loop:								; loop: X = A, if $0008,x >= tmp1 go to CODE_C5B5D7, ...
	tax
	lda.w $0008,x
	cmp.b tmp1
	bcs CODE_C5B5D7
	lda.w $0000,x
	bne .loop
CODE_C5B5B2:						; from CODE_C5B572, CODE_C5B588
	sty.b $81
	tya
	sta.w $0000,x
	txa
	tyx
	stz.w $0000,x
	sta.w $0002,y
	rts
CODE_C5B5C1:						; from CODE_C5B5D7
	lda.w $0002,x
	sta.w $0002,y
	sta.b tmp2
	txa
	sta.w $0000,y
	tya
	sta.w $0002,x
	ldx.b tmp2
	sta.w $0000,x
	rts
CODE_C5B5D7:						; from CODE_C5B59E, CODE_C5B572, CODE_C5B588
	cpx.b d0
	bne CODE_C5B5C1
	sty.b d0
	txa
	sta.w $0000,y
	tya
	sta.w $0002,x
	tyx
	stz.w $0002,x
	rts
PlayerNumberTeamLong:				; PlayerNumberTeam for long calls
	jsr.w PlayerNumberTeam
	rtl
PlayerNumberTeam:					; A = player A's number in BCD (high byte) and team (low byte) from its
									; 12-bit entry at $306A56
	sta.b tmp1
	asl a
	adc.b tmp1
	lsr a
	tax
	lda.l $306A56,x
	sta.b tmp1
	bcc .1
	xba
	lsr a
	and.w #$007F
	tax
	lda.l BCDTable-1,x
	and.w #$FF00
	pha
	lda.b tmp1
	and.w #$01F0
	lsr a
	lsr a
	lsr a
	lsr a
	ora.b $01,s
	plx
	rts
.1:									; A * 2, A * 2, A * 2, A and $007F, ...
	asl a
	asl a
	asl a
	xba
	and.w #$007F
	tax
	lda.l BCDTable-1,x
	and.w #$FF00
	pha
	lda.b tmp1
	and.w #$001F
	ora.b $01,s
	plx
	rts
PrintPlayerCategory:				; prints the League Leaders category name: Goals, Assists, Points, or for
									; goalies Saves, Shots and the percentage
	sta.b d1
	asl a
	tax
	lda.b $85
	lsr a
	lda.l DATA8_C5B66A,x
	bcc .1
	lda.l DATA8_C5B670,x
.1:									; push A, A = $D3, A + $01AA, push A, ...
	pha
	lda.b $D3
	clc
	adc.w #$01AA
	pha
	ldy.w #$0016
	phy
	jsl.l ClearRAM7E
	ply
	pla
	clc
	adc.w #$0040
	jsl.l ClearRAM7E
	plx
	ldy.w #$0007
	lda.w #$00F6
	sta.b $D1
	jsl.l PrintBoldRight
	rts
DATA8_C5B66A:						; not traced: a table read by PrintPlayerCategory
	db $6A,$4B,$6F,$4B,$75,$4B
DATA8_C5B670:						; not traced: a table read by PrintPlayerCategory
	db $7A,$4B,$9E,$4B,$5C,$56
CODE_C5B676:						; called from other segments
	jsr.w BinToBCD
	rtl
BinToBCD:							; A (binary, below 10000) as BCD
	pei ($9F)
	stz.b tmp0
.loop:								; loop: if A < $0064 go to .1, A - $0064, X = A, A = tmp0, ...
	cmp.w #$0064
	bcc .1
	sbc.w #$0064
	tax
	sed
	lda.b tmp0
	adc.w #$0099
	sta.b tmp0
	cld
	txa
	bra .loop
.1:									; X = A, A = BCDTable,x, A and $00FF, A or tmp0, ...
	tax
	lda.l BCDTable,x
	and.w #$00FF
	ora.b tmp0
	plx
	stx.b tmp0
	rts
DrawLeaderRow:						; draws row a3 of the League Leaders list: a leader, his team and the stat
	lda.w #$000A
	sta.b $CF
	lda.b a3
	inc a
	jsr.w BinToBCD
	jsr.w BCDText
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldLeftStr
	lda.w #$0022
	sta.b $CF
	lda.b a3
	asl a
	tax
	lda.w $3E4E,x
	tax
	lda.w $0004,x
	cmp.w #$026A
	bcs .1
	jmp.w .12
.1:									; push X, call CreatedPlayerBits, call NextSaveBits3, tmp1 = $0000
	phx
	jsr.w CreatedPlayerBits
	jsr.w NextSaveBits3
	ldx.w #$0000
	stx.b tmp1
.2:									; push X, call NextSaveBits5, pull X, if A = $0000 go to .5, ...
	phx
	jsr.w NextSaveBits5
	plx
	cmp.w #$0000
	beq .5
	cmp.w #$001D
	bne .3
	lda.w #$003D
	bra .4
.3:									; A + $0040, A + tmp1
	clc
	adc.w #$0040
	adc.b tmp1
.4:									; mesarea,x = A, tmp1 = $0020, X + 1, if X is not $0008 go to .2, ...
	sta.w mesarea,x
	lda.w #$0020
	sta.b tmp1
	inx
	cpx.w #$0008
	bne .2
	bra .7
.5:									; push X
	phx
.loop:								; loop: if X = $0007 go to .6, push X, call NextSaveBits5, pull X, ...
	cpx.w #$0007
	beq .6
	phx
	jsr.w NextSaveBits5
	plx
	inx
	bra .loop
.6:									; pull X
	plx
.7:									; mesarea,x = $0020, tmp1 = 0, X + 1, push X
	lda.w #$0020
	sta.w mesarea,x
	stz.b tmp1
	inx
	phx
.8:									; push X, call NextSaveBits5, pull X, if A = $0000 go to .loop2, ...
	phx
	jsr.w NextSaveBits5
	plx
	cmp.w #$0000
	beq .loop2
	cmp.w #$001D
	bne .9
	lda.w #$003D
	bra .10
.9:									; A + $0040, A + tmp1
	clc
	adc.w #$0040
	adc.b tmp1
.10:								; mesarea,x = A, tmp1 = $0020, X + 1, A = X, ...
	sta.w mesarea,x
	lda.w #$0020
	sta.b tmp1
	inx
	txa
	sec
	sbc.b $01,s
	cmp.w #$000A
	bcc .8
	bra .11
.loop2:								; loop: A = X, A - $01,s, if A = $0009 go to .11, push X, ...
	txa
	sec
	sbc.b $01,s
	cmp.w #$0009
	beq .11
	phx
	jsr.w NextSaveBits5
	plx
	inx
	bra .loop2
.11:								; pull X, $65 = Y, X = mesarea, A = $000C, ...
	plx
	sty.b $65
	ldx.w #mesarea
	lda.w #$000C
	jsl.l FitNameToWorkBuf
	bra .13
.12:								; push X, A * 2, X = A, A = PlayerList,x, ...
	phx
	asl a
	tax
	lda.l PlayerList,x
	adc.w #$0008
	and.w #$3FFF
	tax
	lda.w #$000C
	jsr.w UnpackFitName
.13:								; Y = $6D, call PrintBoldLeftStr, pull X, push X, ...
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	plx
	phx
	lda.w #$0094
	sta.b $CF
	lda.w $000F,x
	jsr.w CODE_C5A321
	ldy.b $6D
	ldx.w #mesarea+2
	jsl.l PrintBoldLeftStr
	plx
	phx
	lda.w $000E,x
	and.w #$00FF
	cmp.w #$001A
	bcc .14
	ldx.w #$484C
	bra .15
.14:								; A * 2, X = A, A = $C30000,x, X = A, ...
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l UnpackText
	ldx.b $16
	lda.b $0A
	beq .15
	inx
.15:								; call UnpackText, $CF = $00A8, Y = $6D, call PrintBoldLeftStr, ...
	jsl.l UnpackText
	lda.w #$00A8
	sta.b $CF
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.w #$00F0
	sta.b $D1
	lda.b d1
	asl a
	adc.b $01,s
	tax
	lda.w $0008,x
	jsr.w BCDText
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldRightStr
	plx
	rts
DrawSeasonTeamStats:				; draws the season stats of the current team (record, goals, save and
									; shooting percentages, shots)
	lda.w #$00D4
	sta.b $18
	lda.w #$0025
	sta.b $1A
	jsr.w CODE_C5BCE3
	lda.w #$000F
	sta.b tmp0
	clc
	lda.b $D3
	adc.w #$022C
	jsr.w CODE_C5B96D
	lda.w #$0001
	sta.b tmp0
	clc
	lda.b $D3
	adc.w #$0266
	jsr.w CODE_C5B96D
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.w #$00F8
	sta.b $D1
	lda.w $17C9
	jsr.w BuildTeamSeasonRecord
	phy
	lda.w $0004,y
	jsr.w BinToBCD
	jsr.w BCDText
	lda.w #$003E
	sta.w mesarea,x
	inx
	lda.w $0006,y
	phx
	jsr.w BinToBCD
	plx
	jsr.w BCDTextAt
	lda.w #$003E
	sta.w mesarea,x
	inx
	lda.w $0008,y
	phx
	jsr.w BinToBCD
	plx
	jsr.w BCDTextAt
	ldx.w #mesarea
	ldy.w #$0009
	jsl.l PrintItalicRightStr
	ply
	phy
	lda.w $0010,y
	jsr.w BinToBCD
	sta.b r2
	xba
	and.w #$00FF
	jsr.w BCDText
	lda.w #$003D
	sta.w mesarea,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w BCDTextAt
	lda.b r2
	and.w #$000F
	jsr.w BCDTextAt
	ldx.w #mesarea
	ldy.w #$000B
	jsl.l PrintItalicRightStr
	ply
	phy
	lda.w $0012,y
	jsr.w BinToBCD
	sta.b r2
	xba
	and.w #$00FF
	jsr.w BCDText
	lda.w #$003D
	sta.w mesarea,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w BCDTextAt
	lda.b r2
	and.w #$000F
	jsr.w BCDTextAt
	ldx.w #mesarea
	ldy.w #$000D
	jsl.l PrintItalicRightStr
	ply
	phy
	lda.w $0014,y
	jsr.w BinToBCD
	jsr.w BCDText
	ldx.w #mesarea
	ldy.w #$000F
	jsl.l PrintItalicRightStr
	ply
	phy
	lda.w $0016,y
	jsr.w BinToBCD
	jsr.w BCDText
	ldx.w #mesarea
	ldy.w #$0011
	jsl.l PrintItalicRightStr
	ply
	phy
	lda.w $001A,y
	jsr.w BinToBCD
	sta.b r2
	xba
	and.w #$00FF
	jsr.w BCDText
	lda.w #$003D
	sta.w mesarea,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w BCDTextAt
	lda.b r2
	and.w #$000F
	jsr.w BCDTextAt
	ldx.w #mesarea
	ldy.w #$0013
	jsl.l PrintItalicRightStr
	ply
	phy
	lda.w $0030,y
	jsr.w BinToBCD
	sta.b r2
	xba
	and.w #$00FF
	jsr.w BCDText
	lda.w #$003D
	sta.w mesarea,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w BCDTextAt
	lda.b r2
	and.w #$000F
CODE_C5B95A:						; called from other segments
	jsr.w BCDTextAt
	ldx.w #mesarea
	ldy.w #$0015
	jsl.l PrintItalicRightStr
	ply
	jsl.l SendTextMap
	rts
CODE_C5B96D:						; from DrawSeasonTeamStats, CODE_C5B96D
	pha
	ldy.w #$0014
	jsl.l ClearRAM7E
	pla
	clc
	adc.w #$0040
	dec.b tmp0
	bpl CODE_C5B96D
	rts
BuildTeamSeasonRecordLong:			; BuildTeamSeasonRecord for long calls
	jsr.w BuildTeamSeasonRecord
	rtl
BuildTeamSeasonRecord:				; team A's season record in a new $32-byte work buffer entry (Y): stat
									; fields from save RAM (ReadTeamStatBits), wins / losses / ties from the
									; 2-bit results at $30606D, points, percentages
	tax
	lda.w #$0032
	jsl.l AllocWorkBuf
	tay
	txa
	sta.w $000C,y
	phy
	ldx.w #$0083
	jsl.l Mul16U
	ply
	lda.w #$000C
	jsr.w ReadTeamStatBits
	sta.w $000E,y
	lda.w #$000D
	jsr.w ReadTeamStatBits
	sta.w $0018,y
	lda.w #$000E
	jsr.w ReadTeamStatBits
	sta.w $001C,y
	lda.w #$000B
	jsr.w ReadTeamStatBits
	sta.w $001E,y
	lda.w #$000B
	jsr.w ReadTeamStatBits
	sta.w $0020,y
	lda.w #$000B
	jsr.w ReadTeamStatBits
	sta.w $0022,y
	lda.w #$000B
	jsr.w ReadTeamStatBits
	sta.w $0024,y
	lda.w #$000B
	jsr.w ReadTeamStatBits
	sta.w $0026,y
	lda.w #$000B
	jsr.w ReadTeamStatBits
	sta.w $0028,y
	lda.w #$000C
	jsr.w ReadTeamStatBits
	sta.w $002A,y
	lda.w #$000E
	jsr.w ReadTeamStatBits
	sta.w $002E,y
	lda.w $000C,y
	ldx.w #$0015
	phy
	jsl.l Mul8U
	plx
	tay
	stz.b r0
	stz.b $2E
	lda.w #$0014
	sta.b r1
	phx
	sep #$20
	phb
	lda.b #$30
	pha
	plb
.loop:								; loop: $32 = $606D,y, A and $03, X = A, $2C,x + 1, ...
	lda.w $606D,y
	sta.b $32
	and.b #$03
	tax
	inc.b $2C,x
	lda.b $32
	lsr a
	lsr a
	sta.b $32
	and.b #$03
	tax
	inc.b $2C,x
	lda.b $32
	lsr a
	lsr a
	sta.b $32
	and.b #$03
	tax
	inc.b $2C,x
	lda.b $32
	lsr a
	lsr a
	tax
	inc.b $2C,x
	iny
	dex
	dec.b r1
	bpl .loop
	rep #$20
	plb
	ply
	lda.b $2D
	and.w #$00FF
	sta.w $0004,y
	lda.b $2E
	and.w #$00FF
	sta.w $0006,y
	lda.b $2F
	and.w #$00FF
	sta.w $0008,y
	lda.w $0004,y
	asl a
	adc.w $0008,y
	sta.w $000A,y
	lda.w #$0054
	sec
	stz.b $2D
	sbc.b r0
	sta.w $002C,y
	ldx.w $000E,y
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w $002C,y
	sta.b r1
	beq .1
	jsl.l Div32x32U
	lda.b r0
.1:									; pull Y, $0010,y = A, X = $002A,y, A = $0064, ...
	ply
	sta.w $0010,y
	ldx.w $002A,y
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w $002C,y
	sta.b r1
	beq .2
	jsl.l Div32x32U
	lda.b r0
.2:									; pull Y, $0012,y = A, A = $002E,y, A - $002A,y, ...
	ply
	sta.w $0012,y
	sec
	lda.w $002E,y
	sbc.w $002A,y
	tax
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w $002E,y
	sta.b r1
	beq .3
	jsl.l Div32x32U
	lda.b r0
.3:									; pull Y, $0014,y = A, X = $000E,y, A = $0064, ...
	ply
	sta.w $0014,y
	sec
	ldx.w $000E,y
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w $0018,y
	sta.b r1
	beq .4
	jsl.l Div32x32U
	lda.b r0
.4:									; pull Y, $0016,y = A, X = $0018,y, A = $0064, ...
	ply
	sta.w $0016,y
	ldx.w $0018,y
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w $002C,y
	sta.b r1
	beq .5
	jsl.l Div32x32U
	lda.b r0
.5:									; pull Y, $001A,y = A, X = $002E,y, A = $0064, ...
	ply
	sta.w $001A,y
	ldx.w $002E,y
	lda.w #$0064
	phy
	jsl.l Mul16x8U
	ply
	phy
	stz.b $32
	lda.w $002C,y
	sta.b r1
	beq .6
	jsl.l Div32x32U
	lda.b r0
.6:									; pull Y, $0030,y = A, X = Y, $0000,x = 0, ...
	ply
	sta.w $0030,y
	tyx
	stz.w $0000,x
	stz.w $0002,x
	rts
ReadTeamStatBits:					; A = the next A bits of the team stats bit stream at $306E43 (bit pointer
									; r2, advanced)
	sta.b r1
	lda.b r2
	lsr a
	lsr a
	lsr a
	tax
	lda.l $306E43,x
	sta.b r0
	lda.l $306E45,x
	sta.b $2E
	lda.b r2
	and.w #$0007
	asl a
	tax
	lda.b r1
	adc.b r2
	sta.b r2
	lda.b $2E
	jmp (DATA8_C5BB6C,x)
DATA8_C5BB6C:						; jump table: the routine for each index
	dw CODE_C5BB91,CODE_C5BB8E,CODE_C5BB8B,CODE_C5BB88
	dw CODE_C5BB85,CODE_C5BB82,CODE_C5BB7F,CODE_C5BB7C
CODE_C5BB7C:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB7F:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB82:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB85:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB88:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB8B:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB8E:						; from DATA8_C5BB6C
	lsr a
	ror.b r0
CODE_C5BB91:						; from DATA8_C5BB6C
	lda.b r1
	asl a
	tax
	lda.b r0
	and.l DATA8_C5BB9C-2,x
	rts
DATA8_C5BB9C:						; not traced: a table read by CODE_C5BB91
	db $01,$00,$03,$00,$07,$00,$0F,$00,$1F,$00,$3F,$00,$7F,$00,$FF,$00
	db $FF,$01,$FF,$03,$FF,$07,$FF,$0F,$FF,$1F,$FF,$3F,$FF,$7F,$FF,$FF
RefreshSpritesLong:					; RefreshSprites for long calls
	jsr.w RefreshSprites
	rtl
RefreshSprites:						; animates the sprites, builds OAM from them, packs the high table and
									; waits for the transfers
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	jsl.l WaitTransfers
	rts
DrawSeasonPlayerRow:				; draws row a3 of the Season Player Stats list: a player and his season
									; stats
	lda.w #$000C
	sta.b $CF
	lda.b d0
	bne .1
	jmp.w .3
.1:									; A = a3, A * 2, X = A, push X, ...
	clc
	lda.b a3
	asl a
	tax
	phx
	asl a
	asl a
	asl a
	asl a
	adc.w #$2EE1
	tax
	lda.w #$000C
	jsl.l FitNameToWorkBuf
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	plx
	lda.w $2E03,x
	pha
	jsr.w PlayerNumberBCD
	jsr.w CODE_C5A321
	lda.w #$0072
	sta.b $CF
	ldx.w #mesarea+2
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.w #$0093
	sta.b $CF
	lda.b $01,s
	jsr.w SeasonSaves
	pei ($9F)
	pha
	jsr.w CODE_C5BCCC
	lda.w #$00B5
	sta.b $CF
	lda.b $05,s
	jsr.w SeasonGoalsAgainst
	pei ($9F)
	clc
	sed
	adc.b $03,s
	cld
	jsr.w CODE_C5BCCC
	lda.w #$00D7
	sta.b $CF
	clc
	lda.b $05,s
	tax
	lda.w #$0064
	jsl.l Mul16x8U
	stz.b $32
	clc
	lda.b $05,s
	adc.b $01,s
	sta.b r1
	beq .2
	jsl.l Div32x32U
	lda.b r0
.2:									; call BinToBCD, pull X, pull X, pull X, ...
	jsr.w BinToBCD
	plx
	plx
	plx
	plx
	jmp.w CODE_C5BCCC
.3:									; A = $2DCB, A + a3, A * 2, X = A, ...
	clc
	lda.w $2DCB
	adc.b a3
	asl a
	tax
	phx
	asl a
	asl a
	asl a
	asl a
	adc.w #$2EE1
	tax
	lda.w #$000C
	jsl.l FitNameToWorkBuf
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	plx
	lda.w $2E03,x
	pha
	jsr.w PlayerNumberBCD
	jsr.w CODE_C5A321
	lda.w #$0072
	sta.b $CF
	ldx.w #mesarea+2
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.w #$0093
	sta.b $CF
	lda.b $01,s
	jsr.w SeasonGoals
	pha
	jsr.w CODE_C5BCCC
	lda.w #$00B5
	sta.b $CF
	lda.b $03,s
	jsr.w SeasonAssists
	pha
	jsr.w CODE_C5BCCC
	lda.w #$00D7
	sta.b $CF
	clc
	sed
	pla
	adc.b $01,s
	cld
	plx
	plx
CODE_C5BCCC:						; from DrawSeasonPlayerRow
	jsr.w BCDText
	ldx.w #mesarea
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	rts
CODE_C5BCD9:						; from SeasonPlayerStats and other segments
	lda.w #$00DE
	sta.b $18
	lda.w #$0025
	sta.b $1A
CODE_C5BCE3:						; from DrawSeasonTeamStats
	ldx.b d7
	jsl.l DeleteSprite
	stz.b d7
	jsr.w CODE_C5A4B9
	lda.w $17C9
	jsl.l CreateSprite
	stx.b d7
	lda.w #$0001
	sta.b $26
	jsr.w RefreshSprites
	lda.w #$0040
	sta.b $CF
	lda.w #$0088
	sta.b $D1
	clc
	lda.b $D3
	adc.w #$0180
	ldy.w #$0080
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	lda.w $17C9
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0006
	jsl.l PrintThinCentred
	jsl.l WaitTransfers
	rts
PlayerNumberBCD:					; A = player A's sweater number in BCD (the 7-bit field of its 12-bit
									; entry at $306A56)
	sta.b tmp0
	asl a
	adc.b tmp0
	lsr a
	tax
	lda.l $306A56,x
	bcc .1
	lsr a
	bra .2
.1:									; A * 2, A * 2, A * 2
	asl a
	asl a
	asl a
.2:									; A and $007F, tmp0 = A, X = A, A = BCDTable,x, ...
	xba
	and.w #$007F
	sta.b tmp0
	tax
	lda.l BCDTable,x
	and.w #$00FF
	rts
SeasonGoalsLong:					; SeasonGoals for long calls
	jsr.w SeasonGoals
	rtl
SeasonGoals:						; A = player A's season goals in BCD, X binary (9 bits a player in the
									; save RAM array at $30628F)
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $30628F,x
.loop:								; loop: A / 2, tmp0 - 1, if the result >= 0 go to .loop, A and $01FF, ...
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$01FF
	sta.b tmp0
	jmp.w BinToBCD
SeasonAssistsLong:					; SeasonAssists for long calls
	jsr.w SeasonAssists
	rtl
SeasonAssists:						; A = player A's season assists in BCD, X binary (9 bits a player in the
									; save RAM array at $306724)
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $306724,x
.loop:								; loop: A / 2, tmp0 - 1, if the result >= 0 go to .loop, A and $01FF, ...
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$01FF
	sta.b tmp0
	jmp.w BinToBCD
SeasonSavesLong:					; SeasonSaves for long calls
	jsr.w SeasonSaves
	rtl
SeasonSaves:						; A = goalie A's season saves in BCD, X binary: its goalie index (7 bits
									; at $30628F), then 12 bits a goalie at $306FED
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $30628F,x
.loop:								; loop: A / 2, tmp0 - 1, if the result >= 0 go to .loop, A and $007F, ...
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$007F
	sta.b tmp0
	asl a
	adc.b tmp0
	lsr a
	tax
	lda.l $306FED,x
	bcc .1
	lsr a
	lsr a
	lsr a
	lsr a
.1:									; A and $0FFF, tmp0 = A, go to BinToBCD
	and.w #$0FFF
	sta.b tmp0
	jmp.w BinToBCD
SeasonGoalieGamesLong:				; SeasonGoalieGames for long calls
	jsr.w SeasonGoalieGames
	rtl
SeasonGoalieGames:					; A = goalie A's season games in BCD, X binary: its goalie index (7 bits
									; at $30628F), then 7 bits a goalie at $307080
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $30628F,x
.loop:								; loop: A / 2, tmp0 - 1, if the result >= 0 go to .loop, A and $007F, ...
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$007F
	sta.b tmp0
	asl a
	adc.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $307080,x
	ldx.b tmp0
.loop2:								; loop: A / 2, X - 1, if the result >= 0 go to .loop2, A and $007F, ...
	lsr a
	dex
	bpl .loop2
	rol a
	and.w #$007F
	sta.b tmp0
	jmp.w BinToBCD
SeasonGoalsAgainstLong:				; SeasonGoalsAgainst for long calls
	jsr.w SeasonGoalsAgainst
	rtl
SeasonGoalsAgainst:					; A = goalie A's season goals against in BCD, X binary (9 bits at $306724
									; and two more at $30628F)
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$FFF8
	trb.b tmp0
	lda.l $30628F,x
	sta.b tmp1
	lda.l $306724,x
.loop:								; loop: tmp1 / 2, A / 2, tmp0 - 1, if the result >= 0 go to .loop, ...
	lsr.b tmp1
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$01FF
	sta.b tmp0
	lda.b tmp1
	and.w #$00C0
	asl a
	asl a
	asl a
	ora.b tmp0
	sta.b tmp0
	jmp.w BinToBCD
DrawStandingsRow:					; draws row a3 of the NHL Standings list: a team and its stat
	lda.w #$000A
	sta.b $CF
	lda.b a3
	inc a
	jsr.w BinToBCD
	jsr.w BCDText
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldLeftStr
	lda.w #$0028
	sta.b $CF
	lda.b a3
	asl a
	tax
	lda.w $3E4E,x
	tax
	lda.w $000C,x
	phx
	pha
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.b $6D
	jsl.l PrintBoldLeft
	pla
	cmp.w #$000D
	bne .1
	ldx.w #$469F
	bra .2
.1:									; if A is not $000E go to .3, X = $46A6
	cmp.w #$000E
	bne .3
	ldx.w #$46A6
.2:									; $CF = $006E, Y = $6D, call PrintBoldLeft
	lda.w #$006E
	sta.b $CF
	ldy.b $6D
	jsl.l PrintBoldLeft
.3:									; pull Y, $D1 = $00E8, A = d0, A * 2, ...
	ply
	lda.w #$00E8
	sta.b $D1
	lda.b d0
	asl a
	tax
	jsr (DATA8_C5BEDD,x)
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldRightStr
	rts
DATA8_C5BEDD:						; jump table: the routine for each index
	dw CODE_C5BEED,CODE_C5BF1D,CODE_C5BF26,CODE_C5BF50
	dw CODE_C5BF7A,CODE_C5BF83,CODE_C5BF8C,CODE_C5BFB6
CODE_C5BEED:						; from DATA8_C5BEDD
	phy
	lda.w $0004,y
	jsr.w BinToBCD
	jsr.w BCDText
	lda.w #$003E
	sta.w mesarea,x
	inx
	lda.w $0006,y
	phx
	jsr.w BinToBCD
	plx
	jsr.w BCDTextAt
	lda.w #$003E
	sta.w mesarea,x
	inx
	lda.w $0008,y
	phx
	jsr.w BinToBCD
	plx
	jsr.w BCDTextAt
	ply
	rts
CODE_C5BF1D:						; from DATA8_C5BEDD
	lda.w $000A,y
	jsr.w BinToBCD
	jmp.w BCDText
CODE_C5BF26:						; from DATA8_C5BEDD
	lda.w $0010,y
	jsr.w BinToBCD
	sta.b r2
	xba
	and.w #$00FF
	jsr.w BCDText
	lda.w #$003D
	sta.w mesarea,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w BCDTextAt
	lda.b r2
	and.w #$000F
	jmp.w BCDTextAt
CODE_C5BF50:						; from DATA8_C5BEDD
	lda.w $0012,y
	jsr.w BinToBCD
	sta.b r2
	xba
	and.w #$00FF
	jsr.w BCDText
	lda.w #$003D
	sta.w mesarea,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w BCDTextAt
	lda.b r2
	and.w #$000F
	jmp.w BCDTextAt
CODE_C5BF7A:						; from DATA8_C5BEDD
	lda.w $0014,y
	jsr.w BinToBCD
	jmp.w BCDText
CODE_C5BF83:						; from DATA8_C5BEDD
	lda.w $0016,y
	jsr.w BinToBCD
	jmp.w BCDText
CODE_C5BF8C:						; from DATA8_C5BEDD
	lda.w $001A,y
	jsr.w BinToBCD
	sta.b r2
	xba
	and.w #$00FF
	jsr.w BCDText
	lda.w #$003D
	sta.w mesarea,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w BCDTextAt
	lda.b r2
	and.w #$000F
	jmp.w BCDTextAt
CODE_C5BFB6:						; from DATA8_C5BEDD
	lda.w $0030,y
	jsr.w BinToBCD
	sta.b r2
	xba
	and.w #$00FF
	jsr.w BCDText
	lda.w #$003D
	sta.w mesarea,x
	inx
	lda.b r2
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w BCDTextAt
	lda.b r2
	and.w #$000F
	jmp.w BCDTextAt

; Segment bankC5_E000: game code, then the sprite object routines (docs/sprite_objects.md): CreateSprite,
; UploadSpriteFrame, AnimateSprites, CreateSpriteSharePal. Untraced routines keep their address as a name.
org $C5DF5F
SimPlayerStats:						; spreads a simulated team's game totals over its players: the shots
									; shared out, each goal to a random skater (+$3A goals, +$A2 shots), then
									; the assists
	lda.w $000C,y
	sta.b $A5
	lda.w $0020,y
	sta.b $0A
	lda.w $001E,y
	sta.b $0C
	stx.b $0E
	lda.b $09
	and.w #$FF00
	ldx.w #$0099
	jsl.l Mul16U
	sec
	lda.b $0A
	sbc.b $36
	sta.b $0A
	pei ($36)
	ldy.w #$0002
	lda.b [p0],y
	jsr.w RandomBelowA7E
	inc a
	sta.b r1
	lda.b $0A
	sta.b r2
	jsl.l Div16x8U
	sta.w $DB90
	sta.w $DB8E
	sta.w $DB8C
	clc
	adc.l RDMPYL
	adc.b $01,s
	sta.w $DB8A
	pla
	ldy.b $0E
	ldx.w #$0000
.loop:								; loop: $00A2,y = $DB8A,x, X + 1, X + 1, Y + 1, ...
	lda.w $DB8A,x
	sta.w $00A2,y
	inx
	inx
	iny
	dec.b r1
	bne .loop
	ldy.w #$0002
.loop2:								; loop: $0C - 1, if the result < 0 go to .1, if zero go to .1, ...
	dec.b $0C
	bmi .1
	beq .1
	lda.b [p0],y
	jsr.w RandomBelowA7E
	clc
	adc.b $0E
	tax
	inc.w $003A,x
	inc.w $00A2,x
	bra .loop2
.1:									; if $A5 is not 0 go to .2, go to SimPlayerStatsReturn
	lda.b $A5
	bne .2
	jmp.w SimPlayerStatsReturn
.2:									; Y = $0002, $DBDA = [p0],y, $DBE0 = A, Y + 1, ...
	ldy.w #$0002
	lda.b [p0],y
	sta.w $DBDA
	sta.w $DBE0
	iny
	iny
	clc
	adc.b [p0],y
	sta.w $DBDC
	sta.w $DBE2
	iny
	iny
	adc.b [p0],y
	sta.w $DBDE
	stz.w $DBE4
	lda.b $A4
	and.w #$FF00
	cmp.w #$0100
	bne .3
	xba
	bra .4
.3:									; X = $00C0, call Mul16U, A = $A5, A - $36, ...
	ldx.w #$00C0
	jsl.l Mul16U
	lda.b $A5
	sec
	sbc.b $36
	sta.w $DBE4
	lda.b $36
.4:									; $DBE6 = A, call SimGiveGoals, $DBE0 = $DBDC, $DBE2 = $DBDE, ...
	sta.w $DBE6
	jsr.w SimGiveGoals
	lda.w $DBDC
	sta.w $DBE0
	lda.w $DBDE
	sta.w $DBE2
	lda.w $DBE4
	sta.w $DBE6
	jsr.w SimGiveGoals
	stz.w $DBE4
	lda.b $A5
	lsr a
	beq SimPlayerStatsReturn
	sta.b $A5
	xba
	and.w #$FF00
	cmp.w #$0100
	bne .5
	xba
	bra .6
.5:									; X = $00C0, call Mul16U, A = $A5, A - $36, ...
	ldx.w #$00C0
	jsl.l Mul16U
	lda.b $A5
	sec
	sbc.b $36
	sta.w $DBE4
	lda.b $36
.6:									; $DBE6 = A, $DBE0 = $DBDA, $DBE2 = $DBDC, call SimGiveAssists, ...
	sta.w $DBE6
	lda.w $DBDA
	sta.w $DBE0
	lda.w $DBDC
	sta.w $DBE2
	jsr.w SimGiveAssists
	lda.w $DBDC
	sta.w $DBE0
	lda.w $DBDE
	sta.w $DBE2
	lda.w $DBE4
	sta.w $DBE6
SimGiveAssists:						; gives $DBE6 assists one at a time to random players of the pick table
									; (BuildSimPickTable): + 1 at + $6E
	lda.w $DBE6
	beq SimPlayerStatsReturn
	jsr.w BuildSimPickTable
.1:									; A = $DBE8, call RandomBelowA7E, X = $0000
	lda.w $DBE8
	jsr.w RandomBelowA7E
	ldx.w #$0000
.loop:								; loop: if A < $DB8A,x go to .2, if zero go to .2, X + 1, X + 1, ...
	cmp.w $DB8A,x
	bcc .2
	beq .2
	inx
	inx
	inx
	inx
	bra .loop
.2:									; A = $DB8C,x, A + $0E, X = A, $006E,x + 1, ...
	lda.w $DB8C,x
	clc
	adc.b $0E
	tax
	inc.w $006E,x
	dec.w $DBE6
	bne .1
SimPlayerStatsReturn:				; the rts SimPlayerStats and SimGiveAssists share
	rts
SimGiveGoals:						; gives $DBE6 goals one at a time to random players of the pick table
									; (BuildSimPickTable): + 1 at + $3A
	lda.w $DBE6
	beq .rts
	jsr.w BuildSimPickTable
.1:									; A = $DBE8, call RandomBelowA7E, X = $0000
	lda.w $DBE8
	jsr.w RandomBelowA7E
	ldx.w #$0000
.loop:								; loop: if A < $DB8A,x go to .2, if zero go to .2, X + 1, X + 1, ...
	cmp.w $DB8A,x
	bcc .2
	beq .2
	inx
	inx
	inx
	inx
	bra .loop
.2:									; A = $DB8C,x, A + $0E, X = A, $003A,x + 1, ...
	lda.w $DB8C,x
	clc
	adc.b $0E
	tax
	inc.w $003A,x
	dec.w $DBE6
	bne .1
.rts:								; return
	rts
BuildSimPickTable:					; the pick table of players $DBE0 up to $DBE2: each weighs 2 ^ (n - 1), n
									; the low nibble of his roster byte + $112, totals in $DB8A by player
	stz.w $DBEA
	stz.w $DBE8
	lda.w $DBE0
.loop:								; loop: A * 2, A * 2, A * 2, A * 2, ...
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.w #$0112
	tay
	lda.b [p0],y
	and.w #$000F
	tay
	lda.w #$0000
	sec
.loop2:								; loop: Y - 1, if the result is not 0 go to .loop2, X = $DBEA, ...
	rol a
	dey
	bne .loop2
	ldx.w $DBEA
	clc
	adc.w $DBE8
	sta.w $DBE8
	sta.w $DB8A,x
	lda.w $DBE0
	sta.w $DB8C,x
	inx
	inx
	inx
	inx
	stx.w $DBEA
	inc a
	sta.w $DBE0
	cmp.w $DBE2
	bne .loop
	rts
SimTeamTotals:						; a simulated team's game totals at X from its goals A: shots are goals +
									; 10 + a random 0-29, the other fields random parts of the goals
	sta.b tmp1
	sta.w $000C,x
	lda.w #$001E
	jsr.w RandomBelowA7E
	adc.w #$000A
	clc
	adc.b tmp1
	sta.w $000E,x
	lda.w #$00C8
	jsr.w RandomBelowA7E
	sta.w $0010,x
	lda.b tmp1
	lsr a
	jsr.w RandomBelowA7E
	sta.w $0012,x
	jsr.w RandomBelowA7E
	sta.w $0014,x
	lda.b tmp1
	lsr a
	jsr.w RandomBelowA7E
	sta.w $0016,x
	jsr.w RandomBelowA7E
	sta.w $0018,x
	lda.b tmp1
	lsr a
	lsr a
	jsr.w RandomBelowA7E
	sta.w $001A,x
	jsr.w RandomBelowA7E
	adc.w $001A,x
	sta.w $001C,x
	rts
RandomBelowA7E:						; RandomBelowA with the data bank $7E around it (its callers run with $7F)
	pea.w $7F7E
	plb
	jsl.l RandomBelowA
	plb
	rts
SaveDayGameStats:					; for each of the day's games not played by a user: AddTeamSeasonStats for
									; both teams, the score to SRDayScores, AddGamePlayerStats; then
									; SRDayPlayed rebuilt
	pea.w $7E7F
	lda.w DayGameCount
	sta.b tmp0
	lda.l SRDayPlayed
	sta.b $0A
	stz.b $0C
	stz.b $0E
	plb
	ldy.w #$8EF8
.loop:								; loop: X = Y, $0A / 2, if carry set go to .1, ...
	tyx
	lsr.b $0A
	bcs .1
	lda.w $0000,y
	bne .1
	lda.w $0002,y
	jsr.w AddTeamSeasonStats
	tya
	clc
	adc.w #$0016
	tax
	lda.w $0004,y
	jsr.w AddTeamSeasonStats
	lda.b $0E
	asl a
	tax
	lda.w $0008,y
	xba
	ora.w $000A,y
	sta.l SRDayScores,x
	phx
	phy
	pei ($9F)
	pei ($A1)
	pei ($A3)
	pei ($A5)
	pei ($0A)
	pei ($0C)
	pei ($0E)
	phb
	jsl.l AddGamePlayerStats
	plb
	pla
	sta.b $0E
	pla
	sta.b $0C
	pla
	sta.b $0A
	pla
	sta.b $A5
	pla
	sta.b tmp2
	pla
	sta.b tmp1
	pla
	sta.b tmp0
	ply
	plx
	sec
.1:									; A = Y, A + $010A, Y = A, $0E + 1, ...
	ror.b $0C
	tya
	adc.w #$010A
	tay
	inc.b $0E
	dec.b tmp0
	bne .loop
	plb
	lda.w #$0010
	sbc.w DayGameCount
.loop2:								; loop: $0C / 2, A - 1, if the result >= 0 go to .loop2, ...
	lsr.b $0C
	dec a
	bpl .loop2
	lda.b $0C
	sta.l SRDayPlayed
	rts
AddTeamSeasonStats:					; adds team A's game totals (the table at Y) to its season record in save
									; RAM: the record read (BuildTeamSeasonRecord), each field plus the game
									; value written back
	phy
	phx
	pha
	pea.w $7F7E
	plb
	jsr.w BuildTeamSeasonRecord
	plb
	pla
	phx
	ldx.w #$0083
	jsl.l Mul16U
	plx
	ply
	clc
	lda.l $7E000E,x
	adc.w $000C,y
	jsr.w PutTeamStat12
	clc
	lda.l $7E0018,x
	adc.w $000E,y
	jsr.w PutTeamStat13
	clc
	lda.l $7E001C,x
	adc.w $0010,y
	jsr.w PutTeamStat14
	clc
	lda.l $7E001E,x
	adc.w $0012,y
	jsr.w PutTeamStat11
	clc
	lda.l $7E0020,x
	adc.w $0014,y
	jsr.w PutTeamStat11
	clc
	lda.l $7E0022,x
	adc.w $0016,y
	jsr.w PutTeamStat11
	clc
	lda.l $7E0024,x
	adc.w $0018,y
	jsr.w PutTeamStat11
	clc
	lda.l $7E0026,x
	adc.w $001A,y
	jsr.w PutTeamStat11
	clc
	lda.l $7E0028,x
	adc.w $001C,y
	jsr.w PutTeamStat11
	clc
	lda.l $7E002A,x
	adc.w $001E,y
	jsr.w PutTeamStat12
	clc
	lda.l $7E002E,x
	adc.w $0020,y
	jsr.w PutTeamStat14
	ply
	rts
PutTeamStat14:						; writes A as the next 14-bit team stat, X kept
	stx.b tmp2
	sta.b tmp1
	jsr.w WriteTeamStatBits14
	ldx.b tmp2
	rts
PutTeamStat13:						; writes A as the next 13-bit team stat, X kept
	stx.b tmp2
	sta.b tmp1
	jsr.w WriteTeamStatBits13
	ldx.b tmp2
	rts
PutTeamStat12:						; writes A as the next 12-bit team stat, X kept
	stx.b tmp2
	sta.b tmp1
	jsr.w WriteTeamStatBits12
	ldx.b tmp2
	rts
PutTeamStat11:						; writes A as the next 11-bit team stat (WriteTeamStatBits11), X kept
	stx.b tmp2
	sta.b tmp1
	jsr.w WriteTeamStatBits11
	ldx.b tmp2
	rts
WriteTeamStatBits14:				; writes the low 14 bits of tmp1 from bit r2 on
	jsr.w WriteTeamStatBit
WriteTeamStatBits13:				; writes the low 13 bits of tmp1 from bit r2 on
	jsr.w WriteTeamStatBit
WriteTeamStatBits12:				; writes the low 12 bits of tmp1 from bit r2 on
	jsr.w WriteTeamStatBit
WriteTeamStatBits11:				; writes the low 11 bits of tmp1 from bit r2 on (WriteTeamStatBit 11
									; times)
	jsr.w WriteTeamStatBit
	jsr.w WriteTeamStatBit
	jsr.w WriteTeamStatBit
	jsr.w WriteTeamStatBit
	jsr.w WriteTeamStatBit
	jsr.w WriteTeamStatBit
	jsr.w WriteTeamStatBit
	jsr.w WriteTeamStatBit
	jsr.w WriteTeamStatBit
	jsr.w WriteTeamStatBit
WriteTeamStatBit:					; writes bit 0 of tmp1 to bit r2 of the team stats bit stream at
									; SRTeamStats; tmp1 / 2, r2 + 1
	lsr.b tmp1
	bcs .1
	lda.b r2
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	eor.w #$FFFF
	sta.b $A5
	lda.b r2
	lsr a
	lsr a
	lsr a
	tax
	lda.l SRTeamStats,x
	and.b $A5
	sta.l SRTeamStats,x
	inc.b r2
	rts
.1:									; A = r2, A and $0007, X = A, A = DATA8_C4C4A6,x, ...
	lda.b r2
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	sta.b $A5
	lda.b r2
	lsr a
	lsr a
	lsr a
	tax
	lda.l SRTeamStats,x
	ora.b $A5
	sta.l SRTeamStats,x
	inc.b r2
	rts
RestoreDayScores:					; puts the scores of the day's games already played (SRDayPlayed) back
									; into the day's game records from SRDayScores, marked done
	phb
	lda.l $7E2C42
	sta.b tmp0
	lda.l SRDayPlayed
	sta.b tmp1
	pea.w $7E7F
	plb
	ldy.w #$8EF8
	ldx.w #$0000
.loop:								; loop: tmp1 / 2, if carry clear go to .1, $0000,y = $0000, A - 1, ...
	lsr.b tmp1
	bcc .1
	lda.w #$0000
	sta.w $0000,y
	dec a
	sta.w $0006,y
	lda.l SRDayScores,x
	and.w #$00FF
	sta.w $000A,y
	lda.l SRDayScores+1,x
	and.w #$00FF
	sta.w $0008,y
.1:									; X + 1, X + 1, A = Y, A + $010A, ...
	inx
	inx
	tya
	clc
	adc.w #$010A
	tay
	dec.b tmp0
	bne .loop
	plb
	plb
	rts
BuildAllTeamRecords:				; BuildTeamSeasonRecord for every team ($19 down to 0 through HomeTeam),
									; linked into a list by + 2, then MarkWorkBuf
	lda.w #$0019
	sta.w HomeTeam
	jsr.w BuildTeamSeasonRecord
	stz.w $0000,x
	stx.b $81
.loop:								; loop: push X, A = HomeTeam, A - 1, if the result < 0 go to .1, ...
	phx
	lda.w HomeTeam
	dec a
	bmi .1
	sta.w HomeTeam
	jsr.w BuildTeamSeasonRecord
	ply
	tya
	sta.w $0000,x
	txa
	sta.w $0002,y
	bra .loop
.1:									; pull X, $0002,x = 0, go to MarkWorkBuf
	plx
	stz.w $0002,x
	jml.l MarkWorkBuf
	brk #$00						; a brk in the ROM, between routines
SaveOptPlayoffs:					; before the playoffs (SRPODay 0), stores OptPlayoffs as SRBestOfSeven
	lda.l SRPODay
	and.w #$00FF
	beq .1
	rts
.1:									; A 8-bit, SRBestOfSeven = OptPlayoffs, A 16-bit, return
	sep #$20
	lda.w OptPlayoffs
	sta.l SRBestOfSeven
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
SaveOptLine:						; stores OptLine in save RAM (SROptLine)
	sep #$20
	lda.w OptLine
	sta.l SROptLine
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
SaveOptPen:							; stores OptPen in save RAM (SROptPen)
	sep #$20
	lda.w OptPen
	sta.l SROptPen
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
SaveOptperlen:						; stores Optperlen in save RAM (SROptperlen)
	sep #$20
	lda.w Optperlen
	sta.l SROptperlen
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
SaveOptGoalie:						; stores OptGoalie in save RAM (SROptGoalie)
	sep #$20
	lda.w OptGoalie
	sta.l SROptGoalie
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
SaveOptUserRec:						; stores OptUserRec in save RAM (SROptUserRec)
	sep #$20
	lda.w OptUserRec
	sta.l SROptUserRec
	rep #$20
	rts
	brk #$00						; a brk in the ROM, between routines
SaveOptRosters:						; stores OptRosters in save RAM, then with it set ClampRosterTeams
	sep #$20
	lda.w OptRosters
	sta.l SROptRosters
	rep #$20
	lda.w OptRosters
	bne ClampRosterTeams
ClampRosterTeamsReturn:				; the rts ClampRosterTeams leaves through when the visiting team is in
									; range
	rts
ClampRosterTeams:					; keeps HomeTeam and VisTeam among the 26 NHL teams (else $E / $17, saved
									; and redrawn)
	lda.w HomeTeam
	cmp.w #$001A
	bcc .1
	lda.w #$000E
	sta.w HomeTeam
	sta.l SRHomeTeam
	jsr.w PrintHomeTeamName
.1:									; if VisTeam < $001A go to ClampRosterTeamsReturn, VisTeam = $0017, ...
	lda.w VisTeam
	cmp.w #$001A
	bcc ClampRosterTeamsReturn
	lda.w #$0017
	sta.w VisTeam
	sta.l SRVisTeam
	jmp.w PrintVisTeamName
ClearPlayerGoals:					; clears player A's 9-bit field of SRGoals
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
	lda.b tmp0
	and.w #$0007
	tay
	lda.w #$FE00
.loop:								; loop: Y - 1, if the result < 0 go to .1, go to .loop
	dey
	bmi .1
	sec
	rol a
	bra .loop
.1:									; tmp0 = A, A = SRGoals,x, A and tmp0, SRGoals,x = A, ...
	sta.b tmp0
	lda.l SRGoals,x
	and.b tmp0
	sta.l SRGoals,x
	rts
ClearCreatedGoals:					; ClearPlayerGoals for each created player slot in use (its first 3 bits
									; not 0), players $26A on
	lda.w #$026A
	sta.b $A5
	ldy.w #$0000
.loop:								; loop: call NextSaveBits3, if A = $0000 go to .1, push Y, A = $A5, ...
	jsr.w NextSaveBits3
	cmp.w #$0000
	beq .1
	phy
	lda.b $A5
	jsr.w ClearPlayerGoals
	ply
.1:									; $A5 + 1, A = Y, A + $0099, Y = A, ...
	inc.b $A5
	clc
	tya
	adc.w #$0099
	tay
	cpy.w #$0C30
	bcc .loop
	rtl
DATA8_C5E499:						; not traced: data between routines
	db $6B
ShowPleaseWait:						; fades out and shows the Please Wait= screen, then waits for the fade in
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	stz.w DMAEnShadow
	jsl.l ResetSprites
	jsr.w SetupScreen
	stz.b $26
	jsr.w RefreshSprites
	stz.b $CF
	lda.w #$0100
	sta.b $D1
	ldx.w #$4692
	ldy.w #$000C
	jsl.l PrintItalicCentred
	jsl.l SendTextMap
	stz.w fadestep
	lda.w #$000F
.loop:								; loop: if A is not brightness go to .loop, return
	cmp.w brightness
	bne .loop
	rts
UpdateDayPlayed:					; SRDayPlayed again: a game's bit is set when it was or its record says it
									; is over (+0 = 0)
	pea.w $7E7F
	lda.w DayGameCount
	sta.b tmp0
	lda.l SRDayPlayed
	sta.b $0A
	stz.b $0C
	plb
	ldy.w #$8EF8
.loop:								; loop: $0A / 2, if carry set go to .1, if $0000,y is not 0 go to .1
	lsr.b $0A
	bcs .1
	lda.w $0000,y
	bne .1
	sec
.1:									; A = Y, A + $010A, Y = A, tmp0 - 1, ...
	ror.b $0C
	tya
	adc.w #$010A
	tay
	dec.b tmp0
	bne .loop
	plb
	lda.w #$0010
	sbc.w DayGameCount
.loop2:								; loop: $0C / 2, A - 1, if the result >= 0 go to .loop2, ...
	lsr.b $0C
	dec a
	bpl .loop2
	lda.b $0C
	sta.l SRDayPlayed
	rts
ResetSprites:						; ResetSpritesAt with the menu screens' tile area (tile $A0, $58 tiles),
									; for long calls
	lda.w #$00A0
	sta.b $E1
	lda.w #$0058
	sta.b $DD
	jsr.w ResetSpritesAt
	rtl
ResetSpritesAt:						; resets the sprite objects: the slot list ($1912 on, $3A bytes each), the
									; palette uses (SpritePalUse) to $FFFF, OAMADDR 0, the sprite tile area
									; from tile $E1 ($DD tiles)
	lda.b $E1
	asl a
	asl a
	asl a
	asl a
	adc.w #$6000
	sta.b $DB
	lda.b $E1
	inc a
	sta.b $E3
	lda.b $DD
	inc a
	sta.b $DF
	lda.w #$3000
	sta.b $D9
	stz.w SpriteCount
	stz.w SpriteFreeCount
	stz.w $1B06
	stz.w $1B08
	stz.w SmallTileNext
	stz.w LargeSlotNext
	lda.w #$0000
	sta.l $002102
	lda.w #$FFFF
	ldx.w #$01FE
.loop:								; loop: SpritePalUse,x = A, X - 1, X - 1, ...
	sta.w SpritePalUse,x
	dex
	dex
	bpl .loop
	sta.w $1B0E
	ldx.w #$0000
	ldy.w #$0007
.loop2:								; loop: SpriteList,x = A, X + 1, X + 1, Y - 1, ...
	sta.w SpriteList,x
	inx
	inx
	dey
	bpl .loop2
	clc
	lda.w #$1912
	ldx.w #SpriteFreeList
	ldy.w #$0007
.loop3:								; loop: $00,x = A, X + 1, X + 1, A + $003A, ...
	sta.b $00,x
	inx
	inx
	adc.w #$003A
	dey
	bpl .loop3
	clc
	lda.w #$0007
	ldx.w #$000E
.loop4:								; loop: $46A8,x = A, X - 1, X - 1, A - 1, ...
	sta.w $46A8,x
	dex
	dex
	dec a
	bpl .loop4
	lda.w #$1D8F
	sta.b $28
	rts
DeleteSprite:						; removes the sprite object X: out of the active list, its palette slot
									; released, onto the free list
	lda.w SpriteCount
	bne .1
	rtl
.1:									; A - 1, A * 2, Y = A, A = X
	dec a
	asl a
	tay
	txa
.loop:								; loop: if A = SpriteList,y go to .2, Y - 1, Y - 1, ...
	cmp.w SpriteList,y
	beq .2
	dey
	dey
	bpl .loop
	rtl
.2:									; X = Y, Y = A, call (RemoveSpriteSlotTable,x), A = $0034,y, ...
	tyx
	tay
	jsr (RemoveSpriteSlotTable,x)
	lda.w $0034,y
	and.w #$00FF
	asl a
	tax
	lda.w SpritePalUse,x
	bit.w #$00FF
	bne .3
	xba
	ora.w #$FF00
	sta.w SpritePalUse,x
	and.w #$00FF
	ldx.w $1B06
	dex
	dex
	sta.w $46A8,x
	stx.w $1B06
	dec.w $1B08
	bra .4
.3:									; A - 1, SpritePalUse,x = A
	dec a
	sta.w SpritePalUse,x
.4:									; X = SpriteFreeCount, X - 1, X - 1, SpriteFreeCount = X, ...
	ldx.w SpriteFreeCount
	dex
	dex
	stx.w SpriteFreeCount
	tya
	sta.w SpriteFreeList,x
	tax
	lda.b $00,x
	bpl .6
	lda.b $02,x
	sta.w $1B0E
	bmi .5
	tay
	lda.w #$FFFF
	sta.w $0000,y
.5:									; A = $12,x, A / 2, A / 2, A / 2, ...
	lda.b $12,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$01FF
	sta.w SmallTileNext
	lda.b $18,x
	sta.w LargeSlotNext
	dec.w SpriteCount
	rtl
.6:									; Y = A, $0018,y = $18,x, $0012,y = $12,x, $0002,y = $02,x, ...
	tay
	lda.b $18,x
	sta.w $0018,y
	lda.b $12,x
	sta.w $0012,y
	lda.b $02,x
	sta.w $0002,y
	tax
	bmi .7
	sty.b $00,x
.7:									; SpriteCount - 1, return
	dec.w SpriteCount
	rtl
RemoveSpriteSlot0:					; DeleteSprite's list close from slot 0: each later SpriteList word moves
									; down one
	lda.w $1AE4
	sta.w SpriteList
RemoveSpriteSlot1:					; the list close from slot 1
	lda.w $1AE6
	sta.w $1AE4
RemoveSpriteSlot2:					; the list close from slot 2
	lda.w $1AE8
	sta.w $1AE6
RemoveSpriteSlot3:					; the list close from slot 3
	lda.w $1AEA
	sta.w $1AE8
RemoveSpriteSlot4:					; the list close from slot 4
	lda.w $1AEC
	sta.w $1AEA
RemoveSpriteSlot5:					; the list close from slot 5
	lda.w $1AEE
	sta.w $1AEC
RemoveSpriteSlot6:					; the list close from slot 6
	lda.w $1AF0
	sta.w $1AEE
RemoveSpriteSlot7:					; the list close from slot 7: nothing to move
	rts
RemoveSpriteSlotTable:				; RemoveSpriteSlot0-7 by slot (DeleteSprite)
	dw RemoveSpriteSlot0,RemoveSpriteSlot1,RemoveSpriteSlot2,RemoveSpriteSlot3
	dw RemoveSpriteSlot4,RemoveSpriteSlot5,RemoveSpriteSlot6,RemoveSpriteSlot7
CreateSprite:						; make a sprite object from record A (carry clear: made, X = the object)
	sta.b $10
	lda.w SpriteCount
	inc a
	cmp.w #$0009
	bcc .1
	rtl
.1:									; SpriteCount = A, A - 1, A * 2, Y = A, ...
	sta.w SpriteCount
	dec a
	asl a
	tay
	ldx.w SpriteFreeCount
	lda.w SpriteFreeList,x
	inx
	inx
	stx.w SpriteFreeCount
	sta.w SpriteList,y
	tax
	lda.b $18
	sta.b $05,x
	lda.b $1A
	sta.b $08,x
	lda.b $10
	sta.b $24,x
	lda.w #$0100
	sta.b $0A,x
	sta.b $0C,x
	sta.b $0E,x
	lda.b $D9
	sta.b $36,x
	stz.b $30,x
	stz.b $1E,x
	stz.b $38,x
	stz.b $20,x
	lda.w #$FFFF
	sta.b $28,x
	sta.b $2A,x
	sta.b $2C,x
	sta.b $00,x
	sta.b $22,x
	lda.b $10
	asl a
	adc.l $008000
	txy
	tax
	lda.b $00,x
	tax
	lda.b $09,x
	and.w #$00FF
	lda.b $00,x
	sta.w $0026,y
	lda.b $04,x
	lda.b $05,x
	lda.b $02,x
	sta.w $002E,y
	stx.b $10
	tax
	lda.b $00,x
	sta.w $0032,y
	ldx.b $10
	lda.b $07,x
	sta.b $10
	lda.b $12,x
	and.w #$00FF
	sta.w $0034,y
	asl a
	tax
	lda.w SpritePalUse,x
	bpl .4
	lda.w $1B08
	cmp.w #$0008
	bcc .2
	brk #$00						; a brk in the ROM, between routines
.2:									; A + 1, $1B08 = A, push X, X = $1B06, ...
	inc a
	sta.w $1B08
	phx
	ldx.w $1B06
	lda.w $46A8,x
	inx
	inx
	stx.w $1B06
	plx
	xba
	sta.w SpritePalUse,x
	ora.w $0034,y
	sta.w $0034,y
	sty.b $12
	tay
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	tya
	xba
	and.w #$00FF
	adc.w #$0008
	asl a
	asl a
	asl a
	asl a
	pha
	lda.l $008004
	pha
	tya
	and.w #$00FF
	xba
	lsr a
	lsr a
	lsr a
	adc.l $008002
	pha
	bcc .3
	lda.b $03,s
	inc a
	sta.b $03,s
.3:									; A = $04, $04 = X, QueueBusy = 0, Y = $12, ...
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	ldy.b $12
	bra .5
.4:									; A + 1, SpritePalUse,x = A, A and $FF00, A or $0034,y, ...
	inc a
	sta.w SpritePalUse,x
	and.w #$FF00
	ora.w $0034,y
	sta.w $0034,y
.5:									; A = $10, A and $00FF, A + $1E, $001A,y = A, ...
	lda.b $10
	and.w #$00FF
	clc
	adc.b $1E
	sta.w $001A,y
	jsr.w AllocSpriteTiles
	bcs .7
	lda.b $10
	xba
	and.w #$00FF
	adc.b $20
	sta.w $001C,y
	jsr.w AllocLargeSpriteTiles
	bcs .8
	ldx.w $1B0E
	bmi .6
	sty.b $00,x
.6:									; A = X, X = Y, $02,x = A, $1B0E = X, ...
	txa
	tyx
	sta.b $02,x
	stx.w $1B0E
	rtl
.7:									; A = $10, A and $00FF, A + $20, $001C,y = A
	lda.b $10
	xba
	and.w #$00FF
	clc
	adc.b $20
	sta.w $001C,y
.8:									; if $1B0E >= 0 go to .loop
	ldx.w $1B0E
	bpl .loop
	brk #$00						; a brk in the ROM, between routines
.9:									; A / 2, A / 2, A / 2, A / 2, ...
	lsr a
	lsr a
	lsr a
	lsr a
	cmp.w $001A,y
	bcc .11
	lda.b $16,x
	sbc.b $18,x
	cmp.w $001C,y
	bcc .11
	lda.b $12,x
	sta.w $0010,y
	sta.w $0012,y
	lda.w $001A,y
	asl a
	asl a
	asl a
	asl a
	adc.w $0010,y
	sta.b $12,x
	lda.b $18,x
	sta.w $0016,y
	sta.w $0018,y
	clc
	adc.w $001C,y
	sta.b $18,x
	lda.b $02,x
	sta.w $0002,y
	sty.b $02,x
	txa
	tyx
	sta.w $0000,y
	lda.b $02,x
	bmi .10
	tay
	txa
	sta.w $0000,y
	tay
.10:								; A = $16,x, A * 2, X = A, A = DATA8_C04AA9,x, ...
	lda.b $16,x
	asl a
	tax
	lda.l DATA8_C04AA9,x
	asl a
	asl a
	asl a
	asl a
	adc.b $DB
	tyx
	sta.b $14,x
	clc
	rtl
.loop:								; loop: A = $10,x, A - $12,x, if the result is not 0 go to .9, ...
	sec
	lda.b $10,x
	sbc.b $12,x
	bne .9
	sec
	lda.b $16,x
	sbc.b $18,x
	bne .9
.11:								; A = $02,x, X = A, if the result >= 0 go to .loop, A = $0034,y, ...
	lda.b $02,x
	tax
	bpl .loop
	lda.w $0034,y
	and.w #$00FF
	asl a
	tax
	lda.w SpritePalUse,x
	bit.w #$00FF
	bne .12
	lda.w #$FFFF
	sta.w SpritePalUse,x
	lda.w $1B06
	dec a
	dec a
	sta.w $1B06
	dec.w $1B08
	bra .13
.12:								; A - 1, SpritePalUse,x = A
	dec a
	sta.w SpritePalUse,x
.13:								; SpriteFreeCount - 1, SpriteFreeCount - 1, SpriteCount - 1, ...
	dec.w SpriteFreeCount
	dec.w SpriteFreeCount
	dec.w SpriteCount
	lda.w SpriteCount
	asl a
	tax
	lda.w #$FFFF
	sta.w SpriteList,x
	sec
	rtl
AllocSpriteTiles:					; takes A sprite tiles from the allocator (SmallTileNext, below $E3) and
									; sets the object's tile base (+$10 / +$12, $6000 + 16 x the first); with
									; no room returns unchanged
	clc
	adc.w SmallTileNext
	cmp.b $E3
	bcc .1
	rts
.1:									; X = SmallTileNext, SmallTileNext = A, A = X, A * 2, ...
	ldx.w SmallTileNext
	sta.w SmallTileNext
	txa
	asl a
	asl a
	asl a
	asl a
	ora.w #$6000
	sta.w $0010,y
	sta.w $0012,y
	rts
AllocLargeSpriteTiles:				; takes A large sprite slots from LargeSlotNext (below $DF), sets the
									; object's slot (+$16 / +$18) and VRAM address (+$14, by DATA8_C04AA9);
									; with no room the small tiles just taken go back
	clc
	adc.w LargeSlotNext
	cmp.b $DF
	bcc .1
	lda.w #$FF00
	trb.b $10
	lda.w SmallTileNext
	sec
	sbc.b $10
	sbc.b $1E
	sta.w SmallTileNext
	rts
.1:									; X = LargeSlotNext, LargeSlotNext = A, A = X, $0016,y = A, ...
	ldx.w LargeSlotNext
	sta.w LargeSlotNext
	txa
	sta.w $0016,y
	sta.w $0018,y
	asl a
	tax
	lda.l DATA8_C04AA9,x
	asl a
	asl a
	asl a
	asl a
	adc.b $DB
	sta.w $0014,y
	rts
UploadSpriteFrame:					; queue object X's current frame tiles for VRAM (unpacked if packed)
	txy
	lda.b $28,x
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $00,x
	xba
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	sta.b tmp2
	lda.b $00,x
	and.w #$FF00
	lsr a
	lsr a
	sta.b $A5
	lda.b $04,x
	sta.b tmp0
	dec.b QueueBusy
	tsc
	sta.b $0A
	lda.b $00
	tcs
	lda.b tmp2
	beq .1
	pha
	lda.w $0010,y
	pha
	lda.b tmp0
	bit.w #$0001
	beq .2
	pea.w $007E
	sty.b $42
	ldy.b $07,x
	sty.b $2E
	sty.b $32
	lda.b $05,x
	phb
	jsr.w UnpackStream0
	plb
	pei ($08)
	sty.b $08
	ldy.b $42
	bra .3
.1:									; $2E = $07,x, $32 = A, A = $05,x, X = A, ...
	lda.b $07,x
	sta.b $2E
	sta.b $32
	lda.b $05,x
	tax
	bra .3
.2:									; A = $07,x, push A, $2E = A, $32 = A, ...
	lda.b $07,x
	pha
	sta.b $2E
	sta.b $32
	lda.b $05,x
	pha
	adc.b tmp2
	tax
.3:									; if $A5 is not 0 go to .4, go to .9
	lda.b $A5
	bne .4
	jmp.w .9
.4:									; A = tmp0, if $0002 bits clear go to .6, ...
	lda.b tmp0
	bit.w #$0002
	beq .6
	bit.w #$0001
	beq .5
	sec
	lda.b $08
	sbc.b $A5
	sta.b r1
	sbc.b $A5
	sta.b r0
	clc
	lda.w #$007E
	sta.b $2E
	sta.b $32
	bra .7
.5:									; $42 = Y, Y = $2E, A = X, call UnpackStream0, ...
	sty.b $42
	ldy.b $2E
	txa
	phb
	jsr.w UnpackStream0
	plb
	lda.w #$007E
	sta.b $2E
	sta.b $32
	lda.b $08
	sta.b r0
	sty.b $08
	adc.b $A5
	sta.b r1
	ldy.b $42
	bra .7
.6:									; r0 = X, A = X, A + $A5, r1 = A
	stx.b r0
	txa
	adc.b $A5
	sta.b r1
.7:									; $0C = $0014,y
	lda.w $0014,y
	sta.b $0C
.loop:								; loop: A and $00FF, A * 2, $0E = A, A + $A5, ...
	and.w #$00FF
	asl a
	sta.b $0E
	adc.b $A5
	cmp.w #$0201
	bcc .8
	lda.w #$0200
	sbc.b $0E
	sta.b $0E
	pha
	pei ($0C)
	pei ($2E)
	pei ($2C)
	pha
	lda.b $0C
	adc.w #$00FF
	pha
	pei ($32)
	pei ($30)
	lda.b r0
	adc.b $0E
	sta.b r0
	lda.b r1
	adc.b $0E
	sta.b r1
	sec
	lda.b $A5
	sbc.b $0E
	sta.b $A5
	lda.b $0C
	adc.w #$01FF
	and.w #$FF00
	sta.b $0C
	bra .loop
.8:									; A = $0C, A + $0100, push A
	pei ($A5)
	pei ($0C)
	pei ($2E)
	pei ($2C)
	pei ($A5)
	lda.b $0C
	adc.w #$0100
	pha
	pei ($32)
	pei ($30)
.9:									; $00 = A, A = $0A, QueueBusy = 0, X = Y, ...
	tsc
	sta.b $00
	lda.b $0A
	tcs
	stz.b QueueBusy
	tyx
	rts
AnimateSprites:						; the animation tick: step the script of each sprite object
	lda.w SpriteCount
	bne .1
	rtl
.1:									; A - 1, A * 2, Y = A, $08 = $18E0
	dec a
	asl a
	tay
	lda.w $18E0
	sta.b $08
AnimateSpriteObject:				; step the timer when the object's update selector matches
	ldx.w SpriteList,y
	lda.b $26
	eor.b $38,x
	bit.w #$0001
	bne AnimateNextSprite
	lda.b $0E,x
	clc								; subtract speed plus one, then test the sign of the result
	sbc.b $0A,x
	bmi BeginSpriteAnimStep
	sta.b $0E,x
AnimateNextSprite:					; continue with the previous active-list entry or return
	dey
	dey
	bpl AnimateSpriteObject
	rtl
BeginSpriteAnimStep:				; save the active-list index and reload the object's timer
	sty.b tmp0
	lda.b $0C,x
	sta.b $0E,x
	txy
ReadSpriteAnim:						; read a frame byte or dispatch a command at the script position
	lda.b $30,x
	clc
	adc.b $32,x
	tax
	lda.b $00,x
	stx.b tmp1
	bit.w #$0080
	beq .1
	jmp.w DispatchSpriteAnim
.1:									; X = Y, Y = tmp0, A and $007F, if A is not $28,x go to .3
	tyx
	ldy.b tmp0
	and.w #$007F
	cmp.b $28,x
	bne .3
.2:									; advance one script byte and yield to the next object
	inc.b $30,x
	clc
	bra AnimateNextSprite
.3:									; $28,x = A, $2A,x = $FFFF, A = $22,x, if $2000 bits clear go to .2, ...
	sta.b $28,x
	lda.w #$FFFF
	sta.b $2A,x
	lda.b $22,x
	bit.w #$2000
	beq .2
	sty.b r2
	stx.b $36
UploadSpriteAnimFrame:				; update sprite VRAM placement and upload the selected frame
	lda.b $12,x
	cmp.b $10,x
	bne .1
	lda.b $18,x
	cmp.b $16,x
	beq .5
	sta.b $16,x
	lda.b $12,x
	sta.b $10,x
	bra .2
.1:									; $10,x = A, $16,x = $18,x
	sta.b $10,x
	lda.b $18,x
	sta.b $16,x
.2:									; if $00,x >= 0 go to .3, A = $10,x, A / 2, A / 2, ...
	lda.b $00,x
	bpl .3
	lda.b $10,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$01FF
	adc.b $1A,x
	sta.w SmallTileNext
	lda.b $16,x
	adc.b $1C,x
	sta.w LargeSlotNext
	bra .4
.3:									; Y = A, A = $1A,x, A * 2, A * 2, ...
	tay
	clc
	lda.b $1A,x
	asl a
	asl a
	asl a
	asl a
	adc.b $10,x
	sta.w $0012,y
	lda.b $16,x
	adc.b $1C,x
	sta.w $0018,y
.4:									; A = $16,x, A * 2, Y = X, X = A, ...
	lda.b $16,x
	asl a
	txy
	tax
	lda.l DATA8_C04AA9,x
	asl a
	asl a
	asl a
	asl a
	adc.b $DB
	tyx
	sta.b $14,x
.5:									; call UploadSpriteFrame, X = $36, $30,x + 1, Y = r2, ...
	jsr.w UploadSpriteFrame
	ldx.b $36
	inc.b $30,x
	ldy.b r2
	clc
	jmp.w AnimateNextSprite
CODE_C5EA91:						; no caller found (not traced)
	txy
	tax
	lda.w $0028,y
	sta.b $28,x
	lda.w $002A,y
	sta.b $2A,x
	stx.b $36
	jmp.w UploadSpriteAnimFrame
CODE_C5EAA2:						; no caller found (not traced)
	lda.w #$FFFF
	sta.b $28,x
	sta.b $2A,x
	ldy.b r2
	clc
	jmp.w AnimateNextSprite
DispatchSpriteAnim:					; advance past the opcode and dispatch its low seven bits
	tyx
	inc.b $30,x
	and.w #$007F
	asl a
	tax
	jmp (SpriteAnimCommands,x)
SpriteAnimCommands:					; handlers indexed by the low seven bits of a script command
	dw SpriteAnimHold,SpriteAnimRestart,SpriteAnimJumpRelative,SpriteAnimSelectScript
	dw SpriteAnimHold84,SpriteAnimSetReload,SpriteAnimSetSpeed,SpriteAnimSetFrames
	dw SpriteAnimDelete,CODE_C5EBB8,SpriteAnimSkipByte,SpriteAnimToggleHFlip
	dw SpriteAnimToggleVFlip,SpriteAnimYield,CODE_C5EC1A,SpriteAnimHold8F
	dw SpriteAnimRestoreScript,SpriteAnimHold,SpriteAnimHold,SpriteAnimSetHFlip
	dw SpriteAnimClearHFlip,SpriteAnimSetVFlip,SpriteAnimClearVFlip,SpriteAnimToggleFlips
	dw SpriteAnimHold,SpriteAnimHold,SpriteAnimHold,SpriteAnimClearFlag4000
	dw SpriteAnimBranchIfFlagClear,SpriteAnimSkipByteAlt
SpriteAnimHold:						; rewind to this command and yield until the next timer expiry
	tyx
	dec.b $30,x
	ldy.b tmp0
	clc
	jmp.w AnimateNextSprite
SpriteAnimRestart:					; restart the current script at position zero immediately
	tyx
	stz.w $0030,x
	jmp.w ReadSpriteAnim
SpriteAnimJumpRelative:				; add the following word to the opcode position and continue
	ldx.b tmp1
	lda.w $0030,y
	dec a
	adc.b $01,x
	sta.w $0030,y
	tyx
	jmp.w ReadSpriteAnim
SpriteAnimSelectScript:				; select and save the byte-indexed script, then start it immediately
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	sta.w $001E,y
	sta.w $0020,y
	asl a
	adc.w $002E,y
	tax
	lda.b $00,x
	tyx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	jmp.w ReadSpriteAnim
SpriteAnimHold84:					; hold at this command through SpriteAnimHold
	jmp.w SpriteAnimHold
SpriteAnimSetReload:				; read a little-endian word into the timer reload field
	ldx.b tmp1
	lda.b $01,x
	tyx
	sta.b $0C,x
	inc.b $30,x
	inc.b $30,x
	jmp.w ReadSpriteAnim
SpriteAnimSetSpeed:					; read a little-endian word into the timer decrement field
	ldx.b tmp1
	lda.b $01,x
	tyx
	sta.b $0A,x
	inc.b $30,x
	inc.b $30,x
	jmp.w ReadSpriteAnim
SpriteAnimSetFrames:				; read a count and frame bytes, upload the list and yield
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	sta.b p0
	sta.b $3A
	phy
.loop:								; loop: A = $02,x, A and $00FF, $0028,y = A, Y + 1, ...
	lda.b $02,x
	and.w #$00FF
	sta.w $0028,y
	iny
	iny
	inx
	dec.b p0
	bne .loop
	ora.w #$FFFF
	sta.w $0028,y
	lda.b $3A
	sec
	plx
	adc.b $30,x
	sta.b $30,x
	stx.b p0
	pei ($9F)
UploadSpriteAnimFrames:				; upload the frame list and restore the saved active-list index
	jsr.w UploadSpriteFrames
	ldx.b p0
	ply
	jmp.w AnimateNextSprite
CODE_C5EB88:						; no caller found (not traced)
	txy
	tax
	stx.b p0
	lda.w $0028,y
	sta.b $28,x
	inx
	inx
	lda.w $002A,y
	bmi .1
	sta.b $28,x
	inx
	inx
	lda.w $002C,y
	bmi .1
	sta.b $28,x
	inx
	inx
.1:									; terminate the copied frame list and enter its upload continuation
	lda.w #$FFFF
	sta.b $28,x
	ldx.b p0
	bra UploadSpriteAnimFrames
SpriteAnimDelete:					; call DeleteSprite via jsr, although its returns use rtl
	tyx
	jsr.w DeleteSprite
	ldy.b tmp0
	clc
	jmp.w AnimateNextSprite
CODE_C5EBB8:						; index into UploadSpriteFrames code bytes as pointers; purpose unresolved
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	cmp.w #$0004
	bcc .1
	brk #$00						; a brk in the ROM, between routines
.1:									; read the indexed word from uploader code and use it as a pointer
	asl a
	tax
	lda.l UploadSpriteFrames,x
	tax
	inc.w $0000,x
	tyx
	inc.b $30,x
	jmp.w ReadSpriteAnim
SpriteAnimSkipByteAlt:				; read a word but skip only one operand byte, then continue
	phy
	ldx.b tmp1
	lda.b $01,x
	ply
	tyx
	inc.b $30,x
	jmp.w ReadSpriteAnim
SpriteAnimSkipByte:					; read and discard one operand byte, then continue
	phy
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	tax
	ply
	tyx
	inc.b $30,x
	jmp.w ReadSpriteAnim
SpriteAnimToggleHFlip:				; toggle the horizontal flip attribute and continue
	tyx
	lda.b $36,x
	eor.w #$4000
	sta.b $36,x
	jmp.w ReadSpriteAnim
SpriteAnimToggleVFlip:				; toggle the vertical tile flip attribute and continue
	tyx
	lda.b $36,x
	eor.w #$8000
	sta.b $36,x
	jmp.w ReadSpriteAnim
SpriteAnimToggleFlips:				; toggle both tile flip attributes and continue
	tyx
	lda.b $36,x
	eor.w #$C000
	sta.b $36,x
	jmp.w ReadSpriteAnim
SpriteAnimYield:					; yield with the script position after this command
	tyx
	ldy.b tmp0
	clc
	jmp.w AnimateNextSprite
CODE_C5EC1A:						; call through UploadSpriteFrames code bytes as pointers; purpose
									; unresolved
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	asl a
	tax
	jsr (UploadSpriteFrames,x)
	bcs .1
	tyx
	inc.b $30,x
	jmp.w ReadSpriteAnim
.1:									; go to SpriteAnimHold
	jmp.w SpriteAnimHold
SpriteAnimHold8F:					; hold at this command through SpriteAnimHold
	jmp.w SpriteAnimHold
SpriteAnimRestoreScript:			; restart the saved script and set the animation flag $4000
	lda.w $0020,y
	sta.w $001E,y
	asl a
	adc.w $002E,y
	tax
	lda.b $00,x
	tyx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	lda.b $22,x
	ora.w #$4000
	sta.b $22,x
	jmp.w ReadSpriteAnim
SpriteAnimSetHFlip:					; set the horizontal flip attribute and continue
	tyx
	lda.b $36,x
	ora.w #$4000
	sta.b $36,x
	jmp.w ReadSpriteAnim
SpriteAnimClearHFlip:				; clear the horizontal flip attribute and continue
	tyx
	lda.b $36,x
	and.w #$BFFF
	sta.b $36,x
	jmp.w ReadSpriteAnim
SpriteAnimSetVFlip:					; set the vertical tile flip attribute and continue
	tyx
	lda.b $36,x
	ora.w #$8000
	sta.b $36,x
	jmp.w ReadSpriteAnim
SpriteAnimClearVFlip:				; clear the vertical tile flip attribute and continue
	tyx
	lda.b $36,x
	and.w #$7FFF
	sta.b $36,x
	jmp.w ReadSpriteAnim
SpriteAnimClearFlag4000:			; clear the animation flag $4000 and continue
	tyx
	lda.b $22,x
	and.w #$BFFF
	sta.b $22,x
	jmp.w ReadSpriteAnim
SpriteAnimBranchIfFlagClear:		; jump to the byte position if animation flag $4000 is clear
	lda.w $0022,y
	bit.w #$4000
	beq .1
	tyx
	inc.b $30,x
	jmp.w ReadSpriteAnim
.1:									; X = tmp1, A = $01,x, A and $00FF, $0030,y = A, ...
	ldx.b tmp1
	lda.b $01,x
	and.w #$00FF
	sta.w $0030,y
	tyx
	jmp.w ReadSpriteAnim
CODE_C5ECA5:						; no caller found (not traced)
	sta.b $1E,x
	asl a
	adc.b $2E,x
	phx
	tax
	lda.b $00,x
	plx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	lda.b $36,x
	and.w #$7FFF
	sta.b $36,x
	rts
SetSpriteAnim:						; starts animation script A of sprite object X (from its record's script
									; list); when it already has A, restarts it only if it was stopped
	cmp.b $1E,x
	beq .1
	sta.b $1E,x
	asl a
	adc.b $2E,x
	phx
	tax
	lda.b $00,x
	plx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	lda.b $36,x
	and.w #$7FFF
	sta.b $36,x
	lda.b $22,x
	ora.w #$4000
	sta.b $22,x
.rtl:								; return
	rtl
.1:									; A = $22,x, if a $4000 bit set go to .rtl, A or $4000, $22,x = A, ...
	lda.b $22,x
	bit.w #$4000
	bne .rtl
	ora.w #$4000
	sta.b $22,x
	stz.b $30,x
	stz.b $0E,x
	rtl
UploadSpriteFrames:					; upload each frame in the object's negative-terminated frame list
	stx.b $18
	txy
	lda.b $10,x
	sta.b $10
	lda.b $14,x
	sta.b $12
	dec.b QueueBusy
	tsc
	sta.b $0A
	lda.b $00
	tcs
	lda.b $28,x
.1:									; A * 2, A + $26,x, X = A, A = $00,x, ...
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $00,x
	xba
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	sta.b tmp2
	lda.b $00,x
	and.w #$FF00
	lsr a
	lsr a
	sta.b $A5
	lda.b $04,x
	sta.b p1
	lda.b tmp2
	beq .2
	pha
	pei ($10)
	lsr a
	adc.b $10
	sta.b $10
	lda.b p1
	bit.w #$0001
	beq .3
	pea.w $007E
	sty.b $42
	ldy.b $07,x
	sty.b $2E
	sty.b $32
	lda.b $05,x
	phb
	jsr.w UnpackStream0
	plb
	pei ($08)
	sty.b $08
	ldy.b $42
	bra .4
.2:									; $2E = $07,x, $32 = A, A = $05,x, X = A, ...
	lda.b $07,x
	sta.b $2E
	sta.b $32
	lda.b $05,x
	tax
	bra .4
.3:									; A = $07,x, push A, $2E = A, $32 = A, ...
	lda.b $07,x
	pha
	sta.b $2E
	sta.b $32
	lda.b $05,x
	pha
	adc.b tmp2
	tax
.4:									; if $A5 is not 0 go to .5, go to .11
	lda.b $A5
	bne .5
	jmp.w .11
.5:									; A = p1, if $0002 bits clear go to .7, if $0001 bits clear go to .6, ...
	lda.b p1
	bit.w #$0002
	beq .7
	bit.w #$0001
	beq .6
	sec
	lda.b $08
	sbc.b $A5
	sta.b r1
	sbc.b $A5
	sta.b r0
	clc
	lda.w #$007E
	sta.b $2E
	sta.b $32
	bra .8
.6:									; $42 = Y, Y = $2E, A = X, call UnpackStream0, ...
	sty.b $42
	ldy.b $2E
	txa
	phb
	jsr.w UnpackStream0
	plb
	lda.w #$007E
	sta.b $2E
	sta.b $32
	lda.b $08
	sta.b r0
	sty.b $08
	adc.b $A5
	sta.b r1
	ldy.b $42
	bra .8
.7:									; r0 = X, A = X, A + $A5, r1 = A
	stx.b r0
	txa
	adc.b $A5
	sta.b r1
.8:									; $0C = $12
	lda.b $12
	sta.b $0C
.loop:								; loop: A and $00FF, A * 2, $0E = A, A + $A5, ...
	and.w #$00FF
	asl a
	sta.b $0E
	adc.b $A5
	cmp.w #$0201
	bcc .9
	lda.w #$0200
	sbc.b $0E
	sta.b $0E
	pha
	pei ($0C)
	pei ($2E)
	pei ($2C)
	pha
	lda.b $0C
	adc.w #$00FF
	pha
	pei ($32)
	pei ($30)
	lda.b r0
	adc.b $0E
	sta.b r0
	lda.b r1
	adc.b $0E
	sta.b r1
	sec
	lda.b $A5
	sbc.b $0E
	sta.b $A5
	lda.b $0C
	adc.w #$01FF
	and.w #$FF00
	sta.b $0C
	bra .loop
.9:									; A = $0C, A + $0100, push A, A = $A5, ...
	pei ($A5)
	pei ($0C)
	pei ($2E)
	pei ($2C)
	pei ($A5)
	lda.b $0C
	adc.w #$0100
	pha
	pei ($32)
	pei ($30)
	lda.b $A5
	lsr a
	adc.b $0C
	bit.w #$0100
	beq .10
	adc.w #$0100
.10:								; $12 = A
	sta.b $12
.11:								; Y + 1, Y + 1, if $0028,y < 0 go to .12, X = $18, ...
	iny
	iny
	lda.w $0028,y
	bmi .12
	ldx.b $18
	jmp.w .1
.12:								; $00 = A, A = $0A, QueueBusy = 0, Y = $18, ...
	tsc
	sta.b $00
	lda.b $0A
	tcs
	stz.b QueueBusy
	ldy.b $18
	tyx
	rts
CODE_C5EE3C:						; no caller found (not traced)
	phx
	lda.b $34,x
	and.w #$00FF
	asl a
	tax
	lda.w SpritePalUse,x
	bit.w #$00FF
	bne .1
	xba
	ora.w #$FF00
	sta.w SpritePalUse,x
	and.w #$00FF
	ldx.w $1B06
	dex
	dex
	sta.w $46A8,x
	stx.w $1B06
	dec.w $1B08
	plx
	rts
.1:									; A - 1, SpritePalUse,x = A, pull X, return
	dec a
	sta.w SpritePalUse,x
	plx
	rts
UseSpritePalette:					; gives object X sprite palette A: a palette already loaded is reused
									; (ReuseSpritePalette), else one of the 8 free CGRAM slots ($46A8 list,
									; $1B08 count) is taken and the colours queued (QueueSpritePalette)
	sta.b $34,x
	txy
	asl a
	tax
	lda.w SpritePalUse,x
	bpl ReuseSpritePalette
	lda.w $1B08
	cmp.w #$0008
	bcc .1
	brk #$00						; a brk in the ROM, between routines
.1:									; A + 1, $1B08 = A, push X, X = $1B06, ...
	inc a
	sta.w $1B08
	phx
	ldx.w $1B06
	lda.w $46A8,x
	inx
	inx
	stx.w $1B06
	plx
	xba
	sta.w SpritePalUse,x
	ora.w $0034,y
	sta.w $0034,y
QueueSpritePalette:					; queues the 16 colours of sprite palette A (low byte) to CGRAM slot (high
									; byte) + 8
	phy
	tay
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	tya
	xba
	and.w #$00FF
	adc.w #$0008
	asl a
	asl a
	asl a
	asl a
	pha
	tya
	bit.w #$0080
	bne .1
	lda.l $808004
	pha
	tya
	and.w #$00FF
	xba
	lsr a
	lsr a
	lsr a
	adc.l $808002
	bra .2
.1:									; A and $007F, A / 2, A / 2, A / 2, ...
	pea.w $00C0
	and.w #$007F
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$3F02
.2:									; push A, A = $04, $04 = X, QueueBusy = 0, ...
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	plx
	rtl
ReuseSpritePalette:					; a sprite palette already loaded: its use count + 1 and its slot into
									; +$34 of the object
	inc a
	sta.w SpritePalUse,x
	and.w #$FF00
	tyx
	ora.b $34,x
	sta.b $34,x
	rtl
CreateSpriteSharePal:				; CreateSprite, sharing the palette slot of the object in Y
	sta.b $10
	lda.w SpriteCount
	inc a
	cmp.w #$0009
	bcc .1
	rtl
.1:									; $1C = Y, SpriteCount = A, A - 1, A * 2, ...
	sty.b $1C
	sta.w SpriteCount
	dec a
	asl a
	tay
	ldx.w SpriteFreeCount
	lda.w SpriteFreeList,x
	inx
	inx
	stx.w SpriteFreeCount
	sta.w SpriteList,y
	tax
	lda.b $18
	sta.b $05,x
	lda.b $1A
	sta.b $08,x
	lda.b $10
	sta.b $24,x
	lda.w #$0100
	sta.b $0A,x
	sta.b $0C,x
	sta.b $0E,x
	lda.b $D9
	sta.b $36,x
	stz.b $30,x
	stz.b $1E,x
	stz.b $38,x
	stz.b $20,x
	stz.b $34,x
	lda.w #$FFFF
	sta.b $28,x
	sta.b $2A,x
	sta.b $2C,x
	sta.b $00,x
	sta.b $22,x
	lda.b $10
	asl a
	adc.l $008000
	txy
	tax
	lda.b $00,x
	tax
	lda.b $09,x
	and.w #$00FF
	lda.b $00,x
	sta.w $0026,y
	lda.b $04,x
	lda.b $05,x
	lda.b $02,x
	sta.w $002E,y
	stx.b $10
	tax
	lda.b $00,x
	sta.w $0032,y
	ldx.b $10
	lda.b $07,x
	sta.b $10
	ldx.b $1C
	lda.b $34,x
	sta.w $0034,y
	and.w #$00FF
	asl a
	tax
	inc.w SpritePalUse,x
	lda.b $10
	and.w #$00FF
	clc
	adc.b $1E
	sta.w $001A,y
	jsr.w AllocSpriteTiles
	bcs .3
	lda.b $10
	xba
	and.w #$00FF
	adc.b $20
	sta.w $001C,y
	jsr.w AllocLargeSpriteTiles
	bcs .4
	ldx.w $1B0E
	bmi .2
	sty.b $00,x
.2:									; A = X, X = Y, $02,x = A, $1B0E = X, ...
	txa
	tyx
	sta.b $02,x
	stx.w $1B0E
	rtl
.3:									; A = $10, A and $00FF, A + $20, $001C,y = A
	lda.b $10
	xba
	and.w #$00FF
	clc
	adc.b $20
	sta.w $001C,y
.4:									; if $1B0E >= 0 go to .loop
	ldx.w $1B0E
	bpl .loop
	brk #$00						; a brk in the ROM, between routines
.5:									; A / 2, A / 2, A / 2, A / 2, ...
	lsr a
	lsr a
	lsr a
	lsr a
	cmp.w $001A,y
	bcc .7
	lda.b $16,x
	sbc.b $18,x
	cmp.w $001C,y
	bcc .7
	lda.b $12,x
	sta.w $0010,y
	sta.w $0012,y
	lda.w $001A,y
	asl a
	asl a
	asl a
	asl a
	adc.w $0010,y
	sta.b $12,x
	lda.b $18,x
	sta.w $0016,y
	sta.w $0018,y
	clc
	adc.w $001C,y
	sta.b $18,x
	lda.b $02,x
	sta.w $0002,y
	sty.b $02,x
	txa
	tyx
	sta.w $0000,y
	lda.b $02,x
	bmi .6
	tay
	txa
	sta.w $0000,y
	tay
.6:									; A = $16,x, A * 2, X = A, A = DATA8_C04AA9,x, ...
	lda.b $16,x
	asl a
	tax
	lda.l DATA8_C04AA9,x
	asl a
	asl a
	asl a
	asl a
	adc.b $DB
	tyx
	sta.b $14,x
	clc
	rtl
.loop:								; loop: A = $10,x, A - $12,x, if the result is not 0 go to .5, ...
	sec
	lda.b $10,x
	sbc.b $12,x
	bne .5
	sec
	lda.b $16,x
	sbc.b $18,x
	bne .5
.7:									; A = $02,x, X = A, if the result >= 0 go to .loop, A = $0034,y, ...
	lda.b $02,x
	tax
	bpl .loop
	lda.w $0034,y
	and.w #$00FF
	asl a
	tax
	lda.w SpritePalUse,x
	bit.w #$00FF
	bne .8
	lda.w #$FFFF
	sta.w SpritePalUse,x
	lda.w $1B06
	dec a
	dec a
	sta.w $1B06
	dec.w $1B08
	bra .9
.8:									; A - 1, SpritePalUse,x = A
	dec a
	sta.w SpritePalUse,x
.9:									; SpriteFreeCount - 1, SpriteFreeCount - 1, SpriteCount - 1, ...
	dec.w SpriteFreeCount
	dec.w SpriteFreeCount
	dec.w SpriteCount
	lda.w SpriteCount
	asl a
	tax
	lda.w #$FFFF
	sta.w SpriteList,x
	sec
	rtl

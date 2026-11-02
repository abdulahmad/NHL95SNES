; Segment bankC5_3000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C5308D
FixLineDefence:						; A = line slot player A if he is a defenceman (roster index $0C up to
									; $A5, after the forwards), else the first defenceman from $0C not in the
									; line (PlayerInLine)
	cmp.b $0C
	bcc .1
	cmp.b $A5
	bcc .rts
.1:									; A = $0C
	lda.b $0C
.loop:								; loop: call PlayerInLine, if carry clear go to .rts, A + 1, go to .loop
	jsr.w PlayerInLine
	bcc .rts
	inc a
	bra .loop
.rts:								; return
	rts
FixLineForward:						; A = line slot player A if he is a forward (roster index $0A up to $0C,
									; after the goalies), else the first forward from $0A not in the line
									; (PlayerInLine)
	cmp.b $0A
	bcc .1
	cmp.b $0C
	bcc .rts
.1:									; A = $0A
	lda.b $0A
.loop:								; loop: call PlayerInLine, if carry clear go to .rts, A + 1, go to .loop
	jsr.w PlayerInLine
	bcc .rts
	inc a
	bra .loop
.rts:								; return
	rts
PlayerInLine:						; carry set (and Z) when player A is in one of the five line slots at +$6D
									; .. +$71 of the roster table at Y
	cmp.w $006D,y
	beq .rts
	cmp.w $006E,y
	beq .rts
	cmp.w $006F,y
	beq .rts
	cmp.w $0070,y
	beq .rts
	cmp.w $0071,y
	beq .rts
	clc
.rts:								; return
	rts
SwapRosterPlayers:					; swaps the roster entries at X and Y (the id at +8 and the index at +$3A)
	lda.w $0008,x
	pha
	lda.w $003A,x
	pha
	lda.w $0008,y
	sta.w $0008,x
	lda.w $003A,y
	sta.w $003A,x
	pla
	sta.w $003A,y
	pla
	sta.w $0008,y
	rts
AddRosterPlayer:					; adds player tmp2 to the roster table at tmp1: the count + 1, its index
									; at +$3A and its PlayerList id at +8
	phx
	lda.b (tmp1)
	inc a
	sta.b (tmp1)
	lda.b tmp2
	sta.w $003A,y
	asl a
	tax
	lda.l PlayerList,x
	and.w #$3FFF
	sta.w $0008,y
	iny
	iny
	plx
	rts
TeamGoalieRange:					; team record A: $A5 = the PlayerList index of its first player, $0A = the
									; index after its goalies (RecordGoalieCount)
	tax
	lda.l $C30000,x
	and.w #$07FF
	lsr a
	sec
	sbc.w #$001C
	sta.b $A5
	txa
	jsr.w RecordGoalieCount
	clc
	adc.b $A5
	sta.b $0A
	rts
RecordGoalieCount:					; A = the goalie count of the team record at X (A = X on entry): the used
									; nibbles of the word its +8 offset points at
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
	rts
TeamForwardRange:					; team record A: $A5 = the PlayerList index of its first forward (after
									; the goalies), $0A = the index after its forwards (high nibble); no
									; caller found
	pha
	tax
	jsr.w RecordGoalieCount
	sta.b $A5
	pla
	tax
	lda.l $C30000,x
	and.w #$07FF
	lsr a
	sec
	sbc.w #$001C
	clc
	adc.b $A5
	sta.b $A5
	txa
	clc
	adc.l $C30006,x
	tax
	lda.l $C30003,x
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.b $A5
	sta.b $0A
	rts
UnpackTeamBonuses:					; unpacks the team bonus bytes at X into roster table Y: the nibbles of
									; bytes 0-2 at +$430 to +$43A (the high one of byte 1 and the low one of
									; byte 2 negated), byte 4 at +$43C
	lda.l $C30000,x
	pha
	and.w #$000F
	sta.w $0432,y
	pla
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	sta.w $0430,y
	lda.l $C30001,x
	pha
	and.w #$000F
	sta.w $0436,y
	pla
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	sta.w $0434,y
	lda.l $C30002,x
	pha
	and.w #$000F
	eor.w #$FFFF
	inc a
	sta.w $043A,y
	pla
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	sta.w $0438,y
	lda.l $C30004,x
	and.w #$00FF
	sta.w $043C,y
	rts
LoadSeasonHomeRoster:				; LoadSeasonRoster of team A into HomeRoster, for long calls
	ldy.w #HomeRoster
	sta.b tmp0
	sty.b tmp1
	jsr.w LoadSeasonRoster
	rtl
LoadSeasonRoster:					; builds team tmp0's roster table at tmp1 from the season data: each
									; player whose entry at SRPlayerTeams has team tmp0 (AddRosterPlayer),
									; then the entries ordered
	asl a
	tax
	lda.l $C30000,x
	tax
	adc.l $C30006,x
	tax
	jsr.w UnpackTeamBonuses
	tyx
	stz.w $0000,x
	stz.w $0002,x
	stz.w $0004,x
	stz.w $0006,x
	stz.b tmp2
	ldx.w #$0000
	ldy.b tmp1
.loop:								; loop: A = SRPlayerTeams,x, A and $001F, if A is not tmp0 go to .1, ...
	lda.l SRPlayerTeams,x
	and.w #$001F
	cmp.b tmp0
	bne .1
	jsr.w AddRosterPlayer
.1:									; A = tmp2, A + 1, if A >= $027E go to .3, tmp2 = A, ...
	lda.b tmp2
	inc a
	cmp.w #$027E
	bcs .3
	sta.b tmp2
	lda.l SRPlayerTeams+1,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$001F
	cmp.b tmp0
	bne .2
	jsr.w AddRosterPlayer
.2:									; X + 1, X + 1, X + 1, A = tmp2, ...
	inx
	inx
	inx
	lda.b tmp2
	inc a
	sta.b tmp2
	cmp.w #$027E
	bcc .loop
.3:									; tmp2 = (tmp1), Y = tmp1
	lda.b (tmp1)
	sta.b tmp2
	ldy.b tmp1
.4:									; if $003A,y < $026A go to .5, push Y, call CreatedPlayerBits, ...
	lda.w $003A,y
	cmp.w #$026A
	bcc .5
	phy
	jsr.w CreatedPlayerBits
	jsr.w NextSaveBits3
	ply
	cmp.w #$0000
	bne .7
	pea.w $0000
	bra .6
.5:									; A * 2, X = A, A = PlayerList,x, if a $C000 bit set go to .7, ...
	asl a
	tax
	lda.l PlayerList,x
	bit.w #$C000
	bne .7
	pea.w $0000
.6:									; X = tmp1, A = $0002,x, $0002,x + 1, A * 2, ...
	ldx.b tmp1
	lda.w $0002,x
	inc.w $0002,x
	asl a
	adc.b tmp1
	tax
	jsr.w SwapRosterPlayers
	plx
	bra .7
.7:									; Y + 1, Y + 1, tmp2 - 1, if the result is not 0 go to .4, ...
	iny
	iny
	dec.b tmp2
	bne .4
	lda.b (tmp1)
	sta.b tmp2
	ldy.b tmp1
.8:									; if $003A,y < $026A go to .9, push Y, call CreatedPlayerBits, ...
	lda.w $003A,y
	cmp.w #$026A
	bcc .9
	phy
	jsr.w CreatedPlayerBits
	jsr.w NextSaveBits3
	ply
	cmp.w #$0003
	bcc .11
	bra .10
.9:									; A * 2, X = A, if PlayerList,x >= 0 go to .11
	asl a
	tax
	lda.l PlayerList,x
	bpl .11
.10:								; X = tmp1, A = $0004,x, $0004,x + 1, A + $0002,x, ...
	ldx.b tmp1
	lda.w $0004,x
	inc.w $0004,x
	clc
	adc.w $0002,x
	asl a
	adc.b tmp1
	tax
	jsr.w SwapRosterPlayers
.11:								; Y + 1, Y + 1, tmp2 - 1, if the result is not 0 go to .8, ...
	iny
	iny
	dec.b tmp2
	bne .8
	ldx.b tmp1
	lda.w $0000,x
	sec
	sbc.w $0002,x
	sbc.w $0004,x
	sta.w $0006,x
	rts
GetForwardCount:					; d0 = the forward count of team a2 (+4 of its roster table); no caller
									; found
	ldx.w #HomeRoster
	lda.b a2
	beq .1
	ldx.w #VisRoster
.1:									; d0 = $0004,x, return
	lda.w $0004,x
	sta.b d0
	rtl
LoadTeamLines:						; copies team a2's lines into RAM through GetTeamLines; OptLine tested as
									; in 94S
	pei ($6F)
	pei ($67)
	phx
	phy
	jsl.l GetTeamLines
	pei ($6F)
	lda.w #HomeRoster
	ldx.b a2
	beq .1
	lda.w #VisRoster
.1:									; a1 = A, A + $0008, X = A, Y = $001C
	sta.b a1
	clc
	adc.w #$0008
	tax
	ldy.w #$001C
.loop:								; loop: (a3) = $006C,x, X + 1, X + 1, a3 + 1, ...
	lda.w $006C,x
	sta.b (a3)
	inx
	inx
	inc.b a3
	inc.b a3
	dey
	bne .loop
	ply
	lda.w OptLine
	bne .2
	stz.w $18AA
	ldx.b a1
	lda.w $006C,x
	sta.w $0000,y
	lda.w $006E,x
	sta.w $0002,y
	lda.w $0070,x
	sta.w $0004,y
	lda.w $0072,x
	sta.w $0006,y
.2:									; pull Y, pull X, pull A, a1 = A, ...
	ply
	plx
	pla
	sta.b a1
	pla
	sta.b a3
	rtl
GetPlayerNumInitial:				; formats TempPlOffset through PlayerShortName while preserving d0 and a2
	pei ($7F)
	pei ($81)
	pei ($6B)
	pei ($6D)
	stz.b a2
	lda.w TempPlOffset
	sta.b d0
	bpl .1
	and.w #$00FF
	sta.b d0
	inc.b a2
	inc.b a2
.1:									; call PlayerShortName, pull A, $6D = A, pull A, ...
	jsl.l PlayerShortName
	pla
	sta.b $6D
	pla
	sta.b a2
	pla
	sta.b $81
	pla
	sta.b d0
	rtl
PlayerShortName:					; from GetPlayerNumInitial and other segments
	pei ($7F)
	pei ($81)
	pei ($6B)
	pei ($6D)
	pei ($63)
	pei ($65)
	jsl.l CODE_C535EF
	stz.b $69
	lda.w #mesarea
	sta.b a1
	lda.w #$0002
	sta.b [a1]
	inc.b a1
	inc.b a1
	pei ($63)
	pei ($65)
	lda.b a0
	clc
	adc.b [a0]
	sta.b a0
	lda.b [a0]
	and.w #$00FF
	sta.b d0
	jsl.l PutDigits2
	lda.w #$0020
	sta.b [a1]
	inc.b a1
	pla
	sta.b $65
	pla
	sta.b a0
	lda.b [a0]
	sta.b d0
	clc
	adc.b a0
	sta.b a2
	lda.b $65
	sta.b $6D
	inc.b a0
	inc.b a0
	lda.b [a0]
	inc.b a0
	sta.b [a1]
	inc.b a1
	lda.w #$002E
	sta.b [a1]
	inc.b a1
	lda.w #$0020
	sta.b [a1]
	inc.b a1
.loop:								; loop: A = [a0], a0 + 1, A and $00FF, if A is not $0020 go to .loop
	lda.b [a0]
	inc.b a0
	and.w #$00FF
	cmp.w #$0020
	bne .loop
.loop2:								; loop: A = [a0], a0 + 1, [a1] = A, a1 + 1, ...
	lda.b [a0]
	inc.b a0
	sta.b [a1]
	inc.b a1
	lda.b a0
	cmp.b a2
	bne .loop2
	pla
	sta.b $65
	pla
	sta.b a0
	pla
	sta.b $6D
	pla
	sta.b a2
	pla
	sta.b $81
	pla
	sta.b d0
	rtl
RosterPlayerShortName:				; selects the roster and player from TempPlOffset and formats a short name
	ldx.w #HomeRoster
	lda.w TempPlOffset
	bpl FormatRosterShortName
	and.w #$00FF
	ldx.w #VisRoster
FormatRosterShortName:				; builds packed number, first initial and surname text from roster X and
									; player A
	stx.b tmp0
	xba
	lsr a
	lsr a
	lsr a
	adc.b tmp0
	tax
	lda.w #$0032
	jsl.l AllocWorkBuf2
	tay
	phx
	lda.w $0110,x
	and.w #$007F
	jsr.w BinToBCD
	tax
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$00B0
	sta.w $0001,y
	txa
	and.w #$000F
	adc.w #$00B0
	ora.w #$A000
	sta.w $0002,y
	plx
	phy
	sep #$21
	lda.w $0118,x
	cmp.b #$3D
	bne .1
	lda.b #$2E
.1:									; A xor $80, $0004,y = A, $0005,y = $AE, $0006,y = $A0
	eor.b #$80
	sta.w $0004,y
	lda.b #$AE
	sta.w $0005,y
	lda.b #$A0
	sta.w $0006,y
.loop:								; loop: A = $0119,x, X + 1, if $0119,x is not $20 go to .loop
	lda.w $0119,x
	inx
	cmp.b #$20
	bne .loop
.loop2:								; loop: X + 1, Y + 1, if $0118,x is not $3D go to .2, A = $2E
	inx
	iny
	lda.w $0118,x
	cmp.b #$3D
	bne .2
	lda.b #$2E
.2:									; A xor $80, $0006,y = A, if the result is not 0 go to .loop2, ...
	eor.b #$80
	sta.w $0006,y
	eor.b #$80
	bne .loop2
	sta.w $0006,y
	rep #$21
	tya
	sbc.b $01,s
	adc.w #$0005
	sep #$20
	ply
	sta.w $0000,y
	rep #$20
	tya
	ldx.w #$007E
	rtl
EraseScoutName:						; an 11 x 2 area of blankchar through eraser (d0, d1, d2); no caller found
	lda.w #$000B
	sta.b d0
	lda.w #$0002
	sta.b d1
	lda.w blankchar
	sta.b d2
	jml.l eraser
PutDigits2:							; from PlayerShortName and other segments
	lda.w #$2020
	sta.b tmp0
	lda.b d0
	and.w #$00FF
	cmp.w #$000A
	bcc .1
	lsr a
	lsr a
	lsr a
	lsr a
	clc
	adc.w #$0030
	sta.b tmp0
.1:									; A = d0, A and $000F, A + $0030, $A0 = A, ...
	lda.b d0
	and.w #$000F
	clc
	adc.w #$0030
	sta.b $A0
	lda.b tmp0
	sta.b [a1]
	inc.b a1
	inc.b a1
	rtl
PushNumber:							; a1 = d0 as a decimal string ending at mesareaEnd: the digits backward,
									; then the length word before them
	phx
	stz.b $69
	lda.w #mesareaEnd
	sta.b a1
	lda.b d0
.loop:								; loop: r2 = A, r1 = $000A, call Div16x8U, a1 - 1, ...
	sta.b r2
	lda.w #$000A
	sta.b r1
	jsl.l Div16x8U
	dec.b a1
	sep #$20
	lda.l RDMPYL
	sta.b [a1]
	rep #$30
	lda.b r0
	bne .loop
	dec.b a1
	dec.b a1
	lda.w #mesareaEnd
	sec
	sbc.b a1
	sta.b [a1]
	plx
	rtl
PushNumberWrap:						; a1 = d0 as d1 digits right-aligned after spaces in a buffer behind a
									; length word d1 + 2 (d0 mod 100 when d1 is 2); the digits are values 0-9
	phx
	ldy.b d1
	lda.b d0
	cpy.w #$0002
	bne .1
.loop:								; loop: if A < $0064 go to .1, A - $0064, go to .loop
	cmp.w #$0064
	bcc .1
	sbc.w #$0064
	bra .loop
.1:									; Y + 1, Y + 1, PushWidthBuf = Y, Y - 1, ...
	iny
	iny
	sty.w PushWidthBuf
	dey
	ldx.w #$2020
	stx.w PushWidthBuf+2
	stx.w PushWidthBuf+4
	stx.w PushWidthBuf+6
	stx.w PushWidthBuf+8
	ldx.w #$000A
	stx.b r1
.loop2:								; loop: r2 = A, call Div16x8U, A = RDMPYL, Y - 1, ...
	sta.b r2
	jsl.l Div16x8U
	lda.l RDMPYL
	xba
	dey
	sta.w PushWidthBuf,y
	lda.b r0
	bne .loop2
	ldx.w #PushWidthBuf
	stx.b a1
	ldx.w #$0000
	stx.b $69
	plx
	rtl
ResetClock:							; sets the period length: gameclock, PerTimeTotal and gmclock from
									; GetPeriodTime (25 in the shootout, 300 in overtime when $1864 is 0) and
									; the clock digits
	jsl.l GetPeriodTime
	lda.w shootoutmode
	beq .1
	lda.w #$0019
	sta.b d0
	lda.w #$0025
	sta.w clockbcd
	bra .2
.1:									; clockbcd = tmp0, if gsp is not $0003 go to .2, ...
	lda.b tmp0
	sta.w clockbcd
	lda.w gsp
	cmp.w #$0003
	bne .2
	lda.w OptPlayMode
	bne .2
	lda.w #$0500
	sta.w clockbcd
	lda.w #$012C
	sta.b d0
.2:									; gameclock = d0, PerTimeTotal = A, gmclock = A, return
	lda.b d0
	sta.w gameclock
	sta.w PerTimeTotal
	sta.w gmclock
	rtl
clearTeamStats:						; clears the team stats (keeping both goalies), the penalty box lists
									; $FFFF, then sets up the two teams' words
	lda.w tmgoalie
	pha
	lda.w tmgoalie+2
	pha
	ldx.w #$01AE
.loop:								; loop: tmPwrGoals,x = 0, X - 1, X - 1, ...
	stz.w tmPwrGoals,x
	dex
	dex
	bpl .loop
	pla
	sta.w tmgoalie+2
	pla
	sta.w tmgoalie
	lda.w #$FFFF
	sta.w tmboxlist
	sta.w $13F5
	stz.w tmsort
	lda.w #$000C
	sta.w tmsort+2
	lda.w HomeTeam
	sta.w tmteam
	asl a
	tax
	lda.l $C30000,x
	sta.w tmdata
	lda.w VisTeam
	sta.w tmteam+2
	asl a
	tax
	lda.l $C30000,x
	sta.w tmdata+2
	rtl
restoreteams:						; called from other segments
	stz.b a2
	jsl.l BenchTeamRoster
	lda.w #$0002
	sta.b a2
BenchTeamRoster:					; team a2: tmap 6 and every roster entry on the bench (tmpdst $FFFE)
	ldy.b a2
	lda.w #$0006
	sta.w tmap,y
	lda.w #$0032
	sta.b d0
.loop:								; loop: if a2 = 0 go to .1, A = $0034
	lda.b a2
	beq .1
	lda.w #$0034
.1:									; A + d0, Y = A, tmpdst,y = $FFFE, d0 - 1, ...
	clc
	adc.b d0
	tay
	lda.w #$FFFE
	sta.w tmpdst,y
	dec.b d0
	dec.b d0
	bpl .loop
	rtl
CODE_C535EF:						; from PlayerShortName and other segments
	ldy.b a2
	lda.w #$00C3
	sta.b $65
	lda.w tmdata,y
	sta.b a0
	lda.b [a0]
	and.w #$07FF
	sta.b a0
	lda.b d0
	asl a
	tay
	lda.b [a0],y
	and.w #$3FFF
	sta.b a0
	adc.b a0
	sta.b a0
	lda.b [a0]
	sta.b a0
	rtl
loadTeamStruct:						; from SetLCmode and other segments
	lda.w pfteam,x
	beq .1
	stz.b a1
	lda.w #$0002
	sta.b a2
	rtl
.1:									; a1 = $0002, a2 = 0, return
	lda.w #$0002
	sta.b a1
	stz.b a2
	rtl
DATA8_C5362B:						; not traced: data between routines
	db $6B
InitScores:							; an rtl: called where 94S sets random scores for the round's other games
	rtl
DATA8_C5362D:						; not traced: data between routines
	db $6B
GetPlayerCount:						; returns team a2 roster count in d0
	ldy.w #HomeRoster
	lda.b a2
	beq .1
	ldy.w #VisRoster
.1:									; d0 = $0000,y, return
	lda.w $0000,y
	sta.b d0
	rtl
ChkShotStat_add:					; no caller found (not traced)
	ldy.b d1
	lda.w pfteam,x
	beq .1
	iny
	iny
.1:									; A = $0000,y, A + d0, $0000,y = A, return
	lda.w $0000,y
	clc
	adc.b d0
	sta.w $0000,y
	rtl
FaceoffPads:						; restores pad sides and resets player control before assigning each team
									; pad through findpc
	jsl.l CalcPuckDistances
	lda.w OptPlayMode
	cmp.w #$0001
	beq .2
	lda.w penshot
	bne .2
	ldy.w #$0008
.loop:								; loop: A = padside,y, A and $FF00, if A is not $8000 go to .1, ...
	lda.w padside,y
	and.w #$FF00
	cmp.w #$8000
	bne .1
	lda.w padside,y
	and.w #$00FF
	sta.w padside,y
	inc a
	inc a
	lsr a
	sta.w cont1team,y
.1:									; Y - 1, Y - 1, if the result >= 0 go to .loop
	dey
	dey
	bpl .loop
.2:									; benchcheer = 0, X = $0016, A = $FFFF
	stz.w benchcheer
	ldx.w #$0016
	lda.w #$FFFF
.loop2:								; loop: playerpad,x = A, goalieflags,x = 0, goalieturnwait,x = 0, ...
	sta.w playerpad,x
	stz.w goalieflags,x
	stz.w goalieturnwait,x
	stz.w goaliedivewait,x
	stz.w FaceoffUnused,x
	dex
	dex
	bpl .loop2
	sta.w dumpinplayer
	ldx.w #$0008
.loop3:								; loop: c1playernum,x = A, X - 1, X - 1, ...
	sta.w c1playernum,x
	dex
	dex
	bpl .loop3
	lda.w teampads
	beq .6
	lda.w #$0005
	sta.b p0
	ldx.w fopadfirst
	lda.w #$FFFF
	sta.w fopadfirst
	dex
	dex
	bpl .loop4
	ldx.w #$0008
.loop4:								; loop: if padside,x is not 0 go to .4, d4 = X, push X, ...
	lda.w padside,x
	bne .4
	stx.b d4
	phx
	lda.w fopadfirst
	bpl .3
	stx.w fopadfirst
.3:									; call findpc, pull X
	jsl.l findpc
	plx
.4:									; X - 1, X - 1, if the result >= 0 go to .5, X = $0008
	dex
	dex
	bpl .5
	ldx.w #$0008
.5:									; p0 - 1, if the result is not 0 go to .loop4
	dec.b p0
	bne .loop4
.6:									; if teampads+2 = 0 go to .rtl, p0 = $0005, X = fopadfirst+2, ...
	lda.w teampads+2
	beq .rtl
	lda.w #$0005
	sta.b p0
	ldx.w fopadfirst+2
	lda.w #$FFFF
	sta.w fopadfirst+2
	dex
	dex
	bpl .loop5
	ldx.w #$0008
.loop5:								; loop: if padside,x is not $0002 go to .8, d4 = X, push X, ...
	lda.w padside,x
	cmp.w #$0002
	bne .8
	stx.b d4
	phx
	lda.w fopadfirst+2
	bpl .7
	stx.w fopadfirst+2
.7:									; call findpc, pull X
	jsl.l findpc
	plx
.8:									; X - 1, X - 1, if the result >= 0 go to .9, X = $0008
	dex
	dex
	bpl .9
	ldx.w #$0008
.9:									; p0 - 1, if the result is not 0 go to .loop5
	dec.b p0
	bne .loop5
.rtl:								; return
	rtl
PuckCarrierPad:						; called from other segments
	ldy.b d0
	lda.w playerpad,y
	bpl .rtl
	phx
	ldx.w #$0000
	cpy.w #$000C
	bcc .1
	ldx.w #$0002
.1:									; if teampads,x = 0 go to .4, Y = puckpadnext,x, Y - 1, Y - 1, ...
	lda.w teampads,x
	beq .4
	ldy.w puckpadnext,x
	dey
	dey
	bpl .2
	ldy.w #$0008
.2:									; r3 = $0005, A = X
	lda.w #$0005
	sta.b r3
	txa
.3:									; if A is not padside,y go to .5, d4 = Y, A = Y, puckpadnext,x = A, ...
	cmp.w padside,y
	bne .5
	sty.b d4
	tya
	sta.w puckpadnext,x
	jsl.l AssignPadPlayer
.4:									; pull X, return
	plx
	rtl
.5:									; Y - 1, Y - 1, if the result >= 0 go to .6, Y = $0008
	dey
	dey
	bpl .6
	ldy.w #$0008
.6:									; r3 - 1, if the result is not 0 go to .3, pull X
	dec.b r3
	bne .3
	plx
.rtl:								; return
	rtl
AssignPadIfFree:					; gives the free pad d4 to player d0 (AssignPadPlayer) unless he already
									; has one
	ldy.b d0
	lda.w playerpad,y
	bpl .rtl
	jsl.l AssignPadPlayer
.rtl:								; return
	rtl
AssignPadPlayer:					; from PuckCarrierPad, AssignPadIfFree, PadTakePosition, ...
	lda.w #$FFFF
	sta.w dumpinplayer
	ldy.b d4
	lda.w c1playernum,y
	cmp.b d0
	beq .rtl
	tay
	cpy.w #$0018
	bcs .1
	lda.w pflags,y
	and.w #$FFF7
	ora.w #$0002
	sta.w pflags,y
	lda.w #$FFFF
	sta.w playerpad,y
	lda.w position,y
	bne .1
	lda.w #$0000
	sta.w goalieflags,y
.1:									; if d0 >= $0018 go to .rtl, A = pflags,y, A or $0008, pflags,y = A, ...
	ldy.b d0
	cpy.w #$0018
	bcs .rtl
	lda.w pflags,y
	ora.w #$0008
	sta.w pflags,y
	lda.b d4
	sta.w playerpad,y
	tay
	lda.b d0
	sta.w c1playernum,y
.rtl:								; return
	rtl
findpc:								; from FaceoffPads and other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	lda.w #$0008
	sta.b r0
	ldy.w puckc
	bra CODE_C53813
CODE_C537DE:						; no caller found (not traced)
	lda.w position,x
	beq .1
	lda.w playerpad,x
	bmi .1
	lda.w pfalock,x
	bne .1
	lda.w puckdist,x
	cmp.w #$0028
	bcs .1
	jmp.w CODE_C53882
.1:									; if playerpad,y < 0 go to .2, Y = A, ...
	lda.w playerpad,y
	bmi .2
	tay
	lda.w padside,y
	cmp.w padside,x
	beq CODE_C53813
.2:									; Y = $0000, if pfgoal,x is not 0 go to .3, Y = $0004
	ldy.w #$0000
	lda.w pfgoal,x
	bne .3
	ldy.w #$0004
.3:									; r0 = Y
	sty.b r0
CODE_C53813:						; from findpc, CODE_C537DE
	lda.w #$0006
	sta.b d1
	ldy.b d4
	lda.w #$FFFF
	sta.b d2
	ldx.w #$0000
	lda.w cont1team,y
	cmp.w #$0001
	beq .loop
	ldx.w #$000C
.loop:								; loop: if position,x < 0 go to .4, if zero go to .4, A = pflags,x, ...
	lda.w position,x
	bmi .4
	beq .4
	lda.w pflags,x
	bit.w #$1000
	bne .4
	lda.w SPA,x
	cmp.w #$2030
	bcc .1
	cmp.w #$21BD
	bcc .2
.1:									; A = pflags,x, A and $1000, if the result is not 0 go to .4
	lda.w pflags,x
	and.w #$1000
	ora.w pfalock,x
	bne .4
.2:									; if playerpad,x < 0 go to .3, if playerpad,x is not d4 go to .4
	lda.w playerpad,x
	bmi .3
	cmp.b d4
	bne .4
.3:									; r3 = 0, if puckdist,x >= d2 go to .4, d3 = X, d2 = A
	stz.b r3
	lda.w puckdist,x
	cmp.b d2
	bcs .4
	stx.b d3
	sta.b d2
.4:									; X + 1, X + 1, d1 - 1, if the result is not 0 go to .loop, ...
	inx
	inx
	dec.b d1
	bne .loop
	ldx.b a3
	lda.b d2
	cmp.w #$FFFF
	beq CODE_C538C5
	ldy.b d4
	lda.b d3
	cmp.w c1playernum,y
	bne CODE_C538BF
CODE_C53882:						; from CODE_C537DE
	lda.w pfalock,x
	bne CODE_C538C5
	pei ($8F)
	pei ($91)
	pei ($93)
	pei ($95)
	pei ($97)
	pei ($99)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	jsl.l Sweepcheck
	pla
	sta.b $69
	pla
	sta.b a1
	pla
	sta.b $65
	pla
	sta.b a0
	pla
	sta.b $99
	pla
	sta.b d6
	pla
	sta.b $95
	pla
	sta.b d5
	pla
	sta.b $91
	pla
	sta.b d4
	bra CODE_C538C5
CODE_C538BF:						; from CODE_C53813
	sta.b d0
	jsl.l AssignPadPlayer
CODE_C538C5:						; from CODE_C53813, CODE_C53882
	pla
	sta.b $8D
	pla
	sta.b d3
	pla
	sta.b $89
	pla
	sta.b d2
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
	rtl
PassPadToTeammate:					; called from other segments
	ldy.w #$0000
	cpx.w #$000C
	bcc .loop
	ldy.w #$000C
.loop:								; loop: if playerpad,y >= 0 go to .1, if position,y >= 0 go to .2
	lda.w playerpad,y
	bpl .1
	lda.w position,y
	bpl .2
.1:									; Y + 1, Y + 1, go to .loop
	iny
	iny
	bra .loop
.2:									; push X, call PadTakePosition, pull X, return
	phx
	jsl.l PadTakePosition
	plx
	rtl
PadTakeGoalie:						; the pad in d4 takes the goalie: A = 0, PadTakePosition
	lda.w #$0000
	bra PadTakePosition
PadTakeRightDefense:				; with defense control on for the pad's team: pad d4 takes the right
									; defenseman (by the side the team shoots at), then PadTakePosition
	ldy.w #$0000
	cpx.w #$000C
	bcc .1
	ldy.w #$0002
.1:									; if defcontrol,y is not 0 go to .2, return
	lda.w defcontrol,y
	bne .2
	rtl
.2:									; A = $0002, if pfgoal,x is not 0 go to PadTakePosition, A = $0001, ...
	lda.w #$0002
	ldy.w pfgoal,x
	bne PadTakePosition
	lda.w #$0001
	bra PadTakePosition
PadTakeLeftDefense:					; with defense control on for the pad's team: pad d4 takes the left
									; defenseman (by the side the team shoots at), then PadTakePosition
	ldy.w #$0000
	cpx.w #$000C
	bcc .1
	ldy.w #$0002
.1:									; if defcontrol,y is not 0 go to .2, return
	lda.w defcontrol,y
	bne .2
	rtl
.2:									; A = $0001, if pfgoal,x is not 0 go to PadTakePosition, A = $0002
	lda.w #$0001
	ldy.w pfgoal,x
	bne PadTakePosition
	lda.w #$0002
PadTakePosition:					; from PadTakeGoalie, PassPadToTeammate, PadTakeRightDefense, ...
	sta.b d1
	phx
	ldy.b d4
	ldx.w #$0000
	lda.w cont1team,y
	cmp.w #$0001
	beq .1
	ldx.w #$000C
.1:									; d0 = $0005
	lda.w #$0005
	sta.b d0
.loop:								; loop: if position,x = d1 go to .2, X + 1, X + 1, d0 - 1, ...
	lda.w position,x
	cmp.b d1
	beq .2
	inx
	inx
	dec.b d0
	bpl .loop
	bra .3
.2:									; if playerpad,x >= 0 go to .3, A = pflags,x, ...
	lda.w playerpad,x
	bpl .3
	lda.w pflags,x
	bit.w #$1000
	bne .3
	lda.w padinputdone,y
	inc a
	sta.w padinputdone,y
	stx.b d0
	jsl.l AssignPadPlayer
.3:									; pull X, return
	plx
	rtl
InitGameSpritesLong:				; InitGameSprites for long calls
	jsr.w InitGameSprites
	rtl
InitGameSprites:					; resets the sprites, creates sprite record $1D (with the allocators at
									; $56 / $45), then the home and away team palettes (HomeSpritePal /
									; VisSpritePal) and palettes $B8 / $B9 (UseSpritePalette)
	jsl.l ResetSprites
	stz.b $20
	stz.b $1E
	lda.w #$001D
	jsl.l CreateSpriteSharePal
	lda.w #$FFFF
	sta.b $0A,x
	lda.w #$0056
	sta.b $1A,x
	sta.w SmallTileNext
	lda.w #$0045
	sta.b $1C,x
	sta.w LargeSlotNext
	lda.w HomeTeam
	asl a
	adc.w #$0081
	sta.w HomeSpritePal
	jsl.l UseSpritePalette
	lda.w VisTeam
	asl a
	adc.w #$0080
	sta.w VisSpritePal
	jsl.l UseSpritePalette
	lda.w #$00B8
	jsl.l UseSpritePalette
	lda.w #$00B9
	jsl.l UseSpritePalette
	jsl.l ResetWorkBuf
	rts
CODE_C539D7:						; called from other segments
	ldx.w #$0009
	ldy.w #$0003
	lda.w #$5AF7
	jsl.l Framer
	lda.w VisTeam
	jsr.w PackTeamSecondText
	ldy.w #$5B18
	jsl.l QueueVRAMDMALen
	lda.w HomeTeam
	jsr.w PackTeamSecondText
	ldy.w #$5B1C
	jsl.l QueueVRAMDMALen
	lda.w tmscore+2
	jsr.w BinToBCD
	jsr.w BCDText
	ldx.w #mesarea
	jsr.w PackShortText
	ldy.w #$5B38
	jsl.l QueueVRAMDMALen
	lda.w tmscore
	jsr.w BinToBCD
	jsr.w BCDText
	ldx.w #mesarea
	jsr.w PackShortText
	ldy.w #$5B3C
	jmp.w QueueVRAMDMALen
CODE_C53A29:						; called from other segments
	jsl.l showclockdma
	lda.w gsp
	asl a
	asl a
	adc.w #$3A61
	ldx.w #$00C5
	ldy.w #$5B21
	jsl.l QueueVRAMDMALen
	lda.w sflags
	bit.w #$2000
	bne .1
	ldx.w #$000A
	ldy.w #$0002
	lda.w #$5B00
	jml.l Framer
.1:									; X = $000A, Y = $0004, A = $5AC0, go to Framer
	ldx.w #$000A
	ldy.w #$0004
	lda.w #$5AC0
	jml.l Framer
DATA8_C53A61:						; not traced: data between routines
	db $03,$B1,$F3,$F4,$03,$B2,$EE,$E4,$03,$B3,$F2,$E4,$03,$CF,$D4,$A0
PackTeamSecondTextLong:				; PackTeamSecondText for long calls
	jsr.w PackTeamSecondText
	rtl
PackTeamSecondText:					; A = a work buffer with team A's second packed string (A a team number)
									; as a length-prefixed text (PackShortText), X = its bank
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jsl.l UnpackText
	ldx.b $16
	lda.b $0A
	beq .1
	inx
.1:									; call UnpackText
	jsl.l UnpackText
PackShortText:						; copies zero-ended text X into a length-prefixed work buffer with bit 7
									; toggled
	lda.w #$0004
	jsl.l AllocWorkBuf2
	pha
	tay
	sep #$20
.loop:								; loop: if $0000,x = 0 go to .1, A xor $80, $0001,y = A, X + 1, ...
	lda.w $0000,x
	beq .1
	eor.b #$80
	sta.w $0001,y
	inx
	iny
	bra .loop
.1:									; A 16-bit, A = Y, A - $01,s, pull X, ...
	rep #$20
	sec
	tya
	sbc.b $01,s
	plx
	sep #$20
	sta.w $0000,x
	rep #$20
	txa
	ldx.w #$007E
	rts
GetPadTeam:							; a2 = the team of the pad that paused (0 home, 2 visitors), from its
									; entry in cont1team
	stz.b a2
	ldx.w pausepad
	bpl .1
	txa
	eor.w #$FFFF
	inc a
	ldx.w #$0008
.loop:								; loop: if A = cont1team,x go to .1, X - 1, X - 1, ...
	cmp.w cont1team,x
	beq .1
	dex
	dex
	bpl .loop
	rtl
.1:									; if $0002 is not cont1team,x go to .rtl, a2 = A
	lda.w #$0002
	cmp.w cont1team,x
	bne .rtl
	sta.b a2
.rtl:								; return
	rtl
ResetBench:							; called from other segments
	stz.w PBnum
	lda.w #$0010
	sta.b d1
	stz.b a0
	jsl.l ResetTeamBench
	lda.w #$0001
	sta.b d1
	lda.w #$0002
	sta.b a0
ResetTeamBench:						; team a0's players: each still in the box counted into PBnum by d1, the
									; others back on the bench (tmpdst) unless out
	lda.w #$0032
	sta.b d0
.1:									; A = PBnum, A + d1, PBnum = A, if a0 = 0 go to .2, ...
	lda.w PBnum
	clc
	adc.b d1
	sta.w PBnum
	lda.b a0
	beq .2
	lda.w #$0034
.2:									; A + d0, Y = A, if tmpdst,y < 0 go to .3, if zero go to .3, ...
	adc.b d0
	tay
	lda.w tmpdst,y
	bmi .3
	beq .3
	bit.w #$1000
	beq .4
	and.w #$07FF
	sta.b d2
	bne .4
	lda.w PBnum
	sec
	sbc.b d1
	sta.w PBnum
	bra .4
.3:									; A = PBnum, A - d1, PBnum = A, if tmpdst,y = $FFFD go to .4, ...
	lda.w PBnum
	sec
	sbc.b d1
	sta.w PBnum
	lda.w tmpdst,y
	cmp.w #$FFFD
	beq .4
	cmp.w #$FFFC
	beq .4
	lda.w #$FFFE
	sta.w tmpdst,y
.4:									; d0 - 1, d0 - 1, if the result >= 0 go to .1, return
	dec.b d0
	dec.b d0
	bpl .1
	rtl
forcepldata:						; face offs: moves team a2's players straight to their new positions
									; (newpos, newpnum)
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	pei ($8F)
	pei ($91)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	ldy.b a2
	lda.w tmsort,y
	sta.b a3
	lda.w #$0005
	sta.b d4
.loop:								; loop: X = a3, A = newpos,x, A and $00FF, ...
	ldx.b a3
	lda.w newpos,x
	and.w #$00FF
	bit.w #$0080
	beq .1
	ora.w #$FF00
.1:									; d0 = A, position,x = A, if A - $0000 < 0 go to .4, call Setplass, ...
	sta.b d0
	sta.w position,x
	cmp.w #$0000
	bmi .4
	jsl.l Setplass
	ldx.b a3
	lda.w position,x
	cmp.w #$0004
	bne .2
	lda.w #$0012
	sta.b d0
	jsl.l assinsert
.2:									; X = a3, A = newpnum,x, A and $00FF, A * 2, ...
	ldx.b a3
	lda.w newpnum,x
	and.w #$00FF
	asl a
	sta.b d3
	lda.b a2
	beq .3
	lda.w #$0034
.3:									; A + d3, Y = A, tmpdst,y = $FFFF, d3 / 2, ...
	clc
	adc.b d3
	tay
	lda.w #$FFFF
	sta.w tmpdst,y
	lsr.b d3
	jsl.l setplayer
.4:									; X = a3, newpnum,x = $FFFF, newpos,x = A, a3 + 1, ...
	ldx.b a3
	lda.w #$FFFF
	sta.w newpnum,x
	sta.w newpos,x
	inc.b a3
	inc.b a3
	dec.b d4
	bpl .loop
	pla
	sta.b $71
	pla
	sta.b a3
	pla
	sta.b $6D
	pla
	sta.b a2
	pla
	sta.b $69
	pla
	sta.b a1
	pla
	sta.b $65
	pla
	sta.b a0
	pla
	sta.b $91
	pla
	sta.b d4
	pla
	sta.b $8D
	pla
	sta.b d3
	pla
	sta.b $89
	pla
	sta.b d2
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
	ldx.b a3
	rtl
Setplass:							; from forcepldata and other segments
	lda.w position,x
	sta.b d0
	bmi .rtl
	lda.w #$00C5
	sta.b $65
	lda.w #$3C3F
	sta.b a0
	ldy.b d0
	lda.b [a0],y
	and.w #$00FF
	sta.b d0
	jml.l assreplace
.rtl:								; return
	rtl
DATA8_C53C3F:						; not traced: data between routines
	db $07,$02,$02,$03,$05,$03,$05
setplayer:							; from forcepldata and other segments
	phx
	phy
	lda.w pflags,x
	and.w #$FFFB
	sta.w pflags,x
	ldy.w #$0000
	lda.w pfteam,x
	beq .1
	ldy.w #$0002
.1:									; a0 = Y, A = d3, A and $00FF, pnum,x = A, ...
	sty.b a0
	lda.b d3
	and.w #$00FF
	sta.w pnum,x
	asl a
	sta.b d3
	lda.w #$000B
	sta.b d0
	lda.b a0
	beq .2
	lda.w #$0034
.2:									; A + d3, Y = A, d1 = tmpdst,y, A = Y, ...
	adc.b d3
	tay
	lda.w tmpdst,y
	sta.b d1
	tya
	sta.b r3
	asl a
	adc.b r3
	asl a
	sta.b r3
	lda.b d1
	bpl .3
	lda.w #$000A
	sta.b d0
	lda.b d1
	cmp.w #$FFFE
	bne .4
.3:									; call assinsert, pfalock,x = 0, SPA,x = 0
	jsl.l assinsert
	stz.w pfalock,x
	stz.w SPA,x
.4:									; if a0 = 0 go to .5, A = $0034
	lda.b a0
	beq .5
	lda.w #$0034
.5:									; A + d3, Y = A, tmpdst,y = $FFFF, d3 / 2, ...
	clc
	adc.b d3
	tay
	lda.w #$FFFF
	sta.w tmpdst,y
	lsr.b d3
	ldy.w #HomeRoster
	lda.b a0
	beq .6
	ldy.w #VisRoster
.6:									; a0 = Y, PPBonus = 0, PKBonus = 0, ThirdPBonus = 0, ...
	sty.b a0
	stz.w PPBonus
	stz.w PKBonus
	stz.w ThirdPBonus
	stz.w HmAwBonus
	lda.w position,x
	bne .7
	jmp.w .14
.7:									; A = sflags, if $2000 bits clear go to .9, call chkpk2, ...
	lda.w sflags
	bit.w #$2000
	beq .9
	jsl.l chkpk2
	beq .8
	lda.w $0436,y
	sta.w PPBonus
	bra .9
.8:									; PKBonus = $0434,y
	lda.w $0434,y
	sta.w PKBonus
.9:									; HmAwBonus = $043A,y, if pfteam,x is not 0 go to .10, HmAwBonus = $0430,y
	lda.w $043A,y
	sta.w HmAwBonus
	lda.w pfteam,x
	bne .10
	lda.w $0430,y
	sta.w HmAwBonus
.10:								; A = gsp, A - $0002, if the result < 0 go to .14, ...
	lda.w gsp
	sec
	sbc.w #$0002
	bmi .14
	bne .11
	jsl.l GetPeriodTime
	lda.b d0
	lsr a
	sec
	sbc.w gameclock
	beq .11
	bpl .14
.11:								; A = tmscore, A - tmscore+2, tmp0 = A, if zero go to .13, ...
	lda.w tmscore
	sec
	sbc.w tmscore+2
	sta.b tmp0
	beq .13
	lda.w pfteam,x
	beq .12
	lda.w #$0000
	sec
	sbc.b tmp0
	sta.b tmp0
.12:								; if tmp0 >= 0 go to .14
	lda.b tmp0
	bpl .14
.13:								; ThirdPBonus = $0002
	lda.w #$0002
	sta.w ThirdPBonus
.14:								; A = d3, A / 2, A / 2, A / 2, ...
	lda.b d3
	xba
	lsr a
	lsr a
	lsr a
	adc.b a0
	tay
	lda.w $0110,y
	and.w #$007F
	phx
	tax
	lda.l BCDTable,x
	and.w #$00FF
	plx
	sta.w rostnum,x
	lda.w $0111,y
	and.w #$00F0
	lsr a
	sta.w weight,x
	sty.b a0
	lda.w $0111,y
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	ldy.w #$0000
	jsr.w HotColdRating
	sta.w legstr,x
	ldy.b a0
	lda.w $0112,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	ldy.w #$0001
	jsr.w HotColdRating
	sta.w legspd,x
	ldy.b a0
	lda.w $0112,y
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	clc
	adc.w PPBonus
	clc
	adc.w PKBonus
	clc
	adc.w HmAwBonus
	clc
	adc.w ThirdPBonus
	ldy.w #$0002
	jsr.w HotColdRating
	eor.w #$000F
	clc
	adc.w #$000F
	lsr a
	sta.w aioff,x
	ldy.b a0
	lda.w $0113,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	clc
	adc.w HmAwBonus
	ldy.w #$0003
	jsr.w HotColdRating
	pha
	lda.w position,x
	beq .15
	pla
	eor.w #$000F
	clc
	adc.w #$0007
	sta.w aidef,x
	bra .16
.15:								; pull A, A xor $000F, A + $000F, A / 2, ...
	pla
	eor.w #$000F
	clc
	adc.w #$000F
	lsr a
	sta.w aidef,x
.16:								; Y = a0, A = $0113,y, A and $0007, r0 = A, ...
	ldy.b a0
	lda.w $0113,y
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	ldy.w #$0004
	jsr.w HotColdRating
	sta.w shotspd,x
	ldy.b a0
	lda.w $0114,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	clc
	adc.w ThirdPBonus
	ldy.w #$0005
	jsr.w HotColdRating
	sta.w checking,x
	ldy.b a0
	lda.w $0114,y
	and.w #$0001
	eor.w #$0001
	sta.w handed,x
	lda.w attribute,x
	ora.w #$0800
	sta.w attribute,x
	lda.w $0114,y
	and.w #$000E
	sta.w fighting,x
	lda.w $0115,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	clc
	adc.w PPBonus
	clc
	adc.w PKBonus
	clc
	adc.w HmAwBonus
	ldy.w #$0006
	jsr.w HotColdRating
	sta.w stickhand,x
	ldy.b a0
	lda.w $0115,y
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	clc
	adc.w PPBonus
	clc
	adc.w PKBonus
	clc
	adc.w HmAwBonus
	ldy.w #$0007
	jsr.w HotColdRating
	sta.w shotacc,x
	ldy.b a0
	lda.w $0116,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	ldy.w #$0008
	jsr.w HotColdRating
	sta.w endurance,x
	ldy.b a0
	lda.w $0116,y
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	clc
	adc.w ThirdPBonus
	clc
	adc.w ThirdPBonus
	ldy.w #$0009
	jsr.w HotColdRating
	sta.w spodds,x
	ldy.b a0
	lda.w $0117,y
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	clc
	adc.w PPBonus
	clc
	adc.w HmAwBonus
	ldy.w #$000A
	jsr.w HotColdRating
	sta.w passacc,x
	ldy.b a0
	lda.w $0117,y
	and.w #$0007
	sta.b r0
	asl a
	asl a
	adc.b r0
	lsr a
	ldy.w #$000B
	jsr.w HotColdRating
	sta.w aggress,x
	txy
	lda.w weight,x
	lsr a
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0020
	clc
	adc.w legstr,x
	sta.b r3
	lda.w legstr,x
	lsr a
	adc.b r3
	sta.b r3
	lda.w position,x
	bne .17
	lda.w legstr,x
	asl a
	adc.b r3
	adc.w #$0008
	sta.b r3
.17:								; A = r3, X = $0007, call Mul8U, A * 2, ...
	lda.b r3
	ldx.w #$0007
	jsl.l Mul8U
	asl a
	sta.w AccelStraight,y
	lda.b r3
	ldx.w #$0004
	jsl.l Mul8U
	asl a
	sta.w AccelDiagonal,y
	ply
	plx
	rtl
HotColdRating:						; A = rating A plus the player's hot / cold byte / 4 (HotColdTable at Y +
									; r3), kept within 0-15
	sta.b $42
	tya
	clc
	adc.b r3
	tay
	sep #$20
	lda.w HotColdTable,y
	lsr a
	lsr a
	bit.b #$00
	beq .1
	ora.b #$00
.1:									; A + $42, if the result >= 0 go to .2, A = $00
	clc
	adc.b $42
	bpl .2
	lda.b #$00
.2:									; if A < $0F go to .3, A = $0F
	cmp.b #$0F
	bcc .3
	lda.b #$0F
.3:									; A 16-bit, A and $00FF, return
	rep #$20
	and.w #$00FF
	rts
resetplstuff:						; resets the players of both teams (ResetTeamPlayers for a2 = 0 and 2),
									; keeping the work words
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	stz.b a2
	jsl.l ResetTeamPlayers
	lda.w #$0002
	sta.b a2
	jsl.l ResetTeamPlayers
	pla
	sta.b $71
	pla
	sta.b a3
	pla
	sta.b $6D
	pla
	sta.b a2
	pla
	sta.b $69
	pla
	sta.b a1
	pla
	sta.b $65
	pla
	sta.b a0
	pla
	sta.b $89
	pla
	sta.b d2
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
	ldx.b a3
	rtl

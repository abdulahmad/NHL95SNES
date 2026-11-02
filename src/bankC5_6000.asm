; Segment bankC5_6000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C56005
CODE_C56005:						; called from other segments
	jsr.w CODE_C56009
	rtl
CODE_C56009:						; from CODE_C56005, CODE_C56F98, CODE_C56FC1
	phy
	phx
	ldy.w #$0000
	sep #$20
.loop:								; loop: if $0000,x = 0 go to .1, Y + 1, X + 1, go to .loop
	lda.w $0000,x
	beq .1
	iny
	inx
	bra .loop
.1:									; A 16-bit, A = $03,s, X = A, A 8-bit
	rep #$20
	lda.b $03,s
	tax
	sep #$20
.loop2:								; loop: if $0000,x = 0 go to .2, Y + 1, X + 1, go to .loop2
	lda.w $0000,x
	beq .2
	iny
	inx
	bra .loop2
.2:									; A 16-bit, A = Y, A + 1, call AllocWorkBuf, ...
	rep #$20
	tya
	inc a
	jsl.l AllocWorkBuf
	pha
	tay
	lda.b $03,s
	tax
	sep #$20
.loop3:								; loop: if $0000,x = 0 go to .3, $0000,y = A, X + 1, Y + 1, ...
	lda.w $0000,x
	beq .3
	sta.w $0000,y
	inx
	iny
	bra .loop3
.3:									; A 16-bit, A = $05,s, X = A, A 8-bit
	rep #$20
	lda.b $05,s
	tax
	sep #$20
.loop4:								; loop: $0000,y = $0000,x, if $0000,x = 0 go to .4, X + 1, Y + 1, ...
	lda.w $0000,x
	sta.w $0000,y
	beq .4
	inx
	iny
	bra .loop4
.4:									; A 16-bit, pull X, pull A, pull A, ...
	rep #$20
	plx
	pla
	pla
	rts
CODE_C5605D:						; from DrawPenaltyRow, DrawScoringRow, CODE_C5711B and other segments
	ldx.w #$0000
	phy
	txy
	sta.b r2
	lda.w #$003C
	sta.b r1
	jsl.l Div16x8U
	tax
	lda.l BCDTable,x
	and.w #$00FF
	tyx
	jsr.w BCDTextAt
	lda.w #$003F
	sta.w mesarea,x
	inx
	txy
	lda.l RDMPYL
	tax
	lda.l BCDTable,x
	tyx
	pha
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w mesarea,x
	inx
	pla
	and.w #$000F
	clc
	adc.w #$0030
	sta.w mesarea,x
	inx
	ply
	rts
CODE_C560A8:						; called from other segments
	jsr.w CODE_C5611C
	rtl
CODE_C560AC:						; called from other segments
	phy
	txy
	sta.b r2
	lda.w #$003C
	sta.b r1
	jsl.l Div16x8U
	tax
	lda.l BCDTable,x
	and.w #$00FF
	pha
	lsr a
	lsr a
	lsr a
	lsr a
	tyx
	jsr.w BCDTextAt
	pla
	and.w #$000F
	jsr.w BCDTextAt
	lda.w #$003F
	sta.w mesarea,x
	inx
	txy
	lda.l RDMPYL
	tax
	lda.l BCDTable,x
	tyx
	pha
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w mesarea,x
	inx
	pla
	and.w #$000F
	clc
	adc.w #$0030
	sta.w mesarea,x
	inx
	ply
	rts
CODE_C56100:						; called from other segments
	jsr.w CODE_C56104
	rtl
CODE_C56104:						; from CODE_C56100, DrawPenaltyRow, DrawScoringRow and other segments
	ldx.w HomeTeam
	cmp.w #$0000
	beq .1
	ldx.w VisTeam
.1:									; A = X, A * 2, X = A, A = $C30000,x, ...
	txa
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
CODE_C5611C:						; from CODE_C560A8 and other segments
	ldy.w #$0000
.loop:								; loop: call CODE_C56140, if A < $001D go to .1, call CODE_C56138, ...
	jsr.w CODE_C56140
	cmp.w #$001D
	bcc .1
	jsr.w CODE_C56138
	bra .loop
.1:									; if A is not $001A go to .loop, if Y = $0000 go to .rts, X + 1
	cmp.w #$001A
	bne .loop
	cpy.w #$0000
	beq .rts
	inx
.rts:								; return
	rts
CODE_C56138:						; from CODE_C5611C
	pha
	tya
	clc
	adc.w #$0003
	bra CODE_C5614C
CODE_C56140:						; from CODE_C5611C
	jsr.w CODE_C56158
	and.w #$001F
	pha
	tya
	clc
	adc.w #$0005
CODE_C5614C:						; from CODE_C56138
	cmp.w #$0008
	bcc .1
	inx
	sbc.w #$0008
.1:									; Y = A, pull A, return
	tay
	pla
	rts
CODE_C56158:						; from CODE_C56140
	lda.l $C30000,x
	cpy.w #$0000
	beq .rts
	phy
.loop:								; loop: A / 2, Y - 1, if the result is not 0 go to .loop, pull Y
	lsr a
	dey
	bne .loop
	ply
.rts:								; return
	rts
CODE_C56168:						; called from other segments
	asl a
	tax
	lda.l DATA8_C35F60,x
	tay
	and.w #$001F
	tax
	lda.l BCDTable,x
	jsr.w CODE_C5A321
	lda.w mesarea+2
	pha
	tya
	and.w #$00E0
	asl a
	asl a
	asl a
	xba
	sta.b tmp0
	asl a
	adc.b tmp0
	tax
	lda.l DATA8_C561DB,x
	sta.w mesarea
	lda.l DATA8_C561DB+2,x
	sta.w mesarea+2
	lda.w #$403D
	sta.w mesarea+3
	lda.w #$0020
	sta.w mesarea+5
	tya
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C561F0,x
	tax
	ldy.w #$FFFF
	sep #$20
.loop:								; loop: Y + 1, X + 1, $04FB,y = $C4FFFF,x, ...
	iny
	inx
	lda.l $C4FFFF,x
	sta.w mesarea+6,y
	bne .loop
	lda.b #$20
	sta.w mesarea+6,y
	pla
	cmp.b #$30
	beq .1
	sta.w mesarea+7,y
	iny
.1:									; pull A, $04FC,y = A, X = Y, $04FD,x = 0, ...
	pla
	sta.w mesarea+7,y
	tyx
	stz.w mesarea+8,x
	rep #$20
	rts
DATA8_C561DB:						; the day names, 3 letters each, read by CODE_C56168
	db "MonTueWedThrFriSatSun"
DATA8_C561F0:						; a word per month: its name (bank $C5), read by CODE_C56168
	dw MonthJanuary,MonthFebruary,MonthMarch,MonthApril
	dw MonthMay,MonthJune,MonthJuly,MonthAugust
	dw MonthSeptember,MonthOctober,MonthNovember,MonthDecember
MonthJanuary:						; January
	db "January",0
MonthFebruary:						; February
	db "February",0
MonthMarch:							; March
	db "March",0
MonthApril:							; April
	db "April",0
MonthMay:							; May
	db "May",0
MonthJune:							; June
	db "June",0
MonthJuly:							; July
	db "July",0
MonthAugust:						; August
	db "August",0
MonthSeptember:						; September
	db "September",0
MonthOctober:						; October
	db "October",0
MonthNovember:						; November
	db "November",0
MonthDecember:						; December
	db "December",0
CODE_C5625E:						; called from other segments
	jsr.w CODE_C56262
	rtl
CODE_C56262:						; from CODE_C5625E and other segments
	phx
	sep #$20
.1:									; if $0000,x = 0 go to .4, if $0000,x is not $3D go to .2, A = $AE, ...
	lda.w $0000,x
	beq .4
	cmp.b #$3D
	bne .2
	lda.b #$AE
	bra .3
.2:									; A xor $80
	eor.b #$80
.3:									; $0000,x = A, X + 1, go to .1
	sta.w $0000,x
	inx
	bra .1
.4:									; A 16-bit, A = X, A - $01,s, if the result = 0 go to .5, ...
	rep #$20
	txa
	sec
	sbc.b $01,s
	beq .5
	pha
	dec a
	txy
	dex
	mvp $7E,$7E
	pla
.5:									; A 8-bit, pull X, $0000,x = A, A 16-bit, ...
	sep #$20
	plx
	sta.w $0000,x
	rep #$20
	rts
ShowGameStats:						; pause menu Game Stats: the team stat rows as a scrolling list
									; (DrawGameStatRow draws each, from one of two row lists); start returns
	lda.w #$531F
	jsr.w SetupStatsPage
	ldx.w #$5D5F
	lda.w OptPen
	bne .1
	ldx.w #$5DD7
.1:									; A = $C30000,x, A and $00FF, a1 = A, X + 1, ...
	lda.l $C30000,x
	and.w #$00FF
	sta.b a1
	inx
	stx.b a0
	ldx.w #$0009
	ldy.w #$000F
	lda.w #DrawGameStatRow
	jsr.w StartScrollList
	jsl.l SendTextMap
	stz.w fadestep
.loop:								; loop: TransfersReady + 1
	inc.w TransfersReady
.loop2:								; loop: if TransfersReady is not 0 go to .loop2, call ReadMenuPads, ...
	lda.w TransfersReady
	bne .loop2
	jsl.l ReadMenuPads
	inc.b $26
	jsr.w ScrollListArrows
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	lda.w repeatdelayframes
	bne .loop
	lda.w padchangeany
	bit.w #$1000
	bne .4
	bit.w #$0800
	beq .2
	jsr.w ScrollListUp
	bra .loop
.2:									; if $0400 bits clear go to .3, call ScrollListDown, go to .loop
	bit.w #$0400
	beq .3
	jsr.w ScrollListDown
	bra .loop
.3:									; go to .loop
	bra .loop
.4:									; go to ExitToPauseMenu
	jmp.w ExitToPauseMenu
DrawGameStatRow:					; draws row a3 of ShowGameStats' scrolling list: a team stat row
	lda.b a3
	asl a
	asl a
	asl a
	sec
	sbc.b a3
	clc
	adc.b a0
	sta.b $65
	tax
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.l $C30000,x
	tax
	ldy.b $6D
	jsl.l PrintBoldCentred
	stz.b a2
	lda.w #$00B8
	sta.b $CF
	lda.w #$00F8
	sta.b $D1
	ldx.b $65
	lda.l $C30002,x
	and.w #$00FF
	tax
	jsr (DATA8_C55D6B,x)
	lda.w #$0002
	sta.b a2
	lda.w #$0010
	sta.b $CF
	lda.w #$0038
	sta.b $D1
	ldx.b $65
	lda.l $C30002,x
	and.w #$00FF
	tax
	jmp (DATA8_C55D6B,x)
ShowPeriodStats:					; pause menu Period Stats: DrawPeriodStats; B switches between goals and
									; shots, start returns
	lda.w #$532D
	jsr.w SetupStatsPage
	stz.b $7B
	jsr.w DrawPeriodStats
	jsl.l SendTextMap
	stz.w fadestep
.loop:								; loop: TransfersReady + 1
	inc.w TransfersReady
.loop2:								; loop: if TransfersReady is not 0 go to .loop2, call ReadMenuPads, ...
	lda.w TransfersReady
	bne .loop2
	jsl.l ReadMenuPads
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	lda.w repeatdelayframes
	bne .loop
	lda.w padchangeany
	bit.w #$8000
	beq .1
	lda.b $D3
	clc
	adc.w #$03C0
	ldy.w #$0340
	jsl.l ClearRAM7E
	lda.b $7B
	eor.w #$0001
	sta.b $7B
	jsr.w DrawPeriodStats
	jsl.l SendTextMap
	bra .loop
.1:									; if $1000 bits clear go to .loop, go to ExitToPauseMenu
	bit.w #$1000
	beq .loop
	jmp.w ExitToPauseMenu
DrawPeriodStats:					; the period stats: the periods played and Total, the heading Goals or
									; Shots with the B hint, then each team's goals or shots per period and
									; their sum
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w #$0000
	ldy.w #$0013
.loop:								; loop: push A, push Y, A * 2, X = A, ...
	pha
	phy
	asl a
	tax
	lda.l DATA8_C35E25,x
	tax
	jsl.l PrintBoldCentred
	ply
	iny
	pla
	cmp.w lastperiod
	beq .1
	inc a
	bra .loop
.1:									; X = $4C1C, Y = $0018, call PrintBoldCentred, a1 = $4EEF, ...
	ldx.w #$4C1C
	ldy.w #$0018
	jsl.l PrintBoldCentred
	lda.w #$4EEF
	sta.b a1
	ldy.w #$129B
	ldx.w #$4B6A
	lda.b $7B
	beq .2
	ldy.w #$1287
	ldx.w #$4B9E
	lda.w #$4EE1
	sta.b a1
.2:									; a0 = Y, Y = $000F, call PrintItalicCentred, Y = $0011, ...
	sty.b a0
	ldy.w #$000F
	jsl.l PrintItalicCentred
	ldy.w #$0011
	jsl.l PrintTitleBar
	ldx.b a1
	ldy.w #$001A
	jsl.l PrintBoldLeft
	lda.w #$0090
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	jsr.w CODE_C56453
	lda.w #$0010
	sta.b $CF
	lda.w #$0070
	sta.b $D1
	inc.b a0
	inc.b a0
	jmp.w CODE_C56453
CODE_C56453:						; from DrawPeriodStats
	stz.b tmp0
	lda.w #$0000
	ldy.w #$0013
.loop:								; loop: push A, push Y, A * 2, A * 2, ...
	pha
	phy
	asl a
	asl a
	tay
	lda.b (a0),y
	adc.b tmp0
	sta.b tmp0
	lda.b (a0),y
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	lda.b $01,s
	tay
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	ply
	iny
	pla
	cmp.w lastperiod
	beq .1
	inc a
	bra .loop
.1:									; Y = $0018, X = tmp0, A = BCDTable,x, A and $00FF, ...
	ldy.w #$0018
	ldx.b tmp0
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	rts
ShowPlayerStats:					; pause menu Player Stats: the skaters of team a2 sorted by a stat column
									; (left / right) or its goalies (B); Y switches the team, up / down
									; scroll, start returns
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	jsr.w SetupScreen
	lda.w #$533B
	jsl.l PrintTextPage
	jsl.l GetPadTeam
	stz.b $7D
	ldy.w #$2801
	ldx.w #$5135
	jsl.l MapTileBlock
	stz.w padchangeany
.1:									; $18 = $00D0, $1A = $0028, $CF = $00A8, $D1 = $00F0, ...
	lda.w #$00D0
	sta.b $18
	lda.w #$0028
	sta.b $1A
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w padchangeany
	bit.w #$8000
	bne .2
	clc
	lda.b $D3
	adc.w #$026A
	pha
	ldy.w #$0012
	jsl.l ClearRAM7E
	pla
	clc
	adc.w #$0040
	ldy.w #$0012
	jsl.l ClearRAM7E
	jsl.l SendTextMap
.2:									; call CODE_C55E57, X = $2DC9, if a2 = 0 go to .3, X = $3207
	jsr.w CODE_C55E57
	ldx.w #$2DC9
	lda.b a2
	beq .3
	ldx.w #$3207
.3:									; if $7D is not $FFFF go to .4, a1 = $0002,x, call SortGoalieStats, ...
	lda.b $7D
	cmp.w #$FFFF
	bne .4
	lda.w $0002,x
	sta.b a1
	jsr.w SortGoalieStats
	bra .5
.4:									; A = $0000,x, A - $0002,x, a1 = A, call SortPlayerStats
	lda.w $0000,x
	sec
	sbc.w $0002,x
	sta.b a1
	jsr.w SortPlayerStats
.5:									; A = DrawPlayerStatRow, X = $000B, Y = $000D, call StartScrollList, ...
	lda.w #DrawPlayerStatRow
	ldx.w #$000B
	ldy.w #$000D
	jsr.w StartScrollList
	jsr.w CODE_C56880
	jsl.l SendTextMap
	stz.w fadestep
.loop:								; loop: TransfersReady + 1
	inc.w TransfersReady
.loop2:								; loop: if TransfersReady is not 0 go to .loop2, call ReadMenuPads, ...
	lda.w TransfersReady
	bne .loop2
	jsl.l ReadMenuPads
	inc.b $26
	jsr.w ScrollListArrows
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	lda.w repeatdelayframes
	bne .loop
	lda.w padchangeany
	bit.w #$1000
	beq .6
	jmp.w ExitToPauseMenu
.6:									; if $0800 bits clear go to .7, call ScrollListUp, go to .loop
	bit.w #$0800
	beq .7
	jsr.w ScrollListUp
	bra .loop
.7:									; if $0400 bits clear go to .8, call ScrollListDown, go to .loop
	bit.w #$0400
	beq .8
	jsr.w ScrollListDown
	bra .loop
.8:									; if $7D = $FFFF go to .11, if $0200 bits clear go to .9, ...
	ldx.b $7D
	cpx.w #$FFFF
	beq .11
	bit.w #$0200
	beq .9
	lda.b $7D
	beq .9
	dec a
	dec a
	sta.b $7D
	bra .10
.9:									; if $0100 bits clear go to .11, if $7D = $0008 go to .11, A + 1, ...
	bit.w #$0100
	beq .11
	lda.b $7D
	cmp.w #$0008
	beq .11
	inc a
	inc a
	sta.b $7D
.10:								; call ClearPlayerStatsList, call SortPlayerStats, call CODE_C55C12, ...
	jsr.w ClearPlayerStatsList
	jsr.w SortPlayerStats
	jsr.w CODE_C55C12
	jsr.w CODE_C56880
	jsl.l SendTextMap
.11:								; if $4000 bits clear go to .13, A = a2, A xor $0002, a2 = A
	bit.w #$4000
	beq .13
	lda.b a2
	eor.w #$0002
	sta.b a2
.12:								; X = $7B, call DeleteSprite, X = $77, call DeleteSprite, ...
	ldx.b $7B
	jsl.l DeleteSprite
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	jsr.w ClearPlayerStatsList
	jmp.w .1
.13:								; if $8000 bits clear go to .15, A = $D3, A + $02C0, Y = $0040, ...
	bit.w #$8000
	beq .15
	lda.b $D3
	clc
	adc.w #$02C0
	ldy.w #$0040
	jsl.l ClearRAM7E
	jsr.w ClearPlayerStatsList
	lda.w #$FFFF
	cmp.b $7D
	beq .14
	sta.b $7D
	bra .12
.14:								; $7D = 0, go to .12
	stz.b $7D
	bra .12
.15:								; go to .loop
	jmp.w .loop
ClearPlayerStatsList:				; clears ShowPlayerStats' list area of the text map ($380 bytes from
									; +$300) and the two header rows above it
	lda.w #$0300
	clc
	adc.b $D3
	pha
	ldy.w #$0380
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	pla
	sec
	sbc.w #$0100
	pha
	ldy.w #$0020
	jsl.l ClearRAM7E
	pla
	clc
	adc.w #$0040
	ldy.w #$0020
	jsl.l ClearRAM7E
	jsl.l WaitTransfers
	rts
SortPlayerStats:					; sorts team a2's skaters by stat column $7D (PlayerStatColumn), best
									; first, into the order list at $364E after the goalies
	ldx.w #$2DC9
	ldy.w #$0000
	lda.b a2
	beq .1
	ldx.w #$3207
	ldy.w #$001A
.1:									; $A5 = Y, $364E = $0002,x, $0C = A, tmp1 = A, ...
	sty.b $A5
	lda.w $0002,x
	sta.w $364E
	sta.b $0C
	sta.b tmp1
	lda.b a1
	dec a
	sta.b tmp0
	lda.w #$0002
	sta.b tmp2
.loop:								; loop: tmp1 + 1, Y = tmp1, call PlayerStatColumn, $0A = A, ...
	inc.b tmp1
	ldy.b tmp1
	jsr.w PlayerStatColumn
	sta.b $0A
	stz.b $0E
.loop2:								; loop: Y = $0E, A = $364E,y, Y = A, call PlayerStatColumn, ...
	ldy.b $0E
	lda.w $364E,y
	tay
	jsr.w PlayerStatColumn
	cmp.b $0A
	bcc .3
	lda.b $0E
	inc a
	inc a
	sta.b $0E
	cmp.b tmp2
	bne .loop2
	tax
.2:									; $364E,x = tmp1, tmp2 + 1, tmp2 + 1, tmp0 - 1, ...
	lda.b tmp1
	sta.w $364E,x
	inc.b tmp2
	inc.b tmp2
	dec.b tmp0
	bne .loop
	rts
.3:									; X = tmp2
	ldx.b tmp2
.loop3:								; loop: X - 1, X - 1, $3650,x = $364E,x, if X is not $0E go to .loop3, ...
	dex
	dex
	lda.w $364E,x
	sta.w $3650,x
	cpx.b $0E
	bne .loop3
	bra .2
PlayerStatColumn:					; A = stat column $7D of roster player Y (+ $A5 for the away team): goals,
									; assists, points, shots or penalty minutes
	tya
	clc
	adc.b $A5
	pha
	ldx.b $7D
	jmp (DATA8_C566DE,x)
StatColGoals:						; PlayerStatColumn's goals column (tmgoals)
	plx
	lda.w tmgoals,x
	and.w #$00FF
	rts
StatColAssists:						; PlayerStatColumn's assists column (tmassists)
	plx
	lda.w tmassists,x
	and.w #$00FF
	rts
StatColPoints:						; PlayerStatColumn's points column (tmgoals + tmassists)
	plx
	lda.w tmassists,x
	and.w #$00FF
	pha
	lda.w tmgoals,x
	and.w #$00FF
	clc
	adc.b $01,s
	plx
	rts
StatColShots:						; PlayerStatColumn's shots column (tmpshots)
	plx
	lda.w tmpshots,x
	and.w #$00FF
	rts
StatColPenMin:						; PlayerStatColumn's penalty minutes column (ppenmin)
	plx
	lda.w ppenmin,x
	and.w #$00FF
	rts
DATA8_C566DE:						; jump table: the routine for each index
	dw StatColGoals,StatColAssists,StatColPoints,StatColShots
	dw StatColPenMin
SortGoalieStats:					; starts ShowPlayerStats' order list at $364E: team a2's goalies ordered
									; by goals against (tmgoals)
	ldx.w #$2DC9
	ldy.w #$0000
	lda.b a2
	beq .1
	ldx.w #$3207
	ldy.w #$001A
.1:									; $A5 = Y, $364E = 0, $0C = 0, tmp1 = 0, ...
	sty.b $A5
	stz.w $364E
	stz.b $0C
	stz.b tmp1
	lda.w $0002,x
	dec a
	sta.b tmp0
	lda.w #$0002
	sta.b tmp2
.loop:								; loop: tmp1 + 1, A = tmp1, A + $A5, X = A, ...
	inc.b tmp1
	lda.b tmp1
	clc
	adc.b $A5
	tax
	lda.w tmgoals,x
	and.w #$00FF
	sta.b $0A
	ldy.b $0C
	stz.b $0E
.loop2:								; loop: A = Y, A + $A5, X = A, A = tmgoals,x, ...
	tya
	clc
	adc.b $A5
	tax
	lda.w tmgoals,x
	and.w #$00FF
	cmp.b $0A
	bcc .3
	iny
	lda.b $0E
	inc a
	inc a
	sta.b $0E
	cmp.b tmp2
	bne .loop2
	tax
.2:									; $364E,x = tmp1, tmp2 + 1, tmp2 + 1, tmp0 - 1, ...
	lda.b tmp1
	sta.w $364E,x
	inc.b tmp2
	inc.b tmp2
	dec.b tmp0
	bne .loop
	rts
.3:									; X = tmp2
	ldx.b tmp2
.loop3:								; loop: X - 1, X - 1, $3650,x = $364E,x, if X is not $0E go to .loop3, ...
	dex
	dex
	lda.w $364E,x
	sta.w $3650,x
	cpx.b $0E
	bne .loop3
	bra .2
DrawPlayerStatRow:					; draws row a3 of ShowPlayerStats' scrolling list: a player and his stats
	lda.w #$0010
	sta.b $CF
	lda.b a3
	asl a
	tay
	lda.w $364E,y
	sta.b $65
	lda.w #$2DC9
	ldx.b a2
	beq .1
	lda.w #$3207
.1:									; push A, A = $65, A * 2, A * 2, ...
	pha
	lda.b $65
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $01,s
	adc.w #$0118
	plx
	tax
	lda.w #$000E
	jsr.w CODE_C55F1F
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.b a2
	beq .2
	lda.b $65
	clc
	adc.w #$001A
	sta.b $65
.2:									; $CF = $0078, $D1 = $0090, X = $65, A = tmgoals,x, ...
	lda.w #$0078
	sta.b $CF
	lda.w #$0090
	sta.b $D1
	ldx.b $65
	lda.w tmgoals,x
	and.w #$00FF
	ldx.w #$0000
	jsr.w CODE_C5680B
	lda.w #$00A8
	sta.b $D1
	ldx.b $65
	lda.b $7D
	cmp.w #$FFFF
	beq CODE_C5683C
	lda.w tmassists,x
	and.w #$00FF
	ldx.w #$0002
	jsr.w CODE_C5680B
	lda.w #$00C0
	sta.b $D1
	ldx.b $65
	lda.w tmgoals,x
	and.w #$00FF
	pha
	lda.w tmassists,x
	and.w #$00FF
	clc
	adc.b $01,s
	ply
	ldx.w #$0004
	jsr.w CODE_C5680B
	lda.w #$00D8
	sta.b $D1
	ldx.b $65
	lda.w tmpshots,x
	and.w #$00FF
	ldx.w #$0006
	jsr.w CODE_C5680B
	lda.w #$00F0
	sta.b $D1
	ldx.b $65
	lda.w ppenmin,x
	and.w #$00FF
	ldx.w #$0008
CODE_C5680B:						; from DrawPlayerStatRow, CODE_C5683C
	cpx.b $7D
	bne .1
	ldx.w #$2400
	stx.b $D5
.1:									; if A is not $0064 go to .2, A = $0100, go to .3
	cmp.w #$0064
	bne .2
	lda.w #$0100
	bra .3
.2:									; X = A, A = BCDTable,x, A and $00FF
	tax
	lda.l BCDTable,x
	and.w #$00FF
.3:									; call BCDText, Y = $6D, X = mesarea, call PrintBoldCentredStr, ...
	jsr.w BCDText
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	lda.w #$2000
	sta.b $D5
	lda.b $D1
	sta.b $CF
	rts
CODE_C5683C:						; from DrawPlayerStatRow
	lda.w tmpshots,x
	and.w #$00FF
	ldx.w #$8000
	jsr.w CODE_C5680B
	lda.w #$00E0
	sta.b $D1
	ldx.b $65
	lda.w tmgoals,x
	and.w #$00FF
	ldx.w #$0064
	jsl.l Mul8U
	sta.b r2
	ldx.b $65
	lda.w tmpshots,x
	and.w #$00FF
	sta.b r1
	beq .1
	jsl.l Div16U
	bra .2
.1:									; A = $0064
	lda.w #$0064
.2:									; A xor $FFFF, A + $0064, X = $8000, go to CODE_C5680B
	eor.w #$FFFF
	sec
	adc.w #$0064
	ldx.w #$8000
	jmp.w CODE_C5680B
CODE_C56880:						; from ShowPlayerStats
	lda.w #$0010
	sta.b $CF
	lda.w #$0078
	sta.b $D1
	lda.w #$0200
	clc
	adc.b $D3
	ldy.w #$0020
	jsl.l ClearRAM7E
	lda.w #$0240
	clc
	adc.b $D3
	ldy.w #$0020
	jsl.l ClearRAM7E
	ldy.w #$000B
	sty.b $6D
	ldx.b $7D
	cpx.w #$FFFF
	bne .1
	jmp.w CODE_C56938
.1:									; A = DATA8_C56989,x, X = A, Y = $0008, call PrintItalicLeft, ...
	lda.l DATA8_C56989,x
	tax
	ldy.w #$0008
	jsl.l PrintItalicLeft
	lda.w #$0020
	sta.b $CF
	ldx.w #$4EF6
	ldy.w #$0019
	jsl.l PrintBoldLeft
	lda.w #$0010
	sta.b $CF
	ldx.w #$4F6C
	lda.w #$8000
	jsr.w CODE_C5691F
	lda.w #$0090
	sta.b $D1
	ldx.w #$4F71
	lda.w #$0000
	jsr.w CODE_C5691F
	lda.w #$00A8
	sta.b $D1
	ldx.w #$4F73
	lda.w #$0002
	jsr.w CODE_C5691F
	lda.w #$00C0
	sta.b $D1
	ldx.w #$4F75
	lda.w #$0004
	jsr.w CODE_C5691F
	lda.w #$00D8
	sta.b $D1
	ldx.w #$4F78
	lda.w #$0006
	jsr.w CODE_C5691F
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4F7B
	lda.w #$0008
CODE_C5691F:						; from CODE_C56880, CODE_C56938
	cmp.b $7D
	bne .1
	lda.w #$2400
	sta.b $D5
.1:									; Y = $6D, call PrintBoldCentred, $D5 = $2000, $CF = $D1, ...
	ldy.b $6D
	jsl.l PrintBoldCentred
	lda.w #$2000
	sta.b $D5
	lda.b $D1
	sta.b $CF
	rts
CODE_C56938:						; from CODE_C56880
	ldx.w #$47F8
	ldy.w #$0008
	jsl.l PrintItalicLeft
	lda.w #$0020
	sta.b $CF
	ldx.w #$4EFE
	ldy.w #$0019
	jsl.l PrintBoldLeft
	lda.w #$0010
	sta.b $CF
	ldx.w #$49B8
	lda.w #$8000
	jsr.w CODE_C5691F
	lda.w #$0090
	sta.b $D1
	ldx.w #$4F7D
	lda.w #$8000
	jsr.w CODE_C5691F
	lda.w #$00A8
	sta.b $D1
	ldx.w #$4F78
	lda.w #$8000
	jsr.w CODE_C5691F
	lda.w #$00E0
	sta.b $D1
	ldx.w #$4F7F
	lda.w #$8000
	jmp.w CODE_C5691F
DATA8_C56989:						; not traced: a table read by CODE_C56880
	db $6A,$4B,$6F,$4B,$75,$4B,$9E,$4B,$08,$48
ShowPenaltySummary:					; pause menu Penalties: the penalties of the game (Per, Time, Tm, Player,
									; PM) as a scrolling list, No Penalties when there are none; start returns
	lda.w #$534D
	jsr.w SetupStatsPage
	lda.w #$0010
	sta.b $CF
	lda.w #$0030
	sta.b $D1
	ldx.w #$4F83
	jsr.w CODE_C56A6B
	lda.w #$0060
	sta.b $D1
	ldx.w #$4F87
	jsr.w CODE_C56A6B
	lda.w #$0080
	sta.b $D1
	ldx.w #$4F8B
	jsr.w CODE_C56A6B
	lda.w #$00E0
	sta.b $D1
	ldx.w #$4F6C
	jsr.w CODE_C56A6B
	lda.w #$00F8
	sta.b $D1
	ldx.w #$4F7B
	jsr.w CODE_C56A6B
	lda.w $1159
	asl a
	adc.w $1159
	bne .1
	sta.b a1
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w #$2400
	sta.b $D5
	ldx.w #$4C2D
	ldy.w #$0011
	jsl.l PrintBoldCentred
	lda.w #$2000
	sta.b $D5
	bra .2
.1:									; A - 1, a1 = A, A = DrawPenaltyRow, X = $0006, ...
	dec a
	sta.b a1
	lda.w #DrawPenaltyRow
	ldx.w #$0006
	ldy.w #$0012
	jsr.w StartScrollList
.2:									; call SendTextMap, fadestep = 0
	jsl.l SendTextMap
	stz.w fadestep
.loop:								; loop: TransfersReady + 1
	inc.w TransfersReady
.loop2:								; loop: if TransfersReady is not 0 go to .loop2, call ReadMenuPads, ...
	lda.w TransfersReady
	bne .loop2
	jsl.l ReadMenuPads
	inc.b $26
	lda.b a1
	beq .3
	jsr.w ScrollListArrows
.3:									; call AnimateSprites, $28 = $1D8F, $2A = $1E00, call BuildSpriteOAM, ...
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	lda.w repeatdelayframes
	bne .loop
	lda.w padchangeany
	bit.w #$1000
	bne .6
	ldx.b a1
	beq .loop
	bit.w #$0800
	beq .4
	jsr.w ScrollListUp
	bra .loop
.4:									; if $0400 bits clear go to .5, call ScrollListDown, go to .loop
	bit.w #$0400
	beq .5
	jsr.w ScrollListDown
	bra .loop
.5:									; go to .loop
	bra .loop
.6:									; go to ExitToPauseMenu
	jmp.w ExitToPauseMenu
CODE_C56A6B:						; from ShowPenaltySummary
	ldy.w #$000F
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	rts
DrawPenaltyRow:						; draws row a3 of ShowPenaltySummary's scrolling list: a penalty (period,
									; time, team, player, minutes)
	lda.b a3
	sta.b r2
	lda.w #$0003
	sta.b r1
	jsl.l Div16x8U
	asl a
	asl a
	sta.b $65
	tax
	lda.l RDMPYL
	beq .2
	dec a
	beq .1
	rts
.1:									; $CF = $0070, $D1 = $00E0, A = $115E,x, A and $00FF, ...
	lda.w #$0070
	sta.b $CF
	lda.w #$00E0
	sta.b $D1
	lda.w $115E,x
	and.w #$00FF
	tax
	lda.l DATA8_C34499,x
	sec
	adc.w #$4499
	inc a
	ldx.w #$00C3
	jsl.l CODE_C58BB9
	ldy.b $6D
	jsl.l PrintBoldRightStr
	rts
.2:									; $D5 = $2400, $CF = $0010, $D1 = $0030, A = $115C,x, ...
	lda.w #$2400
	sta.b $D5
	lda.w #$0010
	sta.b $CF
	lda.w #$0030
	sta.b $D1
	lda.w $115C,x
	and.w #$00C0
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	tax
	lda.l DATA8_C35E25,x
	tax
	ldy.b $6D
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	lda.w #$0060
	sta.b $D1
	ldx.b $65
	lda.w $115B,x
	and.w #$0FFF
	jsr.w CODE_C5605D
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	lda.b $D1
	sta.b $CF
	lda.w #$0080
	sta.b $D1
	ldx.b $65
	lda.w $115D,x
	and.w #$0080
	beq .3
	pea.w $3207
	bra .4
.3:									; continue
	pea.w $2DC9
.4:									; call CODE_C56104, Y = $6D, call PrintBoldCentred, $CF = $D1, ...
	jsr.w CODE_C56104
	ldy.b $6D
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	lda.w #$00E0
	sta.b $D1
	ldx.b $65
	lda.w $115D,x
	and.w #$007F
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $01,s
	adc.w #$0118
	plx
	tax
	lda.w #$000C
	jsr.w CODE_C55F1F
	ldy.b $6D
	jsl.l PrintBoldCentredStr
	lda.b $D1
	sta.b $CF
	lda.w #$00F8
	sta.b $D1
	ldx.b $65
	lda.w $115E,x
	and.w #$00FF
	tax
	lda.l DATA8_C34499,x
	tax
	lda.l DATA8_C34499,x
	and.w #$00FF
	jsr.w BCDText
	ldx.w #mesarea
	ldy.b $6D
	jsl.l PrintBoldCentredStr
	lda.w #$2000
	sta.b $D5
	rts
CODE_C56B7B:						; called from other segments
	lda.w #$0002
	bra CODE_C56B83
CODE_C56B80:						; from PauseTimeout and other segments
	lda.w #$0003
CODE_C56B83:						; from CODE_C56B7B
	stz.w $18F6
	sta.w $18F2
	jmp.w CODE_C54FA9
CODE_C56B8C:						; called from other segments
	jml.l CODE_C5004E
PauseTimeout:						; pause menu Time Out: when team a2 has one left, takes it, gives the team
									; full energy (reenergizeteam) and prints Time Out by and the team's name
	jsl.l GetPadTeam
	ldx.b a2
	lda.w tmtimeouts,x
	beq CODE_C56B80
	dec a
	sta.w tmtimeouts,x
	jsl.l reenergizeteam
	ldx.w #$5D41
	jsr.w CODE_C552AC
	lda.w #$00C3
	sta.b $2E
	lda.w #$5A08
	sta.b r0
	lda.w #$0318
	jsr.w CODE_C56C4C
	lda.w #$5A11
	sta.b r0
	lda.w #$039E
	jsr.w CODE_C56C4C
	lda.w HomeTeam
	ldx.b a2
	beq .1
	lda.w VisTeam
.1:									; A * 2, X = A, A = DATA8_C3585C,x, X = A, ...
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	jsl.l UnpackText
	lda.w #$007E
	sta.b $2E
	stx.b r0
	sep #$20
	ldy.w #$0000
.loop:								; loop: Y + 1, X + 1, if $0000,x is not 0 go to .loop, A = Y, ...
	iny
	inx
	lda.w $0000,x
	bne .loop
	tya
	pha
.loop2:								; loop: X - 1, if $0000,x is not $3D go to .2, A = $2E
	dex
	lda.w $0000,x
	cmp.b #$3D
	bne .2
	lda.b #$2E
.2:									; A xor $80, $0001,x = A, Y - 1, if the result is not 0 go to .loop2, ...
	eor.b #$80
	sta.w $0001,x
	dey
	bne .loop2
	pla
	sta.w $0000,x
	rep #$20
	and.w #$00FF
	eor.w #$FFFF
	sec
	adc.w #$000C
	lsr a
	adc.w #$0000
	asl a
	adc.w #$0414
	jsr.w CODE_C56C4C
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0700
	pea.w $5800
	pea.w $007E
	lda.w $18EE
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsl.l WaitTransfers
	ldx.w #$0096
	ldy.w #$0000
	jsl.l WaitFrames_Inc
	lda.w $18F2
	jmp.w CODE_C54FA9
CODE_C56C4C:						; from PauseTimeout
	clc
	adc.w $18EE
	tax
	lda.b [r0]
	and.w #$00FF
	tay
.loop:								; loop: r0 + 1, A = [r0], A and $00FF, A or $3A00, ...
	inc.b r0
	lda.b [r0]
	and.w #$00FF
	ora.w #$3A00
	sta.w $0000,x
	inx
	inx
	dey
	bne .loop
	rts
ShowScoringSummary:					; pause menu Score Summry: the goals of the game (Per, Time, Tm, Goal /
									; Ass., P/S) as a scrolling list, No Scoring when there are none; start
									; returns
	lda.w #$535B
	jsr.w SetupStatsPage
	lda.w #$0010
	sta.b $CF
	ldx.w #$4F83
	jsr.w CODE_C56D37
	lda.w #$002E
	sta.b $CF
	ldx.w #$4F87
	jsr.w CODE_C56D37
	lda.w #$0054
	sta.b $CF
	ldx.w #$4F8B
	jsr.w CODE_C56D37
	lda.w #$0080
	sta.b $CF
	ldx.w #$4F91
	jsr.w CODE_C56D37
	lda.w #$00E0
	sta.b $CF
	ldx.w #$4F8E
	jsr.w CODE_C56D37
	lda.w ScoreSumbytes
	lsr a
	sta.b a1
	bne .1
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w #$2400
	sta.b $D5
	ldx.w #$4C43
	ldy.w #$0011
	jsl.l PrintBoldCentred
	lda.w #$2000
	sta.b $D5
	bra .2
.1:									; A = DrawScoringRow, X = $0006, Y = $0012, call StartScrollList
	lda.w #DrawScoringRow
	ldx.w #$0006
	ldy.w #$0012
	jsr.w StartScrollList
.2:									; call SendTextMap, fadestep = 0
	jsl.l SendTextMap
	stz.w fadestep
.loop:								; loop: TransfersReady + 1
	inc.w TransfersReady
.loop2:								; loop: if TransfersReady is not 0 go to .loop2, call ReadMenuPads, ...
	lda.w TransfersReady
	bne .loop2
	jsl.l ReadMenuPads
	inc.b $26
	lda.b a1
	beq .3
	jsr.w ScrollListArrows
.3:									; call AnimateSprites, $28 = $1D8F, $2A = $1E00, call BuildSpriteOAM, ...
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	lda.w repeatdelayframes
	bne .loop
	lda.w padchangeany
	bit.w #$1000
	bne .6
	ldx.b a1
	beq .loop
	bit.w #$0800
	beq .4
	jsr.w ScrollListUp
	bra .loop
.4:									; if $0400 bits clear go to .5, call ScrollListDown, go to .loop
	bit.w #$0400
	beq .5
	jsr.w ScrollListDown
	bra .loop
.5:									; go to .loop
	bra .loop
.6:									; go to ExitToPauseMenu
	jmp.w ExitToPauseMenu
CODE_C56D37:						; from ShowScoringSummary
	ldy.w #$000F
	jsl.l PrintBoldLeft
	rts
DrawScoringRow:						; draws row a3 of ShowScoringSummary's scrolling list: a goal (period,
									; time, team, scorer and assists)
	lda.b a3
	sta.b r2
	lda.w #$0003
	sta.b r1
	jsl.l Div16x8U
	asl a
	sta.b $65
	asl a
	adc.b $65
	sta.b $65
	tax
	lda.w ScoreSum+2,x
	and.w #$0080
	beq .1
	pea.w $3207
	bra .2
.1:									; continue
	pea.w $2DC9
.2:									; $CF = $007A, $D1 = $00E0, if RDMPYL = 0 go to .6, A - 1, ...
	lda.w #$007A
	sta.b $CF
	lda.w #$00E0
	sta.b $D1
	lda.l RDMPYL
	beq .6
	dec a
	beq .3
	lda.w ScoreSum+5,x
	bra .4
.3:									; A = $203E,x
	lda.w ScoreSum+4,x
.4:									; A and $00FF, if A = $00FF go to .5, A * 2, A * 2, ...
	and.w #$00FF
	cmp.w #$00FF
	beq .5
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $01,s
	adc.w #$0118
	tax
	lda.w #$000C
	jsr.w CODE_C55F1F
	ldy.b $6D
	jsl.l PrintBoldLeftStr
.5:									; pull X, return
	plx
	rts
.6:									; $D5 = $2400, $CF = $0009, $D1 = $0029, A = $7E203B,x, ...
	lda.w #$2400
	sta.b $D5
	lda.w #$0009
	sta.b $CF
	lda.w #$0029
	sta.b $D1
	lda.l $7E203B,x
	and.w #$00C0
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	tax
	lda.l DATA8_C35E25,x
	tax
	ldy.b $6D
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	lda.w #$0050
	sta.b $D1
	ldx.b $65
	lda.l $7E203A,x
	and.w #$0FFF
	jsr.w CODE_C5605D
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	lda.b $D1
	sta.b $CF
	lda.w #$0068
	sta.b $D1
	ldx.b $65
	lda.l $7E203C,x
	and.w #$0080
	jsr.w CODE_C56104
	ldy.b $6D
	jsl.l PrintBoldCentred
	lda.w #$0072
	sta.b $CF
	ldx.b $65
	lda.l $7E203D,x
	and.w #$007F
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b $01,s
	adc.w #$0118
	plx
	tax
	lda.w #$000D
	jsr.w CODE_C55F1F
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.w #$00E0
	sta.b $CF
	ldx.b $65
	lda.l $7E203C,x
	and.w #$0007
	cmp.w #$0005
	bcc .7
	lda.w #$0002
.7:									; A * 2, X = A, if DATA8_C35E2D,x = $FFFF go to .8, X = A, ...
	asl a
	tax
	lda.l DATA8_C35E2D,x
	cmp.w #$FFFF
	beq .8
	tax
	ldy.b $6D
	jsl.l PrintBoldLeft
.8:									; $D5 = $2000, return
	lda.w #$2000
	sta.b $D5
	rts
PauseGoalieMode:					; pause menu Mnual Goalie / Auto Goalie: switches the goalie mode word of
									; team a2, then redraws the menu
	jsl.l GetPadTeam
	ldx.b a2
	lda.w goaliemode1,x
	eor.w #$0001
	sta.w goaliemode1,x
	lda.w $18F2
	jmp.w CODE_C54FA9
TeamRoster:							; pause menu Team Roster: the roster of team a2 (CODE_C56F5C prints its
									; page: Goalies, Line, Stat); the pad pages through it, start returns
	lda.w #$0001
	sta.w $24DC
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	jsr.w SetupScreen
	lda.w #$5369
	jsl.l PrintTextPage
	jsl.l GetPadTeam
	stz.b $7D
	stz.b $79
	ldy.w #$2801
	ldx.w #$5135
	jsl.l MapTileBlock
.1:									; call CODE_C56F5C, $18 = $00D0, $1A = $0028, $CF = $00A8, ...
	jsr.w CODE_C56F5C
	lda.w #$00D0
	sta.b $18
	lda.w #$0028
	sta.b $1A
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	jsr.w CODE_C55E57
	stz.w fadestep
.loop:								; loop: TransfersReady + 1
	inc.w TransfersReady
.loop2:								; loop: if TransfersReady is not 0 go to .loop2, call ReadMenuPads, ...
	lda.w TransfersReady
	bne .loop2
	jsl.l ReadMenuPads
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	lda.w repeatdelayframes
	bne .loop
	lda.w padchangeany
	bit.w #$1000
	bne .10
	bit.w #$0100
	beq .4
	lda.b $7D
	ldx.b $79
	bne .2
	cmp.w #$000B
	bcs .loop
	bra .3
.2:									; if A >= $000F go to .loop
	cmp.w #$000F
	bcs .loop
.3:									; $7D + 1, go to .9
	inc.b $7D
	bra .9
.4:									; if $0200 bits clear go to .5, if $7D = 0 go to .loop, $7D - 1, go to .9
	bit.w #$0200
	beq .5
	lda.b $7D
	beq .loop
	dec.b $7D
	bra .9
.5:									; if $0400 bits clear go to .6, if $79 >= $0007 go to .loop, $79 + 1, ...
	bit.w #$0400
	beq .6
	lda.b $79
	cmp.w #$0007
	bcs .loop
	inc.b $79
	bra .9
.6:									; if $0800 bits clear go to .7, if $79 = 0 go to .loop, $79 - 1, ...
	bit.w #$0800
	beq .7
	lda.b $79
	beq .loop
	dec.b $79
	bne .9
	lda.w #$000B
	cmp.b $7D
	bcs .9
	sta.b $7D
	bra .9
.7:									; if $4000 bits clear go to .8, A = $0240, A + $D3, Y = $0080, ...
	bit.w #$4000
	beq .8
	lda.w #$0240
	clc
	adc.b $D3
	ldy.w #$0080
	jsl.l ClearRAM7E
	lda.b a2
	eor.w #$0002
	sta.b a2
	bra .9
.8:									; go to .loop
	jmp.w .loop
.9:									; X = $7B, call DeleteSprite, go to .1
	ldx.b $7B
	jsl.l DeleteSprite
	jmp.w .1
.10:								; go to ExitToPauseMenu
	jmp.w ExitToPauseMenu

; Segment bankC5_5000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C54F05
PauseMenuInput:						; the pause menu's pad: left / right the tab (pausetab 0-2), up / down the
									; item (pauseitem), B runs the item through the tab's table (the shorter
									; ones in play mode 1)
	lda.w padchangeany
	bit.w #$0200
	beq .1
	ldx.w pausetab
	beq .1
	cpx.w #$0003
	bcs .1
	dex
	bra SetPauseTab
.1:									; if $0100 bits clear go to .2, X = pausetab, X + 1, ...
	bit.w #$0100
	beq .2
	ldx.w pausetab
	inx
	cpx.w #$0003
	bcc SetPauseTab
.2:									; if a $0800 bit set go to PauseItemUp, ...
	bit.w #$0800
	bne PauseItemUp
	bit.w #$0400
	bne PauseItemDown
	bit.w #$8000
	bne RunPauseItem
PauseMenuReturn:					; the shared rts of PauseMenuInput and its item and tab routines
	rts
RunPauseItem:						; runs item pauseitem of tab pausetab through its table: Info, Stats,
									; Options or the quit prompt (DATA8_C55012 / 18 in play mode 1)
	lda.w OptPlayMode
	cmp.w #$0001
	bne .4
	lda.w pauseitem
	asl a
	tax
	lda.w pausetab
	beq .3
	dec a
	beq .2
	dec a
	beq .1
	jmp (DATA8_C55038,x)
.1:									; jump through DATA8_C55018,x
	jmp (DATA8_C55018,x)
.2:									; jump through DATA8_C55026,x
	jmp (DATA8_C55026,x)
.3:									; jump through DATA8_C55012,x
	jmp (DATA8_C55012,x)
.4:									; A = pauseitem, A * 2, X = A, if pausetab = 0 go to .7, ...
	lda.w pauseitem
	asl a
	tax
	lda.w pausetab
	beq .7
	dec a
	beq .6
	dec a
	beq .5
	jmp (DATA8_C55038,x)
.5:									; jump through DATA8_C5502C,x
	jmp (DATA8_C5502C,x)
.6:									; jump through DATA8_C55026,x
	jmp (DATA8_C55026,x)
.7:									; jump through DATA8_C5501C,x
	jmp (DATA8_C5501C,x)
PauseItemUp:						; the pause menu item one up (pauseitem - 1, not below 0), the tab redrawn
	lda.w pauseitem
	beq PauseMenuReturn
	dec a
	sta.w pauseitem
RedrawPauseTab:						; DrawPauseTab for the current tab
	lda.w pausetab
	bra DrawPauseTab
PauseItemDown:						; the pause menu item one down (below pauseitems), the tab redrawn
	lda.w pauseitem
	inc a
	cmp.w pauseitems
	bcs PauseMenuReturn
	sta.w pauseitem
	bra RedrawPauseTab
SetPauseTab:						; switches the pause menu to tab X when it is another: the old one erased
									; (DeselectPauseTab), item 0, DrawPauseTab
	cpx.w pausetab
	beq PauseMenuReturn
	phx
	bit.w pausetab
	bmi .1
	jsr.w DeselectPauseTab
.1:									; pull A, pausetab = A, pauseitem = 0
	pla
	sta.w pausetab
	stz.w pauseitem
DrawPauseTab:						; draws tab A's item list (its text in bank $C3 from DATA8_C55002, or
									; DATA8_C5500A in play mode 1), the current item's row highlighted
									; (palette $3200), queued to VRAM
	asl a
	tax
	lda.w OptPlayMode
	cmp.w #$0001
	bne .1
	lda.l DATA8_C5500A,x
	bra .2
.1:									; A = DATA8_C55002,x
	lda.l DATA8_C55002,x
.2:									; call DrawPauseItems, call SelectPauseTab, A = pauseitem, A / 2, ...
	jsr.w DrawPauseItems
	jsr.w SelectPauseTab
	lda.w pauseitem
	xba
	lsr a
	adc.w PauseMapBuf
	tax
	ldy.w #$000B
.loop:								; loop: A = $7E0314,x, A and $E3FF, A or $3200, $7E0314,x = A, ...
	lda.l $7E0314,x
	and.w #$E3FF
	ora.w #$3200
	sta.l $7E0314,x
	inx
	inx
	dey
	bpl .loop
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0700
	pea.w $5800
	pea.w $007E
	lda.w PauseMapBuf
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jmp.w ShowPenaltyBoxes
DATA8_C55002:						; the item list (bank $C3) of each pause menu tab: Info, Stats, Options,
									; the quit prompt; DrawPauseTab
	db $CB,$5C,$EF,$5C,$07,$5D,$21,$5D
DATA8_C5500A:						; the same in game mode 1: shorter Info and Options lists; DrawPauseTab
	db $E1,$5C,$EF,$5C,$FD,$5C,$21,$5D
DATA8_C55012:						; game mode 1, Info tab: Team Roster, Score Summry, Records (RunPauseItem
									; jumps through it)
	dw TeamRoster,ShowScoringSummary,RecordHoldersScreen
DATA8_C55018:						; game mode 1, Options tab: Inst Replay, Quit Game
	dw PauseReplay,ShowQuitPrompt
DATA8_C5501C:						; pause menu Info tab: Team Roster, Score Summry, Penalties, Records,
									; Other Scores (RunPauseItem)
	dw TeamRoster,ShowScoringSummary,ShowPenaltySummary,RecordHoldersScreen
	dw ShowOtherScores
DATA8_C55026:						; pause menu Stats tab: Game Stats, Period Stats, Player Stats
	dw ShowGameStats,ShowPeriodStats,ShowPlayerStats
DATA8_C5502C:						; pause menu Options tab: Inst Replay, Edit Lines, Chnge Goalie, the
									; goalie mode, Time Out, Quit Game
	dw PauseReplay,EditLinesScreen,PauseGoalie,PauseGoalieMode
	dw PauseTimeout,ShowQuitPrompt
DATA8_C55038:						; the quit prompt: Resume Game (back to the Options tab), Quit Game
	dw ResumeFromQuit,QuitGameJump
InitPauseScreen:					; the pause screen's set-up: pausemenuon / pausetab $FFFF, the game's text
									; map read from VRAM into a buffer, BackupPauseBuffers, PauseScreenMap
									; unpacked to the pause map buffer, then PauseScreenDraw
	jsl.l forceblack
	jsl.l WaitTransfers
	jsl.l RestoreWorkBuf
	lda.w #$FFFF
	sta.w pausemenuon
	sta.w pausetab
	lda.w #$0802
	jsl.l AllocWorkBuf
	sta.l $7E364A
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	pea.w $0802
	pea.w $0080
	pea.w $5800
	pea.w $3981
	pea.w $007E
	lda.l $7E364A
	pha
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	jsl.l WaitTransfers
	jsl.l BackupPauseBuffers
	lda.w #$2D60
	jsl.l AllocWorkBuf
	sta.w PauseMapBuf
	sta.b r1
	jsl.l MarkWorkBuf
	lda.w #$007E
	sta.b $32
	lda.w #PauseScreenMap&$FFFF
	ldx.w #PauseScreenMap>>16
	jsl.l MapSetToWRAM
	lda.w #$012A
	ldy.w #$0523
	jsr.w FillPauseMapTileRun
	lda.w #$016A
	ldy.w #$052D
	jsr.w FillPauseMapTileRun
	lda.w #$0102
	ldy.w #$0537
	jsr.w FillPauseMapTileRun
	lda.w #$0142
	ldy.w #$0541
	jsr.w FillPauseMapTileRun
	ldy.w #$045F
	ldx.w PauseMapBuf
	clc
.loop:								; loop: A = $7E0000,x, A + $1420, $7E0000,x = A, X + 1, ...
	lda.l $7E0000,x
	adc.w #$1420
	sta.l $7E0000,x
	inx
	inx
	dey
	bpl .loop
PauseScreenDraw:					; draws the pause screen from its map buffer: a sprite (record $1F, placed
									; by gsp), the colours, the map queued, both teams' nickname tiles, the
									; scores and clock, the penalty boxes, the arrow font, screen on
	jsl.l ResetSprites
	lda.w #$0039
	sta.b $1A
	lda.w gsp
	asl a
	tax
	lda.l DATA8_C55245,x
	sta.b $18
	lda.w #$001F
	jsl.l CreateSprite
	stx.w $18F0
	lda.w #$0100
	sta.b $22
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	jsl.l WaitTransfers
	sep #$20
	lda.b #$11
	sta.l TM
	lda.b #$00
	sta.l CGADD
	sta.l CGDATA
	sta.l CGDATA
	lda.b #$43
	sta.l CGADD
	pea.w $318C
	pla
	sta.l CGDATA
	pla
	sta.l CGDATA
	lda.b #$47
	sta.l CGADD
	pea.w $000C
	pea.w $253F
	ldx.w #$0003
.loop:								; loop: pull A, CGDATA = A, X - 1, if the result >= 0 go to .loop, ...
	pla
	sta.l CGDATA
	dex
	bpl .loop
	rep #$20
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0700
	pea.w $5800
	pea.w $007E
	lda.w PauseMapBuf
	pha
	pea.w $2200
	pea.w $2200
	pea.w $007E
	clc
	adc.w #$08C0
	pha
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0040
	pea.w $0050
	pea.w $007E
	adc.w #$2200
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	lda.w #$4100
	jsl.l AllocWorkBuf
	sta.b r0
	pha
	lda.w #$007E
	sta.b $2E
	ldx.w #TeamNicknameTiles>>16
	lda.w #TeamNicknameTiles&$FFFF
	jsl.l Decompress
	pla
	sta.b r0
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0280
	pea.w $3430
	pea.w $007E
	lda.w HomeTeam
	asl a
	sta.b $2E
	asl a
	asl a
	adc.b $2E
	asl a
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b r0
	pha
	pea.w $0280
	pea.w $3570
	pea.w $007E
	lda.w VisTeam
	asl a
	sta.b $2E
	asl a
	asl a
	adc.b $2E
	asl a
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b r0
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsl.l WaitTransfers
	jsr.w PauseScoresClock
	jsr.w ShowPenaltyBoxes
	jsl.l WaitTransfers
	lda.w #$4100
	jsl.l FreeWorkBuf
	ldy.w #$4A00
	lda.w #ArrowFontTiles&$FFFF
	ldx.w #ArrowFontTiles>>16
	jsl.l DecompressToVRAM
	jsl.l WaitTransfers
	jsl.l ScreenOn
	rts
FillPauseMapTileRun:				; writes consecutive tile words into the pause map at offset A starting
									; with tile Y
	clc
	adc.w PauseMapBuf
	tax
	tya
	ldy.w #$0000
.loop:								; loop: $7E0000,x = A, X + 1, X + 1, A + 1, ...
	sta.l $7E0000,x
	inx
	inx
	inc a
	iny
	cpy.w #$000A
	bne .loop
	rts
DATA8_C55245:						; not traced: a table read by PauseScreenDraw
	db $62,$01,$7D,$01,$97,$01
DeselectPauseTab:					; copies the inactive tab tiles into the current pause tab header
	lda.w pausetab
	asl a
	tax
	lda.l DATA8_C5529C,x
	bra CopyPauseTabTiles
SelectPauseTab:						; copies the active tab tiles into the current pause tab header
	lda.w pausetab
	asl a
	tax
	lda.l DATA8_C55294,x
CopyPauseTabTiles:					; copies a tab's two rows of eight tiles from pause map offset A to its
									; place in the tab header (DATA8_C5528C by X); DeselectPauseTab and
									; SelectPauseTab end here
	adc.w PauseMapBuf
	tay
	lda.l DATA8_C5528C,x
	adc.w PauseMapBuf
	tax
	jsr.w CopyPauseTabTileRow
	txa
	adc.w #$0030
	tax
	tya
	adc.w #$0030
	tay
CopyPauseTabTileRow:				; copies eight tile words from Y to X
	lda.w #$0008
	sta.b tmp0
.loop:								; loop: $0000,x = $0000,y, Y + 1, Y + 1, X + 1, ...
	lda.w $0000,y
	sta.w $0000,x
	iny
	iny
	inx
	inx
	dec.b tmp0
	bne .loop
	rts
DATA8_C5528C:						; not traced: a table read by CopyPauseTabTiles
	db $44,$00,$58,$00,$6C,$00,$6C,$00
DATA8_C55294:						; not traced: a table read by SelectPauseTab
	db $C0,$07,$D0,$07,$E0,$07,$E0,$07
DATA8_C5529C:						; not traced: a table read by DeselectPauseTab
	db $40,$08,$50,$08,$60,$08,$60,$08
DrawPauseItems:						; blanks the pause item rows (the bank $C3 list of seven blank items) and
									; prints item list A (PrintPauseItems)
	pha
	ldx.w #$5D41
	jsr.w PrintPauseItems
	plx
PrintPauseItems:					; prints pause item list X (bank $C3: a count to pauseitems, then a
									; routine and a text word an item) into the pause map, an item every two
									; rows from row 12, attribute $3A00
	lda.w #$00C3
	sta.b $2E
	ldy.w #$0314
	lda.l $C30000,x
	sta.w pauseitems
	sta.b tmp0
CODE_C552BD:						; from PrintPauseItemText
	phx
	phy
	lda.l $C30002,x
	beq .1
	sta.b r0
	jmp ($002C)
.1:									; A = $C30004,x
	lda.l $C30004,x
PrintPauseItemText:					; prints item text A (bank $C3, length-prefixed; 0 leaves the item out) on
									; the current item row, then the next item; the item routines go on here
	sta.b r0
	cmp.w #$0000
	beq .1
	tya
	clc
	adc.w PauseMapBuf
	tax
	lda.b [r0]
	and.w #$00FF
	tay
.loop:								; loop: r0 + 1, A = [r0], A and $00FF, A or $3A00, ...
	inc.b r0
	lda.b [r0]
	and.w #$00FF
	ora.w #$3A00
	sta.l $7E0000,x
	inx
	inx
	dey
	bne .loop
	lda.w #$0080
	sta.b r0
.1:									; pull A, A + r0, Y = A, pull A, ...
	pla
	clc
	adc.b r0
	tay
	pla
	adc.w #$0004
	tax
	dec.b tmp0
	bne CODE_C552BD
	rts
GoalieModeItemText:					; the Options tab's goalie mode item: the manual goalie text when
									; goaliemode1 of the pad's team (GetPadTeam) is set, else the auto goalie
									; text
	phy
	phx
	jsl.l GetPadTeam
	lda.w #$59FC
	ldx.b a2
	ldy.w goaliemode1,x
	beq .1
	lda.w #$59EF
.1:									; pull X, pull Y, go to PrintPauseItemText
	plx
	ply
	jmp.w PrintPauseItemText
TimeoutItemText:					; the Options tab's Time Out item, left out (pauseitems - 1, pauseitem
									; kept below it) when the pad's team has no time out left (tmtimeouts)
	phy
	phx
	jsl.l GetPadTeam
	lda.w #$5A08
	ldx.b a2
	ldy.w tmtimeouts,x
	bne .2
	dec.w pauseitems
	ldy.w pauseitem
	cpy.w pauseitems
	bcc .1
	dec.w pauseitem
.1:									; A = $0000
	lda.w #$0000
.2:									; pull X, pull Y, go to PrintPauseItemText
	plx
	ply
	jmp.w PrintPauseItemText
OtherScoresItemText:				; the Info tab's Other Scores item, left out (pauseitems - 1, pauseitem
									; kept below it) unless OptPlayMode is 2
	phx
	lda.w #$5991
	ldx.w OptPlayMode
	cpx.w #$0002
	beq .2
	dec.w pauseitems
	ldy.w pauseitem
	cpy.w pauseitems
	bcc .1
	dec.w pauseitem
.1:									; A = $0000
	lda.w #$0000
.2:									; pull X, go to PrintPauseItemText
	plx
	jmp.w PrintPauseItemText
ShowPenaltyBoxes:					; the pause screen's penalty boxes from text row 13: the home team's list
									; (tmboxlist) at column 23, the away team's at column 1 (ShowPenaltyBox)
	lda.w #$0017
	sta.b tmp1
	lda.w #$01A0
	sta.b tmp2
	lda.w #$0000
	jsr.w ShowPenaltyBox
	lda.w #$0001
	sta.b tmp1
	lda.w #$01A0
	sta.b tmp2
	lda.w #$001A
	jsr.w ShowPenaltyBox
	jsl.l WaitTransfers
	rts
ShowPenaltyBox:						; the players in the penalty box list at tmboxlist + A (bit 7 ends it):
									; those with tmpdst bit 14 clear first, then those with it set
									; (ShowPenaltyBoxPlayer)
	pha
	tay
	asl a
	sta.b $A5
.loop:								; loop: A = tmboxlist,y, Y + 1, A and $00FF, ...
	lda.w tmboxlist,y
	iny
	and.w #$00FF
	bit.w #$0080
	bne .1
	clc
	adc.b $A5
	tax
	lda.w tmpdst,x
	bit.w #$4000
	bne .loop
	jsr.w ShowPenaltyBoxPlayer
	bra .loop
.1:									; pull Y
	ply
.loop2:								; loop: A = tmboxlist,y, Y + 1, A and $00FF, ...
	lda.w tmboxlist,y
	iny
	and.w #$00FF
	bit.w #$0080
	bne rtsmenu
	clc
	adc.b $A5
	tax
	lda.w tmpdst,x
	bit.w #$4000
	beq .loop2
	jsr.w ShowPenaltyBoxPlayer
	bra .loop2
ShowPenaltyBoxPlayer:				; player X's jersey number and penalty time (tmpdst A) as tiles queued to
									; VRAM at the box row (tmp1 + tmp2), then a row down; nothing once tmp2
									; reaches $200
	phy
	ldy.b tmp2
	cpy.w #$0200
	bcc CODE_C553D6
	ply
rtsmenu:							; the rts ShowPenaltyBox's second pass and a full ShowPenaltyBoxPlayer
									; leave through
	rts
CODE_C553D6:						; from ShowPenaltyBoxPlayer
	pha
	txa
	asl a
	asl a
	asl a
	asl a
	pha
	lda.w #HomeRoster
	cpx.w #$0034
	bcc .1
	lda.w #$2EC7
.1:									; A + $01,s, Y = A, pull A, A = $0110,y, ...
	clc
	adc.b $01,s
	tay
	pla
	lda.w $0110,y
	and.w #$00FF
	tax
	lda.l BCDTable,x
	pha
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w BCDText
	pla
	and.w #$000F
	jsr.w BCDTextAt
	lda.w #$0020
	sta.w mesarea,x
	inx
	pla
	and.w #$07FF
	phx
	jsr.w TimeTextMMSS
	plx
	sep #$20
.loop:								; loop: A = mesarea,x, X + 1, if mesarea,x is not $3F go to .loop, ...
	lda.w mesarea,x
	inx
	cmp.b #$3F
	bne .loop
	lda.b #$3A
	sta.w $04F4,x
	rep #$20
	lda.w #$0020
	jsl.l AllocWorkBuf
	pha
	tay
	ldx.w #$0000
.loop2:								; loop: A = mesarea,x, if the result = 0 go to .2, A + $0080, ...
	lda.w mesarea,x
	and.w #$00FF
	beq .2
	clc
	adc.w #$0080
	ora.w #$3A00
	sta.w $0000,y
	inx
	iny
	iny
	bra .loop2
.2:									; A = Y, A - $01,s, X = A, pull Y, ...
	tya
	sec
	sbc.b $01,s
	tax
	ply
	dec.b QueueBusy
	tsc
	sta.b r3
	lda.b $00
	tcs
	phx
	lda.w #$5800
	clc
	adc.b tmp1
	adc.b tmp2
	pha
	pea.w $007E
	phy
	tsc
	sta.b $00
	lda.b r3
	tcs
	stz.b QueueBusy
	lda.b tmp2
	clc
	adc.w #$0020
	sta.b tmp2
	ply
	rts
PauseScoresClock:					; the pause screen's big digits: the home score (tmscore) at map tile $D7
									; and the away score at $C3 (three digits, PushNumberWrap), then the game
									; clock (clockbcd) from tile $8B
	lda.w #$0003
	sta.b d1
	lda.w tmscore
	sta.b d0
	jsl.l PushNumberWrap
	ldy.w #$00D7
	jsr.w PutPauseScore
	lda.w tmscore+2
	sta.b d0
	jsl.l PushNumberWrap
	ldy.w #$00C3
	jsr.w PutPauseScore
	ldy.w #$008B
	lda.w clockbcd+1
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w PutClockDigit
	iny
	iny
	lda.w clockbcd+1
	jsr.w PutClockDigit
	iny
	iny
	iny
	iny
	lda.w clockbcd
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w PutClockDigit
	iny
	iny
	lda.w clockbcd
	jmp.w PutClockDigit
PutPauseScore:						; the three big digits PushNumberWrap left (width 3) to pause map tile Y
									; on, two tiles apart (PutClockDigit)
	lda.w PushWidthBuf+2
	jsr.w PutClockDigit
	iny
	iny
	lda.w $055C
	jsr.w PutClockDigit
	iny
	iny
	lda.w PushWidthBuf+4
PutClockDigit:						; copies big digit A (its low 4 bits: 2 x 3 tiles from the digit set in
									; the pause map) to pause map tile Y
	phy
	and.w #$000F
	asl a
	asl a
	adc.w PauseMapBuf
	tax
	tya
	asl a
	adc.w PauseMapBuf
	tay
	lda.w $0700,x
	sta.w $0000,y
	lda.w $0702,x
	sta.w $0002,y
	lda.w $0740,x
	sta.w $0040,y
	lda.w $0742,x
	sta.w $0042,y
	lda.w $0780,x
	sta.w $0080,y
	lda.w $0782,x
	sta.w $0082,y
	ply
	rts
RestoreGameScreen:					; leaves the pause screen: the team songs back when the pause loaded its
									; music, then the game screen rebuilt (refs, frame tiles, digit font, rink
									; tiles, centre ice, meter font, face off map, the period box)
	jsl.l SoundVolumeDown
	jsl.l FadeOutWait
	lda.w PauseMusicOn
	beq .1
	jsl.l LoadTeamSongs
.1:									; DMAEnShadow = 0, call WaitTransfers, $32 = $007E, A = $21F0, ...
	stz.w DMAEnShadow
	jsl.l WaitTransfers
	lda.w #$007E
	sta.b $32
	lda.w #$21F0
	jsl.l AllocWorkBuf
	pha
	sta.b r1
	lda.w #RefsMap&$FFFF
	ldx.w #RefsMap>>16
	jsl.l MapSetToWRAM
	ply
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $18A0
	pea.w $2200
	pea.w $007E
	tya
	clc
	adc.w #$0930
	pha
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0050
	pea.w $007E
	adc.w #$18A0
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l WaitTransfers
	lda.w #$21F0
	jsl.l FreeWorkBuf
	ldx.w #$20A0
	stx.b tmp2
	ldx.w #$2000
	stx.b tmp1
	lda.w frame+$20
	jsl.l QueueFrameTiles
	ldx.w #$20A8
	stx.b tmp2
	ldx.w #$2004
	stx.b tmp1
	lda.w frame+$22
	jsl.l QueueFrameTiles
	ldx.w #$20C0
	stx.b tmp2
	ldx.w #$2008
	stx.b tmp1
	lda.w frame+$24
	jsl.l QueueFrameTiles
	ldx.w #$20C8
	stx.b tmp2
	ldx.w #$200C
	stx.b tmp1
	lda.w frame+$26
	jsl.l QueueFrameTiles
	ldx.w #$20E0
	stx.b tmp2
	ldx.w #$2010
	stx.b tmp1
	lda.w frame+$28
	jsl.l QueueFrameTiles
	ldx.w #$20E8
	stx.b tmp2
	ldx.w #$2014
	stx.b tmp1
	lda.w frame+$2A
	jsl.l QueueFrameTiles
	ldx.w #$2100
	stx.b tmp2
	ldx.w #$2018
	stx.b tmp1
	lda.w frame+$2C
	jsl.l QueueFrameTiles
	ldx.w #$2108
	stx.b tmp2
	ldx.w #$201C
	stx.b tmp1
	lda.w frame+$2E
	jsl.l QueueFrameTiles
	ldx.w #$2120
	stx.b tmp2
	ldx.w #$2020
	stx.b tmp1
	lda.w frame+$30
	jsl.l QueueFrameTiles
	ldx.w #$2128
	stx.b tmp2
	ldx.w #$2024
	stx.b tmp1
	lda.w frame+$32
	jsl.l QueueFrameTiles
	ldx.w #$2140
	stx.b tmp2
	ldx.w #$2028
	stx.b tmp1
	lda.w frame+$34
	jsl.l QueueFrameTiles
	ldx.w #$2148
	stx.b tmp2
	ldx.w #$202C
	stx.b tmp1
	lda.w frame+$36
	jsl.l QueueFrameTiles
	jsl.l WaitTransfers
	ldx.w #$2180
	stx.b tmp2
	ldx.w #$2034
	stx.b tmp1
	sta.w frame+$3C
	jsl.l QueueFrameTiles
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
	lda.w #$2454
	sta.b tmp1
	lda.w #$25E0
	sta.b tmp2
	lda.w #$0072
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
	lda.w #$01E0
	jsl.l FreeWorkBuf
	lda.w #IceRinkMap&$FFFF
	sta.b r1
	lda.w #IceRinkMap>>16
	sta.b $32
	lda.b [r1]
	clc
	adc.b r1
	bcc .2
	inc.b $32
	clc
.2:									; A + $0002, if carry clear go to .3, $32 + 1
	adc.w #$0002
	bcc .3
	inc.b $32
	clc
.3:									; r0 = A, $2E = $32, r1 = A, A + [r1], ...
	sta.b r0
	ldx.b $32
	stx.b $2E
	sta.b r1
	adc.b [r1]
	bcc .4
	inc.b $32
	clc
.4:									; A + $0009, r1 = A, if carry clear go to .5, $32 + 1
	adc.w #$0009
	sta.b r1
	bcc .5
	inc.b $32
.5:									; A = r0, A + $0008, if carry clear go to .6, $2E + 1
	lda.b r0
	clc
	adc.w #$0008
	bcc .6
	inc.b $2E
.6:									; r0 = A, A = $4100, call AllocWorkBuf, $364C = A, ...
	sta.b r0
	lda.w #$4100
	jsl.l AllocWorkBuf
	sta.w $364C
	ldx.w #$007E
	jsr.w DecompressLZSS
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $4100
	pea.w $0000
	pea.w $007E
	lda.w $364C
	pha
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
	pei ($32)
	pei ($30)
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
	jsl.l WaitTransfers
	lda.w #$4100
	jsl.l FreeWorkBuf
	lda.w #$4E00
	jsl.l AllocWorkBuf
	sta.w $364C
	sta.b r0
	lda.w #$007E
	sta.b $2E
	ldx.w #CenterIceTiles>>16
	lda.w #CenterIceTiles&$FFFF
	jsl.l Decompress
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
	adc.w $364C
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
	lda.w #$4E00
	jsl.l FreeWorkBuf
	lda.w #$03E7
	sta.w Oldrow
	ldy.w #$4800
	lda.w #MeterFontTiles&$FFFF
	ldx.w #MeterFontTiles>>16
	jsl.l DecompressToVRAM
	lda.w #$13E0
	jsl.l AllocWorkBuf
	sta.w $364C
	sta.b r1
	lda.w #$007E
	sta.b $32
	lda.w #FaceOffMap&$FFFF
	ldx.w #FaceOffMap>>16
	jsl.l MapSetToWRAM
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $09C0
	pea.w $4320
	pea.w $007E
	clc
	lda.w $364C
	adc.w #$0A00
	pha
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0070
	pea.w $007E
	adc.w #$09C0
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l WaitTransfers
	jsl.l RestoreWorkBuf
	sep #$20
	lda.b #$13
	sta.l TM
	rep #$20
	jsl.l CODE_C53A29
	jsl.l WaitTransfers
	jml.l RestoreWorkBuf
QueueSavedTextMap:					; queues the text map saved at the pause ($800 bytes from the buffer at
									; $364A) to VRAM $5800
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0800
	pea.w $5800
	pea.w $007E
	lda.w $364A
	inc a
	inc a
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsl.l WaitTransfers
	lda.w #$0802
	jsl.l FreeWorkBuf
	jml.l MarkWorkBuf
FreePauseBuffers:					; frees the pause screen's work buffers (FreeWorkBuf $040E, MarkWorkBuf),
									; then RestorePauseBuffers
	lda.w #$040E
	jsl.l FreeWorkBuf
	jsl.l MarkWorkBuf
RestorePauseBuffers:				; copies BackupPauseBuffers' two buffers back (the sprite objects at
									; SpriteObjRAM, the palette slots from PalSlotList) and re-uploads the
									; frames of the objects in use
	ldx.w $3648
	ldy.w #SpriteObjRAM
	lda.w #$01FD
	mvn $7E,$7E
	ldy.w #PalSlotList
	lda.w #$020F
	mvn $7E,$7E
	lda.w SpriteCount
	dec a
	asl a
	tay
.loop:								; loop: X = SpriteList,y, if $0A,x = $FFFF go to .1, push Y, ...
	ldx.w SpriteList,y
	lda.b $0A,x
	cmp.w #$FFFF
	beq .1
	phy
	jsr.w UploadSpriteFrame
	lda.b $34,x
	jsl.l QueueSpritePalette
	ply
.1:									; Y - 1, Y - 1, if the result >= 0 go to .loop, A = HomeSpritePal, ...
	dey
	dey
	bpl .loop
	lda.w HomeSpritePal
	asl a
	tax
	lda.w SpritePalUse,x
	and.w #$FF00
	ora.w HomeSpritePal
	jsl.l QueueSpritePalette
	lda.w VisSpritePal
	asl a
	tax
	lda.w SpritePalUse,x
	and.w #$FF00
	ora.w VisSpritePal
	jsl.l QueueSpritePalette
	lda.w $4828
	and.w #$FF00
	ora.w #$00B8
	jsl.l QueueSpritePalette
	lda.w $482A
	and.w #$FF00
	ora.w #$00B9
	jsl.l QueueSpritePalette
	jsl.l WaitTransfers
	jml.l RestoreWorkBuf
SetupScreen:						; common start of the stats screens: the tiled background, VRAM cleared,
									; the colour hook, a new text map (InitTextMap) and the sprites
	stz.w DMAEnShadow
	stz.b $22
	stz.b $24
	lda.w #$00D7
	sta.b $18
	lda.w #$00D0
	sta.b $1A
	lda.w #$0020
	jsl.l CreateSprite
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
	jsr.w MapSetToVRAMBody
	ldy.w #$5000
	jsl.l ClearVRAM
	ldy.w #$5400
	jsl.l ClearVRAM
	ldy.w #$5C00
	jsl.l QueueClearVRAM
	lda.w #BlueColoursHook&$FFFF
	ldx.w #BlueColoursHook>>16
	jsl.l SetNMIHook
	jsl.l InitTextMap
	lda.w #$8000
	sta.w DMAEnShadow
	lda.w #$001F
	sta.l TM
	lda.w #$0240
	jsl.l AllocWorkBuf
	sta.b r0
	sta.b r2
	lda.w #$007E
	sta.b $2E
	ldx.w #GradientBarTiles>>16
	lda.w #GradientBarTiles&$FFFF
	jsl.l Decompress
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0240
	pea.w $0010
	pea.w $007E
	pei ($34)
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsr.w QueueHomePalette
	jsr.w QueueVisPalette
	jsl.l WaitTransfers
	lda.w #$0240
	jsl.l FreeWorkBuf
	lda.w #$0002
	sta.w BG2VScroll
	rts
ExitToPauseMenu:					; leaves a pause menu screen: fade out, the text map freed, VRAM cleared,
									; back to the pause menu (PauseScreenDraw); opened from the season's Other
									; Scores it only fades out and returns
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	lda.w SeasonScoresMode
	beq .1
	rts
.1:									; call ClearNMIHook, A = $0800, call FreeWorkBuf, WorkBufMark = A, ...
	jsl.l ClearNMIHook
	lda.w #$0800
	jsl.l FreeWorkBuf
	sta.w WorkBufMark
	jsl.l WaitTransfers
	jsl.l RestorePauseBuffers
	ldy.w #$5000
	jsl.l QueueClearVRAM
	jsl.l WaitTransfers
	stz.w padchangeany
	lda.w SeasonScoresMode
	jmp.w PauseScreenDraw
SetupStatsPage:						; SetupScreen, then the page A (PrintTextPage) and both teams' logo
									; sprites
	pha
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	jsr.w SetupScreen
	pla
	jsl.l PrintTextPage
	lda.w #$0040
	sta.b $18
	sta.b $1A
	lda.w VisTeam
	jsl.l CreateSprite
	lda.w #$00C0
	sta.b $18
	lda.w HomeTeam
	jsl.l CreateSprite
	inc.b $38,x
	ldy.w #$2801
	ldx.w #$5194
	jsl.l MapTileBlock
	ldy.w #$2C01
	ldx.w #$5184
	jsl.l MapTileBlock
	lda.w #$0020
	sta.b $CF
	lda.w #$0068
	sta.b $D1
	lda.w VisTeam
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$000C
	jsl.l PrintThinCentred
	lda.w #$00A0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	lda.w HomeTeam
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$000C
	jsl.l PrintThinCentred
	rts
StartScrollListLong:				; StartScrollList for long calls
	jsr.w StartScrollList
	rtl
StartScrollList:					; starts a scrolling list: X rows shown from text row Y, each row drawn by
									; the routine A, a1 = the last row; the first rows drawn
	sta.b $75
	stx.b $71
	sty.b a4
	stz.b $69
	jsl.l WaitTransfers
	ldx.w #$0060
	jsl.l SetupHDMA
	db $00,$2C,$9D,$46,$7E,$00		; inline parameters
	ldx.w #$0000
	ldy.w #$0017
	lda.b a4
	dec a
	asl a
	asl a
	asl a
	cmp.w #$0080
	bcc .1
	sbc.w #$007F
	ldx.w #$007F
	stx.w BG3ScrollHDMA+$11
	sty.w BG3ScrollHDMA+$12
	ldx.w #$0002
.1:									; BG3ScrollHDMA+$11,x = A, A = Y, BG3ScrollHDMA+$12,x = A, ...
	sta.w BG3ScrollHDMA+$11,x
	tya
	sta.w BG3ScrollHDMA+$12,x
	lda.w #$0008
	sta.w BG3ScrollHDMA+$13,x
	lda.w #$0013
	sta.w BG3ScrollHDMA+$14,x
	lda.b $71
	asl a
	asl a
	asl a
	sta.w BG3ScrollHDMA+$15,x
	tya
	sta.w BG3ScrollHDMA+$16,x
	lda.w #$0008
	sta.w BG3ScrollHDMA+$17,x
	lda.w #$0013
	sta.w BG3ScrollHDMA+$18,x
	lda.w #$0001
	sta.w BG3ScrollHDMA+$19,x
	tya
	sta.w BG3ScrollHDMA+$1A,x
	ldx.w #$FFFF
	lda.b a4
	dec a
	asl a
	asl a
	asl a
	cmp.w #$0080
	bcc .2
	sbc.w #$007F
	sta.w BG3ScrollHDMA+$3
	stx.w BG3ScrollHDMA+$4
	lda.w #$007F
	sta.w BG3ScrollHDMA
	stx.w BG3ScrollHDMA+$1
	ldx.w #$0050
	jsl.l SetupHDMA
	db $02,$12,$8C,$46,$7E,$7E		; inline parameters
	bra .3
.2:									; BG3ScrollHDMA+$3 = A, BG3ScrollHDMA+$4 = X, X = $0050, call SetupHDMA
	sta.w BG3ScrollHDMA+$3
	stx.w BG3ScrollHDMA+$4
	ldx.w #$0050
	jsl.l SetupHDMA
	db $02,$12,$8F,$46,$7E,$7E		; inline parameters
.3:									; X = $FFFF, A = $71, A + 1, A + 1, ...
	ldx.w #$FFFF
	lda.b $71
	inc a
	inc a
	asl a
	asl a
	asl a
	sta.w BG3ScrollHDMA+$6
	stx.w BG3ScrollHDMA+$7
	stz.w BG3ScrollHDMA+$9
	lda.w #$E000
	sta.w DMAEnShadow
	lda.w #$0010
	sta.b $18
	lda.b a4
	asl a
	asl a
	asl a
	sec
	sbc.w #$0004
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $77
	lda.w #$0001
	jsl.l SetSpriteAnim
	lda.b a4
	clc
	adc.b $71
	asl a
	asl a
	asl a
	adc.w #$0004
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $79
	lda.w #$0002
	jsl.l SetSpriteAnim
	stz.b a3
	lda.b a4
	sta.b $6D
StartScrollRowNext:					; StartScrollList's row loop: text row $6D cleared, then the row routine
									; at $75 (returning to StartScrollRowDrawn)
	jsr.w ClearTextRow
	pea.w StartScrollRowDrawn-1
	jmp ($0075)
StartScrollRowDrawn:				; a row drawn for StartScrollList: WaitTransfers, RestoreWorkBuf, the next
									; row while rows and window last, then ScrollListArrows
	jsl.l WaitTransfers
	jsl.l RestoreWorkBuf
	inc.b $6D
	inc.b a3
	lda.b a3
	cmp.b a1
	bcs ScrollListArrows
	dec a
	cmp.b $71
	bcc StartScrollRowNext
ScrollListArrows:					; a scrolling list each frame: its up arrow sprite shown when rows are
									; above, the down arrow when rows are below
	ldx.b $77
	lda.b $22,x
	ldy.b $69
	beq .1
	ora.w #$0001
	bra .2
.1:									; A and $FFFE
	and.w #$FFFE
.2:									; $22,x = A, X = $79, A = Y, A + $71, ...
	sta.b $22,x
	ldx.b $79
	tya
	clc
	adc.b $71
	tay
	lda.b $22,x
	cpy.b a1
	bcs .3
	ora.w #$0001
	bra .4
.3:									; A and $FFFE
	and.w #$FFFE
.4:									; $22,x = A, return
	sta.b $22,x
	rts
RedrawScrollList:					; redraws the visible scrolling list and its adjacent buffered rows
	lda.b $71
	inc a
	sta.b tmp1
	inc a
	sta.b tmp2
	lda.b $71
	sec
	adc.b $69
	pha
	lda.b $69
	beq RedrawScrollRowNext
	dec a
RedrawScrollRowNext:				; RedrawScrollList's loop: row A (from the one above the window) while
									; below both limits, on its wrapped text row through the row routine at
									; $75
	cmp.b $01,s
	bcs RedrawScrollListDone
	cmp.b a1
	bcs RedrawScrollListDone
	sta.b a3
.loop:								; loop: if A < tmp1 go to .1, A - tmp2, if the result >= 0 go to .loop
	cmp.b tmp1
	bcc .1
	sbc.b tmp2
	bpl .loop
.1:									; A + a4, $6D = A, call ClearTextRow, jump through $0075
	clc
	adc.b a4
	sta.b $6D
	jsr.w ClearTextRow
	pea.w RedrawScrollRowDrawn-1
	jmp ($0075)
RedrawScrollRowDrawn:				; a row drawn for RedrawScrollList: WaitTransfers, RestoreWorkBuf, the
									; next row
	jsl.l WaitTransfers
	jsl.l RestoreWorkBuf
	lda.b a3
	inc a
	bra RedrawScrollRowNext
RedrawScrollListDone:				; RedrawScrollList's end: its pushed limit dropped
	pla
	rts
ScrollListDownLong:					; calls ScrollListDown for long callers
	jsr.w ScrollListDown
	rtl
ScrollListDown:						; scrolls a scrolling list down a row (the pad's down) when rows are below
	lda.b $71
	inc a
	sta.b tmp1
	inc a
	sta.b tmp2
	lda.b $69
	clc
	adc.b $71
	cmp.b a1
	bcs ScrollListDownReturn
	inc a
	cmp.b a1
	bcs ScrollListDownAnim
	sta.b a3
.loop:								; loop: if A < tmp1 go to .1, A - tmp2, if the result >= 0 go to .loop
	cmp.b tmp1
	bcc .1
	sbc.b tmp2
	bpl .loop
.1:									; A + a4, $6D = A, call ClearTextRow, jump through $0075
	clc
	adc.b a4
	sta.b $6D
	jsr.w ClearTextRow
	pea.w ScrollDownRowDrawn-1
	jmp ($0075)
ScrollDownRowDrawn:					; ScrollListDown's new bottom row drawn: SendTextMap, then
									; ScrollListDownAnim
	jsl.l SendTextMap
	bra ScrollListDownAnim
ScrollListDownDone:					; the end of a list scroll: padlast and padchangeany cleared, then
									; ScrollListDownReturn
	stz.w padlast
	stz.w padchangeany
ScrollListDownReturn:				; the rts ScrollListDown leaves through when the list is at its end
	rts
ScrollListDownAnim:					; scrolls the list down a row over 8 frames by the BG3 scroll HDMA entries
									; (BG3ScrollHDMA+$6 on), then ScrollListDownDone
	inc.b $69
	ldx.w #$0008
.loop:								; loop: X - 1, if the result < 0 go to ScrollListDownDone, ...
	dex
	bmi ScrollListDownDone
	wai
	inc.w BG3ScrollHDMA+$7
	sep #$20
	dec.w BG3ScrollHDMA+$6
	bne .1
	lda.b tmp2
	asl a
	asl a
	asl a
	sta.w BG3ScrollHDMA+$6
	rep #$20
	lda.w #$FFFF
	sta.w BG3ScrollHDMA+$7
	stz.w BG3ScrollHDMA+$8
	bra .loop
.1:									; A = tmp2, A * 2, A * 2, A * 2, ...
	lda.b tmp2
	asl a
	asl a
	asl a
	sec
	sbc.w BG3ScrollHDMA+$6
	sta.w BG3ScrollHDMA+$9
	rep #$20
	lda.w BG3ScrollHDMA+$6
	and.w #$00FF
	eor.w #$FFFF
	sta.w BG3ScrollHDMA+$A
	lda.w #$0001
	sta.w BG3ScrollHDMA+$C
	lda.w #$FFFF
	sta.w BG3ScrollHDMA+$D
	stz.w BG3ScrollHDMA+$F
	bra .loop
ScrollListUp:						; scrolls a scrolling list up a row (the pad's up) when rows are above
	lda.b $71
	inc a
	sta.b tmp1
	inc a
	sta.b tmp2
	lda.b $69
	beq ScrollListUpReturn
	dec a
	sta.b $69
	dec a
	bmi ScrollListUpAnim
	sta.b a3
.loop:								; loop: if A < tmp1 go to .1, A - tmp2, if the result >= 0 go to .loop
	cmp.b tmp1
	bcc .1
	sbc.b tmp2
	bpl .loop
.1:									; A + a4, $6D = A, call ClearTextRow, jump through $0075
	clc
	adc.b a4
	sta.b $6D
	jsr.w ClearTextRow
	pea.w ScrollUpRowDrawn-1
	jmp ($0075)
ScrollUpRowDrawn:					; ScrollListUp's new top row drawn: SendTextMap, then ScrollListUpAnim
	jsl.l SendTextMap
ScrollListUpAnim:					; scrolls the list up a row over 8 frames by the BG3 scroll HDMA entries
									; (BG3ScrollHDMA+$6 on)
	ldx.w #$0008
.loop:								; loop: X - 1, if the result < 0 go to .2, A 8-bit, A = tmp2, ...
	dex
	bmi .2
	wai
	sep #$20
	lda.b tmp2
	asl a
	asl a
	asl a
	cmp.w BG3ScrollHDMA+$6
	bne .1
	dec a
	sta.w BG3ScrollHDMA+$9
	lda.b #$01
	sta.w BG3ScrollHDMA+$6
	rep #$20
	lda.w BG3ScrollHDMA+$7
	dec a
	sta.w BG3ScrollHDMA+$A
	lda.b tmp2
	asl a
	asl a
	asl a
	dec a
	dec a
	sta.w BG3ScrollHDMA+$7
	lda.w #$0001
	sta.w BG3ScrollHDMA+$C
	lda.w #$FFFF
	sta.w BG3ScrollHDMA+$D
	stz.w BG3ScrollHDMA+$F
	bra .loop
.1:									; BG3ScrollHDMA+$6 + 1, BG3ScrollHDMA+$9 - 1, A 16-bit, ...
	inc.w BG3ScrollHDMA+$6
	dec.w BG3ScrollHDMA+$9
	rep #$20
	dec.w BG3ScrollHDMA+$7
	dec.w BG3ScrollHDMA+$A
	bra .loop
.2:									; padlast = 0, padchangeany = 0
	stz.w padlast
	stz.w padchangeany
ScrollListUpReturn:					; the rts ScrollListUp leaves through when the list is at its top
	rts
DATA8_C55D6B:						; jump table: the routine for each index (code in bankC5_6000 uses it)
	dw DrawTeamStatNumber,DrawTeamStatPair,DrawTeamStatPercent,DrawTeamStatTime
ClearTextRow:						; clears row $6D of the text map at $D3 (32 tiles)
	lda.b $6D
	xba
	lsr a
	lsr a
	adc.b $D3
	tax
	ldy.w #$0020
	lda.w #$0000
.loop:								; loop: $0000,x = A, X + 1, X + 1, Y - 1, ...
	sta.w $0000,x
	inx
	inx
	dey
	bne .loop
	rts
DrawTeamStatNumber:					; formats a team stat as a centred decimal value
	ldx.b $65
	lda.l $C30003,x
	clc
	adc.b a2
	sta.b tmp0
	lda.b (tmp0)
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	rts
DrawTeamStatPair:					; formats two team stats separated by the pair separator
	ldx.b $65
	lda.l $C30003,x
	clc
	adc.b a2
	sta.b tmp0
	lda.b (tmp0)
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	lda.w #$003E
	sta.w mesarea,x
	inx
	txy
	ldx.b $65
	lda.l $C30005,x
	clc
	adc.b a2
	sta.b tmp0
	lda.b (tmp0)
	tax
	lda.l BCDTable,x
	and.w #$00FF
	tyx
	jsr.w BCDTextAt
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	rts
DrawTeamStatPercent:				; formats the ratio of two team stats as a percentage capped at 100
	ldx.b $65
	lda.l $C30005,x
	clc
	adc.b a2
	sta.b tmp0
	lda.b (tmp0)
	beq .2
	sta.b d1
	lda.l $C30003,x
	clc
	adc.b a2
	sta.b tmp0
	lda.b (tmp0)
	cmp.b d1
	bcc .1
	lda.w #$0100
	bra .2
.1:									; X = $0064, call Mul8U, X = A, A = d1, ...
	ldx.w #$0064
	jsl.l Mul8U
	tax
	lda.b d1
	jsl.l DivX8U
	tax
	lda.l BCDTable,x
	and.w #$00FF
.2:									; call BCDText, mesarea,x = $003C, Y = $6D, X = mesarea, ...
	jsr.w BCDText
	lda.w #$003C
	sta.w mesarea,x
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	rts
DrawTeamStatTime:					; formats a team stat time as centred minutes and seconds
	ldx.b $65
	lda.l $C30003,x
	clc
	adc.b a2
	sta.b tmp0
	lda.b (tmp0)
	jsr.w TimeTextMSS
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	rts
TeamLogoSprite:						; for team a2 (HomeTeam / VisTeam): its 16 logo colours queued from
									; $7F:D80A + team * 32 and its logo sprite made (CreateSprite, the object
									; in $7B)
	jsl.l WaitTransfers
	ldy.w HomeTeam
	lda.b a2
	beq .1
	ldy.w VisTeam
.1:									; push Y, QueueBusy - 1, A = $04, $04 = X, ...
	phy
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	pea.w $0020
	pea.w $007F
	tya
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$D80A
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	lda.b $01,s
	jsl.l CreateSprite
	stx.b $7B
	lda.w #$0001
	trb.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	pla
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0009
	jsl.l PrintThinCentred
	jsl.l SendTextMap
	jsl.l WaitTransfers
	rts
BCDTextLong:						; BCDText for long calls
	jsr.w BCDText
	rtl
BCDText:							; the BCD number A as text (no leading zeros, zero ended) at the start of
									; the number buffer
	ldx.w #$0000
BCDTextAt:							; the BCD number A as text (no leading zeros, zero ended) at X in the
									; number buffer; X moves past it
	phy
	ldy.w #$0000
	pha
	xba
	and.w #$00F0
	beq .1
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w mesarea,x
	inx
	iny
.1:									; A = $01,s, if the result is not 0 go to .2, if Y = $0000 go to .3
	lda.b $01,s
	xba
	and.w #$000F
	bne .2
	cpy.w #$0000
	beq .3
.2:									; A + $0030, mesarea,x = A, X + 1, Y + 1
	clc
	adc.w #$0030
	sta.w mesarea,x
	inx
	iny
.3:									; A = $01,s, if the result is not 0 go to .4, if Y = $0000 go to .5
	lda.b $01,s
	and.w #$00F0
	bne .4
	cpy.w #$0000
	beq .5
.4:									; A / 2, A / 2, A / 2, A / 2, ...
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w mesarea,x
	inx
	iny
.5:									; A = $01,s, A and $000F, A + $0030, mesarea,x = A, ...
	lda.b $01,s
	and.w #$000F
	clc
	adc.w #$0030
	sta.w mesarea,x
	inx
	pla
	ply
	rts
FitNameToMesarea:					; FitName into mesarea (Y = mesarea)
	ldy.w #mesarea
FitName:							; copies the zero-ended name at X to Y in at most A characters: as it is,
									; else the first name as an initial ('F= Last'), else cut short with '=';
									; X = Y
	sty.b $2E
	sta.b r0
	phx
	sep #$20
.loop:								; loop: $0000,y = $0000,x, if $0000,x = 0 go to .1, X + 1, Y + 1, ...
	lda.w $0000,x
	sta.w $0000,y
	beq .1
	inx
	iny
	bra .loop
.1:									; A = X, A - $01,s, pull X, if A < r0 go to .2, ...
	txa
	sec
	sbc.b $01,s
	plx
	cmp.b r0
	bcc .2
	beq .2
	ldx.b $2E
	txy
.loop2:								; loop: A = $0001,x, X + 1, if $0001,x is not $20 go to .loop2, ...
	lda.w $0001,x
	inx
	cmp.b #$20
	bne .loop2
	sta.w $0002,y
	lda.b #$3D
	sta.w $0001,y
.loop3:								; loop: Y + 1, X + 1, $0002,y = $0000,x, ...
	iny
	inx
	lda.w $0000,x
	sta.w $0002,y
	bne .loop3
	rep #$20
	tya
	inc a
	sec
	sbc.b $2E
	cmp.b r0
	bcc .2
	beq .2
	sep #$20
	ldy.b $2E
	ldx.b r0
.loop4:								; loop: $0000,y = $0003,y, if $0003,y = 0 go to .2, Y + 1, X - 1, ...
	lda.w $0003,y
	sta.w $0000,y
	beq .2
	iny
	dex
	bne .loop4
	dey
	rep #$20
	lda.w #$003D
	sta.w $0000,y
.2:									; A 16-bit, X = $2E, return
	rep #$20
	ldx.b $2E
	rts
FitNameToWorkBuf:					; FitName into a new work buffer entry of A + 2 bytes (long calls)
	pha
	adc.w #$0002
	jsl.l AllocWorkBuf
	tay
	pla
	jsr.w FitName
	rtl
UnpackFitName:						; unpacks text X (UnpackText) and fits the name in at most A characters in
									; place, as FitName does
	sta.b r0
	jsl.l UnpackText
	stx.b $2E
	ldy.w #$0000
	sep #$20
.loop:								; loop: if $0000,x = 0 go to .1, X + 1, Y + 1, go to .loop
	lda.w $0000,x
	beq .1
	inx
	iny
	bra .loop
.1:									; if Y < r0 go to .3, if zero go to .3, X = $2E, Y = X
	cpy.b r0
	bcc .3
	beq .3
	ldx.b $2E
	txy
.loop2:								; loop: A = $0001,x, X + 1, if $0001,x is not $20 go to .loop2, ...
	lda.w $0001,x
	inx
	cmp.b #$20
	bne .loop2
	sta.w $0002,y
	lda.b #$3D
	sta.w $0001,y
.loop3:								; loop: Y + 1, X + 1, $0002,y = $0000,x, ...
	iny
	inx
	lda.w $0000,x
	sta.w $0002,y
	bne .loop3
	rep #$20
	tya
	inc a
	sec
	sbc.b $2E
	cmp.b r0
	bcc .3
	beq .3
	tya
	dec a
	clc
	sbc.b $2E
	cmp.b r0
	bcc .2
	beq .2
	lda.b $2E
	clc
	adc.b r0
	adc.w #$0004
	tax
	lda.w #$003D
	sta.w $0000,x
.2:									; A = $2E, A + $0003, X = A, return
	lda.b $2E
	clc
	adc.w #$0003
	tax
	rts
.3:									; A 16-bit, X = $2E, return
	rep #$20
	ldx.b $2E
	rts

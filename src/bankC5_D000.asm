; Segment bankC5_D000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C5D00D
TradeValue:							; one side of a trade: the value of its chosen players (from their
									; ratings, RecordOverall) into (tmp1), and how many goalies (d0), forwards
									; and defencemen (d1) it gives
	stz.b d0
	stz.b $81
	stz.b d1
	stz.b r1
	lda.w #$0000
.1:									; $91 = A, Y = A, A = (d2),y, if $0001 bits clear go to .5, ...
	sta.b $91
	tay
	lda.b (d2),y
	bit.w #$0001
	beq .5
	tya
	ldx.b a4
	stz.w $24DC
	cmp.w $0002,x
	bcc .3
	sbc.w $0002,x
	cmp.w $0004,x
	bcc .2
	inc.b d1
	bra .4
.2:									; $81 + 1, go to .4
	inc.b $81
	bra .4
.3:									; d0 + 1, $24DC = $0010
	inc.b d0
	ldx.w #$0010
	stx.w $24DC
.4:									; A = Y, A * 2, A * 2, A * 2, ...
	tya
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b a4
	tax
	lda.w $0110,x
	sta.w mesarea
	lda.w $0112,x
	sta.w mesarea+2
	lda.w $0114,x
	sta.w mesarea+4
	lda.w $0116,x
	sta.w mesarea+6
	jsr.w RecordOverall
	clc
	adc.b (tmp1)
	sta.b (tmp1)
	inc.b r1
.5:									; A = $91, A + 1, if A is not tmp2 go to .1, if r1 = 0 go to .rts, ...
	lda.b $91
	inc a
	cmp.b tmp2
	bne .1
	lda.b r1
	beq .rts
	lda.b (tmp1)
	sta.b r2
	jsl.l Div16U
	lda.b r0
	clc
	adc.b (tmp1)
	lsr a
	sta.b (tmp1)
.rts:								; return
	rts
ExecuteTrade:						; does the trade: each chosen player's team in the player team table goes
									; to the other team
	lda.b $7B
	sta.b tmp0
	ldx.w #$2DC9
	ldy.w #$364E
	lda.w VisTeam
	jsr.w CODE_C5D0A9
	lda.b $7D
	sta.b tmp0
	ldx.w #$3207
	ldy.w #$36B2
	lda.w HomeTeam
CODE_C5D0A9:						; from ExecuteTrade
	stx.b tmp2
	sty.b tmp1
	sta.b $A5
	asl a
	asl a
	asl a
	asl a
	sta.b $0A
	ldy.w #$0000
.1:									; A = (tmp1),y, if $0001 bits clear go to .3, A = Y, A * 2, ...
	lda.b (tmp1),y
	bit.w #$0001
	beq .3
	tya
	asl a
	adc.b tmp2
	tax
	lda.w $003A,x
	sta.b $0C
	lsr a
	bcc .2
	clc
	adc.b $0C
	tax
	lda.l SRPlayerTeams,x
	and.w #$FE0F
	ora.b $0A
	sta.l SRPlayerTeams,x
	bra .3
.2:									; A + $0C, X = A, A = SRPlayerTeams,x, A and $FFE0, ...
	adc.b $0C
	tax
	lda.l SRPlayerTeams,x
	and.w #$FFE0
	ora.b $A5
	sta.l SRPlayerTeams,x
.3:									; Y + 1, if Y is not tmp0 go to .1, return
	iny
	cpy.b tmp0
	bne .1
	rts
UserNameEntry:						; with user records on (not in practice): NameEntryScreen for the first
									; pad on the home team, then for the first on the away team, keeping each
									; one's name
	lda.w #$FFFF
	sta.w $4688
	sta.w $468A
	lda.w OptPlayMode
	cmp.w #$0001
	beq .rts
	lda.w OptUserRec
	beq .rts
	jsr.w CODE_C5D1C5
	ldy.w #$0000
.loop:								; loop: if cont1team,y = $0001 go to .2, Y + 1, Y + 1, ...
	lda.w cont1team,y
	cmp.w #$0001
	beq .2
	iny
	iny
	cpy.w #$000A
	bne .loop
.1:									; Y = $0000
	ldy.w #$0000
.loop2:								; loop: if cont1team,y = $0002 go to .3, Y + 1, Y + 1, ...
	lda.w cont1team,y
	cmp.w #$0002
	beq .3
	iny
	iny
	cpy.w #$000A
	bne .loop2
.rts:								; return
	rts
.2:									; a2 = HomeTeam, pausepad = Y, call NameEntryScreen, $4688 = $65, ...
	lda.w HomeTeam
	sta.b a2
	sty.w pausepad
	jsr.w NameEntryScreen
	lda.b $65
	sta.w $4688
	bra .1
.3:									; a2 = VisTeam, pausepad = Y, call NameEntryScreen, $468A = $65, ...
	lda.w VisTeam
	sta.b a2
	sty.w pausepad
	jsr.w NameEntryScreen
	lda.b $65
	sta.w $468A
	rts
NameEntryScreen:					; the Name Entry screen of a pad: the 8 user names (up / down), B edits
									; one (EditUserName), start takes it
	jsl.l FadeOutWait
	jsr.w DrawNameLog
	stz.w fadestep
.loop:								; loop: TransfersReady + 1, call ReadPauseMenuPad, $26 + 1, ...
	inc.w TransfersReady
	wai
	jsl.l ReadPauseMenuPad
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
	jsr.w EditUserName
	bra .loop
.1:									; if $0400 bits clear go to .2, A = $65, A + 1, if A < $0008 go to .3, ...
	bit.w #$0400
	beq .2
	lda.b $65
	inc a
	cmp.w #$0008
	bcc .3
	lda.w #$0000
	bra .3
.2:									; if $0800 bits clear go to .4, A = $65, A - 1, ...
	bit.w #$0800
	beq .4
	lda.b $65
	dec a
	bpl .3
	lda.w #$0007
.3:									; $65 = A, A * 2, A * 2, A * 2, ...
	sta.b $65
	asl a
	asl a
	asl a
	adc.w #$0036
	ldx.b a0
	sta.b $08,x
	bra .loop
.4:									; if $1000 bits clear go to .loop, return
	bit.w #$1000
	beq .loop
	rts
CODE_C5D1C5:						; from UserNameEntry
	jsl.l FadeOutWait
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$0008
.loop:								; loop: push Y, X = $73,y, call DeleteSprite, pull Y, ...
	phy
	ldx.b $73,y
	jsl.l DeleteSprite
	ply
	dey
	dey
	bpl .loop
	lda.w #$001C
	jsl.l CreateSprite
	stx.b a0
	lda.w #$0003
	jsl.l SetSpriteAnim
	rts
DrawNameLog:						; draws the Name Entry page: the team's name, then the 8 user names,
									; numbered
	stz.b $65
	ldx.b a0
	lda.w #$0010
	sta.b $05,x
	lda.w #$0036
	sta.b $08,x
	lda.b $D3
	ldy.w #$0700
	jsl.l ClearRAM7E
	ldy.w #$5000
	jsl.l ClearVRAM
	ldy.w #$2801
	lda.b a2
	cmp.w HomeTeam
	beq .1
	ldy.w #$2C01
.1:									; X = $5115, call MapTileBlock, X = d7, Y = $9D, ...
	ldx.w #$5115
	jsl.l MapTileBlock
	ldx.b d7
	ldy.b $9D
	lda.b a2
	cmp.w HomeTeam
	beq .2
	txy
	ldx.b $9D
.2:									; $05,x = $00D0, $08,x = $0028, A = $22,x, A or $0001, ...
	lda.w #$00D0
	sta.b $05,x
	lda.w #$0028
	sta.b $08,x
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	lda.w $0022,y
	and.w #$FFFE
	sta.w $0022,y
	lda.w #$542B
	jsl.l PrintTextPage
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b a2
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0009
	jsl.l PrintThinCentred
	lda.w #$0000
.loop:								; loop: push A, A + 1, call BCDText, mesarea,x = $003D, ...
	pha
	inc a
	jsr.w BCDText
	lda.w #$003D
	sta.w mesarea,x
	lda.w #$0014
	sta.b $CF
	lda.b $01,s
	clc
	adc.w #$0006
	tay
	ldx.w #mesarea
	jsl.l PrintBoldLeftStr
	lda.b $01,s
	jsr.w GetUserName
	cpx.w #$0000
	beq .3
	lda.w #$0020
	sta.b $CF
	lda.b $01,s
	clc
	adc.w #$0006
	tay
	ldx.w #mesarea
	jsl.l PrintBoldLeftStr
.3:									; pull A, A + 1, if A is not $0008 go to .loop, call SendTextMap, ...
	pla
	inc a
	cmp.w #$0008
	bne .loop
	jsl.l SendTextMap
	rts
GetUserName:						; user A's name into mesarea: 12 letters of 5 bits from SRUserNames (+ $40
									; a letter, $1B a space, $1F the end)
	asl a
	asl a
	sta.b tmp0
	asl a
	asl a
	asl a
	asl a
	sec
	sbc.b tmp0
	tay
	ldx.w #$0000
.1:									; call NextNameBits5, if A is not $001B go to .2, A = $0020, go to .3
	jsr.w NextNameBits5
	cmp.w #$001B
	bne .2
	lda.w #$0020
	bra .3
.2:									; if A = $001F go to .rts, A + $0040
	cmp.w #$001F
	beq .rts
	adc.w #$0040
.3:									; mesarea,x = A, X + 1, if X is not $000C go to .1
	sta.w mesarea,x
	inx
	cpx.w #$000C
	bne .1
.rts:								; return
	rts
NextNameBits5:						; A = the 5 bits at bit Y of SRUserNames; Y + 5
	phx
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	sta.b tmp0
	tya
	clc
	adc.w #$0005
	tay
	lda.l SRUserNames,x
.loop:								; loop: A / 2, tmp0 - 1, if the result >= 0 go to .loop, A and $001F, ...
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$001F
	plx
	rts
PutUserName:						; stores the name in mesarea as user A's name in SRUserNames: 12 letters
									; of 5 bits (a space $1B, $3E the end $1F, else - $40)
	asl a
	asl a
	sta.b tmp0
	asl a
	asl a
	asl a
	asl a
	sec
	sbc.b tmp0
	tay
	ldx.w #$0000
.1:									; A = mesarea,x, A and $00FF, if A is not $0020 go to .2, A = $001B, ...
	lda.w mesarea,x
	and.w #$00FF
	cmp.w #$0020
	bne .2
	lda.w #$001B
	bra .4
.2:									; if A = $003E go to .3, A - $0040, go to .4
	cmp.w #$003E
	beq .3
	sec
	sbc.w #$0040
	bra .4
.3:									; A = $001F
	lda.w #$001F
.4:									; call PutNameBits5, X + 1, if X is not $000C go to .1, return
	jsr.w PutNameBits5
	inx
	cpx.w #$000C
	bne .1
	rts
PutNameBits5:						; writes the low 5 bits of A at bit Y of SRUserNames; Y + 5
	phx
	and.w #$001F
	sta.b tmp0
	lda.w #$001F
	sta.b tmp1
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
.loop:								; loop: tmp1 * 2, tmp0 * 2, A - 1, if the result >= 0 go to .loop, ...
	asl.b tmp1
	asl.b tmp0
	dec a
	bpl .loop
	ror.b tmp0
	lda.b tmp1
	lsr a
	eor.w #$FFFF
	and.l SRUserNames,x
	ora.b tmp0
	sta.l SRUserNames,x
	tya
	clc
	adc.w #$0005
	tay
	plx
	rts
EditUserName:						; edits the chosen user name on the letter grid (DrawNameGrid): pad to a
									; letter, B to select, Y to go back, start when done, X cancels
	jsr.w DrawNameGrid
.loop:								; loop: TransfersReady + 1, call ReadPauseMenuPad, $26 + 1, ...
	inc.w TransfersReady
	wai
	jsl.l ReadPauseMenuPad
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
	bit.w #$0200
	beq .1
	jsr.w HighlightGridCell
	dec.b a1
	bpl .5
	lda.w #$001A
	bra .4
.1:									; if $0100 bits clear go to .2, call HighlightGridCell, A = a1, A + 1, ...
	bit.w #$0100
	beq .2
	jsr.w HighlightGridCell
	lda.b a1
	inc a
	cmp.w #$001B
	bcc .4
	stz.b a1
	bra .5
.2:									; if $0800 bits clear go to .3, call HighlightGridCell, A = a1, ...
	bit.w #$0800
	beq .3
	jsr.w HighlightGridCell
	lda.b a1
	sec
	sbc.w #$0009
	bpl .4
	adc.w #$001B
	bra .4
.3:									; if $0400 bits clear go to .6, call HighlightGridCell, A = a1, ...
	bit.w #$0400
	beq .6
	jsr.w HighlightGridCell
	lda.b a1
	clc
	adc.w #$0009
	cmp.w #$001B
	bcc .4
	sbc.w #$001B
.4:									; a1 = A
	sta.b a1
.5:									; call MoveGridCursor, go to .11
	jsr.w MoveGridCursor
	bra .11
.6:									; if $8080 bits clear go to .8, X = a1, A = DATA8_C598FA,x, Y = $69, ...
	bit.w #$8080
	beq .8
	ldx.b a1
	lda.l DATA8_C598FA,x
	ldy.b $69
	sep #$20
	cmp.b #$3D
	bne .7
	lda.b #$20
.7:									; mesarea,y = A, A 16-bit, Y + 1, if Y >= $000C go to .10, ...
	sta.w mesarea,y
	rep #$20
	iny
	cpy.w #$000C
	bcs .10
	sty.b $69
	bra .10
.8:									; if $4000 bits clear go to .12, if $69 = 0 go to .9, X - 1
	bit.w #$4000
	beq .12
	ldx.b $69
	beq .9
	dex
.9:									; mesarea,x = $3E3E, $69 = X
	lda.w #$3E3E
	sta.w mesarea,x
	stx.b $69
.10:								; call PrintEditedName, call SendTextMap
	jsr.w PrintEditedName
	jsl.l SendTextMap
.11:								; go to .loop
	jmp.w .loop
.12:								; if $0040 bits clear go to .13, A = $65, call GetUserName, go to .14
	bit.w #$0040
	beq .13
	lda.b $65
	jsr.w GetUserName
	bra .14
.13:								; if $1000 bits clear go to .11, A = $65, call PutUserName
	bit.w #$1000
	beq .11
	lda.b $65
	jsr.w PutUserName
.14:								; X = $FFFF, A 8-bit
	ldx.w #$FFFF
	sep #$20
.loop2:								; loop: X + 1, if mesarea,x is not $3E go to .loop2, mesarea,x = 0, ...
	inx
	lda.w mesarea,x
	cmp.b #$3E
	bne .loop2
	stz.w mesarea,x
	rep #$20
	lda.b $65
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$0188
	ldy.w #$0020
	jsl.l ClearRAM7E
	lda.w mesarea
	and.w #$00FF
	beq .15
	lda.b $65
	clc
	adc.w #$0006
	tay
	lda.w #$0020
	sta.b $CF
	ldx.w #mesarea
	jsl.l PrintBoldLeftStr
.15:								; A = $D3, A + $0380, Y = $0380, call ClearRAM7E, ...
	lda.b $D3
	clc
	adc.w #$0380
	ldy.w #$0380
	jsl.l ClearRAM7E
	lda.w #$0010
	sta.b $CF
	ldx.w #$4F40
	ldy.w #$0019
	jsl.l PrintBoldLeft
	ldx.w #$4F4A
	ldy.w #$001A
	jsl.l PrintBoldLeft
	jsl.l SendTextMap
	ldx.b a0
	lda.w #$0003
	jsl.l SetSpriteAnim
	lda.w #$0010
	sta.b $05,x
	lda.b $65
	asl a
	asl a
	asl a
	adc.w #$0036
	sta.b $08,x
	lda.w padchangeany
	bit.w #$0040
	bne .rts
	lda.b $65
	jsr.w ClearUserRecord
.rts:								; return
	rts
DrawNameGrid:						; draws the letter grid and its keys for EditUserName
	lda.b $D3
	clc
	adc.w #$0380
	ldy.w #$0380
	jsl.l ClearRAM7E
	lda.w #$0018
	sta.b $CF
	lda.w #$2C00
	sta.b $D5
	lda.w #$001A
	ldy.w #$000F
	ldx.w #$490D
	jsl.l PrintItalicFixedLeft
	lda.w #$001A
	ldy.w #$0012
	ldx.w #$4914
	jsl.l PrintItalicFixedLeft
	lda.w #$001A
	ldy.w #$0015
	ldx.w #$4922
	jsl.l PrintItalicFixedLeft
	lda.w #$2000
	sta.b $D5
	lda.w #$543D
	jsl.l PrintTextPage
	ldx.w #$0000
	stx.b $69
	cpx.w #$000C
	bne .1
	dec.b $69
.1:									; A = $003E
	lda.w #$003E
.loop:								; loop: if X = $000C go to .2, mesarea,x = A, X + 1, go to .loop
	cpx.w #$000C
	beq .2
	sta.w mesarea,x
	inx
	bra .loop
.2:									; call PrintEditedName, X = a0, A = $0000, call SetSpriteAnim, ...
	jsr.w PrintEditedName
	ldx.b a0
	lda.w #$0000
	jsl.l SetSpriteAnim
	stz.b a1
	jsr.w MoveGridCursor
	rts
MoveGridCursor:						; unhighlights letter grid cell a1 and moves the cursor sprite (a0) onto
									; it (x and y from DATA8_C5A225 / DATA8_C5A25B)
	jsr.w UnhighlightGridCell
	ldy.b a0
	lda.b a1
	asl a
	tax
	lda.l DATA8_C5A225,x
	sta.w $0005,y
	lda.l DATA8_C5A25B,x
	clc
	adc.w #$0018
	sta.w $0008,y
	rts
UnhighlightGridCell:				; puts palette 0 back on letter grid cell a1 (SetGridCellPalette 0)
	lda.w #$0000
	bra SetGridCellPalette
HighlightGridCell:					; puts palette 3 on letter grid cell a1 (SetGridCellPalette $0C00)
	lda.w #$0C00
SetGridCellPalette:					; puts palette bits tmp0 on the 2 x 2 tiles of letter grid cell a1 (its
									; position from DATA8_C5A1D7), then SendTextMap
	sta.b tmp0
	lda.b a1
	asl a
	tax
	lda.b $D3
	adc.l DATA8_C5A1D7,x
	adc.w #$00C0
	tay
	jsr.w SetTilePalette
	iny
	iny
	jsr.w SetTilePalette
	tya
	adc.w #$003E
	tay
	jsr.w SetTilePalette
	iny
	iny
	jsr.w SetTilePalette
	jsl.l SendTextMap
	rts
SetTilePalette:						; puts palette bits tmp0 on the text map tile at Y (its palette bits
									; cleared first)
	lda.w $0000,y
	and.w #$E3FF
	ora.b tmp0
	sta.w $0000,y
	rts
PrintEditedName:					; prints the name being edited (mesarea) on row $65 + 6 in the fixed-width
									; bold font (width 10), the row cleared first
	lda.b $65
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$0188
	ldy.w #$0020
	jsl.l ClearRAM7E
	lda.w #$0020
	sta.b $CF
	lda.b $65
	clc
	adc.w #$0006
	tay
	ldx.w #mesarea
	lda.w #$000A
	jsl.l PrintBoldFixedLeftStr
	rts
UpdateRecords:						; after a game, outside play mode 1 and with user records on (OptUserRec):
									; the user record of each team that has a user name ($4688 / $468A)
	lda.w OptPlayMode
	cmp.w #$0001
	beq .rtl
	lda.w OptUserRec
	beq .rtl
	lda.w HomeTeam
	sta.w $12AF
	lda.w VisTeam
	sta.w $12B1
	lda.w $4688
	bmi .1
	ldx.w #$0000
	jsr.w UpdateUserRecord
.1:									; if $468A < 0 go to .rtl, X = $0002, call UpdateUserRecord
	lda.w $468A
	bmi .rtl
	ldx.w #$0002
	jsr.w UpdateUserRecord
.rtl:								; return
	rtl
UpdateUserRecord:					; adds the game to the user record of team X: a win, loss or tie, the
									; biggest margin and the most goals with the teams, then WriteUserRecord
	pha
	jsr.w ReadUserRecord
	txa
	eor.w #$0002
	tay
	lda.w tmscore,x
	cmp.w tmscore,y
	beq .1
	bcs .2
	inc.b d4
	bra .4
.1:									; $8D + 1, go to .4
	inc.b $8D
	bra .4
.2:									; d3 + 1, A = $1297,y, A - tmscore,y, if A < $85 go to .3, ...
	inc.b d3
	lda.w $1297,y
	sec
	sbc.w tmscore,y
	cmp.b $85
	bcc .3
	beq .3
	sta.b $85
	lda.w $12AF,x
	sta.b d2
	lda.w $12AF,y
	sta.b $89
.3:									; if tmscore,x < d0 go to .4, if zero go to .4, d0 = A, $81 = $12AF,x, ...
	lda.w tmscore,x
	cmp.b d0
	bcc .4
	beq .4
	sta.b d0
	lda.w $12AF,x
	sta.b $81
	lda.w $12AF,y
	sta.b d1
.4:									; pull A
	pla
WriteUserRecord:					; writes d0, $81, d1 and $85 back as user a3's record in save RAM ($307112
									; on)
	sta.b a3
	asl a
	adc.b a3
	sta.b $71
	asl a
	sec
	sbc.b a3
	tax
	lsr a
	lsr a
	lsr a
	sta.b a4
	txa
	and.w #$0007
	sta.b $75
	lda.w #$0030
	sta.b $79
	ldx.w #$7112
	lda.b d0
	jsr.w CODE_C5D6AA
	ldx.w #$711E
	lda.b $81
	jsr.w CODE_C5D6D0
	ldx.w #$7123
	lda.b d1
	jsr.w CODE_C5D6D0
	ldx.w #$7128
	lda.b $85
	jsr.w CODE_C5D6AA
	ldx.w #$7134
	lda.b d2
	jsr.w CODE_C5D6D0
	ldx.w #$7139
	lda.b $89
	jsr.w CODE_C5D6D0
	ldx.w #$713E
	lda.b d3
	jsr.w CODE_C5D6AA
	ldx.w #$714A
	lda.b d4
	jsr.w CODE_C5D6AA
	ldx.w #$7156
	lda.b $8D
CODE_C5D6AA:						; from WriteUserRecord
	stx.b $77
	tax
	lda.b $71
	lsr a
	tay
	bcc .1
	txa
	asl a
	asl a
	asl a
	asl a
	sta.b $7D
	lda.b [$77],y
	and.w #$000F
	ora.b $7D
	sta.b [$77],y
	rts
.1:									; $7D = X, A = [$77],y, A and $F000, A or $7D, ...
	stx.b $7D
	lda.b [$77],y
	and.w #$F000
	ora.b $7D
	sta.b [$77],y
	rts
CODE_C5D6D0:						; from WriteUserRecord
	stx.b $77
	ldx.w #$001F
	stx.b $7B
	ldy.b a4
	ldx.b $75
.loop:								; loop: $7B * 2, A * 2, X - 1, if the result >= 0 go to .loop, ...
	asl.b $7B
	asl a
	dex
	bpl .loop
	lsr a
	sta.b $7D
	lda.b $7B
	lsr a
	eor.w #$FFFF
	sta.b $7B
	lda.b [$77],y
	and.b $7B
	ora.b $7D
	sta.b [$77],y
	rts
ReadUserRecord:						; reads user A's record from save RAM ($307112 on, $30 bits a user) into
									; d0, $81, d1 and $85
	phx
	sta.b a0
	asl a
	adc.b a0
	sta.b $65
	asl a
	sec
	sbc.b a0
	tax
	lsr a
	lsr a
	lsr a
	sta.b a1
	txa
	and.w #$0007
	sta.b $69
	lda.w #$0030
	sta.b $6D
	ldx.w #$7112
	jsr.w CODE_C5D75C
	sta.b d0
	ldx.w #$711E
	jsr.w CODE_C5D76E
	sta.b $81
	ldx.w #$7123
	jsr.w CODE_C5D76E
	sta.b d1
	ldx.w #$7128
	jsr.w CODE_C5D75C
	sta.b $85
	ldx.w #$7134
	jsr.w CODE_C5D76E
	sta.b d2
	ldx.w #$7139
	jsr.w CODE_C5D76E
	sta.b $89
	ldx.w #$713E
	jsr.w CODE_C5D75C
	sta.b d3
	ldx.w #$714A
	jsr.w CODE_C5D75C
	sta.b d4
	ldx.w #$7156
	jsr.w CODE_C5D75C
	sta.b $8D
	plx
	rts
CODE_C5D75C:						; from ReadUserRecord
	stx.b a2
	lda.b $65
	lsr a
	tay
	lda.b [a2],y
	bcc .1
	lsr a
	lsr a
	lsr a
	lsr a
.1:									; A and $0FFF, return
	and.w #$0FFF
	rts
CODE_C5D76E:						; from ReadUserRecord
	stx.b a2
	ldy.b a1
	ldx.b $69
	lda.b [a2],y
.loop:								; loop: A / 2, X - 1, if the result >= 0 go to .loop, A and $001F, ...
	lsr a
	dex
	bpl .loop
	rol a
	and.w #$001F
	rts
ClearUserRecord:					; clears user a3's record (every field 0, WriteUserRecord)
	stz.b d0
	stz.b $81
	stz.b d1
	stz.b $85
	stz.b d2
	stz.b $89
	stz.b d3
	stz.b d4
	stz.b $8D
	jmp.w WriteUserRecord
FindFreeAgent:						; A = the player index of free agent $65 (counting the players whose team
									; in SRPlayerTeams is $1A)
	ldx.w #$0000
	txy
.loop:								; loop: A = SRPlayerTeams,x, A and $001F, if A is not $001A go to .1, ...
	lda.l SRPlayerTeams,x
	and.w #$001F
	cmp.w #$001A
	bne .1
	dec.b $65
	bmi .3
.1:									; Y + 1, if Y >= $027E go to .3, A = SRPlayerTeams+1,x, A / 2, ...
	iny
	cpy.w #$027E
	bcs .3
	lda.l SRPlayerTeams+1,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$001F
	cmp.w #$001A
	bne .2
	dec.b $65
	bmi .3
.2:									; X + 1, X + 1, X + 1, Y + 1, ...
	inx
	inx
	inx
	iny
	cpy.w #$027E
	bcc .loop
.3:									; A = Y, return
	tya
	rts
CreatedPlayerBits:					; Y = A = the bit offset of created player A's record ($9C bits each, from
									; player $26A)
	sec
	sbc.w #$026A
	tay
	pha
	asl a
	adc.b $01,s
	sta.b $01,s
	tya
	asl a
	asl a
	adc.b $01,s
	asl a
	asl a
	sta.b $01,s
	tya
	xba
	lsr a
	adc.b $01,s
	ply
	tay
	rts
NextSaveBits3:						; A = the 3 bits at bit Y of the save RAM bit array at SRCreatedPlayers; Y
									; + 3
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	pha
	iny
	iny
	iny
	lda.l SRCreatedPlayers,x
	plx
.loop:								; loop: A / 2, X - 1, if the result >= 0 go to .loop, A and $0007, ...
	lsr a
	dex
	bpl .loop
	rol a
	and.w #$0007
	rts
NextSaveBits5:						; A = the 5 bits at bit Y of the save RAM bit array at SRCreatedPlayers; Y
									; + 5
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	pha
	iny
	iny
	iny
	iny
	iny
	lda.l SRCreatedPlayers,x
	plx
.loop:								; loop: A / 2, X - 1, if the result >= 0 go to .loop, A and $001F, ...
	lsr a
	dex
	bpl .loop
	rol a
	and.w #$001F
	rts
NextSaveBits7:						; A = the 7 bits at bit Y of the save RAM bit array at SRCreatedPlayers; Y
									; + 7
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	pha
	tya
	clc
	adc.w #$0007
	tay
	lda.l SRCreatedPlayers,x
	plx
.loop:								; loop: A / 2, X - 1, if the result >= 0 go to .loop, A and $007F, ...
	lsr a
	dex
	bpl .loop
	rol a
	and.w #$007F
	rts
NextSaveBits8:						; A = the 8 bits at bit Y of the save RAM bit array at SRCreatedPlayers; Y
									; + 8
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	pha
	tya
	clc
	adc.w #$0008
	tay
	lda.l SRCreatedPlayers,x
	plx
.loop:								; loop: A / 2, X - 1, if the result >= 0 go to .loop, A and $00FF, ...
	lsr a
	dex
	bpl .loop
	rol a
	and.w #$00FF
	rts
PrintPositionCounts:				; prints the goalie, defence and forward counts (d0, d1, $81) on rows 6-8
									; and their total on row 9
	ldx.b $D3
	stz.w $019C,x
	stz.w $019E,x
	stz.w $01A0,x
	stz.w $01DC,x
	stz.w $01DE,x
	stz.w $01E0,x
	stz.w $021C,x
	stz.w $021E,x
	stz.w $0220,x
	stz.w $025C,x
	stz.w $025E,x
	stz.w $0260,x
	lda.w #$0070
	sta.b $CF
	ldx.b d0
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	ldx.w #mesarea
	ldy.w #$0006
	jsl.l PrintBoldLeftStr
	ldx.b d1
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	ldx.w #mesarea
	ldy.w #$0007
	jsl.l PrintBoldLeftStr
	ldx.b $81
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	ldx.w #mesarea
	ldy.w #$0008
	jsl.l PrintBoldLeftStr
	lda.b d0
	clc
	adc.b d1
	adc.b $81
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	ldx.w #mesarea
	ldy.w #$0009
	jsl.l PrintBoldLeftStr
	rts
CODE_C5D8E7:						; called from other segments
	sta.b d4
	stz.b $77
	stz.b $79
	stz.b a2
	jsl.l WaitTransfers
	ldx.w #$0060
	jsl.l SetupHDMA
	db $00,$2C,$4E,$3E,$7E,$00		; inline parameters
	ldx.w #$0013
	ldy.w #$0017
	lda.b a3
	dec a
	asl a
	asl a
	asl a
	sta.w $3E4E
	sty.w $3E4F
	lda.w #$0008
	sta.w $3E50
	stx.w $3E51
	lda.b a1
	asl a
	asl a
	asl a
	sta.w $3E52
	sty.w $3E53
	lda.w #$0008
	sta.w $3E54
	stx.w $3E55
	lda.b $71
	clc
	sbc.b a3
	sbc.b a1
	dec a
	asl a
	asl a
	asl a
	sta.w $3E56
	sty.w $3E57
	lda.w #$0008
	sta.w $3E58
	stx.w $3E59
	lda.b $69
	asl a
	asl a
	asl a
	sta.w $3E5A
	sty.w $3E5B
	lda.w #$0008
	sta.w $3E5C
	stx.w $3E5D
	lda.w #$0001
	sta.w $3E5E
	sty.w $3E5F
	stz.w $3E60
	ldy.w #$FFFF
	lda.b a3
	dec a
	asl a
	asl a
	asl a
	sta.w $3F4E
	sty.w $3F4F
	lda.b a1
	inc a
	inc a
	asl a
	asl a
	asl a
	sta.w $3F51
	sty.w $3F52
	lda.b $71
	clc
	sbc.b a3
	sbc.b a1
	dec a
	asl a
	asl a
	asl a
	sta.w $3F54
	sty.w $3F55
	lda.b $69
	inc a
	inc a
	asl a
	asl a
	asl a
	sta.w $3F57
	sty.w $3F58
	lda.w #$0001
	sta.w $3F5A
	sty.w $3F5B
	stz.w $3F5D
	ldx.w #$0050
	jsl.l SetupHDMA
	db $02,$12,$4E,$3F,$7E,$7E		; inline parameters
	lda.w #$E000
	sta.w DMAEnShadow
	lda.w #$0010
	sta.b $18
	lda.w #$001C
	jsl.l CreateSprite
	stx.b d3
	lda.w #$0001
	jsl.l SetSpriteAnim
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $8D
	lda.w #$0002
	jsl.l SetSpriteAnim
	lda.b $77
	sta.b $91
	lda.b a4
	sta.b d2
	ldy.b a3
	ldx.b $7B
	lda.b a1
	jsr.w CODE_C5DAAF
	lda.b $79
	sta.b $91
	lda.b $75
	sta.b d2
	ldy.b $71
	ldx.b $7D
	lda.b $69
	jsr.w CODE_C5DAAF
PlaceTradeCursors:					; each frame, places the two trade list cursor sprites (d3, $8D) at their
									; rows and hides the one past its list's end
	ldy.b a2
	ldx.b d3
	lda.w $006F,y
	asl a
	asl a
	asl a
	sec
	sbc.w #$0004
	sta.b $08,x
	lda.w $0077,y
	beq .1
	lda.b $22,x
	ora.w #$0001
	bra .2
.1:									; A = $22,x, A and $FFFE
	lda.b $22,x
	and.w #$FFFE
.2:									; $22,x = A, X = $8D, A = $006F,y, A + $0067,y, ...
	sta.b $22,x
	ldx.b $8D
	lda.w $006F,y
	clc
	adc.w $0067,y
	asl a
	asl a
	asl a
	adc.w #$0004
	sta.b $08,x
	lda.w $0077,y
	clc
	adc.w $0067,y
	cmp.w $007B,y
	bcs .3
	lda.b $22,x
	ora.w #$0001
	bra .4
.3:									; A = $22,x, A and $FFFE
	lda.b $22,x
	and.w #$FFFE
.4:									; $22,x = A, return
	sta.b $22,x
	rts
CODE_C5DA58:						; called from other segments
	lda.b $77
	sta.b $91
	lda.b a4
	sta.b d2
	ldy.b a3
	ldx.b $7B
	lda.b a1
	jsr.w CODE_C5DAAF
	lda.b $79
	sta.b $91
	lda.b $75
	sta.b d2
	ldy.b $71
	ldx.b $7D
	lda.b $69
	jsr.w CODE_C5DAAF
	ldy.w #$0003
	lda.w #$0000
	jsr.w CODE_C5DC54
	lda.b $71
	clc
	sbc.b a3
	sbc.b a1
	dec a
	asl a
	asl a
	asl a
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	lda.w #$0002
	jsr.w CODE_C5DC54
	lda.w #$0001
	sta.w $3F4E,y
	dec a
	sta.w $3F51,y
	dec a
	sta.w $3F4F,y
	rts
CODE_C5DAAF:						; from CODE_C5D8E7, CODE_C5DA58
	phy
	phx
	tay
	inc a
	sta.b tmp1
	inc a
	sta.b tmp2
	tya
	sec
	adc.b $91
	pha
	lda.b $91
	beq CODE_C5DAC2
	dec a
CODE_C5DAC2:						; from CODE_C5DAAF, CODE_C5DAE2
	cmp.b $01,s
	bcs CODE_C5DAEF
	cmp.b $03,s
	bcs CODE_C5DAEF
	sta.b $91
.loop:								; loop: if A < tmp1 go to .1, A - tmp2, if the result >= 0 go to .loop
	cmp.b tmp1
	bcc .1
	sbc.b tmp2
	bpl .loop
.1:									; A + $05,s, $6D = A, call ClearTextRow, jump through $008F
	clc
	adc.b $05,s
	sta.b $6D
	jsr.w ClearTextRow
	pea.w CODE_C5DAE2-1
	jmp ($008F)
CODE_C5DAE2:						; from CODE_C5DAC2
	jsl.l WaitTransfers
	jsl.l RestoreWorkBuf
	lda.b $91
	inc a
	bra CODE_C5DAC2
CODE_C5DAEF:						; from CODE_C5DAC2
	pla
	pla
	pla
	rts
TradeCursorUp:						; moves the cursor of team a2's trade list up a row; when it leaves the
									; shown rows the list scrolls (the new row drawn by the row routine at
									; $8F, then a 7-frame scroll through the HDMA table at $3F4E)
	ldx.b a2
	lda.b $73,x
	sta.b d2
	lda.b $67,x
	inc a
	sta.b tmp1
	inc a
	sta.b tmp2
	lda.b $71
	clc
	sbc.b a3
	sbc.b a1
	dec a
	asl a
	asl a
	asl a
	pha
	lda.b $77,x
	beq CODE_C5DB36
	phx
	dec a
	sta.b $77,x
	dec a
	bmi CODE_C5DB38
	sta.b $91
.loop:								; loop: if A < tmp1 go to .1, A - tmp2, if the result >= 0 go to .loop
	cmp.b tmp1
	bcc .1
	sbc.b tmp2
	bpl .loop
.1:									; A + $6F,x, $6D = A, call ClearTextRow, jump through $008F
	clc
	adc.b $6F,x
	sta.b $6D
	jsr.w ClearTextRow
	pea.w CODE_C5DB30-1
	jmp ($008F)
CODE_C5DB30:						; from TradeCursorUp
	jsl.l SendTextMap
	bra CODE_C5DB38
CODE_C5DB36:						; from TradeCursorUp
	pla
	rts
CODE_C5DB38:						; from TradeCursorUp, CODE_C5DB30
	lda.w #$0007
.1:									; push A, Y = $0003, if $03,s is not 0 go to .2, call CODE_C5DCEE, ...
	pha
	ldy.w #$0003
	wai
	lda.b $03,s
	bne .2
	jsr.w CODE_C5DCEE
	lda.b $05,s
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	lda.b $03,s
	eor.w #$0002
	jsr.w CODE_C5DC54
	lda.w #$0001
	sta.w $3F4E,y
	dec a
	sta.w $3F51,y
	dec a
	sta.w $3F4F,y
	bra .3
.2:									; A xor $0002, call CODE_C5DC54, $3F4E,y = $05,s, $3F4F,y = $FFFF, ...
	eor.w #$0002
	jsr.w CODE_C5DC54
	lda.b $05,s
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	jsr.w CODE_C5DCEE
	lda.w #$0001
	sta.w $3F4E,y
	dec a
	sta.w $3F51,y
	dec a
	sta.w $3F4F,y
.3:									; pull A, A - 1, if the result >= 0 go to .1, pull A, ...
	pla
	dec a
	bpl .1
	pla
	pla
	stz.w padlast
	stz.w repeatdelayframes
	rts
TradeCursorDown:					; moves the cursor of team a2's trade list down a row (not past its count,
									; $7B), scrolling the list as TradeCursorUp does
	ldx.b a2
	lda.b $73,x
	sta.b d2
	lda.b $67,x
	inc a
	sta.b tmp1
	inc a
	sta.b tmp2
	lda.b $71
	clc
	sbc.b a3
	sbc.b a1
	dec a
	asl a
	asl a
	asl a
	pha
	lda.b $77,x
	clc
	adc.b $67,x
	cmp.b $7B,x
	bcs CODE_C5DBE6
	phx
	inc a
	cmp.b $7B,x
	bcs CODE_C5DBE8
	sta.b $91
.loop:								; loop: if A < tmp1 go to .1, A - tmp2, if the result >= 0 go to .loop
	cmp.b tmp1
	bcc .1
	sbc.b tmp2
	bpl .loop
.1:									; A + $6F,x, $6D = A, call ClearTextRow, jump through $008F
	clc
	adc.b $6F,x
	sta.b $6D
	jsr.w ClearTextRow
	pea.w CODE_C5DBE0-1
	jmp ($008F)
CODE_C5DBE0:						; from TradeCursorDown
	jsl.l SendTextMap
	bra CODE_C5DBE8
CODE_C5DBE6:						; from TradeCursorDown
	pla
	rts
CODE_C5DBE8:						; from TradeCursorDown, CODE_C5DBE0
	lda.b $01,s
	tax
	inc.b $77,x
	lda.w #$0007
.1:									; push A, Y = $0003, if $03,s is not 0 go to .2, call CODE_C5DCA7, ...
	pha
	ldy.w #$0003
	wai
	lda.b $03,s
	bne .2
	jsr.w CODE_C5DCA7
	lda.b $05,s
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	lda.b $03,s
	eor.w #$0002
	jsr.w CODE_C5DC54
	lda.w #$0001
	sta.w $3F4E,y
	dec a
	sta.w $3F51,y
	dec a
	sta.w $3F4F,y
	bra .3
.2:									; A xor $0002, call CODE_C5DC54, $3F4E,y = $05,s, $3F4F,y = $FFFF, ...
	eor.w #$0002
	jsr.w CODE_C5DC54
	lda.b $05,s
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	jsr.w CODE_C5DCA7
	lda.w #$0001
	sta.w $3F4E,y
	dec a
	sta.w $3F51,y
	dec a
	sta.w $3F4F,y
.3:									; pull A, A - 1, if the result >= 0 go to .1, pull A, ...
	pla
	dec a
	bpl .1
	pla
	pla
	stz.w padlast
	stz.w repeatdelayframes
	rts
CODE_C5DC54:						; from CODE_C5DA58, CODE_C5DB38, CODE_C5DBE8, CODE_C5DB38, ...
	tax
	lda.b $67,x
	inc a
	inc a
	sta.b $A5
	lda.b $77,x
.loop:								; loop: if A < $A5 go to .1, A - $A5, if the result >= 0 go to .loop
	cmp.b $A5
	bcc .1
	sbc.b $A5
	bpl .loop
.1:									; if A is not $0000 go to .2, A = $A5, A * 2, A * 2, ...
	cmp.w #$0000
	bne .2
	lda.b $A5
	asl a
	asl a
	asl a
	sta.w $3F4E,y
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	rts
.2:									; A * 2, A * 2, A * 2, $3F51,y = A, ...
	asl a
	asl a
	asl a
	sta.w $3F51,y
	tax
	lda.b $A5
	asl a
	asl a
	asl a
	sec
	sbc.w $3F51,y
	sta.w $3F4E,y
	txa
	dec a
	sta.w $3F4F,y
	lda.w $3F4E,y
	and.w #$00FF
	eor.w #$FFFF
	sta.w $3F52,y
	tya
	clc
	adc.w #$0006
	tay
	rts
CODE_C5DCA7:						; from CODE_C5DBE8
	lda.w $3F4F,y
	inc a
	sta.w $3F4F,y
	sep #$20
	lda.w $3F4E,y
	dec a
	sta.w $3F4E,y
	bne .1
	lda.b tmp2
	asl a
	asl a
	asl a
	sta.w $3F4E,y
	rep #$20
	lda.w #$FFFF
	sta.w $3F4F,y
	iny
	iny
	iny
	rts
.1:									; A = tmp2, A * 2, A * 2, A * 2, ...
	lda.b tmp2
	asl a
	asl a
	asl a
	sec
	sbc.w $3F4E,y
	sta.w $3F51,y
	rep #$20
	lda.w $3F4E,y
	and.w #$00FF
	eor.w #$FFFF
	sta.w $3F52,y
	tya
	clc
	adc.w #$0006
	tay
	rts
CODE_C5DCEE:						; from CODE_C5DB38
	sep #$20
	lda.b tmp2
	asl a
	asl a
	asl a
	cmp.w $3F4E,y
	bne .2
	dec a
	sta.w $3F51,y
	lda.b #$01
	sta.w $3F4E,y
	rep #$20
	lda.w $3F4F,y
	dec a
	sta.w $3F52,y
	lda.b tmp2
	asl a
	asl a
	asl a
	dec a
	dec a
	sta.w $3F4F,y
.1:									; A = Y, A + $0006, Y = A, return
	tya
	clc
	adc.w #$0006
	tay
	rts
.2:									; A = $3F4E,y, A + 1, $3F4E,y = A, A = $3F51,y, ...
	lda.w $3F4E,y
	inc a
	sta.w $3F4E,y
	lda.w $3F51,y
	dec a
	sta.w $3F51,y
	rep #$20
	lda.w $3F4F,y
	dec a
	sta.w $3F4F,y
	lda.w $3F52,y
	dec a
	sta.w $3F52,y
	lda.w $3F51,y
	and.w #$00FF
	bne .1
	iny
	iny
	iny
	rts
SimDayScores:						; simulates the score of each of the day's computer games not yet done:
									; goals added at random below each team's rating, the game marked done (+6
									; = $FFFF); in play mode 3 a tie goes to the away team
	lda.w $2C42
	sta.b tmp0
	ldx.w #$8EF8
.loop:								; loop: if $7F0000,x is not 0 go to .3, if $7F0006,x < 0 go to .3, ...
	lda.l $7F0000,x
	bne .3
	lda.l $7F0006,x
	bmi .3
	lda.l $7F0002,x
	txy
	jsr.w CODE_C5DDC0
	sec
	sbc.l $7F0008,x
	bcc .1
	beq .1
	jsl.l RandomBelowA
	clc
	adc.l $7F0008,x
	sta.l $7F0008,x
.1:									; A = $7F0004,x, call CODE_C5DDC0, A + 1, A - $7F000A,x, ...
	lda.l $7F0004,x
	jsr.w CODE_C5DDC0
	inc a
	sec
	sbc.l $7F000A,x
	bcc .2
	beq .2
	jsl.l RandomBelowA
	clc
	adc.l $7F000A,x
	sta.l $7F000A,x
.2:									; $7F0006,x = $FFFF, if OptPlayMode is not $0003 go to .3, ...
	lda.w #$FFFF
	sta.l $7F0006,x
	lda.w OptPlayMode
	cmp.w #$0003
	bne .3
	lda.l $7F000A,x
	cmp.l $7F0008,x
	bne .3
	inc a
	sta.l $7F000A,x
.3:									; A = X, A + $010A, X = A, tmp0 - 1, ...
	clc
	txa
	adc.w #$010A
	tax
	dec.b tmp0
	bne .loop
	rts
CODE_C5DDC0:						; from SimDayScores
	asl a
	tax
	lda.l $C30000,x
	tax
	adc.l $C30006,x
	tax
	lda.l $C30004,x
	and.w #$00FF
	jsl.l RandomBelowA
	sta.l WRDIVL
	lda.w #$000A
	sta.l WRDIVB
	inx
	inx
	inx
	inx
	clc
	tyx
	lda.l RDDIVL
	adc.w #$0004
	rts
RecordDayResults:					; RecordGameResult for each of the day's game records ($2C42 of them at
									; $7F8EF8) whose bit in SRDayPlayed is clear
	pea.w $7E7F
	lda.w $2C42
	sta.b tmp0
	lda.l SRDayPlayed
	sta.b tmp2
	plb
	ldy.w #$8EF8
.loop:								; loop: tmp2 / 2, if carry set go to .1, call RecordGameResult
	lsr.b tmp2
	bcs .1
	jsr.w RecordGameResult
.1:									; A = Y, A + $010A, Y = A, tmp0 - 1, ...
	tya
	clc
	adc.w #$010A
	tay
	dec.b tmp0
	bne .loop
	plb
	rts
CODE_C5DE15:						; from RecordTeamResult
	ldx.w #$0002
	bra CODE_C5DE3F
CODE_C5DE1A:						; from RecordTeamResult
	ldx.w #$0003
	bra CODE_C5DE3F
RecordGameResult:					; records game Y's result for both teams (RecordTeamResult): home by +8
									; against +$A, then away
	lda.w $0008,y
	cmp.w $000A,y
	php
	lda.w $0002,y
	plp
	jsr.w RecordTeamResult
	lda.w $000A,y
	cmp.w $0008,y
	php
	lda.w $0004,y
	plp
RecordTeamResult:					; adds a win (1), loss (2) or tie (3) for team A by the flags of the score
									; compare to its 2-bit results at SRTeamResults (21 bytes a team), in the
									; first free slot
	bcc CODE_C5DE15
	beq CODE_C5DE1A
	ldx.w #$0001
CODE_C5DE3F:						; from CODE_C5DE15, CODE_C5DE1A
	stx.b tmp1
	ldx.w #$0015
	phy
	jsl.l Mul8U
	ply
	tax
	sep #$20
.1:									; A = SRTeamResults,x, if a $03 bit set go to .2, A or tmp1, ...
	lda.l SRTeamResults,x
	bit.b #$03
	bne .2
	ora.b tmp1
	sta.l SRTeamResults,x
	bra .6
.2:									; if a $0C bit set go to .3, tmp1 * 2, tmp1 * 2, A or tmp1, ...
	bit.b #$0C
	bne .3
	asl.b tmp1
	asl.b tmp1
	ora.b tmp1
	sta.l SRTeamResults,x
	bra .6
.3:									; if a $30 bit set go to .4, A = tmp1, A * 2, A * 2, ...
	bit.b #$30
	bne .4
	lda.b tmp1
	asl a
	asl a
	asl a
	asl a
	ora.l SRTeamResults,x
	sta.l SRTeamResults,x
	bra .6
.4:									; if a $C0 bit set go to .5, A = tmp1, A or SRTeamResults,x, ...
	bit.b #$C0
	bne .5
	lda.b tmp1
	clc
	ror a
	ror a
	ror a
	ora.l SRTeamResults,x
	sta.l SRTeamResults,x
	bra .6
.5:									; X + 1, go to .1
	inx
	bra .1
.6:									; A 16-bit, return
	rep #$20
	rts
SimDayGameStats:					; fills the stats of each of the day's computer games: both teams' totals
									; from their goals (SimTeamTotals), then the players' stats
	pea.w $7E7F
	lda.w $2C42
	sta.b tmp0
	lda.l SRDayPlayed
	sta.b tmp2
	plb
	ldy.w #$8EF8
.1:									; tmp2 / 2, if carry clear go to .2, go to .4
	lsr.b tmp2
	bcc .2
	jmp.w .4
.2:									; if $0000,y = 0 go to .3, go to .4
	lda.w $0000,y
	beq .3
	jmp.w .4
.3:									; X = Y, $0034,y = $0008,y, call SimTeamTotals, A = Y, ...
	tyx
	lda.w $0008,y
	sta.w $0034,y
	jsr.w SimTeamTotals
	tya
	clc
	adc.w #$0016
	tax
	lda.w $000A,y
	sta.w $001E,y
	jsr.w SimTeamTotals
	lda.w $0024,y
	sta.w $0020,y
	lda.w $000E,y
	sta.w $0036,y
	phy
	lda.w $0002,y
	sta.l VisTeam
	lda.w $0004,y
	sta.l HomeTeam
	pei ($9F)
	pei ($A1)
	pei ($A3)
	pea.w $7F7E
	plb
	jsl.l RestoreWorkBuf
	jsr.w LoadGameRosters
	ldy.w #$2DC9
	jsl.l CODE_C4EFD8
	ldy.w #$3207
	jsl.l CODE_C4EFD8
	plb
	pla
	sta.b tmp2
	pla
	sta.b tmp1
	pla
	sta.b tmp0
	lda.b $01,s
	clc
	adc.w #$003A
	tax
	inc a
	tay
	stz.w $0000,x
	lda.w #$00CE
	mvn $7F,$7F
	lda.w #$3207
	sta.b p0
	lda.w #$007E
	sta.b $3A
	lda.b $01,s
	tay
	adc.w #$001A
	tax
	jsr.w SimPlayerStats
	lda.w #$2DC9
	sta.b p0
	lda.b $01,s
	clc
	tax
	adc.w #$0016
	tay
	jsr.w SimPlayerStats
	ply
.4:									; A = Y, A + $010A, Y = A, tmp0 - 1, ...
	clc
	tya
	adc.w #$010A
	tay
	dec.b tmp0
	beq .5
	jmp.w .1
.5:									; return
	plb
	rts

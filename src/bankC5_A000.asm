; Segment bankC5_A000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), two jump tables and the data tables the code reads with long addresses.
org $C59F79
PrintCreatedOverall:				; packs the created player's ratings (CreateRatings on; the skater or
									; goalie layout by d0) as the nibbles of a player record in mesarea, then
									; prints its overall rating (RecordOverall) and d2
	stz.w mesarea
	stz.w mesarea+2
	stz.w mesarea+4
	stz.w mesarea+6
	lda.b d0
	bne .1
	lda.w #$0010
	sta.w RatingMode
	lda.w CreateRatings
	jsr.w RatingNibbleHigh
	tsb.w mesarea+2
	lda.w CreateRatings+$2
	jsr.w RatingNibble
	tsb.w mesarea+1
	lda.w CreateRatings+$4
	jsr.w RatingNibbleHigh
	tsb.w mesarea+3
	lda.w CreateRatings+$6
	jsr.w RatingNibble
	tsb.w mesarea+3
	lda.w CreateRatings+$8
	jsr.w RatingNibble
	tsb.w mesarea+6
	lda.w CreateRatings+$A
	jsr.w RatingNibbleHigh
	tsb.w mesarea+6
	lda.w CreateRatings+$C
	jsr.w RatingNibble
	tsb.w mesarea+7
	lda.w CreateRatings+$E
	jsr.w RatingNibbleHigh
	tsb.w mesarea+7
	jmp.w .2
.1:									; RatingMode = 0, A = CreateRatings, call RatingNibbleHigh, ...
	stz.w RatingMode
	lda.w CreateRatings
	jsr.w RatingNibbleHigh
	tsb.w mesarea+2
	lda.w CreateRatings+$2
	jsr.w RatingNibble
	tsb.w mesarea+1
	lda.w CreateRatings+$4
	jsr.w RatingNibbleHigh
	tsb.w mesarea+6
	lda.w CreateRatings+$6
	jsr.w RatingNibble
	tsb.w mesarea+2
	lda.w CreateRatings+$8
	jsr.w RatingNibbleHigh
	tsb.w mesarea+3
	lda.w CreateRatings+$A
	jsr.w RatingNibbleHigh
	tsb.w mesarea+5
	lda.w CreateRatings+$C
	jsr.w RatingNibble
	tsb.w mesarea+3
	lda.w CreateRatings+$E
	jsr.w RatingNibble
	tsb.w mesarea+5
	lda.w CreateRatings+$10
	jsr.w RatingNibbleHigh
	tsb.w mesarea+7
	lda.w CreateRatings+$12
	jsr.w RatingNibble
	tsb.w mesarea+7
	lda.w CreateRatings+$14
	jsr.w RatingNibbleHigh
	tsb.w mesarea+4
.2:									; call RecordOverall, call BinToBCD, call BCDText, Y = $0015, ...
	jsr.w RecordOverall
	jsr.w BinToBCD
	jsr.w BCDText
	ldy.w #$0015
	jsr.w PrintPaddedValue
	lda.b d2
	jsr.w BinToBCD
	jsr.w BCDText
	ldy.w #$0016
PrintPaddedValue:					; prints the BCDText digits in mesarea bold right-aligned at row Y with a
									; space in front
	lda.w mesarea+4
	sta.w mesarea+6
	lda.w mesarea+2
	sta.w mesarea+4
	lda.w mesarea
	sta.w mesarea+2
	lda.w #$2020
	sta.w mesarea
	ldx.w #mesarea+1
	jsl.l PrintBoldRightStr
	rts
RatingNibble:						; A = the 0-6 rating of value A (0-15), from the table after it
	tax
	lda.l DATA8_C5A08B,x
	and.w #$00FF
	rts
RatingNibbleHigh:					; RatingNibble * 16 (for the high nibble of a record byte)
	jsr.w RatingNibble
	asl a
	asl a
	asl a
	asl a
	rts
DATA8_C5A08B:						; not traced: a table read by RatingNibble
	db $00,$00,$01,$01,$02,$02,$03,$03,$03,$03,$04,$04,$04,$05,$05,$06
DrawNameEntry:						; draws the Create Player page: First Name, Last Name, the letter grid and
									; its keys; the screen state goes to 0 (NameEntry)
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l QueueClearVRAM
	lda.w #$FFFF
	sta.w BG3VScroll
	ldy.w #$5C00
	jsl.l ClearVRAM
	ldx.b d7
	jsl.l DeleteSprite
	ldx.b $9D
	jsl.l DeleteSprite
	ldx.b a4
	jsl.l DeleteSprite
	ldx.b $75
	jsl.l DeleteSprite
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$5714
	jsl.l PrintTextPage
	sec
	lda.b $CF
	sbc.w #$0008
	sta.b $CF
	lda.w #$2C00
	sta.b $D5
	lda.w #$001A
	ldy.w #$000C
	ldx.w #$490D
	jsl.l PrintItalicFixedLeft
	lda.w #$001A
	ldy.w #$000F
	ldx.w #$4914
	jsl.l PrintItalicFixedLeft
	lda.w #$001A
	ldy.w #$0012
	ldx.w #$491B
	jsl.l PrintItalicFixedLeft
	lda.w #$2000
	sta.b $D5
	lda.w #$3E3E
	sta.w mesarea
	sta.w mesarea+2
	sta.w mesarea+4
	sta.w mesarea+6
	sta.w mesarea+8
	stz.w mesarea+10
	lda.w #$0078
	sta.b $CF
	lda.w #$000F
	ldy.w #$0008
	ldx.w #mesarea
	jsl.l PrintItalicFixedLeftStr
	stz.w mesarea+8
	lda.w #$000F
	ldy.w #$0006
	ldx.w #mesarea
	jsl.l PrintItalicFixedLeftStr
	jsl.l SendTextMap
	lda.w #$0006
	sta.b $71
	lda.w #$0008
	sta.b $69
	stz.b $99
	stz.b a3
	stz.b d6
	jsr.w MoveCreateGridCursor
	rts
PlaceYesNoCursor:					; the cursor sprite (a0) to x $6A on the Yes (d6 = 0, y $87) or No (y $9F)
									; line
	lda.w #$006A
	ldx.b a0
	sta.b $05,x
	lda.b d6
	beq .1
	lda.w #$009F
	sta.b $08,x
	rts
.1:									; $08,x = $0087, return
	lda.w #$0087
	sta.b $08,x
	rts
LetterCellPalette3:					; palette 3 on the 2 x 2 tiles of Create Player letter grid cell d6
									; (DATA8_C5A1D7)
	lda.b d6
	asl a
	tax
	lda.b $D3
	adc.l DATA8_C5A1D7,x
	tay
	jsr.w SetTilePalette3
	iny
	iny
	jsr.w SetTilePalette3
	tya
	adc.w #$003E
	tay
	jsr.w SetTilePalette3
	iny
	iny
SetTilePalette3:					; palette 3 on the text map tile at Y
	lda.w $0000,y
	and.w #$E3FF
	ora.w #$0C00
	sta.w $0000,y
	rts
LetterCellPalette0:					; palette 0 on the 2 x 2 tiles of Create Player letter grid cell d6
									; (DATA8_C5A1D7), then SendTextMap
	lda.b d6
	asl a
	tax
	lda.b $D3
	adc.l DATA8_C5A1D7,x
	tay
	jsr.w SetTilePalette0
	iny
	iny
	jsr.w SetTilePalette0
	tya
	adc.w #$003E
	tay
	jsr.w SetTilePalette0
	iny
	iny
	jsr.w SetTilePalette0
	jsl.l SendTextMap
	rts
SetTilePalette0:					; palette 0 on the text map tile at Y
	lda.w $0000,y
	and.w #$E3FF
	ora.w #$0000
	sta.w $0000,y
	rts
DATA8_C5A1D7:						; not traced: a table read by LetterCellPalette3, LetterCellPalette0
	db $06,$03,$0C,$03,$12,$03,$18,$03,$1E,$03,$24,$03,$2A,$03,$30,$03
	db $36,$03,$C6,$03,$CC,$03,$D2,$03,$D8,$03,$DE,$03,$E4,$03,$EA,$03
	db $F0,$03,$F6,$03,$86,$04,$8C,$04,$92,$04,$98,$04,$9E,$04,$A4,$04
	db $AA,$04,$B0,$04,$B6,$04
MoveCreateGridCursor:				; palette 0 on Create Player letter grid cell d6 and the cursor sprite
									; (a0) onto it (x and y from DATA8_C5A225 / DATA8_C5A25B)
	jsr.w LetterCellPalette0
	ldy.b a0
	lda.b d6
	asl a
	tax
	lda.l DATA8_C5A25B,x
	sta.w $0008,y
	lda.l DATA8_C5A225,x
	sta.w $0005,y
	rts
DATA8_C5A225:						; not traced: a table read by MoveCreateGridCursor
	db $14,$00,$2C,$00,$44,$00,$5C,$00,$74,$00,$8C,$00,$A4,$00,$BC,$00
	db $D4,$00,$14,$00,$2C,$00,$44,$00,$5C,$00,$74,$00,$8C,$00,$A4,$00
	db $BC,$00,$D4,$00,$14,$00,$2C,$00,$44,$00,$5C,$00,$74,$00,$8C,$00
	db $A4,$00,$BC,$00,$D4,$00
DATA8_C5A25B:						; not traced: a table read by MoveCreateGridCursor
	db $70,$00,$70,$00,$70,$00,$70,$00,$70,$00,$70,$00,$70,$00,$70,$00
	db $70,$00,$88,$00,$88,$00,$88,$00,$88,$00,$88,$00,$88,$00,$88,$00
	db $88,$00,$88,$00,$A0,$00,$A0,$00,$A0,$00,$A0,$00,$A0,$00,$A0,$00
	db $A0,$00,$A0,$00,$A0,$00
FieldPos:							; prints the created player's position (d0: Goalie, Left Defense, Right
									; Defense, Left Wing, Center, Right Wing; DATA8_C5A2A8) on row 8, its
									; field cleared first
	lda.w #$0008
	jsr.w ClearFieldValue
	lda.b d0
	asl a
	tax
	lda.l DATA8_C5A2A8,x
	tax
	ldy.w #$0008
	jsl.l PrintItalicLeft
	rts
DATA8_C5A2A8:						; not traced: a table read by FieldPos
	db $B8,$49,$BD,$49,$C7,$49,$D7,$49,$D2,$49,$E0,$49
FieldWeight:						; prints the created player's weight, $81 * 8 + 140, on row $B, its field
									; cleared first
	lda.w #$000B
	jsr.w ClearFieldValue
	lda.b $81
	asl a
	asl a
	asl a
	adc.w #$008C
	jsr.w BinToBCD
	jsr.w BCDDigits4
	ldx.w #mesarea+1
	ldy.w #$000B
	jsl.l PrintItalicLeftStr
	rts
FieldJersey:						; prints the created player's number (d1, two digits) on row $E, its field
									; cleared first
	lda.w #$000E
	jsr.w ClearFieldValue
	lda.b d1
	jsr.w BinToBCD
	jsr.w BCDDigits4
	ldx.w #mesarea+2
	ldy.w #$000E
	jsl.l PrintItalicLeftStr
	rts
FieldHand:							; prints the created player's hand (Left when $85 is set, else Right) on
									; row $11, its field cleared first
	lda.w #$0011
	jsr.w ClearFieldValue
	ldx.w #$49ED
	lda.b $85
	beq .1
	ldx.w #$49E9
.1:									; Y = $0011, call PrintItalicLeft, return
	ldy.w #$0011
	jsl.l PrintItalicLeft
	rts
ClearFieldValue:					; clears the 16 tiles from column 16 of row A and the row below (a Create
									; Player field's value)
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$0020
	pha
	ldy.w #$0020
	jsl.l ClearRAM7E
	pla
	clc
	adc.w #$0040
	ldy.w #$0020
	jsl.l ClearRAM7E
	rts
BCDDigits4:							; mesarea = the 4 BCD digits of A as text, leading zeros kept
	tax
	xba
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w mesarea
	txa
	xba
	and.w #$000F
	adc.w #$0030
	sta.w mesarea+1
	txa
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w mesarea+2
	txa
	and.w #$000F
	adc.w #$0030
	sta.w mesarea+3
	rts
DATA8_C5A354:						; the check routine of the option line routine after it: LimitTradeTeam2
	dw LimitTradeTeam2
TradeTeam2Hook:						; the routine of the Trades screen's Team 2 line (the word before it is
									; its check, LimitTradeTeam2): PrintVisTeamName
	jmp.w PrintVisTeamName
LimitTradeTeam2:					; the Trades screen Team 2 line's check: VisTeam kept among the 26 NHL
									; teams (wrapping) and stepped once more when it equals HomeTeam, then
									; LimitVisTeam
	lda.w VisTeam
	cmp.w #$001A
	bcc .3
	beq .1
	lda.w #$0019
	bra .2
.1:									; A = $0000
	lda.w #$0000
.2:									; VisTeam = A
	sta.w VisTeam
.3:									; if A is not HomeTeam go to LimitVisTeam, A = padchangeany, ...
	cmp.w HomeTeam
	bne LimitVisTeam
	lda.w padchangeany
	bit.w #$0200
	beq .5
	lda.w VisTeam
	dec a
	bpl .4
	lda.w #$0019
.4:									; VisTeam = A, go to LimitVisTeam
	sta.w VisTeam
	bra LimitVisTeam
.5:									; A = VisTeam, A + 1, if A < $001A go to .4, A = $0000, ...
	lda.w VisTeam
	inc a
	cmp.w #$001A
	bcc .4
	lda.w #$0000
	bra .4
LimitVisTeam:						; the Visiting Team line's check: with OptRosters set or a play mode past
									; Practice, VisTeam wraps past teams $1A / $1B (to 0 / $19)
	lda.w OptRosters
	bne .1
	lda.w OptPlayMode
	beq .rts
	dec a
	beq .rts
.1:									; if VisTeam is not $001A go to .3, A = $0000
	lda.w VisTeam
	cmp.w #$001A
	bne .3
	lda.w #$0000
.2:									; VisTeam = A, go to .rts
	sta.w VisTeam
	bra .rts
.3:									; if A is not $001B go to .rts, A = $0019, go to .2
	cmp.w #$001B
	bne .rts
	lda.w #$0019
	bra .2
.rts:								; return
	rts
DATA8_C5A3BF:						; the check routine of the option line routine after it: LimitVisTeam
	dw LimitVisTeam
PrintVisTeamName:					; saves VisTeam (SRVisTeam) and prints its name, thin and centred between
									; x $20 and $68 on row $D; the Visiting Team lines' routine
	lda.w VisTeam
	sta.l SRVisTeam
	jsl.l WaitTransfers
	pei ($CF)
	pei ($D1)
	lda.w #$0340
	jsr.w ClearTeamNameBox
	lda.w #$0020
	sta.b $CF
	lda.w #$0068
	sta.b $D1
	lda.w VisTeam
	jmp.w CODE_C5A48C
ClearTeamNameBox:					; clears 16 tiles at text map offset A and on the row below (a team name)
	clc
	adc.b $D3
	ldy.w #$0020
	pha
	phy
	jsl.l ClearRAM7E
	ply
	pla
	clc
	adc.w #$0040
	jsl.l ClearRAM7E
	rts
DATA8_C5A3FD:						; the check routine of the option line routine after it: LimitTradeTeam1
	dw LimitTradeTeam1
TradeTeam1Hook:						; the routine of the Trades screen's Team 1 line (the word before it is
									; its check, LimitTradeTeam1): PrintHomeTeamName
	jmp.w PrintHomeTeamName
LimitTradeTeam1:					; the Trades screen Team 1 line's check: HomeTeam kept among the 26 NHL
									; teams (wrapping) and stepped once more when it equals VisTeam, then
									; LimitHomeTeam
	lda.w HomeTeam
	cmp.w #$001A
	bcc .3
	beq .1
	lda.w #$0019
	bra .2
.1:									; A = $0000
	lda.w #$0000
.2:									; HomeTeam = A
	sta.w HomeTeam
.3:									; if A is not VisTeam go to LimitHomeTeam, A = padchangeany, ...
	cmp.w VisTeam
	bne LimitHomeTeam
	lda.w padchangeany
	bit.w #$0200
	beq .5
	lda.w HomeTeam
	dec a
	bpl .4
	lda.w #$0019
.4:									; HomeTeam = A, go to LimitHomeTeam
	sta.w HomeTeam
	bra LimitHomeTeam
.5:									; A = HomeTeam, A + 1, if A < $001A go to .4, A = $0000, ...
	lda.w HomeTeam
	inc a
	cmp.w #$001A
	bcc .4
	lda.w #$0000
	bra .4
LimitHomeTeam:						; the Home Team line's check: with OptRosters set or a play mode past
									; Practice, HomeTeam wraps past teams $1A / $1B (to 0 / $19)
	lda.w OptRosters
	bne .1
	lda.w OptPlayMode
	beq .rts
	dec a
	beq .rts
.1:									; if HomeTeam is not $001A go to .3, A = $0000
	lda.w HomeTeam
	cmp.w #$001A
	bne .3
	lda.w #$0000
.2:									; HomeTeam = A, go to .rts
	sta.w HomeTeam
	bra .rts
.3:									; if A is not $001B go to .rts, A = $0019, go to .2
	cmp.w #$001B
	bne .rts
	lda.w #$0019
	bra .2
.rts:								; return
	rts
DATA8_C5A468:						; the check routine of the option line routine after it: LimitHomeTeam
	dw LimitHomeTeam
PrintHomeTeamName:					; saves HomeTeam (SRHomeTeam) and prints its name, thin and centred
									; between x $A0 and $E8 on row $D; the Home Team lines' routine
	lda.w HomeTeam
	sta.l SRHomeTeam
	jsl.l WaitTransfers
	pei ($CF)
	pei ($D1)
	lda.w #$0360
	jsr.w ClearTeamNameBox
	lda.w #$00A0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	lda.w HomeTeam
CODE_C5A48C:						; from PrintVisTeamName
	ldy.w #$000D
CODE_C5A48F:						; from PrintTeamNameLeft
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	jsl.l PrintThinCentred
	jsl.l SendTextMap
	pla
	sta.b $D1
	pla
	sta.b $CF
	rts
PrintTeamNameLeft:					; prints the name of team A on row Y, thin and centred between x $20 and
									; $68 ($CF / $D1 kept)
	pei ($CF)
	pei ($D1)
	ldx.w #$0020
	stx.b $CF
	ldx.w #$0068
	stx.b $D1
	bra CODE_C5A48F
QueueHomePaletteLong:				; QueueHomePalette for long calls
	jsr.w QueueHomePalette
	rtl
QueueHomePalette:					; queues HomeTeam's 16 colours (TeamPalettes as unpacked at $7F:D80A) for
									; CGRAM $20
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	pea.w $0020
	pea.w $007F
	lda.w HomeTeam
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
	rts
QueueVisPaletteLong:				; QueueVisPalette for long calls
	jsr.w QueueVisPalette
	rtl
QueueVisPalette:					; queues VisTeam's 16 colours (TeamPalettes as unpacked at $7F:D80A) for
									; CGRAM $30
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	pea.w $0030
	pea.w $007F
	lda.w VisTeam
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
	rts
DeleteArrowSpritesLong:				; DeleteArrowSprites for long calls
	jsr.w DeleteArrowSprites
	rtl
DeleteArrowSprites:					; deletes the two arrow sprites a4 and $75 and clears both
	ldx.b a4
	jsl.l DeleteSprite
	stz.b a4
	ldx.b $75
	jsl.l DeleteSprite
	stz.b $75
	rts
SeasonOptions:						; the League Menu (season mode): draws its page (Play Games, NHL
									; Standings, Games Today, League Leaders, Team Stats, Player Stats) and
									; makes SeasonOptionsInput the screen's handler
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l QueueClearVRAM
	ldy.w #$5C00
	jsl.l QueueClearVRAM
	lda.w #$FFFF
	sta.w BG3VScroll
	jsl.l WaitTransfers
	lda.w #$0002
	sta.w OptPlayMode
	lda.l SeasonDay
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C35F60,x
	bne .1
	jsl.l SetupPlayoffs
	inc.w OptPlayMode
.1:									; X = d7, call DeleteSprite, X = $9D, call DeleteSprite, ...
	ldx.b d7
	jsl.l DeleteSprite
	ldx.b $9D
	jsl.l DeleteSprite
	jsr.w DeleteArrowSprites
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$56A4
	jsl.l PrintTextPage
	clc
	lda.b $D3
	adc.w #$0240
	tax
	ldy.w #$01DF
.loop:								; loop: A = $0000,x, A and $E3FF, A or $0C00, $0000,x = A, ...
	lda.w $0000,x
	and.w #$E3FF
	ora.w #$0C00
	sta.w $0000,x
	inx
	inx
	dey
	bpl .loop
	stz.b d6
	lda.w #$0006
	sta.b $99
	stz.w fadestep
PlaceLeagueCursor:					; the cursor sprite (a0) to League Menu item d6: x $30, y d6 * 24 + $3E
	ldx.b a0
	lda.w #$0030
	sta.b $05,x
	lda.b d6
	asl a
	asl a
	asl a
	sta.b tmp0
	asl a
	adc.b tmp0
	adc.w #$003E
	sta.b $08,x
	rts
LeagueLeadersInput:					; the League Leaders screen each frame (screen state 8): up / down scroll,
									; left / right / B redraw it with another category, start / select back to
									; the League Menu
	jsr.w ScrollListArrows
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$0013
	sta.w repeatdelayframes
.1:									; A = padchangeany, if a $3000 bit set go to .4, ...
	lda.w padchangeany
	bit.w #$3000
	bne .4
	bit.w #$0800
	beq .2
	jmp.w ScrollListUp
.2:									; if $0400 bits clear go to .3, go to ScrollListDown
	bit.w #$0400
	beq .3
	jmp.w ScrollListDown
.3:									; if a $0200 bit set go to .5, if a $0100 bit set go to .6, ...
	bit.w #$0200
	bne .5
	bit.w #$0100
	bne .6
	bit.w #$8000
	bne .8
.rts:								; return
	rts
.4:									; call FadeOutWait, X = $77, call DeleteSprite, X = $79, ...
	jsl.l FadeOutWait
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	jmp.w SeasonOptions
.5:									; A = d1, A - 1, if the result >= 0 go to .7, A = $0002, ...
	lda.b d1
	dec a
	bpl .7
	lda.w #$0002
	bra .7
.6:									; A = d1, A + 1, if A < $0003 go to .7, A = $0000
	lda.b d1
	inc a
	cmp.w #$0003
	bcc .7
	lda.w #$0000
.7:									; push A, go to DrawLeagueLeaders
	pha
	jmp.w DrawLeagueLeaders
.8:									; A = $85, A xor $0001, $85 = A, go to DrawLeagueLeaders
	pei ($83)
	lda.b $85
	eor.w #$0001
	sta.b $85
	jmp.w DrawLeagueLeaders
SeasonTeamStatsInput:				; the Season Team Stats screen each frame (screen state 9): left / right
									; switch the team, start / select back to the League Menu
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$0013
	sta.w repeatdelayframes
.1:									; A = padchangeany, if a $0100 bit set go to .2, ...
	lda.w padchangeany
	bit.w #$0100
	bne .2
	bit.w #$0200
	bne .4
	bit.w #$3000
	beq .rts
	jsl.l FadeOutWait
	jmp.w SeasonOptions
.rts:								; return
	rts
.2:									; A = HomeTeam, A + 1, if A < $001A go to .3, A = $0000
	lda.w HomeTeam
	inc a
	cmp.w #$001A
	bcc .3
	lda.w #$0000
.3:									; HomeTeam = A, go to DrawSeasonTeamStats
	sta.w HomeTeam
	jmp.w DrawSeasonTeamStats
.4:									; A = HomeTeam, A - 1, if the result >= 0 go to .5, A = $0019
	lda.w HomeTeam
	dec a
	bpl .5
	lda.w #$0019
.5:									; HomeTeam = A, go to DrawSeasonTeamStats
	sta.w HomeTeam
	jmp.w DrawSeasonTeamStats
SeasonPlayerStatsInput:				; the Season Player Stats screen each frame (screen state 10): up / down
									; scroll, B goalies / players, left / right switch the team, start /
									; select back to the League Menu
	jsr.w ScrollListArrows
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$0014
	sta.w repeatdelayframes
.1:									; A = padchangeany, if a $8000 bit set go to .7, ...
	lda.w padchangeany
	bit.w #$8000
	bne .7
	bit.w #$0100
	bne .5
	bit.w #$0200
	bne .9
	bit.w #$0400
	beq .2
	jmp.w ScrollListDown
.2:									; if $0800 bits clear go to .3, go to ScrollListUp
	bit.w #$0800
	beq .3
	jmp.w ScrollListUp
.3:									; if a $3000 bit set go to .4
	bit.w #$3000
	bne .4
.rts:								; return
	rts
.4:									; call FadeOutWait, X = $77, call DeleteSprite, X = $79, ...
	jsl.l FadeOutWait
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	jmp.w SeasonOptions
.5:									; A = HomeTeam, A + 1, if A < $001A go to .6, A = $0000
	lda.w HomeTeam
	inc a
	cmp.w #$001A
	bcc .6
	lda.w #$0000
.6:									; go to .10
	bra .10
.7:									; call PrintPlayerStatsHeadings, if d0 is not 0 go to .8, d0 - 1, ...
	jsr.w PrintPlayerStatsHeadings
	lda.b d0
	bne .8
	dec.b d0
	bra .11
.8:									; d0 = 0, go to .11
	stz.b d0
	bra .11
.9:									; A = HomeTeam, A - 1, if the result >= 0 go to .10, A = $0019
	lda.w HomeTeam
	dec a
	bpl .10
	lda.w #$0019
.10:								; HomeTeam = A
	sta.w HomeTeam
.11:								; X = $77, call DeleteSprite, X = $79, call DeleteSprite, ...
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	lda.b $D3
	clc
	adc.w #$0280
	ldy.w #$0380
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsr.w DrawPlayerStatsTeam
	jsr.w LoadGameRosters
	lda.w HomeRoster+2
	sta.b a1
	lda.b d0
	bne .12
	sec
	lda.w HomeRoster
	sbc.w HomeRoster+2
	sta.b a1
.12:								; $69 = 0, A = DrawSeasonPlayerRow, X = $000C, Y = $000B, ...
	stz.b $69
	lda.w #DrawSeasonPlayerRow
	ldx.w #$000C
	ldy.w #$000B
	jsr.w StartScrollList
	jsl.l SendTextMap
	rts
PrintPlayerStatsHeadings:			; Season Player Stats: the column headings (row 9) and the B hint (row
									; $18) for the list d0 is switching to: goalies when d0 is 0, else players
	pea.w $559D
	pea.w $55BD
	lda.b d0
	bne .1
	pla
	pla
	pea.w $55AD
	pea.w $55D7
.1:									; A = $0240, A + $D3, Y = $0040, call ClearRAM7E, ...
	clc
	lda.w #$0240
	adc.b $D3
	ldy.w #$0040
	jsl.l ClearRAM7E
	clc
	lda.w #$0600
	adc.b $D3
	ldy.w #$0040
	jsl.l ClearRAM7E
	lda.w #$0018
	sta.b $CF
	ldy.w #$0009
	plx
	jsl.l PrintBoldLeft
	ldy.w #$0018
	plx
	jsl.l PrintBoldLeft
	jsl.l WaitTransfers
	rts
StandingsInput:						; the NHL Standings screen each frame (screen state 11): up / down / left
									; / right change the division or the stat (DrawStandings), start / select
									; back to the League Menu
	jsr.w ScrollListArrows
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$0014
	sta.w repeatdelayframes
.1:									; A = padchangeany, if a $0400 bit set go to .2, ...
	lda.w padchangeany
	bit.w #$0400
	bne .2
	bit.w #$0800
	bne .4
	bit.w #$0200
	bne .6
	bit.w #$0100
	bne .7
	bit.w #$3000
	bne .5
.rts:								; return
	rts
.2:									; A = d1, A + 1, if A < $0004 go to .3, A = $0000
	lda.b d1
	inc a
	cmp.w #$0004
	bcc .3
	lda.w #$0000
.3:									; d1 = A, Y = $03F0, A = $0200, call ClearTextMapAt, ...
	sta.b d1
	ldy.w #$03F0
	lda.w #$0200
	jsr.w ClearTextMapAt
	bra .10
.4:									; A = d1, A - 1, if the result >= 0 go to .3, A = $0003, ...
	lda.b d1
	dec a
	bpl .3
	lda.w #$0003
	bra .3
.5:									; call FadeOutWait, X = $77, call DeleteSprite, X = $79, ...
	jsl.l FadeOutWait
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	jmp.w SeasonOptions
.6:									; d0 - 1, if the result >= 0 go to .9, A = $0007, go to .8
	dec.b d0
	bpl .9
	lda.w #$0007
	bra .8
.7:									; A = d0, A + 1, if A < $0008 go to .8, A = $0000
	lda.b d0
	inc a
	cmp.w #$0008
	bcc .8
	lda.w #$0000
.8:									; d0 = A
	sta.b d0
.9:									; Y = $0270, call CODE_C5A80B
	ldy.w #$0270
	jsr.w CODE_C5A80B
.10:								; X = $77, call DeleteSprite, X = $79, call DeleteSprite, ...
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	jsl.l SendTextMap
	jsl.l WaitTransfers
	jmp.w DrawStandings
CODE_C5A80B:						; from StandingsInput
	lda.w #$01D0
ClearTextMapAt:						; clears Y bytes of the text map from offset A
	clc
	adc.b $D3
	jsl.l ClearRAM7E
	rts
GamesTodayInput:					; the Games Today screen each frame (screen state 7): its current step's
									; routine from DATA8_C5A81B
	ldx.b $89
	jmp (DATA8_C5A81B,x)
DATA8_C5A81B:						; jump table: the routine for each index
	dw GamesTodayKeys,ScrollGamesUp,ScrollGamesDown
GamesTodayKeys:						; Games Today step 0: left / right change the day d0, up / down the game
									; $85 (a scroll at the list's ends), B flips the game between user and
									; computer, start / select leave
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$0010
	sta.w repeatdelayframes
.1:									; A = padchangeany, if a $0200 bit set go to .6, ...
	lda.w padchangeany
	bit.w #$0200
	bne .6
	bit.w #$0100
	bne .7
	bit.w #$0800
	bne .8
	bit.w #$0400
	beq .2
	jmp.w .12
.2:									; if a $8000 bit set go to .3, if $3000 bits clear go to .rts, ...
	bit.w #$8000
	bne .3
	bit.w #$3000
	beq .rts
	jsl.l FadeOutWait
	jmp.w SeasonOptions
.rts:								; return
	rts
.3:									; A = SeasonDay, A and $00FF, if A = d0 go to .4, if carry set go to .rts
	lda.l SeasonDay
	and.w #$00FF
	cmp.b d0
	beq .4
	bcs .rts
.4:									; if not zero go to .5, X = $85, A = SRDayPlayed
	bne .5
	ldx.b $85
	lda.l SRDayPlayed
.loop:								; loop: A / 2, X - 1, if the result >= 0 go to .loop, ...
	lsr a
	dex
	bpl .loop
	bcs .rts
.5:									; A = d4, A + $85, push A, A and $0007, ...
	lda.b d4
	clc
	adc.b $85
	pha
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	sta.b tmp0
	pla
	lsr a
	lsr a
	lsr a
	tax
	lda.l SRUserGames,x
	eor.b tmp0
	sta.l SRUserGames,x
	jmp.w DrawGameMarks
.6:									; A = SeasonDay, A and $00FF, if A >= d0 go to .rts, d0 - 1, ...
	lda.l SeasonDay
	and.w #$00FF
	cmp.b d0
	bcs .rts
	dec.b d0
	jsr.w DrawDayGames
	jmp.w PrintGamesTodayDate
.7:									; A = d0, A * 2, X = A, if DATA8_C35F62,x = 0 go to .rts, ...
	lda.b d0
	asl a
	tax
	lda.l DATA8_C35F62,x
	beq .rts
	inc.b d0
	jsr.w DrawDayGames
	jmp.w PrintGamesTodayDate
.8:									; if $85 = 0 go to .rts, A - 1, $85 = A, if not zero go to .9, ...
	lda.b $85
	beq .rts
	dec a
	sta.b $85
	bne .9
	ldx.b a4
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
.9:									; A = d3, A - $00E0, A and $03FF, d3 = A, ...
	sec
	lda.b d3
	sbc.w #$00E0
	and.w #$03FF
	sta.b d3
	ldx.b a0
	lda.b $08,x
	cmp.w #$0060
	beq .10
	lda.w #$0060
	sta.b $08,x
	rts
.10:								; X = $75, A = $22,x, A or $0001, $22,x = A, ...
	ldx.b $75
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	jsr.w DrawGameInSlot
	lda.b $81
	dec a
	bpl .11
	lda.w #$0002
.11:								; $81 = A, $89 = $0002
	sta.b $81
	lda.w #$0002
	sta.b $89
.rts2:								; return
	rts
.12:								; A = $85, A + 1, if A >= d2 go to .rts2, $85 = A, ...
	lda.b $85
	inc a
	cmp.b d2
	bcs .rts2
	sta.b $85
	inc a
	cmp.b d2
	bcc .13
	ldx.b $75
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	clc
.13:								; A = d3, A + $00E0, A and $03FF, d3 = A, ...
	lda.b d3
	adc.w #$00E0
	and.w #$03FF
	sta.b d3
	ldx.b a0
	lda.b $08,x
	cmp.w #$0098
	beq .14
	lda.w #$0098
	sta.b $08,x
	rts
.14:								; X = a4, A = $22,x, A or $0001, $22,x = A, ...
	ldx.b a4
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	jsr.w DrawGameInSlot
	lda.b $81
	inc a
	cmp.w #$0003
	bcc .15
	lda.w #$0000
.15:								; $81 = A, $89 = $0004, return
	sta.b $81
	lda.w #$0004
	sta.b $89
	rts
ScrollGamesUp:						; Games Today step 1: ScrollGamesUpLine twice a frame
	jsr.w ScrollGamesUpLine
ScrollGamesUpLine:					; one line of the scroll to the game above: BG2 scroll - 1, the scroll
									; HDMA counts and values moved, the entering game's colours queued; step 0
									; again at the end
	dec.w BG2VScroll
	lda.w BG3ScrollHDMA+$3
	and.w #$00FF
	cmp.w #$0038
	bne .1
	lda.w BandScroll+$2
	dec a
	sta.w BandScroll+$4
	lda.w BandScroll
	dec a
	sta.w BandScroll+$2
	clc
	lda.w BandScroll+$10
	adc.w #$00A7
	sta.w BandScroll
	sep #$20
	lda.b #$01
	sta.w BG3ScrollHDMA+$3
	lda.b #$38
	sta.w BG3ScrollHDMA+$6
	dec a
	sta.w BG3ScrollHDMA+$9
	rep #$20
	rts
.1:									; BandScroll - 1, BandScroll+$2 - 1, BandScroll+$4 - 1, ...
	dec.w BandScroll
	dec.w BandScroll+$2
	dec.w BandScroll+$4
	cmp.w #$0028
	bne .3
	pha
	lda.b $85
	lsr a
	ldx.w #$0020
	bcc .2
	ldx.w #$0040
.2:									; A = $8D, A and $00FF, call QueueTeamPalette, pull A
	lda.b $8D
	and.w #$00FF
	jsr.w QueueTeamPalette
	pla
.3:									; if A is not $0010 go to .5, push A, A = $85, A / 2, ...
	cmp.w #$0010
	bne .5
	pha
	lda.b $85
	lsr a
	ldx.w #$0030
	bcc .4
	ldx.w #$0050
.4:									; A = $8E, A and $00FF, call QueueTeamPalette, pull A
	lda.b $8E
	and.w #$00FF
	jsr.w QueueTeamPalette
	pla
.5:									; A 8-bit, A + 1, BG3ScrollHDMA+$3 = A, A = BG3ScrollHDMA+$9, ...
	sep #$20
	inc a
	sta.w BG3ScrollHDMA+$3
	lda.w BG3ScrollHDMA+$9
	dec a
	bne .6
	lda.b #$37
	sta.w BG3ScrollHDMA+$6
	rep #$20
	lda.w BandScroll+$4
	sta.w BandScroll+$10
	lda.w BandScroll+$2
	sta.w BandScroll+$4
	stz.b $89
	rts
.6:									; BG3ScrollHDMA+$9 = A, A 16-bit, return
	sta.w BG3ScrollHDMA+$9
	rep #$20
	rts
ScrollGamesDown:					; Games Today step 2: ScrollGamesDownLine twice a frame
	jsr.w ScrollGamesDownLine
ScrollGamesDownLine:				; one line of the scroll to the game below: BG2 scroll + 1, the scroll
									; HDMA counts and values moved, the entering game's colours queued; step 0
									; again at the end
	inc.w BG2VScroll
	sep #$20
	lda.w BG3ScrollHDMA+$3
	dec a
	beq .7
	sta.w BG3ScrollHDMA+$3
	cmp.b #$28
	bne .2
	rep #$20
	lda.b $85
	lsr a
	ldx.w #$0020
	bcc .1
	ldx.w #$0040
.1:									; A = $8D, A and $00FF, call QueueTeamPalette, A 8-bit, ...
	lda.b $8D
	and.w #$00FF
	jsr.w QueueTeamPalette
	sep #$20
	bra .4
.2:									; if A is not $10 go to .4, A 16-bit, A = $85, A / 2, ...
	cmp.b #$10
	bne .4
	rep #$20
	lda.b $85
	lsr a
	ldx.w #$0030
	bcc .3
	ldx.w #$0050
.3:									; A = $8E, A and $00FF, call QueueTeamPalette, A 8-bit
	lda.b $8E
	and.w #$00FF
	jsr.w QueueTeamPalette
	sep #$20
.4:									; if $38 = BG3ScrollHDMA+$6 go to .5, BG3ScrollHDMA+$6 = A, go to .6
	lda.b #$38
	cmp.w BG3ScrollHDMA+$6
	beq .5
	sta.w BG3ScrollHDMA+$6
	bra .6
.5:									; BG3ScrollHDMA+$9 + 1
	inc.w BG3ScrollHDMA+$9
.6:									; A 16-bit, A = BandScroll+$10, A + 1, BandScroll+$4 = A, ...
	rep #$20
	lda.w BandScroll+$10
	inc a
	sta.w BandScroll+$4
	sta.w BandScroll+$10
	inc.w BandScroll
	inc.w BandScroll+$2
	rts
.7:									; BG3ScrollHDMA+$3 = $38, A - 1, BG3ScrollHDMA+$6 = A, ...
	lda.b #$38
	sta.w BG3ScrollHDMA+$3
	dec a
	sta.w BG3ScrollHDMA+$6
	lda.b #$01
	sta.w BG3ScrollHDMA+$9
	rep #$20
	sec
	lda.w BandScroll
	sbc.w #$00A7
	sta.w BandScroll+$10
	lda.w BandScroll+$2
	inc a
	sta.w BandScroll
	lda.w BandScroll+$4
	inc a
	sta.w BandScroll+$2
	sta.w BandScroll+$4
	stz.b $89
	rts
DrawGameInSlot:						; draws game $85 for a scroll: its marks (DrawGameMarks), $8D / $8E its
									; two teams, the text of slot $81 cleared and both names printed
	jsr.w DrawGameMarks
	ldx.w #$0058
	stx.b $CF
	ldx.w #$00A0
	stx.b $D1
	lda.b $85
	asl a
	adc.b d1
	tax
	lda.l $C30001,x
	sta.b $8D
	lda.b $81
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
	lda.b $8D
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	phy
	jsl.l PrintThinCentred
	lda.b $8E
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	pla
	adc.w #$0003
	tay
	jsl.l PrintThinCentred
	jsl.l SendTextMap
	rts
PrintGamesTodayDate:				; prints day d0's date (MakeDateString) in italics on row 5, the row
									; cleared first
	lda.b $D3
	clc
	adc.w #$0140
	ldy.w #$0080
	jsl.l ClearRAM7E
	lda.b d0
	jsr.w MakeDateString
	lda.w #$0030
	sta.b $CF
	ldx.w #mesarea
	ldy.w #$0005
	jsl.l PrintItalicLeftStr
	jsl.l SendTextMap
	rts
NoGameSelectedInput:				; the A game must be selected warning each frame (screen state 12): start
									; / select back to the League Menu
	lda.w repeatdelayframes
	beq .1
.rts:								; return
	rts
.1:									; A = padchangeany, if $3000 bits clear go to .rts, go to SeasonOptions
	lda.w padchangeany
	bit.w #$3000
	beq .rts
	jmp.w SeasonOptions
StartSeasonInput:					; the season in progress question each frame (screen state 13): up / down
									; Continue Old / Start New; Continue Old goes to the League Menu, Start
									; New clears the season and goes back to the setup screen
	lda.w repeatdelayframes
	beq .1
	rts
.1:									; A = padchangeany, if a $3000 bit set go to .5, ...
	lda.w padchangeany
	bit.w #$3000
	bne .5
	bit.w #$0800
	bne .2
	bit.w #$0400
	bne .4
	rts
.2:									; A = $0015, call SetRowPalette0, A = $0018, call SetRowPalette3, ...
	lda.w #$0015
	jsr.w SetRowPalette0
	lda.w #$0018
	jsr.w SetRowPalette3
	lda.w #$00B5
.3:									; X = a0, $08,x = A, call SendTextMap, return
	ldx.b a0
	sta.b $08,x
	jsl.l SendTextMap
	rts
.4:									; A = $0015, call SetRowPalette3, A = $0018, call SetRowPalette0, ...
	lda.w #$0015
	jsr.w SetRowPalette3
	lda.w #$0018
	jsr.w SetRowPalette0
	lda.w #$00CD
	bra .3
.5:									; X = a0, pull Y, if $08,x is not $00B5 go to .6, go to EnterLeagueMenu
	ldx.b a0
	ply
	lda.b $08,x
	cmp.w #$00B5
	bne .6
	jmp.w EnterLeagueMenu
.6:									; X = a0, $05,x = $0008, $08,x = $008C, call ClearSeasonWarning, ...
	ldx.b a0
	lda.w #$0008
	sta.b $05,x
	lda.w #$008C
	sta.b $08,x
	jsr.w ClearSeasonWarning
	lda.w #$0007
	sta.w OptPlayMode
	jsr.w InitSetupScroll
	lda.w #$C000
	sta.w DMAEnShadow
	jsr.w CreateSetupArrows
	lda.w #$5CC1
	jsl.l DrawOptionList
	jmp.w GameSetUp_reenter
StartNewSeason:						; play mode 7 (Start New's Erase Team Rosters question): play mode Season,
									; the season data cleared (ClearSeasonData), then the League Menu
									; (EnterLeagueMenu)
	lda.w #$0002
	sta.w OptPlayMode
	jsl.l ClearSeasonData
	jmp.w EnterLeagueMenu
ClearSeasonWarning:					; clears the 10 text rows from row $10 (the season in progress warning),
									; then SendTextMap and WaitTransfers
	clc
	lda.w #$0400
	adc.b $D3
	ldy.w #$0280
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsl.l WaitTransfers
	rts
InitSetupScroll:					; the setup screen's scrolling:  $10=BG3ScrollHDMA1 copied to
									; BG3ScrollHDMA, the BandScroll words and the BG scrolls reset,
									; SetupLineRow = $10= $10
	lda.w #$001B
	ldx.w #$48E2
	ldy.w #BG3ScrollHDMA
	mvn $7E,$C0
	lda.w #$FFFF
	sta.w BandScroll
	sta.w BandScroll+$2
	sta.w BandScroll+$4
	sta.w BandScroll+$6
	sta.w BandScroll+$8
	sta.w BandScroll+$10
	stz.w BG1HScroll
	stz.w BG2HScroll
	stz.w BG3HScroll
	sta.w BG1VScroll
	sta.w BG3VScroll
	lda.w #$FFFA
	sta.w BG2VScroll
	lda.w #$FF90
	sta.w BandScroll+$A
	lda.w #$0010
	sta.w SetupLineRow
	rts
SeasonOptionsInput:					; the League Menu each frame (screen state 6): up / down move, B / start /
									; select run the item (SeasonMenuJumps), X leaves
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$000C
	sta.w repeatdelayframes
.1:									; A = padchangeany, if a $0800 bit set go to .4, ...
	lda.w padchangeany
	bit.w #$0800
	bne .4
	bit.w #$0400
	bne .6
	bit.w #$B000
	bne .2
	bit.w #$0040
	bne .3
.rts:								; return
	rts
.2:									; A = d6, A * 2, X = A, jump through SeasonMenuJumps,x
	lda.b d6
	asl a
	tax
	jmp (SeasonMenuJumps,x)
.3:									; call FadeOutWait, OptPlayMode = $0002, go to Restart
	jsl.l FadeOutWait
	lda.w #$0002
	sta.w OptPlayMode
	jmp.w Restart
.4:									; call LeagueItemPalette3, d6 - 1, if the result >= 0 go to .5, d6 = $0005
	jsr.w LeagueItemPalette3
	dec.b d6
	bpl .5
	lda.w #$0005
	sta.b d6
.5:									; call LeagueItemPalette0, call SendTextMap, go to PlaceLeagueCursor
	jsr.w LeagueItemPalette0
	jsl.l SendTextMap
	jmp.w PlaceLeagueCursor
.6:									; call LeagueItemPalette3, A = d6, A + 1, if A < $0006 go to .7, ...
	jsr.w LeagueItemPalette3
	lda.b d6
	inc a
	cmp.w #$0006
	bcc .7
	lda.w #$0000
.7:									; d6 = A, call LeagueItemPalette0, call SendTextMap, ...
	sta.b d6
	jsr.w LeagueItemPalette0
	jsl.l SendTextMap
	jmp.w PlaceLeagueCursor
SeasonMenuJumps:					; the routine of each League Menu item: Play Games, NHL Standings, Games
									; Today, League Leaders, Team Stats, Player Stats
	dw MenuPlayGames,StandingsScreen,GamesToday,LeagueLeadersScreen
	dw SeasonTeamStats,SeasonPlayerStats
LeagueItemPalette3:					; palette 3 on League Menu item d6 (LeagueItemPalette with $0C00)
	lda.w #$0C00
	sta.b tmp0
LeagueItemPalette:					; puts palette bits tmp0 on the 64 tiles of League Menu item d6 (from row
									; d6 * 3 + 6)
	lda.b d6
	asl a
	adc.b d6
	xba
	lsr a
	lsr a
	adc.b $D3
	tax
	ldy.w #$003F
.loop:								; loop: A = $0180,x, A and $E3FF, A or tmp0, $0180,x = A, ...
	lda.w $0180,x
	and.w #$E3FF
	ora.b tmp0
	sta.w $0180,x
	inx
	inx
	dey
	bpl .loop
	rts
LeagueItemPalette0:					; palette 0 on League Menu item d6 (LeagueItemPalette with 0)
	lda.w #$0000
	sta.b tmp0
	bra LeagueItemPalette
GamesToday:							; League Menu Games Today: the day's games (B marks a game, the pad
									; changes the day, start goes back to the League Menu)
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	lda.w OptPlayMode
	cmp.w #$0003
	bne .1
	jml.l PlayoffBracketScreen
.1:									; A = WonCheckTiles&$FFFF, X = WonCheckTiles>>16, ...
	lda.w #WonCheckTiles&$FFFF
	ldx.w #WonCheckTiles>>16
	jsl.l DecompressUnpackbuf
	ldy.w #$5C00
	jsl.l QueueClearVRAM
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0600
	pea.w $0130
	pea.w $007E
	pea.w $50DC
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0070
	pea.w $00C0
	pea.w $3EE2
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l WaitTransfers
	ldx.w #$0060
	jsl.l SetupHDMA
	db $40,$2C,$35,$4A,$C0,$7E		; inline parameters
	ldx.w #$0050
	jsl.l SetupHDMA
	db $42,$12,$8C,$46,$7E,$7E		; inline parameters
	ldx.w #$0040
	jsl.l SetupHDMA
	db $42,$10,$14,$49,$C0,$00		; inline parameters
	lda.w #$0015
	sta.w ScratchBuf
	lda.w #$0011
	sta.w ScratchBuf+$2
	sta.w ScratchBuf+$4
	lda.w #$001B
	ldx.w #$48FE
	ldy.w #BG3ScrollHDMA
	mvn $7E,$C0
	lda.w #$FFFF
	sta.w BandScroll
	sta.w BandScroll+$2
	sta.w BandScroll+$4
	sta.w BandScroll+$10
	lda.w #$FF2F
	sta.w BandScroll+$8
	lda.w #$FF4F
	sta.w BandScroll+$A
	lda.w #$FF2F
	sta.w BandScroll+$6
	lda.w #$F000
	sta.w DMAEnShadow
	lda.w #$00A7
	sta.b $18
	lda.w #$0046
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b a4
	lda.w #$0001
	jsl.l SetSpriteAnim
	lda.w #$00A4
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $75
	inc.b $38,x
	lda.w #$0002
	jsl.l SetSpriteAnim
	ldx.b a0
	lda.w #$002D
	sta.b $05,x
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$568E
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	lda.l SeasonDay
	and.w #$00FF
	sta.b d0
	lda.w #$0002
	sta.b $81
	stz.b $89
	jsr.w DrawDayGames
	jsr.w PrintGamesTodayDate
	lda.w #$0007
	sta.b $99
	stz.w fadestep
	rts
CODE_C5ADD8:						; called from other segments
	bit.b tmp0
	bpl NoGameSelected
ReturnToLeagueMenu:					; drops a return address, rebuilds the setup screen (setoptions), then
									; EnterLeagueMenu: the end of a season or playoff day
	pla
	jsr.w setoptions
	jmp.w EnterLeagueMenu
NoGameSelected:						; the warning A game must be selected. / Okay (screen state 12)
	lda.b $D3
	clc
	adc.w #$0180
	ldy.w #$0580
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.w #$2C00
	sta.b $D5
	lda.w #$0032
	sta.b $CF
	ldx.w #$47A1
	ldy.w #$0008
	jsl.l PrintItalicLeft
	ldy.w #$000A
	ldx.w #$47AB
	jsl.l PrintItalicLeft
	lda.w #$2000
	sta.b $D5
	lda.w #$006E
	sta.b $CF
	ldy.w #$000E
	ldx.w #$47B3
	jsl.l PrintItalicLeft
	jsl.l SendTextMap
	ldx.b a0
	lda.w #$0064
	sta.b $05,x
	lda.w #$007E
	sta.b $08,x
	lda.w #$000C
	sta.b $99
	rts
DATA8_C5AE40:						; not traced: data between routines
	db $FF,$FE,$FC,$F8,$F0,$E0,$C0,$80
MenuPlayGames:						; League Menu Play Games: when the season is over (play mode 3), the end
									; of season (BuildPlayoffDay); else the day's games from the schedule
	stz.b tmp0
	lda.w OptPlayMode
	cmp.w #$0003
	bne .1
	jml.l BuildPlayoffDay
.1:									; A = SeasonDay, A and $00FF, d0 = A, call DayFirstGame, ...
	lda.l SeasonDay
	and.w #$00FF
	sta.b d0
	jsr.w DayFirstGame
	lda.b d4
	and.w #$0007
	tax
	lda.b d4
	lsr a
	lsr a
	lsr a
	tay
	lda.w #$0002
	sta.w OptPlayMode
	lda.l SeasonDay
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C35F60,x
	bne .2
	jsl.l SetupPlayoffs
	inc.w OptPlayMode
	jmp.w ReturnToLeagueMenu
.2:									; A = d0, A * 2, X = A, A = DATA8_C360D4,x, ...
	lda.b d0
	asl a
	tax
	lda.l DATA8_C360D4,x
	tax
	lda.l $C30000,x
	and.w #$00FF
	sta.w DayGameCount
	sta.b tmp0
	pea.w $7E7F
	plb
	ldy.w #$8EF8
.loop:								; loop: A = $C30001,x, A and $00FF, $0002,y = A, A = $C30002,x, ...
	lda.l $C30001,x
	and.w #$00FF
	sta.w $0002,y
	lda.l $C30002,x
	and.w #$00FF
	sta.w $0004,y
	lda.w #$0000
	sta.w $0006,y
	sta.w $0008,y
	sta.w $000A,y
	phx
	lda.b d4
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	sta.b tmp1
	lda.b d4
	lsr a
	lsr a
	lsr a
	tax
	lda.l SRUserGames,x
	ldx.w #$0000
	and.b tmp1
	beq .3
	inx
.3:									; A = X, $0000,y = A, pull X, d4 + 1, ...
	txa
	sta.w $0000,y
	plx
	inc.b d4
	inx
	inx
	tya
	clc
	adc.w #$010A
	tay
	dec.b tmp0
	bne .loop
	lda.l SRDayPlayed
	beq FinishSeasonDay
	jsr.w RestoreDayScores
FinishSeasonDay:					; once no user game of the day is left: Please Wait, the computer games
									; simulated (SimDayScores, SimDayGameStats), the other scores shown, the
									; results and season stats saved, the season day + 1
	lda.l $7E2C42
	sta.b tmp0
	lda.w #$8EF8
	clc
.loop:								; loop: X = A, if $0000,x is not 0 go to .3, A = X, A + $010A, ...
	tax
	lda.w $0000,x
	bne .3
	txa
	adc.w #$010A
	dec.b tmp0
	bne .loop
	plb
	jsr.w ShowPleaseWait
	jsr.w SimDayScores
	jsr.w SimDayGameStats
	jsl.l ResetWorkBuf
	lda.w #$0001
	sta.w $190E
	stz.w $1910
	jsl.l ResetSprites
	jsr.w ShowOtherScores
	stz.w $190E
	jsl.l ResetTransferQueues
	lda.w OptPlayMode
	cmp.w #$0003
	bne .1
	jml.l RecordPlayoffDay
.1:									; call RecordDayResults, call SaveDayGameStats, A = SeasonDay, A + 1, ...
	jsr.w RecordDayResults
	jsr.w SaveDayGameStats
	lda.l SeasonDay
	inc a
	sta.l SeasonDay
	lda.w #$0000
	sta.l SRDayPlayed
	bit.w $1910
	bpl .2
	jmp.w ReturnToLeagueMenu
.2:									; go to MenuPlayGames
	jmp.w MenuPlayGames
.3:									; HomeTeam = $0004,x, A = $0002,x, VisTeam = A, $2C44 = X, ...
	lda.w $0004,x
	sta.l HomeTeam
	lda.w $0002,x
	plb
	sta.w VisTeam
	stx.w $2C44
	jsl.l ResetTransferQueues
	jsl.l ResetWorkBuf
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	wai
	jsr.w SetupScreen
	jsl.l ResetSprites
	lda.w #$FFFA
	sta.w BG2VScroll
	jsr.w DrawSetupTeams
	sep #$20
	lda.b #$17
	sta.l TM
	rep #$20
	stz.b a0
	stz.b a4
	stz.b $75
	pla
	jmp.w StartExhibition

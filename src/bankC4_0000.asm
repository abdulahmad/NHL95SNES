; Segment bankC4_0000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C40000
PlayoffBracketScreen:				; the playoff bracket screen (GamesToday in play mode 3): the pad moves
									; the cursor over the series, the face buttons and L / R mark one, start
									; or select goes back to the League Menu
	jsr.w SetupPlayoffBracket
.1:									; call WaitTransfers, call ReadMenuPads, $26 + 1, ...
	jsl.l WaitTransfers
	jsl.l ReadMenuPads
	inc.b $26
	lda.w repeatdelayframes
	beq .2
	cmp.w #$0012
	bcc .9
	lda.w #$0007
	sta.w repeatdelayframes
.2:									; a2 = padchangeany, if $0100 bits clear go to .3, ...
	lda.w padchangeany
	sta.b a2
	bit.w #$0100
	beq .3
	jsr.w BracketCursorRight
	lda.b a2
.3:									; if $0200 bits clear go to .4, call BracketCursorLeft, A = a2
	bit.w #$0200
	beq .4
	jsr.w BracketCursorLeft
	lda.b a2
.4:									; if $0800 bits clear go to .5, call BracketCursorUp, A = a2
	bit.w #$0800
	beq .5
	jsr.w BracketCursorUp
	lda.b a2
.5:									; if $0400 bits clear go to .6, call BracketCursorDown, A = a2
	bit.w #$0400
	beq .6
	jsr.w BracketCursorDown
	lda.b a2
.6:									; if $0F00 bits clear go to .7, call CODE_C40322, A = a2
	bit.w #$0F00
	beq .7
	jsr.w CODE_C40322
	lda.b a2
.7:									; if $C0F0 bits clear go to .8, call BracketMarkSeries, A = a2
	bit.w #$C0F0
	beq .8
	jsr.w BracketMarkSeries
	lda.b a2
.8:									; if $3000 bits clear go to .9, go to ExitPlayoffBracket
	bit.w #$3000
	beq .9
	jmp.w ExitPlayoffBracket
.9:									; call ScrollBracketToCursor, call CODE_C4077C, call AnimateSprites, ...
	jsr.w ScrollBracketToCursor
	jsr.w CODE_C4077C
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	jmp.w .1
BracketCursorRight:					; moves the bracket cursor one column right (a1, at most 6)
	lda.b a1
	inc a
	cmp.w #$0007
	bcs CODE_C40099
	sta.b a1
	lda.w $3D52
	inc a
	sta.w $3D52
	sta.w $3D5A
CODE_C40099:						; from BracketCursorRight, BracketCursorLeft
	rts
BracketCursorLeft:					; moves the bracket cursor one column left (a1, not below 0)
	lda.b a1
	beq CODE_C40099
	dec a
	sta.b a1
	lda.w $3D52
	dec a
	sta.w $3D52
	sta.w $3D5A
	rts
BracketMarkSeries:					; toggles the mark of the series under the bracket cursor ($2C46) when
									; both teams are known and it is not decided, and highlights its teams'
									; bars
	lda.w $3D52
	asl a
	tax
	lda.l DATA8_C41166,x
	tay
	asl a
	tax
	lda.w $3D5E,x
	ora.w $3D7C,x
	bmi .rts
	tyx
	lda.l $307865,x
	and.w #$00FF
	cmp.w #$0040
	bcs .rts
	and.w #$000F
	cmp.w #$0004
	bcs .rts
	tya
	asl a
	tax
	lda.w $2C46,x
	eor.w #$FFFF
	sta.w $2C46,x
	ldy.w $2C64,x
	phx
	jsr.w ToggleTeamBarHighlight
	plx
	ldy.w $2C82,x
	jsr.w ToggleTeamBarHighlight
	jmp.w CODE_C4062A
.rts:								; return
	rts
BracketCursorUp:					; moves the bracket cursor up a row ($69) by its column's step
									; (DATA8_C400FE)
	lda.b $69
	beq CODE_C40121
	lda.b a1
	asl a
	tax
	jmp (DATA8_C400FE,x)
DATA8_C400FE:						; jump table: the routine for each index
	dw BracketRowUp,CODE_C4011C,CODE_C40152,CODE_C40152
	dw CODE_C40152,CODE_C4011C,BracketRowUp
BracketRowUp:						; the bracket cursor one row up: $3D52 / $3D5A - 7, $69 - 1
	sec
	lda.w $3D52
	sbc.w #$0007
	sta.w $3D52
	sta.w $3D5A
	dec.b $69
	rts
CODE_C4011C:						; from DATA8_C400FE
	jsr.w BracketRowUp
	bra BracketCursorUp
CODE_C40121:						; from BracketCursorUp, BracketCursorDown
	rts
BracketCursorDown:					; moves the bracket cursor down a row ($69, below 3) by its column's step
									; (DATA8_C40130)
	lda.b $69
	cmp.w #$0003
	bcs CODE_C40121
	lda.b a1
	asl a
	tax
	jmp (DATA8_C40130,x)
DATA8_C40130:						; jump table: the routine for each index
	dw BracketRowDown,CODE_C4014D,CODE_C40152,CODE_C40152
	dw CODE_C40152,CODE_C4014D,BracketRowDown
BracketRowDown:						; the bracket cursor one row down: $3D52 / $3D5A + 7, $69 + 1
	inc.b $69
	lda.w $3D52
	adc.w #$0007
	sta.w $3D52
	sta.w $3D5A
	rts
CODE_C4014D:						; from DATA8_C40130
	jsr.w BracketRowDown
	bra BracketCursorDown
CODE_C40152:						; from DATA8_C400FE, DATA8_C40130
	rts
ExitPlayoffBracket:					; leaves the playoff bracket for the League Menu (SeasonOptions): the
									; screen reset for it
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	jsl.l WaitTransfers
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$1B,$49,$C0,$00		; inline parameters
	lda.w #BlueColoursHook&$FFFF
	ldx.w #BlueColoursHook>>16
	jsl.l SetNMIHook
	jsl.l CODE_C5E50E
	lda.w #$001C
	jsl.l CreateSprite
	stx.b a0
	lda.w #$00D7
	sta.b $18
	lda.w #$00D0
	sta.b $1A
	lda.w #$0020
	jsl.l CreateSprite
	phd
	lda.w #$2100
	tcd
	stz.b W12SEL&$FF
	stz.b WOBJSEL&$FF
	stz.b WBGLOG&$FF
	stz.b TMW&$FF
	stz.b CGWSEL&$FF
	pld
	stz.w BG2HScroll
	ldy.w #$0000
	jsl.l QueueClearVRAM
	ldy.w #$5000
	jsl.l ClearVRAM
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
	jsl.l WaitTransfers
	stz.w fadestep
	jml.l SeasonOptions
BuildPlayoffDay:					; the day's playoff game records from the series still running (marked
									; ones for the user), then FinishSeasonDay; with none left
									; StanleyCupScreen, SeasonAwards and Reset
	lda.w #$0000
	sta.l $306051
	jsl.l ResetWorkBuf
	jsr.w CODE_C409E3
	pea.w $7E7F
	plb
	ldy.w #$8EF8
	ldx.w #$001E
	stz.b tmp0
.loop:								; loop: $0004,y = $7E3D5E,x, if the result < 0 go to .2, A = X, ...
	lda.l $7E3D5E,x
	sta.w $0004,y
	ora.l $7E3D7C,x
	bmi .2
	txa
	stx.b tmp1
	lsr a
	tax
	sta.w $0038,y
	lda.l $307865,x
	ldx.b tmp1
	and.w #$00FF
	cmp.w #$0040
	bcs .2
	and.w #$000F
	cmp.w #$0004
	bcs .2
	inc.b tmp0
	lda.l $7E3D7C,x
	sta.w $0002,y
	lda.w #$0000
	sta.w $0006,y
	sta.w $0008,y
	sta.w $000A,y
	sta.w $0000,y
	lda.l $7E2C46,x
	beq .1
	lda.w #$0001
	sta.w $0000,y
.1:									; A = Y, A + $010A, Y = A
	tya
	clc
	adc.w #$010A
	tay
.2:									; X - 1, X - 1, if the result >= 0 go to .loop, if tmp0 = 0 go to .3, ...
	dex
	dex
	bpl .loop
	lda.b tmp0
	beq .3
	sta.l $7E2C42
	jml.l FinishSeasonDay
.3:									; A = $0004, call PlayoffTeamAtRound, push A, A = $0003, ...
	plb
	lda.w #$0004
	jsr.w PlayoffTeamAtRound
	pha
	lda.w #$0003
	jsr.w PlayoffTeamAtRound
	tax
	pla
	jsl.l StanleyCupScreen
	jsl.l SeasonAwards
	jml.l Reset
PlayoffTeamAtRound:					; A = the playoff team whose round ($307874) is A, from the team list at
									; $3075A4
	sep #$20
	ldx.w #$0010
.loop:								; loop: X - 1, if A is not $307874,x go to .loop, A = $3075A4,x, ...
	dex
	cmp.l $307874,x
	bne .loop
	lda.l $3075A4,x
	rep #$20
	and.w #$00FF
	rts
RecordPlayoffDay:					; adds each of the day's playoff results to its series wins at $307865 (+1
									; home, +$10 away; a series starts at 3-3 when $30604D is 0) and moves a
									; team that reaches 4 wins on a round, then the playoff day + 1
	lda.w $2C42
	sta.b tmp0
	pea.w $7E7F
	plb
	ldy.w #$8EF8
.1:									; X = $0038,y, A 8-bit, if $30604D is not 0 go to .2, $307865,x = $33
	ldx.w $0038,y
	sep #$20
	lda.l $30604D
	bne .2
	lda.b #$33
	sta.l $307865,x
.2:									; A 16-bit, if carry clear go to .3, A = $0001
	rep #$20
	lda.w $000A,y
	cmp.w $0008,y
	lda.w #$0010
	bcc .3
	lda.w #$0001
	clc
.3:									; A 8-bit, A + $307865,x, $307865,x = A, if A < $0040 go to .4, ...
	sep #$20
	adc.l $307865,x
	sta.l $307865,x
	rep #$21
	cmp.w #$0040
	bcc .4
	lda.w $0002,y
	jsr.w AdvancePlayoffTeam
	bra .5
.4:									; A and $000F, if A < $0004 go to .5, A = $0004,y, call AdvancePlayoffTeam
	and.w #$000F
	cmp.w #$0004
	bcc .5
	lda.w $0004,y
	jsr.w AdvancePlayoffTeam
.5:									; A = Y, A + $010A, Y = A, tmp0 - 1, ...
	tya
	adc.w #$010A
	tay
	dec.b tmp0
	bne .1
	plb
	jsr.w CODE_C40CB3
	lda.l $3075B4
	inc a
	sta.l $3075B4
	jml.l CODE_C5ADDC
AdvancePlayoffTeam:					; the playoff team A one round on ($307874 + 1 in its slot of the list at
									; $3075A4)
	sep #$20
	ldx.w #$000F
.loop:								; loop: if A = $3075A4,x go to .1, X - 1, ...
	cmp.l $3075A4,x
	beq .1
	dex
	bpl .loop
	rep #$21
	rts
.1:									; A = $307874,x, A + 1, $307874,x = A, return
	lda.l $307874,x
	inc a
	sta.l $307874,x
	rep #$21
	rts
CODE_C40322:						; from PlayoffBracketScreen, SetupPlayoffBracket
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.w $3D52
	asl a
	tax
	lda.l DATA8_C41166,x
	tax
	lda.l $307865,x
	tay
	and.w #$000F
	xba
	lsr a
	lsr a
	adc.w #$02A0
	adc.b $D3
	sta.b tmp0
	tya
	and.w #$00F0
	asl a
	asl a
	adc.w #$02A0
	adc.b $D3
	sta.b tmp1
	txa
	asl a
	tax
	pea.w $0080
	pea.w $5F00
	pea.w $007E
	lda.b $D3
	adc.w #$0700
	pha
	ldy.w #$000A
	lda.w $3D5E,x
	bpl .1
	lda.b $D3
	adc.w #$03E0
	ldy.w #$0014
	bra .2
.1:									; A / 2, A / 2, A + $D3
	xba
	lsr a
	lsr a
	adc.b $D3
.2:									; push Y, push A, Y = $000A, if $3D7C,x >= 0 go to .3, ...
	pea.w $0006
	pea.w $5F09
	pea.w $007E
	pei ($9F)
	phy
	pea.w $5F04
	pea.w $007E
	pha
	ldy.w #$000A
	lda.w $3D7C,x
	bpl .3
	lda.b $D3
	adc.w #$03E0
	ldy.w #$0014
	bra .4
.3:									; A / 2, A / 2, A + $D3
	xba
	lsr a
	lsr a
	adc.b $D3
.4:									; push Y, push A, A = $00, $00 = X, ...
	pea.w $0006
	pea.w $5F29
	pea.w $007E
	pei ($A1)
	phy
	pea.w $5F24
	pea.w $007E
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rts
ScrollBracketToCursor:				; moves the bracket's scroll position ($65) toward the cursor column's
									; (DATA8_C40FF8): one step when near, a larger one when far, the map
									; columns queued
	lda.b a1
	asl a
	tax
	sec
	lda.l DATA8_C40FF8,x
	sbc.b $65
	beq .4
	sta.b tmp0
	bpl .1
	eor.w #$FFFF
	inc a
.1:									; if A >= $0008 go to .2, A = $0001, if plus go to .3, A = $FFFF, ...
	cmp.w #$0008
	bcs .2
	lda.w #$0001
	bit.b tmp0
	bpl .3
	lda.w #$FFFF
	bra .3
.2:									; A = tmp0, A / 2, A / 2, A / 2, ...
	lda.b tmp0
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq .3
	ora.w #$E000
.3:									; A + $65, $65 = A
	clc
	adc.b $65
	sta.b $65
.4:									; if BG2HScroll is not $65 go to .5, return
	lda.w BG2HScroll
	cmp.b $65
	bne .5
	rts
.5:									; A and $FFF8, tmp1 = A, A = $65, A and $FFF8, ...
	and.w #$FFF8
	sta.b tmp1
	lda.b $65
	sec
	and.w #$FFF8
	sbc.b tmp1
	bpl .6
	eor.w #$FFFF
	inc a
	lsr a
	lsr a
	lsr a
	beq .7
	sta.b tmp1
.loop:								; loop: a0 - 1, tmp0 = 0, call CODE_C4064B, tmp1 - 1, ...
	dec.b a0
	stz.b tmp0
	jsr.w CODE_C4064B
	dec.b tmp1
	bne .loop
	bra .7
.6:									; A / 2, A / 2, A / 2, if the result = 0 go to .7, ...
	lsr a
	lsr a
	lsr a
	beq .7
	sta.b tmp1
.loop2:								; loop: a0 + 1, tmp0 = $0020, call CODE_C4064B, tmp1 - 1, ...
	inc.b a0
	lda.w #$0020
	sta.b tmp0
	jsr.w CODE_C4064B
	dec.b tmp1
	bne .loop2
.7:									; BG2HScroll = $65, return
	lda.b $65
	sta.w BG2HScroll
	rts
SetupPlayoffBracket:				; sets up the playoff bracket screen: the bracket and the team name bar
									; map sets, the titles and the teams' bars, the bracket drawn
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	lda.w #DarkBlueColoursHook&$FFFF
	ldx.w #DarkBlueColoursHook>>16
	jsl.l SetNMIHook
	wai
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$A8,$49,$C0,$00		; inline parameters
	ldx.w #$0060
	jsl.l SetupHDMA
	db $44,$26,$EA,$0F,$C4,$7E		; inline parameters
	ldx.w #$0050
	jsl.l SetupHDMA
	db $44,$26,$F1,$0F,$C4,$7E		; inline parameters
	ldy.w #$5C00
	jsl.l QueueClearVRAM
	ldx.b a0
	jsl.l DeleteSprite
	stz.b a0
	jsl.l RefreshSpritesLong
	jsl.l ResetWorkBuf
	lda.w #PlayoffBracketMap&$FFFF
	ldx.w #PlayoffBracketMap>>16
	jsl.l MapSetToUnpackbuf
	ldx.w #$15DE
	clc
.loop:								; loop: A = $50DC,x, A + $2A30, $7F9C7A,x = A, X - 1, ...
	lda.w $50DC,x
	adc.w #$2A30
	sta.l $7F9C7A,x
	dex
	dex
	bpl .loop
	stz.w BG2HScroll
	stz.b $65
	stz.b a1
	stz.b $69
	lda.w #$FFFF
	sta.w BG2VScroll
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0D40
	pea.w $2300
	pea.w $007E
	pea.w $66BC
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0020
	pea.w $007E
	pea.w $73FC
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l WaitTransfers
	lda.w #TeamNameBarsMap&$FFFF
	ldx.w #TeamNameBarsMap>>16
	jsl.l MapSetToUnpackbuf
	lda.w #$04E0
	jsl.l AllocWorkBuf
	jsl.l MarkWorkBuf
	ldx.w #$04DE
.loop2:								; loop: A = $50DC,x, A or $3400, $50DC,x = A, X - 1, ...
	lda.w $50DC,x
	ora.w #$3400
	sta.w $50DC,x
	dex
	dex
	bpl .loop2
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $3980
	pea.w $0000
	pea.w $007E
	pea.w $55BC
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0040
	pea.w $0040
	pea.w $007E
	pea.w $8F3C
	ldx.w #$001E
.loop3:								; loop: A = $8F3C,x, A / 2, A and $BDEF, $8F5C,x = A, ...
	lda.w $8F3C,x
	lsr a
	and.w #$BDEF
	sta.w $8F5C,x
	dex
	dex
	bpl .loop3
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsr.w CODE_C409E3
	stz.b a0
	phd
	lda.w #$2100
	tcd
	stz.b W12SEL&$FF
	lda.w #$00A0
	sta.b WOBJSEL&$FF
	stz.b WBGLOG&$FF
	lda.w #$1717
	sta.b TMW&$FF
	lda.w #$0310
	sta.b CGWSEL&$FF
	sep #$20
	lda.b #$E8
	sta.b COLDATA&$FF
	rep #$20
	pld
	jsl.l InitTextMap
	ldx.w #$4777
	ldy.w #$0001
	stz.b $CF
	lda.w #$0100
	sta.b $D1
	jsl.l PrintBoldCentred
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.l $30604D
	and.w #$00FF
	beq .2
	lda.w #$001A
	sta.b tmp0
.loop4:								; loop: A = tmp0, A * 2, X = A, A = $C30000,x, ...
	lda.b tmp0
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
.1:									; call UnpackText, Y = tmp0, call PrintBoldLeftStr, tmp0 - 1, ...
	jsl.l UnpackText
	ldy.b tmp0
	jsl.l PrintBoldLeftStr
	dec.b tmp0
	bpl .loop4
	lda.w #$0080
	sta.b $CF
	lda.w #$000A
	sta.b tmp0
	lda.w #$0000
.loop5:								; loop: tmp1 = A, call BCDTextLong, Y = tmp0, X = mesarea, ...
	sta.b tmp1
	jsl.l BCDTextLong
	ldy.b tmp0
	ldx.w #mesarea
	jsl.l PrintBoldLeftStr
	inc.b tmp0
	lda.b tmp1
	inc a
	cmp.w #$0005
	bcc .loop5
	ldy.b tmp0
	ldx.w #$4781
	jsl.l PrintBoldLeft
.2:									; X = $001C
	ldx.w #$001C
.loop6:								; loop: if $2C46,x >= 0 go to .3, Y = $2C64,x, push X, ...
	lda.w $2C46,x
	bpl .3
	ldy.w $2C64,x
	phx
	jsr.w ToggleTeamBarHighlight
	plx
	ldy.w $2C82,x
	phx
	jsr.w ToggleTeamBarHighlight
	plx
.3:									; X - 1, X - 1, if the result >= 0 go to .loop6, call CODE_C4062A, ...
	dex
	dex
	bpl .loop6
	wai
	jsr.w CODE_C4062A
	stz.w fadestep
	jmp.w CODE_C40322
CODE_C4062A:						; from SetupPlayoffBracket, BracketMarkSeries
	pei ($63)
	ldx.w #$0003
.loop:								; loop: push X, Y = $0008
	phx
	ldy.w #$0008
.loop2:								; loop: push Y, tmp0 = 0, call CODE_C4064B, a0 + 1, ...
	phy
	stz.b tmp0
	jsr.w CODE_C4064B
	inc.b a0
	ply
	dey
	bpl .loop2
	jsl.l WaitTransfers
	plx
	dex
	bpl .loop
	pla
	sta.b a0
	rts
CODE_C4064B:						; from CODE_C4062A, ScrollBracketToCursor
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	pea.w $0038
	pea.w $0081
	lda.b a0
	clc
	adc.b tmp0
	bit.w #$0020
	beq .1
	and.w #$001F
	ora.w #$5400
	bra .2
.1:									; A and $001F, A or $5000
	and.w #$001F
	ora.w #$5000
.2:									; push A, A = $0038, call AllocWorkBuf, push A, ...
	pha
	pea.w $1801
	pea.w $007E
	lda.w #$0038
	jsl.l AllocWorkBuf
	pha
	tay
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	clc
	lda.b a0
	adc.b tmp0
	asl a
	tax
	lda.w #$001B
	sta.b tmp0
.loop:								; loop: $0000,y = $7F9C7A,x, Y + 1, Y + 1, A = X, ...
	lda.l $7F9C7A,x
	sta.w $0000,y
	iny
	iny
	txa
	adc.w #$00C8
	tax
	dec.b tmp0
	bpl .loop
	rts
CheckCreateSlots:					; returns when one of the 20 created player slots is free; else the Alert
									; You have reached the maximum number of Created Players (ShowAlert)
	ldy.w #$0003
.loop:								; loop: call CODE_C406C4, if A = $0000 go to .rtl, A = Y, A + $009C, ...
	jsr.w CODE_C406C4
	cmp.w #$0000
	beq .rtl
	clc
	tya
	adc.w #$009C
	tay
	cpy.w #$0C30
	bcc .loop
	pea.w $5471
	bra ShowAlert
.rtl:								; return
	rtl
CODE_C406C4:						; from CheckCreateSlots
	tya
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	sta.b tmp0
	lda.l $307162,x
.loop:								; loop: A / 2, tmp0 - 1, if the result >= 0 go to .loop, A and $001F, ...
	lsr a
	dec.b tmp0
	bpl .loop
	rol a
	and.w #$001F
	rts
CheckTradesFrozen:					; returns when trading is open; when its save RAM flag is set: the Alert
									; All player trading has been frozen until the new season begins
									; (ShowAlert)
	lda.l $3075B4
	and.w #$00FF
	bne .1
	rtl
.1:									; continue
	pea.w $54B1
ShowAlert:							; prints the Alert page on the stack, waits for start / select, then goes
									; back to the setup screen (GameSetUp)
	jsl.l FadeOutWait
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l QueueClearVRAM
	ldy.w #$5C00
	jsl.l QueueClearVRAM
	lda.w #$FFFF
	sta.w BG3VScroll
	jsl.l WaitTransfers
	ldx.b d7
	jsl.l DeleteSprite
	stz.b d7
	ldx.b $9D
	jsl.l DeleteSprite
	stz.b $9D
	jsl.l CODE_C5A507
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	pla
	jsl.l PrintTextPage
	ldx.b a0
	lda.w #$FF80
	sta.b $05,x
	sta.b $08,x
	stz.w fadestep
	stz.w repeatdelayframes
	stz.w padchangeany
.loop:								; loop: call UpdateMenuSpritesTwice, call ReadMenuPads, ...
	jsl.l UpdateMenuSpritesTwice
	jsl.l ReadMenuPads
	lda.w repeatdelayframes
	bne .loop
	lda.w padchangeany
	bit.w #$3000
	beq .loop
	jsl.l FadeOutWait
	phb
	pla
	pla
	jml.l GameSetUp
GetShifter:							; called from other segments
	lda.w #$FFF0
	sta.b d2
	lda.w #$0010
	sta.b d1
	lda.w playoffRoundIdx
	tay
.loop:								; loop: A = d2, A + d1, d2 = A, d1 / 2, ...
	lda.b d2
	clc
	adc.b d1
	sta.b d2
	lsr.b d1
	dey
	bpl .loop
	dec.b d1
	rtl
CODE_C4077C:						; from PlayoffBracketScreen
	lda.b $26
	lsr a
	lda.w #$A000
	bcc .1
	lda.w #$C000
.1:									; DMAEnShadow = A, $364E = $00FF, $39CE = A, X = $364E, ...
	sta.w DMAEnShadow
	lda.w #$00FF
	sta.w $364E
	sta.w $39CE
	ldx.w #$364E
	ldy.w #$3650
	lda.w #$037D
	bcs .2
	ldx.w #$39CE
	ldy.w #$39D0
.2:									; X = $3D54, X + 1, X + 1, if $3D54 < $009E go to .3, ...
	mvn $7E,$7E
	ldx.w $3D54
	inx
	inx
	cpx.w #$009E
	bcc .3
	ldx.w #$0000
.3:									; $3D54 = X, Y = $3D52, call CODE_C4081B, A = DATA8_C41006,x, ...
	stx.w $3D54
	ldy.w $3D52
	jsr.w CODE_C4081B
	lda.l DATA8_C41006,x
	adc.b tmp0
	sec
	sbc.w BG2HScroll
	sta.b tmp0
	clc
	lda.b tmp1
	adc.l DATA8_C41076,x
	sta.b tmp1
	ldx.w #$3D4E
	jsr.w CODE_C40840
	ldx.w $3D4E
	ldy.w $3D50
	jsr.w CODE_C408B3
	ldx.w $3D5C
	inx
	inx
	cpx.w #$009E
	bcc .4
	ldx.w #$0000
.4:									; $3D5C = X, Y = $3D5A, call CODE_C4081B, A = DATA8_C4103E,x, ...
	stx.w $3D5C
	ldy.w $3D5A
	jsr.w CODE_C4081B
	lda.l DATA8_C4103E,x
	adc.b tmp0
	sec
	sbc.w BG2HScroll
	sta.b tmp0
	clc
	lda.b tmp1
	adc.l DATA8_C410AE,x
	sta.b tmp1
	ldx.w #$3D56
	jsr.w CODE_C40840
	ldx.w $3D56
	ldy.w $3D58
	jmp.w CODE_C408B3
CODE_C4081B:						; from CODE_C4077C
	lda.l DATA8_C40EF4,x
	tax
	ora.w #$FF00
	bit.w #$0080
	bne .1
	and.w #$00FF
.1:									; tmp0 = A, A = X, A or $FF00, if a $0080 bit set go to .2, ...
	sta.b tmp0
	txa
	xba
	ora.w #$FF00
	bit.w #$0080
	bne .2
	and.w #$00FF
.2:									; tmp1 = A, A = Y, A * 2, X = A, ...
	sta.b tmp1
	tya
	asl a
	tax
	rts
CODE_C40840:						; from CODE_C4077C
	sec
	lda.b tmp0
	sbc.w $0000,x
	sta.b tmp2
	bpl .1
	eor.w #$FFFF
	inc a
.1:									; if A >= $0010 go to .3, if A < $0002 go to .2, A = $0002
	cmp.w #$0010
	bcs .3
	cmp.w #$0002
	bcc .2
	lda.w #$0002
.2:									; if plus go to .4, A xor $FFFF, A + 1, go to .4
	bit.b tmp2
	bpl .4
	eor.w #$FFFF
	inc a
	bra .4
.3:									; A = tmp2, A / 2, A / 2, A / 2, ...
	lda.b tmp2
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq .4
	ora.w #$E000
.4:									; A + $0000,x, $0000,x = A, A = tmp1, A - $0002,x, ...
	clc
	adc.w $0000,x
	sta.w $0000,x
	sec
	lda.b tmp1
	sbc.w $0002,x
	sta.b tmp2
	bpl .5
	eor.w #$FFFF
	inc a
.5:									; if A >= $0010 go to .7, if A < $0002 go to .6, A = $0002
	cmp.w #$0010
	bcs .7
	cmp.w #$0002
	bcc .6
	lda.w #$0002
.6:									; if plus go to .8, A xor $FFFF, A + 1, go to .8
	bit.b tmp2
	bpl .8
	eor.w #$FFFF
	inc a
	bra .8
.7:									; A = tmp2, A / 2, A / 2, A / 2, ...
	lda.b tmp2
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq .8
	ora.w #$E000
.8:									; A + $0002,x, $0002,x = A, return
	clc
	adc.w $0002,x
	sta.w $0002,x
	rts
CODE_C408B3:						; from CODE_C4077C
	stx.b tmp0
	lda.b $26
	lsr a
	tya
	bcs .1
	adc.w #$00E0
.1:									; A * 2, A * 2, Y = A, X = $0054
	asl a
	asl a
	tay
	ldx.w #$0054
.2:									; if zero go to .6, A = DATA8_C40F94,x, A and $00FF, A + tmp0, ...
	lda.w $364E,y
	cmp.w #$00FF
	clc
	beq .6
	lda.l DATA8_C40F94,x
	and.w #$00FF
	adc.b tmp0
	bpl .3
	lda.w #$0000
.3:									; if A >= $0100 go to .10, A 8-bit, $3650,y = A, A = DATA8_C40F95,x, ...
	cmp.w #$0100
	bcs .10
	sep #$20
	sta.w $3650,y
	rep #$21
	lda.l DATA8_C40F95,x
	and.w #$00FF
	adc.b tmp0
	bpl .4
	lda.w #$00FF
	sta.w $3650,y
	bra .10
.4:									; if A < $0100 go to .5, A = $00FF
	cmp.w #$0100
	bcc .5
	lda.w #$00FF
.5:									; A 8-bit, $3651,y = A, A 16-bit, go to .10
	sep #$20
	sta.w $3651,y
	rep #$20
	bra .10
.6:									; A = DATA8_C40F94,x, A and $00FF, A + tmp0, ...
	lda.l DATA8_C40F94,x
	and.w #$00FF
	adc.b tmp0
	bpl .7
	lda.w #$0000
.7:									; if A >= $0100 go to .10, A 8-bit, $364E,y = A, A = DATA8_C40F95,x, ...
	cmp.w #$0100
	bcs .10
	sep #$20
	sta.w $364E,y
	rep #$21
	lda.l DATA8_C40F95,x
	and.w #$00FF
	adc.b tmp0
	bpl .8
	lda.w #$00FF
	sta.w $364E,y
	bra .10
.8:									; if A < $0100 go to .9, A = $00FF
	cmp.w #$0100
	bcc .9
	lda.w #$00FF
.9:									; A 8-bit, $364F,y = A, A 16-bit
	sep #$20
	sta.w $364F,y
	rep #$20
.10:								; A = Y, A + $0004, Y = A, X - 1, ...
	clc
	tya
	adc.w #$0004
	tay
	dex
	dex
	bmi .rts
	jmp.w .2
.rts:								; return
	rts
CODE_C40955:						; from CODE_C40999
	phb
	sta.b tmp0
	asl a
	adc.b tmp0
	asl a
	asl a
	asl a
	asl a
	adc.w #$50DC
	tax
	tya
	adc.w #$9C7A
	tay
	lda.w #$0017
	mvn $7F,$7E
	tya
	adc.w #$00B0
	tay
	lda.w #$0017
	mvn $7F,$7E
	plb
	rts
ToggleTeamBarHighlight:				; toggles the highlight of a team's name bar in the bracket map buffer:
									; palette bit $0400 of its two rows of 12 tiles
	clc
	tyx
	jsr.w ToggleTeamBarRow
	txa
	adc.w #$00B0
	tax
ToggleTeamBarRow:					; toggles palette bit $0400 of 12 tiles at X in the map buffer at $7F9C7A
	ldy.w #$000B
.loop:								; loop: A = $7F9C7A,x, A xor $0400, $7F9C7A,x = A, X + 1, ...
	lda.l $7F9C7A,x
	eor.w #$0400
	sta.l $7F9C7A,x
	inx
	inx
	dey
	bpl .loop
	rts
CODE_C40999:						; from CODE_C409E3
	ldx.w #$000F
.loop:								; loop: A = $3075A4,x, A and $00FF, tmp2 = A, A = $307874,x, ...
	lda.l $3075A4,x
	and.w #$00FF
	sta.b tmp2
	lda.l $307874,x
	and.w #$00FF
	cmp.w #$0004
	bcc .1
	lda.w #$0003
.1:									; $A5 = A, A = X, tmp1 = X, A * 2, ...
	sta.b $A5
	txa
	stx.b tmp1
	asl a
	asl a
	asl a
	tax
.loop2:								; loop: A = $C4119E,x, A * 2, Y = A, $3D5E,y = tmp2, ...
	lda.l $C4119E,x
	asl a
	tay
	lda.b tmp2
	sta.w $3D5E,y
	lda.l DATA8_C410E6,x
	sta.w $2C64,y
	tay
	lda.b tmp2
	phx
	jsr.w CODE_C40955
	plx
	inx
	inx
	dec.b $A5
	bpl .loop2
	ldx.b tmp1
	dex
	bpl .loop
	rts
CODE_C409E3:						; from BuildPlayoffDay, SetupPlayoffBracket
	jsl.l WaitTransfers
	lda.w #$364E
	ldy.w #$1000
	jsl.l ClearRAM7E
	dec.w $3D5E
	lda.w #$0040
	ldx.w #$3D5E
	txy
	iny
	mvn $7E,$7E
	jmp.w CODE_C40999
AddIntermissionGoals:				; in season and playoff play (OptPlayMode 2 / 3), adds a random 0-1 goals
									; to each team of each of the day's computer games not yet done
	lda.w OptPlayMode
	cmp.w #$0002
	beq .1
	cmp.w #$0003
	beq .1
	rtl
.1:									; tmp0 = $2C42, Y = $8EF8
	lda.w $2C42
	sta.b tmp0
	pea.w $7E7F
	plb
	ldy.w #$8EF8
.loop:								; loop: if $0000,y is not 0 go to .3, if $0006,y < 0 go to .3, ...
	lda.w $0000,y
	bne .3
	lda.w $0006,y
	bmi .3
	jsr.w CODE_C40A60
	adc.w $000A,y
	sta.w $000A,y
	jsr.w CODE_C40A60
	adc.w $0008,y
	sta.w $0008,y
	jsr.w CODE_C40A60
	cmp.w #$0014
	bcs .3
	cmp.w #$000A
	lda.w $0006,y
	adc.w #$0000
	cmp.w #$0002
	bcc .2
	lda.w #$0002
.2:									; $0006,y = A
	sta.w $0006,y
.3:									; A = Y, A + $010A, Y = A, tmp0 - 1, ...
	clc
	tya
	adc.w #$010A
	tay
	dec.b tmp0
	bne .loop
	plb
	rtl
CODE_C40A60:						; from AddIntermissionGoals
	lda.w #$0002
	pea.w $7F7E
	plb
	jsl.l RandomBelowA
	plb
	rts
AddGamePlayerStats:					; AddPlayerSeasonStats for both teams of game record Y (home, then away at
									; + $1A)
	tyx
	lda.l $7F0004,x
	sta.l $0017C9
	lda.l $7F0002,x
	sta.l $0017CB
	phy
	pea.w $7E7E
	plb
	plb
	jsl.l RestoreWorkBuf
	jsl.l LoadGameRostersLong
	ply
	phy
	ldx.w #$2DC9
	jsr.w AddPlayerSeasonStats
	pla
	clc
	adc.w #$001A
	tay
	ldx.w #$3207
	jsr.w AddPlayerSeasonStats
	rtl
AddPlayerSeasonStats:				; adds one team's game player stats to the season totals in save RAM:
									; skaters' goals and assists; for goalies who played, games + 1, goals
									; against and saves (shots minus goals)
	lda.w $0000,x
	sta.b $10
	lda.w $0002,x
	sta.b tmp2
	pea.w $7E7F
	plb
.1:									; $A5 = $7E003A,x, $0A = X, $0C = Y, tmp2 - 1, ...
	lda.l $7E003A,x
	sta.b $A5
	stx.b $0A
	sty.b $0C
	dec.b tmp2
	bpl .2
	jsl.l SeasonGoalsLong
	ldy.b $0C
	stx.b tmp0
	lda.w $003A,y
	and.w #$00FF
	clc
	adc.b tmp0
	tax
	lda.b $A5
	jsr.w SetSeasonGoals
	lda.b $A5
	jsl.l SeasonAssistsLong
	stx.b tmp0
	ldy.b $0C
	lda.w $006E,y
	and.w #$00FF
	clc
	adc.b tmp0
	tax
	lda.b $A5
	jsr.w SetSeasonAssists
	bra .3
.2:									; A = $003A,y, A or $00A2,y, if the result = 0 go to .3, A = $A5, ...
	lda.w $003A,y
	ora.w $00A2,y
	and.w #$00FF
	beq .3
	lda.b $A5
	jsl.l SeasonGoalieGamesLong
	inx
	lda.b $A5
	jsr.w SetSeasonGoalieGames
	lda.b $A5
	jsl.l SeasonGoalsAgainstLong
	ldy.b $0C
	lda.w $003A,y
	and.w #$00FF
	sta.b $0E
	clc
	txa
	adc.b $0E
	tax
	lda.b $A5
	jsr.w SetSeasonGoalsAgainst
	lda.b $A5
	jsl.l SeasonSavesLong
	stx.b tmp0
	ldy.b $0C
	lda.w $00A2,y
	and.w #$00FF
	sec
	sbc.b $0E
	clc
	adc.b tmp0
	tax
	lda.b $A5
	jsr.w SetSeasonSaves
.3:									; X = $0A, Y = $0C, X + 1, X + 1, ...
	ldx.b $0A
	ldy.b $0C
	inx
	inx
	iny
	dec.b $10
	beq .4
	jmp.w .1
.4:									; return
	plb
	rts
SetSeasonGoals:						; stores X as player A's season goals (9 bits at $30628F)
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	txy
	lsr a
	lsr a
	lsr a
	tax
	lda.b tmp0
	and.w #$0007
	sty.b tmp0
	tay
	lda.w #$FE00
	dey
	bmi .1
.loop:								; loop: tmp0 * 2, Y - 1, if the result >= 0 go to .loop
	asl.b tmp0
	sec
	rol a
	dey
	bpl .loop
.1:									; $16 = A, A = $30628F,x, A and $16, A or tmp0, ...
	sta.b $16
	lda.l $30628F,x
	and.b $16
	ora.b tmp0
	sta.l $30628F,x
	rts
SetSeasonAssists:					; stores X as player A's season assists (9 bits at $306724)
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	txy
	lsr a
	lsr a
	lsr a
	tax
	lda.b tmp0
	and.w #$0007
	sty.b tmp0
	tay
	lda.w #$FE00
	dey
	bmi .1
.loop:								; loop: tmp0 * 2, Y - 1, if the result >= 0 go to .loop
	asl.b tmp0
	sec
	rol a
	dey
	bpl .loop
.1:									; $16 = A, A = $306724,x, A and $16, A or tmp0, ...
	sta.b $16
	lda.l $306724,x
	and.b $16
	ora.b tmp0
	sta.l $306724,x
	rts
SetSeasonGoalieGames:				; stores X as goalie A's season games (7 bits at $307080 by its goalie
									; index)
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
	stx.b $16
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
	ldy.b tmp0
	lda.w #$FF80
	dey
	bmi .1
.loop2:								; loop: $16 * 2, Y - 1, if the result >= 0 go to .loop2
	asl.b $16
	sec
	rol a
	dey
	bpl .loop2
.1:									; tmp0 = A, A = $307080,x, A and tmp0, A or $16, ...
	sta.b tmp0
	lda.l $307080,x
	and.b tmp0
	ora.b $16
	sta.l $307080,x
	rts
SetSeasonGoalsAgainst:				; stores X as goalie A's season goals against ($306724 and $30628F)
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
	tay
	txa
	sta.b $14
	and.w #$0600
	lsr a
	lsr a
	sta.b $16
	lda.w #$FE7F
	sta.b $2E
	lda.w #$FE00
	sta.b r0
	trb.b $14
	lda.w #$FFF8
	trb.b tmp0
	tyx
	ldy.b tmp0
	dey
	bmi .1
.loop:								; loop: $16 * 2, $14 * 2, Y - 1, if the result >= 0 go to .loop
	asl.b $16
	asl.b $14
	sec
	rol.b r0
	sec
	rol.b $2E
	dey
	bpl .loop
.1:									; A = $30628F,x, A and $2E, A or $16, $30628F,x = A, ...
	lda.l $30628F,x
	and.b $2E
	ora.b $16
	sta.l $30628F,x
	lda.l $306724,x
	and.b r0
	ora.b $14
	sta.l $306724,x
	rts
SetSeasonSaves:						; stores X as goalie A's season saves (12 bits at $306FED by its goalie
									; index)
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
	txy
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
	bcc .1
	tya
	asl a
	asl a
	asl a
	asl a
	sta.b tmp0
	lda.l $306FED,x
	and.w #$000F
	ora.b tmp0
	sta.l $306FED,x
	rts
.1:									; tmp0 = Y, A = $306FED,x, A and $F000, A or tmp0, ...
	sty.b tmp0
	lda.l $306FED,x
	and.w #$F000
	ora.b tmp0
	sta.l $306FED,x
	rts
CODE_C40CB3:						; from RecordPlayoffDay
	lda.w $2C42
	sta.b tmp0
	pea.w $7E7F
	plb
	ldy.w #$8EF8
.loop:								; loop: push Y, A = $0004,y, call CODE_C40CE3, pull Y, ...
	phy
	lda.w $0004,y
	jsr.w CODE_C40CE3
	ply
	phy
	lda.w $0002,y
	tax
	tya
	clc
	adc.w #$001A
	tay
	txa
	jsr.w CODE_C40CE3
	ply
	clc
	tya
	adc.w #$010A
	tay
	dec.b tmp0
	bne .loop
	plb
	rts
CODE_C40CE3:						; from CODE_C40CB3
	ldx.w #$000F
	sep #$20
.loop:								; loop: if A = $3075A4,x go to .1, X - 1, ...
	cmp.l $3075A4,x
	beq .1
	dex
	bpl .loop
	inx
.1:									; A 16-bit, A = X, A * 2, X = A, ...
	rep #$20
	txa
	asl a
	tax
	lda.l DATA8_C40D76,x
	sta.b tmp2
	lda.w #$0018
	sta.b tmp1
.loop2:								; loop: A = $003A,y, A and $00FF, $A5 = A, A = $006E,y, ...
	lda.w $003A,y
	and.w #$00FF
	sta.b $A5
	lda.w $006E,y
	and.w #$00FF
	sta.b $0A
	lda.w #$FF80
	sta.b $0C
	eor.w #$FFFF
	sta.b $10
	lda.b tmp2
	lsr a
	lsr a
	lsr a
	tax
	lda.b tmp2
	and.w #$0007
	sta.b $0E
	dec.b $0E
	bmi .2
.loop3:								; loop: $A5 * 2, $0A * 2, $10 * 2, $0E - 1, ...
	asl.b $A5
	asl.b $0A
	sec
	rol.b $0C
	asl.b $10
	dec.b $0E
	bpl .loop3
.2:									; A = $3072E8,x, A and $10, A + $A5, $A5 = A, ...
	lda.l $3072E8,x
	and.b $10
	clc
	adc.b $A5
	sta.b $A5
	lda.l $3072E8,x
	and.b $0C
	ora.b $A5
	sta.l $3072E8,x
	lda.l $307446,x
	and.b $10
	clc
	adc.b $0A
	sta.b $0A
	lda.l $307446,x
	and.b $0C
	ora.b $0A
	sta.l $307446,x
	clc
	lda.b tmp2
	adc.w #$0007
	sta.b tmp2
	iny
	dec.b tmp1
	bpl .loop2
	rts
DATA8_C40D76:						; not traced: a table read by CODE_C40CE3
	db $00,$00,$AF,$00,$5E,$01,$0D,$02,$BC,$02,$6B,$03,$1A,$04,$C9,$04
	db $78,$05,$27,$06,$D6,$06,$85,$07,$34,$08,$E3,$08,$92,$09,$41,$0A
SetupPlayoffs:						; starts the playoffs once the schedule has no more games: the marks
									; cleared and the 16 playoff teams chosen into the list at $3075A4 (once,
									; while it is empty)
	lda.l $3075A4
	bne .rtl
	lda.w #$2C46
	ldy.w #$0078
	jsl.l ClearRAM7E
	jsl.l RestoreWorkBuf
	jsl.l CODE_C5E37E
	lda.w #$0002
	sta.b tmp0
	jsr.w CODE_C40E45
	jsr.w CODE_C40E3A
	ldx.w #$0004
	bit.w #$0004
	bne .1
	ldx.w #$0008
.1:									; tmp0 = X, call CODE_C40E14, call CODE_C40E2D, r0 = $75A4, ...
	stx.b tmp0
	jsr.w CODE_C40E14
	jsr.w CODE_C40E2D
	lda.w #$75A4
	sta.b r0
	lda.w #$0030
	sta.b $2E
	jsr.w CODE_C40DFB
	lda.w #$0001
	sta.b tmp0
	jsr.w CODE_C40E45
	jsr.w CODE_C40E3A
	ldx.w #$0010
	bit.w #$0010
	bne .2
	ldx.w #$0020
.2:									; tmp0 = X, call CODE_C40E14, call CODE_C40E2D, call CODE_C40DFB
	stx.b tmp0
	jsr.w CODE_C40E14
	jsr.w CODE_C40E2D
	jsr.w CODE_C40DFB
.rtl:								; return
	rtl
CODE_C40DFB:						; from SetupPlayoffs
	sep #$20
	ldy.w #$000E
.loop:								; loop: X = $364E,y, [r0] = $000C,x, X = r0, X + 1, ...
	ldx.w $364E,y
	lda.w $000C,x
	sta.b [r0]
	ldx.b r0
	inx
	stx.b r0
	dey
	dey
	bpl .loop
	rep #$20
	rts
CODE_C40E14:						; from SetupPlayoffs
	ldy.w #$000C
.loop:								; loop: X = $364E,y, A = $000C,x, X = A, A = DATA8_C40EDA,x, ...
	ldx.w $364E,y
	lda.w $000C,x
	tax
	lda.l DATA8_C40EDA,x
	bit.b tmp0
	bne .rts
	dey
	dey
	bpl .loop
	iny
	iny
.rts:								; return
	rts
CODE_C40E2D:						; from SetupPlayoffs
	lda.w $365A
	ldx.w $364E,y
	sta.w $364E,y
	stx.w $365A
	rts
CODE_C40E3A:						; from SetupPlayoffs
	ldy.w $365C
	ldx.w $000C,y
	lda.l DATA8_C40EDA,x
	rts
CODE_C40E45:						; from SetupPlayoffs
	jsr.w CODE_C40ECA
	ldy.b $81
.loop:								; loop: X = $000C,y, A = DATA8_C40EDA,x, if tmp0 bits clear go to .1, ...
	ldx.w $000C,y
	lda.l DATA8_C40EDA,x
	bit.b tmp0
	beq .1
	jsr.w CODE_C40E5F
.1:									; A = $0002,y, Y = A, if the result is not 0 go to .loop, return
	lda.w $0002,y
	tay
	bne .loop
	rts
CODE_C40E5F:						; from CODE_C40E45
	ldx.w #$000E
.1:									; if $364E,x = 0 go to .2, tmp1 = X, X = A, call CODE_C40E8D, ...
	lda.w $364E,x
	beq .2
	stx.b tmp1
	tax
	jsr.w CODE_C40E8D
	bcs .3
	sty.b tmp2
	ldy.w #$364E
	ldx.w #$3650
	lda.b tmp1
	inc a
	mvn $7E,$7E
	ldy.b tmp2
	ldx.b tmp1
.2:									; A = Y, $364E,x = A, return
	tya
	sta.w $364E,x
	rts
.3:									; X = tmp1, X - 1, X - 1, if the result >= 0 go to .1, ...
	ldx.b tmp1
	dex
	dex
	bpl .1
	rts
CODE_C40E8D:						; from CODE_C40E5F
	lda.w $000A,x
	cmp.w $000A,y
	beq .1
	rts
.1:									; if $0004,x = $0004,y go to .2, return
	lda.w $0004,x
	cmp.w $0004,y
	beq .2
	rts
.2:									; if $0008,x = $0008,y go to .3, return
	lda.w $0008,x
	cmp.w $0008,y
	beq .3
	rts
.3:									; if $000E,x = $000E,y go to .4, return
	lda.w $000E,x
	cmp.w $000E,y
	beq .4
	rts
.4:									; if $002A,y = $002A,x go to .5, return
	lda.w $002A,y
	cmp.w $002A,x
	beq .5
	rts
.5:									; if $0018,x = $0018,y go to .6, return
	lda.w $0018,x
	cmp.w $0018,y
	beq .6
	rts
.6:									; return
	lda.w $001C,x
	cmp.w $001C,y
	rts
CODE_C40ECA:						; from CODE_C40E45
	stz.w $364E
	ldx.w #$364E
	ldy.w #$3650
	lda.w #$000D
	mvn $7E,$7E
	rts
DATA8_C40EDA:						; not traced: a table read by CODE_C40E45, CODE_C40E3A, CODE_C40E14
	db $06,$11,$11,$06,$0A,$0A,$0A,$06,$21,$11,$06,$11,$21,$21,$21,$11
	db $21,$11,$11,$06,$0A,$21,$0A,$06,$21,$0A
DATA8_C40EF4:						; not traced: a table read by CODE_C4081B
	db $00,$00,$01,$01,$02,$02,$03,$02,$04,$02,$05,$03,$06,$03,$07,$03
	db $08,$03,$09,$03,$0A,$03,$0B,$03,$0C,$03,$0D,$03,$0E,$03,$0F,$03
	db $10,$02,$11,$02,$12,$02,$13,$01,$14,$00,$13,$FF,$12,$FE,$11,$FE
	db $10,$FE,$0F,$FD,$0E,$FD,$0D,$FD,$0C,$FD,$0B,$FD,$0A,$FD,$09,$FD
	db $08,$FD,$07,$FD,$06,$FD,$05,$FD,$04,$FE,$03,$FE,$02,$FE,$01,$FF
	db $00,$00,$FF,$01,$FE,$02,$FD,$02,$FC,$02,$FB,$03,$FA,$03,$F9,$03
	db $F8,$03,$F7,$03,$F6,$03,$F5,$03,$F4,$03,$F3,$03,$F2,$03,$F1,$03
	db $F0,$02,$EF,$02,$EE,$02,$ED,$01,$EC,$00,$ED,$FF,$EE,$FE,$EF,$FE
	db $F0,$FE,$F1,$FD,$F2,$FD,$F3,$FD,$F4,$FD,$F5,$FD,$F6,$FD,$F7,$FD
	db $F8,$FD,$F9,$FD,$FA,$FD,$FB,$FD,$FC,$FE,$FD,$FE,$FE,$FE,$FF,$FF
DATA8_C40F94:						; not traced: a table read by CODE_C408B3, CODE_C408B3
	db $12
DATA8_C40F95:						; not traced: a table read by CODE_C408B3, CODE_C408B3
	db $1A,$0F,$1D,$0C,$20,$0B,$21,$09,$23,$08,$24,$07,$25,$06,$26,$05
	db $27,$05,$27,$04,$28,$03,$29,$03,$29,$03,$29,$02,$2A,$02,$2A,$02
	db $2A,$01,$2B,$01,$2B,$01,$2B,$01,$2B,$01,$2B,$01,$2B,$01,$2B,$01
	db $2B,$01,$2B,$02,$2A,$02,$2A,$02,$2A,$03,$29,$03,$29,$03,$29,$04
	db $28,$05,$27,$05,$27,$06,$26,$07,$25,$08,$24,$09,$23,$0B,$21,$0C
	db $20,$0F,$1D,$12,$1A,$F0,$4E,$36,$F0,$0E,$38,$00,$F0,$CE,$39,$F0
	db $8E,$3B,$00
DATA8_C40FF8:						; not traced: a table read by ScrollBracketToCursor
	db $00,$00,$28,$00,$9E,$00,$11,$01,$82,$01,$FA,$01,$20,$02

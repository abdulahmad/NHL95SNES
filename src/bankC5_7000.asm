; Segment bankC5_7000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C56F5C
ShowRosterLine:						; TeamRoster's page of team a2: the line title ($79, 0 the goalies) and
									; the title of stat column $7D, then a row per player of the line: its
									; position, name and stat (RosterColumnTable)
	lda.w #$02C0
	clc
	adc.b $D3
	pha
	ldy.w #$0300
	jsl.l ClearRAM7E
	sec
	pla
	sbc.w #$0040
	ldy.w #$0028
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $79
	bne .1
	ldx.w #$47F8
	bra .2
.1:									; A * 2, X = A, A = DATA8_C35E37,x, X = A
	asl a
	tax
	lda.l DATA8_C35E37,x
	tax
.2:									; call UnpackText, push X, X = $4E7D, call UnpackText, ...
	jsl.l UnpackText
	phx
	ldx.w #$4E7D
	jsl.l UnpackText
	ply
	jsr.w ConcatStrings
	ldy.w #$000A
	jsl.l PrintBoldLeftStr
	lda.b $7D
	asl a
	tax
	lda.b $79
	bne .3
	lda.l DATA8_C35E87,x
	bra .4
.3:									; A = DATA8_C35E67,x
	lda.l DATA8_C35E67,x
.4:									; X = A, call UnpackText, push X, X = $4EC1, ...
	tax
	jsl.l UnpackText
	phx
	ldx.w #$4EC1
	jsl.l UnpackText
	ply
	jsr.w ConcatStrings
	ldy.w #$000B
	jsl.l PrintBoldLeftStr
	lda.w #$000D
	sta.b $6D
	stz.b a3
	ldx.w #HomeRoster
	lda.b a2
	beq .5
	ldx.w #VisRoster
.5:									; a0 = X, if $79 is not 0 go to ShowRosterLineSlots, $91 = $0010
	stx.b a0
	lda.b $79
	bne ShowRosterLineSlots
	lda.w #$0010
	sta.b $91
RosterGoalieRowNext:				; ShowRosterLine's goalie rows (line 0): goalie a3's name, then his stat
									; column (RosterColumnTable), returning to RosterGoalieRowDone
	lda.w #$0010
	sta.b $CF
	lda.w #$0028
	sta.b $D1
	ldx.w #$4F71
	ldy.b $6D
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	lda.w #$00D0
	sta.b $D1
	lda.b a3
	sta.b d0
	asl a
	adc.b a0
	tax
	lda.w $0008,x
	sta.b $81
	lda.b a3
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b a0
	adc.w #$0118
	tax
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.w #$00D0
	sta.b $CF
	lda.b $7D
	asl a
	asl a
	tax
	txy
	lda.l DATA8_C09B94,x
	sta.b d4
	lda.l DATA8_C09B94+2,x
	tax
	pea.w RosterGoalieRowDone-1
	jmp (RosterColumnTable,x)
RosterGoalieRowDone:				; a goalie row drawn: the next row while goalies remain
	inc.b $6D
	lda.b a3
	inc a
	sta.b a3
	ldx.b a0
	cmp.w $0002,x
	bne RosterGoalieRowNext
	rts
ShowRosterLineSlots:				; ShowRosterLine for lines 1 up: the line's five players by slot
									; (positions from DATA8_C35E47)
	stz.b $91
RosterSlotRowNext:					; a line slot's row: its position text, the player's name, then his stat
									; column (RosterColumnTable), returning to RosterSlotRowDone
	lda.w #$0010
	sta.b $CF
	lda.w #$0028
	sta.b $D1
	lda.b a3
	asl a
	tax
	lda.l DATA8_C35E47,x
	tax
	ldy.b $6D
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $79
	asl a
	asl a
	asl a
	adc.b a3
	adc.b a0
	inc a
	tax
	lda.w $006C,x
	and.w #$00FF
	dec a
	sta.b d0
	asl a
	adc.b a0
	tax
	lda.w $0008,x
	sta.b $81
	lda.b d0
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b a0
	adc.w #$0118
	tax
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.w #$00D0
	sta.b $CF
	lda.b $7D
	asl a
	asl a
	tax
	txy
	lda.l DATA8_C09B54,x
	sta.b d4
	lda.l DATA8_C09B54+2,x
	tax
	pea.w RosterSlotRowDone-1
	jmp (RosterColumnTable,x)
RosterSlotRowDone:					; a slot row drawn: the next slot while a3 is below 5
	inc.b $6D
	lda.b a3
	inc a
	sta.b a3
	cmp.w #$0005
	bcs .rts
	ldx.b $79
	cpx.w #$0006
	bcc .1
	cmp.w #$0004
	bcc .1
.rts:								; return
	rts
.1:									; go to RosterSlotRowNext
	jmp.w RosterSlotRowNext
RosterColumnTable:					; the stat column routines by column ($7D * 2): RosterColStatus,
									; AttribEnergy, RosterColHand, RosterColWeight, none, RosterColRating
	dw RosterColStatus,AttribEnergy,RosterColHand,RosterColWeight
	dw $0000,RosterColRating
RosterColStatus:					; TeamRoster's status column for player d0: Ice, Bench, Inj= P / Inj= G
									; (DATA8_C35E9F) or the penalty time left (M:SS)
	lda.b d0
	asl a
	ldx.b a2
	beq .1
	adc.w #$0034
.1:									; Y = A, if tmpdst,y >= 0 go to .2, A xor $FFFF, ...
	tay
	lda.w tmpdst,y
	bpl .2
	eor.w #$FFFF
	cmp.w #$0004
	bcc .5
	lda.w #$0001
	bra .5
.2:									; if $1000 bits clear go to .3, A = $0003, go to .5
	bit.w #$1000
	beq .3
	lda.w #$0003
	bra .5
.3:									; push A, A and $0FFF, call TimeTextMSS, pull A, ...
	pha
	and.w #$0FFF
	jsr.w TimeTextMSS
	pla
	bit.w #$4000
	beq .4
	lda.w #$2043
	sta.w mesarea,x
	stz.w mesarea+2,x
.4:									; X = mesarea, Y = $6D, call PrintBoldCentredStr, return
	ldx.w #mesarea
	ldy.b $6D
	jsl.l PrintBoldCentredStr
	rts
.5:									; A * 2, X = A, A = DATA8_C35E9F,x, X = A, ...
	asl a
	tax
	lda.l DATA8_C35E9F,x
	tax
	ldy.b $6D
	jsl.l PrintBoldCentred
	rts
AttribEnergy:						; prints the energy of roster player d0 of team a2 as a percentage: the
									; energy / 40, at most 100 ($1000 when line changes are automatic)
	lda.b d0
	asl a
	ldx.b a2
	beq .1
	adc.w #$0034
.1:									; Y = A, A = tmpde,y, if OptLine is not $0002 go to .2, A = $1000
	tay
	lda.w tmpde,y
	ldx.w OptLine
	cpx.w #$0002
	bne .2
	lda.w #$1000
.2:									; r2 = A, r1 = $0028, call Div16x8U, if r0 < $0065 go to .3, ...
	sta.b r2
	lda.w #$0028
	sta.b r1
	jsl.l Div16x8U
	lda.b r0
	cmp.w #$0065
	bcc .3
	lda.w #$0064
.3:									; call BinToBCD, call BCDText, Y = $6D, X = mesarea, ...
	jsr.w BinToBCD
	jsr.w BCDText
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	rts
RosterColHand:						; TeamRoster's shooting hand column: Left or Right by bit 0 of the
									; attribute (CalcRosterAttrib)
	jsr.w CalcRosterAttrib
	and.w #$0001
	asl a
	tax
	lda.l DATA8_C35E9F+8,x
	tax
	ldy.b $6D
	jsl.l PrintBoldCentred
	rts
RosterColWeight:					; TeamRoster's weight column: the attribute (CalcRosterAttrib) * 8 + 140
	jsr.w CalcRosterAttrib
	asl a
	asl a
	asl a
	adc.w #$008C
	jsr.w BinToBCD
	jsr.w BCDText
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	rts
RosterColRating:					; TeamRoster's rating column: the attribute value (CalcRosterAttrib)
	jsr.w CalcRosterAttrib
	jsr.w BinToBCD
	jsr.w BCDText
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	rts
CalcRosterAttribLong:				; CalcRosterAttrib for long calls
	jsr.w CalcRosterAttrib
	rtl
CalcRosterAttrib:					; the rating of roster player d0 of team a2 for the attributes in mask d4:
									; CalcAttrib's weighted sum with the hot / cold bytes, read from the
									; roster table's player record
	stz.b $81
	ldx.w #HomeRoster
	lda.b d0
	asl a
	adc.b d0
	asl a
	asl a
	ldy.b a2
	beq .1
	adc.w #$0138
	ldx.w #VisRoster
.1:									; $89 = A, d1 = 0, $85 = 0, A = d0, ...
	sta.b $89
	stz.b d1
	stz.b $85
	lda.b d0
	asl a
	asl a
	asl a
	asl a
	asl a
	stx.b d0
	adc.b d0
	sta.b d0
	lda.w #$000F
.2:									; d2 = A, A * 2, X = A, A = BitMaskTable2,x, ...
	sta.b d2
	asl a
	tax
	lda.l BitMaskTable2,x
	bit.b d4
	bne .3
	jmp.w .15
.3:									; if A = $0004 go to .4, if A is not $0200 go to .5
	cmp.w #$0004
	beq .4
	cmp.w #$0200
	bne .5
.4:									; $81 + 1
	inc.b $81
.5:									; A = d2, A / 2, A + d0, X = A, ...
	lda.b d2
	lsr a
	php
	clc
	adc.b d0
	tax
	lda.w $0110,x
	plp
	bcs .6
	lsr a
	lsr a
	lsr a
	lsr a
.6:									; A and $000F, d3 = A, if RatingMode = 0 go to .9, A = d2, ...
	and.w #$000F
	sta.b d3
	lda.w RatingMode
	beq .9
	lda.b d2
	dec a
	dec a
	dec a
	cmp.w #$0006
	bcc .7
	dec a
.7:									; A + $89, X = A, A = HotColdTable,x, A and $00FF, ...
	clc
	adc.b $89
	tax
	lda.w HotColdTable,x
	and.w #$00FF
	tay
	sta.b $8D
	cmp.w #$0080
	bcc .8
	lda.w #$0100
	sbc.b $8D
	sta.b $8D
.8:									; A * 2, A + $8D, A / 2, A / 2, ...
	asl a
	adc.b $8D
	lsr a
	lsr a
	sta.b $8D
	cpy.w #$0080
	bcc .9
	lda.w #$0000
	sbc.b $8D
.9:									; $8D = A, A = d4, if a $0001 bit set go to .13, X = d3, ...
	sta.b $8D
	lda.b d4
	bit.w #$0001
	bne .13
	ldx.b d3
	lda.b d2
	cmp.w #$0002
	beq .12
	cmp.w #$0009
	beq .12
	lda.w #$0012
	jsl.l Mul8U
	clc
	adc.b $8D
	bpl .10
	lda.w #$0000
.10:								; if A < $0065 go to .11, A = $0064
	cmp.w #$0065
	bcc .11
	lda.w #$0064
.11:								; if A >= $0032 go to .rts, A / 2, A + $0019
	cmp.w #$0032
	bcs .rts
	lsr a
	clc
	adc.w #$0019
.rts:								; return
	rts
.12:								; A = X, return
	txa
	rts
.13:								; A = d2, A + $91, X = A, A = DATA8_C57309,x, ...
	lda.b d2
	clc
	adc.b $91
	tax
	lda.l DATA8_C57309,x
	ldx.b d3
	jsl.l Mul8U
	clc
	adc.b d1
	sta.b d1
	lda.b $8D
	ldy.b $91
	beq .14
	asl a
.14:								; A + $85, $85 = A
	clc
	adc.b $85
	sta.b $85
.15:								; A = d2, A - 1, if the result = 0 go to .16, go to .2
	lda.b d2
	dec a
	beq .16
	jmp.w .2
.16:								; if $85 >= 0 go to .18, A xor $FFFF, A + 1, X = A, ...
	lda.b $85
	bpl .18
	eor.w #$FFFF
	inc a
	tax
	lda.w #$000A
	ldy.b $91
	beq .17
	lda.w #$0007
.17:								; call DivX8U, A xor $FFFF, A + d1, if the result >= 0 go to .20, ...
	jsl.l DivX8U
	eor.w #$FFFF
	sec
	adc.b d1
	bpl .20
	lda.w #$0000
	bra .20
.18:								; X = A, A = $000A, if $91 = 0 go to .19, A = $0007
	tax
	lda.w #$000A
	ldy.b $91
	beq .19
	lda.w #$0007
.19:								; call DivX8U, A + d1, if the result >= 0 go to .20, A = $0000
	jsl.l DivX8U
	clc
	adc.b d1
	bpl .20
	lda.w #$0000
.20:								; if $91 = 0 go to .21, A / 2
	ldx.b $91
	beq .21
	lsr a
.21:								; go to .10
	bra .10
DATA8_C57309:						; not traced: a table read by CalcRosterAttrib
	db $00,$00,$01,$02,$03,$03,$02,$01,$02,$01,$03,$02,$01,$01,$01,$01
	db $00,$00,$00,$09,$02,$02,$09,$09,$02,$02,$02,$02,$02,$02,$02,$02
PauseReplay:						; pause menu Inst Replay: fade out, the game state kept, vcountmark+2 set
									; back two, ReplayMode, then back to the pause screen's exit
	jsl.l FadeOutWait
	lda.w PauseMapBuf
	sta.w WorkBufMark
	sta.b $08
	stz.b $22
	ldx.w $18F0
	jsl.l DeleteSprite
	jsl.l RestorePauseBuffers
	jsl.l RestoreGameScreen
	pei ($9B)
	lda.b $5F
	dec a
	dec a
	sta.w vcountmark+2
	lda.w pregamepause
	bne .1
	jsl.l ReplayMode
.1:									; pull A, d7 = A, $A2 = A, pull A, ...
	pla
	sta.b d7
	sta.b $A2
	pla
	jmp.w Pausemode_menu_resume
EditLinesScreen:					; pause menu Edit Lines: the lines of team a2 (pad left / right changes
									; the line); start returns
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	jsr.w SetupScreen
	jsl.l GetPadTeam
	ldy.w #$2801
	ldx.w #$5135
	jsl.l MapTileBlock
	lda.w #$00D0
	sta.b $18
	lda.w #$0028
	sta.b $1A
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	jsr.w TeamLogoSprite
	stz.b $69
	stz.b $79
	ldx.w #$0000
	lda.w OptLine
	beq .1
	ldx.w #$0006
.1:									; $7B = X
	stx.b $7B
.2:									; if $7B = $0000 go to .3, $CF = $0010, Y = $0018, X = $4F06, ...
	ldx.b $7B
	cpx.w #$0000
	beq .3
	lda.w #$0010
	sta.b $CF
	ldy.w #$0018
	ldx.w #$4F06
	jsl.l PrintBoldLeft
.3:									; A = $537F, call PrintTextPage, X = HomeRoster, Y = $17DB, ...
	lda.w #$537F
	jsl.l PrintTextPage
	ldx.w #HomeRoster
	ldy.w #$17DB
	lda.b a2
	beq .4
	ldx.w #VisRoster
	ldy.w #$1813
.4:									; a0 = X, $65 = Y
	stx.b a0
	sty.b $65
.5:									; call PrintLineNames
	jsr.w PrintLineNames
.6:									; call SendTextMap, fadestep = 0
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
	bit.w #$1000
	beq .7
	jmp.w .15
.7:									; if $0800 bits clear go to .8, if $69 = 0 go to .loop, A - 1, go to .9
	bit.w #$0800
	beq .8
	lda.b $69
	beq .loop
	dec a
	bra .9
.8:									; if $0400 bits clear go to .10, if $69 >= a1 go to .loop, A + 1
	bit.w #$0400
	beq .10
	lda.b $69
	cmp.b a1
	bcs .loop
	inc a
.9:									; X = $69, $69 = A, d0 = $2000, A = X, ...
	ldx.b $69
	sta.b $69
	lda.w #$2000
	sta.b d0
	txa
	clc
	adc.w #$000D
	jsr.w RecolourTextRow
	lda.w #$2400
	sta.b d0
	lda.b $69
	clc
	adc.w #$000D
	jsr.w RecolourTextRow
	bra .6
.10:								; if $0200 bits clear go to .11, if $79 = 0 go to .loop, A - 1, ...
	bit.w #$0200
	beq .11
	lda.b $79
	beq .loop
	dec a
	sta.b $79
	bra .12
.11:								; if $0100 bits clear go to .13, if $79 = $7B go to .14, A + 1, $79 = A
	bit.w #$0100
	beq .13
	lda.b $79
	cmp.b $7B
	beq .14
	inc a
	sta.b $79
.12:								; X = $D3, Y = $0014
	ldx.b $D3
	ldy.w #$0014
.loop3:								; loop: $0200,x = 0, $0240,x = 0, $0280,x = 0, X + 1, ...
	stz.w $0200,x
	stz.w $0240,x
	stz.w $0280,x
	inx
	inx
	dey
	bpl .loop3
	lda.b $D3
	clc
	adc.w #$0300
	ldy.w #$02C0
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsl.l WaitTransfers
	stz.b $69
	jmp.w .5
.13:								; if $8000 bits clear go to .14, call SelectLinePlayer, go to .2
	bit.w #$8000
	beq .14
	jsr.w SelectLinePlayer
	jmp.w .2
.14:								; go to .loop
	jmp.w .loop
.15:								; go to ExitToPauseMenu
	jmp.w ExitToPauseMenu
PrintLineNames:						; prints the line being edited: its title (Best Line with line changes
									; off, else the line's name by $79), then each slot's row (PrintLineSlot),
									; the cursor row ($69) highlighted
	lda.w #$0020
	sta.b $CF
	lda.w #$00A8
	sta.b $D1
	lda.w OptLine
	bne .1
	ldx.w #$4C74
	bra .2
.1:									; A = $79, A + 1, A * 2, X = A, ...
	lda.b $79
	inc a
	asl a
	tax
	lda.l DATA8_C35E37,x
	tax
.2:									; Y = $0008, call PrintItalicLeft, Y = $000A, call PrintTitleBar, ...
	ldy.w #$0008
	jsl.l PrintItalicLeft
	ldy.w #$000A
	jsl.l PrintTitleBar
	lda.w #$000D
	sta.b $6D
	stz.b a3
.loop:								; loop: X = $2400, if a3 = $69 go to .3, X = $2000
	ldx.w #$2400
	lda.b a3
	cmp.b $69
	beq .3
	ldx.w #$2000
.3:									; $D5 = X, call PrintLineSlot, $6D + 1, A = a3, ...
	stx.b $D5
	jsr.w PrintLineSlot
	inc.b $6D
	lda.b a3
	inc a
	sta.b a3
	cmp.w #$0005
	bcs .4
	ldx.b $79
	cpx.w #$0005
	bcc .loop
	cmp.w #$0004
	bcc .loop
.4:									; A - 1, a1 = A, $D5 = $2000, return
	dec a
	sta.b a1
	lda.w #$2000
	sta.b $D5
	rts
PrintLineSlot:						; prints slot a3 of the edited line on row $6D: its position name
									; (DATA8_C35E47) and its player
	lda.w #$0020
	sta.b $CF
	lda.w #$0040
	sta.b $D1
	lda.b a3
	asl a
	tax
	lda.l DATA8_C35E47,x
	tax
	ldy.b $6D
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $79
	asl a
	asl a
	asl a
	adc.b a3
	adc.b $65
	inc a
	tax
	lda.w $0000,x
	and.w #$00FF
	dec a
	sta.b d0
	asl a
	adc.b a0
	tax
	lda.w $0008,x
	sta.b $81
	lda.b d0
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b a0
	adc.w #$0118
	tax
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	rts
RecolourTextRow:					; puts palette bits d0 on the non-blank tiles of text row A (32 tiles;
									; their palette bits cleared first)
	xba
	lsr a
	lsr a
	adc.b $D3
	tax
	ldy.w #$0020
.loop:								; loop: A = $0000,x, if the result = 0 go to .1, A or d0, $0000,x = A
	lda.w $0000,x
	and.w #$E3FF
	beq .1
	ora.b d0
	sta.w $0000,x
.1:									; X + 1, X + 1, Y - 1, if the result is not 0 go to .loop, ...
	inx
	inx
	dey
	bne .loop
	rts
SelectLinePlayer:					; picks a player for the line slot: a scrolling list of the team's
									; players, up / down scroll, left / right change the rating column ($7D),
									; B picks, start leaves
	pei ($7B)
	pei ($65)
	pei ($79)
	pei ($69)
	lda.b $D3
	clc
	adc.w #$0300
	ldy.w #$0400
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsl.l WaitTransfers
	stz.b $7D
	stz.b $7B
	stz.b $91
	lda.w #$0001
	sta.w RatingMode
	ldx.b a0
	lda.b $69
	cmp.w #$0002
	bcs .1
	lda.w $0002,x
	clc
	adc.w $0004,x
	sta.b $65
	lda.w $0006,x
	sta.b a1
	bra .2
.1:									; $65 = $0002,x, a1 = $0004,x
	lda.w $0002,x
	sta.b $65
	lda.w $0004,x
	sta.b a1
.2:									; A = DrawLinePlayerRow, X = $000A, Y = $000E, call StartScrollList, ...
	lda.w #DrawLinePlayerRow
	ldx.w #$000A
	ldy.w #$000E
	jsr.w StartScrollList
	jsr.w PrintLinePlayerHeader
	jsl.l SendTextMap
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
	bne .12
	bit.w #$0800
	beq .4
	lda.b $7B
	pha
	beq .3
	dec a
	sta.b $7B
.3:									; call ScrollListUp, pull A, go to .6
	jsr.w ScrollListUp
	pla
	bra .6
.4:									; if $0400 bits clear go to .7, A = $7B, push A, A + 1, ...
	bit.w #$0400
	beq .7
	lda.b $7B
	pha
	inc a
	cmp.b a1
	bcs .5
	sta.b $7B
.5:									; call ScrollListDown, pull A
	jsr.w ScrollListDown
	pla
.6:									; call MoveLinePlayerCursor, go to .loop
	jsr.w MoveLinePlayerCursor
	bra .loop
.7:									; if $0200 bits clear go to .8, if $7D = 0 go to .loop, A - 1, ...
	bit.w #$0200
	beq .8
	lda.b $7D
	beq .loop
	dec a
	sta.b $7D
	bra .9
.8:									; if $0100 bits clear go to .10, if $7D >= $000F go to .loop, A + 1, ...
	bit.w #$0100
	beq .10
	lda.b $7D
	cmp.w #$000F
	bcs .loop
	inc a
	sta.b $7D
.9:									; call ClearLinePlayerStatColumn, call PrintLinePlayerHeader, ...
	jsr.w ClearLinePlayerStatColumn
	jsr.w PrintLinePlayerHeader
	jsr.w RedrawScrollList
	jsl.l SendTextMap
.10:								; if $8000 bits clear go to .11, A = $65, A + $7B, $7B = A, ...
	bit.w #$8000
	beq .11
	lda.b $65
	clc
	adc.b $7B
	sta.b $7B
	lda.b $05,s
	sta.b $65
	lda.b $03,s
	tax
	lda.b $01,s
	jsr.w SetLineSlot
	bra .12
.11:								; go to .loop
	jmp.w .loop
.12:								; X = $77, call DeleteSprite, X = $79, call DeleteSprite, ...
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	jsr.w RefreshSprites
	pla
	sta.b $69
	pla
	sta.b $79
	pla
	sta.b $65
	pla
	sta.b $7B
	jsl.l WaitTransfers
	lda.b $D3
	clc
	adc.w #$0300
	ldy.w #$0400
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.w #$8000
	sta.w DMAEnShadow
	sep #$20
	lda.b #$1F
	sta.l TM
	lda.b #$FF
	sta.l $002112
	sta.l $002112
	rep #$20
	rts
ClearLinePlayerStatColumn:			; clears the right half of text row 12 (the list header) and 10 tiles from
									; column 22 on rows 13-24 (the stat column), then sends the map
	lda.b $D3
	clc
	adc.w #$0320
	pha
	ldy.w #$0020
	jsl.l ClearRAM7E
	pla
	clc
	adc.w #$004C
	ldx.w #$000B
.loop:								; loop: push X, push A, Y = $0014, call ClearRAM7E, ...
	phx
	pha
	ldy.w #$0014
	jsl.l ClearRAM7E
	pla
	clc
	adc.w #$0040
	plx
	dex
	bpl .loop
	jsl.l SendTextMap
	jsl.l WaitTransfers
	rts
DrawLinePlayerRow:					; draws row a3 of SelectLinePlayer's list: a player and the shown rating,
									; the current row highlighted
	ldx.w #$2000
	lda.b a3
	cmp.b $7B
	bne .1
	ldx.w #$2400
.1:									; $D5 = X, $CF = $0010, $D1 = $00D0, A + $65, ...
	stx.b $D5
	ldx.w #$0010
	stx.b $CF
	ldx.w #$00D0
	stx.b $D1
	clc
	adc.b $65
	sta.b d0
	asl a
	adc.b a0
	tax
	lda.w $0008,x
	sta.b $81
	lda.b d0
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b a0
	adc.w #$0118
	tax
	phx
	lda.l $7DFFF8,x
	and.w #$00FF
	jsr.w BinToBCD
	jsr.w BCDText
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldLeftStr
	lda.w #$0022
	sta.b $CF
	plx
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $7D
	asl a
	asl a
	tax
	txy
	lda.l DATA8_C09B54,x
	sta.b d4
	lda.l DATA8_C09B54+2,x
	tax
	pea.w LinePlayerRowDone-1
	jmp (RosterColumnTable,x)
LinePlayerRowDone:					; DrawLinePlayerRow's column drawn: the text palette back to normal ($D5 =
									; $2000)
	lda.w #$2000
	sta.b $D5
	rts
MoveLinePlayerCursor:				; list row A (the old cursor) back to palette 0 and cursor row $7B in
									; palette 1 (RecolourTextRow, rows wrapped as RedrawScrollList does), the
									; map sent; a delay when padlast is set
	ldx.b $71
	inx
	stx.b tmp1
	inx
	stx.b tmp2
	ldx.w #$2000
	stx.b d0
.loop:								; loop: if A < tmp1 go to .1, A - tmp2, if the result >= 0 go to .loop
	cmp.b tmp1
	bcc .1
	sbc.b tmp2
	bpl .loop
.1:									; A + a4, call RecolourTextRow, d0 = $2400, A = $7B
	clc
	adc.b a4
	jsr.w RecolourTextRow
	lda.w #$2400
	sta.b d0
	lda.b $7B
.loop2:								; loop: if A < tmp1 go to .2, A - tmp2, if the result >= 0 go to .loop2
	cmp.b tmp1
	bcc .2
	sbc.b tmp2
	bpl .loop2
.2:									; A + a4, call RecolourTextRow, call SendTextMap, call WaitTransfers, ...
	clc
	adc.b a4
	jsr.w RecolourTextRow
	jsl.l SendTextMap
	jsl.l WaitTransfers
	ldx.w #$0000
	lda.w padlast
	beq .rts
.loop3:								; loop: X - 1, if the result is not 0 go to .loop3, ...
	dex
	bne .loop3
	stz.w repeatdelayframes
	stz.w padchangeany
.rts:								; return
	rts
PrintLinePlayerHeader:				; the list header on text row 12: 'Player' from x $1E, the title of stat
									; column $7D (DATA8_C35E67) right-aligned to x $F0
	lda.w #$000C
	sta.b $6D
	jsr.w ClearTextRow
	lda.w #$001E
	sta.b $CF
	lda.w #$00D0
	sta.b $D1
	ldx.w #$4F6C
	ldy.b $6D
	jsl.l PrintBoldLeft
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $7D
	asl a
	tax
	lda.l DATA8_C35E67,x
	tax
	ldy.b $6D
	jsl.l PrintBoldRight
	rts
SetLineSlot:						; puts player $7B (+ 1) in slot A of line X of the line block at $65
									; through the slot's handler (DATA8_C57810), the old player moved when the
									; new one was in the line
	stx.b tmp1
	inc.b $7B
	asl a
	tax
	lda.l DATA8_C57810,x
	sta.b tmp0
	lda.b tmp1
	asl a
	asl a
	asl a
	adc.b $65
	tax
	sep #$20
	jmp ($009F)
DATA8_C57810:						; the routines SetLineSlot jumps to through a pointer, by index
	dw SetLineSlotLD,SetLineSlotRD,SetLineSlotLW,SetLineSlotC
	dw SetLineSlotRW
SetLineSlotLD:						; slot 0 (LD, line byte +1) = player $7B; the old LD goes to RD when the
									; player was there
	lda.w $0002,x
	cmp.b $7B
	bne .1
	lda.w $0001,x
	sta.w $0002,x
.1:									; $0001,x = $7B, A 16-bit, return
	lda.b $7B
	sta.w $0001,x
	rep #$20
	rts
SetLineSlotRD:						; slot 1 (RD, line byte +2) = player $7B; the old RD goes to LD when the
									; player was there
	lda.w $0001,x
	cmp.b $7B
	bne .1
	lda.w $0002,x
	sta.w $0001,x
.1:									; $0002,x = $7B, A 16-bit, return
	lda.b $7B
	sta.w $0002,x
	rep #$20
	rts
SetLineSlotLW:						; slot 2 (LW, line byte +3) = player $7B; the old LW goes to RW or C,
									; wherever the player was
	lda.w $0005,x
	cmp.b $7B
	bne .2
	lda.w $0003,x
	sta.w $0005,x
.1:									; $0003,x = $7B, A 16-bit, return
	lda.b $7B
	sta.w $0003,x
	rep #$20
	rts
.2:									; if $0004,x is not $7B go to .1, $0004,x = $0003,x, go to .1
	lda.w $0004,x
	cmp.b $7B
	bne .1
	lda.w $0003,x
	sta.w $0004,x
	bra .1
SetLineSlotC:						; slot 3 (C, line byte +4) = player $7B; the old C goes to LW or RW,
									; wherever the player was
	lda.w $0003,x
	cmp.b $7B
	bne .2
	lda.w $0004,x
	sta.w $0003,x
.1:									; $0004,x = $7B, A 16-bit, return
	lda.b $7B
	sta.w $0004,x
	rep #$20
	rts
.2:									; if $0005,x is not $7B go to .1, $0005,x = $0004,x, go to .1
	lda.w $0005,x
	cmp.b $7B
	bne .1
	lda.w $0004,x
	sta.w $0005,x
	bra .1
SetLineSlotRW:						; slot 4 (RW, line byte +5) = player $7B; the old RW goes to LW or C,
									; wherever the player was
	lda.w $0003,x
	cmp.b $7B
	bne .2
	lda.w $0005,x
	sta.w $0003,x
.1:									; $0005,x = $7B, A 16-bit, return
	lda.b $7B
	sta.w $0005,x
	rep #$20
	rts
.2:									; if $0004,x is not $7B go to .1, $0004,x = $0005,x, go to .1
	lda.w $0004,x
	cmp.b $7B
	bne .1
	lda.w $0005,x
	sta.w $0004,x
	bra .1
PauseGoalie:						; pause menu Chnge Goalie: team a2's goalies (pad up / down, left / right
									; the stat); B puts the chosen one in tmgoalie (setpersonel) and returns
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	jsr.w SetupScreen
	lda.w #$5395
	jsl.l PrintTextPage
	jsl.l GetPadTeam
	ldy.w #$2801
	ldx.w #$5135
	jsl.l MapTileBlock
	lda.w #$00D0
	sta.b $18
	lda.w #$0028
	sta.b $1A
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	jsr.w TeamLogoSprite
	stz.b $7D
	ldx.w #HomeRoster
	lda.b a2
	beq .1
	ldx.w #VisRoster
.1:									; a0 = X, a1 = $0002,x, X = a2, if tmgoalie,x >= 0 go to .2, ...
	stx.b a0
	lda.w $0002,x
	sta.b a1
	ldx.b a2
	lda.w tmgoalie,x
	bpl .2
	lda.b a1
.2:									; $69 = A
	sta.b $69
.loop:								; loop: call Pausemode_gnum, call SendTextMap, fadestep = 0
	jsr.w Pausemode_gnum
	jsl.l SendTextMap
	stz.w fadestep
.loop2:								; loop: TransfersReady + 1
	inc.w TransfersReady
.loop3:								; loop: if TransfersReady is not 0 go to .loop3, call ReadMenuPads, ...
	lda.w TransfersReady
	bne .loop3
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
	bne .loop2
	lda.w padchangeany
	bit.w #$1000
	bne .8
	bit.w #$0800
	beq .3
	lda.b $69
	beq .loop2
	dec a
	sta.b $69
	bra .loop
.3:									; if $0400 bits clear go to .4, if $69 = a1 go to .loop2, A + 1, ...
	bit.w #$0400
	beq .4
	lda.b $69
	cmp.b a1
	beq .loop2
	inc a
	sta.b $69
	bra .loop
.4:									; if $0200 bits clear go to .5, if $7D = 0 go to .loop2, A - 1, ...
	bit.w #$0200
	beq .5
	lda.b $7D
	beq .loop2
	dec a
	sta.b $7D
	bra .loop
.5:									; if $0100 bits clear go to .6, if $7D >= $000B go to .loop2, A + 1, ...
	bit.w #$0100
	beq .6
	lda.b $7D
	cmp.w #$000B
	bcs .loop2
	inc a
	sta.b $7D
	bra .loop
.6:									; if $8000 bits clear go to .loop2, if $69 is not a1 go to .7, A = $FFFF
	bit.w #$8000
	beq .loop2
	lda.b $69
	cmp.b a1
	bne .7
	lda.w #$FFFF
.7:									; X = a2, tmgoalie,x = A, call setpersonel
	ldx.b a2
	sta.w tmgoalie,x
	jsl.l setpersonel
.8:									; go to ExitToPauseMenu
	jmp.w ExitToPauseMenu
Pausemode_gnum:						; PauseGoalie's goalie list: 'Player' and the title of stat column $7D
									; over title bars, a row per goalie with its stat, then 'None'; the cursor
									; row ($69) in palette 1
	lda.w #$0300
	clc
	adc.b $D3
	ldy.w #$0280
	jsl.l ClearRAM7E
	lda.w #$000C
	sta.b $6D
	lda.w #$0010
	sta.b $CF
	lda.w #$00D0
	sta.b $D1
	ldx.w #$4F6C
	ldy.b $6D
	jsl.l PrintBoldLeft
	ldy.b $6D
	iny
	jsl.l PrintTitleBar
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $7D
	asl a
	tax
	lda.l DATA8_C35E87,x
	tax
	ldy.b $6D
	jsl.l PrintBoldRight
	ldy.b $6D
	iny
	jsl.l PrintTitleBar
	stz.b a3
	lda.w #$000E
	sta.b $6D
	lda.w #$0010
	sta.b $91
	lda.w #$0001
	sta.w RatingMode
GoalieListRowNext:					; Pausemode_gnum's row loop: goalie a3's row (the cursor row $69 in
									; palette 1) and his stat column (RosterColumnTable), returning to
									; GoalieListRowDone
	jsr.w ClearTextRow
	lda.b a3
	ldx.w #$2000
	sta.b d0
	cmp.b $69
	bne .1
	ldx.w #$2400
.1:									; $D5 = X, $CF = $0010, $D1 = $00D0, A * 2, ...
	stx.b $D5
	ldx.w #$0010
	stx.b $CF
	ldx.w #$00D0
	stx.b $D1
	asl a
	adc.b a0
	tax
	lda.w $0008,x
	sta.b $81
	lda.b d0
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b a0
	adc.w #$0118
	tax
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $7D
	asl a
	asl a
	tax
	txy
	lda.l DATA8_C09B94,x
	sta.b d4
	lda.l DATA8_C09B94+2,x
	tax
	pea.w GoalieListRowDone-1
	jmp (RosterColumnTable,x)
GoalieListRowDone:					; a goalie row drawn: the next one while below a1, then the None row
	inc.b $6D
	lda.b a3
	inc a
	sta.b a3
	cmp.b a1
	bne GoalieListRowNext
	ldx.w #$2000
	cmp.b $69
	bne .1
	ldx.w #$2400
.1:									; $D5 = X, $CF = $0010, $D1 = $00D0, X = $4C86, ...
	stx.b $D5
	lda.w #$0010
	sta.b $CF
	lda.w #$00D0
	sta.b $D1
	ldx.w #$4C86
	ldy.b $6D
	jsl.l PrintBoldLeft
	lda.w #$2000
	sta.b $D5
	rts
ShowOtherScores:					; Other Scores: the date and the other games (DrawOtherScoreRow draws each
									; row); from the pause menu, and from FinishSeasonDay with X: EXIT MENU
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	jsr.w SetupScreen
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4C95
	ldy.w #$0002
	jsl.l PrintTitle
	lda.l SeasonDay
	and.w #$00FF
	tay
	asl a
	tax
	lda.l DATA8_C35F60,x
	bne .1
	lda.w #$000D
	ldx.w #$5F52
	ldy.w #mesarea
	mvn $7E,$C3
	tya
	sec
	sbc.w #mesarea
	pha
	lda.l SRPODay
	inc a
	and.w #$00FF
	jsr.w BinToBCD
	plx
	jsr.w BCDTextAt
	stz.w mesarea,x
	bra .2
.1:									; A = Y, call MakeDateString
	tya
	jsr.w MakeDateString
.2:									; X = mesarea, Y = $0007, call PrintItalicCentredStr, Y = $0009, ...
	ldx.w #mesarea
	ldy.w #$0007
	jsl.l PrintItalicCentredStr
	ldy.w #$0009
	jsl.l PrintTitleBar
	lda.w $190E
	beq .3
	ldx.w #$4717
	ldy.w #$0019
	jsl.l PrintBoldLeft
.3:									; d0 = DayGameCount, X = $0000, Y = X
	lda.w DayGameCount
	sta.b d0
	ldx.w #$0000
	txy
.loop:								; loop: if $7F8EF8,x is not 0 go to .4, Y + 1
	lda.l $7F8EF8,x
	bne .4
	iny
.4:									; A = X, A + $010A, X = A, d0 - 1, ...
	txa
	clc
	adc.w #$010A
	tax
	dec.b d0
	bne .loop
	sty.b d0
	tya
	asl a
	adc.b d0
	bne .5
	pea.w PauseMenuReturn
	bra .6
.5:									; A - 1
	dec a
	pea.w DrawOtherScoreRow
.6:									; a1 = A, $69 = 0, pull A, X = $000B, ...
	sta.b a1
	stz.b $69
	pla
	ldx.w #$000B
	ldy.w #$000B
	jsr.w StartScrollList
	jsl.l SendTextMap
	stz.w fadestep
.loop2:								; loop: TransfersReady + 1, call ReadMenuPads, $26 + 1, ...
	inc.w TransfersReady
	wai
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
	bne .loop2
	lda.w padchangeany
	bit.w #$0040
	bne .9
	bit.w #$1000
	bne .10
	bit.w #$0800
	beq .7
	jsr.w ScrollListUp
	bra .loop2
.7:									; if $0400 bits clear go to .8, call ScrollListDown
	bit.w #$0400
	beq .8
	jsr.w ScrollListDown
.8:									; go to .loop2
	bra .loop2
.9:									; if $190E = 0 go to .loop2, $1910 - 1
	lda.w $190E
	beq .loop2
	dec.w $1910
.10:								; go to ExitToPauseMenu
	jmp.w ExitToPauseMenu
DrawOtherScoreRow:					; draws row a3 of ShowOtherScores' scrolling list: a game and its score
	lda.w #$0010
	sta.b $CF
	lda.w #$00C4
	sta.b $D1
	lda.b a3
	sta.b r2
	lda.w #$0003
	sta.b r1
	jsl.l Div16x8U
	tay
	ldx.w #$0000
.loop:								; loop: if $7F8EF8,x is not 0 go to .1, if Y = $0000 go to .2, Y - 1
	lda.l $7F8EF8,x
	bne .1
	cpy.w #$0000
	beq .2
	dey
.1:									; A = X, A + $010A, X = A, go to .loop
	txa
	clc
	adc.w #$010A
	tax
	bra .loop
.2:									; if RDMPYL = 0 go to .3, A - 1, if the result = 0 go to .4, return
	lda.l RDMPYL
	beq .3
	dec a
	beq .4
	rts
.3:									; push X, A = $7F8EFA,x, A * 2, X = A, ...
	phx
	lda.l $7F8EFA,x
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.b $6D
	jsl.l PrintBoldLeft
	plx
	lda.l $7F8F00,x
	jsr.w BinToBCD
	jsr.w BCDText
	ldx.w #mesarea
	ldy.b $6D
	jsl.l PrintBoldRightStr
	rts
.4:									; push X, A = $7F8EFC,x, A * 2, X = A, ...
	phx
	lda.l $7F8EFC,x
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.b $6D
	jsl.l PrintBoldLeft
	lda.b $01,s
	tax
	lda.l $7F8F02,x
	jsr.w BinToBCD
	jsr.w BCDText
	ldx.w #mesarea
	ldy.b $6D
	jsl.l PrintBoldRightStr
	lda.w #$00C8
	sta.b $CF
	plx
	ldy.b $6D
	lda.l $7F8EFE,x
	bmi .5
	asl a
	tax
	lda.l DATA8_C35E25,x
	tax
	jsl.l PrintBoldLeft
	rts
.5:									; X = $4F67, call PrintBoldLeft, return
	ldx.w #$4F67
	jsl.l PrintBoldLeft
	rts
RecordHoldersScreen:				; pause menu Records: the user records (win percentages worked out and the
									; rows sorted), a page of win / loss records, goals or saves; the pad
									; changes the page, start returns
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	jsr.w SetupScreen
	stz.b $7D
	lda.w #$0000
	tax
.1:									; a4 = X, push A, ScratchBuf,x = A, call GetUserName, ...
	stx.b a4
	pha
	sta.w ScratchBuf,x
	jsr.w GetUserName
	cpx.w #$0000
	beq .2
	ldy.w #$0000
	ldx.b a4
.loop:								; loop: A = mesarea,y, A and $00FF, ScratchBuf+$12,x = A, X + 1, ...
	lda.w mesarea,y
	and.w #$00FF
	sta.w ScratchBuf+$12,x
	inx
	iny
	cpy.w #$000C
	bne .loop
	lda.b $01,s
	jsr.w ReadUserRecord
	lda.b d4
	clc
	adc.b $8D
	adc.b d3
.2:									; if zero go to .5, X = a4, ScratchBuf+$2,x = d0, ...
	beq .5
	ldx.b a4
	lda.b d0
	sta.w ScratchBuf+$2,x
	lda.b $85
	sta.w ScratchBuf+$6,x
	sep #$20
	lda.b $81
	sta.w ScratchBuf+$4,x
	lda.b d1
	sta.w ScratchBuf+$5,x
	lda.b d2
	sta.w ScratchBuf+$8,x
	lda.b $89
	sta.w ScratchBuf+$9,x
	rep #$20
	lda.b d4
	sta.w ScratchBuf+$E,x
	lda.b $8D
	sta.w ScratchBuf+$C,x
	lda.b d3
	sta.w ScratchBuf+$A,x
	ldx.w #$0064
	jsl.l Mul16x8U
	lda.b d4
	clc
	adc.b $8D
	bne .3
	lda.w #$0064
	bra .4
.3:									; A + d3, r1 = A, call Div32U_hi0entry, A = r0
	adc.b d3
	sta.b r1
	jsl.l Div32U_hi0entry
	lda.b r0
.4:									; X = a4, ScratchBuf+$10,x = A, A = X, A + $0020, ...
	ldx.b a4
	sta.w ScratchBuf+$10,x
	txa
	clc
	adc.w #$0020
	tax
	bra .6
.5:									; X = a4
	ldx.b a4
.6:									; pull A, A + 1, if A = $0008 go to .7, go to .1
	pla
	inc a
	cmp.w #$0008
	beq .7
	jmp.w .1
.7:									; A = X, A / 2, A / 2, A / 2, ...
	txa
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b a1
	lda.b a1
	sta.b tmp0
	beq .8
	lda.w #$FFFF
	sta.w ListBuf
	lda.w #$002D
	ldx.w #ListBuf
	ldy.w #ListBuf+$2
	mvn $7E,$7E
	ldx.w #$0000
.loop2:								; loop: tmp1 = X, A = ScratchBuf+$10,x, call InsertWinRecord, ...
	stx.b tmp1
	lda.w ScratchBuf+$10,x
	jsr.w InsertWinRecord
	lda.w ScratchBuf+$2,x
	jsr.w InsertGoalRecord
	lda.w ScratchBuf+$6,x
	jsr.w InsertSaveRecord
	txa
	clc
	adc.w #$0020
	tax
	dec.b tmp0
	bne .loop2
.8:									; A = $545F, call PrintTextPage
	lda.w #$545F
	jsl.l PrintTextPage
.9:									; if a1 is not 0 go to .10, $CF = $0010, $D1 = $00F0, $D5 = $2400, ...
	lda.b a1
	bne .10
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w #$2400
	sta.b $D5
	ldx.w #$4D98
	ldy.w #$0006
	jsl.l PrintBoldCentred
	lda.w #$2000
	sta.b $D5
	bra .11
.10:								; A = $D3, A + $0180, Y = $02C0, call ClearRAM7E, ...
	lda.b $D3
	clc
	adc.w #$0180
	ldy.w #$02C0
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsl.l WaitTransfers
	ldx.b $7D
	jsr (DATA8_C57DCD,x)
.11:								; call SendTextMap, call WaitTransfers, fadestep = 0
	jsl.l SendTextMap
	jsl.l WaitTransfers
	stz.w fadestep
.loop3:								; loop: TransfersReady + 1, call ReadMenuPads, $26 + 1, ...
	inc.w TransfersReady
	wai
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
	bne .loop3
	lda.w padchangeany
	bit.w #$1000
	beq .12
	jmp.w ExitToPauseMenu
.12:								; if a1 = 0 go to .loop3, if $0100 bits clear go to .14, A = $7D, ...
	ldx.b a1
	beq .loop3
	bit.w #$0100
	beq .14
	lda.b $7D
	inc a
	inc a
	cmp.w #$0006
	bcc .13
	lda.w #$0000
.13:								; $7D = A, go to .9
	sta.b $7D
	jmp.w .9
.14:								; if $0200 bits clear go to .loop3, A = $7D, A - 1, A - 1, ...
	bit.w #$0200
	beq .loop3
	lda.b $7D
	dec a
	dec a
	bpl .13
	lda.w #$0004
	bra .13
DATA8_C57DCD:						; jump table: the routine for each index
	dw PrintWinRecords,PrintGoalRecords,PrintSaveRecords
InsertWinRecord:					; puts user record tmp1 in the win page's order list before the first one
									; whose win % is not above A (the rest moved down); X = tmp1
	ldy.w #$0000
.loop:								; loop: if ListBuf,y < 0 go to .2, if A >= ScratchBuf+$10,x go to .1, ...
	ldx.w ListBuf,y
	bmi .2
	cmp.w ScratchBuf+$10,x
	bcs .1
	iny
	iny
	cpy.w #$000E
	bcc .loop
.1:									; push Y, Y = ListBuf+$F, X = ListBuf+$D, A = $000D, ...
	phy
	ldy.w #ListBuf+$F
	ldx.w #ListBuf+$D
	sec
	lda.w #$000D
	sbc.b $01,s
	mvp $7E,$7E
	ply
.2:									; ListBuf,y = tmp1, X = A, return
	lda.b tmp1
	sta.w ListBuf,y
	tax
	rts
InsertGoalRecord:					; puts user record tmp1 in the goal page's order list before the first one
									; whose goals are not above A (the rest moved down); X = tmp1
	ldy.w #$0000
.loop:								; loop: if ListBuf+$10,y < 0 go to .2, ...
	ldx.w ListBuf+$10,y
	bmi .2
	cmp.w ScratchBuf+$2,x
	bcs .1
	iny
	iny
	cpy.w #$000E
	bcc .loop
.1:									; push Y, Y = ListBuf+$1F, X = ListBuf+$1D, A = $000D, ...
	phy
	ldy.w #ListBuf+$1F
	ldx.w #ListBuf+$1D
	sec
	lda.w #$000D
	sbc.b $01,s
	mvp $7E,$7E
	ply
.2:									; ListBuf+$10,y = tmp1, X = A, return
	lda.b tmp1
	sta.w ListBuf+$10,y
	tax
	rts
InsertSaveRecord:					; puts user record tmp1 in the save page's order list before the first one
									; whose saves are not above A (the rest moved down); X = tmp1
	ldy.w #$0000
.loop:								; loop: if ListBuf+$20,y < 0 go to .2, ...
	ldx.w ListBuf+$20,y
	bmi .2
	cmp.w ScratchBuf+$6,x
	bcs .1
	iny
	iny
	cpy.w #$000E
	bcc .loop
.1:									; push Y, Y = ListBuf+$2F, X = ListBuf+$2D, A = $000D, ...
	phy
	ldy.w #ListBuf+$2F
	ldx.w #ListBuf+$2D
	sec
	lda.w #$000D
	sbc.b $01,s
	mvp $7E,$7E
	ply
.2:									; ListBuf+$20,y = tmp1, X = A, return
	lda.b tmp1
	sta.w ListBuf+$20,y
	tax
	rts
PrintWinRecords:					; Record Holders page 0: name, win %, wins, losses, ties of each user
	lda.w #$0010
	sta.b $CF
	lda.w #$0060
	sta.b $D1
	ldx.w #$4DA4
	jsr.w PrintHeadRow6
	lda.w #$0088
	sta.b $D1
	ldx.w #$4DA8
	jsr.w PrintHeadRow6
	lda.w #$00A8
	sta.b $D1
	ldx.w #$4DAD
	jsr.w PrintHeadRow6
	lda.w #$00C8
	sta.b $D1
	ldx.w #$4DB1
	jsr.w PrintHeadRow6
	lda.w #$00E8
	sta.b $D1
	ldx.w #$4DB5
	jsr.w PrintHeadRow6
	lda.w #$0008
	sta.b $6D
	lda.w #$0000
.loop:								; loop: $65 = A, call PrintWinRecordRow, $6D + 1, A = $65, ...
	sta.b $65
	jsr.w PrintWinRecordRow
	inc.b $6D
	lda.b $65
	inc a
	cmp.b a1
	bne .loop
	rts
PrintWinRecordRow:					; win page row A on text row $6D: the user's name, win %, wins, losses and
									; ties of the record the win order list gives
	ldx.w #$0010
	stx.b $CF
	ldx.w #$0060
	stx.b $D1
	asl a
	tax
	lda.w ListBuf,x
	sta.b a3
	adc.w #ScratchBuf+$12
	tax
	ldy.b $6D
	jsr.w PrintWinRecordCell
	ldx.b a3
	lda.w #$0088
	sta.b $D1
	lda.w ScratchBuf+$10,x
	jsr.w PrintWinRecordNumber
	lda.w #$00A8
	sta.b $D1
	lda.w ScratchBuf+$A,x
	jsr.w PrintWinRecordNumber
	lda.w #$00C8
	sta.b $D1
	lda.w ScratchBuf+$E,x
	jsr.w PrintWinRecordNumber
	lda.w #$00E8
	sta.b $D1
	lda.w ScratchBuf+$C,x
PrintWinRecordNumber:				; A as a number (BinToBCD, BCDText) centred in the cell $CF-$D1 on row
									; $6D, then $CF = $D1 and X = a3
	jsr.w BinToBCD
	jsr.w BCDText
	ldx.w #mesarea
	ldy.b $6D
PrintWinRecordCell:					; PrintBoldCentredStr of X on row Y, then the next column ($D1) becomes
									; the current one ($CF) and X = a3
	jsl.l PrintBoldCentredStr
	lda.b $D1
	sta.b $CF
	ldx.b a3
	rts
PrintGoalRecords:					; Record Holders page 1: the users' goal records (name, Goals)
	lda.w #$0010
	sta.b $CF
	lda.w #$0060
	sta.b $D1
	ldx.w #$4DA4
	jsr.w PrintHeadRow6
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4B6A
	jsr.w PrintHeadRow6
	lda.w #$0008
	sta.b $6D
	lda.w #$0000
.loop:								; loop: $65 = A, call PrintGoalRecordRow, $6D + 1, A = $65, ...
	sta.b $65
	jsr.w PrintGoalRecordRow
	inc.b $6D
	lda.b $65
	inc a
	cmp.b a1
	bne .loop
CODE_C57F36:						; from PrintGoalRecordRow
	dec.b $6D
	rts
PrintGoalRecordRow:					; goal record A on row $6D: the holder's name, then the goals 'by' the
									; team 'vs' the other team; nothing (row $6D taken back) when the record's
									; wins are 0
	asl a
	tax
	lda.w ListBuf+$10,x
	sta.b a3
	tax
	ldy.w ScratchBuf+$A,x
	beq CODE_C57F36
	ldx.w #$0010
	stx.b $CF
	ldx.w #$0060
	stx.b $D1
	adc.w #ScratchBuf+$12
	tax
	ldy.b $6D
	jsr.w PrintGoalRecordCell
	lda.w #$00F0
	sta.b $D1
	ldx.b a3
	lda.w ScratchBuf+$2,x
	jsr.w BinToBCD
	jsr.w BCDText
	lda.w #$6220
	sta.w mesarea,x
	inx
	inx
	lda.w #$2079
	sta.w mesarea,x
	inx
	inx
	phx
	ldy.b a3
	lda.w ScratchBuf+$4,y
	and.w #$00FF
	tax
	jsr.w TeamNumSecondText
	jsl.l UnpackText
	ply
	jsr.w AppendGoalMesarea
	lda.w #$7620
	sta.w mesarea,y
	iny
	iny
	lda.w #$2073
	sta.w mesarea,y
	iny
	iny
	phy
	ldy.b a3
	lda.w ScratchBuf+$5,y
	and.w #$00FF
	tax
	jsr.w TeamNumSecondText
	jsl.l UnpackText
	ply
	jsr.w AppendGoalMesarea
	lda.w #$0000
	sta.w mesarea,y
	ldx.w #mesarea
	ldy.b $6D
PrintGoalRecordCell:				; PrintBoldCentredStr, then the next column ($D1) becomes the current one
									; ($CF)
	jsl.l PrintBoldCentredStr
	lda.b $D1
	sta.b $CF
	rts
AppendGoalMesarea:					; copies the zero ended string at X to mesarea + Y (no zero after it); Y =
									; its end
	sep #$20
.loop:								; loop: if $0000,x = 0 go to .1, mesarea,y = A, X + 1, Y + 1, ...
	lda.w $0000,x
	beq .1
	sta.w mesarea,y
	inx
	iny
	bra .loop
.1:									; A 16-bit, return
	rep #$20
	rts
PrintSaveRecords:					; Record Holders page 2: the users' save records (name, Saves)
	lda.w #$0010
	sta.b $CF
	lda.w #$0060
	sta.b $D1
	ldx.w #$4DA4
	jsr.w PrintHeadRow6
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4B7A
	jsr.w PrintHeadRow6
	lda.w #$0008
	sta.b $6D
	lda.w #$0000
.loop:								; loop: $65 = A, call PrintSaveRecordRow, $6D + 1, A = $65, ...
	sta.b $65
	jsr.w PrintSaveRecordRow
	inc.b $6D
	lda.b $65
	inc a
	cmp.b a1
	bne .loop
	dec.b $6D
	rts

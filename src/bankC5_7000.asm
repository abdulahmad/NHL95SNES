; Segment bankC5_7000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C56F5C
CODE_C56F5C:						; called from other segments
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
	jsr.w CODE_C56009
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
	jsr.w CODE_C56009
	ldy.w #$000B
	jsl.l PrintBoldLeftStr
	lda.w #$000D
	sta.b $6D
	stz.b a3
	ldx.w #$2DC9
	lda.b a2
	beq .5
	ldx.w #$3207
.5:									; a0 = X, if $79 is not 0 go to CODE_C5705C, $91 = $0010
	stx.b a0
	lda.b $79
	bne CODE_C5705C
	lda.w #$0010
	sta.b $91
CODE_C56FF5:						; from CODE_C5704D
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
	pea.w CODE_C5704D-1
	jmp (DATA8_C570E8,x)
CODE_C5704D:						; from CODE_C56FF5
	inc.b $6D
	lda.b a3
	inc a
	sta.b a3
	ldx.b a0
	cmp.w $0002,x
	bne CODE_C56FF5
	rts
CODE_C5705C:						; from CODE_C56F5C
	stz.b $91
CODE_C5705E:						; from CODE_C570CC
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
	pea.w CODE_C570CC-1
	jmp (DATA8_C570E8,x)
CODE_C570CC:						; from CODE_C5705E
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
.1:									; go to CODE_C5705E
	jmp.w CODE_C5705E
DATA8_C570E8:						; jump table: the routine for each index
	dw CODE_C570F4,AttribEnergy,CODE_C57187,CODE_C5719B
	dw $0000,CODE_C571B4
CODE_C570F4:						; from DATA8_C570E8
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
.3:									; push A, A and $0FFF, call CODE_C5605D, pull A, ...
	pha
	and.w #$0FFF
	jsr.w CODE_C5605D
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
CODE_C57187:						; from DATA8_C570E8
	jsr.w CODE_C571CB
	and.w #$0001
	asl a
	tax
	lda.l PhotoPaletteTable-4,x
	tax
	ldy.b $6D
	jsl.l PrintBoldCentred
	rts
CODE_C5719B:						; from DATA8_C570E8
	jsr.w CODE_C571CB
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
CODE_C571B4:						; from DATA8_C570E8
	jsr.w CODE_C571CB
	jsr.w BinToBCD
	jsr.w BCDText
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	rts
CODE_C571C7:						; called from other segments
	jsr.w CODE_C571CB
	rtl
CODE_C571CB:						; from CODE_C571C7, CODE_C57187, CODE_C5719B, CODE_C571B4
	stz.b $81
	ldx.w #$2DC9
	lda.b d0
	asl a
	adc.b d0
	asl a
	asl a
	ldy.b a2
	beq .1
	adc.w #$0138
	ldx.w #$3207
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
.6:									; A and $000F, d3 = A, if $24DC = 0 go to .9, A = d2, ...
	and.w #$000F
	sta.b d3
	lda.w $24DC
	beq .9
	lda.b d2
	dec a
	dec a
	dec a
	cmp.w #$0006
	bcc .7
	dec a
.7:									; A + $89, X = A, A = $1543,x, A and $00FF, ...
	clc
	adc.b $89
	tax
	lda.w $1543,x
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
DATA8_C57309:						; not traced: a table read by CODE_C571CB
	db $00,$00,$01,$02,$03,$03,$02,$01,$02,$01,$03,$02,$01,$01,$01,$01
	db $00,$00,$00,$09,$02,$02,$09,$09,$02,$02,$02,$02,$02,$02,$02,$02
PauseReplay:						; pause menu Inst Replay: fade out, the game state kept, vcountmark+2 set
									; back two, ReplayMode, then back to the pause screen's exit
	jsl.l FadeOutWait
	lda.w $18EE
	sta.w $18E0
	sta.b $08
	stz.b $22
	ldx.w $18F0
	jsl.l DeleteSprite
	jsl.l CODE_C558D7
	jsl.l CODE_C55513
	pei ($9B)
	lda.b $5F
	dec a
	dec a
	sta.w vcountmark+2
	lda.w $17D1
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
	jsr.w CODE_C55E57
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
.3:									; A = $537F, call PrintTextPage, X = $2DC9, Y = $17DB, ...
	lda.w #$537F
	jsl.l PrintTextPage
	ldx.w #$2DC9
	ldy.w #$17DB
	lda.b a2
	beq .4
	ldx.w #$3207
	ldy.w #$1813
.4:									; a0 = X, $65 = Y
	stx.b a0
	sty.b $65
.5:									; call CODE_C574A4
	jsr.w CODE_C574A4
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
	jsr.w CODE_C5755C
	lda.w #$2400
	sta.b d0
	lda.b $69
	clc
	adc.w #$000D
	jsr.w CODE_C5755C
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
.13:								; if $8000 bits clear go to .14, call CODE_C57578, go to .2
	bit.w #$8000
	beq .14
	jsr.w CODE_C57578
	jmp.w .2
.14:								; go to .loop
	jmp.w .loop
.15:								; go to ExitToPauseMenu
	jmp.w ExitToPauseMenu
CODE_C574A4:						; from EditLinesScreen
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
.3:									; $D5 = X, call CODE_C57509, $6D + 1, A = a3, ...
	stx.b $D5
	jsr.w CODE_C57509
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
CODE_C57509:						; from CODE_C574A4
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
CODE_C5755C:						; from EditLinesScreen, CODE_C57779
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
CODE_C57578:						; from EditLinesScreen
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
	sta.w $24DC
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
.2:									; A = CODE_C576FD, X = $000A, Y = $000E, call StartScrollList, ...
	lda.w #CODE_C576FD
	ldx.w #$000A
	ldy.w #$000E
	jsr.w StartScrollList
	jsr.w CODE_C577C3
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
.6:									; call CODE_C57779, go to .loop
	jsr.w CODE_C57779
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
.9:									; call CODE_C576CC, call CODE_C577C3, call CODE_C55C12, call SendTextMap
	jsr.w CODE_C576CC
	jsr.w CODE_C577C3
	jsr.w CODE_C55C12
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
	jsr.w CODE_C577F7
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
CODE_C576CC:						; from CODE_C57578
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
CODE_C576FD:						; a callback: CODE_C57578 passes it to StartScrollList
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
	pea.w CODE_C57773-1
	jmp (DATA8_C570E8,x)
CODE_C57773:						; from CODE_C576FD
	lda.w #$2000
	sta.b $D5
	rts
CODE_C57779:						; from CODE_C57578
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
.1:									; A + a4, call CODE_C5755C, d0 = $2400, A = $7B
	clc
	adc.b a4
	jsr.w CODE_C5755C
	lda.w #$2400
	sta.b d0
	lda.b $7B
.loop2:								; loop: if A < tmp1 go to .2, A - tmp2, if the result >= 0 go to .loop2
	cmp.b tmp1
	bcc .2
	sbc.b tmp2
	bpl .loop2
.2:									; A + a4, call CODE_C5755C, call SendTextMap, call WaitTransfers, ...
	clc
	adc.b a4
	jsr.w CODE_C5755C
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
CODE_C577C3:						; from CODE_C57578
	lda.w #$000C
	sta.b $6D
	jsr.w CODE_C55D73
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
CODE_C577F7:						; from CODE_C57578
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
DATA8_C57810:						; the routines CODE_C577F7 jumps to through a pointer, by index
	dw CODE_C5781A,CODE_C5782F,CODE_C57844,CODE_C57868
	dw CODE_C5788C
CODE_C5781A:						; from DATA8_C57810
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
CODE_C5782F:						; from DATA8_C57810
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
CODE_C57844:						; from DATA8_C57810
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
CODE_C57868:						; from DATA8_C57810
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
CODE_C5788C:						; from DATA8_C57810
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
	jsr.w CODE_C55E57
	stz.b $7D
	ldx.w #$2DC9
	lda.b a2
	beq .1
	ldx.w #$3207
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
.loop:								; loop: call CODE_C57997, call SendTextMap, fadestep = 0
	jsr.w CODE_C57997
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
CODE_C57997:						; from PauseGoalie
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
	sta.w $24DC
CODE_C579F4:						; from CODE_C57A4D
	jsr.w CODE_C55D73
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
	pea.w CODE_C57A4D-1
	jmp (DATA8_C570E8,x)
CODE_C57A4D:						; from CODE_C579F4
	inc.b $6D
	lda.b a3
	inc a
	sta.b a3
	cmp.b a1
	bne CODE_C579F4
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
									; row); from the pause menu, and from CODE_C5AF07 with X: EXIT MENU
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
	lda.l $306050
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
	lda.l $3075B4
	inc a
	and.w #$00FF
	jsr.w BinToBCD
	plx
	jsr.w BCDTextAt
	stz.w mesarea,x
	bra .2
.1:									; A = Y, call CODE_C56168
	tya
	jsr.w CODE_C56168
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
.3:									; d0 = $2C42, X = $0000, Y = X
	lda.w $2C42
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
	pea.w CODE_C54F37
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
.1:									; a4 = X, push A, $364E,x = A, call CODE_C5D2B4, ...
	stx.b a4
	pha
	sta.w $364E,x
	jsr.w CODE_C5D2B4
	cpx.w #$0000
	beq .2
	ldy.w #$0000
	ldx.b a4
.loop:								; loop: A = mesarea,y, A and $00FF, $3660,x = A, X + 1, ...
	lda.w mesarea,y
	and.w #$00FF
	sta.w $3660,x
	inx
	iny
	cpy.w #$000C
	bne .loop
	lda.b $01,s
	jsr.w CODE_C5D6F5
	lda.b d4
	clc
	adc.b $8D
	adc.b d3
.2:									; if zero go to .5, X = a4, $3650,x = d0, $3654,x = $85, ...
	beq .5
	ldx.b a4
	lda.b d0
	sta.w $3650,x
	lda.b $85
	sta.w $3654,x
	sep #$20
	lda.b $81
	sta.w $3652,x
	lda.b d1
	sta.w $3653,x
	lda.b d2
	sta.w $3656,x
	lda.b $89
	sta.w $3657,x
	rep #$20
	lda.b d4
	sta.w $365C,x
	lda.b $8D
	sta.w $365A,x
	lda.b d3
	sta.w $3658,x
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
.4:									; X = a4, $365E,x = A, A = X, A + $0020, ...
	ldx.b a4
	sta.w $365E,x
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
	sta.w $3E4E
	lda.w #$002D
	ldx.w #$3E4E
	ldy.w #$3E50
	mvn $7E,$7E
	ldx.w #$0000
.loop2:								; loop: tmp1 = X, A = $365E,x, call CODE_C57DD3, A = $3650,x, ...
	stx.b tmp1
	lda.w $365E,x
	jsr.w CODE_C57DD3
	lda.w $3650,x
	jsr.w CODE_C57DFF
	lda.w $3654,x
	jsr.w CODE_C57E2B
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
CODE_C57DD3:						; from RecordHoldersScreen
	ldy.w #$0000
.loop:								; loop: if $3E4E,y < 0 go to .2, if A >= $365E,x go to .1, Y + 1, ...
	ldx.w $3E4E,y
	bmi .2
	cmp.w $365E,x
	bcs .1
	iny
	iny
	cpy.w #$000E
	bcc .loop
.1:									; push Y, Y = $3E5D, X = $3E5B, A = $000D, ...
	phy
	ldy.w #$3E5D
	ldx.w #$3E5B
	sec
	lda.w #$000D
	sbc.b $01,s
	mvp $7E,$7E
	ply
.2:									; $3E4E,y = tmp1, X = A, return
	lda.b tmp1
	sta.w $3E4E,y
	tax
	rts
CODE_C57DFF:						; from RecordHoldersScreen
	ldy.w #$0000
.loop:								; loop: if $3E5E,y < 0 go to .2, if A >= $3650,x go to .1, Y + 1, ...
	ldx.w $3E5E,y
	bmi .2
	cmp.w $3650,x
	bcs .1
	iny
	iny
	cpy.w #$000E
	bcc .loop
.1:									; push Y, Y = $3E6D, X = $3E6B, A = $000D, ...
	phy
	ldy.w #$3E6D
	ldx.w #$3E6B
	sec
	lda.w #$000D
	sbc.b $01,s
	mvp $7E,$7E
	ply
.2:									; $3E5E,y = tmp1, X = A, return
	lda.b tmp1
	sta.w $3E5E,y
	tax
	rts
CODE_C57E2B:						; from RecordHoldersScreen
	ldy.w #$0000
.loop:								; loop: if $3E6E,y < 0 go to .2, if A >= $3654,x go to .1, Y + 1, ...
	ldx.w $3E6E,y
	bmi .2
	cmp.w $3654,x
	bcs .1
	iny
	iny
	cpy.w #$000E
	bcc .loop
.1:									; push Y, Y = $3E7D, X = $3E7B, A = $000D, ...
	phy
	ldy.w #$3E7D
	ldx.w #$3E7B
	sec
	lda.w #$000D
	sbc.b $01,s
	mvp $7E,$7E
	ply
.2:									; $3E6E,y = tmp1, X = A, return
	lda.b tmp1
	sta.w $3E6E,y
	tax
	rts
PrintWinRecords:					; Record Holders page 0: name, win %, wins, losses, ties of each user
	lda.w #$0010
	sta.b $CF
	lda.w #$0060
	sta.b $D1
	ldx.w #$4DA4
	jsr.w CODE_C580AB
	lda.w #$0088
	sta.b $D1
	ldx.w #$4DA8
	jsr.w CODE_C580AB
	lda.w #$00A8
	sta.b $D1
	ldx.w #$4DAD
	jsr.w CODE_C580AB
	lda.w #$00C8
	sta.b $D1
	ldx.w #$4DB1
	jsr.w CODE_C580AB
	lda.w #$00E8
	sta.b $D1
	ldx.w #$4DB5
	jsr.w CODE_C580AB
	lda.w #$0008
	sta.b $6D
	lda.w #$0000
.loop:								; loop: $65 = A, call CODE_C57EAA, $6D + 1, A = $65, ...
	sta.b $65
	jsr.w CODE_C57EAA
	inc.b $6D
	lda.b $65
	inc a
	cmp.b a1
	bne .loop
	rts
CODE_C57EAA:						; from PrintWinRecords
	ldx.w #$0010
	stx.b $CF
	ldx.w #$0060
	stx.b $D1
	asl a
	tax
	lda.w $3E4E,x
	sta.b a3
	adc.w #$3660
	tax
	ldy.b $6D
	jsr.w CODE_C57EFA
	ldx.b a3
	lda.w #$0088
	sta.b $D1
	lda.w $365E,x
	jsr.w CODE_C57EEF
	lda.w #$00A8
	sta.b $D1
	lda.w $3658,x
	jsr.w CODE_C57EEF
	lda.w #$00C8
	sta.b $D1
	lda.w $365C,x
	jsr.w CODE_C57EEF
	lda.w #$00E8
	sta.b $D1
	lda.w $365A,x
CODE_C57EEF:						; from CODE_C57EAA
	jsr.w BinToBCD
	jsr.w BCDText
	ldx.w #mesarea
	ldy.b $6D
CODE_C57EFA:						; from CODE_C57EAA
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
	jsr.w CODE_C580AB
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4B6A
	jsr.w CODE_C580AB
	lda.w #$0008
	sta.b $6D
	lda.w #$0000
.loop:								; loop: $65 = A, call CODE_C57F39, $6D + 1, A = $65, ...
	sta.b $65
	jsr.w CODE_C57F39
	inc.b $6D
	lda.b $65
	inc a
	cmp.b a1
	bne .loop
CODE_C57F36:						; from CODE_C57F39
	dec.b $6D
	rts
CODE_C57F39:						; from PrintGoalRecords
	asl a
	tax
	lda.w $3E5E,x
	sta.b a3
	tax
	ldy.w $3658,x
	beq CODE_C57F36
	ldx.w #$0010
	stx.b $CF
	ldx.w #$0060
	stx.b $D1
	adc.w #$3660
	tax
	ldy.b $6D
	jsr.w CODE_C57FBE
	lda.w #$00F0
	sta.b $D1
	ldx.b a3
	lda.w $3650,x
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
	lda.w $3652,y
	and.w #$00FF
	tax
	jsr.w CODE_C580B7
	jsl.l UnpackText
	ply
	jsr.w CODE_C57FC7
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
	lda.w $3653,y
	and.w #$00FF
	tax
	jsr.w CODE_C580B7
	jsl.l UnpackText
	ply
	jsr.w CODE_C57FC7
	lda.w #$0000
	sta.w mesarea,y
	ldx.w #mesarea
	ldy.b $6D
CODE_C57FBE:						; from CODE_C57F39
	jsl.l PrintBoldCentredStr
	lda.b $D1
	sta.b $CF
	rts
CODE_C57FC7:						; from CODE_C57F39
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
	jsr.w CODE_C580AB
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4B7A
	jsr.w CODE_C580AB
	lda.w #$0008
	sta.b $6D
	lda.w #$0000
.loop:								; loop: $65 = A, call CODE_C5800C, $6D + 1, A = $65, ...
	sta.b $65
	jsr.w CODE_C5800C
	inc.b $6D
	lda.b $65
	inc a
	cmp.b a1
	bne .loop
	dec.b $6D
	rts

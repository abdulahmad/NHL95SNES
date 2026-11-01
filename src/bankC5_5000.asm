; Segment bankC5_5000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C54F05
CODE_C54F05:						; called from other segments
	lda.w padchangeany
	bit.w #$0200
	beq .1
	ldx.w $18F2
	beq .1
	cpx.w #$0003
	bcs .1
	dex
	bra CODE_C54F94
.1:									; if $0100 bits clear go to .2, X = $18F2, X + 1, ...
	bit.w #$0100
	beq .2
	ldx.w $18F2
	inx
	cpx.w #$0003
	bcc CODE_C54F94
.2:									; if a $0800 bit set go to CODE_C54F78, ...
	bit.w #$0800
	bne CODE_C54F78
	bit.w #$0400
	bne CODE_C54F86
	bit.w #$8000
	bne CODE_C54F38
CODE_C54F37:						; from CODE_C54F94, CODE_C54F78, CODE_C54F86
	rts
CODE_C54F38:						; from CODE_C54F05
	lda.w OptPlayMode
	cmp.w #$0001
	bne .4
	lda.w $18F6
	asl a
	tax
	lda.w $18F2
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
.4:									; A = $18F6, A * 2, X = A, if $18F2 = 0 go to .7, ...
	lda.w $18F6
	asl a
	tax
	lda.w $18F2
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
CODE_C54F78:						; from CODE_C54F05
	lda.w $18F6
	beq CODE_C54F37
	dec a
	sta.w $18F6
CODE_C54F81:						; from CODE_C54F86
	lda.w $18F2
	bra CODE_C54FA9
CODE_C54F86:						; from CODE_C54F05
	lda.w $18F6
	inc a
	cmp.w $18F4
	bcs CODE_C54F37
	sta.w $18F6
	bra CODE_C54F81
CODE_C54F94:						; from CODE_C54F05 and other segments
	cpx.w $18F2
	beq CODE_C54F37
	phx
	bit.w $18F2
	bmi .1
	jsr.w CODE_C5524B
.1:									; pull A, $18F2 = A, $18F6 = 0
	pla
	sta.w $18F2
	stz.w $18F6
CODE_C54FA9:						; from CODE_C54F81
	asl a
	tax
	lda.w OptPlayMode
	cmp.w #$0001
	bne .1
	lda.l DATA8_C5500A,x
	bra .2
.1:									; A = DATA8_C55002,x
	lda.l DATA8_C55002,x
.2:									; call CODE_C552A4, call CODE_C55256, A = $18F6, A / 2, ...
	jsr.w CODE_C552A4
	jsr.w CODE_C55256
	lda.w $18F6
	xba
	lsr a
	adc.w $18EE
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
	lda.w $18EE
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jmp.w CODE_C55367
DATA8_C55002:						; the item list (bank $C3) of each pause menu tab: Info, Stats, Options,
									; the quit prompt; CODE_C54FA9
	db $CB,$5C,$EF,$5C,$07,$5D,$21,$5D
DATA8_C5500A:						; the same in game mode 1: shorter Info and Options lists; CODE_C54FA9
	db $E1,$5C,$EF,$5C,$FD,$5C,$21,$5D
DATA8_C55012:						; game mode 1, Info tab: Team Roster, Score Summry, Records (CODE_C54F38
									; jumps through it)
	dw TeamRoster,ShowScoringSummary,RecordHoldersScreen
DATA8_C55018:						; game mode 1, Options tab: Inst Replay, Quit Game
	dw PauseReplay,CODE_C56B80
DATA8_C5501C:						; pause menu Info tab: Team Roster, Score Summry, Penalties, Records,
									; Other Scores (CODE_C54F38)
	dw TeamRoster,ShowScoringSummary,ShowPenaltySummary,RecordHoldersScreen
	dw ShowOtherScores
DATA8_C55026:						; pause menu Stats tab: Game Stats, Period Stats, Player Stats
	dw ShowGameStats,ShowPeriodStats,ShowPlayerStats
DATA8_C5502C:						; pause menu Options tab: Inst Replay, Edit Lines, Chnge Goalie, the
									; goalie mode, Time Out, Quit Game
	dw PauseReplay,EditLinesScreen,PauseGoalie,PauseGoalieMode
	dw PauseTimeout,CODE_C56B80
DATA8_C55038:						; the quit prompt: Resume Game (back to the Options tab), Quit Game
	dw CODE_C56B7B,CODE_C56B8C
CODE_C5503C:						; called from other segments
	jsl.l forceblack
	jsl.l WaitTransfers
	jsl.l RestoreWorkBuf
	lda.w #$FFFF
	sta.w pausemenuon
	sta.w $18F2
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
	sta.w $18EE
	sta.b r1
	jsl.l MarkWorkBuf
	lda.w #$007E
	sta.b $32
	lda.w #PauseScreenMap&$FFFF
	ldx.w #PauseScreenMap>>16
	jsl.l MapSetToWRAM
	lda.w #$012A
	ldy.w #$0523
	jsr.w CODE_C5522E
	lda.w #$016A
	ldy.w #$052D
	jsr.w CODE_C5522E
	lda.w #$0102
	ldy.w #$0537
	jsr.w CODE_C5522E
	lda.w #$0142
	ldy.w #$0541
	jsr.w CODE_C5522E
	ldy.w #$045F
	ldx.w $18EE
	clc
.loop:								; loop: A = $7E0000,x, A + $1420, $7E0000,x = A, X + 1, ...
	lda.l $7E0000,x
	adc.w #$1420
	sta.l $7E0000,x
	inx
	inx
	dey
	bpl .loop
CODE_C550E2:						; from ExitToPauseMenu
	jsl.l CODE_C5E50E
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
	lda.w $18EE
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
	lda.w $17C9
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
	lda.w $17CB
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
	jsr.w CODE_C5547C
	jsr.w CODE_C55367
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
CODE_C5522E:						; from CODE_C5503C
	clc
	adc.w $18EE
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
DATA8_C55245:						; not traced: a table read by CODE_C550E2
	db $62,$01,$7D,$01,$97,$01
CODE_C5524B:						; from CODE_C54F94
	lda.w $18F2
	asl a
	tax
	lda.l DATA8_C5529C,x
	bra CODE_C5525F
CODE_C55256:						; from CODE_C54FA9
	lda.w $18F2
	asl a
	tax
	lda.l DATA8_C55294,x
CODE_C5525F:						; from CODE_C5524B
	adc.w $18EE
	tay
	lda.l DATA8_C5528C,x
	adc.w $18EE
	tax
	jsr.w CODE_C55278
	txa
	adc.w #$0030
	tax
	tya
	adc.w #$0030
	tay
CODE_C55278:						; from CODE_C5525F
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
DATA8_C5528C:						; not traced: a table read by CODE_C5525F
	db $44,$00,$58,$00,$6C,$00,$6C,$00
DATA8_C55294:						; not traced: a table read by CODE_C55256
	db $C0,$07,$D0,$07,$E0,$07,$E0,$07
DATA8_C5529C:						; not traced: a table read by CODE_C5524B
	db $40,$08,$50,$08,$60,$08,$60,$08
CODE_C552A4:						; from CODE_C54FA9
	pha
	ldx.w #$5D41
	jsr.w CODE_C552AC
	plx
CODE_C552AC:						; from CODE_C552A4
	lda.w #$00C3
	sta.b $2E
	ldy.w #$0314
	lda.l $C30000,x
	sta.w $18F4
	sta.b tmp0
CODE_C552BD:						; from CODE_C552CE
	phx
	phy
	lda.l $C30002,x
	beq .1
	sta.b r0
	jmp ($002C)
.1:									; A = $C30004,x
	lda.l $C30004,x
CODE_C552CE:						; from CODE_C55308, CODE_C55320, CODE_C55346
	sta.b r0
	cmp.w #$0000
	beq .1
	tya
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
CODE_C55308:						; no caller found (not traced)
	phy
	phx
	jsl.l GetPadTeam
	lda.w #$59FC
	ldx.b a2
	ldy.w goaliemode1,x
	beq .1
	lda.w #$59EF
.1:									; pull X, pull Y, go to CODE_C552CE
	plx
	ply
	jmp.w CODE_C552CE
CODE_C55320:						; no caller found (not traced)
	phy
	phx
	jsl.l GetPadTeam
	lda.w #$5A08
	ldx.b a2
	ldy.w tmtimeouts,x
	bne .2
	dec.w $18F4
	ldy.w $18F6
	cpy.w $18F4
	bcc .1
	dec.w $18F6
.1:									; A = $0000
	lda.w #$0000
.2:									; pull X, pull Y, go to CODE_C552CE
	plx
	ply
	jmp.w CODE_C552CE
CODE_C55346:						; no caller found (not traced)
	phx
	lda.w #$5991
	ldx.w OptPlayMode
	cpx.w #$0002
	beq .2
	dec.w $18F4
	ldy.w $18F6
	cpy.w $18F4
	bcc .1
	dec.w $18F6
.1:									; A = $0000
	lda.w #$0000
.2:									; pull X, go to CODE_C552CE
	plx
	jmp.w CODE_C552CE
CODE_C55367:						; from CODE_C550E2, CODE_C54FA9
	lda.w #$0017
	sta.b tmp1
	lda.w #$01A0
	sta.b tmp2
	lda.w #$0000
	jsr.w CODE_C5538C
	lda.w #$0001
	sta.b tmp1
	lda.w #$01A0
	sta.b tmp2
	lda.w #$001A
	jsr.w CODE_C5538C
	jsl.l WaitTransfers
	rts
CODE_C5538C:						; from CODE_C55367
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
	jsr.w CODE_C553CC
	bra .loop
.1:									; pull Y
	ply
.loop2:								; loop: A = tmboxlist,y, Y + 1, A and $00FF, ...
	lda.w tmboxlist,y
	iny
	and.w #$00FF
	bit.w #$0080
	bne CODE_C553D5
	clc
	adc.b $A5
	tax
	lda.w tmpdst,x
	bit.w #$4000
	beq .loop2
	jsr.w CODE_C553CC
	bra .loop2
CODE_C553CC:						; from CODE_C5538C
	phy
	ldy.b tmp2
	cpy.w #$0200
	bcc CODE_C553D6
	ply
CODE_C553D5:						; from CODE_C5538C
	rts
CODE_C553D6:						; from CODE_C553CC
	pha
	txa
	asl a
	asl a
	asl a
	asl a
	pha
	lda.w #$2DC9
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
	jsr.w CODE_C560AC
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
CODE_C5547C:						; from CODE_C550E2
	lda.w #$0003
	sta.b d1
	lda.w tmscore
	sta.b d0
	jsl.l CODE_C534E8
	ldy.w #$00D7
	jsr.w CODE_C554CA
	lda.w tmscore+2
	sta.b d0
	jsl.l CODE_C534E8
	ldy.w #$00C3
	jsr.w CODE_C554CA
	ldy.w #$008B
	lda.w clockbcd+1
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w CODE_C554DD
	iny
	iny
	lda.w clockbcd+1
	jsr.w CODE_C554DD
	iny
	iny
	iny
	iny
	lda.w clockbcd
	lsr a
	lsr a
	lsr a
	lsr a
	jsr.w CODE_C554DD
	iny
	iny
	lda.w clockbcd
	jmp.w CODE_C554DD
CODE_C554CA:						; from CODE_C5547C
	lda.w $055B
	jsr.w CODE_C554DD
	iny
	iny
	lda.w $055C
	jsr.w CODE_C554DD
	iny
	iny
	lda.w $055D
CODE_C554DD:						; from CODE_C5547C, CODE_C554CA
	phy
	and.w #$000F
	asl a
	asl a
	adc.w $18EE
	tax
	tya
	asl a
	adc.w $18EE
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
	lda.w replaynewframe,x
	sta.w $0082,y
	ply
	rts
CODE_C55513:						; called from other segments
	jsl.l SoundVolumeDown
	jsl.l FadeOutWait
	lda.w $18F8
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
	lda.w $0876
	jsl.l QueueFrameTiles
	ldx.w #$20A8
	stx.b tmp2
	ldx.w #$2004
	stx.b tmp1
	lda.w $0878
	jsl.l QueueFrameTiles
	ldx.w #$20C0
	stx.b tmp2
	ldx.w #$2008
	stx.b tmp1
	lda.w $087A
	jsl.l QueueFrameTiles
	ldx.w #$20C8
	stx.b tmp2
	ldx.w #$200C
	stx.b tmp1
	lda.w $087C
	jsl.l QueueFrameTiles
	ldx.w #$20E0
	stx.b tmp2
	ldx.w #$2010
	stx.b tmp1
	lda.w $087E
	jsl.l QueueFrameTiles
	ldx.w #$20E8
	stx.b tmp2
	ldx.w #$2014
	stx.b tmp1
	lda.w $0880
	jsl.l QueueFrameTiles
	ldx.w #$2100
	stx.b tmp2
	ldx.w #$2018
	stx.b tmp1
	lda.w $0882
	jsl.l QueueFrameTiles
	ldx.w #$2108
	stx.b tmp2
	ldx.w #$201C
	stx.b tmp1
	lda.w $0884
	jsl.l QueueFrameTiles
	ldx.w #$2120
	stx.b tmp2
	ldx.w #$2020
	stx.b tmp1
	lda.w $0886
	jsl.l QueueFrameTiles
	ldx.w #$2128
	stx.b tmp2
	ldx.w #$2024
	stx.b tmp1
	lda.w $0888
	jsl.l QueueFrameTiles
	ldx.w #$2140
	stx.b tmp2
	ldx.w #$2028
	stx.b tmp1
	lda.w $088A
	jsl.l QueueFrameTiles
	ldx.w #$2148
	stx.b tmp2
	ldx.w #$202C
	stx.b tmp1
	lda.w $088C
	jsl.l QueueFrameTiles
	jsl.l WaitTransfers
	ldx.w #$2180
	stx.b tmp2
	ldx.w #$2034
	stx.b tmp1
	sta.w $0892
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
	lda.w $17C9
	pea.w $0020
	pea.w $0040
	pea.w $00C0
	xba
	lsr a
	lsr a
	adc.w #$3F22
	pha
	lda.w $17CB
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
	lda.w $17C9
	asl a
	adc.w $17C9
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
	lda.w $17C9
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
CODE_C5589E:						; called from other segments
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
CODE_C558CC:						; called from other segments
	lda.w #$040E
	jsl.l FreeWorkBuf
	jsl.l MarkWorkBuf
CODE_C558D7:						; from ExitToPauseMenu and other segments
	ldx.w $3648
	ldy.w #$1912
	lda.w #$01FD
	mvn $7E,$7E
	ldy.w #$46A8
	lda.w #$020F
	mvn $7E,$7E
	lda.w $1B02
	dec a
	asl a
	tay
.loop:								; loop: X = $1AE2,y, if $0A,x = $FFFF go to .1, push Y, ...
	ldx.w $1AE2,y
	lda.b $0A,x
	cmp.w #$FFFF
	beq .1
	phy
	jsr.w UploadSpriteFrame
	lda.b $34,x
	jsl.l CODE_C5EE9B
	ply
.1:									; Y - 1, Y - 1, if the result >= 0 go to .loop, A = $17CD, ...
	dey
	dey
	bpl .loop
	lda.w $17CD
	asl a
	tax
	lda.w $46B8,x
	and.w #$FF00
	ora.w $17CD
	jsl.l CODE_C5EE9B
	lda.w $17CF
	asl a
	tax
	lda.w $46B8,x
	and.w #$FF00
	ora.w $17CF
	jsl.l CODE_C5EE9B
	lda.w $4828
	and.w #$FF00
	ora.w #$00B8
	jsl.l CODE_C5EE9B
	lda.w $482A
	and.w #$FF00
	ora.w #$00B9
	jsl.l CODE_C5EE9B
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
	jsr.w CODE_C5852B
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
	jsr.w CODE_C5A4B9
	jsr.w CODE_C5A4E2
	jsl.l WaitTransfers
	lda.w #$0240
	jsl.l FreeWorkBuf
	lda.w #$0002
	sta.w BG2VScroll
	rts
ExitToPauseMenu:					; leaves a pause menu screen: fade out, the text map freed, VRAM cleared,
									; back to the pause menu (CODE_C550E2); opened from the season's Other
									; Scores it only fades out and returns
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	lda.w $190E
	beq .1
	rts
.1:									; call ClearNMIHook, A = $0800, call FreeWorkBuf, $18E0 = A, ...
	jsl.l ClearNMIHook
	lda.w #$0800
	jsl.l FreeWorkBuf
	sta.w $18E0
	jsl.l WaitTransfers
	jsl.l CODE_C558D7
	ldy.w #$5000
	jsl.l QueueClearVRAM
	jsl.l WaitTransfers
	stz.w padchangeany
	lda.w $190E
	jmp.w CODE_C550E2
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
	lda.w $17CB
	jsl.l CreateSprite
	lda.w #$00C0
	sta.b $18
	lda.w $17C9
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
	lda.w $17CB
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
	lda.w $17C9
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
	stx.w $469D
	sty.w $469E
	ldx.w #$0002
.1:									; $469D,x = A, A = Y, $469E,x = A, $469F,x = $0008, ...
	sta.w $469D,x
	tya
	sta.w $469E,x
	lda.w #$0008
	sta.w $469F,x
	lda.w #$0013
	sta.w $46A0,x
	lda.b $71
	asl a
	asl a
	asl a
	sta.w $46A1,x
	tya
	sta.w $46A2,x
	lda.w #$0008
	sta.w $46A3,x
	lda.w #$0013
	sta.w $46A4,x
	lda.w #$0001
	sta.w $46A5,x
	tya
	sta.w $46A6,x
	ldx.w #$FFFF
	lda.b a4
	dec a
	asl a
	asl a
	asl a
	cmp.w #$0080
	bcc .2
	sbc.w #$007F
	sta.w $468F
	stx.w $4690
	lda.w #$007F
	sta.w $468C
	stx.w $468D
	ldx.w #$0050
	jsl.l SetupHDMA
	db $02,$12,$8C,$46,$7E,$7E		; inline parameters
	bra .3
.2:									; $468F = A, $4690 = X, X = $0050, call SetupHDMA
	sta.w $468F
	stx.w $4690
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
	sta.w $4692
	stx.w $4693
	stz.w $4695
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
CODE_C55BC8:						; from CODE_C55BD1
	jsr.w ClearTextRow
	pea.w CODE_C55BD1-1
	jmp ($0075)
CODE_C55BD1:						; from CODE_C55BC8
	jsl.l WaitTransfers
	jsl.l RestoreWorkBuf
	inc.b $6D
	inc.b a3
	lda.b a3
	cmp.b a1
	bcs ScrollListArrows
	dec a
	cmp.b $71
	bcc CODE_C55BC8
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
CODE_C55C12:						; called from other segments
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
	beq CODE_C55C25
	dec a
CODE_C55C25:						; from CODE_C55C12, CODE_C55C45
	cmp.b $01,s
	bcs CODE_C55C52
	cmp.b a1
	bcs CODE_C55C52
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
	pea.w CODE_C55C45-1
	jmp ($0075)
CODE_C55C45:						; from CODE_C55C25
	jsl.l WaitTransfers
	jsl.l RestoreWorkBuf
	lda.b a3
	inc a
	bra CODE_C55C25
CODE_C55C52:						; from CODE_C55C25
	pla
	rts
CODE_C55C54:						; called from other segments
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
	bcs CODE_C55C92
	inc a
	cmp.b a1
	bcs CODE_C55C93
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
	pea.w CODE_C55C86-1
	jmp ($0075)
CODE_C55C86:						; from ScrollListDown
	jsl.l SendTextMap
	bra CODE_C55C93
CODE_C55C8C:						; from CODE_C55C93
	stz.w padlast
	stz.w padchangeany
CODE_C55C92:						; from ScrollListDown
	rts
CODE_C55C93:						; from ScrollListDown, CODE_C55C86
	inc.b $69
	ldx.w #$0008
.loop:								; loop: X - 1, if the result < 0 go to CODE_C55C8C, $4693 + 1, ...
	dex
	bmi CODE_C55C8C
	wai
	inc.w $4693
	sep #$20
	dec.w $4692
	bne .1
	lda.b tmp2
	asl a
	asl a
	asl a
	sta.w $4692
	rep #$20
	lda.w #$FFFF
	sta.w $4693
	stz.w $4694
	bra .loop
.1:									; A = tmp2, A * 2, A * 2, A * 2, ...
	lda.b tmp2
	asl a
	asl a
	asl a
	sec
	sbc.w $4692
	sta.w $4695
	rep #$20
	lda.w $4692
	and.w #$00FF
	eor.w #$FFFF
	sta.w $4696
	lda.w #$0001
	sta.w $4698
	lda.w #$FFFF
	sta.w $4699
	stz.w $469B
	bra .loop
ScrollListUp:						; scrolls a scrolling list up a row (the pad's up) when rows are above
	lda.b $71
	inc a
	sta.b tmp1
	inc a
	sta.b tmp2
	lda.b $69
	beq CODE_C55D6A
	dec a
	sta.b $69
	dec a
	bmi CODE_C55D14
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
	pea.w CODE_C55D10-1
	jmp ($0075)
CODE_C55D10:						; from ScrollListUp
	jsl.l SendTextMap
CODE_C55D14:						; from ScrollListUp
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
	cmp.w $4692
	bne .1
	dec a
	sta.w $4695
	lda.b #$01
	sta.w $4692
	rep #$20
	lda.w $4693
	dec a
	sta.w $4696
	lda.b tmp2
	asl a
	asl a
	asl a
	dec a
	dec a
	sta.w $4693
	lda.w #$0001
	sta.w $4698
	lda.w #$FFFF
	sta.w $4699
	stz.w $469B
	bra .loop
.1:									; $4692 + 1, $4695 - 1, A 16-bit, $4693 - 1, ...
	inc.w $4692
	dec.w $4695
	rep #$20
	dec.w $4693
	dec.w $4696
	bra .loop
.2:									; padlast = 0, padchangeany = 0
	stz.w padlast
	stz.w padchangeany
CODE_C55D6A:						; from ScrollListUp
	rts
DATA8_C55D6B:						; jump table: the routine for each index (code in bankC5_6000 uses it)
	dw CODE_C55D8A,CODE_C55DAC,CODE_C55DEF,CODE_C55E3D
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
CODE_C55D8A:						; from DATA8_C55D6B
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
CODE_C55DAC:						; from DATA8_C55D6B
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
CODE_C55DEF:						; from DATA8_C55D6B
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
CODE_C55E3D:						; from DATA8_C55D6B
	ldx.b $65
	lda.l $C30003,x
	clc
	adc.b a2
	sta.b tmp0
	lda.b (tmp0)
	jsr.w CODE_C5605D
	ldy.b $6D
	ldx.w #mesarea
	jsl.l PrintBoldCentredStr
	rts
CODE_C55E57:						; called from other segments
	jsl.l WaitTransfers
	ldy.w $17C9
	lda.b a2
	beq .1
	ldy.w $17CB
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
CODE_C55F1F:						; called from other segments
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

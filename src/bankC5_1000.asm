; Segment bankC5_1000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C510F6
GetPeriodTime:						; d0 = the period length in seconds for the period length option
									; (Optperlen), tmp0 the same as BCD minutes and seconds
	phx
	lda.w Optperlen
	asl a
	tax
	lda.l DATA8_C51112,x
	sta.b tmp0
	lda.l DATA8_C5110A,x
	sta.b d0
	plx
	rtl
DATA8_C5110A:						; not traced: a table read by GetPeriodTime
	db $2C,$01,$58,$02,$B0,$04,$1E,$00
DATA8_C51112:						; not traced: a table read by GetPeriodTime
	db $00,$05,$00,$10,$00,$20,$30,$00
printscores1:						; X = a3; chk4lc, SetFaceoffComputerLine and lcfound_close call it after a
									; line change
	ldx.b a3
	rtl
CODE_C5111D:						; no caller found (not traced)
	lda.w gsp
	sta.b d0
	cmp.w #$0004
	bne .1
	dec.w printx
	inc.b d0
.1:									; $65 = $00C0, a0 = $9B54
	lda.w #$00C0
	sta.b $65
	lda.w #$9B54
	sta.b a0
.loop:								; loop: $69 = $65, a1 = a0, A = [a0], A + a0, ...
	lda.b $65
	sta.b $69
	lda.b a0
	sta.b a1
	lda.b [a0]
	clc
	adc.b a0
	sta.b a0
	dec.b d0
	bpl .loop
	jsl.l CODE_C528D3
	ldy.b a2
	lda.w tmscore,y
	sta.b d0
	jsl.l Mod100
	stz.b $69
	lda.w #mesarea
	sta.b a1
	lda.w #$0004
	sta.b [a1]
	lda.w #$0020
	sta.w mesarea+2
	lda.b d0
	sta.b r2
	lda.w #$000A
	sta.b r1
	phx
	jsl.l Div16x8U
	plx
	lda.b r0
	beq .2
	adc.w #$0030
	sta.w mesarea+2
.2:									; A = RDMPYL, A + $0030, $04F8 = A, return
	lda.l RDMPYL
	adc.w #$0030
	sta.w mesarea+3
	rtl
AlignBigNumber:						; no caller found (not traced)
	ldy.w #$0002
.loop:								; loop: printx - 1, A = [a1],y, A and $00FF, if A = $0031 go to .1, ...
	dec.w printx
	lda.b [a1],y
	and.w #$00FF
	cmp.w #$0031
	beq .1
	dec.w printx
.1:									; Y + 1, A = Y, if A < [a1] go to .loop, return
	iny
	tya
	cmp.b [a1]
	bcc .loop
	rtl
Mod100:								; from CODE_C5111D and other segments
	lda.b d0
.loop:								; loop: if A < $0064 go to .1, A - $0064, go to .loop
	cmp.w #$0064
	bcc .1
	sbc.w #$0064
	bra .loop
.1:									; d0 = A, return
	sta.b d0
	rtl
DATA8_C511B7:						; not traced: data between routines
	db $6B
SetScore:							; the score of the other game a0 for the ticker: its period stepped and
									; both scores raised from the teams' strengths (SimPeriodGoals), or the
									; game ended
	phx
	ldx.b a0
	lda.w gsper,x
	cmp.w #$0004
	bcc .1
	jmp.w .6
.1:									; X = a0, if gsper,x is not $0003 go to .4, A = $0005
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	ldx.b a0
	lda.w gsper,x
	cmp.w #$0003
	bne .4
	lda.w #$0005
	sta.w gsper,x
	lda.w gss1,x
	sec
	sbc.w gss2,x
	bit.w #$8000
	beq .2
	eor.w #$FFFF
	inc a
.2:									; if A >= $0002 go to .5, if gsp is not $0004 go to .3, ...
	cmp.w #$0002
	bcs .5
	lda.w gsp
	cmp.w #$0004
	bne .3
	lda.w gss1,x
	cmp.w gss2,x
	bne .5
	inc a
	sta.w gss1,x
	bra .5
.3:									; gsper,x = $0003, A = gsflags,x, A or $0002, gsflags,x = A, ...
	lda.w #$0003
	sta.w gsper,x
	lda.w gsflags,x
	ora.w #$0002
	sta.w gsflags,x
	bra .5
.4:									; gsper,x + 1, d0 = gst1,x, d1 = gst2,x, call SimPeriodGoals, ...
	inc.w gsper,x
	lda.w gst1,x
	sta.b d0
	lda.w gst2,x
	sta.b d1
	jsl.l SimPeriodGoals
	ldx.b a0
	lda.w gss1,x
	clc
	adc.b d0
	sta.w gss1,x
	lda.w gst2,x
	sta.b d0
	lda.w gst1,x
	sta.b d1
	jsl.l SimPeriodGoals
	ldx.b a0
	lda.w gss2,x
	clc
	adc.b d0
	sta.w gss2,x
.5:									; pull A, $69 = A, pull A, a1 = A, ...
	pla
	sta.b $69
	pla
	sta.b a1
	pla
	sta.b $65
	pla
	sta.b a0
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
.6:									; pull X, return
	plx
	rtl
DATA8_C51271:						; not traced: data between routines
	db $2B,$00,$1E,$00,$17,$00,$04,$00,$27,$00,$20,$00,$18,$00,$05,$00
	db $23,$00,$21,$00,$1A,$00,$06,$00,$1E,$00,$22,$00,$1E,$00,$06,$00
	db $1A,$00,$24,$00,$1E,$00,$08,$00,$16,$00,$25,$00,$1F,$00,$0A,$00
	db $13,$00,$26,$00,$1F,$00,$0C,$00,$0F,$00,$26,$00,$20,$00,$0F,$00
SimPeriodGoals:						; d0 = the goals team d0 scores against team d1 in a period of another
									; game, from both teams' weight rows (DATA8_C51271 by their ratings)
	asl.b d0
	lda.w #$00C3
	sta.b $69
	stz.b a1
	ldy.b d0
	lda.b [a1],y
	sta.b a1
	ldy.w #$0006
	adc.b [a1],y
	sta.b a1
	lda.b [a1]
	and.w #$0070
	lsr a
	adc.w #$1271
	sta.b a1
	lda.w #$00C5
	sta.b $69
	lda.b [a1]
	sta.w $07BE
	ldy.w #$0002
	lda.b [a1],y
	sta.w $07C0
	ldy.w #$0004
	lda.b [a1],y
	sta.w $07C2
	ldy.w #$0006
	lda.b [a1],y
	sta.w $07C4
	asl.b d1
	lda.w #$00C3
	sta.b $69
	stz.b a1
	ldy.b d1
	lda.b [a1],y
	sta.b a1
	ldy.w #$0006
	adc.b [a1],y
	sta.b a1
	lda.b [a1]
	and.w #$0007
	asl a
	asl a
	asl a
	adc.w #$1271
	sta.b a1
	lda.w #$00C5
	sta.b $69
	lda.b [a1]
	adc.w $07BE
	sta.w $07BE
	ldy.w #$0002
	lda.b [a1],y
	adc.w $07C0
	sta.w $07C0
	ldy.w #$0004
	lda.b [a1],y
	adc.w $07C2
	sta.w $07C2
	ldy.w #$0006
	lda.b [a1],y
	adc.w $07C4
	sta.w $07C4
	lda.w #$0004
	sta.b d0
	pei ($85)
	pei ($83)
	pei ($69)
	pei ($67)
	stz.b $69
	lda.w #$07BE
	sta.b a1
	stz.b d1
	bra .1
.loop:								; loop: A = d1, A + [a1], d1 = A, a1 + 1, ...
	lda.b d1
	clc
	adc.b [a1]
	sta.b d1
	inc.b a1
	inc.b a1
.1:									; d0 - 1, if the result >= 0 go to .loop, d0 = d1, call randomd0
	dec.b d0
	bpl .loop
	lda.b d1
	sta.b d0
	jsl.l randomd0
.loop2:								; loop: a1 - 1, a1 - 1, A = d0, A - [a1], ...
	dec.b a1
	dec.b a1
	lda.b d0
	sec
	sbc.b [a1]
	sta.b d0
	bpl .loop2
	lda.b a1
	sec
	sbc.w #$07BE
	lsr a
	sta.b d0
	pla
	sta.b a1
	pla
	sta.b $69
	pla
	sta.b d1
	pla
	sta.b $85
	rtl
showclockdma:						; puts the game clock (clockbcd as M:SS, no leading zero) in the
									; scoreboard text and queues it to VRAM
	lda.w #$A0A0
	sta.l $7E2CD0
	sta.l $7E2CD5
	lda.w #$A005
	sta.l $7E2CCF
	sep #$21
	lda.b #$BA
	sta.l $7E2CD2
	lda.w clockbcd+1
	tay
	and.b #$F0
	beq .1
	lsr a
	lsr a
	lsr a
	lsr a
	adc.b #$B0
	sta.l $7E2CD0
	sec
.1:									; A = Y, A and $0F, A + $AF, $7E2CD1 = A, ...
	tya
	and.b #$0F
	adc.b #$AF
	sta.l $7E2CD1
	lda.w clockbcd
	tay
	lsr a
	lsr a
	lsr a
	lsr a
	clc
	adc.b #$B0
	sta.l $7E2CD3
	tya
	and.b #$0F
	adc.b #$B0
	sta.l $7E2CD4
	rep #$30
	ldy.w #$5B24
	lda.w #$2CCF
	ldx.w #$007E
	jml.l QueueVRAMDMALen
USBoard:							; the penalty box lists of both teams (DispPen for team 0, then 2) with
									; the d and a registers kept; returns with X = a3
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
	pei ($93)
	pei ($95)
	pei ($97)
	pei ($99)
	pei ($9B)
	pei ($9D)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	stz.b a2
	jsl.l DispPen
	lda.w #$0002
	sta.b a2
	jsl.l DispPen
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
	sta.b $9D
	pla
	sta.b d7
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
USBoard_rtl:						; the return DispPen and pplpen leave through
	rtl
DispPen:							; from USBoard and other segments
	lda.b a2
	beq .1
	lda.w #$001A
.1:									; a0 = A
	sta.b a0
.loop:								; loop: Y = a0, A = tmboxlist,y, a0 + 1, A and $00FF, ...
	ldy.b a0
	lda.w tmboxlist,y
	inc.b a0
	and.w #$00FF
	sta.b d0
	bit.w #$0080
	bne .3
	lda.b a2
	beq .2
	lda.w #$0034
.2:									; A + d0, Y = A, A = tmpdst,y, if a $4000 bit set go to .loop, ...
	clc
	adc.b d0
	tay
	lda.w tmpdst,y
	bit.w #$4000
	bne .loop
	jsl.l pplpen
	bra .loop
.3:									; if a2 = 0 go to .4, A = $001A
	lda.b a2
	beq .4
	lda.w #$001A
.4:									; a0 = A
	sta.b a0
.loop2:								; loop: Y = a0, A = tmboxlist,y, a0 + 1, A and $00FF, ...
	ldy.b a0
	lda.w tmboxlist,y
	inc.b a0
	and.w #$00FF
	sta.b d0
	bit.w #$0080
	bne USBoard_rtl
	lda.b a2
	beq .5
	lda.w #$0034
.5:									; A + d0, Y = A, A = tmpdst,y, if $4000 bits clear go to .loop2, ...
	clc
	adc.b d0
	tay
	lda.w tmpdst,y
	bit.w #$4000
	beq .loop2
	jsl.l pplpen
	bra .loop2
pplpen:								; from DispPen and other segments
	lda.w printy
	cmp.w #$000B
	bcs USBoard_rtl
	lda.b a2
	beq .1
	lda.w #$0034
.1:									; A + d0, Y = A, A = tmpdst,y, A and $07FF, ...
	adc.b d0
	tay
	lda.w tmpdst,y
	and.w #$07FF
	sta.b d2
	lda.w #$00C3
	sta.b $69
	ldy.b a2
	lda.w tmdata,y
	sta.b a1
	lda.b [a1]
	and.w #$07FF
	clc
	adc.b d0
	sta.b a1
	lda.b [a1]
	and.w #$3FFF
	sta.b a1
	lda.b [a1]
	and.w #$00FF
	sta.b d0
	rtl
Intermission:						; the intermission between periods: the teams set up
									; (SetupTeamForIntermission), the ticker, the pause pad, then
									; Pausemode_menu
	jsl.l SetupTeamForIntermission
	lda.w #$0000
	ldy.w #$001E
.loop:								; loop: Xpos,y = A, Y - 1, Y - 1, if the result >= 0 go to .loop, ...
	sta.w Xpos,y
	dey
	dey
	bpl .loop
	lda.b Vcount
	ldy.b $5F
	sta.w vcountmark
	sty.w vcountmark+2
	lda.w #$0001
	trb.w sflags
	lda.w gsp
	cmp.w #$0004
	beq .1
	bra .1
.1:									; pausetimer = $0708, demoflag = $0001, A = Vcount, A - $0150, ...
	lda.w #$0708
	sta.w pausetimer
	lda.w #$0001
	sta.w demoflag
	lda.b Vcount
	sec
	sbc.w #$0150
	sta.w tickervc
	jsl.l Intermission_ticker
	lda.w TickerNum
	sta.w tickerstart
	lda.w #$FFFF
	sta.w pausepad
	ldy.w #$0000
	tyx
.loop2:								; loop: if cont1team,y is not 0 go to .2, X + 1, X + 1, ...
	lda.w cont1team,y
	bne .2
	inx
	inx
	cpx.w #$0008
	bne .loop2
	lda.w #$0001
.2:									; A xor $FFFF, A + 1, pausepad = A, A = cont1team, ...
	eor.w #$FFFF
	inc a
	sta.w pausepad
	lda.w cont1team
	ora.w cont2team
	ora.w cont3team
	ora.w cont4team
	ora.w cont5team
	bne .3
	stz.w pausepad
.3:									; InIntermission = $0001, if $23BA = 0 go to .4, go to .5
	lda.w #$0001
	sta.w InIntermission
	lda.w $23BA
	beq .4
	jmp.w .5
.4:									; call AddIntermissionGoals
	jsl.l AddIntermissionGoals
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
	pei ($93)
	pei ($95)
	pei ($97)
	pei ($99)
	pei ($9B)
	pei ($9D)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	pei ($73)
	pei ($75)
	pei ($77)
	pei ($79)
	pei ($7B)
	pei ($7D)
	jsl.l Pausemode_menu
	pla
	sta.b $7D
	pla
	sta.b $7B
	pla
	sta.b $79
	pla
	sta.b $77
	pla
	sta.b $75
	pla
	sta.b a4
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
	sta.b $9D
	pla
	sta.b d7
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
	jsl.l CODE_C558CC
	jsl.l CODE_C5589E
	jsl.l SoundVolumeUp
.5:									; Vcount = 0, OldVcount = 0, pausemenuon = 0, InIntermission = 0, ...
	stz.b Vcount
	stz.w OldVcount
	stz.w pausemenuon
	stz.w InIntermission
	stz.w demoflag
Intermission_rtl:					; the return at the end of Intermission; Intermission_ticker leaves
									; through it when there is no ticker game
	rtl
Intermission_ticker:				; the intermission's ticker (Intermission calls it where 94S calls
									; Intermission_ticker)
	lda.w TickerNum
	bmi .1
	ora.w gamenum
	bne .2
.1:									; call GetShifter, TickerNum = d1, if d1 < 0 go to Intermission_rtl
	jsl.l GetShifter
	lda.b d1
	sta.w TickerNum
	bmi Intermission_rtl
.2:									; go to NewTicker2
	jmp.w NewTicker2
Intermission_tick:					; no caller found (not traced)
	lda.w demoflag
	beq IntermissionTick_done
	lda.b Vcount
	sec
	sbc.w tickervc
	cmp.w #$0150
	bcc IntermissionTick_done
	jsl.l NewTicker2_next
	lda.w tickerstart
	cmp.w TickerNum
	bne Intermission_tick
	jsl.l DoHiLights
	lda.w #$0008
	trb.w sflags3
IntermissionTick_done:				; A = 0, return: the end of Intermission_tick
	lda.w #$0000
	rtl
NewTicker2_next:					; from Intermission_tick and other segments
	lda.w TickerNum
	bmi .1
	ora.w gamenum
	bne .2
.1:									; call GetShifter, TickerNum = d1, if d1 < 0 go to IntermissionTick_done
	jsl.l GetShifter
	lda.b d1
	sta.w TickerNum
	bmi IntermissionTick_done
.2:									; go to NewTicker2
	jmp.w NewTicker2
PushTime:							; a1 = the time d0 (seconds) as a minutes:seconds string (in a work
									; buffer, length byte first)
	lda.w #$0020
	jsl.l AllocWorkBuf2
	clc
	adc.w #$001F
	sta.b a1
	pha
	lda.b d0
	sta.b r2
	lda.w #$000A
	sta.b r1
	jsl.l Div16x8U
	dec.b a1
	sep #$20
	lda.l RDMPYL
	clc
	adc.b #$B0
	sta.b (a1)
	rep #$30
	lda.b r0
	sta.b r2
	lda.w #$0006
	sta.b r1
	jsl.l Div16x8U
	dec.b a1
	sep #$20
	lda.l RDMPYL
	clc
	adc.b #$B0
	sta.b (a1)
	rep #$20
	dec.b a1
	sep #$20
	lda.b #$BA
	sta.b (a1)
	rep #$30
	lda.b r0
	sta.b r2
	lda.w #$000A
	sta.b r1
	jsl.l Div16x8U
	dec.b a1
	sep #$20
	lda.l RDMPYL
	clc
	adc.b #$B0
	sta.b (a1)
	rep #$31
	lda.b r0
	beq .1
	dec.b a1
	sep #$20
	adc.b #$B0
	sta.b (a1)
	rep #$30
.1:									; a1 - 1, pull A, A - a1, A 8-bit, ...
	dec.b a1
	pla
	clc
	sbc.b a1
	sep #$20
	sta.b (a1)
	rep #$20
	rtl
NewTicker:							; shows the next ticker score (NewTicker2) once gameclock is below $1E1
	lda.w gameclock
	cmp.w #$01E1
	bcc NewTicker2
	rtl
NewTicker2:							; the score ticker's next game: TickerNum counted down, skipping the
									; user's game and games with flag bits $0006, then its box shown
	lda.w TickerNum
	sta.b d3
	bmi .rtl
	dec.w TickerNum
	lda.b d3
	cmp.w gamenum
	beq NewTicker2
	bra .1
.rtl:								; return
	rtl
.1:									; A = d3, A * 2, a0 = A, X = A, ...
	lda.b d3
	asl a
	sta.b a0
	tax
	lda.w gsflags,x
	bit.w #$0006
	bne NewTicker2
	lda.w sflags
	bit.w #$0001
	bne .2
.2:									; A = printy, A - $0005, printy = A, d0 = $001C, ...
	lda.w printy
	sec
	sbc.w #$0005
	sta.w printy
	lda.w #$001C
	sta.b d0
	lda.w #$0005
	sta.b d1
	lda.b Vcount
	sta.w tickervc
	inc.w printx
	lda.w printy
	sec
	sbc.w #$0004
	sta.w printy
	lda.w printx
	pha
	jsl.l GetShifter
	lda.w #$2400
	sta.w printa
	lda.b $01,s
	sta.w printx
	lda.w playoffRoundIdx
	inc a
	sta.b d0
	lda.w OptPlayMode
	bne .3
	stz.b d0
.3:									; pull A, return
	pla
	rtl
waitxsr:							; no caller found (not traced)
	phx
	pei ($7F)
.loop:								; loop: X = $0000
	ldx.w #$0000
.loop2:								; loop: A = X, A * 2, Y = A, if cont1team,y = 0 go to .1, ...
	txa
	asl a
	tay
	lda.w cont1team,y
	beq .1
	txa
	jsl.l ReadjoyA
	lda.b d3
	bne .2
.1:									; X + 1, if X < $0005 go to .loop2, $28 = $1D8F, $2A = $1E00, ...
	inx
	cpx.w #$0005
	bcc .loop2
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l setvideo
	lda.b Vcount
.loop3:								; loop: if A = Vcount go to .loop3, call ReadPads, pull A, A - 1, ...
	cmp.b Vcount
	beq .loop3
	jsl.l ReadPads
	pla
	dec a
	pha
	bpl .loop
.2:									; pull A, pull X, return
	pla
	plx
	rtl
clockcont:							; called from other segments
	lda.w gmclock
	ora.w gameclock
	bne .rtl
	jsl.l freezewindow
	jmp.w clockcont_0
.rtl:								; return
	rtl
DoHiLights:							; an rtl: called where 94S plays the playoff highlights
	rtl
CODE_C51812:						; no caller found (not traced)
	lda.w #$0013
	sta.b d0
	lda.w #$0009
	sta.b d1
	lda.w blankchar
	sta.b d2
	jml.l eraser
ShowGoalBox:						; the goal box after a goal: both line change boxes closed (CloseLCBoxes),
									; then the last ScoreSum entry with the scorer and the assists
	pei ($6D)
	pei ($6B)
	pei ($71)
	pei ($6F)
	inc.w $18AA
	lda.w #$FFFF
	sta.w lcpad
	sta.w lcpad+2
	jsl.l CloseLCBoxes
	lda.w ScoreSumbytes
	sec
	sbc.w #$0006
	sta.b $6D
	tax
	ldy.w #$0004
	lda.w ScoreSum+4,x
	bit.w #$0080
	bne .1
	iny
	iny
	lda.w ScoreSum+5,x
	bit.w #$0080
	bne .1
	iny
.1:									; X = $0013, A = $584C, call Framer, Y = $0000, ...
	ldx.w #$0013
	lda.w #$584C
	jsl.l Framer
	ldy.w #$0000
	ldx.b $6D
	lda.w ScoreSum+2,x
	bit.w #$0080
	beq .2
	ldy.w #$001A
.2:									; a2 = Y, A = $203D,x, A and $00FF, A + a2, ...
	sty.b a2
	lda.w ScoreSum+3,x
	and.w #$00FF
	clc
	adc.b a2
	tay
	lda.w #$2DC9
	ldx.b a2
	beq .3
	lda.w #$3207
.3:									; a2 = A, A = tmgoals,y, A and $00FF, if A is not $0003 go to .4, ...
	sta.b a2
	lda.w tmgoals,y
	and.w #$00FF
	cmp.w #$0003
	bne .4
	ldx.w #$00C3
	lda.w #$5A26
	ldy.w #$5870
	jsl.l QueueVRAMDMALen
	bra .5
.4:									; X = $00C3, A = $5A31, Y = $5872, call QueueVRAMDMALen
	ldx.w #$00C3
	lda.w #$5A31
	ldy.w #$5872
	jsl.l QueueVRAMDMALen
.5:									; a3 = $58AD, A = a2, A + $0110, a2 = A, ...
	lda.w #$58AD
	sta.b a3
	lda.b a2
	clc
	adc.w #$0110
	sta.b a2
	ldx.b $6D
	lda.w ScoreSum+3,x
	and.w #$00FF
	jsr.w CODE_C51911
	ldx.b $6D
	lda.w ScoreSum+4,x
	bit.w #$0080
	bne .6
	pha
	lda.b a3
	tay
	clc
	adc.w #$0020
	sta.b a3
	ldx.w #$00C3
	lda.w #$5A36
	jsl.l QueueVRAMDMALen
	pla
	and.w #$00FF
	jsr.w CODE_C51911
	ldx.b $6D
	lda.w ScoreSum+5,x
	bit.w #$0080
	bne .6
	and.w #$00FF
	jsr.w CODE_C51911
.6:									; pull A, a3 = A, X = A, pull A, ...
	pla
	sta.b a3
	tax
	pla
	sta.b $71
	pla
	sta.b a2
	pla
	sta.b $6D
	rtl
CODE_C51911:						; from ShowGoalBox
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b a2
	sta.b $71
	tax
	lda.w $0000,x
	and.w #$00FF
	jsr.w BinToBCD
	jsr.w BCDText
	lda.w #$0020
	sta.w mesarea,x
	txa
	sec
	adc.w #mesarea
	tay
	lda.b $71
	clc
	adc.w #$0008
	tax
	lda.w #$000D
	jsr.w FitName
	ldx.w #mesarea
	jsr.w CODE_C56262
	jsl.l CopyString2
	txa
	ldx.w #$007E
	ldy.b a3
	jsl.l QueueVRAMDMALen
	lda.b a3
	clc
	adc.w #$0020
	sta.b a3
	rts
DATA8_C5195D:						; not traced: data between routines
	db $00,$01,$02,$03,$04,$05,$06,$00,$00,$01,$05,$03,$04,$02,$00,$00
	db $00,$03,$05,$01,$04,$00,$00,$00,$00,$04,$04,$04,$04,$04,$04,$00
	db $00,$00,$06,$FF,$DD,$FF,$CE,$FF,$23,$00,$CE,$FF,$CE,$FF,$F6,$FF
	db $00,$00,$F1,$FF,$32,$00,$F6,$FF,$00,$00,$C4,$FF
updatefaceoff:						; the face off countdown (temp1): the ref's drop frame from the time left
									; (fofdata)
	lda.w temp1,x
	beq .3
	clc
	adc.w #$0006
	lsr a
	lsr a
	lsr a
	sta.b d0
	cmp.w #$0003
	bpl .rtl
	lda.w penshot
	bne .2
	lda.w OptPlayMode
	cmp.w #$0001
	beq .2
	phx
	phy
	lda.w $2014
	inc a
	sta.w $2014
	lsr a
	lsr a
	cmp.w #$0004
	bcc .1
	lda.w #$0003
.1:									; call CODE_C52008, pull Y, pull X
	jsl.l CODE_C52008
	ply
	plx
.2:									; A = d0, A xor $FFFF, A + 1, A + $000A, ...
	lda.b d0
	eor.w #$FFFF
	inc a
	clc
	adc.w #$000A
	sta.b d0
	sta.w fofdata
.rtl:								; return
	rtl
.3:									; push X, call CODE_C58944, push Y, push A, ...
	phx
	jsl.l CODE_C58944
	phy
	pha
	lda.w penshot
	bne .4
	lda.w OptPlayMode
	cmp.w #$0001
	beq .4
	ldx.w $2020
	jsl.l DeleteSprite
	ldx.w $2022
	jsl.l DeleteSprite
	lda.w $2024
	sta.w $18E0
.4:									; pull A, pull Y, pull X, FrameCount = 0, ...
	pla
	ply
	plx
	stz.w FrameCount
	stz.b $48
	rtl
CODE_C51A13:						; called from other segments
	jsr.w CentrePuck
	lda.w fox
	sta.w puckx
	lda.w foy
	sta.w pucky
	stz.b d4
	jsr.w CODE_C51A30
	lda.w #$0002
	sta.b d4
	jsr.w CODE_C51A30
	rtl
CODE_C51A30:						; from CODE_C51A13
	ldy.w #$0008
.loop:								; loop: if padside,y < 0 go to .1, if padside,y = d4 go to .2
	lda.w padside,y
	bmi .1
	cmp.b d4
	beq .2
.1:									; Y - 1, Y - 1, if the result >= 0 go to .loop, go to .rts
	dey
	dey
	bpl .loop
	bra .rts
.2:									; if c1playernum,y >= 0 go to .1, d4 = Y, call PadTakeGoalie
	lda.w c1playernum,y
	bpl .1
	sty.b d4
	jsl.l PadTakeGoalie
.rts:								; return
	rts
CentrePuck:							; the puck at centre ice and still: puckx, pucky, puckz and the three
									; speeds 0
	stz.w puckx
	stz.w pucky
	stz.w puckz
	stz.w puckvx
	stz.w puckvy
	stz.w puckvz
	rts
SetupPenaltyShot:					; penalty shot set up: the puck at centre ice, every player reassigned,
									; the defending goalie to his pad, the shooter gets the puck, pstimer 900,
									; ClearPenaltyBuffer
	jsr.w CentrePuck
	phx
	ldx.w #$0000
	lda.w #$0002
	sta.b d4
	lda.w BA_Team
	beq .1
	ldx.w #$000C
	lda.w #$0000
	sta.b d4
.1:									; d0 = $0010, call FillPlayerAssignments, call FillPlayerAssignments, ...
									; FillPlayerAssignments, ...
	lda.w #$0010
	sta.b d0
	jsl.l FillPlayerAssignments
	jsl.l FillPlayerAssignments
	jsl.l FillPlayerAssignments
	jsl.l FillPlayerAssignments
	jsl.l FillPlayerAssignments
	jsl.l FillPlayerAssignments
	ldx.b d4
	lda.w teampads,x
	beq .4
	lda.w goaliemode1,x
	beq .4
	ldy.w #$0000
.loop:								; loop: if padside,y < 0 go to .2, if padside,y = d4 go to .3
	lda.w padside,y
	bmi .2
	cmp.b d4
	beq .3
.2:									; Y + 1, Y + 1, if Y < $000A go to .loop, go to .4
	iny
	iny
	cpy.w #$000A
	bcc .loop
	bra .4
.3:									; d4 = Y, call PadTakeGoalie
	sty.b d4
	jsl.l PadTakeGoalie
.4:									; pull X, Y = BA_Team, tmtouch1,y = $FFFF, tmtouch2,y = A, ...
	plx
	ldy.w BA_Team
	lda.w #$FFFF
	sta.w tmtouch1,y
	sta.w tmtouch2,y
	sta.w tmtouch3,y
	lda.w CwdExciteLvl
	clc
	adc.w #$0014
	bmi .5
	sta.w CwdExciteLvl
.5:									; puckc = BA_Sktr_SCnum, Y = A, if pspad < 0 go to .6, playerpad,y = A
	lda.w BA_Sktr_SCnum
	sta.w puckc
	tay
	lda.w pspad
	bmi .6
	sta.w playerpad,y
.6:									; PenShotActive = 0, PenShotActive + 1, penshotlive = $0001, ...
	stz.w PenShotActive
	inc.w PenShotActive
	lda.w #$0001
	sta.w penshotlive
	lda.w #$0384
	sta.w pstimer
	jml.l ClearPenaltyBuffer
Endfaceoff:							; drops the puck: the face off sound, sflags $0100 / $0400 cleared, fobox,
									; replaydelay and gmclock cleared, then the winner from the centres' pull
									; directions (fodir1, fodir2) and frames
	lda.w #$000D
	jsl.l StartSound
	lda.w #$0100
	trb.w sflags
	stz.w fobox
	lda.w #$0400
	trb.w sflags
	stz.w replaydelay
	stz.w gmclock
	lda.w #$0010
	tsb.w sflags3
	lda.w fodir1
	sta.b d3
	lda.w #$0800
	sta.b d4
	stz.b a1
	lda.w #$0010
	sta.b d2
	ldx.w fofdata2
	lda.l DATA8_C51C52-1,x
	and.w #$00FF
	bit.w #$0080
	beq .1
	ora.w #$FF00
.1:									; A xor $FFFF, A + 1, A + d2, d2 = A, ...
	eor.w #$FFFF
	inc a
	clc
	adc.b d2
	sta.b d2
	ldx.w fofdata2+4
	lda.l DATA8_C51C52-1,x
	and.w #$00FF
	bit.w #$0080
	beq .2
	ora.w #$FF00
.2:									; A + d2, d2 = A, call RandomWord, A and $001F, ...
	clc
	adc.b d2
	sta.b d2
	jsl.l RandomWord
	and.w #$001F
	inc a
	cmp.b d2
	bcs .3
	lda.w #$0004
	sta.b a1
.3:									; X = a1, A = fofdata2+2,x, if $0800 bits clear go to .4, d3 = fodir2, ...
	ldx.b a1
	lda.w fofdata2+2,x
	bit.w #$0800
	beq .4
	lda.w fodir2
	sta.b d3
	lda.w #$F800
	sta.b d4
.4:									; A = d3, if a $0008 bit set go to .5, A and $0007, d0 = A, ...
	lda.b d3
	bit.w #$0008
	bne .5
	and.w #$0007
	sta.b d0
	lda.w seed
	and.w #$0003
	bne .6
.5:									; A = $0005, call randoma8, A - 1, A - 1, ...
	lda.w #$0005
	jsl.l randoma8
	dec a
	dec a
	and.w #$0007
	sta.b d0
	lda.b d4
	bmi .6
	lda.b d0
	eor.w #$0004
	sta.b d0
.6:									; d0 * 2, d0 * 2, X = d0, A = DATA8_C09C04,x, ...
	asl.b d0
	asl.b d0
	ldx.b d0
	lda.l DATA8_C09C04,x
	asl a
	asl a
	asl a
	asl a
	asl a
	ldx.b a3
	sta.w Xvel,x
	ldx.b d0
	lda.l $C09C06,x
	asl a
	asl a
	asl a
	asl a
	asl a
	clc
	adc.b d4
	ldx.b a3
	sta.w Yvel,x
	lda.w #$0004
	ldy.w #$0000
	jsr.w FindPositionSlot
	bmi .10
	lda.w puckvy
	bpl .8
	lda.w pfgoal,y
	bne .9
.7:									; A = $0004, Y = $000C, call FindPositionSlot, if minus go to .10, ...
	lda.w #$0004
	ldy.w #$000C
	jsr.w FindPositionSlot
	bmi .10
	bra .9
.8:									; if pfgoal,y is not 0 go to .7
	lda.w pfgoal,y
	bne .7
.9:									; a2 = Y, X = a3, call a2touchpuck
	sty.b a2
	ldx.b a3
	jsl.l a2touchpuck
.10:								; A = tmflags, A and $FFFB, tmflags = A, A = tmflags+2, ...
	lda.w tmflags
	and.w #$FFFB
	sta.w tmflags
	lda.w tmflags+2
	and.w #$FFFB
	sta.w tmflags+2
	ldx.b a3
	jsl.l RandomWord
	and.w #$07FF
	sta.w puckvz
	stz.w puckz
	stz.w pfnc,x
	lda.w #$0018
	sta.b d0
	jml.l assreplace
FindPositionSlot:					; Y = the slot (from Y, six of them) of the player in position A, or
									; $FFFF; the flags from cpy #0
	pha
	lda.w #$0006
	sta.b d0
	pla
.loop:								; loop: if A = position,y go to .1, Y + 1, Y + 1, d0 - 1, ...
	cmp.w position,y
	beq .1
	iny
	iny
	dec.b d0
	bne .loop
	ldy.w #$FFFF
.1:									; return
	cpy.w #$0000
	rts
DATA8_C51C52:						; not traced: data between routines
	db $00,$08,$10,$00,$08,$10
faceoffinput:						; pad input of a centre taking a face off (assignment $17): the pad
									; direction to fodir1 / fodir2 by pfgoal; B starts the swing (pf2aip)
	lda.w asscur,x
	cmp.w #$0017
	bne .rtl
	lda.w pfgoal,x
	beq .2
	lda.b d0
	sta.w fodir2
	lda.w pf2aip,x
	bne .rtl
	lda.b d1
	bit.w #$8000
	beq .4
	sta.w pf2aip,x
	lda.w OptPlayMode
	cmp.w #$0001
	beq .1
	ldx.w $2020
	stz.b $30,x
.1:									; X = a3, A = $24FA, go to SetSPAFromA
	ldx.b a3
	lda.w #$24FA
	jml.l SetSPAFromA
.rtl:								; return
	rtl
.2:									; fodir1 = d0, if pf2aip,x is not 0 go to .rtl, A = d1, ...
	lda.b d0
	sta.w fodir1
	lda.w pf2aip,x
	bne .rtl
	lda.b d1
	bit.w #$8000
	beq .4
	sta.w pf2aip,x
	lda.w OptPlayMode
	cmp.w #$0001
	beq .3
	ldx.w $2022
	stz.b $30,x
.3:									; X = a3, A = $24FA, go to SetSPAFromA
	ldx.b a3
	lda.w #$24FA
	jml.l SetSPAFromA
.4:									; A = $2524, go to SetSPAFromA
	lda.w #$2524
	jml.l SetSPAFromA
puckfaceoff:						; assignment (asstab entry 27): the puck at the start of play; PeriodOver
									; when the clock has run out, Stop4Pen for a penalty
	stz.w CrowdLoud
	lda.w shootoutmode
	beq .1
	lda.w shootoutstop
	beq .1
	inc.w shootoutturnover
	rtl
.1:									; puckc = $FFFF, call pucknorm_move, A = pflags,x, ...
	lda.w #$FFFF
	sta.w puckc
	jsl.l pucknorm_move
	lda.w pflags,x
	bit.w #$0002
	bne .2
	jmp.w WaitForFaceoffLineChanges
.2:									; A and $FFFD, pflags,x = A, if gameclock is not 0 go to .3, ...
	and.w #$FFFD
	sta.w pflags,x
	lda.w gameclock
	bne .3
	jml.l PeriodOver
.3:									; A = gmode, if $0040 bits clear go to .4, go to PeriodOver
	lda.w gmode
	bit.w #$0040
	beq .4
	jml.l PeriodOver
.4:									; if gsp is not $0003 go to .5, if tmscore = tmscore+2 go to .5, ...
	lda.w gsp
	cmp.w #$0003
	bne .5
	lda.w tmscore
	cmp.w tmscore+2
	beq .5
	jml.l clockcont_0
.5:									; A = gmode, if $0008 bits clear go to .6, go to Stop4Pen
	lda.w gmode
	bit.w #$0008
	beq .6
	jml.l Stop4Pen
.6:									; call ReturnGoalies, temp1,x = $FFFF, temp2,x = A, ...
	jsl.l ReturnGoalies
	lda.w #$FFFF
	sta.w temp1,x
	sta.w temp2,x
	lda.w OptLine
	bne .7
	jmp.w WaitForFaceoffLineChanges
.7:									; A = penshot, if the result = 0 go to .8, go to WaitForFaceoffLineChanges
	lda.w penshot
	ora.w penshotlive
	beq .8
	jmp.w WaitForFaceoffLineChanges
.8:									; lcpad = $FFFF, lcpad+2 = A, $18E2 = 0, $18E4 = 0, ...
	lda.w #$FFFF
	sta.w lcpad
	sta.w lcpad+2
	stz.w $18E2
	stz.w $18E4
	lda.w #$0008
	trb.w tmflags
	trb.w tmflags+2
	lda.w cont1team
	ora.w cont2team
	ora.w cont3team
	ora.w cont4team
	ora.w cont5team
	beq .9
	lda.l $7E2CF5
	beq .9
	lda.w #$0040
	tsb.w sflags
	jsl.l ClrHor
.9:									; if newperiod is not 0 go to .10, if teampads = 0 go to .10, ...
	lda.w newperiod
	bne .10
	lda.w teampads
	beq .10
	jsl.l HomePadPlayer
	lsr a
	sta.b d0
	jsl.l HomeFaceoffLineChange
.10:								; if newperiod is not 0 go to .11, if teampads+2 = 0 go to .11, ...
	lda.w newperiod
	bne .11
	lda.w teampads+2
	beq .11
	jsl.l AwayPadPlayer
	lsr a
	sta.b d0
	jsl.l AwayFaceoffLineChange
.11:								; newperiod = 0, a1 = 0, a2 = $0002, d0 = A, ...
	stz.w newperiod
	stz.b a1
	lda.w #$0002
	sta.b a2
	sta.b d0
	jsl.l SetFaceoffComputerLine
	jmp.w WaitForFaceoffLineChanges
SetFaceoffComputerLine:				; line changes on and team d0 not on a pad: CompLine, setpersonel,
									; printscores1
	lda.w OptLine
	bne .1
	jmp.w rtsfaceoff
.1:									; if d0 is not cont1team go to .2, go to rtsfaceoff
	lda.b d0
	cmp.w cont1team
	bne .2
	jmp.w rtsfaceoff
.2:									; if A is not cont2team go to .3, go to rtsfaceoff
	cmp.w cont2team
	bne .3
	jmp.w rtsfaceoff
.3:									; if A is not cont3team go to .4, go to rtsfaceoff
	cmp.w cont3team
	bne .4
	jmp.w rtsfaceoff
.4:									; if A is not cont4team go to .5, go to rtsfaceoff
	cmp.w cont4team
	bne .5
	jmp.w rtsfaceoff
.5:									; if A is not cont5team go to CODE_C51DEA, go to rtsfaceoff
	cmp.w cont5team
	bne CODE_C51DEA
	jmp.w rtsfaceoff
CODE_C51DEA:						; from HomeFaceoffLineChange, AwayFaceoffLineChange, ...
	jsl.l CompLine
	jsl.l setpersonel
	jml.l printscores1
HomeFaceoffLineChange:				; home's face off line change: with automatic line changes (OptLine 2) the
									; computer picks home's line, else player d0 opens the box
									; (StartFaceoffLineChange)
	lda.w OptLine
	cmp.w #$0002
	bne StartFaceoffLineChange
	stz.b a2
	lda.w #$0002
	sta.b a1
	lda.w #$0001
	sta.b d0
	bra CODE_C51DEA
AwayFaceoffLineChange:				; the away team's face off line change, as HomeFaceoffLineChange
	lda.w OptLine
	cmp.w #$0002
	bne StartFaceoffLineChange
	stz.b a1
	lda.w #$0002
	sta.b a2
	sta.b d0
	bra CODE_C51DEA
StartFaceoffLineChange:				; player d0 opens its team's line change box; when the box is open its
									; timer starts in temp1 (home, $258) or temp2 (away, $168) of the puck,
									; the player's object number in temp3 / temp4
	ldy.b a3
	sty.b a2
	lda.b d0
	asl a
	sta.b d0
	sta.b a3
	tax
	phy
	ldy.w #$0000
	lda.w pfteam,x
	beq .1
	ldy.w #$0002
.1:									; lcpad,y = $FFFF, call SetLCmode, pull Y, a2 = Y, ...
	lda.w #$FFFF
	sta.w lcpad,y
	jsl.l SetLCmode
	ply
	sty.b a2
	ldx.b a3
	phy
	ldy.w #$0000
	lda.w pfteam,x
	beq .2
	ldy.w #$0002
.2:									; A = tmflags,y, pull Y, if $0008 bits clear go to .4, ...
	lda.w tmflags,y
	ply
	bit.w #$0008
	beq .4
	lda.w pfteam,x
	beq .3
	lda.w #$0168
	sta.w temp2,y
	txa
	lsr a
	sta.w temp4,y
	bra .4
.3:									; temp1,y = $0258, A = X, A / 2, temp3,y = A
	lda.w #$0258
	sta.w temp1,y
	txa
	lsr a
	sta.w temp3,y
.4:									; X = a2, a2 = a3, a3 = X
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
rtsfaceoff:							; the shared return of the face off routines
	rtl
WaitForFaceoffLineChanges:			; runs both line change timers; when both are done, the computer lines,
									; then assignment $1C (puckfaceoff2)
	stz.w penshotlive
	stz.b d0
	jsl.l UpdateFaceoffLineChangeTimer
	lda.w #$0020
	sta.b d0
	jsl.l UpdateFaceoffLineChangeTimer
	ldx.b a3
	lda.w temp1,x
	bpl rtsfaceoff
	lda.w temp2,x
	bpl rtsfaceoff
	stz.b a2
	lda.w #$0001
	sta.b d0
	inc a
	sta.b a1
	jsl.l SetFaceoffComputerLine
	lda.w #$001C
	sta.b d0
	ldx.b a3
	jml.l assreplace
UpdateFaceoffLineChangeTimer:		; line change timer d0 (0 home, $20 away) of the puck: closes the box when
									; the player closed it, else counts down by d7 and takes row 0 (lcfound)
									; when it runs out
	lda.b a3
	clc
	adc.b d0
	tay
	lda.w temp1,y
	bmi rtsfaceoff
	lda.w temp3,y
	asl a
	sta.b d1
	tay
	stz.b a0
	stz.b a2
	lda.w pfteam,y
	beq .1
	lda.w #$0002
	sta.b a2
.1:									; push Y, Y = a2, A = tmflags,y, pull Y, ...
	phy
	ldy.b a2
	lda.w tmflags,y
	ply
	bit.w #$0008
	bne .3
	phy
	ldy.b a2
	lda.w $18E2,y
	beq .2
	ply
	bra .3
.2:									; A + 1, $18E2,y = A, pull Y, A = a3, ...
	inc a
	sta.w $18E2,y
	ply
	lda.b a3
	clc
	adc.b d0
	tay
	lda.w temp1,y
	ora.w #$FF00
	sta.w temp1,y
	ldx.b a3
	jmp.w SetLCmode2
.3:									; A = a3, A + d0, Y = A, A = temp1,y, ...
	lda.b a3
	clc
	adc.b d0
	tay
	lda.w temp1,y
	sec
	sbc.b d7
	sta.w temp1,y
	bmi .4
	jmp.w rtsfaceoff
.4:									; X = a3, push X, a3 = d1, push Y, ...
	ldx.b a3
	phx
	ldx.b d1
	stx.b a3
	phy
	ldy.w #$0000
	lda.w pfteam,x
	beq .5
	ldy.w #$0002
.5:									; A = tmflags,y, pull Y, if $0008 bits clear go to .6, d2 = 0, ...
	lda.w tmflags,y
	ply
	bit.w #$0008
	beq .6
	stz.b d2
	jsl.l lcfound
	bmi .6
	jsl.l SetLCmode2
.6:									; pull X, a3 = X, return
	plx
	stx.b a3
	rtl
FirstTeamPad:						; A = the first pad (0-8 by 2) whose padside is team a2, or $FFFF
	ldy.w #$0000
.loop:								; loop: if padside,y = a2 go to .1, Y + 1, Y + 1, ...
	lda.w padside,y
	cmp.b a2
	beq .1
	iny
	iny
	cpy.w #$000A
	bcc .loop
	lda.w #$FFFF
	bra .rtl
.1:									; A = Y
	tya
.rtl:								; return
	rtl
HomePadPlayer:						; A = the player of home's first pad (c1playernum)
	lda.w #$0000
	sta.b a2
	jsl.l FirstTeamPad
	tay
	lda.w c1playernum,y
	rtl
AwayPadPlayer:						; A = the player of the away team's first pad (c1playernum)
	lda.w #$0002
	sta.b a2
	jsl.l FirstTeamPad
	tay
	lda.w c1playernum,y
	rtl
limitfo:							; keeps the face off spot away from the blue line for every called
									; penalty: LimitPenaltyFaceoff for each PenBuf entry
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	stz.b $65
	lda.w #PenBuf
	sta.b a0
.loop:								; loop: A = [a0], call LimitPenaltyFaceoff, a0 + 1, a0 + 1, ...
	lda.b [a0]
	jsl.l LimitPenaltyFaceoff
	inc.b a0
	inc.b a0
	lda.b [a0]
	bne .loop
	pla
	sta.b $69
	pla
	sta.b a1
	pla
	sta.b $65
	pla
	sta.b a0
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
	rtl
LimitPenaltyFaceoff:				; for called penalty A (not $34): when foy is past $5C toward the end the
									; penalized player defends (pfgoal), the spot moves to that end's dot (foy
									; +-$45, fox +-$50 by its side)
	and.w #$00FF
	cmp.w #$0034
	beq .rtl
	lda.b [a0]
	xba
	and.w #$007F
	asl a
	tay
	lda.w #$005C
	sta.b d1
	lda.w pfgoal,y
	bne .1
	lda.w #$FFA4
	sta.b d1
	cmp.w foy
	bmi .rtl
	lda.w #$FFBB
	sta.w foy
	bra .2
.1:									; if d1 - foy >= 0 go to .rtl, foy = $0045
	lda.b d1
	cmp.w foy
	bpl .rtl
	lda.w #$0045
	sta.w foy
.2:									; d0 = $0050, if fox >= 0 go to .3, d0 = $FFB0
	lda.w #$0050
	sta.b d0
	lda.w fox
	bpl .3
	lda.w #$FFB0
	sta.b d0
.3:									; fox = d0
	lda.b d0
	sta.w fox
.rtl:								; return
	rtl

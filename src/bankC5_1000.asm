; Segment bankC5_1000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C510F6
CODE_C510F6:						; called from other segments
	phx
	lda.w $186A
	asl a
	tax
	lda.l DATA8_C51112,x
	sta.b tmp0
	lda.l DATA8_C5110A,x
	sta.b d0
	plx
	rtl
DATA8_C5110A:						; not traced: a table read by CODE_C510F6
	db $2C,$01,$58,$02,$B0,$04,$1E,$00
DATA8_C51112:						; not traced: a table read by CODE_C510F6
	db $00,$05,$00,$10,$00,$20,$30,$00
CODE_C5111A:						; from CODE_C51DEA and other segments
	ldx.b a3
	rtl
CODE_C5111D:						; no caller found (not traced)
	lda.w gsp
	sta.b d0
	cmp.w #$0004
	bne .1
	dec.w $07D4
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
	lda.w #$04F5
	sta.b a1
	lda.w #$0004
	sta.b [a1]
	lda.w #$0020
	sta.w $04F7
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
	sta.w $04F7
.2:									; A = RDMPYL, A + $0030, $04F8 = A, return
	lda.l RDMPYL
	adc.w #$0030
	sta.w $04F8
	rtl
AlignBigNumber:						; no caller found (not traced)
	ldy.w #$0002
.loop:								; loop: $07D4 - 1, A = [a1],y, A and $00FF, if A = $0031 go to .1, ...
	dec.w $07D4
	lda.b [a1],y
	and.w #$00FF
	cmp.w #$0031
	beq .1
	dec.w $07D4
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
CODE_C511B8:						; called from other segments
	phx
	ldx.b a0
	lda.w $2458,x
	cmp.w #$0004
	bcc .1
	jmp.w .6
.1:									; X = a0, if $2458,x is not $0003 go to .4, A = $0005
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	ldx.b a0
	lda.w $2458,x
	cmp.w #$0003
	bne .4
	lda.w #$0005
	sta.w $2458,x
	lda.w $2468,x
	sec
	sbc.w $2478,x
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
	lda.w $2468,x
	cmp.w $2478,x
	bne .5
	inc a
	sta.w $2468,x
	bra .5
.3:									; $2458,x = $0003, A = $2488,x, A or $0002, $2488,x = A, ...
	lda.w #$0003
	sta.w $2458,x
	lda.w $2488,x
	ora.w #$0002
	sta.w $2488,x
	bra .5
.4:									; $2458,x + 1, d0 = $2418,x, d1 = $2428,x, call CODE_C512B1, ...
	inc.w $2458,x
	lda.w $2418,x
	sta.b d0
	lda.w $2428,x
	sta.b d1
	jsl.l CODE_C512B1
	ldx.b a0
	lda.w $2468,x
	clc
	adc.b d0
	sta.w $2468,x
	lda.w $2428,x
	sta.b d0
	lda.w $2418,x
	sta.b d1
	jsl.l CODE_C512B1
	ldx.b a0
	lda.w $2478,x
	clc
	adc.b d0
	sta.w $2478,x
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
CODE_C512B1:						; from CODE_C511B8 and other segments
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
.1:									; d0 - 1, if the result >= 0 go to .loop, d0 = d1, call CODE_C37EBF
	dec.b d0
	bpl .loop
	lda.b d1
	sta.b d0
	jsl.l CODE_C37EBF
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
CODE_C51397:						; called from other segments
	lda.w #$A0A0
	sta.l $7E2CD0
	sta.l $7E2CD5
	lda.w #$A005
	sta.l $7E2CCF
	sep #$21
	lda.b #$BA
	sta.l $7E2CD2
	lda.w $1152
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
	lda.w $1151
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
CODE_C513F4:						; called from other segments
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
CODE_C5147D:						; from pplpen, DispPen
	rtl
DispPen:							; from CODE_C513F4 and other segments
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
	bne CODE_C5147D
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
	lda.w $07D6
	cmp.w #$000B
	bcs CODE_C5147D
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
	lda.w $17D3,y
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
	sta.w $0810
	sty.w $0812
	lda.w #$0001
	trb.w sflags
	lda.w gsp
	cmp.w #$0004
	beq .1
	bra .1
.1:									; $07AA = $0708, $07F0 = $0001, A = Vcount, A - $0150, ...
	lda.w #$0708
	sta.w $07AA
	lda.w #$0001
	sta.w $07F0
	lda.b Vcount
	sec
	sbc.w #$0150
	sta.w $07F4
	jsl.l Intermission_ticker
	lda.w TickerNum
	sta.w $24C8
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
.3:									; $153F = $0001, if $23BA = 0 go to .4, go to .5
	lda.w #$0001
	sta.w $153F
	lda.w $23BA
	beq .4
	jmp.w .5
.4:									; call CODE_C40A02
	jsl.l CODE_C40A02
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
.5:									; Vcount = 0, $07C6 = 0, $2372 = 0, $153F = 0, ...
	stz.b Vcount
	stz.w $07C6
	stz.w $2372
	stz.w $153F
	stz.w $07F0
CODE_C51667:						; from Intermission_ticker
	rtl
Intermission_ticker:				; the intermission's ticker (Intermission calls it where 94S calls
									; Intermission_ticker)
	lda.w TickerNum
	bmi .1
	ora.w $24C6
	bne .2
.1:									; call GetShifter, TickerNum = d1, if d1 < 0 go to CODE_C51667
	jsl.l GetShifter
	lda.b d1
	sta.w TickerNum
	bmi CODE_C51667
.2:									; go to CODE_C51752
	jmp.w CODE_C51752
Intermission_tick:					; no caller found (not traced)
	lda.w $07F0
	beq CODE_C516A6
	lda.b Vcount
	sec
	sbc.w $07F4
	cmp.w #$0150
	bcc CODE_C516A6
	jsl.l NewTicker2_next
	lda.w $24C8
	cmp.w TickerNum
	bne Intermission_tick
	jsl.l CODE_C51811
	lda.w #$0008
	trb.w sflags3
CODE_C516A6:						; from Intermission_tick, NewTicker2_next
	lda.w #$0000
	rtl
NewTicker2_next:					; from Intermission_tick and other segments
	lda.w TickerNum
	bmi .1
	ora.w $24C6
	bne .2
.1:									; call GetShifter, TickerNum = d1, if d1 < 0 go to CODE_C516A6
	jsl.l GetShifter
	lda.b d1
	sta.w TickerNum
	bmi CODE_C516A6
.2:									; go to CODE_C51752
	jmp.w CODE_C51752
CODE_C516C2:						; called from other segments
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
CODE_C51749:						; no caller found (not traced)
	lda.w gameclock
	cmp.w #$01E1
	bcc CODE_C51752
	rtl
CODE_C51752:						; from Intermission_ticker, NewTicker2_next, CODE_C51749, CODE_C51752, ...
	lda.w TickerNum
	sta.b d3
	bmi .rtl
	dec.w TickerNum
	lda.b d3
	cmp.w $24C6
	beq CODE_C51752
	bra .1
.rtl:								; return
	rtl
.1:									; A = d3, A * 2, a0 = A, X = A, ...
	lda.b d3
	asl a
	sta.b a0
	tax
	lda.w $2488,x
	bit.w #$0006
	bne CODE_C51752
	lda.w sflags
	bit.w #$0001
	bne .2
.2:									; A = $07D6, A - $0005, $07D6 = A, d0 = $001C, ...
	lda.w $07D6
	sec
	sbc.w #$0005
	sta.w $07D6
	lda.w #$001C
	sta.b d0
	lda.w #$0005
	sta.b d1
	lda.b Vcount
	sta.w $07F4
	inc.w $07D4
	lda.w $07D6
	sec
	sbc.w #$0004
	sta.w $07D6
	lda.w $07D4
	pha
	jsl.l GetShifter
	lda.w #$2400
	sta.w $07D2
	lda.b $01,s
	sta.w $07D4
	lda.w $24C4
	inc a
	sta.b d0
	lda.w $1864
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
	jsl.l CODE_C52295
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
CODE_C51811:						; from Intermission_tick and other segments
	rtl
CODE_C51812:						; no caller found (not traced)
	lda.w #$0013
	sta.b d0
	lda.w #$0009
	sta.b d1
	lda.w $24C0
	sta.b d2
	jml.l CODE_C528D4
CODE_C51825:						; called from other segments
	pei ($6D)
	pei ($6B)
	pei ($71)
	pei ($6F)
	inc.w $18AA
	lda.w #$FFFF
	sta.w lcpad
	sta.w $184E
	jsl.l CODE_C54BAF
	lda.w $2038
	sec
	sbc.w #$0006
	sta.b $6D
	tax
	ldy.w #$0004
	lda.w $203E,x
	bit.w #$0080
	bne .1
	iny
	iny
	lda.w $203F,x
	bit.w #$0080
	bne .1
	iny
.1:									; X = $0013, A = $584C, call CODE_C58C36, Y = $0000, ...
	ldx.w #$0013
	lda.w #$584C
	jsl.l CODE_C58C36
	ldy.w #$0000
	ldx.b $6D
	lda.w $203C,x
	bit.w #$0080
	beq .2
	ldy.w #$001A
.2:									; a2 = Y, A = $203D,x, A and $00FF, A + a2, ...
	sty.b a2
	lda.w $203D,x
	and.w #$00FF
	clc
	adc.b a2
	tay
	lda.w #$2DC9
	ldx.b a2
	beq .3
	lda.w #$3207
.3:									; a2 = A, A = $1413,y, A and $00FF, if A is not $0003 go to .4, ...
	sta.b a2
	lda.w $1413,y
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
	lda.w $203D,x
	and.w #$00FF
	jsr.w CODE_C51911
	ldx.b $6D
	lda.w $203E,x
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
	lda.w $203F,x
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
CODE_C51911:						; from CODE_C51825
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
	sta.w $04F5,x
	txa
	sec
	adc.w #$04F5
	tay
	lda.b $71
	clc
	adc.w #$0008
	tax
	lda.w #$000D
	jsr.w CODE_C55F22
	ldx.w #$04F5
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
CODE_C51999:						; called from other segments
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
	lda.w $1864
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
	sta.w $2030
.rtl:								; return
	rtl
.3:									; push X, call CODE_C58944, push Y, push A, ...
	phx
	jsl.l CODE_C58944
	phy
	pha
	lda.w penshot
	bne .4
	lda.w $1864
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
	jsr.w CODE_C51A4E
	lda.w $2034
	sta.w $0830
	lda.w $2036
	sta.w pucky
	stz.b d4
	jsr.w CODE_C51A30
	lda.w #$0002
	sta.b d4
	jsr.w CODE_C51A30
	rtl
CODE_C51A30:						; from CODE_C51A13
	ldy.w #$0008
.loop:								; loop: if $1525,y < 0 go to .1, if $1525,y = d4 go to .2
	lda.w $1525,y
	bmi .1
	cmp.b d4
	beq .2
.1:									; Y - 1, Y - 1, if the result >= 0 go to .loop, go to .rts
	dey
	dey
	bpl .loop
	bra .rts
.2:									; if c1playernum,y >= 0 go to .1, d4 = Y, call CODE_C538FE
	lda.w c1playernum,y
	bpl .1
	sty.b d4
	jsl.l CODE_C538FE
.rts:								; return
	rts
CODE_C51A4E:						; from CODE_C51A13, CODE_C51A61
	stz.w $0830
	stz.w pucky
	stz.w puckz
	stz.w puckvx
	stz.w puckvy
	stz.w puckvz
	rts
CODE_C51A61:						; called from other segments
	jsr.w CODE_C51A4E
	phx
	ldx.w #$0000
	lda.w #$0002
	sta.b d4
	lda.w BA_Team
	beq .1
	ldx.w #$000C
	lda.w #$0000
	sta.b d4
.1:									; d0 = $0010, call CODE_C38824, call CODE_C38824, call CODE_C38824, ...
	lda.w #$0010
	sta.b d0
	jsl.l CODE_C38824
	jsl.l CODE_C38824
	jsl.l CODE_C38824
	jsl.l CODE_C38824
	jsl.l CODE_C38824
	jsl.l CODE_C38824
	ldx.b d4
	lda.w teampads,x
	beq .4
	lda.w $17C1,x
	beq .4
	ldy.w #$0000
.loop:								; loop: if $1525,y < 0 go to .2, if $1525,y = d4 go to .3
	lda.w $1525,y
	bmi .2
	cmp.b d4
	beq .3
.2:									; Y + 1, Y + 1, if Y < $000A go to .loop, go to .4
	iny
	iny
	cpy.w #$000A
	bcc .loop
	bra .4
.3:									; d4 = Y, call CODE_C538FE
	sty.b d4
	jsl.l CODE_C538FE
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
.5:									; puckc = BA_Sktr_SCnum, Y = A, if $18B6 < 0 go to .6, playerpad,y = A
	lda.w BA_Sktr_SCnum
	sta.w puckc
	tay
	lda.w $18B6
	bmi .6
	sta.w playerpad,y
.6:									; PenShotActive = 0, PenShotActive + 1, $18C0 = $0001, $18C2 = $0384, ...
	stz.w PenShotActive
	inc.w PenShotActive
	lda.w #$0001
	sta.w $18C0
	lda.w #$0384
	sta.w $18C2
	jml.l CODE_C4818C
CODE_C51AFF:						; called from other segments
	lda.w #$000D
	jsl.l StartSound
	lda.w #$0100
	trb.w sflags
	stz.w $2016
	lda.w #$0400
	trb.w sflags
	stz.w replaydelay
	stz.w gmclock
	lda.w #$0010
	tsb.w sflags3
	lda.w $2018
	sta.b d3
	lda.w #$0800
	sta.b d4
	stz.b a1
	lda.w #$0010
	sta.b d2
	ldx.w $2028
	lda.l $C51C51,x
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
	ldx.w $202C
	lda.l $C51C51,x
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
.3:									; X = a1, A = $202A,x, if $0800 bits clear go to .4, d3 = $201A, ...
	ldx.b a1
	lda.w $202A,x
	bit.w #$0800
	beq .4
	lda.w $201A
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
	jsr.w CODE_C51C39
	bmi .10
	lda.w puckvy
	bpl .8
	lda.w pfgoal,y
	bne .9
.7:									; A = $0004, Y = $000C, call CODE_C51C39, if minus go to .10, ...
	lda.w #$0004
	ldy.w #$000C
	jsr.w CODE_C51C39
	bmi .10
	bra .9
.8:									; if pfgoal,y is not 0 go to .7
	lda.w pfgoal,y
	bne .7
.9:									; a2 = Y, X = a3, call a2touchpuck
	sty.b a2
	ldx.b a3
	jsl.l a2touchpuck
.10:								; A = tmflags, A and $FFFB, tmflags = A, A = $1301, ...
	lda.w tmflags
	and.w #$FFFB
	sta.w tmflags
	lda.w $1301
	and.w #$FFFB
	sta.w $1301
	ldx.b a3
	jsl.l RandomWord
	and.w #$07FF
	sta.w puckvz
	stz.w puckz
	stz.w pfnc,x
	lda.w #$0018
	sta.b d0
	jml.l assreplace
CODE_C51C39:						; from CODE_C51AFF
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
CODE_C51C58:						; called from other segments
	lda.w asscur,x
	cmp.w #$0017
	bne .rtl
	lda.w pfgoal,x
	beq .2
	lda.b d0
	sta.w $201A
	lda.w pf2aip,x
	bne .rtl
	lda.b d1
	bit.w #$8000
	beq .4
	sta.w pf2aip,x
	lda.w $1864
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
.2:									; $2018 = d0, if pf2aip,x is not 0 go to .rtl, A = d1, ...
	lda.b d0
	sta.w $2018
	lda.w pf2aip,x
	bne .rtl
	lda.b d1
	bit.w #$8000
	beq .4
	sta.w pf2aip,x
	lda.w $1864
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
CODE_C51CC1:						; asstab entry 27: an assignment routine
	stz.w $14E5
	lda.w $189C
	beq .1
	lda.w $189E
	beq .1
	inc.w $18A2
	rtl
.1:									; puckc = $FFFF, call pucknorm_move, A = pflags,x, ...
	lda.w #$FFFF
	sta.w puckc
	jsl.l pucknorm_move
	lda.w pflags,x
	bit.w #$0002
	bne .2
	jmp.w CODE_C51E81
.2:									; A and $FFFD, pflags,x = A, if gameclock is not 0 go to .3, ...
	and.w #$FFFD
	sta.w pflags,x
	lda.w gameclock
	bne .3
	jml.l CODE_C50ADD
.3:									; A = gmode, if $0040 bits clear go to .4, go to CODE_C50ADD
	lda.w gmode
	bit.w #$0040
	beq .4
	jml.l CODE_C50ADD
.4:									; if gsp is not $0003 go to .5, if tmscore = $12AD go to .5, ...
	lda.w gsp
	cmp.w #$0003
	bne .5
	lda.w tmscore
	cmp.w $12AD
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
	lda.w $186E
	bne .7
	jmp.w CODE_C51E81
.7:									; A = penshot, if the result = 0 go to .8, go to CODE_C51E81
	lda.w penshot
	ora.w $18C0
	beq .8
	jmp.w CODE_C51E81
.8:									; lcpad = $FFFF, $184E = A, $18E2 = 0, $18E4 = 0, ...
	lda.w #$FFFF
	sta.w lcpad
	sta.w $184E
	stz.w $18E2
	stz.w $18E4
	lda.w #$0008
	trb.w tmflags
	trb.w $1301
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
	jsl.l CODE_C52264
.9:									; if $234C is not 0 go to .10, if teampads = 0 go to .10, ...
	lda.w $234C
	bne .10
	lda.w teampads
	beq .10
	jsl.l CODE_C51F60
	lsr a
	sta.b d0
	jsl.l CODE_C51DF6
.10:								; if $234C is not 0 go to .11, if $14F7 = 0 go to .11, ...
	lda.w $234C
	bne .11
	lda.w $14F7
	beq .11
	jsl.l CODE_C51F6E
	lsr a
	sta.b d0
	jsl.l CODE_C51E0C
.11:								; $234C = 0, a1 = 0, a2 = $0002, d0 = A, ...
	stz.w $234C
	stz.b a1
	lda.w #$0002
	sta.b a2
	sta.b d0
	jsl.l CODE_C51DB8
	jmp.w CODE_C51E81
CODE_C51DB8:						; from CODE_C51E81, CODE_C51CC1 and other segments
	lda.w $186E
	bne .1
	jmp.w CODE_C51E80
.1:									; if d0 is not cont1team go to .2, go to CODE_C51E80
	lda.b d0
	cmp.w cont1team
	bne .2
	jmp.w CODE_C51E80
.2:									; if A is not cont2team go to .3, go to CODE_C51E80
	cmp.w cont2team
	bne .3
	jmp.w CODE_C51E80
.3:									; if A is not cont3team go to .4, go to CODE_C51E80
	cmp.w cont3team
	bne .4
	jmp.w CODE_C51E80
.4:									; if A is not cont4team go to .5, go to CODE_C51E80
	cmp.w cont4team
	bne .5
	jmp.w CODE_C51E80
.5:									; if A is not cont5team go to CODE_C51DEA, go to CODE_C51E80
	cmp.w cont5team
	bne CODE_C51DEA
	jmp.w CODE_C51E80
CODE_C51DEA:						; from CODE_C51DF6, CODE_C51E0C, CODE_C51DB8
	jsl.l CompLine
	jsl.l setpersonel
	jml.l CODE_C5111A
CODE_C51DF6:						; from CODE_C51CC1 and other segments
	lda.w $186E
	cmp.w #$0002
	bne CODE_C51E1F
	stz.b a2
	lda.w #$0002
	sta.b a1
	lda.w #$0001
	sta.b d0
	bra CODE_C51DEA
CODE_C51E0C:						; from CODE_C51CC1 and other segments
	lda.w $186E
	cmp.w #$0002
	bne CODE_C51E1F
	stz.b a1
	lda.w #$0002
	sta.b a2
	sta.b d0
	bra CODE_C51DEA
CODE_C51E1F:						; from CODE_C51DF6, CODE_C51E0C
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
.1:									; lcpad,y = $FFFF, call CODE_C5404A, pull Y, a2 = Y, ...
	lda.w #$FFFF
	sta.w lcpad,y
	jsl.l CODE_C5404A
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
CODE_C51E80:						; from CODE_C51DB8, CODE_C51E81, CODE_C51EB8, CODE_C51DB8, ...
	rtl
CODE_C51E81:						; no caller found (not traced)
	stz.w $18C0
	stz.b d0
	jsl.l CODE_C51EB8
	lda.w #$0020
	sta.b d0
	jsl.l CODE_C51EB8
	ldx.b a3
	lda.w temp1,x
	bpl CODE_C51E80
	lda.w temp2,x
	bpl CODE_C51E80
	stz.b a2
	lda.w #$0001
	sta.b d0
	inc a
	sta.b a1
	jsl.l CODE_C51DB8
	lda.w #$001C
	sta.b d0
	ldx.b a3
	jml.l assreplace
CODE_C51EB8:						; from CODE_C51E81 and other segments
	lda.b a3
	clc
	adc.b d0
	tay
	lda.w temp1,y
	bmi CODE_C51E80
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
	jmp.w CODE_C54070
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
	jmp.w CODE_C51E80
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
	jsl.l CODE_C54070
.6:									; pull X, a3 = X, return
	plx
	stx.b a3
	rtl
CODE_C51F48:						; from CODE_C51F60, CODE_C51F6E and other segments
	ldy.w #$0000
.loop:								; loop: if $1525,y = a2 go to .1, Y + 1, Y + 1, ...
	lda.w $1525,y
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
CODE_C51F60:						; from CODE_C51CC1 and other segments
	lda.w #$0000
	sta.b a2
	jsl.l CODE_C51F48
	tay
	lda.w c1playernum,y
	rtl
CODE_C51F6E:						; from CODE_C51CC1 and other segments
	lda.w #$0002
	sta.b a2
	jsl.l CODE_C51F48
	tay
	lda.w c1playernum,y
	rtl
CODE_C51F7C:						; called from other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	stz.b $65
	lda.w #$10F9
	sta.b a0
.loop:								; loop: A = [a0], call CODE_C51FBA, a0 + 1, a0 + 1, ...
	lda.b [a0]
	jsl.l CODE_C51FBA
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
CODE_C51FBA:						; from CODE_C51F7C and other segments
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
	cmp.w $2036
	bmi .rtl
	lda.w #$FFBB
	sta.w $2036
	bra .2
.1:									; if d1 - $2036 >= 0 go to .rtl, $2036 = $0045
	lda.b d1
	cmp.w $2036
	bpl .rtl
	lda.w #$0045
	sta.w $2036
.2:									; d0 = $0050, if $2034 >= 0 go to .3, d0 = $FFB0
	lda.w #$0050
	sta.b d0
	lda.w $2034
	bpl .3
	lda.w #$FFB0
	sta.b d0
.3:									; $2034 = d0
	lda.b d0
	sta.w $2034
.rtl:								; return
	rtl

; Segment bankC4_3000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4313E
assdefd:							; called from other segments
	ldy.w puckc
	bmi .2
	lda.w pfteam,x
	cmp.w pfteam,y
	bne .2
	lda.w #$0001
	sta.b d0
	jmp.w assreplace
.rtl:								; return
	rtl
.1:									; go to donothing
	jmp.w donothing
.2:									; if gmclock is not 0 go to .1, call check4bench, ...
	lda.w gmclock
	bne .1
	jsl.l check4bench
	lda.w playerpad,x
	bpl .rtl
	lda.w pflags,x
	bit.w #$0002
	beq .3
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
.3:									; A = temp1,x, A - d7, temp1,x = A, if minus go to .4, ...
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bmi .4
	jmp.w DefenceSkateAndCheck
.4:									; A + aidef,x, if the result >= 0 go to .5, A = $0000
	clc
	adc.w aidef,x
	bpl .5
	lda.w #$0000
.5:									; temp1,x = A, d1 = pucky, A = puckvy, A / 2, ...
	sta.w temp1,x
	lda.w pucky
	sta.b d1
	lda.w puckvy
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0200
	beq .6
	ora.w #$FC00
.6:									; d3 = A, if pfgoal,x is not 0 go to .7, A = $0000, A - d1, ...
	sta.b d3
	lda.w pfgoal,x
	bne .7
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
	lda.w #$0000
	sec
	sbc.b d3
	sta.b d3
.7:									; if d3 >= 0 go to .8, d3 = 0
	lda.b d3
	bpl .8
	stz.b d3
.8:									; A = d3, A + d1, d3 = A, A - $005C, ...
	lda.b d3
	clc
	adc.b d1
	sta.b d3
	sec
	sbc.w #$005C
	bmi .10
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne .10
	lda.w puckc
	bmi .9
	lsr a
.9:									; d1 = A, if minus go to .10, call chkpk, if zero go to .10, ...
	sta.b d1
	bmi .10
	jsl.l chkpk
	beq .10
	lda.b d1
	sec
	sbc.w #$0006
	sta.b d1
	txa
	lsr a
	sec
	sbc.w #$0006
	sta.b d2
	eor.b d1
	sta.b d1
.10:								; temp3,x = $0041, if position,x = $0002 go to .11, temp3,x = $FFBF
	lda.w #$0041
	sta.w temp3,x
	lda.w position,x
	cmp.w #$0002
	beq .11
	lda.w #$FFBF
	sta.w temp3,x
.11:								; Y = $0000, if X >= $000C go to .12, Y = $000C
	ldy.w #$0000
	cpx.w #$000C
	bcs .12
	ldy.w #$000C
.12:								; d2 = $0006, d0 = $FC18, if pfgoal,x = 0 go to DefenceScanTopThreats, d0
									; = $03E8
	lda.w #$0006
	sta.b d2
	lda.w #$FC18
	sta.b d0
	lda.w pfgoal,x
	beq DefenceScanTopThreats
	lda.w #$03E8
	sta.b d0
.loop:								; loop: a0 = Y, A = pflags,y, if a $1000 bit set go to .15, ...
	sty.b a0
	lda.w pflags,y
	bit.w #$1000
	bne .15
	lda.w position,y
	bmi .15
	lda.w Yvel,y
	bmi .13
	lda.w #$0000
.13:								; A / 2, A / 2, A / 2, A / 2, ...
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0400
	beq .14
	ora.w #$F800
.14:								; A + Ypos,y, d1 = A, A - d0, if the result >= 0 go to .15, ...
	clc
	adc.w Ypos,y
	sta.b d1
	sec
	sbc.b d0
	bpl .15
	lda.b d1
	sta.b d0
.15:								; Y = a0, Y + 1, Y + 1, d2 - 1, ...
	ldy.b a0
	iny
	iny
	dec.b d2
	bne .loop
	lda.b d0
	sec
	sbc.w #$0028
	sta.b d0
	sec
	sbc.w #$FF42
	bpl .16
	lda.w #$FF24
	sta.b d0
.16:								; temp4,x = d0, d0 = puckx, A = temp3,x, A xor d0, ...
	lda.b d0
	sta.w temp4,x
	lda.w puckx
	sta.b d0
	lda.w temp3,x
	eor.b d0
	sta.b d1
	bpl DefenceSkateAndCheck
	stz.w temp3,x
	bra DefenceSkateAndCheck
DATA8_C432A0:						; an rtl no traced code reaches
	db $6B
DefenceScanTopThreats:				; scan opponents for the top-end defensive depth target
	sty.b a0
	lda.w pflags,y
	bit.w #$1000
	bne .3
	lda.w position,y
	bmi .3
	lda.w Yvel,y
	bpl .1
	lda.w #$0000
.1:									; A / 2, A / 2, A / 2, A / 2, ...
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0400
	beq .2
	ora.w #$F800
.2:									; A + Ypos,y, d1 = A, A - d0, if the result < 0 go to .3, ...
	clc
	adc.w Ypos,y
	sta.b d1
	sec
	sbc.b d0
	bmi .3
	lda.b d1
	sta.b d0
.3:									; Y = a0, Y + 1, Y + 1, d2 - 1, ...
	ldy.b a0
	iny
	iny
	dec.b d2
	bne DefenceScanTopThreats
	lda.b d0
	clc
	adc.w #$0028
	sta.b d0
	sec
	sbc.w #$00BE
	bmi .4
	lda.w #$00DC
	sta.b d0
.4:									; temp4,x = d0, A = $0000, A - temp3,x, temp3,x = A, ...
	lda.b d0
	sta.w temp4,x
	lda.w #$0000
	sec
	sbc.w temp3,x
	sta.w temp3,x
	lda.w puckx
	sta.b d0
	lda.w temp3,x
	eor.b d0
	sta.b d1
	bpl DefenceSkateAndCheck
	stz.w temp3,x
DefenceSkateAndCheck:				; skate the defender to the saved target and look for a check
	lda.w temp3,x
	sta.b d0
	lda.w temp4,x
	sta.b d1
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b a0
	jsl.l skateto
	jmp.w check4check
assdefo:							; called from other segments
	cpx.w puckc
	beq DefenceTakePuckAssignment
	ldy.w puckc
	bmi OffensiveDefenceThink
	lda.w pfteam,x
	cmp.w pfteam,y
	beq OffensiveDefenceThink
	lda.w #$0002
	sta.b d0
	jmp.w assreplace
OffensiveDefenceReturn:				; return from the offensive defender assignment
	rtl
DATA8_C43345:						; not traced: data between routines
	db $4C,$FD,$36
DefenceTakePuckAssignment:			; insert the puck carrier assignment for the defender
	lda.w #$0011
	sta.b d0
	jmp.w assinsert
OffensiveDefenceThink:				; update computer offensive defender movement
	lda.w gmclock
	beq .1
	jmp.w donothing
.1:									; call check4bench, if playerpad,x >= 0 go to OffensiveDefenceReturn, ...
	jsl.l check4bench
	lda.w playerpad,x
	bpl OffensiveDefenceReturn
	lda.w pflags,x
	bit.w #$0002
	beq .2
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
.2:									; A = temp1,x, A - d7, temp1,x = A, if plus go to .4, ...
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl .4
	clc
	adc.w aioff,x
	bpl .3
	lda.w #$0000
.3:									; temp1,x = A
	sta.w temp1,x
.4:									; $65 = EvadePC>>16, a0 = EvadePC, Y = $0050, ...
	lda.w #EvadePC>>16
	sta.b $65
	lda.w #EvadePC
	sta.b a0
	ldy.w #$0050
	lda.w position,x
	cmp.w #$0002
	beq .5
	ldy.w #$FFB0
.5:									; if pfgoal,x is not 0 go to .6, A = Y, A xor $FFFF, A + 1, ...
	lda.w pfgoal,x
	bne .6
	tya
	eor.w #$FFFF
	inc a
	tay
.6:									; d0 = Y, A = puckx, if the result < 0 go to OffensiveDefenceBlendX, A =
									; puckx, ...
	sty.b d0
	lda.w puckx
	eor.b d0
	bmi OffensiveDefenceBlendX
	lda.w puckx
	bra OffensiveDefenceTargetY
DATA8_C433C3:						; an rtl no traced code reaches
	db $6B
OffensiveDefenceBlendX:				; blend the puck X position into the defender lateral target
	lda.w puckx
	pha
	asl a
	pla
	ror a
	clc
	adc.b d0
OffensiveDefenceTargetY:			; choose the offensive defender depth and skate to the target
	sta.b d0
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne .6
	lda.w pucky
	sta.b d2
	lda.w pfgoal,x
	bne .1
	lda.w #$0000
	sec
	sbc.b d2
	sta.b d2
.1:									; if d2 - $FFA4 < 0 go to .3, if d2 - $005C < 0 go to .2, d1 = $0066, ...
	lda.b d2
	cmp.w #$FFA4
	bmi .3
	cmp.w #$005C
	bmi .2
	lda.w #$0066
	sta.b d1
	bra .4
.2:									; d1 = $FFAE, go to .4
	lda.w #$FFAE
	sta.b d1
	bra .4
.3:									; d1 = $FF24
	lda.w #$FF24
	sta.b d1
.4:									; if pfgoal,x is not 0 go to .5, A = $0000, A - d1, d1 = A
	lda.w pfgoal,x
	bne .5
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
.5:									; go to skateto
	jmp.w skateto
.6:									; Y = $0066, if pfgoal,x = 0 go to .7, Y = $FF9A
	ldy.w #$0066
	lda.w pfgoal,x
	beq .7
	ldy.w #$FF9A
.7:									; d1 = Y, go to .5
	sty.b d1
	bra .5
EvadePC:							; passed as a long pointer (lda #bank, lda #low) to skateto
	lda.w puckc
	bmi .rtl
	lda.w $09A1,x
	sec
	sbc.w $09BD
	and.w #$00FF
	bit.w #$0080
	beq .1
	ora.w #$FF00
.1:									; A + Xpos,x, A - puckx, if A - $FFD7 < 0 go to .rtl, ...
	clc
	adc.w Xpos,x
	sec
	sbc.w puckx
	cmp.w #$FFD7
	bmi .rtl
	cmp.w #$0029
	bpl .rtl
	lda.w $09C1,x
	sec
	sbc.w $09DD
	and.w #$00FF
	bit.w #$0080
	beq .2
	ora.w #$FF00
.2:									; A + Ypos,x, A - pucky, if A - $FFD7 < 0 go to .rtl, ...
	clc
	adc.w Ypos,x
	sec
	sbc.w pucky
	cmp.w #$FFD7
	bmi .rtl
	cmp.w #$0029
	bpl .rtl
	lda.w Xpos,x
	sec
	sbc.w puckx
	sta.b d0
	lda.w Ypos,x
	sec
	sbc.w pucky
	sta.b d1
	jml.l vtoa
.rtl:								; return
	rtl
asswingd:							; called from other segments
	ldy.w puckc
	bmi .2
	lda.w pfteam,x
	cmp.w pfteam,y
	bne .2
	lda.w #$0004
	sta.b d0
	jmp.w assreplace
.rtl:								; return
	rtl
.1:									; go to donothing
	jmp.w donothing
.2:									; if gmclock is not 0 go to .1, call check4bench, ...
	lda.w gmclock
	bne .1
	jsl.l check4bench
	lda.w playerpad,x
	bpl .rtl
	lda.w pflags,x
	bit.w #$0002
	beq .3
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
.3:									; A = temp1,x, A - d7, temp1,x = A, if plus go to .5, ...
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl .5
	clc
	adc.w aidef,x
	bpl .4
	lda.w #$0000
.4:									; temp1,x = A
	sta.w temp1,x
.5:									; d0 = $0064, if position,x is not $0005 go to .6, d0 = $FF9C
	lda.w #$0064
	sta.b d0
	lda.w position,x
	cmp.w #$0005
	bne .6
	lda.w #$FF9C
	sta.b d0
.6:									; Y = puckc, if pfgoal,x = 0 go to DefensiveWingTopTarget, A = $0000, A -
									; d0, ...
	ldy.w puckc
	lda.w pfgoal,x
	beq DefensiveWingTopTarget
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$FF5E
	sta.b d1
	lda.w #$FFAE
	sta.b d2
	lda.w position,y
	beq DefensiveWingUseLimit
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne DefensiveWingUseLimit
	lda.b d2
	sec
	sbc.w pucky
	bpl DefensiveWingBottomLimit
	lda.w pucky
	sta.b d1
	bra DefensiveWingSkate
DATA8_C43530:						; an rtl no traced code reaches
	db $6B
DefensiveWingBottomLimit:			; limit the defensive wing target at the bottom goal line
	lda.w #$FEF2
	sta.b d2
	sec
	sbc.w pucky
	bmi DefensiveWingSkate
	bra DefensiveWingUseLimit
DefensiveWingTopTarget:				; choose the defensive wing target depth at the top end
	lda.w #$00A2
	sta.b d1
	lda.w #$0052
	sta.b d2
	lda.w position,y
	beq DefensiveWingUseLimit
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne DefensiveWingUseLimit
	lda.b d2
	sec
	sbc.w pucky
	bmi .1
	lda.w pucky
	sta.b d1
	bra DefensiveWingSkate
.1:									; d2 = $010E, A - pucky, if the result >= 0 go to DefensiveWingSkate
	lda.w #$010E
	sta.b d2
	sec
	sbc.w pucky
	bpl DefensiveWingSkate
DefensiveWingUseLimit:				; use the selected depth limit as the defensive wing target
	lda.b d2
	sta.b d1
DefensiveWingSkate:					; finish the defensive wing lateral target and skate there
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b a0
	lda.w puckx
	eor.b d0
	sta.b d2
	bmi .1
	lda.w puckx
	sta.b d0
.1:									; go to skateto
	jmp.w skateto
asswingo:							; called from other segments
	cpx.w puckc
	beq .2
	ldy.w puckc
	bmi .3
	lda.w pfteam,x
	cmp.w pfteam,y
	beq .3
	lda.w #$0003
	sta.b d0
	jmp.w assreplace
.rtl:								; return
	rtl
.1:									; go to donothing
	jmp.w donothing
.2:									; d0 = $0011, go to assinsert
	lda.w #$0011
	sta.b d0
	jmp.w assinsert
.3:									; if gmclock is not 0 go to .1, call check4bench, ...
	lda.w gmclock
	bne .1
	jsl.l check4bench
	lda.w playerpad,x
	bpl .rtl
	lda.w pflags,x
	bit.w #$0002
	beq .4
	and.w #$FFFD
	sta.w pflags,x
	lda.w #$FFFF
	sta.w temp5,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
.4:									; A = temp1,x, A - d7, temp1,x = A, if minus go to .5, ...
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bmi .5
	jmp.w .11
.5:									; A + aidef,x, if the result >= 0 go to .6, A = $0000
	clc
	adc.w aidef,x
	bpl .6
	lda.w #$0000
.6:									; temp1,x = A, d0 = pucky, A = puckvy, A / 2, ...
	sta.w temp1,x
	lda.w pucky
	sta.b d0
	lda.w puckvy
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0200
	beq .7
	ora.w #$FC00
.7:									; A + d0, d3 = A, if pfgoal,x is not 0 go to .8, A = $0000, ...
	clc
	adc.b d0
	sta.b d3
	lda.w pfgoal,x
	bne .8
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d3
	sta.b d3
.8:									; d2 = 0, A = d3, A - $FFA4, if the result < 0 go to .9, ...
	stz.b d2
	lda.b d3
	sec
	sbc.w #$FFA4
	bmi .9
	lda.w #$0008
	sta.b d2
	lda.b d0
	sec
	sbc.w #$005C
	bmi .9
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne .9
	asl.b d2
	lda.b d3
	sec
	sbc.w #$010E
	bmi .9
	lda.w #$0018
	sta.b d2
.9:									; if d2 is not temp5,x go to .10, if seed >= $0200 go to .11
	lda.b d2
	cmp.w temp5,x
	bne .10
	lda.w seed
	cmp.w #$0200
	bcs .11
.10:								; temp5,x = d2, Y = A, $65 = DATA8_C436DD>>16, a0 = DATA8_C436DD, ...
	lda.b d2
	sta.w temp5,x
	tay
	lda.w #DATA8_C436DD>>16
	sta.b $65
	lda.w #DATA8_C436DD
	sta.b a0
	iny
	iny
	lda.b [a0],y
	dey
	dey
	jsl.l randomd0s
	adc.b [a0],y
	sta.w temp3,x
	tya
	clc
	adc.w #$0006
	tay
	lda.b [a0],y
	dey
	dey
	jsl.l randomd0s
	adc.b [a0],y
	sta.w temp4,x
.11:								; d0 = temp3,x, if position,x = $0005 go to .12, A = $0000, A - d0, ...
	lda.w temp3,x
	sta.b d0
	lda.w position,x
	cmp.w #$0005
	beq .12
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.12:								; d1 = temp4,x, if pfgoal,x is not 0 go to .13, A = $0000, A - d0, ...
	lda.w temp4,x
	sta.b d1
	lda.w pfgoal,x
	bne .13
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
.13:								; $65 = EvadePC>>16, a0 = EvadePC, go to skateto
	lda.w #EvadePC>>16
	sta.b $65
	lda.w #EvadePC
	sta.b a0
	jml.l skateto
DATA8_C436DC:						; an rtl no traced code reaches
	db $6B
DATA8_C436DD:						; not traced: a table read by asswingo
	db $50,$00,$14,$00,$BA,$FF,$0A,$00,$64,$00,$14,$00,$3C,$00,$0A,$00
	db $3C,$00,$32,$00,$E6,$00,$14,$00,$50,$00,$1E,$00,$FA,$00,$14,$00
donothing:							; from OffensiveDefenceThink, assdefd, asswingd, ...
	lda.w playerpad,x
	bpl .rtl
	lda.w #$0008
	sta.b d0
	jml.l doplayeracc
.rtl:								; return
	rtl
assexit:							; from assfaceoff, assfaceoffpl and other segments
	lda.w assnum,x
	inc a
	and.w #$0007
	sta.w assnum,x
	phx
	phy
	txa
	asl a
	asl a
	adc.w assnum,x
	tay
	lda.w asslist,y
	and.w #$00FF
	ply
	plx
	sta.w asscur,x
	lda.w pflags,x
	ora.w #$0002
	sta.w pflags,x
	rtl
assinsert:							; X = player, d0 = assignment: added as the newest of the 8 slots (assnum
									; - 1), then assreplace
	lda.w assnum,x
	dec a
	and.w #$0007
	sta.w assnum,x
assreplace:							; from assdefd, assdefo, asswingd, ...
	lda.w pflags,x
	ora.w #$0002
	sta.w pflags,x
	txa
	asl a
	asl a
	adc.w assnum,x
	tay
	sep #$20
	lda.b d0
	sta.w asslist,y
	rep #$30
	sta.w asscur,x
	rtl
assfaceoff:							; assignment (asstab entry 22): players not in the face off wait until
									; sflags bit 8 clears, then clear $18AA and leave through assexit
	lda.w pfalock,x
	bne .rtl
	lda.w sflags
	bit.w #$0100
	beq .1
.rtl:								; return
	rtl
.1:									; $18AA = 0, go to assexit
	stz.w $18AA
	jmp.w assexit
assfaceoffpl:						; called from other segments
	lda.w pfalock,x
	beq .1
	jmp.w .rtl
.1:									; A = sflags, if $0100 bits clear go to .5, A = pflags,x, ...
	lda.w sflags
	bit.w #$0100
	beq .5
	lda.w pflags,x
	bit.w #$0002
	beq .2
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
.2:									; $65 = $007E, a0 = $2028, if pfteam,x = 0 go to .3, a0 = $202C
	lda.w #$007E
	sta.b $65
	lda.w #$2028
	sta.b a0
	lda.w pfteam,x
	beq .3
	lda.w #$202C
	sta.b a0
.3:									; A = SPAnum,x, A / 2, A / 2, A + 1, ...
	lda.w SPAnum,x
	lsr a
	lsr a
	inc a
	sta.b d0
	lda.w handed,x
	bne .4
	inc.b d0
	inc.b d0
	inc.b d0
.4:									; [a0] = d0, if playerpad,x >= 0 go to .rtl, A = pf2aip,x, push A, ...
	lda.b d0
	sta.b [a0]
	lda.w playerpad,x
	bpl .rtl
	lda.w pf2aip,x
	pha
	lda.w #$0001
	sta.w pf2aip,x
	pla
	cmp.w #$0000
	bne .rtl
	lda.w #$24FA
	sta.b d1
	lda.w temp1+$1C
	cmp.w #$0011
	bcc .6
	jsl.l RandomWord
	and.w #$0007
	sta.b d0
	beq .6
	lda.w #$2524
	sta.b d1
	lda.w #$0001
	sta.w pf2aip,x
	jml.l SetSPA
.5:									; $18AA = 0, nopuck,x = $0014, go to assexit
	stz.w $18AA
	lda.w #$0014
	sta.w nopuck,x
	jmp.w assexit
.6:									; A = pfgoal,x, A / 2, if carry clear go to .7, X = $2020
	lda.w pfgoal,x
	lsr a
	ldx.w $2022
	bcc .7
	ldx.w $2020
.7:									; if OptPlayMode = $0001 go to .8, $30,x = 0
	lda.w OptPlayMode
	cmp.w #$0001
	beq .8
	stz.b $30,x
.8:									; X = a3, pf2aip,x = $0001, go to SetSPA
	ldx.b a3
	lda.w #$0001
	sta.w pf2aip,x
	jml.l SetSPA
.rtl:								; return
	rtl
puckfaceoff2:						; assignment: the face off and the setup for play; on a new assignment the
									; crowd, the music, the puck and the scroll are reset (ClrHor)
	lda.w pflags,x
	bit.w #$0002
	bne .1
	jmp.w TickFaceoffCountdown
.1:									; A and $FFFD, pflags,x = A
	and.w #$FFFD
	sta.w pflags,x
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
	lda.w #$0006
	jsl.l StartSound
	jsl.l StartCrowdSound
	lda.w #$FFFF
	sta.w recsfx
	sta.w recsfx2
	stz.w $2346
	lda.l Crowdlevel
	cmp.w #$0258
	bcc .2
	lda.w #$0258
	sta.l Crowdlevel
.2:									; call FadeOutWait, fadestep = $001E, call WaitTransfers, ...
	jsl.l FadeOutWait
	lda.w #$001E
	sta.w fadestep
	jsl.l WaitTransfers
	jsl.l CODE_C539D7
	lda.w PBnum
	beq .4
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b r3
	lda.w PBnum
	and.w #$000F
	cmp.b r3
	beq .4
	bcs .3
	lda.w #$0004
	jsl.l PlayTeamSong
	bra .7
.3:									; A = $0001, call PlayTeamSong, go to .7
	lda.w #$0001
	jsl.l PlayTeamSong
	bra .7
.4:									; if percue is not 0 go to .5, if OptPlayMode = $0004 go to .7, ...
	ldy.w percue
	bne .5
	lda.w OptPlayMode
	cmp.w #$0004
	beq .7
	jsl.l RandomWord
	and.w #$0003
	bne .7
.5:									; A = $0000, if percue is not 0 go to .6, A = $0002
	lda.w #$0000
	ldy.w percue
	bne .6
	lda.w #$0002
.6:									; call PlayTeamSong, percue = 0
	jsl.l PlayTeamSong
	stz.w percue
.7:									; A = $000D, A = $0001, iflags = 0, replaydelay = 0, ...
	lda.w #$000D
	trb.w sflags
	lda.w #$0001
	trb.w sflags3
	stz.w iflags
	stz.w replaydelay
	lda.w #$FFFF
	sta.w RefCnt
	sta.w puckcross+2
	sta.w puckcross+6
	sta.w puckz
	sta.w passReceiverPlayerNum
	asl a
	sta.w puckc
	lda.w #$8200
	trb.w sflags
	stz.w refwindow
	stz.w $234A
	lda.w #$0500
	tsb.w sflags
	jsl.l ClrHor
	lda.w #$0008
	tsb.w tmflags
	tsb.w tmflags+2
	jsl.l CloseLCBoxes
	lda.w #$0008
	trb.w tmflags
	trb.w tmflags+2
	stz.b Vpos
	stz.b Hpos
	lda.w fox
	sta.w puckx
	lda.w foy
	sta.w pucky
	stz.w puckvx
	stz.w puckvy
	stz.w puckvz
	stz.w $09B8
	stz.w $09D8
	stz.w $082C
	lda.w #$0117
	sta.w $08AE
	stz.w $09BA
	stz.w $09DA
	stz.w $082E
	lda.w #$FEE8
	sta.w $08B0
	lda.w #$01B3
	sta.w frame+$1E
	stz.w $0C9E
	stz.w attribute+$1E
	stz.w $08FC
	lda.w #$0040
	trb.w sflags
	lda.w #$0064
	sta.b d4
.loop:								; loop: call checkwindow, d4 - 1, if the result >= 0 go to .loop, ...
	jsl.l checkwindow
	dec.b d4
	bpl .loop
	lda.w #$003C
	sta.w yleader
	lda.w OptPlayMode
	cmp.w #$0001
	bne .8
	lda.w homepracplayers
	inc a
	sta.w tmap
	lda.w awaypracplayers
	inc a
	sta.w $12C9
.8:									; call ResetBench, a2 = 0, call setpersonel, call forcepldata, ...
	jsl.l ResetBench
	stz.b a2
	jsl.l setpersonel
	jsl.l forcepldata
	inc.b a2
	inc.b a2
	jsl.l setpersonel
	jsl.l forcepldata
	jsl.l resetplstuff
	lda.w #$FFFF
	sta.w tmtouch2
	sta.w tmtouch3
	sta.w $12C1
	sta.w $12C5
	pei ($71)
	pei ($6F)
	stz.b a3
	lda.w #$000B
	sta.b d2
	pha
.9:									; if a3 >= $0018 go to .10, A = pfteam,x, A / 2, A xor gmode, ...
	ldx.b a3
	cpx.w #$0018
	bcs .10
	lda.w pfteam,x
	lsr a
	eor.w gmode
	and.w #$0002
	lsr a
	eor.w #$0001
	sta.w pfgoal,x
.10:								; A = pnum,x, A * 2, if X < $000C go to .11, A + $0034
	lda.w pnum,x
	asl a
	cpx.w #$000C
	bcc .11
	clc
	adc.w #$0034
.11:								; X = A, if tmpdst,x < 0 go to .12, if a $1000 bit set go to .12, ...
	tax
	lda.w tmpdst,x
	bmi .12
	bit.w #$1000
	bne .12
	jmp.w .30
.12:								; X = a3, Xpos,x = $FF10, Ypos,x = 0, frame,x = $0001, ...
	ldx.b a3
	lda.w #$FF10
	sta.w Xpos,x
	stz.w Ypos,x
	lda.w #$0001
	sta.w frame,x
	lda.w position,x
	sta.b d1
	bpl .13
	jmp.w .30
.13:								; if zero go to .18, if penshot = 0 go to .15, push X, X = $0008, ...
	beq .18
	lda.w penshot
	beq .15
	phx
	ldx.w #$0008
	lda.w BA_Team
	beq .14
	ldx.w #$0014
.14:								; pnum,x = BA_Skater_Offset, d3 = A, pull X
	lda.w BA_Skater_Offset
	sta.w pnum,x
	sta.b d3
	plx
.15:								; d0 = $0016, if d1 is not $0004 go to .17, a2 = 0, ...
	lda.w #$0016
	sta.b d0
	lda.b d1
	cmp.w #$0004
	bne .17
	stz.b a2
	lda.w pfteam,x
	beq .16
	inc.b a2
	inc.b a2
.16:								; Y = a2, A = pnum,x, A and $00FF, tmtouch1,y = A, ...
	ldy.b a2
	lda.w pnum,x
	and.w #$00FF
	sta.w tmtouch1,y
	lda.w #$0004
	sta.w tmflags,y
	lda.w #$0017
	sta.b d0
.17:								; call assinsert
	jsl.l assinsert
.18:								; d4 = tmap, X = a3, if pfteam,x = 0 go to .19, d4 = $12C9
	lda.w tmap
	sta.b d4
	ldx.b a3
	lda.w pfteam,x
	beq .19
	lda.w $12C9
	sta.b d4
.19:								; A = d4, A xor $FFFF, A + 1, A + $0006, ...
	lda.b d4
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0006
	asl a
	asl a
	asl a
	sta.b d4
	lda.w OptPlayMode
	cmp.w #$0001
	bne .20
	stz.b d4
.20:								; $69 = $00C5, A = $195D, A + d4, a1 = A, ...
	lda.w #$00C5
	sta.b $69
	lda.w #$195D
	clc
	adc.b d4
	sta.b a1
	lda.w penshot
	beq .21
	lda.w #$00C5
	sta.b $69
	lda.w #$1975
	sta.b a1
.21:								; Y = d1, A = [a1],y, A and $00FF, A * 2, ...
	ldy.b d1
	lda.b [a1],y
	and.w #$00FF
	asl a
	asl a
	sta.b d4
	lda.w #$00C5
	sta.b $69
	lda.w #$197D
	sta.b a1
	ldy.b d4
	lda.b [a1],y
	sta.b d0
	iny
	iny
	lda.b [a1],y
	sta.b d1
	lda.w pfgoal,x
	bne .22
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
.22:								; if position,x = 0 go to .27, if d4 - $0009 >= 0 go to .26, A = fox, ...
	lda.w position,x
	beq .27
	lda.b d4
	cmp.w #$0009
	bpl .26
	lda.w fox
	eor.b d0
	bpl .24
	lda.w foy
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq .23
	ora.w #$E000
.23:								; A xor $FFFF, A + 1, A + d1, d1 = A
	eor.w #$FFFF
	inc a
	clc
	adc.b d1
	sta.b d1
.24:								; A = fox, A / 2, A / 2, if $2000 bits clear go to .25, ...
	lda.w fox
	lsr a
	lsr a
	bit.w #$2000
	beq .25
	ora.w #$C000
.25:								; d3 = A, A = d0, A - d3, d0 = A
	sta.b d3
	lda.b d0
	sec
	sbc.b d3
	sta.b d0
.26:								; A = d0, A + fox, d0 = A, A = d1, ...
	lda.b d0
	clc
	adc.w fox
	sta.b d0
	lda.b d1
	clc
	adc.w foy
	sta.b d1
.27:								; Xpos,x = d0, A - puckx, A xor $FFFF, A + 1, ...
	lda.b d0
	sta.w Xpos,x
	sec
	sbc.w puckx
	eor.w #$FFFF
	inc a
	sta.b d0
	lda.b d1
	sta.w Ypos,x
	sec
	sbc.w pucky
	eor.w #$FFFF
	inc a
	sta.b d1
	stz.w Xvel,x
	stz.w Yvel,x
	jsl.l vtoa
	lda.b d0
	sta.w facedir,x
	lda.w pflags,x
	and.w #$EFFF
	sta.w pflags,x
	stz.w pfalock,x
	stz.w SPA,x
	lda.w position,x
	bne .28
	lda.w #$121E
	bra .29
.28:								; A = $1958
	lda.w #$1958
.29:								; call SetSPAFromA, call updateanim
	jsl.l SetSPAFromA
	jsl.l updateanim
.30:								; a3 + 1, a3 + 1, pull A, A - 1, ...
	inc.b a3
	inc.b a3
	pla
	dec a
	sta.b d2
	bmi .31
	pha
	jmp.w .9
.31:								; call SprSort, pull A, a3 = A, pull A, ...
	jsl.l SprSort
	pla
	sta.b a3
	pla
	sta.b $71
	lda.w penshot
	beq .35
	ldx.w #$0008
.loop2:								; loop: if padside,x is not BA_Team go to .32, if X = pspad go to .32, ...
	lda.w padside,x
	cmp.w BA_Team
	bne .32
	cpx.w pspad
	beq .32
	ora.w #$8000
	sta.w padside,x
	stz.w cont1team,x
.32:								; X - 1, X - 1, if the result >= 0 go to .loop2, A = BA_Team, ...
	dex
	dex
	bpl .loop2
	lda.w BA_Team
	eor.w #$0002
	sta.b d0
	tax
	lda.w teampads,x
	beq .35
	ldy.w puckpadnext,x
.loop3:								; loop: Y + 1, Y + 1, if Y is not $000A go to .33, Y = $0000
	iny
	iny
	cpy.w #$000A
	bne .33
	ldy.w #$0000
.33:								; if padside,y is not d0 go to .loop3, d1 = Y, A = Y, ...
	lda.w padside,y
	cmp.b d0
	bne .loop3
	sty.b d1
	tya
	sta.w puckpadnext,x
	ldx.w #$0008
.loop4:								; loop: if padside,x is not d0 go to .34, if X = d1 go to .34, ...
	lda.w padside,x
	cmp.b d0
	bne .34
	cpx.b d1
	beq .34
	ora.w #$8000
	sta.w padside,x
	stz.w cont1team,x
.34:								; X - 1, X - 1, if the result >= 0 go to .loop4
	dex
	dex
	bpl .loop4
.35:								; X = a3, call FaceoffPads, push X, push Y, ...
	ldx.b a3
	jsl.l FaceoffPads
	phx
	phy
	jsl.l ClearTextMapTop
	inc.w TransfersReady
	ldy.w #$0036
	lda.w fox
	bpl .36
	ldy.w #$00BE
.36:								; d0 = Y, A = Y, fodropx = A, A - $002E, ...
	sty.b d0
	tya
	sta.w fodropx
	sec
	sbc.w #$002E
	lsr a
	lsr a
	lsr a
	clc
	adc.w #$5860
	sta.w $2026
	lda.w #$005C
	sta.w fodropy
	jsl.l SeatPenaltyBox
	lda.w penshot
	beq .37
	jmp.w DrawPenaltyShotMatchup
.37:								; if OptPlayMode is not $0001 go to .38, go to CODE_C43FC1
	lda.w OptPlayMode
	cmp.w #$0001
	bne .38
	jmp.w CODE_C43FC1
.38:								; fobox = $0001, call WaitTransfers, call RestoreWorkBuf, A = $0A00, ...
	lda.w #$0001
	sta.w fobox
	jsl.l WaitTransfers
	jsl.l RestoreWorkBuf
	lda.w #$0A00
	jsl.l AllocWorkBuf
	sta.w $2024
	sta.b r1
	jsl.l MarkWorkBuf
	lda.w #$007E
	sta.b $32
	lda.w #FaceOffMap&$FFFF
	ldx.w #FaceOffMap>>16
	jsl.l MapSetToWRAM
	lda.w $2024
	tax
	ldy.w #$04FF
	clc
.loop5:								; loop: A = $7E0000,x, A + $3E32, $7E0000,x = A, X + 1, ...
	lda.l $7E0000,x
	adc.w #$3E32
	sta.l $7E0000,x
	inx
	inx
	dey
	bpl .loop5
	lda.w #$0000
	sta.w $2014
	jsl.l QueueFaceoffBox
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $09C0
	pea.w $4320
	pea.w $007E
	clc
	lda.w $2024
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
	lda.w fodropy
	clc
	adc.w #$0005
	sta.b $1A
	lda.w fodropx
	sec
	sbc.w #$002B
	sta.b $18
	lda.w #$001E
	jsl.l CreateSpriteSharePal
	stx.w $2020
	clc
	lda.b $18
	adc.w #$0059
	sta.b $18
	lda.w gsp
	lsr a
	lda.w HomeSpritePal
	bcc .39
	lda.w VisSpritePal
.39:								; call UseSpritePalette, A = $001E, call CreateSpriteSharePal, ...
	jsl.l UseSpritePalette
	lda.w #$001E
	jsl.l CreateSpriteSharePal
	stx.w $2022
	lda.b $36,x
	eor.w #$4000
	sta.b $36,x
	inc.b $38,x
	lda.w #$0001
	jsl.l SetSpriteAnim
	lda.w gsp
	lsr a
	lda.w VisSpritePal
	bcc .40
	lda.w HomeSpritePal
.40:								; call UseSpritePalette, call CODE_C53A29
	jsl.l UseSpritePalette
	jsl.l CODE_C53A29
FinishFaceoffSetup:					; end of the face off set-up: the line box (line changes on, no penalty
									; shot), the drop time in temp1, the centres' and the ref's frames
									; (fofdata2, fofdata), fodir1 / fodir2 cleared, the registers restored
	ply
	plx
	ldx.b a3
	lda.w OptLine
	beq .1
	lda.w penshot
	ora.w penshotlive
	beq .2
.1:									; go to .5
	jmp.w .5
.2:									; A = $59A1, if fox >= 0 go to .3, A = $59B2
	lda.w #$59A1
	ldx.w fox
	bpl .3
	lda.w #$59B2
.3:									; push A, X = $000C, Y = $0002, call Framer, ...
	pha
	ldx.w #$000C
	ldy.w #$0002
	jsl.l Framer
	ldx.w tmline
	ldy.w $12B9
	lda.w gmode
	bit.w #$0002
	beq .4
	txy
	ldx.w $12B9
.4:									; d0 = X, d1 = Y, A = $000B, call AllocWorkBuf, ...
	stx.b d0
	sty.b d1
	lda.w #$000B
	jsl.l AllocWorkBuf
	tay
	jsl.l MarkWorkBuf
	lda.w #$000A
	sta.w $0000,y
	lda.b d0
	asl a
	adc.b d0
	tax
	lda.l DATA8_C09B3F,x
	sta.w $0001,y
	lda.l DATA8_C09B3F+1,x
	sta.w $0002,y
	lda.w #$A0A0
	sta.w $0004,y
	lda.w #$A0A0
	sta.w $0006,y
	lda.b d1
	asl a
	adc.b d1
	tax
	lda.l DATA8_C09B3F,x
	sta.w $0008,y
	lda.l DATA8_C09B3F+1,x
	sta.w $0009,y
	pla
	clc
	adc.w #$0021
	tax
	tya
	txy
	ldx.w #$007E
	jsl.l QueueVRAMDMALen
.5:									; call RandomWord, A and $007F, A + $00B4, d0 = A, ...
	jsl.l RandomWord
	and.w #$007F
	adc.w #$00B4
	sta.b d0
	ldx.b a3
	sta.w temp1,x
	lda.w OptPlayMode
	cmp.w #$0001
	bne .6
	lda.w #$003C
	sta.w temp1,x
.6:									; if penshot = 0 go to .7, temp1,x = $00B4
	lda.w penshot
	beq .7
	lda.w #$00B4
	sta.w temp1,x
.7:									; fofdata2 = $0001, fofdata2+2 = $8000, fofdata+2 = A, ...
	lda.w #$0001
	sta.w fofdata2
	lda.w #$8000
	sta.w fofdata2+2
	sta.w fofdata+2
	lda.w #$0004
	sta.w fofdata2+4
	lda.w #$A800
	sta.w fofdata2+6
	lda.w #$0007
	sta.w fofdata
	lda.w gmode
	bit.w #$0002
	bne .8
	lda.w #$8800
	sta.w fofdata2+2
	lda.w #$A000
	sta.w fofdata2+6
.8:									; fodir1 = $FFFF, fodir2 = A, pull A, $7D = A, ...
	lda.w #$FFFF
	sta.w fodir1
	sta.w fodir2
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
	ldx.b a3
	rtl
TickFaceoffCountdown:				; counts the face off time (temp1) down by d7: updatefaceoff while it
									; runs, else Endfaceoff, then play mode 1's path, SetupPenaltyShot or the
									; normal drop
	lda.b d7
	sta.b tmp0
	cmp.w temp1,x
	bmi .1
	lda.w #$0001
	sta.b tmp0
.1:									; A = temp1,x, A - tmp0, temp1,x = A, if minus go to .2, ...
	lda.w temp1,x
	sec
	sbc.b tmp0
	sta.w temp1,x
	bmi .2
	jml.l updatefaceoff
.2:									; if OptPlayMode is not $0001 go to .3, call Endfaceoff, ...
	lda.w OptPlayMode
	cmp.w #$0001
	bne .3
	jsl.l Endfaceoff
	jml.l PracticeFaceoffDrop
.3:									; if penshot = 0 go to .4, call Endfaceoff, go to SetupPenaltyShot
	lda.w penshot
	beq .4
	jsl.l Endfaceoff
	jml.l SetupPenaltyShot
.4:									; PenShotActive = 0, BA_Sktr_SCnum = $FFFF, go to Endfaceoff
	stz.w PenShotActive
	lda.w #$FFFF
	sta.w BA_Sktr_SCnum
	jml.l Endfaceoff
DrawPenaltyShotMatchup:				; draws the penalty shot box: the shooter's and the other team's goalie's
									; names centred, the text and the 30 second time, then FinishFaceoffSetup
	jsl.l WaitTransfers
	ldx.w #$0014
	ldy.w #$0008
	lda.w #$5846
	jsl.l Framer
	ldx.w #$2DC9
	ldy.w BA_Team
	beq .1
	ldx.w #$3207
.1:									; A = BA_Skater_Offset, call FormatRosterShortName, call CentreNameX, ...
	lda.w BA_Skater_Offset
	jsl.l FormatRosterShortName
	jsr.w CentreNameX
	adc.w #$58A6
	tay
	lda.b r0
	jsl.l QueueVRAMDMALen
	ldy.w #$58EF
	ldx.w #$00C3
	lda.w #$5F13
	jsl.l QueueVRAMDMALen
	ldx.w #$3207
	ldy.w BA_Team
	beq .2
	ldx.w #$2DC9
.2:									; A = Y, A xor $0002, Y = A, A = tmgoalie,y, ...
	tya
	eor.w #$0002
	tay
	lda.w tmgoalie,y
	jsl.l FormatRosterShortName
	jsr.w CentreNameX
	adc.w #$5926
	tay
	lda.b r0
	jsl.l QueueVRAMDMALen
	ldy.w #$5867
	lda.w #$5F40
	ldx.w #$00C3
	jsl.l QueueVRAMDMALen
	ldx.w #$000A
	ldy.w #$0003
	lda.w #$5AE0
	jsl.l Framer
	lda.w #$5F4A
	ldx.w #$00C3
	ldy.w #$5B01
	jsl.l QueueVRAMDMALen
	lda.w #$001E
	sta.b d0
	jsl.l PushTime
	ldx.w #$007E
	lda.b a1
	ldy.w #$5B23
	jsl.l QueueVRAMDMALen
	jmp.w FinishFaceoffSetup
CentreNameX:						; r0 = the string pointer, A = (20 - its length) / 2 with carry clear: the
									; column that centres it in the 20-wide box
	sta.b r0
	stx.b $2E
	lda.b [r0]
	and.w #$00FF
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0014
	lsr a
	clc
	rts
CODE_C43FC1:						; from puckfaceoff2
	jsl.l CODE_C53A29
	jmp.w FinishFaceoffSetup

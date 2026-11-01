; Segment bankC4_A000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C49FBD
chk4pass:							; called from other segments
	lda.w $07EE
	bne .1
	lda.w #$0010
	clc
	adc.w spodds,x
	jsl.l randoma8
	cmp.w #$0009
	bcs .rtl
.1:									; A = $0006, call randoma8, d0 = A, if X < $000C go to .2, ...
	lda.w #$0006
	jsl.l randoma8
	sta.b d0
	cpx.w #$000C
	bcc .2
	clc
	adc.w #$0006
	sta.b d0
.2:									; if position,x = 0 go to .3, if $0830 - $FFD7 < 0 go to .3, ...
	lda.w position,x
	beq .3
	lda.w $0830
	cmp.w #$FFD7
	bmi .3
	cmp.w #$0029
	bpl .3
	lda.w pucky
	cmp.w #$FF2D
	bmi .rtl
	cmp.w #$00D3
	bpl .rtl
.3:									; d0 * 2, if X is not d0 go to .4
	asl.b d0
	cpx.b d0
	bne .4
.rtl:								; return
	rtl
.4:									; a0 = d0, if position,y = 0 go to .rtl, if minus go to .rtl, ...
	ldy.b d0
	sty.b a0
	lda.w position,y
	beq .rtl
	bmi .rtl
	lda.w pflags,y
	and.w #$1000
	ora.w pfalock,y
	bne .rtl
	lda.w Ypos,y
	sta.b d0
	lda.w Ypos,x
	sta.b d1
	lda.w pfgoal,x
	bne .5
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
.5:									; A = gmode, if $0020 bits clear go to .6, A = d0, A - $005C, ...
	lda.w gmode
	bit.w #$0020
	beq .6
	lda.b d0
	sec
	sbc.w #$005C
	sta.b tmp0
	lda.b d1
	sec
	sbc.w #$005C
	eor.b tmp0
	bmi .rtl
.6:									; if d0 - $005C >= 0 go to .7, A = d0, A - d1, d0 = A, ...
	lda.b d0
	cmp.w #$005C
	bpl .7
	lda.b d0
	sec
	sbc.b d1
	sta.b d0
	cmp.w #$FFF1
	bmi .rtl2
.7:									; A = puckdir,y, A - $0004, A and $0007, passdir = A, ...
	lda.w puckdir,y
	sec
	sbc.w #$0004
	and.w #$0007
	sta.w passdir
	lda.w $05E4,y
	sta.b d2
	lda.w #$0005
	sta.b d3
	ldy.w #$0000
	stz.b a1
	cpx.w #$000C
	bcs .loop
	ldy.w #$000C
.loop:								; loop: if d2 < $05E4,y go to .8, A = puckdir,y, A - $0004, ...
	lda.b d2
	cmp.w $05E4,y
	bcc .8
	lda.w puckdir,y
	sec
	sbc.w #$0004
	and.w #$0007
	cmp.w passdir
	beq .rtl2
.8:									; Y + 1, Y + 1, d3 - 1, if the result >= 0 go to .loop, ...
	iny
	iny
	dec.b d3
	bpl .loop
	jsl.l dopass
	lda.w position,x
	beq .rtl2
	pla
	sep #$20
	pla
	rep #$30
	jmp.w assexit
.rtl2:								; return
	rtl
CODE_C4A0C1:						; called from other segments
	lda.b d2
	bit.w #$8000
	bne dopass
	lda.b d0
	bit.w #$0008
	bne .rtl
	and.w #$0007
	sta.w passdir
	ora.w #$0008
	sta.b d0
	bra dopass
.rtl:								; return
	rtl
dopass:								; from CODE_C4A0C1, chk4pass and other segments
	stz.w onetimerreq
	lda.w #$0004
	trb.w sflags
	lda.w #$FFFF
	sta.w puckc
	lda.w #$0010
	sta.w nopuck,x
	txa
	lsr a
	sta.w lastplayer
	lda.w #$0007
	sta.b d0
	lda.w position,x
	beq .1
	lda.w passacc,x
	sta.b d0
.1:									; A = d0, A * 2, A * 2, A + $00C8, ...
	lda.b d0
	asl a
	asl a
	adc.w #$00C8
	cmp.w #$0100
	bcc .2
	lda.w #$00FF
.2:									; passspeed = A, d4 = $FFFF, d3 = $0005, a1 = 0, ...
	sta.w passspeed
	lda.w #$FFFF
	sta.b d4
	lda.w #$0005
	sta.b d3
	stz.b a1
	cpx.w #$000C
	bcc .loop
	lda.w #$000C
	sta.b a1
.loop:								; loop: if X = a1 go to .5, Y = a1, if position,y < 0 go to .5, ...
	cpx.b a1
	beq .5
	ldy.b a1
	lda.w position,y
	bmi .5
	beq .5
	lda.w pflags,y
	bit.w #$1000
	bne .5
	lda.w puckdir,y
	sec
	sbc.w passdir
	sec
	sbc.w #$0004
	stz.b r0
	and.w #$0007
	beq .4
	cmp.w #$0001
	beq .3
	cmp.w #$0007
	bne .5
.3:									; r0 = $1000
	lda.w #$1000
	sta.b r0
.4:									; A = r0, A + $05E4,y, if carry set go to .5, if A >= d4 go to .5, ...
	lda.b r0
	clc
	adc.w $05E4,y
	bcs .5
	cmp.b d4
	bcs .5
	sta.b d4
	lda.b a1
	sta.b a0
.5:									; a1 + 1, a1 + 1, d3 - 1, if the result < 0 go to .6, ...
	inc.b a1
	inc.b a1
	dec.b d3
	bmi .6
	jmp.w .loop
.6:									; X = a3, if d4 < 0 go to .7, call dopass_count, A = $000B, ...
	ldx.b a3
	lda.b d4
	bmi .7
	jsl.l dopass_count
	lda.w #$000B
	jsl.l StartSound
	jmp.w dopass_swing
.7:									; A = passdir, A * 2, A * 2, A + $9C06, ...
	lda.w passdir
	asl a
	asl a
	adc.w #$9C06
	sta.b a0
	lda.w #$00C0
	sta.b $65
	lda.b [a0]
	cmp.w #$8000
	ror a
	tax
	lda.w #$0050
	jsl.l Mul8XS
	asl a
	sta.b r3
	ldx.b curobj
	lda.w Yvel,x
	cmp.w #$8000
	ror a
	clc
	adc.b r3
	sta.w puckvy
	dec.b a0
	dec.b a0
	lda.b [a0]
	cmp.w #$8000
	ror a
	tax
	lda.w #$0050
	jsl.l Mul8XS
	asl a
	sta.b r3
	ldx.b curobj
	lda.w Xvel,x
	cmp.w #$8000
	ror a
	clc
	adc.b r3
	sta.w puckvx
	jsl.l RandomWord
	and.w #$0FFF
	sta.w puckvz
dopass_swing:						; from dopass, CODE_C4A52A
	lda.w position,x
	bne .3
	lda.w pfgoal,x
	beq .1
	lda.w puckvy
	bmi .2
	bra .3
.1:									; if puckvy < 0 go to .3
	lda.w puckvy
	bmi .3
.2:									; A xor $FFFF, A + 1, puckvy = A
	eor.w #$FFFF
	inc a
	sta.w puckvy
.3:									; d0 = puckvx, d1 = puckvy, call vtoa, Y = $144E, ...
	lda.w puckvx
	sta.b d0
	lda.w puckvy
	sta.b d1
	jsl.l vtoa
	ldy.w #$144E
	lda.w position,x
	beq .4
	ldy.w #$1B40
	jsl.l Findhittype
	beq .4
	ldy.w #$1BB2
.4:									; d1 = Y, call SetSPA, pfalock,x = $0001, ...
	sty.b d1
	jsl.l SetSPA
	lda.w #$0001
	sta.w pfalock,x
	lda.w position,x
	bne .rtl
	lda.w playerpad,x
	bmi .rtl
	stz.w Xvel,x
	stz.w Yvel,x
	sta.b d4
	jsl.l findpc
.rtl:								; return
	rtl
dopass_count:						; from dopass and other segments
	jsl.l loadTeamStruct
	lda.w gmclock
	bne .1
	ldy.b a2
	lda.w $12DF,y
	inc a
	sta.w $12DF,y
.1:									; X = $0664,y, A = aidef,x, A / 2, A + $0001, ...
	ldx.w $0664,y
	lda.w aidef,x
	lsr a
	clc
	adc.w #$0001
	adc.w temp1,x
	sta.w temp1,x
	lda.b a0
	sta.w passReceiverPlayerNum
	ldx.b a0
	lda.w #$0015
	sta.b d0
	jsl.l CODE_C43734
	ldx.b a3
	ldy.b a0
	lda.w frame,y
	pha
	lda.w attribute,y
	bit.w #$0800
	beq .2
	lda.w #$0000
	sec
	sbc.w facedir,y
	bra .3
.2:									; A = facedir,y
	lda.w facedir,y
.3:									; A and $0007, A * 2, X = A, A = DATA8_C41E48,x, ...
	and.w #$0007
	asl a
	tax
	lda.l DATA8_C41E48,x
	tax
	lda.l $C40000,x
	ldx.b a3
	ldy.b a0
	sta.w frame,y
	lda.b a0
	jsl.l CODE_C37FE2
	ldy.b a0
	pla
	sta.w frame,y
	lda.b d1
	clc
	adc.w Ypos,y
	sec
	sbc.w pucky
	sta.b d1
	lda.b d0
	clc
	adc.w Xpos,y
	sec
	sbc.w $0830
	sta.b d0
	lda.w #$0018
	sta.b d6
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldy.b a0
	ldx.w Xvel,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b d0
	sta.b d2
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldx.w Yvel,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b d1
	sta.b d3
	ldy.b d2
	jsl.l ApproxLength
	sta.b d4
	asl a
	tax
	lda.w #$0003
	jsl.l DivX8U
	cmp.w #$0040
	bcc .4
	cmp.w #$0050
	bcc .6
	ldx.b d4
	lda.w #$0005
	jsl.l DivX8U
	sta.b d6
	lda.w #$0050
	bra .5
.4:									; A = d4, A / 2, A / 2, d6 = A, ...
	lda.b d4
	lsr a
	lsr a
	sta.b d6
	lda.w #$0040
.5:									; push A, A = d6, A * 2, A * 2, ...
	pha
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldy.b a0
	ldx.w Xvel,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b d0
	sta.b d2
	lda.b d6
	asl a
	asl a
	asl a
	asl a
	ldx.w Yvel,y
	jsl.l Mul16XS
	lda.b $36
	clc
	adc.b d1
	sta.b d3
	ldy.b d2
	jsl.l ApproxLength
	sta.b d4
	pla
.6:									; d5 = A, passspeed = A, X = curobj, A = $0010, ...
	sta.b d5
	sta.w passspeed
	ldx.b curobj
	lda.w #$0010
	sec
	sbc.w passacc,x
	jsl.l randomd0s
	clc
	adc.b d5
	sta.b d5
	ldx.b d2
	jsl.l Mul16x8XS
	lda.b d4
	sta.b r1
	jsl.l Div32S
	lda.b r0
	xba
	and.w #$FF00
	sta.w puckvx
	lda.b d5
	ldx.b d3
	jsl.l Mul16x8XS
	lda.b d4
	sta.b r1
	jsl.l Div32S
	lda.b r0
	xba
	and.w #$FF00
	sta.w puckvy
	lda.b d2
	clc
	adc.w $0830
	sta.w $066E
	lda.b d3
	clc
	adc.w pucky
	sta.w passtargety
	lda.b d4
	asl a
	asl a
	asl a
	sta.w puckvz
	lda.w #$000A
	sta.w $0CFC
	ldy.b a0
	lda.b d6
	clc
	adc.w #$0006
	sta.w $0676,y
	ldx.b curobj
	lda.b d6
	sta.w nopuck,x
	ldy.b a2
	lda.w playerpad,x
	sta.w $05C8,y
	lda.w position,x
	bne .rtl
	lda.w playerpad,x
	bmi .rtl
	stz.w Xvel,x
	stz.w Yvel,x
	lda.w playerpad,x
	sta.b d4
	lda.w passReceiverPlayerNum
	sta.b d0
	jsl.l CODE_C5376A
	lda.w playerpad,x
	bmi .rtl
	jsl.l findpc
.rtl:								; return
	rtl
DumpInTarget:						; from assdumpin and other segments
	stx.w $066A
	lda.w position,x
	beq .6
	lda.w pfgoal,x
	bne .3
	lda.w Ypos,x
	cmp.w #$FFA4
	bmi .2
	lda.w #$0004
	sta.w passdir
	lda.w Xpos,x
	bmi .1
	lda.w #$000A
	sta.w dumpintarget
	rtl
.1:									; dumpintarget = $0006, return
	lda.w #$0006
	sta.w dumpintarget
	rtl
.2:									; A = $063E, A - $0004, A and $0007, passdir = A, ...
	lda.w $063E
	sec
	sbc.w #$0004
	and.w #$0007
	sta.w passdir
	lda.w #$0008
	sta.w dumpintarget
	rtl
.3:									; if Ypos,x - $005C >= 0 go to .5, passdir = $0000, ...
	lda.w Ypos,x
	cmp.w #$005C
	bpl .5
	lda.w #$0000
	sta.w passdir
	lda.w Xpos,x
	bmi .4
	lda.w #$0016
	sta.w dumpintarget
	rtl
.4:									; dumpintarget = $0012, return
	lda.w #$0012
	sta.w dumpintarget
	rtl
.5:									; A = $063C, A - $0004, A and $0007, passdir = A, ...
	lda.w $063C
	sec
	sbc.w #$0004
	and.w #$0007
	sta.w passdir
	lda.w #$0014
	sta.w dumpintarget
	rtl
.6:									; dumpintarget = 0, passdir = 0, if pfgoal,x is not 0 go to .rtl, ...
	stz.w dumpintarget
	stz.w passdir
	lda.w pfgoal,x
	bne .rtl
	lda.w #$000C
	sta.w dumpintarget
	lda.w #$0004
	sta.w passdir
.rtl:								; return
	rtl
CODE_C4A4AB:						; called from other segments
	lda.w #$0014
	sta.b d0
	jmp.w assreplace
assdumpin:							; called from other segments
	cpx.w puckc
	bne .2
	lda.w pflags,x
	bit.w #$0002
	beq .3
	jsl.l DumpInTarget
	lda.w pflags,x
	and.w #$FFFD
	sta.w pflags,x
	lda.w playerpad,x
	bpl .3
	lda.w dumpintarget
	cmp.w #$0014
	beq .1
	cmp.w #$0008
	beq .1
	rtl
.1:									; go to CompShoot
	jmp.w CompShoot
.2:									; go to assexit
	jmp.w assexit
.3:									; Y = $0000, if passdir = facedir,x go to .4, Y + 1, A - 1, ...
	ldy.w #$0000
	lda.w passdir
	cmp.w facedir,x
	beq .4
	iny
	dec a
	and.w #$0007
	cmp.w facedir,x
	beq .4
	iny
	inc a
	inc a
	and.w #$0007
	cmp.w facedir,x
	beq .4
	lda.w passdir
	sta.b d0
	jsl.l AdjustFacingDirection
	rtl
.4:									; if position,x is not 0 go to .5, A = Y, A * 2, A + dumpintarget, ...
	lda.w position,x
	bne .5
	tya
	asl a
	adc.w dumpintarget
	sta.w dumpintarget
	lda.w facedir,x
	sta.w passdir
.5:									; call CODE_C4A52A, go to assexit
	jsl.l CODE_C4A52A
	jmp.w assexit
CODE_C4A52A:						; from assdumpin and other segments
	txy
	lda.w #$000F
	sec
	sbc.w passacc,y
	asl a
	sta.b d4
	ldx.w dumpintarget
	lda.l DATA8_C4A5FD,x
	clc
	adc.b d4
	jsl.l randomd0s
	clc
	adc.l DATA8_C4A62D,x
	sec
	sbc.w $0830
	sta.b d0
	lda.l DATA8_C4A615,x
	clc
	adc.b d4
	jsl.l randomd0s
	clc
	adc.l DATA8_C4A645,x
	sec
	sbc.w pucky
	sta.b d1
	ldy.b d0
	jsl.l ApproxLength
	sta.b d2
	asl a
	asl a
	asl a
	asl a
	tax
	lda.w #$0078
	jsl.l DivX8U
	cmp.w #$0061
	bcc .1
	lda.w #$0060
.1:									; X = curobj, if position,x = 0 go to .3, if A >= $0010 go to .2, ...
	ldx.b curobj
	ldy.w position,x
	beq .3
	cmp.w #$0010
	bcs .2
	lda.w #$0010
.2:									; go to .4
	bra .4
.3:									; if A >= $0020 go to .4, A = $0020
	cmp.w #$0020
	bcs .4
	lda.w #$0020
.4:									; d3 = A, X = d0, call Mul16x8XS, r1 = d2, ...
	sta.b d3
	ldx.b d0
	jsl.l Mul16x8XS
	lda.b d2
	sta.b r1
	jsl.l Div32S
	lda.b r0
	xba
	and.w #$FF00
	sta.w puckvx
	lda.b d3
	ldx.b d1
	jsl.l Mul16x8XS
	lda.b d2
	sta.b r1
	jsl.l Div32S
	lda.b r0
	xba
	and.w #$FF00
	sta.w puckvy
	asl a
	asl a
	asl a
	asl a
	lda.w #$03C0
	sec
	sbc.b d4
	jsl.l randomd0A
	clc
	adc.w #$10E0
	sta.w puckvz
	jsl.l puckflip
	ldx.b curobj
	lda.w #$FFFF
	sta.w $066A
	sta.w puckc
	lda.w #$001E
	sta.w nopuck,x
	txa
	lsr a
	sta.w lastplayer
	jmp.w dopass_swing
DATA8_C4A5FD:						; not traced: a table read by CODE_C4A52A
	db $19,$00,$19,$00,$19,$00,$19,$00,$14,$00,$19,$00,$19,$00,$19,$00
	db $19,$00,$19,$00,$14,$00,$19,$00
DATA8_C4A615:						; not traced: a table read by CODE_C4A52A
	db $14,$00,$19,$00,$19,$00,$46,$00,$14,$00,$46,$00,$14,$00,$19,$00
	db $19,$00,$46,$00,$14,$00,$46,$00
DATA8_C4A62D:						; not traced: a table read by CODE_C4A52A
	db $00,$00,$B0,$FF,$50,$00,$B0,$FF,$00,$00,$50,$00,$00,$00,$50,$00
	db $B0,$FF,$B0,$FF,$00,$00,$50,$00
DATA8_C4A645:						; not traced: a table read by CODE_C4A52A
	db $97,$FF,$8D,$FF,$8D,$FF,$4C,$FF,$29,$FF,$4C,$FF,$69,$00,$73,$00
	db $73,$00,$B4,$00,$D7,$00,$B4,$00
CODE_C4A65D:						; called from other segments
	lda.w $0874
	cmp.w $0894
	beq .1
	phx
.loop:								; loop: if TransfersReady is not 0 go to .loop, tmp2 = $2580, ...
	ldx.w TransfersReady
	bne .loop
	ldx.w #$2580
	stx.b tmp2
	ldx.w #$2035
	stx.b tmp1
	sta.w $0894
	jsl.l QueueFrameTiles
	plx
	lda.w $0874
.1:									; if A is not $01B3 go to .2, $0832 = $0830, A = pucky, A + 1, ...
	cmp.w #$01B3
	bne .2
	lda.w $0830
	sta.w $0832
	lda.w pucky
	inc a
	sta.w $08B4
	rtl
.2:									; Y = A, if the result = 0 go to .rtl, $0832 = $0030, A = $0133, ...
	tay
	beq .rtl
	lda.w #$0030
	sta.w $0832
	lda.w #$0133
	bit.w pucky
	bpl .3
	lda.w #$8000
	sta.w $08FE
	lda.w #$FEAF
.3:									; $08B4 = A
	sta.w $08B4
.rtl:								; return
	rtl
puckbody:							; called from other segments
	lda.w puckz
	cmp.w #$0008
	bpl .1
	lda.b d0
	and.w #$000F
	beq .1
	jmp.w puckstick
.1:									; call a2touchpuck, A = puckvx, Y = puckvy, call ApproxLength, ...
	jsl.l a2touchpuck
	lda.w puckvx
	ldy.w puckvy
	jsl.l ApproxLength
	and.w #$7F00
	sta.b tmp0
	xba
	tsb.b tmp0
	ldy.w puckz
	cmp.w #$000E
	bmi .2
	lda.w #$000D
	bra .3
.2:									; A = $0011
	lda.w #$0011
.3:									; call StartSoundVolume, puckvz = 0, Y = a2, nopuck,y = $0008, ...
	jsl.l StartSoundVolume
	stz.w puckvz
	ldy.b a2
	lda.w #$0008
	sta.w nopuck,y
	lda.w Xpos,x
	sec
	sbc.w Xpos,y
	sta.b d0
	lda.w Ypos,x
	sec
	sbc.w Ypos,y
	sta.b d1
	bne .4
	tya
	jsl.l CODE_C37FE2
.4:									; d2 = Xvel,x, d3 = Yvel,x, A 8-bit, $09A1,x = d0, ...
	lda.w Xvel,x
	sta.b d2
	lda.w Yvel,x
	sta.b d3
	sep #$20
	lda.b d0
	sta.w $09A1,x
	lda.b d1
	sta.w $09C1,x
	rep #$30
	jsl.l puckflip
	lda.w puckz
	cmp.w #$0008
	bmi .rtl
	lda.b d2
	tax
	jsl.l Mul16S
	lda.b $36
	sta.b $89
	lda.b r2
	sta.b d2
	lda.b d3
	tax
	jsl.l Mul16S
	ldx.b a3
	lda.b r2
	clc
	adc.b d2
	sta.b d2
	lda.b $36
	adc.b $89
	sta.b $89
	cmp.w #$0900
	bcc .5
	lda.w puckz
	cmp.w #$000C
	bmi .rtl
	jmp.w FallDown
.rtl:								; return
	rtl
.5:									; Y = a2, if pfalock,y is not 0 go to .rtl, A + 1, pf2aip,y = A, ...
	ldy.b a2
	lda.w pfalock,y
	bne .rtl
	inc a
	sta.w pf2aip,y
	lda.w #$26B6
	ldx.b a2
	jsl.l SetSPAFromA
	ldx.b a3
	rtl
puckgoalie:							; called from other segments
	lda.w gmode
	bit.w #$0010
	beq .1
	jmp.w .rtl
.1:									; d2 = 0, if puckz - $0008 >= 0 go to .2, d2 + 1, d2 + 1
	stz.b d2
	lda.w puckz
	cmp.w #$0008
	bpl .2
	inc.b d2
	inc.b d2
.2:									; A = $0000, A - d0, d0 = A, A = $0000, ...
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
	jsl.l vtoa
	ldy.b a2
	lda.b d0
	sec
	sbc.w facedir,y
	and.w #$0007
	sta.b d0
	and.w #$0003
	sta.b d1
	bne .3
	lda.w seed
	sta.b d0
.3:									; A = d0, A and $0004, A / 2, A / 2, ...
	lda.b d0
	and.w #$0004
	lsr a
	lsr a
	eor.w #$0001
	clc
	adc.b d2
	asl a
	sta.b d2
	lda.w $0F60,y
	sta.b d1
	lda.b d2
	beq .4
	lda.w passacc,y
	sta.b d1
	lda.b d2
	cmp.w #$0002
	beq .4
	lda.w spodds,y
	sta.b d1
	lda.b d2
	cmp.w #$0004
	beq .4
	lda.w $0F40,y
	sta.b d1
.4:									; A = d1, A + $000F, d1 = A, A = attribute,y, ...
	lda.b d1
	clc
	adc.w #$000F
	sta.b d1
	lda.w attribute,y
	bit.w #$0800
	beq .5
	lda.b d2
	eor.w #$0002
	sta.b d2
.5:									; A = frame,y, A - $0286, if A >= $0018 go to .6, ...
	lda.w frame,y
	sec
	sbc.w #$0286
	cmp.w #$0018
	bcs .6
	lda.w puckz
	cmp.w #$0005
	bmi .6
	jmp.w .rtl
.6:									; call ChkShotStat, call a2touchpuck, A = puckvy, ...
	jsl.l ChkShotStat
	jsl.l a2touchpuck
	lda.w puckvy
	bit.w #$8000
	beq .7
	eor.w #$FFFF
	inc a
.7:									; A and $7F00, tmp0 = A, A = $0011, call StartSoundVolume, ...
	and.w #$7F00
	sta.b tmp0
	xba
	tsb.b tmp0
	lda.w #$0011
	jsl.l StartSoundVolume
	lda.w puckvy
	cmp.w #$3000
	bpl .8
	cmp.w #$D000
	bpl .11
.8:									; A = CwdExciteLvl, A + $000A, if the result < 0 go to .9, ...
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi .9
	sta.w CwdExciteLvl
.9:									; Y = a2, if pfteam,y = 0 go to .10, A = $000A, call StartSound, ...
	ldy.b a2
	lda.w pfteam,y
	beq .10
	lda.w #$000A
	jsl.l StartSound
	bra .11
.10:								; A = $7E24CA, A + $0258, $7E24CA = A, crowdhold = $003C
	lda.l $7E24CA
	clc
	adc.w #$0258
	sta.l $7E24CA
	lda.w #$003C
	sta.b crowdhold
.11:								; if puckc < 0 go to .12, A / 2
	lda.w puckc
	bmi .12
	lsr a
.12:								; d2 = A, if plus go to .13, go to .21
	sta.b d2
	bpl .13
	jmp.w .21
.13:								; if X is not puckc go to .14, go to .21
	cpx.w puckc
	bne .14
	jmp.w .21
.14:								; A = $FF00, d2 * 2, a0 = d2, Y = A, ...
	lda.w #$FF00
	tsb.w puckc
	asl.b d2
	lda.b d2
	sta.b a0
	tay
	lda.w #$0014
	sta.w nopuck,y
	tya
	lsr a
	sta.w lastplayer
	lda.w #$000C
	trb.w sflags
.15:								; puckvz = 0, Y = a2, nopuck,y = $000A, temp4,y = $0004, ...
	stz.w puckvz
	ldy.b a2
	lda.w #$000A
	sta.w nopuck,y
	lda.w #$0004
	sta.w temp4,y
	lda.w Xpos,x
	sec
	sbc.w Xpos,y
	sta.b d0
	lda.w Ypos,x
	sec
	sbc.w Ypos,y
	sta.b d1
	bne .16
	lda.b a2
	jsl.l CODE_C37FE2
.16:								; A = d1, A and $00FF, if $0080 bits clear go to .17, A or $FF00
	lda.b d1
	and.w #$00FF
	bit.w #$0080
	beq .17
	ora.w #$FF00
.17:								; d1 = A, if d1 = 0 go to .18, d1 + 1
	sta.b d1
	lda.b d1
	beq .18
	inc.b d1
.18:								; Y = a2, A = Yvel,y, if the result < 0 go to .19, A = $0000, ...
	ldy.b a2
	lda.w Yvel,y
	eor.b d1
	bmi .19
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
.19:								; A 8-bit, $09A1,x = d0, $09C1,x = d1, A 16-bit, ...
	sep #$20
	lda.b d0
	sta.w $09A1,x
	lda.b d1
	sta.w $09C1,x
	rep #$20
	jmp.w puckflip
.rtl:								; return
	rtl
.20:								; go to .15
	jmp.w .15
.21:								; A = $0002, A + $0E80,y, A and $FF00, A * 2, ...
	lda.w #$0002
	clc
	adc.w $0E80,y
	xba
	and.w #$FF00
	asl a
	jsl.l randomd0A
	adc.w #$2000
	sta.b d0
	cmp.w puckvx
	bmi .20
	lda.b d0
	cmp.w puckvy
	bmi .20
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	cmp.w puckvx
	bpl .20
	lda.b d0
	cmp.w puckvy
	bpl .20
	ldy.b a2
	lda.w pflags,y
	bit.w #$1000
	bne .20
	stz.w puckvz
	jmp.w CODE_C44E0A
ChkShotStat:						; from puckgoalie, Goal and other segments
	lda.w #$1000
	trb.w sflags
	bne .1
	jmp.w .rtl
.1:									; if gmclock = 0 go to .2, go to .rtl
	lda.w gmclock
	beq .2
	jmp.w .rtl
.2:									; push X, a3 = $07EA, a2 = 0, A = $0002
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	pei ($7F)
	pei ($81)
	phx
	ldx.w $07EA
	stx.b a3
	stz.b a2
	lda.w #$0002
	sta.b a1
	txa
	cmp.w #$000C
	bmi .3
	lda.w #$0002
	sta.b a2
	stz.b a1
.3:									; Y = $1297, if pfteam,x = 0 go to .4, Y + 1, Y + 1
	ldy.w #$1297
	lda.w pfteam,x
	beq .4
	iny
	iny
.4:									; A = $0000,y, A + 1, $0000,y = A, if a2 is not 0 go to .6, ...
	lda.w $0000,y
	inc a
	sta.w $0000,y
	ldy.b a2
	bne .6
	lda.w tmap
	sec
	sbc.w $12C9
	beq .8
	bmi .5
	lda.w tmPPShots
	inc a
	sta.w tmPPShots
	bra .8
.5:									; A = tmSHShots, A + 1, tmSHShots = A, go to .8
	lda.w tmSHShots
	inc a
	sta.w tmSHShots
	bra .8
.6:									; A = $12C9, A - tmap, if the result = 0 go to .8, if minus go to .7, ...
	lda.w $12C9
	sec
	sbc.w tmap
	beq .8
	bmi .7
	lda.w $1279
	inc a
	sta.w $1279
	bra .8
.7:									; A = $127D, A + 1, $127D = A
	lda.w $127D
	inc a
	sta.w $127D
.8:									; A = gsp, A * 2, A * 2, X = A, ...
	lda.w gsp
	asl a
	asl a
	tax
	lda.b a2
	beq .9
	inx
	inx
.9:									; A = $1287,x, A + 1, $1287,x = A, X = a3, ...
	lda.w $1287,x
	inc a
	sta.w $1287,x
	ldx.b a3
	lda.w pnum,x
	sta.b d0
	lda.b a2
	beq .10
	lda.w #$001A
.10:								; A + d0, X = a2, if A = tmgoalie,x go to .11, X = A, ...
	clc
	adc.b d0
	ldx.b a2
	cmp.w tmgoalie,x
	beq .11
	tax
	sep #$20
	inc.w $147B,x
	rep #$20
.11:								; X = a1, d0 = tmgoalie,x, if tmgoalie,x < 0 go to .13, ...
	ldx.b a1
	lda.w tmgoalie,x
	sta.b d0
	bmi .13
	lda.b a1
	beq .12
	lda.w #$001A
.12:								; A + d0, X = A, A 8-bit, $147B,x + 1, ...
	clc
	adc.b d0
	tax
	sep #$20
	inc.w $147B,x
	rep #$20
.13:								; pull X, pull A, $81 = A, pull A, ...
	plx
	pla
	sta.b $81
	pla
	sta.b d0
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
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi .rtl
	sta.w CwdExciteLvl
.rtl:								; return
	rtl
Goal:								; called from other segments
	lda.w gmclock
	beq .1
	stz.w puckvz
	stz.w puckvx
	stz.w puckvy
	rtl
.1:									; if PenShotActive = 0 go to .6, if pucky >= 0 go to .2, A = gmode, ...
	lda.w PenShotActive
	beq .6
	lda.w pucky
	bpl .2
	lda.w gmode
	bit.w #$0002
	beq .5
	bra .3
.2:									; A = gmode, if $0002 bits clear go to .3, go to .5
	lda.w gmode
	bit.w #$0002
	beq .3
	bra .5
.3:									; if BA_Team = 0 go to .6
	lda.w BA_Team
	beq .6
.4:									; call EndPenaltyShot, go to CODE_C4AD25
	jsl.l EndPenaltyShot
	jmp.w CODE_C4AD25
.5:									; if BA_Team = 0 go to .4
	lda.w BA_Team
	beq .4
.6:									; call ChkShotStat, call freezewindow, replaydelay = $001E, a2 = 0, ...
	jsl.l ChkShotStat
	jsl.l freezewindow
	lda.w #$001E
	sta.w replaydelay
	stz.b a2
	lda.w #$0002
	sta.b a1
	lda.w pucky
	bpl .7
	stz.b a1
	lda.w #$0002
	sta.b a2
.7:									; A = gmode, if $0002 bits clear go to .8, a2 = a1, A xor $0002, ...
	lda.w gmode
	bit.w #$0002
	beq .8
	lda.b a1
	sta.b a2
	eor.w #$0002
	sta.b a1
.8:									; Y = a2, A = tmscore,y, A + 1, tmscore,y = A, ...
	ldy.b a2
	lda.w tmscore,y
	inc a
	sta.w tmscore,y
	lda.w tmap
	sec
	sbc.w $12C9
	beq .11
	bmi .9
	ldy.b a2
	beq .11
	bra .10
.9:									; if a2 is not 0 go to .11
	ldy.b a2
	bne .11
.10:								; A = $127F,y, A + 1, $127F,y = A
	lda.w $127F,y
	inc a
	sta.w $127F,y
.11:								; if penshot is not 0 go to .12, if breakaway = 0 go to .13, Y = a2, ...
	lda.w penshot
	bne .12
	lda.w breakaway
	beq .13
	ldy.b a2
	lda.w $12E7,y
	inc a
	sta.w $12E7,y
	bra .13
.12:								; Y = a2, A = $12EF,y, A + 1, $12EF,y = A
	ldy.b a2
	lda.w $12EF,y
	inc a
	sta.w $12EF,y
.13:								; if onetimer = 0 go to .14, Y = a2, A = $12FB,y, A + 1, ...
	lda.w onetimer
	beq .14
	ldy.b a2
	lda.w $12FB,y
	inc a
	sta.w $12FB,y
.14:								; A = $0009, call QueueSoundCmd, A = $00A2, call StartSound, ...
	lda.w #$0009
	jsl.l QueueSoundCmd
	lda.w #$00A2
	jsl.l StartSound
	stz.w $06EC
	ldy.b a2
	beq .16
	lda.w #$0004
	jsl.l CODE_C382B6
	lda.l $7E24CA
	sec
	sbc.w #$0300
	bpl .15
	lda.w #$0000
.15:								; $7E24CA = A, go to .17
	sta.l $7E24CA
	bra .17
.16:								; A + 1, A + 1, call CODE_C382B6, A = $7E24CA, ...
	inc a
	inc a
	jsl.l CODE_C382B6
	lda.l $7E24CA
	clc
	adc.w #$01F4
	sta.l $7E24CA
	lda.w #$0078
	sta.b crowdhold
	lda.w #$0003
	jsl.l PlayTeamSongNow
.17:								; $07EC = Vcount, call EndPenaltyShot, breakaway = 0, onetimer = 0, ...
	lda.b Vcount
	sta.w $07EC
	jsl.l EndPenaltyShot
	stz.w breakaway
	stz.w onetimer
	phx
	lda.w gsp
	asl a
	asl a
	tax
	lda.w CwdExciteLvl
	clc
	adc.w #$001E
	bmi .18
	sta.w CwdExciteLvl
.18:								; if a2 = 0 go to .19, X + 1, X + 1, A = CwdExciteLvl, ...
	lda.b a2
	beq .19
	inx
	inx
	lda.w CwdExciteLvl
	clc
	adc.w #$FFCE
	bmi .19
	sta.w CwdExciteLvl
.19:								; A = $129B,x, A + 1, $129B,x = A, pull X, ...
	lda.w $129B,x
	inc a
	sta.w $129B,x
	plx
	lda.w $2038
	cmp.w #$0258
	bne .20
	sec
	sbc.w #$0006
	sta.w $2038
.20:								; $65 = $007E, A = $203A, A + $2038, a0 = A, ...
	lda.w #$007E
	sta.b $65
	lda.w #$203A
	clc
	adc.w $2038
	sta.b a0
	lda.w $2038
	adc.w #$0006
	sta.w $2038
	jsl.l GetPeriodTimeRemaining
	lda.b d0
	sta.b [a0]
	inc.b a0
	inc.b a0
	lda.w #$0002
	clc
	ldy.b a2
	adc.w tmap,y
	ldy.b a1
	sec
	sbc.w tmap,y
	ldy.b a2
	beq .21
	ora.w #$0080
.21:								; [a0] = A, a0 + 1, d0 = tmtouch1,y, [a0] = A, ...
	sta.b [a0]
	inc.b a0
	lda.w tmtouch1,y
	sta.b d0
	sta.b [a0]
	inc.b a0
	lda.w #$FFFF
	sta.b [a0]
	ldx.b a2
	lda.w tmgoalie,x
	cmp.b d0
	beq .23
	lda.b a2
	beq .22
	lda.w #$001A
.22:								; A + d0, X = A, A 8-bit, $1413,x + 1, ...
	clc
	adc.b d0
	tax
	sep #$20
	inc.w $1413,x
	rep #$20
.23:								; Y = a2, d0 = tmtouch2,y, if tmtouch2,y < 0 go to .26, A 8-bit, ...
	ldy.b a2
	lda.w tmtouch2,y
	sta.b d0
	bmi .26
	sep #$20
	sta.b [a0]
	rep #$20
	lda.b a2
	beq .24
	lda.w #$001A
.24:								; A + d0, X = A, A 8-bit, $1447,x + 1, ...
	clc
	adc.b d0
	tax
	sep #$20
	inc.w $1447,x
	rep #$20
	inc.b a0
	lda.w tmtouch3,y
	sta.b d0
	bmi .26
	sep #$20
	sta.b [a0]
	rep #$20
	lda.b a2
	beq .25
	lda.w #$001A
.25:								; A + d0, X = A, A 8-bit, $1447,x + 1, ...
	clc
	adc.b d0
	tax
	sep #$20
	inc.w $1447,x
	rep #$20
.26:								; Y = a1, d0 = tmgoalie,y, if tmgoalie,y < 0 go to .28, ...
	ldy.b a1
	lda.w tmgoalie,y
	sta.b d0
	bmi .28
	lda.b a1
	beq .27
	lda.w #$001A
.27:								; A + d0, X = A, $1413,x + 1
	clc
	adc.b d0
	tax
	inc.w $1413,x
.28:								; call PenGoalStuff, call CODE_C539D7, X = a3, d0 = $0008, ...
	jsl.l PenGoalStuff
	jsl.l CODE_C539D7
	ldx.b a3
	lda.w #$0008
	sta.b d0
	jsl.l CODE_C4AD04
	lda.b a2
	bne .29
	lda.w $12AD
	sec
	sbc.w tmscore
	bmi .29
	cmp.w #$0003
	bcs .29
.29:								; collflag = 0, puckvx = 0, puckvy = 0, Y = $0006, ...
	stz.w collflag
	stz.w puckvx
	stz.w puckvy
	ldy.w #$0006
	lda.w $0830
	bpl .30
	ldy.w #$FFFA
.30:								; $0830 = Y, Y = $0116, if pucky >= 0 go to .31, Y = $FEEA
	sty.w $0830
	ldy.w #$0116
	lda.w pucky
	bpl .31
	ldy.w #$FEEA
.31:								; pucky = Y, puckvz = $0600, puckz = 0, puckcross = $FFFF, ...
	sty.w pucky
	lda.w #$0600
	sta.w puckvz
	stz.w puckz
	lda.w #$FFFF
	sta.w puckcross
	sta.w $07DE
	sta.w $109C
	lda.w #$001A
	sta.b d0
	jsl.l assreplace
	inx
	inx
	lda.w #$253E
	jsl.l SetSPAFromA
	ldy.b a2
	ldx.w tmsort,y
	stx.b a3
	lda.w #$000E
	sta.b d0
	jsl.l AddPenalty2
	ldx.w #$001C
	stx.b a3
	rtl
CODE_C4AD04:						; from Goal and other segments
	phx
	ldy.b a2
	lda.w tmsort,y
	tax
	lda.w #$0005
	sta.b d3
.loop:								; loop: if position,x < 0 go to .1, if zero go to .1, pfnc,x = 0, ...
	lda.w position,x
	bmi .1
	beq .1
	stz.w pfnc,x
	jsl.l CODE_C43734
.1:									; X + 1, X + 1, d3 - 1, if the result >= 0 go to .loop, ...
	inx
	inx
	dec.b d3
	bpl .loop
	plx
CODE_C4AD25:						; from Goal
	rtl
puckstick:							; from puckbody and other segments
	ldy.b a2
	lda.w position,y
	bne .1
	lda.w gmode
	bit.w #$0010
	beq .1
.rtl:								; return
	rtl
.1:									; A = pflags,y, A and $FFFE, pflags,y = A, if puckc >= 0 go to .2, ...
	lda.w pflags,y
	and.w #$FFFE
	sta.w pflags,y
	ldy.w puckc
	bpl .2
	jmp.w .5
.2:									; A = pfteam,y, Y = a2, if pfteam,y = pfteam,y go to .rtl, ...
	lda.w pfteam,y
	ldy.b a2
	cmp.w pfteam,y
	beq .rtl
	lda.b d0
	cmp.w #$0025
	bcs .rtl
	lda.w position,y
	beq .3
	ldy.b a0
	lda.w position,y
	beq .rtl
	lda.w stickhand,y
	jsl.l makepde
	pei ($7F)
	lda.b a0
	ldy.b a2
	sty.b a0
	sta.b a2
	lda.w stickhand,y
	sta.b d0
	jsl.l makepde
	lda.b a0
	ldy.b a2
	sty.b a0
	sta.b a2
	pla
	sec
	sbc.b d0
	clc
	adc.w #$0024
	jsl.l randomd0A
	cmp.w #$0003
	bcs .rtl
.3:									; Y = a0, A = stickhand,y, call makepde, A = d0, ...
	ldy.b a0
	lda.w stickhand,y
	jsl.l makepde
	lda.b d0
	adc.w #$0014
	ldy.b a0
	sta.w nopuck,y
	lda.b a0
	ldy.b a2
	sty.b a0
	sta.b a2
	lda.w stickhand,y
	jsl.l makepde
	lda.b d0
	adc.w #$0014
	ldy.b a0
	sta.w nopuck,y
	lda.b a0
	ldy.b a2
	sty.b a0
	sta.b a2
	tya
	lsr a
	sta.w lastplayer
	lda.w #$000C
	trb.w sflags
.4:									; A = $000D, call StartSound, call a2touchpuck, go to deflect
	lda.w #$000D
	jsl.l StartSound
	jsl.l a2touchpuck
	jmp.w deflect
.rtl2:								; return
	rtl
.5:									; d2 = d0, A = puckvx, push X, X = A, ...
	lda.b d0
	sta.b d2
	lda.w puckvx
	phx
	tax
	jsl.l Mul16S
	lda.b $36
	sta.b $81
	lda.b r2
	sta.b d0
	lda.w puckvy
	tax
	jsl.l Mul16S
	plx
	lda.b r2
	clc
	adc.b d0
	sta.b d0
	lda.b $36
	adc.b $81
	sta.b $81
	stz.b d1
	lda.w sflags
	bit.w #$1000
	bne .6
	ldy.b a2
	lda.w stickhand,y
	phx
	ldx.w #$02BC
	jsl.l Mul16x8U
	lda.b r2
	sta.b d1
	plx
.6:									; A = d1, A + $2710, if position,x = 0 go to .7, ...
	lda.b d1
	clc
	adc.w #$2710
	ldy.w position,x
	beq .7
	cpx.w passReceiverPlayerNum
	bne .8
.7:									; A + $0BB8
	adc.w #$0BB8
.8:									; push X, X = A, call Mul16U, pull X, ...
	phx
	tax
	jsl.l Mul16U
	plx
	lda.b r2
	cmp.b d0
	lda.b $36
	sbc.b $81
	bcs .10
	lda.w position,x
	beq .9
	lda.b d2
	cmp.w #$0025
	bcc .9
	jmp.w .rtl2
.9:									; Y = a2, nopuck,y = $0008, go to .4
	ldy.b a2
	lda.w #$0008
	sta.w nopuck,y
	jmp.w .4
.10:								; go to CODE_C44E0A
	jmp.w CODE_C44E0A
deflect:							; from puckstick
	lda.w #$FFFF
	sta.w puckc
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w puckvy
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w puckvx
	jsl.l RandomWord
	and.w #$0FFF
	sta.w puckvz
	jmp.w puckflip
PuckIChk:							; called from other segments
	lda.w iflags
	bit.w #$0004
	beq .rtl
	bit.w #$0001
	bne .rtl
	lda.w puckc
	bpl .rtl
	lda.w #$010E
	sta.b d0
	lda.w iflags
	bit.w #$0002
	bne .1
	lda.w #$FEF2
	sec
	sbc.w pucky
	bpl .2
.rtl:								; return
	rtl
.1:									; A = $010E, A - pucky, if the result >= 0 go to .rtl
	lda.w #$010E
	sec
	sbc.w pucky
	bpl .rtl
.2:									; A = $0001, return
	lda.w #$0001
	tsb.w iflags
	rtl
ChkOffsides:						; the offsides check: ClearOffsidesIfAllPlayers for both sides, then the
									; puck against the blue line (ChkOffsides_other / _blue / _rtl)
	stz.b a1
	lda.w #$0002
	sta.b a2
	jsl.l ClearOffsidesIfAllPlayers
	stz.b a2
	lda.w #$0002
	sta.b a1
	jsl.l ClearOffsidesIfAllPlayers
	lda.w #$0058
	sta.b d0
	lda.w pucky
	bpl .1
	jmp.w ChkOffsides_other
.1:									; A = d0, A - pucky, if the result < 0 go to .2, A = d0, ...
	lda.b d0
	sec
	sbc.w pucky
	bmi .2
	lda.b d0
	sec
	sbc.w OldYpos
	bpl CODE_C4AF74
	bra ChkOffsides_blue
.2:									; A = d0, A - OldYpos, if the result < 0 go to CODE_C4AF74
	lda.b d0
	sec
	sbc.w OldYpos
	bmi CODE_C4AF74
ChkOffsides_blue:					; from ChkOffsides
	jsl.l StartBreakaway
	lda.w gmode
	bit.w #$0020
	bne .1
	jmp.w CODE_C4AF74
.1:									; d0 = $0062, A = gmode, if $0002 bits clear go to .2, A = a2, ...
	lda.w #$0062
	sta.b d0
	lda.w gmode
	bit.w #$0002
	beq .2
	lda.b a2
	ldy.b a1
	sty.b a2
	sta.b a1
.2:									; if puckc >= 0 go to .3, A = lastplayer, A * 2
	lda.w puckc
	bpl .3
	lda.w lastplayer
	asl a
.3:									; if A - $000C >= 0 go to .4, if a2 = 0 go to .5, go to CODE_C4AF74
	cmp.w #$000C
	bpl .4
	lda.b a2
	beq .5
	bra CODE_C4AF74
.4:									; if a2 = 0 go to CODE_C4AF74
	lda.b a2
	beq CODE_C4AF74
.5:									; d2 = $0005, Y = a2, a0 = tmsort,y
	lda.w #$0005
	sta.b d2
	ldy.b a2
	lda.w tmsort,y
	sta.b a0
ChkOffsides_loop:					; from CODE_C4AF75
	ldy.b a0
	lda.w position,y
	bmi CODE_C4AF75
	lda.b d0
	sec
	sbc.w Ypos,y
	bpl CODE_C4AF75
	ldy.b a2
	lda.w tmflags,y
	ora.w #$0010
	sta.w tmflags,y
CODE_C4AF74:						; from ClearOffsidesIfAllPlayers, ChkOffsides, ChkOffsides_other, ...
	rtl
CODE_C4AF75:						; from ChkOffsides_loop
	inc.b a0
	inc.b a0
	dec.b d2
	bpl ChkOffsides_loop
	rtl
ChkOffsides_other:					; from ChkOffsides
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.b d0
	sec
	sbc.w pucky
	bmi .1
	lda.b d0
	sec
	sbc.w OldYpos
	bpl CODE_C4AF74
	bra .2
.1:									; A = d0, A - OldYpos, if the result < 0 go to CODE_C4AF74
	lda.b d0
	sec
	sbc.w OldYpos
	bmi CODE_C4AF74
.2:									; call StartBreakaway, A = gmode, if a $0020 bit set go to .3, ...
	jsl.l StartBreakaway
	lda.w gmode
	bit.w #$0020
	bne .3
	jmp.w CODE_C4AF74
.3:									; A = d0, A - $000A, d0 = A, A = gmode, ...
	lda.b d0
	sec
	sbc.w #$000A
	sta.b d0
	lda.w gmode
	bit.w #$0002
	bne .4
	lda.b a2
	ldy.b a1
	sty.b a2
	sta.b a1
.4:									; if puckc >= 0 go to .5, A = lastplayer, A * 2
	lda.w puckc
	bpl .5
	lda.w lastplayer
	asl a
.5:									; if A - $000C >= 0 go to .6, if a2 = 0 go to .7, go to CODE_C4AF74
	cmp.w #$000C
	bpl .6
	lda.b a2
	beq .7
	bra CODE_C4AF74
.6:									; if a2 = 0 go to CODE_C4AF74
	lda.b a2
	beq CODE_C4AF74
.7:									; d2 = $0005, Y = a2, a0 = tmsort,y
	lda.w #$0005
	sta.b d2
	ldy.b a2
	lda.w tmsort,y
	sta.b a0
.8:									; Y = a0, if position,y < 0 go to .9, A = d0, A - Ypos,y, ...
	ldy.b a0
	lda.w position,y
	bmi .9
	lda.b d0
	sec
	sbc.w Ypos,y
	bmi .9
	ldy.b a2
	lda.w tmflags,y
	ora.w #$0010
	sta.w tmflags,y
	rtl
.9:									; a0 + 1, a0 + 1, d2 - 1, if the result >= 0 go to .8, ...
	inc.b a0
	inc.b a0
	dec.b d2
	bpl .8
	rtl

; Segment bankC4_7000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4702E
skatetopuck:						; called from other segments
	jsl.l skatetopuckinit
	lda.w temp2,x
	sec
	sbc.b d7
	sta.w temp2,x
	bmi .1
	jmp.w .5
.1:									; A + $0005, temp2,x = A, call CODE_C46BF6, A = X, ...
	adc.w #$0005
	sta.w temp2,x
	jsl.l CODE_C46BF6
	pei ($83)
	pei ($7F)
	txa
	jsl.l CODE_C37FE2
	lda.b d0
	eor.w #$FFFF
	inc a
	sec
	sbc.w $09A1,x
	and.w #$00FF
	bit.w #$0080
	beq .2
	ora.w #$FF00
.2:									; A + $01,s, A - Xpos,x, d0 = A, A = d1, ...
	clc
	adc.b $01,s
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.b d1
	eor.w #$FFFF
	inc a
	sec
	sbc.w $09C1,x
	and.w #$00FF
	bit.w #$0080
	beq .3
	ora.w #$FF00
.3:									; A + $03,s, A - Ypos,x, d1 = A, pull A, ...
	clc
	adc.b $03,s
	sec
	sbc.w Ypos,x
	sta.b d1
	pla
	pla
	jsl.l vtoa
	lda.b d0
	sta.w temp2b,x
	lda.w position,x
	beq .5
	lda.w puckvx
	sta.b d0
	lda.w puckvy
	sta.b d1
	jsl.l vtoa
	lda.b d0
	cmp.w #$0008
	beq .4
	eor.w #$0004
	cmp.w facedir,x
	beq .5
.4:									; A = pucky, A - Ypos,x, d1 = A, push A, ...
	lda.w pucky
	sec
	sbc.w Ypos,x
	sta.b d1
	pha
	lda.w $0830
	sec
	sbc.w Xpos,x
	sta.b d0
	pha
	jsl.l vtoa
	lda.b d0
	sta.b tmp0
	pla
	sta.b d0
	sta.b r0
	pla
	sta.b d1
	lda.w facedir,x
	cmp.b tmp0
	beq .6
.5:									; d0 = temp2b,x, go to doplayeracc
	lda.w temp2b,x
	sta.b d0
	jml.l doplayeracc
.6:									; if puckc < 0 go to .5, A = r0, A / 2, A / 2, ...
	lda.w puckc
	bmi .5
	lda.b r0
	lsr a
	lsr a
	and.w #$01FE
	tax
	lda.l DATA8_C38A4A,x
	sta.b d0
	lda.b d1
	and.w #$07F8
	lsr a
	lsr a
	tax
	lda.l DATA8_C38A4A,x
	ldx.b a3
	adc.b d0
	cmp.w #$000E
	bcc .5
	cmp.w #$0028
	bcs .7
	jmp.w CODE_C45606
.7:									; go to .5
	bra .5
CODE_C47122:						; called from other segments
	lda.w gmode
	bit.w #$0040
	beq .1
	lda.b a2
	inc a
	inc a
	jsl.l CODE_C382B6
.1:									; if playerpad,x < 0 go to .2, A = PadRaw1,y, ...
	ldy.w playerpad,x
	bmi .2
	lda.w PadRaw1,y
	and.w #$FFF0
	beq .2
	rtl
.2:									; A = Xvel,x, X = A, A = $00C0, call Mul16x8XS, ...
	lda.w Xvel,x
	tax
	lda.w #$00C0
	jsl.l Mul16x8XS
	ldx.b a3
	lda.b $35
	sta.w Xvel,x
	lda.w Yvel,x
	tax
	lda.w #$00C0
	jsl.l Mul16x8XS
	ldx.b a3
	lda.b $35
	sta.w Yvel,x
	txa
	lsr a
	cmp.w puckc
	bne .3
	lda.w #$FFFF
	sta.w puckc
	lda.w #$0708
	sta.w nopuck,x
.3:									; A = pflags,x, if $0002 bits clear go to .5, A and $FFFD, ...
	lda.w pflags,x
	bit.w #$0002
	beq .5
	and.w #$FFFD
	sta.w pflags,x
	jsl.l CODE_C471E2
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
	lda.w #$005A
	sta.w temp3,x
	lda.b $CB
	bpl .4
	lda.w #$FFA6
	sta.w temp3,x
.4:									; temp4,x = $CD
	lda.b $CD
	sta.w temp4,x
.5:									; $65 = $00C4, a0 = $883F, d0 = temp3,x, d1 = temp4,x, ...
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b a0
	lda.w temp3,x
	sta.b d0
	lda.w temp4,x
	sta.b d1
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl CODE_C471ED
	lda.w #$2824
	sta.b d1
	sta.w pfalock,x
	cpx.w $07EA
	bne .6
	lda.w #$27B2
	sta.b d1
	lda.w #$FFFF
	sta.w $07EA
.6:									; call SetSPA
	jsl.l SetSPA
CODE_C471E2:						; from CODE_C47122 and other segments
	lda.w #$0078
	jsl.l randoma8
	sta.w temp1,x
	rtl
CODE_C471ED:						; from CODE_C47122
	jmp.w skateto
CODE_C471F0:						; called from other segments
	jsl.l updatepentime
	jsl.l checkfornewpen
	jsl.l chkprogress
	jml.l CODE_C38C4A
chkatop:							; from CODE_C47FD4 and other segments
	stz.b d1
	lda.w pucky
	sec
	sbc.w #$005C
	bpl .1
	inc.b d1
	inc.b d1
	lda.w pucky
	sec
	sbc.w #$FFA4
	bpl .rtl
.1:									; A = gmode, if $0002 bits clear go to .2, A = d1, A xor $0002, ...
	lda.w gmode
	bit.w #$0002
	beq .2
	lda.b d1
	eor.w #$0002
	sta.b d1
.2:									; Y = d1, A = $126F,y, A + 1, $126F,y = A
	ldy.b d1
	lda.w $126F,y
	inc a
	sta.w $126F,y
.rtl:								; return
	rtl
CountPowerPlayTime:					; from CODE_C47FD4 and other segments
	stz.b d1
	lda.w tmap
	sec
	sbc.w $12C9
	beq .rtl
	bpl .1
	lda.w #$0002
	sta.b d1
.1:									; Y = d1, A = $1273,y, A + 1, $1273,y = A
	ldy.b d1
	lda.w $1273,y
	inc a
	sta.w $1273,y
.rtl:								; return
	rtl
checkfornewpen:						; from CODE_C471F0 and other segments
	lda.w $2CF5
	beq .1
	jmp.w .rtl
.1:									; a0 = $10F9
	lda.w #$10F9
	sta.b a0
.loop:								; loop: A = (a0), a0 + 1, a0 + 1, A and $00FF, ...
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	cmp.w #$0034
	beq .loop
	tay
	bne .2
	jmp.w .rtl
.2:									; A = gmode, if a $0004 bit set go to .5, d0 = Y, $69 = $00C3, ...
	lda.w gmode
	bit.w #$0004
	bne .5
	sty.b d0
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b a1
	lda.b [a1],y
	clc
	adc.b a1
	sta.b a1
	lda.b [a1]
	and.w #$00FF
	beq .4
	lda.w puckc
	bmi .8
	lsr a
	sec
	sbc.w #$0006
	sta.b d0
	dec.b a0
	lda.b (a0)
	inc.b a0
	and.w #$00FF
	bit.w #$0080
	beq .3
	ora.w #$FF00
.3:									; A - $0006, if the result < 0 go to .8
	sec
	sbc.w #$0006
	eor.b d0
	bmi .8
.4:									; call Stop4Pen
	jsl.l Stop4Pen
.5:									; a0 - 1, A = (a0), Y = A, A or $0080, ...
	dec.b a0
	lda.b (a0)
	tay
	ora.w #$0080
	sta.b (a0)
	inc.b a0
	tya
	bit.w #$0080
	beq .6
	jmp.w .loop
.6:									; a0 - 1, a0 - 1, A = (a0), a0 + 1, ...
	dec.b a0
	dec.b a0
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	sta.b d0
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b a1
	lda.b [a1],y
	clc
	adc.b a1
	sta.b a1
	ldy.w #$0001
	lda.b [a1],y
	and.w #$00FF
	asl a
	asl a
	asl a
	asl a
	asl a
	sta.b d1
	sec
	sbc.w PenCntDwn
	beq .7
	bmi .7
	lda.b d1
	sta.w PenCntDwn
.7:									; go to .loop
	jmp.w .loop
.rtl:								; return
	rtl
.8:									; A = $0008, if not zero go to .7, d0 = $0030, call CODE_C38C6D, ...
	lda.w #$0008
	tsb.w gmode
	bne .7
	lda.w #$0030
	sta.b d0
	jsl.l CODE_C38C6D
	jmp.w .loop
Stop4Pen:							; from checkfornewpen and other segments
	lda.w #$FFFF
	tsb.w gmclock
	beq .1
	jmp.w .7
.1:									; d0 = 0, d1 = 0, a0 - 1, a0 - 1, ...
	stz.b d0
	stz.b d1
	dec.b a0
	dec.b a0
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	cmp.w #$000E
	beq .2
	pha
	lda.w $2004
	sta.b d0
	lda.w $2006
	sta.b d1
	pla
	cmp.w #$0006
	beq .2
	ldy.w $0830
	sty.b d0
	ldy.w pucky
	sty.b d1
	cmp.w #$000C
	bne .2
	dec.b a0
	lda.b (a0)
	inc.b a0
	and.w #$00FF
	asl a
	tay
	lda.w #$0258
	sta.b d1
	lda.w pfgoal,y
	beq .2
	lda.w #$FDA8
	sta.b d1
.2:									; tmp0 = d0, A - $0050, if the result < 0 go to .3, d0 = $0050
	lda.b d0
	sta.b tmp0
	sec
	sbc.w #$0050
	bmi .3
	lda.w #$0050
	sta.b d0
.3:									; A = d0, A - $FFB0, if the result >= 0 go to .4, d0 = $FFB0
	lda.b d0
	sec
	sbc.w #$FFB0
	bpl .4
	lda.w #$FFB0
	sta.b d0
.4:									; A = d1, A - $00AC, if the result < 0 go to .5, d1 = $00D4, ...
	lda.b d1
	sec
	sbc.w #$00AC
	bmi .5
	lda.w #$00D4
	sta.b d1
	lda.w #$0050
	sta.b d0
	lda.b tmp0
	bpl .5
	lda.w #$FFB0
	sta.b d0
.5:									; A = d1, A - $FF54, if the result >= 0 go to .6, d1 = $FF2C, ...
	lda.b d1
	sec
	sbc.w #$FF54
	bpl .6
	lda.w #$FF2C
	sta.b d1
	lda.w #$0050
	sta.b d0
	lda.b tmp0
	bpl .6
	lda.w #$FFB0
	sta.b d0
.6:									; $2034 = d0, $2036 = d1, call CODE_C51F7C
	lda.b d0
	sta.w $2034
	lda.b d1
	sta.w $2036
	jsl.l CODE_C51F7C
.7:									; A = Vcount, A - $07EC, if A < $003C go to .8
	lda.b Vcount
	sec
	sbc.w $07EC
	cmp.w #$003C
	bcc .8
.8:									; if replaydelay is not 0 go to .9, replaydelay = $001E
	lda.w replaydelay
	bne .9
	lda.w #$001E
	sta.w replaydelay
.9:									; A = $0012, call StartSound, PenCntDwn = 0, A = $0004, ...
	lda.w #$0012
	jsl.l StartSound
	stz.w PenCntDwn
	lda.w #$0004
	tsb.w gmode
	lda.w #$000A
	sta.b d0
	jml.l CODE_C38C6D
chkprogress:						; from CODE_C471F0 and other segments
	lda.w gmode
	bit.w #$0004
	bne .1
.rtl:								; return
	rtl
.1:									; if PenCntDwn >= 0 go to .2, go to .3
	lda.w PenCntDwn
	bpl .2
	jmp.w .3
.2:									; A - d7, PenCntDwn = A, if plus go to .rtl, A = $0008, ...
	sec
	sbc.b d7
	sta.w PenCntDwn
	bpl .rtl
	lda.w #$0008
	trb.w gmode
	lda.w #$10F9
	sta.b a0
.loop:								; loop: A = (a0), a0 + 1, a0 + 1, A and $00FF, ...
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	cmp.w #$0034
	beq .loop
	tay
	beq .rtl
	dec.b a0
	dec.b a0
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	sta.b d0
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b a1
	clc
	adc.b [a1],y
	sta.b a1
	lda.b [a1]
	and.w #$00FF
	beq .loop
	cmp.w #$0001
	beq .loop
	lda.w #$0400
	tsb.w sflags
	jsl.l FadeOutWait
	jsl.l CODE_C5226A
	lda.w #$0038
	sta.b $CB
	stz.b $CD
	jsl.l freezewindow
	lda.w #$FF00
	tsb.w puckc
	ldx.w #$001C
	stx.b a3
	lda.w #$001A
	sta.b d0
	jsl.l CODE_C43734
	ldx.b a3
	lda.w #$1C20
	sta.w temp1,x
	lda.w #$FF00
	tsb.w $1147
	stz.w RefCnt
	jsl.l CODE_C38C4A
	lda.w #$0032
	sta.w RefCnt
	stz.b d0
	stz.w tmp0
	phx
	jsl.l CODE_C38CFC
	plx
	stz.w fadestep
	rtl
.3:									; call SeatPenaltyBox, if RefCnt < 0 go to .4, go to .rtl2
	jsl.l SeatPenaltyBox
	lda.w RefCnt
	bmi .4
	jmp.w .rtl2
.4:									; if $1147 < 0 go to .5, go to .rtl2
	lda.w $1147
	bmi .5
	jmp.w .rtl2
.5:									; continue
	pei ($7F)
	pei ($81)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
.6:									; a0 = $10F9
	lda.w #$10F9
	sta.b a0
.loop2:								; loop: A = (a0), a0 + 1, a0 + 1, A and $00FF, ...
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	cmp.w #$0034
	beq .loop2
	cmp.w #$0000
	bne .loop3
	jmp.w .23
.loop3:								; loop: A = (a0), a0 + 1, a0 + 1, if (a0) is not $0000 go to .loop3, ...
	lda.b (a0)
	inc.b a0
	inc.b a0
	cmp.w #$0000
	bne .loop3
	dec.b a0
	dec.b a0
	dec.b a0
	dec.b a0
	lda.b (a0)
	pha
	and.w #$7FFF
	sta.b (a0)
	pla
	bmi .8
	lda.b (a0)
	xba
	and.w #$00FF
	asl a
	sta.b d1
	tay
	lda.w position,y
	bmi .7
	jmp.w .24
.7:									; (a0) = $0000, go to .24
	lda.w #$0000
	sta.b (a0)
	jmp.w .24
.8:									; A = (a0), A and $00FF, d0 = A, Y = A, ...
	lda.b (a0)
	and.w #$00FF
	sta.b d0
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b a1
	lda.b [a1],y
	clc
	adc.b a1
	sta.b a1
	cmp.w #$455B
	bne .9
	jmp.w .20
.9:									; A = [a1], A and $00FF, d2 = A, if not zero go to .10, ...
	lda.b [a1]
	and.w #$00FF
	sta.b d2
	bne .10
	jmp.w .21
.10:								; call GetPeriodTimeRemaining
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	pei ($73)
	pei ($75)
	jsl.l GetPeriodTimeRemaining
	lda.b (a0)
	xba
	and.w #$00FF
	asl a
	sta.b d1
	tax
	stx.b a3
	stz.b d0
	stz.b a2
	lda.w #$0002
	sta.b a1
	lda.w pfteam,x
	beq .11
	lda.w #$8000
	sta.b d0
	stz.b a1
	lda.w #$0002
	sta.b a2
	lda.w CwdExciteLvl
	clc
	adc.w #$0014
	bmi .11
	sta.w CwdExciteLvl
.11:								; Y = a2, A = $1267,y, A + 1, $1267,y = A, ...
	ldy.b a2
	lda.w $1267,y
	inc a
	sta.w $1267,y
	lda.w $126B,y
	clc
	adc.b d2
	sta.w $126B,y
	lda.w pnum,x
	and.w #$00FF
	ora.b d0
	sta.w TempPlOffset
	lda.w pnum,x
	sta.b d0
	lda.b a2
	beq .12
	lda.w #$001A
.12:								; push X, A + d0, X = A, A 8-bit, ...
	phx
	clc
	adc.b d0
	tax
	sep #$20
	lda.w $14AF,x
	rep #$20
	and.w #$00FF
	clc
	adc.b d2
	sep #$20
	sta.w $14AF,x
	rep #$20
	plx
	lda.w $1159
	cmp.w #$0041
	bcs .14
	asl a
	asl a
	tay
	jsl.l GetPeriodTimeRemaining
	lda.b d0
	sta.w $115B,y
	iny
	iny
	lda.w TempPlOffset
	cmp.w #$0080
	bmi .13
	ora.w #$0080
.13:								; A 8-bit, $115B,y = A, A 16-bit, Y + 1, ...
	sep #$20
	sta.w $115B,y
	rep #$20
	iny
	lda.b (a0)
	and.w #$00FF
	sep #$20
	sta.w $115B,y
	rep #$20
	inc.w $1159
.14:								; A = TempPlOffset, A and $00FF, if $0080 bits clear go to .15, A or $FF00
	lda.w TempPlOffset
	and.w #$00FF
	bit.w #$0080
	beq .15
	ora.w #$FF00
.15:								; A * 2, d0 = A, push X, X = $003C, ...
	asl a
	sta.b d0
	phx
	ldx.w #$003C
	lda.b d2
	and.w #$00FF
	jsl.l Mul8U
	ora.w #$2000
	sta.b d2
	plx
	lda.b a2
	beq .16
	lda.w #$0034
.16:								; A + d0, Y = A, if tmpdst,y < 0 go to .17, A and $1000, ...
	clc
	adc.b d0
	tay
	lda.w tmpdst,y
	bmi .17
	and.w #$1000
	tsb.b d2
.17:								; tmpdst,y = d2, A = $1000, if a2 = 0 go to .18, A = $001A
	lda.b d2
	sta.w tmpdst,y
	lda.w #$1000
	trb.b d2
	pei ($65)
	pei ($63)
	lda.b a2
	beq .18
	lda.w #$001A
.18:								; a0 = A, d1 = $0018
	sta.b a0
	lda.w #$0018
	sta.b d1
.loop4:								; loop: Y = a0, a0 + 1, A = tmboxlist,y, if a $0080 bit set go to .19, ...
	ldy.b a0
	inc.b a0
	lda.w tmboxlist,y
	bit.w #$0080
	bne .19
	dec.b d1
	bpl .loop4
.19:								; A = d0, A or $FF00, tmboxlist,y = A, pull A, ...
	lda.b d0
	ora.w #$FF00
	sta.w tmboxlist,y
	pla
	sta.b a0
	pla
	sta.b $65
	lda.w #$000D
	sta.b d0
	jsl.l assreplace
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
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
	ldx.b a3
	jsl.l CODE_C38C6D
	jsl.l CODE_C513F4
	bra .24
.20:								; call StartPenaltyShot
	jsl.l StartPenaltyShot
.21:								; (a0) = $0000, if $2CF5 = 0 go to .22, go to .6
	lda.w #$0000
	sta.b (a0)
	lda.w $2CF5
	beq .22
	jmp.w .6
.22:								; call CODE_C38C6D, go to .24
	jsl.l CODE_C38C6D
	bra .24
.23:								; A = $0004, a3 = $001C, d0 = $001B, call assreplace
	lda.w #$0004
	trb.w gmode
	ldx.w #$001C
	stx.b a3
	lda.w #$001B
	sta.b d0
	jsl.l assreplace
.24:								; if $1864 = $0001 go to .25, if penshot is not 0 go to .25, a2 = 0, ...
	lda.w $1864
	cmp.w #$0001
	beq .25
	lda.w penshot
	bne .25
	stz.b a2
	jsl.l InProgress_ap
	lda.w #$0002
	sta.b a2
	jsl.l InProgress_ap
.25:								; pull A, $71 = A, pull A, a3 = A, ...
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
	sta.b $81
	pla
	sta.b d0
	ldx.b a3
.rtl2:								; return
	rtl
InProgress_ap:						; from chkprogress and other segments
	lda.w #$0006
	sta.b d1
	lda.w #$0032
	sta.b d0
.loop:								; loop: if a2 = 0 go to .1, A = $0034
	lda.b a2
	beq .1
	lda.w #$0034
.1:									; A + d0, Y = A, if tmpdst,y < 0 go to .2, if zero go to .2, ...
	clc
	adc.b d0
	tay
	lda.w tmpdst,y
	bmi .2
	beq .2
	and.w #$DFFF
	sta.w tmpdst,y
	bit.w #$5000
	bne .2
	lda.b d1
	cmp.w #$0004
	beq .2
	dec.b d1
.2:									; d0 - 1, d0 - 1, if the result >= 0 go to .loop, Y = a2, ...
	dec.b d0
	dec.b d0
	bpl .loop
	ldy.b a2
	lda.b d1
	sta.w tmap,y
	rtl
updatepwrplay:						; called from other segments
	lda.w $1864
	cmp.w #$0001
	beq .rtl
	stz.b a2
	lda.w #$0002
	sta.b a3
	lda.w tmap
	sec
	sbc.w $12C9
	sta.b d0
	bne .1
	jmp.w updatepwrplay_clr
.1:									; if plus go to .2, A = sflags, if a $4000 bit set go to .3, ...
	bpl .2
	lda.w sflags
	bit.w #$4000
	bne .3
	jsl.l updatepwrplay_clr
	lda.w #$4000
	tsb.w sflags
	bra .3
.rtl:								; return
	rtl
.2:									; X = a2, a2 = a3, a3 = X, A = sflags, ...
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	lda.w sflags
	bit.w #$4000
	beq .3
	jsl.l updatepwrplay_clr
	lda.w #$4000
	trb.w sflags
.3:									; A = $2000, if not zero go to .4, call CODE_C53A29, X = a3, ...
	lda.w #$2000
	tsb.w sflags
	bne .4
	jsl.l CODE_C53A29
	ldx.b a3
	inc.w $1263,x
.4:									; A = $0005, call AllocWorkBuf2, X = A, $0000,x = $0004, ...
	lda.w #$0005
	jsl.l AllocWorkBuf2
	tax
	lda.w #$0004
	sta.w $0000,x
	lda.w #$9C9B
	sta.w $0001,x
	lda.w #$9E9D
	sta.w $0003,x
	txa
	ldx.w #$007E
	ldy.w #$5B04
	jsl.l QueueVRAMDMALen
	jsl.l GetLowestPen
	lda.w gmclock
	bne .7
	lda.b d0
	cmp.w #$0005
	bcs .7
	cmp.w #$0001
	beq .5
	lda.w #$0001
	bra .6
.5:									; A = $0001
	lda.w #$0001
.6:									; call StartSound
	jsl.l StartSound
.7:									; call CODE_C516C2, A = a1, X = $007E, Y = $5AE5, ...
	jsl.l CODE_C516C2
	lda.b a1
	ldx.w #$007E
	ldy.w #$5AE5
	jsl.l QueueVRAMDMALen
	lda.w sflags
	ldx.w $17C9
	bit.w #$4000
	beq .8
	ldx.w $17CB
.8:									; A = X, call CODE_C53A71, Y = $5AE1, go to QueueVRAMDMALen
	txa
	jsl.l CODE_C53A71
	ldy.w #$5AE1
	jml.l QueueVRAMDMALen
updatepwrplay_clr:					; from updatepwrplay and other segments
	lda.w #$2000
	trb.w sflags
	beq CODE_C4789C
CODE_C4785E:						; called from other segments
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.l DATA8_C58942
	sta.w $3E4E
	ldx.w #$3E4E
	ldy.w #$3E50
	lda.w #$0013
	mvn $7E,$7E
	clc
	lda.w #$5AA0
	ldy.w #$0002
.loop:								; loop: push A, A + $0020, Y - 1, if the result >= 0 go to .loop, ...
	pea.w $0016
	pha
	pea.w $007E
	pea.w $3E4E
	adc.w #$0020
	dey
	bpl .loop
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jml.l CODE_C53A29
CODE_C4789C:						; from updatepwrplay_clr
	rtl
AddPenalty:							; from CODE_C47ACD, CODE_C47C8C and other segments
	lda.w gmclock
	bne .rtl
	lda.w PenShotActive
	bne .rtl
	lda.b d0
	cmp.w #$000C
	beq AddPenalty2
	lda.w $186C
	beq .rtl
	lda.w gmode
	bit.w #$0020
	bne AddPenalty2
	lda.b d0
	cmp.w #$0012
	bne AddPenalty2
.rtl:								; return
	rtl
AddPenalty2:						; from AddPenalty and other segments
	lda.w $2CF5
	beq .1
	jmp.w .rtl
.1:									; if d0 is not $000E go to .2
	pei ($83)
	pei ($85)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	lda.b d0
	cmp.w #$000E
	bne .2
.2:									; A - $000E, if the result < 0 go to .4, A = $7E24CA, A + $00C8, ...
	sec
	sbc.w #$000E
	bmi .4
	lda.l $7E24CA
	clc
	adc.w #$00C8
	sta.l $7E24CA
	lda.w #$002D
	sta.b crowdhold
	lda.w pfteam,x
	beq .4
	lda.l $7E24CA
	sec
	sbc.w #$00C8
	bcs .3
	lda.w #$0000
.3:									; $7E24CA = A
	sta.l $7E24CA
.4:									; a1 = $10F9, d1 = $001F
	lda.w #$10F9
	sta.b a1
	lda.w #$001F
	sta.b d1
.loop:								; loop: A = (a1), a1 + 1, a1 + 1, A and $00FF, ...
	lda.b (a1)
	inc.b a1
	inc.b a1
	and.w #$00FF
	cmp.w #$0034
	beq .loop
	tay
	beq .5
	dec.b d1
	bpl .loop
	bra .6
.5:									; a1 - 1, a1 - 1, A = X, A / 2, ...
	dec.b a1
	dec.b a1
	txa
	lsr a
	xba
	and.w #$FF00
	ora.b d0
	sta.b (a1)
	lda.w #$00C3
	sta.b $65
	lda.w #$4499
	sta.b a0
	ldy.b d0
	clc
	adc.b [a0],y
	sta.b a0
	lda.b [a0]
	and.w #$00FF
	beq .6
	lda.w pflags,x
	pha
	ora.w #$4000
	sta.w pflags,x
	pla
	bit.w #$4000
	beq .6
	lda.w #$0000
	sta.b (a1)
.6:									; pull A, $69 = A, pull A, a1 = A, ...
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
.rtl:								; return
	rtl
PenGoalStuff:						; called from other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($63)
	pei ($65)
	jsl.l CODE_C54BAF
	lda.w gsp
	cmp.w #$0003
	beq .4
	lda.w #$10F9
	sta.b a0
.loop:								; loop: A = (a0), a0 + 1, a0 + 1, A and $00FF, ...
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$00FF
	cmp.w #$0034
	beq .loop
	cmp.w #$0000
	bne .1
	jmp.w .5
.1:									; Y = A, $69 = $00C3, a1 = $4499, A = [a1],y, ...
	tay
	lda.w #$00C3
	sta.b $69
	lda.w #$4499
	sta.b a1
	lda.b [a1],y
	clc
	adc.b a1
	sta.b a1
	lda.b [a1]
	and.w #$00FF
	beq .3
	dec.b a0
	dec.b a0
	lda.w #$0000
	sta.b d0
	lda.b (a0)
	inc.b a0
	inc.b a0
	and.w #$FF00
	cmp.w #$0600
	bcc .2
	lda.w #$0002
	sta.b d0
.2:									; if a2 = d0 go to .loop
	lda.b a2
	cmp.b d0
	beq .loop
.3:									; a0 - 1, a0 - 1, (a0) = $0034, a0 + 1, ...
	dec.b a0
	dec.b a0
	lda.w #$0034
	sta.b (a0)
	inc.b a0
	inc.b a0
	bra .loop
.4:									; call CODE_C4818C
	jsl.l CODE_C4818C
.5:									; Y = a2, A = tmap,y, Y = a1, A - tmap,y, ...
	ldy.b a2
	lda.w tmap,y
	ldy.b a1
	sec
	sbc.w tmap,y
	beq .8
	bmi .8
	lda.b a1
	beq .6
	lda.w #$001A
.6:									; a0 = A
	sta.b a0
.loop2:								; loop: Y = a0, A = tmboxlist,y, a0 + 1, A and $00FF, ...
	ldy.b a0
	lda.w tmboxlist,y
	inc.b a0
	and.w #$00FF
	sta.b d2
	bit.w #$0080
	bne .8
	lda.b a1
	beq .7
	lda.w #$0034
.7:									; A + d2, Y = A, A = tmpdst,y, if a $4000 bit set go to .loop2, ...
	clc
	adc.b d2
	tay
	lda.w tmpdst,y
	bit.w #$4000
	bne .loop2
	lda.w #$0000
	sta.w tmpdst,y
	jsl.l CODE_C45A9F
	ldy.b a1
	lda.w tmap,y
	inc a
	sta.w tmap,y
	jsr.w CODE_C47A7C
	ldy.b a2
	lda.w $125F,y
	inc a
	sta.w $125F,y
	lda.w #$0001
	tsb.w tmflags
	tsb.w $1301
.8:									; pull A, $65 = A, pull A, a0 = A, ...
	pla
	sta.b $65
	pla
	sta.b a0
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
	rtl
CODE_C47A7C:						; from PenGoalStuff
	phx
	tyx
	lda.w teampads,x
	cmp.w #$0004
	bcc .2
	ldy.w $05C0,x
.loop:								; loop: Y + 1, Y + 1, if Y is not $000A go to .1, Y = $0000
	iny
	iny
	cpy.w #$000A
	bne .1
	ldy.w #$0000
.1:									; if $1525,y >= 0 go to .loop, A and $00FF, ...
	lda.w $1525,y
	bpl .loop
	and.w #$00FF
	cmp.b a1
	bne .loop
	sta.w $1525,y
	inc a
	inc a
	lsr a
	sta.w cont1team,y
	ldx.b curobj
	tya
	sta.w playerpad,x
	txa
	sta.w c1playernum,y
.2:									; pull X, return
	plx
	rts
checkint:							; called from other segments
	jsl.l CODE_C47ACD
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	jsl.l CODE_C47ACD
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
CODE_C47ACC:						; from CODE_C47ACD
	rtl
CODE_C47ACD:						; from checkint and other segments
	ldy.b a2
	lda.w position,y
	bne CODE_C47ACC
	lda.w gmclock
	bne CODE_C47ACC
	lda.w puckc
	cmp.b a3
	beq .1
	lda.w $0A00,x
	sec
	sbc.w #$001A
	bmi CODE_C47ACC
.1:									; A = $0A00,x, A - $0003, if the result < 0 go to CODE_C47ACC, X = a2, ...
	lda.w $0A00,x
	sec
	sbc.w #$0003
	bmi CODE_C47ACC
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	jsl.l CODE_C44F20
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	lda.w $0A00,y
	sec
	sbc.w #$001F
	bmi CODE_C47ACC
	lda.w pflags,x
	bit.w #$4000
	bne CODE_C47ACC
	lda.w #$0014
	sec
	sbc.w $0F60,x
	jsl.l randoma8
	cmp.w #$0002
	bcs CODE_C47ACC
	lda.w gmode
	bit.w #$0010
	bne CODE_C47ACC
	lda.w goalieflags,y
	and.w #$0004
	bne CODE_C47ACC
	lda.w #$0026
	sta.b d0
	jmp.w AddPenalty
CODE_C47B3F:						; called from other segments
	lda.w attribute,x
	and.w #$F7FF
	sta.w attribute,x
	lda.w pflags,x
	bit.w #$0002
	bne .1
	jmp.w .3
.1:									; A and $FFFD, pflags,x = A, Y = $0010, if pfteam,x = 0 go to .2, ...
	and.w #$FFFD
	sta.w pflags,x
	ldy.w #$0010
	lda.w pfteam,x
	beq .2
	ldy.w #$0001
.2:									; d0 = Y, A = PBnum, A - d0, PBnum = A, ...
	sty.b d0
	lda.w PBnum
	sec
	sbc.b d0
	sta.w PBnum
	stz.w Xvel,x
	stz.w Yvel,x
	lda.w #$009B
	sta.w Xpos,x
	lda.w #$0002
	sta.w facedir,x
	sta.w pfalock,x
	lda.w #$18EC
	jsl.l SetSPAFromA
	jml.l SprSort
.3:									; facedir,x = $0004, newpnum,x = $FFFF, newpos,x = A, A = pflags,x, ...
	lda.w #$0004
	sta.w facedir,x
	lda.w #$FFFF
	sta.w newpnum,x
	sta.w newpos,x
	lda.w pflags,x
	and.w #$6FF7
	sta.w pflags,x
	stz.w pfnc,x
	lda.w #$F000
	sta.w Xvel,x
	lda.w handed,x
	bne .4
	lda.w attribute,x
	ora.w #$0800
	sta.w attribute,x
.4:									; X = a2, if teampads,x < $0004 go to .6, Y = $05C0,x
	ldx.b a2
	lda.w teampads,x
	cmp.w #$0004
	bcc .6
	ldy.w $05C0,x
.loop:								; loop: Y + 1, Y + 1, if Y is not $000A go to .5, Y = $0000
	iny
	iny
	cpy.w #$000A
	bne .5
	ldy.w #$0000
.5:									; if $1525,y >= 0 go to .loop, A and $00FF, ...
	lda.w $1525,y
	bpl .loop
	and.w #$00FF
	cmp.b a2
	bne .loop
	sta.w $1525,y
	inc a
	inc a
	lsr a
	sta.w cont1team,y
	ldx.b curobj
	tya
	sta.w playerpad,x
	txa
	sta.w c1playernum,y
.6:									; X = curobj, go to assexit
	ldx.b curobj
	jml.l assexit
GetLowestPen:						; from updatepwrplay and other segments
	stz.b d0
	stz.b d3
	lda.b a2
	beq .1
	lda.w #$001A
.1:									; a0 = A
	sta.b a0
.loop:								; loop: Y = a0, a0 + 1, A = tmboxlist,y, A and $00FF, ...
	ldy.b a0
	inc.b a0
	lda.w tmboxlist,y
	and.w #$00FF
	sta.b d2
	bit.w #$0080
	bne .3
	lda.b a2
	beq .2
	lda.w #$0034
.2:									; A + d2, Y = A, d2 = tmpdst,y, if a $4000 bit set go to .loop, ...
	clc
	adc.b d2
	tay
	lda.w tmpdst,y
	sta.b d2
	bit.w #$4000
	bne .loop
	lda.b d2
	sec
	sbc.b d3
	sta.b d2
	clc
	adc.b d0
	sta.b d0
	lda.b d2
	sta.b d3
	bra .loop
.3:									; Y = a3, if tmap,y = $0006 go to .rtl, A = d0, A - d3, ...
	ldy.b a3
	lda.w tmap,y
	cmp.w #$0006
	beq .rtl
	lda.b d0
	sec
	sbc.b d3
	sta.b d0
	lda.b a3
	beq .4
	lda.w #$001A
.4:									; a0 = A
	sta.b a0
.loop2:								; loop: Y = a0, A = tmboxlist,y, a0 + 1, A and $00FF, ...
	ldy.b a0
	lda.w tmboxlist,y
	inc.b a0
	and.w #$00FF
	sta.b d2
	bit.w #$0080
	bne .rtl
	lda.b a3
	beq .5
	lda.w #$0034
.5:									; A + d2, Y = A, A = tmpdst,y, if a $4000 bit set go to .loop2, ...
	clc
	adc.b d2
	tay
	lda.w tmpdst,y
	bit.w #$4000
	bne .loop2
	lda.b d0
	cmp.w tmpdst,y
	bmi .rtl
	lda.b d0
	clc
	adc.b d3
	sta.b d0
.rtl:								; return
	rtl
CODE_C47C8C:						; called from other segments
	ldy.b a2
	lda.w pfalock,x
	bne .rtl
	lda.w position,x
	beq .rtl
	lda.w $186C
	bne .1
	lda.w playerpad,y
	bmi .1
	lda.w #$0010
	clc
	adc.w checking,y
	sec
	sbc.w legstr,x
	jsl.l randoma8
	cmp.w #$000C
	bcc .rtl
.1:									; A = Xpos,x, A - Xpos,y, d0 = A, A = Ypos,x, ...
	lda.w Xpos,x
	sec
	sbc.w Xpos,y
	sta.b d0
	lda.w Ypos,x
	sec
	sbc.w Ypos,y
	sta.b d1
	jsl.l vtoa
	ldy.b a2
	lda.b d0
	sec
	sbc.w facedir,y
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs .rtl
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	jsl.l CODE_C44F20
	jsl.l PenShotChk
	beq .2
	lda.w BA_Sktr_SCnum
	bpl .2
	ldy.b a2
	sty.w BA_Sktr_SCnum
	lda.w playerpad,y
	sta.w $18B6
	lda.w #$0024
	sta.b d0
	jsl.l AddPenalty
	bra .3
.rtl:								; return
	rtl
.2:									; call checkagr, if d0 >= $0005 go to .3, d0 = $0022, call AddPenalty
	jsl.l checkagr
	lda.b d0
	cmp.w #$0005
	bcs .3
	lda.w #$0022
	sta.b d0
	jsl.l AddPenalty
.3:									; X = a2, a2 = a3, a3 = X, collflag = $FFFF, ...
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	lda.w #$FFFF
	sta.w collflag
	rtl
asspenalty:							; called from other segments
	lda.w pflags,x
	bit.w #$0002
	bne .1
	jmp.w .2
.1:									; call CODE_C47E65, A = pflags,x, A and $FFF9, A or $1000, ...
	jsl.l CODE_C47E65
	lda.w pflags,x
	and.w #$FFF9
	ora.w #$1000
	sta.w pflags,x
	stz.b d4
	jsl.l setpads
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
	jsl.l PenBoxSpot
	lda.b r2
	sta.b d1
	sta.w temp4,x
	lda.w #$009B
	sta.w temp3,x
	stz.w temp1,x
	lda.w pflags,x
	ora.w #$8000
	sta.w pflags,x
	stz.w Wallcos,x
	stz.w Wallsin,x
	lda.w #$0384
	sta.w temp5,x
.2:									; A = temp5,x, A - timestep, temp5,x = A, if plus go to .4, ...
	lda.w temp5,x
	sec
	sbc.w timestep
	sta.w temp5,x
	bpl .4
	jmp.w .8
.rtl:								; return
	rtl
.3:									; d0 = temp3,x, d1 = temp4,x, $65 = $00C4, a0 = $883F, ...
	lda.w temp3,x
	sta.b d0
	lda.w temp4,x
	sta.b d1
	lda.w #$00C4
	sta.b $65
	lda.w #$883F
	sta.b a0
	jml.l skateto
.4:									; A = Ypos,x, A - temp4,x, if A - $FFF3 < 0 go to .3, ...
	lda.w Ypos,x
	sec
	sbc.w temp4,x
	cmp.w #$FFF3
	bmi .3
	cmp.w #$000D
	bpl .3
	lda.w Xpos,x
	sec
	sbc.w temp3,x
	sta.b d0
	sec
	sbc.w #$FFE8
	bmi .3
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl .rtl
	adc.w #$0008
	sta.w temp1,x
	cpx.w puckc
	bne .5
	lda.w #$FFFF
	sta.w puckc
	lda.w #$003C
	sta.w nopuck,x
.5:									; pfnc,x = $1958, call SetSPAFromA, d2 = $0006, ...
	lda.w #$1958
	sta.w pfnc,x
	jsl.l SetSPAFromA
	lda.w #$0006
	sta.b d2
	lda.w handed,x
	beq .6
	lda.w #$0002
	sta.b d2
.6:									; if facedir,x = d2 go to .7, A + 1, A and $0007, facedir,x = A
	lda.w facedir,x
	cmp.b d2
	beq .7
	inc a
	and.w #$0007
	sta.w facedir,x
.7:									; Yvel,x = 0, Xvel,x = $1000, A = d0, A - $FFF8, ...
	stz.w Yvel,x
	lda.w #$1000
	sta.w Xvel,x
	lda.b d0
	sec
	sbc.w #$FFF8
	bmi CODE_C47E64
	stz.w Xvel,x
	lda.w facedir,x
	cmp.b d2
	bne CODE_C47E64
.8:									; Ypos,x = temp4,x, Xpos,x = $009B, A = attribute,x, A and $F7FF, ...
	lda.w temp4,x
	sta.w Ypos,x
	lda.w #$009B
	sta.w Xpos,x
	lda.w attribute,x
	and.w #$F7FF
	sta.w attribute,x
	lda.w #$0002
	sta.w facedir,x
	sta.w pfalock,x
	lda.w #$18BE
	jsl.l SetSPAFromA
	lda.w pflags,x
	and.w #$BFFF
	sta.w pflags,x
	lda.w #$000E
	sta.b d0
	jml.l assreplace
CODE_C47E64:						; from CODE_C47E65, asspenalty
	rtl
CODE_C47E65:						; from asspenalty and other segments
	ldy.b a2
	lda.w teampads,y
	cmp.w #$0004
	bcc .2
	sta.b d1
	lda.w #$0006
	sta.b d0
	lda.w tmsort,y
	tax
	ldy.w #$0000
.loop:								; loop: if position,x < 0 go to .1, if zero go to .1, Y + 1
	lda.w position,x
	bmi .1
	beq .1
	iny
.1:									; X + 1, X + 1, d0 - 1, if the result is not 0 go to .loop, ...
	inx
	inx
	dec.b d0
	bne .loop
	cpy.b d1
	beq .4
	bcc .4
.2:									; X = curobj, if playerpad,x >= 0 go to .3, go to CODE_C47E64
	ldx.b curobj
	lda.w playerpad,x
	bpl .3
	jmp.w CODE_C47E64
.3:									; d4 = A, call PassPadToTeammate, return
	sta.b d4
	jsl.l PassPadToTeammate
	rtl
.4:									; if Y is not $0003 go to .6, X = a2, Y = $05C0,x
	cpy.w #$0003
	bne .6
	ldx.b a2
	ldy.w $05C0,x
.loop2:								; loop: Y + 1, Y + 1, if Y is not $000A go to .5, Y = $0000
	iny
	iny
	cpy.w #$000A
	bne .5
	ldy.w #$0000
.5:									; if $1525,y >= 0 go to .loop2, A and $00FF, ...
	lda.w $1525,y
	bpl .loop2
	and.w #$00FF
	cmp.b a2
	bne .loop2
	sta.w $1525,y
	inc a
	inc a
	lsr a
	sta.w cont1team,y
.6:									; X = a2, Y = $05C0,x, go to .7
	ldx.b a2
	ldy.w $05C0,x
	bra .7
.loop3:								; loop: Y + 1, Y + 1, if Y is not $000A go to .7, Y = $0000
	iny
	iny
	cpy.w #$000A
	bne .7
	ldy.w #$0000
.7:									; if $1525,y is not a2 go to .loop3, A or $FF00, $1525,y = A, ...
	lda.w $1525,y
	cmp.b a2
	bne .loop3
	ora.w #$FF00
	sta.w $1525,y
	lda.w #$0000
	sta.w cont1team,y
	phy
	iny
	iny
	cpy.w #$000A
	bne .8
	ldy.w #$0000
.8:									; A = Y, $05C0,x = A, pull Y, X = c1playernum,y, ...
	tya
	sta.w $05C0,x
	ply
	ldx.w c1playernum,y
	lda.w #$FFFF
	sta.w c1playernum,y
	sta.w playerpad,x
	jmp.w .2
PenBoxSpot:							; from SeatPenaltyBox, asspenalty and other segments
	lda.w #$000B
	sta.b d0
	lda.w PBnum
	sta.b d1
	lda.w pfteam,x
	bne .1
	lda.b d1
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b d1
	lda.w #$FFF5
	sta.b d0
.1:									; A = d1, A and $000F, d1 = A, if A < $0003 go to .2, ...
	lda.b d1
	and.w #$000F
	sta.b d1
	cmp.w #$0003
	bcc .2
	lda.w #$0002
	sta.b d1
.2:									; d1 + 1, d1 + 1, d1 + 1, push X, ...
	inc.b d1
	inc.b d1
	inc.b d1
	phx
	lda.b d0
	ldx.b d1
	jsl.l Mul16S
	plx
	rtl
assdopen:							; from SeatPenaltyBox and other segments
	lda.w #$0010
	sta.b d0
	lda.w pfteam,x
	beq .1
	lda.w #$0001
	sta.b d0
.1:									; A = PBnum, A + d0, PBnum = A, position,x = $FFFF, ...
	lda.w PBnum
	clc
	adc.b d0
	sta.w PBnum
	lda.w #$FFFF
	sta.w position,x
	lda.w attribute,x
	and.w #$F7FF
	sta.w attribute,x
	lda.w #$02A4
	sta.w frame,x
	rtl
SeatPenaltyBox:						; from chkprogress and other segments
	lda.w $1864
	cmp.w #$0001
	beq .rtl
	lda.w penshot
	ora.w PenShotActive
	ora.w $189C
	bne .rtl
	phx
	stz.w PBnum
	ldx.w #$0000
.loop:								; loop: if position,x >= 0 go to .1, call PenBoxSpot, Ypos,x = r2, ...
	lda.w position,x
	bpl .1
	jsl.l PenBoxSpot
	lda.b r2
	sta.w Ypos,x
	lda.w #$009B
	sta.w Xpos,x
	jsl.l assdopen
.1:									; X + 1, X + 1, if X < $0018 go to .loop, pull X
	inx
	inx
	cpx.w #$0018
	bcc .loop
	plx
.rtl:								; return
	rtl

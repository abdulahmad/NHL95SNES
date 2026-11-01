; Segment bankC5_4000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C53FE5
CODE_C53FE5:						; called from other segments
	ldy.b a2
	lda.w tmflags,y
	and.w #$FFEF
	sta.w tmflags,y
	lda.w #$0005
	sta.b d2
	ldx.w tmsort,y
	stx.b a3
.1:									; if handed,x = 0 go to .2, A = attribute,x, A and $F7FF, attribute,x = A
	lda.w handed,x
	beq .2
	lda.w attribute,x
	and.w #$F7FF
	sta.w attribute,x
.2:									; pf2aip,x = 0, A = pflags,x, A and $2FFF, pflags,x = A, ...
	stz.w pf2aip,x
	lda.w pflags,x
	and.w #$2FFF
	sta.w pflags,x
	lda.w position,x
	bmi .5
	bne .3
	lda.w #$121E
	bra .4
.3:									; A = $1958
	lda.w #$1958
.4:									; call SetSPAFromA, $0A00,x = 0, nopuck,x = 0, A = pflags,x, ...
	jsl.l SetSPAFromA
	stz.w $0A00,x
	stz.w nopuck,x
	lda.w pflags,x
	and.w #$FFF6
	sta.w pflags,x
	stz.w pfnc,x
	stz.w pfrev,x
	stz.w pfalock,x
.5:									; a3 + 1, a3 + 1, X = a3, d2 - 1, ...
	inc.b a3
	inc.b a3
	ldx.b a3
	dec.b d2
	bpl .1
	rtl
CODE_C5404A:						; called from other segments
	lda.w $186E
	cmp.w #$0001
	bne .rtl
	jsl.l loadTeamStruct
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0008
	bne .rtl
	ora.w #$0008
	sta.w tmflags,y
	lda.w #$000C
	trb.w sflags
	jmp.w CODE_C54070
.rtl:								; return
	rtl
CODE_C54070:						; from CODE_C5404A, lineinput and other segments
	phx
	jsr.w CODE_C54114
	sta.b d0
	sty.b $81
	jsl.l CODE_C58C36
	lda.b a2
	jsr.w CODE_C56104
	jsl.l CODE_C4C3AE
	jsr.w CODE_C56262
	lda.b d0
	clc
	adc.w #$0027
	tay
	txa
	ldx.w #$007E
	jsl.l QueueVRAMDMALen
	lda.b $81
	dec a
	asl a
	asl a
	asl a
	asl a
	asl a
	sec
	adc.b d0
	sta.b d0
	lda.w #$0002
.loop:								; loop: $81 = A, call CODE_C54155, X = A, if the result < 0 go to .3, ...
	sta.b $81
	jsr.w CODE_C54155
	tax
	bmi .3
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0008
	bne .1
	lda.b $81
	cmp.w $1307,y
	bne .2
	ldx.w tmline,y
.1:									; push X, A = $0006, call CODE_C4C561, Y = A, ...
	phx
	lda.w #$0006
	jsl.l CODE_C4C561
	tay
	lda.w #$0005
	sta.w $0000,y
	lda.b $81
	asl a
	tax
	lda.l DATA8_C5410E,x
	sta.w $0001,y
	lda.b $01,s
	asl a
	adc.b $01,s
	tax
	lda.l DATA8_C09B3F,x
	sta.w $0003,y
	lda.l $C09B40,x
	sta.w $0004,y
	tya
	ldx.w #$007E
	ldy.b d0
	jsl.l QueueVRAMDMALen
	pla
	jsr.w CODE_C54D03
.2:									; A = d0, A - $0020, d0 = A
	lda.b d0
	sec
	sbc.w #$0020
	sta.b d0
.3:									; A = $81, A - 1, if the result >= 0 go to .loop, pull X, ...
	lda.b $81
	dec a
	bpl .loop
	plx
	rtl
DATA8_C5410E:						; not traced: a table read by CODE_C54070
	db $D9,$A0,$C2,$A0,$C1,$A0
CODE_C54114:						; from CODE_C54070, CODE_C54B60
	lda.w gmode
	ldx.b a2
	beq CODE_C54130
	bit.w #$0002
	beq CODE_C54135
CODE_C54120:						; not traced: data between routines
	db $A0,$B5
CODE_C54122:						; called from other segments
	phy
	lda.w tmap
	cmp.w $12C9
	beq CODE_C54140
	ldy.w #$5AD5
	bra CODE_C54140
CODE_C54130:						; from CODE_C54114
	bit.w #$0002
	beq CODE_C54120
CODE_C54135:						; from CODE_C54114
	ldy.w #$5855
	lda.w $18AA
	beq CODE_C54140
	ldy.w #$5995
CODE_C54140:						; from CODE_C54122, CODE_C54135
	phy
	lda.w #$0002
	jsr.w CODE_C54155
	ldy.w #$0005
	cmp.w #$FFFF
	bne .1
	dey
.1:									; X = $000B, pull A, return
	ldx.w #$000B
	pla
	rts
CODE_C54155:						; from CODE_C54070, lcfound, CODE_C54140
	phx
	pha
	lda.b a2
	tax
	eor.w #$0002
	tay
	lda.w tmap,y
	sec
	sbc.w tmap,x
	beq .2
	bmi .1
	lda.w #$002A
	bra .2
.1:									; A = $0015
	lda.w #$0015
.2:									; A + $01,s, $01,s = A, Y = a2, A = tmline,y, ...
	clc
	adc.b $01,s
	sta.b $01,s
	ldy.b a2
	lda.w tmline,y
	asl a
	adc.w tmline,y
	adc.b $01,s
	tax
	ply
	lda.l DATA8_C54194,x
	plx
	and.w #$00FF
	bit.w #$0080
	beq .rts
	ora.w #$FF00
.rts:								; return
	rts
DATA8_C54194:						; not traced: a table read by CODE_C54155
	db $00,$01,$02,$01,$02,$00,$02,$00,$01,$00,$01,$02,$00,$01,$02,$00
	db $01,$02,$00,$01,$02,$03,$04,$FF,$03,$04,$FF,$03,$04,$FF,$03,$04
	db $FF,$04,$03,$FF,$03,$04,$FF,$03,$04,$FF,$05,$06,$FF,$05,$06,$FF
	db $05,$06,$FF,$05,$06,$FF,$05,$06,$FF,$05,$06,$FF,$06,$05,$FF
setpersonel:						; from CODE_C5492E, lcfound and other segments
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
	ldy.b a2
	ldx.w tmsort,y
	stx.b a3
	lda.w #$0005
	sta.b d4
.loop:								; loop: newpos,x = $FFFF, newpnum,x = A, X + 1, X + 1, ...
	lda.w #$FFFF
	sta.w newpos,x
	sta.w newpnum,x
	inx
	inx
	stx.b a3
	dec.b d4
	bpl .loop
	jsl.l SetPlList
	lda.w #$0005
	sta.b d4
	lda.w #$007E
	sta.b $75
	lda.w #$2008
	sta.b a4
.1:									; Y = d4, A = [a4],y, A and $00FF, d5 = A, ...
	ldy.b d4
	lda.b [a4],y
	and.w #$00FF
	sta.b d5
	beq .5
	dec.b d5
	lda.w #$0005
	sta.b d3
	ldy.b a2
	ldx.w tmsort,y
	dex
	dex
.loop2:								; loop: X + 1, X + 1, a3 = X, A = pnum,x, ...
	inx
	inx
	stx.b a3
	lda.w pnum,x
	and.w #$00FF
	sta.b tmp0
	lda.b d5
	and.w #$00FF
	cmp.b tmp0
	beq .2
	dec.b d3
	bpl .loop2
	bra .5
.2:									; A = d4, A + $0006, Y = A, A = [a4],y, ...
	lda.b d4
	clc
	adc.w #$0006
	tay
	lda.b [a4],y
	and.w #$00FF
	bit.w #$0080
	beq .3
	ora.w #$FF00
.3:									; newpos,x = A, A = d5, A and $00FF, if $0080 bits clear go to .4, ...
	sta.w newpos,x
	lda.b d5
	and.w #$00FF
	bit.w #$0080
	beq .4
	ora.w #$FF00
.4:									; newpnum,x = A, Y = d4, A 8-bit, [a4],y = $00, ...
	sta.w newpnum,x
	ldy.b d4
	sep #$20
	lda.b #$00
	sta.b [a4],y
	rep #$20
.5:									; d4 - 1, if the result >= 0 go to .1, d4 = $0005, $75 = $007E, ...
	dec.b d4
	bpl .1
	lda.w #$0005
	sta.b d4
	lda.w #$007E
	sta.b $75
	lda.w #$2008
	sta.b a4
.6:									; Y = d4, A = [a4],y, A and $00FF, d5 = A, ...
	ldy.b d4
	lda.b [a4],y
	and.w #$00FF
	sta.b d5
	beq .12
	dec.b d5
	lda.w #$0005
	sta.b d3
	ldy.b a2
	ldx.w tmsort,y
	dex
	dex
.loop3:								; loop: X + 1, X + 1, a3 = X, A = newpnum,x, ...
	inx
	inx
	stx.b a3
	lda.w newpnum,x
	bit.w #$0080
	bne .7
	dec.b d3
	bpl .loop3
	bra .8
.7:									; a0 = X
	stx.b a0
.8:									; if position,x >= 0 go to .9, d3 - 1, if the result >= 0 go to .loop3
	lda.w position,x
	bpl .9
	dec.b d3
	bpl .loop3
.9:									; A = d4, A + $0006, Y = A, A = [a4],y, ...
	lda.b d4
	clc
	adc.w #$0006
	tay
	lda.b [a4],y
	and.w #$00FF
	bit.w #$0080
	beq .10
	ora.w #$FF00
.10:								; Y = a0, newpos,y = A, A = d5, A and $00FF, ...
	ldy.b a0
	sta.w newpos,y
	lda.b d5
	and.w #$00FF
	bit.w #$0080
	beq .11
	ora.w #$FF00
.11:								; newpnum,y = A, Y = d4, A 8-bit, [a4],y = $00, ...
	sta.w newpnum,y
	ldy.b d4
	sep #$20
	lda.b #$00
	sta.b [a4],y
	rep #$20
.12:								; d4 - 1, if the result >= 0 go to .6, pull A, $75 = A, ...
	dec.b d4
	bpl .6
	pla
	sta.b $75
	pla
	sta.b a4
	pla
	sta.b $71
	pla
	sta.b a3
CODE_C54320:						; called from other segments
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
SetPlList:							; from setpersonel and other segments
	lda.w #$007E
	sta.b $75
	lda.w #$2008
	sta.b a4
	stz.w $2008
	stz.w $200A
	stz.w $200C
	lda.w #$00C0
	sta.b $65
	lda.w #$9B2A
	sta.b a0
	lda.w $1864
	cmp.w #$0001
	bne .1
	lda.w #$00C0
	sta.b $65
	lda.w #$9B38
	sta.b a0
	bra .3
.1:									; if penshot = 0 go to .2, $65 = $00C0, a0 = $9B31, ...
	lda.w penshot
	beq .2
	lda.w #$00C0
	sta.b $65
	lda.w #$9B31
	sta.b a0
	lda.b a2
	cmp.w BA_Team
	bne .3
	inc.b a0
	bra .3
.2:									; Y = a2, if tmgoalie,y >= 0 go to .3, a0 + 1
	ldy.b a2
	lda.w tmgoalie,y
	bpl .3
	inc.b a0
.3:									; call GetTeamLines, $69 = $71, a1 = a3, pull A, ...
	pei ($71)
	pei ($6F)
	jsl.l GetTeamLines
	lda.b $71
	sta.b $69
	lda.b a3
	sta.b a1
	pla
	sta.b a3
	pla
	sta.b $71
	ldy.b a2
	lda.w tmline,y
	asl a
	asl a
	asl a
	sta.b d0
	adc.b a1
	sta.b a1
	lda.w tmap,y
	sta.b d4
	bra .7
.loop:								; loop: Y = d4, A = [a0],y, A and $00FF, d5 = A, ...
	ldy.b d4
	lda.b [a0],y
	and.w #$00FF
	sta.b d5
	tay
	sep #$20
	lda.b [a1],y
	ldy.b d4
	sta.b [a4],y
	lda.b d5
	beq .4
	lda.w penshot
	beq .4
	lda.w $18B2
	inc a
	sta.b [a4],y
.4:									; Y + 1, Y + 1, Y + 1, Y + 1, ...
	iny
	iny
	iny
	iny
	iny
	iny
	lda.b d5
	sta.b [a4],y
	rep #$20
	lda.b d5
	bne .7
	ldy.b a2
	lda.w tmgoalie,y
	inc a
	sta.b d3
	bne .6
	lda.w $1864
	cmp.w #$0001
	beq .5
	lda.w penshot
	beq .6
.5:									; d3 + 1
	inc.b d3
.6:									; Y = d4, A 8-bit, [a4],y = d3, A 16-bit
	ldy.b d4
	sep #$20
	lda.b d3
	sta.b [a4],y
	rep #$20
.7:									; d4 - 1, if the result >= 0 go to .loop, d4 = $0005
	dec.b d4
	bpl .loop
	lda.w #$0005
	sta.b d4
.8:									; Y = d4, A = [a4],y, A and $00FF, d3 = A, ...
	ldy.b d4
	lda.b [a4],y
	and.w #$00FF
	sta.b d3
	bne .9
	jmp.w .13
.9:									; A and $00FF, if $0080 bits clear go to .10, A or $FF00
	and.w #$00FF
	bit.w #$0080
	beq .10
	ora.w #$FF00
.10:								; A - 1, A * 2, d3 = A, if a2 = 0 go to .11, ...
	dec a
	asl a
	sta.b d3
	lda.b a2
	beq .11
	lda.w #$0034
.11:								; A + d3, Y = A, if tmpdst,y = $FFFD go to .12, ...
	clc
	adc.b d3
	tay
	lda.w tmpdst,y
	cmp.w #$FFFD
	beq .12
	cmp.w #$FFFC
	beq .12
	lda.w tmpdst,y
	bmi .13
	beq .13
.12:								; call GetTeamLines, $69 = $71, a1 = a3, pull A, ...
	pei ($71)
	pei ($6F)
	jsl.l GetTeamLines
	lda.b $71
	sta.b $69
	lda.b a3
	sta.b a1
	pla
	sta.b a3
	pla
	sta.b $71
	lda.b d4
	clc
	adc.w #$0006
	tay
	lda.b [a4],y
	and.w #$00FF
	asl a
	sta.b d0
	lda.w #$00C0
	sta.b $65
	lda.w #$9AC0
	sta.b a0
	ldy.b d0
	lda.b [a0],y
	clc
	adc.b a0
	sta.b a0
.loop2:								; loop: A = [a0], a0 + 1, A and $00FF, d0 = A, ...
	lda.b [a0]
	inc.b a0
	and.w #$00FF
	sta.b d0
	bit.w #$0080
	bne .14
	ldy.b d0
	lda.b [a1],y
	and.w #$00FF
	sta.b d0
	jsl.l TryAddPlayerToList
	beq .loop2
.13:								; d4 - 1, if the result < 0 go to .rtl, go to .8
	dec.b d4
	bmi .rtl
	jmp.w .8
.rtl:								; return
	rtl
.14:								; call CODE_C5362E, d3 = d0
	jsl.l CODE_C5362E
	lda.b d0
	sta.b d3
.loop3:								; loop: d0 = d3, d3 - 1, if the result < 0 go to .13, ...
	lda.b d3
	sta.b d0
	dec.b d3
	bmi .13
	jsl.l TryAddPlayerToList
	beq .loop3
	bra .13
TryAddPlayerToList:					; from SetPlList and other segments
	lda.b d0
	sta.b d1
	dec.b d0
	asl.b d0
	lda.b a2
	beq .1
	lda.w #$0034
.1:									; A + d0, Y = A, A = tmpdst,y, A - $0000, ...
	adc.b d0
	tay
	lda.w tmpdst,y
	sec
	sbc.w #$0000
	beq .2
	bpl .3
.2:									; if tmpdst,y = $FFFD go to .3, if tmpdst,y = $FFFC go to .3, d0 = $0005
	lda.w tmpdst,y
	cmp.w #$FFFD
	beq .3
	cmp.w #$FFFC
	beq .3
	lda.w #$0005
	sta.b d0
.loop:								; loop: Y = d0, A = [a4],y, A and $00FF, tmp0 = A, ...
	ldy.b d0
	lda.b [a4],y
	and.w #$00FF
	sta.b tmp0
	lda.b d1
	and.w #$00FF
	cmp.b tmp0
	beq .3
	dec.b d0
	bpl .loop
	ldy.b d4
	sep #$20
	lda.b d1
	sta.b [a4],y
	rep #$20
	lda.b d1
	and.w #$00FF
	rtl
.3:									; d1 = $0000, return
	lda.w #$0000
	sta.b d1
	rtl
lineinput:							; called from other segments
	pei ($83)
	stz.b a2
	lda.w pfteam,x
	beq .1
	inc.b a2
	inc.b a2
.1:									; Y = a2, A = tmflags,y, if $0001 bits clear go to .2, A and $FFFE, ...
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0001
	beq .2
	and.w #$FFFE
	sta.w tmflags,y
	lda.w #$FFFF
	sta.w lcpad,y
	jsl.l CODE_C54070
.2:									; pull A, d1 = A, d2 = 0, if a $4000 bit set go to .4, ...
	pla
	sta.b d1
	stz.b d2
	bit.w #$4000
	bne .4
	inc.b d2
	bit.w #$8000
	bne .4
	inc.b d2
	bit.w #$0080
	bne .4
	bit.w #$2000
	bne .3
	lda.w pflags,x
	bit.w #$0008
	beq .rtl
	lda.w pfalock,x
	bne .rtl
	jml.l doplayeracc
.rtl:								; return
	rtl
.3:									; A = pflags,x, A or $0008, pflags,x = A, call loadTeamStruct, ...
	lda.w pflags,x
	ora.w #$0008
	sta.w pflags,x
	jsl.l loadTeamStruct
	ldy.b a2
	lda.w tmflags,y
	and.w #$FFF7
	sta.w tmflags,y
	lda.w #$FFFF
	sta.w lcpad,y
	jmp.w CODE_C54B60
.4:									; call lcfound, if minus go to .rtl2, if gmclock is not 0 go to .rtl2, ...
	jsl.l lcfound
	bmi .rtl2
	lda.w gmclock
	bne .rtl2
	jmp.w CODE_C54B60
.rtl2:								; return
	rtl
assbench:							; asstab entry 12: an assignment routine
	lda.w temp1,x
	cmp.w #$0064
	bne .1
	jmp.w .14
.1:									; call check4bench, A = pflags,x, if $4000 bits clear go to .2, ...
	jsl.l check4bench
	lda.w pflags,x
	bit.w #$4000
	beq .2
	jml.l assexit
.2:									; if $0002 bits clear go to .4, A and $FFFD, pflags,x = A, ...
	bit.w #$0002
	beq .4
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
	lda.w #$0050
	sta.b d0
	lda.w pfteam,x
	bne .3
	lda.w #$FFB0
	sta.b d0
.3:									; temp4,x = d0, temp3,x = $FF5D, temp1,x = 0
	lda.b d0
	sta.w temp4,x
	lda.w #$FF5D
	sta.w temp3,x
	stz.w temp1,x
.4:									; if newpnum,x is not pnum,x go to .5, go to .18
	lda.w newpnum,x
	cmp.w pnum,x
	bne .5
	jmp.w .18
.5:									; if position,x is not 0 go to .6, A = goalieflags,x, A or $0003, ...
	lda.w position,x
	bne .6
	lda.w goalieflags,x
	ora.w #$0003
	sta.w goalieflags,x
.6:									; A = temp1,x, A - d7, temp1,x = A, if minus go to .7, ...
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bmi .7
	jmp.w .17
.7:									; A = temp1,x, A + $0008, temp1,x = A, A = Ypos,x, ...
	lda.w temp1,x
	adc.w #$0008
	sta.w temp1,x
	lda.w Ypos,x
	sec
	sbc.w temp4,x
	bit.w #$8000
	beq .8
	eor.w #$FFFF
	inc a
.8:									; if A < $0029 go to .9, go to .17
	cmp.w #$0029
	bcc .9
	jmp.w .17
.9:									; A = Xpos,x, A - temp3,x, d0 = A, A - $0020, ...
	lda.w Xpos,x
	sec
	sbc.w temp3,x
	sta.b d0
	sec
	sbc.w #$0020
	beq .10
	bmi .10
	jmp.w .17
.10:								; A = $1958, if position,x is not 0 go to .11, A = $121E
	lda.w #$1958
	ldy.w position,x
	bne .11
	lda.w #$121E
.11:								; call SetSPAFromA, pfnc,x = $0001, if facedir,x = $0004 go to .12, ...
	jsl.l SetSPAFromA
	lda.w #$0001
	sta.w pfnc,x
	lda.w facedir,x
	cmp.w #$0004
	beq .12
	inc a
	and.w #$0007
	sta.w facedir,x
.12:								; Yvel,x = 0, Xvel,x = $F800, A = d0, A - $0010, ...
	stz.w Yvel,x
	lda.w #$F800
	sta.w Xvel,x
	lda.b d0
	sec
	sbc.w #$0010
	beq .13
	bpl .rtl
.13:								; Xvel,x = 0, if facedir,x is not $0004 go to .rtl, Xpos,x = $FF65, ...
	stz.w Xvel,x
	lda.w facedir,x
	cmp.w #$0004
	bne .rtl
	lda.w #$FF65
	sta.w Xpos,x
	lda.w #$0002
	sta.w facedir,x
	lda.w attribute,x
	ora.w #$0800
	sta.w attribute,x
	lda.w #$18BE
	jsl.l SetSPAFromA
	lda.w #$0064
	sta.w temp1,x
	sta.w pfalock,x
.rtl:								; return
	rtl
.14:								; A = pnum,x, A * 2, d0 = A, a0 = 0, ...
	lda.w pnum,x
	asl a
	sta.b d0
	stz.b a0
	lda.w pfteam,x
	beq .15
	lda.w #$0002
	sta.b a0
.15:								; if a0 = 0 go to .16, A = $0034
	lda.b a0
	beq .16
	lda.w #$0034
.16:								; A + d0, Y = A, tmpdst,y = $FFFE, d3 = newpnum,x, ...
	clc
	adc.b d0
	tay
	lda.w #$FFFE
	sta.w tmpdst,y
	lda.w newpnum,x
	sta.b d3
	jsl.l CODE_C54734
	jmp.w setplayer
.17:								; if pfnc,x is not 0 go to .rtl, A = pflags,x, ...
	lda.w pfnc,x
	bne .rtl
	lda.w pflags,x
	bit.w #$4008
	bne .rtl
	lda.w temp3,x
	sta.b d0
	lda.w temp4,x
	sta.b d1
	lda.w #$00C4
	sta.b $65
	lda.w #$342A
	sta.b a0
	jml.l skateto
.18:								; A = pflags,x, A and $EFFF, pflags,x = A
	lda.w pflags,x
	and.w #$EFFF
	sta.w pflags,x
CODE_C54734:						; from assbench and other segments
	lda.w newpos,x
	sta.b d0
	sta.w position,x
	jsl.l Setplass
	lda.w #$FFFF
	sta.w newpnum,x
	sta.w newpos,x
	rtl
asseben:							; asstab entry 10: an assignment routine
	lda.w pfalock,x
	bne .rtl
	lda.w pflags,x
	bit.w #$0002
	beq .2
	and.w #$FFFD
	sta.w pflags,x
	stz.w Xvel,x
	stz.w Yvel,x
	stz.w goalieflags,x
	txa
	lsr a
	sec
	sbc.w #$0006
	bmi .1
	inc a
.1:									; push X, X = A, A = $000E, call Mul16x8XS, ...
	phx
	tax
	lda.w #$000E
	jsl.l Mul16x8XS
	plx
	lda.b r2
	sta.w Ypos,x
	lda.w attribute,x
	ora.w #$0800
	sta.w attribute,x
	lda.w #$FF65
	sta.w Xpos,x
	lda.w #$0002
	sta.w facedir,x
	sta.w pfalock,x
	lda.w #$18EC
	jml.l SetSPAUpdate
.rtl:								; return
	rtl
.2:									; facedir,x = $0004, A = pflags,x, A and $6FFF, pflags,x = A, ...
	lda.w #$0004
	sta.w facedir,x
	lda.w pflags,x
	and.w #$6FFF
	sta.w pflags,x
	stz.w pfnc,x
	stz.w SPA,x
	lda.w #$1000
	sta.w Xvel,x
	lda.w handed,x
	beq .3
	lda.w attribute,x
	and.w #$F7FF
	sta.w attribute,x
.3:									; go to assexit
	jml.l assexit
CompLine:							; from CODE_C5492E and other segments
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($63)
	pei ($65)
	lda.w #$0003
	sta.b d0
	ldy.b a2
	lda.w tmap,y
	ldy.b a1
	cmp.w tmap,y
	beq CODE_C54828
	bpl .1
	inc.b d0
	inc.b d0
.1:									; A = d0, push A, A + 1, call CODE_C54CB9, ...
	lda.b d0
	pha
	inc a
	jsr.w CODE_C54CB9
	sta.b d1
	lda.b $01,s
	jsr.w CODE_C54CB9
	sec
	sbc.b d0
	bpl .2
	pla
	inc a
	bra .3
.2:									; pull A
	pla
.3:									; Y = a2, tmline,y = A
	ldy.b a2
	sta.w tmline,y
CODE_C5480F:						; from CODE_C548C1, CODE_C54828
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
CODE_C54828:						; from CompLine
	ldy.b a2
	beq .1
	jmp.w CODE_C548C1
.1:									; if $186E is not $0002 go to .2, if c1playernum,y < 0 go to .2, ...
	lda.w $186E
	cmp.w #$0002
	bne .2
	lda.w c1playernum,y
	bmi .2
	jmp.w CODE_C548C1
.2:									; d1 = $0002, $65 = $00C5, a0 = $4897, if gsp is not $0002 go to .3, ...
	lda.w #$0002
	sta.b d1
	lda.w #$00C5
	sta.b $65
	lda.w #$4897
	sta.b a0
	lda.w gsp
	cmp.w #$0002
	bne .3
	lda.w tmscore,y
	ldy.b a1
	cmp.w tmscore,y
	beq .3
	php
	lda.w #$00C5
	sta.b $65
	lda.w #$48A5
	sta.b a0
	plp
	bpl .3
	lda.w #$00C5
	sta.b $65
	lda.w #$48B3
	sta.b a0
.3:									; Y = a1, A = tmline,y, A * 2, d1 = A, ...
	ldy.b a1
	lda.w tmline,y
	asl a
	sta.b d1
	tay
	lda.b [a0],y
	jsr.w CODE_C54CB9
	cmp.w #$0C01
	bcc CODE_C548C1
	ldy.b d1
	lda.b [a0],y
	ldy.b a2
	sta.w tmline,y
	jmp.w CODE_C5480F
DATA8_C54897:						; not traced: data between routines
	db $00,$00,$01,$00,$02,$00,$00,$00,$01,$00,$00,$00,$01,$00,$02,$00
	db $00,$00,$01,$00,$02,$00,$00,$00,$02,$00,$00,$00,$00,$00,$01,$00
	db $00,$00,$00,$00,$01,$00,$00,$00,$01,$00
CODE_C548C1:						; from CODE_C54828
	lda.w #$0002
	sta.b d1
	lda.w #$00C5
	sta.b $65
	lda.w #$491C
	sta.b a0
	lda.w gsp
	cmp.w #$0002
	bne .loop
	ldy.b a2
	lda.w tmscore,y
	ldy.b a1
	cmp.w tmscore,y
	beq .loop
	php
	lda.w #$00C5
	sta.b $65
	lda.w #$4922
	sta.b a0
	plp
	bpl .loop
	lda.w #$00C5
	sta.b $65
	lda.w #$4928
	sta.b a0
.loop:								; loop: A = [a0], a0 + 1, a0 + 1, call CODE_C54CB9, ...
	lda.b [a0]
	inc.b a0
	inc.b a0
	jsr.w CODE_C54CB9
	cmp.w #$0F34
	bcs .1
	dec.b d1
	bpl .loop
.1:									; a0 - 1, a0 - 1, Y = a2, tmline,y = [a0], ...
	dec.b a0
	dec.b a0
	ldy.b a2
	lda.b [a0]
	sta.w tmline,y
	jmp.w CODE_C5480F
DATA8_C5491C:						; not traced: data between routines
	db $00,$00,$01,$00,$02,$00,$00,$00,$02,$00,$01,$00,$00,$00,$01,$00
	db $00,$00
CODE_C5492E:						; called from other segments
	lda.w $186E
	cmp.w #$0002
	beq .rtl
	lda.w pucky
	sta.b d0
	lda.w pfgoal,x
	bne .1
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.1:									; if d0 < 0 go to .rtl, A - $005C, if the result >= 0 go to .rtl, ...
	lda.b d0
	bmi .rtl
	sec
	sbc.w #$005C
	bpl .rtl
	lda.w seed
	and.w #$0003
	bne .rtl
	phy
	ldy.w #$0000
	lda.w pfteam,x
	beq .2
	ldy.w #$0002
.2:									; A = tmflags,y, pull Y, if a $0008 bit set go to .rtl, a2 = 0, ...
	lda.w tmflags,y
	ply
	bit.w #$0008
	bne .rtl
	stz.b a2
	lda.w #$0002
	sta.b a1
	lda.w pfteam,x
	beq .3
	stz.b a1
	lda.w #$0002
	sta.b a2
.3:									; call AvgCline, if d0 >= $0C01 go to .rtl, ...
	jsl.l AvgCline
	lda.b d0
	cmp.w #$0C01
	bcs .rtl
	lda.w PenShotActive
	bne .rtl
	lda.w $186E
	beq .rtl
	jsl.l CompLine
	jsl.l setpersonel
	jsl.l CODE_C5111A
	jml.l CompShoot
.rtl:								; return
	rtl
check4bench:						; from assbench and other segments
	lda.w pflags,x
	bit.w #$4000
	bne .rtl
	lda.w newpos,x
	bpl .1
	lda.w newpnum,x
	bmi .rtl
.1:									; if newpnum,x = pnum,x go to .2, if asscur,x = $000C go to .rtl, ...
	lda.w newpnum,x
	cmp.w pnum,x
	beq .2
	lda.w asscur,x
	cmp.w #$000C
	beq .rtl
	cpx.w puckc
	beq .rtl
	sep #$20
	pla
	rep #$30
	pla
	lda.w pflags,x
	ora.w #$1000
	sta.w pflags,x
	stz.w temp1,x
	lda.w #$000C
	sta.b d0
	jml.l assreplace
.rtl:								; return
	rtl
.2:									; A 8-bit, pull A, A, X / Y 16-bit, pull A, ...
	sep #$20
	pla
	rep #$30
	pla
	lda.w pflags,x
	and.w #$EFFF
	sta.w pflags,x
	stz.w pfnc,x
	lda.w #$FFFF
	sta.w newpnum,x
	sta.w newpos,x
	lda.w position,x
	sta.b d0
	jmp.w Setplass
getpde:								; from makepde and other segments
	lda.w pnum,x
	and.w #$00FF
	asl a
	sta.b d1
	lda.w pfteam,x
	beq .1
	lda.w #$0002
.1:									; a2 = A, if zero go to .2, A = $0034
	sta.b a2
	beq .2
	lda.w #$0034
.2:									; A + d1, Y = A, d0 = tmpde,y, return
	adc.b d1
	tay
	lda.w tmpde,y
	sta.b d0
	rtl
setpde:								; called from other segments
	lda.b a2
	beq .1
	lda.w #$0034
.1:									; A + d1, Y = A, if d0 >= 0 go to .2, d0 = $0000
	clc
	adc.b d1
	tay
	lda.b d0
	bpl .2
	lda.w #$0000
	sta.b d0
.2:									; tmpde,y = A, return
	sta.w tmpde,y
	rtl
makepde:							; called from other segments
	pha
	pei ($83)
	pei ($6B)
	ldx.b a0
	jsl.l getpde
	pla
	sta.b a2
	pla
	sta.b d1
	pla
	ldx.b d0
	jsl.l Mul16S
	lda.b $36
	asl.b r2
	rol a
	asl.b r2
	rol a
	asl.b r2
	rol a
	asl.b r2
	rol a
	sta.b d0
	ldx.b a3
	clc
	rtl
AvgCline:							; from CODE_C5492E and other segments
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	pei ($63)
	pei ($65)
	stz.b d0
	stz.b d1
	lda.w #$0005
	sta.b d2
	sta.b d2
	ldy.b a2
	lda.w tmsort,y
	sta.b a0
.loop:								; loop: Y = a0, if position,y = 0 go to .2, if minus go to .2, ...
	ldy.b a0
	lda.w position,y
	beq .2
	bmi .2
	lda.w pnum,y
	and.w #$00FF
	asl a
	sta.b d3
	lda.b a2
	beq .1
	lda.w #$0034
.1:									; A + d3, Y = A, A = tmpde,y, A + d0, ...
	adc.b d3
	tay
	lda.w tmpde,y
	adc.b d0
	sta.b d0
	inc.b d1
.2:									; a0 + 1, a0 + 1, d2 - 1, if the result >= 0 go to .loop, ...
	inc.b a0
	inc.b a0
	dec.b d2
	bpl .loop
	lda.b d1
	beq .3
	sta.b r1
	phx
	lda.b d0
	sta.b r2
	jsl.l Div16U
	lda.b r0
	sta.b d0
	plx
.3:									; pull A, $65 = A, pull A, a0 = A, ...
	pla
	sta.b $65
	pla
	sta.b a0
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
	rtl
reenergizeteam:						; gives every player of team a2 full energy ($1000); the bench check after
									; it never passes (one value compared with $FFFD, then with $FFFC)
	ldy.w #$0032
	ldx.w #$0019
	lda.b a2
	beq .loop
	ldy.w #$0066
.loop:								; loop: tmpde,y = $1000, if tmpdst,y is not $FFFD go to .1, ...
	lda.w #$1000
	sta.w tmpde,y
	lda.w tmpdst,y
	cmp.w #$FFFD
	bne .1
	cmp.w #$FFFC
	bne .1
	lda.w #$FFFE
	sta.w tmpdst,y
.1:									; Y - 1, Y - 1, X - 1, if the result >= 0 go to .loop, ...
	dey
	dey
	dex
	bpl .loop
	rtl
RestoreBenchEnergy:					; called from other segments
	lda.w $186E
	beq CODE_C54B5F
	stz.b a2
	jsl.l CODE_C54B2B
	lda.w #$0002
	sta.b a2
CODE_C54B2B:						; from RestoreBenchEnergy and other segments
	lda.w #$0032
	sta.b d0
.loop:								; loop: if a2 = 0 go to .1, A = $0034
	lda.b a2
	beq .1
	lda.w #$0034
.1:									; A + d0, Y = A, if tmpdst,y is not $FFFE go to .2, A = tmpde,y, ...
	clc
	adc.b d0
	tay
	lda.w tmpdst,y
	cmp.w #$FFFE
	bne .2
	lda.w tmpde,y
	clc
	adc.w #$000A
	sta.w tmpde,y
	sec
	sbc.w #$1000
	bmi .2
	lda.w #$1000
	sta.w tmpde,y
.2:									; d0 - 1, d0 - 1, if the result >= 0 go to .loop
	dec.b d0
	dec.b d0
	bpl .loop
CODE_C54B5F:						; from RestoreBenchEnergy
	rtl
CODE_C54B60:						; from CODE_C54BAF, lineinput, ...
	jsr.w CODE_C54114
	pha
	tay
	jsl.l CODE_C4CEDB
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	ldx.w #$0006
.loop:								; loop: push Y, A = Y, A + $0020, Y = A, ...
	pea.w $000B
	pea.w $0000
	phy
	pea.w $1808
	pea.w $00C5
	pea.w $8942
	tya
	clc
	adc.w #$0020
	tay
	dex
	bne .loop
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	jsl.l CODE_C4CEDB
	pla
	cmp.w #$5AB5
	bcc .1
	jsl.l CODE_C539D7
.1:									; call CODE_C51397, call CODE_C4CEDB, go to CODE_C5111A
	jsl.l CODE_C51397
	jsl.l CODE_C4CEDB
	jml.l CODE_C5111A
CODE_C54BAF:						; called from other segments
	lda.w $186E
	beq .rtl
	pei ($6B)
	lda.w tmflags
	bit.w #$0008
	beq .1
	and.w #$FFF7
	sta.w tmflags
	stz.b a2
	jsl.l CODE_C54B60
.1:									; A = $1301, if $0008 bits clear go to .2, A and $FFF7, $1301 = A, ...
	lda.w $1301
	bit.w #$0008
	beq .2
	and.w #$FFF7
	sta.w $1301
	lda.w #$0002
	sta.b a2
	jsl.l CODE_C54B60
.2:									; pull A, a2 = A, $18AA + 1
	pla
	sta.b a2
	inc.w $18AA
.rtl:								; return
	rtl
CODE_C54BE8:						; no caller found (not traced)
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	pei ($67)
	pei ($69)
	lda.w #$2000
	sta.w $07D2
	lda.b d0
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	cmp.w #$0020
	bcc .1
	lda.w #$001F
.1:									; d0 = A, Y = $0002, $04F5 = $0006, d3 = $0003
	sta.b d0
	ldy.w #$0002
	lda.w #$0006
	sta.w $04F5
	lda.w #$0003
	sta.b d3
.loop:								; loop: d2 = $FFFF, if d0 < 0 go to .2, d2 = A, ...
	lda.w #$FFFF
	sta.b d2
	lda.b d0
	bmi .2
	sta.b d2
	cmp.w #$0008
	bcc .2
	lda.w #$0007
	sta.b d2
.2:									; A = d2, A + d1, if the result is not 0 go to .3, A = $0020
	lda.b d2
	sec
	adc.b d1
	and.w #$00FF
	bne .3
	lda.w #$0020
.3:									; $04F5,y = A, Y + 1, A = d0, A - $0008, ...
	sta.w $04F5,y
	iny
	lda.b d0
	sec
	sbc.w #$0008
	sta.b d0
	dec.b d3
	bpl .loop
	lda.b d1
	beq .4
	lda.w #$0C00
	tsb.w $07D2
.4:									; $69 = 0, a1 = $04F5, A = $07D4, A - $000B, ...
	stz.b $69
	lda.w #$04F5
	sta.b a1
	lda.w $07D4
	sec
	sbc.w #$000B
	sta.w $07D4
	lda.w #$4000
	tsb.w $07D2
	stz.b $69
	lda.w #$04F5
	sta.b a1
	sep #$20
	lda.w $04FA
	ldy.w $04F7
	sty.w $04FA
	sta.w $04F7
	rep #$30
	lda.w $04F8
	xba
	sta.w $04F8
	lda.w #$4000
	trb.w $07D2
	pla
	sta.b $69
	pla
	sta.b a1
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
	rtl
CODE_C54CB9:						; from CompLine, CODE_C54D03, CODE_C548C1, CODE_C54828
	pei ($8F)
	phx
	inc a
	asl a
	asl a
	asl a
	adc.w #$2DC9
	ldy.b a2
	beq .1
	adc.w #$043E
.1:									; X = A, r2 = 0, Y = a2, A = tmap,y, ...
	tax
	stz.b r2
	ldy.b a2
	lda.w tmap,y
	dec a
	sta.b r1
.loop:								; loop: d4 = A, A = X, A + d4, Y = A, ...
	sta.b d4
	txa
	clc
	adc.b d4
	tay
	lda.w $006C,y
	and.w #$00FF
	asl a
	ldy.b a2
	beq .2
	adc.w #$0034
.2:									; Y = A, A = $1309,y, A + r2, r2 = A, ...
	tay
	lda.w $1309,y
	clc
	adc.b r2
	sta.b r2
	lda.b d4
	dec a
	bne .loop
	jsl.l Div16x8U
	lda.b r0
	plx
	ply
	sty.b d4
	rts
CODE_C54D03:						; from CODE_C54070
	jsr.w CODE_C54CB9
	cmp.w #$0100
	bcs .1
	lda.w #$0100
.1:									; if A < $0FFF go to .2, A = $0FFF
	cmp.w #$0FFF
	bcc .2
	lda.w #$0FFF
.2:									; $85 = A, A * 2, A + $85, $85 = A, ...
	sta.b $85
	asl a
	adc.b $85
	sta.b $85
	xba
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	tax
	lda.w #$0003
	jsl.l CODE_C4C561
	pha
	tay
	lda.w #$A0A0
	sta.w $0000,y
	sta.w $0001,y
	jmp (DATA8_C54D3A,x)
DATA8_C54D3A:						; jump table: the routine for each index
	dw CODE_C54D69,CODE_C54D55,CODE_C54D40
CODE_C54D40:						; from DATA8_C54D3A
	lda.w #$8888
	sta.w $0000,y
	lda.w #$0080
	sta.b d1
	lda.b $85
	sec
	sbc.w #$2000
	iny
	iny
	bra CODE_C54D70
CODE_C54D55:						; from DATA8_C54D3A
	lda.w #$0091
	sta.w $0000,y
	lda.w #$0089
	sta.b d1
	lda.b $85
	sec
	sbc.w #$1000
	iny
	bra CODE_C54D70
CODE_C54D69:						; from DATA8_C54D3A
	lda.w #$0092
	sta.b d1
	lda.b $85
CODE_C54D70:						; from CODE_C54D55, CODE_C54D40
	and.w #$FE00
	xba
	lsr a
	adc.b d1
	sep #$20
	sta.w $0000,y
	rep #$20
	ply
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	pea.w $0003
	pea.w $0000
	lda.b d0
	clc
	adc.w #$0006
	pha
	pea.w $1800
	pea.w $007E
	phy
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	rts
lcfound:							; from lineinput and other segments
	ldx.b a3
	ldy.b a2
	lda.b d2
	sta.w $1307,y
	jsr.w CODE_C54155
	bmi .rtl
	sta.b d0
	lda.w pflags,x
	ora.w #$0008
	sta.w pflags,x
	jsl.l loadTeamStruct
	ldy.b a2
	lda.w tmflags,y
	and.w #$FFF7
	sta.w tmflags,y
	lda.b d0
	sta.w tmline,y
	lda.w #$FFFF
	sta.w lcpad,y
	jsl.l setpersonel
	lda.w #$0000
.rtl:								; return
	rtl
SetupTeamForIntermission:			; called from other segments
	jsl.l ResetBench
	lda.w #$0001
	sta.w $234C
	stz.b a2
	lda.w #$0002
	sta.b a3
	jsl.l CODE_C54DFB
	stz.b a3
	lda.w #$0002
	sta.b a2
CODE_C54DFB:						; from SetupTeamForIntermission and other segments
	jsl.l reenergizeteam
	ldx.b a3
	ldy.b a2
	stz.w tmline,x
	lda.w $186E
	beq .rtl
	lda.w tmap,x
	sec
	sbc.w tmap,y
	sta.b d0
	beq .rtl
	lda.w #$0003
	sta.w tmline,x
	lda.b d0
	bpl .rtl
	lda.w #$0005
	sta.w tmline,x
.rtl:								; return
	rtl
Create_HotCold_Table:				; called from other segments
	ldx.w #$026F
.1:									; A = $000E, call randoma8, if A < $000D go to .2, A = $000C
	lda.w #$000E
	jsl.l randoma8
	cmp.w #$000D
	bcc .2
	lda.w #$000C
.2:									; Y = A, A = seed, if the result is not 0 go to .3, A 8-bit, ...
	tay
	lda.w seed
	and.w #$0010
	bne .3
	sep #$20
	tya
	eor.b #$FF
	inc a
	sta.w $1543,x
	bra .4
.3:									; A 8-bit, A = Y, $1543,x = A
	sep #$20
	tya
	sta.w $1543,x
.4:									; A 16-bit, X - 1, if the result >= 0 go to .1, return
	rep #$20
	dex
	bpl .1
	rtl
GetTeamLines:						; from SetPlList and other segments
	lda.w #$007E
	sta.b $71
	lda.b a2
	beq .1
	lda.w #$1813
	bra .2
.1:									; A = $17DB
	lda.w #$17DB
.2:									; a3 = A, return
	sta.b a3
	rtl
CODE_C54E6D:						; called from other segments
	jsl.l CODE_CF039E
	jsl.l FadeOutWait
	stz.w $18F8
	lda.w $17D1
	bne .1
	lda.w $153F
	beq .2
.1:									; A = $05D7, X = $00CF, call CODE_CF0134, A = $00A5, ...
	lda.w #$05D7
	ldx.w #$00CF
	jsl.l CODE_CF0134
	lda.w #$00A5
	jsl.l CODE_CF040B
	jsl.l CODE_CF03D0
	dec.w $18F8
.2:									; call CODE_C5503C, X = $0002, call CODE_C54F94, $059E = $0001
	jsr.w CODE_C5503C
	ldx.w #$0002
	jsr.w CODE_C54F94
	lda.w #$0001
	sta.w $059E
.3:									; TransfersReady + 1
	inc.w TransfersReady
.loop:								; loop: if TransfersReady is not 0 go to .loop, A = teampads, ...
	lda.w TransfersReady
	bne .loop
	lda.w teampads
	ora.w $14F7
	bne .4
	stz.w $1525
	jsl.l CODE_C36C49
	dec.w $1525
	bra .5
.4:									; call CODE_C36C49
	jsl.l CODE_C36C49
.5:									; $26 + 1, call AnimateSprites, $28 = $1D8F, $2A = $1E00, ...
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w repeatdelayframes
	bne .3
	jsr.w CODE_C54F05
	lda.w $058D
	bit.w #$3000
	beq .3
	lda.w $18EE
	sta.w $18E0
	sta.b $08
	stz.b $22
	ldx.w $18F0
	jsl.l CODE_C5E596
	jmp.w CODE_C55513

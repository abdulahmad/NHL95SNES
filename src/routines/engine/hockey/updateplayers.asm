updateplayers:						; every object's frame: the old positions kept, the goalie at each end
									; found, then updateanim, doinput and checkcoll among its steps
	lda.w #$FFFF
	sta.w topgoalie
	sta.w botgoalie
	sta.w tmnear
	sta.w tmnear+2
	sta.w tmnearpl
	sta.w tmnearpl+2
	lda.w puckz
	sta.w puckoldz
	ldx.w #$001E
.1:									; curobj = X, OldXpos,x = Xpos,x, OldXfrac,x = Xfrac,x, ...
	stx.b curobj
	lda.w Xpos,x
	sta.w OldXpos,x
	lda.w Xfrac,x
	sta.w OldXfrac,x
	lda.w Ypos,x
	sta.w OldYpos,x
	lda.w Yfrac,x
	sta.w OldYfrac,x
	cpx.w #$0018
	beq .2
	cpx.w #$001A
	bne .3
.2:									; go to .16
	jmp.w .16
.3:									; if position,x >= 0 go to .4, go to .44
	lda.w position,x
	bpl .4
	jmp.w .44
.4:									; if not zero go to .6, if Ypos,x >= 0 go to .5, botgoalie = X, go to .6
	bne .6
	lda.w Ypos,x
	bpl .5
	stx.w botgoalie
	bra .6
.5:									; topgoalie = X
	stx.w topgoalie
.6:									; call updateanim, A = nopuck,x, A - timestep, ...
	jsl.l updateanim
	lda.w nopuck,x
	sec
	sbc.w timestep
	bpl .7
	lda.w #$0000
.7:									; nopuck,x = A, A = nopuckb,x, A - timestep, ...
	sta.w nopuck,x
	lda.w nopuckb,x
	sec
	sbc.w timestep
	bpl .8
	lda.w #$0000
.8:									; nopuckb,x = A, A = sflags3, if $0020 bits clear go to .10, ...
	sta.w nopuckb,x
	lda.w sflags3
	bit.w #$0020
	beq .10
	lda.w pnum,x
	and.w #$00FF
	cmp.w #$0080
	bcc .9
	ora.w #$FF00
.9:									; d0 = A, if A - $0000 < 0 go to .10, d0 * 2, call loadTeamStruct
	sta.b d0
	cmp.w #$0000
	bmi .10
	asl.b d0
	jsl.l loadTeamStruct
.10:								; if goaliedivewait,x = 0 go to .12, A - timestep, ...
	lda.w goaliedivewait,x
	beq .12
	sec
	sbc.w timestep
	bpl .11
	lda.w #$0000
.11:								; goaliedivewait,x = A
	sta.w goaliedivewait,x
.12:								; if X is not passReceiverPlayerNum go to .13, ...
	cpx.w passReceiverPlayerNum
	bne .13
	lda.w onetimer
	beq .13
	jmp.w .33
.13:								; if SPA,x is not SPAinjury1&$FFFF go to .14, go to .44
	lda.w SPA,x
	cmp.w #SPAinjury1&$FFFF
	bne .14
	jmp.w .44
.14:								; if A < SPAboardfront&$FFFF go to .15, go to .44
	cmp.w #SPAboardfront&$FFFF
	bcc .15
	jmp.w .44
.15:								; if X is not $001C go to .16, if puckz = 0 go to .16, go to .33
	cpx.w #$001C
	bne .16
	lda.w puckz
	beq .16
	jmp.w .33
.16:								; Y = $FFFF, A = pflags,x, if $0001 bits clear go to .24, ...
	ldy.w #$FFFF
	lda.w pflags,x
	bit.w #$0001
	beq .24
	lda.w Xvel,x
	bpl .18
	sty.b r2
	sta.b $35
	sec
	lda.b r2
	sbc.b $35
	sta.b r2
	bcc .17
	inc.b r2+2
.17:								; Xvel,x = $35, go to .20
	lda.b $35
	sta.w Xvel,x
	bra .20
.18:								; r2 = 0, $35 = A, A = r2, A - $35, ...
	stz.b r2
	sta.b $35
	sec
	lda.b r2
	sbc.b $35
	sta.b r2
	bcs .19
	dec.b r2+2
.19:								; Xvel,x = $35
	lda.b $35
	sta.w Xvel,x
.20:								; if Yvel,x >= 0 go to .22, r2 = Y, $35 = A, A = r2, ...
	lda.w Yvel,x
	bpl .22
	sty.b r2
	sta.b $35
	sec
	lda.b r2
	sbc.b $35
	sta.b r2
	bcc .21
	inc.b r2+2
.21:								; Yvel,x = $35, go to .33
	lda.b $35
	sta.w Yvel,x
	jmp.w .33
.22:								; r2 = 0, $35 = A, A = r2, A - $35, ...
	stz.b r2
	sta.b $35
	sec
	lda.b r2
	sbc.b $35
	sta.b r2
	bcs .23
	dec.b r2+2
.23:								; Yvel,x = $35, go to .33
	lda.b $35
	sta.w Yvel,x
	jmp.w .33
.24:								; A = d7, A - 1, if the result = 0 go to .25, A = $00F8, ...
	lda.b d7
	dec a
	beq .25
	lda.w #$00F8
	txy
	ldx.w Xvel,y
	jsl.l Mul16x8HiXS
	sta.w Xvel,y
	lda.w #$00F8
	ldx.w Yvel,y
	jsl.l Mul16x8HiXS
	sta.w Yvel,y
	tyx
	jmp.w .33
.25:								; if Xvel,x >= 0 go to .27, r2 = Y, $35 = A, A * 2, ...
	lda.w Xvel,x
	bpl .27
	sty.b r2
	sta.b $35
	asl a
	clc
	adc.b $35
	sta.b r0
	sec
	lda.b r2
	sbc.b r0
	sta.b r2
	bcc .26
	inc.b r2+2
.26:								; Xvel,x = $35, go to .29
	lda.b $35
	sta.w Xvel,x
	bra .29
.27:								; r2 = 0, $35 = A, A * 2, A + $35, ...
	stz.b r2
	sta.b $35
	asl a
	adc.b $35
	sta.b r0
	sec
	lda.b r2
	sbc.b r0
	sta.b r2
	bcs .28
	dec.b r2+2
.28:								; Xvel,x = $35
	lda.b $35
	sta.w Xvel,x
.29:								; if Yvel,x >= 0 go to .31, r2 = Y, $35 = A, A * 2, ...
	lda.w Yvel,x
	bpl .31
	sty.b r2
	sta.b $35
	asl a
	clc
	adc.b $35
	sta.b r0
	sec
	lda.b r2
	sbc.b r0
	sta.b r2
	bcc .30
	inc.b r2+2
.30:								; Yvel,x = $35, go to .33
	lda.b $35
	sta.w Yvel,x
	bra .33
.31:								; r2 = 0, $35 = A, A * 2, A + $35, ...
	stz.b r2
	sta.b $35
	asl a
	adc.b $35
	sta.b r0
	sec
	lda.b r2
	sbc.b r0
	sta.b r2
	bcs .32
	dec.b r2+2
.32:								; Yvel,x = $35
	lda.b $35
	sta.w Yvel,x
.33:								; Y = $FFFF, A = d7, A - 1, if the result is not 0 go to .34, ...
	ldy.w #$FFFF
	lda.b d7
	dec a
	bne .34
	jmp.w .38
.34:								; if Xvel,x < 0 go to .35, r2+2 = 0, A * 2, A * 2, ...
	lda.w Xvel,x
	bmi .35
	stz.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	adc.w Xfrac,x
	sta.w Xfrac,x
	lda.w Xpos,x
	adc.b r2+2
	sta.w Xpos,x
	bra .36
.35:								; r2+2 = Y, A * 2, A * 2, A * 2, ...
	sty.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	clc
	adc.w Xfrac,x
	sta.w Xfrac,x
	lda.w Xpos,x
	adc.b r2+2
	sta.w Xpos,x
.36:								; if Yvel,x < 0 go to .37, r2+2 = 0, A * 2, A * 2, ...
	lda.w Yvel,x
	bmi .37
	stz.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	adc.w Yfrac,x
	sta.w Yfrac,x
	lda.w Ypos,x
	adc.b r2+2
	sta.w Ypos,x
	jmp.w .42
.37:								; r2+2 = Y, A * 2, A * 2, A * 2, ...
	sty.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	clc
	adc.w Yfrac,x
	sta.w Yfrac,x
	lda.w Ypos,x
	adc.b r2+2
	sta.w Ypos,x
	jmp.w .42
.38:								; if Xvel,x < 0 go to .39, r2+2 = 0, A * 2, A * 2, ...
	lda.w Xvel,x
	bmi .39
	stz.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	adc.w Xfrac,x
	sta.w Xfrac,x
	lda.w Xpos,x
	adc.b r2+2
	sta.w Xpos,x
	bra .40
.39:								; r2+2 = Y, A * 2, A * 2, A * 2, ...
	sty.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	clc
	adc.w Xfrac,x
	sta.w Xfrac,x
	lda.w Xpos,x
	adc.b r2+2
	sta.w Xpos,x
.40:								; if Yvel,x < 0 go to .41, r2+2 = 0, A * 2, A * 2, ...
	lda.w Yvel,x
	bmi .41
	stz.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	adc.w Yfrac,x
	sta.w Yfrac,x
	lda.w Ypos,x
	adc.b r2+2
	sta.w Ypos,x
	bra .42
.41:								; r2+2 = Y, A * 2, A * 2, A * 2, ...
	sty.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	asl a
	rol.b r2+2
	clc
	adc.w Yfrac,x
	sta.w Yfrac,x
	lda.w Ypos,x
	adc.b r2+2
	sta.w Ypos,x
.42:								; if X is not $001C go to .44, if puckz < 0 go to .44, ...
	cpx.w #$001C
	bne .44
	lda.w puckz
	bmi .44
	bne .43
	lda.w puckvz
	beq .44
.43:								; A = puckvz, A - gravstep, puckvz = A, X = A, ...
	lda.w puckvz
	sec
	sbc.w gravstep
	sta.w puckvz
	tax
	lda.w velstep
	jsl.l Mul16x8XS
	ldx.b curobj
	lda.b r2
	clc
	adc.w shadowz
	sta.w shadowz
	lda.b r2+2
	adc.w puckz
	sta.w puckz
	bpl .44
	stz.w puckz
	stz.w shadowz
	lda.w puckvz
	eor.w #$FFFF
	inc a
	lsr a
	sta.w puckvz
	cmp.w #$0200
	bmi .44
	asl a
	and.w #$FF00
	sta.b tmp0
	xba
	tsb.b tmp0
	lda.w #$000D
	jsl.l StartSoundVolume
.44:								; A = puckx, A - Xpos,x, d0 = A, if plus go to .45, ...
	sec
	lda.w puckx
	sbc.w Xpos,x
	sta.b d0
	bpl .45
	eor.w #$FFFF
	inc a
	sec
.45:								; r3 = A, A = pucky, A - Ypos,x, d1 = A, ...
	sta.b r3
	lda.w pucky
	sbc.w Ypos,x
	sta.b d1
	bpl .46
	eor.w #$FFFF
	inc a
.46:								; if A < r3 go to .47, r3 / 2, A * 2
	cmp.b r3
	bcc .47
	lsr.b r3
	asl a
.47:								; A / 2, A + r3, puckdist,x = A, if X >= $0018 go to .49, ...
	lsr a
	adc.b r3
	sta.w puckdist,x
	cpx.w #$0018
	bcs .49
	sta.b r3
	lda.w position,x
	bmi .49
	beq .49
	lda.w pflags,x
	and.w #$1000
	ora.w pfalock,x
	bne .49
	lda.b r3
	cpx.w #$000C
	bcs .48
	cmp.w tmnear
	bcs .49
	sta.w tmnear
	stx.w tmnearpl
	bra .49
.48:								; if A >= tmnear+2 go to .49, tmnear+2 = A, tmnearpl+2 = X
	cmp.w tmnear+2
	bcs .49
	sta.w tmnear+2
	stx.w tmnearpl+2
.49:								; if X >= $0018 go to .52, if A >= $001E go to .52, A = iflags, ...
	cpx.w #$0018
	bcs .52
	cmp.w #$001E
	bcs .52
	lda.w iflags
	bit.w #$0004
	beq .52
	bit.w #$0001
	bne .52
	and.w #$0002
	beq .50
	lda.w pfgoal,x
	bne .52
	bra .51
.50:								; if pfgoal,x = 0 go to .52
	lda.w pfgoal,x
	beq .52
.51:								; if puckz >= $000D go to .52, if puckvy >= $2400 go to .52, ...
	lda.w puckz
	cmp.w #$000D
	bcs .52
	lda.w puckvy
	cmp.w #$2400
	bcs .52
	cmp.w #$DC00
	bmi .52
	lda.w #$0005
	trb.w iflags
.52:								; call vtoa, puckdir,x = A, X - 1, X - 1, ...
	jsl.l vtoa
	sta.w puckdir,x
	dex
	dex
	bmi .53
	jmp.w .1
.53:								; if Ypos+24 - $012E < 0 go to .54, A = $012E
	lda.w Ypos+24
	cmp.w #$012E
	bmi .54
	lda.w #$012E
.54:								; Ypos+24 = A, if Ypos+26 - $FED2 >= 0 go to .55, A = $FED2
	sta.w Ypos+24
	lda.w Ypos+26
	cmp.w #$FED2
	bpl .55
	lda.w #$FED2
.55:								; Ypos+26 = A, PadControlObj = $000F, PadControlObj+2 = A, ...
	sta.w Ypos+26
	lda.w #$000F
	sta.w PadControlObj
	sta.w PadControlObj+2
	sta.w PadControlObj+4
	sta.w PadControlObj+6
	sta.w PadControlObj+8
	sta.w PadControlObj+10
	sta.w PadControlObj+12
	stz.w padinputdone
	stz.w padinputdone+2
	stz.w padinputdone+4
	stz.w padinputdone+6
	stz.w padinputdone+8
	stz.b $BD
	lda.w #$0002
	sta.b $BF
	ldx.w #$0000
.56:								; a3 = X, curobj = X, if X is not $000C go to .57, $BD = $0002, ...
	stx.b a3
	stx.b curobj
	cpx.w #$000C
	bne .57
	lda.w #$0002
	sta.b $BD
	stz.b $BF
.57:								; $B9 = $FFFF, if position,x >= 0 go to .58, go to .72
	lda.w #$FFFF
	sta.b $B9
	lda.w position,x
	bpl .58
	jmp.w .72
.58:								; A = X, A / 2, d6 = A, if X is not puckc go to .59, ...
	txa
	lsr a
	sta.b d6
	cpx.w puckc
	bne .59
	stz.b d4
	jsl.l setpads
.59:								; if X >= $0018 go to .60, if playerpad,x < 0 go to .60, Y = A, ...
	cpx.w #$0018
	bcs .60
	lda.w playerpad,x
	bmi .60
	tay
	lda.w padinputdone,y
	bne .60
	lda.w #$0001
	sta.w padinputdone,y
	lda.w PadRaw1,y
	sta.b d3
	lda.w padchange,y
	sta.b d2
	lda.w padnew1,y
	sta.b d1
	lda.w paddir,y
	sta.b d0
	iny
	iny
	sty.b d4
	jsl.l doinput
.60:								; if pfalock,x is not 0 go to .61, A = asscur,x, A * 2, A * 2, ...
	lda.w pfalock,x
	bne .61
	lda.w asscur,x
	asl a
	asl a
	tax
	lda.l asstab,x
	sta.w jmlvector+1
	lda.l $C09A25,x
	sta.w jmlvector+2
	ldx.b curobj
	jsl.l loadTeamStruct
	jsl.l jmlvector
.61:								; A = position,x, if the result is not 0 go to .65, ...
	lda.w position,x
	ora.w gmclock
	bne .65
	cpx.w #$0018
	bcs .65
	cpx.w puckc
	beq .65
	lda.w goalieflags,x
	bit.w #$0001
	bne .65
	lda.w Xpos,x
	cmp.w #$FFD5
	bpl .62
	cmp.w #$FFCF
	bmi .63
	lda.w #$FFD5
	stz.w Xvel,x
	bra .63
.62:								; if A - $002C < 0 go to .63, if A - $0031 >= 0 go to .63, A = $002B, ...
	cmp.w #$002C
	bmi .63
	cmp.w #$0031
	bpl .63
	lda.w #$002B
	stz.w Xvel,x
.63:								; Xpos,x = A, if Ypos,x >= 0 go to .64, ...
	sta.w Xpos,x
	lda.w Ypos,x
	bpl .64
	cmp.w #$FF15
	bmi .65
	cmp.w #$FF1A
	bpl .65
	lda.w #$FF14
	sta.w Ypos,x
	stz.w Yvel,x
	bra .65
.64:								; if A - $00EC >= 0 go to .65, if A - $00E7 < 0 go to .65, ...
	cmp.w #$00EC
	bpl .65
	cmp.w #$00E7
	bmi .65
	lda.w #$00EC
	sta.w Ypos,x
	stz.w Yvel,x
.65:								; Wallcos,x = 0, Wallsin,x = 0, d3 = Ypos,x, d2 = Xpos,x, ...
	stz.w Wallcos,x
	stz.w Wallsin,x
	lda.w Ypos,x
	sta.b d3
	lda.w Xpos,x
	sta.b d2
	cmp.w OldXpos,x
	bne .66
	lda.b d3
	cmp.w OldYpos,x
	bne .66
	jmp.w .71
.66:								; call checkcoll, if X >= $0018 go to .71, ...
	jsl.l checkcoll
	cpx.w #$0018
	bcs .71
	lda.w position,x
	beq .71
	lda.w pflags,x
	and.w #$8000
	bne .71
	lda.w Xpos,x
	cmp.w #$FFE7
	bmi .71
	cmp.w #$0019
	bpl .71
	lda.w Ypos,x
	bit.w #$8000
	beq .67
	eor.w #$FFFF
	inc a
.67:								; A - $0113, r0 = A, A = OldYpos,x, if $8000 bits clear go to .68, ...
	sec
	sbc.w #$0113
	sta.b r0
	lda.w OldYpos,x
	bit.w #$8000
	beq .68
	eor.w #$FFFF
	inc a
.68:								; A - $0113, if the result < 0 go to .70, A = Ypos,x, ...
	sec
	sbc.w #$0113
	eor.b r0
	bmi .70
	lda.w Ypos,x
	bit.w #$8000
	beq .69
	eor.w #$FFFF
	inc a
.69:								; if A < $0109 go to .71, if A >= $011D go to .71
	cmp.w #$0109
	bcc .71
	cmp.w #$011D
	bcs .71
.70:								; Xpos,x = OldXpos,x, Ypos,x = OldYpos,x
	lda.w OldXpos,x
	sta.w Xpos,x
	lda.w OldYpos,x
	sta.w Ypos,x
.71:								; A = impact,x, A - impactstep, if the result >= 0 go to .72, A = $0000
	lda.w impact,x
	sec
	sbc.w impactstep
	bpl .72
	lda.w #$0000
.72:								; impact,x = A, X + 1, X + 1, if X = $0020 go to .73, ...
	sta.w impact,x
	inx
	inx
	cpx.w #$0020
	beq .73
	jmp.w .56
.73:								; if puckz >= $0018 go to .75, if puckx - $FF65 >= 0 go to .74, ...
	lda.w puckz
	cmp.w #$0018
	bcs .75
	lda.w puckx
	cmp.w #$FF65
	bpl .74
	lda.w #$FF65
	sta.w puckx
	ldx.w frame+$1C
	cpx.w #SPFpuck
	bne .74
	sta.w Xpos+$1E
.74:								; if puckx - $009B < 0 go to .75, puckx = $009B, ...
	lda.w puckx
	cmp.w #$009B
	bmi .75
	lda.w #$009B
	sta.w puckx
	ldx.w frame+$1C
	cpx.w #SPFpuck
	bne .75
	sta.w Xpos+$1E
.75:								; if puckz is not 0 go to .77, if pucky - $FEAE < 0 go to .77, ...
	lda.w puckz
	bne .77
	lda.w pucky
	cmp.w #$FEAE
	bmi .77
	cmp.w #$0152
	bpl .77
	lda.w pucky
	cmp.w #$FEC7
	bpl .76
	lda.w #$FEC7
	sta.w pucky
	sta.w Ypos+$1E
.76:								; if pucky - $013E < 0 go to .77, pucky = $013E, Ypos+$1E = A
	lda.w pucky
	cmp.w #$013E
	bmi .77
	lda.w #$013E
	sta.w pucky
	sta.w Ypos+$1E
.77:								; if puckc < 0 go to .rtl, carriedy = pucky
	lda.w puckc
	bmi .rtl
	lda.w pucky
	sta.w carriedy
.rtl:								; return
	rtl

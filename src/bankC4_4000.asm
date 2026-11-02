; Segment bankC4_4000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C43FC8
checkcoll:							; collisions of object X (updateplayers): checkwallcoll at its position
									; and at its hot spot (GetFrameHot), then checkplcoll
	stz.w collflag
	lda.w pfnc,x
	bne .2
	pei ($8B)
	pei ($87)
	lda.w Xpos,x
	sta.b d2
	lda.w Ypos,x
	sta.b d3
	lda.w radiusx,x
	sta.w wcradiusx
	lda.w radiusy,x
	sta.w wcradiusy
	jsl.l checkwallcoll
	lda.w Wallcos,x
	ora.w Wallsin,x
	bne .1
	cpx.w #$0018
	bcs .1
	txa
	jsl.l GetFrameHot
	lda.w Xpos,x
	clc
	adc.b d0
	sta.b d2
	lda.w Ypos,x
	clc
	adc.b d1
	sta.b d3
	lda.w #$0001
	sta.w wcradiusx
	sta.w wcradiusy
	jsl.l checkwallcoll
.1:									; pull A, d2 = A, pull A, d3 = A, ...
	pla
	sta.b d2
	pla
	sta.b d3
	lda.w position,x
	bmi .2
	jsl.l checkplcoll
.2:									; if collflag = 0 go to .3, go to .6
	lda.w collflag
	beq .3
	jmp.w .6
.3:									; d1 = OOlistpos,x
	lda.w OOlistpos,x
	sta.b d1
.loop:								; loop: if d1 = $000F go to .4, A = OOlist+1,y, A and $00FF, d4 = A, ...
	ldy.b d1
	cpy.w #$000F
	beq .4
	lda.w OOlist+1,y
	and.w #$00FF
	sta.b d4
	tay
	lda.b d3
	sec
	sbc.w Ylist,y
	beq .4
	bmi .4
	inc.w OOlistpos,x
	lda.w OOlistpos,y
	dec a
	sta.w OOlistpos,y
	sep #$30
	ldy.b d1
	lda.b d4
	sta.w OOlist,y
	txa
	sta.w OOlist+1,y
	rep #$30
	inc.b d1
	bra .loop
.4:									; if OOlistpos,x = 0 go to .5, d1 = A
	lda.w OOlistpos,x
	beq .5
	sta.b d1
.loop2:								; loop: Y = d1, A = $10DF,y, A and $00FF, d4 = A, ...
	ldy.b d1
	lda.w $10DF,y
	and.w #$00FF
	sta.b d4
	tay
	lda.b d3
	sec
	sbc.w Ylist,y
	bpl .5
	dec.w OOlistpos,x
	lda.w OOlistpos,y
	inc a
	sta.w OOlistpos,y
	sep #$30
	ldy.b d1
	lda.b d4
	sta.w OOlist,y
	txa
	sta.w $10DF,y
	rep #$30
	dec.b d1
	bne .loop2
.5:									; Ylist,x = d3, return
	lda.b d3
	sta.w Ylist,x
	rtl
.6:									; if SPA,x >= $28F6 go to .rtl, Xpos,x = OldXpos,x, Ypos,x = OldYpos,x
	lda.w SPA,x
	cmp.w #$28F6
	bcs .rtl
	lda.w OldXpos,x
	sta.w Xpos,x
	lda.w OldYpos,x
	sta.w Ypos,x
.rtl:								; return
	rtl
checkwallcoll:						; from checkcoll and other segments
	lda.w #$013E
	sec
	sbc.w wcradiusy
	pha
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0052
	sta.b d5
	lda.w #$009B
	sec
	sbc.w wcradiusx
	pha
	eor.w #$FFFF
	inc a
	clc
	adc.w #$0052
	sta.b d4
	lda.b d3
	pha
	ldy.b d2
	phy
	dec a
	cmp.b d5
	bpl .1
	lda.b d2
	cmp.b d4
	bmi .3
	lda.w #$0000
	sec
	sbc.b d4
	sta.b d4
	cmp.b d2
	bmi .3
	lda.w #$001A
	sta.b a2
	jsl.l checkgoal
	jmp.w WallStraightEdges
.1:									; A = $0000, A - d5, d5 = A, if A - d3 >= 0 go to .2, ...
	lda.w #$0000
	sec
	sbc.b d5
	sta.b d5
	cmp.b d3
	bpl .2
	lda.b d2
	cmp.b d4
	bmi .3
	lda.w #$0000
	sec
	sbc.b d4
	sta.b d4
	cmp.b d2
	bmi .3
	lda.w #$0018
	sta.b a2
	jsl.l checkgoal
.2:									; go to WallStraightEdges
	jmp.w WallStraightEdges
.3:									; A = d2, A - d4, d2 = A, A xor $FFFF, ...
	lda.b d2
	sec
	sbc.b d4
	sta.b d2
	eor.w #$FFFF
	inc a
	sta.b d1
	bit.w #$8000
	beq WallCornerNormal
WallCornerAbsX:						; take the absolute horizontal corner displacement
	eor.w #$FFFF
	inc a
WallCornerNormal:					; calculate the corner collision normal and apply the wall response
	sta.b tmp4
	lda.b d3
	sec
	sbc.b d5
	sta.b d0
	bit.w #$8000
	beq .1
	eor.w #$FFFF
	inc a
.1:									; $B1 = A, if A < tmp4 go to .2, A = tmp4, A / 2, ...
	sta.b $B1
	cmp.b tmp4
	bcc .2
	lda.b tmp4
	lsr a
	lsr a
	adc.b $B1
	bra .3
.2:									; A / 2, A / 2, A + tmp4
	lsr a
	lsr a
	adc.b tmp4
.3:									; if A < $0053 go to WallStraightEdges, d3 = A, A = d0, A and $FF00, ...
	cmp.w #$0053
	bcc WallStraightEdges
	sta.b d3
	lda.b d0
	xba
	and.w #$FF00
	tax
	lda.b d3
	jsl.l DivX8S
	cmp.w #$FF01
	bpl .4
	lda.w #$FF01
.4:									; if A - $00FF < 0 go to .5, A = $00FF
	cmp.w #$00FF
	bmi .5
	lda.w #$00FF
.5:									; d0 = A, A = d1, A and $FF00, X = A, ...
	sta.b d0
	lda.b d1
	xba
	and.w #$FF00
	tax
	lda.b d3
	jsl.l DivX8S
	ldx.b a3
	cmp.w #$FF01
	bpl .6
	lda.w #$FF01
.6:									; if A - $00FF < 0 go to .7, A = $00FF
	cmp.w #$00FF
	bmi .7
	lda.w #$00FF
.7:									; d1 = A, call wallcollb
	sta.b d1
	jsl.l wallcollb
WallStraightEdges:					; restore collision bounds and check straight wall edges
	pla
	sta.b d2
	pla
	sta.b d3
	pla
	sta.b d4
	pla
	sta.b d5
	lda.w Wallcos,x
	ora.w Wallsin,x
	bne .rtl
	stz.b d1
	lda.w #$00FF
	sta.b d0
	lda.b d3
	dec a
	cmp.b d5
	bpl wallcollb
	lda.w #$FF01
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d5
	dec a
	cmp.b d3
	bpl wallcollb
	stz.b d0
	lda.w #$FF01
	sta.b d1
	lda.b d2
	dec a
	cmp.b d4
	bpl wallcollb
	lda.w #$00FF
	sta.b d1
	lda.w #$0000
	sec
	sbc.b d4
	dec a
	cmp.b d2
	bpl wallcollb
.rtl:								; return
	rtl
WallPlayerResponse:					; continue into the player wall collision response
	jmp.w wallcoll
WallPuckOutResponse:				; continue into the puck out-of-bounds response
	jmp.w wallcollb_out
wallcollb:							; from WallStraightEdges, WallCornerNormal and other segments
	cpx.w #$001C
	bne WallPlayerResponse
	lda.w puckz
	cmp.w #$0021
	bpl WallPuckOutResponse
	lda.w puckz
	cmp.w #$0016
	bcc WallPlayerResponse
	lda.w pucky
	cmp.w #$012F
	bmi WallPuckOutResponse
	lda.w puckx
	cmp.w #$000D
	bmi WallPlayerResponse
	lda.w puckx
	cmp.w #$0010
	bpl WallPlayerResponse
	lda.w puckvy
	cmp.w #$0FA0
	bmi WallPlayerResponse
	phx
	lda.w puckvy
	pha
	asl a
	pla
	ror a
	sta.w puckvy
	inx
	inx
	stx.b a3
	plx
	stx.b a3
	lda.l Crowdlevel
	clc
	adc.w #$0258
	sta.l Crowdlevel
	lda.w #$005A
	sta.b crowdhold
	lda.w CwdExciteLvl
	clc
	adc.w #$000F
	bmi wallcollb_out
	sta.w CwdExciteLvl
wallcollb_out:						; from wallcollb, WallPuckOutResponse
	lda.w #$0040
	tsb.w sflags
	sta.w $109C
	lda.w pucky
	bpl .1
	lda.w #$8000
	tsb.w $08FC
.1:									; frame+$1E = 0, if gmclock is not 0 go to .2, A = ltplayer, A * 2, ...
	stz.w frame+$1E
	lda.w gmclock
	bne .2
	lda.w ltplayer
	asl a
	sta.b a3
	tax
	lda.w #$0006
	sta.b d0
	jsl.l ShootoutWonBy
	ldx.w #$001C
	stx.b a3
.2:									; call EndPenaltyShot, breakaway = 0, onetimer = 0, return
	jsl.l EndPenaltyShot
	stz.w breakaway
	stz.w onetimer
	rtl
wallcoll:							; from WallPlayerResponse, checkgoalp, checkgoal, ...
	lda.b d0
	sta.w Wallcos,x
	lda.b d1
	sta.w Wallsin,x
	pei ($87)
	pei ($8B)
	pei ($83)
	lda.b d0
	pha
	txy
	ldx.w Yvel,y
	jsl.l Mul16x8S
	lda.b $35
	sta.b d0
	ldx.w Xvel,y
	lda.b d1
	jsl.l Mul16x8S
	lda.b d0
	sec
	sbc.b $35
	eor.w #$FFFF
	inc a
	sta.b d2
	ldx.w Xvel,y
	lda.b $01,s
	jsl.l Mul16x8S
	lda.b $35
	sta.b d0
	ldx.w Yvel,y
	lda.b d1
	jsl.l Mul16x8S
	lda.b $35
	clc
	adc.b d0
	sta.b d3
	tyx
	cpx.w #$001C
	beq .1
	jmp.w .10
.1:									; A = $1000, if d2 < 0 go to .2, go to .14
	lda.w #$1000
	trb.w sflags
	lda.b d2
	bmi .2
	jmp.w .14
.2:									; A / 2, A / 2, if $2000 bits clear go to .3, A or $C000
	lsr a
	lsr a
	bit.w #$2000
	beq .3
	ora.w #$C000
.3:									; d2 = A, A - $FC00, if the result >= 0 go to .7, call RandomWord, ...
	sta.b d2
	sec
	sbc.w #$FC00
	bpl .7
	jsl.l RandomWord
	and.w #$07FF
	eor.w #$FFFF
	inc a
	sta.w puckvz
	sta.b d0
	jsl.l puckflip
	lda.w puckvx
	ldy.w puckvy
	jsl.l ApproxLength
	and.w #$7F00
	sta.b tmp0
	xba
	tsb.b tmp0
	bit.w puckx
	bpl .4
	sep #$20
	lsr a
	lsr a
	sta.b $A0
	bra .5
.4:									; A 8-bit, A / 2, A / 2, tmp0 = A
	sep #$20
	lsr a
	lsr a
	sta.b tmp0
.5:									; A 16-bit, A = $0003, if puckz >= $000B go to .6, A = $0003
	rep #$20
	lda.w #$0003
	ldy.w puckz
	cpy.w #$000B
	bcs .6
	lda.w #$0003
.6:									; call StartSoundVolume
	jsl.l StartSoundVolume
.7:									; A = d3, A / 2, A / 2, A / 2, ...
	lda.b d3
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	bit.w #$0200
	beq .8
	ora.w #$FC00
.8:									; d0 = A, push A, A * 2, pull A, ...
	sta.b d0
	pha
	asl a
	pla
	ror a
	sta.b $81
	lda.b d3
	sec
	sbc.b d0
	sec
	sbc.b $81
	sta.b d3
	bra .13
.9:									; go to .14
	jmp.w .14
.10:								; A = d2, A - $03E8, if the result >= 0 go to .9, A = d2, ...
	lda.b d2
	sec
	sbc.w #$03E8
	bpl .9
	lda.b d2
	sec
	sbc.w #$F000
	bpl .11
	lda.w impact,x
	sec
	sbc.w #$000A
	bmi .11
	lda.w Xvel,x
	sta.b p0
	lda.w Yvel,x
	sta.b $3A
	lda.w #$0003
	jsl.l StartSound
.11:								; A = d2, A / 2, A / 2, if $2000 bits clear go to .12, ...
	lda.b d2
	lsr a
	lsr a
	bit.w #$2000
	beq .12
	ora.w #$C000
.12:								; d2 = A, A - $FC7C, if the result < 0 go to .13, d2 = $FC18
	sta.b d2
	sec
	sbc.w #$FC7C
	bmi .13
	lda.w #$FC18
	sta.b d2
.13:								; A = $01,s, X = d3, call Mul16x8S, tmp0 = $35, ...
	lda.b $01,s
	ldx.b d3
	jsl.l Mul16x8S
	lda.b $35
	sta.b tmp0
	lda.b $03,s
	ldx.b d2
	jsl.l Mul16x8S
	lda.b tmp0
	sec
	sbc.b $35
	ldx.b a3
	sta.w Xvel,x
	lda.b $03,s
	ldx.b d3
	jsl.l Mul16x8S
	lda.b $35
	sta.b d3
	lda.b $01,s
	ldx.b d2
	jsl.l Mul16x8S
	lda.b $35
	clc
	adc.b d3
	ldx.b a3
	sta.w Yvel,x
	lda.w puckvz
	bmi .14
	stz.w puckvz
.14:								; pull A, pull A, pull A, d3 = A, ...
	pla
	pla
	pla
	sta.b d3
	pla
	sta.b d2
	cpx.w #$001C
	bne .rtl
	lda.w puckc
	bpl .rtl
	jsl.l EndPenaltyShot
	stz.w breakaway
	stz.w onetimer
.rtl:								; return
	rtl
checkgoal:							; from checkwallcoll and other segments
	cpx.w #$001C
	beq .1
	jmp.w checkgoalp
.1:									; if puckc < 0 go to .2, if position,y = 0 go to .rtl
	ldy.w puckc
	bmi .2
	lda.w position,y
	beq .rtl
.2:									; if puckz - $000D >= 0 go to .rtl, Y = a2, A = d2, A - Xpos,y, ...
	lda.w puckz
	cmp.w #$000D
	bpl .rtl
	ldy.b a2
	lda.b d2
	sec
	sbc.w Xpos,y
	sta.b d2
	cmp.w #$0017
	bpl .rtl
	lda.b d2
	cmp.w #$FFEA
	bmi .rtl
	lda.w #$0009
	sta.b d5
	lda.b d3
	sec
	sbc.w Ypos,y
	sta.b d3
	cmp.w #$000A
	bpl .rtl
	lda.w #$0000
	sec
	sbc.b d5
	sta.b d5
	lda.b d3
	cmp.w #$FFF7
	bmi .rtl
	lda.w #$FFFF
	sta.w collflag
	lda.w puckoldz
	cmp.w #$000D
	bmi .3
	lda.w puckoldz
	sta.w puckz
	jmp.w .18
.rtl:								; return
	rtl
.3:									; pfgoal+28 = 0, if puckc < 0 go to .5, Y = A, puckc = $FFFF, ...
	stz.w pfgoal+28
	lda.w puckc
	bmi .5
	tay
	lda.w #$FFFF
	sta.w puckc
	lda.w #$0008
	sta.w nopuck,y
	lda.w pucky
	sta.b d1
	lda.w pfgoal,y
	bne .4
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
.4:									; if d1 >= 0 go to .5, pfgoal+28 = $0001
	lda.b d1
	bpl .5
	lda.w #$0001
	sta.w pfgoal+28
.5:									; d0 = $FF01, p0 = $FF01, A = Yfrac,x, A - OldYfrac,x, ...
	lda.w #$FF01
	sta.b d0
	lda.w #$FF01
	sta.b p0
	lda.w Yfrac,x
	sec
	sbc.w OldYfrac,x
	sta.b d1
	lda.w Ypos,x
	sbc.w OldYpos,x
	sta.b $85
	lda.b $84
	sta.b d1
	cmp.w #$0000
	beq .9
	bmi .6
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b p0
	sta.b p0
	lda.w #$0000
	sec
	sbc.b d5
	sta.b d5
.6:									; A = d5, A + d3, d5 = A, r2 = A, ...
	lda.b d5
	clc
	adc.b d3
	sta.b d5
	sta.b r2
	lda.w Xfrac,x
	sec
	sbc.w OldXfrac,x
	sta.b d3
	lda.w Xpos,x
	sbc.w OldXpos,x
	sta.b $8D
	lda.b $8C
	sta.b d3
	ldx.b r2
	jsl.l Mul16S
	ldx.b a3
	lda.b d1
	bit.w #$8000
	beq .7
	eor.w #$FFFF
	inc a
.7:									; r1 = A, A = $36, if $8000 bits clear go to .8, A xor $FFFF, ...
	sta.b r1
	lda.b $36
	bit.w #$8000
	beq .8
	eor.w #$FFFF
	inc a
.8:									; if A >= r1 go to .9, r1 = d1, call Div32S, d5 = r0, ...
	cmp.b r1
	bcs .9
	lda.b d1
	sta.b r1
	jsl.l Div32S
	lda.b r0
	sta.b d5
	ldx.b a3
	lda.b d2
	sec
	sbc.b d5
	sta.b d2
	cmp.w #$FFEA
	bmi .9
	lda.b d2
	cmp.w #$0017
	bmi .14
.9:									; go to .20
	jmp.w .20
.10:								; if puckvy - $0800 >= 0 go to .12, if puckvy - $F800 < 0 go to .12, ...
	lda.w puckvy
	cmp.w #$0800
	bpl .12
	cmp.w #$F800
	bmi .12
	cmp.w #$0000
	bpl .11
	lda.w #$F800
	sta.w puckvy
	bra .12
.11:								; puckvy = $0800
	lda.w #$0800
	sta.w puckvy
.12:								; go to wallcoll
	jmp.w wallcoll
.13:								; go to Goal
	jmp.w Goal
.14:								; d1 = 0, A = pucky, if the result < 0 go to .10, A = $0000, ...
	stz.b d1
	lda.w pucky
	eor.b p0
	bmi .10
	lda.w #$0000
	sec
	sbc.b p0
	sta.b p0
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w pfgoal+28
	bne .10
	lda.w puckz
	cmp.w #$000D
	beq .15
	lda.b d2
	cmp.w #$0012
	bpl .15
	lda.b d2
	cmp.w #$FFEF
	bpl .13
.15:								; call ChkShotStat, breakaway = 0, onetimer = 0, A = $000C, ...
	jsl.l ChkShotStat
	stz.w breakaway
	stz.w onetimer
	lda.w #$000C
	jsl.l StartSound
	lda.l Crowdlevel
	clc
	adc.w #$012C
	sta.l Crowdlevel
	lda.w #$003C
	sta.b crowdhold
	lda.w CwdExciteLvl
	clc
	adc.w #$0028
	bmi .16
	sta.w CwdExciteLvl
.16:								; call RandomWord, A and $0FFF, d0 = A, if pucky < 0 go to .17, ...
	jsl.l RandomWord
	and.w #$0FFF
	sta.b d0
	lda.w pucky
	bmi .17
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.17:								; puckvy = d0, call RandomWord, A and $1FFF, A - $1000, ...
	lda.b d0
	sta.w puckvy
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w puckvx
	jsl.l RandomWord
	and.w #$1FFF
	sec
	sbc.w #$1000
	sta.w puckvz
	jmp.w puckflip
.18:								; A = puckvz, if $8000 bits clear go to .19, A xor $FFFF, A + 1
	lda.w puckvz
	bit.w #$8000
	beq .19
	eor.w #$FFFF
	inc a
.19:								; puckvz = A, return
	sta.w puckvz
	rtl
.20:								; if puckvx - $0800 >= 0 go to .22, if puckvx - $F800 < 0 go to .22, ...
	lda.w puckvx
	cmp.w #$0800
	bpl .22
	cmp.w #$F800
	bmi .22
	cmp.w #$0000
	bpl .21
	lda.w #$F800
	sta.w puckvx
	bra .22
.21:								; puckvx = $0800
	lda.w #$0800
	sta.w puckvx
.22:								; d0 = 0, d1 = $00FF, A = puckx, A - OldXpos+$1C, ...
	stz.b d0
	lda.w #$00FF
	sta.b d1
	lda.w puckx
	sec
	sbc.w OldXpos+$1C
	sta.b d2
	bmi .23
	lda.w #$FF01
	sta.b d1
.23:								; go to wallcoll
	jmp.w wallcoll
checkgoalp:							; from checkgoal
	lda.w pflags,x
	bit.w #$8000
	bne .rtl
	cpx.w #$0017
	bcc .1
.rtl:								; return
	rtl
.1:									; if a2 = $0018 go to .2, A = d3, A - wcradiusy, ...
	ldy.b a2
	cpy.w #$0018
	beq .2
	lda.b d3
	sec
	sbc.w wcradiusy
	cmp.w #$FF10
	bpl .rtl
	bra .3
.2:									; A = d3, A + wcradiusy, if A - $00F0 < 0 go to .rtl
	lda.b d3
	clc
	adc.w wcradiusy
	cmp.w #$00F0
	bmi .rtl
.3:									; A = d2, if $8000 bits clear go to .4, A xor $FFFF, A + 1
	lda.b d2
	bit.w #$8000
	beq .4
	eor.w #$FFFF
	inc a
.4:									; A - wcradiusx, if A - $0040 >= 0 go to .rtl, A = d3, push A, ...
	sec
	sbc.w wcradiusx
	cmp.w #$0040
	bpl .rtl
	lda.b d3
	pha
	sec
	sbc.w Ypos,y
	sta.b d3
	eor.w #$FFFF
	inc a
	sta.b d0
	lda.b d2
	pha
	sec
	sbc.w Xpos,y
	sta.b d1
	sta.b r1
	tax
	jsl.l Mul8S
	sta.b r2
	ldx.b a3
	lsr a
	lsr a
	cmp.w #$0101
	bcs .5
	sta.b d2
	lda.b d3
	sta.b $32
	tax
	jsl.l Mul8S
	asl a
	sta.b $36
	ldx.b a3
	clc
	adc.b d2
	cmp.w #$0101
.5:									; if carry set go to .10, pull A, d2 = A, pull A, ...
	bcs .10
	pla
	sta.b d2
	pla
	sta.b d3
	jsr.w CheckDislodgeGoal
	pei ($8B)
	pei ($87)
	lda.b r1
	ldy.b $32
	jsl.l ApproxLength
	inc a
	sta.b d2
	lda.b d0
	xba
	and.w #$FF00
	tax
	lda.b d2
	jsl.l DivX8S
	cmp.w #$00FF
	bmi .6
	lda.w #$00FF
.6:									; if A - $FF01 >= 0 go to .7, A = $FF01
	cmp.w #$FF01
	bpl .7
	lda.w #$FF01
.7:									; d0 = A, A = d1, A and $FF00, X = A, ...
	sta.b d0
	lda.b d1
	xba
	and.w #$FF00
	tax
	lda.b d2
	jsl.l DivX8S
	cmp.w #$00FF
	bmi .8
	lda.w #$00FF
.8:									; if A - $FF01 >= 0 go to .9, A = $FF01
	cmp.w #$FF01
	bpl .9
	lda.w #$FF01
.9:									; d1 = A, X = a3, call wallcoll
	sta.b d1
	ldx.b a3
	jsl.l wallcoll
.10:								; pull A, d2 = A, pull A, d3 = A, ...
	pla
	sta.b d2
	pla
	sta.b d3
	rtl
CheckDislodgeGoal:					; test a burst collision for dislodging the goal and a stoppage penalty
	pei ($7F)
	pei ($83)
	lda.w seed
	and.w #$01C0
	bne .1
	lda.w SPA,x
	cmp.w #$21BC
	bne .1
	ldy.b a2
	lda.w pucky
	sec
	sbc.w Ypos,y
	cmp.w #$FF80
	bmi .1
	cmp.w #$0080
	bpl .1
	lda.w Xvel,x
	sta.b d0
	lda.w Yvel,x
	sta.b d1
	cmp.w #$DFFF
	bmi .2
	cmp.w #$2001
	bpl .2
	lda.b d0
	cmp.w #$DFFF
	bmi .2
	cmp.w #$2001
	bpl .2
.1:									; pull A, d1 = A, pull A, d0 = A
	pla
	sta.b d1
	pla
	sta.b d0
.rts:								; return
	rts
.2:									; pull A, pull A, A = d0, A / 2, ...
	pla
	pla
	lda.b d0
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq .3
	ora.w #$E000
.3:									; d0 = A, A + d0, d0 = A, Y = a2, ...
	sta.b d0
	cmp.w #$8000
	ror a
	clc
	adc.b d0
	sta.b d0
	ldy.b a2
	sta.w Xvel,y
	lda.b d1
	lsr a
	lsr a
	lsr a
	bit.w #$1000
	beq .4
	ora.w #$E000
.4:									; d1 = A, A + d1, d1 = A, Yvel,y = A, ...
	sta.b d1
	cmp.w #$8000
	ror a
	clc
	adc.b d1
	sta.b d1
	sta.w Yvel,y
	stz.w Xvel,x
	stz.w Yvel,x
	lda.w #$0040
	tsb.w sflags
	lda.w gmclock
	bne .rts
	pla
	lda.w #$0008
	sta.b d0
	jmp.w AddPenalty2
checkplcoll:						; from checkcoll and other segments
	lda.w pflags,x
	bit.w #$8000
	bne .rtl
	cpx.w #$0018
	bcc .1
.rtl:								; return
	rtl
.1:									; d1 = OOlistpos,x
	lda.w OOlistpos,x
	sta.b d1
.loop:								; loop: if d1 = $000F go to .3, A = OOlist+1,y, A and $00FF, Y = A, ...
	ldy.b d1
	cpy.w #$000F
	beq .3
	lda.w OOlist+1,y
	and.w #$00FF
	tay
	lda.w Ylist,y
	sec
	sbc.b d3
	sec
	sbc.w #$000E
	bpl .3
	lda.w position,y
	bmi .2
	lda.w Xpos,y
	sec
	sbc.b d2
	cmp.w #$FFF1
	bmi .2
	cmp.w #$000F
	bpl .2
	lda.w pflags,y
	and.w #$8000
	ora.w pfnc,y
	bne .2
	cpy.w #$0018
	bcs .2
	jsl.l CollidePlayers
.2:									; d1 + 1, go to .loop
	inc.b d1
	bra .loop
.3:									; if OOlistpos,x = 0 go to .rtl2, d1 = A
	lda.w OOlistpos,x
	beq .rtl2
	sta.b d1
.loop2:								; loop: Y = d1, A = $10DF,y, A and $00FF, Y = A, ...
	ldy.b d1
	lda.w $10DF,y
	and.w #$00FF
	tay
	lda.b d3
	sec
	sbc.w Ylist,y
	sec
	sbc.w #$000E
	bpl .rtl2
	lda.w position,y
	bmi .4
	lda.w Xpos,y
	sec
	sbc.b d2
	cmp.w #$FFF1
	bmi .4
	cmp.w #$000F
	bpl .4
	lda.w pflags,y
	and.w #$8000
	ora.w pfnc,y
	bne .4
	cpy.w #$0018
	bcs .4
	jsl.l CollidePlayers
.4:									; d1 - 1, if the result is not 0 go to .loop2
	dec.b d1
	bne .loop2
.rtl2:								; return
	rtl
CollidePlayers:						; collides player X with player Y: their distance and closing speed, the
									; collision sound, checkint, checkcheck and the bounce
	pei ($7F)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($8B)
	pei ($8F)
	pei ($93)
	sty.b a2
	lda.w Xpos,y
	sec
	sbc.w Xpos,x
	sta.b d2
	lda.w Ypos,y
	sec
	sbc.w Ypos,x
	sta.b d3
	ldy.b d2
	jsl.l ApproxLength
	cmp.w #$0010
	bmi .1
	jmp.w .16
.1:									; Y = a2, A = Xvel,x, A - Xvel,y, d0 = A, ...
	ldy.b a2
	lda.w Xvel,x
	sec
	sbc.w Xvel,y
	sta.b d0
	lda.w Yvel,x
	sec
	sbc.w Yvel,y
	sta.b d1
	lda.b d0
	ora.b d1
	bne .2
	jmp.w .16
.2:									; A = d3, X = d1, call Mul16x8S, $85 = $36, ...
	pei ($83)
	pei ($7F)
	lda.b d3
	ldx.b d1
	jsl.l Mul16x8S
	lda.b $36
	sta.b $85
	lda.b r2
	sta.b d1
	lda.b d2
	ldx.b d0
	jsl.l Mul16x8S
	ldx.b a3
	lda.b r2
	clc
	adc.b d1
	sta.b d1
	lda.b $36
	adc.b $85
	sta.b $85
	bpl .3
	jmp.w .17
.3:									; if SPA,x < $2280 go to .5, if SPA,x >= $2345 go to .5, ...
	lda.w SPA,x
	cmp.w #$2280
	bcc .5
	cmp.w #$2345
	bcs .5
	stz.w pfalock,x
	stz.w pf2aip,x
	ldy.w impactp,x
	lda.w SPA,y
	cmp.w #$2280
	bcc .4
	cmp.w #$2345
	bcs .4
	lda.w #$0000
	sta.w pfalock,y
	sta.w pf2aip,y
.4:									; Y = a2
	ldy.b a2
.5:									; if SPA,y < $2280 go to .7, if SPA,y >= $2345 go to .7, ...
	lda.w SPA,y
	cmp.w #$2280
	bcc .7
	cmp.w #$2345
	bcs .7
	lda.w #$0000
	sta.w pfalock,y
	sta.w pf2aip,y
	ldx.w impactp,y
	lda.w SPA,x
	cmp.w #$2280
	bcc .6
	cmp.w #$2345
	bcs .6
	stz.w pfalock,x
	stz.w pf2aip,x
.6:									; X = a3
	ldx.b a3
.7:									; d1 = $84, if pfteam,x = pfteam,y go to .14, A = d1, A / 2, ...
	lda.b $84
	sta.b d1
	lda.w pfteam,x
	cmp.w pfteam,y
	beq .14
	lda.b d1
	lsr a
	lsr a
	lsr a
	lsr a
	cmp.w #$0005
	bcs .8
	lda.w #$0005
.8:									; d4 = A, if SPA,x < $2082 go to .10, if SPA,x >= $21BD go to .10
	sta.b d4
	lda.w SPA,x
	cmp.w #$2082
	bcc .10
	cmp.w #$21BD
	bcs .10
.9:									; A = d4, A / 2, A + d4, d4 = A, ...
	lda.b d4
	lsr a
	adc.b d4
	sta.b d4
	bra .11
.10:								; if SPA,y < $2082 go to .11, if SPA,y < $21BD go to .9
	lda.w SPA,y
	cmp.w #$2082
	bcc .11
	cmp.w #$21BD
	bcc .9
.11:								; A = d4, A + impact,x, impact,x = A, A = d4, ...
	lda.b d4
	clc
	adc.w impact,x
	sta.w impact,x
	lda.b d4
	clc
	adc.w impact,y
	sta.w impact,y
	txa
	sta.w impactp,y
	tya
	sta.w impactp,x
	lda.b d4
	cmp.w #$0014
	bcc .13
	cpx.w puckc
	beq .12
	cpy.w puckc
	bne .13
.12:								; call CollisionSfx
	jsl.l CollisionSfx
.13:								; call checkint, call checkcheck, pull A, d3 = A, ...
	pei ($83)
	pei ($87)
	pei ($8B)
	jsl.l checkint
	jsl.l checkcheck
	pla
	sta.b d3
	pla
	sta.b d2
	pla
	sta.b d1
.14:								; d4 = d1, pull A, d0 = A, pull A, ...
	lda.b d1
	sta.b d4
	pla
	sta.b d0
	pla
	sta.b d1
	lda.w collflag
	bpl .15
	jmp.w .16
.15:								; A = d2, X = d1, call Mul16x8S, $85 = $36, ...
	lda.b d2
	ldx.b d1
	jsl.l Mul16x8S
	lda.b $36
	sta.b $85
	lda.b r2
	sta.b d1
	lda.b d3
	ldx.b d0
	jsl.l Mul16x8S
	lda.b r2
	sec
	sbc.b d1
	sta.b d1
	lda.b $36
	sbc.b $85
	sta.b $85
	lda.b $84
	sta.b d5
	ldx.b a3
	lda.w weight,x
	clc
	adc.w #$008C
	sta.b d0
	ldy.b a2
	lda.w weight,y
	clc
	adc.w #$008C
	sta.b d1
	lda.b d1
	clc
	adc.b d0
	sta.b d1
	lda.b d0
	ldx.b d4
	jsl.l Mul16x8XS
	lda.b d1
	sta.b r1
	jsl.l Div32S
	lda.b r0
	sta.b d0
	sta.b d1
	lda.b d3
	ldx.b d5
	jsl.l Mul16x8S
	lda.b r2
	sta.b tmp0
	lda.b d2
	ldx.b d0
	jsl.l Mul16x8S
	lda.b r2
	clc
	adc.b tmp0
	ldx.b a3
	clc
	adc.w Xvel,y
	sta.w Xvel,x
	lda.b d2
	ldx.b d5
	jsl.l Mul16x8S
	lda.b r2
	sta.b tmp0
	lda.b d3
	ldx.b d0
	jsl.l Mul16x8S
	lda.b r2
	sec
	sbc.b tmp0
	ldx.b a3
	clc
	adc.w Yvel,y
	sta.w Yvel,x
	lda.b d2
	ldx.b d1
	jsl.l Mul16x8S
	lda.b r2
	clc
	adc.w Xvel,y
	sta.w Xvel,y
	lda.b d3
	ldx.b d1
	jsl.l Mul16x8S
	lda.b r2
	clc
	adc.w Yvel,y
	sta.w Yvel,y
	ldx.b a3
	lda.w #$FFFF
	sta.w collflag
.16:								; pull A, d5 = A, pull A, d4 = A, ...
	pla
	sta.b d5
	pla
	sta.b d4
	pla
	sta.b d3
	pla
	sta.b d2
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b d0
	rtl
.17:								; pull A, pull A, go to .16
	pla
	pla
	bra .16
checkpuckcoll:						; called from other segments
	lda.w puckz
	sec
	sbc.w #$0010
	bpl .rtl
	ldy.w $10DC
.loop:								; loop: d1 = Y, if Y = $000F go to .1, A = OOlist+1,y, A and $00FF, ...
	sty.b d1
	cpy.w #$000F
	beq .1
	lda.w OOlist+1,y
	and.w #$00FF
	tay
	lda.w Ylist,y
	sec
	sbc.w pucky
	sec
	sbc.w #$0028
	bpl .1
	jsl.l checkpuckcoll_ccx
	ldy.b d1
	iny
	bra .loop
.1:									; if $10DC = 0 go to .rtl
	ldy.w $10DC
	beq .rtl
.loop2:								; loop: d1 = Y, A = $10DF,y, A and $00FF, Y = A, ...
	sty.b d1
	lda.w $10DF,y
	and.w #$00FF
	tay
	lda.w pucky
	sec
	sbc.w Ylist,y
	sec
	sbc.w #$0028
	bpl .rtl
	jsl.l checkpuckcoll_ccx
	ldy.b d1
	dey
	bne .loop2
.rtl:								; return
	rtl
checkpuckcoll_ccx:					; puck collision with player Y: the stick (puckstick) when the puck is
									; low, slow and within reach of the frame's hot spot, else the body
									; (puckbody) when close
	sty.b a2
	cpy.w puckc
	beq .rtl
	cpy.w #$0018
	bcs .rtl
	lda.w position,y
	bmi .rtl
	lda.w pfnc,y
	ora.w nopuck,y
	beq .3
.rtl:								; return
	rtl
.1:									; go to .7
	jmp.w .7
.2:									; go to PuckCollisionStickRange
	jmp.w PuckCollisionStickRange
.3:									; continue
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
	lda.w pflags,y
	bit.w #$1000
	bne .1
	lda.w position,y
	beq .2
	lda.w puckz
	cmp.w #$0005
	bpl .1
	lda.w puckvz
	cmp.w #$0100
	bpl .1
	tya
	jsl.l GetFrameHot
	ldy.b a2
	lda.b d0
	clc
	adc.w Xpos,y
	sec
	sbc.w puckx
	bit.w #$8000
	beq .4
	eor.w #$FFFF
	inc a
.4:									; if A >= $000F go to .7, d0 = A, A = d1, A + Ypos,y, ...
	cmp.w #$000F
	bcs .7
	sta.b d0
	lda.b d1
	clc
	adc.w Ypos,y
	sec
	sbc.w pucky
	bit.w #$8000
	beq .5
	eor.w #$FFFF
	inc a
.5:									; if A >= $000F go to .7, A and $00FF, A * 2, X = A, ...
	cmp.w #$000F
	bcs .7
	and.w #$00FF
	asl a
	tax
	lda.l SquareTable,x
	sta.b d1
	lda.b d0
	and.w #$00FF
	asl a
	tax
	lda.b d1
	adc.l SquareTable,x
	sta.b d0
	ldx.b curobj
	lda.w #$00C4
	sta.b d1
	lda.w nopuck+28
	bmi .6
	beq .6
	lsr.b d1
	lsr.b d1
.6:									; if d1 < d0 go to .7, call puckstick, go to PuckCollisionRestore
	lda.b d1
	cmp.b d0
	bcc .7
	jsl.l puckstick
	bra PuckCollisionRestore
.7:									; if position,y is not 0 go to .8, go to PuckCollisionGoalieRange
	lda.w position,y
	bne .8
	jmp.w PuckCollisionGoalieRange
.8:									; A = Xpos,y, A - puckx, if $8000 bits clear go to .9, A xor $FFFF, ...
	lda.w Xpos,y
	sec
	sbc.w puckx
	bit.w #$8000
	beq .9
	eor.w #$FFFF
	inc a
.9:									; if A >= $000D go to PuckCollisionRestore, d0 = A, A = Ypos,y, A - pucky,
									; ...
	cmp.w #$000D
	bcs PuckCollisionRestore
	sta.b d0
	lda.w Ypos,y
	sec
	sbc.w pucky
	bit.w #$8000
	beq .10
	eor.w #$FFFF
	inc a
.10:								; if A >= $000D go to PuckCollisionRestore, A and $00FF, A * 2, d1 = A,
									; ...
	cmp.w #$000D
	bcs PuckCollisionRestore
	and.w #$00FF
	asl a
	sta.b d1
	lda.b d0
	and.w #$00FF
	asl a
	tax
	lda.l SquareTable,x
	ldx.b d1
	adc.l SquareTable,x
	sta.b d0
	ldx.b a3
	cmp.w #$0091
	bcs PuckCollisionRestore
	jsl.l puckbody
PuckCollisionRestore:				; restore saved puck collision scratch words and return
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
	rtl
PuckCollisionGoalieRange:			; test the close puck-to-player range before puckgoalie
	lda.w Xpos,y
	sec
	sbc.w puckx
	sta.b d0
	cmp.w #$FFF5
	bmi PuckCollisionRestore
	cmp.w #$000B
	bpl PuckCollisionRestore
	lda.w Ypos,y
	sec
	sbc.w pucky
	sta.b d1
	cmp.w #$FFF5
	bmi PuckCollisionRestore
	cmp.w #$000B
	bpl PuckCollisionRestore
	jsl.l puckgoalie
	bra PuckCollisionRestore
DATA8_C44CDD:						; not traced: a table read by PuckCollisionStickRange,
									; PuckCollisionStickRange
	db $00,$00,$01,$00,$01,$00,$02,$00,$03,$00,$03,$00,$04,$00,$05,$00
	db $05,$00,$06,$00,$07,$00,$07,$00,$08,$00,$09,$00,$09,$00,$0A,$00
	db $0B,$00,$0B,$00,$0C,$00,$0D,$00,$0D,$00,$0E,$00,$0F,$00,$0F,$00
	db $10,$00,$11,$00,$11,$00,$12,$00,$13,$00,$13,$00,$14,$00,$15,$00
	db $15,$00,$16,$00,$17,$00,$17,$00,$18,$00,$19,$00,$19,$00,$1A,$00
	db $1B,$00,$1B,$00,$1C,$00,$1D,$00,$1D,$00,$1E,$00,$1F,$00,$1F,$00
PuckCollisionStickRange:			; test the frame hotspot reach and puck height for stick contact
	tya
	jsl.l GetFrameHot
	lda.b d0
	bit.w #$8000
	beq .1
	eor.w #$FFFF
	inc a
.1:									; d2 = A, A * 2, X = A, d4 = DATA8_C44CDD,x, ...
	sta.b d2
	asl a
	tax
	lda.l DATA8_C44CDD,x
	sta.b d4
	lda.b d1
	bit.w #$8000
	beq .2
	eor.w #$FFFF
	inc a
.2:									; A * 2, X = A, d3 = DATA8_C44CDD,x, X = curobj, ...
	asl a
	tax
	lda.l DATA8_C44CDD,x
	sta.b d3
	ldx.b curobj
	lda.b a2
	jsl.l GetFrameHot
	ldy.b a2
	lda.b d0
	clc
	adc.w Xpos,y
	sec
	sbc.w puckx
	bit.w #$8000
	beq .3
	eor.w #$FFFF
	inc a
.3:									; if A >= d2 go to .6, d0 = A, A = d1, A + Ypos,y, ...
	cmp.b d2
	bcs .6
	sta.b d0
	lda.b d1
	clc
	adc.w Ypos,y
	sec
	sbc.w pucky
	bit.w #$8000
	beq .4
	eor.w #$FFFF
	inc a
.4:									; if A >= d2 go to .6, d1 = A, A = d3, A + d4, ...
	cmp.b d2
	bcs .6
	sta.b d1
	lda.b d3
	clc
	adc.b d4
	cmp.w #$0005
	bpl .5
	lda.w #$0005
.5:									; if A < puckz go to .6, A = d3, A - d4, if the result < 0 go to .7, ...
	cmp.w puckz
	bcc .6
	lda.b d3
	sec
	sbc.b d4
	bmi .7
	cmp.w puckz
	bcc .7
.6:									; go to PuckCollisionGoalieRange
	jmp.w PuckCollisionGoalieRange
.7:									; A = d0, A and $00FF, A * 2, X = A, ...
	lda.b d0
	and.w #$00FF
	asl a
	tax
	lda.l SquareTable,x
	sta.b d0
	lda.b d1
	and.w #$00FF
	asl a
	tax
	lda.l SquareTable,x
	adc.b d0
	sta.b d0
	lda.b d2
	and.w #$00FF
	asl a
	tax
	lda.l SquareTable,x
	ldx.b curobj
	sta.b d1
	lda.w nopuck+28
	bmi .8
	beq .8
	lsr.b d1
	lsr.b d1
.8:									; if d1 < d0 go to .9, call puckstick
	lda.b d1
	cmp.b d0
	bcc .9
	jsl.l puckstick
.9:									; go to PuckCollisionGoalieRange
	jmp.w PuckCollisionGoalieRange
puckglue:							; give player a2 puck possession and update possession statistics and
									; control
	ldy.b a2
	cpy.w puckc
	beq .1
	jsl.l EndPenaltyShot
	stz.w breakaway
	stz.w onetimer
.1:									; puckc = a2, puckvz = 0, puckz = 0, if SPA,y < $224E go to .2, ...
	ldy.b a2
	sty.w puckc
	stz.w puckvz
	stz.w puckz
	lda.w SPA,y
	cmp.w #$224E
	bcc .2
	cmp.w #$22B3
	bcs .2
	lda.w #$FFFF
	sta.w puckc
.2:									; d0 = Y, a0 = 0, a1 = $0002, if pfteam,y is not 0 go to .3, ...
	sty.b d0
	stz.b a0
	lda.w #$0002
	sta.b a1
	lda.w pfteam,y
	bne .3
	stz.b a1
	lda.w #$0002
	sta.b a0
.3:									; Y = a0, tmtouch2,y = $FFFF, tmtouch3,y = A, A = tmflags,y, ...
	ldy.b a0
	lda.w #$FFFF
	sta.w tmtouch2,y
	sta.w tmtouch3,y
	lda.w tmflags,y
	ora.w #$0004
	sta.w tmflags,y
	lda.w #$0010
	trb.w sflags3
	beq .4
	ldy.b a1
	lda.w tmfowon,y
	inc a
	sta.w tmfowon,y
	lda.l Crowdlevel
	clc
	adc.w #$00C8
	sta.l Crowdlevel
	lda.w #$0014
	sta.b crowdhold
.4:									; if gmclock is not 0 go to .5, ...
	lda.w gmclock
	bne .5
	lda.b a2
	cmp.w passReceiverPlayerNum
	bne .5
	ldy.b a1
	lda.w tmpasscomp,y
	inc a
	sta.w tmpasscomp,y
.5:									; A = $000C, Y = a2, if position,y is not 0 go to .6, ...
	lda.w #$000C
	trb.w sflags
	ldy.b a2
	lda.w position,y
	bne .6
	jsl.l ChkShotStat
	ldy.b a2
	lda.w #$008C
	sta.w temp5,y
	lda.w SPA,y
	cmp.w #$1552
	bne .6
	lda.w #$0005
	sta.w temp5,y
.6:									; if a2 is not passReceiverPlayerNum go to .7, Y = a1, d4 = passpad,y, ...
	lda.b a2
	cmp.w passReceiverPlayerNum
	bne .7
	ldy.b a1
	lda.w passpad,y
	sta.b d4
	bmi .7
	jsl.l AssignPadIfFree
	bra .8
.7:									; call PuckCarrierPad
	jsl.l PuckCarrierPad
.8:									; passReceiverPlayerNum = $FFFF, return
	lda.w #$FFFF
	sta.w passReceiverPlayerNum
	rtl
CollisionSfx:						; the collision sound of players X and Y: sound driver command 4, its
									; volume from their relative speed (ApproxLength), a random pitch
	phx
	phy
	sec
	lda.w Xvel,x
	sbc.w Xvel,y
	pha
	sec
	lda.w Yvel,x
	sbc.w Yvel,y
	tay
	pla
	jsl.l ApproxLength
	xba
	and.w #$00F0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	lsr a
	tsb.b tmp0
	lda.w #$0014
	jsl.l RandomBelowA
	sec
	sbc.w #$000A
	xba
	ora.b tmp0
	tay
	ldx.w #$0008
	lda.w #$0004
	jsl.l QueueSoundCmd
	ply
	plx
	rtl

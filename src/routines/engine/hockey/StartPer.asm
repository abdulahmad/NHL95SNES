StartPer:							; starts a period: the stack reset (not in the shootout), both teams'
									; energy full (reenergizeteam), then the period set up
	lda.w shootoutmode
	bne .1
	lda.w #$1FFF
	tcs
.1:									; a2 = 0, call reenergizeteam, a2 = $0002, call reenergizeteam, ...
	stz.b a2
	jsl.l reenergizeteam
	lda.w #$0002
	sta.b a2
	jsl.l reenergizeteam
	jsl.l setupice_reset
	jsl.l ResetClock
	jsl.l InitCrowdExcite
	lda.w #$FFFF
	sta.w sfpj
	lda.w cont1team
	ora.w cont2team
	ora.w cont3team
	ora.w cont4team
	ora.w cont5team
	bne .2
	jsl.l SoundVolumeUp
.2:									; if pregamepause = 0 go to .3, Y = $5800, call ClearVRAM, call startpause
	lda.w pregamepause
	beq .3
	ldy.w #$5800
	jsl.l ClearVRAM
	jsl.l startpause
.3:									; fox = 0, foy = 0, a3 = $001C, d0 = $001B, ...
	stz.w fox
	stz.w foy
	ldx.w #$001C
	stx.b a3
	lda.w #$001B
	sta.b d0
	jsl.l assreplace
	jsl.l ClearTextMap
	lda.w #$0400
	tsb.w sflags
	lda.w #$FFFF
	sta.w recsfx
	sta.w recsfx2
	sta.w percue
	lda.w OptPlayMode
	cmp.w #$0004
	beq .4
	lda.w #$0010
	trb.w sflags
	lda.w #$007F
	sta.w recbpr+2
	stz.w recbpr
	bra .5
.4:									; percue = 0
	stz.w percue
.5:									; textdirtylo = $FFFF, textdirtyhi = 0, Vcount = 0, $5F = 0, ...
	lda.w #$FFFF
	sta.w textdirtylo
	stz.w textdirtyhi
	stz.b Vcount
	stz.b $5F
	stz.w lastframevc
	stz.w OldVcount
	lda.w shootoutmode
	beq Gameloop
	rtl

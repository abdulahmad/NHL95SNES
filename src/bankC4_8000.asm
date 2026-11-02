; Segment bankC4_8000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C47FB5
updatepentime:						; called from other segments
	lda.w #$0020
	trb.w sflags3
	lda.w gmclock
	beq .1
	jmp.w PenaltyTimeReturn
.1:									; if PenShotActive = 0 go to .2, go to PenaltyTimeReturn
	lda.w PenShotActive
	beq .2
	jmp.w PenaltyTimeReturn
.2:									; A = Penaltytimer, Y = d7, Y - 1, if the result = 0 go to .3, ...
	lda.w Penaltytimer
	ldy.b d7
	dey
	beq .3
	dec a
.3:									; A - 1, Penaltytimer = A, if plus go to PenaltyTimeReturn, A + $0018, ...
	dec a
	sta.w Penaltytimer
	bpl PenaltyTimeReturn
	clc
	adc.w #$0018
	sta.w Penaltytimer
	lda.w #$0020
	tsb.w sflags3
	jsl.l chkatop
	jsl.l CountPowerPlayTime
	stz.b a2
	jsl.l UpdateTeamPenaltyTimes
	lda.w #$0002
	sta.b a2
UpdateTeamPenaltyTimes:				; start the penalty clock update for team a2
	lda.b a2
	beq .1
	lda.w #$001A
.1:									; a0 = A, $69 = 0, a1 = mesarea, d1 = $0002, ...
	sta.b a0
	stz.b $69
	lda.w #mesarea
	sta.b a1
	lda.w #$0002
	sta.b d1
	sta.b d3
UpdatePenaltyListEntry:				; tick the next active penalty in the team box list
	ldy.b a0
	lda.w tmboxlist,y
	inc.b a0
	and.w #$00FF
	sta.b d0
	bit.w #$0080
	bne CheckTimedPenaltyReleases
	lda.b a2
	beq .1
	lda.w #$0034
.1:									; A + d0, Y = A, A = tmpdst,y, if a $4000 bit set go to
									; UpdateCoincidentalPenalty, ...
	clc
	adc.b d0
	tay
	lda.w tmpdst,y
	bit.w #$4000
	bne UpdateCoincidentalPenalty
	dec.b d1
	bmi UpdatePenaltyListEntry
	lda.b d0
	sta.b [a1]
	inc.b a1
	inc.b a1
	lda.w tmpdst,y
	dec a
	sta.w tmpdst,y
	bne .2
	jsl.l RemovePlayerFromList
.2:									; go to UpdatePenaltyListEntry
	bra UpdatePenaltyListEntry
PenaltyTimeReturn:					; return from the penalty clock update
	rtl
CheckTimedPenaltyReleases:			; check the players whose ordinary penalties were timed for release
	lda.w mesarea
	sta.b d0
	lda.b d1
	cmp.w #$0001
	beq ReleaseExpiredPenalty
	lda.b d1
	bne .1
	jsl.l ReleaseExpiredPenalty
	bra .2
.1:									; if d1 is not $FFFF go to PenaltyTimeReturn
	lda.b d1
	cmp.w #$FFFF
	bne PenaltyTimeReturn
.2:									; d0 = $04F7
	lda.w mesarea+2
	sta.b d0
ReleaseExpiredPenalty:				; release the selected player when the penalty time reaches zero
	lda.b a2
	beq .1
	lda.w #$0034
.1:									; A + d0, Y = A, if tmpdst,y - $0006 >= 0 go to PenaltyTimeReturn, ...
	clc
	adc.b d0
	tay
	lda.w tmpdst,y
	cmp.w #$0006
	bpl PenaltyTimeReturn
	lda.w tmpdst,y
	bne .rtl
	jsl.l releasepl
.rtl:								; return
	rtl
UpdateCoincidentalPenalty:			; tick a coincidental penalty and advance or finish its timed state
	dec a
	sta.w tmpdst,y
	bit.w #$0800
	bne .1
	jmp.w UpdatePenaltyListEntry
.1:									; if a $1000 bit set go to .2, tmpdst,y = $1000, ...
									; RemovePlayerFromList
	bit.w #$1000
	bne .2
	lda.w #$1000
	sta.w tmpdst,y
	jml.l RemovePlayerFromList
.2:									; tmpdst,y = $0000, go to RemovePlayerFromList
	lda.w #$0000
	sta.w tmpdst,y
	jml.l RemovePlayerFromList
PenShotChk:							; called from other segments
	lda.w gmode
	bit.w #$0010
	bne .3
	lda.b a2
	cmp.w puckc
	bne .3
	lda.w breakaway
	bne .1
	jmp.w .3
.1:									; call CheckBreakaway, breakaway = IsBreakaway, ...
	jsl.l CheckBreakaway
	lda.w IsBreakaway
	sta.w breakaway
	bne .2
	jmp.w .3
.2:									; A = $FFFF, go to .rtl
	lda.w #$FFFF
	bra .rtl
.3:									; A = $0000
	lda.w #$0000
.rtl:								; return
	rtl
releasepl:							; return the released penalty player to an available on-ice slot
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	pei ($8B)
	pei ($8D)
	pei ($63)
	pei ($65)
	pei ($67)
	pei ($69)
	pei ($6B)
	pei ($6D)
	pei ($6F)
	pei ($71)
	ldy.b a2
	ldx.w tmsort,y
	dex
	dex
.loop:								; loop: X + 1, X + 1, if position,x >= 0 go to .loop, A = d0, ...
	inx
	inx
	lda.w position,x
	bpl .loop
	lda.b d0
	lsr a
	sta.b d3
	ldy.b a2
	lda.w tmap,y
	sta.b d1
	inc a
	sta.w tmap,y
	lda.w #$0001
	tsb.w tmflags
	tsb.w tmflags+2
	lda.w #$00C0
	sta.b $65
	lda.w #$9B2A
	sta.b a0
	lda.w tmgoalie,y
	bpl .1
	inc.b a0
.1:									; Y = d1, A = [a0],y, A and $00FF, position,x = A, ...
	ldy.b d1
	lda.b [a0],y
	and.w #$00FF
	sta.w position,x
	stx.b a3
	jsl.l Setplass
	jsl.l setplayer
	lda.w pflags,x
	ora.w #$1000
	sta.w pflags,x
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
ClearPenaltyBuffer:					; clears the 32 words of PenBuf
	phx
	ldx.w #$003E
.loop:								; loop: PenBuf,x = 0, X - 1, X - 1, if the result >= 0 go to .loop, ...
	stz.w PenBuf,x
	dex
	dex
	bpl .loop
	plx
	rtl
checkagr:							; called from other segments
	lda.w #$0014
	sec
	sbc.w aggress,x
	asl a
	asl a
	asl a
	asl a
	sta.b d0
	lda.w playerpad,x
	bmi .1
	asl.b d0
.1:									; A = Xpos,x, A - puckx, if A - $FFD7 < 0 go to .2, ...
	lda.w Xpos,x
	sec
	sbc.w puckx
	cmp.w #$FFD7
	bmi .2
	cmp.w #$0029
	bpl .2
	lda.w Ypos,x
	sec
	sbc.w pucky
	cmp.w #$FFD7
	bmi .2
	cmp.w #$0029
	bpl .2
	lsr.b d0
.2:									; go to randomd0
	jml.l randomd0
prefmes:							; the message for penalty d0 (negative: none): penmsgbox cleared, then its
									; text from Penaltylist in a frame (with the player's short name in
									; horizontal mode); penmsgbox = 1
	lda.w penmsgbox
	beq .1
	stz.w penmsgbox
.1:									; if d0 >= 0 go to .2, return
	ldx.b d0
	bpl .2
	rtl
.2:									; A = Penaltylist,x, X = A, A = DATA8_C3449B,x, A and $00FF, ...
	lda.l Penaltylist,x
	tax
	lda.l DATA8_C3449B,x
	and.w #$00FF
	dec a
	beq .rtl
	phx
	ldx.w sfhormode
	beq .3
	jsl.l CloseLCBoxes
	ldx.w #$0012
	ldy.w #$0003
	lda.w #$584A
	jsl.l Framer
	jsl.l RosterPlayerShortName
	ldy.w #$588B
	jsl.l QueueVRAMDMALen
	ldy.w #$586B
	bra .4
.3:									; X = A, X + 1, X + 1, X + 1, ...
	tax
	inx
	inx
	inx
	txa
	asl a
	sta.w $1541
	ldy.w #$0002
	lda.w #$5941
	jsl.l Framer
	ldy.w #$5962
.4:									; pull A, A + $449B, X = $00C3, call QueueVRAMDMALen, ...
	pla
	clc
	adc.w #$449B
	ldx.w #$00C3
	jsl.l QueueVRAMDMALen
	lda.w #$0001
	sta.w penmsgbox
.rtl:								; return
	rtl
CheckInjury:						; counts InjCntDown down; at 0, ShowInjuryBox
	dec.w InjCntDown
	bne .rtl
	jmp.w ShowInjuryBox
.rtl:								; return
	rtl
setInjuryType:						; called from other segments
	ldy.b a2
	lda.w pflags,y
	ora.w #$1000
	sta.w pflags,y
	lda.l Crowdlevel
	clc
	adc.w #$012C
	sta.l Crowdlevel
	lda.w #$003C
	sta.b crowdhold
	lda.w #$000A
	jsl.l StartSound
	ldy.b a2
	lda.w Xpos,y
	sta.w xc1
	lda.w Ypos,y
	sta.w yc1
	lda.w #$0040
	tsb.w sflags
	stz.b d1
	stz.b a0
	lda.w pfteam,y
	beq .1
	lda.w #$8000
	sta.b d1
	lda.w #$0002
	sta.b a0
.1:									; A = pnum,y, A and $00FF, A or d1, TempPlOffset = A, ...
	lda.w pnum,y
	and.w #$00FF
	ora.b d1
	sta.w TempPlOffset
	and.w #$00FF
	bit.w #$0080
	beq .2
	ora.w #$FF00
.2:									; A * 2, d1 = A, if a0 = 0 go to .3, A = $0034
	asl a
	sta.b d1
	lda.b a0
	beq .3
	lda.w #$0034
.3:									; A + d1, Y = A, tmpdst,y = $FFFD, A = $0007, ...
	adc.b d1
	tay
	lda.w #$FFFD
	sta.w tmpdst,y
	lda.w #$0007
	jsl.l randoma8
	cmp.w #$0000
	bne .rtl
	lda.w #$FFFC
	sta.w tmpdst,y
	lda.w TempPlOffset
	ora.w #$4000
	sta.w TempPlOffset
.rtl:								; return
	rtl
ShowInjuryBox:						; the injury box: a frame, its two texts (a third one when TempPlOffset
									; has bit $4000) and the injured player's short name
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
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
	inc.w $18AA
	lda.w #$58CA
	ldx.w #$0012
	ldy.w #$0004
	jsl.l Framer
	lda.w #$5F1D
	ldx.w #$00C3
	ldy.w #$590B
	jsl.l QueueVRAMDMALen
	lda.w #$5F28
	ldx.w #$00C3
	ldy.w #$58EB
	jsl.l QueueVRAMDMALen
	lda.w TempPlOffset
	bit.w #$4000
	beq .1
	and.w #$BFFF
	sta.w TempPlOffset
	lda.w #$5F37
	ldx.w #$00C3
	ldy.w #$58F3
	jsl.l QueueVRAMDMALen
.1:									; call RosterPlayerShortName, Y = $592B, call QueueVRAMDMALen, pull A, ...
	jsl.l RosterPlayerShortName
	ldy.w #$592B
	jsl.l QueueVRAMDMALen
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
checkob:							; called from other segments
	lda.w gmode
	bit.w #$0020
	bne .1
	jmp.w .rtl
.1:									; d0 = $0005, Y = $0000, if X < $000C go to .2, Y = $000C
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($63)
	pei ($65)
	lda.w #$0005
	sta.b d0
	ldy.w #$0000
	cpx.w #$000C
	bcc .2
	ldy.w #$000C
.2:									; a0 = Y, d1 = $0060, if pfgoal,x = 0 go to .3, go to .8
	sty.b a0
	lda.w #$0060
	sta.b d1
	lda.w pfgoal,x
	beq .3
	jmp.w .8
.3:									; d1 = $FFA0, A - pucky, if the result = 0 go to .loop, if plus go to .5
	lda.w #$FFA0
	sta.b d1
	sec
	sbc.w pucky
	beq .loop
	bpl .5
.loop:								; loop: Y = a0, if position,y < 0 go to .4, A = d1, A - Ypos,y, ...
	ldy.b a0
	lda.w position,y
	bmi .4
	lda.b d1
	sec
	sbc.w Ypos,y
	beq .4
	bpl .7
.4:									; a0 + 1, a0 + 1, d0 - 1, if the result >= 0 go to .loop
	inc.b a0
	inc.b a0
	dec.b d0
	bpl .loop
.5:									; d0 = $0040, A = $8000, if zero go to .6, ...
	lda.w #$0040
	sta.b d0
	lda.w #$8000
	trb.w sflags
	beq .6
	lda.w refwindow
	bne .6
	jsl.l ClearTextMapTop
.6:									; pull A, $65 = A, pull A, a0 = A, ...
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
.rtl:								; return
	rtl
.7:									; tmp0 = $0014, A = $8000, if not zero go to .6, ...
	lda.w #$0014
	sta.w tmp0
	lda.w #$8000
	tsb.w sflags
	bne .6
	lda.w RefCnt
	bpl .6
	phx
	jsl.l PushRef
	plx
	bra .6
.8:									; if d1 - pucky < 0 go to .5
	lda.b d1
	cmp.w pucky
	bmi .5
.loop2:								; loop: Y = a0, if position,y < 0 go to .9, if d1 - Ypos,y < 0 go to .7
	ldy.b a0
	lda.w position,y
	bmi .9
	lda.b d1
	cmp.w Ypos,y
	bmi .7
.9:									; a0 + 1, a0 + 1, d0 - 1, if the result >= 0 go to .loop2, ...
	inc.b a0
	inc.b a0
	dec.b d0
	bpl .loop2
	bra .5
a2touchpuck:						; called from other segments
	ldy.b a2
	cpy.w #$0018
	bcc .1
	jmp.w .rtl
.1:									; ltx = Xpos,y, lty = Ypos,y, A = Y, A / 2, ...
	lda.w Xpos,y
	sta.w ltx
	lda.w Ypos,y
	sta.w lty
	tya
	lsr a
	sta.w ltplayer
	stz.b a0
	lda.w pfteam,y
	beq .2
	inc.b a0
	inc.b a0
.2:									; d0 = pnum,y, Y = a0, if pnum,y = tmtouch1,y go to .6, A = tmflags,y, ...
	lda.w pnum,y
	sta.b d0
	ldy.b a0
	cmp.w tmtouch1,y
	beq .6
	lda.w tmflags,y
	bit.w #$0004
	beq .4
	and.w #$FFFB
	sta.w tmflags,y
	cpy.w #$0000
	bne .5
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi .3
	sta.w CwdExciteLvl
.3:									; go to .5
	bra .5
.4:									; tmtouch3,y = tmtouch2,y, tmtouch2,y = tmtouch1,y
	lda.w tmtouch2,y
	sta.w tmtouch3,y
	lda.w tmtouch1,y
	sta.w tmtouch2,y
.5:									; tmtouch1,y = d0, if d0 is not tmtouch3,y go to .6, tmtouch3,y = $FFFF
	lda.b d0
	sta.w tmtouch1,y
	cmp.w tmtouch3,y
	bne .6
	lda.w #$FFFF
	sta.w tmtouch3,y
.6:									; A = $1000, call a2offsides, Y = a2, A = iflags, ...
	lda.w #$1000
	trb.w sflags
	jsl.l a2offsides
	ldy.b a2
	lda.w iflags
	bit.w #$0004
	beq .9
	bit.w #$0001
	beq .9
	lda.w position,y
	beq .9
	lda.w iflags
	bit.w #$0002
	bne .8
	lda.w pfgoal,y
	beq .9
.7:									; push X, A = $07B7, A and $00FF, A * 2, ...
	phx
	lda.w $07B7
	and.w #$00FF
	asl a
	sta.b a3
	tax
	lda.w #$000C
	sta.b d0
	jsl.l AddPenalty
	plx
	stx.b a3
.rtl:								; return
	rtl
.8:									; if pfgoal,y = 0 go to .7
	lda.w pfgoal,y
	beq .7
.9:									; A = Y, A / 2, iflags = A, d0 = pucky, ...
	tya
	lsr a
	xba
	sta.w iflags
	lda.w pucky
	sta.b d0
	lda.w pfgoal,y
	beq .10
	lda.w #$0002
	tsb.w iflags
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.10:								; if d0 < 0 go to .rtl, A = tmap, A - $12C9, d0 = A, ...
	lda.b d0
	bmi .rtl
	lda.w tmap
	sec
	sbc.w $12C9
	sta.b d0
	lda.w pfteam,y
	beq .11
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.11:								; if d0 < 0 go to .rtl, A = $0004, return
	lda.b d0
	bmi .rtl
	lda.w #$0004
	tsb.w iflags
	rtl
a2offsides:							; from a2touchpuck and other segments
	ldy.b a2
	lda.w gmode
	bit.w #$0020
	beq .rtl
	lda.w pucky
	sta.b d0
	lda.w pfgoal,y
	bne .1
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.1:									; if d0 - $005C < 0 go to .rtl, a0 = 0, if pfteam,y = 0 go to .2, ...
	lda.b d0
	cmp.w #$005C
	bmi .rtl
	stz.b a0
	lda.w pfteam,y
	beq .2
	lda.w #$0002
	sta.b a0
.2:									; Y = a0, A = tmflags,y, if $0010 bits clear go to .rtl, A = gmode, ...
	ldy.b a0
	lda.w tmflags,y
	bit.w #$0010
	beq .rtl
	lda.w gmode
	bit.w #$0010
	bne .rtl
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
	lda.w #$0012
	sta.b d0
	jsl.l AddPenalty
	ldx.b a2
	ldy.b a3
	sty.b a2
	stx.b a3
.rtl:								; return
	rtl
CheckBreakaway:						; from StartBreakaway, PenShotChk and other segments
	stz.w IsBreakaway
	lda.w puckc
	bpl .1
	jmp.w .rtl
.1:									; A = gmode, if a $0002 bit set go to .2, ...
	lda.w gmode
	bit.w #$0002
	bne .2
	lda.w puckc
	cmp.w #$000C
	bmi .6
	bra .3
.2:									; if puckc - $000C < 0 go to .3, go to .6
	lda.w puckc
	cmp.w #$000C
	bmi .3
	bra .6
.3:									; Y = puckc, if Ypos,y >= 0 go to .rtl, A - $0004, d0 = A, ...
	ldy.w puckc
	lda.w Ypos,y
	bpl .rtl
	sec
	sbc.w #$0004
	sta.b d0
	ldy.w #$0000
	lda.w puckc
	cmp.w #$000C
	bpl .4
	ldy.w #$000C
.4:									; d2 = $0006
	lda.w #$0006
	sta.b d2
.loop:								; loop: if position,y < 0 go to .5, if zero go to .5, A = d0, ...
	lda.w position,y
	bmi .5
	beq .5
	lda.b d0
	sec
	sbc.w Ypos,y
	bpl .rtl
.5:									; Y + 1, Y + 1, d2 - 1, if the result >= 0 go to .loop, ...
	iny
	iny
	dec.b d2
	bpl .loop
	bra .9
.6:									; Y = puckc, if Ypos,y < 0 go to .rtl, A + $0004, d0 = A, ...
	ldy.w puckc
	lda.w Ypos,y
	bmi .rtl
	clc
	adc.w #$0004
	sta.b d0
	ldy.w #$0000
	lda.w puckc
	cmp.w #$000C
	bpl .7
	ldy.w #$000C
.7:									; d2 = $0006
	lda.w #$0006
	sta.b d2
.loop2:								; loop: if position,y < 0 go to .8, if zero go to .8, A = d0, ...
	lda.w position,y
	bmi .8
	beq .8
	lda.b d0
	sec
	sbc.w Ypos,y
	bmi .rtl
.8:									; Y + 1, Y + 1, d2 - 1, if the result >= 0 go to .loop2
	iny
	iny
	dec.b d2
	bpl .loop2
.9:									; IsBreakaway = 0, IsBreakaway + 1
	stz.w IsBreakaway
	inc.w IsBreakaway
.rtl:								; return
	rtl
StartBreakaway:						; called from other segments
	jsl.l CheckBreakaway
	lda.w IsBreakaway
	sta.w breakaway
	beq .rtl
	lda.w penshot
	bne .1
	lda.w #$0001
	jsl.l StartSound
.1:									; A = CwdExciteLvl, A + $0014, if the result < 0 go to .2, ...
	lda.w CwdExciteLvl
	clc
	adc.w #$0014
	bmi .2
	sta.w CwdExciteLvl
.2:									; push Y, Y = $0000, if puckc - $000C < 0 go to .3, Y = $0002
	phy
	ldy.w #$0000
	lda.w puckc
	cmp.w #$000C
	bmi .3
	ldy.w #$0002
.3:									; if penshot is not 0 go to .4, A = tmBreakaways,y, A + 1, ...
	lda.w penshot
	bne .4
	lda.w tmBreakaways,y
	inc a
	sta.w tmBreakaways,y
.4:									; pull Y
	ply
.rtl:								; return
	rtl
StartPenaltyShot:					; called from other segments
	lda.w penshot
	bne .rtl
	lda.w BA_Sktr_SCnum
	cmp.w #$000C
	bmi .1
	lda.w #$0002
	sta.w BA_Team
	inc.w tmPenShots+2
	bra .2
.1:									; BA_Team = 0, tmPenShots + 1
	stz.w BA_Team
	inc.w tmPenShots
.2:									; push Y, A = BA_Team, A xor $0002, Y = A, ...
	phy
	lda.w BA_Team
	eor.w #$0002
	tay
	lda.w #$0001
	sta.w tmap,y
	ldy.w BA_Team
	lda.w #$0001
	sta.w tmap,y
	ply
	phx
	ldx.w BA_Sktr_SCnum
	lda.w pnum,x
	sta.w BA_Skater_Offset
	plx
	stz.w penshot
	inc.w penshot
	lda.w fox
	sta.w psfoxsave
	lda.w foy
	sta.w psfoysave
	stz.w fox
	stz.w foy
.rtl:								; return
	rtl
EndPenaltyShot:						; called from other segments
	lda.w PenShotActive
	beq .rtl
	lda.w penshot
	beq .rtl
	phx
	jsl.l WaitTransfers
	jsl.l CODE_C4785E
	stz.w PenShotActive
	stz.w penshot
	lda.w #$FFFF
	sta.w BA_Sktr_SCnum
	lda.w #$000A
	sta.b d0
	jsl.l ShootoutWonBy
	lda.w psfoxsave
	sta.w ltx
	lda.w psfoysave
	sta.w lty
	plx
.rtl:								; return
	rtl
goalieacc:							; called from other segments
	lda.w #$121E
	sta.b d1
	lda.b d0
	and.w #$000F
	sta.b d0
	cmp.w #$0008
	bcc .3
	ldy.w playerpad,x
	bpl .1
	cmp.w #$0009
	bne .2
.1:									; A = Xvel,x, if the result is not 0 go to .6
	lda.w Xvel,x
	ora.w Yvel,x
	bne .6
.2:									; if pf2aip,x is not 0 go to .rtl, go to SetSPA
	lda.w pf2aip,x
	bne .rtl
	jml.l SetSPA
.rtl:								; return
	rtl
.3:									; if X = puckc go to .7, if asscur,x = $000C go to .7, A = Ypos,x, ...
	cpx.w puckc
	beq .7
	lda.w asscur,x
	cmp.w #$000C
	beq .7
	lda.w Ypos,x
	bit.w #$8000
	beq .4
	eor.w #$FFFF
	inc a
.4:									; if A < $009C go to .7, if playerpad,x < 0 go to .5, ...
	cmp.w #$009C
	bcc .7
	ldy.w playerpad,x
	bmi .5
	lda.w SPA,x
	cmp.w #$1552
	bcc .5
	cmp.w #$2708
	bcc .6
.5:									; if d0 = facedir,x go to .8, d2 = A, A = $121E, call SetSPAFromA, ...
	lda.b d0
	cmp.w facedir,x
	beq .8
	sta.b d2
	lda.w #$121E
	jsl.l SetSPAFromA
	jmp.w .13
.6:									; go to stopna
	jmp.w stopna
.7:									; if goalieturnwait,x is not 0 go to .8, A = d0, A - facedir,x, ...
	lda.w goalieturnwait,x
	bne .8
	lda.b d0
	sec
	sbc.w facedir,x
	sta.b d0
	beq .8
	eor.w #$FFFF
	inc a
	and.w #$0004
	lsr a
	dec a
	clc
	adc.w facedir,x
	and.w #$0007
	sta.b d0
	sta.w facedir,x
	lda.w #$0006
	sta.w goalieturnwait,x
.8:									; if goalieturnwait,x = 0 go to .10, A - timestep, ...
	lda.w goalieturnwait,x
	beq .10
	sec
	sbc.w timestep
	bpl .9
	lda.w #$0000
.9:									; goalieturnwait,x = A
	sta.w goalieturnwait,x
.10:								; A = goalieflags,x, if a $0002 bit set go to .11, A = $121E, go to .12
	lda.w goalieflags,x
	bit.w #$0002
	bne .11
	lda.w #$121E
	bra .12
.11:								; A = $14C0
	lda.w #$14C0
.12:								; call SetSPAFromA, d2 = facedir,x
	jsl.l SetSPAFromA
	lda.w facedir,x
	sta.b d2
.13:								; if playerpad,x < 0 go to .14, A = legspd,x, push A, A / 2, ...
	lda.w playerpad,x
	bmi .14
	lda.w legspd,x
	pha
	lsr a
	sta.b tmp0
	lsr a
	lsr a
	sta.b tmp1
	sec
	lda.b tmp0
	sbc.b tmp1
	sta.w legspd,x
	phx
	jsl.l playeracc
	plx
	pla
	sta.w legspd,x
	rtl
.14:								; go to playeracc
	jml.l playeracc
ChkGoalies:							; called from other segments
	lda.w gmclock
	bne rtss
	stz.b a2
	lda.w #$0002
	sta.b a1
	jsl.l CheckTeamGoaliePull
	stz.b a1
	lda.w #$0002
	sta.b a2
CheckTeamGoaliePull:				; check whether team a2 should pull its goalie
	ldy.b a2
	lda.w tmgoalie,y
	bmi rtss
	ldx.w tmsort,y
	ldy.w puckc
	bmi rtss
	lda.w pfteam,y
	cmp.w pfteam,x
	bne rtss
	ldy.b a2
	lda.w gmode
	bit.w #$0008
	bne .1
	lda.w teampads,y
	bne rtss
	lda.w pucky
	sta.b d1
	jsl.l CPgoalie
	rtl
.1:									; A = tmgoalie,y, A or $FF00, tmgoalie,y = A, call setpersonel
	lda.w tmgoalie,y
	ora.w #$FF00
	sta.w tmgoalie,y
	jsl.l setpersonel
rtss:								; an rtl: asstab entry 0 (no assignment), as 94S rtss
	rtl
ReturnGoalies:						; called from other segments
	stz.b a2
	lda.w #$0002
	sta.b a1
	jsl.l ReturnTeamGoalie
	stz.b a1
	lda.w #$0002
	sta.b a2
ReturnTeamGoalie:					; return team a2 goalie and reconsider the computer pull rule
	ldy.b a2
	lda.w tmgoalie,y
	bpl .rtl
	and.w #$00FF
	cmp.w #$000A
	bcs .rtl
	sta.w tmgoalie,y
	lda.w teampads,y
	bne .rtl
	lda.w foy
	sta.b d1
	jmp.w CPgoalie
.rtl:								; return
	rtl
CPgoalie:							; from CheckTeamGoaliePull, ReturnTeamGoalie and other segments
	lda.w gsp
	cmp.w #$0002
	bne .rtl
	ldy.b a1
	lda.w tmscore,y
	ldy.b a2
	sec
	sbc.w tmscore,y
	bmi .rtl
	beq .rtl
	cmp.w #$0003
	bcs .rtl
	lda.w gameclock
	cmp.w #$003D
	bcs .rtl
	lda.w tmsort,y
	tay
	lda.w pfgoal,y
	bne .1
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
.1:									; if d1 < 0 go to .rtl, Y = a2, A = tmgoalie,y, A or $FF00, ...
	lda.b d1
	bmi .rtl
	ldy.b a2
	lda.w tmgoalie,y
	ora.w #$FF00
	sta.w tmgoalie,y
	jml.l setpersonel
.rtl:								; return
	rtl
assgoalietopuck:					; called from other segments
	lda.w #$0006
	ora.w goalieflags,x
	sta.w goalieflags,x
	lda.w Xpos,x
	cmp.w #$FFD8
	bmi .2
	cmp.w #$0029
	bpl .2
	lda.w Ypos,x
	bit.w #$8000
	beq .1
	eor.w #$FFFF
	inc a
.1:									; r0 = A, if A - $00EB < 0 go to .2, if A - $010A >= 0 go to .2, ...
	sta.b r0
	cmp.w #$00EB
	bmi .2
	cmp.w #$010A
	bpl .2
	lda.w #$FFFB
	and.w goalieflags,x
	sta.w goalieflags,x
.2:									; if Xpos,x - $FFD0 < 0 go to .4, if Xpos,x - $0031 >= 0 go to .4, ...
	lda.w Xpos,x
	cmp.w #$FFD0
	bmi .4
	cmp.w #$0031
	bpl .4
	lda.w Ypos,x
	bit.w #$8000
	beq .3
	eor.w #$FFFF
	inc a
.3:									; if A - $00EB < 0 go to .4, A = $FFFD, A and goalieflags,x, ...
	cmp.w #$00EB
	bmi .4
	lda.w #$FFFD
	and.w goalieflags,x
	sta.w goalieflags,x
.4:									; if playerpad,x >= 0 go to .6, if gmclock is not 0 go to .6, ...
	lda.w playerpad,x
	bpl .6
	lda.w gmclock
	bne .6
	jsl.l check4bench
	lda.w pflags,x
	bit.w #$0002
	beq .5
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w $0692
.5:									; A = temp1,x, A - d7, temp1,x = A, if plus go to .10, ...
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bpl .10
	lda.w aidef,x
	lsr a
	lsr a
	clc
	adc.w temp1,x
	bpl .7
	lda.w #$0000
	bra .7
.6:									; go to assexit
	jmp.w assexit
.7:									; temp1,x = A, if puckc >= 0 go to .6, A = puckvy, ...
	sta.w temp1,x
	lda.w puckc
	bpl .6
	lda.w puckvy
	ldy.w pfgoal,x
	beq .8
	eor.w #$FFFF
	inc a
.8:									; if A - $F800 < 0 go to .6, a1 = 0, a2 = $0002, ...
	cmp.w #$F800
	bmi .6
	stz.b a1
	lda.w #$0002
	sta.b a2
	lda.w pfteam,x
	beq .9
	stz.b a2
	lda.w #$0002
	sta.b a1
.9:									; Y = a2, if tmnear,y < $0046 go to .6
	ldy.b a2
	lda.w tmnear,y
	cmp.w #$0046
	bcc .6
.10:								; call GoaliePuckVector, call vtoa, call AdjustFacingDirection, ...
	jsr.w GoaliePuckVector
	jsl.l vtoa
	jsl.l AdjustFacingDirection
	asl.w legstr,x
	jsl.l GoalieChasePuck
	lsr.w legstr,x
	rtl
GoalieChasePuck:					; steer the goalie toward the predicted puck position
	lda.w temp2,x
	sec
	sbc.b d7
	sta.w temp2,x
	bmi .1
	jmp.w .6
.1:									; A + $0005, temp2,x = A, A = puckvx, A and $00FF, ...
	adc.w #$0005
	sta.w temp2,x
	lda.w puckvx
	xba
	and.w #$00FF
	bit.w #$0080
	beq .2
	ora.w #$FF00
.2:									; A + puckx, d0 = A, A = puckvy, A and $00FF, ...
	clc
	adc.w puckx
	sta.b d0
	lda.w puckvy
	xba
	and.w #$00FF
	bit.w #$0080
	beq .3
	ora.w #$FF00
.3:									; A + pucky, d1 = A, call avdgoal, A = d0, ...
	clc
	adc.w pucky
	sta.b d1
	jsl.l avdgoal
	pei ($83)
	lda.b d0
	pha
	txa
	jsl.l GetFrameHot
	lda.b d0
	eor.w #$FFFF
	inc a
	sec
	sbc.w $09A1,x
	and.w #$00FF
	bit.w #$0080
	beq .4
	ora.w #$FF00
.4:									; A + $01,s, A - Xpos,x, d0 = A, A = d1, ...
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
	beq .5
	ora.w #$FF00
.5:									; A + $03,s, A - Ypos,x, d1 = A, pull A, ...
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
.6:									; d0 = temp2b,x, go to doplayeracc
	lda.w temp2b,x
	sta.b d0
	jml.l doplayeracc
GoalieCount:						; count the goalie odds nibbles for team a2 into d0
	ldy.b a2
	stz.b d0
	lda.w #$00C3
	sta.b tmp1
	lda.w tmdata,y
	sta.b tmp0
	ldy.w #$0008
	clc
	adc.b [tmp0],y
	sta.b tmp0
	lda.b [tmp0]
	xba
.loop:								; loop: d0 + 1, A * 2, A * 2, A * 2, ...
	inc.b d0
	asl a
	asl a
	asl a
	asl a
	bne .loop
	rtl
AdvanceStringPtr:					; no caller found (not traced)
	bra .1
.loop:								; loop: A = a1, A + [a1], a1 = A
	lda.b a1
	clc
	adc.b [a1]
	sta.b a1
.1:									; d0 - 1, if the result >= 0 go to .loop, return
	dec.b d0
	bpl .loop
	rtl
assgoalie:							; assignment (asstab entry 7): the goalie
	lda.w #$0006
	ora.w goalieflags,x
	sta.w goalieflags,x
	lda.w Xpos,x
	cmp.w #$FFD8
	bmi .2
	cmp.w #$0029
	bpl .2
	lda.w Ypos,x
	bit.w #$8000
	beq .1
	eor.w #$FFFF
	inc a
.1:									; r0 = A, if A - $00EB < 0 go to .2, if A - $010A >= 0 go to .2, ...
	sta.b r0
	cmp.w #$00EB
	bmi .2
	cmp.w #$010A
	bpl .2
	lda.w #$FFFB
	and.w goalieflags,x
	sta.w goalieflags,x
.2:									; if Xpos,x - $FFD0 < 0 go to .4, if Xpos,x - $0031 >= 0 go to .4, ...
	lda.w Xpos,x
	cmp.w #$FFD0
	bmi .4
	cmp.w #$0031
	bpl .4
	lda.w Ypos,x
	bit.w #$8000
	beq .3
	eor.w #$FFFF
	inc a
.3:									; r0 = A, if A - $00EB < 0 go to .4, A = $FFFD, A and goalieflags,x, ...
	sta.b r0
	cmp.w #$00EB
	bmi .4
	lda.w #$FFFD
	and.w goalieflags,x
	sta.w goalieflags,x
.4:									; call check4bench, A = pflags,x, if $0002 bits clear go to .5, ...
	jsl.l check4bench
	lda.w pflags,x
	bit.w #$0002
	beq .5
	and.w #$FFFD
	sta.w pflags,x
	stz.w temp1,x
	stz.w temp2,x
	lda.w #$0008
	sta.w temp2b,x
	lda.w #$FFFF
	sta.w temp4,x
.5:									; if playerpad,x >= 0 go to GoalieCheckManualState, ...
	ldy.w playerpad,x
	bpl GoalieCheckManualState
	lda.w Xpos,x
	cmp.w #$FFCB
	bmi .7
	cmp.w #$0035
	bpl .7
	lda.w Ypos,x
	bit.w #$8000
	beq .6
	eor.w #$FFFF
	inc a
.6:									; if A >= $0115 go to .7, if A >= $00D9 go to GoalieUpdateStateJump
	cmp.w #$0115
	bcs .7
	cmp.w #$00D9
	bcs GoalieUpdateStateJump
.7:									; $65 = rtss>>16, a0 = rtss, Y = $0004, if Xpos,x >= 0 go to .8, ...
	lda.w #rtss>>16
	sta.b $65
	lda.w #rtss
	sta.b a0
	ldy.w #$0004
	lda.w Xpos,x
	bpl .8
	ldy.w #$FFFC
.8:									; d0 = Y, d1 = $00FA, if pfgoal,x = 0 go to .9, d1 = $FF06
	sty.b d0
	lda.w #$00FA
	sta.b d1
	lda.w pfgoal,x
	beq .9
	lda.w #$FF06
	sta.b d1
.9:									; go to skateto
	jml.l skateto
DATA8_C48B47:						; an rtl no traced code reaches
	db $6B
GoalieCheckManualState:				; update the goalie control state before movement
	lda.w gmclock
	bne .1
	cpx.w puckc
	beq .1
	jmp.w GoalieCheckPadDirection
.1:									; A = goalieflags,x, A or $0001, goalieflags,x = A
	lda.w goalieflags,x
	ora.w #$0001
	sta.w goalieflags,x
GoalieUpdateStateJump:				; continue into the goalie animation and decision update
	jmp.w GoalieUpdateState
GoalieReturnToCrease:				; skate the goalie back toward the crease
	lda.w #rtss>>16
	sta.b $65
	lda.w #rtss
	sta.b a0
	ldy.w #$0004
	lda.w Xpos,x
	bpl .1
	ldy.w #$FFFC
.1:									; d0 = Y, d1 = $00FF, if pfgoal,x = 0 go to .2, d1 = $FF01
	sty.b d0
	lda.w #$00FF
	sta.b d1
	lda.w pfgoal,x
	beq .2
	lda.w #$FF01
	sta.b d1
.2:									; temp2,x = 0, go to skateto
	stz.w temp2,x
	jml.l skateto
GoalieCheckPadDirection:			; check manual goalie direction and stop when no direction is pressed
	lda.w goalieflags,x
	bit.w #$0001
	bne GoalieUpdateStateJump
	bit.w #$0002
	bne GoalieReturnToCrease
	ldy.w playerpad,x
	lda.w paddir,y
	cmp.w #$0008
	bne GoalieUpdateState
	jsl.l stopna
GoalieUpdateState:					; update goalie animation, puck holding, saves and computer movement
	lda.w pf2aip,x
	bne .1
	lda.w #$121E
	jsl.l SetSPAFromA
.1:									; if gmclock is not 0 go to .rtl, if temp5,x < 0 go to .4, ...
	lda.w gmclock
	bne .rtl
	lda.w temp5,x
	bmi .4
	cpx.w puckc
	bne .2
	lda.w Ypos,x
	cmp.w #$00BB
	bpl .3
	cmp.w #$FF45
	bmi .3
	stz.w temp5,x
	bra .3
.2:									; temp5,x = $FFFF, go to .4
	lda.w #$FFFF
	sta.w temp5,x
	bra .4
.rtl:								; return
	rtl
.3:									; A = temp5,x, A - d7, temp5,x = A, if plus go to .4, ...
	lda.w temp5,x
	sec
	sbc.b d7
	sta.w temp5,x
	bpl .4
	lda.w #$0008
	sta.b d0
	jsl.l AddPenalty2
.4:									; if pf2aip,x = 0 go to .5, go to .rtl
	lda.w pf2aip,x
	beq .5
	jmp.w .rtl
.5:									; A = temp1,x, A - d7, temp1,x = A, if minus go to .6, ...
	lda.w temp1,x
	sec
	sbc.b d7
	sta.w temp1,x
	bmi .6
	jmp.w .90
.6:									; A = aidef,x, A / 2, A + temp1,x, if A - $0000 >= 0 go to .7, ...
	lda.w aidef,x
	lsr a
	clc
	adc.w temp1,x
	cmp.w #$0000
	bpl .7
	lda.w #$0000
.7:									; temp1,x = A, if playerpad,x >= 0 go to .11, d0 = pucky, A = Ypos,x, ...
	sta.w temp1,x
	lda.w playerpad,x
	bpl .11
	lda.w pucky
	sta.b d0
	lda.w Ypos,x
	eor.b d0
	sta.b d1
	bpl .9
	stz.b d0
	lda.w #$00FA
	sta.b d2
	lda.w pfgoal,x
	beq .8
	lda.w #$FF06
	sta.b d2
.8:									; go to .78
	jmp.w .78
.9:									; temp4,x - 1, if the result >= 0 go to .10, temp4,x = $FFFF
	dec.w temp4,x
	bpl .10
	lda.w #$FFFF
	sta.w temp4,x
.10:								; if X = puckc go to .12
	cpx.w puckc
	beq .12
.11:								; go to .19
	jmp.w .19
.12:								; if temp5,x >= 0 go to .13, temp5,x = $005A
	lda.w temp5,x
	bpl .13
	lda.w #$005A
	sta.w temp5,x
.13:								; temp4,x = $FFFF, A = temp5,x, A - $005A, ...
	lda.w #$FFFF
	sta.w temp4,x
	lda.w temp5,x
	sec
	sbc.w #$005A
	bpl .15
	jsl.l RandomWord
	cmp.w #$C000
	bcc .15
	lda.w #$0005
	sta.b d0
	stz.b a0
	lda.w pfteam,x
	bne .loop
	lda.w #$000C
	sta.b a0
.loop:								; loop: Y = a0, A = pflags,y, if a $1000 bit set go to .14, ...
	ldy.b a0
	lda.w pflags,y
	bit.w #$1000
	bne .14
	lda.w $05E4,y
	cmp.w #$0023
	bcc .16
.14:								; a0 + 1, a0 + 1, d0 - 1, if the result >= 0 go to .loop, ...
	inc.b a0
	inc.b a0
	dec.b d0
	bpl .loop
	lda.w #$0001
	sta.w threat
	jsl.l chk4pass
	lda.w puckc
	bmi .rtl2
.15:								; go to .28
	jmp.w .28
.16:								; Y = $0000, if A >= $0014 go to .15, pf2aip,x = $005A, A = $1636, ...
	ldy.w #$0000
	cmp.w #$0014
	bcs .15
	lda.w #$005A
	sta.w pf2aip,x
	lda.w #$1636
	jsl.l SetSPAFromA
.rtl2:								; return
	rtl
.17:								; call vtoa, A = d0
	jsl.l vtoa
	lda.b d0
.18:								; facedir,x = A, pfalock,x = A, A = $15C4, call SetSPAFromA, ...
	sta.w facedir,x
	sta.w pfalock,x
	lda.w #$15C4
	jsl.l SetSPAFromA
	lda.w #$00F0
	sta.w goaliedivewait,x
	rtl
.19:								; if playerpad,x < 0 go to .22, ...
	ldy.w playerpad,x
	bmi .22
	lda.w padinputdone,y
	cmp.w #$0001
	bne .22
	cpx.w puckc
	beq .15
	lda.w puckx
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w pucky
	sec
	sbc.w Ypos,x
	sta.b d1
	lda.w PadRaw1,y
	bit.w #$4000
	bne .20
	lda.w padnew,y
	bit.w #$0040
	beq .15
	lda.w paddir,y
	cmp.w #$0008
	beq .17
	and.w #$0007
	bra .18
.20:								; if paddir,y is not $0008 go to .21, go to .25
	lda.w paddir,y
	cmp.w #$0008
	bne .21
	jmp.w .25
.21:								; A and $0007, go to .26
	and.w #$0007
	jmp.w .26
.22:								; A = puckx, A - Xpos,x, d0 = A, A = pucky, ...
	lda.w puckx
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w pucky
	sec
	sbc.w Ypos,x
	sta.b d1
	lda.w puckc
	bmi .23
	lsr a
	tay
	lda.w pfteam,y
	cmp.w pfteam,x
	beq .24
	lda.w goaliedivewait,x
	bne .24
	jsl.l RandomWord
	cmp.w #$0A00
	bcs .24
	lda.w $05E4,x
	cmp.w #$0023
	bcs .28
	lda.w pucky
	cmp.w #$FEF1
	bmi .28
	cmp.w #$010F
	bpl .28
	jmp.w .17
.23:								; if temp4,x is not 0 go to .24, if $05E4,x >= $002D go to .28, ...
	lda.w temp4,x
	bne .24
	lda.w $05E4,x
	cmp.w #$002D
	bcs .28
	lda.w pucky
	cmp.w #$FEF1
	bmi .28
	cmp.w #$010F
	bpl .28
	lda.b a2
	eor.w #$0002
	tay
	lda.w tmnear,y
	cmp.w #$003C
	bcs .28
	jsl.l RandomWord
	cmp.w #$0800
	bcs .28
	bra .25
.24:								; go to .28
	jmp.w .28
.25:								; call vtoa, A = d0
	jsl.l vtoa
	lda.b d0
.26:								; facedir,x = A, Y = $1552, A = Y, call SetSPAFromA, ...
	sta.w facedir,x
	ldy.w #$1552
	tya
	jsl.l SetSPAFromA
	lda.w #$0168
	sta.w goaliedivewait,x
	lda.w CwdExciteLvl
	clc
	adc.w #$000A
	bmi .27
	sta.w CwdExciteLvl
.27:								; pfalock,x = $0096, Crowdlevel + A, crowdhold = $001E, ...
	lda.w #$0096
	sta.w pfalock,x
	clc
	adc.l Crowdlevel
	sta.l Crowdlevel
	lda.w #$001E
	sta.b crowdhold
	rtl
.28:								; if pfgoal,x is not 0 go to .29, $65 = 0, a0 = $07D8, d3 = $010A, ...
	lda.w pfgoal,x
	bne .29
	stz.b $65
	lda.w #$07D8
	sta.b a0
	lda.w #$010A
	sta.b d3
	lda.w #$010E
	sta.b d4
	bra .30
.29:								; a0 = $07DC, d3 = $FEF6, d4 = $FEF2
	lda.w #$07DC
	sta.b a0
	lda.w #$FEF6
	sta.b d3
	lda.w #$FEF2
	sta.b d4
.30:								; if X = puckc go to .31, call GoaliePuckVector, call vtoa, ...
	cpx.w puckc
	beq .31
	jsr.w GoaliePuckVector
	jsl.l vtoa
	jsl.l AdjustFacingDirection
	bra .32
.31:								; if playerpad,x >= 0 go to .32, A = pfgoal,x, A xor $0001, A * 2, ...
	lda.w playerpad,x
	bpl .32
	lda.w pfgoal,x
	eor.w #$0001
	asl a
	asl a
	sta.b d0
	jsl.l AdjustFacingDirection
.32:								; if Ypos,x - $FEF5 < 0 go to .34, if Ypos,x - $010B >= 0 go to .34
	lda.w Ypos,x
	cmp.w #$FEF5
	bmi .34
	cmp.w #$010B
	bpl .34
.33:								; d0 = puckx, d1 = pucky, call ClampGoalieTargetY, ...
	lda.w puckx
	sta.b d0
	lda.w pucky
	sta.b d1
	jsl.l ClampGoalieTargetY
	lda.b d1
	cmp.w #$FFD2
	bmi .36
	cmp.w #$002E
	bpl .36
	pei ($83)
	pei ($7F)
	jmp.w .47
.34:								; if playerpad,x >= 0 go to .33, d2 = 0, d0 = 0, ...
	lda.w playerpad,x
	bpl .33
	stz.b d2
	stz.b d0
	lda.w Xpos,x
	cmp.w #$FFD3
	bmi .35
	cmp.w #$002D
	bpl .35
	lda.w #$009B
	sta.b d0
	lda.w Xpos,x
	bpl .35
	lda.w #$FF65
	sta.b d0
.35:								; go to .78
	jmp.w .78
.36:								; A = puckvy, A / 2, A and $007F, if $0040 bits clear go to .37, ...
	lda.w puckvy
	xba
	lsr a
	and.w #$007F
	bit.w #$0040
	beq .37
	ora.w #$FF80
.37:								; r3 = A, A + r3, A + pucky, d1 = A, ...
	sta.b r3
	cmp.w #$8000
	ror a
	adc.b r3
	clc
	adc.w pucky
	sta.b d1
	lda.b d1
	cmp.w #$00E6
	bpl .38
	lda.b d1
	cmp.w #$FF1A
	bpl .43
.38:								; if passReceiverPlayerNum >= 0 go to .41, if puckc < 0 go to .41, ...
	lda.w passReceiverPlayerNum
	bpl .41
	lda.w puckc
	bmi .41
	lda.w seed
	and.w #$0180
	beq .44
.39:								; A = puckvx, A and $00FF, if $0080 bits clear go to .40, A or $FF00
	lda.w puckvx
	xba
	and.w #$00FF
	bit.w #$0080
	beq .40
	ora.w #$FF00
.40:								; r3 = A, A + r3, A + puckx, d0 = A, ...
	sta.b r3
	cmp.w #$8000
	ror a
	adc.b r3
	clc
	adc.w puckx
	sta.b d0
	bra .46
.41:								; A = puckvx, A / 2, A and $007F, if $0040 bits clear go to .42, ...
	lda.w puckvx
	xba
	lsr a
	and.w #$007F
	bit.w #$0040
	beq .42
	ora.w #$FF80
.42:								; A + puckx, d0 = A, go to .46
	clc
	adc.w puckx
	sta.b d0
	bra .46
.43:								; A = seed, if the result = 0 go to .39
	lda.w seed
	and.w #$0380
	beq .39
.44:								; A = puckvx, A and $00FF, if $0080 bits clear go to .45, A or $FF00
	lda.w puckvx
	xba
	and.w #$00FF
	bit.w #$0080
	beq .45
	ora.w #$FF00
.45:								; A + puckx, d0 = A
	clc
	adc.w puckx
	sta.b d0
.46:								; call ClampGoalieTargetY
	jsl.l ClampGoalieTargetY
	pei ($83)
	pei ($7F)
.47:								; A = d0, Y = d1, call ApproxLength, d0 = A, ...
	lda.b d0
	ldy.b d1
	jsl.l ApproxLength
	sta.b d0
	cmp.w #$001E
	bcs .48
	pla
	sta.b d0
	pla
	sta.b d1
	bra .50
.48:								; A = d0, A + 1, d2 = A, d4 = $0014, ...
	lda.b d0
	inc a
	sta.b d2
	lda.w #$0014
	sta.b d4
	lda.w sflags
	bit.w #$0008
	beq .49
	lda.w #$001C
	sta.b d4
.49:								; pull A, d0 = A, pull A, d1 = A, ...
	pla
	sta.b d0
	pla
	sta.b d1
	tax
	lda.b d4
	jsl.l Mul16x8XS
	lda.b d2
	sta.b r1
	jsl.l Div32S
	lda.b r0
	sta.b d1
	lda.b d4
	adc.w #$0006
	sta.b d4
	ldx.b d0
	jsl.l Mul16x8XS
	lda.b d2
	sta.b r1
	jsl.l Div32S
	lda.b r0
	sta.b d0
	ldx.b curobj
.50:								; A = d1, A + d3, d1 = A, d2 = A, ...
	lda.b d1
	clc
	adc.b d3
	sta.b d1
	sta.b d2
	ldy.w playerpad,x
	bmi .52
	cpx.w puckc
	beq .51
	lda.w PadRaw1,y
	bit.w #$0080
	bne .56
.51:								; go to .76
	jmp.w .76
.52:								; Y = $0002, if [a0],y < $0023 go to .53, go to .78
	ldy.w #$0002
	lda.b [a0],y
	cmp.w #$0023
	bcc .53
	jmp.w .78
.53:								; if [a0] - $FFE7 < 0 go to .55, if [a0] - $0019 >= 0 go to .55, ...
	lda.b [a0]
	cmp.w #$FFE7
	bmi .55
	cmp.w #$0019
	bpl .55
	lda.b [a0],y
	cmp.w #$0013
	bcs .54
	lda.w pucky
	cmp.w #$FEF1
	bmi .54
	cmp.w #$010F
	bmi .56
.54:								; go to .76
	jmp.w .76
.55:								; go to .93
	jmp.w .93
.56:								; Xvel,x = A, Yvel,x = A, A = goalieflags,x, ...
	lda.w Xvel,x
	cmp.w #$8000
	ror a
	sta.w Xvel,x
	lda.w Yvel,x
	cmp.w #$8000
	ror a
	sta.w Yvel,x
	lda.w goalieflags,x
	bit.w #$0002
	beq .57
	jmp.w .71
.57:								; A = puckvx, A / 2, A / 2, A and $003F, ...
	lda.w puckvx
	xba
	lsr a
	lsr a
	and.w #$003F
	bit.w #$0020
	beq .58
	ora.w #$FFC0
.58:								; A + puckx, A - Xpos,x, d0 = A, $2E = A, ...
	clc
	adc.w puckx
	sec
	sbc.w Xpos,x
	sta.b d0
	sta.b $2E
	bit.w #$8000
	beq .59
	eor.w #$FFFF
	inc a
.59:								; r0 = A, A = puckvy, A / 2, A / 2, ...
	sta.b r0
	lda.w puckvy
	xba
	lsr a
	lsr a
	and.w #$003F
	bit.w #$0020
	beq .60
	ora.w #$FFC0
.60:								; A + pucky, A - Ypos,x, d1 = A, if $8000 bits clear go to .61, ...
	clc
	adc.w pucky
	sec
	sbc.w Ypos,x
	sta.b d1
	bit.w #$8000
	beq .61
	eor.w #$FFFF
	inc a
.61:								; r1 = A, call vtoa, if d0 = $0008 go to .63, A - facedir,x, ...
	sta.b r1
	jsl.l vtoa
	lda.b d0
	cmp.w #$0008
	beq .63
	sec
	sbc.w facedir,x
	and.w #$0007
	sta.b d3
	beq .63
	jmp.w .72
.62:								; if puckvy - $0800 >= 0 go to .63, if puckvy - $F800 < 0 go to .63, ...
	lda.w puckvy
	cmp.w #$0800
	bpl .63
	cmp.w #$F800
	bmi .63
	lda.w #$0008
	sta.b d0
	jmp.w .75
.63:								; if facedir,x = 0 go to .64, if facedir,x = $0004 go to .66, ...
	lda.w facedir,x
	beq .64
	cmp.w #$0004
	beq .66
	cmp.w #$0001
	beq .68
	cmp.w #$0005
	beq .68
	cmp.w #$0007
	beq .69
	cmp.w #$0003
	beq .69
	lda.w seed
	and.w #$0001
	bra .72
.64:								; if $2E >= 0 go to .67
	lda.b $2E
	bpl .67
.65:								; A = $0007, go to .72
	lda.w #$0007
	bra .72
.66:								; if $2E >= 0 go to .65
	lda.b $2E
	bpl .65
.67:								; A = $0001, go to .72
	lda.w #$0001
	bra .72
.68:								; if r0 - r1 >= 0 go to .67, go to .65
	lda.b r0
	cmp.b r1
	bpl .67
	bra .65
.69:								; if r1 - r0 >= 0 go to .67, go to .65
	lda.b r1
	cmp.b r0
	bpl .67
	bra .65
.70:								; A = d0, A + $0006, d0 = A, go to .75
	lda.b d0
	clc
	adc.w #$0006
	sta.b d0
	jmp.w .75
.71:								; A = puckdir,x, A - facedir,x, A and $0007, d3 = A, ...
	lda.w puckdir,x
	sec
	sbc.w facedir,x
	and.w #$0007
	sta.b d3
	beq .63
.72:								; if A = $0004 go to .62, A / 2, A / 2, d0 = A, ...
	cmp.w #$0004
	beq .62
	lsr a
	lsr a
	sta.b d0
	lda.w attribute,x
	bit.w #$0800
	beq .73
	lda.b d0
	eor.w #$0001
	sta.b d0
.73:								; if d3 < $0004 go to .74, A xor $FFFF, A + $0008
	lda.b d3
	cmp.w #$0004
	bcc .74
	eor.w #$FFFF
	adc.w #$0008
.74:								; if A >= $0002 go to .70, A = puckz, A - $0008, ...
	cmp.w #$0002
	bcs .70
	lda.w puckz
	sec
	sbc.w #$0008
	bpl .75
	lda.w puckvz
	sec
	sbc.w #$0800
	bpl .75
	lda.b d0
	clc
	adc.w #$0004
	sta.b d0
	ldy.w #$0002
	lda.b [a0],y
	cmp.w #$0009
	bcc .75
	lda.w facedir,x
	cmp.w #$0002
	beq .75
	cmp.w #$0006
	beq .75
	lda.w puckc
	bmi .75
	dec.b d0
	dec.b d0
.75:								; d0 * 2, $69 = $00C4, a1 = $932C, Y = d0, ...
	asl.b d0
	lda.w #$00C4
	sta.b $69
	lda.w #$932C
	sta.b a1
	ldy.b d0
	lda.b [a1],y
	sta.w pfalock,x
	jsl.l SetSPAFromA
	lda.l Crowdlevel
	clc
	adc.w #$0096
	sta.l Crowdlevel
	lda.w #$001E
	sta.b crowdhold
.76:								; d0 = [a0], A = pucky, A - $0102, if the result >= 0 go to .77, ...
	lda.b [a0]
	sta.b d0
	lda.w pucky
	sec
	sbc.w #$0102
	bpl .77
	lda.w pucky
	sec
	sbc.w #$FEFE
	bpl .78
.77:								; d0 = $0018, if puckx >= 0 go to .78, d0 = $FFE8
	lda.w #$0018
	sta.b d0
	lda.w puckx
	bpl .78
	lda.w #$FFE8
	sta.b d0
.78:								; if playerpad,x < 0 go to .79, go to GoalieTargetReturn
	lda.w playerpad,x
	bmi .79
	jmp.w GoalieTargetReturn
.79:								; if puckc < 0 go to .83, if pfteam,x = pfteam,y go to .83, ...
	ldy.w puckc
	bmi .83
	lda.w pfteam,x
	cmp.w pfteam,y
	beq .83
	lda.w SPA,y
	cmp.w #$1C24
	bcc .82
	cmp.w #$1EFB
	bcs .82
	lda.w Yvel,y
	bit.w #$8000
	beq .80
	eor.w #$FFFF
	inc a
.80:								; r0 = A, A = Xvel,y, if $8000 bits clear go to .81, A xor $FFFF, ...
	sta.b r0
	lda.w Xvel,y
	bit.w #$8000
	beq .81
	eor.w #$FFFF
	inc a
.81:								; A / 2, if A >= r0 go to .82, if $0668 is not 0 go to .83, ...
	lsr a
	cmp.b r0
	bcs .82
	lda.w $0668
	bne .83
	stz.w Xvel,x
	stz.w Yvel,x
	inc.w $0668
	rtl
.82:								; $0668 = 0
	stz.w $0668
.83:								; d1 = d2, push A, A = Xvel,x, A and $00FF, ...
	lda.b d2
	sta.b d1
	pha
	pei ($7F)
	lda.w Xvel,x
	xba
	and.w #$00FF
	bit.w #$0080
	beq .84
	ora.w #$FF00
.84:								; A xor $FFFF, A + 1, d0 = A, pull A, ...
	eor.w #$FFFF
	inc a
	sta.b d0
	pla
	clc
	adc.b d0
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w Yvel,x
	xba
	and.w #$00FF
	bit.w #$0080
	beq .85
	ora.w #$FF00
.85:								; A xor $FFFF, A + 1, d1 = A, pull A, ...
	eor.w #$FFFF
	inc a
	sta.b d1
	pla
	clc
	adc.b d1
	sec
	sbc.w Ypos,x
	sta.b d1
	lda.w #$0005
	sta.b tmp0
	cpx.w puckc
	bne .86
	asl.b tmp0
.86:								; A = d0, if $8000 bits clear go to .87, A xor $FFFF, A + 1
	lda.b d0
	bit.w #$8000
	beq .87
	eor.w #$FFFF
	inc a
.87:								; if A >= tmp0 go to .89, A = d1, if $8000 bits clear go to .88, ...
	cmp.b tmp0
	bcs .89
	lda.b d1
	bit.w #$8000
	beq .88
	eor.w #$FFFF
	inc a
.88:								; if A >= tmp0 go to .89, d0 = 0, d1 = 0
	cmp.b tmp0
	bcs .89
	stz.b d0
	stz.b d1
.89:								; call vtoa, temp2b,x = d0
	jsl.l vtoa
	lda.b d0
	sta.w temp2b,x
.90:								; if playerpad,x >= 0 go to .rtl3, d2 = temp2b,x, A - $0007, ...
	ldy.w playerpad,x
	bpl .rtl3
	lda.w temp2b,x
	sta.b d2
	sec
	sbc.w #$0007
	beq .91
	bmi .91
	jmp.w stopna
.91:								; go to playeracc
	jml.l playeracc
.92:								; go to .78
	jmp.w .78
.rtl3:								; return
	rtl
.93:								; if puckc >= 0 go to .92, A = iflags, if a $0004 bit set go to .92, ...
	lda.w puckc
	bpl .92
	lda.w iflags
	bit.w #$0004
	bne .92
	lda.w puckx
	bit.w #$8000
	beq .94
	eor.w #$FFFF
	inc a
.94:								; if A - $0068 < 0 go to .92, A = puckvy, ...
	cmp.w #$0068
	bmi .92
	lda.w puckvy
	bit.w #$8000
	beq .95
	eor.w #$FFFF
	inc a
.95:								; if A - $3800 < 0 go to .92, if pucky - $00BE >= 0 go to .96, ...
	cmp.w #$3800
	bmi .92
	lda.w pucky
	cmp.w #$00BE
	bpl .96
	lda.w pucky
	cmp.w #$FF42
	bpl .92
.96:								; A = puckvy, if pfgoal,x = 0 go to .97, A xor $FFFF, A + 1
	lda.w puckvy
	ldy.w pfgoal,x
	beq .97
	eor.w #$FFFF
	inc a
.97:								; if A - $FC00 < 0 go to .92, a1 = 0, a2 = $0002, ...
	cmp.w #$FC00
	bmi .92
	stz.b a1
	lda.w #$0002
	sta.b a2
	lda.w pfteam,x
	beq .98
	stz.b a2
	lda.w #$0002
	sta.b a1
.98:								; Y = a1, if tmnear,y < $0064 go to .99, Y = a2, ...
	ldy.b a1
	lda.w tmnear,y
	cmp.w #$0064
	bcc .99
	ldy.b a2
	lda.w tmnear,y
	cmp.w #$0064
	bcc .99
	lda.w #$000F
	sta.b d0
	jmp.w assinsert
.99:								; go to .78
	jmp.w .78

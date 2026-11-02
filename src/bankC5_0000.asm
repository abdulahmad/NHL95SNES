; Segment bankC5_0000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C50000
Opening:							; the cold start that Reset_Fast jumps to (94S Opening)
	pea.w $7E7E
	plb
	plb
	sep #$20
	ldx.w #$000C
.loop:								; loop: FrameHook,x = InitHooks,x, X - 1, ...
	lda.l InitHooks,x
	sta.w FrameHook,x
	dex
	bpl .loop
	lda.b #$81
	sta.l NMITIMEN
	rep #$20
	lda.w #$005C
	sta.w jmlvector
	jsl.l forceblack
	jsl.l Multi5Init
	jsl.l InitSoundSystem
	jsl.l IntroSequence
	jsl.l DeveloperCredits
	jsl.l CopyrightScreen
	jsl.l TitleScreen
	jsl.l forceblack
	jsl.l CheckPAL
	jsl.l GetMenuPadButtons
	jsl.l LoadSavedGameOptions
QuitGame:							; the quit prompt's Quit Game: the pad read (GetMenuPadButtons),
									; FadeOutWait, then Restart (the setup screen)
	jsl.l GetMenuPadButtons
	jsl.l FadeOutWait
Restart:							; starts over at the setup screen: the stack reset, StartMenuMusic,
									; jmlvector, GameSetUp, then the shootout or the scouting report and the
									; game
	rep #$30
	lda.w #$1FFF
	tcs
	stz.w playoffRoundIdx
	jsl.l StartMenuMusic
	lda.w #$445C
	sta.w jmlvector
	lda.w #$C08B
	sta.w jmlvector+2
	jsl.l CheckPAL
	jsl.l GameSetUp
	lda.w #$007E
	sta.b $71
	stz.w shootoutmode
	lda.w OptPlayMode
	cmp.w #$0004
	bne .1
	jsl.l PlayShootout
	bra Restart
.1:									; call Create_HotCold_Table, call LoadGameRosters, ...
	jsl.l Create_HotCold_Table
	jsr.w LoadGameRosters
	jsl.l ScoutingReport
	jsr.w InitGameSprites
StartGame_go:						; starts a game: fade out, the game RAM cleared, the games started count +
									; 1, the penalties flag from the option
	jsl.l FadeOutWait
	ldx.w #$059E
.loop:								; loop: $00,x = 0, X + 1, X + 1, if X < $1543 go to .loop, ...
	stz.b $00,x
	inx
	inx
	cpx.w #$1543
	bcc .loop
	lda.w #$0000
	ldx.w #$2000
.loop2:								; loop: $0000,x = A, X + 1, X + 1, if X < $2375 go to .loop2, ...
	sta.w $0000,x
	inx
	inx
	cpx.w #$2375
	bcc .loop2
	inc.w $2378
	stz.w gmode
	stz.w gsp
	lda.w OptPen
	cmp.w #$0001
	bne .1
	lda.w #$0020
	tsb.w gmode
.1:									; call clearTeamStats, call restoreteams, call InitScores, ...
	jsl.l clearTeamStats
	jsl.l restoreteams
	jsl.l InitScores
	lda.w #$007F
	sta.w recbpr+2
	stz.w recbpr
	lda.w #$0010
	trb.w sflags
	stz.b a2
	jsl.l LoadTeamLines
	lda.w #$0002
	sta.b a2
	jsl.l LoadTeamLines
	lda.w OptGoalie
	sta.w goaliemode1
	sta.w goaliemode2
	lda.w #$0001
	sta.w tmtimeouts
	sta.w tmtimeouts+2
	sta.l $7E234C
	stz.w penshot
	stz.w penshotlive
	stz.w lastperiod
	stz.w teampads
	stz.w teampads+2
	ldx.w #$0008
.2:									; if cont1team,x is not $0001 go to .3, teampads + 1, go to .4
	lda.w cont1team,x
	cmp.w #$0001
	bne .3
	inc.w teampads
	bra .4
.3:									; if A is not $0002 go to .4, teampads+2 + 1
	cmp.w #$0002
	bne .4
	inc.w teampads+2
.4:									; A - 1, A * 2, padside,x = A, X - 1, ...
	dec a
	asl a
	sta.w padside,x
	dex
	dex
	bpl .2
	jsl.l setupice
	stz.w pregamepause
	ldx.w #$0008
.loop3:								; loop: if cont1team,x is not 0 go to .5, X - 1, X - 1, ...
	lda.w cont1team,x
	bne .5
	dex
	dex
	bpl .loop3
	jsl.l LoadTeamSongs
	bra .6
.5:									; pregamepause = $0001
	lda.w #$0001
	sta.w pregamepause
.6:									; BA_Sktr_SCnum = $FFFF, if shootoutmode = 0 go to StartPer, return
	lda.w #$FFFF
	sta.w BA_Sktr_SCnum
	lda.w shootoutmode
	beq StartPer
	rtl
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
	sta.w pausepad
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
Gameloop:							; the game loop: frame counts and the speed, a random team song, the time
									; steps from Vcount, ReadPads, the clock and the game, Pausemode on the
									; sflags pause bit
	lda.b $26
	lsr a
	lda.w #$E000
	bcs .1
	lda.w #$F000
.1:									; $D7 = A, A = Vcount, X = A, A - OldVcount, ...
	sta.b $D7
	lda.b Vcount
	tax
	sec
	sbc.w OldVcount
	bne .2
	inc a
	inx
.2:									; push X, push A, A = $003C, X = $48, ...
	phx
	pha
	lda.w #$003C
	ldx.b $48
	inx
	stx.b $48
	stx.b $26
	jsl.l Mul16x8U
	lda.w FrameCount
	sta.b r1
	jsl.l Div32U
	lda.b r0
	sta.w gamefps
	lda.w gsp
	cmp.w #$0002
	bne .3
	jsl.l RandomWord
	and.w #$03FF
	bne .3
	lda.w #$0005
	jsl.l PlayTeamSong
.3:									; pull A, pull X, d7 = A, timestep = A, ...
	pla
	plx
	sta.b d7
	sta.w timestep
	asl a
	sta.w impactstep
	asl a
	asl a
	asl a
	sta.w velstep
	asl a
	sta.w gravstep
	asl a
	adc.w gravstep
	sta.w gravstep
	stx.w lastframevc
	stx.w OldVcount
	jsl.l ReadPads
	lda.w sflags
	bit.w #$0001
	bne .8
	lda.w gmclock
	bne .8
	lda.w shootoutmode
	bne .6
	lda.w PenShotActive
	beq .6
	lda.w pstimer
	ldx.b d7
	dex
	beq .4
	sec
	sbc.b d7
.4:									; A - d7, pstimer = A, if plus go to .5, call EndPenaltyShot, ...
	sec
	sbc.b d7
	sta.w pstimer
	bpl .5
	jsl.l EndPenaltyShot
	bra .8
.5:									; r2 = A, r1 = $001E, call Div16x8U, d0 = r0, ...
	sta.b r2
	lda.w #$001E
	sta.b r1
	jsl.l Div16x8U
	lda.b r0
	sta.b d0
	jsl.l PushTime
	ldx.w #$007E
	lda.b a1
	ldy.w #$5B23
	jsl.l QueueVRAMDMALen
	bra .8
.6:									; X = d7, X - 1, if the result = 0 go to .7, call GameClockTick
	ldx.b d7
	dex
	beq .7
	jsr.w GameClockTick
.7:									; call GameClockTick
	jsr.w GameClockTick
.8:									; if cheercnt = 0 go to .9, A = Vcount, A - cheervc, ...
	lda.w cheercnt
	beq .9
	lda.b Vcount
	sec
	sbc.w cheervc
	cmp.w #$0096
	bcc .9
	dec.w cheercnt
	lda.w cheervc
	clc
	adc.w #$0096
	sta.w cheervc
.9:									; call DoGameFrame, call demoread, A = sflags, ...
	jsl.l DoGameFrame
	jsl.l demoread
	lda.w sflags
	bit.w #$0001
	bne .10
	lda.w mp5warning
	beq .11
	lda.w gmode
	bit.w #$0010
	bne .11
	lda.w #$0001
	tsb.w sflags
.10:								; call Pausemode
	jsl.l Pausemode
.11:								; if shootoutmode = 0 go to .12, if shootoutturnover = 0 go to .12, return
	lda.w shootoutmode
	beq .12
	lda.w shootoutturnover
	beq .12
	rtl
.12:								; go to Gameloop
	jmp.w Gameloop
DoGameFrame:						; one frame of game logic: UpdateBenchCheer, periodicevents,
									; updateplayers, checkwindow, updatereplay, then setvideo once
									; TransfersReady is 0
	jsl.l UpdateBenchCheer
	jsl.l periodicevents
	jsl.l updateplayers
	jsl.l checkwindow
	jsl.l updatereplay
.loop:								; loop: if TransfersReady is not 0 go to .loop, $28 = $1D8F, ...
	lda.w TransfersReady
	bne .loop
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jml.l setvideo
periodicevents:						; from DoGameFrame and other segments
	jsl.l PenaltyManager
	jsl.l updatecrowdf
	jsl.l clockcont
	lda.w lldisp
	sec
	sbc.b d7
	sta.w lldisp
	bpl .rtl
	clc
	adc.w #$0018
	sta.w lldisp
	jsl.l ChkGoalies
	jsl.l RestoreBenchEnergy
	jsl.l CheckInjury
	jsl.l updatepwrplay
.rtl:								; return
	rtl
updateplayers:						; every object's frame: the old positions kept, the goalie at each end
									; found, then updateanim, doinput and checkcoll among its steps
	lda.w #$FFFF
	sta.w topgoalie
	sta.w botgoalie
	sta.w tmnear
	sta.w $12D1
	sta.w tmnearpl
	sta.w $12D5
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
.13:								; if SPA,x is not $2708 go to .14, go to .44
	lda.w SPA,x
	cmp.w #$2708
	bne .14
	jmp.w .44
.14:								; if A < $28F6 go to .15, go to .44
	cmp.w #$28F6
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
	inc.b $36
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
	dec.b $36
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
	inc.b $36
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
	dec.b $36
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
	inc.b $36
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
	dec.b $36
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
	inc.b $36
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
	dec.b $36
.32:								; Yvel,x = $35
	lda.b $35
	sta.w Yvel,x
.33:								; Y = $FFFF, A = d7, A - 1, if the result is not 0 go to .34, ...
	ldy.w #$FFFF
	lda.b d7
	dec a
	bne .34
	jmp.w .38
.34:								; if Xvel,x < 0 go to .35, $36 = 0, A * 2, A * 2, ...
	lda.w Xvel,x
	bmi .35
	stz.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	adc.w Xfrac,x
	sta.w Xfrac,x
	lda.w Xpos,x
	adc.b $36
	sta.w Xpos,x
	bra .36
.35:								; $36 = Y, A * 2, A * 2, A * 2, ...
	sty.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	clc
	adc.w Xfrac,x
	sta.w Xfrac,x
	lda.w Xpos,x
	adc.b $36
	sta.w Xpos,x
.36:								; if Yvel,x < 0 go to .37, $36 = 0, A * 2, A * 2, ...
	lda.w Yvel,x
	bmi .37
	stz.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	adc.w Yfrac,x
	sta.w Yfrac,x
	lda.w Ypos,x
	adc.b $36
	sta.w Ypos,x
	jmp.w .42
.37:								; $36 = Y, A * 2, A * 2, A * 2, ...
	sty.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	clc
	adc.w Yfrac,x
	sta.w Yfrac,x
	lda.w Ypos,x
	adc.b $36
	sta.w Ypos,x
	jmp.w .42
.38:								; if Xvel,x < 0 go to .39, $36 = 0, A * 2, A * 2, ...
	lda.w Xvel,x
	bmi .39
	stz.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	adc.w Xfrac,x
	sta.w Xfrac,x
	lda.w Xpos,x
	adc.b $36
	sta.w Xpos,x
	bra .40
.39:								; $36 = Y, A * 2, A * 2, A * 2, ...
	sty.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	clc
	adc.w Xfrac,x
	sta.w Xfrac,x
	lda.w Xpos,x
	adc.b $36
	sta.w Xpos,x
.40:								; if Yvel,x < 0 go to .41, $36 = 0, A * 2, A * 2, ...
	lda.w Yvel,x
	bmi .41
	stz.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	adc.w Yfrac,x
	sta.w Yfrac,x
	lda.w Ypos,x
	adc.b $36
	sta.w Ypos,x
	bra .42
.41:								; $36 = Y, A * 2, A * 2, A * 2, ...
	sty.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	asl a
	rol.b $36
	clc
	adc.w Yfrac,x
	sta.w Yfrac,x
	lda.w Ypos,x
	adc.b $36
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
	lda.b $36
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
.47:								; A / 2, A + r3, $05E4,x = A, if X >= $0018 go to .49, ...
	lsr a
	adc.b r3
	sta.w $05E4,x
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
.48:								; if A >= $12D1 go to .49, $12D1 = A, $12D5 = X
	cmp.w $12D1
	bcs .49
	sta.w $12D1
	stx.w $12D5
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
.53:								; if $08AE - $012E < 0 go to .54, A = $012E
	lda.w $08AE
	cmp.w #$012E
	bmi .54
	lda.w #$012E
.54:								; $08AE = A, if $08B0 - $FED2 >= 0 go to .55, A = $FED2
	sta.w $08AE
	lda.w $08B0
	cmp.w #$FED2
	bpl .55
	lda.w #$FED2
.55:								; $08B0 = A, PadControlObj = $000F, $05B0 = A, $05B2 = A, ...
	sta.w $08B0
	lda.w #$000F
	sta.w PadControlObj
	sta.w $05B0
	sta.w $05B2
	sta.w $05B4
	sta.w $05B6
	sta.w $05B8
	sta.w PadControlObj+12
	stz.w padinputdone
	stz.w $05A6
	stz.w $05A8
	stz.w $05AA
	stz.w $05AC
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
	lda.w padnew,y
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
	cpx.w #$01B3
	bne .74
	sta.w Xpos+$1E
.74:								; if puckx - $009B < 0 go to .75, puckx = $009B, ...
	lda.w puckx
	cmp.w #$009B
	bmi .75
	lda.w #$009B
	sta.w puckx
	ldx.w frame+$1C
	cpx.w #$01B3
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
.77:								; if puckc < 0 go to .rtl, $2000 = pucky
	lda.w puckc
	bmi .rtl
	lda.w pucky
	sta.w $2000
.rtl:								; return
	rtl
DATA8_C50A00:						; not traced: data between routines
	db $FD,$FA,$F7,$F4,$F1,$EE,$EB,$E8,$E6,$E3,$FF,$FF,$FE,$FE,$FE,$FD
	db $FD,$FD,$FC,$FC
clockcont_0:						; called from other segments
	ldx.w #$001C
	stx.b a3
	lda.w #$0018
	sta.b d0
	jsl.l assinsert
	lda.w #$0007
	jsl.l StartSound
	stz.b p0
	lda.w gsp
	cmp.w #$0002
	bcs .1
	jmp.w .5
.1:									; d0 = $0008, a3 = $0000, d2 = $0005, if tmscore = tmscore+2 go to .5, ...
	lda.w #$0008
	sta.b d0
	ldx.w #$0000
	stx.b a3
	lda.w #$0005
	sta.b d2
	lda.w tmscore
	cmp.w tmscore+2
	beq .5
	bpl .loop
	ldx.w #$000C
	stx.b a3
.loop:								; loop: if position,x = 0 go to .2, if minus go to .2, ...
	lda.w position,x
	beq .2
	bmi .2
	jsl.l assinsert
	lda.w #$0008
	sta.b d0
.2:									; X + 1, X + 1, a3 = X, d2 - 1, ...
	inx
	inx
	stx.b a3
	dec.b d2
	bpl .loop
.3:									; call ClearPenaltyBuffer, A = Crowdlevel, A + $03E8, Crowdlevel = A, ...
	jsl.l ClearPenaltyBuffer
	lda.l Crowdlevel
	clc
	adc.w #$03E8
	sta.l Crowdlevel
	lda.w #$003C
	sta.b crowdhold
	lda.w #$0040
	sta.w gmclock
	tsb.w gmode
	lda.w tmscore
	cmp.w tmscore+2
	bmi .4
	lda.w #$0000
	sta.l Crowdlevel
	lda.w #$0003
	sta.w cheercnt
	lda.b Vcount
	sec
	sbc.w #$0096
	sta.w cheervc
.4:									; call ShowScoringLeaders, d0 = $0004, call AddPenalty2, ...
	jsl.l ShowScoringLeaders
	lda.w #$0004
	sta.b d0
	jsl.l AddPenalty2
	lda.b p0
	beq .rtl
	lda.w #$0032
	sta.b d0
	jsl.l AddPenalty2
.rtl:								; return
	rtl
.5:									; if gsp is not $0003 go to .6, if OptPlayMode = 0 go to .3
	lda.w gsp
	cmp.w #$0003
	bne .6
	lda.w OptPlayMode
	beq .3
.6:									; call EndPenaltyShot, d0 = $0002, go to ShootoutWonBy
	jsl.l EndPenaltyShot
	lda.w #$0002
	sta.b d0
	jml.l ShootoutWonBy
PeriodOver:							; end of a period (jumped to when the clock runs out): play turned around,
									; gsp counted with the tie check, Intermission, then StartPer for the next
									; period or the end of the game
	jsl.l FadeOut
	jsl.l forceblack
	lda.w gmode
	eor.w #$0002
	sta.w gmode
	ldy.w #$0000
.loop:								; loop: if tmpdst,y is not $FFFD go to .1, tmpdst,y = $FFFE
	lda.w tmpdst,y
	cmp.w #$FFFD
	bne .1
	lda.w #$FFFE
	sta.w tmpdst,y
.1:									; Y + 1, Y + 1, if Y < $0068 go to .loop, call SetHor, ...
	iny
	iny
	cpy.w #$0068
	bcc .loop
	jsl.l SetHor
	jsl.l setvideo
	inc.w gsp
	lda.w gsp
	cmp.w #$0003
	beq .2
	bcc .3
	lda.w #$0003
	sta.w gsp
	lda.w OptPlayMode
	cmp.w #$0003
	beq .2
	lda.w #$0004
	sta.w gsp
.2:									; if tmscore = tmscore+2 go to .3, gsp = $0004
	lda.w tmscore
	cmp.w tmscore+2
	beq .3
	lda.w #$0004
	sta.w gsp
.3:									; call ResetClock, if gsp is not $0004 go to .5, call UpdateRecords, ...
	jsl.l ResetClock
	lda.w gsp
	cmp.w #$0004
	bne .5
	jsl.l UpdateRecords
	lda.w OptPlayMode
	cmp.w #$0003
	beq .4
	cmp.w #$0002
	bne .5
.4:									; call SimDayScores
	jsr.w SimDayScores
.5:									; call Intermission, if gsp = $0004 go to .6, lastperiod = gsp, ...
	jsl.l Intermission
	lda.w gsp
	cmp.w #$0004
	beq .6
	lda.w gsp
	sta.w lastperiod
	jsl.l FadeOut
	lda.w #$FFFF
	sta.w BA_Sktr_SCnum
	jmp.w StartPer
.6:									; if OptPlayMode = $0003 go to .7, if OptPlayMode = $0002 go to .7, ...
	lda.w OptPlayMode
	cmp.w #$0003
	beq .7
	cmp.w #$0002
	beq .7
	jmp.w Restart
.7:									; call ShowPleaseWait, call SeasonGameOver, call SimDayGameStats, ...
	jsr.w ShowPleaseWait
	jsr.w SeasonGameOver
	jsr.w SimDayGameStats
	lda.w OptPlayMode
	cmp.w #$0003
	beq .8
	jsr.w RecordDayResults
	jsr.w SaveDayGameStats
	bra .9
.8:									; call UpdateDayPlayed
	jsr.w UpdateDayPlayed
.9:									; X = DayGameCount, A = SRDayPlayed
	pea.w $C57E
	plb
	pea.w $007B
	pea.w $9677
	ldx.w DayGameCount
	lda.l SRDayPlayed
.loop2:								; loop: A / 2, if carry clear go to .11, X - 1, ...
	lsr a
	bcc .11
	dex
	bne .loop2
	lda.w OptPlayMode
	cmp.w #$0003
	bne .10
	jml.l RecordPlayoffDay
.10:								; A = SeasonDay, A + 1, SeasonDay = A, SRDayPlayed = $0000, ...
	lda.l SeasonDay
	inc a
	sta.l SeasonDay
	lda.w #$0000
	sta.l SRDayPlayed
	dec a
	sta.b tmp0
	jsl.l StartMenuMusic
	jmp.w ReturnToLeagueMenu
.11:								; go to FinishSeasonDay
	pea.w $7E7F
	plb
	jmp.w FinishSeasonDay
SeasonGameOver:						; after the user's season game: its game record (the first one in use at
									; $7F8EF8) marked played in SRDayPlayed, the scores and team stats copied
									; in, then the result and the season stats (outside play mode 3)
	ldy.w #$0000
	tyx
	clc
	bra .1
.loop:								; loop: Y + 1, A = X, A + $010A, X = A
	iny
	txa
	adc.w #$010A
	tax
.1:									; if $7F8EF8,x = 0 go to .loop, tmp1 = X, A = Y, A * 2, ...
	lda.l $7F8EF8,x
	beq .loop
	stx.b tmp1
	tya
	asl a
	tax
	lda.l SRDayPlayed
	ora.l BitMaskTable,x
	sta.l SRDayPlayed
	ldx.b tmp1
	lda.w tmscore
	sta.l $7F8F02,x
	sta.l $7F8F1A,x
	sta.l $7F8F16,x
	sta.b tmp0
	lda.w tmscore+2
	sta.l $7F8F00,x
	sta.l $7F8F04,x
	sta.l $7F8F2C,x
	xba
	tsb.b tmp0
	lda.w $1297
	sta.l $7F8F1C,x
	sta.l $7F8F18,x
	lda.w $1299
	sta.l $7F8F06,x
	sta.l $7F8F2E,x
	lda.w tmchecks
	sta.l $7F8F1E,x
	lda.w tmchecks+2
	sta.l $7F8F08,x
	lda.w tmPwrPlays
	sta.l $7F8F20,x
	lda.w tmPwrPlays+2
	sta.l $7F8F0A,x
	lda.w tmPwrGoals
	sta.l $7F8F22,x
	lda.w $1261
	sta.l $7F8F0C,x
	lda.w tmSHShots
	sta.l $7F8F24,x
	lda.w $127D
	sta.l $7F8F0E,x
	lda.w tmSHGoals
	sta.l $7F8F26,x
	lda.w tmSHGoals+2
	sta.l $7F8F10,x
	lda.w tmOneTimerGoals
	sta.l $7F8F28,x
	lda.w tmOneTimerGoals+2
	sta.l $7F8F12,x
	lda.w tmOneTimerSwings
	sta.l $7F8F2A,x
	lda.w tmOneTimerSwings+2
	sta.l $7F8F14,x
	lda.w #$0000
	sta.l $7F8EF8,x
	dec a
	sta.l $7F8EFE,x
	tya
	asl a
	tax
	lda.b tmp0
	sta.l SRDayScores,x
	clc
	lda.b tmp1
	adc.w #$8F32
	tay
	ldx.w #$1413
	lda.w #$00CF
	phb
	mvn $7F,$00
	plb
	lda.w OptPlayMode
	cmp.w #$0003
	beq .rts
	pea.w $7E7F
	plb
	lda.b tmp1
	clc
	adc.w #$8EF8
	tay
	jsr.w RecordGameResult
	tyx
	lda.w $0002,y
	jsr.w AddTeamSeasonStats
	tya
	clc
	adc.w #$0016
	tax
	lda.w $0004,y
	jsr.w AddTeamSeasonStats
	plb
	jsl.l AddGamePlayerStats
.rts:								; return
	rts
ExtendTextDirtyLo:					; textdirtylo = A when A is lower; no caller found
	cmp.w textdirtylo
	bcs .rtl
	sta.w textdirtylo
.rtl:								; return
	rtl
ExtendTextDirtyHi:					; textdirtyhi = A when A is higher; no caller found
	cmp.w textdirtyhi
	bcc .rtl
	sta.w textdirtyhi
.rtl:								; return
	rtl
startpause1:						; pause from pad 1: pausepad = 0, then startpause
	stz.w pausepad
startpause:							; starts a pause: the sflags pause bit, unless sfhormode is set
	lda.w sfhormode
	bne .rtl
	lda.w #$0001
	tsb.w sflags
.rtl:								; return
	rtl
PauseFromPad:						; from demoread and other segments
	sta.w pausepad
	bra startpause
Pausemode:							; the game loop's pause (the sflags pause bit): the game state saved,
									; Pausemode_menu, the state back
	lda.w sfhormode
	pha
	jsl.l SetHor
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
	jsl.l FreePauseBuffers
	jsl.l QueueSavedTextMap
	pla
	sta.w sfhormode
	bne .1
	jsl.l ClrHor
.1:									; Vcount = 0, OldVcount = 0, call WaitTransfers, pausemenuon = 0, ...
	stz.b Vcount
	stz.w OldVcount
	jsl.l WaitTransfers
	stz.w pausemenuon
	stz.w $1857
	jsl.l forceblack
	stz.w textdirtylo
	lda.w #$0001
	trb.w sflags
	lda.w pregamepause
	bne .2
	jsl.l ScreenOn
.2:									; pregamepause = 0, A = $0006, call StartSound, call StartCrowdSound, ...
	stz.w pregamepause
	lda.w #$0006
	jsl.l StartSound
	jsl.l StartCrowdSound
	jsl.l SoundVolumeUp
	lda.w #$FFFF
	sta.w recsfx
	sta.w recsfx2
	lda.b Vcount
	sta.w lastframevc
	sta.w OldVcount
	rtl
demoread:							; from Gameloop and other segments
	lda.w OptPlayMode
	cmp.w #$0004
	bne .3
	lda.w cont1team
	ora.w cont2team
	ora.w cont3team
	ora.w cont4team
	ora.w cont5team
	beq .3
	ldx.w #$0000
.1:									; push X, if cont1team,x = 0 go to .2, A = X, A / 2, ...
	phx
	lda.w cont1team,x
	beq .2
	txa
	lsr a
	jsl.l ReadjoyA
	lda.b d3
	bit.w #$1000
	beq .2
	pla
	jmp.w PauseFromPad
.2:									; pull X, X + 1, X + 1, if X < $000A go to .1, ...
	plx
	inx
	inx
	cpx.w #$000A
	bcc .1
	rtl
.3:									; A = cont1team, A or cont2team, A or cont3team, A or cont4team, ...
	lda.w cont1team
	ora.w cont2team
	ora.w cont3team
	ora.w cont4team
	ora.w cont5team
	bne .rtl
	jsl.l ReadJoy1
	lda.b d1
	bit.w #$1000
	beq .4
	jmp.w startpause1
.4:									; if d1 is not 0 go to .5
	lda.b d1
	bne .5
.rtl:								; return
	rtl
.5:									; fadestep = 0, go to Restart
	stz.w fadestep
	jml.l Restart
CODE_C50E8D:						; no caller found (not traced)
	lda.w #$0005
	sta.w fadestep
	rtl
FadeOut:							; starts a fade out: fadestep = $FFFF
	lda.w #$FFFF
	sta.w fadestep
	rtl
GameClockTick:						; one frame of the game clock: gameclock+2 - $0AAA; on a borrow gameclock
									; - 1, clockbcd - 1 second, showclockdma, CwdExciteLvl - 3
	lda.w gameclock
	beq .rts
	lda.w gameclock+2
	sec
	sbc.w #$0AAA
	sta.w gameclock+2
	bcs .rts
	dec.w gameclock
	sep #$29
	lda.w clockbcd
	sbc.b #$01
	bcs .1
	lda.w clockbcd+1
	sbc.b #$00
	sta.w clockbcd+1
	lda.b #$59
.1:									; clockbcd = A, call showclockdma, A = CwdExciteLvl, A + $FFFD, ...
	sta.w clockbcd
	rep #$28
	jsl.l showclockdma
	lda.w CwdExciteLvl
	clc
	adc.w #$FFFD
	bmi .rts
	sta.w CwdExciteLvl
.rts:								; return
	rts
UpdateScores:						; no caller found (not traced)
	jsl.l GetShifter
	lda.b d1
	sta.w TickerNum
	asl a
	sta.b a0
.loop:								; loop: if d1 = gamenum go to .1, X = a0, A = gsflags,x, A and $FFFD, ...
	lda.b d1
	cmp.w gamenum
	beq .1
	ldx.b a0
	lda.w gsflags,x
	and.w #$FFFD
	sta.w gsflags,x
	bit.w #$0004
	bne .1
	jsl.l SetScore
.1:									; a0 - 1, a0 - 1, d1 - 1, if the result >= 0 go to .loop, ...
	dec.b a0
	dec.b a0
	dec.b d1
	bpl .loop
	rtl
GetNameandAttrib:					; an rtl: called where 94S prints the player name and one rating
	rtl
CalcAttrib:							; no caller found (not traced)
	lda.b d0
	asl a
	adc.b d0
	asl a
	asl a
	sta.b r0
	stz.b $81
	ldy.b a2
	beq .1
	lda.b r0
	clc
	adc.w #$0138
	sta.b r0
.1:									; $65 = $00C3, a0 = tmdata,y, A = [a0], A and $07FF, ...
	lda.w #$00C3
	sta.b $65
	lda.w tmdata,y
	sta.b a0
	clc
	lda.b [a0]
	and.w #$07FF
	sta.b a0
	lda.b d0
	asl a
	adc.b a0
	sta.b a0
	lda.b [a0]
	and.w #$3FFF
	sta.b a0
	lda.b [a0]
	clc
	adc.b a0
	sta.b a0
	stz.b d0
	stz.b d1
	phx
	lda.w #$0000
.2:									; d2 = A, A * 2, X = A, A = BitMaskTable2,x, ...
	sta.b d2
	asl a
	tax
	lda.l BitMaskTable2,x
	bit.b $91
	bne .3
	jmp.w .17
.3:									; if X = $000C go to .4, if X is not $001A go to .5
	cpx.w #$000C
	beq .4
	cpx.w #$001A
	bne .5
.4:									; $81 + 1
	inc.b $81
.5:									; A = $000F, A - d2, p1 = A, A / 2, ...
	lda.w #$000F
	sec
	sbc.b d2
	sta.b p1
	lsr a
	clc
	adc.b a0
	sta.b p0
	lda.b $65
	sta.b $3A
	lda.b [p0]
	sta.b d3
	lda.b d2
	lsr a
	bcc .6
	lda.b d3
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b d3
.6:									; A = d3, A and $000F, d3 = A, A = p1, ...
	lda.b d3
	and.w #$000F
	sta.b d3
	lda.b p1
	dec a
	dec a
	dec a
	cmp.w #$0006
	bcc .7
	dec a
.7:									; A + r0, X = A, if $7E24DC = 0 go to .8, A = HotColdTable,x, ...
	clc
	adc.b r0
	tax
	lda.l $7E24DC
	beq .8
	lda.w HotColdTable,x
	and.w #$00FF
.8:									; $42 = A, if A < $0080 go to .9, A = $0100, A - $42
	sta.b $42
	cmp.w #$0080
	bcc .9
	lda.w #$0100
	sbc.b $42
.9:									; r3 = A, A * 2, A + r3, A / 2, ...
	sta.b r3
	asl a
	clc
	adc.b r3
	lsr a
	lsr a
	bit.w #$2000
	beq .10
	ora.w #$C000
.10:								; r3 = A, A = $42, if $0080 bits clear go to .11, A = $0000, ...
	sta.b r3
	lda.b $42
	bit.w #$0080
	beq .11
	lda.w #$0000
	sec
	sbc.b r3
	sta.b r3
.11:								; if $91 < 0 go to .15, X = p1, A = DATA8_C510CF,x, ...
	lda.b $91
	bmi .15
	ldx.b p1
	lda.l DATA8_C510CF,x
	and.w #$00FF
	beq .14
	lda.w #$0012
	ldx.b d3
	jsl.l Mul8U
	clc
	adc.b r3
	bpl .12
	lda.w #$0000
.12:								; if A < $0065 go to .13, A = $0064
	cmp.w #$0065
	bcc .13
	lda.w #$0064
.13:								; d0 = A, pull X, go to .25
	sta.b d0
	plx
	jmp.w .25
.14:								; d0 = d3, pull X, go to .25
	lda.b d3
	sta.b d0
	plx
	jmp.w .25
.15:								; A = p1, A + r2, X = A, A = DATA8_C510AF,x, ...
	lda.b p1
	clc
	adc.b r2
	tax
	lda.l DATA8_C510AF,x
	ldx.b d3
	jsl.l Mul8U
	clc
	adc.b d0
	sta.b d0
	lda.b r3
	ldy.b r2
	beq .16
	asl a
.16:								; A + d1, d1 = A
	clc
	adc.b d1
	sta.b d1
.17:								; A = d2, A + 1, if A - $000F >= 0 go to .18, go to .2
	lda.b d2
	inc a
	cmp.w #$000F
	bpl .18
	jmp.w .2
.18:								; if d1 >= 0 go to .21, A xor $FFFF, A + 1, if r2 is not 0 go to .19, ...
	lda.b d1
	bpl .21
	eor.w #$FFFF
	inc a
	ldx.b r2
	bne .19
	tax
	lda.w #$000A
	bra .20
.19:								; X = A, A = $0007
	tax
	lda.w #$0007
.20:								; call DivX8U, A xor $FFFF, A + d0, d0 = A, ...
	jsl.l DivX8U
	sec
	eor.w #$FFFF
	adc.b d0
	sta.b d0
	lda.b d0
	bpl .24
	stz.b d0
	lda.w #$0000
	bra .24
.21:								; if r2 is not 0 go to .22, X = A, A = $000A, go to .23
	ldx.b r2
	bne .22
	tax
	lda.w #$000A
	bra .23
.22:								; X = A, A = $0007
	tax
	lda.w #$0007
.23:								; call DivX8U, A + d0, d0 = A, if d0 >= 0 go to .24, ...
	jsl.l DivX8U
	clc
	adc.b d0
	sta.b d0
	lda.b d0
	bpl .24
	stz.b d0
	lda.w #$0000
.24:								; d0 = A, pull X, if r2 = 0 go to .25, d0 / 2
	sta.b d0
	plx
	lda.b r2
	beq .25
	lsr.b d0
.25:								; if $81 is not 0 go to .rtl, if d0 < $0065 go to .26, A = $0064
	lda.b $81
	bne .rtl
	lda.b d0
	cmp.w #$0065
	bcc .26
	lda.w #$0064
.26:								; if A >= $0032 go to .27, A / 2, A + $0019
	cmp.w #$0032
	bcs .27
	lsr a
	clc
	adc.w #$0019
.27:								; d0 = A
	sta.b d0
.rtl:								; return
	rtl
DATA8_C510AF:						; not traced: a table read by CalcAttrib
	db $00,$00,$01,$02,$03,$03,$02,$01,$02,$01,$03,$02,$01,$01,$01,$01
	db $00,$00,$00,$09,$02,$02,$09,$09,$02,$02,$02,$02,$02,$02,$02,$02
DATA8_C510CF:						; not traced: a table read by CalcAttrib
	db $00,$00,$00,$01,$01,$01,$01,$01,$01,$00,$01,$01,$01,$01,$01,$01
GetPeriodTimeRemaining:				; called from other segments
	lda.w gsp
	xba
	and.w #$FF00
	asl a
	asl a
	asl a
	asl a
	asl a
	asl a
	ora.w PerTimeTotal
	sec
	sbc.w gameclock
	sta.b d0
	rtl

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
	sta.b a3+2
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
	ldx.w #mp5readall
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
	inc.w gamesstarted
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

Pausemode_menu:						; the pause menu screen: its music, the Options tab first, the pad until
									; start / select (.resume)
	jsl.l SoundVolumeDown
	jsl.l FadeOutWait
	stz.w PauseMusicOn
	lda.w pregamepause
	bne .1
	lda.w InIntermission
	beq .2
.1:									; A = (SongLists+$3)&$FFFF, X = (SongLists+$3)>>16, ...
	lda.w #(SongLists+$3)&$FFFF
	ldx.w #(SongLists+$3)>>16
	jsl.l LoadSounds
	lda.w #$00A5
	jsl.l StartSound
	jsl.l SoundVolumeUp
	dec.w PauseMusicOn
.2:									; call InitPauseScreen, X = $0002, call SetPauseTab, mp5readall = $0001
	jsr.w InitPauseScreen
	ldx.w #$0002
	jsr.w SetPauseTab
	lda.w #$0001
	sta.w mp5readall
.3:									; TransfersReady + 1
	inc.w TransfersReady
.loop:								; loop: if TransfersReady is not 0 go to .loop, A = teampads, ...
	lda.w TransfersReady
	bne .loop
	lda.w teampads
	ora.w teampads+2
	bne .4
	stz.w padside
	jsl.l ReadActiveMenuPad
	dec.w padside
	bra .5
.4:									; call ReadActiveMenuPad
	jsl.l ReadActiveMenuPad
.5:									; $26 + 1, call AnimateSprites, $28 = OAMBuf+$1FF, $2A = OAMHighBytes, ...
	inc.b $26
	jsl.l AnimateSprites
	lda.w #OAMBuf+$1FF
	sta.b $28
	lda.w #OAMHighBytes
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	lda.w repeatdelayframes
	bne .3
	jsr.w PauseMenuInput
	lda.w padchangeany
	bit.w #$3000
	beq .3
.resume:							; start / select leave the pause screen: back to the game
									; (RestoreGameScreen); PauseReplay comes here after the replay
	lda.w PauseMapBuf
	sta.w WorkBufMark
	sta.b $08
	stz.b $22
	ldx.w PauseSprite
	jsl.l DeleteSprite
	jmp.w RestoreGameScreen

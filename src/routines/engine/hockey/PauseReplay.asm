PauseReplay:						; pause menu Inst Replay: fade out, the game state kept, vcountmark+2 set
									; back two, ReplayMode, then back to the pause screen's exit
	jsl.l FadeOutWait
	lda.w PauseMapBuf
	sta.w WorkBufMark
	sta.b $08
	stz.b $22
	ldx.w PauseSprite
	jsl.l DeleteSprite
	jsl.l RestorePauseBuffers
	jsl.l RestoreGameScreen
	pei ($9B)
	lda.b $5F
	dec a
	dec a
	sta.w vcountmark+2
	lda.w pregamepause
	bne .1
	jsl.l ReplayMode
.1:									; pull A, d7 = A, $A2 = A, pull A, ...
	pla
	sta.b d7
	sta.b $A2
	pla
	jmp.w Pausemode_menu_resume

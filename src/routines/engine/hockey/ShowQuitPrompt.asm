ShowQuitPrompt:						; shows the quit prompt (tab 3: Resume Game, Quit Game)
	lda.w #$0003
ShowPauseTab:						; shows tab A of the pause menu at item 0 (DrawPauseTab)
	stz.w pauseitem
	sta.w pausetab
	jmp.w DrawPauseTab

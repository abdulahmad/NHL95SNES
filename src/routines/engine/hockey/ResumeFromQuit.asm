ResumeFromQuit:						; the quit prompt's Resume Game: back to the Options tab (2)
	lda.w #$0002
	bra ShowPauseTab

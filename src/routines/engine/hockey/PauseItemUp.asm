PauseItemUp:						; the pause menu item one up (pauseitem - 1, not below 0), the tab redrawn
	lda.w pauseitem
	beq PauseMenuReturn
	dec a
	sta.w pauseitem
RedrawPauseTab:						; DrawPauseTab for the current tab
	lda.w pausetab
	bra DrawPauseTab

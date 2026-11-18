PauseItemDown:						; the pause menu item one down (below pauseitems), the tab redrawn
	lda.w pauseitem
	inc a
	cmp.w pauseitems
	bcs PauseMenuReturn
	sta.w pauseitem
	bra RedrawPauseTab

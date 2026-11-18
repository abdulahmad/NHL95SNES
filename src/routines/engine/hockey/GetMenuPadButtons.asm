GetMenuPadButtons:					; copy the menu button word to d1
	lda.w padchangeany
	sta.b d1
	rtl

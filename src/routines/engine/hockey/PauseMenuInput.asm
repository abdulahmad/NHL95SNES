PauseMenuInput:						; the pause menu's pad: left / right the tab (pausetab 0-2), up / down the
									; item (pauseitem), B runs the item through the tab's table (the shorter
									; ones in play mode 1)
	lda.w padchangeany
	bit.w #$0200
	beq .1
	ldx.w pausetab
	beq .1
	cpx.w #$0003
	bcs .1
	dex
	bra SetPauseTab
.1:									; if $0100 bits clear go to .2, X = pausetab, X + 1, ...
	bit.w #$0100
	beq .2
	ldx.w pausetab
	inx
	cpx.w #$0003
	bcc SetPauseTab
.2:									; if a $0800 bit set go to PauseItemUp, ...
	bit.w #$0800
	bne PauseItemUp
	bit.w #$0400
	bne PauseItemDown
	bit.w #$8000
	bne RunPauseItem
PauseMenuReturn:					; the shared rts of PauseMenuInput and its item and tab routines
	rts

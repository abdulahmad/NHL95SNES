ReadPads:							; once per frame: each pad's direction (PadDirection), then the changed
									; and new buttons (GetNewPresses)
	lda.b PadRaw1
	xba
	and.w #$000F
	tax
	lda.l PadDirection,x
	and.w #$00FF
	sta.w paddir
	lda.b PadRaw2
	xba
	and.w #$000F
	tax
	lda.l PadDirection,x
	and.w #$00FF
	sta.w paddir+2
	lda.b PadRaw3
	xba
	and.w #$000F
	tax
	lda.l PadDirection,x
	and.w #$00FF
	sta.w paddir+4
	lda.b PadRaw4
	xba
	and.w #$000F
	tax
	lda.l PadDirection,x
	and.w #$00FF
	sta.w paddir+6
	lda.b PadRaw5
	xba
	and.w #$000F
	tax
	lda.l PadDirection,x
	and.w #$00FF
	sta.w paddir+8
	jsr.w GetNewPresses
	lda.w padchange
	ora.w padchange+2
	ora.w padchange+4
	ora.w padchange+6
	ora.w padchange+8
	sta.w padchangeany
	rtl

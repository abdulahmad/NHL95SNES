SetupStatsPage:						; SetupScreen, then the page A (PrintTextPage) and both teams' logo
									; sprites
	pha
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	jsr.w SetupScreen
	pla
	jsl.l PrintTextPage
	lda.w #$0040
	sta.b $18
	sta.b $1A
	lda.w VisTeam
	jsl.l CreateSprite
	lda.w #$00C0
	sta.b $18
	lda.w HomeTeam
	jsl.l CreateSprite
	inc.b $38,x
	ldy.w #$2801
	ldx.w #$5194
	jsl.l MapTileBlock
	ldy.w #$2C01
	ldx.w #$5184
	jsl.l MapTileBlock
	lda.w #$0020
	sta.b $CF
	lda.w #$0068
	sta.b $D1
	lda.w VisTeam
	asl a
	tax
	lda.l TeamCityNames,x
	tax
	ldy.w #$000C
	jsl.l PrintThinCentred
	lda.w #$00A0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	lda.w HomeTeam
	asl a
	tax
	lda.l TeamCityNames,x
	tax
	ldy.w #$000C
	jsl.l PrintThinCentred
	rts

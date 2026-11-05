TitleStartTextPage:					; draws the next title text page and starts its fade task
	jsr.w DrawTitleTextPage
	ldx.b d1
	lda.w #TitleFadeTextIn
	sta.w $0002,x
TitleFadeTextIn:					; fades in the title text palette and resets the page hold timer
	lda.w #$0000
	jsr.w QueueFadeStep
	bne TitleFinishWhiteFadeReturn
	ldx.b d1
	stz.w $0008,x
	lda.w #TitleHoldTextPage
	sta.w $0002,x
TitleHoldTextPage:					; holds the title text page, then starts its fade to black
	lda.w $0008,x
	cmp.w #$00F0
	bne TitleEndDelayReturn
	lda.w #$0010
	sta.b d3
	lsr a
	sta.b $7D
	lda.b d4
	ldy.w #$0000
	jsl.l FillWords7E
	lda.w #TextPalettes>>16
	sta.b a3+2
	lda.w #TextPalettes&$FFFF
	sta.b a3
	ldx.w #$007E
	lda.b d4
	ldy.b d5
	jsl.l StartColourFade
	ldx.b d1
	lda.w #TitleFadeTextOut
	sta.w $0002,x
TitleFadeTextOut:					; fades out the text and selects the next page or the final title delay
	lda.w #$0000
	jsr.w QueueFadeStep
	bne TitleEndDelayReturn
	ldx.b d5+2
	lda.l CreditsPages,x
	and.w #$00FF
	bne .1
	ldx.b d1
	stz.w $0008,x
	lda.w #TitleEndDelay
	sta.w $0002,x
	rtl
.1:									; X = d1, $0002,x = TitleStartTextPage, return
	ldx.b d1
	lda.w #TitleStartTextPage
	sta.w $0002,x
	rtl

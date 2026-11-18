CreditsWaitForFade:					; waits for the developer credits delay before fading their palettes
	lda.w $0008,x
	cmp.w #$00B4
	bne CreditsEndDelayReturn
	lda.w #CreditsFadePalettes
	sta.w $0002,x
CreditsFadePalettes:				; steps and queues both developer credits palette fades
	lda.w #$0060
	sta.b d3
	ldy.b d7
	jsl.l StepColourFade
	lda.b d6
	ldx.w #$007E
	ldy.b d7
	jsl.l PackFadeColours
	lda.b d6
	ldx.w #$007E
	ldy.w #$0020
	jsl.l QueueColours
	lda.w #$0020
	sta.b d3
	ldy.b d5
	jsl.l StepColourFade
	lda.b d4
	ldx.w #$007E
	ldy.b d5
	jsl.l PackFadeColours
	lda.b d4
	ldx.w #$007E
	ldy.w #$0000
	jsl.l QueueColours
	dec.b $7D
	bne CreditsEndDelayReturn
	ldx.b d1
	stz.w $0008,x
	lda.w #CreditsEndDelay
	sta.w $0002,x
CreditsEndDelay:					; ends the developer credits task sequence after the final delay
	lda.w $0008,x
	cmp.w #$00B4
	bne CreditsEndDelayReturn
	lda.w #$8000
	trb.b d1+2
CreditsEndDelayReturn:				; the rtl CreditsEndDelay ends with, shared by the other credits tasks
	rtl

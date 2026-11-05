DrawTitleTextPage:					; draws the next centred title text page and starts its palette fade
	lda.w #$0020
	sta.b $7D
	lsr a
	sta.b d3
	lda.w #$007E
	sta.b a3+2
	lda.b d4
	sta.b a3
	ldy.w #$0000
	jsl.l FillWords7E
	ldx.w #TextPalettes>>16
	lda.w #TextPalettes&$FFFF
	ldy.b d5
	jsl.l StartColourFade
	lda.b $D3
	ldy.w #$0700
	jsl.l ClearRAM7E
	ldx.b d5+2
	lda.l CreditsPages,x
	and.w #$00FF
	sta.b d6+2
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	stz.b d6
	lda.w #$2400
	sta.b $D5
	inx
.loop:								; loop: d5+2 = X, A = CreditsPages,x, X = A, Y = d6, ...
	stx.b d5+2
	lda.l CreditsPages,x
	tax
	ldy.b d6
	jsl.l PrintBoldCentred
	ldx.b d5+2
	lda.w #$2000
	cmp.b $D5
	beq .1
	sta.b $D5
	inc.b d6
.1:									; d6 + 1, X + 1, X + 1, d6+2 - 1, ...
	inc.b d6
	inx
	inx
	dec.b d6+2
	bne .loop
	stx.b d5+2
	dec.b QueueBusy
	lda.b VRAMQueueSP
	tsx
	tcs
	stx.b VRAMQueueSP
	pea.w $0180
	pea.w $56C0
	pea.w $007E
	pei ($D3)
	lda.b VRAMQueueSP
	tsx
	tcs
	stx.b VRAMQueueSP
	stz.b QueueBusy
	rts

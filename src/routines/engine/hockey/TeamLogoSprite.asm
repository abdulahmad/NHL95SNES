TeamLogoSprite:						; for team a2 (HomeTeam / VisTeam): its 16 logo colours queued from
									; $7F:D80A + team * 32 and its logo sprite made (CreateSprite, the object
									; in $7B)
	jsl.l WaitTransfers
	ldy.w HomeTeam
	lda.b a2
	beq .1
	ldy.w VisTeam
.1:									; push Y, QueueBusy - 1, A = CGRAMQueueSP, CGRAMQueueSP = X, ...
	phy
	dec.b QueueBusy
	lda.b CGRAMQueueSP
	tsx
	tcs
	stx.b CGRAMQueueSP
	pea.w $0020
	pea.w $0020
	pea.w $007F
	tya
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$D80A
	pha
	lda.b CGRAMQueueSP
	tsx
	tcs
	stx.b CGRAMQueueSP
	stz.b QueueBusy
	lda.b $01,s
	jsl.l CreateSprite
	stx.b $7B
	lda.w #$0001
	trb.b $26
	jsl.l AnimateSprites
	lda.w #OAMBuf+$1FF
	sta.b $28
	lda.w #OAMHighBytes
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	pla
	asl a
	tax
	lda.l TeamCityNames,x
	tax
	ldy.w #$0009
	jsl.l PrintThinCentred
	jsl.l SendTextMap
	jsl.l WaitTransfers
	rts

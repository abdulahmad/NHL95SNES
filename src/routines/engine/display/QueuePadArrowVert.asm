QueuePadArrowVert:					; queues the pad's up / down edge arrow image (from + 0 of its tile source
									; in bank $7F) to its three VRAM blocks
	tsc
	sta.b $28
	lda.b VRAMQueueSP
	tcs
	pea.w $0040
	lda.l $C4FFFA,x
	pha
	pea.w $007F
	lda.l $C4FFF4,x
	pha
	tay
	pea.w $0040
	lda.l $C4FFFC,x
	pha
	pea.w $007F
	tya
	adc.w #$0040
	pha
	adc.w #$0040
	tay
	pea.w $0060
	lda.l $C4FFFE,x
	pha
	pea.w $007F
	phy
	tsc
	sta.b VRAMQueueSP
	lda.b $28
	tcs
	rts

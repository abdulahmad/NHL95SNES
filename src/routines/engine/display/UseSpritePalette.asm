UseSpritePalette:					; gives object X sprite palette A: a palette already loaded is reused
									; (ReuseSpritePalette), else one of the 8 free CGRAM slots (PalSlotList,
									; PalSlotsUsed) is taken and the colours queued (QueueSpritePalette)
	sta.b $34,x
	txy
	asl a
	tax
	lda.w SpritePalUse,x
	bpl ReuseSpritePalette
	lda.w PalSlotsUsed
	cmp.w #$0008
	bcc .1
	brk #$00						; a brk in the ROM, between routines
.1:									; A + 1, PalSlotsUsed = A, push X, X = PalSlotNext, ...
	inc a
	sta.w PalSlotsUsed
	phx
	ldx.w PalSlotNext
	lda.w PalSlotList,x
	inx
	inx
	stx.w PalSlotNext
	plx
	xba
	sta.w SpritePalUse,x
	ora.w $0034,y
	sta.w $0034,y
QueueSpritePalette:					; queues the 16 colours of sprite palette A (low byte) to CGRAM slot (high
									; byte) + 8
	phy
	tay
	dec.b QueueBusy
	lda.b CGRAMQueueSP
	tsx
	tcs
	stx.b CGRAMQueueSP
	pea.w $0020
	tya
	xba
	and.w #$00FF
	adc.w #$0008
	asl a
	asl a
	asl a
	asl a
	pha
	tya
	bit.w #$0080
	bne .1
	lda.l $808004
	pha
	tya
	and.w #$00FF
	xba
	lsr a
	lsr a
	lsr a
	adc.l $808002
	bra .2
.1:									; A and $007F, A / 2, A / 2, A / 2, ...
	pea.w $00C0
	and.w #$007F
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$3F02
.2:									; push A, A = CGRAMQueueSP, CGRAMQueueSP = X, QueueBusy = 0, ...
	pha
	lda.b CGRAMQueueSP
	tsx
	tcs
	stx.b CGRAMQueueSP
	stz.b QueueBusy
	plx
	rtl

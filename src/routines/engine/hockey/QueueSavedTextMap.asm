QueueSavedTextMap:					; queues the text map saved at the pause ($800 bytes from the buffer at
									; pausesavebuf) to VRAM $5800
	dec.b QueueBusy
	lda.b VRAMQueueSP
	tsx
	tcs
	stx.b VRAMQueueSP
	pea.w $0800
	pea.w $5800
	pea.w $007E
	lda.w pausesavebuf&$FFFF
	inc a
	inc a
	pha
	lda.b VRAMQueueSP
	tsx
	tcs
	stx.b VRAMQueueSP
	stz.b QueueBusy
	jsl.l WaitTransfers
	lda.w #$0802
	jsl.l FreeWorkBuf
	jml.l MarkWorkBuf

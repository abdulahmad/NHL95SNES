LoadSample:							; assigns sample A a driver slot, copies its header parameters and uploads
									; BRR data if not already loaded
	and.w #$00FF
	tax
	lda.w SampleSlots,x
	and.w #$00FF
	bne .1
	lda.w SampleSlotNext
	inc.w SampleSlotNext
	sep #$20
	sta.w SampleSlots,x
	rep #$20
	asl a
	asl a
	tay
	txa
	asl a
	asl a
	tax
	lda.l SampleList,x
	sta.w SampleSlotSources,y
	lda.l SampleList+2,x
	sta.w SampleSlotSources+2,y
	tyx
	bra .2
.1:									; A * 2, A * 2, X = A
	asl a
	asl a
	tax
.2:									; r1 = SampleSlotSources,x, r1+2 = SampleSlotSources+2,x, ...
	lda.w SampleSlotSources,x
	sta.b r1
	lda.w SampleSlotSources+2,x
	sta.b r1+2
	lda.b [r1]						; header +0: the pitch; +2 / +3 the left / right volume
	sta.w SampleParams,x
	ldy.w #$0002
	lda.b [r1],y
	sta.w SampleParams+2,x
	txa
	lsr a
	tax
	ldy.w #$0004					; header +4: the note transpose; +5 the signed fine tune
	lda.b [r1],y
	sta.w SampleNoteParams,x
	ldy.w #$0006
LoadSampleEnvelopeAndData:			; stores the envelope (header +6 ADSR1, +7 ADSR2 or, with ADSR1 bit 7
									; clear, GAIN), reuses matching BRR data or allocates and uploads it
	lda.b [r1],y
	sta.w SampleEnvelopes,x
	txa
	asl a
	tax
	ldy.w #$0000
.1:									; if LoadedSampleSources,y is not r1 go to .2, ...
	lda.w LoadedSampleSources,y
	cmp.b r1
	bne .2
	lda.w LoadedSampleSources+2,y
	cmp.b r1+2
	bne .2
	lda.w SampleDirectory,y
	sta.w SampleDirectory,x
	lda.w SampleDirectory+2,y
	sta.w SampleDirectory+2,x
	rtl
.2:									; Y + 1, Y + 1, Y + 1, Y + 1, ...
	iny
	iny
	iny
	iny
	cpy.w #$0100
	bne .1
	lda.b r1
	sta.w LoadedSampleSources,x
	lda.b r1+2
	sta.w LoadedSampleSources+2,x
	clc
	ldy.w #$0008					; header +8: the loop offset (0 stays 0, else + the BRR base)
	lda.b [r1],y
	beq .3
	adc.b tmp0
.3:									; SampleDirectory+2,x = A, SampleDirectory,x = tmp0, A = r1, ...
	sta.w SampleDirectory+2,x
	lda.b tmp0
	sta.w SampleDirectory,x
	lda.b r1
	adc.w #$000A					; header +10: the BRR length; the BRR data from +12
	sta.b r1
AppendSoundData:					; allocates space for the length-prefixed block at r1 and sends it to the
									; sound CPU
	lda.b tmp0
	tay
	clc
	adc.b [r1]
	bcs .1
	cmp.w #$F47F
	bcc .2
.1:									; SoundAllocWraps + 1, A = $0C00, Y = A
	inc.w SoundAllocWraps
	lda.w #$0C00
	tay
.2:									; tmp0 = A, A = r1, X = r1+2
	sta.b tmp0
	lda.b r1
	ldx.b r1+2
UploadSoundData:					; sends the length-prefixed block at X:A to sound RAM Y with command $19
									; and port handshakes
	sta.b r0
	stx.b r0+2
	tya
	tyx
	sta.l APUIO1
	lda.b [r0]
	tax
	ldy.w #$0002
	stz.b tmp1
	sep #$20
	lda.b #$19
	sta.l APUIO3
	lda.b #$00
.loop:								; loop: if A is not APUIO3 go to .loop
	cmp.l APUIO3
	bne .loop
.loop2:								; loop: APUIO0 = [r0],y, Y + 1, APUIO1 = [r0],y, Y + 1, ...
	lda.b [r0],y
	sta.l APUIO0
	iny
	lda.b [r0],y
	sta.l APUIO1
	iny
	lda.b [r0],y
	sta.l APUIO2
	iny
	lda.b tmp1
	inc a
	bpl .1
	and.b #$7F
.1:									; tmp1 = A, X - 1, if the result = 0 go to .4, X - 1, ...
	sta.b tmp1
	dex
	beq .4
	dex
	beq .3
	dex
	beq .2
	sta.l APUIO3
.loop3:								; loop: if A is not APUIO3 go to .loop3, go to .loop2
	cmp.l APUIO3
	bne .loop3
	bra .loop2
.2:									; A = $83, go to .5
	lda.b #$83
	bra .5
.3:									; A = $82, go to .5
	lda.b #$82
	bra .5
.4:									; A = $81
	lda.b #$81
.5:									; APUIO3 = A, A = $7E
	sta.l APUIO3
	lda.b #$7E
.loop4:								; loop: if A is not APUIO3 go to .loop4, A 16-bit, return
	cmp.l APUIO3
	bne .loop4
	rep #$20
	rtl

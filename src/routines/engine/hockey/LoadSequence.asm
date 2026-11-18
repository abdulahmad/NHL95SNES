LoadSequence:						; uploads sequence A and its referenced samples, recording the sequence
									; address for the driver
	and.w #$007F
	pei ($34)
	pei ($36)
	asl a
	tay
	asl a
	tax
	lda.b tmp0
	sta.w SequenceAddrs,y
	lda.l SoundSequenceTable,x
	sta.b r1
	lda.l SoundSequenceTable+2,x
	sta.b r1+2
	jsl.l AppendSoundData
	lda.b r1
	sta.b r2
	lda.b r1+2
	sta.b r2+2
	ldy.w #$0003
	lda.b [r2],y
	and.w #$007F
	tax
	iny
.loop:								; loop: A = [r2],y, A and $00FF, push X, push Y, ...
	lda.b [r2],y
	and.w #$00FF
	phx
	phy
	jsl.l LoadSample
	ply
	plx
	iny
	dex
	bne .loop
	lda.b r2						; the address's low word, not the flag byte (r2+2):
	bmi .1							; the index is address bits 8-14, past the 4 lists
	xba
	and.w #$007F
	asl a
	tax
	lda.l SampleVolumeOverrideLists,x
	tax
.loop2:								; loop: A = $CF0000,x, A and $00FF, if A >= $0021 go to .1, Y = A, ...
	lda.l $CF0000,x
	and.w #$00FF
	cmp.w #$0021
	bcs .1
	tay
	lda.w SampleSlots,y
	and.w #$00FF
	asl a
	asl a
	tay
	lda.l $CF0001,x
	sta.w SampleParams+2,y
	inx
	inx
	inx
	bra .loop2
.1:									; pull A, r2+2 = A, pull A, r2 = A, ...
	pla
	sta.b r2+2
	pla
	sta.b r2
	rtl

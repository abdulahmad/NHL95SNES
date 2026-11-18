UploadSpriteFrames:					; upload each frame in the object's negative-terminated frame list
	stx.b $18
	txy
	lda.b $10,x
	sta.b $10
	lda.b $14,x
	sta.b $12
	dec.b QueueBusy
	tsc
	sta.b $0A
	lda.b VRAMQueueSP
	tcs
	lda.b $28,x
.1:									; A * 2, A + $26,x, X = A, A = $00,x, ...
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $00,x
	xba
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	sta.b tmp2
	lda.b $00,x
	and.w #$FF00
	lsr a
	lsr a
	sta.b tmp3
	lda.b $04,x
	sta.b p1
	lda.b tmp2
	beq .2
	pha
	pei ($10)
	lsr a
	adc.b $10
	sta.b $10
	lda.b p1
	bit.w #$0001
	beq .3
	pea.w $007E
	sty.b $42
	ldy.b $07,x
	sty.b r0+2
	sty.b r1+2
	lda.b $05,x
	phb
	jsr.w UnpackStream0
	plb
	pei ($08)
	sty.b $08
	ldy.b $42
	bra .4
.2:									; r0+2 = $07,x, r1+2 = A, A = $05,x, X = A, ...
	lda.b $07,x
	sta.b r0+2
	sta.b r1+2
	lda.b $05,x
	tax
	bra .4
.3:									; A = $07,x, push A, r0+2 = A, r1+2 = A, ...
	lda.b $07,x
	pha
	sta.b r0+2
	sta.b r1+2
	lda.b $05,x
	pha
	adc.b tmp2
	tax
.4:									; if tmp3 is not 0 go to .5, go to .11
	lda.b tmp3
	bne .5
	jmp.w .11
.5:									; A = p1, if $0002 bits clear go to .7, if $0001 bits clear go to .6, ...
	lda.b p1
	bit.w #$0002
	beq .7
	bit.w #$0001
	beq .6
	sec
	lda.b $08
	sbc.b tmp3
	sta.b r1
	sbc.b tmp3
	sta.b r0
	clc
	lda.w #$007E
	sta.b r0+2
	sta.b r1+2
	bra .8
.6:									; $42 = Y, Y = r0+2, A = X, call UnpackStream0, ...
	sty.b $42
	ldy.b r0+2
	txa
	phb
	jsr.w UnpackStream0
	plb
	lda.w #$007E
	sta.b r0+2
	sta.b r1+2
	lda.b $08
	sta.b r0
	sty.b $08
	adc.b tmp3
	sta.b r1
	ldy.b $42
	bra .8
.7:									; r0 = X, A = X, A + tmp3, r1 = A
	stx.b r0
	txa
	adc.b tmp3
	sta.b r1
.8:									; $0C = $12
	lda.b $12
	sta.b $0C
.loop:								; loop: A and $00FF, A * 2, $0E = A, A + tmp3, ...
	and.w #$00FF
	asl a
	sta.b $0E
	adc.b tmp3
	cmp.w #$0201
	bcc .9
	lda.w #$0200
	sbc.b $0E
	sta.b $0E
	pha
	pei ($0C)
	pei ($2E)
	pei ($2C)
	pha
	lda.b $0C
	adc.w #$00FF
	pha
	pei ($32)
	pei ($30)
	lda.b r0
	adc.b $0E
	sta.b r0
	lda.b r1
	adc.b $0E
	sta.b r1
	sec
	lda.b tmp3
	sbc.b $0E
	sta.b tmp3
	lda.b $0C
	adc.w #$01FF
	and.w #$FF00
	sta.b $0C
	bra .loop
.9:									; A = $0C, A + $0100, push A, A = tmp3, ...
	pei ($A5)
	pei ($0C)
	pei ($2E)
	pei ($2C)
	pei ($A5)
	lda.b $0C
	adc.w #$0100
	pha
	pei ($32)
	pei ($30)
	lda.b tmp3
	lsr a
	adc.b $0C
	bit.w #$0100
	beq .10
	adc.w #$0100
.10:								; $12 = A
	sta.b $12
.11:								; Y + 1, Y + 1, if $0028,y < 0 go to .12, X = $18, ...
	iny
	iny
	lda.w $0028,y
	bmi .12
	ldx.b $18
	jmp.w .1
.12:								; VRAMQueueSP = A, A = $0A, QueueBusy = 0, Y = $18, ...
	tsc
	sta.b VRAMQueueSP
	lda.b $0A
	tcs
	stz.b QueueBusy
	ldy.b $18
	tyx
	rts

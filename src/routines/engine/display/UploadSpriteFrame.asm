UploadSpriteFrame:					; queue object X's current frame tiles for VRAM (unpacked if packed)
	txy
	lda.b $28,x
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
	sta.b tmp0
	dec.b QueueBusy
	tsc
	sta.b $0A
	lda.b VRAMQueueSP
	tcs
	lda.b tmp2
	beq .1
	pha
	lda.w $0010,y
	pha
	lda.b tmp0
	bit.w #$0001
	beq .2
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
	bra .3
.1:									; r0+2 = $07,x, r1+2 = A, A = $05,x, X = A, ...
	lda.b $07,x
	sta.b r0+2
	sta.b r1+2
	lda.b $05,x
	tax
	bra .3
.2:									; A = $07,x, push A, r0+2 = A, r1+2 = A, ...
	lda.b $07,x
	pha
	sta.b r0+2
	sta.b r1+2
	lda.b $05,x
	pha
	adc.b tmp2
	tax
.3:									; if tmp3 is not 0 go to .4, go to .9
	lda.b tmp3
	bne .4
	jmp.w .9
.4:									; A = tmp0, if $0002 bits clear go to .6, ...
	lda.b tmp0
	bit.w #$0002
	beq .6
	bit.w #$0001
	beq .5
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
	bra .7
.5:									; $42 = Y, Y = r0+2, A = X, call UnpackStream0, ...
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
	bra .7
.6:									; r0 = X, A = X, A + tmp3, r1 = A
	stx.b r0
	txa
	adc.b tmp3
	sta.b r1
.7:									; $0C = $0014,y
	lda.w $0014,y
	sta.b $0C
.loop:								; loop: A and $00FF, A * 2, $0E = A, A + tmp3, ...
	and.w #$00FF
	asl a
	sta.b $0E
	adc.b tmp3
	cmp.w #$0201
	bcc .8
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
.8:									; A = $0C, A + $0100, push A
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
.9:									; VRAMQueueSP = A, A = $0A, QueueBusy = 0, X = Y, ...
	tsc
	sta.b VRAMQueueSP
	lda.b $0A
	tcs
	stz.b QueueBusy
	tyx
	rts

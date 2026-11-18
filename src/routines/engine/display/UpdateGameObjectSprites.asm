UpdateGameObjectSprites:			; queue changed player frames and build sorted object sprites
	lda.b gameframes
	lsr a
	bcc .1
	jmp.w .8
.1:									; if frame+$C = frame+$2C go to .2, tmp2 = $2100, tmp1 = $2018, ...
	lda.w frame+$C
	cmp.w frame+$2C
	beq .2
	ldx.w #$2100
	stx.b tmp2
	ldx.w #$2018
	stx.b tmp1
	sta.w frame+$2C
	jsl.l QueueFrameTiles
.2:									; if frame+$E = frame+$2E go to .3, tmp2 = $2108, tmp1 = $201C, ...
	lda.w frame+$E
	cmp.w frame+$2E
	beq .3
	ldx.w #$2108
	stx.b tmp2
	ldx.w #$201C
	stx.b tmp1
	sta.w frame+$2E
	jsl.l QueueFrameTiles
.3:									; if frame+$10 = frame+$30 go to .4, tmp2 = $2120, tmp1 = $2020, ...
	lda.w frame+$10
	cmp.w frame+$30
	beq .4
	ldx.w #$2120
	stx.b tmp2
	ldx.w #$2020
	stx.b tmp1
	sta.w frame+$30
	jsl.l QueueFrameTiles
.4:									; if frame+$12 = frame+$32 go to .5, tmp2 = $2128, tmp1 = $2024, ...
	lda.w frame+$12
	cmp.w frame+$32
	beq .5
	ldx.w #$2128
	stx.b tmp2
	ldx.w #$2024
	stx.b tmp1
	sta.w frame+$32
	jsl.l QueueFrameTiles
.5:									; if frame+$14 = frame+$34 go to .6, tmp2 = $2140, tmp1 = $2028, ...
	lda.w frame+$14
	cmp.w frame+$34
	beq .6
	ldx.w #$2140
	stx.b tmp2
	ldx.w #$2028
	stx.b tmp1
	sta.w frame+$34
	jsl.l QueueFrameTiles
.6:									; if frame+$16 = frame+$36 go to .7, tmp2 = $2148, tmp1 = $202C, ...
	lda.w frame+$16
	cmp.w frame+$36
	beq .7
	ldx.w #$2148
	stx.b tmp2
	ldx.w #$202C
	stx.b tmp1
	sta.w frame+$36
	jsl.l QueueFrameTiles
.7:									; go to .14
	jmp.w .14
.8:									; if frame = frame+$20 go to .9, tmp2 = $20A0, tmp1 = $2000, ...
	lda.w frame
	cmp.w frame+$20
	beq .9
	ldx.w #$20A0
	stx.b tmp2
	ldx.w #$2000
	stx.b tmp1
	sta.w frame+$20
	jsl.l QueueFrameTiles
.9:									; if frame+$2 = frame+$22 go to .10, tmp2 = $20A8, tmp1 = $2004, ...
	lda.w frame+$2
	cmp.w frame+$22
	beq .10
	ldx.w #$20A8
	stx.b tmp2
	ldx.w #$2004
	stx.b tmp1
	sta.w frame+$22
	jsl.l QueueFrameTiles
.10:								; if frame+$4 = frame+$24 go to .11, tmp2 = $20C0, tmp1 = $2008, ...
	lda.w frame+$4
	cmp.w frame+$24
	beq .11
	ldx.w #$20C0
	stx.b tmp2
	ldx.w #$2008
	stx.b tmp1
	sta.w frame+$24
	jsl.l QueueFrameTiles
.11:								; if frame+$6 = frame+$26 go to .12, tmp2 = $20C8, tmp1 = $200C, ...
	lda.w frame+$6
	cmp.w frame+$26
	beq .12
	ldx.w #$20C8
	stx.b tmp2
	ldx.w #$200C
	stx.b tmp1
	sta.w frame+$26
	jsl.l QueueFrameTiles
.12:								; if frame+$8 = frame+$28 go to .13, tmp2 = $20E0, tmp1 = $2010, ...
	lda.w frame+$8
	cmp.w frame+$28
	beq .13
	ldx.w #$20E0
	stx.b tmp2
	ldx.w #$2010
	stx.b tmp1
	sta.w frame+$28
	jsl.l QueueFrameTiles
.13:								; if frame+$A = frame+$2A go to .14, tmp2 = $20E8, tmp1 = $2014, ...
	lda.w frame+$A
	cmp.w frame+$2A
	beq .14
	ldx.w #$20E8
	stx.b tmp2
	ldx.w #$2014
	stx.b tmp1
	sta.w frame+$2A
	jsl.l QueueFrameTiles
.14:								; if frame+$1C = frame+$3C go to .15, tmp1 = $2034, frame+$3C = A, ...
	lda.w frame+$1C
	cmp.w frame+$3C
	beq .15
	ldx.w #$2034
	stx.b tmp1
	sta.w frame+$3C
	jsl.l QueueFrameTiles
.15:								; QueueBusy - 1, $1C = A, A = $28, Y = $2A, ...
	dec.b QueueBusy
	tsc
	sta.b $1C
	lda.b $28
	tcs
	ldy.b $2A
	lda.w #NextSortedGameObjectJump&$FFFF
	sta.b tmp3
	ldx.w #$000F
DrawSortedGameObject:				; draw the current sorted object with its frame and flip attributes
	lda.w OOlist,x
	stx.b $1A
	and.w #$00FF
	tax
	clc
	lda.w Xpos,x
	adc.w #$0080
	sec
	sbc.b Hpos
	sta.b $0A
	sec
	lda.b Vpos
	sbc.w Ypos,x
	clc
	adc.w #$005E
	sta.b $0C
	lda.w attribute,x
	and.w #$0800
	beq .1
	lda.l ObjSmallTilesFlip,x
	sta.b tmp1
	lda.l ObjBigTilesFlip,x
	sta.b tmp2
	lda.w frame+$20,x
	bmi NextSortedGameObject
	beq NextSortedGameObject
	jml.l DrawFrameLayoutFlip
.1:									; tmp1 = ObjSmallTiles,x, tmp2 = ObjBigTiles,x, ...
	lda.l ObjSmallTiles,x
	sta.b tmp1
	lda.l ObjBigTiles,x
	sta.b tmp2
	lda.w frame+$20,x
	bmi NextSortedGameObject
	beq NextSortedGameObject
	jml.l DrawFrameLayout

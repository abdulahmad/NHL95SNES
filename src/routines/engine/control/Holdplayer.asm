Holdplayer:							; called from other segments
	lda.w position,x
	beq .rtl
	lda.w pfalock,x
	beq .1
	lda.w SPA,x
	cmp.w #SPAburst&$FFFF
	bne .1
.rtl:								; return
	rtl
.1:									; d3 = $FFFF, a0 = A, Y = $0000, if X >= $000C go to .2, ...
	lda.w #$FFFF
	sta.b d3
	sta.b a0
	ldy.w #$0000
	cpx.w #$000C
	bcs .2
	ldy.w #$000C
.2:									; d2 = $0006
	lda.w #$0006
	sta.b d2
.loop:								; loop: a2 = Y, if position,y = 0 go to .3, if minus go to .3, ...
	sty.b a2
	lda.w position,y
	beq .3
	bmi .3
	lda.w Xpos,y
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w Ypos,y
	sec
	sbc.w Ypos,x
	sta.b d1
	ldy.b d1
	lda.b d0
	jsl.l ApproxLength
	sta.b d4
	jsl.l vtoa
	lda.b d0
	sec
	sbc.w facedir,x
	and.w #$0007
	cmp.w #$0005
	bcc .3
	eor.w #$FFFF
	adc.w #$0008
.3:									; A * 2, A * 2, A * 2, A * 2, ...
	asl a
	asl a
	asl a
	asl a
	adc.b d4
	cmp.b d3
	bcs .4
	sta.b d3
	lda.b a2
	sta.b a0
.4:									; Y = a2, Y + 1, Y + 1, d2 - 1, ...
	ldy.b a2
	iny
	iny
	dec.b d2
	bne .loop
Acheck:								; from check4check and other segments
	lda.w #SPAhook&$FFFF
	sta.b d1
	sta.w pfalock,x
	ldy.b a0
	bmi .1
	lda.w facedir,x
	sec
	sbc.w facedir,y
	inc a
	inc a
	and.w #$0007
	cmp.w #$0005
	bcc .1
	lda.w #SPAHold&$FFFF
	sta.b d1
.1:									; go to SetSPA
	jml.l SetSPA

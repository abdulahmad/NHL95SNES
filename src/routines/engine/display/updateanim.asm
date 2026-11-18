updateanim:							; from SetSPAUpdate and other segments
	lda.w SPA,x
	bne .1
	stz.w pf2aip,x
	stz.w pfalock,x
	rtl
.1:									; push Y, a0 = A, a0+2 = $00C4, Y = $0010, ...
	phy
	sta.b a0
	lda.w #$00C4
	sta.b a0+2
	ldy.w #$0010
	lda.b [a0],y
	sta.b d1
	lda.w SPA,x
	cmp.w #SPAbenchcheckr&$FFFF
	bcs .2
	lda.w attribute,x
	bit.w #$0800
	beq .2
	lda.w #$0000
	sec
	sbc.w facedir,x
	bra .3
.2:									; A = facedir,x
	lda.w facedir,x
.3:									; A and $0007, A * 2, Y = A, a0 = [a0],y, ...
	and.w #$0007
	asl a
	tay
	lda.b [a0],y
	sta.b a0
	ldy.w SPAnum,x
	sty.b d0
	lda.b [a0],y
	sta.b d2
	lda.w SPAcnt,x
	bmi .5
	sec
	sbc.w timestep
	sta.w SPAcnt,x
	bpl .7
	lda.w SPAnum,x
	clc
	adc.w #$0004
	sta.w SPAnum,x
	sta.b d0
	iny
	iny
	lda.b [a0],y
	cmp.w #$0000
	bpl .5
	stz.b d0
	stz.w SPAnum,x
	stz.w pf2aip,x
	stz.w pfalock,x
	lda.w SPA,x
	cmp.w #$2B18
	bcs .4
	cmp.w #SPAbenchcheckr&$FFFF
	bcs .9
.4:									; if d1 is not 0 go to .5, SPA,x = 0
	lda.b d1
	bne .5
	stz.w SPA,x
.5:									; Y = d0, Y + 1, Y + 1, A = [a0],y, ...
	ldy.b d0
	iny
	iny
	lda.b [a0],y
	bit.w #$8000
	beq .6
	eor.w #$FFFF
	inc a
.6:									; SPAcnt,x = A
	sta.w SPAcnt,x
.7:									; frame,x = d2
	lda.b d2
	sta.w frame,x
.8:									; pull Y, return
	ply
	rtl
.9:									; Xpos,x = $FF65, facedir,x = $0002, pfalock,x = A, A = attribute,x, ...
	lda.w #$FF65
	sta.w Xpos,x
	lda.w #$0002
	sta.w facedir,x
	sta.w pfalock,x
	lda.w attribute,x
	ora.w #$0800
	sta.w attribute,x
	lda.w #SPAwallout&$FFFF
	jsl.l SetSPAUpdate
	bra .8

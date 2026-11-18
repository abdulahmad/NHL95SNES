SprSort:							; from defaultsprites_0 and other segments
	phx
	phy
	pei ($7F)
	pei ($81)
	pei ($83)
	pei ($85)
	pei ($87)
	pei ($89)
	ldx.w #$0000
.loop:								; loop: Ylist,x = Ypos,x, X + 1, X + 1, if X is not $0020 go to .loop
	lda.w Ypos,x
	sta.w Ylist,x
	inx
	inx
	cpx.w #$0020
	bne .loop
.loop2:								; loop: d2 = 0, X = $0000
	stz.b d2
	ldx.w #$0000
.loop3:								; loop: A = OOlist+1,x, A and $00FF, d1 = A, A = OOlist,x, ...
	lda.w OOlist+1,x
	and.w #$00FF
	sta.b d1
	lda.w OOlist,x
	and.w #$00FF
	sta.b d0
	tay
	lda.w Ylist,y
	ldy.b d1
	cmp.w Ylist,y
	bmi .1
	beq .1
	lda.w OOlist,x
	xba
	sta.w OOlist,x
	txa
	sta.w OOlistpos,y
	inc a
	ldy.b d0
	sta.w OOlistpos,y
	inc.b d2
.1:									; X + 1, if X is not $000F go to .loop3, if d2 is not 0 go to .loop2, ...
	inx
	cpx.w #$000F
	bne .loop3
	lda.b d2
	bne .loop2
	pla
	sta.b d2+2
	pla
	sta.b d2
	pla
	sta.b d1+2
	pla
	sta.b d1
	pla
	sta.b d0+2
	pla
	sta.b d0
	ply
	plx
	rtl

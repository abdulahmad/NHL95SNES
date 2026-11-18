SetSpriteAnim:						; starts animation script A of sprite object X (from its record's script
									; list); when it already has A, restarts it only if it was stopped
	cmp.b $1E,x
	beq .1
	sta.b $1E,x
	asl a
	adc.b $2E,x
	phx
	tax
	lda.b $00,x
	plx
	sta.b $32,x
	stz.b $30,x
	stz.b $0E,x
	lda.b $36,x
	and.w #$7FFF
	sta.b $36,x
	lda.b $22,x
	ora.w #$4000
	sta.b $22,x
.rtl:								; return
	rtl
.1:									; A = $22,x, if a $4000 bit set go to .rtl, A or $4000, $22,x = A, ...
	lda.b $22,x
	bit.w #$4000
	bne .rtl
	ora.w #$4000
	sta.b $22,x
	stz.b $30,x
	stz.b $0E,x
	rtl

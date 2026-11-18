burst:								; check button: a speed burst in the facing direction that costs energy
									; (getpde / setpde), then SetSPAFromA
	lda.w pfalock,x
	beq .1
	rtl
.1:									; call getpde, if OptLine = 0 go to .2, A = d0, A - $00CC, ...
	jsl.l getpde
	lda.w OptLine
	beq .2
	lda.b d0
	sec
	sbc.w #$00CC
	sta.b d0
	jsl.l setpde
	lda.w OptLine
	cmp.w #$0002
	bne .2
	lda.w #$1000
	sta.b d0
.2:									; r2 = 0, r2+2 = 0, A = d0, A * 2, ...
	stz.b r2
	stz.b r2+2
	lda.b d0
	asl a
	sta.b $35
	stz.b r0+2
	asl a
	asl a
	asl a
	rol.b r0+2
	asl a
	rol.b r0+2
	asl a
	rol.b r0+2
	adc.b r2
	sta.b r2
	lda.b r0+2
	adc.b r2+2
	sta.b $B1
	lda.w facedir,x
	asl a
	asl a
	tay
	lda.w #dirtab>>16
	sta.b a0+2
	lda.w #dirtab&$FFFF
	sta.b a0
	lda.b [a0],y
	iny
	iny
	tax
	lda.b $B1
	jsl.l Mul8XS
	ldx.b a3
	clc
	adc.w Xvel,x
	sta.w Xvel,x
	lda.b [a0],y
	tax
	lda.b $B1
	jsl.l Mul8XS
	ldx.b a3
	clc
	adc.w Yvel,x
	sta.w Yvel,x
	lda.w #SPAburst&$FFFF
	sta.w pfalock,x
	jml.l SetSPAFromA

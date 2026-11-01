; Segment bankC4_6000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C45FAC
PlayerAccDir2x2:					; playeracc toward direction 2 (right), the step taken twice
									; (PlayerAccFrames)
	lda.l DATA8_C4692F,x
	sta.b d0
	ldx.b curobj
	lda.w Wallsin,x
	beq .1
	eor.b d0
	bpl .1
	lda.w Xvel,x
	bra .2
.1:									; A = $0D80,x, A * 2, A + Xvel,x
	lda.w $0D80,x
	asl a
	clc
	adc.w Xvel,x
.2:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w $09C1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .3
	lda.w #$1000
	sta.b d0
.3:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .4
	lda.w playerpad,x
	bmi .4
	lda.w goalieflags,x
	bit.w #$0004
	bne .4
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.4:									; pull A, if carry clear go to .5, Xvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .5
	sta.w Xvel,x
.5:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .6
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.6:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir3:						; playeracc toward direction 3 (down-right), one step (PlayerAccOneFrame)
	lda.l DATA8_C4692F,x
	sta.b d0
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = Yvel,x, A - $0DA0,x
	sec
	lda.w Yvel,x
	sbc.w $0DA0,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w Wallsin,x
	beq .3
	eor.b d0
	bpl .3
	lda.w Xvel,x
	bra .4
.3:									; A = Xvel,x, A + $0DA0,x
	lda.w Xvel,x
	adc.w $0DA0,x
.4:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .5
	lda.w #$1000
	sta.b d0
.5:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .6
	lda.w playerpad,x
	bmi .6
	lda.w goalieflags,x
	bit.w #$0004
	bne .6
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.6:									; pull A, if carry clear go to .7, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .7
	sta.w Yvel,x
.7:									; pull A, if carry clear go to .8, Xvel,x = A
	pla
	bcc .8
	sta.w Xvel,x
.8:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .9
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.9:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir3x2:					; playeracc toward direction 3 (down-right), the step taken twice
									; (PlayerAccFrames)
	lda.l DATA8_C4692F,x
	sta.b d0
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = Yvel,x, A - $0DA0,x, A - $0DA0,x
	sec
	lda.w Yvel,x
	sbc.w $0DA0,x
	sec
	sbc.w $0DA0,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w Wallsin,x
	beq .3
	eor.b d0
	bpl .3
	lda.w Xvel,x
	bra .4
.3:									; A = $0DA0,x, A * 2, A + Xvel,x
	lda.w $0DA0,x
	asl a
	clc
	adc.w Xvel,x
.4:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .5
	lda.w #$1000
	sta.b d0
.5:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .6
	lda.w playerpad,x
	bmi .6
	lda.w goalieflags,x
	bit.w #$0004
	bne .6
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.6:									; pull A, if carry clear go to .7, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .7
	sta.w Yvel,x
.7:									; pull A, if carry clear go to .8, Xvel,x = A
	pla
	bcc .8
	sta.w Xvel,x
.8:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .9
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.9:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir4:						; playeracc toward direction 4 (down), one step (PlayerAccOneFrame)
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = Yvel,x, A - $0D80,x
	sec
	lda.w Yvel,x
	sbc.w $0D80,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w $09A1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .3
	lda.w #$1000
	sta.b d0
.3:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .4
	lda.w playerpad,x
	bmi .4
	lda.w goalieflags,x
	bit.w #$0004
	bne .4
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.4:									; pull A, if carry clear go to .5, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .5
	sta.w Yvel,x
.5:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .6
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.6:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir4x2:					; playeracc toward direction 4 (down), the step taken twice
									; (PlayerAccFrames)
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = Yvel,x, A - $0D80,x, A - $0D80,x
	sec
	lda.w Yvel,x
	sbc.w $0D80,x
	sec
	sbc.w $0D80,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w $09A1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .3
	lda.w #$1000
	sta.b d0
.3:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .4
	lda.w playerpad,x
	bmi .4
	lda.w goalieflags,x
	bit.w #$0004
	bne .4
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.4:									; pull A, if carry clear go to .5, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .5
	sta.w Yvel,x
.5:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .6
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.6:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir5:						; playeracc toward direction 5 (down-left), one step (PlayerAccOneFrame)
	lda.l DATA8_C4692F,x
	sta.b d0
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = Yvel,x, A - $0DA0,x
	sec
	lda.w Yvel,x
	sbc.w $0DA0,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w Wallsin,x
	beq .3
	eor.b d0
	bpl .3
	lda.w Xvel,x
	bra .4
.3:									; A = Xvel,x, A - $0DA0,x
	sec
	lda.w Xvel,x
	sbc.w $0DA0,x
.4:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .5
	lda.w #$1000
	sta.b d0
.5:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .6
	lda.w playerpad,x
	bmi .6
	lda.w goalieflags,x
	bit.w #$0004
	bne .6
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.6:									; pull A, if carry clear go to .7, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .7
	sta.w Yvel,x
.7:									; pull A, if carry clear go to .8, Xvel,x = A
	pla
	bcc .8
	sta.w Xvel,x
.8:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .9
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.9:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir5x2:					; playeracc toward direction 5 (down-left), the step taken twice
									; (PlayerAccFrames)
	lda.l DATA8_C4692F,x
	sta.b d0
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = Yvel,x, A - $0DA0,x, A - $0DA0,x
	sec
	lda.w Yvel,x
	sbc.w $0DA0,x
	sec
	sbc.w $0DA0,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w Wallsin,x
	beq .3
	eor.b d0
	bpl .3
	lda.w Xvel,x
	bra .4
.3:									; A = Xvel,x, A - $0DA0,x, A - $0DA0,x
	sec
	lda.w Xvel,x
	sbc.w $0DA0,x
	sec
	sbc.w $0DA0,x
.4:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .5
	lda.w #$1000
	sta.b d0
.5:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .6
	lda.w playerpad,x
	bmi .6
	lda.w goalieflags,x
	bit.w #$0004
	bne .6
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.6:									; pull A, if carry clear go to .7, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .7
	sta.w Yvel,x
.7:									; pull A, if carry clear go to .8, Xvel,x = A
	pla
	bcc .8
	sta.w Xvel,x
.8:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .9
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.9:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir6:						; playeracc toward direction 6 (left), one step (PlayerAccOneFrame)
	lda.l DATA8_C4692F,x
	sta.b d0
	ldx.b curobj
	lda.w Wallsin,x
	beq .1
	eor.b d0
	bpl .1
	lda.w Xvel,x
	bra .2
.1:									; A = Xvel,x, A - $0D80,x
	sec
	lda.w Xvel,x
	sbc.w $0D80,x
.2:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w $09C1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .3
	lda.w #$1000
	sta.b d0
.3:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .4
	lda.w playerpad,x
	bmi .4
	lda.w goalieflags,x
	bit.w #$0004
	bne .4
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.4:									; pull A, if carry clear go to .5, Xvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .5
	sta.w Xvel,x
.5:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .6
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.6:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir6x2:					; playeracc toward direction 6 (left), the step taken twice
									; (PlayerAccFrames)
	lda.l DATA8_C4692F,x
	sta.b d0
	ldx.b curobj
	lda.w Wallsin,x
	beq .1
	eor.b d0
	bpl .1
	lda.w Xvel,x
	bra .2
.1:									; A = Xvel,x, A - $0D80,x, A - $0D80,x
	sec
	lda.w Xvel,x
	sbc.w $0D80,x
	sec
	sbc.w $0D80,x
.2:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w $09C1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .3
	lda.w #$1000
	sta.b d0
.3:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .4
	lda.w playerpad,x
	bmi .4
	lda.w goalieflags,x
	bit.w #$0004
	bne .4
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.4:									; pull A, if carry clear go to .5, Xvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .5
	sta.w Xvel,x
.5:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .6
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.6:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir7:						; playeracc toward direction 7 (up-left), one step (PlayerAccOneFrame)
	lda.l DATA8_C4692F,x
	sta.b d0
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = Yvel,x, A + $0DA0,x
	lda.w Yvel,x
	adc.w $0DA0,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w Wallsin,x
	beq .3
	eor.b d0
	bpl .3
	lda.w Xvel,x
	bra .4
.3:									; A = Xvel,x, A - $0DA0,x
	sec
	lda.w Xvel,x
	sbc.w $0DA0,x
.4:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .5
	lda.w #$1000
	sta.b d0
.5:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .6
	lda.w playerpad,x
	bmi .6
	lda.w goalieflags,x
	bit.w #$0004
	bne .6
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.6:									; pull A, if carry clear go to .7, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .7
	sta.w Yvel,x
.7:									; pull A, if carry clear go to .8, Xvel,x = A
	pla
	bcc .8
	sta.w Xvel,x
.8:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .9
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.9:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
PlayerAccDir7x2:					; playeracc toward direction 7 (up-left), the step taken twice
									; (PlayerAccFrames)
	lda.l DATA8_C4692F,x
	sta.b d0
	lda.l DATA8_C4693F,x
	sta.b d1
	ldx.b curobj
	lda.w Wallcos,x
	beq .1
	eor.b d1
	bmi .1
	lda.w Yvel,x
	bra .2
.1:									; A = $0DA0,x, A * 2, A + Yvel,x
	lda.w $0DA0,x
	asl a
	clc
	adc.w Yvel,x
.2:									; d1 = A, A and $00FF, A * 2, X = A, ...
	sta.b d1
	xba
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	tay
	ldx.b curobj
	lda.w Wallsin,x
	beq .3
	eor.b d0
	bpl .3
	lda.w Xvel,x
	bra .4
.3:									; A = Xvel,x, A - $0DA0,x, A - $0DA0,x
	sec
	lda.w Xvel,x
	sbc.w $0DA0,x
	sec
	sbc.w $0DA0,x
.4:									; d0 = A, A and $00FF, A * 2, X = A, ...
	sta.b d0
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l SignedSquareTable,x
	sta.b d3
	ldx.b curobj
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w OptLine
	cmp.w #$0002
	bne .5
	lda.w #$1000
	sta.b d0
.5:									; A = $0E20,x, A * 2, X = A, A = d0, ...
	lda.w $0E20,x
	asl a
	tax
	lda.b d0
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b d2
	lda.l DATA8_C09BC4+2,x
	sta.b $89
	ldx.b curobj
	lda.w position,x
	bne .6
	lda.w playerpad,x
	bmi .6
	lda.w goalieflags,x
	bit.w #$0004
	bne .6
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
.6:									; pull A, if carry clear go to .7, Yvel,x = A
	lda.b $89
	cmp.b d3
	pla
	bcc .7
	sta.w Yvel,x
.7:									; pull A, if carry clear go to .8, Xvel,x = A
	pla
	bcc .8
	sta.w Xvel,x
.8:									; if OptLine = 0 go to .rtl, A = seed, ...
	lda.w OptLine
	beq .rtl
	lda.w seed
	and.w #$003F
	bne .rtl
	jsl.l getpde
	lda.b d0
	sec
	sbc.w #$0021
	sta.b d0
	cmp.w #$0C00
	bmi .9
	lda.w $0F40,x
	sta.b d2
	clc
	adc.b d0
	sta.b d0
.9:									; go to setpde
	jml.l setpde
.rtl:								; return
	rtl
DATA8_C4692F:						; not traced: a table read by PlayerAccDir2x2, PlayerAccDir3, ...
	db $00,$00,$04,$00,$07,$00,$04,$00,$00,$00,$FC,$FF,$F9,$FF,$FC,$FF
DATA8_C4693F:						; not traced: a table read by PlayerAccDir3, PlayerAccDir3x2, ...
	db $07,$00,$04,$00,$00,$00,$FC,$FF,$F9,$FF,$FC,$FF,$00,$00,$04,$00
doplayeracc:						; from CODE_C470E7 and other segments
	lda.w position,x
	bne .1
	jmp.w goalieacc
.1:									; if SPA,x = $2082 go to .rtl, d1 = $1958, if pfrev,x = 0 go to .2, ...
	lda.w SPA,x
	cmp.w #$2082
	beq .rtl
	lda.w #$1958
	sta.b d1
	lda.w pfrev,x
	beq .2
	lda.w #$1F6C
	sta.b d1
.2:									; A = d0, A and $000F, d0 = A, if A < $0008 go to .4, ...
	lda.b d0
	and.w #$000F
	sta.b d0
	cmp.w #$0008
	bcc .4
	cmp.w #$0009
	bne .3
	lda.w Xvel,x
	ora.w Yvel,x
	beq .3
	jmp.w dostop
.3:									; if pf2aip,x is not 0 go to .rtl, go to SetSPA
	lda.w pf2aip,x
	bne .rtl
	jmp.w SetSPA
.rtl:								; return
	rtl
.4:									; A = d0, push A, d2 = A, if X is not puckc go to .5, ...
	pei ($83)
	lda.b d0
	pha
	sta.b d2
	cpx.w puckc
	bne .5
	jmp.w .11
.5:									; A = $0830, A - Xpos,x, d0 = A, d3 = Ypos,x, ...
	lda.w $0830
	sec
	sbc.w Xpos,x
	sta.b d0
	lda.w Ypos,x
	sta.b d3
	lda.w $09DD
	and.w #$00FF
	cmp.w #$0080
	bcc .6
	ora.w #$FF00
.6:									; A + pucky, A - d3, d1 = A, if pfgoal,x is not 0 go to .7, ...
	clc
	adc.w pucky
	sec
	sbc.b d3
	sta.b d1
	lda.w pfgoal,x
	bne .7
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
	lda.w #$0000
	sec
	sbc.b d1
	sta.b d1
	lda.w #$0000
	sec
	sbc.b d3
	sta.b d3
	lda.b d2
	eor.w #$0004
	sta.b d2
.7:									; if pfrev,x is not 0 go to .8, if d3 >= 0 go to .11, ...
	lda.w pfrev,x
	bne .8
	lda.b d3
	bpl .11
	lda.b d2
	cmp.w #$0004
	bne .11
	jsl.l vtoa
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs .11
	bra .9
.8:									; A = d2, A - $0003, A and $0007, if A >= $0003 go to .11, ...
	lda.b d2
	sec
	sbc.w #$0003
	and.w #$0007
	cmp.w #$0003
	bcs .11
	jsl.l vtoa
	inc a
	inc a
	and.w #$0007
	cmp.w #$0005
	bcs .11
.9:									; if pfrev,x is not 0 go to .12, d0 = Xvel,x, ...
	lda.w pfrev,x
	bne .12
	lda.w Xvel,x
	sta.b d0
	ora.w Yvel,x
	beq .10
	lda.w Yvel,x
	sta.b d1
	jsl.l vtoa
	sec
	sbc.b $01,s
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs .12
.10:								; A + 1, pfrev,x = A, go to .12
	inc a
	sta.w pfrev,x
	bra .12
.11:								; pfrev,x = 0
	stz.w pfrev,x
.12:								; pull A, d0 = A, pull A, d1 = A, ...
	pla
	sta.b d0
	pla
	sta.b d1
	lda.w facedir,x
	sta.b d2
	lda.b d0
	sec
	sbc.b d2
	and.w #$0007
	asl a
	sta.b d0
	tax
	lda.l DATA8_C46B26,x
	ldx.b a3
	cmp.w #$0000
	bne .13
	jmp.w noturn0
.13:								; A * 2, tmp0 = A, A = $09A1,x, A and $00FF, ...
	asl a
	sta.b tmp0
	lda.w $09A1,x
	and.w #$00FF
	asl a
	tax
	lda.l SignedSquareTable,x
	sta.b d4
	ldx.b a3
	lda.w $09C1,x
	and.w #$00FF
	asl a
	tax
	lda.b d4
	adc.l SignedSquareTable,x
	sta.b d3
	lda.w #$0300
	sec
	sbc.b d3
	sta.b d4
	sec
	sbc.w #$0180
	bpl .14
	lda.w #$0180
	sta.b d4
.14:								; A = tmp0, X = d4, call Mul16x8S, $91 = $36, ...
	lda.b tmp0
	ldx.b d4
	jsl.l Mul16x8S
	lda.b $36
	sta.b $91
	lda.b r2
	sta.b d4
	ldx.b a3
	lda.w pfrev,x
	beq .15
	lda.w #$0000
	sec
	sbc.b d4
	sta.b d4
	lda.w #$0000
	sbc.b $91
	sta.b $91
.15:								; A = $0C60,x, A + d4, $0C60,x = A, A = facedir,x, ...
	lda.w $0C60,x
	clc
	adc.b d4
	sta.w $0C60,x
	lda.w facedir,x
	adc.b $91
	and.w #$0007
	sta.w facedir,x
	sta.b d2
	lda.b d3
	cmp.w #$0015
	bcc .17
	lda.w #$198A
	sta.b d1
	lda.b tmp0
	bpl .16
	lda.w #$198A
	sta.b d1
.16:								; A = attribute,x, if $0800 bits clear go to .17, d1 = $198A
	lda.w attribute,x
	bit.w #$0800
	beq .17
	lda.w #$198A
	sta.b d1
.17:								; if pf2aip,x is not 0 go to .18, call SetSPA, pf2aip,x = $0001
	lda.w pf2aip,x
	bne .18
	jsl.l SetSPA
	lda.w #$0001
	sta.w pf2aip,x
.18:								; if d3 < $0003 go to .rtl2, go to revplayeracc
	lda.b d3
	cmp.w #$0003
	bcc .rtl2
	jmp.w revplayeracc
.rtl2:								; return
	rtl
DATA8_C46B26:						; not traced: a table read by doplayeracc
	db $00,$00,$11,$00,$11,$00,$11,$00,$00,$00,$EF,$FF,$EF,$FF,$EF,$FF
noturn0:							; from doplayeracc
	lda.w #$0002
	sta.b d4
	lda.w pfrev,x
	beq .1
	lda.w #$0006
	sta.b d4
	lda.b d0
	eor.w #$0008
	sta.b d0
.1:									; if d0 = 0 go to .5, d0 = Xvel,x, d1 = Yvel,x, call vtoa, ...
	lda.b d0
	beq .5
	lda.w Xvel,x
	sta.b d0
	lda.w Yvel,x
	sta.b d1
	jsl.l vtoa
	bit.w #$0008
	bne .2
	sec
	sbc.w facedir,x
	clc
	adc.b d4
	and.w #$0007
	sta.b d0
	cmp.w #$0004
	bcs .2
	jmp.w dostop
.2:									; facedir,x + 1, A = attribute,x, if $0800 bits clear go to .3, ...
	inc.w facedir,x
	lda.w attribute,x
	bit.w #$0800
	beq .3
	dec.w facedir,x
	dec.w facedir,x
.3:									; A = facedir,x, A and $0007, facedir,x = A, d1 = $1958, ...
	lda.w facedir,x
	and.w #$0007
	sta.w facedir,x
	lda.w #$1958
	sta.b d1
	lda.w pfrev,x
	bne .4
	jmp.w SetSPA
.4:									; Y = $0001, A = $1F6C, go to SetSPAFromA
	ldy.w #$0001
	lda.w #$1F6C
	jml.l SetSPAFromA
.5:									; Y = $0001, d1 = $1F9E, if pfrev,x is not 0 go to .7, Y = $0000, ...
	ldy.w #$0001
	lda.w #$1F9E
	sta.b d1
	lda.w pfrev,x
	bne .7
	ldy.w #$0000
	lda.w #$1A3C
	sta.b d1
	lda.w pflags,x
	bit.w #$0004
	beq .6
	ldy.w #$0001
	lda.w #$25D2
	sta.b d1
.6:									; if X is not puckc go to .7, Y = $0000, d1 = $198A
	cpx.w puckc
	bne .7
	ldy.w #$0000
	lda.w #$198A
	sta.b d1
.7:									; if pf2aip,x is not 0 go to revplayeracc, A = Y, pf2aip,x = A, ...
	lda.w pf2aip,x
	bne revplayeracc
	tya
	sta.w pf2aip,x
	jsl.l SetSPA
revplayeracc:						; from doplayeracc, noturn0
	lda.w pfrev,x
	beq .1
	lda.b d2
	eor.w #$0004
	sta.b d2
.1:									; go to playeracc
	jmp.w playeracc
CODE_C46BF6:						; from CODE_C47040 and other segments
	stz.b tmp2
	lda.w Xpos,x
	sta.b p0
	lda.w Ypos,x
	sta.b $3A
	lda.b d0
	sta.b p1
	lda.b d1
	sta.b $3E
	lda.w position,x
	bne .1
	jmp.w CODE_C46E4B
.1:									; X = $00EB, Y = $0122, call CODE_C46DCA, X = $00EA, ...
	ldx.w #$00EB
	ldy.w #$0122
	jsr.w CODE_C46DCA
	ldx.w #$00EA
	ldy.w #$0123
	stx.b r3
	sty.b $42
	lda.w #$010E
	sta.b $46
	lda.w $0664
	sta.b $44
	lda.b tmp2
	bne .2
	ldx.w #$FEDE
	ldy.w #$FF15
	jsr.w CODE_C46DCA
	ldx.w #$FEDD
	ldy.w #$FF16
	stx.b r3
	sty.b $42
	lda.w #$FEF2
	sta.b $46
	lda.w $0666
	sta.b $44
	lda.b tmp2
	bne .4
	ldx.b curobj
	rtl
.2:									; A = r3, r3 = $42, $42 = A, A = $3A, ...
	lda.b r3
	ldy.b $42
	sty.b r3
	sta.b $42
	lda.b $3A
	eor.w #$FFFF
	inc a
	sta.b $3A
	lda.b $3E
	eor.w #$FFFF
	inc a
	sta.b $3E
	lda.b tmp0
	bit.w #$000A
	beq .3
	eor.w #$000A
	sta.b tmp0
.3:									; A = tmp1, if $000A bits clear go to .4, A xor $000A, tmp1 = A
	lda.b tmp1
	bit.w #$000A
	beq .4
	eor.w #$000A
	sta.b tmp1
.4:									; if tmp1 = 0 go to .5, X = tmp0, call (DATA8_C46DB0,x), X = curobj, ...
	lda.b tmp1
	beq .5
	ldx.b tmp0
	jsr (DATA8_C46DB0,x)
	ldx.b curobj
	rtl
.5:									; call CODE_C46C99, X = curobj, return
	jsr.w CODE_C46C99
	ldx.b curobj
	rtl
CODE_C46C99:						; from CODE_C46BF6
	ldx.b curobj
	lda.b $3A
	cmp.w #$FEF2
	bpl .1
	lda.b $3E
	cmp.w #$FEF2
	bmi .rts
	bra CODE_C46CE3
.1:									; if $3E - $FEF2 < 0 go to .3, if $44 < 0 go to .rts, ...
	lda.b $3E
	cmp.w #$FEF2
	bmi .3
	ldy.b $44
	bmi .rts
	lda.b p0
	cmp.b p1
	bmi .2
	cmp.w Xpos,y
	bmi .rts
	lda.b $42
	sta.b d1
.rts:								; return
	rts
.2:									; if A - Xpos,y >= 0 go to .rts2, d1 = $42
	cmp.w Xpos,y
	bpl .rts2
	lda.b $42
	sta.b d1
.rts2:								; return
	rts
.3:									; d1 = $42, go to CODE_C46D11
	lda.b $42
	sta.b d1
	bra CODE_C46D11
CODE_C46CD6:						; from CODE_C46CE3, CODE_C46CF5
	lda.w #$FFCA
	sta.b d0
	rts
CODE_C46CDC:						; from DATA8_C46DB0
	lda.b $3A
	cmp.w #$FEF2
	bpl CODE_C46CF5
CODE_C46CE3:						; from CODE_C46C99
	lda.b p0
	cmp.w #$FFCB
	bmi CODE_C46CD6
	cmp.w #$0036
	bpl CODE_C46D5E
	lda.b r3
	sta.b d1
	bra CODE_C46D36
CODE_C46CF5:						; from CODE_C46CDC
	lda.b $3E
	cmp.w #$FEF2
	bpl .1
	lda.b $46
	sta.b d1
	ldy.b $44
	bmi CODE_C46D36
	lda.b p0
	cmp.w Xpos,y
	bmi CODE_C46CD6
	bra CODE_C46D5E
.1:									; if $44 < 0 go to CODE_C46D4F
	ldy.b $44
	bmi CODE_C46D4F
CODE_C46D11:						; from CODE_C46C99
	lda.b p1
	sec
	sbc.w Xpos,y
	pha
	lda.b p0
	sec
	sbc.b p1
	eor.b $01,s
	bpl CODE_C46D50
	pla
	lda.b p0
	cmp.w Xpos,y
	bpl CODE_C46D5E
	bra CODE_C46D90
CODE_C46D2B:						; from DATA8_C46DB0
	lda.b $42
	sta.b d1
	lda.b tmp1
	and.w #$0008
	bne CODE_C46D4F
CODE_C46D36:						; from CODE_C46CE3, CODE_C46D7D, CODE_C46CF5
	lda.b p1
	bpl .1
	cmp.w #$FFCB
	bmi CODE_C46D4F
	lda.w #$FFCA
	sta.b d0
	rts
.1:									; if A - $0036 >= 0 go to CODE_C46D4F, d0 = $0036
	cmp.w #$0036
	bpl CODE_C46D4F
	lda.w #$0036
	sta.b d0
CODE_C46D4F:						; from CODE_C46D2B, CODE_C46D36, CODE_C46CF5
	rts
CODE_C46D50:						; from CODE_C46D11
	pla
	rts
CODE_C46D52:						; from DATA8_C46DB0
	lda.b tmp1
	cmp.w #$0010
	bne CODE_C46D5E
CODE_C46D59:						; from CODE_C46D64, CODE_C46D96, CODE_C46DA3
	lda.b $42
	sta.b d1
	rts
CODE_C46D5E:						; from CODE_C46CE3, CODE_C46D52, CODE_C46D71, CODE_C46CF5, ...
	lda.w #$0036
	sta.b d0
	rts
CODE_C46D64:						; from DATA8_C46DB0
	lda.w #$0036
	sta.b d0
	lda.b tmp1
	and.w #$000A
	beq CODE_C46D59
	rts
CODE_C46D71:						; from DATA8_C46DB0
	lda.b tmp1
	cmp.w #$0010
	bne CODE_C46D5E
CODE_C46D78:						; from CODE_C46D89
	lda.b r3
	sta.b d1
	rts
CODE_C46D7D:						; from DATA8_C46DB0
	lda.b r3
	sta.b d1
	lda.b tmp1
	and.w #$0002
	bne CODE_C46D36
	rts
CODE_C46D89:						; from DATA8_C46DB0
	lda.b tmp1
	cmp.w #$0004
	beq CODE_C46D78
CODE_C46D90:						; from CODE_C46D11
	lda.w #$FFCA
	sta.b d0
	rts
CODE_C46D96:						; from DATA8_C46DB0
	lda.w #$FFCA
	sta.b d0
	lda.b tmp1
	and.w #$000A
	beq CODE_C46D59
	rts
CODE_C46DA3:						; from DATA8_C46DB0
	lda.b tmp1
	cmp.w #$0004
	beq CODE_C46D59
	lda.w #$FFCA
	sta.b d0
	rts
DATA8_C46DB0:						; jump table: the routine for each index
	dw CODE_C46CDC,CODE_C46D2B,CODE_C46D64,CODE_C46D52
	dw CODE_C46D7D,$0000,CODE_C46D71,$0000
	dw CODE_C46D96,CODE_C46DA3,$0000,$0000
	dw CODE_C46D89
CODE_C46DCA:						; from CODE_C46BF6
	stx.b r3
	sty.b $42
	stz.b tmp0
	stz.b tmp1
	ldx.b $3A
	ldy.b $3E
	cpx.b r3
	bpl .3
	lda.w #$0008
	sta.b tmp0
	cpy.b r3
	bpl .4
.rts:								; return
	rts
.1:									; if Y - $42 < 0 go to .5, tmp1 = $0002, go to .5
	cpy.b $42
	bmi .5
	lda.w #$0002
	sta.b tmp1
	bra .5
.2:									; if Y - $002C < 0 go to .6, A = tmp1, A or $0004, tmp1 = A, ...
	cpy.w #$002C
	bmi .6
	lda.b tmp1
	ora.w #$0004
	sta.b tmp1
	bra .6
.3:									; if Y - r3 >= 0 go to .4, tmp1 = $0008
	cpy.b r3
	bpl .4
	lda.w #$0008
	sta.b tmp1
.4:									; if X - $42 < 0 go to .1, tmp0 = $0002, if Y - $42 >= 0 go to .rts
	cpx.b $42
	bmi .1
	lda.w #$0002
	sta.b tmp0
	cpy.b $42
	bpl .rts
.5:									; X = p0, Y = p1, if p0 - $002C < 0 go to .2, A = tmp0, ...
	ldx.b p0
	ldy.b p1
	cpx.w #$002C
	bmi .2
	lda.b tmp0
	ora.w #$0004
	sta.b tmp0
	cpy.w #$002C
	bpl .rts
.6:									; if X - $FFD4 >= 0 go to .8, A = tmp0, A or $0010, tmp0 = A, ...
	cpx.w #$FFD4
	bpl .8
	lda.b tmp0
	ora.w #$0010
	sta.b tmp0
	cpy.w #$FFD4
	bmi .rts
.7:									; tmp2 + 1, return
	inc.b tmp2
	rts
.8:									; if Y - $FFD4 >= 0 go to .7, A = tmp1, A or $0010, tmp1 = A, ...
	cpy.w #$FFD4
	bpl .7
	lda.b tmp1
	ora.w #$0010
	sta.b tmp1
	inc.b tmp2
	rts
CODE_C46E4B:						; from CODE_C46BF6
	ldx.w #$0108
	ldy.w #$0122
	jsr.w CODE_C46FAD
	ldx.w #$0107
	ldy.w #$0123
	stx.b r3
	sty.b $42
	lda.b tmp2
	bne .1
	ldx.w #$FEDE
	ldy.w #$FEF8
	jsr.w CODE_C46FAD
	ldx.w #$FEDD
	ldy.w #$FEF9
	stx.b r3
	sty.b $42
	lda.b tmp2
	bne .3
	ldx.b curobj
	rtl
.1:									; A = r3, r3 = $42, $42 = A, A = $3A, ...
	lda.b r3
	ldy.b $42
	sty.b r3
	sta.b $42
	lda.b $3A
	eor.w #$FFFF
	inc a
	sta.b $3A
	lda.b $3E
	eor.w #$FFFF
	inc a
	sta.b $3E
	lda.b tmp0
	bit.w #$000A
	beq .2
	eor.w #$000A
	sta.b tmp0
.2:									; A = tmp1, if $000A bits clear go to .3, A xor $000A, tmp1 = A
	lda.b tmp1
	bit.w #$000A
	beq .3
	eor.w #$000A
	sta.b tmp1
.3:									; if tmp1 = 0 go to .4, X = tmp0, call (DATA8_C46F93,x), X = curobj, ...
	lda.b tmp1
	beq .4
	ldx.b tmp0
	jsr (DATA8_C46F93,x)
	ldx.b curobj
	rtl
.4:									; call CODE_C46EBE, X = curobj, return
	jsr.w CODE_C46EBE
	ldx.b curobj
	rtl
CODE_C46EBE:						; from CODE_C46E4B
	ldx.b curobj
	lda.b $3A
	cmp.w #$FEF2
	bpl .1
	lda.b $3E
	cmp.w #$FEF2
	bmi .rts
	bra CODE_C46EF1
.1:									; if $3E - $FEF2 >= 0 go to .rts, go to CODE_C46F0A
	lda.b $3E
	cmp.w #$FEF2
	bpl .rts
	bra CODE_C46F0A
.rts:								; return
	rts
CODE_C46EDA:						; no caller found (not traced)
	cmp.w Xpos,y
	bpl CODE_C46F34
	lda.b $42
	sta.b d1
	rts
CODE_C46EE4:						; from CODE_C46EF1
	lda.w #$FFDA
	sta.b d0
	rts
CODE_C46EEA:						; from DATA8_C46F93
	lda.b $3A
	cmp.w #$FEF2
	bpl CODE_C46F03
CODE_C46EF1:						; from CODE_C46EBE
	lda.b p0
	cmp.w #$FFDB
	bmi CODE_C46EE4
	cmp.w #$0026
	bpl CODE_C46F41
	lda.b r3
	sta.b d1
	bra CODE_C46F1B
CODE_C46F03:						; from CODE_C46EEA
	lda.b tmp1
	bit.w #$0002
	bne CODE_C46F34
CODE_C46F0A:						; from CODE_C46EBE
	lda.b $42
	sta.b d1
	bra CODE_C46F1B
CODE_C46F10:						; from DATA8_C46F93
	lda.b $42
	sta.b d1
	lda.b tmp1
	and.w #$0008
	bne CODE_C46F34
CODE_C46F1B:						; from CODE_C46EF1, CODE_C46F60, CODE_C46F0A
	lda.b p1
	bpl .1
	cmp.w #$FFDB
	bmi CODE_C46F34
	lda.w #$FFDA
	sta.b d0
	rts
.1:									; if A - $0026 >= 0 go to CODE_C46F34, d0 = $0026
	cmp.w #$0026
	bpl CODE_C46F34
	lda.w #$0026
	sta.b d0
CODE_C46F34:						; from CODE_C46EDA, CODE_C46F10, CODE_C46F1B, CODE_C46F03, ...
	rts
CODE_C46F35:						; from DATA8_C46F93
	lda.b tmp1
	cmp.w #$0010
	bne CODE_C46F41
CODE_C46F3C:						; from CODE_C46F47, CODE_C46F79, CODE_C46F86
	lda.b $42
	sta.b d1
	rts
CODE_C46F41:						; from CODE_C46EF1, CODE_C46F35, CODE_C46F54
	lda.w #$0026
	sta.b d0
	rts
CODE_C46F47:						; from DATA8_C46F93
	lda.w #$0026
	sta.b d0
	lda.b tmp1
	and.w #$000A
	beq CODE_C46F3C
	rts
CODE_C46F54:						; from DATA8_C46F93
	lda.b tmp1
	cmp.w #$0010
	bne CODE_C46F41
CODE_C46F5B:						; from CODE_C46F6C
	lda.b r3
	sta.b d1
	rts
CODE_C46F60:						; from DATA8_C46F93
	lda.b r3
	sta.b d1
	lda.b tmp1
	and.w #$0002
	bne CODE_C46F1B
	rts
CODE_C46F6C:						; from DATA8_C46F93
	lda.b tmp1
	cmp.w #$0004
	beq CODE_C46F5B
	lda.w #$FFDA
	sta.b d0
	rts
CODE_C46F79:						; from DATA8_C46F93
	lda.w #$FFDA
	sta.b d0
	lda.b tmp1
	and.w #$000A
	beq CODE_C46F3C
	rts
CODE_C46F86:						; from DATA8_C46F93
	lda.b tmp1
	cmp.w #$0004
	beq CODE_C46F3C
	lda.w #$FFDA
	sta.b d0
	rts
DATA8_C46F93:						; jump table: the routine for each index
	dw CODE_C46EEA,CODE_C46F10,CODE_C46F47,CODE_C46F35
	dw CODE_C46F60,$0000,CODE_C46F54,$0000
	dw CODE_C46F79,CODE_C46F86,$0000,$0000
	dw CODE_C46F6C
CODE_C46FAD:						; from CODE_C46E4B
	stx.b r3
	sty.b $42
	stz.b tmp0
	stz.b tmp1
	ldx.b $3A
	ldy.b $3E
	cpx.b r3
	bpl .3
	lda.w #$0008
	sta.b tmp0
	cpy.b r3
	bpl .4
.rts:								; return
	rts
.1:									; if Y - $42 < 0 go to .5, tmp1 = $0002, go to .5
	cpy.b $42
	bmi .5
	lda.w #$0002
	sta.b tmp1
	bra .5
.2:									; if Y - $0024 < 0 go to .6, A = tmp1, A or $0004, tmp1 = A, ...
	cpy.w #$0024
	bmi .6
	lda.b tmp1
	ora.w #$0004
	sta.b tmp1
	bra .6
.3:									; if Y - r3 >= 0 go to .4, tmp1 = $0008
	cpy.b r3
	bpl .4
	lda.w #$0008
	sta.b tmp1
.4:									; if X - $42 < 0 go to .1, tmp0 = $0002, if Y - $42 >= 0 go to .rts
	cpx.b $42
	bmi .1
	lda.w #$0002
	sta.b tmp0
	cpy.b $42
	bpl .rts
.5:									; X = p0, Y = p1, if p0 - $0024 < 0 go to .2, A = tmp0, ...
	ldx.b p0
	ldy.b p1
	cpx.w #$0024
	bmi .2
	lda.b tmp0
	ora.w #$0004
	sta.b tmp0
	cpy.w #$0024
	bpl .rts
.6:									; if X - $FFDC >= 0 go to .8, A = tmp0, A or $0010, tmp0 = A, ...
	cpx.w #$FFDC
	bpl .8
	lda.b tmp0
	ora.w #$0010
	sta.b tmp0
	cpy.w #$FFDC
	bmi .rts
.7:									; tmp2 + 1, return
	inc.b tmp2
	rts
.8:									; if Y - $FFDC >= 0 go to .7, A = tmp1, A or $0010, tmp1 = A, ...
	cpy.w #$FFDC
	bpl .7
	lda.b tmp1
	ora.w #$0010
	sta.b tmp1
	inc.b tmp2
	rts

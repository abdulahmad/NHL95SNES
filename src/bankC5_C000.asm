; Segment bankC5_C000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C5BFE0
CODE_C5BFE0:						; called from other segments
	ldx.b d1
	lda.l DATA8_C04CBF,x
	and.w #$00FF
	sta.b tmp0
	lda.l DATA8_C04CC3,x
	and.w #$00FF
	sta.b a1
	ldy.w #$0032
.loop:								; loop: X = $3E4E,y, A = $000C,x, X = A, A = DATA8_C40EDA,x, ...
	ldx.w $3E4E,y
	lda.w $000C,x
	tax
	lda.l DATA8_C40EDA,x
	and.w #$00FF
	cmp.b tmp0
	beq .1
	lda.w #$0000
	sta.w $3E4E,y
.1:									; Y - 1, Y - 1, if the result >= 0 go to .loop, X = $0000, ...
	dey
	dey
	bpl .loop
	ldx.w #$0000
	txy
.loop2:								; loop: if $3E4E,x = 0 go to .2, $3E4E,y = A, Y + 1, Y + 1
	lda.w $3E4E,x
	beq .2
	sta.w $3E4E,y
	iny
	iny
.2:									; X + 1, X + 1, if X < $0034 go to .loop2, return
	inx
	inx
	cpx.w #$0034
	bcc .loop2
	rts
CODE_C5C029:						; called from other segments
	ldx.w #$0032
.loop:								; loop: $3E4E,x = 0, X - 1, X - 1, if the result >= 0 go to .loop, ...
	stz.w $3E4E,x
	dex
	dex
	bpl .loop
	lda.b d0
	asl a
	tax
	lda.l DATA8_C5C0AE,x
	sta.b tmp0
	lda.b $81
CODE_C5C03F:						; from CODE_C5C05C
	tax
	stx.b tmp1
	ldy.w #$0000
	bra CODE_C5C04A
CODE_C5C047:						; from CODE_C5C068, CODE_C5C072, CODE_C5C07C, CODE_C5C086, ...
	ply
CODE_C5C048:						; from CODE_C5C054
	iny
	iny
CODE_C5C04A:						; from CODE_C5C03F
	lda.w $3E4E,y
	beq CODE_C5C05C
	phy
	tay
	jmp ($009F)
CODE_C5C054:						; from CODE_C5C068, CODE_C5C072, CODE_C5C07C, CODE_C5C086, ...
	txa
	tyx
	ply
	sta.w $3E4E,y
	bra CODE_C5C048
CODE_C5C05C:						; from CODE_C5C04A
	txa
	sta.w $3E4E,y
	ldx.b tmp1
	lda.w $0002,x
	bne CODE_C5C03F
	rts
CODE_C5C068:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $000A,y
	cmp.w $000A,x
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C072:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $0010,y
	cmp.w $0010,x
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C07C:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $0012,x
	cmp.w $0012,y
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C086:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $0014,y
	cmp.w $0014,x
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C090:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $0016,y
	cmp.w $0016,x
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C09A:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $001A,y
	cmp.w $001A,x
	bcc CODE_C5C054
	bra CODE_C5C047
CODE_C5C0A4:						; a compare routine of the sort (DATA8_C5C0AE), back to the sort loop
	lda.w $0030,x
	cmp.w $0030,y
	bcc CODE_C5C054
	bra CODE_C5C047
DATA8_C5C0AE:						; the compare routines of the sort in CODE_C5C029 (one per sort key)
	dw CODE_C5C068,CODE_C5C068,CODE_C5C072,CODE_C5C07C
	dw CODE_C5C086,CODE_C5C090,CODE_C5C09A,CODE_C5C0A4
CODE_C5C0BE:						; called from other segments
	stz.b $22
	stz.b $24
	lda.w #$00C0
	sta.b $18
	lda.w #$0040
	sta.b $1A
	jsr.w CODE_C5A4B9
	jsr.w CODE_C5A4E2
	jsl.l WaitTransfers
	ldy.w #$2801
	ldx.w #$5194
	jsl.l MapTileBlock
	ldy.w #$2C01
	ldx.w #$5184
	jsl.l MapTileBlock
	lda.w $17C9
	jsl.l CreateSprite
	stx.b d7
	lda.w #$0040
	sta.b $18
	lda.w $17CB
	jsl.l CreateSprite
	stx.b $9D
	inc.b $38,x
	jsr.w CODE_C5A46A
	jmp.w CODE_C5A3C1
SignFreeAgents:						; the Hire Free Agents screen: the free agents (up / down, B marks one);
									; start hires them (CODE_C5C58A), X leaves
	jsl.l CheckTradesFrozen
	jsl.l FadeOutWait
	jsr.w CODE_C5C1F6
	stz.w fadestep
.loop:								; loop: TransfersReady + 1, call ReadMenuPads, $26 + 1, ...
	inc.w TransfersReady
	wai
	jsl.l ReadMenuPads
	inc.b $26
	jsr.w ScrollListArrows
	ldx.b a0
	lda.b $85
	asl a
	asl a
	asl a
	adc.w #$0076
	sta.b $08,x
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w repeatdelayframes
	bne .loop
	lda.w $058D
	bit.w #$1000
	beq .1
	lda.b a1
	beq .2
	jmp.w CODE_C5C58A
.1:									; if $0040 bits clear go to .3
	bit.w #$0040
	beq .3
.2:									; go to GameSetUp
	jmp.w GameSetUp
.3:									; if a1 = 0 go to .loop, if $0800 bits clear go to .5, ...
	ldx.b a1
	beq .loop
	bit.w #$0800
	beq .5
	lda.b $85
	beq .4
	dec a
	sta.b $85
	bra .loop
.4:									; call ScrollListUp, go to .loop
	jsr.w ScrollListUp
	bra .loop
.5:									; if $0400 bits clear go to .7, if $85 >= $0007 go to .6, A + $69, ...
	bit.w #$0400
	beq .7
	lda.b $85
	cmp.w #$0007
	bcs .6
	sec
	adc.b $69
	cmp.b a1
	beq .loop
	inc.b $85
	bra .loop
.6:									; call ScrollListDown, go to .loop
	jsr.w ScrollListDown
	jmp.w .loop
.7:									; if $8000 bits clear go to .15, A = $85, A + $69, X = A, ...
	bit.w #$8000
	beq .15
	lda.b $85
	clc
	adc.b $69
	tax
	lda.w $364E,x
	bit.w #$0040
	bne .8
	bit.w #$0080
	beq .8
	jmp.w .loop
.8:									; A xor $0040, $364E,x = A, if $0040 bits clear go to .11, ...
	eor.w #$0040
	sta.w $364E,x
	bit.w #$0040
	beq .11
	and.w #$000F
	bne .9
	inc.b d0
	bra .14
.9:									; if A >= $0003 go to .10, d1 + 1, go to .14
	cmp.w #$0003
	bcs .10
	inc.b d1
	bra .14
.10:								; $81 + 1, go to .14
	inc.b $81
	bra .14
.11:								; if the result is not 0 go to .12, d0 - 1, go to .14
	and.w #$000F
	bne .12
	dec.b d0
	bra .14
.12:								; if A >= $0003 go to .13, d1 - 1, go to .14
	cmp.w #$0003
	bcs .13
	dec.b d1
	bra .14
.13:								; $81 - 1
	dec.b $81
.14:								; call CODE_C5C4FC, call CODE_C5D85D, call CODE_C55C12, call SendTextMap
	jsr.w CODE_C5C4FC
	jsr.w CODE_C5D85D
	jsr.w CODE_C55C12
	jsl.l SendTextMap
.15:								; go to .loop
	jmp.w .loop
CODE_C5C1F6:						; from SignFreeAgents
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l QueueClearVRAM
	ldy.w #$5C00
	jsl.l ClearVRAM
	lda.w #$FFFF
	sta.w BG3VScroll
	jsl.l WaitTransfers
CODE_C5C214:						; called from other segments
	ldy.w #$2C01
	ldx.w #$5115
	jsl.l MapTileBlock
	ldx.b d7
	jsl.l DeleteSprite
	stz.b d7
	ldx.b a4
	jsl.l DeleteSprite
	ldx.b $75
	jsl.l DeleteSprite
	ldx.b $9D
	lda.w #$00D0
	sta.b $05,x
	lda.w #$0028
	sta.b $08,x
	ldx.b a0
	lda.w #$0003
	jsl.l SetSpriteAnim
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$53AB
	jsl.l PrintTextPage
	lda.w #$0010
	sta.b $CF
	lda.w #$008C
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4F6C
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4CD7
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4CDE
	jsl.l PrintBoldCentred
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w $17CB
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0009
	jsl.l PrintThinCentred
	lda.w $1864
	pha
	lda.w #$0002
	sta.w $1864
	jsr.w CODE_C52CC1
	pla
	sta.w $1864
	ldx.w #$3207
	lda.w $0002,x
	sta.b d0
	lda.w $0006,x
	sta.b d1
	lda.w $0004,x
	sta.b $81
	stz.b a1
	stz.b $69
	ldx.w #$0000
	txy
.loop:								; loop: A = $306A56,x, A and $001F, if A is not $001A go to .1, a1 + 1
	lda.l $306A56,x
	and.w #$001F
	cmp.w #$001A
	bne .1
	inc.b a1
.1:									; Y + 1, if Y >= $027E go to .3, A = $306A57,x, A / 2, ...
	iny
	cpy.w #$027E
	bcs .3
	lda.l $306A57,x
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$001F
	cmp.w #$001A
	bne .2
	inc.b a1
.2:									; X + 1, X + 1, X + 1, Y + 1, ...
	inx
	inx
	inx
	iny
	cpy.w #$027E
	bcc .loop
.3:									; if a1 is not 0 go to .loop2, $D5 = $2400, $CF = $0010, $D1 = $00F0, ...
	ldx.b a1
	bne .loop2
	lda.w #$2400
	sta.b $D5
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4CE3
	ldy.w #$000E
	jsl.l PrintBoldCentred
	ldx.b a0
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	bra .4
.loop2:								; loop: X - 1, $364E,x = 0, if not zero go to .loop2, ...
	dex
	stz.w $364E,x
	bne .loop2
	jsr.w CODE_C5C4FC
	lda.w #CODE_C5C34C
	ldx.w #$0008
	ldy.w #$000E
	jsr.w StartScrollList
	stz.b $85
.4:									; call CODE_C5D85D, call SendTextMap, return
	jsr.w CODE_C5D85D
	jsl.l SendTextMap
	rts
CODE_C5C34C:						; a callback: CODE_C5C214 passes it to StartScrollList
	ldx.b a3
	stx.b $65
	lda.w $364E,x
	bit.w #$0040
	beq .1
	ldy.w #$2400
	bra .2
.1:									; if $0080 bits clear go to .3, Y = $2C00
	bit.w #$0080
	beq .3
	ldy.w #$2C00
.2:									; $D5 = Y
	sty.b $D5
.3:									; A and $000F, A * 2, X = A, A = DATA8_C35E5B,x, ...
	and.w #$000F
	asl a
	tax
	lda.l DATA8_C35E5B,x
	tax
	lda.w #$008C
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldy.b $6D
	jsl.l PrintBoldCentred
	jsr.w CODE_C5D794
	cmp.w #$026A
	bcs .4
	asl a
	adc.w #$0038
	tax
	lda.l $C30000,x
	and.w #$3FFF
	pha
	tax
	lda.w #$0010
	sta.b $CF
	lda.l $C30000,x
	and.w #$00FF
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	ldy.b $6D
	ldx.w #$04F5
	jsl.l PrintBoldLeftStr
	lda.b $01,s
	clc
	adc.w #$0008
	tax
	lda.w #$0024
	sta.b $CF
	jsl.l UnpackText
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	plx
	ldy.w #$0000
.loop:								; loop: $04F5,y = $C30000,x, X + 1, X + 1, Y + 1, ...
	lda.l $C30000,x
	sta.w $04F5,y
	inx
	inx
	iny
	iny
	cpy.w #$0008
	bne .loop
	jmp.w .15
.4:									; call CODE_C5D7CD, call CODE_C5D7E9, $A5 = $0000
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	ldx.w #$0000
	stx.b $A5
.5:									; push X, call CODE_C5D804, pull X, if A = $0000 go to .8, ...
	phx
	jsr.w CODE_C5D804
	plx
	cmp.w #$0000
	beq .8
	cmp.w #$001D
	bne .6
	lda.w #$003D
	bra .7
.6:									; A + $0040, A + $A5
	clc
	adc.w #$0040
	adc.b $A5
.7:									; $04F5,x = A, $A5 = $0020, X + 1, if X is not $0008 go to .5, ...
	sta.w $04F5,x
	lda.w #$0020
	sta.b $A5
	inx
	cpx.w #$0008
	bne .5
	bra .10
.8:									; push X
	phx
.loop2:								; loop: if X = $0007 go to .9, push X, call CODE_C5D804, pull X, ...
	cpx.w #$0007
	beq .9
	phx
	jsr.w CODE_C5D804
	plx
	inx
	bra .loop2
.9:									; pull X
	plx
.10:								; $04F5,x = $0020, $A5 = 0, X + 1, push X
	lda.w #$0020
	sta.w $04F5,x
	stz.b $A5
	inx
	phx
.11:								; push X, call CODE_C5D804, pull X, if A = $0000 go to .loop3, ...
	phx
	jsr.w CODE_C5D804
	plx
	cmp.w #$0000
	beq .loop3
	cmp.w #$001D
	bne .12
	lda.w #$003D
	bra .13
.12:								; A + $0040, A + $A5
	clc
	adc.w #$0040
	adc.b $A5
.13:								; $04F5,x = A, $A5 = $0020, X + 1, A = X, ...
	sta.w $04F5,x
	lda.w #$0020
	sta.b $A5
	inx
	txa
	sec
	sbc.b $01,s
	cmp.w #$000A
	bcc .11
	bra .14
.loop3:								; loop: A = X, A - $01,s, if A = $0009 go to .14, push X, ...
	txa
	sec
	sbc.b $01,s
	cmp.w #$0009
	beq .14
	phx
	jsr.w CODE_C5D804
	plx
	inx
	bra .loop3
.14:								; pull X, $65 = Y, $CF = $0024, X = $04F5, ...
	plx
	sty.b $65
	lda.w #$0024
	sta.b $CF
	ldx.w #$04F5
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	ldy.b $65
	jsr.w CODE_C5D821
	sty.b $65
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	lda.w #$0010
	sta.b $CF
	ldy.b $6D
	ldx.w #$04F5
	jsl.l PrintBoldLeftStr
	ldy.b $65
	ldx.w #$0001
.loop4:								; loop: push X, call CODE_C5D83F, pull X, A 8-bit, ...
	phx
	jsr.w CODE_C5D83F
	plx
	sep #$20
	sta.w $04F5,x
	rep #$20
	inx
	cpx.w #$0008
	bne .loop4
.15:								; Y = $0000, X = a3, A = $364E,x, if the result is not 0 go to .16, ...
	ldy.w #$0000
	ldx.b a3
	lda.w $364E,x
	and.w #$000F
	bne .16
	ldy.w #$0010
.16:								; $24DC = Y, call CODE_C5C6B7, call BinToBCD, call BCDText, ...
	sty.w $24DC
	jsr.w CODE_C5C6B7
	jsr.w BinToBCD
	jsr.w BCDText
	lda.w #$00C8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$04F5
	ldy.b $6D
	jsl.l PrintBoldCentredStr
	lda.w #$2000
	sta.b $D5
	rts
CODE_C5C4FC:						; from CODE_C5C214, SignFreeAgents
	ldx.w #$0000
.1:									; a3 = X, $65 = X, call CODE_C5D794, if A >= $026A go to .4, ...
	stx.b a3
	stx.b $65
	jsr.w CODE_C5D794
	cmp.w #$026A
	bcs .4
	stz.b tmp0
	asl a
	tax
	lda.l PlayerList,x
	bmi .3
	bit.w #$4000
	bne .2
	ldx.b a3
	bra .5
.2:									; X = a3, tmp0 = $0001, go to .7
	ldx.b a3
	lda.w #$0001
	sta.b tmp0
	bra .7
.3:									; tmp0 = $0003, X = a3, go to .8
	lda.w #$0003
	sta.b tmp0
	ldx.b a3
	bra .8
.4:									; call CODE_C5D7CD, call CODE_C5D7E9, tmp0 = A, X = a3, ...
	jsr.w CODE_C5D7CD
	jsr.w CODE_C5D7E9
	sta.b tmp0
	ldx.b a3
	cmp.w #$0000
	bne .6
.5:									; if d0 < $0003 go to .10, go to .9
	lda.b d0
	cmp.w #$0003
	bcc .10
	bra .9
.6:									; if A >= $0003 go to .8
	cmp.w #$0003
	bcs .8
.7:									; if d1 < $000F go to .10, go to .9
	lda.b d1
	cmp.w #$000F
	bcc .10
	bra .9
.8:									; if $81 < $000F go to .10
	lda.b $81
	cmp.w #$000F
	bcc .10
.9:									; A = $0080, A or $364E,x, A or tmp0, $364E,x = A, ...
	lda.w #$0080
	ora.w $364E,x
	ora.b tmp0
	sta.w $364E,x
	bra .11
.10:								; A = d0, A + d1, A + $81, if A >= $0019 go to .9, ...
	lda.b d0
	clc
	adc.b d1
	adc.b $81
	cmp.w #$0019
	bcs .9
	lda.w $364E,x
	and.w #$FF7F
	ora.b tmp0
	sta.w $364E,x
.11:								; X + 1, if X = a1 go to .rts, go to .1
	inx
	cpx.b a1
	beq .rts
	jmp.w .1
.rts:								; return
	rts
CODE_C5C58A:						; from SignFreeAgents
	lda.w $17CB
	asl a
	asl a
	asl a
	asl a
	sta.b tmp1
	ldx.b a1
.1:									; X - 1, if the result >= 0 go to .2, go to GameSetUp
	dex
	bpl .2
	jmp.w GameSetUp
.2:									; a1 = X, $65 = X, A = $364E,x, if $0040 bits clear go to .1, ...
	stx.b a1
	stx.b $65
	lda.w $364E,x
	bit.w #$0040
	beq .1
	jsr.w CODE_C5D794
	sta.b tmp0
	lsr a
	bcc .3
	clc
	adc.b tmp0
	tax
	lda.l $306A56,x
	and.w #$000F
	ora.w #$FE00
	ora.b tmp1
	sta.l $306A56,x
	bra .4
.3:									; A + tmp0, X = A, A = $306A56,x, A and $F000, ...
	adc.b tmp0
	tax
	lda.l $306A56,x
	and.w #$F000
	ora.w #$0FE0
	ora.w $17CB
	sta.l $306A56,x
.4:									; if tmp0 < $026A go to .5, call CODE_C5D7CD, A = Y, A + $005D, ...
	lda.b tmp0
	cmp.w #$026A
	bcc .5
	jsr.w CODE_C5D7CD
	tya
	clc
	adc.w #$005D
	tay
	jsr.w CODE_C5D821
	bra .loop
.5:									; A * 2, A + $0038, X = A, A = $C30000,x, ...
	asl a
	adc.w #$0038
	tax
	lda.l $C30000,x
	and.w #$3FFF
	tax
	lda.l $C30000,x
	and.w #$00FF
.loop:								; loop: tmp2 = A, call CODE_C5C658, if carry clear go to .6, A = tmp2, ...
	sta.b tmp2
	jsr.w CODE_C5C658
	bcc .6
	lda.b tmp2
	inc a
	cmp.w #$0064
	bcc .loop
	lda.w #$0000
	bra .loop
.6:									; A = tmp0, A / 2, if carry clear go to .7, A + tmp0, ...
	lda.b tmp0
	lsr a
	bcc .7
	clc
	adc.b tmp0
	tax
	lda.b tmp2
	xba
	asl a
	sta.b tmp2
	lda.l $306A56,x
	and.w #$01FF
	ora.b tmp2
	sta.l $306A56,x
	ldx.b a1
	jmp.w .1
.7:									; A + tmp0, X = A, A = tmp2, A * 2, ...
	adc.b tmp0
	tax
	lda.b tmp2
	asl a
	asl a
	asl a
	asl a
	asl a
	sta.b tmp2
	lda.l $306A56,x
	and.w #$F01F
	ora.b tmp2
	sta.l $306A56,x
	ldx.b a1
	jmp.w .1
DATA8_C5C655:						; not traced: data between routines
	db $4C,$32,$8D
CODE_C5C658:						; from CODE_C5C58A
	ldx.w #$0000
	txy
.loop:								; loop: A = $306A56,x, A and $001F, if A is not $17CB go to .1, ...
	lda.l $306A56,x
	and.w #$001F
	cmp.w $17CB
	bne .1
	lda.l $306A56,x
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	and.w #$007F
	cmp.b tmp2
	beq .4
.1:									; Y + 1, if Y >= $027E go to .3, A = $306A57,x, A and $01F0, ...
	iny
	cpy.w #$027E
	bcs .3
	lda.l $306A57,x
	and.w #$01F0
	cmp.b tmp1
	bne .2
	lda.l $306A58,x
	lsr a
	and.w #$007F
	cmp.b tmp2
	beq .4
.2:									; X + 1, X + 1, X + 1, Y + 1, ...
	inx
	inx
	inx
	iny
	cpy.w #$027E
	bcc .loop
.3:									; return
	clc
	rts
.4:									; return
	sec
	rts
CODE_C5C6A2:						; called from other segments
	pei ($9F)
	pei ($A5)
	pei ($0A)
	phy
	jsr.w CODE_C5C6B7
	ply
	plx
	stx.b $0A
	plx
	stx.b $A5
	plx
	stx.b tmp0
	rtl
CODE_C5C6B7:						; from CODE_C5C6A2, CODE_C5CC4D, CODE_C5C34C, CODE_C5C926, ...
	ldx.w #$5DF9
	lda.l $7E24DC
	beq .1
	ldx.w #$F0C9
.1:									; tmp0 = X, $A5 = 0, A = $000F
	stx.b tmp0
	stz.b $A5
	lda.w #$000F
.loop:								; loop: $0A = A, A * 2, X = A, A = BitMaskTable2,x, ...
	sta.b $0A
	asl a
	tax
	lda.l BitMaskTable2,x
	bit.b tmp0
	beq .3
	lda.b $0A
	lsr a
	tax
	lda.w $04F5,x
	bcs .2
	lsr a
	lsr a
	lsr a
	lsr a
.2:									; A and $000F, Y = A, A = $0A, A + $7E24DC, ...
	and.w #$000F
	tay
	lda.b $0A
	clc
	adc.l $7E24DC
	tax
	lda.l DATA8_C57309,x
	tyx
	jsl.l Mul8U
	clc
	adc.b $A5
	sta.b $A5
.3:									; A = $0A, A - 1, if the result is not 0 go to .loop, ...
	lda.b $0A
	dec a
	bne .loop
	lda.b $A5
	bpl .4
	lda.w #$0000
.4:									; if $24DC = 0 go to .5, A / 2
	ldx.w $24DC
	beq .5
	lsr a
.5:									; if A < $0065 go to .6, A = $0064
	cmp.w #$0065
	bcc .6
	lda.w #$0064
.6:									; if A >= $0032 go to .rts, A / 2, A + $0019
	cmp.w #$0032
	bcs .rts
	lsr a
	clc
	adc.w #$0019
.rts:								; return
	rts
ReleasePlayers:						; the Release Players screen: a team's roster (up / down, B marks a
									; player); start releases them (CODE_C5CA27), X leaves
	jsl.l CheckTradesFrozen
	jsl.l FadeOutWait
	jsr.w CODE_C5C826
	stz.w fadestep
.loop:								; loop: TransfersReady + 1, call ReadMenuPads, $26 + 1, ...
	inc.w TransfersReady
	wai
	jsl.l ReadMenuPads
	inc.b $26
	jsr.w ScrollListArrows
	ldx.b a0
	lda.b $85
	asl a
	asl a
	asl a
	adc.w #$0076
	sta.b $08,x
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w repeatdelayframes
	bne .loop
	lda.w $058D
	bit.w #$1000
	beq .1
	jmp.w CODE_C5CA27
.1:									; if $0040 bits clear go to .2, go to GameSetUp
	bit.w #$0040
	beq .2
	jmp.w GameSetUp
.2:									; if $0800 bits clear go to .4, if $85 = 0 go to .3, A - 1, $85 = A, ...
	bit.w #$0800
	beq .4
	lda.b $85
	beq .3
	dec a
	sta.b $85
	bra .loop
.3:									; call ScrollListUp, go to .loop
	jsr.w ScrollListUp
	bra .loop
.4:									; if $0400 bits clear go to .6, if $85 >= $0007 go to .5, A + $69, ...
	bit.w #$0400
	beq .6
	lda.b $85
	cmp.w #$0007
	bcs .5
	sec
	adc.b $69
	cmp.b a1
	beq .loop
	inc.b $85
	bra .loop
.5:									; call ScrollListDown, go to .loop
	jsr.w ScrollListDown
	jmp.w .loop
.6:									; if $8000 bits clear go to .loop, Y = $3207, A = $69, A + $85, ...
	bit.w #$8000
	beq .loop
	ldy.w #$3207
	lda.b $69
	clc
	adc.b $85
	tax
	lda.w $364E,x
	bit.w #$0001
	beq .7
	txa
	sec
	sbc.w $0002,y
	bmi .8
	sbc.w $0004,y
	bmi .10
	bra .12
.7:									; A = X, A - $0002,y, if the result >= 0 go to .9, if d0 < $0003 go to .16
	txa
	sec
	sbc.w $0002,y
	bpl .9
	lda.b d0
	cmp.w #$0003
	bcc .16
.8:									; tmp0 = $007F, go to .13
	lda.w #$007F
	sta.b tmp0
	bra .13
.9:									; A - $0004,y, if the result >= 0 go to .11, if $81 < $000A go to .16
	sbc.w $0004,y
	bpl .11
	lda.b $81
	cmp.w #$000A
	bcc .16
.10:								; tmp0 = $0081, go to .13
	lda.w #$0081
	sta.b tmp0
	bra .13
.11:								; if d1 < $0007 go to .16
	lda.b d1
	cmp.w #$0007
	bcc .16
.12:								; tmp0 = $0083
	lda.w #$0083
	sta.b tmp0
.13:								; A = $364E,x, A xor $0001, $364E,x = A, ...
	lda.w $364E,x
	eor.w #$0001
	sta.w $364E,x
	bit.w #$0001
	beq .14
	lda.b (tmp0)
	dec a
	sta.b (tmp0)
	bra .15
.14:								; A = (tmp0), A + 1, (tmp0) = A
	lda.b (tmp0)
	inc a
	sta.b (tmp0)
.15:								; call CODE_C5D85D, call CODE_C55C12, call SendTextMap
	jsr.w CODE_C5D85D
	jsr.w CODE_C55C12
	jsl.l SendTextMap
.16:								; go to .loop
	jmp.w .loop
CODE_C5C826:						; from ReleasePlayers
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l QueueClearVRAM
	ldy.w #$5C00
	jsl.l ClearVRAM
	lda.w #$FFFF
	sta.w BG3VScroll
	jsl.l WaitTransfers
	ldy.w #$2C01
	ldx.w #$5115
	jsl.l MapTileBlock
	ldx.b d7
	jsl.l DeleteSprite
	ldx.b a4
	jsl.l DeleteSprite
	ldx.b $75
	jsl.l DeleteSprite
	ldx.b $9D
	lda.w #$00D0
	sta.b $05,x
	lda.w #$0028
	sta.b $08,x
	ldx.b a0
	lda.w #$0003
	jsl.l SetSpriteAnim
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$53D5
	jsl.l PrintTextPage
	lda.w #$0010
	sta.b $CF
	lda.w #$008C
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4F6C
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4CD7
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldy.w #$000C
	ldx.w #$4CDE
	jsl.l PrintBoldCentred
	lda.w #$00A8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.w $17CB
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0009
	jsl.l PrintThinCentred
	lda.w $1864
	pha
	lda.w #$0002
	sta.w $1864
	jsr.w CODE_C52CC1
	pla
	sta.w $1864
	ldx.w #$3207
	lda.w $0002,x
	sta.b d0
	lda.w $0006,x
	sta.b d1
	lda.w $0004,x
	sta.b $81
	clc
	adc.b d1
	adc.b d0
	sta.b a1
	stz.b $69
	stz.b $85
	ldx.w #$0000
.loop:								; loop: $364E,x = 0, X + 1, if X is not a1 go to .loop, ...
	stz.w $364E,x
	inx
	cpx.b a1
	bne .loop
	lda.w #CODE_C5C926
	ldx.w #$0008
	ldy.w #$000E
	jsr.w StartScrollList
	jsr.w CODE_C5D85D
	jsl.l SendTextMap
	rts
CODE_C5C926:						; a callback: CODE_C5C826 passes it to StartScrollList
	lda.w #$0010
	sta.l $7E24DC
	ldy.w #$3207
	ldx.w #$49B8
	lda.b a3
	sec
	sbc.w $0002,y
	bpl .1
	lda.b d0
	cmp.w #$0003
	bne .2
	bra .4
.1:									; $24DC = 0, X = $4CF6, A - $0004,y, if the result >= 0 go to .3, ...
	stz.w $24DC
	ldx.w #$4CF6
	sbc.w $0004,y
	bpl .3
	lda.b $81
	cmp.w #$000A
	bcs .4
.2:									; $D5 = $2C00, go to .4
	lda.w #$2C00
	sta.b $D5
	bra .4
.3:									; X = $4CF0, if d1 < $0007 go to .2
	ldx.w #$4CF0
	lda.b d1
	cmp.w #$0007
	bcc .2
.4:									; Y = a3, A = $364E,y, if $0001 bits clear go to .5, $D5 = $2400
	ldy.b a3
	lda.w $364E,y
	bit.w #$0001
	beq .5
	lda.w #$2400
	sta.b $D5
.5:									; $CF = $008C, $D1 = $00C8, Y = $6D, call PrintBoldCentred, ...
	lda.w #$008C
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldy.b $6D
	jsl.l PrintBoldCentred
	lda.b a3
	asl a
	adc.w #$3207
	tax
	lda.w $003A,x
	sta.b tmp0
	lsr a
	bcc .6
	clc
	adc.b tmp0
	tax
	lda.l $306A57,x
	lsr a
	bra .7
.6:									; A + tmp0, X = A, A = $306A56,x, A / 2, ...
	adc.b tmp0
	tax
	lda.l $306A56,x
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
.7:									; A and $007F, X = A, A = BCDTable,x, A and $00FF, ...
	and.w #$007F
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	lda.w #$0010
	sta.b $CF
	ldx.w #$04F5
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.w #$0024
	sta.b $CF
	lda.b a3
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.w #$331F
	tax
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.b a3
	asl a
	asl a
	asl a
	asl a
	asl a
	tax
	lda.w $3317,x
	sta.w $04F5
	lda.w $3319,x
	sta.w $04F7
	lda.w $331B,x
	sta.w $04F9
	lda.w $331D,x
	sta.w $04FB
	jsr.w CODE_C5C6B7
	jsr.w BinToBCD
	jsr.w BCDText
	lda.w #$00C8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$04F5
	ldy.b $6D
	jsl.l PrintBoldCentredStr
	lda.w #$2000
	sta.b $D5
	rts
CODE_C5CA27:						; from ReleasePlayers
	ldy.w #$FFFF
.1:									; Y + 1, if Y is not a1 go to .2, go to GameSetUp
	iny
	cpy.b a1
	bne .2
	jmp.w GameSetUp
.2:									; A = $364E,y, if $0001 bits clear go to .1, A = Y, A * 2, ...
	lda.w $364E,y
	bit.w #$0001
	beq .1
	tya
	asl a
	tax
	lda.w $3241,x
	sta.b tmp0
	lsr a
	bcc .3
	clc
	adc.b tmp0
	tax
	lda.l $306A56,x
	and.w #$FE0F
	ora.w #$01A0
	sta.l $306A56,x
	bra .1
.3:									; A + tmp0, X = A, A = $306A56,x, A and $FFE0, ...
	adc.b tmp0
	tax
	lda.l $306A56,x
	and.w #$FFE0
	ora.w #$001A
	sta.l $306A56,x
	bra .1
TradePlayers:						; the Trade Players screen: both rosters (Y switches the team, up / down
									; move, B marks a player); start goes on to GMDecisionScreen, X leaves
	jsl.l CheckTradesFrozen
	jsl.l FadeOutWait
	jsr.w CODE_C5CB36
	stz.w fadestep
.1:									; TransfersReady + 1, call ReadMenuPads, $26 + 1, call CODE_C5DA09, ...
	inc.w TransfersReady
	wai
	jsl.l ReadMenuPads
	inc.b $26
	jsr.w CODE_C5DA09
	ldx.b a0
	lda.b $85
	asl a
	asl a
	asl a
	ldy.b a2
	bne .2
	adc.w #$0046
	bra .3
.2:									; A + $008E
	adc.w #$008E
.3:									; $08,x = A, call AnimateSprites, $28 = $1D8F, $2A = $1E00, ...
	sta.b $08,x
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w repeatdelayframes
	bne .1
	lda.w $058D
	bit.w #$1000
	beq .4
	jmp.w GMDecisionScreen
.4:									; if $0040 bits clear go to .5, go to GameSetUp
	bit.w #$0040
	beq .5
	jmp.w GameSetUp
.5:									; if $0800 bits clear go to .7, if $85 = 0 go to .6, A - 1, $85 = A, ...
	bit.w #$0800
	beq .7
	lda.b $85
	beq .6
	dec a
	sta.b $85
	bra .1
.6:									; call CODE_C5DAF3, go to .1
	jsr.w CODE_C5DAF3
	bra .1
.7:									; if $0400 bits clear go to .9, if $85 >= $0004 go to .8, X = a2, ...
	bit.w #$0400
	beq .9
	lda.b $85
	cmp.w #$0004
	bcs .8
	ldx.b a2
	sec
	adc.b $77,x
	cmp.b $7B,x
	beq .1
	inc.b $85
	bra .1
.8:									; call CODE_C5DB9F, go to .1
	jsr.w CODE_C5DB9F
	jmp.w .1
.9:									; if $4000 bits clear go to .10, A = a2, A xor $0002, a2 = A, ...
	bit.w #$4000
	beq .10
	lda.b a2
	eor.w #$0002
	sta.b a2
	jmp.w .1
.10:								; if $8000 bits clear go to .12, tmp0 = 0, if a2 = 0 go to .11, ...
	bit.w #$8000
	beq .12
	stz.b tmp0
	ldx.b a2
	beq .11
	lda.w #$0064
	sta.b tmp0
.11:								; A = $85, A + $77,x, A + tmp0, X = A, ...
	lda.b $85
	clc
	adc.b $77,x
	adc.b tmp0
	tax
	lda.w $364E,x
	eor.w #$0001
	sta.w $364E,x
	jsr.w CODE_C5DA58
	jsl.l SendTextMap
.12:								; go to .1
	jmp.w .1
CODE_C5CB36:						; from TradePlayers
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l QueueClearVRAM
	lda.w #$FFFF
	sta.w BG3VScroll
	jsl.l WaitTransfers
	ldx.b d7
	jsl.l DeleteSprite
	ldx.b $9D
	jsl.l DeleteSprite
	ldx.b a4
	jsl.l DeleteSprite
	ldx.b $75
	jsl.l DeleteSprite
	ldx.b a0
	lda.w #$0003
	jsl.l SetSpriteAnim
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$56F2
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	ldy.w #$2801
	ldx.w #$5084
	jsl.l MapTileBlock
	ldy.w #$2C01
	ldx.w #$51A4
	jsl.l MapTileBlock
	ldy.w #$0005
	lda.w $17C9
	jsr.w CODE_C5A4A5
	ldy.w #$000E
	lda.w $17CB
	jsr.w CODE_C5A4A5
	lda.w #$008C
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldx.w #$4CD7
	ldy.w #$0006
	jsl.l PrintBoldCentred
	ldx.w #$4CD7
	ldy.w #$000F
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$4CDE
	ldy.w #$0006
	jsl.l PrintBoldCentred
	ldx.w #$4CDE
	ldy.w #$000F
	jsl.l PrintBoldCentred
	lda.w $1864
	pha
	lda.w #$0002
	sta.w $1864
	jsr.w CODE_C52CC1
	pla
	sta.w $1864
	lda.w $2DCB
	clc
	adc.w $2DCD
	adc.w $2DCF
	sta.b $7B
	lda.w $3209
	clc
	adc.w $320B
	adc.w $320D
	sta.b $7D
	ldx.w #$0000
.loop:								; loop: $364E,x = 0, X + 1, if X is not $7B go to .loop, X = $0000
	stz.w $364E,x
	inx
	cpx.b $7B
	bne .loop
	ldx.w #$0000
.loop2:								; loop: $36B2,x = 0, X + 1, if X is not $7D go to .loop2, a1 = $0005, ...
	stz.w $36B2,x
	inx
	cpx.b $7D
	bne .loop2
	lda.w #$0005
	sta.b a1
	sta.b $69
	lda.w #$0008
	sta.b a3
	lda.w #$0011
	sta.b $71
	lda.w #$2DC9
	sta.b a4
	lda.w #$3207
	sta.b $75
	lda.w #CODE_C5CC4D
	jsr.w CODE_C5D8E7
	jsl.l SendTextMap
	jsl.l WaitTransfers
	stz.b $85
	rts
CODE_C5CC4D:						; a callback: CODE_C5CB36 passes it to CODE_C5D8E7
	ldy.b d2
	lda.w #$0010
	sta.l $7E24DC
	ldx.w #$49B8
	lda.b $91
	sec
	sbc.w $0002,y
	bmi .1
	stz.w $24DC
	ldx.w #$4CF6
	sbc.w $0004,y
	bmi .1
	ldx.w #$4CF0
.1:									; A = $0000, if d2 = $2DC9 go to .2, A = $0064
	lda.w #$0000
	ldy.b d2
	cpy.w #$2DC9
	beq .2
	lda.w #$0064
.2:									; A + $91, Y = A, A = $364E,y, if $0001 bits clear go to .3, ...
	clc
	adc.b $91
	tay
	lda.w $364E,y
	bit.w #$0001
	beq .3
	lda.w #$2400
	sta.b $D5
.3:									; $CF = $008C, $D1 = $00C8, Y = $6D, call PrintBoldCentred, ...
	lda.w #$008C
	sta.b $CF
	lda.w #$00C8
	sta.b $D1
	ldy.b $6D
	jsl.l PrintBoldCentred
	lda.b $91
	asl a
	adc.b d2
	tax
	lda.w $003A,x
	sta.b tmp0
	lsr a
	bcc .4
	clc
	adc.b tmp0
	tax
	lda.l $306A57,x
	lsr a
	bra .5
.4:									; A + tmp0, X = A, A = $306A56,x, A / 2, ...
	adc.b tmp0
	tax
	lda.l $306A56,x
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
.5:									; A and $007F, X = A, A = BCDTable,x, A and $00FF, ...
	and.w #$007F
	tax
	lda.l BCDTable,x
	and.w #$00FF
	jsr.w BCDText
	lda.w #$0010
	sta.b $CF
	ldx.w #$04F5
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.w #$0024
	sta.b $CF
	lda.b $91
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b d2
	adc.w #$0118
	tax
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	lda.b $91
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b d2
	tax
	lda.w $0110,x
	sta.w $04F5
	lda.w $0112,x
	sta.w $04F7
	lda.w $0114,x
	sta.w $04F9
	lda.w $0116,x
	sta.w $04FB
	jsr.w CODE_C5C6B7
	jsr.w BinToBCD
	jsr.w BCDText
	lda.w #$00C8
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	ldx.w #$04F5
	ldy.b $6D
	jsl.l PrintBoldCentredStr
	lda.w #$2000
	sta.b $D5
	rts
GMDecisionScreen:					; the trade decision: DrawGMDecision, then start does an accepted trade
									; (CheckTrade, ExecuteTrade) and leaves, X goes back to TradePlayers
	jsr.w DrawGMDecision
	stz.w fadestep
.loop:								; loop: TransfersReady + 1, call ReadMenuPads, $26 + 1, ...
	inc.w TransfersReady
	wai
	jsl.l ReadMenuPads
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w repeatdelayframes
	bne .loop
	lda.w $058D
	bit.w #$1000
	beq .2
	jsr.w CheckTrade
	bcs .1
	jsr.w ExecuteTrade
.1:									; go to GameSetUp
	jmp.w GameSetUp
.2:									; if $0040 bits clear go to .3, X = a0, $05,x = $0008, go to TradePlayers
	bit.w #$0040
	beq .3
	ldx.b a0
	lda.w #$0008
	sta.b $05,x
	jmp.w TradePlayers
.3:									; go to .loop
	bra .loop
DrawGMDecision:						; draws the trade decision: both teams, their chosen players
									; (PrintTradedPlayers), then Accepted, or Rejected with Illegal or
									; Advantage and the team (CheckTrade)
	jsr.w CheckTrade
	phx
	php
	lda.b $77
	ora.b $79
	bne .1
	plp
	pla
	pla
	jmp.w GameSetUp
.1:									; call FadeOutWait, DMAEnShadow = $8000, Y = $5000, ...
	jsl.l FadeOutWait
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l QueueClearVRAM
	jsl.l WaitTransfers
	ldx.b a0
	lda.w #$012C
	sta.b $05,x
	ldx.b d3
	jsl.l DeleteSprite
	stz.b d3
	ldx.b $8D
	jsl.l DeleteSprite
	stz.b $8D
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$53FF
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	ldy.w #$2801
	ldx.w #$5084
	jsl.l MapTileBlock
	ldy.w #$2C01
	ldx.w #$5094
	jsl.l MapTileBlock
	ldy.w #$0005
	lda.w $17C9
	jsr.w CODE_C5A4A5
	lda.w #$00A0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	lda.w $17CB
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0005
	jsl.l PrintThinCentred
	lda.w #$0010
	sta.b $CF
	lda.w #$2DC9
	sta.b d2
	ldy.w #$0008
	ldx.b $7B
	lda.w #$364E
	jsr.w PrintTradedPlayers
	lda.w #$0090
	sta.b $CF
	lda.w #$3207
	sta.b d2
	ldy.w #$0008
	ldx.b $7D
	lda.w #$36B2
	jsr.w PrintTradedPlayers
	lda.w #$0010
	sta.b $CF
	ldy.w #$0012
	plp
	bcs .2
	plx
	lda.w #$2400
	sta.b $D5
	ldx.w #$4D53
	jsl.l PrintItalicLeft
	bra .5
.2:									; $D5 = $2800, X = $4D5A, call PrintItalicLeft, $D5 = $2000, ...
	lda.w #$2800
	sta.b $D5
	ldx.w #$4D5A
	jsl.l PrintItalicLeft
	lda.w #$2000
	sta.b $D5
	lda.b $01,s
	cmp.b r3
	beq .3
	ldx.w #$4B7F
	bra .4
.3:									; X = $4D61
	ldx.w #$4D61
.4:									; Y = $0014, call PrintBoldLeft, $CF = $0061, pull A, ...
	ldy.w #$0014
	jsl.l PrintBoldLeft
	lda.w #$0061
	sta.b $CF
	pla
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0014
	jsl.l PrintBoldLeft
.5:									; $D5 = $2000, call SendTextMap, return
	lda.w #$2000
	sta.b $D5
	jsl.l SendTextMap
	rts
PrintTradedPlayers:					; prints the chosen players of a trade list (bit 0 of each entry): No
									; Selections when none, Etc. after 8
	sty.b $6D
	stx.b tmp0
	sta.b tmp1
	ldx.w #$0000
	txy
.loop:								; loop: A = (tmp1),y, if $0001 bits clear go to .1, X + 1
	lda.b (tmp1),y
	bit.w #$0001
	beq .1
	inx
.1:									; Y + 1, if Y is not tmp0 go to .loop, if X is not $0000 go to .2, ...
	iny
	cpy.b tmp0
	bne .loop
	cpx.w #$0000
	bne .2
	ldx.w #$4D3F
	ldy.b $6D
	jsl.l PrintBoldLeft
	rts
.2:									; tmp0 = X, tmp2 = 0, Y = $0000
	stx.b tmp0
	stz.b tmp2
	ldy.w #$0000
.loop2:								; loop: A = (tmp1),y, Y + 1, if $0001 bits clear go to .loop2, push Y, ...
	lda.b (tmp1),y
	iny
	bit.w #$0001
	beq .loop2
	phy
	dey
	tya
	asl a
	asl a
	asl a
	asl a
	asl a
	adc.b d2
	adc.w #$0118
	tax
	lda.w #$000C
	jsl.l CODE_C55F8A
	ldy.b $6D
	jsl.l PrintBoldLeftStr
	inc.b $6D
	ply
	lda.b tmp2
	inc a
	sta.b tmp2
	cmp.b tmp0
	bne .3
	rts
.3:									; if A is not $0008 go to .loop2, A + 1, if A = tmp0 go to .loop2, ...
	cmp.w #$0008
	bne .loop2
	inc a
	cmp.b tmp0
	beq .loop2
	ldx.w #$4D4A
	ldy.b $6D
	jsl.l PrintBoldLeft
	rts
CheckTrade:							; checks the trade: carry clear when it can go; else carry set, X = the
									; team and r3 = the Illegal text (a roster rule broken) or the same team
									; (the trade values differ by 5 or more)
	lda.w #$0077
	sta.b tmp1
	stz.b $77
	lda.b $7B
	sta.b tmp2
	lda.w #$364E
	sta.b d2
	lda.w #$2DC9
	sta.b a4
	jsr.w TradeValue
	lda.b d0
	sta.b d5
	lda.b $81
	sta.b $95
	lda.b d1
	sta.b d6
	lda.w #$0079
	sta.b tmp1
	stz.b $79
	lda.b $7D
	sta.b tmp2
	lda.w #$36B2
	sta.b d2
	lda.w #$3207
	sta.b a4
	jsr.w TradeValue
	ldx.w $17CB
	lda.b $77
	sec
	sbc.b $79
	tay
	bpl .1
	eor.w #$FFFF
	inc a
.1:									; if A < $0005 go to .3, A = Y, if the result >= 0 go to .2, X = $17C9
	cmp.w #$0005
	bcc .3
	tya
	bpl .2
	ldx.w $17C9
.2:									; r3 = X, return
	stx.b r3
	sec
	rts
.3:									; A = $2DCB, A - d5, A + d0, if A >= $0002 go to .4, ...
	lda.w $2DCB
	sec
	sbc.b d5
	clc
	adc.b d0
	cmp.w #$0002
	bcs .4
	jmp.w .5
.4:									; if A >= $0004 go to .5, r3 = A, A = $2DCD, A - $95, ...
	cmp.w #$0004
	bcs .5
	sta.b r3
	lda.w $2DCD
	sec
	sbc.b $95
	clc
	adc.b $81
	cmp.w #$0009
	bcc .5
	cmp.w #$0010
	bcs .5
	adc.b r3
	sta.b r3
	lda.w $2DCF
	sec
	sbc.b d6
	clc
	adc.b d1
	cmp.w #$0006
	bcc .5
	cmp.w #$0010
	bcs .5
	adc.b r3
	cmp.w #$001A
	bcs .5
	lda.w $3209
	sec
	sbc.b d0
	clc
	adc.b d5
	cmp.w #$0002
	bcc .6
	cmp.w #$0004
	bcs .6
	sta.b r3
	lda.w $320B
	sec
	sbc.b $81
	clc
	adc.b $95
	cmp.w #$0009
	bcc .6
	cmp.w #$0010
	bcs .6
	adc.b r3
	sta.b r3
	lda.w $320D
	sec
	sbc.b d1
	clc
	adc.b d6
	cmp.w #$0006
	bcc .6
	cmp.w #$0010
	bcs .6
	adc.b r3
	cmp.w #$001A
	bcs .6
	stx.b r3
	clc
	rts
.5:									; X = $17C9, go to .7
	ldx.w $17C9
	bra .7
.6:									; X = $17CB
	ldx.w $17CB
.7:									; r3 = $4B7F, return
	lda.w #$4B7F
	sta.b r3
	sec
	rts

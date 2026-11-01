; Segment bankC3_8000: the rest of bank $C3's game code (routines keep their address as a name, with their
; callers) and the data tables it reads; the sound samples start after it.
org $C37FE2
CODE_C37FE2:						; called from other segments
	phx
	tay
	lda.w frame,y
	asl a
	tax
	lda.l DATA8_CE0192,x
	eor.w #$FFFF
	inc a
	sta.b d1
	lda.w attribute,y
	bit.w #$0800
	beq .1
	lda.l DATA8_CDF94A,x
	eor.w #$FFFF
	inc a
	sta.b d0
	plx
	rtl
.1:									; d0 = DATA8_CDF94A,x, pull X, return
	lda.l DATA8_CDF94A,x
	sta.b d0
	plx
	rtl
CODE_C3800F:						; no caller found (not traced)
	lda.b d0
	sec
	sbc.b $CB
	sta.b d0
	lda.b d1
	sec
	sbc.b $CD
	sta.b d1
	lda.b d0
	clc
	adc.w #$0080
	sta.b d0
	lda.b d2
	asl a
	clc
	adc.b d2
	pha
	asl a
	pla
	ror a
	clc
	adc.b d1
	sta.b d1
	lda.w #$005E
	sec
	sbc.b d1
	sta.b d1
	rtl
DATA8_C3803D:						; not traced: data between routines
	db $A9,$20,$4E,$85,$83,$6B
setpads:							; called from other segments
	txa
	lsr a
	ldy.b d4
	sta.w PadControlObj,y
	rtl
DATA8_C3804B:						; not traced: data between routines
	db $6B,$6B
SetupScrollIRQ:						; no caller found (not traced): the three BG1 scroll splits at the
									; lines A, X and Y; the scroll values start at $FFFF
	sta.w irqline1
	stx.w irqline2
	sty.w irqline3
	lda.w #$FFFF
	sta.w irqvscroll1
	sta.w irqvscroll2
	sta.w irqvscroll3
	lda.w #$00C4
	sta.w IRQHTime
	lda.w #IRQ_StatsScroll1&$FFFF
	ldx.w #IRQ_StatsScroll1>>16
	ldy.w irqline1
	jml.l SetIRQ
IRQ_StatsScroll1:					; IRQ hook: the first BG1 scroll split, then IRQ_StatsScroll2
	sep #$20
	lda.w irqvscroll1
	sta.l BG1VOFS
	lda.w irqvscroll1+1
	sta.l BG1VOFS
	rep #$20
	lda.w #IRQ_StatsScroll2&$FFFF
	sta.w IRQHook
	lda.w irqline2
	sta.l VTIMEL
	lda.w #$FFFF
	rtl
IRQ_StatsScroll2:					; IRQ hook: the second BG1 scroll split, then IRQ_StatsScroll3
	sep #$20
	lda.w irqvscroll2
	sta.l BG1VOFS
	lda.w irqvscroll2+1
	sta.l BG1VOFS
	rep #$20
	lda.w #IRQ_StatsScroll3&$FFFF
	sta.w IRQHook
	lda.w irqline3
	sta.l VTIMEL
	rtl
IRQ_StatsScroll3:					; IRQ hook: the last BG1 scroll split, then IRQ_StatsScroll1 again
	sep #$20
	lda.w irqvscroll3
	sta.l BG1VOFS
	lda.w irqvscroll3+1
	sta.l BG1VOFS
	rep #$20
	lda.w #IRQ_StatsScroll1&$FFFF
	sta.w IRQHook
	rtl
CODE_C380D1:						; called from other segments
	lda.w $1864
	cmp.w #$0001
	bne .1
	rtl
.1:									; push X, push Y, $2CE3 = $FFFF, $2CE5 = A
	phx
	phy
	pei ($81)
	pei ($7F)
	pei ($65)
	pei ($63)
	pei ($69)
	pei ($67)
	pei ($6D)
	pei ($6B)
	lda.w #$FFFF
	sta.w $2CE3
	sta.w $2CE5
	sta.w $2CE7
	jsr.w CODE_C381D5
	ldy.w gsp
	lda.w #$584C
	cpy.w #$0003
	bne .2
	ldy.w gameclock
	beq .2
	lda.w #$59AC
.2:									; X = $0013, Y = $0005, call CODE_C58C36, A = gsp, ...
	ldx.w #$0013
	ldy.w #$0005
	jsl.l CODE_C58C36
	lda.w gsp
	ldy.w #$586D
	cmp.w #$0003
	bne .3
	lda.w gameclock
	beq .3
	ldy.w #$59CD
.3:									; X = $00C3, A = $5A14, call QueueVRAMDMALen, A = $588D, ...
	ldx.w #$00C3
	lda.w #$5A14
	jsl.l QueueVRAMDMALen
	lda.w #$588D
	ldy.w gsp
	cpy.w #$0003
	bne .4
	ldy.w gameclock
	beq .4
	lda.w #$59ED
.4:									; a0 = A, if $2CE3 < 0 go to .5, call CODE_C3817D, ...
	sta.b a0
	ldx.w $2CE3
	bmi .5
	jsr.w CODE_C3817D
	ldx.w $2CE5
	bmi .5
	jsr.w CODE_C3817D
	ldx.w $2CE7
	bmi .5
	jsr.w CODE_C3817D
.5:									; pull A, a2 = A, pull A, $6D = A, ...
	pla
	sta.b a2
	pla
	sta.b $6D
	pla
	sta.b a1
	pla
	sta.b $69
	pla
	sta.b a0
	pla
	sta.b $65
	pla
	sta.b d0
	pla
	sta.b $81
	ply
	plx
	rtl
CODE_C3817D:						; from CODE_C380D1
	stx.b $65
	lda.w #$0000
	cpx.w #$001A
	bcc .1
	inc a
.1:									; call CODE_C56100, call CODE_C4C3AE, call CODE_C5625E, A = X, ...
	jsl.l CODE_C56100
	jsl.l CODE_C4C3AE
	jsl.l CODE_C5625E
	txa
	ldx.w #$007E
	ldy.b a0
	jsl.l QueueVRAMDMALen
	lda.b $65
	asl a
	asl a
	asl a
	asl a
	asl a
	cmp.w #$0340
	bcc .2
	adc.w #$2FDE
	bra .3
.2:									; A + $2EE1
	adc.w #$2EE1
.3:									; X = A, A = $000D, call CODE_C55F8A, call CODE_C5625E, ...
	tax
	lda.w #$000D
	jsl.l CODE_C55F8A
	jsl.l CODE_C5625E
	txa
	ldx.w #$007E
	ldy.b a0
	iny
	iny
	iny
	iny
	jsl.l QueueVRAMDMALen
	lda.b a0
	clc
	adc.w #$0020
	sta.b a0
	rts
CODE_C381D5:						; from CODE_C380D1
	ldx.w $2DC9
.loop:								; loop: X - 1, A = X, call CODE_C381F4, if X >= $2DCB go to .loop, ...
	dex
	txa
	jsr.w CODE_C381F4
	cpx.w $2DCB
	bcs .loop
	ldx.w $3207
.loop2:								; loop: X - 1, A = X, A + $001A, call CODE_C381F4, ...
	dex
	txa
	clc
	adc.w #$001A
	jsr.w CODE_C381F4
	cpx.w $3209
	bcs .loop2
	rts
CODE_C381F4:						; from CODE_C381D5
	tay
	lda.w $1413,y
	and.w #$00FF
	sta.b tmp0
	lda.w $1447,y
	and.w #$00FF
	sta.b tmp1
	clc
	adc.b tmp0
	sta.b tmp2
	lda.w $2CE3
	bmi .3
	clc
	lda.w $2CE9
	adc.w $2CEB
	cmp.b tmp2
	bcc .3
	bne .1
	lda.w $2CE9
	cmp.b tmp0
	bcc .3
.1:									; if $2CE5 < 0 go to .4, A = $2CED, A + $2CEF, if A < tmp2 go to .4, ...
	lda.w $2CE5
	bmi .4
	clc
	lda.w $2CED
	adc.w $2CEF
	cmp.b tmp2
	bcc .4
	bne .2
	lda.w $2CED
	cmp.b tmp0
	bcc .4
.2:									; if $2CE7 < 0 go to .5, A = $2CF1, A + $2CF3, if A < tmp2 go to .5, ...
	lda.w $2CE7
	bmi .5
	clc
	lda.w $2CF1
	adc.w $2CF3
	cmp.b tmp2
	bcc .5
	bne .rts
	lda.w $2CF1
	cmp.b tmp0
	bcc .5
.rts:								; return
	rts
.3:									; $2CE7 = $2CE5, $2CE5 = $2CE3, $2CF1 = $2CED, $2CED = $2CE9, ...
	lda.w $2CE5
	sta.w $2CE7
	lda.w $2CE3
	sta.w $2CE5
	lda.w $2CED
	sta.w $2CF1
	lda.w $2CE9
	sta.w $2CED
	lda.w $2CEF
	sta.w $2CF3
	lda.w $2CEB
	sta.w $2CEF
	sty.w $2CE3
	lda.b tmp0
	sta.w $2CE9
	lda.b tmp1
	sta.w $2CEB
	rts
.4:									; $2CE7 = $2CE5, $2CF1 = $2CED, $2CF3 = $2CEF, $2CE5 = Y, ...
	lda.w $2CE5
	sta.w $2CE7
	lda.w $2CED
	sta.w $2CF1
	lda.w $2CEF
	sta.w $2CF3
	sty.w $2CE5
	lda.b tmp0
	sta.w $2CED
	lda.b tmp1
	sta.w $2CEF
	rts
.5:									; $2CE7 = Y, $2CF1 = tmp0, $2CF3 = tmp1, return
	sty.w $2CE7
	lda.b tmp0
	sta.w $2CF1
	lda.b tmp1
	sta.w $2CF3
	rts
CODE_C382B6:						; called from other segments
	rtl
CODE_C382B7:						; called from other segments
	rtl
CODE_C382B8:						; called from other segments
	lda.b $48
	lsr a
	bcc .1
	jmp.w .8
.1:									; if $0862 = $0882 go to .2, tmp2 = $2100, tmp1 = $2018, $0882 = A, ...
	lda.w $0862
	cmp.w $0882
	beq .2
	ldx.w #$2100
	stx.b tmp2
	ldx.w #$2018
	stx.b tmp1
	sta.w $0882
	jsl.l CODE_C5F368
.2:									; if $0864 = $0884 go to .3, tmp2 = $2108, tmp1 = $201C, $0884 = A, ...
	lda.w $0864
	cmp.w $0884
	beq .3
	ldx.w #$2108
	stx.b tmp2
	ldx.w #$201C
	stx.b tmp1
	sta.w $0884
	jsl.l CODE_C5F368
.3:									; if $0866 = $0886 go to .4, tmp2 = $2120, tmp1 = $2020, $0886 = A, ...
	lda.w $0866
	cmp.w $0886
	beq .4
	ldx.w #$2120
	stx.b tmp2
	ldx.w #$2020
	stx.b tmp1
	sta.w $0886
	jsl.l CODE_C5F368
.4:									; if $0868 = $0888 go to .5, tmp2 = $2128, tmp1 = $2024, $0888 = A, ...
	lda.w $0868
	cmp.w $0888
	beq .5
	ldx.w #$2128
	stx.b tmp2
	ldx.w #$2024
	stx.b tmp1
	sta.w $0888
	jsl.l CODE_C5F368
.5:									; if $086A = $088A go to .6, tmp2 = $2140, tmp1 = $2028, $088A = A, ...
	lda.w $086A
	cmp.w $088A
	beq .6
	ldx.w #$2140
	stx.b tmp2
	ldx.w #$2028
	stx.b tmp1
	sta.w $088A
	jsl.l CODE_C5F368
.6:									; if $086C = $088C go to .7, tmp2 = $2148, tmp1 = $202C, $088C = A, ...
	lda.w $086C
	cmp.w $088C
	beq .7
	ldx.w #$2148
	stx.b tmp2
	ldx.w #$202C
	stx.b tmp1
	sta.w $088C
	jsl.l CODE_C5F368
.7:									; go to .14
	jmp.w .14
.8:									; if frame = $0876 go to .9, tmp2 = $20A0, tmp1 = $2000, $0876 = A, ...
	lda.w frame
	cmp.w $0876
	beq .9
	ldx.w #$20A0
	stx.b tmp2
	ldx.w #$2000
	stx.b tmp1
	sta.w $0876
	jsl.l CODE_C5F368
.9:									; if $0858 = $0878 go to .10, tmp2 = $20A8, tmp1 = $2004, $0878 = A, ...
	lda.w $0858
	cmp.w $0878
	beq .10
	ldx.w #$20A8
	stx.b tmp2
	ldx.w #$2004
	stx.b tmp1
	sta.w $0878
	jsl.l CODE_C5F368
.10:								; if $085A = $087A go to .11, tmp2 = $20C0, tmp1 = $2008, $087A = A, ...
	lda.w $085A
	cmp.w $087A
	beq .11
	ldx.w #$20C0
	stx.b tmp2
	ldx.w #$2008
	stx.b tmp1
	sta.w $087A
	jsl.l CODE_C5F368
.11:								; if $085C = $087C go to .12, tmp2 = $20C8, tmp1 = $200C, $087C = A, ...
	lda.w $085C
	cmp.w $087C
	beq .12
	ldx.w #$20C8
	stx.b tmp2
	ldx.w #$200C
	stx.b tmp1
	sta.w $087C
	jsl.l CODE_C5F368
.12:								; if $085E = $087E go to .13, tmp2 = $20E0, tmp1 = $2010, $087E = A, ...
	lda.w $085E
	cmp.w $087E
	beq .13
	ldx.w #$20E0
	stx.b tmp2
	ldx.w #$2010
	stx.b tmp1
	sta.w $087E
	jsl.l CODE_C5F368
.13:								; if $0860 = $0880 go to .14, tmp2 = $20E8, tmp1 = $2014, $0880 = A, ...
	lda.w $0860
	cmp.w $0880
	beq .14
	ldx.w #$20E8
	stx.b tmp2
	ldx.w #$2014
	stx.b tmp1
	sta.w $0880
	jsl.l CODE_C5F368
.14:								; if $0872 = $0892 go to .15, tmp1 = $2034, $0892 = A, call CODE_C5F368
	lda.w $0872
	cmp.w $0892
	beq .15
	ldx.w #$2034
	stx.b tmp1
	sta.w $0892
	jsl.l CODE_C5F368
.15:								; QueueBusy - 1, $1C = A, A = $28, Y = $2A, ...
	dec.b QueueBusy
	tsc
	sta.b $1C
	lda.b $28
	tcs
	ldy.b $2A
	lda.w #$EE1D
	sta.b $A5
	ldx.w #$000F
CODE_C38415:						; from CODE_C3846C
	lda.w OOlist,x
	stx.b $1A
	and.w #$00FF
	tax
	clc
	lda.w Xpos,x
	adc.w #$0080
	sec
	sbc.b $CB
	sta.b $0A
	sec
	lda.b $CD
	sbc.w Ypos,x
	clc
	adc.w #$005E
	sta.b $0C
	lda.w attribute,x
	and.w #$0800
	beq .1
	lda.l DATA8_C384BC,x
	sta.b tmp1
	lda.l DATA8_C384DC,x
	sta.b tmp2
	lda.w $0876,x
	bmi CODE_C3846C
	beq CODE_C3846C
	jml.l CODE_CFEE25
.1:									; tmp1 = DATA8_C3847C,x, tmp2 = DATA8_C3849C,x, ...
	lda.l DATA8_C3847C,x
	sta.b tmp1
	lda.l DATA8_C3849C,x
	sta.b tmp2
	lda.w $0876,x
	bmi CODE_C3846C
	beq CODE_C3846C
	jml.l CODE_CFEE6C
CODE_C3846C:						; from CODE_C38415 and other segments
	ldx.b $1A
	dex
	bpl CODE_C38415
	tsc
	sta.b $28
	lda.b $1C
	tcs
	sty.b $2A
	stz.b QueueBusy
	rtl
DATA8_C3847C:						; not traced: a table read by CODE_C38415
	db $00,$20,$04,$20,$08,$20,$0C,$20,$10,$20,$14,$20,$18,$22,$1C,$22
	db $20,$22,$24,$22,$28,$22,$2C,$22,$30,$20,$30,$20,$34,$20,$35,$20
DATA8_C3849C:						; not traced: a table read by CODE_C38415
	db $A0,$20,$A8,$20,$C0,$20,$C8,$20,$E0,$20,$E8,$20,$00,$23,$08,$23
	db $20,$23,$28,$23,$40,$23,$48,$23,$60,$21,$68,$21,$80,$21,$80,$35
DATA8_C384BC:						; not traced: a table read by CODE_C38415
	db $00,$60,$04,$60,$08,$60,$0C,$60,$10,$60,$14,$60,$18,$62,$1C,$62
	db $20,$62,$24,$62,$28,$62,$2C,$62,$30,$60,$30,$60,$34,$60,$35,$60
DATA8_C384DC:						; not traced: a table read by CODE_C38415
	db $A0,$60,$A8,$60,$C0,$60,$C8,$60,$E0,$60,$E8,$60,$00,$63,$08,$63
	db $20,$63,$28,$63,$40,$63,$48,$63,$60,$61,$68,$61,$80,$61,$80,$75
SprSort:							; from CODE_C3856E and other segments
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
.loop3:								; loop: A = $10E1,x, A and $00FF, d1 = A, A = OOlist,x, ...
	lda.w $10E1,x
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
	sta.b $89
	pla
	sta.b d2
	pla
	sta.b $85
	pla
	sta.b d1
	pla
	sta.b $81
	pla
	sta.b d0
	ply
	plx
	rtl
CODE_C3856E:						; called from other segments
	ldx.w #$0000
.loop:								; loop: Xpos,x = 0, X + 1, X + 1, if X is not $07CC go to .loop, ...
	stz.w Xpos,x
	inx
	inx
	cpx.w #$07CC
	bne .loop
	stz.b d6
	stz.b a1
	stz.b a2
	stz.b a3
	stz.b a4
.loop2:								; loop: X = a2, Y = a3, $0C20,y = d6, $0900,y = $FFFF, ...
	ldx.b a2
	ldy.b a3
	lda.b d6
	sta.w $0C20,y
	lda.w #$FFFF
	sta.w $0900,y
	sta.w $0876,y
	sta.w pnum,y
	lda.l DATA8_C38658,x
	sta.w Xpos,y
	lda.l DATA8_C3865A,x
	sta.w Ypos,y
	lda.l DATA8_C3865E,x
	sta.w frame,y
	lda.l DATA8_C38660,x
	sta.w attribute,y
	lda.l DATA8_C38662,x
	sta.w $0BA0,y
	lda.l DATA8_C38664,x
	sta.w $0BC0,y
	lda.b d6
	asl a
	asl a
	asl a
	tay
	lda.l DATA8_C38666,x
	sta.w $0A60,y
	ldy.b a3
	sta.w asscur,y
	lda.l DATA8_C38668,x
	sta.w pflags,y
	lda.w #$0000
	sta.w pfnc,y
	cpy.w #$001E
	bne .1
	lda.w #$0001
	sta.w pfnc,y
.1:									; A + 1, A and $0001, pfgoal,y = A, if X < $006C go to .2, ...
	cpx.w #$006C
	rol a
	inc a
	and.w #$0001
	sta.w pfgoal,y
	cpx.w #$006C
	bcc .2
	cpx.w #$00D8
	bcs .2
	lda.w #$0034
	sta.w pfteam,y
.2:									; a3 + 1, a3 + 1, A 8-bit, A = d6, ...
	inc.b a3
	inc.b a3
	sep #$20
	lda.b d6
	asl a
	ldy.b a1
	sta.w OOlist,y
	inc.b a1
	rep #$30
	ldy.b a4
	lda.b d6
	sta.w OOlistpos,y
	inc.b a4
	inc.b a4
	inc.b d6
	lda.b a2
	clc
	adc.w #$0012
	sta.b a2
	lda.b d6
	cmp.w #$0010
	beq .3
	jmp.w .loop2
.3:									; $0A38 = $FFFF, $0A3A = A, $088E = $086E, $0890 = $0870, ...
	lda.w #$FFFF
	sta.w $0A38
	sta.w $0A3A
	lda.w $086E
	sta.w $088E
	lda.w $0870
	sta.w $0890
	lda.w $0874
	sta.w $0894
	jmp.w SprSort
DATA8_C38658:						; not traced: a table read by CODE_C3856E
	db $60,$01
DATA8_C3865A:						; not traced: a table read by CODE_C3856E
	db $C0,$00,$00,$00
DATA8_C3865E:						; not traced: a table read by CODE_C3856E
	db $01,$00
DATA8_C38660:						; not traced: a table read by CODE_C3856E
	db $00,$00
DATA8_C38662:						; not traced: a table read by CODE_C3856E
	db $08,$00
DATA8_C38664:						; not traced: a table read by CODE_C3856E
	db $04,$00
DATA8_C38666:						; not traced: a table read by CODE_C3856E
	db $00,$00
DATA8_C38668:						; not traced: a table read by CODE_C3856E
	db $00,$00,$38,$FF,$9C,$FF,$00,$00,$01,$00,$00,$00,$08,$00,$04,$00
	db $00,$00,$00,$00,$38,$FF,$B0,$FF,$00,$00,$01,$00,$00,$00,$08,$00
	db $04,$00,$00,$00,$00,$00,$38,$FF,$C4,$FF,$00,$00,$01,$00,$00,$00
	db $08,$00,$04,$00,$00,$00,$00,$00,$38,$FF,$D8,$FF,$00,$00,$01,$00
	db $00,$00,$08,$00,$04,$00,$00,$00,$00,$00,$38,$FF,$EC,$FF,$00,$00
	db $01,$00,$00,$00,$08,$00,$04,$00,$00,$00,$00,$00,$C0,$00,$C0,$00
	db $00,$00,$01,$00,$01,$00,$08,$00,$04,$00,$00,$00,$00,$00,$38,$FF
	db $28,$00,$00,$00,$01,$00,$01,$00,$08,$00,$04,$00,$00,$00,$00,$00
	db $38,$FF,$3C,$00,$00,$00,$01,$00,$01,$00,$08,$00,$04,$00,$00,$00
	db $00,$00,$38,$FF,$50,$00,$00,$00,$01,$00,$01,$00,$08,$00,$04,$00
	db $00,$00,$00,$00,$38,$FF,$64,$00,$00,$00,$01,$00,$01,$00,$08,$00
	db $04,$00,$00,$00,$00,$00,$38,$FF,$78,$00,$00,$00,$01,$00,$01,$00
	db $08,$00,$04,$00,$00,$00,$00,$00,$00,$00,$17,$01,$00,$00,$BE,$01
	db $00,$00,$16,$00,$0A,$00,$00,$00,$00,$00,$00,$00,$E8,$FE,$00,$00
	db $BF,$01,$00,$00,$17,$00,$0A,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$B4,$01,$00,$00,$05,$00,$05,$00,$18,$00,$01,$00,$00,$00
	db $00,$00,$00,$00,$B3,$01,$00,$00,$03,$00,$03,$00,$19,$00,$00,$00
ApproxLength:						; called from other segments
	cmp.w #$0000
	bpl .1
	eor.w #$FFFF
	inc a
.1:									; tmp0 = A, A = Y, if the result >= 0 go to .2, A xor $FFFF, ...
	sta.b tmp0
	tya
	bpl .2
	eor.w #$FFFF
	inc a
.2:									; if A >= tmp0 go to .3, A / 2, A + tmp0, return
	cmp.b tmp0
	bcs .3
	lsr a
	clc
	adc.b tmp0
	rtl
.3:									; tmp0 / 2, A + tmp0, return
	lsr.b tmp0
	clc
	adc.b tmp0
	rtl
CODE_C38799:						; called from other segments
	ldx.w #$0000
.loop:								; loop: A = $0830, A - Xpos,x, d0 = A, if plus go to .1, ...
	sec
	lda.w $0830
	sbc.w Xpos,x
	sta.b d0
	bpl .1
	eor.w #$FFFF
	inc a
	sec
.1:									; r3 = A, A = pucky, A - Ypos,x, d1 = A, ...
	sta.b r3
	lda.w pucky
	sbc.w Ypos,x
	sta.b d1
	bpl .2
	eor.w #$FFFF
	inc a
.2:									; if A < r3 go to .3, r3 / 2, A * 2
	cmp.b r3
	bcc .3
	lsr.b r3
	asl a
.3:									; A / 2, A + r3, $05E4,x = A, call vtoa, ...
	lsr a
	adc.b r3
	sta.w $05E4,x
	jsl.l vtoa
	sta.w puckdir,x
	inx
	inx
	cpx.w #$0020
	bcc .loop
	rtl
CODE_C387D8:						; called from other segments
	lda.w #$0080
	sta.l VMAIN
	txa
	sta.l VMADDL
	jsl.l CODE_C387F2
	tay
	txa
	clc
	adc.w #$0020
	sta.l VMADDL
CODE_C387F2:						; from CODE_C387D8 and other segments
	tya
	ldy.w #$0008
.loop:								; loop: VMDATAL = A, A + 1, Y - 1, if the result >= 0 go to .loop, ...
	sta.l VMDATAL
	inc a
	dey
	bpl .loop
	rtl
CODE_C387FF:						; called from other segments
	lda.w #$01FE
	jsl.l CODE_C4C558
	sta.w $3648
	tay
	lda.w #$0210
	jsl.l CODE_C4C558
	lda.w #$01FD
	ldx.w #$1912
	mvn $7E,$7E
	lda.w #$020F
	ldx.w #$46A8
	mvn $7E,$7E
	rtl
CODE_C38824:						; called from other segments
	stx.w puckc
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	jsl.l CODE_C43734
	inx
	inx
	rtl
DATA8_C3884A:						; not traced: a table read by CODE_C44BF1, CODE_C44C5D, CODE_C44DC7
	db $00,$00,$01,$00,$04,$00,$09,$00,$10,$00,$19,$00,$24,$00,$31,$00
	db $40,$00,$51,$00,$64,$00,$79,$00,$90,$00,$A9,$00,$C4,$00,$E1,$00
	db $00,$01,$21,$01,$44,$01,$69,$01,$90,$01,$B9,$01,$E4,$01,$11,$02
	db $40,$02,$71,$02,$A4,$02,$D9,$02,$10,$03,$49,$03,$84,$03,$C1,$03
	db $00,$04,$41,$04,$84,$04,$C9,$04,$10,$05,$59,$05,$A4,$05,$F1,$05
	db $40,$06,$91,$06,$E4,$06,$39,$07,$90,$07,$E9,$07,$44,$08,$A1,$08
	db $00,$09,$61,$09,$C4,$09,$29,$0A,$90,$0A,$F9,$0A,$64,$0B,$D1,$0B
	db $40,$0C,$B1,$0C,$24,$0D,$99,$0D,$10,$0E,$89,$0E,$04,$0F,$81,$0F
	db $00,$10,$81,$10,$04,$11,$89,$11,$10,$12,$99,$12,$24,$13,$B1,$13
	db $40,$14,$D1,$14,$64,$15,$F9,$15,$90,$16,$29,$17,$C4,$17,$61,$18
	db $00,$19,$A1,$19,$44,$1A,$E9,$1A,$90,$1B,$39,$1C,$E4,$1C,$91,$1D
	db $40,$1E,$F1,$1E,$A4,$1F,$59,$20,$10,$21,$C9,$21,$84,$22,$41,$23
	db $00,$24,$C1,$24,$84,$25,$49,$26,$10,$27,$D9,$27,$A4,$28,$71,$29
	db $40,$2A,$11,$2B,$E4,$2B,$B9,$2C,$90,$2D,$69,$2E,$44,$2F,$21,$30
	db $00,$31,$E1,$31,$C4,$32,$A9,$33,$90,$34,$79,$35,$64,$36,$51,$37
	db $40,$38,$31,$39,$24,$3A,$19,$3B,$10,$3C,$09,$3D,$04,$3E,$01,$3F
	db $00,$40,$01,$41,$04,$42,$09,$43,$10,$44,$19,$45,$24,$46,$31,$47
	db $40,$48,$51,$49,$64,$4A,$79,$4B,$90,$4C,$A9,$4D,$C4,$4E,$E1,$4F
	db $00,$51,$21,$52,$44,$53,$69,$54,$90,$55,$B9,$56,$E4,$57,$11,$59
	db $40,$5A,$71,$5B,$A4,$5C,$D9,$5D,$10,$5F,$49,$60,$84,$61,$C1,$62
	db $00,$64,$41,$65,$84,$66,$C9,$67,$10,$69,$59,$6A,$A4,$6B,$F1,$6C
	db $40,$6E,$91,$6F,$E4,$70,$39,$72,$90,$73,$E9,$74,$44,$76,$A1,$77
	db $00,$79,$61,$7A,$C4,$7B,$29,$7D,$90,$7E,$F9,$7F,$64,$81,$D1,$82
	db $40,$84,$B1,$85,$24,$87,$99,$88,$10,$8A,$89,$8B,$04,$8D,$81,$8E
	db $00,$90,$81,$91,$04,$93,$89,$94,$10,$96,$99,$97,$24,$99,$B1,$9A
	db $40,$9C,$D1,$9D,$64,$9F,$F9,$A0,$90,$A2,$29,$A4,$C4,$A5,$61,$A7
	db $00,$A9,$A1,$AA,$44,$AC,$E9,$AD,$90,$AF,$39,$B1,$E4,$B2,$91,$B4
	db $40,$B6,$F1,$B7,$A4,$B9,$59,$BB,$10,$BD,$C9,$BE,$84,$C0,$41,$C2
	db $00,$C4,$C1,$C5,$84,$C7,$49,$C9,$10,$CB,$D9,$CC,$A4,$CE,$71,$D0
	db $40,$D2,$11,$D4,$E4,$D5,$B9,$D7,$90,$D9,$69,$DB,$44,$DD,$21,$DF
	db $00,$E1,$E1,$E2,$C4,$E4,$A9,$E6,$90,$E8,$79,$EA,$64,$EC,$51,$EE
	db $40,$F0,$31,$F2,$24,$F4,$19,$F6,$10,$F8,$09,$FA,$04,$FC,$01,$FE
DATA8_C38A4A:						; not traced: a table read by CODE_C37684, CODE_C45BD2, CODE_C45E1C, ...
	db $00,$00,$01,$00,$04,$00,$09,$00,$10,$00,$19,$00,$24,$00,$31,$00
	db $40,$00,$51,$00,$64,$00,$79,$00,$90,$00,$A9,$00,$C4,$00,$E1,$00
	db $00,$01,$21,$01,$44,$01,$69,$01,$90,$01,$B9,$01,$E4,$01,$11,$02
	db $40,$02,$71,$02,$A4,$02,$D9,$02,$10,$03,$49,$03,$84,$03,$C1,$03
	db $00,$04,$41,$04,$84,$04,$C9,$04,$10,$05,$59,$05,$A4,$05,$F1,$05
	db $40,$06,$91,$06,$E4,$06,$39,$07,$90,$07,$E9,$07,$44,$08,$A1,$08
	db $00,$09,$61,$09,$C4,$09,$29,$0A,$90,$0A,$F9,$0A,$64,$0B,$D1,$0B
	db $40,$0C,$B1,$0C,$24,$0D,$99,$0D,$10,$0E,$89,$0E,$04,$0F,$81,$0F
	db $00,$10,$81,$10,$04,$11,$89,$11,$10,$12,$99,$12,$24,$13,$B1,$13
	db $40,$14,$D1,$14,$64,$15,$F9,$15,$90,$16,$29,$17,$C4,$17,$61,$18
	db $00,$19,$A1,$19,$44,$1A,$E9,$1A,$90,$1B,$39,$1C,$E4,$1C,$91,$1D
	db $40,$1E,$F1,$1E,$A4,$1F,$59,$20,$10,$21,$C9,$21,$84,$22,$41,$23
	db $00,$24,$C1,$24,$84,$25,$49,$26,$10,$27,$D9,$27,$A4,$28,$71,$29
	db $40,$2A,$11,$2B,$E4,$2B,$B9,$2C,$90,$2D,$69,$2E,$44,$2F,$21,$30
	db $00,$31,$E1,$31,$C4,$32,$A9,$33,$90,$34,$79,$35,$64,$36,$51,$37
	db $40,$38,$31,$39,$24,$3A,$19,$3B,$10,$3C,$09,$3D,$04,$3E,$01,$3F
	db $00,$40,$01,$3F,$04,$3E,$09,$3D,$10,$3C,$19,$3B,$24,$3A,$31,$39
	db $40,$38,$51,$37,$64,$36,$79,$35,$90,$34,$A9,$33,$C4,$32,$E1,$31
	db $00,$31,$21,$30,$44,$2F,$69,$2E,$90,$2D,$B9,$2C,$E4,$2B,$11,$2B
	db $40,$2A,$71,$29,$A4,$28,$D9,$27,$10,$27,$49,$26,$84,$25,$C1,$24
	db $00,$24,$41,$23,$84,$22,$C9,$21,$10,$21,$59,$20,$A4,$1F,$F1,$1E
	db $40,$1E,$91,$1D,$E4,$1C,$39,$1C,$90,$1B,$E9,$1A,$44,$1A,$A1,$19
	db $00,$19,$61,$18,$C4,$17,$29,$17,$90,$16,$F9,$15,$64,$15,$D1,$14
	db $40,$14,$B1,$13,$24,$13,$99,$12,$10,$12,$89,$11,$04,$11,$81,$10
	db $00,$10,$81,$0F,$04,$0F,$89,$0E,$10,$0E,$99,$0D,$24,$0D,$B1,$0C
	db $40,$0C,$D1,$0B,$64,$0B,$F9,$0A,$90,$0A,$29,$0A,$C4,$09,$61,$09
	db $00,$09,$A1,$08,$44,$08,$E9,$07,$90,$07,$39,$07,$E4,$06,$91,$06
	db $40,$06,$F1,$05,$A4,$05,$59,$05,$10,$05,$C9,$04,$84,$04,$41,$04
	db $00,$04,$C1,$03,$84,$03,$49,$03,$10,$03,$D9,$02,$A4,$02,$71,$02
	db $40,$02,$11,$02,$E4,$01,$B9,$01,$90,$01,$69,$01,$44,$01,$21,$01
	db $00,$01,$E1,$00,$C4,$00,$A9,$00,$90,$00,$79,$00,$64,$00,$51,$00
	db $40,$00,$31,$00,$24,$00,$19,$00,$10,$00,$09,$00,$04,$00,$01,$00
CODE_C38C4A:						; called from other segments
	lda.w RefCnt
	bmi .rtl
	sec
	sbc.b d7
	sta.w RefCnt
	bpl .1
	jsl.l CODE_C38C95
.1:									; A = $1143, A - d7, $1143 = A, if plus go to .rtl, ...
	lda.w $1143
	sec
	sbc.b d7
	sta.w $1143
	bpl .rtl
	lda.w #$7FFF
	sta.w $1143
.rtl:								; return
	rtl
CODE_C38C6D:						; called from other segments
	lda.b d0
	sta.w $1149
	stz.w $1147
	jsl.l CODE_C481D5
	lda.b d0
	cmp.w #$000E
	bne .1
	jsl.l CODE_C51825
.1:									; $1143 = $7FFF, if $2CF5 = 0 go to CODE_C38C95, $1143 = $003C
	lda.w #$7FFF
	sta.w $1143
	lda.w $2CF5
	beq CODE_C38C95
	lda.w #$003C
	sta.w $1143
CODE_C38C95:						; from CODE_C38C4A, CODE_C38C6D and other segments
	phx
	lda.w $1147
	bpl .2
	lda.w $189C
	beq .1
	lda.w #$0001
	sta.w $189E
.1:									; A = $1147, pull X, return
	lda.w $1147
	plx
	rtl
.2:									; tmp0 = A, A + 1, A + 1, $1147 = A, ...
	sta.b tmp0
	inc a
	inc a
	sta.w $1147
	ldx.w $1149
	beq .4
	lda.l DATA8_C34499,x
	tax
	lda.l DATA8_C3449B,x
	and.w #$00FF
	sec
	adc.b tmp0
	stx.b tmp0
	sec
	adc.b tmp0
	tax
	lda.l DATA8_C3449A,x
	bpl .3
	eor.w #$FFFF
	inc a
	ldx.w #$FFFF
	stx.w $1147
.3:									; tmp0 = A, A and $00FF, A * 2, A * 2, ...
	sta.b tmp0
	and.w #$00FF
	asl a
	asl a
	asl a
	sta.w RefCnt
	lda.b tmp0
	xba
	and.w #$00FF
	sta.b tmp0
	jsl.l CODE_C38CFC
.4:									; pull X, return
	plx
	rtl
CODE_C38CF5:						; called from other segments
	lda.w #$0200
	trb.w sflags
	rtl
CODE_C38CFC:						; from CODE_C38C95 and other segments
	lda.b tmp0
	cmp.w #$0040
	beq .2
	cmp.w #$0014
	beq .1
	lda.w #$0001
	sta.w $2348
.1:									; A = tmp0, A * 2, X = A, A = DATA8_C38D43,x, ...
	lda.b tmp0
	asl a
	tax
	lda.l DATA8_C38D43,x
	tax
	ldy.w #$5842
	jsr.w CODE_C38DAD
	lda.w #$0200
	tsb.w sflags
	rtl
.2:									; if $234A = 0 go to .3, call CODE_C38D6D
	lda.w $234A
	beq .3
	jsl.l CODE_C38D6D
.3:									; TransfersReady + 1, X = $001C, Y = $5842, call CODE_C38DAD, ...
	inc.w TransfersReady
	ldx.w #$001C
	ldy.w #$5842
	jsr.w CODE_C38DAD
	lda.w #$0200
	tsb.w sflags
	stz.w $2348
	rtl
DATA8_C38D43:						; not traced: a table read by CODE_C38CFC
	db $00,$00,$0E,$00,$1C,$00,$2A,$00,$38,$00,$46,$00,$54,$00,$10,$03
	db $1E,$03,$2C,$03,$3A,$03,$48,$03,$56,$03,$64,$03,$20,$06,$2E,$06
	db $3C,$06,$4A,$06,$58,$06,$66,$06,$74,$06
CODE_C38D6D:						; from CODE_C38CFC and other segments
	lda.l DATA8_C58942
	sta.w $364E
	lda.w #$003D
	ldx.w #$364E
	ldy.w #$3650
	mvn $7E,$7E
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	clc
	lda.w $1541
	adc.w #$0002
	tay
	ldx.w #$0002
	lda.w #$5940
.loop:								; loop: push Y, push A, A + $0020, X - 1, ...
	phy
	pha
	adc.w #$0020
	pea.w $007E
	pea.w $364E
	dex
	bpl .loop
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rtl
CODE_C38DAD:						; from CODE_C38CFC
	phd
	pea.w $7E7F
	plb
	lda.w #$2100
	tcd
	lda.w #$0080
	wai
	sta.b $15
	tya
	clc
	sta.b $16
	ldy.w $C6FA,x
	sty.b $18
	ldy.w $C6FC,x
	sty.b $18
	ldy.w $C6FE,x
	sty.b $18
	ldy.w $C700,x
	sty.b $18
	ldy.w $C702,x
	sty.b $18
	ldy.w $C704,x
	sty.b $18
	ldy.w $C706,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C75C,x
	sty.b $18
	ldy.w $C75E,x
	sty.b $18
	ldy.w $C760,x
	sty.b $18
	ldy.w $C762,x
	sty.b $18
	ldy.w $C764,x
	sty.b $18
	ldy.w $C766,x
	sty.b $18
	ldy.w $C768,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C7BE,x
	sty.b $18
	ldy.w $C7C0,x
	sty.b $18
	ldy.w $C7C2,x
	sty.b $18
	ldy.w $C7C4,x
	sty.b $18
	ldy.w $C7C6,x
	sty.b $18
	ldy.w $C7C8,x
	sty.b $18
	ldy.w $C7CA,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C820,x
	sty.b $18
	ldy.w $C822,x
	sty.b $18
	ldy.w $C824,x
	sty.b $18
	ldy.w $C826,x
	sty.b $18
	ldy.w $C828,x
	sty.b $18
	ldy.w $C82A,x
	sty.b $18
	ldy.w $C82C,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C882,x
	sty.b $18
	ldy.w $C884,x
	sty.b $18
	ldy.w $C886,x
	sty.b $18
	ldy.w $C888,x
	sty.b $18
	ldy.w $C88A,x
	sty.b $18
	ldy.w $C88C,x
	sty.b $18
	ldy.w $C88E,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C8E4,x
	sty.b $18
	ldy.w $C8E6,x
	sty.b $18
	ldy.w $C8E8,x
	sty.b $18
	ldy.w $C8EA,x
	sty.b $18
	ldy.w $C8EC,x
	sty.b $18
	ldy.w $C8EE,x
	sty.b $18
	ldy.w $C8F0,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C946,x
	sty.b $18
	ldy.w $C948,x
	sty.b $18
	ldy.w $C94A,x
	sty.b $18
	ldy.w $C94C,x
	sty.b $18
	ldy.w $C94E,x
	sty.b $18
	ldy.w $C950,x
	sty.b $18
	ldy.w $C952,x
	sty.b $18
	adc.w #$0020
	sta.b $16
	ldy.w $C9A8,x
	sty.b $18
	ldy.w $C9AA,x
	sty.b $18
	ldy.w $C9AC,x
	sty.b $18
	ldy.w $C9AE,x
	sty.b $18
	ldy.w $C9B0,x
	sty.b $18
	ldy.w $C9B2,x
	sty.b $18
	ldy.w $C9B4,x
	sty.b $18
	plb
	pld
	rts

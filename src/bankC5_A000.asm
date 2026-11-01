; Segment bankC5_A000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), two jump tables and the data tables the code reads with long addresses.
org $C59F79
CODE_C59F79:						; called from other segments
	stz.w $04F5
	stz.w $04F7
	stz.w $04F9
	stz.w $04FB
	lda.b d0
	bne .1
	lda.w #$0010
	sta.w $24DC
	lda.w $0527
	jsr.w CODE_C5A083
	tsb.w $04F7
	lda.w $0529
	jsr.w CODE_C5A07A
	tsb.w $04F6
	lda.w $052B
	jsr.w CODE_C5A083
	tsb.w $04F8
	lda.w $052D
	jsr.w CODE_C5A07A
	tsb.w $04F8
	lda.w $052F
	jsr.w CODE_C5A07A
	tsb.w $04FB
	lda.w $0531
	jsr.w CODE_C5A083
	tsb.w $04FB
	lda.w $0533
	jsr.w CODE_C5A07A
	tsb.w $04FC
	lda.w $0535
	jsr.w CODE_C5A083
	tsb.w $04FC
	jmp.w .2
.1:									; $24DC = 0, A = $0527, call CODE_C5A083, A = $0529, ...
	stz.w $24DC
	lda.w $0527
	jsr.w CODE_C5A083
	tsb.w $04F7
	lda.w $0529
	jsr.w CODE_C5A07A
	tsb.w $04F6
	lda.w $052B
	jsr.w CODE_C5A083
	tsb.w $04FB
	lda.w $052D
	jsr.w CODE_C5A07A
	tsb.w $04F7
	lda.w $052F
	jsr.w CODE_C5A083
	tsb.w $04F8
	lda.w $0531
	jsr.w CODE_C5A083
	tsb.w $04FA
	lda.w $0533
	jsr.w CODE_C5A07A
	tsb.w $04F8
	lda.w $0535
	jsr.w CODE_C5A07A
	tsb.w $04FA
	lda.w $0537
	jsr.w CODE_C5A083
	tsb.w $04FC
	lda.w $0539
	jsr.w CODE_C5A07A
	tsb.w $04FC
	lda.w $053B
	jsr.w CODE_C5A083
	tsb.w $04F9
.2:									; call CODE_C5C6B7, call BinToBCD, call BCDText, Y = $0015, ...
	jsr.w CODE_C5C6B7
	jsr.w BinToBCD
	jsr.w BCDText
	ldy.w #$0015
	jsr.w CODE_C5A05A
	lda.b d2
	jsr.w BinToBCD
	jsr.w BCDText
	ldy.w #$0016
CODE_C5A05A:						; from CODE_C59F79
	lda.w $04F9
	sta.w $04FB
	lda.w $04F7
	sta.w $04F9
	lda.w $04F5
	sta.w $04F7
	lda.w #$2020
	sta.w $04F5
	ldx.w #$04F6
	jsl.l PrintBoldRightStr
	rts
CODE_C5A07A:						; from CODE_C59F79, CODE_C5A083 and other segments
	tax
	lda.l DATA8_C5A08B,x
	and.w #$00FF
	rts
CODE_C5A083:						; from CODE_C59F79
	jsr.w CODE_C5A07A
	asl a
	asl a
	asl a
	asl a
	rts
DATA8_C5A08B:						; not traced: a table read by CODE_C5A07A
	db $00,$00,$01,$01,$02,$02,$03,$03,$03,$03,$04,$04,$04,$05,$05,$06
DrawNameEntry:						; draws the Create Player page: First Name, Last Name, the letter grid and
									; its keys; the screen state goes to 0 (NameEntry)
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l QueueClearVRAM
	lda.w #$FFFF
	sta.w BG3VScroll
	ldy.w #$5C00
	jsl.l ClearVRAM
	ldx.b d7
	jsl.l DeleteSprite
	ldx.b $9D
	jsl.l DeleteSprite
	ldx.b a4
	jsl.l DeleteSprite
	ldx.b $75
	jsl.l DeleteSprite
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$5714
	jsl.l PrintTextPage
	sec
	lda.b $CF
	sbc.w #$0008
	sta.b $CF
	lda.w #$2C00
	sta.b $D5
	lda.w #$001A
	ldy.w #$000C
	ldx.w #$490D
	jsl.l CODE_C4BC2C
	lda.w #$001A
	ldy.w #$000F
	ldx.w #$4914
	jsl.l CODE_C4BC2C
	lda.w #$001A
	ldy.w #$0012
	ldx.w #$491B
	jsl.l CODE_C4BC2C
	lda.w #$2000
	sta.b $D5
	lda.w #$3E3E
	sta.w $04F5
	sta.w $04F7
	sta.w $04F9
	sta.w $04FB
	sta.w $04FD
	stz.w $04FF
	lda.w #$0078
	sta.b $CF
	lda.w #$000F
	ldy.w #$0008
	ldx.w #$04F5
	jsl.l CODE_C4BC46
	stz.w $04FD
	lda.w #$000F
	ldy.w #$0006
	ldx.w #$04F5
	jsl.l CODE_C4BC46
	jsl.l SendTextMap
	lda.w #$0006
	sta.b $71
	lda.w #$0008
	sta.b $69
	stz.b $99
	stz.b a3
	stz.b d6
	jsr.w CODE_C5A20D
	rts
CODE_C5A164:						; called from other segments
	lda.w #$006A
	ldx.b a0
	sta.b $05,x
	lda.b d6
	beq .1
	lda.w #$009F
	sta.b $08,x
	rts
.1:									; $08,x = $0087, return
	lda.w #$0087
	sta.b $08,x
	rts
CODE_C5A17B:						; called from other segments
	lda.b d6
	asl a
	tax
	lda.b $D3
	adc.l DATA8_C5A1D7,x
	tay
	jsr.w CODE_C5A198
	iny
	iny
	jsr.w CODE_C5A198
	tya
	adc.w #$003E
	tay
	jsr.w CODE_C5A198
	iny
	iny
CODE_C5A198:						; from CODE_C5A17B
	lda.w $0000,y
	and.w #$E3FF
	ora.w #$0C00
	sta.w $0000,y
	rts
CODE_C5A1A5:						; from CODE_C5A20D
	lda.b d6
	asl a
	tax
	lda.b $D3
	adc.l DATA8_C5A1D7,x
	tay
	jsr.w CODE_C5A1CA
	iny
	iny
	jsr.w CODE_C5A1CA
	tya
	adc.w #$003E
	tay
	jsr.w CODE_C5A1CA
	iny
	iny
	jsr.w CODE_C5A1CA
	jsl.l SendTextMap
	rts
CODE_C5A1CA:						; from CODE_C5A1A5
	lda.w $0000,y
	and.w #$E3FF
	ora.w #$0000
	sta.w $0000,y
	rts
DATA8_C5A1D7:						; not traced: a table read by CODE_C5A17B, CODE_C5A1A5
	db $06,$03,$0C,$03,$12,$03,$18,$03,$1E,$03,$24,$03,$2A,$03,$30,$03
	db $36,$03,$C6,$03,$CC,$03,$D2,$03,$D8,$03,$DE,$03,$E4,$03,$EA,$03
	db $F0,$03,$F6,$03,$86,$04,$8C,$04,$92,$04,$98,$04,$9E,$04,$A4,$04
	db $AA,$04,$B0,$04,$B6,$04
CODE_C5A20D:						; from DrawNameEntry and other segments
	jsr.w CODE_C5A1A5
	ldy.b a0
	lda.b d6
	asl a
	tax
	lda.l DATA8_C5A25B,x
	sta.w $0008,y
	lda.l DATA8_C5A225,x
	sta.w $0005,y
	rts
DATA8_C5A225:						; not traced: a table read by CODE_C5A20D
	db $14,$00,$2C,$00,$44,$00,$5C,$00,$74,$00,$8C,$00,$A4,$00,$BC,$00
	db $D4,$00,$14,$00,$2C,$00,$44,$00,$5C,$00,$74,$00,$8C,$00,$A4,$00
	db $BC,$00,$D4,$00,$14,$00,$2C,$00,$44,$00,$5C,$00,$74,$00,$8C,$00
	db $A4,$00,$BC,$00,$D4,$00
DATA8_C5A25B:						; not traced: a table read by CODE_C5A20D
	db $70,$00,$70,$00,$70,$00,$70,$00,$70,$00,$70,$00,$70,$00,$70,$00
	db $70,$00,$88,$00,$88,$00,$88,$00,$88,$00,$88,$00,$88,$00,$88,$00
	db $88,$00,$88,$00,$A0,$00,$A0,$00,$A0,$00,$A0,$00,$A0,$00,$A0,$00
	db $A0,$00,$A0,$00,$A0,$00
CODE_C5A291:						; called from other segments
	lda.w #$0008
	jsr.w CODE_C5A304
	lda.b d0
	asl a
	tax
	lda.l DATA8_C5A2A8,x
	tax
	ldy.w #$0008
	jsl.l PrintItalicLeft
	rts
DATA8_C5A2A8:						; not traced: a table read by CODE_C5A291
	db $B8,$49,$BD,$49,$C7,$49,$D7,$49,$D2,$49,$E0,$49
CODE_C5A2B4:						; called from other segments
	lda.w #$000B
	jsr.w CODE_C5A304
	lda.b $81
	asl a
	asl a
	asl a
	adc.w #$008C
	jsr.w BinToBCD
	jsr.w CODE_C5A321
	ldx.w #$04F6
	ldy.w #$000B
	jsl.l PrintItalicLeftStr
	rts
CODE_C5A2D3:						; called from other segments
	lda.w #$000E
	jsr.w CODE_C5A304
	lda.b d1
	jsr.w BinToBCD
	jsr.w CODE_C5A321
	ldx.w #$04F7
	ldy.w #$000E
	jsl.l PrintItalicLeftStr
	rts
CODE_C5A2EC:						; called from other segments
	lda.w #$0011
	jsr.w CODE_C5A304
	ldx.w #$49ED
	lda.b $85
	beq .1
	ldx.w #$49E9
.1:									; Y = $0011, call PrintItalicLeft, return
	ldy.w #$0011
	jsl.l PrintItalicLeft
	rts
CODE_C5A304:						; from CODE_C5A291, CODE_C5A2B4, CODE_C5A2D3, CODE_C5A2EC
	xba
	lsr a
	lsr a
	adc.b $D3
	adc.w #$0020
	pha
	ldy.w #$0020
	jsl.l ClearRAM7E
	pla
	clc
	adc.w #$0040
	ldy.w #$0020
	jsl.l ClearRAM7E
	rts
CODE_C5A321:						; from CODE_C5A2B4, CODE_C5A2D3
	tax
	xba
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w $04F5
	txa
	xba
	and.w #$000F
	adc.w #$0030
	sta.w $04F6
	txa
	and.w #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0030
	sta.w $04F7
	txa
	and.w #$000F
	adc.w #$0030
	sta.w $04F8
	rts
DATA8_C5A354:						; a pointer to CODE_C5A359 (its reader is not traced)
	dw CODE_C5A359
CODE_C5A356:						; after the pointer word DATA8_C5A354; no caller found (not traced)
	jmp.w CODE_C5A3C1
CODE_C5A359:						; DATA8_C5A354 points here; no caller found (not traced)
	lda.w $17CB
	cmp.w #$001A
	bcc .3
	beq .1
	lda.w #$0019
	bra .2
.1:									; A = $0000
	lda.w #$0000
.2:									; $17CB = A
	sta.w $17CB
.3:									; if A is not $17C9 go to CODE_C5A397, A = $058D, ...
	cmp.w $17C9
	bne CODE_C5A397
	lda.w $058D
	bit.w #$0200
	beq .5
	lda.w $17CB
	dec a
	bpl .4
	lda.w #$0019
.4:									; $17CB = A, go to CODE_C5A397
	sta.w $17CB
	bra CODE_C5A397
.5:									; A = $17CB, A + 1, if A < $001A go to .4, A = $0000, ...
	lda.w $17CB
	inc a
	cmp.w #$001A
	bcc .4
	lda.w #$0000
	bra .4
CODE_C5A397:						; from CODE_C5A359
	lda.w $1872
	bne .1
	lda.w $1864
	beq .rts
	dec a
	beq .rts
.1:									; if $17CB is not $001A go to .3, A = $0000
	lda.w $17CB
	cmp.w #$001A
	bne .3
	lda.w #$0000
.2:									; $17CB = A, go to .rts
	sta.w $17CB
	bra .rts
.3:									; if A is not $001B go to .rts, A = $0019, go to .2
	cmp.w #$001B
	bne .rts
	lda.w #$0019
	bra .2
.rts:								; return
	rts
DATA8_C5A3BF:						; a pointer to CODE_C5A397 (its reader is not traced)
	dw CODE_C5A397
CODE_C5A3C1:						; from CODE_C5A356 and other segments
	lda.w $17CB
	sta.l $306043
	jsl.l WaitTransfers
	pei ($CF)
	pei ($D1)
	lda.w #$0340
	jsr.w CODE_C5A3E6
	lda.w #$0020
	sta.b $CF
	lda.w #$0068
	sta.b $D1
	lda.w $17CB
	jmp.w CODE_C5A48C
CODE_C5A3E6:						; from CODE_C5A3C1, CODE_C5A46A
	clc
	adc.b $D3
	ldy.w #$0020
	pha
	phy
	jsl.l ClearRAM7E
	ply
	pla
	clc
	adc.w #$0040
	jsl.l ClearRAM7E
	rts
DATA8_C5A3FD:						; a pointer to CODE_C5A402 (its reader is not traced)
	dw CODE_C5A402
CODE_C5A3FF:						; after the pointer word DATA8_C5A3FD; no caller found (not traced)
	jmp.w CODE_C5A46A
CODE_C5A402:						; DATA8_C5A3FD points here; no caller found (not traced)
	lda.w $17C9
	cmp.w #$001A
	bcc .3
	beq .1
	lda.w #$0019
	bra .2
.1:									; A = $0000
	lda.w #$0000
.2:									; $17C9 = A
	sta.w $17C9
.3:									; if A is not $17CB go to CODE_C5A440, A = $058D, ...
	cmp.w $17CB
	bne CODE_C5A440
	lda.w $058D
	bit.w #$0200
	beq .5
	lda.w $17C9
	dec a
	bpl .4
	lda.w #$0019
.4:									; $17C9 = A, go to CODE_C5A440
	sta.w $17C9
	bra CODE_C5A440
.5:									; A = $17C9, A + 1, if A < $001A go to .4, A = $0000, ...
	lda.w $17C9
	inc a
	cmp.w #$001A
	bcc .4
	lda.w #$0000
	bra .4
CODE_C5A440:						; from CODE_C5A402
	lda.w $1872
	bne .1
	lda.w $1864
	beq .rts
	dec a
	beq .rts
.1:									; if $17C9 is not $001A go to .3, A = $0000
	lda.w $17C9
	cmp.w #$001A
	bne .3
	lda.w #$0000
.2:									; $17C9 = A, go to .rts
	sta.w $17C9
	bra .rts
.3:									; if A is not $001B go to .rts, A = $0019, go to .2
	cmp.w #$001B
	bne .rts
	lda.w #$0019
	bra .2
.rts:								; return
	rts
DATA8_C5A468:						; a pointer to CODE_C5A440 (its reader is not traced)
	dw CODE_C5A440
CODE_C5A46A:						; from CODE_C5A3FF and other segments
	lda.w $17C9
	sta.l $306041
	jsl.l WaitTransfers
	pei ($CF)
	pei ($D1)
	lda.w #$0360
	jsr.w CODE_C5A3E6
	lda.w #$00A0
	sta.b $CF
	lda.w #$00E8
	sta.b $D1
	lda.w $17C9
CODE_C5A48C:						; from CODE_C5A3C1
	ldy.w #$000D
CODE_C5A48F:						; from CODE_C5A4A5
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	jsl.l PrintThinCentred
	jsl.l SendTextMap
	pla
	sta.b $D1
	pla
	sta.b $CF
	rts
CODE_C5A4A5:						; called from other segments
	pei ($CF)
	pei ($D1)
	ldx.w #$0020
	stx.b $CF
	ldx.w #$0068
	stx.b $D1
	bra CODE_C5A48F
CODE_C5A4B5:						; called from other segments
	jsr.w CODE_C5A4B9
	rtl
CODE_C5A4B9:						; from CODE_C5A4B5 and other segments
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	pea.w $0020
	pea.w $007F
	lda.w $17C9
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$D80A
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	rts
CODE_C5A4DE:						; called from other segments
	jsr.w CODE_C5A4E2
	rtl
CODE_C5A4E2:						; from CODE_C5A4DE and other segments
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	pea.w $0030
	pea.w $007F
	lda.w $17CB
	xba
	lsr a
	lsr a
	lsr a
	adc.w #$D80A
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	rts
CODE_C5A507:						; called from other segments
	jsr.w CODE_C5A50B
	rtl
CODE_C5A50B:						; from CODE_C5A507, SeasonOptions and other segments
	ldx.b a4
	jsl.l DeleteSprite
	stz.b a4
	ldx.b $75
	jsl.l DeleteSprite
	stz.b $75
	rts
SeasonOptions:						; the League Menu (season mode): draws its page (Play Games, NHL
									; Standings, Games Today, League Leaders, Team Stats, Player Stats) and
									; makes CODE_C5AC07 the screen's handler
	lda.w #$8000
	sta.w DMAEnShadow
	ldy.w #$5000
	jsl.l QueueClearVRAM
	ldy.w #$5C00
	jsl.l QueueClearVRAM
	lda.w #$FFFF
	sta.w BG3VScroll
	jsl.l WaitTransfers
	lda.w #$0002
	sta.w $1864
	lda.l $306050
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C35F60,x
	bne .1
	jsl.l CODE_C40D96
	inc.w $1864
.1:									; X = d7, call DeleteSprite, X = $9D, call DeleteSprite, ...
	ldx.b d7
	jsl.l DeleteSprite
	ldx.b $9D
	jsl.l DeleteSprite
	jsr.w CODE_C5A50B
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$56A4
	jsl.l PrintTextPage
	clc
	lda.b $D3
	adc.w #$0240
	tax
	ldy.w #$01DF
.loop:								; loop: A = $0000,x, A and $E3FF, A or $0C00, $0000,x = A, ...
	lda.w $0000,x
	and.w #$E3FF
	ora.w #$0C00
	sta.w $0000,x
	inx
	inx
	dey
	bpl .loop
	stz.b d6
	lda.w #$0006
	sta.b $99
	stz.w fadestep
CODE_C5A599:						; from CODE_C5AC07
	ldx.b a0
	lda.w #$0030
	sta.b $05,x
	lda.b d6
	asl a
	asl a
	asl a
	sta.b tmp0
	asl a
	adc.b tmp0
	adc.w #$003E
	sta.b $08,x
	rts
CODE_C5A5B0:						; called from other segments
	jsr.w CODE_C55BE8
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$0013
	sta.w repeatdelayframes
.1:									; A = $058D, if a $3000 bit set go to .4, ...
	lda.w $058D
	bit.w #$3000
	bne .4
	bit.w #$0800
	beq .2
	jmp.w CODE_C55CE6
.2:									; if $0400 bits clear go to .3, go to CODE_C55C58
	bit.w #$0400
	beq .3
	jmp.w CODE_C55C58
.3:									; if a $0200 bit set go to .5, if a $0100 bit set go to .6, ...
	bit.w #$0200
	bne .5
	bit.w #$0100
	bne .6
	bit.w #$8000
	bne .8
.rts:								; return
	rts
.4:									; call FadeOutWait, X = $77, call DeleteSprite, X = $79, ...
	jsl.l FadeOutWait
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	jmp.w SeasonOptions
.5:									; A = d1, A - 1, if the result >= 0 go to .7, A = $0002, ...
	lda.b d1
	dec a
	bpl .7
	lda.w #$0002
	bra .7
.6:									; A = d1, A + 1, if A < $0003 go to .7, A = $0000
	lda.b d1
	inc a
	cmp.w #$0003
	bcc .7
	lda.w #$0000
.7:									; push A, go to CODE_C5AFCC
	pha
	jmp.w CODE_C5AFCC
.8:									; A = $85, A xor $0001, $85 = A, go to CODE_C5AFCC
	pei ($83)
	lda.b $85
	eor.w #$0001
	sta.b $85
	jmp.w CODE_C5AFCC
CODE_C5A623:						; called from other segments
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$0013
	sta.w repeatdelayframes
.1:									; A = $058D, if a $0100 bit set go to .2, if a $0200 bit set go to .4, ...
	lda.w $058D
	bit.w #$0100
	bne .2
	bit.w #$0200
	bne .4
	bit.w #$3000
	beq .rts
	jsl.l FadeOutWait
	jmp.w SeasonOptions
.rts:								; return
	rts
.2:									; A = $17C9, A + 1, if A < $001A go to .3, A = $0000
	lda.w $17C9
	inc a
	cmp.w #$001A
	bcc .3
	lda.w #$0000
.3:									; $17C9 = A, go to CODE_C5B7F1
	sta.w $17C9
	jmp.w CODE_C5B7F1
.4:									; A = $17C9, A - 1, if the result >= 0 go to .5, A = $0019
	lda.w $17C9
	dec a
	bpl .5
	lda.w #$0019
.5:									; $17C9 = A, go to CODE_C5B7F1
	sta.w $17C9
	jmp.w CODE_C5B7F1
CODE_C5A66E:						; called from other segments
	jsr.w CODE_C55BE8
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$0014
	sta.w repeatdelayframes
.1:									; A = $058D, if a $8000 bit set go to .7, if a $0100 bit set go to .5, ...
	lda.w $058D
	bit.w #$8000
	bne .7
	bit.w #$0100
	bne .5
	bit.w #$0200
	bne .9
	bit.w #$0400
	beq .2
	jmp.w CODE_C55C58
.2:									; if $0800 bits clear go to .3, go to CODE_C55CE6
	bit.w #$0800
	beq .3
	jmp.w CODE_C55CE6
.3:									; if a $3000 bit set go to .4
	bit.w #$3000
	bne .4
.rts:								; return
	rts
.4:									; call FadeOutWait, X = $77, call DeleteSprite, X = $79, ...
	jsl.l FadeOutWait
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	jmp.w SeasonOptions
.5:									; A = $17C9, A + 1, if A < $001A go to .6, A = $0000
	lda.w $17C9
	inc a
	cmp.w #$001A
	bcc .6
	lda.w #$0000
.6:									; go to .10
	bra .10
.7:									; call CODE_C5A72D, if d0 is not 0 go to .8, d0 - 1, go to .11
	jsr.w CODE_C5A72D
	lda.b d0
	bne .8
	dec.b d0
	bra .11
.8:									; d0 = 0, go to .11
	stz.b d0
	bra .11
.9:									; A = $17C9, A - 1, if the result >= 0 go to .10, A = $0019
	lda.w $17C9
	dec a
	bpl .10
	lda.w #$0019
.10:								; $17C9 = A
	sta.w $17C9
.11:								; X = $77, call DeleteSprite, X = $79, call DeleteSprite, ...
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	lda.b $D3
	clc
	adc.w #$0280
	ldy.w #$0380
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsr.w CODE_C5BCD9
	jsr.w CODE_C52CC1
	lda.w $2DCB
	sta.b a1
	lda.b d0
	bne .12
	sec
	lda.w $2DC9
	sbc.w $2DCB
	sta.b a1
.12:								; $69 = 0, A = CODE_C5BBDD, X = $000C, Y = $000B, ...
	stz.b $69
	lda.w #CODE_C5BBDD
	ldx.w #$000C
	ldy.w #$000B
	jsr.w CODE_C55ABC
	jsl.l SendTextMap
	rts
CODE_C5A72D:						; from CODE_C5A66E
	pea.w $559D
	pea.w $55BD
	lda.b d0
	bne .1
	pla
	pla
	pea.w $55AD
	pea.w $55D7
.1:									; A = $0240, A + $D3, Y = $0040, call ClearRAM7E, ...
	clc
	lda.w #$0240
	adc.b $D3
	ldy.w #$0040
	jsl.l ClearRAM7E
	clc
	lda.w #$0600
	adc.b $D3
	ldy.w #$0040
	jsl.l ClearRAM7E
	lda.w #$0018
	sta.b $CF
	ldy.w #$0009
	plx
	jsl.l PrintBoldLeft
	ldy.w #$0018
	plx
	jsl.l PrintBoldLeft
	jsl.l WaitTransfers
	rts
CODE_C5A773:						; called from other segments
	jsr.w CODE_C55BE8
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$0014
	sta.w repeatdelayframes
.1:									; A = $058D, if a $0400 bit set go to .2, if a $0800 bit set go to .4, ...
	lda.w $058D
	bit.w #$0400
	bne .2
	bit.w #$0800
	bne .4
	bit.w #$0200
	bne .6
	bit.w #$0100
	bne .7
	bit.w #$3000
	bne .5
.rts:								; return
	rts
.2:									; A = d1, A + 1, if A < $0004 go to .3, A = $0000
	lda.b d1
	inc a
	cmp.w #$0004
	bcc .3
	lda.w #$0000
.3:									; d1 = A, Y = $03F0, A = $0200, call CODE_C5A80E, ...
	sta.b d1
	ldy.w #$03F0
	lda.w #$0200
	jsr.w CODE_C5A80E
	bra .10
.4:									; A = d1, A - 1, if the result >= 0 go to .3, A = $0003, ...
	lda.b d1
	dec a
	bpl .3
	lda.w #$0003
	bra .3
.5:									; call FadeOutWait, X = $77, call DeleteSprite, X = $79, ...
	jsl.l FadeOutWait
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	jmp.w SeasonOptions
.6:									; d0 - 1, if the result >= 0 go to .9, A = $0007, go to .8
	dec.b d0
	bpl .9
	lda.w #$0007
	bra .8
.7:									; A = d0, A + 1, if A < $0008 go to .8, A = $0000
	lda.b d0
	inc a
	cmp.w #$0008
	bcc .8
	lda.w #$0000
.8:									; d0 = A
	sta.b d0
.9:									; Y = $0270, call CODE_C5A80B
	ldy.w #$0270
	jsr.w CODE_C5A80B
.10:								; X = $77, call DeleteSprite, X = $79, call DeleteSprite, ...
	ldx.b $77
	jsl.l DeleteSprite
	ldx.b $79
	jsl.l DeleteSprite
	jsl.l SendTextMap
	jsl.l WaitTransfers
	jmp.w CODE_C5B1AF
CODE_C5A80B:						; from CODE_C5A773
	lda.w #$01D0
CODE_C5A80E:						; from CODE_C5A773
	clc
	adc.b $D3
	jsl.l ClearRAM7E
	rts
CODE_C5A816:						; called from other segments
	ldx.b $89
	jmp (DATA8_C5A81B,x)
DATA8_C5A81B:						; jump table: the routine for each index
	dw CODE_C5A821,CODE_C5A95A,CODE_C5A9FB
CODE_C5A821:						; from DATA8_C5A81B
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$0010
	sta.w repeatdelayframes
.1:									; A = $058D, if a $0200 bit set go to .6, if a $0100 bit set go to .7, ...
	lda.w $058D
	bit.w #$0200
	bne .6
	bit.w #$0100
	bne .7
	bit.w #$0800
	bne .8
	bit.w #$0400
	beq .2
	jmp.w .12
.2:									; if a $8000 bit set go to .3, if $3000 bits clear go to .rts, ...
	bit.w #$8000
	bne .3
	bit.w #$3000
	beq .rts
	jsl.l FadeOutWait
	jmp.w SeasonOptions
.rts:								; return
	rts
.3:									; A = $306050, A and $00FF, if A = d0 go to .4, if carry set go to .rts
	lda.l $306050
	and.w #$00FF
	cmp.b d0
	beq .4
	bcs .rts
.4:									; if not zero go to .5, X = $85, A = $306051
	bne .5
	ldx.b $85
	lda.l $306051
.loop:								; loop: A / 2, X - 1, if the result >= 0 go to .loop, ...
	lsr a
	dex
	bpl .loop
	bcs .rts
.5:									; A = d4, A + $85, push A, A and $0007, ...
	lda.b d4
	clc
	adc.b $85
	pha
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	sta.b tmp0
	pla
	lsr a
	lsr a
	lsr a
	tax
	lda.l $307884,x
	eor.b tmp0
	sta.l $307884,x
	jmp.w CODE_C5B38F
.6:									; A = $306050, A and $00FF, if A >= d0 go to .rts, d0 - 1, ...
	lda.l $306050
	and.w #$00FF
	cmp.b d0
	bcs .rts
	dec.b d0
	jsr.w CODE_C5B22D
	jmp.w CODE_C5AAF0
.7:									; A = d0, A * 2, X = A, if DATA8_C35F62,x = 0 go to .rts, ...
	lda.b d0
	asl a
	tax
	lda.l DATA8_C35F62,x
	beq .rts
	inc.b d0
	jsr.w CODE_C5B22D
	jmp.w CODE_C5AAF0
.8:									; if $85 = 0 go to .rts, A - 1, $85 = A, if not zero go to .9, ...
	lda.b $85
	beq .rts
	dec a
	sta.b $85
	bne .9
	ldx.b a4
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
.9:									; A = d3, A - $00E0, A and $03FF, d3 = A, ...
	sec
	lda.b d3
	sbc.w #$00E0
	and.w #$03FF
	sta.b d3
	ldx.b a0
	lda.b $08,x
	cmp.w #$0060
	beq .10
	lda.w #$0060
	sta.b $08,x
	rts
.10:								; X = $75, A = $22,x, A or $0001, $22,x = A, ...
	ldx.b $75
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	jsr.w CODE_C5AA94
	lda.b $81
	dec a
	bpl .11
	lda.w #$0002
.11:								; $81 = A, $89 = $0002
	sta.b $81
	lda.w #$0002
	sta.b $89
.rts2:								; return
	rts
.12:								; A = $85, A + 1, if A >= d2 go to .rts2, $85 = A, ...
	lda.b $85
	inc a
	cmp.b d2
	bcs .rts2
	sta.b $85
	inc a
	cmp.b d2
	bcc .13
	ldx.b $75
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	clc
.13:								; A = d3, A + $00E0, A and $03FF, d3 = A, ...
	lda.b d3
	adc.w #$00E0
	and.w #$03FF
	sta.b d3
	ldx.b a0
	lda.b $08,x
	cmp.w #$0098
	beq .14
	lda.w #$0098
	sta.b $08,x
	rts
.14:								; X = a4, A = $22,x, A or $0001, $22,x = A, ...
	ldx.b a4
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	jsr.w CODE_C5AA94
	lda.b $81
	inc a
	cmp.w #$0003
	bcc .15
	lda.w #$0000
.15:								; $81 = A, $89 = $0004, return
	sta.b $81
	lda.w #$0004
	sta.b $89
	rts
CODE_C5A95A:						; from DATA8_C5A81B
	jsr.w CODE_C5A95D
CODE_C5A95D:						; from CODE_C5A95A
	dec.w BG2VScroll
	lda.w $468F
	and.w #$00FF
	cmp.w #$0038
	bne .1
	lda.w $0102
	dec a
	sta.w $0104
	lda.w $0100
	dec a
	sta.w $0102
	clc
	lda.w $0110
	adc.w #$00A7
	sta.w $0100
	sep #$20
	lda.b #$01
	sta.w $468F
	lda.b #$38
	sta.w $4692
	dec a
	sta.w $4695
	rep #$20
	rts
.1:									; $0100 - 1, $0102 - 1, $0104 - 1, if A is not $0028 go to .3, ...
	dec.w $0100
	dec.w $0102
	dec.w $0104
	cmp.w #$0028
	bne .3
	pha
	lda.b $85
	lsr a
	ldx.w #$0020
	bcc .2
	ldx.w #$0040
.2:									; A = $8D, A and $00FF, call CODE_C5B369, pull A
	lda.b $8D
	and.w #$00FF
	jsr.w CODE_C5B369
	pla
.3:									; if A is not $0010 go to .5, push A, A = $85, A / 2, ...
	cmp.w #$0010
	bne .5
	pha
	lda.b $85
	lsr a
	ldx.w #$0030
	bcc .4
	ldx.w #$0050
.4:									; A = $8E, A and $00FF, call CODE_C5B369, pull A
	lda.b $8E
	and.w #$00FF
	jsr.w CODE_C5B369
	pla
.5:									; A 8-bit, A + 1, $468F = A, A = $4695, ...
	sep #$20
	inc a
	sta.w $468F
	lda.w $4695
	dec a
	bne .6
	lda.b #$37
	sta.w $4692
	rep #$20
	lda.w $0104
	sta.w $0110
	lda.w $0102
	sta.w $0104
	stz.b $89
	rts
.6:									; $4695 = A, A 16-bit, return
	sta.w $4695
	rep #$20
	rts
CODE_C5A9FB:						; from DATA8_C5A81B
	jsr.w CODE_C5A9FE
CODE_C5A9FE:						; from CODE_C5A9FB
	inc.w BG2VScroll
	sep #$20
	lda.w $468F
	dec a
	beq .7
	sta.w $468F
	cmp.b #$28
	bne .2
	rep #$20
	lda.b $85
	lsr a
	ldx.w #$0020
	bcc .1
	ldx.w #$0040
.1:									; A = $8D, A and $00FF, call CODE_C5B369, A 8-bit, ...
	lda.b $8D
	and.w #$00FF
	jsr.w CODE_C5B369
	sep #$20
	bra .4
.2:									; if A is not $10 go to .4, A 16-bit, A = $85, A / 2, ...
	cmp.b #$10
	bne .4
	rep #$20
	lda.b $85
	lsr a
	ldx.w #$0030
	bcc .3
	ldx.w #$0050
.3:									; A = $8E, A and $00FF, call CODE_C5B369, A 8-bit
	lda.b $8E
	and.w #$00FF
	jsr.w CODE_C5B369
	sep #$20
.4:									; if $38 = $4692 go to .5, $4692 = A, go to .6
	lda.b #$38
	cmp.w $4692
	beq .5
	sta.w $4692
	bra .6
.5:									; $4695 + 1
	inc.w $4695
.6:									; A 16-bit, A = $0110, A + 1, $0104 = A, ...
	rep #$20
	lda.w $0110
	inc a
	sta.w $0104
	sta.w $0110
	inc.w $0100
	inc.w $0102
	rts
.7:									; $468F = $38, A - 1, $4692 = A, $4695 = $01, ...
	lda.b #$38
	sta.w $468F
	dec a
	sta.w $4692
	lda.b #$01
	sta.w $4695
	rep #$20
	sec
	lda.w $0100
	sbc.w #$00A7
	sta.w $0110
	lda.w $0102
	inc a
	sta.w $0100
	lda.w $0104
	inc a
	sta.w $0102
	sta.w $0104
	stz.b $89
	rts
CODE_C5AA94:						; from CODE_C5A821
	jsr.w CODE_C5B38F
	ldx.w #$0058
	stx.b $CF
	ldx.w #$00A0
	stx.b $D1
	lda.b $85
	asl a
	adc.b d1
	tax
	lda.l $C30001,x
	sta.b $8D
	lda.b $81
	asl a
	tax
	phx
	lda.l DATA8_C5B35D,x
	adc.b $D3
	ldy.w #$01C0
	jsl.l ClearRAM7E
	plx
	lda.l DATA8_C5B363,x
	tay
	lda.b $8D
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	phy
	jsl.l PrintThinCentred
	lda.b $8E
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C3585C,x
	tax
	pla
	adc.w #$0003
	tay
	jsl.l PrintThinCentred
	jsl.l SendTextMap
	rts
CODE_C5AAF0:						; from CODE_C5A821, GamesToday
	lda.b $D3
	clc
	adc.w #$0140
	ldy.w #$0080
	jsl.l ClearRAM7E
	lda.b d0
	jsr.w CODE_C56168
	lda.w #$0030
	sta.b $CF
	ldx.w #$04F5
	ldy.w #$0005
	jsl.l PrintItalicLeftStr
	jsl.l SendTextMap
	rts
CODE_C5AB16:						; called from other segments
	lda.w repeatdelayframes
	beq .1
.rts:								; return
	rts
.1:									; A = $058D, if $3000 bits clear go to .rts, go to SeasonOptions
	lda.w $058D
	bit.w #$3000
	beq .rts
	jmp.w SeasonOptions
CODE_C5AB27:						; called from other segments
	lda.w repeatdelayframes
	beq .1
	rts
.1:									; A = $058D, if a $3000 bit set go to .5, if a $0800 bit set go to .2, ...
	lda.w $058D
	bit.w #$3000
	bne .5
	bit.w #$0800
	bne .2
	bit.w #$0400
	bne .4
	rts
.2:									; A = $0015, call CODE_C590BB, A = $0018, call CODE_C5909D, ...
	lda.w #$0015
	jsr.w CODE_C590BB
	lda.w #$0018
	jsr.w CODE_C5909D
	lda.w #$00B5
.3:									; X = a0, $08,x = A, call SendTextMap, return
	ldx.b a0
	sta.b $08,x
	jsl.l SendTextMap
	rts
.4:									; A = $0015, call CODE_C5909D, A = $0018, call CODE_C590BB, ...
	lda.w #$0015
	jsr.w CODE_C5909D
	lda.w #$0018
	jsr.w CODE_C590BB
	lda.w #$00CD
	bra .3
.5:									; X = a0, pull Y, if $08,x is not $00B5 go to .6, go to CODE_C5963A
	ldx.b a0
	ply
	lda.b $08,x
	cmp.w #$00B5
	bne .6
	jmp.w CODE_C5963A
.6:									; X = a0, $05,x = $0008, $08,x = $008C, call CODE_C5ABAE, ...
	ldx.b a0
	lda.w #$0008
	sta.b $05,x
	lda.w #$008C
	sta.b $08,x
	jsr.w CODE_C5ABAE
	lda.w #$0007
	sta.w $1864
	jsr.w CODE_C5ABC4
	lda.w #$C000
	sta.w DMAEnShadow
	jsr.w CODE_C59217
	lda.w #$5CC1
	jsl.l CODE_C59308
	jmp.w $8D44
CODE_C5ABA1:						; called from other segments
	lda.w #$0002
	sta.w $1864
	jsl.l CODE_C4CFF5
	jmp.w CODE_C5963A
CODE_C5ABAE:						; from CODE_C5AB27
	clc
	lda.w #$0400
	adc.b $D3
	ldy.w #$0280
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsl.l WaitTransfers
	rts
CODE_C5ABC4:						; from CODE_C5AB27 and other segments
	lda.w #$001B
	ldx.w #$48E2
	ldy.w #$468C
	mvn $7E,$C0
	lda.w #$FFFF
	sta.w $0100
	sta.w $0102
	sta.w $0104
	sta.w $0106
	sta.w $0108
	sta.w $0110
	stz.w BG1HScroll
	stz.w BG2HScroll
	stz.w BG3HScroll
	sta.w BG1VScroll
	sta.w BG3VScroll
	lda.w #$FFFA
	sta.w BG2VScroll
	lda.w #$FF90
	sta.w $010A
	lda.w #$0010
	sta.w $010E
	rts
CODE_C5AC07:						; the League Menu each frame: up / down move, B / start / select run the
									; item (SeasonMenuJumps), X leaves
	lda.w repeatdelayframes
	beq .1
	cmp.w #$0014
	bcc .rts
	lda.w #$000C
	sta.w repeatdelayframes
.1:									; A = $058D, if a $0800 bit set go to .4, if a $0400 bit set go to .6, ...
	lda.w $058D
	bit.w #$0800
	bne .4
	bit.w #$0400
	bne .6
	bit.w #$B000
	bne .2
	bit.w #$0040
	bne .3
.rts:								; return
	rts
.2:									; A = d6, A * 2, X = A, jump through SeasonMenuJumps,x
	lda.b d6
	asl a
	tax
	jmp (SeasonMenuJumps,x)
.3:									; call FadeOutWait, $1864 = $0002, go to CODE_C50056
	jsl.l FadeOutWait
	lda.w #$0002
	sta.w $1864
	jmp.w CODE_C50056
.4:									; call CODE_C5AC7F, d6 - 1, if the result >= 0 go to .5, d6 = $0005
	jsr.w CODE_C5AC7F
	dec.b d6
	bpl .5
	lda.w #$0005
	sta.b d6
.5:									; call CODE_C5ACA3, call SendTextMap, go to CODE_C5A599
	jsr.w CODE_C5ACA3
	jsl.l SendTextMap
	jmp.w CODE_C5A599
.6:									; call CODE_C5AC7F, A = d6, A + 1, if A < $0006 go to .7, ...
	jsr.w CODE_C5AC7F
	lda.b d6
	inc a
	cmp.w #$0006
	bcc .7
	lda.w #$0000
.7:									; d6 = A, call CODE_C5ACA3, call SendTextMap, go to CODE_C5A599
	sta.b d6
	jsr.w CODE_C5ACA3
	jsl.l SendTextMap
	jmp.w CODE_C5A599
SeasonMenuJumps:					; the routine of each League Menu item: Play Games, NHL Standings, Games
									; Today, League Leaders, Team Stats, Player Stats
	dw MenuPlayGames,StandingsScreen,GamesToday,LeagueLeadersScreen
	dw SeasonTeamStats,SeasonPlayerStats
CODE_C5AC7F:						; from CODE_C5AC07
	lda.w #$0C00
	sta.b tmp0
CODE_C5AC84:						; from CODE_C5ACA3
	lda.b d6
	asl a
	adc.b d6
	xba
	lsr a
	lsr a
	adc.b $D3
	tax
	ldy.w #$003F
.loop:								; loop: A = $0180,x, A and $E3FF, A or tmp0, $0180,x = A, ...
	lda.w $0180,x
	and.w #$E3FF
	ora.b tmp0
	sta.w $0180,x
	inx
	inx
	dey
	bpl .loop
	rts
CODE_C5ACA3:						; from CODE_C5AC07
	lda.w #$0000
	sta.b tmp0
	bra CODE_C5AC84
GamesToday:							; League Menu Games Today: the day's games (B marks a game, the pad
									; changes the day, start goes back to the League Menu)
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	lda.w $1864
	cmp.w #$0003
	bne .1
	jml.l CODE_C40000
.1:									; A = WonCheckTiles&$FFFF, X = WonCheckTiles>>16, ...
	lda.w #WonCheckTiles&$FFFF
	ldx.w #WonCheckTiles>>16
	jsl.l DecompressUnpackbuf
	ldy.w #$5C00
	jsl.l QueueClearVRAM
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0600
	pea.w $0130
	pea.w $007E
	pea.w $50DC
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0070
	pea.w $00C0
	pea.w $3EE2
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l WaitTransfers
	ldx.w #$0060
	jsl.l SetupHDMA
	db $40,$2C,$35,$4A,$C0,$7E		; inline parameters
	ldx.w #$0050
	jsl.l SetupHDMA
	db $42,$12,$8C,$46,$7E,$7E		; inline parameters
	ldx.w #$0040
	jsl.l SetupHDMA
	db $42,$10,$14,$49,$C0,$00		; inline parameters
	lda.w #$0015
	sta.w $364E
	lda.w #$0011
	sta.w $3650
	sta.w $3652
	lda.w #$001B
	ldx.w #$48FE
	ldy.w #$468C
	mvn $7E,$C0
	lda.w #$FFFF
	sta.w $0100
	sta.w $0102
	sta.w $0104
	sta.w $0110
	lda.w #$FF2F
	sta.w $0108
	lda.w #$FF4F
	sta.w $010A
	lda.w #$FF2F
	sta.w $0106
	lda.w #$F000
	sta.w DMAEnShadow
	lda.w #$00A7
	sta.b $18
	lda.w #$0046
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b a4
	lda.w #$0001
	jsl.l SetSpriteAnim
	lda.w #$00A4
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	stx.b $75
	inc.b $38,x
	lda.w #$0002
	jsl.l SetSpriteAnim
	ldx.b a0
	lda.w #$002D
	sta.b $05,x
	jsl.l ResetWorkBuf
	jsl.l InitTextMap
	lda.w #$568E
	jsl.l PrintTextPage
	jsl.l WaitTransfers
	lda.l $306050
	and.w #$00FF
	sta.b d0
	lda.w #$0002
	sta.b $81
	stz.b $89
	jsr.w CODE_C5B22D
	jsr.w CODE_C5AAF0
	lda.w #$0007
	sta.b $99
	stz.w fadestep
	rts
CODE_C5ADD8:						; called from other segments
	bit.b tmp0
	bpl NoGameSelected
CODE_C5ADDC:						; from CODE_C5AF07, MenuPlayGames and other segments
	pla
	jsr.w setoptions
	jmp.w CODE_C5963A
NoGameSelected:						; the warning A game must be selected. / Okay (screen state 12)
	lda.b $D3
	clc
	adc.w #$0180
	ldy.w #$0580
	jsl.l ClearRAM7E
	jsl.l SendTextMap
	jsl.l WaitTransfers
	lda.w #$2C00
	sta.b $D5
	lda.w #$0032
	sta.b $CF
	ldx.w #$47A1
	ldy.w #$0008
	jsl.l PrintItalicLeft
	ldy.w #$000A
	ldx.w #$47AB
	jsl.l PrintItalicLeft
	lda.w #$2000
	sta.b $D5
	lda.w #$006E
	sta.b $CF
	ldy.w #$000E
	ldx.w #$47B3
	jsl.l PrintItalicLeft
	jsl.l SendTextMap
	ldx.b a0
	lda.w #$0064
	sta.b $05,x
	lda.w #$007E
	sta.b $08,x
	lda.w #$000C
	sta.b $99
	rts
DATA8_C5AE40:						; not traced: data between routines
	db $FF,$FE,$FC,$F8,$F0,$E0,$C0,$80
MenuPlayGames:						; League Menu Play Games: when the season is over (play mode 3), the end
									; of season (CODE_C401E5); else the day's games from the schedule
	stz.b tmp0
	lda.w $1864
	cmp.w #$0003
	bne .1
	jml.l CODE_C401E5
.1:									; A = $306050, A and $00FF, d0 = A, call CODE_C5B20E, ...
	lda.l $306050
	and.w #$00FF
	sta.b d0
	jsr.w CODE_C5B20E
	lda.b d4
	and.w #$0007
	tax
	lda.b d4
	lsr a
	lsr a
	lsr a
	tay
	lda.w #$0002
	sta.w $1864
	lda.l $306050
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C35F60,x
	bne .2
	jsl.l CODE_C40D96
	inc.w $1864
	jmp.w CODE_C5ADDC
.2:									; A = d0, A * 2, X = A, A = DATA8_C360D4,x, ...
	lda.b d0
	asl a
	tax
	lda.l DATA8_C360D4,x
	tax
	lda.l $C30000,x
	and.w #$00FF
	sta.w $2C42
	sta.b tmp0
	pea.w $7E7F
	plb
	ldy.w #$8EF8
.loop:								; loop: A = $C30001,x, A and $00FF, $0002,y = A, A = $C30002,x, ...
	lda.l $C30001,x
	and.w #$00FF
	sta.w $0002,y
	lda.l $C30002,x
	and.w #$00FF
	sta.w $0004,y
	lda.w #$0000
	sta.w $0006,y
	sta.w $0008,y
	sta.w $000A,y
	phx
	lda.b d4
	and.w #$0007
	tax
	lda.l DATA8_C4C4A6,x
	and.w #$00FF
	sta.b tmp1
	lda.b d4
	lsr a
	lsr a
	lsr a
	tax
	lda.l $307884,x
	ldx.w #$0000
	and.b tmp1
	beq .3
	inx
.3:									; A = X, $0000,y = A, pull X, d4 + 1, ...
	txa
	sta.w $0000,y
	plx
	inc.b d4
	inx
	inx
	tya
	clc
	adc.w #$010A
	tay
	dec.b tmp0
	bne .loop
	lda.l $306051
	beq CODE_C5AF07
	jsr.w CODE_C5E336
CODE_C5AF07:						; from MenuPlayGames and other segments
	lda.l $7E2C42
	sta.b tmp0
	lda.w #$8EF8
	clc
.loop:								; loop: X = A, if $0000,x is not 0 go to .3, A = X, A + $010A, ...
	tax
	lda.w $0000,x
	bne .3
	txa
	adc.w #$010A
	dec.b tmp0
	bne .loop
	plb
	jsr.w CODE_C5E49A
	jsr.w CODE_C5DD47
	jsr.w CODE_C5DE9B
	jsl.l ResetWorkBuf
	lda.w #$0001
	sta.w $190E
	stz.w $1910
	jsl.l CODE_C5E50E
	jsr.w ShowOtherScores
	stz.w $190E
	jsl.l CODE_C4C574
	lda.w $1864
	cmp.w #$0003
	bne .1
	jml.l CODE_C40296
.1:									; call CODE_C5DDF0, call CODE_C5E17C, A = $306050, A + 1, ...
	jsr.w CODE_C5DDF0
	jsr.w CODE_C5E17C
	lda.l $306050
	inc a
	sta.l $306050
	lda.w #$0000
	sta.l $306051
	bit.w $1910
	bpl .2
	jmp.w CODE_C5ADDC
.2:									; go to MenuPlayGames
	jmp.w MenuPlayGames
.3:									; $0017C9 = $0004,x, A = $0002,x, $17CB = A, $2C44 = X, ...
	lda.w $0004,x
	sta.l $0017C9
	lda.w $0002,x
	plb
	sta.w $17CB
	stx.w $2C44
	jsl.l CODE_C4C574
	jsl.l ResetWorkBuf
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	wai
	jsr.w CODE_C55951
	jsl.l CODE_C5E50E
	lda.w #$FFFA
	sta.w BG2VScroll
	jsr.w CODE_C5C0BE
	sep #$20
	lda.b #$17
	sta.l TM
	rep #$20
	stz.b a0
	stz.b a4
	stz.b $75
	pla
	jmp.w CODE_C593B1

; Segment bankCF_E000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $CFEE1D
CODE_CFEE1D:						; no caller found (not traced): jml to bank $C3
	jml.l NextSortedGameObject
CODE_CFEE21:						; no caller found (not traced): jml to bank $C5
	jml.l CODE_C5287A
CODE_CFEE25:						; called from other segments
	asl a
	tax
	lda.l DATA8_C618D8,x
	adc.b $0C
	sta.b $0C
	clc
	lda.b $0A
	adc.l DATA8_C62120,x
	sta.b $0A
	lda.l DATA8_C60848+1,x
	and.w #$00FF
	dec a
	eor.w #$0001
	cmp.w #$008E
	bcs .1
	asl a
	tax
	lda.l DATA8_CFF3A2,x
	tax
	stx.b $E5
	lda.l $CF0000,x
	and.w #$00FF
	tax
	jmp (DATA8_CFEEAE,x)
.1:									; if A >= $0090 go to .2, A xor $0001, A * 2, X = A, ...
	cmp.w #$0090
	bcs .2
	eor.w #$0001
	asl a
	tax
	jmp (DATA8_CFF3A2,x)
.2:									; jump through $00A5
	jmp ($00A5)
CODE_CFEE6C:						; called from other segments
	asl a
	tax
	lda.l DATA8_C61090,x
	adc.b $0A
	sta.b $0A
	clc
	lda.l DATA8_C618D8,x
	adc.b $0C
	sta.b $0C
	lda.l DATA8_C60848+1,x
	and.w #$00FF
	beq .2
	cmp.w #$008F
	bcs .1
	asl a
	tax
	lda.l DATA8_CFF3A0,x
	sta.b $E5
	tax
	lda.l $CF0000,x
	and.w #$00FF
	tax
	jmp (DATA8_CFEEAE,x)
.1:									; if A >= $0092 go to .2, A * 2, X = A, jump through DATA8_CFF3A0,x
	cmp.w #$0092
	bcs .2
	asl a
	tax
	jmp (DATA8_CFF3A0,x)
.2:									; jump through $00A5
	jmp ($00A5)
DATA8_CFEEAE:						; jump table: the routine for each index
	dw CODE_CFEEB8,CODE_CFEECF,CODE_CFEEFE,CODE_CFEF41
	dw CODE_CFF086
CODE_CFEEB8:						; from DATA8_CFEEAE
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	jmp.w CODE_CFF04D
CODE_CFEECF:						; from DATA8_CFEEAE
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	lda.l $CF0003,x
	and.w #$00FF
	sta.b $E9
	lda.l $CF0004,x
	and.w #$00FF
	sta.b $F1
	lda.b tmp2
	inc a
	inc a
	sta.b tmp2
	jmp.w CODE_CFF00F
CODE_CFEEFE:						; from DATA8_CFEEAE
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	lda.l $CF0003,x
	and.w #$00FF
	sta.b $E9
	lda.l $CF0004,x
	and.w #$00FF
	sta.b $F1
	lda.l $CF0005,x
	and.w #$00FF
	sta.b $EB
	lda.l $CF0006,x
	and.w #$00FF
	sta.b $F3
	clc
	lda.b tmp2
	adc.w #$0004
	sta.b tmp2
	jmp.w CODE_CFEFD1
CODE_CFEF41:						; from DATA8_CFEEAE
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	lda.l $CF0003,x
	and.w #$00FF
	sta.b $E9
	lda.l $CF0004,x
	and.w #$00FF
	sta.b $F1
	lda.l $CF0005,x
	and.w #$00FF
	sta.b $EB
	lda.l $CF0006,x
	and.w #$00FF
	sta.b $F3
	lda.l $CF0007,x
	and.w #$00FF
	sta.b $ED
	lda.l $CF0008,x
	and.w #$00FF
	sta.b $F5
	clc
	lda.b tmp2
	adc.w #$0006
	sta.b tmp2
	lda.b tmp2
	pha
	dec a
	dec a
	sta.b tmp2
	ldx.w #$0002
	clc
	lda.b $ED
	adc.b $0A
	bpl .1
	cmp.w #$FFF1
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $F5, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $F5
	adc.b $0C
	bpl .3
	cmp.w #$FFF1
	and.w #$00FF
	bcs .4
.2:									; pull A, go to CODE_CFEFD1
	pla
	bra CODE_CFEFD1
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
CODE_CFEFD1:						; from CODE_CFEEFE, CODE_CFEF41
	lda.b tmp2
	pha
	dec a
	dec a
	sta.b tmp2
	ldx.w #$0002
	clc
	lda.b $EB
	adc.b $0A
	bpl .1
	cmp.w #$FFF1
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $F3, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $F3
	adc.b $0C
	bpl .3
	cmp.w #$FFF1
	and.w #$00FF
	bcs .4
.2:									; pull A, go to CODE_CFF00F
	pla
	bra CODE_CFF00F
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
CODE_CFF00F:						; from CODE_CFEECF, CODE_CFEFD1 and other segments
	lda.b tmp2
	pha
	dec a
	dec a
	sta.b tmp2
	ldx.w #$0002
	clc
	lda.b $E9
	adc.b $0A
	bpl .1
	cmp.w #$FFF1
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $F1, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $F1
	adc.b $0C
	bpl .3
	cmp.w #$FFF1
	and.w #$00FF
	bcs .4
.2:									; pull A, go to CODE_CFF04D
	pla
	bra CODE_CFF04D
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
CODE_CFF04D:						; from CODE_CFF00F, CODE_CFEEB8
	pei ($A3)
	ldx.w #$0002
	clc
	lda.b $E7
	adc.b $0A
	bpl .1
	cmp.w #$FFF1
	bcc .2
	inx
	and.w #$00FF
.1:									; if A >= $0100 go to .2, tmp0 = A, A = $EF, A + $0C, ...
	cmp.w #$0100
	bcs .2
	sta.b tmp0
	lda.b $EF
	adc.b $0C
	bpl .3
	cmp.w #$FFF1
	and.w #$00FF
	bcs .4
.2:									; pull A, go to CODE_CFF086
	pla
	bra CODE_CFF086
.3:									; if A >= $00E0 go to .2
	cmp.w #$00E0
	bcs .2
.4:									; A or tmp0, push A, $00,y = X, Y + 1
	xba
	ora.b tmp0
	pha
	stx.b $00,y
	iny
CODE_CFF086:						; from CODE_CFF04D, DATA8_CFEEAE
	ldx.b $E5
	lda.l $CF0000,x
	and.w #$000F
	cmp.w #$0008
	bcc .1
	inx
	bra .2
.1:									; A + $0003, A + $E5, X = A
	adc.w #$0003
	adc.b $E5
	tax
.2:									; $E5 = X, A = $CF0000,x, A and $00FF, X = A, ...
	stx.b $E5
	lda.l $CF0000,x
	and.w #$00FF
	tax
	jmp (DATA8_CFF0AA,x)
DATA8_CFF0AA:						; jump table: the routine for each index
	dw CODE_CFF0B4,CODE_CFF0CB,CODE_CFF0F6,CODE_CFF137
	dw CODE_CFF279
CODE_CFF0B4:						; from DATA8_CFF0AA
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	jmp.w CODE_CFF240

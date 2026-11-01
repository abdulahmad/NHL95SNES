; Segment bankCF_E000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $CFEE1D
CODE_CFEE1D:						; no caller found (not traced): jml to bank $C3
	jml.l CODE_C3846C
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
	bcs CODE_CFEE5C
	asl a
	tax
	lda.l $CFF3A2,x
	tax
	stx.b $E5
	lda.l $CF0000,x
	and.w #$00FF
	tax
	jmp (DATA8_CFEEAE,x)
CODE_CFEE5C:						; from CODE_CFEE25
	cmp.w #$0090
	bcs CODE_CFEE69
	eor.w #$0001
	asl a
	tax
	jmp ($F3A2,x)
CODE_CFEE69:						; from CODE_CFEE5C
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
	beq CODE_CFEEAB
	cmp.w #$008F
	bcs CODE_CFEEA1
	asl a
	tax
	lda.l $CFF3A0,x
	sta.b $E5
	tax
	lda.l $CF0000,x
	and.w #$00FF
	tax
	jmp (DATA8_CFEEAE,x)
CODE_CFEEA1:						; from CODE_CFEE6C
	cmp.w #$0092
	bcs CODE_CFEEAB
	asl a
	tax
	jmp ($F3A0,x)
CODE_CFEEAB:						; from CODE_CFEE6C, CODE_CFEEA1
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
	lda.b $A3
	inc a
	inc a
	sta.b $A3
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
	lda.b $A3
	adc.w #$0004
	sta.b $A3
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
	lda.b $A3
	adc.w #$0006
	sta.b $A3
	lda.b $A3
	pha
	dec a
	dec a
	sta.b $A3
	ldx.w #$0002
	clc
	lda.b $ED
	adc.b $0A
	bpl CODE_CFEFAD
	cmp.w #$FFF1
	bcc CODE_CFEFC2
	inx
	and.w #$00FF
CODE_CFEFAD:						; from CODE_CFEF41
	cmp.w #$0100
	bcs CODE_CFEFC2
	sta.b $9F
	lda.b $F5
	adc.b $0C
	bpl CODE_CFEFC5
	cmp.w #$FFF1
	and.w #$00FF
	bcs CODE_CFEFCA
CODE_CFEFC2:						; from CODE_CFEF41, CODE_CFEFAD, CODE_CFEFC5
	pla
	bra CODE_CFEFD1
CODE_CFEFC5:						; from CODE_CFEFAD
	cmp.w #$00E0
	bcs CODE_CFEFC2
CODE_CFEFCA:						; from CODE_CFEFAD
	xba
	ora.b $9F
	pha
	stx.b $00,y
	iny
CODE_CFEFD1:						; from CODE_CFEEFE, CODE_CFEFC2
	lda.b $A3
	pha
	dec a
	dec a
	sta.b $A3
	ldx.w #$0002
	clc
	lda.b $EB
	adc.b $0A
	bpl CODE_CFEFEB
	cmp.w #$FFF1
	bcc CODE_CFF000
	inx
	and.w #$00FF
CODE_CFEFEB:						; from CODE_CFEFD1
	cmp.w #$0100
	bcs CODE_CFF000
	sta.b $9F
	lda.b $F3
	adc.b $0C
	bpl CODE_CFF003
	cmp.w #$FFF1
	and.w #$00FF
	bcs CODE_CFF008
CODE_CFF000:						; from CODE_CFEFD1, CODE_CFEFEB, CODE_CFF003
	pla
	bra CODE_CFF00F
CODE_CFF003:						; from CODE_CFEFEB
	cmp.w #$00E0
	bcs CODE_CFF000
CODE_CFF008:						; from CODE_CFEFEB
	xba
	ora.b $9F
	pha
	stx.b $00,y
	iny
CODE_CFF00F:						; from CODE_CFEECF, CODE_CFF000 and other segments
	lda.b $A3
	pha
	dec a
	dec a
	sta.b $A3
	ldx.w #$0002
	clc
	lda.b $E9
	adc.b $0A
	bpl CODE_CFF029
	cmp.w #$FFF1
	bcc CODE_CFF03E
	inx
	and.w #$00FF
CODE_CFF029:						; from CODE_CFF00F
	cmp.w #$0100
	bcs CODE_CFF03E
	sta.b $9F
	lda.b $F1
	adc.b $0C
	bpl CODE_CFF041
	cmp.w #$FFF1
	and.w #$00FF
	bcs CODE_CFF046
CODE_CFF03E:						; from CODE_CFF00F, CODE_CFF029, CODE_CFF041
	pla
	bra CODE_CFF04D
CODE_CFF041:						; from CODE_CFF029
	cmp.w #$00E0
	bcs CODE_CFF03E
CODE_CFF046:						; from CODE_CFF029
	xba
	ora.b $9F
	pha
	stx.b $00,y
	iny
CODE_CFF04D:						; from CODE_CFF03E, CODE_CFEEB8
	pei ($A3)
	ldx.w #$0002
	clc
	lda.b $E7
	adc.b $0A
	bpl CODE_CFF062
	cmp.w #$FFF1
	bcc CODE_CFF077
	inx
	and.w #$00FF
CODE_CFF062:						; from CODE_CFF04D
	cmp.w #$0100
	bcs CODE_CFF077
	sta.b $9F
	lda.b $EF
	adc.b $0C
	bpl CODE_CFF07A
	cmp.w #$FFF1
	and.w #$00FF
	bcs CODE_CFF07F
CODE_CFF077:						; from CODE_CFF04D, CODE_CFF062, CODE_CFF07A
	pla
	bra CODE_CFF086
CODE_CFF07A:						; from CODE_CFF062
	cmp.w #$00E0
	bcs CODE_CFF077
CODE_CFF07F:						; from CODE_CFF062
	xba
	ora.b $9F
	pha
	stx.b $00,y
	iny
CODE_CFF086:						; from CODE_CFF077, DATA8_CFEEAE
	ldx.b $E5
	lda.l $CF0000,x
	and.w #$000F
	cmp.w #$0008
	bcc CODE_CFF097
	inx
	bra CODE_CFF09D
CODE_CFF097:						; from CODE_CFF086
	adc.w #$0003
	adc.b $E5
	tax
CODE_CFF09D:						; from CODE_CFF086
	stx.b $E5
	lda.l $CF0000,x
	and.w #$00FF
	tax
	jmp (DATA8_CFF0AA,x)
DATA8_CFF0AA:						; jump table: the routine for each index
	dw CODE_CFF0B4,$F0CB,$F0F6,$F137
	dw $F279
CODE_CFF0B4:						; from DATA8_CFF0AA
	ldx.b $E5
	lda.l $CF0001,x
	and.w #$00FF
	sta.b $E7
	lda.l $CF0002,x
	and.w #$00FF
	sta.b $EF
	jmp.w $F240

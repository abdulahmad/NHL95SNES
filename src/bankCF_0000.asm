; Segment bankCF_0000: the sound code (uploads to the sound CPU, the command queue), the sound block table,
; SampleList, then the first sound blocks.
org $CF0000
CODE_CF0000:						; called from other segments
	stz.w $4DCE
	jsl.l CODE_CF001A
	lda.w #$8001
	sta.w $4ABC
	lda.w #$FFFF
	sta.w $4ABE
	lda.w #$007F
	sta.w $059C
	rtl
CODE_CF001A:						; from CODE_CF0000 and other segments
	lda.w #SoundRAMClear&$FFFF
	ldx.w #SoundRAMClear>>16
	jsl.l SPCUpload
	lda.w #SoundDriver&$FFFF
	ldx.w #SoundDriver>>16
	jsl.l SPCUpload
	sep #$20
	lda.b #$7F
CODE_CF0032:						; from CODE_CF0032
	cmp.l $002143
	bne CODE_CF0032
	sta.l $002140
	rep #$20
	lda.w #$FFFF
	sta.w $4BC0
	stz.w $1EA1
	stz.w $1EA3
	rtl
SPCUpload:							; upload the blocks at X:A to the sound CPU boot loader (94S SPCUpload)
	pea.w $7E80
	plb
	sta.b $2C
	sep #$20
	txa
	sta.b $2E
	lda.b #$1B
	sta.w $2143
	rep #$20
	lda.w #$BBAA
	jsr.w CODE_CF00B7
	sep #$20
	lda.b #$CC
	bra CODE_CF008B
CODE_CF0069:						; from CODE_CF0098
	jsr.w CODE_CF00BD
	xba
	lda.b #$00
	bra CODE_CF007A
CODE_CF0071:						; from CODE_CF007A
	xba
	jsr.w CODE_CF00BD
	xba
	jsr.w CODE_CF00B7
	inc a
CODE_CF007A:						; from CODE_CF0069
	rep #$20
	sta.w $2140
	sep #$20
	dex
	bne CODE_CF0071
	jsr.w CODE_CF00B7
CODE_CF0087:						; from CODE_CF0087
	adc.b #$03
	beq CODE_CF0087
CODE_CF008B:						; from SPCUpload
	pha
	rep #$20
	jsr.w CODE_CF00CC
	tax
	jsr.w CODE_CF00CC
	sta.w $2142
CODE_CF0098:						; called from other segments
	sep #$20
	cpx.w #$0001
	lda.b #$00
	rol a
	sta.w $2141
	adc.b #$7F
	pla
	sta.w $2140
	jsr.w CODE_CF00B7
	bvs CODE_CF0069
	lda.b #$00
	sta.w $2140
	rep #$20
	plb
	rtl
CODE_CF00B7:						; from SPCUpload, CODE_CF0098, CODE_CF00B7, CODE_CF007A, ...
	cmp.w $2140
	bne CODE_CF00B7
	rts
CODE_CF00BD:						; from CODE_CF0069, CODE_CF0071
	lda.b [$2C]
	ldy.b $2C
	iny
	bne CODE_CF00C9
	inc.b $2E
	ldy.w #$8000
CODE_CF00C9:						; from CODE_CF00BD
	sty.b $2C
	rts
CODE_CF00CC:						; from CODE_CF008B
	lda.b [$2C]
	ldy.b $2C
	iny
	bne CODE_CF00D8
	inc.b $2E
	ldy.w #$8000
CODE_CF00D8:						; from CODE_CF00CC
	iny
	bne CODE_CF00E0
	inc.b $2E
	ldy.w #$8000
CODE_CF00E0:						; from CODE_CF00D8
	sty.b $2C
	rts
CODE_CF00E3:						; from CODE_CF03B2, CODE_CF03EE, CODE_CF040B, ...
	phy
	ldy.w $1EA1
	sta.w $4AC0,y
	txa
	sta.w $4AC1,y
	pla
	sta.w $4AC2,y
	tya
	clc
	adc.w #$0004
	and.w #$00FF
	sta.w $1EA1
CODE_CF00FD:						; called from other segments
	rtl
CODE_CF00FE:						; called from other segments
	ldx.w $1EA3
CODE_CF0101:						; called from other segments
	cpx.w $1EA1
	bne CODE_CF0107
	rtl
CODE_CF0107:						; from CODE_CF0101
	txa
	clc
	adc.w #$0004
	and.w #$00FF
	sta.w $1EA3
	lda.l $7E4AC2,x
	tay
	lda.l $7E4AC1,x
	pha
	lda.l $7E4AC0,x
	plx
	pha
	tya
	sta.w $2141
	sep #$20
	txa
	sta.w $2140
	pla
	sta.w $2143
	pla
	rep #$20
	rtl
CODE_CF0134:						; from CODE_CF0134, CODE_CF0427, CODE_CF04C0 and other segments
	ldy.w $1EA3
	cpy.w $1EA1
	bne CODE_CF0134
	wai
	stz.w $1EA5
	pha
	phx
	lda.w #$0C00
	sta.b $9F
	ldx.w #$00FE
	lda.w #$FFFF
CODE_CF014D:						; from CODE_CF014D
	sta.w $4BC8,x
	sta.w $4CCA,x
	stz.w $48BA,x
	dex
	dex
	bpl CODE_CF014D
	lda.w #$0001
	sta.w $49BA
	plx
	pla
CODE_CF0162:						; from CODE_CF045C and other segments
	sta.b $34
	stx.b $36
CODE_CF0166:						; from CODE_CF0166, CODE_CF0178
	lda.b [$34]
	and.w #$00FF
	bit.w #$0080
	bne CODE_CF0178
	inc.b $34
	jsl.l CODE_CF01E0
	bra CODE_CF0166
CODE_CF0178:						; from CODE_CF0166
	cmp.w #$00FF
	beq CODE_CF0185
	inc.b $34
	jsl.l CODE_CF0313
	bra CODE_CF0166
CODE_CF0185:						; from CODE_CF0178
	lda.b $9F
	clc
CODE_CF0188:						; called from other segments
	adc.w #$0B80
	sta.w $4DCA
	eor.w #$FFFF
	inc a
	sta.w $4DCC
	lda.w #$0100
	sta.w $4CC8
	lda.w #$4CC8
	ldx.w #$007E
	ldy.w #$F600
	jsl.l CODE_CF02A5
	lda.w #$0100
	sta.w $48B8
	lda.w #$48B8
	ldx.w #$007E
	ldy.w #$F480
	jsl.l CODE_CF02A5
	lda.w #$0080
	sta.w $5052
	lda.w #$5052
	ldx.w #$007E
	ldy.w #$F580
	jsl.l CODE_CF02A5
	lda.w #$0280
	sta.w $4DD0
	lda.w #$4DD0
	ldx.w #$007E
	ldy.w #$FD00
	jmp.w CODE_CF02A5
CODE_CF01E0:						; from CODE_CF0166, CODE_CF0345 and other segments
	and.w #$00FF
	tax
	lda.w $48BA,x
	and.w #$00FF
	bne CODE_CF0211
	lda.w $49BA
	inc.w $49BA
	sep #$20
	sta.w $48BA,x
	rep #$20
	asl a
	asl a
	tay
	txa
	asl a
	asl a
	tax
	lda.l SampleList,x
	sta.w $49BC,y
	lda.l SampleList+2,x
	sta.w $49BE,y
	tyx
	bra CODE_CF0214
CODE_CF0211:						; from CODE_CF01E0
	asl a
	asl a
	tax
CODE_CF0214:						; from CODE_CF01E0
	lda.w $49BC,x
	sta.b $30
	lda.w $49BE,x
	sta.b $32
	lda.b [$30]
	sta.w $4DD2,x
	ldy.w #$0002
	lda.b [$30],y
	sta.w $4DD4,x
	txa
	lsr a
	tax
	ldy.w #$0004
	lda.b [$30],y
	sta.w $4FD2,x
	ldy.w #$0006
CODE_CF0239:						; called from other segments
	lda.b [$30],y
	sta.w $5054,x
	txa
	asl a
	tax
	ldy.w #$0000
CODE_CF0244:						; from CODE_CF025F
	lda.w $4BC8,y
	cmp.b $30
	bne CODE_CF025F
	lda.w $4BCA,y
	cmp.b $32
	bne CODE_CF025F
	lda.w $4ED2,y
	sta.w $4ED2,x
	lda.w $4ED4,y
	sta.w $4ED4,x
	rtl
CODE_CF025F:						; from CODE_CF0244
	iny
	iny
	iny
	iny
	cpy.w #$0100
	bne CODE_CF0244
	lda.b $30
	sta.w $4BC8,x
	lda.b $32
	sta.w $4BCA,x
	clc
	ldy.w #$0008
	lda.b [$30],y
	beq CODE_CF027C
	adc.b $9F
CODE_CF027C:						; from CODE_CF025F
	sta.w $4ED4,x
	lda.b $9F
	sta.w $4ED2,x
	lda.b $30
	adc.w #$000A
	sta.b $30
CODE_CF028B:						; from CODE_CF0313 and other segments
	lda.b $9F
	tay
	clc
	adc.b [$30]
	bcs CODE_CF0298
	cmp.w #$F47F
	bcc CODE_CF029F
CODE_CF0298:						; from CODE_CF028B
	inc.w $4DCE
	lda.w #$0C00
	tay
CODE_CF029F:						; from CODE_CF028B
	sta.b $9F
	lda.b $30
	ldx.b $32
CODE_CF02A5:						; from CODE_CF0188 and other segments
	sta.b $2C
	stx.b $2E
	tya
	tyx
	sta.l $002141
	lda.b [$2C]
	tax
	ldy.w #$0002
	stz.b $A1
	sep #$20
	lda.b #$19
	sta.l $002143
	lda.b #$00
CODE_CF02C1:						; from CODE_CF02C1
	cmp.l $002143
	bne CODE_CF02C1
CODE_CF02C7:						; from CODE_CF02F2
	lda.b [$2C],y
	sta.l $002140
	iny
	lda.b [$2C],y
	sta.l $002141
	iny
	lda.b [$2C],y
	sta.l $002142
	iny
	lda.b $A1
	inc a
	bpl CODE_CF02E3
	and.b #$7F
CODE_CF02E3:						; from CODE_CF02C7
	sta.b $A1
	dex
	beq CODE_CF0302
	dex
	beq CODE_CF02FE
	dex
	beq CODE_CF02FA
	sta.l $002143
CODE_CF02F2:						; from CODE_CF02F2
	cmp.l $002143
	bne CODE_CF02F2
	bra CODE_CF02C7
CODE_CF02FA:						; from CODE_CF02E3
	lda.b #$83
	bra CODE_CF0304
CODE_CF02FE:						; from CODE_CF02E3
	lda.b #$82
	bra CODE_CF0304
CODE_CF0302:						; from CODE_CF02E3
	lda.b #$81
CODE_CF0304:						; from CODE_CF02FE, CODE_CF02FA
	sta.l $002143
	lda.b #$7E
CODE_CF030A:						; from CODE_CF030A
	cmp.l $002143
	bne CODE_CF030A
	rep #$20
	rtl
CODE_CF0313:						; from CODE_CF0178 and other segments
	and.w #$007F
	pei ($34)
	pei ($36)
	asl a
	tay
	asl a
	tax
	lda.b $9F
	sta.w $4CCA,y
	lda.l DATA8_CF04E3,x
	sta.b $30
	lda.l DATA8_CF04E3+2,x
	sta.b $32
	jsl.l CODE_CF028B
	lda.b $30
	sta.b $34
	lda.b $32
	sta.b $36
	ldy.w #$0003
	lda.b [$34],y
	and.w #$007F
	tax
	iny
CODE_CF0345:						; from CODE_CF0345
	lda.b [$34],y
	and.w #$00FF
	phx
	phy
	jsl.l CODE_CF01E0
	ply
	plx
	iny
	dex
	bne CODE_CF0345
	lda.b $34
	bmi CODE_CF0387
	xba
	and.w #$007F
	asl a
	tax
	lda.l DATA8_CF0583,x
	tax
CODE_CF0365:						; from CODE_CF0365
	lda.l $CF0000,x
	and.w #$00FF
	cmp.w #$0021
	bcs CODE_CF0387
	tay
	lda.w $48BA,y
	and.w #$00FF
	asl a
	asl a
	tay
	lda.l $CF0001,x
	sta.w $4DD4,y
	inx
	inx
	inx
	bra CODE_CF0365
CODE_CF0387:						; from CODE_CF0345, CODE_CF0365
	pla
	sta.b $36
	pla
	sta.b $34
	rtl
CODE_CF038E:						; called from other segments
	lda.w $1EA5
	bne CODE_CF039D
	lda.w #$0002
	sta.w $1EA5
	jml.l CODE_CF040B
CODE_CF039D:						; from CODE_CF038E
	rtl
CODE_CF039E:						; from CODE_CF04C0 and other segments
	jsr.w CODE_CF0402
	lda.w $059C
	beq CODE_CF03CF
	xba
	sta.b $9F
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b $A3
	ldx.w #$000F
CODE_CF03B2:						; from CODE_CF03B2
	sec
	lda.b $9F
	sbc.b $A3
	sta.b $9F
	and.w #$FF00
	sta.b $A1
	xba
	ora.b $A1
	tay
	lda.w #$0008
	jsl.l CODE_CF00E3
	dex
	bpl CODE_CF03B2
	stz.w $059C
CODE_CF03CF:						; from CODE_CF039E
	rtl
CODE_CF03D0:						; from CODE_CF04C0 and other segments
	jsr.w CODE_CF0402
	lda.w $059C
	cmp.w #$007F
	beq CODE_CF0401
	stz.b $9F
	ldx.w #$000F
CODE_CF03E0:						; from CODE_CF03EE
	lda.b $9F
	clc
	adc.w #$0808
	cmp.w #$7F80
	bcc CODE_CF03EE
	lda.w #$7F7F
CODE_CF03EE:						; from CODE_CF03E0
	sta.b $9F
	tay
	lda.w #$0008
	jsl.l CODE_CF00E3
	dex
	bpl CODE_CF03E0
	lda.w #$007F
	sta.w $059C
CODE_CF0401:						; from CODE_CF03D0
	rtl
CODE_CF0402:						; from CODE_CF039E, CODE_CF03D0, CODE_CF0402
	ldy.w $1EA3
	cpy.w $1EA1
	bne CODE_CF0402
	rts
CODE_CF040B:						; from CODE_CF038E, CODE_CF04A8, CODE_CF04C0 and other segments
	phx
	phy
	tax
	lda.w #$0001
	jsl.l CODE_CF00E3
	ply
	plx
	rtl
CODE_CF0418:						; called from other segments
	phx
	phy
	tax
	lda.w #$0003
	ldy.b $9F
	jsl.l CODE_CF00E3
	ply
	plx
	rtl
CODE_CF0427:						; called from other segments
	ldx.w #DATA8_CF0663>>16
	lda.w #DATA8_CF0663&$FFFF
	jsl.l CODE_CF0134
	lda.w $17C9
	asl a
	adc.w $17C9
	asl a
	tax
	lda.w #$50D4
	sta.b $2C
	ldy.w #$0005
CODE_CF0442:						; from CODE_CF045C
	lda.l TeamSongs,x
	and.w #$00FF
	cmp.w #$00FF
	bne CODE_CF045C
	phx
	lda.w #$0007
	jsl.l CODE_C58CCD
	tax
	lda.l DefaultSongs,x
	plx
CODE_CF045C:						; from CODE_CF0442
	sta.b ($2C)
	inc.b $2C
	inx
	dey
	bpl CODE_CF0442
	lda.w #$FFFF
	sta.b ($2C)
	lda.w #$50D4
	ldx.w #$007E
	jsl.l CODE_CF0162
	ldx.w #$001B
	lda.w $48BA,x
	and.w #$00FF
	asl a
	tax
	lda.w #$00E8
	sta.w $4FD2,x
	rtl
CODE_CF0485:						; called from other segments
	phx
	sta.b $9F
	bra CODE_CF04A8
CODE_CF048A:						; called from other segments
	phx
	sta.b $9F
	ldx.w #$03E8
CODE_CF0490:						; from CODE_CF0490
	dex
	bmi CODE_CF04B4
	lda.l $002143
	and.w #$00FF
	cmp.w #$007E
	bne CODE_CF0490
	lda.l $002142
	and.w #$0038
	bne CODE_CF04B4
CODE_CF04A8:						; from CODE_CF0485
	ldx.b $9F
	lda.w $50D4,x
	and.w #$00FF
	jsl.l CODE_CF040B
CODE_CF04B4:						; from CODE_CF0490
	plx
	rtl
CODE_CF04B6:						; called from other segments
	lda.w $1EA7
	bne CODE_CF04C0
	lda.w $1EA9
	beq CODE_CF04DC
CODE_CF04C0:						; from CODE_CF04B6
	stz.w $1EA7
	jsl.l CODE_CF039E
	ldx.w #DATA8_CF05D4>>16
	lda.w #DATA8_CF05D4&$FFFF
	jsl.l CODE_CF0134
	lda.w #$00A4
	jsl.l CODE_CF040B
	jsl.l CODE_CF03D0
CODE_CF04DC:						; from CODE_CF04B6
	lda.w #$0001
	sta.w $1EA9
	rtl
DATA8_CF04E3:						; the sounds (CODE_CF0313 reads entry A): a long pointer to the sound,
									; then a flag byte ($00, or $80-$83 for the last five; not traced)
	dd DATA8_CF0CDC					; sound 0
	dd DATA8_CF0679					; sound 1
	dd DATA8_CF0949					; sound 2
	dd DATA8_CF0AFB					; sound 3
	dd DATA8_CF0E46					; sound 4
	dd DATA8_CF1099					; sound 5
	dd DATA8_CF1284					; sound 6
	dd DATA8_CF1454					; sound 7
	dd DATA8_CF1582					; sound 8
	dd DATA8_CF1718					; sound 9
	dd DATA8_CF19C0					; sound 10
	dd DATA8_CF1BBF					; sound 11
	dd DATA8_CF1D38					; sound 12
	dd DATA8_CF1EFB					; sound 13
	dd DATA8_CF2123					; sound 14
	dd DATA8_CF2222					; sound 15
	dd DATA8_CF2443					; sound 16
	dd DATA8_CF25BA					; sound 17
	dd DATA8_CF2744					; sound 18
	dd DATA8_CF2844					; sound 19
	dd DATA8_CF2A6A					; sound 20
	dd DATA8_CF2CF5					; sound 21
	dd DATA8_CF2F75					; sound 22
	dd DATA8_CF319B					; sound 23
	dd DATA8_CF33DD					; sound 24
	dd DATA8_CF361F					; sound 25
	dd DATA8_CF37EE					; sound 26
	dd DATA8_CF3AB7					; sound 27
	dd DATA8_CF3D9D					; sound 28
	dd DATA8_CF3F79					; sound 29
	dd DATA8_CF410C					; sound 30
	dd DATA8_CF41BE					; sound 31
	dd DATA8_CF4351					; sound 32
	dd DATA8_CF4402					; sound 33
	dd $CFC262						; sound 34
	dd $CF5717|$80000000			; sound 35
	dd DATA8_CF46CE|$80000000		; sound 36
	dd $CF590B|$81000000			; sound 37
	dd $CF6A1A|$82000000			; sound 38
	dd $CF8145|$83000000			; sound 39
DATA8_CF0583:						; four lists in this bank (CODE_CF0313): records of a sample number
									; and a word, ended by a byte of $21 or more
	dw DATA8_CF058B&$FFFF,DATA8_CF059E&$FFFF,DATA8_CF05B1&$FFFF,DATA8_CF05C1&$FFFF
DATA8_CF058B:						; list 0 of DATA8_CF0583
	db $1C,$26,$26,$17,$2C,$2C,$1F,$3A,$3A,$1D,$20,$20,$1E,$29,$29,$19
	db $32,$32,$21
DATA8_CF059E:						; list 1 of DATA8_CF0583
	db $1C,$32,$32,$1F,$34,$34,$17,$29,$29,$1D,$1E,$1E,$19,$37,$37,$1E
	db $37,$37,$21
DATA8_CF05B1:						; list 2 of DATA8_CF0583
	db $1C,$32,$32,$17,$29,$29,$1F,$32,$32,$1E,$2D,$2D,$19,$37,$37,$21
DATA8_CF05C1:						; list 3 of DATA8_CF0583
	db $1C,$28,$28,$17,$2D,$2D,$1E,$32,$32,$1D,$28,$28,$1F,$2A,$2A,$19
	db $37,$37,$21
DATA8_CF05D4:						; a byte list ending in $FF; CODE_CF04B6 passes it to CODE_CF0134
	db $A3,$A4,$FF,$A5,$FF,$A6,$FF,$A7,$FF
SampleList:							; the 33 sound samples: a long pointer each (dd: then a zero);
									; CODE_CF01E0 sends sample A to the sound CPU
	dd Sample00						; sample 0
	dd Sample01						; sample 1
	dd Sample02						; sample 2
	dd Sample03						; sample 3
	dd Sample04						; sample 4
	dd Sample05						; sample 5
	dd $CFD29C						; sample 6
	dd Sample07						; sample 7
	dd Sample08						; sample 8
	dd Sample09						; sample 9
	dd Sample10						; sample 10
	dd Sample11						; sample 11
	dd Sample12						; sample 12
	dd Sample13						; sample 13
	dd Sample14						; sample 14
	dd Sample15						; sample 15
	dd Sample16						; sample 16
	dd Sample17						; sample 17
	dd Sample18						; sample 18
	dd Sample19						; sample 19
	dd Sample20						; sample 20
	dd Sample21						; sample 21
	dd Sample22						; sample 22
	dd $CFC561						; sample 23
	dd Sample24						; sample 24
	dd Sample25						; sample 25
	dd $CF95A4						; sample 26
	dd $CF95A4						; sample 27
	dd Sample28						; sample 28
	dd Sample29						; sample 29
	dd Sample30						; sample 30
	dd $CFAAAD						; sample 31
	dd Sample32						; sample 32
DATA8_CF0661:						; not traced (no reader found)
	db $A6,$FF
DATA8_CF0663:						; a byte list ending in $FF; CODE_CF0427 passes it to CODE_CF0134
	db $02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$01,$1A,$1B,$A2,$FF
DATA8_CF0679:						; sound 1 of DATA8_CF04E3: a length word, then its data; CODE_CF0313
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $02CE						; length of the data that follows
	incbin "../Extracted/segments/bankCF_0000.bin":$67B..$949
DATA8_CF0949:						; sound 2 of DATA8_CF04E3: a length word, then its data; CODE_CF0313
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $01B0						; length of the data that follows
	incbin "../Extracted/segments/bankCF_0000.bin":$94B..$AFB
DATA8_CF0AFB:						; sound 3 of DATA8_CF04E3: a length word, then its data; CODE_CF0313
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $01DF						; length of the data that follows
	incbin "../Extracted/segments/bankCF_0000.bin":$AFD..$CDC
DATA8_CF0CDC:						; sound 0 of DATA8_CF04E3: a length word, then its data; CODE_CF0313
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $0168						; length of the data that follows
	incbin "../Extracted/segments/bankCF_0000.bin":$CDE..$E46
DATA8_CF0E46:						; sound 4 of DATA8_CF04E3: a length word, then its data; CODE_CF0313
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $0251						; length of the data that follows
	incbin "../Extracted/segments/bankCF_0000.bin":$E48..$1000
	incbin "../Extracted/segments/bankCF_1000.bin":$0..$99

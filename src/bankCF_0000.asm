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
.loop:								; loop: if A is not $002143 go to .loop, $002140 = A, A 16-bit, ...
	cmp.l $002143
	bne .loop
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
	sta.b r0
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
	bra .1
.loop:								; loop: call CODE_CF00BD, call CODE_CF00B7, A + 1
	xba
	jsr.w CODE_CF00BD
	xba
	jsr.w CODE_CF00B7
	inc a
.1:									; A 16-bit, $2140 = A, A 8-bit, X - 1, ...
	rep #$20
	sta.w $2140
	sep #$20
	dex
	bne .loop
	jsr.w CODE_CF00B7
.loop2:								; loop: A + $03, if the result = 0 go to .loop2
	adc.b #$03
	beq .loop2
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
CODE_CF00B7:						; from SPCUpload, CODE_CF0098, CODE_CF00B7, CODE_CF0069, ...
	cmp.w $2140
	bne CODE_CF00B7
	rts
CODE_CF00BD:						; from CODE_CF0069
	lda.b [r0]
	ldy.b r0
	iny
	bne .1
	inc.b $2E
	ldy.w #$8000
.1:									; r0 = Y, return
	sty.b r0
	rts
CODE_CF00CC:						; from CODE_CF008B
	lda.b [r0]
	ldy.b r0
	iny
	bne .1
	inc.b $2E
	ldy.w #$8000
.1:									; Y + 1, if the result is not 0 go to .2, $2E + 1, Y = $8000
	iny
	bne .2
	inc.b $2E
	ldy.w #$8000
.2:									; r0 = Y, return
	sty.b r0
	rts
CODE_CF00E3:						; from CODE_CF039E, CODE_CF03D0, CODE_CF040B, ...
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
	bne .1
	rtl
.1:									; A = X, A + $0004, A and $00FF, $1EA3 = A, ...
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
CODE_CF0134:						; from CODE_CF0134, CODE_CF0427, CODE_CF04B6 and other segments
	ldy.w $1EA3
	cpy.w $1EA1
	bne CODE_CF0134
	wai
	stz.w $1EA5
	pha
	phx
	lda.w #$0C00
	sta.b tmp0
	ldx.w #$00FE
	lda.w #$FFFF
.loop:								; loop: $4BC8,x = A, $4CCA,x = A, $48BA,x = 0, X - 1, ...
	sta.w $4BC8,x
	sta.w $4CCA,x
	stz.w $48BA,x
	dex
	dex
	bpl .loop
	lda.w #$0001
	sta.w $49BA
	plx
	pla
CODE_CF0162:						; from CODE_CF0427 and other segments
	sta.b r2
	stx.b $36
.loop:								; loop: A = [r2], A and $00FF, if a $0080 bit set go to .1, r2 + 1, ...
	lda.b [r2]
	and.w #$00FF
	bit.w #$0080
	bne .1
	inc.b r2
	jsl.l CODE_CF01E0
	bra .loop
.1:									; if A = $00FF go to .2, r2 + 1, call CODE_CF0313, go to .loop
	cmp.w #$00FF
	beq .2
	inc.b r2
	jsl.l CODE_CF0313
	bra .loop
.2:									; A = tmp0
	lda.b tmp0
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
CODE_CF01E0:						; from CODE_CF0162, CODE_CF0313 and other segments
	and.w #$00FF
	tax
	lda.w $48BA,x
	and.w #$00FF
	bne .1
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
	bra .2
.1:									; A * 2, A * 2, X = A
	asl a
	asl a
	tax
.2:									; r1 = $49BC,x, $32 = $49BE,x, $4DD2,x = [r1], Y = $0002, ...
	lda.w $49BC,x
	sta.b r1
	lda.w $49BE,x
	sta.b $32
	lda.b [r1]
	sta.w $4DD2,x
	ldy.w #$0002
	lda.b [r1],y
	sta.w $4DD4,x
	txa
	lsr a
	tax
	ldy.w #$0004
	lda.b [r1],y
	sta.w $4FD2,x
	ldy.w #$0006
CODE_CF0239:						; called from other segments
	lda.b [r1],y
	sta.w $5054,x
	txa
	asl a
	tax
	ldy.w #$0000
.1:									; if $4BC8,y is not r1 go to .2, if $4BCA,y is not $32 go to .2, ...
	lda.w $4BC8,y
	cmp.b r1
	bne .2
	lda.w $4BCA,y
	cmp.b $32
	bne .2
	lda.w $4ED2,y
	sta.w $4ED2,x
	lda.w $4ED4,y
	sta.w $4ED4,x
	rtl
.2:									; Y + 1, Y + 1, Y + 1, Y + 1, ...
	iny
	iny
	iny
	iny
	cpy.w #$0100
	bne .1
	lda.b r1
	sta.w $4BC8,x
	lda.b $32
	sta.w $4BCA,x
	clc
	ldy.w #$0008
	lda.b [r1],y
	beq .3
	adc.b tmp0
.3:									; $4ED4,x = A, $4ED2,x = tmp0, A = r1, A + $000A, ...
	sta.w $4ED4,x
	lda.b tmp0
	sta.w $4ED2,x
	lda.b r1
	adc.w #$000A
	sta.b r1
CODE_CF028B:						; from CODE_CF0313 and other segments
	lda.b tmp0
	tay
	clc
	adc.b [r1]
	bcs .1
	cmp.w #$F47F
	bcc .2
.1:									; $4DCE + 1, A = $0C00, Y = A
	inc.w $4DCE
	lda.w #$0C00
	tay
.2:									; tmp0 = A, A = r1, X = $32
	sta.b tmp0
	lda.b r1
	ldx.b $32
CODE_CF02A5:						; from CODE_CF0188 and other segments
	sta.b r0
	stx.b $2E
	tya
	tyx
	sta.l $002141
	lda.b [r0]
	tax
	ldy.w #$0002
	stz.b tmp1
	sep #$20
	lda.b #$19
	sta.l $002143
	lda.b #$00
.loop:								; loop: if A is not $002143 go to .loop
	cmp.l $002143
	bne .loop
.loop2:								; loop: $002140 = [r0],y, Y + 1, $002141 = [r0],y, Y + 1, ...
	lda.b [r0],y
	sta.l $002140
	iny
	lda.b [r0],y
	sta.l $002141
	iny
	lda.b [r0],y
	sta.l $002142
	iny
	lda.b tmp1
	inc a
	bpl .1
	and.b #$7F
.1:									; tmp1 = A, X - 1, if the result = 0 go to .4, X - 1, ...
	sta.b tmp1
	dex
	beq .4
	dex
	beq .3
	dex
	beq .2
	sta.l $002143
.loop3:								; loop: if A is not $002143 go to .loop3, go to .loop2
	cmp.l $002143
	bne .loop3
	bra .loop2
.2:									; A = $83, go to .5
	lda.b #$83
	bra .5
.3:									; A = $82, go to .5
	lda.b #$82
	bra .5
.4:									; A = $81
	lda.b #$81
.5:									; $002143 = A, A = $7E
	sta.l $002143
	lda.b #$7E
.loop4:								; loop: if A is not $002143 go to .loop4, A 16-bit, return
	cmp.l $002143
	bne .loop4
	rep #$20
	rtl
CODE_CF0313:						; from CODE_CF0162 and other segments
	and.w #$007F
	pei ($34)
	pei ($36)
	asl a
	tay
	asl a
	tax
	lda.b tmp0
	sta.w $4CCA,y
	lda.l DATA8_CF04E3,x
	sta.b r1
	lda.l DATA8_CF04E3+2,x
	sta.b $32
	jsl.l CODE_CF028B
	lda.b r1
	sta.b r2
	lda.b $32
	sta.b $36
	ldy.w #$0003
	lda.b [r2],y
	and.w #$007F
	tax
	iny
.loop:								; loop: A = [r2],y, A and $00FF, push X, push Y, ...
	lda.b [r2],y
	and.w #$00FF
	phx
	phy
	jsl.l CODE_CF01E0
	ply
	plx
	iny
	dex
	bne .loop
	lda.b r2
	bmi .1
	xba
	and.w #$007F
	asl a
	tax
	lda.l DATA8_CF0583,x
	tax
.loop2:								; loop: A = $CF0000,x, A and $00FF, if A >= $0021 go to .1, Y = A, ...
	lda.l $CF0000,x
	and.w #$00FF
	cmp.w #$0021
	bcs .1
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
	bra .loop2
.1:									; pull A, $36 = A, pull A, r2 = A, ...
	pla
	sta.b $36
	pla
	sta.b r2
	rtl
CODE_CF038E:						; called from other segments
	lda.w $1EA5
	bne .rtl
	lda.w #$0002
	sta.w $1EA5
	jml.l CODE_CF040B
.rtl:								; return
	rtl
CODE_CF039E:						; from CODE_CF04B6 and other segments
	jsr.w CODE_CF0402
	lda.w $059C
	beq .rtl
	xba
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b tmp2
	ldx.w #$000F
.loop:								; loop: A = tmp0, A - tmp2, tmp0 = A, A and $FF00, ...
	sec
	lda.b tmp0
	sbc.b tmp2
	sta.b tmp0
	and.w #$FF00
	sta.b tmp1
	xba
	ora.b tmp1
	tay
	lda.w #$0008
	jsl.l CODE_CF00E3
	dex
	bpl .loop
	stz.w $059C
.rtl:								; return
	rtl
CODE_CF03D0:						; from CODE_CF04B6 and other segments
	jsr.w CODE_CF0402
	lda.w $059C
	cmp.w #$007F
	beq .rtl
	stz.b tmp0
	ldx.w #$000F
.loop:								; loop: A = tmp0, A + $0808, if A < $7F80 go to .1, A = $7F7F
	lda.b tmp0
	clc
	adc.w #$0808
	cmp.w #$7F80
	bcc .1
	lda.w #$7F7F
.1:									; tmp0 = A, Y = A, A = $0008, call CODE_CF00E3, ...
	sta.b tmp0
	tay
	lda.w #$0008
	jsl.l CODE_CF00E3
	dex
	bpl .loop
	lda.w #$007F
	sta.w $059C
.rtl:								; return
	rtl
CODE_CF0402:						; from CODE_CF039E, CODE_CF03D0, CODE_CF0402
	ldy.w $1EA3
	cpy.w $1EA1
	bne CODE_CF0402
	rts
CODE_CF040B:						; from CODE_CF038E, CODE_CF04A8, CODE_CF04B6 and other segments
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
	ldy.b tmp0
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
	sta.b r0
	ldy.w #$0005
.loop:								; loop: A = TeamSongs,x, A and $00FF, if A is not $00FF go to .1, ...
	lda.l TeamSongs,x
	and.w #$00FF
	cmp.w #$00FF
	bne .1
	phx
	lda.w #$0007
	jsl.l CODE_C58CCD
	tax
	lda.l DefaultSongs,x
	plx
.1:									; (r0) = A, r0 + 1, X + 1, Y - 1, ...
	sta.b (r0)
	inc.b r0
	inx
	dey
	bpl .loop
	lda.w #$FFFF
	sta.b (r0)
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
	sta.b tmp0
	bra CODE_CF04A8
CODE_CF048A:						; called from other segments
	phx
	sta.b tmp0
	ldx.w #$03E8
.loop:								; loop: X - 1, if the result < 0 go to CODE_CF04B4, A = $002143, ...
	dex
	bmi CODE_CF04B4
	lda.l $002143
	and.w #$00FF
	cmp.w #$007E
	bne .loop
	lda.l $002142
	and.w #$0038
	bne CODE_CF04B4
CODE_CF04A8:						; from CODE_CF0485
	ldx.b tmp0
	lda.w $50D4,x
	and.w #$00FF
	jsl.l CODE_CF040B
CODE_CF04B4:						; from CODE_CF048A
	plx
	rtl
CODE_CF04B6:						; called from other segments
	lda.w $1EA7
	bne .1
	lda.w $1EA9
	beq .2
.1:									; $1EA7 = 0, call CODE_CF039E, X = DATA8_CF05D4>>16, ...
	stz.w $1EA7
	jsl.l CODE_CF039E
	ldx.w #DATA8_CF05D4>>16
	lda.w #DATA8_CF05D4&$FFFF
	jsl.l CODE_CF0134
	lda.w #$00A4
	jsl.l CODE_CF040B
	jsl.l CODE_CF03D0
.2:									; $1EA9 = $0001, return
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
	dd DATA8_CFC262					; sound 34
	dd DATA8_CF5717|$80000000		; sound 35
	dd DATA8_CF46CE|$80000000		; sound 36
	dd DATA8_CF590B|$81000000		; sound 37
	dd DATA8_CF6A1A|$82000000		; sound 38
	dd DATA8_CF8145|$83000000		; sound 39
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
	dd Sample06						; sample 6
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
	dd Sample23						; sample 23
	dd Sample24						; sample 24
	dd Sample25						; sample 25
	dd Sample26						; sample 26
	dd Sample26						; sample 27
	dd Sample28						; sample 28
	dd Sample29						; sample 29
	dd Sample30						; sample 30
	dd Sample31						; sample 31
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

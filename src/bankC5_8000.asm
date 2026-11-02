; Segment bankC5_8000: the rest of the reset, Decompress and its formats, the LZSS and map set unpackers,
; the transfer queue helpers, HDMA set-up, then game code. Routines not traced to a job keep their address as
; a name.
org $C5800C
CODE_C5800C:						; called from other segments
	asl a
	tax
	lda.w $3E6E,x
	sta.b a3
	tax
	ldy.w $3654,x
	beq CODE_C5800C-3
	ldx.w #$0010
	stx.b $CF
	ldx.w #$0060
	stx.b $D1
	adc.w #$3660
	tax
	ldy.b $6D
	jsr.w CODE_C58091
	lda.w #$00F0
	sta.b $D1
	ldx.b a3
	lda.w $3654,x
	jsr.w BinToBCD
	jsr.w BCDText
	lda.w #$6220
	sta.w mesarea,x
	inx
	inx
	lda.w #$2079
	sta.w mesarea,x
	inx
	inx
	phx
	ldy.b a3
	lda.w $3656,y
	and.w #$00FF
	tax
	jsr.w CODE_C580B7
	jsl.l UnpackText
	ply
	jsr.w CODE_C5809A
	lda.w #$7620
	sta.w mesarea,y
	iny
	iny
	lda.w #$2073
	sta.w mesarea,y
	iny
	iny
	phy
	ldy.b a3
	lda.w $3657,y
	and.w #$00FF
	tax
	jsr.w CODE_C580B7
	jsl.l UnpackText
	ply
	jsr.w CODE_C5809A
	lda.w #$0000
	sta.w mesarea,y
	ldx.w #mesarea
	ldy.b $6D
CODE_C58091:						; from CODE_C5800C
	jsl.l PrintBoldCentredStr
	lda.b $D1
	sta.b $CF
	rts
CODE_C5809A:						; from CODE_C5800C
	sep #$20
.loop:								; loop: if $0000,x = 0 go to .1, mesarea,y = A, X + 1, Y + 1, ...
	lda.w $0000,x
	beq .1
	sta.w mesarea,y
	inx
	iny
	bra .loop
.1:									; A 16-bit, return
	rep #$20
	rts
CODE_C580AB:						; called from other segments
	ldy.w #$0006
	jsl.l PrintBoldCentred
	lda.b $D1
	sta.b $CF
	rts
CODE_C580B7:						; from CODE_C5800C
	asl a
	tax
	lda.l $C30000,x
	tax
	lda.l $C30002,x
	tax
	jmp.w CODE_C5611C
Reset_Fast:							; the rest of the reset: CPU and PPU registers, RAM, the hooks, ...
	lda.w #$0000
	sta.l MDMAEN
	lda.w #$1FFF
	tcs
	lda.w #$2100
	tcd
	sep #$30
	lda.b #$80
	pha
	plb
	stz.w NMITIMEN
	stz.w HTIMEL
	stz.w $4208
	stz.w VTIMEL
	stz.w VTIMEH
	stz.w MEMSEL
	sta.b INIDISP&$FF
	sta.w brightness
	stz.b TM&$FF
	stz.b TS&$FF
	stz.b SETINI&$FF
	lda.b #$01
	sta.b BGMODE&$FF
	stz.b MOSAIC&$FF
	ldx.b #$03
	stx.b OBSEL&$FF
	sta.b VMAIN&$FF
	stz.b CGWSEL&$FF
	stz.b CGADSUB&$FF
	stz.b COLDATA&$FF
	stz.b W12SEL&$FF
	stz.b W34SEL&$FF
	stz.b WOBJSEL&$FF
	ldx.b #$FF
	stx.b WH0&$FF
	stz.b WH1&$FF
	stx.b WH2&$FF
	stz.b WH3&$FF
	stz.b OAMADDL&$FF
	stz.b OAMADDH&$FF
	stz.b M7A&$FF
	stz.b M7A&$FF
	stz.b M7B&$FF
	stz.b OAMDATA&$FF
	stz.b BGMODE&$FF
	stz.b MOSAIC&$FF
	ldx.b #$01
	stx.w JOYSER0
	stz.w JOYSER0
	rep #$20
	lda.w #$8008
	sta.w DMAP0
	lda.w #ZeroFillWord
	sta.w A1T0L
	ldx.b #ZeroFillWord>>16
	stx.w A1B0
	stz.w DAS0L
	ldx.b #$7F
	stx.b WMADDH&$FF
	stz.b WMADDL&$FF
	ldx.b #$01
	stx.w MDMAEN
	stz.b WMADDL&$FF
	stz.b WMADDM&$FF
	lda.w #$2000
	sta.w DAS0L
	stx.w MDMAEN
	rep #$10
	lda.w #$DFC0
	sta.w DAS0L
	lda.w #$0001
	sta.w MDMAEN
	lda.w #$003F
	ldx.w #$FFC0
	txy
	mvn $7E,$C0
	jsr.w SetBGMapRegs
	db $58,$51,$5C,$5C,$02,$43		; inline parameters
	lda.w #$0000
	tcd
	jsl.l CODE_C4CEF5
	lda.w #$548B
	sta.w BlockMove
	lda.w #$6BAB
	sta.w BlockMove+4
	inc.w $1906
	jml.l Opening
SetBGMapRegs:						; BG1SC, BG2SC, BG3SC, BG4SC, BG12NBA, ...
	phb
	phk
	plb
	sep #$30
	ldy.b #$01
	lda.b ($02,s),y
	sta.l BG1SC
	iny
	lda.b ($02,s),y
	sta.l BG2SC
	iny
	lda.b ($02,s),y
	sta.l BG3SC
	iny
	lda.b ($02,s),y
	sta.l BG4SC
	iny
	lda.b ($02,s),y
	sta.l BG12NBA
	iny
	lda.b ($02,s),y
	sta.l BG34NBA
	rep #$31
	lda.b $02,s
	adc.w #$0006
	sta.b $02,s
	plb
	rts
DecompressUnpackbuf:				; Decompress X:A into unpackbuf
	ldy.w #unpackbuf
	sty.b r0
	ldy.w #unpackbuf>>16
	sty.b $2E
Decompress:							; unpack the set at X:A (size word, format word, stream) to [$2C]
	phb
	sta.b r1
	stx.b $32
	sep #$30
	lda.b #$54
	sta.b tmp0
	sta.b tmp2
	lda.b #$6B
	sta.b $A2
	sta.b $A6
	lda.b $2E
	sta.b $A4
	sta.b $A5
	sta.b $A0
	stx.b tmp1
	rep #$31
	lda.b r0
	sta.b $0C
	ldy.w #$0002
	lda.b [r1],y
	tax
	lda.b r1
	adc.w #$0003
	sta.b r1
	bcc .1
	inc.b $32
	clc
.1:									; jump through DecompressFormats,x
	jmp (DecompressFormats,x)
DecompressFormats:					; the format routines, by format word (0, 2, 4, 6, 8)
	dw UnpackFormat0,UnpackFormat2,UnpackFormat4,UnpackFormat6
	dw UnpackFormat8
UnpackFormat0:						; format 0: literal runs and copies from an absolute output offset
	lda.b [r1]
	bpl .1
	xba
	and.w #$007F
	beq .2
	sta.b $0A
	ldy.w #$0002
	lda.b [r1],y
	adc.b $0C
	tax
	lda.b r1
	adc.w #$0003
	sta.b r1
	ldy.b r0
	lda.b $0A
	jsl.l $0000A3
	lda.b r0
	adc.b $0A
	inc a
	sta.b r0
	bra UnpackFormat0
.1:									; A and $007F, $0A = A, A = r1, A + $0002, ...
	xba
	and.w #$007F
	sta.b $0A
	lda.b r1
	adc.w #$0002
	tax
	adc.b $0A
	sta.b r1
	lda.b $0A
	ldy.b r0
	jsl.l $00009F
	lda.b r0
	adc.b $0A
	inc a
	sta.b r0
	bra UnpackFormat0
.2:									; return
	plb
	rtl
UnpackFormat2:						; format 2: literal runs and copies from up to 10 bits back
	lda.b [r1]
	bpl .1
	xba
	and.w #$007F
	beq .2
	lsr a
	lsr a
	sta.b $0A
	ldy.w #$0001
	lda.b [r1],y
	xba
	and.w #$03FF
	sta.b $0C
	sec
	lda.b r0
	sbc.b $0C
	tax
	clc
	lda.b r1
	adc.w #$0002
	sta.b r1
	ldy.b r0
	lda.b $0A
	jsl.l $0000A3
	lda.b r0
	adc.b $0A
	inc a
	sta.b r0
	bra UnpackFormat2
.1:									; A and $007F, $0A = A, A = r1, A + $0002, ...
	xba
	and.w #$007F
	sta.b $0A
	lda.b r1
	adc.w #$0002
	tax
	adc.b $0A
	sta.b r1
	lda.b $0A
	ldy.b r0
	jsl.l $00009F
	lda.b r0
	adc.b $0A
	inc a
	sta.b r0
	bra UnpackFormat2
.2:									; return
	plb
	rtl
UnpackFormat4:						; format 4: literal runs and copies from up to 11 bits back
	lda.b [r1]
	bpl .1
	xba
	and.w #$007F
	lsr a
	lsr a
	lsr a
	beq .2
	sta.b $0A
	ldy.w #$0001
	lda.b [r1],y
	xba
	and.w #$07FF
	sta.b $0C
	sec
	lda.b r0
	sbc.b $0C
	tax
	clc
	lda.b r1
	adc.w #$0002
	sta.b r1
	ldy.b r0
	lda.b $0A
	jsl.l $0000A3
	lda.b r0
	adc.b $0A
	inc a
	sta.b r0
	bra UnpackFormat4
.1:									; A and $007F, $0A = A, A = r1, A + $0002, ...
	xba
	and.w #$007F
	sta.b $0A
	lda.b r1
	adc.w #$0002
	tax
	adc.b $0A
	sta.b r1
	lda.b $0A
	ldy.b r0
	jsl.l $00009F
	lda.b r0
	adc.b $0A
	inc a
	sta.b r0
	bra UnpackFormat4
.2:									; return
	plb
	rtl
UnpackFormat6:						; format 6: a flag byte per 8 runs or copies, up to 11 bits back
	inc.b r1
	bne .1
	inc.b $32
.1:									; A = [r1], A / 2, $0E = A, call UnpackFormat6Step, ...
	lda.b [r1]
	lsr a
	sta.b $0E
	jsr.w UnpackFormat6Step
	lsr.b $0E
	jsr.w UnpackFormat6Step
	lsr.b $0E
	jsr.w UnpackFormat6Step
	lsr.b $0E
	jsr.w UnpackFormat6Step
	lsr.b $0E
	jsr.w UnpackFormat6Step
	lsr.b $0E
	jsr.w UnpackFormat6Step
	lsr.b $0E
	jsr.w UnpackFormat6Step
	lsr.b $0E
	jsr.w UnpackFormat6Step
	bra UnpackFormat6
UnpackFormat6Step:					; one token of unpack format 6 by the flag bit in carry: set, a back
									; reference (length from the top 5 bits, 11-bit distance); clear, a
									; literal run (a count byte)
	bcc .1
	ldy.w #$0001
	lda.b [r1],y
	and.w #$00FF
	lsr a
	lsr a
	lsr a
	sta.b $0A
	lda.b [r1],y
	xba
	and.w #$07FF
	sta.b $0C
	sec
	lda.b r0
	sbc.b $0C
	tax
	clc
	lda.b r1
	adc.w #$0002
	sta.b r1
	ldy.b r0
	lda.b $0A
	adc.w #$0002
	jsl.l $0000A3
	lda.b r0
	adc.b $0A
	adc.w #$0003
	sta.b r0
	rts
.1:									; Y = $0001, A = [r1],y, if the result = 0 go to .2, A - 1, ...
	ldy.w #$0001
	lda.b [r1],y
	and.w #$00FF
	beq .2
	dec a
	sta.b $0A
	lda.b r1
	adc.w #$0002
	tax
	adc.b $0A
	sta.b r1
	lda.b $0A
	ldy.b r0
	jsl.l $00009F
	lda.b r0
	adc.b $0A
	inc a
	sta.b r0
	rts
.2:									; pull A, return
	pla
	plb
	rtl
UnpackFormat8:						; format 8: a flag byte per 8 runs or copies, up to 12 bits back
	inc.b r1
	bne .1
	inc.b $32
.1:									; A = [r1], A / 2, $0E = A, call UnpackFormat8Step, ...
	lda.b [r1]
	lsr a
	sta.b $0E
	jsr.w UnpackFormat8Step
	lsr.b $0E
	jsr.w UnpackFormat8Step
	lsr.b $0E
	jsr.w UnpackFormat8Step
	lsr.b $0E
	jsr.w UnpackFormat8Step
	lsr.b $0E
	jsr.w UnpackFormat8Step
	lsr.b $0E
	jsr.w UnpackFormat8Step
	lsr.b $0E
	jsr.w UnpackFormat8Step
	lsr.b $0E
	jsr.w UnpackFormat8Step
	bra UnpackFormat8
UnpackFormat8Step:					; one token of unpack format 8 by the flag bit in carry: set, a back
									; reference (length from the high nibble, 12-bit distance); clear, a
									; literal run (a count byte)
	bcc .1
	ldy.w #$0001
	lda.b [r1],y
	and.w #$00FF
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b $0A
	lda.b [r1],y
	xba
	and.w #$0FFF
	sta.b $0C
	sec
	lda.b r0
	sbc.b $0C
	tax
	clc
	lda.b r1
	adc.w #$0002
	sta.b r1
	ldy.b r0
	lda.b $0A
	adc.w #$0002
	jsl.l $0000A3
	lda.b r0
	adc.b $0A
	adc.w #$0003
	sta.b r0
	rts
.1:									; Y = $0001, A = [r1],y, if the result = 0 go to .2, A - 1, ...
	ldy.w #$0001
	lda.b [r1],y
	and.w #$00FF
	beq .2
	dec a
	sta.b $0A
	lda.b r1
	adc.w #$0002
	tax
	adc.b $0A
	sta.b r1
	lda.b $0A
	ldy.b r0
	jsl.l $00009F
	lda.b r0
	adc.b $0A
	inc a
	sta.b r0
	rts
.2:									; pull A, return
	pla
	plb
	rtl
DecompressLZSS:						; LZSS (4 KB ring) from [$2C] to the WRAM port at X:A; a count word first
	sta.l WMADDL
	sep #$20
	txa
	and.b #$01
	sta.l WMADDH
	rep #$20
CODE_C58467:						; from MapSetToWRAM
	ldx.w #$01FE
.loop:								; loop: $364E,x = 0, $384E,x = 0, $3A4E,x = 0, $3C4E,x = 0, ...
	stz.w $364E,x
	stz.w $384E,x
	stz.w $3A4E,x
	stz.w $3C4E,x
	stz.w $3E4E,x
	stz.w $404E,x
	stz.w $4266,x
	stz.w $4466,x
	dex
	dex
	bpl .loop
	lda.b [r0]
	sta.b p1
	lda.b r0
	clc
	adc.w #$0002
	bcc .1
	inc.b $2E
.1:									; r0 = A, $42 = 0, Y = $0FEE
	sta.b r0
	stz.b $42
	ldy.w #$0FEE
.loop2:								; loop: $42 / 2, A = $42, if the result is not 0 go to .3, A = [r0], ...
	lsr.b $42
	lda.b $42
	and.w #$0100
	bne .3
	lda.b [r0]
	inc.b r0
	bne .2
	inc.b $2E
.2:									; A or $FF00, $42 = A
	ora.w #$FF00
	sta.b $42
.3:									; A = $42, if the result = 0 go to .5, A = [r0], r0 + 1, ...
	lda.b $42
	and.w #$0001
	beq .5
	lda.b [r0]
	inc.b r0
	bne .4
	inc.b $2E
.4:									; A 8-bit, WMDATA = A, $364E,y = A, A 16-bit, ...
	sep #$20
	sta.l WMDATA
	sta.w $364E,y
	rep #$20
	iny
	tya
	and.w #$0FFF
	tay
	dec.b p1
	bne .loop2
	bra .rts
.5:									; A = [r0], A and $00FF, r0 + 1, if the result is not 0 go to .6, ...
	lda.b [r0]
	and.w #$00FF
	inc.b r0
	bne .6
	inc.b $2E
.6:									; $3E = A, A = [r0], r0 + 1, if the result is not 0 go to .7, ...
	sta.b $3E
	lda.b [r0]
	inc.b r0
	bne .7
	inc.b $2E
.7:									; X = A, A and $00F0, A * 2, A * 2, ...
	tax
	and.w #$00F0
	asl a
	asl a
	asl a
	asl a
	tsb.b $3E
	txa
	and.w #$000F
	adc.w #$0003
	sta.b r3
.loop3:								; loop: A = $3E, A and $0FFF, X = A, A 8-bit, ...
	lda.b $3E
	and.w #$0FFF
	tax
	sep #$20
	lda.w $364E,x
	sta.l WMDATA
	sta.w $364E,y
	rep #$20
	iny
	tya
	and.w #$0FFF
	tay
	dec.b p1
	beq .rts
	inc.b $3E
	dec.b r3
	bne .loop3
	jmp.w .loop2
.rts:								; return
	rts
MapSetToVRAM:						; the map set at X:A to VRAM at $9F (map words + $A1), ...
	jsr.w CODE_C5852B
	rtl
CODE_C5852B:						; from MapSetToVRAM
	sta.b r1
	stx.b $32
	sty.b tmp2
	sep #$20
	lda.b #$80
	sta.l VMAIN
	rep #$21
	lda.b r1
	adc.w #$0005
	sta.b r0
	lda.b $32
	adc.w #$0000
	sta.b $2E
	pea.w $0000
	ldy.w #$0004
	lda.b [r1],y
	bit.w #$0001
	bne .1
	bit.w #$0002
	beq .2
.1:									; continue
	brk #$00						; a trap: this header form is not handled
.2:									; if a $0004 bit set go to .3, go to CODE_C586CA
	bit.w #$0004
	bne .3
	jmp.w CODE_C586CA
.3:									; if $0080 bits clear go to .4, pull X, Y = $0005, A = [r1],y, ...
	bit.w #$0080
	beq .4
	plx
	ldy.w #$0005
	lda.b [r1],y
	inc a
	inc a
	pha
	jsl.l AllocWorkBuf
	pha
	inc a
	inc a
	ldx.w #$007E
	jsr.w DecompressLZSS
	pla
	sta.b r0
	lda.w #$007E
	sta.b $2E
.4:									; Y = $0005, A = [r1],y, A / 2, X = A, ...
	ldy.w #$0005
	lda.b [r1],y
	lsr a
	tax
	ldy.w #$0002
	lda.b [r1],y
	and.w #$00FF
	cmp.w #$0020
	beq .5
	cmp.w #$0040
	beq .6
	brk #$00						; a trap: this header form is not handled
.5:									; Y = $0002, VMADDL = tmp0
	ldy.w #$0002
	lda.b tmp0
	sta.l VMADDL
	clc
.loop:								; loop: A = [r0],y, A + tmp1, VMDATAL = A, Y + 1, ...
	lda.b [r0],y
	adc.b tmp1
	sta.l VMDATAL
	iny
	iny
	dex
	bne .loop
	bra .7
.6:									; Y = $0003, A = [r1],y, A and $00FF, $A5 = A, ...
	ldy.w #$0003
	lda.b [r1],y
	and.w #$00FF
	sta.b $A5
	ldy.w #$0002
	lda.b tmp0
.loop2:								; loop: VMADDL = A, X = $001F
	sta.l VMADDL
	ldx.w #$001F
	clc
.loop3:								; loop: A = [r0],y, A + tmp1, VMDATAL = A, Y + 1, ...
	lda.b [r0],y
	adc.b tmp1
	sta.l VMDATAL
	iny
	iny
	dex
	bpl .loop3
	lda.b tmp0
	adc.w #$0400
	sta.l VMADDL
	ldx.w #$001F
.loop4:								; loop: A = [r0],y, A + tmp1, VMDATAL = A, Y + 1, ...
	lda.b [r0],y
	adc.b tmp1
	sta.l VMDATAL
	iny
	iny
	dex
	bpl .loop4
	lda.b tmp0
	adc.w #$0020
	sta.b tmp0
	dec.b $A5
	bne .loop2
.7:									; pull A, call FreeWorkBuf, call CODE_C586B6, Y = $0004, ...
	pla
	jsl.l FreeWorkBuf
	jsr.w CODE_C586B6
	ldy.w #$0004
	lda.b [r1],y
	bit.w #$0080
	beq .8
	ldy.w #$0005
	lda.b [r1],y
	and.w #$00FF
	sta.b $A5
	ldy.w #$0006
	lda.b [r1],y
	and.w #$00FF
	cmp.b $A5
	bne .8
	ldy.w #$0007
	lda.b [r1],y
	and.w #$00FF
	beq .9
.8:									; continue
	brk #$00						; a trap: this header form is not handled
.9:									; A = $0008, Y = A, A + r1, r0 = A, ...
	clc
	lda.w #$0008
	tay
	adc.b r1
	sta.b r0
	lda.b $32
	adc.w #$0000
	sta.b $2E
	lda.b [r1],y
	sta.b $A5
	sta.b $0A
	lsr.b $0A
	pha
	jsl.l AllocWorkBuf
	pha
	ldx.w #$007E
	jsr.w DecompressLZSS
	pla
	sta.b r0
	lda.w #$007E
	sta.b $2E
	lda.b tmp2
	sta.l VMADDL
	ldy.w #$0000
.loop5:								; loop: VMDATAL = [r0],y, Y + 1, Y + 1, if Y < $A5 go to .loop5, ...
	lda.b [r0],y
	sta.l VMDATAL
	iny
	iny
	cpy.b $A5
	bcc .loop5
	pla
	jsl.l FreeWorkBuf
	jsr.w CODE_C586B6
	ldy.w #$0005
	lda.b [r1],y
	asl a
	tax
	ldy.w #$0003
	lda.b [r1],y
	tay
	lda.b tmp1
	and.w #$1C00
	lsr a
	lsr a
	xba
	sta.b tmp1
	lda.w #$0000
.loop6:								; loop: A + tmp1, Y - 1, if the result is not 0 go to .loop6, A 8-bit, ...
	adc.b tmp1
	dey
	bne .loop6
	sep #$20
	sta.l CGADD
	ldy.w #$0007
.loop7:								; loop: CGDATA = [r1],y, Y + 1, X - 1, ...
	lda.b [r1],y
	sta.l CGDATA
	iny
	dex
	bne .loop7
	rep #$31
	rts
CODE_C586B6:						; from CODE_C5852B, CODE_C586CA
	clc
	lda.b [r1]
	adc.b r1
	bcc .1
	inc.b $32
	clc
.1:									; A + $0002, r1 = A, if carry clear go to .rts, $32 + 1
	adc.w #$0002
	sta.b r1
	bcc .rts
	inc.b $32
.rts:								; return
	rts
CODE_C586CA:						; from CODE_C5852B
	bit.w #$0080
	bne .1
	brk #$00						; a trap: this header form is not handled
.1:									; A = $0005, Y = A, A + r1, r0 = A, ...
	clc
	lda.w #$0005
	tay
	adc.b r1
	sta.b r0
	lda.b $32
	adc.w #$0000
	sta.b $2E
	lda.b [r1],y
	pha
	jsl.l AllocWorkBuf
	pha
	ldx.w #$007E
	jsr.w DecompressLZSS
	pla
	sta.b r0
	lda.w #$007E
	sta.b $2E
	stz.b tmp2
	lda.w #$0000
	sta.l VMADDL
	sep #$20
	sta.l VMAIN
	ldy.w #$0003
	lda.b [r1],y
	sta.b $A5
	stz.b $A6
	ldy.w #$0002
	lda.b [r1],y
	sta.b tmp0
	stz.b $A0
	ldy.w #$0000
.loop:								; loop: X = tmp0
	ldx.b tmp0
.loop2:								; loop: VMDATAL = [r0],y, Y + 1, X - 1, ...
	lda.b [r0],y
	sta.l VMDATAL
	iny
	dex
	bne .loop2
	rep #$21
	lda.b tmp2
	adc.w #$0080
	sta.b tmp2
	sta.l VMADDL
	sep #$20
	dec.b $A5
	bne .loop
	rep #$20
	pla
	jsl.l FreeWorkBuf
	jsr.w CODE_C586B6
	ldy.w #$0004
	lda.b [r1],y
	bit.w #$0001
	bne .2
	bit.w #$0080
	beq .2
	ldy.w #$0005
	lda.b [r1],y
	and.w #$00FF
	cmp.w #$0008
	bne .2
	ldy.w #$0006
	lda.b [r1],y
	and.w #$00FF
	cmp.w #$0008
	bne .2
	ldy.w #$0007
	lda.b [r1],y
	and.w #$00FF
	cmp.w #$0003
	beq .3
.2:									; continue
	brk #$00						; a trap: this header form is not handled
.3:									; A = $0008, Y = A, A + r1, r0 = A, ...
	clc
	lda.w #$0008
	tay
	adc.b r1
	sta.b r0
	lda.b $32
	adc.w #$0000
	sta.b $2E
	lda.b [r1],y
	sta.b $A5
	pha
	jsl.l AllocWorkBuf
	pha
	ldx.w #$007E
	stx.b $2E
	jsr.w DecompressLZSS
	pla
	sta.b r0
	lda.w #$007E
	sta.b $2E
	lda.w #$0000
	sta.l VMADDL
	sep #$20
	lda.b #$80
	sta.l VMAIN
	ldy.w #$0000
.loop3:								; loop: VMDATAH = [r0],y, Y + 1, if Y < $A5 go to .loop3, A 16-bit, ...
	lda.b [r0],y
	sta.l VMDATAH
	iny
	cpy.b $A5
	bcc .loop3
	rep #$20
	pla
	jsl.l FreeWorkBuf
	jsr.w CODE_C586B6
	ldy.w #$0002
	lda.b [r1],y
	and.w #$00FF
	cmp.w #$0001
	bne .4
	ldy.w #$0003
	lda.b [r1],y
	cmp.w #$0100
	bne .4
	ldy.w #$0005
	lda.b [r1],y
	cmp.w #$0100
	beq .5
.4:									; continue
	brk #$00						; a trap: this header form is not handled
.5:									; A 8-bit, CGADD = $00, Y = $0007, X = $00FF
	sep #$20
	lda.b #$00
	sta.l CGADD
	ldy.w #$0007
	ldx.w #$00FF
.loop4:								; loop: CGDATA = [r1],y, Y + 1, CGDATA = [r1],y, Y + 1, ...
	lda.b [r1],y
	sta.l CGDATA
	iny
	lda.b [r1],y
	sta.l CGDATA
	iny
	dex
	bpl .loop4
	rep #$20
	rts
MapSetToUnpackbuf:					; MapSetToWRAM with the buffer unpackbuf
	ldy.w #unpackbuf
	sty.b r1
	ldy.w #unpackbuf>>16
	sty.b $32
MapSetToWRAM:						; unpacks the map set at X:A into the WRAM buffer at r1 (bank in $32): the
									; map, the tiles and the colours
	sta.b r2
	stx.b $36
	clc
	lda.b r2
	adc.w #$0005
	sta.b r0
	bcc .1
	inx
.1:									; $2E = X, A = r1, X = $32, call DecompressLZSS, ...
	stx.b $2E
	lda.b r1
	ldx.b $32
	jsr.w DecompressLZSS
	jsr.w CODE_C58874
	clc
	lda.b r2
	adc.w #$0008
	sta.b r0
	lda.b $36
	adc.w #$0000
	sta.b $2E
	jsr.w CODE_C58467
	jsr.w CODE_C58874
	clc
	lda.b r2
	adc.w #$0007
	sta.b r0
	lda.b $36
	adc.w #$0000
	sta.b $2E
	sec
	lda.b [r2]
	sbc.w #$0005
	tax
	ldy.w #$0000
	sep #$20
.loop:								; loop: WMDATA = [r0],y, Y + 1, X - 1, ...
	lda.b [r0],y
	sta.l WMDATA
	iny
	dex
	bne .loop
	rep #$20
	rtl
CODE_C58874:						; from MapSetToWRAM
	clc
	lda.b [r2]
	adc.b r2
	sta.b r2
	lda.b $36
	adc.w #$0000
	sta.b $36
	clc
	lda.b r2
	adc.w #$0002
	sta.b r2
	bcc .rts
	inc.b $36
.rts:								; return
	rts
CODE_C5888F:						; called from other segments
	sep #$20
	sta.l WRMPYA
	rep #$20
	txa
	bmi .1
	sta.l WRMPYB
	xba
	tax
	nop
	lda.l RDMPYL
	sta.b $14
	txa
	sta.l WRMPYB
	clc
	lda.b $15
	and.w #$00FF
	adc.l RDMPYL
	sta.b $15
	rts
.1:									; A xor $FFFF, A + 1, WRMPYB = A, X = A, ...
	eor.w #$FFFF
	inc a
	sta.l WRMPYB
	xba
	tax
	nop
	lda.l RDMPYL
	sta.b $14
	txa
	sta.l WRMPYB
	clc
	lda.b $15
	and.w #$00FF
	adc.l RDMPYL
	eor.w #$FF00
	sta.b $15
	lda.b $14
	eor.w #$FFFF
	inc a
	bne .2
	inc.b $16
.2:									; $14 = A, return
	sta.b $14
	rts
CODE_C588EB:						; called from other segments
	stx.b $2E
	sta.b r0
	stz.b r1
	sty.b $32
	stz.b r2
	stz.b $36
	ldy.w #$0010
	lda.b $32
.loop:								; loop: A * 2, Y + 1, if carry clear go to .loop, $32 = A
	asl a
	iny
	bcc .loop
	ror a
	sta.b $32
.loop2:								; loop: r2 * 2, if $2E < $32 go to .3, if not zero go to .1, ...
	asl.b r2
	rol.b $36
	lda.b $2E
	cmp.b $32
	bcc .3
	bne .1
	lda.b r0
	cmp.b r1
	bcs .2
	lsr.b $32
	ror.b r1
	dey
	bne .loop2
	lda.b r2
	ldx.b $36
	ldy.b r0
	rts
.1:									; A = r0
	lda.b r0
.2:									; A - r1, r0 = A, A = $2E, A - $32, ...
	sbc.b r1
	sta.b r0
	lda.b $2E
	sbc.b $32
	sta.b $2E
	lda.w #$0001
	tsb.b r2
.3:									; $32 / 2, Y - 1, if the result is not 0 go to .loop2, A = r2, ...
	lsr.b $32
	ror.b r1
	dey
	bne .loop2
	lda.b r2
	ldx.b $36
	ldy.b r0
	rts
DATA8_C58942:						; not reached by the traced code (data or unused code)
	db $DF,$22
CODE_C58944:						; called from other segments
	phx
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	pea.w $0200
	pea.w $0000
	pea.w $5800
	pea.w $1808
	pea.w DATA8_C58942>>16
	pea.w DATA8_C58942&$FFFF
	pea.w $0200
	pea.w $0080
	pea.w $5800
	pea.w $1908
	pea.w DATA8_C58942>>16
	pea.w (DATA8_C58942+1)&$FFFF
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	plx
	rtl
CODE_C5897B:						; called from other segments
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	pea.w $0400
	pea.w $0000
	pea.w $5800
	pea.w $1808
	pea.w DATA8_C58942>>16
	pea.w DATA8_C58942&$FFFF
	pea.w $0400
	pea.w $0080
	pea.w $5800
	pea.w $1908
	pea.w DATA8_C58942>>16
	pea.w (DATA8_C58942+1)&$FFFF
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	rtl
ClearVRAM:							; QueueClearVRAM, then WaitTransfers
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	pea.w $0400
	pea.w $0000
	phy
	pea.w $1808
	pea.w ZeroFillWord>>16
	pea.w ZeroFillWord
	pea.w $0400
	pea.w $0080
	phy
	pea.w $1908
	pea.w ZeroFillWord>>16
	pea.w ZeroFillWord
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	jml.l WaitTransfers
QueueClearVRAM:						; queues a clear of $400 words of VRAM at Y (two DMAs from ZeroFillWord:
									; the low bytes, then the high)
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	pea.w $0400
	pea.w $0000
	phy
	pea.w $1808
	pea.w ZeroFillWord>>16
	pea.w ZeroFillWord
	pea.w $0400
	pea.w $0080
	phy
	pea.w $1908
	pea.w ZeroFillWord>>16
	pea.w ZeroFillWord
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	rtl
QueueVRAMDMALen:					; queue a DMA to VRAM at Y of the bytes at X:A after their length byte
	sta.w r0
	stx.w $002E
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	lda.b [r0]
	and.w #$00FF
	pha
	pea.w $0000
	phy
	pea.w $1800
	pei ($2E)
	lda.b r0
	inc a
	pha
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	rtl
CODE_C58A3F:						; called from other segments
	lda.w #$0003
	sta.l BGMODE
	lda.w #$0011
	sta.l TM
	jsr.w SetBGMapRegs
	db $58,$50,$5C,$5C,$30,$00		; inline parameters
	ldy.w #$5800
	jsr.w ClearVRAM
	ldy.w #$0000
	jsr.w ClearVRAM
	rtl
ZeroFillWord:						; the zero word the VRAM clears DMA from (fixed source)
	db $00,$00
DecompressToVRAM:					; Decompress A:X into a $1000 byte heap block and queue it to VRAM at Y
	phy
	tay
	lda.w #$1000
	jsl.l AllocWorkBuf
	pha
	sta.b r0
	lda.w #$007E
	sta.b $2E
	tya
	jsl.l Decompress
	ply
	plx
	stx.b tmp0
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $1000
	pei ($9F)
	pea.w $007E
	phy
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rtl
FadeOutWait:						; fadestep = $FFFF, then wait until the screen is black (94S FadeOut, ...
	lda.w #$FFFF
	sta.w fadestep
.loop:								; loop: if brightness-1 >= 0 go to .loop, return
	lda.w brightness-1
	bpl .loop
	rtl
SetupHDMA:							; HDMA channel X from the 6 bytes after the jsl: DMAP, BBAD, source, ...
	phb
	sep #$20
	lda.b $04,s
	pha
	plb
	ldy.w #$0001
	rep #$21
	lda.b ($02,s),y
	sta.l DMAP0,x
	iny
	iny
	lda.b ($02,s),y
	sta.l A1T0L,x
	iny
	iny
	lda.b ($02,s),y
	sta.l A1B0,x
	ldy.w #$0006
	lda.b ($02,s),y
	sta.l $004307,x
	lda.b $02,s
	adc.w #$0006
	sta.b $02,s
	plb
	rtl
DivAByX:							; A = A / X (X 8-bit) by the divider registers, X = the remainder
	sta.l WRDIVL
	sep #$20
	txa
	sta.l WRDIVB
	rep #$20
	pha
	xba
	pla
	lda.l RDMPYL
	tax
	lda.l RDDIVL
	rtl
CODE_C58AF3:						; called from other segments
	pha
	txa
	xba
	ora.w #$007E
	sta.w BlockMove+2
	tyx
	lda.b $06,s
	tay
	txa
	dec a
	plx
	jsl.l BlockMove
	lda.b $02,s
	sta.b $04,s
	lda.b $01,s
	sta.b $03,s
	pla
	rtl
ClearRAM7E:							; clears Y bytes at A in bank $7E: a zero, then a block move through the
									; RAM routine
	phy
	tax
	inc a
	tay
	sep #$20
	lda.b #$00
	sta.l $7E0000,x
	rep #$20
	lda.w #$7E7E
	sta.w BlockMove+2
	pla
	dec a
	jml.l BlockMove
CODE_C58B2B:						; called from other segments
	lda.w #$0000
CODE_C58B2E:						; called from other segments
	inc.b QueueBusy
	pha
	sep #$20
	lda.b #$00
	sta.l CGADD
	pla
	sta.l CGDATA
	pla
	sta.l CGDATA
	rep #$20
	dec.b QueueBusy
	rtl
SetupMode7Screen:					; a mode 7 screen: fade out, the work buffer reset, BGMODE 7, M7SEL, the
									; mode 7 scroll and matrix registers, OBSEL, TM
	jsl.l FadeOutWait
	jsl.l WaitTransfers
	jsl.l ResetWorkBuf
	jsl.l ResetSprites
	pea.w $7E80
	plb
	sep #$20
	lda.b #$07
	sta.w BGMODE
	lda.b #$80
	sta.w $211A
	sta.l $0018D6
	lda.b #$03
	sta.w OBSEL
	lda.b #$17
	sta.w TM
	stz.w $210D
	stz.w $210D
	lda.b #$FF
	sta.w $210E
	sta.w $210E
	stz.w $211C
	stz.w $211C
	stz.w $211D
	stz.w $211D
	lda.b #$80
	sta.w VMAIN
	lda.b #$09
	sta.w DMAP0
	lda.b #$18
	sta.w $4301
	lda.b #$00
	sta.w A1B0
	ldx.w #$1900
	stx.w A1T0L
	lda.b #$01
	sta.w MDMAEN
	rep #$20
	plb
	lda.w #$0100
	sta.w $18D0
	rtl
CODE_C58BB9:						; called from other segments
	sta.b r0
	stx.b $2E
	lda.b [r0]
	and.w #$00FF
	sta.b tmp0
	inc a
	jsl.l AllocWorkBuf2
	pha
	tax
	ldy.w #$0001
	sep #$20
.loop:								; loop: A = [r0],y, A xor $80, $0000,x = A, Y + 1, ...
	lda.b [r0],y
	eor.b #$80
	sta.w $0000,x
	iny
	inx
	dec.b tmp0
	bne .loop
	stz.w $0000,x
	rep #$20
	plx
	rtl
SetupMode1Screen:					; a mode 1 screen: the work buffer reset, the BG map registers
									; (SetBGMapRegs), BGMODE 1, TM, the BG scrolls
	jsl.l WaitTransfers
	jsl.l ResetWorkBuf
	jsl.l ResetSprites
	jsr.w SetBGMapRegs
	db $58,$51,$5C,$5C,$02,$43		; inline parameters
	pea.w $7E80
	plb
	sep #$20
	lda.b #$01
	sta.w BGMODE
	lda.b #$03
	sta.w TM
	stz.w $210D
	stz.w $210D
	stz.w $210F
	stz.w $210F
	lda.b #$FF
	sta.w $210E
	sta.w $210E
	sta.w $2110
	sta.w $2110
	rep #$20
	plb
	stz.w BG1HScroll
	stz.w BG2HScroll
	lda.w #$FFFF
	sta.w BG1VScroll
	sta.w BG2VScroll
	rtl
Framer:								; draws a frame X tiles wide and Y high (its corners, edges and inside) to
									; the VRAM map at A, queued row by row
	sty.b tmp2
	stx.b tmp1
	sta.b tmp0
	txa
	dec a
	dec a
	asl a
	tax
	lda.w #$22FC
	sta.w $3650,x
	lda.w #$22DE
.loop:								; loop: $364E,x = A, X - 1, X - 1, if the result is not 0 go to .loop, ...
	sta.w $364E,x
	dex
	dex
	bne .loop
	lda.w #$22FB
	sta.w $364E,x
	lda.b tmp1
	asl a
	tax
	lda.w #$22FD
	sta.w $364E,x
	lda.w #$22A0
	ldy.b tmp1
	dey
.loop2:								; loop: $3650,x = A, X + 1, X + 1, Y - 1, ...
	sta.w $3650,x
	inx
	inx
	dey
	bne .loop2
	lda.w #$22FE
	sta.w $364E,x
	lda.w #$22FF
	sta.w $3650,x
	lda.w #$22E0
	ldy.b tmp1
	dey
.loop3:								; loop: $3652,x = A, X + 1, X + 1, Y - 1, ...
	sta.w $3652,x
	inx
	inx
	dey
	bne .loop3
	lda.w #$229F
	sta.w $3650,x
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.b tmp1
	asl a
	sta.b tmp1
	pha
	lda.b tmp0
	pha
	adc.w #$0020
	tay
	pea.w $007E
	lda.w #$364E
	pha
	adc.b tmp1
	tax
	tya
.loop4:								; loop: push A, A + $0020, push X, tmp2 - 1, ...
	pei ($A1)
	pha
	adc.w #$0020
	pea.w $007E
	phx
	dec.b tmp2
	bne .loop4
	pla
	adc.b tmp1
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jml.l WaitTransfers
RandomBelowA:						; A = a random number below A: the next byte of its generator divided by
									; A, the remainder
	sep #$20
	pha
	lda.w $4671
	adc.b #$12
	asl a
	asl a
	asl a
	eor.w $4671
	asl a
	asl a
	rol.w $466E
	rol.w $466F
	rol.w $4670
	rol.w $4671
	rep #$20
	lda.w $466F
	and.w #$00FF
	sta.l WRDIVL
	sep #$20
	pla
	sta.l WRDIVB
	rep #$20
	pha
	pla
	lda.l RDMPYL
	rtl
CODE_C58D05:						; from CODE_C58D05
	lda.l $002137
	sep #$20
	lda.l $00213C
	sta.w $466E
	lda.l $00213C
	sta.w $466F
	lda.l $00213D
	sta.w $4670
	lda.l $00213D
	sta.w $4671
	rep #$20
	lda.w $466E
	ora.w $4670
	beq CODE_C58D05
	rtl
GameSetUp:							; the game setup screen (setoptions builds it): up / down pick a line,
									; left / right change it, start / select run the play mode (DATA8_C58DD0);
									; 360 frames with no key start the demo (StartDemo)
	jsr.w setoptions
	lda.w $23BA
	beq .1
	jsl.l LoadSavedGameOptions
.1:									; fadestep = 0, $23BA = 0, $23BC = 0
	stz.w fadestep
	stz.w $23BA
.reenter:							; the idle count cleared, ...
									; after Start New
	stz.w $23BC
.loop:								; loop: TransfersReady + 1
	inc.w TransfersReady
.loop2:								; loop: if TransfersReady is not 0 go to .loop2, call ReadMenuPads, ...
	lda.w TransfersReady
	bne .loop2
	jsl.l ReadMenuPads
	inc.b $26
	ldx.b $99
	jsr (DATA8_C58DF0,x)
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	lda.b $99
	bne .loop
	lda.w repeatdelayframes
	beq .2
	cmp.w #$0014
	bcc .loop
	lda.w #$000F
	sta.w repeatdelayframes
	bra .3
.2:									; $23BC = 0
	stz.w $23BC
.3:									; A = padchangeany, if $0800 bits clear go to .4, call CODE_C58EE0, ...
	lda.w padchangeany
	bit.w #$0800
	beq .4
	jsr.w CODE_C58EE0
	bra .8
.4:									; if $0400 bits clear go to .5, call CODE_C58F28, go to .8
	bit.w #$0400
	beq .5
	jsr.w CODE_C58F28
	bra .8
.5:									; if $0200 bits clear go to .6, call CODE_C58FD8, go to .8
	bit.w #$0200
	beq .6
	jsr.w CODE_C58FD8
	bra .8
.6:									; if $0100 bits clear go to .7, call CODE_C59012, go to .8
	bit.w #$0100
	beq .7
	jsr.w CODE_C59012
	bra .8
.7:									; if $3000 bits clear go to .8, A = OptPlayMode, A * 2, X = A, ...
	bit.w #$3000
	beq .8
	lda.w OptPlayMode
	asl a
	tax
	jmp (DATA8_C58DD0,x)
.8:									; A = $23BC, A + 1, if A >= $0168 go to StartDemo, $23BC = A, ...
	lda.w $23BC
	inc a
	cmp.w #$0168
	bcs StartDemo
	sta.w $23BC
	jmp.w .loop
DATA8_C58DD0:						; the routine of each play mode, run on start in the setup screen:
									; Exhibition, Practice, Season, Trades, Free Agent, Release, Make Player,
									; then an eighth
	dw CODE_C593B1,CODE_C5939D,StartSeason,TradePlayers
	dw SignFreeAgents,ReleasePlayers,CreatePlayer,CODE_C5ABA1
StartDemo:							; starts the demo: the demo flag set, user records off, play mode
									; Exhibition, then the controller setup (CODE_C593B1)
	lda.w #$0001
	sta.l $7E23BA
	stz.w $1904
	stz.w OptPlayMode
	jmp.w CODE_C593B1
DATA8_C58DF0:						; jump table: the routine for each index
	dw CODE_C59052,CODE_C58DF6,CODE_C58E71
CODE_C58DF6:						; from DATA8_C58DF0
	lda.w $4692
	and.w #$00FF
	cmp.w #$0010
	bne .1
	lda.w $0106
	dec a
	sta.w $0108
	lda.w $0104
	dec a
	sta.w $0106
	lda.w $0102
	dec a
	sta.w $0104
	lda.w $0100
	dec a
	sta.w $0102
	clc
	lda.w $0110
	adc.w #$004F
	sta.w $0100
	sep #$20
	lda.b #$01
	sta.w $4692
	lda.b #$10
	sta.w $469B
	dec a
	sta.w $469E
	rep #$20
	rts
.1:									; $0100 - 1, $0102 - 1, $0104 - 1, $0106 - 1, ...
	dec.w $0100
	dec.w $0102
	dec.w $0104
	dec.w $0106
	dec.w $0108
	sep #$20
	inc a
	sta.w $4692
	lda.w $469E
	dec a
	bne .2
	lda.b #$0F
	sta.w $469B
	rep #$20
	lda.w $0108
	sta.w $0110
	lda.w $0106
	sta.w $0108
	stz.b $99
	rts
.2:									; $469E = A, A 16-bit, return
	sta.w $469E
	rep #$20
	rts
CODE_C58E71:						; from DATA8_C58DF0
	sep #$20
	lda.w $4692
	dec a
	beq .3
	sta.w $4692
	lda.b #$10
	cmp.w $469B
	beq .1
	sta.w $469B
	bra .2
.1:									; $469E + 1
	inc.w $469E
.2:									; A 16-bit, A = $0110, A + 1, $0108 = A, ...
	rep #$20
	lda.w $0110
	inc a
	sta.w $0108
	sta.w $0110
	inc.w $0100
	inc.w $0102
	inc.w $0104
	inc.w $0106
	rts
.3:									; $4692 = $10, A - 1, $469B = A, $469E = $01, ...
	lda.b #$10
	sta.w $4692
	dec a
	sta.w $469B
	lda.b #$01
	sta.w $469E
	rep #$20
	sec
	lda.w $0100
	sbc.w #$004F
	sta.w $0110
	lda.w $0102
	inc a
	sta.w $0100
	lda.w $0104
	inc a
	sta.w $0102
	lda.w $0106
	inc a
	sta.w $0104
	lda.w $0108
	inc a
	sta.w $0106
	sta.w $0108
	stz.b $99
	rts
CODE_C58EE0:						; from GameSetUp
	lda.b d6
	beq .rts
	dec a
	sta.b d6
	bne .1
	ldx.b a4
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
.1:									; call CODE_C5909A, A = $010E, A - 1, A - 1, ...
	jsr.w CODE_C5909A
	lda.w $010E
	dec a
	dec a
	cmp.w #$0010
	bcs .2
	lda.w #$0018
.2:									; $010E = A, X = a0, A = $08,x, A - $0010, ...
	sta.w $010E
	sec
	ldx.b a0
	lda.b $08,x
	sbc.w #$0010
	cmp.w #$008C
	bcs .3
	ldx.b $75
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	lda.w #$0002
	sta.b $99
	bra CODE_C58F75
.3:									; $08,x = A, call CODE_C590B8
	sta.b $08,x
	jsr.w CODE_C590B8
.rts:								; return
	rts
CODE_C58F28:						; from GameSetUp
	lda.b d6
	inc a
	cmp.b $69
	bcc .1
	jmp.w CODE_C58FD7
.1:									; d6 = A, A + 1, if A < $69 go to .2, if A < $0005 go to .2, ...
	sta.b d6
	inc a
	cmp.b $69
	bcc .2
	cmp.w #$0005
	bcc .2
	ldx.b $75
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
.2:									; call CODE_C5909A, A = $010E, A + 1, A + 1, ...
	jsr.w CODE_C5909A
	lda.w $010E
	inc a
	inc a
	cmp.w #$001A
	bcc .3
	lda.w #$0010
.3:									; $010E = A, X = a0, A = $08,x, A + $0010, ...
	sta.w $010E
	clc
	ldx.b a0
	lda.b $08,x
	adc.w #$0010
	cmp.w #$00CC
	bcc CODE_C58FD2
	ldx.b a4
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	lda.w #$0004
	sta.b $99
CODE_C58F75:						; from CODE_C58EE0
	lda.w $010E
	xba
	lsr a
	lsr a
	adc.b $D3
	ldy.w #$0080
	jsl.l ClearRAM7E
	lda.w #$0010
	sta.b $CF
	lda.b d6
	asl a
	asl a
	asl a
	adc.b a3
	tax
	phx
	lda.l $C30002,x
	tax
	ldy.w $010E
	jsl.l PrintItalicLeft
	plx
	lda.w #$0094
	sta.b $CF
	lda.l $C30006,x
	tay
	lda.w $0000,y
	inc a
	asl a
	adc.l $C30004,x
	tax
	lda.l $C30000,x
	tax
	ldy.w $010E
	lda.w OptPlayMode
	cmp.w #$0007
	bne .1
	jsl.l PrintItalicRight
	bra .2
.1:									; call PrintItalicCentred
	jsl.l PrintItalicCentred
.2:									; call SendTextMap, return
	jsl.l SendTextMap
	rts
CODE_C58FD2:						; from CODE_C58F28
	sta.b $08,x
	jsr.w CODE_C590B8
CODE_C58FD7:						; from CODE_C58F28
	rts

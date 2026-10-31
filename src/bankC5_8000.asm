; Segment bankC5_8000: the rest of the reset, Decompress and its formats, the LZSS and map set unpackers,
; the transfer queue helpers, HDMA set-up, then game code. Routines not traced to a job keep their address as
; a name.
org $C5800C
CODE_C5800C:						; called from other segments
	asl a
	tax
	lda.w $3E6E,x
	sta.b $6F
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
	ldx.b $6F
	lda.w $3654,x
	jsr.w CODE_C5B67A
	jsr.w $5EC7
	lda.w #$6220
	sta.w $04F5,x
	inx
	inx
	lda.w #$2079
	sta.w $04F5,x
	inx
	inx
	phx
	ldy.b $6F
	lda.w $3656,y
	and.w #$00FF
	tax
	jsr.w CODE_C580B7
	jsl.l $C4C3BA
	ply
	jsr.w CODE_C5809A
	lda.w #$7620
	sta.w $04F5,y
	iny
	iny
	lda.w #$2073
	sta.w $04F5,y
	iny
	iny
	phy
	ldy.b $6F
	lda.w $3657,y
	and.w #$00FF
	tax
	jsr.w CODE_C580B7
	jsl.l $C4C3BA
	ply
	jsr.w CODE_C5809A
	lda.w #$0000
	sta.w $04F5,y
	ldx.w #$04F5
	ldy.b $6D
CODE_C58091:						; from CODE_C5800C
	jsl.l $C4BBF1
	lda.b $D1
	sta.b $CF
	rts
CODE_C5809A:						; from CODE_C5800C
	sep #$20
CODE_C5809C:						; from CODE_C5809C
	lda.w $0000,x
	beq CODE_C580A8
	sta.w $04F5,y
	inx
	iny
	bra CODE_C5809C
CODE_C580A8:						; from CODE_C5809C
	rep #$20
	rts
CODE_C580AB:						; called from other segments
	ldy.w #$0006
	jsl.l $C4BBE5
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
	jmp.w $611C
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
	sta.b $00
	sta.w brightness
	stz.b $2C
	stz.b $2D
	stz.b $33
	lda.b #$01
	sta.b $05
	stz.b QueueBusy
	ldx.b #$03
	stx.b $01
	sta.b $15
	stz.b $30
	stz.b $31
	stz.b $32
	stz.b $23
	stz.b $24
	stz.b $25
	ldx.b #$FF
	stx.b $26
	stz.b $27
	stx.b $28
	stz.b $29
	stz.b $02
	stz.b $03
	stz.b $1B
	stz.b $1B
	stz.b $1C
	stz.b $04
	stz.b $05
	stz.b QueueBusy
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
	stx.b $83
	stz.b $81
	ldx.b #$01
	stx.w MDMAEN
	stz.b $81
	stz.b $82
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
	jsl.l $C4CEF5
	lda.w #$548B
	sta.w $18FA
	lda.w #$6BAB
	sta.w $18FE
	inc.w $1906
	jml.l $C50000
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
	sty.b $2C
	ldy.w #unpackbuf>>16
	sty.b $2E
Decompress:							; unpack the set at X:A (size word, format word, stream) to [$2C]
	phb
	sta.b $30
	stx.b $32
	sep #$30
	lda.b #$54
	sta.b $9F
	sta.b $A3
	lda.b #$6B
	sta.b $A2
	sta.b $A6
	lda.b $2E
	sta.b $A4
	sta.b $A5
	sta.b $A0
	stx.b $A1
	rep #$31
	lda.b $2C
	sta.b $0C
	ldy.w #$0002
	lda.b [$30],y
	tax
	lda.b $30
	adc.w #$0003
	sta.b $30
	bcc CODE_C58216
	inc.b $32
	clc
CODE_C58216:						; from Decompress
	jmp (DecompressFormats,x)
DecompressFormats:					; the format routines, by format word (0, 2, 4, 6, 8)
	dw UnpackFormat0,UnpackFormat2,UnpackFormat4,UnpackFormat6
	dw UnpackFormat8
UnpackFormat0:						; format 0: literal runs and copies from an absolute output offset
	lda.b [$30]
	bpl CODE_C5824F
	xba
	and.w #$007F
	beq CODE_C58270
	sta.b $0A
	ldy.w #$0002
	lda.b [$30],y
	adc.b $0C
	tax
	lda.b $30
	adc.w #$0003
	sta.b $30
	ldy.b $2C
	lda.b $0A
	jsl.l $0000A3
	lda.b $2C
	adc.b $0A
	inc a
	sta.b $2C
	bra UnpackFormat0
CODE_C5824F:						; from UnpackFormat0
	xba
	and.w #$007F
	sta.b $0A
	lda.b $30
	adc.w #$0002
	tax
	adc.b $0A
	sta.b $30
	lda.b $0A
	ldy.b $2C
	jsl.l $00009F
	lda.b $2C
	adc.b $0A
	inc a
	sta.b $2C
	bra UnpackFormat0
CODE_C58270:						; from UnpackFormat0
	plb
	rtl
UnpackFormat2:						; format 2: literal runs and copies from up to 10 bits back
	lda.b [$30]
	bpl CODE_C582AA
	xba
	and.w #$007F
	beq CODE_C582CB
	lsr a
	lsr a
	sta.b $0A
	ldy.w #$0001
	lda.b [$30],y
	xba
	and.w #$03FF
	sta.b $0C
	sec
	lda.b $2C
	sbc.b $0C
	tax
	clc
	lda.b $30
	adc.w #$0002
	sta.b $30
	ldy.b $2C
	lda.b $0A
	jsl.l $0000A3
	lda.b $2C
	adc.b $0A
	inc a
	sta.b $2C
	bra UnpackFormat2
CODE_C582AA:						; from UnpackFormat2
	xba
	and.w #$007F
	sta.b $0A
	lda.b $30
	adc.w #$0002
	tax
	adc.b $0A
	sta.b $30
	lda.b $0A
	ldy.b $2C
	jsl.l $00009F
	lda.b $2C
	adc.b $0A
	inc a
	sta.b $2C
	bra UnpackFormat2
CODE_C582CB:						; from UnpackFormat2
	plb
	rtl
UnpackFormat4:						; format 4: literal runs and copies from up to 11 bits back
	lda.b [$30]
	bpl CODE_C58306
	xba
	and.w #$007F
	lsr a
	lsr a
	lsr a
	beq CODE_C58327
	sta.b $0A
	ldy.w #$0001
	lda.b [$30],y
	xba
	and.w #$07FF
	sta.b $0C
	sec
	lda.b $2C
	sbc.b $0C
	tax
	clc
	lda.b $30
	adc.w #$0002
	sta.b $30
	ldy.b $2C
	lda.b $0A
	jsl.l $0000A3
	lda.b $2C
	adc.b $0A
	inc a
	sta.b $2C
	bra UnpackFormat4
CODE_C58306:						; from UnpackFormat4
	xba
	and.w #$007F
	sta.b $0A
	lda.b $30
	adc.w #$0002
	tax
	adc.b $0A
	sta.b $30
	lda.b $0A
	ldy.b $2C
	jsl.l $00009F
	lda.b $2C
	adc.b $0A
	inc a
	sta.b $2C
	bra UnpackFormat4
CODE_C58327:						; from UnpackFormat4
	plb
	rtl
UnpackFormat6:						; format 6: a flag byte per 8 runs or copies, up to 11 bits back
	inc.b $30
	bne CODE_C5832F
	inc.b $32
CODE_C5832F:						; from UnpackFormat6
	lda.b [$30]
	lsr a
	sta.b $0E
	jsr.w CODE_C5835C
	lsr.b $0E
	jsr.w CODE_C5835C
	lsr.b $0E
	jsr.w CODE_C5835C
	lsr.b $0E
	jsr.w CODE_C5835C
	lsr.b $0E
	jsr.w CODE_C5835C
	lsr.b $0E
	jsr.w CODE_C5835C
	lsr.b $0E
	jsr.w CODE_C5835C
	lsr.b $0E
	jsr.w CODE_C5835C
	bra UnpackFormat6
CODE_C5835C:						; from CODE_C5832F
	bcc CODE_C58396
	ldy.w #$0001
	lda.b [$30],y
	and.w #$00FF
	lsr a
	lsr a
	lsr a
	sta.b $0A
	lda.b [$30],y
	xba
	and.w #$07FF
	sta.b $0C
	sec
	lda.b $2C
	sbc.b $0C
	tax
	clc
	lda.b $30
	adc.w #$0002
	sta.b $30
	ldy.b $2C
	lda.b $0A
	adc.w #$0002
	jsl.l $0000A3
	lda.b $2C
	adc.b $0A
	adc.w #$0003
	sta.b $2C
	rts
CODE_C58396:						; from CODE_C5835C
	ldy.w #$0001
	lda.b [$30],y
	and.w #$00FF
	beq CODE_C583BD
	dec a
	sta.b $0A
	lda.b $30
	adc.w #$0002
	tax
	adc.b $0A
	sta.b $30
	lda.b $0A
	ldy.b $2C
	jsl.l $00009F
	lda.b $2C
	adc.b $0A
	inc a
	sta.b $2C
	rts
CODE_C583BD:						; from CODE_C58396
	pla
	plb
	rtl
UnpackFormat8:						; format 8: a flag byte per 8 runs or copies, up to 12 bits back
	inc.b $30
	bne CODE_C583C6
	inc.b $32
CODE_C583C6:						; from UnpackFormat8
	lda.b [$30]
	lsr a
	sta.b $0E
	jsr.w CODE_C583F3
	lsr.b $0E
	jsr.w CODE_C583F3
	lsr.b $0E
	jsr.w CODE_C583F3
	lsr.b $0E
	jsr.w CODE_C583F3
	lsr.b $0E
	jsr.w CODE_C583F3
	lsr.b $0E
	jsr.w CODE_C583F3
	lsr.b $0E
	jsr.w CODE_C583F3
	lsr.b $0E
	jsr.w CODE_C583F3
	bra UnpackFormat8
CODE_C583F3:						; from CODE_C583C6
	bcc CODE_C5842E
	ldy.w #$0001
	lda.b [$30],y
	and.w #$00FF
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b $0A
	lda.b [$30],y
	xba
	and.w #$0FFF
	sta.b $0C
	sec
	lda.b $2C
	sbc.b $0C
	tax
	clc
	lda.b $30
	adc.w #$0002
	sta.b $30
	ldy.b $2C
	lda.b $0A
	adc.w #$0002
	jsl.l $0000A3
	lda.b $2C
	adc.b $0A
	adc.w #$0003
	sta.b $2C
	rts
CODE_C5842E:						; from CODE_C583F3
	ldy.w #$0001
	lda.b [$30],y
	and.w #$00FF
	beq CODE_C58455
	dec a
	sta.b $0A
	lda.b $30
	adc.w #$0002
	tax
	adc.b $0A
	sta.b $30
	lda.b $0A
	ldy.b $2C
	jsl.l $00009F
	lda.b $2C
	adc.b $0A
	inc a
	sta.b $2C
	rts
CODE_C58455:						; from CODE_C5842E
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
CODE_C58467:						; from CODE_C5882B
	ldx.w #$01FE
CODE_C5846A:						; from CODE_C5846A
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
	bpl CODE_C5846A
	lda.b [$2C]
	sta.b $3C
	lda.b $2C
	clc
	adc.w #$0002
	bcc CODE_C58494
	inc.b $2E
CODE_C58494:						; from CODE_C5846A
	sta.b $2C
	stz.b $42
	ldy.w #$0FEE
CODE_C5849B:						; from CODE_C584C0, CODE_C584FF
	lsr.b $42
	lda.b $42
	and.w #$0100
	bne CODE_C584B1
	lda.b [$2C]
	inc.b $2C
	bne CODE_C584AC
	inc.b $2E
CODE_C584AC:						; from CODE_C5849B
	ora.w #$FF00
	sta.b $42
CODE_C584B1:						; from CODE_C5849B
	lda.b $42
	and.w #$0001
	beq CODE_C584D7
	lda.b [$2C]
	inc.b $2C
	bne CODE_C584C0
	inc.b $2E
CODE_C584C0:						; from CODE_C584B1
	sep #$20
	sta.l WMDATA
	sta.w $364E,y
	rep #$20
	iny
	tya
	and.w #$0FFF
	tay
	dec.b $3C
	bne CODE_C5849B
	bra CODE_C58526
CODE_C584D7:						; from CODE_C584B1
	lda.b [$2C]
	and.w #$00FF
	inc.b $2C
	bne CODE_C584E2
	inc.b $2E
CODE_C584E2:						; from CODE_C584D7
	sta.b $3E
	lda.b [$2C]
	inc.b $2C
	bne CODE_C584EC
	inc.b $2E
CODE_C584EC:						; from CODE_C584E2
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
	sta.b $40
CODE_C584FF:						; from CODE_C584FF
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
	dec.b $3C
	beq CODE_C58526
	inc.b $3E
	dec.b $40
	bne CODE_C584FF
	jmp.w CODE_C5849B
CODE_C58526:						; from CODE_C584C0, CODE_C584FF
	rts
MapSetToVRAM:						; the map set at X:A to VRAM at $9F (map words + $A1), ...
	jsr.w CODE_C5852B
	rtl
CODE_C5852B:						; from MapSetToVRAM
	sta.b $30
	stx.b $32
	sty.b $A3
	sep #$20
	lda.b #$80
	sta.l VMAIN
	rep #$21
	lda.b $30
	adc.w #$0005
	sta.b $2C
	lda.b $32
	adc.w #$0000
	sta.b $2E
	pea.w $0000
	ldy.w #$0004
	lda.b [$30],y
	bit.w #$0001
	bne CODE_C5855B
	bit.w #$0002
	beq CODE_C5855D
CODE_C5855B:						; from CODE_C5852B
	brk #$00						; a trap: this header form is not handled
CODE_C5855D:						; from CODE_C5852B
	bit.w #$0004
	bne CODE_C58565
	jmp.w CODE_C586CA
CODE_C58565:						; from CODE_C5855D
	bit.w #$0080
	beq CODE_C58588
	plx
	ldy.w #$0005
	lda.b [$30],y
	inc a
	inc a
	pha
	jsl.l $C4C558
	pha
	inc a
	inc a
	ldx.w #$007E
	jsr.w DecompressLZSS
	pla
	sta.b $2C
	lda.w #$007E
	sta.b $2E
CODE_C58588:						; from CODE_C58565
	ldy.w #$0005
	lda.b [$30],y
	lsr a
	tax
	ldy.w #$0002
	lda.b [$30],y
	and.w #$00FF
	cmp.w #$0020
	beq CODE_C585A3
	cmp.w #$0040
	beq CODE_C585BC
	brk #$00						; a trap: this header form is not handled
CODE_C585A3:						; from CODE_C58588
	ldy.w #$0002
	lda.b $9F
	sta.l VMADDL
	clc
CODE_C585AD:						; from CODE_C585AD
	lda.b [$2C],y
	adc.b $A1
	sta.l VMDATAL
	iny
	iny
	dex
	bne CODE_C585AD
	bra CODE_C58604
CODE_C585BC:						; from CODE_C58588
	ldy.w #$0003
	lda.b [$30],y
	and.w #$00FF
	sta.b $A5
	ldy.w #$0002
	lda.b $9F
CODE_C585CB:						; from CODE_C585EC
	sta.l VMADDL
	ldx.w #$001F
	clc
CODE_C585D3:						; from CODE_C585D3
	lda.b [$2C],y
	adc.b $A1
	sta.l VMDATAL
	iny
	iny
	dex
	bpl CODE_C585D3
	lda.b $9F
	adc.w #$0400
	sta.l VMADDL
	ldx.w #$001F
CODE_C585EC:						; from CODE_C585EC
	lda.b [$2C],y
	adc.b $A1
	sta.l VMDATAL
	iny
	iny
	dex
	bpl CODE_C585EC
	lda.b $9F
	adc.w #$0020
	sta.b $9F
	dec.b $A5
	bne CODE_C585CB
CODE_C58604:						; from CODE_C585AD
	pla
	jsl.l $C4C56A
	jsr.w CODE_C586B6
	ldy.w #$0004
	lda.b [$30],y
	bit.w #$0080
	beq CODE_C58636
	ldy.w #$0005
	lda.b [$30],y
	and.w #$00FF
	sta.b $A5
	ldy.w #$0006
	lda.b [$30],y
	and.w #$00FF
	cmp.b $A5
	bne CODE_C58636
	ldy.w #$0007
	lda.b [$30],y
	and.w #$00FF
	beq CODE_C58638
CODE_C58636:						; from CODE_C58604
	brk #$00						; a trap: this header form is not handled
CODE_C58638:						; from CODE_C58604
	clc
	lda.w #$0008
	tay
	adc.b $30
	sta.b $2C
	lda.b $32
	adc.w #$0000
	sta.b $2E
	lda.b [$30],y
	sta.b $A5
	sta.b $0A
	lsr.b $0A
	pha
	jsl.l $C4C558
	pha
	ldx.w #$007E
	jsr.w DecompressLZSS
	pla
	sta.b $2C
	lda.w #$007E
	sta.b $2E
	lda.b $A3
	sta.l VMADDL
	ldy.w #$0000
CODE_C5866D:						; from CODE_C5866D
	lda.b [$2C],y
	sta.l VMDATAL
	iny
	iny
	cpy.b $A5
	bcc CODE_C5866D
	pla
	jsl.l $C4C56A
	jsr.w CODE_C586B6
	ldy.w #$0005
	lda.b [$30],y
	asl a
	tax
	ldy.w #$0003
	lda.b [$30],y
	tay
	lda.b $A1
	and.w #$1C00
	lsr a
	lsr a
	xba
	sta.b $A1
	lda.w #$0000
CODE_C5869B:						; from CODE_C5869B
	adc.b $A1
	dey
	bne CODE_C5869B
	sep #$20
	sta.l CGADD
	ldy.w #$0007
CODE_C586A9:						; from CODE_C586A9
	lda.b [$30],y
	sta.l CGDATA
	iny
	dex
	bne CODE_C586A9
	rep #$31
	rts
CODE_C586B6:						; from CODE_C58604, CODE_C5866D, CODE_C5871D, CODE_C587B8
	clc
	lda.b [$30]
	adc.b $30
	bcc CODE_C586C0
	inc.b $32
	clc
CODE_C586C0:						; from CODE_C586B6
	adc.w #$0002
	sta.b $30
	bcc CODE_C586C9
	inc.b $32
CODE_C586C9:						; from CODE_C586C0
	rts
CODE_C586CA:						; from CODE_C5855D
	bit.w #$0080
	bne CODE_C586D1
	brk #$00						; a trap: this header form is not handled
CODE_C586D1:						; from CODE_C586CA
	clc
	lda.w #$0005
	tay
	adc.b $30
	sta.b $2C
	lda.b $32
	adc.w #$0000
	sta.b $2E
	lda.b [$30],y
	pha
	jsl.l $C4C558
	pha
	ldx.w #$007E
	jsr.w DecompressLZSS
	pla
	sta.b $2C
	lda.w #$007E
	sta.b $2E
	stz.b $A3
	lda.w #$0000
	sta.l VMADDL
	sep #$20
	sta.l VMAIN
	ldy.w #$0003
	lda.b [$30],y
	sta.b $A5
	stz.b $A6
	ldy.w #$0002
	lda.b [$30],y
	sta.b $9F
	stz.b $A0
	ldy.w #$0000
CODE_C5871B:						; from CODE_C5871D
	ldx.b $9F
CODE_C5871D:						; from CODE_C5871D
	lda.b [$2C],y
	sta.l VMDATAL
	iny
	dex
	bne CODE_C5871D
	rep #$21
	lda.b $A3
	adc.w #$0080
	sta.b $A3
	sta.l VMADDL
	sep #$20
	dec.b $A5
	bne CODE_C5871B
	rep #$20
	pla
	jsl.l $C4C56A
	jsr.w CODE_C586B6
	ldy.w #$0004
	lda.b [$30],y
	bit.w #$0001
	bne CODE_C5877A
	bit.w #$0080
	beq CODE_C5877A
	ldy.w #$0005
	lda.b [$30],y
	and.w #$00FF
	cmp.w #$0008
	bne CODE_C5877A
	ldy.w #$0006
	lda.b [$30],y
	and.w #$00FF
	cmp.w #$0008
	bne CODE_C5877A
	ldy.w #$0007
	lda.b [$30],y
	and.w #$00FF
	cmp.w #$0003
	beq CODE_C5877C
CODE_C5877A:						; from CODE_C5871D
	brk #$00						; a trap: this header form is not handled
CODE_C5877C:						; from CODE_C5871D
	clc
	lda.w #$0008
	tay
	adc.b $30
	sta.b $2C
	lda.b $32
	adc.w #$0000
	sta.b $2E
	lda.b [$30],y
	sta.b $A5
	pha
	jsl.l $C4C558
	pha
	ldx.w #$007E
	stx.b $2E
	jsr.w DecompressLZSS
	pla
	sta.b $2C
	lda.w #$007E
	sta.b $2E
	lda.w #$0000
	sta.l VMADDL
	sep #$20
	lda.b #$80
	sta.l VMAIN
	ldy.w #$0000
CODE_C587B8:						; from CODE_C587B8
	lda.b [$2C],y
	sta.l VMDATAH
	iny
	cpy.b $A5
	bcc CODE_C587B8
	rep #$20
	pla
	jsl.l $C4C56A
	jsr.w CODE_C586B6
	ldy.w #$0002
	lda.b [$30],y
	and.w #$00FF
	cmp.w #$0001
	bne CODE_C587EE
	ldy.w #$0003
	lda.b [$30],y
	cmp.w #$0100
	bne CODE_C587EE
	ldy.w #$0005
	lda.b [$30],y
	cmp.w #$0100
	beq CODE_C587F0
CODE_C587EE:						; from CODE_C587B8
	brk #$00						; a trap: this header form is not handled
CODE_C587F0:						; from CODE_C587B8
	sep #$20
	lda.b #$00
	sta.l CGADD
	ldy.w #$0007
	ldx.w #$00FF
CODE_C587FE:						; from CODE_C587FE
	lda.b [$30],y
	sta.l CGDATA
	iny
	lda.b [$30],y
	sta.l CGDATA
	iny
	dex
	bpl CODE_C587FE
	rep #$20
	rts
CODE_C58812:						; called from other segments
	ldy.w #unpackbuf
	sty.b $30
	ldy.w #unpackbuf>>16
	sty.b $32
CODE_C5881C:						; called from other segments
	sta.b $34
	stx.b $36
	clc
	lda.b $34
	adc.w #$0005
	sta.b $2C
	bcc CODE_C5882B
	inx
CODE_C5882B:						; from CODE_C5881C
	stx.b $2E
	lda.b $30
	ldx.b $32
	jsr.w DecompressLZSS
	jsr.w CODE_C58874
	clc
	lda.b $34
	adc.w #$0008
	sta.b $2C
	lda.b $36
	adc.w #$0000
	sta.b $2E
	jsr.w CODE_C58467
	jsr.w CODE_C58874
	clc
	lda.b $34
	adc.w #$0007
	sta.b $2C
	lda.b $36
	adc.w #$0000
	sta.b $2E
	sec
	lda.b [$34]
	sbc.w #$0005
	tax
	ldy.w #$0000
	sep #$20
CODE_C58867:						; from CODE_C58867
	lda.b [$2C],y
	sta.l WMDATA
	iny
	dex
	bne CODE_C58867
	rep #$20
	rtl
CODE_C58874:						; from CODE_C5882B
	clc
	lda.b [$34]
	adc.b $34
	sta.b $34
	lda.b $36
	adc.w #$0000
	sta.b $36
	clc
	lda.b $34
	adc.w #$0002
	sta.b $34
	bcc CODE_C5888E
	inc.b $36
CODE_C5888E:						; from CODE_C58874
	rts
CODE_C5888F:						; called from other segments
	sep #$20
	sta.l WRMPYA
	rep #$20
	txa
	bmi CODE_C588B9
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
CODE_C588B9:						; from CODE_C5888F
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
	bne CODE_C588E8
	inc.b $16
CODE_C588E8:						; from CODE_C588B9
	sta.b $14
	rts
CODE_C588EB:						; called from other segments
	stx.b $2E
	sta.b $2C
	stz.b $30
	sty.b $32
	stz.b $34
	stz.b $36
	ldy.w #$0010
	lda.b $32
CODE_C588FC:						; from CODE_C588FC
	asl a
	iny
	bcc CODE_C588FC
	ror a
	sta.b $32
CODE_C58903:						; from CODE_C58903, CODE_C58934
	asl.b $34
	rol.b $36
	lda.b $2E
	cmp.b $32
	bcc CODE_C58934
	bne CODE_C58923
	lda.b $2C
	cmp.b $30
	bcs CODE_C58925
	lsr.b $32
	ror.b $30
	dey
	bne CODE_C58903
	lda.b $34
	ldx.b $36
	ldy.b $2C
	rts
CODE_C58923:						; from CODE_C58903
	lda.b $2C
CODE_C58925:						; from CODE_C58903
	sbc.b $30
	sta.b $2C
	lda.b $2E
	sbc.b $32
	sta.b $2E
	lda.w #$0001
	tsb.b $34
CODE_C58934:						; from CODE_C58903
	lsr.b $32
	ror.b $30
	dey
	bne CODE_C58903
	lda.b $34
	ldx.b $36
	ldy.b $2C
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
	pea.w $00C5
	pea.w $8942
	pea.w $0200
	pea.w $0080
	pea.w $5800
	pea.w $1908
	pea.w $00C5
	pea.w $8943
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
	pea.w $00C5
	pea.w $8942
	pea.w $0400
	pea.w $0080
	pea.w $5800
	pea.w $1908
	pea.w $00C5
	pea.w $8943
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	rtl
CODE_C589B0:						; from CODE_C58A3F
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
	jml.l $C4CEDB
CODE_C589E4:						; called from other segments
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
	sta.w $002C
	stx.w $002E
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	lda.b [$2C]
	and.w #$00FF
	pha
	pea.w $0000
	phy
	pea.w $1800
	pei ($2E)
	lda.b $2C
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
	jsr.w CODE_C589B0
	ldy.w #$0000
	jsr.w CODE_C589B0
	rtl
ZeroFillWord:						; the zero word the VRAM clears DMA from (fixed source)
	db $00,$00
DecompressToVRAM:					; Decompress A:X into a $1000 byte heap block and queue it to VRAM at Y
	phy
	tay
	lda.w #$1000
	jsl.l $C4C558
	pha
	sta.b $2C
	lda.w #$007E
	sta.b $2E
	tya
	jsl.l Decompress
	ply
	plx
	stx.b $9F
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
CODE_C58A9F:						; from CODE_C58A9F
	lda.w brightness-1
	bpl CODE_C58A9F
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
CODE_C58AD9:						; called from other segments
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
	sta.w $18FC
	tyx
	lda.b $06,s
	tay
	txa
	dec a
	plx
	jsl.l $0018FA
	lda.b $02,s
	sta.b $04,s
	lda.b $01,s
	sta.b $03,s
	pla
	rtl
CODE_C58B11:						; from CODE_C58F75
	phy
	tax
	inc a
	tay
	sep #$20
	lda.b #$00
	sta.l $7E0000,x
	rep #$20
	lda.w #$7E7E
	sta.w $18FC
	pla
	dec a
	jml.l $0018FA
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
CODE_C58B48:						; called from other segments
	jsl.l FadeOutWait
	jsl.l $C4CEDB
	jsl.l $C4C530
	jsl.l CODE_C5E50E
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
	sta.b $2C
	stx.b $2E
	lda.b [$2C]
	and.w #$00FF
	sta.b $9F
	inc a
	jsl.l $C4C561
	pha
	tax
	ldy.w #$0001
	sep #$20
CODE_C58BD0:						; from CODE_C58BD0
	lda.b [$2C],y
	eor.b #$80
	sta.w $0000,x
	iny
	inx
	dec.b $9F
	bne CODE_C58BD0
	stz.w $0000,x
	rep #$20
	plx
	rtl
CODE_C58BE4:						; called from other segments
	jsl.l $C4CEDB
	jsl.l $C4C530
	jsl.l CODE_C5E50E
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
	stz.w $04BC
	stz.w $04C0
	lda.w #$FFFF
	sta.w $04BE
	sta.w $04C2
	rtl
CODE_C58C36:						; called from other segments
	sty.b $A3
	stx.b $A1
	sta.b $9F
	txa
	dec a
	dec a
	asl a
	tax
	lda.w #$22FC
	sta.w $3650,x
	lda.w #$22DE
CODE_C58C4A:						; from CODE_C58C4A
	sta.w $364E,x
	dex
	dex
	bne CODE_C58C4A
	lda.w #$22FB
	sta.w $364E,x
	lda.b $A1
	asl a
	tax
	lda.w #$22FD
	sta.w $364E,x
	lda.w #$22A0
	ldy.b $A1
	dey
CODE_C58C67:						; from CODE_C58C67
	sta.w $3650,x
	inx
	inx
	dey
	bne CODE_C58C67
	lda.w #$22FE
	sta.w $364E,x
	lda.w #$22FF
	sta.w $3650,x
	lda.w #$22E0
	ldy.b $A1
	dey
CODE_C58C81:						; from CODE_C58C81
	sta.w $3652,x
	inx
	inx
	dey
	bne CODE_C58C81
	lda.w #$229F
	sta.w $3650,x
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.b $A1
	asl a
	sta.b $A1
	pha
	lda.b $9F
	pha
	adc.w #$0020
	tay
	pea.w $007E
	lda.w #$364E
	pha
	adc.b $A1
	tax
	tya
CODE_C58CAF:						; from CODE_C58CAF
	pei ($A1)
	pha
	adc.w #$0020
	pea.w $007E
	phx
	dec.b $A3
	bne CODE_C58CAF
	pla
	adc.b $A1
	pha
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jml.l $C4CEDB
CODE_C58CCD:						; called from other segments
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
CODE_C58D32:						; called from other segments
	jsr.w CODE_C590DA
	lda.w $23BA
	beq CODE_C58D3E
	jsl.l $C36B83
CODE_C58D3E:						; from CODE_C58D32
	stz.w fadestep
	stz.w $23BA
	stz.w $23BC
CODE_C58D47:						; from CODE_C58D4A, CODE_C58DC1
	inc.w TransfersReady
CODE_C58D4A:						; from CODE_C58D4A
	lda.w TransfersReady
	bne CODE_C58D4A
	jsl.l $C36C2D
	inc.b $26
	ldx.b $99
	jsr (DATA8_C58DF0,x)
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l $C5F0D1
	jsl.l $C5F3DB
	lda.b $99
	bne CODE_C58D47
	lda.w $058F
	beq CODE_C58D86
	cmp.w #$0014
	bcc CODE_C58D47
	lda.w #$000F
	sta.w $058F
	bra CODE_C58D89
CODE_C58D86:						; from CODE_C58D4A
	stz.w $23BC
CODE_C58D89:						; from CODE_C58D4A
	lda.w $058D
	bit.w #$0800
	beq CODE_C58D96
	jsr.w CODE_C58EE0
	bra CODE_C58DC1
CODE_C58D96:						; from CODE_C58D89
	bit.w #$0400
	beq CODE_C58DA0
	jsr.w CODE_C58F28
	bra CODE_C58DC1
CODE_C58DA0:						; from CODE_C58D96
	bit.w #$0200
	beq CODE_C58DAA
	jsr.w CODE_C58FD8
	bra CODE_C58DC1
CODE_C58DAA:						; from CODE_C58DA0
	bit.w #$0100
	beq CODE_C58DB4
	jsr.w CODE_C59012
	bra CODE_C58DC1
CODE_C58DB4:						; from CODE_C58DAA
	bit.w #$3000
	beq CODE_C58DC1
	lda.w $1864
	asl a
	tax
	jmp (DATA8_C58DD0,x)
CODE_C58DC1:						; from CODE_C58D89, CODE_C58D96, CODE_C58DA0, CODE_C58DAA, ...
	lda.w $23BC
	inc a
	cmp.w #$0168
	bcs CODE_C58DE0
	sta.w $23BC
	jmp.w CODE_C58D47
DATA8_C58DD0:						; jump table: the routine for each index
	dw CODE_C593B1,CODE_C5939D,CODE_C59588,$CA6C
	dw $C109,$C722,CODE_C59643,$ABA1
CODE_C58DE0:						; from CODE_C58DC1
	lda.w #$0001
	sta.l $7E23BA
	stz.w $1904
	stz.w $1864
	jmp.w CODE_C593B1
DATA8_C58DF0:						; jump table: the routine for each index
	dw CODE_C59052,CODE_C58DF6,CODE_C58E71
CODE_C58DF6:						; called from other segments
	lda.w $4692
	and.w #$00FF
	cmp.w #$0010
	bne CODE_C58E3A
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
CODE_C58E3A:						; from CODE_C58DF6
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
	bne CODE_C58E6B
	lda.b #$0F
	sta.w $469B
	rep #$20
	lda.w $0108
	sta.w $0110
	lda.w $0106
	sta.w $0108
	stz.b $99
	rts
CODE_C58E6B:						; from CODE_C58E3A
	sta.w $469E
	rep #$20
	rts
CODE_C58E71:						; called from other segments
	sep #$20
	lda.w $4692
	dec a
	beq CODE_C58EA4
	sta.w $4692
	lda.b #$10
	cmp.w $469B
	beq CODE_C58E88
	sta.w $469B
	bra CODE_C58E8B
CODE_C58E88:						; from CODE_C58E71
	inc.w $469E
CODE_C58E8B:						; from CODE_C58E71
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
CODE_C58EA4:						; from CODE_C58E71
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
CODE_C58EE0:						; from CODE_C58D89
	lda.b $97
	beq CODE_C58F27
	dec a
	sta.b $97
	bne CODE_C58EF2
	ldx.b $73
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
CODE_C58EF2:						; from CODE_C58EE0
	jsr.w CODE_C5909A
	lda.w $010E
	dec a
	dec a
	cmp.w #$0010
	bcs CODE_C58F02
	lda.w #$0018
CODE_C58F02:						; from CODE_C58EF2
	sta.w $010E
	sec
	ldx.b $63
	lda.b $08,x
	sbc.w #$0010
	cmp.w #$008C
	bcs CODE_C58F22
	ldx.b $75
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	lda.w #$0002
	sta.b $99
	bra CODE_C58F75
CODE_C58F22:						; from CODE_C58F02
	sta.b $08,x
	jsr.w CODE_C590B8
CODE_C58F27:						; from CODE_C58EE0
	rts
CODE_C58F28:						; from CODE_C58D96
	lda.b $97
	inc a
	cmp.b $69
	bcc CODE_C58F32
	jmp.w CODE_C58FD7
CODE_C58F32:						; from CODE_C58F28
	sta.b $97
	inc a
	cmp.b $69
	bcc CODE_C58F47
	cmp.w #$0005
	bcc CODE_C58F47
	ldx.b $75
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
CODE_C58F47:						; from CODE_C58F32
	jsr.w CODE_C5909A
	lda.w $010E
	inc a
	inc a
	cmp.w #$001A
	bcc CODE_C58F57
	lda.w #$0010
CODE_C58F57:						; from CODE_C58F47
	sta.w $010E
	clc
	ldx.b $63
	lda.b $08,x
	adc.w #$0010
	cmp.w #$00CC
	bcc CODE_C58FD2
	ldx.b $73
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	lda.w #$0004
	sta.b $99
CODE_C58F75:						; from CODE_C58F02
	lda.w $010E
	xba
	lsr a
	lsr a
	adc.b $D3
	ldy.w #$0080
	jsl.l CODE_C58B11
	lda.w #$0010
	sta.b $CF
	lda.b $97
	asl a
	asl a
	asl a
	adc.b $6F
	tax
	phx
	lda.l $C30002,x
	tax
	ldy.w $010E
	jsl.l $C4BC26
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
	lda.w $1864
	cmp.w #$0007
	bne CODE_C58FC9
	jsl.l $C4BCBC
	bra CODE_C58FCD
CODE_C58FC9:						; from CODE_C58F75
	jsl.l $C4BCA4
CODE_C58FCD:						; from CODE_C58F75
	jsl.l $C4C2AA
	rts
CODE_C58FD2:						; from CODE_C58F57
	sta.b $08,x
	jsr.w CODE_C590B8
CODE_C58FD7:						; from CODE_C58F28
	rts

; Segment bankC4_C000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4BF47
CODE_C4BF47:						; from DATA8_C4C07D (pushed as its address - 1, then rts)
	asl.b $16
	bcc CODE_C4BF54
	lda.w $0000,y
	ora.w #$0080
	sta.w $0000,y
CODE_C4BF54:						; from CODE_C4BF47
	asl.b $14
	bcc CODE_C4BF61
	lda.w $0001,y
	ora.w #$0080
	sta.w $0001,y
CODE_C4BF61:						; from CODE_C4BF54
	dex
	bne CODE_C4BF67
CODE_C4BF64:						; from CODE_C4BF81, CODE_C4BF9E, CODE_C4BFBB
	jmp.w CODE_C4C03B
CODE_C4BF67:						; from DATA8_C4C07D (pushed as its address - 1, then rts)
	asl.b $16
	bcc CODE_C4BF74
	lda.w $0000,y
	ora.w #$0040
	sta.w $0000,y
CODE_C4BF74:						; from CODE_C4BF67
	asl.b $14
	bcc CODE_C4BF81
	lda.w $0001,y
	ora.w #$0040
	sta.w $0001,y
CODE_C4BF81:						; from CODE_C4BF74
	dex
	beq CODE_C4BF64
CODE_C4BF84:						; from DATA8_C4C07D (pushed as its address - 1, then rts)
	asl.b $16
	bcc CODE_C4BF91
	lda.w $0000,y
	ora.w #$0020
	sta.w $0000,y
CODE_C4BF91:						; from CODE_C4BF84
	asl.b $14
	bcc CODE_C4BF9E
	lda.w $0001,y
	ora.w #$0020
	sta.w $0001,y
CODE_C4BF9E:						; from CODE_C4BF91
	dex
	beq CODE_C4BF64
CODE_C4BFA1:						; from DATA8_C4C07D (pushed as its address - 1, then rts)
	asl.b $16
	bcc CODE_C4BFAE
	lda.w $0000,y
	ora.w #$0010
	sta.w $0000,y
CODE_C4BFAE:						; from CODE_C4BFA1
	asl.b $14
	bcc CODE_C4BFBB
	lda.w $0001,y
	ora.w #$0010
	sta.w $0001,y
CODE_C4BFBB:						; from CODE_C4BFAE
	dex
	beq CODE_C4BF64
CODE_C4BFBE:						; from DATA8_C4C07D (pushed as its address - 1, then rts)
	asl.b $16
	bcc CODE_C4BFCB
	lda.w $0000,y
	ora.w #$0008
	sta.w $0000,y
CODE_C4BFCB:						; from CODE_C4BFBE
	asl.b $14
	bcc CODE_C4BFD8
	lda.w $0001,y
	ora.w #$0008
	sta.w $0001,y
CODE_C4BFD8:						; from CODE_C4BFCB
	dex
	beq CODE_C4C03B
CODE_C4BFDB:						; from DATA8_C4C07D (pushed as its address - 1, then rts)
	asl.b $16
	bcc CODE_C4BFE8
	lda.w $0000,y
	ora.w #$0004
	sta.w $0000,y
CODE_C4BFE8:						; from CODE_C4BFDB
	asl.b $14
	bcc CODE_C4BFF5
	lda.w $0001,y
	ora.w #$0004
	sta.w $0001,y
CODE_C4BFF5:						; from CODE_C4BFE8
	dex
	beq CODE_C4C03B
CODE_C4BFF8:						; from DATA8_C4C07D (pushed as its address - 1, then rts)
	asl.b $16
	bcc CODE_C4C005
	lda.w $0000,y
	ora.w #$0002
	sta.w $0000,y
CODE_C4C005:						; from CODE_C4BFF8
	asl.b $14
	bcc CODE_C4C012
	lda.w $0001,y
	ora.w #$0002
	sta.w $0001,y
CODE_C4C012:						; from CODE_C4C005
	dex
	beq CODE_C4C03B
CODE_C4C015:						; from DATA8_C4C07D (pushed as its address - 1, then rts)
	asl.b $16
	bcc CODE_C4C022
	lda.w $0000,y
	ora.w #$0001
	sta.w $0000,y
CODE_C4C022:						; from CODE_C4C015
	asl.b $14
	bcc CODE_C4C02F
	lda.w $0001,y
	ora.w #$0001
	sta.w $0001,y
CODE_C4C02F:						; from CODE_C4C022
	dex
	beq CODE_C4C03B
	tya
	clc
	adc.w #$0010
	tay
	jmp.w CODE_C4BF47
CODE_C4C03B:						; from CODE_C4BF64, CODE_C4BFD8, CODE_C4BFF5, CODE_C4C012, ...
	ply
	iny
	iny
	plx
	inx
	inx
	cpx.b $3A
	bcs CODE_C4C048
	jmp.w CODE_C4BF1A
CODE_C4C048:						; from CODE_C4C03B
	lda.b $0E
	lsr a
	bcc CODE_C4C066
	txa
	adc.w #$000F
	tax
	adc.w #$0010
	sta.b $3A
	tya
	adc.w #$01F0
	tay
	lda.w #$8000
	tsb.b $0E
	bne CODE_C4C066
	jmp.w CODE_C4BF1A
CODE_C4C066:						; from CODE_C4C048
	lda.b p0
CODE_C4C068:						; called from other segments
	clc
	adc.b $0A
	sta.b $0A
	jmp.w CODE_C4BE53
CODE_C4C070:						; called from other segments
	lda.b $0A
	cmp.l $0018DC
	bcc CODE_C4C07C
	sta.l $0018DC
CODE_C4C07C:						; from CODE_C4C070
	rtl
DATA8_C4C07D:						; the 8 routines CODE_C4BF1A runs (address - 1: pushed, then rts)
	dw CODE_C4BF47-1,CODE_C4BF67-1,CODE_C4BF84-1,CODE_C4BFA1-1
	dw CODE_C4BFBE-1,CODE_C4BFDB-1,CODE_C4BFF8-1,CODE_C4C015-1
CODE_C4C08D:						; called from other segments
	lda.b $0A
	and.w #$0007
	tax
	lda.l DATA8_C4C4AE,x
	and.w #$00FF
	sta.b $36
	lda.b $10
	clc
	adc.b $0C
	tax
	lda.b $0A
	and.w #$FFF8
	asl a
	adc.b $A5
	tay
	sep #$20
	lda.l $C00000,x
	ora.l $C00001,x
	asl a
	bcc CODE_C4C0C2
	lda.w $0000,y
	ora.w $0001,y
	bit.b $36
	bne CODE_C4C140
CODE_C4C0C2:						; from CODE_C4C08D
	lda.l $C00002,x
	ora.l $C00003,x
	asl a
	bcc CODE_C4C0D7
	lda.w $0002,y
	ora.w $0003,y
	bit.b $36
	bne CODE_C4C140
CODE_C4C0D7:						; from CODE_C4C0C2
	lda.l $C00004,x
	ora.l $C00005,x
	asl a
	bcc CODE_C4C0EC
	lda.w $0004,y
	ora.w $0005,y
	bit.b $36
	bne CODE_C4C140
CODE_C4C0EC:						; from CODE_C4C0D7
	lda.l $C00006,x
	ora.l $C00007,x
	asl a
	bcc CODE_C4C101
	lda.w QueueBusy,y
	ora.w $0007,y
	bit.b $36
	bne CODE_C4C140
CODE_C4C101:						; from CODE_C4C0EC
	lda.l $C00008,x
	ora.l $C00009,x
	asl a
	bcc CODE_C4C116
	lda.w $0008,y
	ora.w $0009,y
	bit.b $36
	bne CODE_C4C140
CODE_C4C116:						; from CODE_C4C101
	lda.l $C0000A,x
	ora.l $C0000B,x
	asl a
	bcc CODE_C4C12B
	lda.w $000A,y
	ora.w $000B,y
	bit.b $36
	bne CODE_C4C140
CODE_C4C12B:						; from CODE_C4C116
	lda.l $C0000C,x
	ora.l $C0000D,x
	asl a
	bcc CODE_C4C143
	lda.w $000C,y
	ora.w $000D,y
	bit.b $36
	beq CODE_C4C143
CODE_C4C140:						; from CODE_C4C08D, CODE_C4C0C2, CODE_C4C0D7, CODE_C4C0EC, ...
	rep #$20
	rts
CODE_C4C143:						; from CODE_C4C12B
	lda.l $C0000E,x
	ora.l $C0000F,x
	asl a
	bcc CODE_C4C158
	lda.w $000E,y
	ora.w $000F,y
	bit.b $36
	bne CODE_C4C140
CODE_C4C158:						; from CODE_C4C143
	lda.b $0E
	lsr a
	bcs CODE_C4C160
	rep #$20
	rts
CODE_C4C160:						; from CODE_C4C158
	lda.l $C00020,x
	ora.l $C00021,x
	asl a
	bcc CODE_C4C175
	lda.w $0200,y
	ora.w $0201,y
	bit.b $36
	bne CODE_C4C140
CODE_C4C175:						; from CODE_C4C160
	lda.l $C00022,x
	ora.l $C00023,x
	asl a
	bcc CODE_C4C18A
	lda.w $0202,y
	ora.w $0203,y
	bit.b $36
	bne CODE_C4C140
CODE_C4C18A:						; from CODE_C4C175
	lda.l $C00024,x
	ora.l $C00025,x
	asl a
	bcc CODE_C4C19F
	lda.w $0204,y
	ora.w $0205,y
	bit.b $36
	bne CODE_C4C140
CODE_C4C19F:						; from CODE_C4C18A
	lda.l $C00026,x
	ora.l $C00027,x
	asl a
	bcc CODE_C4C1B4
	lda.w $0206,y
	ora.w $0207,y
	bit.b $36
	bne CODE_C4C140
CODE_C4C1B4:						; from CODE_C4C19F
	lda.l $C00028,x
	ora.l $C00029,x
	asl a
	bcc CODE_C4C1C9
	lda.w $0208,y
	ora.w $0209,y
	bit.b $36
	bne CODE_C4C209
CODE_C4C1C9:						; from CODE_C4C1B4
	lda.l $C0002A,x
	ora.l $C0002B,x
	asl a
	bcc CODE_C4C1DE
	lda.w $020A,y
	ora.w $020B,y
	bit.b $36
	bne CODE_C4C209
CODE_C4C1DE:						; from CODE_C4C1C9
	lda.l $C0002C,x
	ora.l $C0002D,x
	asl a
	bcc CODE_C4C1F3
	lda.w $020C,y
	ora.w $020D,y
	bit.b $36
	bne CODE_C4C209
CODE_C4C1F3:						; from CODE_C4C1DE
	lda.l $C0002E,x
	ora.l $C0002F,x
	asl a
	bcc CODE_C4C209
	lda.w $020E,y
	ora.w $020F,y
	bit.b $36
	bne CODE_C4C209
	clc
CODE_C4C209:						; from CODE_C4C1B4, CODE_C4C1C9, CODE_C4C1DE, CODE_C4C1F3
	rep #$20
	rts
CODE_C4C20C:						; called from other segments
	lda.w #$3000
	sta.b p0
	lda.b $12
	lsr a
	lsr a
	lsr a
	sta.b $16
	tya
	xba
	lsr a
	lsr a
	lsr a
	adc.b $16
	sta.b $14
	inc a
	asl a
	asl a
	asl a
	adc.b p0
	tay
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.b $12
	and.w #$FFF8
	pha
	asl a
	phy
	pea.w $007E
	adc.b $A5
	pha
	lda.b $0A
	adc.w #$0007
	sec
	sbc.b $07,s
	and.w #$FFF8
	sta.b $A5
	asl a
	sta.b $07,s
	tax
	lda.b $0E
	lsr a
	bcc CODE_C4C264
	phx
	lda.b $07,s
	adc.w #$00FF
	pha
	pea.w $007E
	lda.b $07,s
	adc.w #$0200
	pha
CODE_C4C264:						; from CODE_C4C20C
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	inc.w TransfersReady
	rtl
CODE_C4C270:						; called from other segments
	lda.b $14
	asl a
	adc.b $D3
	tax
	lda.b $A5
	lsr a
	lsr a
	lsr a
	sta.b $A5
	lda.b p0
	sec
	sbc.w #$3000
	lsr a
	lsr a
	lsr a
	adc.b $14
	ora.b $D5
	tay
CODE_C4C28B:						; from CODE_C4C29E
	iny
	tya
	sta.l $7E0000,x
	lda.b $0E
	lsr a
	bcc CODE_C4C29E
	tya
	adc.w #$001F
	sta.l $7E0040,x
CODE_C4C29E:						; from CODE_C4C28B
	inx
	inx
	dec.b $A5
	bne CODE_C4C28B
	lda.b $0A
	sec
	sbc.b $12
	rtl
CODE_C4C2AA:						; called from other segments
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0800
	pea.w $5C00
	pea.w $007E
	pei ($D3)
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rtl
CODE_C4C2C6:						; no caller found (not traced)
	sty.b $A5
	tay
	lda.w $18DA
	lsr a
	lsr a
	lsr a
	sta.b $16
	lda.w $18DC
	clc
	adc.w #$0007
	lsr a
	lsr a
	lsr a
	sec
	sbc.b $16
	asl a
	sta.b $14
	tya
	xba
	lsr a
	lsr a
	adc.b $16
	adc.b $16
	adc.b $D3
	tay
	txa
	xba
	lsr a
	lsr a
	lsr a
	adc.b $16
	adc.w #$5C00
	tax
	dec.b QueueBusy
	tsc
	sta.b $1C
	lda.b $00
	tcs
CODE_C4C2FF:						; from CODE_C4C2FF
	pei ($14)
	phx
	pea.w $007E
	phy
	txa
	adc.w #$0020
	tax
	tya
	adc.w #$0040
	tay
	dec.b $A5
	bne CODE_C4C2FF
	tsc
	sta.b $00
	lda.b $1C
	tcs
	stz.b QueueBusy
	rtl
CODE_C4C31D:						; from CODE_C4C46B and other segments
	phx
	lda.b $0E
	bit.w #$0004
	beq CODE_C4C35B
	stz.b $0A
	txy
CODE_C4C328:						; from CODE_C4C350
	lda.w $0000,y
	and.w #$00FF
	beq CODE_C4C357
	iny
	cmp.w #$0020
	bne CODE_C4C33B
	lda.w #$0004
	bra CODE_C4C350
CODE_C4C33B:						; from CODE_C4C328
	sec
	sbc.w #$0030
	tax
	cmp.w #$0031
	bcc CODE_C4C349
	sbc.w #$0020
	tax
CODE_C4C349:						; from CODE_C4C33B
	lda.l DATA8_C4C4D7,x
	and.w #$007F
CODE_C4C350:						; from CODE_C4C328
	clc
	adc.b $0A
	sta.b $0A
	bra CODE_C4C328
CODE_C4C357:						; from CODE_C4C328
	lda.b $0A
	plx
	rtl
CODE_C4C35B:						; from CODE_C4C31D
	lda.w $18DA
	pha
	lda.w $18DC
	pha
	lda.w #$0000
	jsl.l CODE_C4BE34
	ldy.w #$0400
	lda.b $0E
	lsr a
	bcs CODE_C4C375
	ldy.w #$0200
CODE_C4C375:						; from CODE_C4C35B
	tya
	jsl.l CODE_C4C56A
	lda.b $0A
	pla
	sta.w $18DC
	pla
	sta.w $18DA
	plx
	rtl
CODE_C4C386:						; called from other segments
	phy
	phx
	ldy.w #$0001
	sep #$20
CODE_C4C38D:						; from CODE_C4C38D
	lda.l $C30000,x
	beq CODE_C4C397
	inx
	iny
	bra CODE_C4C38D
CODE_C4C397:						; from CODE_C4C38D
	rep #$20
	tya
	pha
	jsl.l CODE_C4C558
	ply
	plx
	pha
	pha
	txa
	ldx.w #$00C3
	jsl.l CODE_C58AF3
	plx
	ply
	rtl
CODE_C4C3AE:						; called from other segments
	phy
	stx.b $16
	lda.w #$003C
	jsl.l CODE_C4C561
	bra CODE_C4C3C4
CODE_C4C3BA:						; called from other segments
	phy
	stx.b $16
	lda.w #$003C
	jsl.l CODE_C4C558
CODE_C4C3C4:						; from CODE_C4C3AE
	pha
	tay
	lda.w #$0041
	sta.b $14
	stz.b $0A
CODE_C4C3CD:						; from CODE_C4C402, CODE_C4C3FC
	jsr.w CODE_C4C43D
	cmp.b #$1A
	bcc CODE_C4C400
	cmp.b #$1B
	beq CODE_C4C408
	bcc CODE_C4C40C
	cmp.b #$1D
	beq CODE_C4C416
	bcc CODE_C4C3F4
	cmp.b #$1F
	bcc CODE_C4C3EC
	jsr.w CODE_C4C431
	clc
	adc.b #$10
	bra CODE_C4C419
CODE_C4C3EC:						; from CODE_C4C3CD
	jsr.w CODE_C4C431
	clc
	adc.b #$08
	bra CODE_C4C419
CODE_C4C3F4:						; from CODE_C4C3CD
	lda.b #$41
	cmp.b $14
	bne CODE_C4C3FC
	lda.b #$61
CODE_C4C3FC:						; from CODE_C4C3F4
	sta.b $14
	bra CODE_C4C3CD
CODE_C4C400:						; from CODE_C4C3CD
	adc.b $14
CODE_C4C402:						; from CODE_C4C408, CODE_C4C419
	sta.w $0000,y
	iny
	bra CODE_C4C3CD
CODE_C4C408:						; from CODE_C4C3CD
	lda.b #$20
	bra CODE_C4C402
CODE_C4C40C:						; from CODE_C4C3CD
	lda.b #$00
	sta.w $0000,y
	rep #$20
	plx
	ply
	rtl
CODE_C4C416:						; from CODE_C4C3CD
	jsr.w CODE_C4C431
CODE_C4C419:						; from CODE_C4C3CD, CODE_C4C3EC
	tax
	lda.l DATA8_C4C420,x
	bra CODE_C4C402
DATA8_C4C420:						; not traced: a table read by CODE_C4C419
	db $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
	db $40
CODE_C4C431:						; from CODE_C4C3CD, CODE_C4C416, CODE_C4C3EC
	jsr.w CODE_C4C45A
	and.w #$0007
	pha
	lda.w #$0003
	bra CODE_C4C447
CODE_C4C43D:						; from CODE_C4C3CD
	jsr.w CODE_C4C45A
	and.w #$001F
	pha
	lda.w #$0005
CODE_C4C447:						; from CODE_C4C431
	clc
	adc.b $0A
	cmp.w #$0008
	bcc CODE_C4C454
	inc.b $16
	sbc.w #$0008
CODE_C4C454:						; from CODE_C4C447
	sta.b $0A
	pla
	sep #$20
	rts
CODE_C4C45A:						; from CODE_C4C43D, CODE_C4C431
	rep #$20
	ldx.b $16
	lda.l $C30000,x
	ldx.b $0A
	beq CODE_C4C46A
CODE_C4C466:						; from CODE_C4C466
	lsr a
	dex
	bne CODE_C4C466
CODE_C4C46A:						; from CODE_C4C45A
	rts
CODE_C4C46B:						; called from other segments
	jsl.l CODE_C4C31D
	lsr.b $0A
	lda.b $D1
	sec
	sbc.b $CF
	lsr a
	sec
	sbc.b $0A
	clc
	adc.b $CF
	rtl
CODE_C4C47E:						; called from other segments
	phy
	phx
	ldy.w #$0001
	sep #$20
CODE_C4C485:						; from CODE_C4C485
	lda.l $7E0000,x
	beq CODE_C4C48F
	inx
	iny
	bra CODE_C4C485
CODE_C4C48F:						; from CODE_C4C485
	rep #$20
	tya
	pha
	jsl.l CODE_C4C561
	ply
	plx
	pha
	pha
	txa
	ldx.w #$007E
	jsl.l CODE_C58AF3
	plx
	ply
	rtl
DATA8_C4C4A6:						; not traced: data between routines
	db $01,$02,$04,$08,$10,$20,$40,$80
DATA8_C4C4AE:						; not traced: a table read by CODE_C4C08D
	db $80,$40,$20,$10,$08,$04,$02,$01
DATA8_C4C4B6:						; not traced: a table read by CODE_C4BEB1
	db $0B,$07,$0B,$0B,$0B,$0B,$0B,$09,$0B,$0C,$05,$08,$0C,$06,$0B,$07
	db $05,$0A,$0B,$0B,$0B,$0B,$0B,$0B,$0C,$07,$0C,$0C,$08,$0D,$0D,$0B
	db $0B
DATA8_C4C4D7:						; not traced: a table read by CODE_C4C349, CODE_C4BE99
	db $0B,$0B,$0B,$0A,$0C,$09,$0C,$0B,$0A,$0B,$02,$03,$01,$83,$87,$83
	db $84,$87,$87,$86,$87,$86,$86,$87,$86,$82,$85,$87,$85,$88,$87,$88
	db $86,$88,$86,$85,$86,$86,$87,$88,$86,$86,$85
DATA8_C4C502:						; not traced: a table read by CODE_C4BEA6
	db $86,$85,$86,$86,$87,$86,$86,$86,$86,$86,$83,$83,$88,$83,$85,$83
	db $83,$88,$87,$88,$87,$86,$86,$88,$87,$83,$86,$87,$87,$88,$87,$88
	db $87,$88,$88,$87,$87,$87,$88,$88,$87,$87,$87,$02,$03,$01
CODE_C4C530:						; from CODE_C4D193 and other segments
	lda.w #$50DC
	sta.w $18E0
CODE_C4C536:						; called from other segments
	lda.w $18E0
	sta.b $08
	lda.w #$E000
	sta.b $D7
	rtl
CODE_C4C541:						; called from other segments
	lda.b $08
	sta.w $18E0
	rtl
CODE_C4C547:						; called from other segments
	phx
	phy
	pha
	jsl.l CODE_C4C558
	ply
	pha
	jsl.l CODE_C58B11
	pla
	ply
	plx
	rtl
CODE_C4C558:						; from CODE_C4C3BA, CODE_C4C547, CODE_C4C397 and other segments
	pei ($08)
	clc
	adc.b $08
	sta.b $08
	pla
	rtl
CODE_C4C561:						; from CODE_C4C3AE, CODE_C4C48F and other segments
	pei ($D7)
	clc
	adc.b $D7
	sta.b $D7
	pla
	rtl
CODE_C4C56A:						; from CODE_C4C375 and other segments
	sec
	sbc.b $08
	eor.w #$FFFF
	inc a
	sta.b $08
	rtl
CODE_C4C574:						; from CODE_C4D193 and other segments
	lda.w #$FFFF
	sta.b QueueBusy
	lda.w #$03FF
	sta.b $00
	lda.w #$01FF
	sta.b $02
	lda.w #$048F
	sta.b $04
	stz.b QueueBusy
	rtl
CODE_C4C58B:						; called from other segments
	ldx.b $02
	dex
	stz.b $00,x
	ldx.b $00
	dex
	stz.b $00,x
	sep #$11
	lda.w #$1801
	sta.w DMAP0
	ldx.b #$80
	stx.w VMAIN
	lda.w #$0300
	tcd
	ldy.b #$01
CODE_C4C5A8:						; from CODE_C4C913
	lda.b $FE
	bne CODE_C4C5AF
	jmp.w CODE_C4C930
CODE_C4C5AF:						; from CODE_C4C5A8
	sta.w DAS0L
	lda.b $FC
	sta.w VMADDL
	ldx.b $FA
	stx.w A1B0
	lda.b $F8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $F6
	bne CODE_C4C5CB
	jmp.w CODE_C4C930
CODE_C4C5CB:						; from CODE_C4C5AF
	sta.w DAS0L
	lda.b $F4
	sta.w VMADDL
	ldx.b $F2
	stx.w A1B0
	lda.b $F0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $EE
	bne CODE_C4C5E7
	jmp.w CODE_C4C930
CODE_C4C5E7:						; from CODE_C4C5CB
	sta.w DAS0L
	lda.b $EC
	sta.w VMADDL
	ldx.b $EA
	stx.w A1B0
	lda.b $E8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $E6
	bne CODE_C4C603
	jmp.w CODE_C4C930
CODE_C4C603:						; from CODE_C4C5E7
	sta.w DAS0L
	lda.b $E4
	sta.w VMADDL
	ldx.b $E2
	stx.w A1B0
	lda.b $E0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $DE
	bne CODE_C4C61F
	jmp.w CODE_C4C930
CODE_C4C61F:						; from CODE_C4C603
	sta.w DAS0L
	lda.b $DC
	sta.w VMADDL
	ldx.b $DA
	stx.w A1B0
	lda.b $D8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $D6
	bne CODE_C4C63B
	jmp.w CODE_C4C930
CODE_C4C63B:						; from CODE_C4C61F
	sta.w DAS0L
	lda.b $D4
	sta.w VMADDL
	ldx.b $D2
	stx.w A1B0
	lda.b $D0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $CE
	bne CODE_C4C657
	jmp.w CODE_C4C930
CODE_C4C657:						; from CODE_C4C63B
	sta.w DAS0L
	lda.b $CC
	sta.w VMADDL
	ldx.b $CA
	stx.w A1B0
	lda.b $C8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $C6
	bne CODE_C4C673
	jmp.w CODE_C4C930
CODE_C4C673:						; from CODE_C4C657
	sta.w DAS0L
	lda.b $C4
	sta.w VMADDL
	ldx.b $C2
	stx.w A1B0
	lda.b $C0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $BE
	bne CODE_C4C68F
	jmp.w CODE_C4C930
CODE_C4C68F:						; from CODE_C4C673
	sta.w DAS0L
	lda.b $BC
	sta.w VMADDL
	ldx.b $BA
	stx.w A1B0
	lda.b $B8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $B6
	bne CODE_C4C6AB
	jmp.w CODE_C4C930
CODE_C4C6AB:						; from CODE_C4C68F
	sta.w DAS0L
	lda.b $B4
	sta.w VMADDL
	ldx.b $B2
	stx.w A1B0
	lda.b $B0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $AE
	bne CODE_C4C6C7
	jmp.w CODE_C4C930
CODE_C4C6C7:						; from CODE_C4C6AB
	sta.w DAS0L
	lda.b $AC
	sta.w VMADDL
	ldx.b $AA
	stx.w A1B0
	lda.b $A8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $A6
	bne CODE_C4C6E3
	jmp.w CODE_C4C930
CODE_C4C6E3:						; from CODE_C4C6C7
	sta.w DAS0L
	lda.b $A4
	sta.w VMADDL
	ldx.b $A2
	stx.w A1B0
	lda.b $A0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $9E
	bne CODE_C4C6FF
	jmp.w CODE_C4C930
CODE_C4C6FF:						; from CODE_C4C6E3
	sta.w DAS0L
	lda.b $9C
	sta.w VMADDL
	ldx.b $9A
	stx.w A1B0
	lda.b $98
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $96
	bne CODE_C4C71B
	jmp.w CODE_C4C930
CODE_C4C71B:						; from CODE_C4C6FF
	sta.w DAS0L
	lda.b $94
	sta.w VMADDL
	ldx.b $92
	stx.w A1B0
	lda.b $90
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $8E
	bne CODE_C4C737
	jmp.w CODE_C4C930
CODE_C4C737:						; from CODE_C4C71B
	sta.w DAS0L
	lda.b $8C
	sta.w VMADDL
	ldx.b $8A
	stx.w A1B0
	lda.b $88
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $86
	bne CODE_C4C753
	jmp.w CODE_C4C930
CODE_C4C753:						; from CODE_C4C737
	sta.w DAS0L
	lda.b $84
	sta.w VMADDL
	ldx.b $82
	stx.w A1B0
	lda.b $80
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $7E
	bne CODE_C4C76F
	jmp.w CODE_C4C930
CODE_C4C76F:						; from CODE_C4C753
	sta.w DAS0L
	lda.b $7C
	sta.w VMADDL
	ldx.b $7A
	stx.w A1B0
	lda.b $78
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $76
	bne CODE_C4C78B
	jmp.w CODE_C4C930
CODE_C4C78B:						; from CODE_C4C76F
	sta.w DAS0L
	lda.b $74
	sta.w VMADDL
	ldx.b $72
	stx.w A1B0
	lda.b $70
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $6E
	bne CODE_C4C7A7
	jmp.w CODE_C4C930
CODE_C4C7A7:						; from CODE_C4C78B
	sta.w DAS0L
	lda.b $6C
	sta.w VMADDL
	ldx.b $6A
	stx.w A1B0
	lda.b $68
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $66
	bne CODE_C4C7C3
	jmp.w CODE_C4C930
CODE_C4C7C3:						; from CODE_C4C7A7
	sta.w DAS0L
	lda.b $64
	sta.w VMADDL
	ldx.b $62
	stx.w A1B0
	lda.b $60
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $5E
	bne CODE_C4C7DF
	jmp.w CODE_C4C930
CODE_C4C7DF:						; from CODE_C4C7C3
	sta.w DAS0L
	lda.b $5C
	sta.w VMADDL
	ldx.b $5A
	stx.w A1B0
	lda.b $58
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $56
	bne CODE_C4C7FB
	jmp.w CODE_C4C930
CODE_C4C7FB:						; from CODE_C4C7DF
	sta.w DAS0L
	lda.b $54
	sta.w VMADDL
	ldx.b $52
	stx.w A1B0
	lda.b $50
	sta.w A1T0L
	sty.w MDMAEN
	lda.b DMAQueueTail
	bne CODE_C4C817
	jmp.w CODE_C4C930
CODE_C4C817:						; from CODE_C4C7FB
	sta.w DAS0L
	lda.b DMAQueueHead
	sta.w VMADDL
	ldx.b NMISkip
	stx.w A1B0
	lda.b $48
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $46
	bne CODE_C4C833
	jmp.w CODE_C4C930
CODE_C4C833:						; from CODE_C4C817
	sta.w DAS0L
	lda.b $44
	sta.w VMADDL
	ldx.b $42
	stx.w A1B0
	lda.b r3
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $3E
	bne CODE_C4C84F
	jmp.w CODE_C4C930
CODE_C4C84F:						; from CODE_C4C833
	sta.w DAS0L
	lda.b p1
	sta.w VMADDL
	ldx.b $3A
	stx.w A1B0
	lda.b p0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $36
	bne CODE_C4C86B
	jmp.w CODE_C4C930
CODE_C4C86B:						; from CODE_C4C84F
	sta.w DAS0L
	lda.b r2
	sta.w VMADDL
	ldx.b $32
	stx.w A1B0
	lda.b r1
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $2E
	bne CODE_C4C887
	jmp.w CODE_C4C930
CODE_C4C887:						; from CODE_C4C86B
	sta.w DAS0L
	lda.b r0
	sta.w VMADDL
	ldx.b $2A
	stx.w A1B0
	lda.b $28
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $26
	bne CODE_C4C8A3
	jmp.w CODE_C4C930
CODE_C4C8A3:						; from CODE_C4C887
	sta.w DAS0L
	lda.b $24
	sta.w VMADDL
	ldx.b $22
	stx.w A1B0
	lda.b $20
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $1E
	bne CODE_C4C8BF
	jmp.w CODE_C4C930
CODE_C4C8BF:						; from CODE_C4C8A3
	sta.w DAS0L
	lda.b $1C
	sta.w VMADDL
	ldx.b $1A
	stx.w A1B0
	lda.b $18
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $16
	bne CODE_C4C8DB
	jmp.w CODE_C4C930
CODE_C4C8DB:						; from CODE_C4C8BF
	sta.w DAS0L
	lda.b $14
	sta.w VMADDL
	ldx.b $12
	stx.w A1B0
	lda.b $10
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $0E
	bne CODE_C4C8F7
	jmp.w CODE_C4C930
CODE_C4C8F7:						; from CODE_C4C8DB
	sta.w DAS0L
	lda.b $0C
	sta.w VMADDL
	ldx.b $0A
	stx.w A1B0
	lda.b $08
	sta.w A1T0L
	sty.w MDMAEN
	lda.b QueueBusy
	bne CODE_C4C913
	jmp.w CODE_C4C930
CODE_C4C913:						; from CODE_C4C8F7
	sta.w DAS0L
	lda.b $04
	sta.w VMADDL
	ldx.b $02
	stx.w A1B0
	lda.b $00
	sta.w A1T0L
	sty.w MDMAEN
	tdc
	sbc.w #$0100
	tcd
	jmp.w CODE_C4C5A8
CODE_C4C930:						; from CODE_C4C5A8, CODE_C4C5AF, CODE_C4C5CB, CODE_C4C5E7, ...
	lda.w #$0100
	tcd
	lda.b $FE
	bne CODE_C4C93B
	jmp.w CODE_C4CC52
CODE_C4C93B:						; from CODE_C4C930
	sta.w DAS0L
	ldx.b $FC
	stx.w VMAIN
	lda.b $FA
	sta.w VMADDL
	lda.b $F8
	sta.w DMAP0
	ldx.b $F6
	stx.w A1B0
	lda.b $F4
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $F2
	bne CODE_C4C961
	jmp.w CODE_C4CC52
CODE_C4C961:						; from CODE_C4C93B
	sta.w DAS0L
	ldx.b $F0
	stx.w VMAIN
	lda.b $EE
	sta.w VMADDL
	lda.b $EC
	sta.w DMAP0
	ldx.b $EA
	stx.w A1B0
	lda.b $E8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $E6
	bne CODE_C4C987
	jmp.w CODE_C4CC52
CODE_C4C987:						; from CODE_C4C961
	sta.w DAS0L
	ldx.b $E4
	stx.w VMAIN
	lda.b $E2
	sta.w VMADDL
	lda.b $E0
	sta.w DMAP0
	ldx.b $DE
	stx.w A1B0
	lda.b $DC
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $DA
	bne CODE_C4C9AD
	jmp.w CODE_C4CC52
CODE_C4C9AD:						; from CODE_C4C987
	sta.w DAS0L
	ldx.b $D8
	stx.w VMAIN
	lda.b $D6
	sta.w VMADDL
	lda.b $D4
	sta.w DMAP0
	ldx.b $D2
	stx.w A1B0
	lda.b $D0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $CE
	bne CODE_C4C9D3
	jmp.w CODE_C4CC52
CODE_C4C9D3:						; from CODE_C4C9AD
	sta.w DAS0L
	ldx.b $CC
	stx.w VMAIN
	lda.b $CA
	sta.w VMADDL
	lda.b $C8
	sta.w DMAP0
	ldx.b $C6
	stx.w A1B0
	lda.b $C4
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $C2
	bne CODE_C4C9F9
	jmp.w CODE_C4CC52
CODE_C4C9F9:						; from CODE_C4C9D3
	sta.w DAS0L
	ldx.b $C0
	stx.w VMAIN
	lda.b $BE
	sta.w VMADDL
	lda.b $BC
	sta.w DMAP0
	ldx.b $BA
	stx.w A1B0
	lda.b $B8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $B6
	bne CODE_C4CA1F
	jmp.w CODE_C4CC52
CODE_C4CA1F:						; from CODE_C4C9F9
	sta.w DAS0L
	ldx.b $B4
	stx.w VMAIN
	lda.b $B2
	sta.w VMADDL
	lda.b $B0
	sta.w DMAP0
	ldx.b $AE
	stx.w A1B0
	lda.b $AC
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $AA
	bne CODE_C4CA45
	jmp.w CODE_C4CC52
CODE_C4CA45:						; from CODE_C4CA1F
	sta.w DAS0L
	ldx.b $A8
	stx.w VMAIN
	lda.b $A6
	sta.w VMADDL
	lda.b $A4
	sta.w DMAP0
	ldx.b $A2
	stx.w A1B0
	lda.b $A0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $9E
	bne CODE_C4CA6B
	jmp.w CODE_C4CC52
CODE_C4CA6B:						; from CODE_C4CA45
	sta.w DAS0L
	ldx.b $9C
	stx.w VMAIN
	lda.b $9A
	sta.w VMADDL
	lda.b $98
	sta.w DMAP0
	ldx.b $96
	stx.w A1B0
	lda.b $94
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $92
	bne CODE_C4CA91
	jmp.w CODE_C4CC52
CODE_C4CA91:						; from CODE_C4CA6B
	sta.w DAS0L
	ldx.b $90
	stx.w VMAIN
	lda.b $8E
	sta.w VMADDL
	lda.b $8C
	sta.w DMAP0
	ldx.b $8A
	stx.w A1B0
	lda.b $88
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $86
	bne CODE_C4CAB7
	jmp.w CODE_C4CC52
CODE_C4CAB7:						; from CODE_C4CA91
	sta.w DAS0L
	ldx.b $84
	stx.w VMAIN
	lda.b $82
	sta.w VMADDL
	lda.b $80
	sta.w DMAP0
	ldx.b $7E
	stx.w A1B0
	lda.b $7C
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $7A
	bne CODE_C4CADD
	jmp.w CODE_C4CC52
CODE_C4CADD:						; from CODE_C4CAB7
	sta.w DAS0L
	ldx.b $78
	stx.w VMAIN
	lda.b $76
	sta.w VMADDL
	lda.b $74
	sta.w DMAP0
	ldx.b $72
	stx.w A1B0
	lda.b $70
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $6E
	bne CODE_C4CB03
	jmp.w CODE_C4CC52
CODE_C4CB03:						; from CODE_C4CADD
	sta.w DAS0L
	ldx.b $6C
	stx.w VMAIN
	lda.b $6A
	sta.w VMADDL
	lda.b $68
	sta.w DMAP0
	ldx.b $66
	stx.w A1B0
	lda.b $64
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $62
	bne CODE_C4CB29
	jmp.w CODE_C4CC52
CODE_C4CB29:						; from CODE_C4CB03
	sta.w DAS0L
	ldx.b $60
	stx.w VMAIN
	lda.b $5E
	sta.w VMADDL
	lda.b $5C
	sta.w DMAP0
	ldx.b $5A
	stx.w A1B0
	lda.b $58
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $56
	bne CODE_C4CB4F
	jmp.w CODE_C4CC52
CODE_C4CB4F:						; from CODE_C4CB29
	sta.w DAS0L
	ldx.b $54
	stx.w VMAIN
	lda.b $52
	sta.w VMADDL
	lda.b $50
	sta.w DMAP0
	ldx.b DMAQueueTail
	stx.w A1B0
	lda.b DMAQueueHead
	sta.w A1T0L
	sty.w MDMAEN
	lda.b NMISkip
	bne CODE_C4CB75
	jmp.w CODE_C4CC52
CODE_C4CB75:						; from CODE_C4CB4F
	sta.w DAS0L
	ldx.b $48
	stx.w VMAIN
	lda.b $46
	sta.w VMADDL
	lda.b $44
	sta.w DMAP0
	ldx.b $42
	stx.w A1B0
	lda.b r3
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $3E
	bne CODE_C4CB9B
	jmp.w CODE_C4CC52
CODE_C4CB9B:						; from CODE_C4CB75
	sta.w DAS0L
	ldx.b p1
	stx.w VMAIN
	lda.b $3A
	sta.w VMADDL
	lda.b p0
	sta.w DMAP0
	ldx.b $36
	stx.w A1B0
	lda.b r2
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $32
	bne CODE_C4CBC1
	jmp.w CODE_C4CC52
CODE_C4CBC1:						; from CODE_C4CB9B
	sta.w DAS0L
	ldx.b r1
	stx.w VMAIN
	lda.b $2E
	sta.w VMADDL
	lda.b r0
	sta.w DMAP0
	ldx.b $2A
	stx.w A1B0
	lda.b $28
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $26
	bne CODE_C4CBE7
	jmp.w CODE_C4CC52
CODE_C4CBE7:						; from CODE_C4CBC1
	sta.w DAS0L
	ldx.b $24
	stx.w VMAIN
	lda.b $22
	sta.w VMADDL
	lda.b $20
	sta.w DMAP0
	ldx.b $1E
	stx.w A1B0
	lda.b $1C
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $1A
	bne CODE_C4CC0D
	jmp.w CODE_C4CC52
CODE_C4CC0D:						; from CODE_C4CBE7
	sta.w DAS0L
	ldx.b $18
	stx.w VMAIN
	lda.b $16
	sta.w VMADDL
	lda.b $14
	sta.w DMAP0
	ldx.b $12
	stx.w A1B0
	lda.b $10
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $0E
	bne CODE_C4CC33
	jmp.w CODE_C4CC52
CODE_C4CC33:						; from CODE_C4CC0D
	sta.w DAS0L
	ldx.b $0C
	stx.w VMAIN
	lda.b $0A
	sta.w VMADDL
	lda.b $08
	sta.w DMAP0
	ldx.b QueueBusy
	stx.w A1B0
	lda.b $04
	sta.w A1T0L
	sty.w MDMAEN
CODE_C4CC52:						; from CODE_C4C930, CODE_C4C93B, CODE_C4C961, CODE_C4C987, ...
	lda.w #$0400
	tcd
	lda.w #$2200
	sta.w DMAP0
	rep #$30
	ldx.w $0004
	dex
	stz.w $0000,x
	sep #$10
	lda.b $8E
	bne CODE_C4CC6E
	jmp.w CODE_C4CE5F
CODE_C4CC6E:						; from CODE_C4CC52
	sta.w DAS0L
	ldx.b $8C
	stx.w CGADD
	ldx.b $8A
	stx.w A1B0
	lda.b $88
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $86
	bne CODE_C4CC8A
	jmp.w CODE_C4CE5F
CODE_C4CC8A:						; from CODE_C4CC6E
	sta.w DAS0L
	ldx.b $84
	stx.w CGADD
	ldx.b $82
	stx.w A1B0
	lda.b $80
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $7E
	bne CODE_C4CCA6
	jmp.w CODE_C4CE5F
CODE_C4CCA6:						; from CODE_C4CC8A
	sta.w DAS0L
	ldx.b $7C
	stx.w CGADD
	ldx.b $7A
	stx.w A1B0
	lda.b $78
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $76
	bne CODE_C4CCC2
	jmp.w CODE_C4CE5F
CODE_C4CCC2:						; from CODE_C4CCA6
	sta.w DAS0L
	ldx.b $74
	stx.w CGADD
	ldx.b $72
	stx.w A1B0
	lda.b $70
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $6E
	bne CODE_C4CCDE
	jmp.w CODE_C4CE5F
CODE_C4CCDE:						; from CODE_C4CCC2
	sta.w DAS0L
	ldx.b $6C
	stx.w CGADD
	ldx.b $6A
	stx.w A1B0
	lda.b $68
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $66
	bne CODE_C4CCFA
	jmp.w CODE_C4CE5F
CODE_C4CCFA:						; from CODE_C4CCDE
	sta.w DAS0L
	ldx.b $64
	stx.w CGADD
	ldx.b $62
	stx.w A1B0
	lda.b $60
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $5E
	bne CODE_C4CD16
	jmp.w CODE_C4CE5F
CODE_C4CD16:						; from CODE_C4CCFA
	sta.w DAS0L
	ldx.b $5C
	stx.w CGADD
	ldx.b $5A
	stx.w A1B0
	lda.b $58
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $56
	bne CODE_C4CD32
	jmp.w CODE_C4CE5F
CODE_C4CD32:						; from CODE_C4CD16
	sta.w DAS0L
	ldx.b $54
	stx.w CGADD
	ldx.b $52
	stx.w A1B0
	lda.b $50
	sta.w A1T0L
	sty.w MDMAEN
	lda.b DMAQueueTail
	bne CODE_C4CD4E
	jmp.w CODE_C4CE5F
CODE_C4CD4E:						; from CODE_C4CD32
	sta.w DAS0L
	ldx.b DMAQueueHead
	stx.w CGADD
	ldx.b NMISkip
	stx.w A1B0
	lda.b $48
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $46
	bne CODE_C4CD6A
	jmp.w CODE_C4CE5F
CODE_C4CD6A:						; from CODE_C4CD4E
	sta.w DAS0L
	ldx.b $44
	stx.w CGADD
	ldx.b $42
	stx.w A1B0
	lda.b r3
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $3E
	bne CODE_C4CD86
	jmp.w CODE_C4CE5F
CODE_C4CD86:						; from CODE_C4CD6A
	sta.w DAS0L
	ldx.b p1
	stx.w CGADD
	ldx.b $3A
	stx.w A1B0
	lda.b p0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $36
	bne CODE_C4CDA2
	jmp.w CODE_C4CE5F
CODE_C4CDA2:						; from CODE_C4CD86
	sta.w DAS0L
	ldx.b r2
	stx.w CGADD
	ldx.b $32
	stx.w A1B0
	lda.b r1
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $2E
	bne CODE_C4CDBE
	jmp.w CODE_C4CE5F
CODE_C4CDBE:						; from CODE_C4CDA2
	sta.w DAS0L
	ldx.b r0
	stx.w CGADD
	ldx.b $2A
	stx.w A1B0
	lda.b $28
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $26
	bne CODE_C4CDDA
	jmp.w CODE_C4CE5F
CODE_C4CDDA:						; from CODE_C4CDBE
	sta.w DAS0L
	ldx.b $24
	stx.w CGADD
	ldx.b $22
	stx.w A1B0
	lda.b $20
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $1E
	bne CODE_C4CDF6
	jmp.w CODE_C4CE5F
CODE_C4CDF6:						; from CODE_C4CDDA
	sta.w DAS0L
	ldx.b $1C
	stx.w CGADD
	ldx.b $1A
	stx.w A1B0
	lda.b $18
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $16
	bne CODE_C4CE12
	jmp.w CODE_C4CE5F
CODE_C4CE12:						; from CODE_C4CDF6
	sta.w DAS0L
	ldx.b $14
	stx.w CGADD
	ldx.b $12
	stx.w A1B0
	lda.b $10
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $0E
	bne CODE_C4CE2E
	jmp.w CODE_C4CE5F
CODE_C4CE2E:						; from CODE_C4CE12
	sta.w DAS0L
	ldx.b $0C
	stx.w CGADD
	ldx.b $0A
	stx.w A1B0
	lda.b $08
	sta.w A1T0L
	sty.w MDMAEN
	lda.b QueueBusy
	bne CODE_C4CE4A
	jmp.w CODE_C4CE5F
CODE_C4CE4A:						; from CODE_C4CE2E
	sta.w DAS0L
	ldx.b $04
	stx.w CGADD
	ldx.b $02
	stx.w A1B0
	lda.b $00
	sta.w A1T0L
	sty.w MDMAEN
CODE_C4CE5F:						; from CODE_C4CC52, CODE_C4CC6E, CODE_C4CC8A, CODE_C4CCA6, ...
	rep #$31
	lda.w #$0000
	tcd
	lda.w #$03FF
	sta.b $00
	lda.w #$01FF
	sta.b $02
	lda.w #$048F
	sta.b $04
	stz.w $2102
	sec
	lda.b $28
	sbc.w #$1B91
	bcc CODE_C4CEBC
	adc.w #$0001
	sta.w DAS0L
	lda.w #$939C
	sta.w A1T0L
	lda.w #$C593
	sta.w $4303
	lda.w #$0408
	sta.w DMAP0
	lda.w #$0221
	sbc.w DAS0L
	ldx.w #$0001
	stx.w MDMAEN
	sta.w DAS0L
	lda.w #$001B
	sta.w $4303
	lda.w #$0400
	sta.w DMAP0
	lda.b $28
	inc a
	sta.w A1T0L
	stx.w MDMAEN
	rtl
CODE_C4CEBC:						; from CODE_C4CE5F
	lda.w #$0220
	sta.w DAS0L
	lda.w #$1B90
	sta.w A1T0L
	lda.w #$001B
	sta.w $4303
	lda.w #$0400
	sta.w DMAP0
	lda.w #$0001
	sta.w MDMAEN
	rtl
CODE_C4CEDB:						; called from other segments
	inc.w TransfersReady
	wai
	rtl
CODE_C4CEE0:						; no caller found (not traced)
	sta.b r0
	stx.b $2E
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rtl
CODE_C4CEF5:						; called from other segments
	pea.w $7E30
	plb
	ldy.w #$6000
	jsr.w CODE_C4CF64
	bne CODE_C4CF11
	ldy.w #$6A16
	jsr.w CODE_C4CF64
	bne CODE_C4CF11
	ldy.w #$790D
	jsr.w CODE_C4CF64
	beq CODE_C4CF58
CODE_C4CF11:						; from CODE_C4CEF5
	lda.w #$1FFE
	stz.w $6000
	ldx.w #$6000
	txy
	iny
	mvn $30,$30
	ldy.w #$6000
	jsr.w CODE_C4CF5A
	ldy.w #$6A16
	jsr.w CODE_C4CF5A
	ldy.w #$790D
	jsr.w CODE_C4CF5A
	jsl.l CODE_C4CF75
	lda.w #$0101
	sta.l $306049
	lda.w #$000E
	sta.l $306041
	lda.w #$0017
	sta.l $306043
	ldx.w #$003A
	lda.w #$FFFF
CODE_C4CF50:						; from CODE_C4CF50
	sta.l $3070D6,x
	dex
	dex
	bpl CODE_C4CF50
CODE_C4CF58:						; from CODE_C4CEF5
	plb
	rtl
CODE_C4CF5A:						; from CODE_C4CF11
	ldx.w #$FFC0
	lda.w #$003F
	mvn $30,$C0
	rts
CODE_C4CF64:						; from CODE_C4CEF5
	ldx.w #$FFC0
CODE_C4CF67:						; from CODE_C4CF67
	lda.b $00,x
	cmp.w $0000,y
	bne CODE_C4CF74
	iny
	iny
	inx
	inx
	bne CODE_C4CF67
CODE_C4CF74:						; from CODE_C4CF67
	rts
CODE_C4CF75:						; from CODE_C4CF11 and other segments
	jsr.w CODE_C4D05B
	jsr.w CODE_C4D0D5
CODE_C4CF7B:						; from CODE_C4D051 and other segments
	pea.w $7E7E
	plb
	plb
	stz.b $0A
	jsl.l CODE_C4CF8F
	ldy.w #$0014
	lda.w #$026A
	jmp.w CODE_C4CFBE
CODE_C4CF8F:						; from CODE_C4CF7B and other segments
	lda.w #$0019
CODE_C4CF92:						; from CODE_C4CFDE
	sta.w $17C9
	asl a
	tax
	lda.l $C30000,x
	tax
	phx
	adc.l $C30008,x
	tax
	lda.l $C30000,x
	xba
	ldy.w #$0000
CODE_C4CFAA:						; from CODE_C4CFAA
	iny
	asl a
	asl a
	asl a
	asl a
	bne CODE_C4CFAA
	plx
	lda.l $C30000,x
	and.w #$07FF
	lsr a
	sec
	sbc.w #$001C
CODE_C4CFBE:						; from CODE_C4CF7B, CODE_C4CFDE
	phy
	pha
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	asl a
	adc.b tmp0
	sta.b tmp0
	lsr a
	lsr a
	lsr a
	tax
	lda.b tmp0
	and.w #$0007
	tay
	lda.b $0A
CODE_C4CFD8:						; from CODE_C4CFD8
	dey
	bmi CODE_C4CFDE
	asl a
	bra CODE_C4CFD8
CODE_C4CFDE:						; from CODE_C4CFD8
	ora.l $30628F,x
	sta.l $30628F,x
	inc.b $0A
	pla
	inc a
	ply
	dey
	bne CODE_C4CFBE
	lda.w $17C9
	dec a
	bpl CODE_C4CF92
	rtl

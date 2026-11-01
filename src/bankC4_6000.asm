; Segment bankC4_6000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C45FAC
CODE_C45FAC:						; called from other segments
	lda.l DATA8_C4692F,x
	sta.b $7F
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C45FC2
	eor.b $7F
	bpl CODE_C45FC2
	lda.w $09A0,x
	bra CODE_C45FCA
CODE_C45FC2:						; from CODE_C45FAC
	lda.w $0D80,x
	asl a
	clc
	adc.w $09A0,x
CODE_C45FCA:						; from CODE_C45FAC
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	ldx.b $B7
	lda.w $09C1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	jsl.l getpde
	lda.w $186E
	cmp.w #$0002
	bne CODE_C45FFD
	lda.w #$1000
	sta.b $7F
CODE_C45FFD:						; from CODE_C45FCA
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C4603E
	lda.w $14F9,x
	bmi CODE_C4603E
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C4603E
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C4603E:						; from CODE_C45FFD
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C46048
	sta.w $09A0,x
CODE_C46048:						; from CODE_C4603E
	lda.w $186E
	beq CODE_C46074
	lda.w $04B0
	and.w #$003F
	bne CODE_C46074
	jsl.l getpde
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C46070
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C46070:						; from CODE_C46048
	jml.l CODE_C54A2F
CODE_C46074:						; from CODE_C46048
	rtl
CODE_C46075:						; called from other segments
	lda.l DATA8_C4692F,x
	sta.b $7F
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C46091
	eor.b $83
	bmi CODE_C46091
	lda.w $09C0,x
	bra CODE_C46098
CODE_C46091:						; from CODE_C46075
	sec
	lda.w $09C0,x
	sbc.w $0DA0,x
CODE_C46098:						; from CODE_C46075
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C460B5
	eor.b $7F
	bpl CODE_C460B5
	lda.w $09A0,x
	bra CODE_C460BB
CODE_C460B5:						; from CODE_C46098
	lda.w $09A0,x
	adc.w $0DA0,x
CODE_C460BB:						; from CODE_C46098
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w $186E
	cmp.w #$0002
	bne CODE_C460E1
	lda.w #$1000
	sta.b $7F
CODE_C460E1:						; from CODE_C460BB
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C46122
	lda.w $14F9,x
	bmi CODE_C46122
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C46122
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C46122:						; from CODE_C460E1
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C4612C
	sta.w $09C0,x
CODE_C4612C:						; from CODE_C46122
	pla
	bcc CODE_C46132
	sta.w $09A0,x
CODE_C46132:						; from CODE_C4612C
	lda.w $186E
	beq CODE_C4615E
	lda.w $04B0
	and.w #$003F
	bne CODE_C4615E
	jsl.l getpde
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C4615A
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C4615A:						; from CODE_C46132
	jml.l CODE_C54A2F
CODE_C4615E:						; from CODE_C46132
	rtl
CODE_C4615F:						; called from other segments
	lda.l DATA8_C4692F,x
	sta.b $7F
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C4617B
	eor.b $83
	bmi CODE_C4617B
	lda.w $09C0,x
	bra CODE_C46186
CODE_C4617B:						; from CODE_C4615F
	sec
	lda.w $09C0,x
	sbc.w $0DA0,x
	sec
	sbc.w $0DA0,x
CODE_C46186:						; from CODE_C4615F
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C461A3
	eor.b $7F
	bpl CODE_C461A3
	lda.w $09A0,x
	bra CODE_C461AB
CODE_C461A3:						; from CODE_C46186
	lda.w $0DA0,x
	asl a
	clc
	adc.w $09A0,x
CODE_C461AB:						; from CODE_C46186
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w $186E
	cmp.w #$0002
	bne CODE_C461D1
	lda.w #$1000
	sta.b $7F
CODE_C461D1:						; from CODE_C461AB
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C46212
	lda.w $14F9,x
	bmi CODE_C46212
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C46212
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C46212:						; from CODE_C461D1
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C4621C
	sta.w $09C0,x
CODE_C4621C:						; from CODE_C46212
	pla
	bcc CODE_C46222
	sta.w $09A0,x
CODE_C46222:						; from CODE_C4621C
	lda.w $186E
	beq CODE_C4624E
	lda.w $04B0
	and.w #$003F
	bne CODE_C4624E
	jsl.l getpde
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C4624A
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C4624A:						; from CODE_C46222
	jml.l CODE_C54A2F
CODE_C4624E:						; from CODE_C46222
	rtl
CODE_C4624F:						; called from other segments
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C46265
	eor.b $83
	bmi CODE_C46265
	lda.w $09C0,x
	bra CODE_C4626C
CODE_C46265:						; from CODE_C4624F
	sec
	lda.w $09C0,x
	sbc.w $0D80,x
CODE_C4626C:						; from CODE_C4624F
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	ldx.b $B7
	lda.w $09A1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($83)
	jsl.l getpde
	lda.w $186E
	cmp.w #$0002
	bne CODE_C4629F
	lda.w #$1000
	sta.b $7F
CODE_C4629F:						; from CODE_C4626C
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C462E0
	lda.w $14F9,x
	bmi CODE_C462E0
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C462E0
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C462E0:						; from CODE_C4629F
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C462EA
	sta.w $09C0,x
CODE_C462EA:						; from CODE_C462E0
	lda.w $186E
	beq CODE_C46316
	lda.w $04B0
	and.w #$003F
	bne CODE_C46316
	jsl.l getpde
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C46312
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C46312:						; from CODE_C462EA
	jml.l CODE_C54A2F
CODE_C46316:						; from CODE_C462EA
	rtl
CODE_C46317:						; called from other segments
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C4632D
	eor.b $83
	bmi CODE_C4632D
	lda.w $09C0,x
	bra CODE_C46338
CODE_C4632D:						; from CODE_C46317
	sec
	lda.w $09C0,x
	sbc.w $0D80,x
	sec
	sbc.w $0D80,x
CODE_C46338:						; from CODE_C46317
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	ldx.b $B7
	lda.w $09A1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($83)
	jsl.l getpde
	lda.w $186E
	cmp.w #$0002
	bne CODE_C4636B
	lda.w #$1000
	sta.b $7F
CODE_C4636B:						; from CODE_C46338
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C463AC
	lda.w $14F9,x
	bmi CODE_C463AC
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C463AC
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C463AC:						; from CODE_C4636B
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C463B6
	sta.w $09C0,x
CODE_C463B6:						; from CODE_C463AC
	lda.w $186E
	beq CODE_C463E2
	lda.w $04B0
	and.w #$003F
	bne CODE_C463E2
	jsl.l getpde
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C463DE
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C463DE:						; from CODE_C463B6
	jml.l CODE_C54A2F
CODE_C463E2:						; from CODE_C463B6
	rtl
CODE_C463E3:						; called from other segments
	lda.l DATA8_C4692F,x
	sta.b $7F
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C463FF
	eor.b $83
	bmi CODE_C463FF
	lda.w $09C0,x
	bra CODE_C46406
CODE_C463FF:						; from CODE_C463E3
	sec
	lda.w $09C0,x
	sbc.w $0DA0,x
CODE_C46406:						; from CODE_C463E3
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C46423
	eor.b $7F
	bpl CODE_C46423
	lda.w $09A0,x
	bra CODE_C4642A
CODE_C46423:						; from CODE_C46406
	sec
	lda.w $09A0,x
	sbc.w $0DA0,x
CODE_C4642A:						; from CODE_C46406
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w $186E
	cmp.w #$0002
	bne CODE_C46450
	lda.w #$1000
	sta.b $7F
CODE_C46450:						; from CODE_C4642A
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C46491
	lda.w $14F9,x
	bmi CODE_C46491
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C46491
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C46491:						; from CODE_C46450
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C4649B
	sta.w $09C0,x
CODE_C4649B:						; from CODE_C46491
	pla
	bcc CODE_C464A1
	sta.w $09A0,x
CODE_C464A1:						; from CODE_C4649B
	lda.w $186E
	beq CODE_C464CD
	lda.w $04B0
	and.w #$003F
	bne CODE_C464CD
	jsl.l getpde
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C464C9
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C464C9:						; from CODE_C464A1
	jml.l CODE_C54A2F
CODE_C464CD:						; from CODE_C464A1
	rtl
CODE_C464CE:						; called from other segments
	lda.l DATA8_C4692F,x
	sta.b $7F
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C464EA
	eor.b $83
	bmi CODE_C464EA
	lda.w $09C0,x
	bra CODE_C464F5
CODE_C464EA:						; from CODE_C464CE
	sec
	lda.w $09C0,x
	sbc.w $0DA0,x
	sec
	sbc.w $0DA0,x
CODE_C464F5:						; from CODE_C464CE
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C46512
	eor.b $7F
	bpl CODE_C46512
	lda.w $09A0,x
	bra CODE_C4651D
CODE_C46512:						; from CODE_C464F5
	sec
	lda.w $09A0,x
	sbc.w $0DA0,x
	sec
	sbc.w $0DA0,x
CODE_C4651D:						; from CODE_C464F5
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w $186E
	cmp.w #$0002
	bne CODE_C46543
	lda.w #$1000
	sta.b $7F
CODE_C46543:						; from CODE_C4651D
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C46584
	lda.w $14F9,x
	bmi CODE_C46584
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C46584
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C46584:						; from CODE_C46543
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C4658E
	sta.w $09C0,x
CODE_C4658E:						; from CODE_C46584
	pla
	bcc CODE_C46594
	sta.w $09A0,x
CODE_C46594:						; from CODE_C4658E
	lda.w $186E
	beq CODE_C465C0
	lda.w $04B0
	and.w #$003F
	bne CODE_C465C0
	jsl.l getpde
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C465BC
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C465BC:						; from CODE_C46594
	jml.l CODE_C54A2F
CODE_C465C0:						; from CODE_C46594
	rtl
CODE_C465C1:						; called from other segments
	lda.l DATA8_C4692F,x
	sta.b $7F
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C465D7
	eor.b $7F
	bpl CODE_C465D7
	lda.w $09A0,x
	bra CODE_C465DE
CODE_C465D7:						; from CODE_C465C1
	sec
	lda.w $09A0,x
	sbc.w $0D80,x
CODE_C465DE:						; from CODE_C465C1
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	ldx.b $B7
	lda.w $09C1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	jsl.l getpde
	lda.w $186E
	cmp.w #$0002
	bne CODE_C46611
	lda.w #$1000
	sta.b $7F
CODE_C46611:						; from CODE_C465DE
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C46652
	lda.w $14F9,x
	bmi CODE_C46652
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C46652
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C46652:						; from CODE_C46611
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C4665C
	sta.w $09A0,x
CODE_C4665C:						; from CODE_C46652
	lda.w $186E
	beq CODE_C46688
	lda.w $04B0
	and.w #$003F
	bne CODE_C46688
	jsl.l getpde
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C46684
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C46684:						; from CODE_C4665C
	jml.l CODE_C54A2F
CODE_C46688:						; from CODE_C4665C
	rtl
CODE_C46689:						; called from other segments
	lda.l DATA8_C4692F,x
	sta.b $7F
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C4669F
	eor.b $7F
	bpl CODE_C4669F
	lda.w $09A0,x
	bra CODE_C466AA
CODE_C4669F:						; from CODE_C46689
	sec
	lda.w $09A0,x
	sbc.w $0D80,x
	sec
	sbc.w $0D80,x
CODE_C466AA:						; from CODE_C46689
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	ldx.b $B7
	lda.w $09C1,x
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	jsl.l getpde
	lda.w $186E
	cmp.w #$0002
	bne CODE_C466DD
	lda.w #$1000
	sta.b $7F
CODE_C466DD:						; from CODE_C466AA
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C4671E
	lda.w $14F9,x
	bmi CODE_C4671E
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C4671E
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C4671E:						; from CODE_C466DD
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C46728
	sta.w $09A0,x
CODE_C46728:						; from CODE_C4671E
	lda.w $186E
	beq CODE_C46754
	lda.w $04B0
	and.w #$003F
	bne CODE_C46754
	jsl.l getpde
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C46750
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C46750:						; from CODE_C46728
	jml.l CODE_C54A2F
CODE_C46754:						; from CODE_C46728
	rtl
CODE_C46755:						; called from other segments
	lda.l DATA8_C4692F,x
	sta.b $7F
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C46771
	eor.b $83
	bmi CODE_C46771
	lda.w $09C0,x
	bra CODE_C46777
CODE_C46771:						; from CODE_C46755
	lda.w $09C0,x
	adc.w $0DA0,x
CODE_C46777:						; from CODE_C46755
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C46794
	eor.b $7F
	bpl CODE_C46794
	lda.w $09A0,x
	bra CODE_C4679B
CODE_C46794:						; from CODE_C46777
	sec
	lda.w $09A0,x
	sbc.w $0DA0,x
CODE_C4679B:						; from CODE_C46777
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w $186E
	cmp.w #$0002
	bne CODE_C467C1
	lda.w #$1000
	sta.b $7F
CODE_C467C1:						; from CODE_C4679B
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C46802
	lda.w $14F9,x
	bmi CODE_C46802
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C46802
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C46802:						; from CODE_C467C1
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C4680C
	sta.w $09C0,x
CODE_C4680C:						; from CODE_C46802
	pla
	bcc CODE_C46812
	sta.w $09A0,x
CODE_C46812:						; from CODE_C4680C
	lda.w $186E
	beq CODE_C4683E
	lda.w $04B0
	and.w #$003F
	bne CODE_C4683E
	jsl.l getpde
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C4683A
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C4683A:						; from CODE_C46812
	jml.l CODE_C54A2F
CODE_C4683E:						; from CODE_C46812
	rtl
CODE_C4683F:						; called from other segments
	lda.l DATA8_C4692F,x
	sta.b $7F
	lda.l DATA8_C4693F,x
	sta.b $83
	ldx.b $B7
	lda.w $0BE0,x
	beq CODE_C4685B
	eor.b $83
	bmi CODE_C4685B
	lda.w $09C0,x
	bra CODE_C46863
CODE_C4685B:						; from CODE_C4683F
	lda.w $0DA0,x
	asl a
	clc
	adc.w $09C0,x
CODE_C46863:						; from CODE_C4683F
	sta.b $83
	xba
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	tay
	ldx.b $B7
	lda.w $0C00,x
	beq CODE_C46880
	eor.b $7F
	bpl CODE_C46880
	lda.w $09A0,x
	bra CODE_C4688B
CODE_C46880:						; from CODE_C46863
	sec
	lda.w $09A0,x
	sbc.w $0DA0,x
	sec
	sbc.w $0DA0,x
CODE_C4688B:						; from CODE_C46863
	sta.b $7F
	xba
	and.w #$00FF
	asl a
	tax
	tya
	adc.l DATA8_C38A4A,x
	sta.b $8B
	ldx.b $B7
	pei ($7F)
	pei ($83)
	jsl.l getpde
	lda.w $186E
	cmp.w #$0002
	bne CODE_C468B1
	lda.w #$1000
	sta.b $7F
CODE_C468B1:						; from CODE_C4688B
	lda.w $0E20,x
	asl a
	tax
	lda.b $7F
	lsr a
	adc.w #$0800
	jsr (DATA8_C45C7D,x)
	xba
	lsr a
	lsr a
	and.w #$003C
	tax
	lda.l DATA8_C09BC4,x
	sta.b $87
	lda.l $C09BC6,x
	sta.b $89
	ldx.b $B7
	lda.w $0A20,x
	bne CODE_C468F2
	lda.w $14F9,x
	bmi CODE_C468F2
	lda.w $05CC,x
	bit.w #$0004
	bne CODE_C468F2
	lda.b $89
	lsr a
	lsr a
	eor.w #$FFFF
	inc a
	adc.b $89
	sta.b $89
CODE_C468F2:						; from CODE_C468B1
	lda.b $89
	cmp.b $8B
	pla
	bcc CODE_C468FC
	sta.w $09C0,x
CODE_C468FC:						; from CODE_C468F2
	pla
	bcc CODE_C46902
	sta.w $09A0,x
CODE_C46902:						; from CODE_C468FC
	lda.w $186E
	beq CODE_C4692E
	lda.w $04B0
	and.w #$003F
	bne CODE_C4692E
	jsl.l getpde
	lda.b $7F
	sec
	sbc.w #$0021
	sta.b $7F
	cmp.w #$0C00
	bmi CODE_C4692A
	lda.w $0F40,x
	sta.b $87
	clc
	adc.b $7F
	sta.b $7F
CODE_C4692A:						; from CODE_C46902
	jml.l CODE_C54A2F
CODE_C4692E:						; from CODE_C46902
	rtl
DATA8_C4692F:						; not traced: a table read by CODE_C45FAC, CODE_C46075, CODE_C4615F, ...
	db $00,$00,$04,$00,$07,$00,$04,$00,$00,$00,$FC,$FF,$F9,$FF,$FC,$FF
DATA8_C4693F:						; not traced: a table read by CODE_C46075, CODE_C4615F, CODE_C4624F, ...
	db $07,$00,$04,$00,$00,$00,$FC,$FF,$F9,$FF,$FC,$FF,$00,$00,$04,$00
doplayeracc:						; from CODE_C470E7 and other segments
	lda.w $0A20,x
	bne CODE_C46957
	jmp.w goalieacc
CODE_C46957:						; from doplayeracc
	lda.w $0C80,x
	cmp.w #$2082
	beq CODE_C46992
	lda.w #$1958
	sta.b $83
	lda.w $1040,x
	beq CODE_C4696E
	lda.w #$1F6C
	sta.b $83
CODE_C4696E:						; from CODE_C46957
	lda.b $7F
	and.w #$000F
	sta.b $7F
	cmp.w #$0008
	bcc CODE_C46993
	cmp.w #$0009
	bne CODE_C4698A
	lda.w $09A0,x
	ora.w $09C0,x
	beq CODE_C4698A
	jmp.w dostop
CODE_C4698A:						; from CODE_C4696E
	lda.w $1060,x
	bne CODE_C46992
	jmp.w SetSPA
CODE_C46992:						; from CODE_C46957, CODE_C4698A
	rtl
CODE_C46993:						; from CODE_C4696E
	pei ($83)
	lda.b $7F
	pha
	sta.b $87
	cpx.w $05A0
	bne CODE_C469A2
	jmp.w CODE_C46A50
CODE_C469A2:						; from CODE_C46993
	lda.w $0830
	sec
	sbc.w $0814,x
	sta.b $7F
	lda.w $0896,x
	sta.b $8B
	lda.w $09DD
	and.w #$00FF
	cmp.w #$0080
	bcc CODE_C469BE
	ora.w #$FF00
CODE_C469BE:						; from CODE_C469A2
	clc
	adc.w $08B2
	sec
	sbc.b $8B
	sta.b $83
	lda.w $0FE0,x
	bne CODE_C469EB
	lda.w #$0000
	sec
	sbc.b $7F
	sta.b $7F
	lda.w #$0000
	sec
	sbc.b $83
	sta.b $83
	lda.w #$0000
	sec
	sbc.b $8B
	sta.b $8B
	lda.b $87
	eor.w #$0004
	sta.b $87
CODE_C469EB:						; from CODE_C469BE
	lda.w $1040,x
	bne CODE_C46A0A
	lda.b $8B
	bpl CODE_C46A50
	lda.b $87
	cmp.w #$0004
	bne CODE_C46A50
	jsl.l vtoa
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs CODE_C46A50
	bra CODE_C46A26
CODE_C46A0A:						; from CODE_C469EB
	lda.b $87
	sec
	sbc.w #$0003
	and.w #$0007
	cmp.w #$0003
	bcs CODE_C46A50
	jsl.l vtoa
	inc a
	inc a
	and.w #$0007
	cmp.w #$0005
	bcs CODE_C46A50
CODE_C46A26:						; from CODE_C469EB
	lda.w $1040,x
	bne CODE_C46A53
	lda.w $09A0,x
	sta.b $7F
	ora.w $09C0,x
	beq CODE_C46A4A
	lda.w $09C0,x
	sta.b $83
	jsl.l vtoa
	sec
	sbc.b $01,s
	inc a
	and.w #$0007
	cmp.w #$0003
	bcs CODE_C46A53
CODE_C46A4A:						; from CODE_C46A26
	inc a
	sta.w $1040,x
	bra CODE_C46A53
CODE_C46A50:						; from CODE_C46993, CODE_C469EB, CODE_C46A0A
	stz.w $1040,x
CODE_C46A53:						; from CODE_C46A26, CODE_C46A4A
	pla
	sta.b $7F
	pla
	sta.b $83
	lda.w $0C40,x
	sta.b $87
	lda.b $7F
	sec
	sbc.b $87
	and.w #$0007
	asl a
	sta.b $7F
	tax
	lda.l DATA8_C46B26,x
	ldx.b $6F
	cmp.w #$0000
	bne CODE_C46A78
	jmp.w noturn0
CODE_C46A78:						; from CODE_C46A53
	asl a
	sta.b $9F
	lda.w $09A1,x
	and.w #$00FF
	asl a
	tax
	lda.l DATA8_C38A4A,x
	sta.b $8F
	ldx.b $6F
	lda.w $09C1,x
	and.w #$00FF
	asl a
	tax
	lda.b $8F
	adc.l DATA8_C38A4A,x
	sta.b $8B
	lda.w #$0300
	sec
	sbc.b $8B
	sta.b $8F
	sec
	sbc.w #$0180
	bpl CODE_C46AAE
	lda.w #$0180
	sta.b $8F
CODE_C46AAE:						; from CODE_C46A78
	lda.b $9F
	ldx.b $8F
	jsl.l Mul16x8S
	lda.b $36
	sta.b $91
	lda.b $34
	sta.b $8F
	ldx.b $6F
	lda.w $1040,x
	beq CODE_C46AD4
	lda.w #$0000
	sec
	sbc.b $8F
	sta.b $8F
	lda.w #$0000
	sbc.b $91
	sta.b $91
CODE_C46AD4:						; from CODE_C46AAE
	lda.w $0C60,x
	clc
	adc.b $8F
	sta.w $0C60,x
	lda.w $0C40,x
	adc.b $91
	and.w #$0007
	sta.w $0C40,x
	sta.b $87
	lda.b $8B
	cmp.w #$0015
	bcc CODE_C46B0C
	lda.w #$198A
	sta.b $83
	lda.b $9F
	bpl CODE_C46AFF
	lda.w #$198A
	sta.b $83
CODE_C46AFF:						; from CODE_C46AD4
	lda.w $08E0,x
	bit.w #$0800
	beq CODE_C46B0C
	lda.w #$198A
	sta.b $83
CODE_C46B0C:						; from CODE_C46AD4, CODE_C46AFF
	lda.w $1060,x
	bne CODE_C46B1B
	jsl.l SetSPA
	lda.w #$0001
	sta.w $1060,x
CODE_C46B1B:						; from CODE_C46B0C
	lda.b $8B
	cmp.w #$0003
	bcc CODE_C46B25
	jmp.w revplayeracc
CODE_C46B25:						; from CODE_C46B1B
	rtl
DATA8_C46B26:						; not traced: a table read by CODE_C46A53
	db $00,$00,$11,$00,$11,$00,$11,$00,$00,$00,$EF,$FF,$EF,$FF,$EF,$FF
noturn0:							; from CODE_C46A53
	lda.w #$0002
	sta.b $8F
	lda.w $1040,x
	beq CODE_C46B4C
	lda.w #$0006
	sta.b $8F
	lda.b $7F
	eor.w #$0008
	sta.b $7F
CODE_C46B4C:						; from noturn0
	lda.b $7F
	beq CODE_C46BA8
	lda.w $09A0,x
	sta.b $7F
	lda.w $09C0,x
	sta.b $83
	jsl.l vtoa
	bit.w #$0008
	bne CODE_C46B77
	sec
	sbc.w $0C40,x
	clc
	adc.b $8F
	and.w #$0007
	sta.b $7F
	cmp.w #$0004
	bcs CODE_C46B77
	jmp.w dostop
CODE_C46B77:						; from CODE_C46B4C
	inc.w $0C40,x
	lda.w $08E0,x
	bit.w #$0800
	beq CODE_C46B88
	dec.w $0C40,x
	dec.w $0C40,x
CODE_C46B88:						; from CODE_C46B77
	lda.w $0C40,x
	and.w #$0007
	sta.w $0C40,x
	lda.w #$1958
	sta.b $83
	lda.w $1040,x
	bne CODE_C46B9E
	jmp.w SetSPA
CODE_C46B9E:						; from CODE_C46B88
	ldy.w #$0001
	lda.w #$1F6C
	jml.l SetSPAFromA
CODE_C46BA8:						; from CODE_C46B4C
	ldy.w #$0001
	lda.w #$1F9E
	sta.b $83
	lda.w $1040,x
	bne CODE_C46BDA
	ldy.w #$0000
	lda.w #$1A3C
	sta.b $83
	lda.w $0D60,x
	bit.w #$0004
	beq CODE_C46BCD
	ldy.w #$0001
	lda.w #$25D2
	sta.b $83
CODE_C46BCD:						; from CODE_C46BA8
	cpx.w $05A0
	bne CODE_C46BDA
	ldy.w #$0000
	lda.w #$198A
	sta.b $83
CODE_C46BDA:						; from CODE_C46BA8, CODE_C46BCD
	lda.w $1060,x
	bne revplayeracc
	tya
	sta.w $1060,x
	jsl.l SetSPA
revplayeracc:						; from CODE_C46B1B, CODE_C46BDA
	lda.w $1040,x
	beq CODE_C46BF3
	lda.b $87
	eor.w #$0004
	sta.b $87
CODE_C46BF3:						; from revplayeracc
	jmp.w CODE_C45ABE
CODE_C46BF6:						; from CODE_C47040 and other segments
	stz.b $A3
	lda.w $0814,x
	sta.b $38
	lda.w $0896,x
	sta.b $3A
	lda.b $7F
	sta.b $3C
	lda.b $83
	sta.b $3E
	lda.w $0A20,x
	bne CODE_C46C12
	jmp.w CODE_C46E4B
CODE_C46C12:						; from CODE_C46BF6
	ldx.w #$00EB
	ldy.w #$0122
	jsr.w CODE_C46DCA
	ldx.w #$00EA
	ldy.w #$0123
	stx.b $40
	sty.b $42
	lda.w #$010E
	sta.b $46
	lda.w $0664
	sta.b $44
	lda.b $A3
	bne CODE_C46C57
	ldx.w #$FEDE
	ldy.w #$FF15
	jsr.w CODE_C46DCA
	ldx.w #$FEDD
	ldy.w #$FF16
	stx.b $40
	sty.b $42
	lda.w #$FEF2
	sta.b $46
	lda.w $0666
	sta.b $44
	lda.b $A3
	bne CODE_C46C87
	ldx.b $B7
	rtl
CODE_C46C57:						; from CODE_C46C12
	lda.b $40
	ldy.b $42
	sty.b $40
	sta.b $42
	lda.b $3A
	eor.w #$FFFF
	inc a
	sta.b $3A
	lda.b $3E
	eor.w #$FFFF
	inc a
	sta.b $3E
	lda.b $9F
	bit.w #$000A
	beq CODE_C46C7B
	eor.w #$000A
	sta.b $9F
CODE_C46C7B:						; from CODE_C46C57
	lda.b $A1
	bit.w #$000A
	beq CODE_C46C87
	eor.w #$000A
	sta.b $A1
CODE_C46C87:						; from CODE_C46C12, CODE_C46C7B
	lda.b $A1
	beq CODE_C46C93
	ldx.b $9F
	jsr (DATA8_C46DB0,x)
	ldx.b $B7
	rtl
CODE_C46C93:						; from CODE_C46C87
	jsr.w CODE_C46C99
	ldx.b $B7
	rtl
CODE_C46C99:						; from CODE_C46C93
	ldx.b $B7
	lda.b $3A
	cmp.w #$FEF2
	bpl CODE_C46CAB
	lda.b $3E
	cmp.w #$FEF2
	bmi CODE_C46CC5
	bra CODE_C46CE3
CODE_C46CAB:						; from CODE_C46C99
	lda.b $3E
	cmp.w #$FEF2
	bmi CODE_C46CD0
	ldy.b $44
	bmi CODE_C46CC5
	lda.b $38
	cmp.b $3C
	bmi CODE_C46CC6
	cmp.w $0814,y
	bmi CODE_C46CC5
	lda.b $42
	sta.b $83
CODE_C46CC5:						; from CODE_C46C99, CODE_C46CAB
	rts
CODE_C46CC6:						; from CODE_C46CAB
	cmp.w $0814,y
	bpl CODE_C46CCF
	lda.b $42
	sta.b $83
CODE_C46CCF:						; from CODE_C46CC6
	rts
CODE_C46CD0:						; from CODE_C46CAB
	lda.b $42
	sta.b $83
	bra CODE_C46D11
CODE_C46CD6:						; from CODE_C46CE3, CODE_C46CF5
	lda.w #$FFCA
	sta.b $7F
	rts
CODE_C46CDC:						; from DATA8_C46DB0
	lda.b $3A
	cmp.w #$FEF2
	bpl CODE_C46CF5
CODE_C46CE3:						; from CODE_C46C99
	lda.b $38
	cmp.w #$FFCB
	bmi CODE_C46CD6
	cmp.w #$0036
	bpl CODE_C46D5E
	lda.b $40
	sta.b $83
	bra CODE_C46D36
CODE_C46CF5:						; from CODE_C46CDC
	lda.b $3E
	cmp.w #$FEF2
	bpl CODE_C46D0D
	lda.b $46
	sta.b $83
	ldy.b $44
	bmi CODE_C46D36
	lda.b $38
	cmp.w $0814,y
	bmi CODE_C46CD6
	bra CODE_C46D5E
CODE_C46D0D:						; from CODE_C46CF5
	ldy.b $44
	bmi CODE_C46D4F
CODE_C46D11:						; from CODE_C46CD0
	lda.b $3C
	sec
	sbc.w $0814,y
	pha
	lda.b $38
	sec
	sbc.b $3C
	eor.b $01,s
	bpl CODE_C46D50
	pla
	lda.b $38
	cmp.w $0814,y
	bpl CODE_C46D5E
	bra CODE_C46D90
CODE_C46D2B:						; from DATA8_C46DB0
	lda.b $42
	sta.b $83
	lda.b $A1
	and.w #$0008
	bne CODE_C46D4F
CODE_C46D36:						; from CODE_C46CE3, CODE_C46D7D, CODE_C46CF5
	lda.b $3C
	bpl CODE_C46D45
	cmp.w #$FFCB
	bmi CODE_C46D4F
	lda.w #$FFCA
	sta.b $7F
	rts
CODE_C46D45:						; from CODE_C46D36
	cmp.w #$0036
	bpl CODE_C46D4F
	lda.w #$0036
	sta.b $7F
CODE_C46D4F:						; from CODE_C46D2B, CODE_C46D36, CODE_C46D45, CODE_C46D0D
	rts
CODE_C46D50:						; from CODE_C46D11
	pla
	rts
CODE_C46D52:						; from DATA8_C46DB0
	lda.b $A1
	cmp.w #$0010
	bne CODE_C46D5E
CODE_C46D59:						; from CODE_C46D64, CODE_C46D96, CODE_C46DA3
	lda.b $42
	sta.b $83
	rts
CODE_C46D5E:						; from CODE_C46CE3, CODE_C46D52, CODE_C46D71, CODE_C46CF5, ...
	lda.w #$0036
	sta.b $7F
	rts
CODE_C46D64:						; from DATA8_C46DB0
	lda.w #$0036
	sta.b $7F
	lda.b $A1
	and.w #$000A
	beq CODE_C46D59
	rts
CODE_C46D71:						; from DATA8_C46DB0
	lda.b $A1
	cmp.w #$0010
	bne CODE_C46D5E
CODE_C46D78:						; from CODE_C46D89
	lda.b $40
	sta.b $83
	rts
CODE_C46D7D:						; from DATA8_C46DB0
	lda.b $40
	sta.b $83
	lda.b $A1
	and.w #$0002
	bne CODE_C46D36
	rts
CODE_C46D89:						; from DATA8_C46DB0
	lda.b $A1
	cmp.w #$0004
	beq CODE_C46D78
CODE_C46D90:						; from CODE_C46D11
	lda.w #$FFCA
	sta.b $7F
	rts
CODE_C46D96:						; from DATA8_C46DB0
	lda.w #$FFCA
	sta.b $7F
	lda.b $A1
	and.w #$000A
	beq CODE_C46D59
	rts
CODE_C46DA3:						; from DATA8_C46DB0
	lda.b $A1
	cmp.w #$0004
	beq CODE_C46D59
	lda.w #$FFCA
	sta.b $7F
	rts
DATA8_C46DB0:						; jump table: the routine for each index
	dw CODE_C46CDC,CODE_C46D2B,CODE_C46D64,CODE_C46D52
	dw CODE_C46D7D,$0000,CODE_C46D71,$0000
	dw CODE_C46D96,CODE_C46DA3,$0000,$0000
	dw CODE_C46D89
CODE_C46DCA:						; from CODE_C46C12
	stx.b $40
	sty.b $42
	stz.b $9F
	stz.b $A1
	ldx.b $3A
	ldy.b $3E
	cpx.b $40
	bpl CODE_C46DFD
	lda.w #$0008
	sta.b $9F
	cpy.b $40
	bpl CODE_C46E06
CODE_C46DE3:						; from CODE_C46E06, CODE_C46E13, CODE_C46E28
	rts
CODE_C46DE4:						; from CODE_C46E06
	cpy.b $42
	bmi CODE_C46E13
	lda.w #$0002
	sta.b $A1
	bra CODE_C46E13
CODE_C46DEF:						; from CODE_C46E13
	cpy.w #$002C
	bmi CODE_C46E28
	lda.b $A1
	ora.w #$0004
	sta.b $A1
	bra CODE_C46E28
CODE_C46DFD:						; from CODE_C46DCA
	cpy.b $40
	bpl CODE_C46E06
	lda.w #$0008
	sta.b $A1
CODE_C46E06:						; from CODE_C46DCA, CODE_C46DFD
	cpx.b $42
	bmi CODE_C46DE4
	lda.w #$0002
	sta.b $9F
	cpy.b $42
	bpl CODE_C46DE3
CODE_C46E13:						; from CODE_C46DE4
	ldx.b $38
	ldy.b $3C
	cpx.w #$002C
	bmi CODE_C46DEF
	lda.b $9F
	ora.w #$0004
	sta.b $9F
	cpy.w #$002C
	bpl CODE_C46DE3
CODE_C46E28:						; from CODE_C46DEF
	cpx.w #$FFD4
	bpl CODE_C46E3C
	lda.b $9F
	ora.w #$0010
	sta.b $9F
	cpy.w #$FFD4
	bmi CODE_C46DE3
CODE_C46E39:						; from CODE_C46E3C
	inc.b $A3
	rts
CODE_C46E3C:						; from CODE_C46E28
	cpy.w #$FFD4
	bpl CODE_C46E39
	lda.b $A1
	ora.w #$0010
	sta.b $A1
	inc.b $A3
	rts
CODE_C46E4B:						; from CODE_C46BF6
	ldx.w #$0108
	ldy.w #$0122
	jsr.w CODE_C46FAD
	ldx.w #$0107
	ldy.w #$0123
	stx.b $40
	sty.b $42
	lda.b $A3
	bne CODE_C46E7C
	ldx.w #$FEDE
	ldy.w #$FEF8
	jsr.w CODE_C46FAD
	ldx.w #$FEDD
	ldy.w #$FEF9
	stx.b $40
	sty.b $42
	lda.b $A3
	bne CODE_C46EAC
	ldx.b $B7
	rtl
CODE_C46E7C:						; from CODE_C46E4B
	lda.b $40
	ldy.b $42
	sty.b $40
	sta.b $42
	lda.b $3A
	eor.w #$FFFF
	inc a
	sta.b $3A
	lda.b $3E
	eor.w #$FFFF
	inc a
	sta.b $3E
	lda.b $9F
	bit.w #$000A
	beq CODE_C46EA0
	eor.w #$000A
	sta.b $9F
CODE_C46EA0:						; from CODE_C46E7C
	lda.b $A1
	bit.w #$000A
	beq CODE_C46EAC
	eor.w #$000A
	sta.b $A1
CODE_C46EAC:						; from CODE_C46E4B, CODE_C46EA0
	lda.b $A1
	beq CODE_C46EB8
	ldx.b $9F
	jsr (DATA8_C46F93,x)
	ldx.b $B7
	rtl
CODE_C46EB8:						; from CODE_C46EAC
	jsr.w CODE_C46EBE
	ldx.b $B7
	rtl
CODE_C46EBE:						; from CODE_C46EB8
	ldx.b $B7
	lda.b $3A
	cmp.w #$FEF2
	bpl CODE_C46ED0
	lda.b $3E
	cmp.w #$FEF2
	bmi CODE_C46ED9
	bra CODE_C46EF1
CODE_C46ED0:						; from CODE_C46EBE
	lda.b $3E
	cmp.w #$FEF2
	bpl CODE_C46ED9
	bra CODE_C46F0A
CODE_C46ED9:						; from CODE_C46EBE, CODE_C46ED0
	rts
CODE_C46EDA:						; no caller found (not traced)
	cmp.w $0814,y
	bpl CODE_C46F34
	lda.b $42
	sta.b $83
	rts
CODE_C46EE4:						; from CODE_C46EF1
	lda.w #$FFDA
	sta.b $7F
	rts
CODE_C46EEA:						; from DATA8_C46F93
	lda.b $3A
	cmp.w #$FEF2
	bpl CODE_C46F03
CODE_C46EF1:						; from CODE_C46EBE
	lda.b $38
	cmp.w #$FFDB
	bmi CODE_C46EE4
	cmp.w #$0026
	bpl CODE_C46F41
	lda.b $40
	sta.b $83
	bra CODE_C46F1B
CODE_C46F03:						; from CODE_C46EEA
	lda.b $A1
	bit.w #$0002
	bne CODE_C46F34
CODE_C46F0A:						; from CODE_C46ED0
	lda.b $42
	sta.b $83
	bra CODE_C46F1B
CODE_C46F10:						; from DATA8_C46F93
	lda.b $42
	sta.b $83
	lda.b $A1
	and.w #$0008
	bne CODE_C46F34
CODE_C46F1B:						; from CODE_C46EF1, CODE_C46F60, CODE_C46F0A
	lda.b $3C
	bpl CODE_C46F2A
	cmp.w #$FFDB
	bmi CODE_C46F34
	lda.w #$FFDA
	sta.b $7F
	rts
CODE_C46F2A:						; from CODE_C46F1B
	cmp.w #$0026
	bpl CODE_C46F34
	lda.w #$0026
	sta.b $7F
CODE_C46F34:						; from CODE_C46EDA, CODE_C46F10, CODE_C46F1B, CODE_C46F03, ...
	rts
CODE_C46F35:						; from DATA8_C46F93
	lda.b $A1
	cmp.w #$0010
	bne CODE_C46F41
CODE_C46F3C:						; from CODE_C46F47, CODE_C46F79, CODE_C46F86
	lda.b $42
	sta.b $83
	rts
CODE_C46F41:						; from CODE_C46EF1, CODE_C46F35, CODE_C46F54
	lda.w #$0026
	sta.b $7F
	rts
CODE_C46F47:						; from DATA8_C46F93
	lda.w #$0026
	sta.b $7F
	lda.b $A1
	and.w #$000A
	beq CODE_C46F3C
	rts
CODE_C46F54:						; from DATA8_C46F93
	lda.b $A1
	cmp.w #$0010
	bne CODE_C46F41
CODE_C46F5B:						; from CODE_C46F6C
	lda.b $40
	sta.b $83
	rts
CODE_C46F60:						; from DATA8_C46F93
	lda.b $40
	sta.b $83
	lda.b $A1
	and.w #$0002
	bne CODE_C46F1B
	rts
CODE_C46F6C:						; from DATA8_C46F93
	lda.b $A1
	cmp.w #$0004
	beq CODE_C46F5B
	lda.w #$FFDA
	sta.b $7F
	rts
CODE_C46F79:						; from DATA8_C46F93
	lda.w #$FFDA
	sta.b $7F
	lda.b $A1
	and.w #$000A
	beq CODE_C46F3C
	rts
CODE_C46F86:						; from DATA8_C46F93
	lda.b $A1
	cmp.w #$0004
	beq CODE_C46F3C
	lda.w #$FFDA
	sta.b $7F
	rts
DATA8_C46F93:						; jump table: the routine for each index
	dw CODE_C46EEA,CODE_C46F10,CODE_C46F47,CODE_C46F35
	dw CODE_C46F60,$0000,CODE_C46F54,$0000
	dw CODE_C46F79,CODE_C46F86,$0000,$0000
	dw CODE_C46F6C
CODE_C46FAD:						; from CODE_C46E4B
	stx.b $40
	sty.b $42
	stz.b $9F
	stz.b $A1
	ldx.b $3A
	ldy.b $3E
	cpx.b $40
	bpl CODE_C46FE0
	lda.w #$0008
	sta.b $9F
	cpy.b $40
	bpl CODE_C46FE9
CODE_C46FC6:						; from CODE_C46FE9, CODE_C46FF6, CODE_C4700B
	rts
CODE_C46FC7:						; from CODE_C46FE9
	cpy.b $42
	bmi CODE_C46FF6
	lda.w #$0002
	sta.b $A1
	bra CODE_C46FF6
CODE_C46FD2:						; from CODE_C46FF6
	cpy.w #$0024
	bmi CODE_C4700B
	lda.b $A1
	ora.w #$0004
	sta.b $A1
	bra CODE_C4700B
CODE_C46FE0:						; from CODE_C46FAD
	cpy.b $40
	bpl CODE_C46FE9
	lda.w #$0008
	sta.b $A1
CODE_C46FE9:						; from CODE_C46FAD, CODE_C46FE0
	cpx.b $42
	bmi CODE_C46FC7
	lda.w #$0002
	sta.b $9F
	cpy.b $42
	bpl CODE_C46FC6
CODE_C46FF6:						; from CODE_C46FC7
	ldx.b $38
	ldy.b $3C
	cpx.w #$0024
	bmi CODE_C46FD2
	lda.b $9F
	ora.w #$0004
	sta.b $9F
	cpy.w #$0024
	bpl CODE_C46FC6
CODE_C4700B:						; from CODE_C46FD2
	cpx.w #$FFDC
	bpl CODE_C4701F
	lda.b $9F
	ora.w #$0010
	sta.b $9F
	cpy.w #$FFDC
	bmi CODE_C46FC6
CODE_C4701C:						; from CODE_C4701F
	inc.b $A3
	rts
CODE_C4701F:						; from CODE_C4700B
	cpy.w #$FFDC
	bpl CODE_C4701C
	lda.b $A1
	ora.w #$0010
	sta.b $A1
	inc.b $A3
	rts

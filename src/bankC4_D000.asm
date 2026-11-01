; Segment bankC4_D000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4CFF5
CODE_C4CFF5:						; called from other segments
	phb
	lda.w #$0000
	sta.l $306050
	ldx.w #$6050
	ldy.w #$6052
	lda.w #$09C3
	mvn $30,$30
	ldx.w #$6E43
	ldy.w #$6E45
	lda.w #$0290
	stz.w $0000,x
	mvn $30,$30
	ldx.w #$72E8
	ldy.w #$72EA
	lda.w #$0622
	stz.w $0000,x
	mvn $30,$30
	lda.l $001902
	beq CODE_C4D051
	lda.w #$0183
	ldx.w #$7162
	ldy.w #$7164
	stz.w $0000,x
	mvn $30,$30
	lda.w #$03EA
	ldx.w #$6A56
	ldy.w #$6A58
	stz.w $0000,x
	mvn $30,$30
	jsr.w CODE_C4D05B
	jsr.w CODE_C4D0D5
CODE_C4D051:						; from CODE_C4CFF5
	jsl.l CODE_C4CF7B
	jsl.l CODE_C5E474
	plb
	rtl
CODE_C4D05B:						; from CODE_C4CFF5 and other segments
	ldx.w #$0032
CODE_C4D05E:						; from CODE_C4D0C1
	stx.b $9F
	lda.l $C30000,x
	tax
	lda.l $C30000,x
	tay
	xba
	and.w #$00F8
	lsr a
	lsr a
	lsr a
	sta.b $A1
	tya
	and.w #$07FF
	tax
CODE_C4D078:						; from CODE_C4D0C1
	stx.b $A3
	txa
	sec
	sbc.w #$0038
	sta.b $A5
	asl a
	adc.b $A5
	lsr a
	lsr a
	tay
	lda.l $C30000,x
	and.w #$3FFF
	tax
	bcc CODE_C4D0AA
	lda.b $9F
	asl a
	asl a
	asl a
	sta.b $A5
	lda.l $C2FFFF,x
	and.w #$7F00
	asl a
	tsb.b $A5
	lda.w $6A56,y
	and.w #$000F
	bra CODE_C4D0C1
CODE_C4D0AA:						; from CODE_C4D078
	lda.b $9F
	lsr a
	sta.b $A5
	lda.l $C2FFFF,x
	and.w #$7F00
	lsr a
	lsr a
	lsr a
	tsb.b $A5
	lda.w $6A56,y
	and.w #$F000
CODE_C4D0C1:						; from CODE_C4D078
	ora.b $A5
	sta.w $6A56,y
	ldx.b $A3
	inx
	inx
	dec.b $A1
	bne CODE_C4D078
	ldx.b $9F
	dex
	dex
	bpl CODE_C4D05E
	rts
CODE_C4D0D5:						; from CODE_C4CFF5 and other segments
	ldy.w #$1CF8
	lda.w #$0013
	sta.b $9F
	tya
CODE_C4D0DE:						; from CODE_C4D0F0
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	beq CODE_C4D0ED
	lda.w #$01F0
	bra CODE_C4D0F0
CODE_C4D0ED:						; from CODE_C4D0DE
	lda.w #$001F
CODE_C4D0F0:						; from CODE_C4D0DE
	ora.w $6A56,x
	sta.w $6A56,x
	tya
	clc
	adc.w #$000C
	tay
	dec.b $9F
	bpl CODE_C4D0DE
	rts
DATA8_C4D101:						; not traced: data between routines
	db $4A,$01,$78,$22,$38,$22,$01,$33,$00
DATA8_C4D10A:						; not traced: a table read by CODE_C4D4F5, CODE_C4D5AC, CODE_C4D5F6
	db $03,$E4,$50,$F2,$50,$FE,$50,$03,$08,$51,$11,$51,$1B,$51,$03,$26
	db $51,$2D,$51,$34,$51,$03,$26,$51,$41,$51,$4A,$51,$03,$26,$51,$55
	db $51,$62,$51,$03,$26,$51,$6C,$51,$75,$51,$02,$26,$51,$80,$51,$03
	db $8B,$51,$99,$51,$A6,$51,$02,$B0,$51,$BC,$51,$02,$C7,$51,$D5,$51
	db $02,$DE,$51,$ED,$51,$02,$F6,$51,$FD,$51,$02,$07,$52,$15,$52,$03
	db $1E,$52,$27,$52,$31,$52,$03,$1E,$52,$3C,$52,$46,$52,$03,$50,$52
	db $5F,$52,$6A,$52,$02,$74,$52,$80,$52,$04,$89,$52,$97,$52,$A4,$52
	db $B2,$52,$02,$C0,$52,$CF,$52,$02,$DB,$52,$EA,$52,$03,$F3,$52,$FF
	db $52,$09,$53,$02,$F3,$52,$13,$53,$00
CODE_C4D193:						; called from other segments
	jsl.l CODE_C4C530
	jsl.l CODE_C4BAF6
	jsl.l CODE_C4C574
	jsl.l CODE_C5E50E
	lda.w #$FFFF
	sta.w $04BE
	sta.w $04C2
	ldy.w #$3800
	jsl.l CODE_C589E4
	ldy.w #$3C00
	jsl.l CODE_C589E4
	ldy.w #$5800
	jsl.l CODE_C589E4
	ldy.w #$5C00
	jsl.l CODE_C589E4
	ldy.w #$3000
	jsl.l CODE_C589E4
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	pea.w $02C0
	pea.w $0000
	pea.w $5400
	pea.w $1808
	pea.w $00C4
	pea.w $D101
	pea.w $02C0
	pea.w $0080
	pea.w $5400
	pea.w $1908
	pea.w $00C4
	pea.w $D102
	pea.w $0180
	pea.w $0000
	pea.w $56C0
	pea.w $1809
	pea.w $00C5
	pea.w $8A63
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	jsl.l CODE_C4CEDB
	lda.w #$5420
	sta.b $9F
	lda.w #$214A
	sta.b $A1
	ldx.w #$00C2
	lda.w #$71F6
	ldy.w #$2A50
	jsl.l MapSetToVRAM
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	pea.w $0020
	pea.w $0010
	ldx.w #$00C2
	lda.w #$71F6
	jsr.w CODE_C4D636
	phx
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	lda.w #$5820
	sta.b $9F
	lda.w #$0800
	sta.b $A1
	ldx.w #$00C2
	lda.w #$2CB2
	ldy.w #$0000
	jsl.l MapSetToVRAM
	lda.w #$3820
	sta.b $9F
	lda.w #$0800
	sta.b $A1
	ldx.w #$00C2
	lda.w #$0AB8
	ldy.w #$4000
	jsl.l MapSetToVRAM
	sep #$20
	lda.b #$39
	sta.l BG1SC
	lda.b #$59
	sta.l BG2SC
	lda.b #$55
	sta.l BG3SC
	lda.b #$04
	sta.l BG12NBA
	lda.b #$09
	sta.l BGMODE
	lda.b #$17
	sta.l TM
	rep #$20
	ldx.w #$0070
	jsl.l SetupHDMA
	db $00,$0C,$03,$D1,$C4,$7E		; inline parameters
	lda.w #$8000
	sta.w DMAEnShadow
	jsl.l CODE_C58B2B
	jsl.l CODE_C4B6EB
	lda.w #$0010
	sta.b $7D
	lda.w #$007E
	sta.b $71
	lda.b $08
	sta.b $8F
	sta.b $6F
	clc
	adc.w #$0040
	sta.b $93
	adc.w #$0180
	sta.b $08
	jsl.l CODE_C4C541
	lda.w #$0010
	sta.b $8B
	lda.b $8F
	ldy.w #$7FFF
	jsl.l CODE_C4B970
	ldx.w #$00C2
	lda.w #$0AB8
	jsr.w CODE_C4D636
	ldy.b $93
	jsl.l CODE_C4B8D1
	ldx.w #$007E
	lda.b $8F
	ldy.w #$0020
	jsl.l CODE_C4B84C
	lda.w #$0100
	sta.w $04BC
	stz.w $04C0
	ldx.w #CODE_C4D377>>16
	lda.w #CODE_C4D377
	ldy.w #$0001
	clc
	jsl.l CODE_C4B743
	jsl.l CODE_C4CEDB
	lda.w #$00A3
	jsl.l CODE_CF040B
	ldx.w #CODE_C4B6D2>>16
	lda.w #CODE_C4B6D2
	ldy.w #$FF00
	jsl.l CODE_C4B763
	inc.w $1EA7
	stz.w fadestep
CODE_C4D33F:						; from CODE_C4D33F
	jsl.l CODE_C4B7D4
	jsl.l AnimateSprites
	lda.w $2D9D
	beq CODE_C4D33F
	lda.w #$0058
	sta.l BG1SC
	lda.w #$0051
	sta.l BG2SC
	lda.w #$005C
	sta.l BG3SC
	lda.w #$005C
	sta.l BG4SC
	lda.w #$0002
	sta.l BG12NBA
	lda.w #$0043
	sta.l BG34NBA
	rtl
CODE_C4D377:						; passed as a long pointer (lda # of its bank and address) to CODE_C4B743
	lda.w $0008,x
	cmp.w #$003C
	bne CODE_C4D3AD
	stz.w $0008,x
	lda.w #CODE_C4D388
	sta.w $0002,x
CODE_C4D388:						; a task routine: stored as the next routine of a task
	lda.w #$0020
	jsr.w CODE_C4D588
	bne CODE_C4D398
	ldx.b $83
	lda.w #CODE_C4D398
	sta.w $0002,x
CODE_C4D398:						; a task routine: stored as the next routine of a task
	lda.w $04C0
	inc a
	inc a
	sta.w $04C0
	cmp.w #$0080
	bcc CODE_C4D3AD
	ldx.b $83
	lda.w #CODE_C4D3AE
	sta.w $0002,x
CODE_C4D3AD:						; from CODE_C4D377, CODE_C4D398, CODE_C4D3AE
	rtl
CODE_C4D3AE:						; a task routine: stored as the next routine of a task
	lda.w $04BC
	dec a
	dec a
	dec a
	dec a
	sta.w $04BC
	lda.w $04C0
	inc a
	inc a
	sta.w $04C0
	cmp.w #$0100
	bcc CODE_C4D3AD
	lda.w #$00CB
	sta.b $18
	lda.w #$0093
	sta.b $1A
	lda.w #$0028
	jsr.w CODE_C4D52B
	ldx.b $83
	lda.w #CODE_C4D3DD
	sta.w $0002,x
CODE_C4D3DD:						; a task routine: stored as the next routine of a task
	ldx.b $91
	lda.w $0034,x
	and.w #$FF00
	xba
	clc
	adc.w #$0008
	asl a
	asl a
	asl a
	asl a
	jsr.w CODE_C4D588
	bne CODE_C4D3FB
	ldx.b $83
	lda.w #CODE_C4D3FC
	sta.w $0002,x
CODE_C4D3FB:						; from CODE_C4D3DD, CODE_C4D414, CODE_C4D435
	rtl
CODE_C4D3FC:						; a task routine: stored as the next routine of a task
	lda.w #$000A
	sta.b $18
	lda.w #$0090
	sta.b $1A
	lda.w #$0027
	jsr.w CODE_C4D52B
	ldx.b $83
	lda.w #CODE_C4D414
	sta.w $0002,x
CODE_C4D414:						; a task routine: stored as the next routine of a task
	ldx.b $91
	lda.w $0034,x
	and.w #$FF00
	xba
	clc
	adc.w #$0008
	asl a
	asl a
	asl a
	asl a
	jsr.w CODE_C4D588
	bne CODE_C4D3FB
	ldx.b $83
	stz.w $0008,x
	lda.w #CODE_C4D435
	sta.w $0002,x
CODE_C4D435:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$003C
	bne CODE_C4D3FB
	lda.w #$0010
	sta.b $7D
	sta.b $8B
	lda.b $8F
	ldy.w #$7FFF
	jsl.l CODE_C4B970
	ldx.w #$00C2
	stx.b $71
	lda.w #$0AB8
	sta.b $6F
	clc
	adc.b [$6F]
	bcc CODE_C4D45E
	inx
	clc
CODE_C4D45E:						; from CODE_C4D435
	adc.w #$0002
	bcc CODE_C4D465
	inx
	clc
CODE_C4D465:						; from CODE_C4D45E
	sta.b $6F
	adc.b [$6F]
	bcc CODE_C4D46D
	inx
	clc
CODE_C4D46D:						; from CODE_C4D465
	adc.w #$0009
	bcc CODE_C4D473
	inx
CODE_C4D473:						; from CODE_C4D46D
	stx.b $71
	sta.b $6F
	ldx.w #$007E
	lda.b $8F
	ldy.b $93
	jsl.l CODE_C4B8D1
	ldx.b $83
	lda.w #CODE_C4D48A
	sta.w $0002,x
CODE_C4D48A:						; a task routine: stored as the next routine of a task
	lda.w #$0020
	jsr.w CODE_C4D588
	bne CODE_C4D4A0
	stz.b $95
	jsl.l CODE_C4B738
	ldx.b $83
	lda.w #CODE_C4D4A1
	sta.w $0002,x
CODE_C4D4A0:						; from CODE_C4D48A, CODE_C4D4AC
	rtl
CODE_C4D4A1:						; a task routine: stored as the next routine of a task
	jsr.w CODE_C4D5AC
	ldx.b $83
	lda.w #CODE_C4D4AC
	sta.w $0002,x
CODE_C4D4AC:						; a task routine: stored as the next routine of a task
	lda.w #$0000
	jsr.w CODE_C4D588
	bne CODE_C4D4A0
	ldx.b $83
	stz.w $0008,x
	lda.w #CODE_C4D4BF
	sta.w $0002,x
CODE_C4D4BF:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$00F0
	bne CODE_C4D52A
	lda.w #$0010
	sta.b $8B
	lsr a
	sta.b $7D
	lda.b $8F
	ldy.w #$0000
	jsl.l CODE_C4B970
	lda.w #$00C4
	sta.b $71
	lda.w #$BAD6
	sta.b $6F
	ldx.w #$007E
	lda.b $8F
	ldy.b $93
	jsl.l CODE_C4B8D1
	ldx.b $83
	lda.w #CODE_C4D4F5
	sta.w $0002,x
CODE_C4D4F5:						; a task routine: stored as the next routine of a task
	lda.w #$0000
	jsr.w CODE_C4D588
	bne CODE_C4D52A
	ldx.b $95
	lda.l DATA8_C4D10A,x
	and.w #$00FF
	bne CODE_C4D514
	ldx.b $83
	stz.w $0008,x
	lda.w #CODE_C4D51D
	sta.w $0002,x
	rtl
CODE_C4D514:						; from CODE_C4D4F5
	ldx.b $83
	lda.w #CODE_C4D4A1
	sta.w $0002,x
	rtl
CODE_C4D51D:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$01E0
	bne CODE_C4D52A
	lda.w #$8000
	trb.b $85
CODE_C4D52A:						; from CODE_C4D4BF, CODE_C4D4F5, CODE_C4D51D
	rtl
CODE_C4D52B:						; from CODE_C4D3AE, CODE_C4D3FC
	jsl.l CreateSprite
	stx.b $91
	lda.w #$0010
	sta.b $8B
	lda.b $8F
	ldy.w #$0000
	jsl.l CODE_C4B970
	lda.w #$007E
	sta.b $71
	lda.b $8F
	sta.b $6F
	lda.w #$0020
	sta.b $7D
	ldx.b $91
	ldy.w $0034,x
	lda.l $008004
	and.w #$00FF
	tax
	tya
	and.w #$00FF
	xba
	lsr a
	lsr a
	lsr a
	adc.l $008002
	ldy.b $93
	jsl.l CODE_C4B8D1
	ldx.b $91
	lda.w $0034,x
	and.w #$FF00
	xba
	clc
	adc.w #$0008
	asl a
	asl a
	asl a
	asl a
	tay
	ldx.w #$007E
	lda.b $8F
	jsl.l CODE_C4B84C
	rts
CODE_C4D588:						; from CODE_C4D388, CODE_C4D3DD, CODE_C4D414, CODE_C4D48A, ...
	pha
	lda.w #$0010
	sta.b $8B
	ldy.b $93
	jsl.l CODE_C4B8AC
	ldx.w #$007E
	lda.b $8F
	ldy.b $93
	jsl.l CODE_C4B871
	ldx.w #$007E
	lda.b $8F
	ply
	jsl.l CODE_C4B84C
	dec.b $7D
	rts
CODE_C4D5AC:						; from CODE_C4D4A1
	lda.w #$0020
	sta.b $7D
	lsr a
	sta.b $8B
	lda.w #$007E
	sta.b $71
	lda.b $8F
	sta.b $6F
	ldy.w #$0000
	jsl.l CODE_C4B970
	ldx.w #$00C4
	lda.w #$BAD6
	ldy.b $93
	jsl.l CODE_C4B8D1
	lda.b $D3
	ldy.w #$0700
	jsl.l CODE_C58B11
	ldx.b $95
	lda.l DATA8_C4D10A,x
	and.w #$00FF
	sta.b $99
	lda.w #$0010
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	stz.b $97
	lda.w #$2400
	sta.b $D5
	inx
CODE_C4D5F6:						; from CODE_C4D610
	stx.b $95
	lda.l DATA8_C4D10A,x
	tax
	ldy.b $97
	jsl.l CODE_C4BBE5
	ldx.b $95
	lda.w #$2000
	cmp.b $D5
	beq CODE_C4D610
	sta.b $D5
	inc.b $97
CODE_C4D610:						; from CODE_C4D5F6
	inc.b $97
	inx
	inx
	dec.b $99
	bne CODE_C4D5F6
	stx.b $95
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0180
	pea.w $56C0
	pea.w $007E
	pei ($D3)
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	rts
CODE_C4D636:						; from CODE_C4D193
	stx.b $A1
	sta.b $9F
	clc
	adc.b [$9F]
	bcc CODE_C4D641
	inx
	clc
CODE_C4D641:						; from CODE_C4D636
	adc.w #$0002
	bcc CODE_C4D648
	inx
	clc
CODE_C4D648:						; from CODE_C4D641
	sta.b $9F
	adc.b [$9F]
	bcc CODE_C4D650
	inx
	clc
CODE_C4D650:						; from CODE_C4D648
	adc.w #$0009
	bcc CODE_C4D656
	inx
CODE_C4D656:						; from CODE_C4D650
	rts
CODE_C4D657:						; called from other segments
	jsl.l CODE_C4C574
	jsl.l CODE_C4C530
	stz.w DMAEnShadow
	wai
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$1B,$49,$C0,$00		; inline parameters
	lda.w #$FFFF
	stz.w $04BC
	stz.w $04C0
	stz.w $04C4
	sta.w $04BE
	sta.w $04C6
	lda.w #$0400
	sta.b $A1
	lda.w #$5800
	sta.b $9F
	lda.w #$87F2
	ldx.w #$00C0
	ldy.w #$2000
	jsl.l MapSetToVRAM
	sep #$20
	pea.w $7E80
	plb
	lda.b #$17
	sta.w TM
	lda.b #$09
	sta.w BGMODE
	lda.b #$03
	sta.w OBSEL
	plb
	rep #$20
	lda.w #BlueColoursHook
	ldx.w #BlueColoursHook>>16
	jsl.l SetNMIHook
	jsl.l CODE_C5E50E
	lda.w #$00D7
	sta.b $18
	lda.w #$00D0
	sta.b $1A
	lda.w #$0020
	jsl.l CreateSprite
	lda.w #$007C
	sta.b $18
	lda.w #$000F
	sta.b $1A
	lda.w #$001C
	jsl.l CreateSprite
	lda.w #$0005
	jsl.l CODE_C5ECBD
	lda.w #$0018
	sta.b $1A
	lda.w #$0039
	sta.b $18
	lda.w #$001C
	jsl.l CreateSprite
	lda.w #$0004
	jsl.l CODE_C5ECBD
	lda.w #$00A8
	sta.b $1A
	lda.w #$00B1
	sta.b $18
	lda.w #$001C
	jsl.l CreateSprite
	lda.w #$0004
	jsl.l CODE_C5ECBD
	jsl.l CODE_C4BAF6
	lda.w #$0004
	sta.w $18DE
	lda.w #$54F9
	jsl.l CODE_C4BB5A
	jsl.l CODE_C4CEDB
	lda.w #$8000
	sta.w DMAEnShadow
	stz.w fadestep
	stz.b $26
	stz.b $63
CODE_C4D73A:						; from CODE_C4D73A, CODE_C4D75D
	jsl.l CODE_C3716D
	jsl.l CODE_C36C2D
	lda.w $058D
	and.w #$FFF0
	tsb.b $63
	lda.b $26
	cmp.w #$003C
	bne CODE_C4D75D
	lda.w #$05D4
	ldx.w #$00CF
	jsl.l CODE_CF0134
	bra CODE_C4D73A
CODE_C4D75D:						; from CODE_C4D73A
	cmp.w #$00C3
	bcc CODE_C4D73A
	ldx.b $63
	bne CODE_C4D76B
	cmp.w #$04B0
	bcc CODE_C4D73A
CODE_C4D76B:						; from CODE_C4D75D
	jsl.l FadeOutWait
	jml.l ClearNMIHook
CODE_C4D773:						; from CODE_C4D818, CODE_C4DFD6
	jsl.l CODE_C4C574
	jsl.l CODE_C5E50E
	jsl.l CODE_C4C530
	lda.w #$007F
	sta.b $2E
	lda.w #$D80A
	sta.b $2C
	lda.w #$0000
	ldx.w #$00C0
	jsl.l Decompress
	jsl.l FadeOutWait
	stz.w DMAEnShadow
	jsl.l ClearNMIHook
	wai
	lda.w #$00D7
	sta.b $18
	lda.w #$00D0
	sta.b $1A
	lda.w #$0020
	jsl.l CreateSprite
	ldx.w #$0070
	jsl.l SetupHDMA
	db $03,$21,$1B,$49,$C0,$00		; inline parameters
	lda.w #$0400
	sta.b $A1
	lda.w #$5800
	sta.b $9F
	lda.w #$87F2
	ldx.w #$00C0
	ldy.w #$2000
	jsl.l MapSetToVRAM
	ldy.w #$5000
	jsl.l CODE_C589E4
	ldy.w #$5C00
	jsl.l CODE_C589E4
	jsl.l CODE_C4BAF6
	jsl.l CODE_C4CEDB
	lda.w #$8000
	sta.w DMAEnShadow
	sep #$20
	lda.b #$09
	sta.l BGMODE
	lda.b #$1F
	sta.l TM
	lda.b #$03
	sta.l OBSEL
	rep #$20
	stz.w $04C0
	jsl.l CODE_C5BBBC
	lda.w #BlueColoursHook
	ldx.w #BlueColoursHook>>16
	jsl.l SetNMIHook
	rts
CODE_C4D818:						; called from other segments
	jsl.l CODE_CF039E
	lda.w #$05DB
	ldx.w #$00CF
	ldy.w #$FF00
	jsl.l CODE_CF0134
	lda.w #$00A7
	jsl.l CODE_CF040B
	jsl.l CODE_CF03D0
	jsr.w CODE_C4D773
	lda.w #$003D
	sta.b $1A
	lda.w #$0030
	sta.b $18
	lda.w #$0026
	jsl.l CreateSprite
	stx.b $73
	lda.w #$2000
	sta.b $36,x
	lda.w #$FFFF
	sta.b $75
	lda.w #$0240
	jsl.l CODE_C4C558
	sta.b $2C
	sta.b $34
	lda.w #$007E
	sta.b $2E
	ldx.w #$00C0
	lda.w #$083D
	jsl.l Decompress
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0240
	pea.w $0640
	pea.w $007E
	pei ($34)
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsl.l CODE_C4CEDB
	ldy.w #$2864
	ldx.w #$5245
	jsl.l CODE_C387D8
	ldy.w #$3076
	ldx.w #$5106
	jsr.w CODE_C4EE9D
	lda.w #$0240
	jsl.l CODE_C4C56A
	lda.w #$0002
	sta.w $04C2
	lda.w #$5419
	jsl.l CODE_C4BB5A
	jsl.l CODE_C4CEDB
	jsl.l CODE_C4C2AA
	stz.w fadestep
	stz.b $63
	jsl.l CODE_C4CEDB
	jsr.w CODE_C4D941
	jsr.w CODE_C4DC45
	jsr.w CODE_C4DAAD
CODE_C4D8CE:						; from CODE_C4D8CE, CODE_C4D915, CODE_C4D93B, CODE_C4D936
	inc.w TransfersReady
	wai
	jsl.l CODE_C36C2D
	inc.b $26
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l CODE_C5F3DB
	lda.w $058F
	bne CODE_C4D8CE
	lda.w $058D
	bit.w #$0100
	beq CODE_C4D908
	lda.b $63
	inc a
	cmp.w #$0008
	bcc CODE_C4D915
	lda.w #$0000
	bra CODE_C4D915
CODE_C4D908:						; from CODE_C4D8CE
	bit.w #$0200
	beq CODE_C4D93B
	lda.b $63
	dec a
	bpl CODE_C4D915
	lda.w #$0007
CODE_C4D915:						; from CODE_C4D8CE, CODE_C4D908
	sta.b $63
	lda.b $D3
	clc
	adc.w #$0140
	ldy.w #$0480
	jsl.l CODE_C58B11
	jsr.w CODE_C4D941
	jsr.w CODE_C4DC45
	ldx.b $63
	cpx.w #$0007
	bne CODE_C4D936
	jsr.w CODE_C4DBCC
	bra CODE_C4D8CE
CODE_C4D936:						; from CODE_C4D915
	jsr.w CODE_C4DAAD
	bra CODE_C4D8CE
CODE_C4D93B:						; from CODE_C4D908
	bit.w #$1000
	beq CODE_C4D8CE
	rtl
CODE_C4D941:						; from CODE_C4D818, CODE_C4D915
	lda.w #$0005
	sta.w $18DE
	ldy.w #$5000
	jsl.l CODE_C589B0
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	ldx.b $75
	bmi CODE_C4D963
	jsl.l CODE_C5E596
	lda.w #$FFFF
	sta.b $75
CODE_C4D963:						; from CODE_C4D941
	ldx.b $73
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	jsl.l CODE_C5BBBC
	lda.w #$0088
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b $63
	asl a
	pha
	asl a
	tax
	phx
	lda.l AwardNames,x
	tax
	ldy.w #$0012
	jsl.l CODE_C4BBE5
	plx
	lda.l AwardNames+2,x
	beq CODE_C4D99C
	tax
	ldy.w #$0013
	jsl.l CODE_C4BBE5
CODE_C4D99C:						; from CODE_C4D963
	stz.b $CF
	lda.w #$0100
	sta.b $D1
	plx
	lda.l AwardDescs,x
	tax
	ldy.w #$0015
	jsl.l CODE_C4BBE5
	jsl.l CODE_C4CEDB
	lda.b $63
	asl a
	asl a
	tax
	lda.b $08
	sta.b $30
	lda.w #$007E
	sta.b $32
	lda.l AwardPictures+2,x
	tay
	lda.l AwardPictures,x
	tyx
	jsl.l CODE_C5881C
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	ldx.b $63
	lda.l DATA8_C4DA75,x
	and.w #$00FF
	asl a
	asl a
	asl a
	asl a
	asl a
	pha
	sta.b $9F
	pea.w $0000
	pea.w $007E
	lda.b $08
	clc
	adc.w #$00EA
	pha
	adc.b $9F
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0030
	pea.w $007E
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	jsl.l CODE_C4CEDB
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	ldx.w #$50B3
	ldy.b $08
CODE_C4DA25:						; from CODE_C4DA25
	pea.w $0012
	phx
	pea.w $007E
	phy
	tya
	clc
	adc.w #$0012
	tay
	txa
	clc
	adc.w #$0020
	tax
	cmp.w #$5253
	bne CODE_C4DA25
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	lda.w #$0009
	sta.w $18DE
	rts
AwardPictures:						; the picture (map set) of each award, a long pointer; read by CODE_C4D99C
	dw VezinaPicMap&$FFFF,VezinaPicMap>>16	; 0: Vezina Trophy
	dw SelkePicMap&$FFFF,SelkePicMap>>16	; 1: Frank J. Selke Trophy
	dw ConnSmythePicMap&$FFFF,ConnSmythePicMap>>16	; 2: Conn Smythe Trophy
	dw JenningsPicMap&$FFFF,JenningsPicMap>>16	; 3: William M. Jennings Trophy
	dw HartPicMap&$FFFF,HartPicMap>>16	; 4: Hart Memorial Trophy
	dw ArtRossPicMap&$FFFF,ArtRossPicMap>>16	; 5: Art Ross Trophy
	dw NorrisPicMap&$FFFF,NorrisPicMap>>16	; 6: James Norris Memorial Trophy
	dw PresidentsPicMap&$FFFF,PresidentsPicMap>>16	; 7: Presidents Trophy
DATA8_C4DA75:						; not traced: a table read by CODE_C4D99C
	db $3B,$2F,$4C,$5F,$31,$52,$42,$22
AwardNames:							; per award: the name text, then a second line or 0; CODE_C4D963
	dw $4FC2,$0000					; 0: Vezina Trophy
	dw $4FD9,$4FAC					; 1: Frank J. Selke Trophy
	dw $4FF7,$4FAC					; 2: Conn Smythe Trophy
	dw $501A,$5039					; 3: William M. Jennings Trophy
	dw $5045,$4FAC					; 4: Hart Memorial Trophy
	dw $5061,$0000					; 5: Art Ross Trophy
	dw $5079,$4FB1					; 6: James Norris Memorial Trophy
	dw $508F,$4FAC					; 7: Presidents Trophy
AwardDescs:							; per award: the description text; read by CODE_C4D99C
	dw $4FCD						; 0: Vezina Trophy
	dw $4FE5						; 1: Frank J. Selke Trophy
	dw $5001						; 2: Conn Smythe Trophy
	dw $5023						; 3: William M. Jennings Trophy
	dw $5050						; 4: Hart Memorial Trophy
	dw $506F						; 5: Art Ross Trophy
	dw $5083						; 6: James Norris Memorial Trophy
	dw $5097						; 7: Presidents Trophy
CODE_C4DAAD:						; from CODE_C4D818, CODE_C4D936
	pha
	jsl.l CODE_C5B5EA
	and.w #$00FF
	sta.w $17C9
	asl a
	tax
	lda.w #$0028
	sta.b $CF
	lda.w #$0070
	sta.b $D1
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0012
	jsl.l CODE_C4BCAA
	jsl.l CODE_C52CA3
	ldy.w #$FFFE
	pla
CODE_C4DAD8:						; from CODE_C4DAD8
	iny
	iny
	cmp.w $2E03,y
	bne CODE_C4DAD8
	sty.b $65
	lda.w $2EA7,y
	sta.b $67
	and.w #$00FF
	sta.b $71
	tax
	cmp.w #$00FF
	beq CODE_C4DB4A
	lda.w $2E75,y
	sta.b $6F
	clc
	adc.w #$00C0
	phy
	ldy.b $68
	jsr.w CODE_C4EC88
	ply
	sta.b $6B
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0760
	pea.w $007E
	pei ($6B)
	ldy.b $00
	tsx
	stx.b $00
	ldx.b $04
	txs
	sty.b $04
	pea.w $0020
	pea.w $0040
	pei ($71)
	lda.b $67
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	adc.b $6F
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	ldx.b $73
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	jsl.l CODE_C4CEDB
	bra CODE_C4DB91
CODE_C4DB4A:						; from CODE_C4DAD8
	ldx.b $73
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	lda.w #$0058
	sta.b $1A
	lda.w #$004C
	sta.b $18
	lda.w $17C9
	jsl.l CreateSprite
	stx.b $75
	stz.w $364E
	ldx.w #$364E
	ldy.w #$3650
	lda.w #$047D
	mvn $7E,$7E
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0760
	pea.w $007E
	pea.w $364E
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
CODE_C4DB91:						; from CODE_C4DAD8
	lda.w #$0010
	sta.b $CF
	lda.w #$0080
	sta.b $D1
	lda.b $65
	asl a
	asl a
	asl a
	asl a
	adc.w #$2EE1
	tax
	ldy.w #$000F
	jsl.l CODE_C4BBF1
	jsl.l CODE_C5A4B5
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	ldy.w #$2864
	ldx.w #$5245
	jsl.l CODE_C387D8
	ldy.w #$3076
	ldx.w #$5106
	jsr.w CODE_C4EE9D
	rts
CODE_C4DBCC:						; from CODE_C4D915
	sta.w $17C9
	asl a
	tax
	lda.w #$0028
	sta.b $CF
	lda.w #$0070
	sta.b $D1
	lda.l DATA8_C3585C,x
	tax
	ldy.w #$0012
	jsl.l CODE_C4BCAA
	stz.w $364E
	ldx.w #$364E
	ldy.w #$3650
	lda.w #$047D
	mvn $7E,$7E
	dec.b QueueBusy
	lda.b $00
	tsx
	tcs
	stx.b $00
	pea.w $0480
	pea.w $0760
	pea.w $007E
	pea.w $364E
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	ldx.b $73
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	lda.w #$0058
	sta.b $1A
	lda.w #$004C
	sta.b $18
	lda.w $17C9
	jsl.l CreateSprite
	stx.b $75
	jsl.l CODE_C5A4B5
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	ldy.w #$2864
	ldx.w #$5245
	jsl.l CODE_C387D8
	rts
CODE_C4DC45:						; from CODE_C4D818, CODE_C4D915
	lda.w #$0030
	sta.b $69
	lda.b $63
	asl a
	tax
	jmp (DATA8_C4DC51,x)
DATA8_C4DC51:						; jump table: the routine for each index
	dw CODE_C4DC61,CODE_C4DC9C,CODE_C4DCE2,CODE_C4DD41
	dw CODE_C4DD74,CODE_C4DE68,CODE_C4DED9,CODE_C4DF20
CODE_C4DC61:						; from DATA8_C4DC51
	lda.w #$0000
	sta.b $6B
CODE_C4DC66:						; from CODE_C4DC91
	sta.b $6D
	sta.w $17C9
	jsl.l CODE_C531BC
CODE_C4DC6F:						; from CODE_C4DC6F
	lda.w $2DCB
	dec a
	bmi CODE_C4DC91
	sta.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b $6F
	jsl.l CODE_C5BDA8
	lda.b $9F
	cmp.b $6B
	bcc CODE_C4DC6F
	sta.b $6B
	lda.b $6F
	sta.b $71
	bra CODE_C4DC6F
CODE_C4DC91:						; from CODE_C4DC6F
	lda.b $6D
	inc a
	cmp.w #$001A
	bne CODE_C4DC66
	lda.b $71
	rts
CODE_C4DC9C:						; from DATA8_C4DC51
	stz.b $6B
	jsr.w CODE_C4DF5B
	sta.w $17C9
	jsl.l CODE_C531BC
	stz.b $6B
CODE_C4DCAA:						; from CODE_C4DCAA
	lda.w $2DCD
	dec a
	bmi CODE_C4DCDF
	beq CODE_C4DCDF
	sta.w $2DCD
	clc
	adc.w $2DCB
	asl a
	tax
	lda.w $2E05,x
	sta.b $6F
	jsl.l CODE_C5BD52
	lda.b $9F
	sta.b $A1
	lda.b $6F
	jsl.l CODE_C5BD7D
	lda.b $9F
	clc
	adc.b $A1
	cmp.b $6B
	bcc CODE_C4DCAA
	sta.b $6B
	lda.b $6F
	sta.b $71
	bra CODE_C4DCAA
CODE_C4DCDF:						; from CODE_C4DCAA
	lda.b $71
	rts
CODE_C4DCE2:						; from DATA8_C4DC51
	lda.w #$0000
	sta.b $6B
CODE_C4DCE7:						; from CODE_C4DD36
	sta.b $6D
	tax
	lda.l $3075A4,x
	and.w #$00FF
	sta.w $17C9
	jsl.l CODE_C531BC
	lda.w $2DC9
	clc
	sbc.w $2DCB
	sta.w $2DC9
CODE_C4DD02:						; from CODE_C4DD02
	lda.w $2DC9
	dec a
	bmi CODE_C4DD36
	sta.w $2DC9
	ldx.b $6D
	sec
	adc.w $2DCB
	pha
	jsr.w CODE_C4DF82
	sta.b $A3
	pla
	ldx.b $6D
	jsr.w CODE_C4DFAC
	clc
	adc.b $A3
	cmp.b $6B
	bcc CODE_C4DD02
	sta.b $6B
	lda.w $2DC9
	sec
	adc.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b $71
	bra CODE_C4DD02
CODE_C4DD36:						; from CODE_C4DD02
	lda.b $6D
	inc a
	cmp.w #$0010
	bcc CODE_C4DCE7
	lda.b $71
	rts
CODE_C4DD41:						; from DATA8_C4DC51
	stz.b $6B
	jsr.w CODE_C4DF5B
	sta.w $17C9
	jsl.l CODE_C531BC
	stz.b $6B
CODE_C4DD4F:						; from CODE_C4DD4F
	lda.w $2DCB
	dec a
	bmi CODE_C4DD71
	sta.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b $6F
	jsl.l CODE_C5BDE7
	lda.b $9F
	cmp.b $6B
	bcc CODE_C4DD4F
	sta.b $6B
	lda.b $6F
	sta.b $71
	bra CODE_C4DD4F
CODE_C4DD71:						; from CODE_C4DD4F
	lda.b $71
	rts
CODE_C4DD74:						; from DATA8_C4DC51
	stz.b $6B
	stz.b $32
	ldx.w #$002E
CODE_C4DD7B:						; from CODE_C4DD7B
	stz.w $364E,x
	dex
	dex
	bpl CODE_C4DD7B
	lda.w #$0000
CODE_C4DD85:						; from CODE_C4DDC6
	sta.b $6D
	jsl.l CODE_C5B97F
	ldx.w #$364E
CODE_C4DD8E:						; from CODE_C4DD8E
	lda.w $000A,y
	cmp.w $0000,x
	bcs CODE_C4DDA3
	txa
	clc
	adc.w #$0006
	tax
	cmp.w #$367E
	bne CODE_C4DD8E
	bra CODE_C4DDC6
CODE_C4DDA3:						; from CODE_C4DD8E
	phy
	txa
	eor.w #$FFFF
	inc a
	clc
	ldy.w #$367D
	ldx.w #$3677
	adc.w #$3678
	beq CODE_C4DDB9
	dec a
	mvp $7E,$7E
CODE_C4DDB9:						; from CODE_C4DDA3
	ply
	inx
	lda.w $000A,y
	sta.w $0000,x
	lda.b $6D
	sta.w $0004,x
CODE_C4DDC6:						; from CODE_C4DD8E
	lda.b $6D
	inc a
	cmp.w #$001A
	bne CODE_C4DD85
	ldx.w #$0000
CODE_C4DDD1:						; from CODE_C4DE56
	stx.b $6D
	lda.w $3652,x
	sta.w $17C9
	jsl.l CODE_C531BC
	stz.b $A3
	stz.b $30
	lda.w $2DCF
	clc
	adc.w $2DCD
CODE_C4DDE8:						; from CODE_C4DDE8
	dec a
	bmi CODE_C4DE25
	sta.w $2DCD
	adc.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b $6F
	jsl.l CODE_C5BD52
	lda.b $9F
	sta.b $A1
	lda.b $6F
	jsl.l CODE_C5BD7D
	lda.b $9F
	clc
	adc.b $A1
	ldx.b $A3
	sta.w $3680,x
	clc
	adc.b $30
	sta.b $30
	lda.b $6F
	sta.w $367E,x
	inx
	inx
	inx
	inx
	stx.b $A3
	lda.w $2DCD
	bra CODE_C4DDE8
CODE_C4DE25:						; from CODE_C4DDE8, CODE_C4DE25
	dex
	dex
	dex
	dex
	bmi CODE_C4DE56
	stx.b $A3
	stz.b $34
	stz.b $36
	lda.w $3680,x
	asl a
	sta.b $35
	pei ($30)
	pei ($32)
	jsl.l Div32x32U
	pla
	sta.b $32
	pla
	sta.b $30
	ldx.b $A3
	lda.b $2C
	cmp.b $6B
	bcc CODE_C4DE25
	sta.b $6B
	lda.w $367E,x
	sta.b $71
	bra CODE_C4DE25
CODE_C4DE56:						; from CODE_C4DE25
	lda.b $6D
	clc
	adc.w #$0006
	tax
	cmp.w #$0030
	bcs CODE_C4DE65
	jmp.w CODE_C4DDD1
CODE_C4DE65:						; from CODE_C4DE56
	lda.b $71
	rts
CODE_C4DE68:						; from DATA8_C4DC51
	lda.w #$FFFF
	sta.w $17C9
	inc a
	sta.b $6B
CODE_C4DE71:						; from CODE_C4DECE
	sta.b $6F
	asl a
	adc.b $6F
	lsr a
	tax
	lda.l $306A56,x
	bcc CODE_C4DE82
	lsr a
	lsr a
	lsr a
	lsr a
CODE_C4DE82:						; from CODE_C4DE71
	and.w #$001F
	cmp.w #$001A
	bcs CODE_C4DECE
	cmp.w $17C9
	beq CODE_C4DEA0
	sta.w $17C9
	pei ($6F)
	pei ($71)
	jsl.l CODE_C531BC
	pla
	sta.b $71
	pla
	sta.b $6F
CODE_C4DEA0:						; from CODE_C4DE82
	lda.w $2DCB
	dec a
	asl a
	tax
	lda.b $6F
CODE_C4DEA8:						; from CODE_C4DEA8
	cmp.w $2E03,x
	beq CODE_C4DECE
	dex
	dex
	bpl CODE_C4DEA8
	jsl.l CODE_C5BD52
	lda.b $9F
	sta.b $A1
	lda.b $6F
	jsl.l CODE_C5BD7D
	lda.b $9F
	clc
	adc.b $A1
	cmp.b $6B
	bcc CODE_C4DECE
	sta.b $6B
	lda.b $6F
	sta.b $71
CODE_C4DECE:						; from CODE_C4DE82, CODE_C4DEA8
	lda.b $6F
	inc a
	cmp.w #$027E
	bcc CODE_C4DE71
	lda.b $71
	rts
CODE_C4DED9:						; from DATA8_C4DC51
	stz.b $6B
	jsr.w CODE_C4DF5B
	sta.w $17C9
	jsl.l CODE_C531BC
	stz.b $6B
CODE_C4DEE7:						; from CODE_C4DEE7
	lda.w $2DCF
	dec a
	beq CODE_C4DF1D
	sta.w $2DCF
	clc
	adc.w $2DCB
	adc.w $2DCD
	asl a
	tax
	lda.w $2E03,x
	sta.b $6F
	jsl.l CODE_C5BD52
	lda.b $9F
	sta.b $A1
	lda.b $6F
	jsl.l CODE_C5BD7D
	lda.b $9F
	clc
	adc.b $A1
	cmp.b $6B
	bcc CODE_C4DEE7
	sta.b $6B
	lda.b $6F
	sta.b $71
	bra CODE_C4DEE7
CODE_C4DF1D:						; from CODE_C4DEE7
	lda.b $71
	rts
CODE_C4DF20:						; from DATA8_C4DC51
	lda.w #$FFFF
	sta.b $6F
	lda.w #$0000
	sta.b $6B
CODE_C4DF2A:						; from CODE_C4DF50
	sta.b $6D
	jsl.l CODE_C5B97F
	lda.w $0004,x
	cmp.b $6B
	bcc CODE_C4DF50
	bne CODE_C4DF45
	lda.w $0006,x
	cmp.b $6F
	bcs CODE_C4DF50
	sta.b $6F
	lda.w $0004,x
CODE_C4DF45:						; from CODE_C4DF2A
	sta.b $6B
	lda.w $0006,x
	sta.b $6F
	lda.b $6D
	sta.b $71
CODE_C4DF50:						; from CODE_C4DF2A
	lda.b $6D
	inc a
	cmp.w #$001A
	bne CODE_C4DF2A
	lda.b $71
	rts
CODE_C4DF5B:						; from CODE_C4DC9C, CODE_C4DD41, CODE_C4DED9
	lda.w #$0000
	sta.b $6B
	sta.b $71
	dec.b $6B
CODE_C4DF64:						; from CODE_C4DF77
	sta.b $6D
	jsl.l CODE_C5B97F
	lda.w $002A,x
	cmp.b $6B
	bcs CODE_C4DF77
	sta.b $6B
	lda.b $6D
	sta.b $71
CODE_C4DF77:						; from CODE_C4DF64
	lda.b $6D
	inc a
	cmp.w #$001A
	bne CODE_C4DF64
	lda.b $71
	rts
CODE_C4DF82:						; from CODE_C4DD02
	sta.b $9F
	asl a
	asl a
	asl a
	sec
	sbc.b $9F
	sta.b $9F
	txa
	asl a
	tax
	lda.l DATA8_C40D76,x
	adc.b $9F
	tay
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	tay
	lda.l $3072E8,x
CODE_C4DFA3:						; from CODE_C4DFA3
	lsr a
	dey
	bpl CODE_C4DFA3
	rol a
	and.w #$007F
	rts
CODE_C4DFAC:						; from CODE_C4DD02
	sta.b $9F
	asl a
	asl a
	asl a
	sec
	sbc.b $9F
	sta.b $9F
	txa
	asl a
	tax
	lda.l DATA8_C40D76,x
	adc.b $9F
	tay
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	tay
	lda.l $307446,x
CODE_C4DFCD:						; from CODE_C4DFCD
	lsr a
	dey
	bpl CODE_C4DFCD
	rol a
	and.w #$007F
	rts

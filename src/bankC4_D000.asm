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
	beq .1
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
.1:									; call CODE_C4CF7B, call CODE_C5E474, return
	jsl.l CODE_C4CF7B
	jsl.l CODE_C5E474
	plb
	rtl
CODE_C4D05B:						; from CODE_C4CFF5 and other segments
	ldx.w #$0032
.1:									; tmp0 = X, A = $C30000,x, X = A, A = $C30000,x, ...
	stx.b tmp0
	lda.l $C30000,x
	tax
	lda.l $C30000,x
	tay
	xba
	and.w #$00F8
	lsr a
	lsr a
	lsr a
	sta.b tmp1
	tya
	and.w #$07FF
	tax
.2:									; tmp2 = X, A = X, A - $0038, $A5 = A, ...
	stx.b tmp2
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
	bcc .3
	lda.b tmp0
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
	bra .4
.3:									; A = tmp0, A / 2, $A5 = A, A = $C2FFFF,x, ...
	lda.b tmp0
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
.4:									; A or $A5, $6A56,y = A, X = tmp2, X + 1, ...
	ora.b $A5
	sta.w $6A56,y
	ldx.b tmp2
	inx
	inx
	dec.b tmp1
	bne .2
	ldx.b tmp0
	dex
	dex
	bpl .1
	rts
CODE_C4D0D5:						; from CODE_C4CFF5 and other segments
	ldy.w #$1CF8
	lda.w #$0013
	sta.b tmp0
	tya
.1:									; A / 2, A / 2, A / 2, X = A, ...
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	beq .2
	lda.w #$01F0
	bra .3
.2:									; A = $001F
	lda.w #$001F
.3:									; A or $6A56,x, $6A56,x = A, A = Y, A + $000C, ...
	ora.w $6A56,x
	sta.w $6A56,x
	tya
	clc
	adc.w #$000C
	tay
	dec.b tmp0
	bpl .1
	rts
DATA8_C4D101:						; not traced: data between routines
	db $4A,$01,$78,$22,$38,$22,$01,$33,$00
DATA8_C4D10A:						; not traced: a table read by CODE_C4D4F5, CODE_C4D5AC, CODE_C4D5AC
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
	sta.w BG1VScroll
	sta.w BG2VScroll
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
	sta.b tmp0
	lda.w #$214A
	sta.b tmp1
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
	sta.b tmp0
	lda.w #$0800
	sta.b tmp1
	ldx.w #$00C2
	lda.w #$2CB2
	ldy.w #$0000
	jsl.l MapSetToVRAM
	lda.w #$3820
	sta.b tmp0
	lda.w #$0800
	sta.b tmp1
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
	sta.b d4
	sta.b a3
	clc
	adc.w #$0040
	sta.b d5
	adc.w #$0180
	sta.b $08
	jsl.l CODE_C4C541
	lda.w #$0010
	sta.b d3
	lda.b d4
	ldy.w #$7FFF
	jsl.l CODE_C4B970
	ldx.w #$00C2
	lda.w #$0AB8
	jsr.w CODE_C4D636
	ldy.b d5
	jsl.l CODE_C4B8D1
	ldx.w #$007E
	lda.b d4
	ldy.w #$0020
	jsl.l CODE_C4B84C
	lda.w #$0100
	sta.w BG1HScroll
	stz.w BG2HScroll
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
.loop:								; loop: call CODE_C4B7D4, call AnimateSprites, ...
	jsl.l CODE_C4B7D4
	jsl.l AnimateSprites
	lda.w $2D9D
	beq .loop
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
	ldx.b d1
	lda.w #CODE_C4D398
	sta.w $0002,x
CODE_C4D398:						; a task routine: stored as the next routine of a task
	lda.w BG2HScroll
	inc a
	inc a
	sta.w BG2HScroll
	cmp.w #$0080
	bcc CODE_C4D3AD
	ldx.b d1
	lda.w #CODE_C4D3AE
	sta.w $0002,x
CODE_C4D3AD:						; from CODE_C4D377, CODE_C4D398, CODE_C4D3AE
	rtl
CODE_C4D3AE:						; a task routine: stored as the next routine of a task
	lda.w BG1HScroll
	dec a
	dec a
	dec a
	dec a
	sta.w BG1HScroll
	lda.w BG2HScroll
	inc a
	inc a
	sta.w BG2HScroll
	cmp.w #$0100
	bcc CODE_C4D3AD
	lda.w #$00CB
	sta.b $18
	lda.w #$0093
	sta.b $1A
	lda.w #$0028
	jsr.w CODE_C4D52B
	ldx.b d1
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
	ldx.b d1
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
	ldx.b d1
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
	ldx.b d1
	stz.w $0008,x
	lda.w #CODE_C4D435
	sta.w $0002,x
CODE_C4D435:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$003C
	bne CODE_C4D3FB
	lda.w #$0010
	sta.b $7D
	sta.b d3
	lda.b d4
	ldy.w #$7FFF
	jsl.l CODE_C4B970
	ldx.w #$00C2
	stx.b $71
	lda.w #$0AB8
	sta.b a3
	clc
	adc.b [a3]
	bcc .1
	inx
	clc
.1:									; A + $0002, if carry clear go to .2, X + 1
	adc.w #$0002
	bcc .2
	inx
	clc
.2:									; a3 = A, A + [a3], if carry clear go to .3, X + 1, ...
	sta.b a3
	adc.b [a3]
	bcc .3
	inx
	clc
.3:									; A + $0009, if carry clear go to .4, X + 1
	adc.w #$0009
	bcc .4
	inx
.4:									; $71 = X, a3 = A, X = $007E, A = d4, ...
	stx.b $71
	sta.b a3
	ldx.w #$007E
	lda.b d4
	ldy.b d5
	jsl.l CODE_C4B8D1
	ldx.b d1
	lda.w #CODE_C4D48A
	sta.w $0002,x
CODE_C4D48A:						; a task routine: stored as the next routine of a task
	lda.w #$0020
	jsr.w CODE_C4D588
	bne CODE_C4D4A0
	stz.b $95
	jsl.l CODE_C4B738
	ldx.b d1
	lda.w #CODE_C4D4A1
	sta.w $0002,x
CODE_C4D4A0:						; from CODE_C4D48A, CODE_C4D4AC
	rtl
CODE_C4D4A1:						; a task routine: stored as the next routine of a task
	jsr.w CODE_C4D5AC
	ldx.b d1
	lda.w #CODE_C4D4AC
	sta.w $0002,x
CODE_C4D4AC:						; a task routine: stored as the next routine of a task
	lda.w #$0000
	jsr.w CODE_C4D588
	bne CODE_C4D4A0
	ldx.b d1
	stz.w $0008,x
	lda.w #CODE_C4D4BF
	sta.w $0002,x
CODE_C4D4BF:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$00F0
	bne CODE_C4D52A
	lda.w #$0010
	sta.b d3
	lsr a
	sta.b $7D
	lda.b d4
	ldy.w #$0000
	jsl.l CODE_C4B970
	lda.w #$00C4
	sta.b $71
	lda.w #$BAD6
	sta.b a3
	ldx.w #$007E
	lda.b d4
	ldy.b d5
	jsl.l CODE_C4B8D1
	ldx.b d1
	lda.w #CODE_C4D4F5
	sta.w $0002,x
CODE_C4D4F5:						; a task routine: stored as the next routine of a task
	lda.w #$0000
	jsr.w CODE_C4D588
	bne CODE_C4D52A
	ldx.b $95
	lda.l DATA8_C4D10A,x
	and.w #$00FF
	bne .1
	ldx.b d1
	stz.w $0008,x
	lda.w #CODE_C4D51D
	sta.w $0002,x
	rtl
.1:									; X = d1, $0002,x = CODE_C4D4A1, return
	ldx.b d1
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
	sta.b d3
	lda.b d4
	ldy.w #$0000
	jsl.l CODE_C4B970
	lda.w #$007E
	sta.b $71
	lda.b d4
	sta.b a3
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
	ldy.b d5
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
	lda.b d4
	jsl.l CODE_C4B84C
	rts
CODE_C4D588:						; from CODE_C4D388, CODE_C4D3DD, CODE_C4D414, CODE_C4D48A, ...
	pha
	lda.w #$0010
	sta.b d3
	ldy.b d5
	jsl.l CODE_C4B8AC
	ldx.w #$007E
	lda.b d4
	ldy.b d5
	jsl.l CODE_C4B871
	ldx.w #$007E
	lda.b d4
	ply
	jsl.l CODE_C4B84C
	dec.b $7D
	rts
CODE_C4D5AC:						; from CODE_C4D4A1
	lda.w #$0020
	sta.b $7D
	lsr a
	sta.b d3
	lda.w #$007E
	sta.b $71
	lda.b d4
	sta.b a3
	ldy.w #$0000
	jsl.l CODE_C4B970
	ldx.w #$00C4
	lda.w #$BAD6
	ldy.b d5
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
	stz.b d6
	lda.w #$2400
	sta.b $D5
	inx
.loop:								; loop: $95 = X, A = DATA8_C4D10A,x, X = A, Y = d6, ...
	stx.b $95
	lda.l DATA8_C4D10A,x
	tax
	ldy.b d6
	jsl.l CODE_C4BBE5
	ldx.b $95
	lda.w #$2000
	cmp.b $D5
	beq .1
	sta.b $D5
	inc.b d6
.1:									; d6 + 1, X + 1, X + 1, $99 - 1, ...
	inc.b d6
	inx
	inx
	dec.b $99
	bne .loop
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
	stx.b tmp1
	sta.b tmp0
	clc
	adc.b [tmp0]
	bcc .1
	inx
	clc
.1:									; A + $0002, if carry clear go to .2, X + 1
	adc.w #$0002
	bcc .2
	inx
	clc
.2:									; tmp0 = A, A + [tmp0], if carry clear go to .3, X + 1, ...
	sta.b tmp0
	adc.b [tmp0]
	bcc .3
	inx
	clc
.3:									; A + $0009, if carry clear go to .rts, X + 1
	adc.w #$0009
	bcc .rts
	inx
.rts:								; return
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
	stz.w BG1HScroll
	stz.w BG2HScroll
	stz.w BG3HScroll
	sta.w BG1VScroll
	sta.w BG3VScroll
	lda.w #$0400
	sta.b tmp1
	lda.w #$5800
	sta.b tmp0
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
	stz.b a0
.loop:								; loop: call CODE_C3716D, call CODE_C36C2D, A = $058D, A and $FFF0, ...
	jsl.l CODE_C3716D
	jsl.l CODE_C36C2D
	lda.w $058D
	and.w #$FFF0
	tsb.b a0
	lda.b $26
	cmp.w #$003C
	bne .1
	lda.w #$05D4
	ldx.w #$00CF
	jsl.l CODE_CF0134
	bra .loop
.1:									; if A < $00C3 go to .loop, if a0 is not 0 go to .2, ...
	cmp.w #$00C3
	bcc .loop
	ldx.b a0
	bne .2
	cmp.w #$04B0
	bcc .loop
.2:									; call FadeOutWait, go to ClearNMIHook
	jsl.l FadeOutWait
	jml.l ClearNMIHook
CODE_C4D773:						; from CODE_C4D818, CODE_C4DFD6
	jsl.l CODE_C4C574
	jsl.l CODE_C5E50E
	jsl.l CODE_C4C530
	lda.w #$007F
	sta.b $2E
	lda.w #$D80A
	sta.b r0
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
	sta.b tmp1
	lda.w #$5800
	sta.b tmp0
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
	stz.w BG2HScroll
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
	stx.b a4
	lda.w #$2000
	sta.b $36,x
	lda.w #$FFFF
	sta.b $75
	lda.w #$0240
	jsl.l CODE_C4C558
	sta.b r0
	sta.b r2
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
	sta.w BG2VScroll
	lda.w #$5419
	jsl.l CODE_C4BB5A
	jsl.l CODE_C4CEDB
	jsl.l CODE_C4C2AA
	stz.w fadestep
	stz.b a0
	jsl.l CODE_C4CEDB
	jsr.w CODE_C4D941
	jsr.w CODE_C4DC45
	jsr.w CODE_C4DAAD
.loop:								; loop: TransfersReady + 1, call CODE_C36C2D, $26 + 1, ...
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
	lda.w repeatdelayframes
	bne .loop
	lda.w $058D
	bit.w #$0100
	beq .1
	lda.b a0
	inc a
	cmp.w #$0008
	bcc .2
	lda.w #$0000
	bra .2
.1:									; if $0200 bits clear go to .4, A = a0, A - 1, ...
	bit.w #$0200
	beq .4
	lda.b a0
	dec a
	bpl .2
	lda.w #$0007
.2:									; a0 = A, A = $D3, A + $0140, Y = $0480, ...
	sta.b a0
	lda.b $D3
	clc
	adc.w #$0140
	ldy.w #$0480
	jsl.l CODE_C58B11
	jsr.w CODE_C4D941
	jsr.w CODE_C4DC45
	ldx.b a0
	cpx.w #$0007
	bne .3
	jsr.w CODE_C4DBCC
	bra .loop
.3:									; call CODE_C4DAAD, go to .loop
	jsr.w CODE_C4DAAD
	bra .loop
.4:									; if $1000 bits clear go to .loop, return
	bit.w #$1000
	beq .loop
	rtl
CODE_C4D941:						; from CODE_C4D818
	lda.w #$0005
	sta.w $18DE
	ldy.w #$5000
	jsl.l CODE_C589B0
	jsl.l CODE_C4C2AA
	jsl.l CODE_C4CEDB
	ldx.b $75
	bmi .1
	jsl.l CODE_C5E596
	lda.w #$FFFF
	sta.b $75
.1:									; X = a4, A = $22,x, A and $FFFE, $22,x = A, ...
	ldx.b a4
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	jsl.l CODE_C5BBBC
	lda.w #$0088
	sta.b $CF
	lda.w #$00F0
	sta.b $D1
	lda.b a0
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
	beq .2
	tax
	ldy.w #$0013
	jsl.l CODE_C4BBE5
.2:									; $CF = 0, $D1 = $0100, pull X, A = AwardDescs,x, ...
	stz.b $CF
	lda.w #$0100
	sta.b $D1
	plx
	lda.l AwardDescs,x
	tax
	ldy.w #$0015
	jsl.l CODE_C4BBE5
	jsl.l CODE_C4CEDB
	lda.b a0
	asl a
	asl a
	tax
	lda.b $08
	sta.b r1
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
	ldx.b a0
	lda.l DATA8_C4DA75,x
	and.w #$00FF
	asl a
	asl a
	asl a
	asl a
	asl a
	pha
	sta.b tmp0
	pea.w $0000
	pea.w $007E
	lda.b $08
	clc
	adc.w #$00EA
	pha
	adc.b tmp0
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
.loop:								; loop: push X, push Y, A = Y, A + $0012, ...
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
	bne .loop
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
AwardPictures:						; the picture (map set) of each award, a long pointer; read by CODE_C4D941
	dw VezinaPicMap&$FFFF,VezinaPicMap>>16	; 0: Vezina Trophy
	dw SelkePicMap&$FFFF,SelkePicMap>>16	; 1: Frank J. Selke Trophy
	dw ConnSmythePicMap&$FFFF,ConnSmythePicMap>>16	; 2: Conn Smythe Trophy
	dw JenningsPicMap&$FFFF,JenningsPicMap>>16	; 3: William M. Jennings Trophy
	dw HartPicMap&$FFFF,HartPicMap>>16	; 4: Hart Memorial Trophy
	dw ArtRossPicMap&$FFFF,ArtRossPicMap>>16	; 5: Art Ross Trophy
	dw NorrisPicMap&$FFFF,NorrisPicMap>>16	; 6: James Norris Memorial Trophy
	dw PresidentsPicMap&$FFFF,PresidentsPicMap>>16	; 7: Presidents Trophy
DATA8_C4DA75:						; not traced: a table read by CODE_C4D941
	db $3B,$2F,$4C,$5F,$31,$52,$42,$22
AwardNames:							; per award: the name text, then a second line or 0; CODE_C4D941
	dw $4FC2,$0000					; 0: Vezina Trophy
	dw $4FD9,$4FAC					; 1: Frank J. Selke Trophy
	dw $4FF7,$4FAC					; 2: Conn Smythe Trophy
	dw $501A,$5039					; 3: William M. Jennings Trophy
	dw $5045,$4FAC					; 4: Hart Memorial Trophy
	dw $5061,$0000					; 5: Art Ross Trophy
	dw $5079,$4FB1					; 6: James Norris Memorial Trophy
	dw $508F,$4FAC					; 7: Presidents Trophy
AwardDescs:							; per award: the description text; read by CODE_C4D941
	dw $4FCD						; 0: Vezina Trophy
	dw $4FE5						; 1: Frank J. Selke Trophy
	dw $5001						; 2: Conn Smythe Trophy
	dw $5023						; 3: William M. Jennings Trophy
	dw $5050						; 4: Hart Memorial Trophy
	dw $506F						; 5: Art Ross Trophy
	dw $5083						; 6: James Norris Memorial Trophy
	dw $5097						; 7: Presidents Trophy
CODE_C4DAAD:						; from CODE_C4D818
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
.loop:								; loop: Y + 1, Y + 1, if A is not $2E03,y go to .loop, $65 = Y, ...
	iny
	iny
	cmp.w $2E03,y
	bne .loop
	sty.b $65
	lda.w $2EA7,y
	sta.b a1
	and.w #$00FF
	sta.b $71
	tax
	cmp.w #$00FF
	beq .1
	lda.w $2E75,y
	sta.b a3
	clc
	adc.w #$00C0
	phy
	ldy.b $68
	jsr.w CODE_C4EC88
	ply
	sta.b a2
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
	lda.b a1
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	adc.b a3
	pha
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	ldx.b a4
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	jsl.l CODE_C4CEDB
	bra .2
.1:									; X = a4, A = $22,x, A and $FFFE, $22,x = A, ...
	ldx.b a4
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
.2:									; $CF = $0010, $D1 = $0080, A = $65, A * 2, ...
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
CODE_C4DBCC:						; from CODE_C4D818
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
	ldx.b a4
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
CODE_C4DC45:						; from CODE_C4D818
	lda.w #$0030
	sta.b $69
	lda.b a0
	asl a
	tax
	jmp (DATA8_C4DC51,x)
DATA8_C4DC51:						; jump table: the routine for each index
	dw CODE_C4DC61,CODE_C4DC9C,CODE_C4DCE2,CODE_C4DD41
	dw CODE_C4DD74,CODE_C4DE68,CODE_C4DED9,CODE_C4DF20
CODE_C4DC61:						; from DATA8_C4DC51
	lda.w #$0000
	sta.b a2
.1:									; $6D = A, $17C9 = A, call CODE_C531BC
	sta.b $6D
	sta.w $17C9
	jsl.l CODE_C531BC
.loop:								; loop: A = $2DCB, A - 1, if the result < 0 go to .2, $2DCB = A, ...
	lda.w $2DCB
	dec a
	bmi .2
	sta.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b a3
	jsl.l CODE_C5BDA8
	lda.b tmp0
	cmp.b a2
	bcc .loop
	sta.b a2
	lda.b a3
	sta.b $71
	bra .loop
.2:									; A = $6D, A + 1, if A is not $001A go to .1, A = $71, ...
	lda.b $6D
	inc a
	cmp.w #$001A
	bne .1
	lda.b $71
	rts
CODE_C4DC9C:						; from DATA8_C4DC51
	stz.b a2
	jsr.w CODE_C4DF5B
	sta.w $17C9
	jsl.l CODE_C531BC
	stz.b a2
.loop:								; loop: A = $2DCD, A - 1, if the result < 0 go to .1, ...
	lda.w $2DCD
	dec a
	bmi .1
	beq .1
	sta.w $2DCD
	clc
	adc.w $2DCB
	asl a
	tax
	lda.w $2E05,x
	sta.b a3
	jsl.l CODE_C5BD52
	lda.b tmp0
	sta.b tmp1
	lda.b a3
	jsl.l CODE_C5BD7D
	lda.b tmp0
	clc
	adc.b tmp1
	cmp.b a2
	bcc .loop
	sta.b a2
	lda.b a3
	sta.b $71
	bra .loop
.1:									; A = $71, return
	lda.b $71
	rts
CODE_C4DCE2:						; from DATA8_C4DC51
	lda.w #$0000
	sta.b a2
.1:									; $6D = A, X = A, A = $3075A4,x, A and $00FF, ...
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
.loop:								; loop: A = $2DC9, A - 1, if the result < 0 go to .2, $2DC9 = A, ...
	lda.w $2DC9
	dec a
	bmi .2
	sta.w $2DC9
	ldx.b $6D
	sec
	adc.w $2DCB
	pha
	jsr.w CODE_C4DF82
	sta.b tmp2
	pla
	ldx.b $6D
	jsr.w CODE_C4DFAC
	clc
	adc.b tmp2
	cmp.b a2
	bcc .loop
	sta.b a2
	lda.w $2DC9
	sec
	adc.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b $71
	bra .loop
.2:									; A = $6D, A + 1, if A < $0010 go to .1, A = $71, ...
	lda.b $6D
	inc a
	cmp.w #$0010
	bcc .1
	lda.b $71
	rts
CODE_C4DD41:						; from DATA8_C4DC51
	stz.b a2
	jsr.w CODE_C4DF5B
	sta.w $17C9
	jsl.l CODE_C531BC
	stz.b a2
.loop:								; loop: A = $2DCB, A - 1, if the result < 0 go to .1, $2DCB = A, ...
	lda.w $2DCB
	dec a
	bmi .1
	sta.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b a3
	jsl.l CODE_C5BDE7
	lda.b tmp0
	cmp.b a2
	bcc .loop
	sta.b a2
	lda.b a3
	sta.b $71
	bra .loop
.1:									; A = $71, return
	lda.b $71
	rts
CODE_C4DD74:						; from DATA8_C4DC51
	stz.b a2
	stz.b $32
	ldx.w #$002E
.loop:								; loop: $364E,x = 0, X - 1, X - 1, if the result >= 0 go to .loop, ...
	stz.w $364E,x
	dex
	dex
	bpl .loop
	lda.w #$0000
.1:									; $6D = A, call CODE_C5B97F, X = $364E
	sta.b $6D
	jsl.l CODE_C5B97F
	ldx.w #$364E
.loop2:								; loop: if $000A,y >= $0000,x go to .2, A = X, A + $0006, X = A, ...
	lda.w $000A,y
	cmp.w $0000,x
	bcs .2
	txa
	clc
	adc.w #$0006
	tax
	cmp.w #$367E
	bne .loop2
	bra .4
.2:									; push Y, A = X, A xor $FFFF, A + 1, ...
	phy
	txa
	eor.w #$FFFF
	inc a
	clc
	ldy.w #$367D
	ldx.w #$3677
	adc.w #$3678
	beq .3
	dec a
	mvp $7E,$7E
.3:									; pull Y, X + 1, $0000,x = $000A,y, $0004,x = $6D
	ply
	inx
	lda.w $000A,y
	sta.w $0000,x
	lda.b $6D
	sta.w $0004,x
.4:									; A = $6D, A + 1, if A is not $001A go to .1, X = $0000
	lda.b $6D
	inc a
	cmp.w #$001A
	bne .1
	ldx.w #$0000
.5:									; $6D = X, $17C9 = $3652,x, call CODE_C531BC, tmp2 = 0, ...
	stx.b $6D
	lda.w $3652,x
	sta.w $17C9
	jsl.l CODE_C531BC
	stz.b tmp2
	stz.b r1
	lda.w $2DCF
	clc
	adc.w $2DCD
.loop3:								; loop: A - 1, if the result < 0 go to .loop4, $2DCD = A, A + $2DCB, ...
	dec a
	bmi .loop4
	sta.w $2DCD
	adc.w $2DCB
	asl a
	tax
	lda.w $2E03,x
	sta.b a3
	jsl.l CODE_C5BD52
	lda.b tmp0
	sta.b tmp1
	lda.b a3
	jsl.l CODE_C5BD7D
	lda.b tmp0
	clc
	adc.b tmp1
	ldx.b tmp2
	sta.w $3680,x
	clc
	adc.b r1
	sta.b r1
	lda.b a3
	sta.w $367E,x
	inx
	inx
	inx
	inx
	stx.b tmp2
	lda.w $2DCD
	bra .loop3
.loop4:								; loop: X - 1, X - 1, X - 1, X - 1, ...
	dex
	dex
	dex
	dex
	bmi .6
	stx.b tmp2
	stz.b r2
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
	sta.b r1
	ldx.b tmp2
	lda.b r0
	cmp.b a2
	bcc .loop4
	sta.b a2
	lda.w $367E,x
	sta.b $71
	bra .loop4
.6:									; A = $6D, A + $0006, X = A, if A >= $0030 go to .7, ...
	lda.b $6D
	clc
	adc.w #$0006
	tax
	cmp.w #$0030
	bcs .7
	jmp.w .5
.7:									; A = $71, return
	lda.b $71
	rts
CODE_C4DE68:						; from DATA8_C4DC51
	lda.w #$FFFF
	sta.w $17C9
	inc a
	sta.b a2
.loop:								; loop: a3 = A, A * 2, A + a3, A / 2, ...
	sta.b a3
	asl a
	adc.b a3
	lsr a
	tax
	lda.l $306A56,x
	bcc .1
	lsr a
	lsr a
	lsr a
	lsr a
.1:									; A and $001F, if A >= $001A go to .3, if A = $17C9 go to .2, ...
	and.w #$001F
	cmp.w #$001A
	bcs .3
	cmp.w $17C9
	beq .2
	sta.w $17C9
	pei ($6F)
	pei ($71)
	jsl.l CODE_C531BC
	pla
	sta.b $71
	pla
	sta.b a3
.2:									; A = $2DCB, A - 1, A * 2, X = A, ...
	lda.w $2DCB
	dec a
	asl a
	tax
	lda.b a3
.loop2:								; loop: if A = $2E03,x go to .3, X - 1, X - 1, ...
	cmp.w $2E03,x
	beq .3
	dex
	dex
	bpl .loop2
	jsl.l CODE_C5BD52
	lda.b tmp0
	sta.b tmp1
	lda.b a3
	jsl.l CODE_C5BD7D
	lda.b tmp0
	clc
	adc.b tmp1
	cmp.b a2
	bcc .3
	sta.b a2
	lda.b a3
	sta.b $71
.3:									; A = a3, A + 1, if A < $027E go to .loop, A = $71, ...
	lda.b a3
	inc a
	cmp.w #$027E
	bcc .loop
	lda.b $71
	rts
CODE_C4DED9:						; from DATA8_C4DC51
	stz.b a2
	jsr.w CODE_C4DF5B
	sta.w $17C9
	jsl.l CODE_C531BC
	stz.b a2
.loop:								; loop: A = $2DCF, A - 1, if the result = 0 go to .1, $2DCF = A, ...
	lda.w $2DCF
	dec a
	beq .1
	sta.w $2DCF
	clc
	adc.w $2DCB
	adc.w $2DCD
	asl a
	tax
	lda.w $2E03,x
	sta.b a3
	jsl.l CODE_C5BD52
	lda.b tmp0
	sta.b tmp1
	lda.b a3
	jsl.l CODE_C5BD7D
	lda.b tmp0
	clc
	adc.b tmp1
	cmp.b a2
	bcc .loop
	sta.b a2
	lda.b a3
	sta.b $71
	bra .loop
.1:									; A = $71, return
	lda.b $71
	rts
CODE_C4DF20:						; from DATA8_C4DC51
	lda.w #$FFFF
	sta.b a3
	lda.w #$0000
	sta.b a2
.loop:								; loop: $6D = A, call CODE_C5B97F, if $0004,x < a2 go to .2, ...
	sta.b $6D
	jsl.l CODE_C5B97F
	lda.w $0004,x
	cmp.b a2
	bcc .2
	bne .1
	lda.w $0006,x
	cmp.b a3
	bcs .2
	sta.b a3
	lda.w $0004,x
.1:									; a2 = A, a3 = $0006,x, $71 = $6D
	sta.b a2
	lda.w $0006,x
	sta.b a3
	lda.b $6D
	sta.b $71
.2:									; A = $6D, A + 1, if A is not $001A go to .loop, A = $71, ...
	lda.b $6D
	inc a
	cmp.w #$001A
	bne .loop
	lda.b $71
	rts
CODE_C4DF5B:						; from CODE_C4DC9C, CODE_C4DD41, CODE_C4DED9
	lda.w #$0000
	sta.b a2
	sta.b $71
	dec.b a2
.loop:								; loop: $6D = A, call CODE_C5B97F, if $002A,x >= a2 go to .1, a2 = A, ...
	sta.b $6D
	jsl.l CODE_C5B97F
	lda.w $002A,x
	cmp.b a2
	bcs .1
	sta.b a2
	lda.b $6D
	sta.b $71
.1:									; A = $6D, A + 1, if A is not $001A go to .loop, A = $71, ...
	lda.b $6D
	inc a
	cmp.w #$001A
	bne .loop
	lda.b $71
	rts
CODE_C4DF82:						; from CODE_C4DCE2
	sta.b tmp0
	asl a
	asl a
	asl a
	sec
	sbc.b tmp0
	sta.b tmp0
	txa
	asl a
	tax
	lda.l DATA8_C40D76,x
	adc.b tmp0
	tay
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	tay
	lda.l $3072E8,x
.loop:								; loop: A / 2, Y - 1, if the result >= 0 go to .loop, A and $007F, ...
	lsr a
	dey
	bpl .loop
	rol a
	and.w #$007F
	rts
CODE_C4DFAC:						; from CODE_C4DCE2
	sta.b tmp0
	asl a
	asl a
	asl a
	sec
	sbc.b tmp0
	sta.b tmp0
	txa
	asl a
	tax
	lda.l DATA8_C40D76,x
	adc.b tmp0
	tay
	lsr a
	lsr a
	lsr a
	tax
	tya
	and.w #$0007
	tay
	lda.l $307446,x
.loop:								; loop: A / 2, Y - 1, if the result >= 0 go to .loop, A and $007F, ...
	lsr a
	dey
	bpl .loop
	rol a
	and.w #$007F
	rts

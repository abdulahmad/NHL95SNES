; Segment bankC4_B000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4B00F
ClearOffsidesIfAllPlayers:			; called from other segments
	ldy.b a2
	lda.w tmflags,y
	bit.w #$0010
	bne .1
	jmp.w OffsidesReturn
.1:									; a0 = tmsort,y, d1 = $0005
	lda.w tmsort,y
	sta.b a0
	lda.w #$0005
	sta.b d1
.2:									; Y = a0, if position,y < 0 go to .3, d0 = Ypos,y, ...
	ldy.b a0
	lda.w position,y
	bmi .3
	lda.w Ypos,y
	sta.b d0
	lda.w pfgoal,y
	bne .3
	lda.w #$0000
	sec
	sbc.b d0
	sta.b d0
.3:									; a0 + 1, a0 + 1, A = d0, A - $005C, ...
	inc.b a0
	inc.b a0
	lda.b d0
	sec
	sbc.w #$005C
	bmi .4
	jmp.w OffsidesReturn
.4:									; d1 - 1, if the result >= 0 go to .2, Y = a2, A = tmflags,y, ...
	dec.b d1
	bpl .2
	ldy.b a2
	lda.w tmflags,y
	and.w #$FFEF
	sta.w tmflags,y
	rtl
CODE_C4B05E:						; passed as a long pointer (lda # of its bank and address) to SetNMIHook
	sep #$20
	lda.w $18D0
	sta.w $211B
	lda.w $18D1
	sta.w $211B
	lda.w $18D0
	sta.w $211E
	lda.w $18D1
	sta.w $211E
	lda.w $18D2
	sta.w $211F
	lda.w $18D3
	sta.w $211F
	lda.w $18D4
	sta.w $2120
	lda.w $18D5
	sta.w $2120
	lda.w $18D6
	sta.w $211A
	lda.w $18D8
	sta.w TM
	rep #$20
	rtl
IntroSequence:						; the power-on animation: the EA Sports logo from its sprites
									; (EALogoESprite, EALogoASprite, SportsWordSprite, ElectronicWordSprite
									; ...), run by tasks until they end
	jsl.l Multi5Bios
	jsl.l ReadMenuPads
	ldx.w #DATA8_C07F7B>>16
	lda.w #DATA8_C07F7B&$FFFF
	jsl.l LoadSounds
	lda.w #CODE_C4B05E
	ldx.w #CODE_C4B05E>>16
	jsl.l SetNMIHook
	jsl.l InitTasks
	stz.b $81
	lda.b PadRaw1
	jsr.w CODE_C4B1D6
	lda.b PadRaw2
	jsr.w CODE_C4B1D6
	lda.b $C5
	jsr.w CODE_C4B1D6
	lda.b $C7
	jsr.w CODE_C4B1D6
	lda.b $C9
	jsr.w CODE_C4B1D6
	jsl.l SetupMode7Screen
	lda.w #$7FFF
	jsl.l SetBackdropColour
	lda.b $08
	sta.b $65
	lda.w #$0021
	jsl.l CreateSprite
	stx.b a0
	lda.w #$0066
	ldy.w #$0043
	jsr.w CODE_C4B280
	jsl.l AnimateSprites
	jsl.l MarkWorkBuf
	lda.b $08
	sta.b $69
	lda.w #$0022
	jsl.l CreateSprite
	stx.b a1
	lda.w #$009F
	ldy.w #$0043
	jsr.w CODE_C4B280
	jsl.l AnimateSprites
	jsl.l MarkWorkBuf
	lda.b $08
	sta.b $6D
	lda.w #$0023
	jsl.l CreateSprite
	stx.b a2
	lda.w #$0080
	ldy.w #$007C
	jsr.w CODE_C4B280
	jsl.l AnimateSprites
	jsl.l MarkWorkBuf
	lda.b $08
	sta.b $71
	lda.w #$0024
	jsl.l CreateSprite
	stx.b a3
	lda.w #$0080
	ldy.w #$0094
	jsr.w CODE_C4B280
	jsl.l AnimateSprites
	jsl.l MarkWorkBuf
	lda.w #$0025
	jsl.l CreateSprite
	stx.b $7B
	lda.w #$0080
	ldy.w #$00B4
	jsr.w CODE_C4B280
	jsl.l MarkWorkBuf
	lda.w #$0010
	sta.w $18D8
	jsl.l AnimateSprites
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
	jsl.l WaitTransfers
	lda.w #$F254
	sta.b d3
	ldx.b a0
	ldy.b $65
	jsr.w CODE_C4B36A
	lda.w #CODE_C4B1E4
	ldx.w #CODE_C4B1E4>>16
	ldy.w #$0001
	clc
	jsl.l StartTasks
	jsl.l AddStartKeyTask
	lda.w #CODE_C4B66E
	ldx.w #CODE_C4B66E>>16
	ldy.w #$F000
	jsl.l AddTask
	lda.b a0
	ldx.w #$0001
	jsr.w CODE_C4B299
	stz.w fadestep
.loop:								; loop: call RunTasks, if $2D9D = 0 go to .loop, go to ClearNMIHook
	jsl.l RunTasks
	lda.w $2D9D
	beq .loop
	jml.l ClearNMIHook
CODE_C4B1D6:						; from IntroSequence
	and.w #$F0C0
	cmp.w #$F0C0
	bne .rts
	lda.w #$8000
	tsb.b $81
.rts:								; return
	rts
CODE_C4B1E4:						; passed as a long pointer (lda # of its bank and address) to StartTasks
	lda.w $18D0
	cmp.w #$0100
	beq .1
	jmp.w CODE_C4B27F
.1:									; X = a1, Y = $69, call CODE_C4B36A, A = a1, ...
	ldx.b a1
	ldy.b $69
	jsr.w CODE_C4B36A
	lda.b a1
	ldx.w #$0001
	jsr.w CODE_C4B299
	ldx.b d1
	lda.w #CODE_C4B206
	sta.w $0002,x
CODE_C4B206:						; a task routine: stored as the next routine of a task
	lda.w $18D0
	cmp.w #$0100
	beq .1
	jmp.w CODE_C4B27F
.1:									; X = a2, Y = $6D, call CODE_C4B36A, A = a2, ...
	ldx.b a2
	ldy.b $6D
	jsr.w CODE_C4B36A
	lda.b a2
	ldx.w #$0000
	jsr.w CODE_C4B299
	ldx.b d1
	lda.w #CODE_C4B228
	sta.w $0002,x
CODE_C4B228:						; a task routine: stored as the next routine of a task
	lda.w $18D0
	cmp.w #$0100
	bne CODE_C4B27F
	ldx.b a3
	ldy.b $71
	jsr.w CODE_C4B36A
	lda.b a3
	ldx.w #$0000
	jsr.w CODE_C4B299
	ldx.b d1
	lda.w #CODE_C4B247
	sta.w $0002,x
CODE_C4B247:						; a task routine: stored as the next routine of a task
	lda.w $18D0
	cmp.w #$0100
	bne CODE_C4B27F
	ldx.b d1
	stz.w $0008,x
	lda.w #CODE_C4B25A
	sta.w $0002,x
CODE_C4B25A:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$001E
	bne CODE_C4B27F
	ldx.b $7B
	jsr.w CODE_C4B31A
	ldx.b d1
	stz.w $0008,x
	lda.w #CODE_C4B272
	sta.w $0002,x
CODE_C4B272:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$0258
	bne CODE_C4B27F
	lda.w #$8000
	trb.b $85
CODE_C4B27F:						; from CODE_C4B1E4, CODE_C4B206, CODE_C4B228, CODE_C4B247, ...
	rtl
CODE_C4B280:						; from IntroSequence, CODE_C4B10D
	bit.b $81
	bpl .1
	sec
	sbc.w #$0100
	eor.w #$FFFF
	inc a
.1:									; $05,x = A, A = Y, $08,x = A, A = $22,x, ...
	sta.b $05,x
	tya
	sta.b $08,x
	lda.b $22,x
	and.w #$FFFE
	sta.b $22,x
	rts
CODE_C4B299:						; from CODE_C4B10D, CODE_C4B228, CODE_C4B1E4, CODE_C4B206
	sta.b d0
	lda.w #$0001
	trb.b $81
	txa
	tsb.b $81
	lda.w #$0011
	sta.w $18D8
	lda.w #$4000
	sta.w $18D0
	lda.w #CODE_C4B2BD
	ldx.w #CODE_C4B2BD>>16
	ldy.w #$1000
	jsl.l AddTask
	rts
CODE_C4B2BD:						; passed as a long pointer (lda # of its bank and address) to AddTask
	jsr.w CODE_C4B2F9
	cmp.w #$0280
	bcs CODE_C4B2F8
	lda.w #CODE_C4B2DC
	sta.w $0002,x
	lda.b $81
	lsr a
	bcc CODE_C4B2F8
	lda.w #CODE_C4B32D
	ldx.w #CODE_C4B32D>>16
	ldy.w #$0500
	jmp.w AddTask
CODE_C4B2DC:						; a task routine: stored as the next routine of a task
	jsr.w CODE_C4B2F9
	cmp.w #$0100
	bcs CODE_C4B2F8
	lda.w #$0100
	sta.w $18D0
	lda.w #$0010
	sta.w $18D8
	ldx.b d0
	jsr.w CODE_C4B31A
	jmp.w RemoveTask
CODE_C4B2F8:						; from CODE_C4B2BD, CODE_C4B2DC
	rtl
CODE_C4B2F9:						; from CODE_C4B2BD, CODE_C4B2DC
	lda.w $18D0
	lsr a
	lsr a
	cmp.w #$0280
	bcc .1
	lda.w #$0280
.1:									; if A >= $0020 go to .2, A = $0020
	cmp.w #$0020
	bcs .2
	lda.w #$0020
.2:									; A - $18D0, A xor $FFFF, A + 1, $18D0 = A, ...
	sec
	sbc.w $18D0
	eor.w #$FFFF
	inc a
	sta.w $18D0
	rts
CODE_C4B31A:						; from CODE_C4B25A, CODE_C4B2DC
	lda.b $22,x
	ora.w #$0001
	sta.b $22,x
	bit.b $81
	bpl .rts
	lda.b $36,x
	ora.w #$4000
	sta.b $36,x
.rts:								; return
	rts
CODE_C4B32D:						; passed as a long pointer (lda # of its bank and address) to AddTask
	and.w #$00FF
	sep #$20
	lda.w $0008,x
	tax
	lda.l DATA8_C4B35D,x
	beq .1
	sta.l $002132
	lda.b #$01
	sta.l $002131
	dec a
	sta.l $002130
	rep #$20
	rtl
.1:									; $002131 = A, $002132 = $E0, A 16-bit, go to RemoveTask
	sta.l $002131
	lda.b #$E0
	sta.l $002132
	rep #$20
	jmp.w RemoveTask
DATA8_C4B35D:						; not traced: a table read by CODE_C4B32D
	db $64,$68,$6C,$70,$74,$78,$7C,$7F,$78,$70,$68,$64,$00
CODE_C4B36A:						; from CODE_C4B10D, CODE_C4B228, CODE_C4B1E4, CODE_C4B206
	lda.b $34,x
	and.w #$FF00
	lsr a
	lsr a
	lsr a
	lsr a
	adc.w #$0080
	sta.b $79
	jsl.l RestoreWorkBuf
	phx
	stz.b a4
	lda.b $28,x
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $01,x
	and.w #$00FF
	asl a
	asl a
	sta.b $77
	ldx.b $08
.1:									; A 8-bit, $75 = $08
	sep #$20
	lda.b #$08
	sta.b $75
.loop:								; loop: A = $0000,y, A and $80, call CODE_C4B669, A = $0001,y, ...
	lda.w $0000,y
	and.b #$80
	jsr.w CODE_C4B669
	lda.w $0001,y
	and.b #$80
	jsr.w CODE_C4B668
	lda.w $0010,y
	and.b #$80
	jsr.w CODE_C4B667
	lda.w $0011,y
	and.b #$80
	jsr.w CODE_C4B660
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$40
	jsr.w CODE_C4B668
	lda.w $0001,y
	and.b #$40
	jsr.w CODE_C4B667
	lda.w $0010,y
	and.b #$40
	jsr.w CODE_C4B660
	lda.w $0011,y
	and.b #$40
	jsr.w CODE_C4B661
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$20
	jsr.w CODE_C4B667
	lda.w $0001,y
	and.b #$20
	jsr.w CODE_C4B660
	lda.w $0010,y
	and.b #$20
	jsr.w CODE_C4B661
	lda.w $0011,y
	and.b #$20
	jsr.w CODE_C4B662
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$10
	jsr.w CODE_C4B660
	lda.w $0001,y
	and.b #$10
	jsr.w CODE_C4B661
	lda.w $0010,y
	and.b #$10
	jsr.w CODE_C4B662
	lda.w $0011,y
	and.b #$10
	jsr.w CODE_C4B663
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$08
	jsr.w CODE_C4B661
	lda.w $0001,y
	and.b #$08
	jsr.w CODE_C4B662
	lda.w $0010,y
	and.b #$08
	jsr.w CODE_C4B663
	lda.w $0011,y
	and.b #$08
	tsb.b a4
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$04
	jsr.w CODE_C4B662
	lda.w $0001,y
	and.b #$04
	jsr.w CODE_C4B663
	lda.w $0010,y
	and.b #$04
	tsb.b a4
	lda.w $0011,y
	and.b #$04
	jsr.w CODE_C4B66A
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$02
	jsr.w CODE_C4B663
	lda.w $0001,y
	and.b #$02
	tsb.b a4
	lda.w $0010,y
	and.b #$02
	jsr.w CODE_C4B66A
	lda.w $0011,y
	and.b #$02
	jsr.w CODE_C4B669
	jsr.w CODE_C4B653
	lda.w $0000,y
	and.b #$01
	tsb.b a4
	lda.w $0001,y
	and.b #$01
	jsr.w CODE_C4B66A
	lda.w $0010,y
	and.b #$01
	jsr.w CODE_C4B669
	lda.w $0011,y
	and.b #$01
	jsr.w CODE_C4B668
	jsr.w CODE_C4B653
	iny
	iny
	dec.b $75
	beq .2
	jmp.w .loop
.2:									; A 16-bit, A = Y, A + $0010, Y = A, ...
	rep #$20
	tya
	clc
	adc.w #$0010
	tay
	dec.b $77
	beq .3
	jmp.w .1
.3:									; pull X, push X, A = $28,x, A * 2, ...
	plx
	phx
	lda.b $28,x
	asl a
	adc.b $26,x
	tax
	lda.b $00,x
	tax
	lda.b $00,x
	and.w #$FF00
	tay
	lda.w #$0040
	sta.b a4
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	lda.w brightness
	cmp.w #$0080
	bne .loop2
	tya
	bra .5
.loop2:								; loop: A = Y, A xor $FFFF, A + 1, if A >= d3 go to .4, ...
	tya
	eor.w #$FFFF
	inc a
	cmp.b d3
	bcs .4
	lda.b d3
.4:									; A xor $FFFF, A + 1
	eor.w #$FFFF
	inc a
.5:									; push A, $75 = A, A = $02, $02 = X, ...
	pha
	sta.b $75
	pea.w $0080
	pei ($73)
	pea.w $1900
	pea.w $007E
	pei ($08)
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	lda.b $75
	adc.b a4
	sta.b a4
	lda.b $08
	adc.b $75
	sta.b $08
	tya
	sec
	sbc.b $75
	tay
	beq .6
	inc.w TransfersReady
	wai
	lda.w #$F254
	sta.b d3
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	bra .loop2
.6:									; A = d3, A + $75, d3 = A, if A < $FF10 go to .7, ...
	lda.b d3
	clc
	adc.b $75
	sta.b d3
	cmp.w #$FF10
	bcc .7
	inc.w TransfersReady
	wai
.7:									; X = $08, Y = $0E00
	ldx.b $08
	ldy.w #$0E00
.loop3:								; loop: $0000,x = 0, X + 1, X + 1, Y - 1, ...
	stz.w $0000,x
	inx
	inx
	dey
	bne .loop3
	ply
	lda.w $0028,y
	asl a
	adc.w $0026,y
	tax
	lda.b $00,x
	tax
	lda.b $02,x
	tax
	lda.l SpritePieces,x
	eor.w #$FFFF
	inc a
	sta.w $18D2
	lda.l SpritePieces+2,x
	eor.w #$FFFF
	inc a
	sta.w $18D4
	lda.w $0005,y
	sec
	sbc.w $18D2
	eor.w #$FFFF
	inc a
	sta.w BG1HScroll
	lda.w $0008,y
	sec
	sbc.w $18D4
	eor.w #$FFFF
	sta.w BG1VScroll
	bit.b $81
	bpl .8
	lda.w $0005,y
	sec
	sbc.w #$0100
	eor.w #$FFFF
	inc a
	sec
	sbc.w $18D2
	eor.w #$FFFF
	inc a
	sta.w BG1HScroll
	lda.w #$0001
	tsb.w $18D6
	bra .9
.8:									; A = $0001
	lda.w #$0001
	trb.w $18D6
.9:									; a4 = $0001, push X, A = $0028,y, A * 2, ...
	lda.w #$0001
	sta.b a4
	phx
	lda.w $0028,y
	asl a
	adc.w $0026,y
	tax
	lda.b $00,x
	tax
	lda.b $01,x
	and.w #$00FF
	plx
	sta.b $77
	asl a
	inc a
	sta.b $75
.loop4:								; loop: A = SpritePieces+4,x, A and $00FF, A / 2, A / 2, ...
	lda.l SpritePieces+4,x
	and.w #$00FF
	lsr a
	lsr a
	lsr a
	sta.b $79
	lda.l SpritePieces+5,x
	and.w #$00FF
	asl a
	asl a
	asl a
	asl a
	adc.b $79
	adc.b $08
	tay
	sep #$20
	lda.b a4
	sta.w $0000,y
	inc a
	sta.w $0001,y
	inc a
	sta.b a4
	lda.b $75
	sta.w $0080,y
	inc a
	sta.w $0081,y
	inc a
	sta.b $75
	rep #$20
	inx
	inx
	dec.b $77
	bne .loop4
	dec.b QueueBusy
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b a4
	lda.b $08
	clc
	ldx.w #$000A
.loop5:								; loop: push A, A = a4, A + $0080, a4 = A, ...
	pea.w $0018
	pea.w $0000
	pei ($73)
	pea.w $1800
	pea.w $007E
	pha
	lda.b a4
	adc.w #$0080
	sta.b a4
	adc.b $08
	dex
	bpl .loop5
	lda.b $02
	tsx
	tcs
	stx.b $02
	stz.b QueueBusy
	inc.w TransfersReady
	wai
	rts
CODE_C4B653:						; from CODE_C4B36A
	lda.b a4
	beq .1
	ora.b $79
.1:									; $0000,x = A, X + 1, a4 = 0, return
	sta.w $0000,x
	inx
	stz.b a4
	rts
CODE_C4B660:						; from CODE_C4B36A
	lsr a
CODE_C4B661:						; from CODE_C4B36A
	lsr a
CODE_C4B662:						; from CODE_C4B36A
	lsr a
CODE_C4B663:						; from CODE_C4B36A
	lsr a
	tsb.b a4
	rts
CODE_C4B667:						; from CODE_C4B36A
	rol a
CODE_C4B668:						; from CODE_C4B36A
	rol a
CODE_C4B669:						; from CODE_C4B36A
	rol a
CODE_C4B66A:						; from CODE_C4B36A
	rol a
	tsb.b a4
	rts
CODE_C4B66E:						; passed as a long pointer (lda # of its bank and address) to AddTask
	lda.w $0008,x
	cmp.w #$001E
	bcc CODE_C4B688
	lda.w #CODE_C4B689
	sta.w $0002,x
	lda.w #$0014
	jsl.l StartSound
	lda.w #$0011
	bra CODE_C4B6CE
CODE_C4B688:						; a task routine: stored as the next routine of a task
	rtl
CODE_C4B689:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$003C
	bcc CODE_C4B688
	lda.w #CODE_C4B6A3
	sta.w $0002,x
	lda.w #$0013
	jsl.l StartSound
	lda.w #$0010
	bra CODE_C4B6CE
CODE_C4B6A3:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$005A
	bcc CODE_C4B688
	lda.w #CODE_C4B6BD
	sta.w $0002,x
	lda.w #$0016
	jsl.l StartSound
	lda.w #$0009
	bra CODE_C4B6CE
CODE_C4B6BD:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$0096
	bcc CODE_C4B688
	lda.w #CODE_C4B688
	sta.w $0002,x
	lda.w #$0015
CODE_C4B6CE:						; from CODE_C4B66E, CODE_C4B689, CODE_C4B6A3
	jml.l StartSound
CODE_C4B6D2:						; passed as a long pointer (lda # of its bank and address) to AddTask
	lda.w $0008,x
	cmp.w #$0177
	bcc CODE_C4B6EA
	lda.w #$00A4
	jsl.l StartSound
	stz.w $1EA7
	lda.w #CODE_C4B6EA
	sta.w $0002,x
CODE_C4B6EA:						; a task routine: stored as the next routine of a task
	rtl
InitTasks:							; empties the task list: 10 free task slots, the list head and its last
									; task (TaskFrameEnd), the task flags; the done flag is kept as the last
									; one and cleared
	ldx.w #$0000
	lda.w #$2CF7
	clc
.loop:								; loop: $2D6F,x = A, A + $000C, X + 1, X + 1, ...
	sta.w $2D6F,x
	adc.w #$000C
	inx
	inx
	cpx.w #$0014
	bne .loop
	stz.w $2D6F,x
	stz.w $2D83
	lda.w #TaskFrameEnd
	sta.w $2D87
	sta.w $2D93
	lda.w #TaskFrameEnd>>16
	sta.w $2D89
	sta.w $2D95
	stz.w $2D8B
	lda.w #$2D91
	sta.w $2D85
	lda.w #$FFFF
	sta.w $2D97
	stz.w $2D91
	lda.w #$8002
	sta.b $85
	lda.w $2D9D
	sta.w $2D9F
	stz.w $2D9D
	rtl
AddStartKeyTask:					; adds TaskStartKey to the task list (priority $F000)
	lda.w #TaskStartKey
	ldx.w #TaskStartKey>>16
	ldy.w #$F000
	bra AddTask
StartTasks:							; a new task list (InitTasks) with TaskEndCheck, then AddTask X:A, Y; with
									; carry set the sprites are not built each frame
	pha
	phx
	phy
	php
	jsl.l InitTasks
	lda.w #TaskEndCheck
	ldx.w #TaskEndCheck>>16
	ldy.w #$FFFE
	jsl.l AddTask
	plp
	bcc .1
	lda.w #$0002
	trb.b $85
.1:									; pull Y, pull X, pull A
	ply
	plx
	pla
AddTask:							; adds the task routine X:A with priority Y to the task list, before the
									; first task of a higher priority
	phx
	pha
	ldx.w #$2D85
	phy
	tya
.loop:								; loop: if A < $0006,x go to .1, Y = X, if $0000,y is not 0 go to .loop
	cmp.w $0006,x
	bcc .1
	txy
	ldx.w $0000,y
	bne .loop
.1:									; X = $2D83, A = $2D6F,x, X + 1, X + 1, ...
	ldx.w $2D83
	lda.w $2D6F,x
	inx
	inx
	stx.w $2D83
	tax
	pla
	sta.w $0006,x
	stz.w $0008,x
	stz.w $000A,x
	pla
	sta.w $0002,x
	pla
	sta.w $0004,x
	lda.w $0000,y
	sta.w $0000,x
	txa
	sta.w $0000,y
	rtl
RemoveTask:							; takes the running task (d1) out of the task list and frees its slot
	ldy.b d1
	lda.w $0002,y
	ldx.w $0004,y
	sta.b d2
	stx.b $89
	ldx.w #$2D85
.loop:								; loop: if A is not $0002,x go to .1, if $89 = $0004,x go to .2, A = d2
	cmp.w $0002,x
	bne .1
	lda.b $89
	cmp.w $0004,x
	beq .2
	lda.b d2
.1:									; Y = X, if $0000,y is not 0 go to .loop
	txy
	ldx.w $0000,y
	bne .loop
.2:									; $0000,y = $0000,x, A = X, X = $2D83, X - 1, ...
	lda.w $0000,x
	sta.w $0000,y
	txa
	ldx.w $2D83
	dex
	dex
	sta.w $2D6F,x
	stx.w $2D83
	rtl
RunTasks:							; runs each task of the task list once, in order (its frame count + 1),
									; through jmlvector
	ldx.w $2D85
.loop:								; loop: d1 = X, $0008,x + 1, jmlvector+3 = $0004,x, ...
	stx.b d1
	inc.w $0008,x
	lda.w $0004,x
	sta.w jmlvector+3
	lda.w $0002,x
	sta.w jmlvector+1
	jsl.l jmlvector
	ldy.b d1
	ldx.w $0000,y
	bne .loop
	rtl
TaskEndCheck:						; a task: once task flag bit 15 is cleared, fades out and sets the done
									; flag the task loops wait for
	bit.b $85
	bmi .rtl
	jsl.l FadeOutWait
	lda.w $2D9F
	tax
	inc a
	sta.w $2D9D
.rtl:								; return
	rtl
TaskFrameEnd:						; the last task of the list: the sprites to OAM (when task flag bit 1 is
									; set), then waits for the frame
	lda.b $85
	bit.w #$0002
	beq .1
	lda.w #$1D8F
	sta.b $28
	lda.w #$1E00
	sta.b $2A
	jsl.l BuildSpriteOAM
	jsl.l PackOAMHigh
.1:									; TransfersReady + 1, d3 = $F254, return
	inc.w TransfersReady
	wai
	lda.w #$F254
	sta.b d3
	rtl
TaskStartKey:						; a task: start clears task flag bit 15 (so TaskEndCheck ends the list)
									; and sets bit 0
	jsl.l ReadMenuPads
	lda.w repeatdelayframes
	bne .rtl
	lda.w padchangeany
	bit.w #$1000
	beq .rtl
	lda.w #$8000
	trb.b $85
	lda.w #$0001
	tsb.b $85
.rtl:								; return
	rtl
CODE_C4B844:						; no caller found (not traced)
	sta.w $2D9D
	lda.w #$1FFC
	tcs
	rtl
QueueColours16:						; QueueColours with d3 = 16
	pha
	lda.w #$0010
	sta.b d3
	pla
QueueColours:						; queues d3 colours from X:A for CGRAM at Y (a record on the CGRAM
									; transfer stack)
	sta.b $77
	stx.b $79
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	lda.b d3
	asl a
	pha
	phy
	pei ($79)
	pei ($77)
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
	rtl
PackFadeColours:					; writes the colour fade's d3 current colours as BGR words at A (the 8.8
									; values' integer parts)
	tax
	lda.b d3
	jsr.w SetFadeTables
	lda.b d3
	sta.b $77
	ldy.w #$0000
.loop:								; loop: A = (a0),y, A and $00FF, push A, A = ($65),y, ...
	lda.b (a0),y
	xba
	and.w #$00FF
	pha
	lda.b ($65),y
	xba
	and.w #$00FF
	asl a
	asl a
	asl a
	asl a
	asl a
	ora.b $01,s
	sta.b $01,s
	lda.b (a1),y
	and.w #$FF00
	asl a
	asl a
	ora.b $01,s
	sta.b $01,s
	pla
	sta.w $0000,x
	inx
	inx
	iny
	iny
	dec.b $77
	bne .loop
	rtl
StepColourFade:						; one step of the colour fade: the red, green and blue step tables added
									; to the d3 colours' values
	lda.b d3
	jsr.w SetFadeTables
	ldx.b d3
	ldy.w #$0000
.loop:								; loop: A = (a0),y, A + ($69),y, (a0),y = A, A = ($65),y, ...
	lda.b (a0),y
	clc
	adc.b ($69),y
	sta.b (a0),y
	lda.b ($65),y
	clc
	adc.b (a2),y
	sta.b ($65),y
	lda.b (a1),y
	clc
	adc.b ($6D),y
	sta.b (a1),y
	iny
	iny
	dex
	bne .loop
	rtl
StartColourFade:					; sets up a fade of d3 colours from the palette at [a3] to the one at [a4]
									; in $7D steps: each colour's red, green and blue as 8.8 values and a step
									; for each (FadeDelta), in the tables at Y
	sta.b a4
	stx.b $75
	lda.b d3
	jsr.w SetFadeTables
	ldx.b d3
	ldy.w #$0000
.loop:								; loop: A = [a3],y, push A, A and $001F, $77 = A, ...
	lda.b [a3],y
	pha
	and.w #$001F
	sta.b $77
	xba
	sta.b (a0),y
	lda.b $01,s
	and.w #$03E0
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	sta.b $79
	xba
	sta.b ($65),y
	pla
	and.w #$7C00
	xba
	lsr a
	lsr a
	sta.b $7B
	xba
	sta.b (a1),y
	lda.b [a4],y
	pha
	and.w #$001F
	sec
	sbc.b $77
	jsr.w FadeDelta
	sta.b ($69),y
	lda.b $01,s
	and.w #$03E0
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	sec
	sbc.b $79
	jsr.w FadeDelta
	sta.b (a2),y
	pla
	and.w #$7C00
	xba
	lsr a
	lsr a
	sec
	sbc.b $7B
	jsr.w FadeDelta
	sta.b ($6D),y
	iny
	iny
	dex
	bne .loop
	rtl
FadeDelta:							; A = the signed colour difference A * 256 / $7D (the fade's step count)
	phx
	xba
	and.w #$FF00
	php
	bpl .1
	eor.w #$FFFF
	inc a
.1:									; X = $7D, call DivAByX, if plus go to .2, A xor $FFFF, ...
	ldx.b $7D
	jsl.l DivAByX
	plp
	bpl .2
	eor.w #$FFFF
	inc a
.2:									; pull X, return
	plx
	rts
SetFadeTables:						; lays out the colour fade's six tables of A words from Y: red, green,
									; blue, then their steps (a0, $65, a1, $69, a2, $6D)
	asl a
	sta.b $77
	tya
	sta.b a0
	adc.b $77
	sta.b $65
	adc.b $77
	sta.b a1
	adc.b $77
	sta.b $69
	adc.b $77
	sta.b a2
	adc.b $77
	sta.b $6D
	rts
FillWords7E:						; fills d3 words of bank $7E from A with Y
	tax
	tya
	ldy.b d3
.loop:								; loop: $7E0000,x = A, X + 1, X + 1, Y - 1, ...
	sta.l $7E0000,x
	inx
	inx
	dey
	bne .loop
	rtl
DeveloperCredits:					; the developer credits: HIGH SCORE PRODUCTIONS AND / VISUAL CONCEPTS
									; PRESENT (HighScoreMap, VisualConceptsMap), faded in and out by tasks
	jsl.l InitTasks
	jsl.l SetupMode1Screen
	jsl.l ResetPPURegs
	jsl.l BlackBackdrop
	lda.w #$5900
	sta.b tmp0
	stz.b tmp1
	ldx.w #VisualConceptsMap>>16
	lda.w #VisualConceptsMap&$FFFF
	ldy.w #$2000
	jsl.l MapSetToVRAM
	lda.w #$50C0
	sta.b tmp0
	lda.w #$0800
	sta.b tmp1
	ldx.w #HighScoreMap>>16
	lda.w #HighScoreMap&$FFFF
	ldy.w #$0000
	jsl.l MapSetToVRAM
	sep #$20
	lda.b #$02
	sta.l $002130
	sta.l TS
	dec a
	sta.l $002131
	rep #$20
	lda.w #$003C
	sta.b $7D
	lda.b $08
	sta.b d4
	clc
	adc.w #$0040
	sta.b d5
	adc.w #$0180
	sta.b d6
	adc.w #$00C0
	sta.b d7
	adc.w #$0480
	sta.b $08
	jsl.l MarkWorkBuf
	lda.w #$0060
	sta.b d3
	lda.b d6
	ldy.w #$0000
	jsl.l FillWords7E
	lda.w #$CBAE
	sta.b a3
	lda.w #$00C2
	sta.b $71
	lda.b d6
	ldx.w #$007E
	ldy.b d7
	jsl.l StartColourFade
	lda.w #$0020
	sta.b d3
	lda.b d4
	sta.b a3
	ldx.w #$007E
	stx.b $71
	ldy.w #$0000
	jsl.l FillWords7E
	lda.w #(VisualConceptsPalette+$7)&$FFFF
	ldx.w #(VisualConceptsPalette+$7)>>16
	ldy.b d5
	jsl.l StartColourFade
	lda.b d4
	ldx.w #$007E
	ldy.w #$0000
	jsl.l QueueColours
	stz.w fadestep
	stz.w fadestep
	lda.w #CODE_C4BA67
	ldx.w #CODE_C4BA67>>16
	ldy.w #$0001
	sec
	jsl.l StartTasks
	jsl.l AddStartKeyTask
.loop:								; loop: call RunTasks, if $2D9D = 0 go to .loop, $002130 = $0000, ...
	jsl.l RunTasks
	lda.w $2D9D
	beq .loop
	lda.w #$0000
	sta.l $002130
	rtl
CODE_C4BA67:						; passed as a long pointer (lda # of its bank and address) to StartTasks
	lda.w $0008,x
	cmp.w #$00B4
	bne CODE_C4BAD5
	lda.w #CODE_C4BA75
	sta.w $0002,x
CODE_C4BA75:						; a task routine: stored as the next routine of a task
	lda.w #$0060
	sta.b d3
	ldy.b d7
	jsl.l StepColourFade
	lda.b d6
	ldx.w #$007E
	ldy.b d7
	jsl.l PackFadeColours
	lda.b d6
	ldx.w #$007E
	ldy.w #$0020
	jsl.l QueueColours
	lda.w #$0020
	sta.b d3
	ldy.b d5
	jsl.l StepColourFade
	lda.b d4
	ldx.w #$007E
	ldy.b d5
	jsl.l PackFadeColours
	lda.b d4
	ldx.w #$007E
	ldy.w #$0000
	jsl.l QueueColours
	dec.b $7D
	bne CODE_C4BAD5
	ldx.b d1
	stz.w $0008,x
	lda.w #CODE_C4BAC8
	sta.w $0002,x
CODE_C4BAC8:						; a task routine: stored as the next routine of a task
	lda.w $0008,x
	cmp.w #$00B4
	bne CODE_C4BAD5
	lda.w #$8000
	trb.b $85
CODE_C4BAD5:						; from CODE_C4BA67, CODE_C4BA75, CODE_C4BAC8
	rtl
TextPalettes:						; the 4 text palettes, 4 colours each, that InitTextMap queues to CGRAM
									; colour 0
	db $00,$00,$00,$00,$CE,$39,$FF,$7F,$40,$01,$00,$00,$BF,$02,$FF,$03
	db $40,$01,$00,$00,$0A,$14,$1F,$00,$40,$01,$00,$00,$C6,$18,$EF,$3D
InitTextMap:						; a new text map: $800 bytes cleared from the work buffer, the text
									; palettes (TextPalettes) to CGRAM, the margins 0 / $100 and the space
									; width 9
	ldy.w #$0004
	lda.w #$0800
	jsl.l AllocClearWorkBuf
	sta.b $D3
	jsl.l MarkWorkBuf
	lda.w #$2000
	sta.b $D5
	tya
	beq .1
	dec.b QueueBusy
	lda.b $04
	tsx
	tcs
	stx.b $04
	tya
	asl a
	asl a
	asl a
	pha
	pea.w $0000
	pea.w $00C4
	pea.w $BAD6
	lda.b $04
	tsx
	tcs
	stx.b $04
	stz.b QueueBusy
.1:									; $CF = 0, $D1 = $0100, $18DE = $0009, $18DA = $FFFF, ...
	stz.b $CF
	lda.w #$0100
	sta.b $D1
	lda.w #$0009
	sta.w $18DE
	lda.w #$FFFF
	sta.w $18DA
	stz.w $18DC
	rtl
CODE_C4BB43:						; no caller found (not traced)
	tax
	phb
	sep #$20
.loop:								; loop: if $C30000,x = 0 go to .1, $0000,y = A, X + 1, Y + 1, ...
	lda.l $C30000,x
	beq .1
	sta.w $0000,y
	inx
	iny
	bra .loop
.1:									; $0000,y = A, A 16-bit, return
	sta.w $0000,y
	rep #$20
	rtl
PrintTextPage:						; prints the text page whose descriptor is at A in bank $C3: the margins,
									; a title, then texts with their rows and print flags to a zero
	pha
	jsl.l RestoreWorkBuf
	plx
	phx
	lda.l $C30000,x
	sta.b $CF
	lda.l $C30002,x
	sta.b $D1
	lda.l $C30004,x
	beq .1
	pha
	lda.l $C30006,x
	tay
	plx
	jsl.l PrintTitle
.1:									; pull X
	plx
.2:									; if $C30008,x = 0 go to .11, if $C30008,x is not $FFFF go to .3, ...
	lda.l $C30008,x
	beq .11
	cmp.w #$FFFF
	bne .3
	lda.l $C3000A,x
	sta.b $CF
	bra .10
.3:									; push X, push A, A = $C3000A,x, pull X, ...
	phx
	pha
	lda.l $C3000A,x
	plx
	pha
	and.w #$3FFF
	tay
	pla
	bpl .6
	bit.w #$2000
	beq .4
	jsl.l PrintBoldRight
	bra .9
.4:									; if $4000 bits clear go to .5, call PrintBoldCentred, go to .9
	bit.w #$4000
	beq .5
	jsl.l PrintBoldCentred
	bra .9
.5:									; call PrintBoldLeft, go to .9
	jsl.l PrintBoldLeft
	bra .9
.6:									; if $4000 bits clear go to .7, call PrintItalicCentred, go to .9
	bit.w #$4000
	beq .7
	jsl.l PrintItalicCentred
	bra .9
.7:									; if a $2000 bit set go to .8, call PrintItalicLeft, go to .9
	bit.w #$2000
	bne .8
	jsl.l PrintItalicLeft
	bra .9
.8:									; call PrintItalicRight
	jsl.l PrintItalicRight
.9:									; pull X
	plx
.10:								; X + 1, X + 1, X + 1, X + 1, ...
	inx
	inx
	inx
	inx
	bra .2
.11:								; call SendTextMap, go to RestoreWorkBuf
	jsl.l SendTextMap
	jmp.w RestoreWorkBuf
PrintBoldCentred:					; prints the packed text X at row Y in BoldFontGlyphs, centred between the
									; margins
	jsl.l RenderBoldCentred
	bra UploadAndMapText
CODE_C4BBEB:						; no caller found (not traced)
	jsl.l RenderBoldCentred
	bra UploadAndMapText
PrintBoldCentredStr:				; PrintBoldCentred for the string X in RAM (CopyString)
	jsl.l RenderBoldCentredStr
UploadAndMapText:					; queue rendered text tiles and map them onto the screen
	jsl.l QueueTextTiles
	jmp.w MapTextTiles
PrintBoldLeft:						; prints the packed text X at row Y in BoldFontGlyphs from the left margin
	jsl.l RenderBoldLeft
	bra UploadAndMapText
PrintBoldLeftROMStr:				; print a left-aligned ROM string in the bold font
	jsl.l RenderBoldLeftROMStr
	bra UploadAndMapText
PrintBoldLeftStr:					; PrintBoldLeft for the string X in RAM
	jsl.l RenderBoldLeftStr
	bra UploadAndMapText
PrintBoldRight:						; prints the packed text X at row Y in BoldFontGlyphs, ending at the right
									; margin
	jsl.l RenderBoldRight
	bra UploadAndMapText
PrintBoldRightROMStr:				; print a right-aligned ROM string in the bold font
	jsl.l RenderBoldRightROMStr
	bra UploadAndMapTextJump
PrintBoldRightStr:					; PrintBoldRight for the string X in RAM
	jsl.l RenderBoldRightStr
	bra UploadAndMapText
PrintItalicRightStr:				; PrintItalicRight for the string X in RAM
	jsl.l RenderItalicRightStr
	bra UploadAndMapText
PrintItalicLeft:					; prints the packed text X at row Y in ItalicFontGlyphs from the left
									; margin
	jsl.l RenderItalicLeft
	bra UploadAndMapText
PrintItalicFixedLeft:				; print packed italic text from the left margin with glyph width A
	sta.b p0
	jsl.l UnpackText
DrawItalicFixedLeft:				; draw and upload italic text with the supplied fixed glyph width
	lda.w #$4003
	sta.b $0E
	lda.w #ItalicFontGlyphs&$FFFF
	sta.b $0C
	phy
	lda.b $CF
	jsl.l DrawText
	ply
UploadAndMapTextJump:				; continue to queue and map the rendered text
	bra UploadAndMapText
PrintItalicFixedLeftStr:			; print a RAM string in italic with glyph width A
	sta.b p0
	jsl.l CopyString
	bra DrawItalicFixedLeft
PrintBoldFixedLeft:					; print packed bold text from the left margin with glyph width A
	sta.b p0
	jsl.l UnpackText
DrawBoldFixedLeft:					; draw and upload bold text with the supplied fixed glyph width
	lda.w #$4000
	sta.b $0E
	lda.w #BoldFontGlyphs&$FFFF
	sta.b $0C
	phy
	lda.b $CF
	jsl.l DrawText
	ply
	bra UploadAndMapTextJump
PrintBoldFixedLeftStr:				; print a RAM string in bold with glyph width A
	sta.b p0
	jsl.l CopyString
	bra DrawBoldFixedLeft
CopyString:							; copies the zero ended string at X (bank $7E) into a new work buffer;
									; returns X = the copy
	phy
	phx
	ldy.w #$0001
	sep #$20
.loop:								; loop: if $7E0000,x = 0 go to .1, X + 1, Y + 1, go to .loop
	lda.l $7E0000,x
	beq .1
	inx
	iny
	bra .loop
.1:									; A 16-bit, A = Y, push A, call AllocWorkBuf, ...
	rep #$20
	tya
	pha
	jsl.l AllocWorkBuf
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
PrintItalicLeftROMStr:				; print a left-aligned ROM string in the italic font
	jsl.l RenderItalicLeftROMStr
	bra UploadAndMapTextJump
PrintItalicLeftStr:					; PrintItalicLeft for the string X in RAM
	jsl.l RenderItalicLeftStr
	bra UploadAndMapTextJump
PrintItalicCentred:					; prints the packed text X at row Y in ItalicFontGlyphs, centred between
									; the margins
	jsl.l RenderItalicCentred
	bra UploadAndMapTextJump
PrintThinCentred:					; prints the packed text X at row Y in ThinFontGlyphs, centred between the
									; margins
	jsl.l RenderThinCentred
	bra UploadAndMapTextJump
PrintItalicCentredStr:				; PrintItalicCentred for the string X in RAM
	jsl.l RenderItalicCentredStr
	bra UploadAndMapTextJump
PrintItalicCentredROMStr:			; print a centred ROM string in the italic font
	jsl.l RenderItalicCentredROMStr
	bra UploadAndMapTextJump
PrintItalicRight:					; prints the packed text X at row Y in ItalicFontGlyphs, ending at the
									; right margin
	jsl.l RenderItalicRight
	bra UploadAndMapTextJump
RenderBoldCentred:					; render centred packed text in the bold font
	jsl.l UnpackText
	bra DrawBoldCentredBuffer
RenderBoldCentredStr:				; render a centred RAM string in the bold font
	jsl.l CopyString
	bra DrawBoldCentredBuffer
RenderBoldCentredROMStr:			; render a centred ROM string in the bold font
	jsl.l CopyROMString
DrawBoldCentredBuffer:				; draw the prepared text buffer centred in the bold font
	stz.b $0E
	lda.w #BoldFontGlyphs&$FFFF
	sta.b $0C
	phy
	jsl.l CentreText
	jsl.l DrawText
	ply
	rtl
RenderBoldLeft:						; render left-aligned packed text in the bold font
	jsl.l UnpackText
	bra DrawBoldLeftBuffer
RenderBoldLeftStr:					; render a left-aligned RAM string in the bold font
	jsl.l CopyString
	bra DrawBoldLeftBuffer
RenderBoldLeftROMStr:				; render a left-aligned ROM string in the bold font
	jsl.l CopyROMString
DrawBoldLeftBuffer:					; draw the prepared text buffer from the left margin in the bold font
	stz.b $0E
	lda.w #BoldFontGlyphs&$FFFF
	sta.b $0C
	phy
	lda.b $CF
	jsl.l DrawText
	ply
	rtl
RenderBoldRight:					; render right-aligned packed text in the bold font
	jsl.l UnpackText
	bra DrawBoldRightBuffer
RenderBoldRightStr:					; render a right-aligned RAM string in the bold font
	jsl.l CopyString
	bra DrawBoldRightBuffer
RenderBoldRightROMStr:				; render a right-aligned ROM string in the bold font
	jsl.l CopyROMString
DrawBoldRightBuffer:				; draw the prepared text buffer ending at the right margin in the bold
									; font
	stz.b $0E
	lda.w #BoldFontGlyphs&$FFFF
	sta.b $0C
	phy
	jsl.l TextWidth
	sec
	lda.b $D1
	sbc.b $0A
	jsl.l DrawText
	ply
	rtl
RenderItalicLeft:					; render left-aligned packed text in the italic font
	jsl.l UnpackText
	bra DrawItalicLeftBuffer
RenderItalicLeftStr:				; render a left-aligned RAM string in the italic font
	jsl.l CopyString
	bra DrawItalicLeftBuffer
RenderItalicLeftROMStr:				; render a left-aligned ROM string in the italic font
	jsl.l CopyROMString
DrawItalicLeftBuffer:				; draw the prepared text buffer from the left margin in the italic font
	lda.w #$0003
	sta.b $0E
	lda.w #ItalicFontGlyphs&$FFFF
	sta.b $0C
	phy
	lda.b $CF
	jsl.l DrawText
	ply
	rtl
RenderThinCentred:					; render centred packed text in the thin font
	jsl.l UnpackText
	lda.w #$0005
	sta.b $0E
	lda.w #ThinFontGlyphs&$FFFF
	sta.b $0C
	phy
	jsl.l CentreText
	jsl.l DrawText
	ply
	rtl
RenderItalicCentred:				; unpack and render centred text in the italic font
	jsl.l UnpackText
RenderItalicCentredStr:				; render a centred RAM string in the italic font
	jsl.l CopyString
	bra DrawItalicCentredBuffer
RenderItalicCentredROMStr:			; render a centred ROM string in the italic font
	jsl.l CopyROMString
DrawItalicCentredBuffer:			; draw the prepared text buffer centred in the italic font
	lda.w #$0003
	sta.b $0E
	lda.w #ItalicFontGlyphs&$FFFF
	sta.b $0C
	phy
	jsl.l CentreText
	jsl.l DrawText
	ply
	rtl
RenderItalicRightStr:				; render a right-aligned RAM string in the italic font
	jsl.l CopyString
	bra DrawItalicRightBuffer
RenderItalicRight:					; render right-aligned packed text in the italic font
	jsl.l UnpackText
DrawItalicRightBuffer:				; draw the prepared text buffer ending at the right margin in the italic
									; font
	lda.w #$0003
	sta.b $0E
	lda.w #ItalicFontGlyphs&$FFFF
	sta.b $0C
	phy
	jsl.l TextWidth
	sec
	lda.b $D1
	sbc.b $0A
	jsl.l DrawText
	ply
	rtl
PrintTitle:							; prints the packed text X at row Y as a title: PrintItalicLeft with the
									; map bits $2400, then PrintTitleBar under it (map bits $2800)
	pei ($D5)
	lda.w #$2400
	sta.b $D5
	phy
	jsl.l PrintItalicLeft
	ply
	iny
	iny
	ldx.w #$2800
	stx.b $D5
	jsl.l PrintTitleBar
	pla
	sta.b $D5
	rtl
PrintTitleStr:						; PrintTitle for the string X in RAM
	pei ($D5)
	lda.w #$2400
	sta.b $D5
	phy
	jsl.l PrintItalicLeftStr
	ply
	iny
	iny
	ldx.w #$2800
	stx.b $D5
	jsl.l PrintTitleBar
	pla
	sta.b $D5
	rtl
PrintTitleBar:						; prints a bar at row Y as wide as A says: its left end, middle pieces,
									; its right end (BoldFontGlyphs characters $5B, $5C, $5D)
	phy
	dec a
	dec a
	dec a
	ldx.w #$0003
	jsl.l DivAByX
	txy
	beq .1
	inc a
.1:									; Y = A, A + 1, A + 1, A + 1, ...
	tay
	inc a
	inc a
	inc a
	jsl.l AllocWorkBuf
	pha
	tax
	sep #$20
	lda.b #$5B
	jsr.w AppendTitleBarByte
	inc a
.loop:								; loop: call AppendTitleBarByte, Y - 1, if the result is not 0 go to
									; .loop, ...
	jsr.w AppendTitleBarByte
	dey
	bne .loop
	inc a
	jsr.w AppendTitleBarByte
	lda.b #$00
	jsr.w AppendTitleBarByte
	rep #$20
	stz.b $0E
	lda.w #BoldFontGlyphs&$FFFF
	sta.b $0C
	lda.b $12
	plx
	jsl.l DrawText
	ply
	jsl.l QueueTextTiles
	jmp.w MapTextTiles
AppendTitleBarByte:					; append one byte to the title bar string
	sta.l $7E0000,x
	inx
	rts
DrawText:							; draws the text at X (zero ended) from pixel column A into new work
									; buffer tiles, in the font of $0C (bank $C0) with the flags of $0E
	sta.b $12
	sta.b $0A
	cmp.w $18DA
	bcs .1
	sta.w $18DA
.1:									; Y = $0400, A = $0E, A / 2, if carry set go to .2, ...
	ldy.w #$0400
	lda.b $0E
	lsr a
	bcs .2
	ldy.w #$0200
.2:									; A = Y, call AllocClearWorkBuf, $A5 = A, push X
	tya
	jsl.l AllocClearWorkBuf
	sta.b $A5
	phx
DrawNextTextCharacter:				; read the next character and prepare its glyph for drawing
	ply
	lda.w $0000,y
	and.w #$00FF
	bne .1
	jmp.w FinishTextDraw
.1:									; Y + 1, push Y, if A is not $0020 go to .3, A = $0E, ...
	iny
	phy
	cmp.w #$0020
	bne .3
	lda.b $0E
	bit.w #$0004
	beq .2
	lda.w #$0004
	jmp.w AdvanceTextCursor
.2:									; A = $18DE, go to AdvanceTextCursor
	lda.w $18DE
	jmp.w AdvanceTextCursor
.3:									; A - $0030, X = A, if A < $0031 go to .4, A - $0020, ...
	sec
	sbc.w #$0030
	tax
	cmp.w #$0031
	bcc .4
	sbc.w #$0020
	tax
	lda.b $0E
	bit.w #$0002
	beq .4
	txa
	adc.w #$002A
	tax
	lda.l $C4C48B,x
	bra .7
.4:									; A = $0E, if $0004 bits clear go to .5, A = DATA8_C4C4D7,x, go to .7
	lda.b $0E
	bit.w #$0004
	beq .5
	lda.l DATA8_C4C4D7,x
	bra .7
.5:									; if a $0001 bit set go to .6, A = DATA8_C4C502,x, go to .7
	bit.w #$0001
	bne .6
	lda.l DATA8_C4C502,x
	bra .7
.6:									; A = DATA8_C4C4B6,x
	lda.l DATA8_C4C4B6,x
.7:									; A and $00FF, if overflow clear go to .8, A = p0
	and.w #$00FF
	bit.b $0E
	bvc .8
	lda.b p0
.8:									; p0 = A, A = X, A / 2, A / 2, ...
	sta.b p0
	txa
	xba
	lsr a
	lsr a
	sta.b $10
	lda.b $0E
	lsr a
	bcs .9
	lsr.b $10
	bit.b $0E
	bvs .11
.9:									; A = $0080, if not zero go to .10, A = $0A, A - 1, ...
	lda.w #$0080
	trb.b p0
	bne .10
	lda.b $0A
	dec a
	dec a
	bmi .11
	cmp.b $12
	bcc .11
	sta.b $0A
	jsr.w CheckGlyphLeftOverlap
	bcc .11
	inc.b $0A
	jsr.w CheckGlyphLeftOverlap
	bcc .11
	inc.b $0A
	bra .11
.10:								; if p0 is not $007F go to .11, A = $18DE, go to AdvanceTextCursor
	lda.b p0
	cmp.w #$007F
	bne .11
	lda.w $18DE
	jmp.w AdvanceTextCursor
.11:								; A = $8000, A = $10, A + $0C, X = A, ...
	lda.w #$8000
	trb.b $0E
	lda.b $10
	clc
	adc.b $0C
	tax
	adc.w #$0010
	sta.b $3A
	lda.b $0A
	and.w #$FFF8
	asl a
	adc.b $A5
	tay
DrawGlyphRow:						; load a glyph row and dispatch by its destination pixel column
	phx
	phy
	sep #$20
	lda.l $C00000,x
	sta.b $17
	lda.l $C00010,x
	sta.b $16
	lda.l $C00001,x
	sta.b $15
	lda.l $C00011,x
	sta.b $14
	rep #$20
	lda.b $0A
	and.w #$0007
	asl a
	tax
	lda.l DATA8_C4C07D,x
	pha
	ldx.b p0
	rts

; Segment bankC4_F000: game code (routines keep their address as a name, with their callers), then sound
; sample 2 and zeros to the end of the bank.
org $C4F01E
BuildTeamLines:						; builds the line data of roster table Y from its players: each player's
									; value (RecordOverallLong), then the line slots filled position by
									; position
	sty.b tmp0
	stz.w $24DC
	lda.w $0000,y
	sta.b tmp1
.loop:								; loop: if zero go to .1, A - 1, tmp1 = A, A * 2, ...
	beq .1
	dec a
	sta.b tmp1
	asl a
	tay
	asl a
	asl a
	asl a
	asl a
	adc.b tmp0
	tax
	lda.w $0110,x
	sta.w mesarea
	lda.w $0112,x
	sta.w mesarea+2
	lda.w $0114,x
	sta.w mesarea+4
	lda.w $0116,x
	sta.w mesarea+6
	jsl.l RecordOverallLong
	sta.w $364E,y
	lda.b tmp1
	sta.w $368E,y
	bra .loop
.1:									; $36CE = $FFFF, X = $36CE, Y = $36D0, A = $00FD, ...
	lda.w #$FFFF
	sta.w $36CE
	ldx.w #$36CE
	ldy.w #$36D0
	lda.w #$00FD
	mvn $7E,$7E
	ldy.b tmp0
	clc
	lda.w $0002,y
	adc.w $0004,y
	dec a
	asl a
	tax
	lda.w $0004,y
	sta.b tmp1
	sta.b $A5
.loop2:								; loop: call InsertRankedLineForward, X - 1, X - 1, tmp1 - 1, ...
	jsr.w InsertRankedLineForward
	dex
	dex
	dec.b tmp1
	bne .loop2
	ldy.b tmp0
	lda.w $0000,y
	dec a
	asl a
	tax
	lda.w $0006,y
	sta.b tmp1
	sta.b $0A
.loop3:								; loop: call InsertRankedLineDefenceman, X - 1, X - 1, tmp1 - 1, ...
	jsr.w InsertRankedLineDefenceman
	dex
	dex
	dec.b tmp1
	bne .loop3
	lda.w #$0001
	sta.w $37CE
	lda.w $374E
	sta.w $37CF
	lda.w $3750
	sta.w $37D0
	lda.w $36D0
	sta.w $37D1
	lda.w $36CE
	sta.w $37D2
	lda.w $36D2
	sta.w $37D3
	lda.w $36D4
	sta.w $37D4
	stz.w $37D5
	lda.w #$0007
	ldx.w #$37CE
	ldy.w #$37D6
	mvn $7E,$7E
	stz.b r0
	stz.b $2E
	lda.w #$0005
	sta.b tmp1
	ldx.w #$37D6
	stx.b $14
	lda.w $0000,x
	and.w #$00FF
	jsr.w MarkLineDefencemanUsed
	lda.w $0001,x
	and.w #$00FF
	jsr.w MarkLineDefencemanUsed
	lda.w $0002,x
	and.w #$00FF
	jsr.w MarkLineForwardUsed
	lda.w $0003,x
	and.w #$00FF
	jsr.w MarkLineForwardUsed
	lda.w $0004,x
	and.w #$00FF
	jsr.w MarkLineForwardUsed
	lda.w $0005,x
	and.w #$00FF
	jsr.w MarkLineForwardUsed
.loop4:								; loop: A = $14, A + $0008, X = A, $14 = X
	lda.b $14
	clc
	adc.w #$0008
	tax
	stx.b $14
.loop5:								; loop: tmp2 = 0, A 8-bit, call PickUnusedLineDefenceman, ...
	stz.b tmp2
	sep #$20
	jsr.w PickUnusedLineDefenceman
	bcs .loop5
	sta.w $0001,x
	jsr.w MarkLineDefencemanUsed
	stz.b tmp2
	jsr.w PickUnusedLineDefenceman
	bcs .loop5
	sta.w $0002,x
	jsr.w MarkLineDefencemanUsed
	stz.b tmp2
	jsr.w PickUnusedLineForward
	bcs .loop5
	sta.w $0003,x
	jsr.w MarkLineForwardUsed
	stz.b tmp2
	jsr.w PickUnusedLineForward
	bcs .loop5
	sta.w $0004,x
	jsr.w MarkLineForwardUsed
	stz.b tmp2
	jsr.w PickUnusedLineForward
	bcs .loop5
	sta.w $0005,x
	jsr.w MarkLineForwardUsed
	stz.b tmp2
	jsr.w PickUnusedLineForward
	bcs .loop5
	sta.w $0006,x
	jsr.w MarkLineForwardUsed
	rep #$20
	lda.b $14
	dec.b tmp1
	bpl .loop4
	clc
	lda.b tmp0
	adc.w #$006C
	tay
	ldx.w #$37CE
	lda.w #$003F
	mvn $7E,$7E
	rts
NoLineDefenceman:					; PickUnusedLineDefenceman's end of list: the used count ($2E) back to 0,
									; X restored, carry set
	stz.b $2E
	ldx.b $14
	sec
	rts
PickUnusedLineDefenceman:			; selects the next ranked defenceman not in the used list; carry set when
									; the pool is exhausted
	rep #$20
	lda.b tmp2
	cmp.b $0A
	beq NoLineDefenceman
	asl a
	tay
	sep #$20
	lda.w $374E,y
	jsr.w IsLineDefencemanUsed
	bcs PickUnusedLineDefenceman
	ldx.b $14
	rts
NoLineForward:						; PickUnusedLineForward's end of list: the used count (r0) back to 0, X
									; restored, carry set
	stz.b r0
	ldx.b $14
	sec
	rts
PickUnusedLineForward:				; selects the next ranked forward not in the used list; carry set when the
									; pool is exhausted
	rep #$20
	lda.b tmp2
	cmp.b $A5
	beq NoLineForward
	asl a
	tay
	sep #$20
	lda.w $36CE,y
	jsr.w IsLineForwardUsed
	bcs PickUnusedLineForward
	ldx.b $14
	rts
IsLineDefencemanUsed:				; advances the candidate index and returns carry set if the defenceman is
									; already used
	inc.b tmp2
	ldx.b $2E
	dex
	bmi LinePlayerNotUsed
.loop:								; loop: if A = $384E,x go to LinePlayerUsed, X - 1, ...
	cmp.w $384E,x
	beq LinePlayerUsed
	dex
	bpl .loop
LinePlayerNotUsed:					; carry clear: the player is not in the used list (IsLineDefencemanUsed /
									; IsLineForwardUsed)
	clc
	rts
LinePlayerUsed:						; carry set: the player is in the used list (IsLineDefencemanUsed /
									; IsLineForwardUsed)
	sec
	rts
IsLineForwardUsed:					; advances the candidate index and returns carry set if the forward is
									; already used
	inc.b tmp2
	ldx.b r0
	dex
	bmi LinePlayerNotUsed
.loop:								; loop: if A = $380E,x go to LinePlayerUsed, X - 1, ...
	cmp.w $380E,x
	beq LinePlayerUsed
	dex
	bpl .loop
	clc
	rts
MarkLineForwardUsed:				; appends the forward index to the used list and increments its count
	ldy.b r0
	sta.w $380E,y
	iny
	sty.b r0
	rts
MarkLineDefencemanUsed:				; appends the defenceman index to the used list and increments its count
	ldy.b $2E
	sta.w $384E,y
	iny
	sty.b $2E
	rts
InsertRankedLineForward:			; inserts a forward and his overall rating into the descending line
									; selection lists
	ldy.w #$0000
.loop:								; loop: if $370E,y < 0 go to .2, if $370E,y < $364E,x go to .1, Y + 1, ...
	lda.w $370E,y
	bmi .2
	cmp.w $364E,x
	bcc .1
	iny
	iny
	bra .loop
.1:									; push Y, push X, tmp2 = Y, A = $001D, ...
	phy
	phx
	sty.b tmp2
	sec
	lda.w #$001D
	sbc.b tmp2
	pha
	ldx.w #$372A
	ldy.w #$372C
	mvp $7E,$7E
	pla
	ldx.w #$36EA
	ldy.w #$36EC
	mvp $7E,$7E
	plx
	ply
.2:									; $370E,y = $364E,x, A = $368E,x, A + 1, $36CE,y = A, ...
	lda.w $364E,x
	sta.w $370E,y
	lda.w $368E,x
	inc a
	sta.w $36CE,y
	rts
InsertRankedLineDefenceman:			; inserts a defenceman and his overall rating into the descending line
									; selection lists
	ldy.w #$0000
.loop:								; loop: if $378E,y < 0 go to .2, if $378E,y < $364E,x go to .1, Y + 1, ...
	lda.w $378E,y
	bmi .2
	cmp.w $364E,x
	bcc .1
	iny
	iny
	bra .loop
.1:									; push Y, push X, tmp2 = Y, A = $001D, ...
	phy
	phx
	sty.b tmp2
	sec
	lda.w #$001D
	sbc.b tmp2
	pha
	ldx.w #$37AA
	ldy.w #$37AC
	mvp $7E,$7E
	pla
	ldx.w #$376A
	ldy.w #$376C
	mvp $7E,$7E
	plx
	ply
.2:									; $378E,y = $364E,x, A = $368E,x, A + 1, $374E,y = A, ...
	lda.w $364E,x
	sta.w $378E,y
	lda.w $368E,x
	inc a
	sta.w $374E,y
	rts
RosterDiffers:						; carry set when the roster table at Y differs from the one at X (a count
									; at +0 / +2 / +4 or a player index at +$3A)
	lda.w $0002,x
	cmp.w $0002,y
	bne .1
	lda.w $0004,x
	cmp.w $0004,y
	bne .1
	lda.w $0000,x
	cmp.w $0000,y
	bne .1
	dec a
	sta.b tmp0
.loop:								; loop: if $003A,x is not $003A,y go to .1, X + 1, X + 1, Y + 1, ...
	lda.w $003A,x
	cmp.w $003A,y
	bne .1
	inx
	inx
	iny
	iny
	dec.b tmp0
	bpl .loop
	clc
	rts
.1:									; return
	sec
	rts
RebuildChangedLines:				; for both teams of the game (HomeTeam into $2DC9, VisTeam into $3207), in
									; play mode 2 or 3, or 0 / 1 with OptRosters set: BuildTeamLines when its
									; roster differs from the cartridge one
	lda.w OptPlayMode
	cmp.w #$0002
	bcc .3
.1:									; A = HomeTeam, Y = $364E, call LoadDefaultRoster, Y = HomeRoster, ...
	lda.w HomeTeam
	ldy.w #$364E
	jsl.l LoadDefaultRoster
	ldy.w #HomeRoster
	ldx.w #$364E
	jsr.w RosterDiffers
	bcc .2
	ldy.w #HomeRoster
	jsr.w BuildTeamLines
.2:									; A = VisTeam, Y = $364E, call LoadDefaultRoster, Y = VisRoster, ...
	lda.w VisTeam
	ldy.w #$364E
	jsl.l LoadDefaultRoster
	ldy.w #VisRoster
	ldx.w #$364E
	jsr.w RosterDiffers
	bcc .rts
	ldy.w #VisRoster
	jsr.w BuildTeamLines
	bra .rts
.3:									; if OptPlayMode = 0 go to .4, A - 1, if the result is not 0 go to .rts
	lda.w OptPlayMode
	beq .4
	dec a
	bne .rts
.4:									; if OptRosters is not 0 go to .1
	lda.w OptRosters
	bne .1
.rts:								; return
	rts
Sample02:							; sound sample 2 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC4_F000.bin":$2FC..$A58
	padbyte $00						; unused to the end of the bank
	pad $C50000

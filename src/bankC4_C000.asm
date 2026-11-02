; Segment bankC4_C000: game code (not traced to a job yet: the routines keep their address as a name, with
; their callers), jump tables and the data tables the code reads with long addresses.
org $C4BF47
DrawGlyphPixel0:					; draw the next glyph pixel at column zero of the tile
	asl.b $16
	bcc .1
	lda.w $0000,y
	ora.w #$0080
	sta.w $0000,y
.1:									; $14 * 2, if carry clear go to .2, A = $0001,y, A or $0080, ...
	asl.b $14
	bcc .2
	lda.w $0001,y
	ora.w #$0080
	sta.w $0001,y
.2:									; X - 1, if the result is not 0 go to DrawGlyphPixel1
	dex
	bne DrawGlyphPixel1
DrawGlyphRowDoneJump:				; continue after finishing the glyph row
	jmp.w DrawGlyphNextRow
DrawGlyphPixel1:					; draw the next glyph pixel at column one of the tile
	asl.b $16
	bcc .1
	lda.w $0000,y
	ora.w #$0040
	sta.w $0000,y
.1:									; $14 * 2, if carry clear go to .2, A = $0001,y, A or $0040, ...
	asl.b $14
	bcc .2
	lda.w $0001,y
	ora.w #$0040
	sta.w $0001,y
.2:									; X - 1, if the result = 0 go to DrawGlyphRowDoneJump
	dex
	beq DrawGlyphRowDoneJump
DrawGlyphPixel2:					; draw the next glyph pixel at column two of the tile
	asl.b $16
	bcc .1
	lda.w $0000,y
	ora.w #$0020
	sta.w $0000,y
.1:									; $14 * 2, if carry clear go to .2, A = $0001,y, A or $0020, ...
	asl.b $14
	bcc .2
	lda.w $0001,y
	ora.w #$0020
	sta.w $0001,y
.2:									; X - 1, if the result = 0 go to DrawGlyphRowDoneJump
	dex
	beq DrawGlyphRowDoneJump
DrawGlyphPixel3:					; draw the next glyph pixel at column three of the tile
	asl.b $16
	bcc .1
	lda.w $0000,y
	ora.w #$0010
	sta.w $0000,y
.1:									; $14 * 2, if carry clear go to .2, A = $0001,y, A or $0010, ...
	asl.b $14
	bcc .2
	lda.w $0001,y
	ora.w #$0010
	sta.w $0001,y
.2:									; X - 1, if the result = 0 go to DrawGlyphRowDoneJump
	dex
	beq DrawGlyphRowDoneJump
DrawGlyphPixel4:					; draw the next glyph pixel at column four of the tile
	asl.b $16
	bcc .1
	lda.w $0000,y
	ora.w #$0008
	sta.w $0000,y
.1:									; $14 * 2, if carry clear go to .2, A = $0001,y, A or $0008, ...
	asl.b $14
	bcc .2
	lda.w $0001,y
	ora.w #$0008
	sta.w $0001,y
.2:									; X - 1, if the result = 0 go to DrawGlyphNextRow
	dex
	beq DrawGlyphNextRow
DrawGlyphPixel5:					; draw the next glyph pixel at column five of the tile
	asl.b $16
	bcc .1
	lda.w $0000,y
	ora.w #$0004
	sta.w $0000,y
.1:									; $14 * 2, if carry clear go to .2, A = $0001,y, A or $0004, ...
	asl.b $14
	bcc .2
	lda.w $0001,y
	ora.w #$0004
	sta.w $0001,y
.2:									; X - 1, if the result = 0 go to DrawGlyphNextRow
	dex
	beq DrawGlyphNextRow
DrawGlyphPixel6:					; draw the next glyph pixel at column six of the tile
	asl.b $16
	bcc .1
	lda.w $0000,y
	ora.w #$0002
	sta.w $0000,y
.1:									; $14 * 2, if carry clear go to .2, A = $0001,y, A or $0002, ...
	asl.b $14
	bcc .2
	lda.w $0001,y
	ora.w #$0002
	sta.w $0001,y
.2:									; X - 1, if the result = 0 go to DrawGlyphNextRow
	dex
	beq DrawGlyphNextRow
DrawGlyphPixel7:					; draw the last pixel column and continue into the next tile when needed
	asl.b $16
	bcc .1
	lda.w $0000,y
	ora.w #$0001
	sta.w $0000,y
.1:									; $14 * 2, if carry clear go to .2, A = $0001,y, A or $0001, ...
	asl.b $14
	bcc .2
	lda.w $0001,y
	ora.w #$0001
	sta.w $0001,y
.2:									; X - 1, if the result = 0 go to DrawGlyphNextRow, A = Y, A + $0010, ...
	dex
	beq DrawGlyphNextRow
	tya
	clc
	adc.w #$0010
	tay
	jmp.w DrawGlyphPixel0
DrawGlyphNextRow:					; advance to the next glyph row or finish the character
	ply
	iny
	iny
	plx
	inx
	inx
	cpx.b $3A
	bcs .1
	jmp.w DrawGlyphRow
.1:									; A = $0E, A / 2, if carry clear go to .2, A = X, ...
	lda.b $0E
	lsr a
	bcc .2
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
	bne .2
	jmp.w DrawGlyphRow
.2:									; A = p0
	lda.b p0
AdvanceTextCursor:					; advance the text pixel cursor by A and read the next character
	clc
	adc.b $0A
	sta.b $0A
	jmp.w DrawNextTextCharacter
FinishTextDraw:						; record the rightmost text extent and return
	lda.b $0A
	cmp.l $0018DC
	bcc .rtl
	sta.l $0018DC
.rtl:								; return
	rtl
DATA8_C4C07D:						; the 8 routines DrawGlyphRow runs (address - 1: pushed, then rts)
	dw DrawGlyphPixel0-1,DrawGlyphPixel1-1,DrawGlyphPixel2-1,DrawGlyphPixel3-1
	dw DrawGlyphPixel4-1,DrawGlyphPixel5-1,DrawGlyphPixel6-1,DrawGlyphPixel7-1
CheckGlyphLeftOverlap:				; test whether the glyph leading column overlaps existing text pixels
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
	bcc .1
	lda.w $0000,y
	ora.w $0001,y
	bit.b $36
	bne .7
.1:									; A = $C00002,x, A or $C00003,x, A * 2, if carry clear go to .2, ...
	lda.l $C00002,x
	ora.l $C00003,x
	asl a
	bcc .2
	lda.w $0002,y
	ora.w $0003,y
	bit.b $36
	bne .7
.2:									; A = $C00004,x, A or $C00005,x, A * 2, if carry clear go to .3, ...
	lda.l $C00004,x
	ora.l $C00005,x
	asl a
	bcc .3
	lda.w $0004,y
	ora.w $0005,y
	bit.b $36
	bne .7
.3:									; A = $C00006,x, A or $C00007,x, A * 2, if carry clear go to .4, ...
	lda.l $C00006,x
	ora.l $C00007,x
	asl a
	bcc .4
	lda.w $0006,y
	ora.w $0007,y
	bit.b $36
	bne .7
.4:									; A = $C00008,x, A or $C00009,x, A * 2, if carry clear go to .5, ...
	lda.l $C00008,x
	ora.l $C00009,x
	asl a
	bcc .5
	lda.w $0008,y
	ora.w $0009,y
	bit.b $36
	bne .7
.5:									; A = $C0000A,x, A or $C0000B,x, A * 2, if carry clear go to .6, ...
	lda.l $C0000A,x
	ora.l $C0000B,x
	asl a
	bcc .6
	lda.w $000A,y
	ora.w $000B,y
	bit.b $36
	bne .7
.6:									; A = $C0000C,x, A or $C0000D,x, A * 2, if carry clear go to .8, ...
	lda.l $C0000C,x
	ora.l $C0000D,x
	asl a
	bcc .8
	lda.w $000C,y
	ora.w $000D,y
	bit.b $36
	beq .8
.7:									; A 16-bit, return
	rep #$20
	rts
.8:									; A = $C0000E,x, A or $C0000F,x, A * 2, if carry clear go to .9, ...
	lda.l $C0000E,x
	ora.l $C0000F,x
	asl a
	bcc .9
	lda.w $000E,y
	ora.w $000F,y
	bit.b $36
	bne .7
.9:									; A = $0E, A / 2, if carry set go to .10, A 16-bit, ...
	lda.b $0E
	lsr a
	bcs .10
	rep #$20
	rts
.10:								; A = $C00020,x, A or $C00021,x, A * 2, if carry clear go to .11, ...
	lda.l $C00020,x
	ora.l $C00021,x
	asl a
	bcc .11
	lda.w $0200,y
	ora.w $0201,y
	bit.b $36
	bne .7
.11:								; A = $C00022,x, A or $C00023,x, A * 2, if carry clear go to .12, ...
	lda.l $C00022,x
	ora.l $C00023,x
	asl a
	bcc .12
	lda.w $0202,y
	ora.w $0203,y
	bit.b $36
	bne .7
.12:								; A = $C00024,x, A or $C00025,x, A * 2, if carry clear go to .13, ...
	lda.l $C00024,x
	ora.l $C00025,x
	asl a
	bcc .13
	lda.w $0204,y
	ora.w $0205,y
	bit.b $36
	bne .7
.13:								; A = $C00026,x, A or $C00027,x, A * 2, if carry clear go to .14, ...
	lda.l $C00026,x
	ora.l $C00027,x
	asl a
	bcc .14
	lda.w $0206,y
	ora.w $0207,y
	bit.b $36
	bne .7
.14:								; A = $C00028,x, A or $C00029,x, A * 2, if carry clear go to .15, ...
	lda.l $C00028,x
	ora.l $C00029,x
	asl a
	bcc .15
	lda.w $0208,y
	ora.w $0209,y
	bit.b $36
	bne .18
.15:								; A = $C0002A,x, A or $C0002B,x, A * 2, if carry clear go to .16, ...
	lda.l $C0002A,x
	ora.l $C0002B,x
	asl a
	bcc .16
	lda.w $020A,y
	ora.w $020B,y
	bit.b $36
	bne .18
.16:								; A = $C0002C,x, A or $C0002D,x, A * 2, if carry clear go to .17, ...
	lda.l $C0002C,x
	ora.l $C0002D,x
	asl a
	bcc .17
	lda.w $020C,y
	ora.w $020D,y
	bit.b $36
	bne .18
.17:								; A = $C0002E,x, A or $C0002F,x, A * 2, if carry clear go to .18, ...
	lda.l $C0002E,x
	ora.l $C0002F,x
	asl a
	bcc .18
	lda.w $020E,y
	ora.w $020F,y
	bit.b $36
	bne .18
	clc
.18:								; A 16-bit, return
	rep #$20
	rts
QueueTextTiles:						; queues the tiles DrawText made for VRAM (text row Y)
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
	bcc .1
	phx
	lda.b $07,s
	adc.w #$00FF
	pha
	pea.w $007E
	lda.b $07,s
	adc.w #$0200
	pha
.1:									; A = $00, $00 = X, QueueBusy = 0, TransfersReady + 1, ...
	lda.b $00
	tsx
	tcs
	stx.b $00
	stz.b QueueBusy
	inc.w TransfersReady
	rtl
MapTextTiles:						; writes the text map entries of the tiles DrawText made (row Y, the
									; palette bits of $D5)
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
.loop:								; loop: Y + 1, A = Y, $7E0000,x = A, A = $0E, ...
	iny
	tya
	sta.l $7E0000,x
	lda.b $0E
	lsr a
	bcc .1
	tya
	adc.w #$001F
	sta.l $7E0040,x
.1:									; X + 1, X + 1, $A5 - 1, if the result is not 0 go to .loop, ...
	inx
	inx
	dec.b $A5
	bne .loop
	lda.b $0A
	sec
	sbc.b $12
	rtl
SendTextMap:						; queues the text map ($800 bytes) for VRAM at $5C00
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
.loop:								; loop: push X, push Y, A = X, A + $0020, ...
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
	bne .loop
	tsc
	sta.b $00
	lda.b $1C
	tcs
	stz.b QueueBusy
	rtl
TextWidth:							; the width in pixels of the text at X in the font of $0E (per character
									; widths)
	phx
	lda.b $0E
	bit.w #$0004
	beq .6
	stz.b $0A
	txy
.1:									; A = $0000,y, if the result = 0 go to .5, Y + 1, ...
	lda.w $0000,y
	and.w #$00FF
	beq .5
	iny
	cmp.w #$0020
	bne .2
	lda.w #$0004
	bra .4
.2:									; A - $0030, X = A, if A < $0031 go to .3, A - $0020, ...
	sec
	sbc.w #$0030
	tax
	cmp.w #$0031
	bcc .3
	sbc.w #$0020
	tax
.3:									; A = DATA8_C4C4D7,x, A and $007F
	lda.l DATA8_C4C4D7,x
	and.w #$007F
.4:									; A + $0A, $0A = A, go to .1
	clc
	adc.b $0A
	sta.b $0A
	bra .1
.5:									; A = $0A, pull X, return
	lda.b $0A
	plx
	rtl
.6:									; A = $18DA, push A, A = $18DC, push A, ...
	lda.w $18DA
	pha
	lda.w $18DC
	pha
	lda.w #$0000
	jsl.l DrawText
	ldy.w #$0400
	lda.b $0E
	lsr a
	bcs .7
	ldy.w #$0200
.7:									; A = Y, call FreeWorkBuf, A = $0A, pull A, ...
	tya
	jsl.l FreeWorkBuf
	lda.b $0A
	pla
	sta.w $18DC
	pla
	sta.w $18DA
	plx
	rtl
CopyROMString:						; copy the zero-terminated ROM string at X into a new work buffer
	phy
	phx
	ldy.w #$0001
	sep #$20
.loop:								; loop: if $C30000,x = 0 go to .1, X + 1, Y + 1, go to .loop
	lda.l $C30000,x
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
	ldx.w #$00C3
	jsl.l CODE_C58AF3
	plx
	ply
	rtl
UnpackText2:						; as UnpackText, into the second work buffer (AllocWorkBuf2)
	phy
	stx.b $16
	lda.w #$003C
	jsl.l AllocWorkBuf2
	bra DecodePackedText
UnpackText:							; unpacks the packed text at X in bank $C3 into a new work buffer ($3C
									; bytes, AllocWorkBuf); returns X = the text, zero ended
	phy
	stx.b $16
	lda.w #$003C
	jsl.l AllocWorkBuf
DecodePackedText:					; decode packed text symbols into the allocated string buffer
	pha
	tay
	lda.w #$0041
	sta.b $14
	stz.b $0A
.1:									; call ReadTextFiveBits, if A < $1A go to .5, if A = $1B go to .7, ...
	jsr.w ReadTextFiveBits
	cmp.b #$1A
	bcc .5
	cmp.b #$1B
	beq .7
	bcc .8
	cmp.b #$1D
	beq .9
	bcc .3
	cmp.b #$1F
	bcc .2
	jsr.w ReadTextThreeBits
	clc
	adc.b #$10
	bra .10
.2:									; call ReadTextThreeBits, A + $08, go to .10
	jsr.w ReadTextThreeBits
	clc
	adc.b #$08
	bra .10
.3:									; if $41 is not $14 go to .4, A = $61
	lda.b #$41
	cmp.b $14
	bne .4
	lda.b #$61
.4:									; $14 = A, go to .1
	sta.b $14
	bra .1
.5:									; A + $14
	adc.b $14
.6:									; $0000,y = A, Y + 1, go to .1
	sta.w $0000,y
	iny
	bra .1
.7:									; A = $20, go to .6
	lda.b #$20
	bra .6
.8:									; $0000,y = $00, A 16-bit, pull X, pull Y, ...
	lda.b #$00
	sta.w $0000,y
	rep #$20
	plx
	ply
	rtl
.9:									; call ReadTextThreeBits
	jsr.w ReadTextThreeBits
.10:								; X = A, A = DATA8_C4C420,x, go to .6
	tax
	lda.l DATA8_C4C420,x
	bra .6
DATA8_C4C420:						; not traced: a table read by DecodePackedText
	db $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
	db $40
ReadTextThreeBits:					; read a three-bit packed text extension
	jsr.w PeekTextBits
	and.w #$0007
	pha
	lda.w #$0003
	bra AdvanceTextBits
ReadTextFiveBits:					; read a five-bit packed text symbol
	jsr.w PeekTextBits
	and.w #$001F
	pha
	lda.w #$0005
AdvanceTextBits:					; advance the packed text bit cursor and return the saved symbol
	clc
	adc.b $0A
	cmp.w #$0008
	bcc .1
	inc.b $16
	sbc.w #$0008
.1:									; $0A = A, pull A, A 8-bit, return
	sta.b $0A
	pla
	sep #$20
	rts
PeekTextBits:						; peek the packed text bits at the current source position
	rep #$20
	ldx.b $16
	lda.l $C30000,x
	ldx.b $0A
	beq .rts
.loop:								; loop: A / 2, X - 1, if the result is not 0 go to .loop
	lsr a
	dex
	bne .loop
.rts:								; return
	rts
CentreText:							; A = the pixel column that centres the text at X between the left and
									; right margins
	jsl.l TextWidth
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
CopyString2:						; CopyString into the second work buffer (AllocWorkBuf2)
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
.1:									; A 16-bit, A = Y, push A, call AllocWorkBuf2, ...
	rep #$20
	tya
	pha
	jsl.l AllocWorkBuf2
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
DATA8_C4C4AE:						; not traced: a table read by CheckGlyphLeftOverlap
	db $80,$40,$20,$10,$08,$04,$02,$01
DATA8_C4C4B6:						; not traced: a table read by CODE_C4BEB1
	db $0B,$07,$0B,$0B,$0B,$0B,$0B,$09,$0B,$0C,$05,$08,$0C,$06,$0B,$07
	db $05,$0A,$0B,$0B,$0B,$0B,$0B,$0B,$0C,$07,$0C,$0C,$08,$0D,$0D,$0B
	db $0B
DATA8_C4C4D7:						; not traced: a table read by TextWidth, CODE_C4BE99
	db $0B,$0B,$0B,$0A,$0C,$09,$0C,$0B,$0A,$0B,$02,$03,$01,$83,$87,$83
	db $84,$87,$87,$86,$87,$86,$86,$87,$86,$82,$85,$87,$85,$88,$87,$88
	db $86,$88,$86,$85,$86,$86,$87,$88,$86,$86,$85
DATA8_C4C502:						; not traced: a table read by CODE_C4BEA6
	db $86,$85,$86,$86,$87,$86,$86,$86,$86,$86,$83,$83,$88,$83,$85,$83
	db $83,$88,$87,$88,$87,$86,$86,$88,$87,$83,$86,$87,$87,$88,$87,$88
	db $87,$88,$88,$87,$87,$87,$88,$88,$87,$87,$87,$02,$03,$01
ResetWorkBuf:						; both work buffer pointers back to their starts, the saved mark too
	lda.w #$50DC
	sta.w $18E0
RestoreWorkBuf:						; the work buffer pointer back to the saved mark (MarkWorkBuf), the second
									; one to its start
	lda.w $18E0
	sta.b $08
	lda.w #$E000
	sta.b $D7
	rtl
MarkWorkBuf:						; saves the work buffer pointer as the mark RestoreWorkBuf goes back to
	lda.b $08
	sta.w $18E0
	rtl
AllocClearWorkBuf:					; takes A bytes from the work buffer (AllocWorkBuf) and clears them
									; (ClearRAM7E); returns A = their start
	phx
	phy
	pha
	jsl.l AllocWorkBuf
	ply
	pha
	jsl.l ClearRAM7E
	pla
	ply
	plx
	rtl
AllocWorkBuf:						; takes A bytes from the work buffer in bank $7E: returns A = their start
									; (the buffer pointer moves on)
	pei ($08)
	clc
	adc.b $08
	sta.b $08
	pla
	rtl
AllocWorkBuf2:						; as AllocWorkBuf, from the second work buffer (from $E000)
	pei ($D7)
	clc
	adc.b $D7
	sta.b $D7
	pla
	rtl
FreeWorkBuf:						; gives the last A bytes back to the work buffer (AllocWorkBuf)
	sec
	sbc.b $08
	eor.w #$FFFF
	inc a
	sta.b $08
	rtl
ResetTransferQueues:				; empties the transfer queues: their stack pointers $00 = $03FF, $02 =
									; $01FF, $04 = $048F, with QueueBusy set around the stores
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
.1:									; if $FE is not 0 go to .2, go to .34
	lda.b $FE
	bne .2
	jmp.w .34
.2:									; DAS0L = A, VMADDL = $FC, A1B0 = $FA, A1T0L = $F8, ...
	sta.w DAS0L
	lda.b $FC
	sta.w VMADDL
	ldx.b $FA
	stx.w A1B0
	lda.b $F8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $F6
	bne .3
	jmp.w .34
.3:									; DAS0L = A, VMADDL = $F4, A1B0 = $F2, A1T0L = $F0, ...
	sta.w DAS0L
	lda.b $F4
	sta.w VMADDL
	ldx.b $F2
	stx.w A1B0
	lda.b $F0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $EE
	bne .4
	jmp.w .34
.4:									; DAS0L = A, VMADDL = $EC, A1B0 = $EA, A1T0L = $E8, ...
	sta.w DAS0L
	lda.b $EC
	sta.w VMADDL
	ldx.b $EA
	stx.w A1B0
	lda.b $E8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $E6
	bne .5
	jmp.w .34
.5:									; DAS0L = A, VMADDL = $E4, A1B0 = $E2, A1T0L = $E0, ...
	sta.w DAS0L
	lda.b $E4
	sta.w VMADDL
	ldx.b $E2
	stx.w A1B0
	lda.b $E0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $DE
	bne .6
	jmp.w .34
.6:									; DAS0L = A, VMADDL = $DC, A1B0 = $DA, A1T0L = $D8, ...
	sta.w DAS0L
	lda.b $DC
	sta.w VMADDL
	ldx.b $DA
	stx.w A1B0
	lda.b $D8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $D6
	bne .7
	jmp.w .34
.7:									; DAS0L = A, VMADDL = $D4, A1B0 = $D2, A1T0L = $D0, ...
	sta.w DAS0L
	lda.b $D4
	sta.w VMADDL
	ldx.b $D2
	stx.w A1B0
	lda.b $D0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $CE
	bne .8
	jmp.w .34
.8:									; DAS0L = A, VMADDL = $CC, A1B0 = $CA, A1T0L = $C8, ...
	sta.w DAS0L
	lda.b $CC
	sta.w VMADDL
	ldx.b $CA
	stx.w A1B0
	lda.b $C8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $C6
	bne .9
	jmp.w .34
.9:									; DAS0L = A, VMADDL = $C4, A1B0 = $C2, A1T0L = $C0, ...
	sta.w DAS0L
	lda.b $C4
	sta.w VMADDL
	ldx.b $C2
	stx.w A1B0
	lda.b $C0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $BE
	bne .10
	jmp.w .34
.10:								; DAS0L = A, VMADDL = $BC, A1B0 = $BA, A1T0L = $B8, ...
	sta.w DAS0L
	lda.b $BC
	sta.w VMADDL
	ldx.b $BA
	stx.w A1B0
	lda.b $B8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $B6
	bne .11
	jmp.w .34
.11:								; DAS0L = A, VMADDL = $B4, A1B0 = $B2, A1T0L = $B0, ...
	sta.w DAS0L
	lda.b $B4
	sta.w VMADDL
	ldx.b $B2
	stx.w A1B0
	lda.b $B0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $AE
	bne .12
	jmp.w .34
.12:								; DAS0L = A, VMADDL = $AC, A1B0 = $AA, A1T0L = $A8, ...
	sta.w DAS0L
	lda.b $AC
	sta.w VMADDL
	ldx.b $AA
	stx.w A1B0
	lda.b $A8
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $A6
	bne .13
	jmp.w .34
.13:								; DAS0L = A, VMADDL = $A4, A1B0 = $A2, A1T0L = $A0, ...
	sta.w DAS0L
	lda.b $A4
	sta.w VMADDL
	ldx.b $A2
	stx.w A1B0
	lda.b $A0
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $9E
	bne .14
	jmp.w .34
.14:								; DAS0L = A, VMADDL = $9C, A1B0 = $9A, A1T0L = $98, ...
	sta.w DAS0L
	lda.b $9C
	sta.w VMADDL
	ldx.b $9A
	stx.w A1B0
	lda.b $98
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $96
	bne .15
	jmp.w .34
.15:								; DAS0L = A, VMADDL = $94, A1B0 = $92, A1T0L = $90, ...
	sta.w DAS0L
	lda.b $94
	sta.w VMADDL
	ldx.b $92
	stx.w A1B0
	lda.b $90
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $8E
	bne .16
	jmp.w .34
.16:								; DAS0L = A, VMADDL = $8C, A1B0 = $8A, A1T0L = $88, ...
	sta.w DAS0L
	lda.b $8C
	sta.w VMADDL
	ldx.b $8A
	stx.w A1B0
	lda.b $88
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $86
	bne .17
	jmp.w .34
.17:								; DAS0L = A, VMADDL = $84, A1B0 = $82, A1T0L = $80, ...
	sta.w DAS0L
	lda.b $84
	sta.w VMADDL
	ldx.b $82
	stx.w A1B0
	lda.b $80
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $7E
	bne .18
	jmp.w .34
.18:								; DAS0L = A, VMADDL = $7C, A1B0 = $7A, A1T0L = $78, ...
	sta.w DAS0L
	lda.b $7C
	sta.w VMADDL
	ldx.b $7A
	stx.w A1B0
	lda.b $78
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $76
	bne .19
	jmp.w .34
.19:								; DAS0L = A, VMADDL = $74, A1B0 = $72, A1T0L = $70, ...
	sta.w DAS0L
	lda.b $74
	sta.w VMADDL
	ldx.b $72
	stx.w A1B0
	lda.b $70
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $6E
	bne .20
	jmp.w .34
.20:								; DAS0L = A, VMADDL = $6C, A1B0 = $6A, A1T0L = $68, ...
	sta.w DAS0L
	lda.b $6C
	sta.w VMADDL
	ldx.b $6A
	stx.w A1B0
	lda.b $68
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $66
	bne .21
	jmp.w .34
.21:								; DAS0L = A, VMADDL = $64, A1B0 = $62, A1T0L = $60, ...
	sta.w DAS0L
	lda.b $64
	sta.w VMADDL
	ldx.b $62
	stx.w A1B0
	lda.b $60
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $5E
	bne .22
	jmp.w .34
.22:								; DAS0L = A, VMADDL = $5C, A1B0 = $5A, A1T0L = $58, ...
	sta.w DAS0L
	lda.b $5C
	sta.w VMADDL
	ldx.b $5A
	stx.w A1B0
	lda.b $58
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $56
	bne .23
	jmp.w .34
.23:								; DAS0L = A, VMADDL = $54, A1B0 = $52, A1T0L = $50, ...
	sta.w DAS0L
	lda.b $54
	sta.w VMADDL
	ldx.b $52
	stx.w A1B0
	lda.b $50
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $4E
	bne .24
	jmp.w .34
.24:								; DAS0L = A, VMADDL = $4C, A1B0 = $4A, A1T0L = $48, ...
	sta.w DAS0L
	lda.b $4C
	sta.w VMADDL
	ldx.b $4A
	stx.w A1B0
	lda.b $48
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $46
	bne .25
	jmp.w .34
.25:								; DAS0L = A, VMADDL = $44, A1B0 = $42, A1T0L = $40, ...
	sta.w DAS0L
	lda.b $44
	sta.w VMADDL
	ldx.b $42
	stx.w A1B0
	lda.b $40
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $3E
	bne .26
	jmp.w .34
.26:								; DAS0L = A, VMADDL = $3C, A1B0 = $3A, A1T0L = $38, ...
	sta.w DAS0L
	lda.b $3C
	sta.w VMADDL
	ldx.b $3A
	stx.w A1B0
	lda.b $38
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $36
	bne .27
	jmp.w .34
.27:								; DAS0L = A, VMADDL = $34, A1B0 = $32, A1T0L = $30, ...
	sta.w DAS0L
	lda.b $34
	sta.w VMADDL
	ldx.b $32
	stx.w A1B0
	lda.b $30
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $2E
	bne .28
	jmp.w .34
.28:								; DAS0L = A, VMADDL = $2C, A1B0 = $2A, A1T0L = $28, ...
	sta.w DAS0L
	lda.b $2C
	sta.w VMADDL
	ldx.b $2A
	stx.w A1B0
	lda.b $28
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $26
	bne .29
	jmp.w .34
.29:								; DAS0L = A, VMADDL = $24, A1B0 = $22, A1T0L = $20, ...
	sta.w DAS0L
	lda.b $24
	sta.w VMADDL
	ldx.b $22
	stx.w A1B0
	lda.b $20
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $1E
	bne .30
	jmp.w .34
.30:								; DAS0L = A, VMADDL = $1C, A1B0 = $1A, A1T0L = $18, ...
	sta.w DAS0L
	lda.b $1C
	sta.w VMADDL
	ldx.b $1A
	stx.w A1B0
	lda.b $18
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $16
	bne .31
	jmp.w .34
.31:								; DAS0L = A, VMADDL = $14, A1B0 = $12, A1T0L = $10, ...
	sta.w DAS0L
	lda.b $14
	sta.w VMADDL
	ldx.b $12
	stx.w A1B0
	lda.b $10
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $0E
	bne .32
	jmp.w .34
.32:								; DAS0L = A, VMADDL = $0C, A1B0 = $0A, A1T0L = $08, ...
	sta.w DAS0L
	lda.b $0C
	sta.w VMADDL
	ldx.b $0A
	stx.w A1B0
	lda.b $08
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $06
	bne .33
	jmp.w .34
.33:								; DAS0L = A, VMADDL = $04, A1B0 = $02, A1T0L = $00, ...
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
	jmp.w .1
.34:								; A = $0100, if $FE is not 0 go to .35, go to .56
	lda.w #$0100
	tcd
	lda.b $FE
	bne .35
	jmp.w .56
.35:								; DAS0L = A, VMAIN = $FC, VMADDL = $FA, DMAP0 = $F8, ...
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
	bne .36
	jmp.w .56
.36:								; DAS0L = A, VMAIN = $F0, VMADDL = $EE, DMAP0 = $EC, ...
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
	bne .37
	jmp.w .56
.37:								; DAS0L = A, VMAIN = $E4, VMADDL = $E2, DMAP0 = $E0, ...
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
	bne .38
	jmp.w .56
.38:								; DAS0L = A, VMAIN = $D8, VMADDL = $D6, DMAP0 = $D4, ...
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
	bne .39
	jmp.w .56
.39:								; DAS0L = A, VMAIN = $CC, VMADDL = $CA, DMAP0 = $C8, ...
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
	bne .40
	jmp.w .56
.40:								; DAS0L = A, VMAIN = $C0, VMADDL = $BE, DMAP0 = $BC, ...
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
	bne .41
	jmp.w .56
.41:								; DAS0L = A, VMAIN = $B4, VMADDL = $B2, DMAP0 = $B0, ...
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
	bne .42
	jmp.w .56
.42:								; DAS0L = A, VMAIN = $A8, VMADDL = $A6, DMAP0 = $A4, ...
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
	bne .43
	jmp.w .56
.43:								; DAS0L = A, VMAIN = $9C, VMADDL = $9A, DMAP0 = $98, ...
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
	bne .44
	jmp.w .56
.44:								; DAS0L = A, VMAIN = $90, VMADDL = $8E, DMAP0 = $8C, ...
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
	bne .45
	jmp.w .56
.45:								; DAS0L = A, VMAIN = $84, VMADDL = $82, DMAP0 = $80, ...
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
	bne .46
	jmp.w .56
.46:								; DAS0L = A, VMAIN = $78, VMADDL = $76, DMAP0 = $74, ...
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
	bne .47
	jmp.w .56
.47:								; DAS0L = A, VMAIN = $6C, VMADDL = $6A, DMAP0 = $68, ...
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
	bne .48
	jmp.w .56
.48:								; DAS0L = A, VMAIN = $60, VMADDL = $5E, DMAP0 = $5C, ...
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
	bne .49
	jmp.w .56
.49:								; DAS0L = A, VMAIN = $54, VMADDL = $52, DMAP0 = $50, ...
	sta.w DAS0L
	ldx.b $54
	stx.w VMAIN
	lda.b $52
	sta.w VMADDL
	lda.b $50
	sta.w DMAP0
	ldx.b $4E
	stx.w A1B0
	lda.b $4C
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $4A
	bne .50
	jmp.w .56
.50:								; DAS0L = A, VMAIN = $48, VMADDL = $46, DMAP0 = $44, ...
	sta.w DAS0L
	ldx.b $48
	stx.w VMAIN
	lda.b $46
	sta.w VMADDL
	lda.b $44
	sta.w DMAP0
	ldx.b $42
	stx.w A1B0
	lda.b $40
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $3E
	bne .51
	jmp.w .56
.51:								; DAS0L = A, VMAIN = $3C, VMADDL = $3A, DMAP0 = $38, ...
	sta.w DAS0L
	ldx.b $3C
	stx.w VMAIN
	lda.b $3A
	sta.w VMADDL
	lda.b $38
	sta.w DMAP0
	ldx.b $36
	stx.w A1B0
	lda.b $34
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $32
	bne .52
	jmp.w .56
.52:								; DAS0L = A, VMAIN = $30, VMADDL = $2E, DMAP0 = $2C, ...
	sta.w DAS0L
	ldx.b $30
	stx.w VMAIN
	lda.b $2E
	sta.w VMADDL
	lda.b $2C
	sta.w DMAP0
	ldx.b $2A
	stx.w A1B0
	lda.b $28
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $26
	bne .53
	jmp.w .56
.53:								; DAS0L = A, VMAIN = $24, VMADDL = $22, DMAP0 = $20, ...
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
	bne .54
	jmp.w .56
.54:								; DAS0L = A, VMAIN = $18, VMADDL = $16, DMAP0 = $14, ...
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
	bne .55
	jmp.w .56
.55:								; DAS0L = A, VMAIN = $0C, VMADDL = $0A, DMAP0 = $08, ...
	sta.w DAS0L
	ldx.b $0C
	stx.w VMAIN
	lda.b $0A
	sta.w VMADDL
	lda.b $08
	sta.w DMAP0
	ldx.b $06
	stx.w A1B0
	lda.b $04
	sta.w A1T0L
	sty.w MDMAEN
.56:								; A = $0400, DMAP0 = $2200, A, X / Y 16-bit, X = $0004, ...
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
	bne .57
	jmp.w .75
.57:								; DAS0L = A, CGADD = $8C, A1B0 = $8A, A1T0L = $88, ...
	sta.w DAS0L
	ldx.b $8C
	stx.w CGADD
	ldx.b $8A
	stx.w A1B0
	lda.b $88
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $86
	bne .58
	jmp.w .75
.58:								; DAS0L = A, CGADD = $84, A1B0 = $82, A1T0L = $80, ...
	sta.w DAS0L
	ldx.b $84
	stx.w CGADD
	ldx.b $82
	stx.w A1B0
	lda.b $80
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $7E
	bne .59
	jmp.w .75
.59:								; DAS0L = A, CGADD = $7C, A1B0 = $7A, A1T0L = $78, ...
	sta.w DAS0L
	ldx.b $7C
	stx.w CGADD
	ldx.b $7A
	stx.w A1B0
	lda.b $78
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $76
	bne .60
	jmp.w .75
.60:								; DAS0L = A, CGADD = $74, A1B0 = $72, A1T0L = $70, ...
	sta.w DAS0L
	ldx.b $74
	stx.w CGADD
	ldx.b $72
	stx.w A1B0
	lda.b $70
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $6E
	bne .61
	jmp.w .75
.61:								; DAS0L = A, CGADD = $6C, A1B0 = $6A, A1T0L = $68, ...
	sta.w DAS0L
	ldx.b $6C
	stx.w CGADD
	ldx.b $6A
	stx.w A1B0
	lda.b $68
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $66
	bne .62
	jmp.w .75
.62:								; DAS0L = A, CGADD = $64, A1B0 = $62, A1T0L = $60, ...
	sta.w DAS0L
	ldx.b $64
	stx.w CGADD
	ldx.b $62
	stx.w A1B0
	lda.b $60
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $5E
	bne .63
	jmp.w .75
.63:								; DAS0L = A, CGADD = $5C, A1B0 = $5A, A1T0L = $58, ...
	sta.w DAS0L
	ldx.b $5C
	stx.w CGADD
	ldx.b $5A
	stx.w A1B0
	lda.b $58
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $56
	bne .64
	jmp.w .75
.64:								; DAS0L = A, CGADD = $54, A1B0 = $52, A1T0L = $50, ...
	sta.w DAS0L
	ldx.b $54
	stx.w CGADD
	ldx.b $52
	stx.w A1B0
	lda.b $50
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $4E
	bne .65
	jmp.w .75
.65:								; DAS0L = A, CGADD = $4C, A1B0 = $4A, A1T0L = $48, ...
	sta.w DAS0L
	ldx.b $4C
	stx.w CGADD
	ldx.b $4A
	stx.w A1B0
	lda.b $48
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $46
	bne .66
	jmp.w .75
.66:								; DAS0L = A, CGADD = $44, A1B0 = $42, A1T0L = $40, ...
	sta.w DAS0L
	ldx.b $44
	stx.w CGADD
	ldx.b $42
	stx.w A1B0
	lda.b $40
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $3E
	bne .67
	jmp.w .75
.67:								; DAS0L = A, CGADD = $3C, A1B0 = $3A, A1T0L = $38, ...
	sta.w DAS0L
	ldx.b $3C
	stx.w CGADD
	ldx.b $3A
	stx.w A1B0
	lda.b $38
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $36
	bne .68
	jmp.w .75
.68:								; DAS0L = A, CGADD = $34, A1B0 = $32, A1T0L = $30, ...
	sta.w DAS0L
	ldx.b $34
	stx.w CGADD
	ldx.b $32
	stx.w A1B0
	lda.b $30
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $2E
	bne .69
	jmp.w .75
.69:								; DAS0L = A, CGADD = $2C, A1B0 = $2A, A1T0L = $28, ...
	sta.w DAS0L
	ldx.b $2C
	stx.w CGADD
	ldx.b $2A
	stx.w A1B0
	lda.b $28
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $26
	bne .70
	jmp.w .75
.70:								; DAS0L = A, CGADD = $24, A1B0 = $22, A1T0L = $20, ...
	sta.w DAS0L
	ldx.b $24
	stx.w CGADD
	ldx.b $22
	stx.w A1B0
	lda.b $20
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $1E
	bne .71
	jmp.w .75
.71:								; DAS0L = A, CGADD = $1C, A1B0 = $1A, A1T0L = $18, ...
	sta.w DAS0L
	ldx.b $1C
	stx.w CGADD
	ldx.b $1A
	stx.w A1B0
	lda.b $18
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $16
	bne .72
	jmp.w .75
.72:								; DAS0L = A, CGADD = $14, A1B0 = $12, A1T0L = $10, ...
	sta.w DAS0L
	ldx.b $14
	stx.w CGADD
	ldx.b $12
	stx.w A1B0
	lda.b $10
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $0E
	bne .73
	jmp.w .75
.73:								; DAS0L = A, CGADD = $0C, A1B0 = $0A, A1T0L = $08, ...
	sta.w DAS0L
	ldx.b $0C
	stx.w CGADD
	ldx.b $0A
	stx.w A1B0
	lda.b $08
	sta.w A1T0L
	sty.w MDMAEN
	lda.b $06
	bne .74
	jmp.w .75
.74:								; DAS0L = A, CGADD = $04, A1B0 = $02, A1T0L = $00, ...
	sta.w DAS0L
	ldx.b $04
	stx.w CGADD
	ldx.b $02
	stx.w A1B0
	lda.b $00
	sta.w A1T0L
	sty.w MDMAEN
.75:								; A = $0000, $00 = $03FF, $02 = $01FF, $04 = $048F, ...
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
	bcc .76
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
.76:								; DAS0L = $0220, A1T0L = $1B90, $4303 = $001B, DMAP0 = $0400, ...
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
WaitTransfers:						; lets the NMI run the queued transfers (TransfersReady + 1) and waits for
									; it (wai)
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
	bne .1
	ldy.w #$6A16
	jsr.w CODE_C4CF64
	bne .1
	ldy.w #$790D
	jsr.w CODE_C4CF64
	beq .2
.1:									; A = $1FFE, $6000 = 0, X = $6000, Y = X, ...
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
	sta.l SROptperlen
	lda.w #$000E
	sta.l SRHomeTeam
	lda.w #$0017
	sta.l SRVisTeam
	ldx.w #$003A
	lda.w #$FFFF
.loop:								; loop: $3070D6,x = A, X - 1, X - 1, if the result >= 0 go to .loop
	sta.l $3070D6,x
	dex
	dex
	bpl .loop
.2:									; return
	plb
	rtl
CODE_C4CF5A:						; from CODE_C4CEF5
	ldx.w #$FFC0
	lda.w #$003F
	mvn $30,$C0
	rts
CODE_C4CF64:						; from CODE_C4CEF5
	ldx.w #$FFC0
.loop:								; loop: if $00,x is not $0000,y go to .rts, Y + 1, Y + 1, X + 1, ...
	lda.b $00,x
	cmp.w $0000,y
	bne .rts
	iny
	iny
	inx
	inx
	bne .loop
.rts:								; return
	rts
CODE_C4CF75:						; from CODE_C4CEF5 and other segments
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
CODE_C4CF92:						; from CODE_C4CFBE
	sta.w HomeTeam
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
.loop:								; loop: Y + 1, A * 2, A * 2, A * 2, ...
	iny
	asl a
	asl a
	asl a
	asl a
	bne .loop
	plx
	lda.l $C30000,x
	and.w #$07FF
	lsr a
	sec
	sbc.w #$001C
CODE_C4CFBE:						; from CODE_C4CF7B, CODE_C4CFBE
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
.loop:								; loop: Y - 1, if the result < 0 go to .1, A * 2, go to .loop
	dey
	bmi .1
	asl a
	bra .loop
.1:									; A or SRGoals,x, SRGoals,x = A, $0A + 1, pull A, ...
	ora.l SRGoals,x
	sta.l SRGoals,x
	inc.b $0A
	pla
	inc a
	ply
	dey
	bne CODE_C4CFBE
	lda.w HomeTeam
	dec a
	bpl CODE_C4CF92
	rtl

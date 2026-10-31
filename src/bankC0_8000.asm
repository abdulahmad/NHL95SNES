; Segment bankC0_8000: data, then the start of the engine: the NMI and IRQ with their hooks, the frame waits,
; the pad waits, RandomWord, the screen on / off routines and the 8 and 16 x 8 bit multiplies (as in 94S's
; engine bank). The data before the engine is not traced to a use, except TiledBackMap.
org $C08000
DATA8_C08000:						; the sprite objects: header, 27 byte records, frame headers into bank
									; $C1 (docs/sprite_objects.md); not split up yet
	incbin "../Extracted/segments/bankC0_8000.bin":0..$7F2
TiledBackMap:						; tilemap of a 16 x 3 block of tiles repeated over the screen, LZSS
									; packed; screen set-ups have the map unpacker send it to VRAM
	dw .end-.width					; bytes after this word
.width:								; map width in tiles
	db $20
	db $1C							; height in tiles
	db $8C							; flags: bit 7 LZSS packed
	dw $0700						; unpacked size in bytes, then the LZSS stream
	incbin "../Extracted/segments/bankC0_8000.bin":$7F9..$939
.end:								; the end of the set
DATA8_C08939:						; not traced: a set with the same length word (another format), then
									; 7 bytes
	incbin "../Extracted/segments/bankC0_8000.bin":$939..$B17
DATA8_C08B17:						; not traced: 16 colours, magenta then blues
	dw $7C1F,$7C00,$7800,$7400,$6C00,$7400,$6C00,$6800
	dw $6400,$6800,$6400,$6000,$5800,$7C1F,$7C1F,$7C1F
InitHooks:							; initial FrameHook, NMIHook, IRQHook (long pointers into the bank $80
									; mirror) and the random seed
	dl $800000|(NullHook&$FFFF),$800000|(NullHook&$FFFF),$800000|(IRQHook_Off&$FFFF)
	dw $AFE5,$F527
NullHook:							; an empty hook
	rtl
NMI_Fast:							; NMI: save the registers; just return while NMISkip is set
	rep #$30
	phd
	phb
	pea.w $8080						; data bank $80 (pulled twice)
	plb
	plb
	pha
	lda.w #$0000
	tcd
	lda.w RDNMI
	lda.b NMISkip
	beq .run
	pla
	plb
	pld
	rti
.run:								; NMISkip clear: set it, then the NMI hook
	inc a
	sta.b NMISkip
	phx
	phy
	sep #$10
	ldx.w NMIHookNext+1
	beq .1
	lda.w NMIHookNext
	sta.w NMIHook
	stz.w NMIHookNext
	ldx.w NMIHookNext+2
	stx.w NMIHook+2
.1:									; call [NMIHook]; its rtl lands on NMI_HookReturn
	ldx.b #NMI_HookReturn>>16
	phx
	pea.w NMI_HookReturn-1
	jml.w [NMIHook]
NMI_HookReturn:						; NMI after the hook: IRQ timers, BG scroll, queued transfers, DMA enables
	rep #$30
	lda.w IRQVTime
	sta.l VTIMEL
	lda.w IRQHTime
	sta.l HTIMEL
	sep #$30
	lda.w BG1HScroll
	sta.w BG1HOFS
	lda.w BG1HScroll+1
	sta.w BG1HOFS
	lda.w BG1VScroll
	sta.w BG1VOFS
	lda.w BG1VScroll+1
	sta.w BG1VOFS
	lda.w BG2HScroll
	sta.w BG2HOFS
	lda.w BG2HScroll+1
	sta.w BG2HOFS
	lda.w BG2VScroll
	sta.w BG2VOFS
	lda.w BG2VScroll+1
	sta.w BG2VOFS
	lda.w BG3HScroll
	sta.w BG3HOFS
	lda.w BG3HScroll+1
	sta.w BG3HOFS
	lda.w BG3VScroll
	sta.w BG3VOFS
	lda.w BG3VScroll+1
	sta.w BG3VOFS
	lda.b #$80						; forced blank while the transfers run
	sta.w INIDISP
	rep #$30
	lda.w TransfersReady
	beq .1
	bit.b QueueBusy
	bmi .1
	stz.w MDMAEN
	jsl.l $C4C58B
	stz.w TransfersReady
.1:									; DMA and HDMA enables
	lda.w DMAEnShadow
	sta.w MDMAEN
NMI_Tick:							; Vcount + 1, the fade, FrameCount, then the frame hook
	clc
	lda.b Vcount
	adc.w #$0001
	sta.b Vcount
	bcc .1
	inc.b Vcount+2
.1:									; the fade
	lda.w fadestep
	bmi .fadeout
	dec a
	bmi .fadein
	sta.w fadestep
	sep #$20
	bra .write
.fadein:							; fadestep 0: brightness + 1 up to 15
	sep #$20
	lda.w brightness
	bpl .up
	lda.b #$FF
.up:								; up one step
	inc a
	cmp.b #$10
	bcs .write
	sta.w brightness
	bra .write
.fadeout:							; fadestep negative: brightness - 1 until negative
	sep #$20
	lda.w brightness
	bmi .write
	dec a
	sta.w brightness
.write:								; brightness to INIDISP
	lda.w brightness
	sta.w INIDISP
	rep #$20
	lda.w FrameCountHold
	bne .2
	inc.w FrameCount
.2:									; the frame hook: FrameHookNext to FrameHook
	sep #$10
	ldx.w FrameHookNext+1
	beq .3
	lda.w FrameHookNext
	sta.w FrameHook
	stz.w FrameHookNext
	ldx.w FrameHookNext+2
	stx.w FrameHook+2
.3:									; call [FrameHook]; its rtl lands on NMI_FrameHookReturn
	ldx.b #NMI_FrameHookReturn>>16
	phx
	pea.w NMI_FrameHookReturn-1
	jml.w [FrameHook]
NMI_FrameHookReturn:				; NMI after the frame hook: pads and sound, then restore and rti
	jsl.l $C36D3A
	rep #$30
	jsl.l $CF00FE
	stz.b NMISkip
	ply
	plx
	pla
	plb
	pld
	rti
BCDTable:							; 0 to 99 in BCD, by binary value
	db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09
	db $10,$11,$12,$13,$14,$15,$16,$17,$18,$19
	db $20,$21,$22,$23,$24,$25,$26,$27,$28,$29
	db $30,$31,$32,$33,$34,$35,$36,$37,$38,$39
	db $40,$41,$42,$43,$44,$45,$46,$47,$48,$49
	db $50,$51,$52,$53,$54,$55,$56,$57,$58,$59
	db $60,$61,$62,$63,$64,$65,$66,$67,$68,$69
	db $70,$71,$72,$73,$74,$75,$76,$77,$78,$79
	db $80,$81,$82,$83,$84,$85,$86,$87,$88,$89
	db $90,$91,$92,$93,$94,$95,$96,$97,$98,$99
IRQ:								; IRQ entry: jml IRQ_Fast (the IRQ vector points to RAM)
	jml.l IRQ_Fast
IRQ_Fast:							; IRQ: save the registers, acknowledge TIMEUP and run the IRQ hook
	rep #$30
	sei
	phb
	phk
	plb
	pha
	phx
	phy
	sep #$10
	ldx.w TIMEUP
	ldx.b #IRQ_HookReturn>>16
	phx
	pea.w IRQ_HookReturn-1
	jml.w [IRQHook]
IRQ_HookReturn:						; IRQ: restore the registers and rti (where the IRQ hooks return)
	rep #$30
	ply
	plx
	pla
	plb
	rti
IRQOff:								; turn the IRQ off, the NMI and pad reading on
	sei
	php
	pha
	sep #$20
	lda.b #$81
	sta.l NMITIMEN
	stz.w IRQHook+2
	rep #$20
	lda.w #IRQHook_Off
	sta.w IRQHook
	pla
	plp
	cli
	rtl
SetIRQ:								; turn on an IRQ at line Y with the routine at X:A
	php
	sei
	sep #$20
	pha
	lda.b #$81
	sta.l NMITIMEN
	pla
	rep #$20
	tya
	sty.w IRQVTime
	sta.l VTIMEL
	lda.w IRQHTime
	sta.l HTIMEL
	sep #$10
	stx.w IRQHook+2
	sta.w IRQHook
	jsl.l WaitFrame
	sep #$20
	lda.b #$B1
	sta.l NMITIMEN
	plp
	cli
IRQHook_Off:						; rtl; the IRQ hook when the raster IRQ is off
	rtl
ClearFrameHook:						; set the frame hook back to the empty routine
	pha
	phx
	ldx.w #NullHook>>16
	lda.w #NullHook
	jsl.l SetFrameHook
	plx
	pla
	rtl
SetFrameHook:						; run the routine at X:A as the frame hook from the next NMI
	sep #$10
	stx.w FrameHookNext+2
	sta.w FrameHookNext
	rep #$10
	rtl
ClearNMIHook:						; set the NMI hook back to the empty routine
	pha
	phx
	ldx.w #NullHook>>16
	lda.w #NullHook
	jsl.l SetNMIHook
	plx
	pla
	rtl
SetNMIHook:							; run the routine at X:A as the NMI hook from the next NMI
	sep #$10
	stx.w NMIHookNext+2
	sta.w NMIHookNext
	rep #$10
	rtl
WaitFrame:							; wait for the next frame (FrameCount changes)
	pha
	lda.w FrameCount
.loop:								; until FrameCount changes
	cmp.w FrameCount
	beq .loop
	pla
	rtl
WaitFrames_Inc:						; WaitFrames with Y + 1 first
	iny
WaitFrames:							; wait X frames, Y counting the rounds of 65536
	wai
	dex
	bne WaitFrames
	dey
	bne WaitFrames
	rtl
WaitDMAQueue:						; wait until the DMA queue is empty (DMAQueueHead = DMAQueueTail)
	pha
.loop:								; until the queue is empty
	lda.b DMAQueueHead
	cmp.b DMAQueueTail
	bne .loop
	pla
	rtl
.t1:								; wait up to X+Y*65536 frames for a button on pad 1
	iny
.1:									; next frame
	jsl.l WaitFrame
	dex
	bne .t1x
	dey
	bne .t1x
	lda.w #$0000
	rtl
.t1x:								; a button held: return it
	lda.b PadRaw1
	beq .1
	rtl
.t2:								; the same for pad 2
	iny
.2:									; next frame
	jsl.l WaitFrame
	dex
	bne .t1xx
	dey
	bne .t1xx
	lda.w #$0000
	rtl
.t1xx:								; a button held: return it
	lda.b PadRaw2
	beq .2
	rtl
.t2x:								; wait for one of the buttons in A on pad 1
	sta.b r3
	iny
.3:									; next frame
	jsl.l WaitFrame
	dex
	bne .t1xxx
	dey
	bne .t1xxx
	lda.w #$0000
	rtl
.t1xxx:								; one of them held: return them
	lda.b PadRaw1
	and.b r3
	beq .3
	rtl
.t2xx:								; the same for pad 2
	sta.b r3
	iny
.4:									; next frame
	jsl.l WaitFrame
	dex
	bne .t1xxxx
	dey
	bne .t1xxxx
	lda.w #$0000
	rtl
.t1xxxx:							; one of them held: return them
	lda.b PadRaw2
	and.b r3
	beq .4
	rtl
WaitNoButtons:						; wait until no button is held on pad 1
	pha
.loop:								; until no button (the d-pad bits ignored)
	lda.b PadRaw1
	and.w #$FFF0
	bne .loop
	pla
	rtl
.t1:								; the same for pad 2
	pha
.loopx:								; until no button
	lda.b PadRaw2
	and.w #$FFF0
	bne .loopx
	pla
	rtl
.t2:								; wait up to X frames for no button on pad 1
	pha
.loopx2:							; next frame
	jsl.l WaitFrame
	lda.b PadRaw1
	and.w #$FFF0
	beq .1
	dex
	bne .loopx2
.1:									; return
	pla
	rtl
.t1x:								; the same for pad 2
	pha
.loopxx:							; next frame
	jsl.l WaitFrame
	lda.b PadRaw2
	and.w #$FFF0
	beq .1x
	dex
	bne .loopxx
.1x:								; return
	pla
	rtl
JoyDirIndex_Hi:						; JoyDirIndex of the high byte of A
	xba
JoyDirIndex:						; X = 2 * JoyDirTable[the d-pad bits A & $F]
	and.w #$000F
	tax
	lda.l JoyDirTable,x
	and.w #$00FF
	asl a
	tax
	rtl
JoyDirTable:						; direction index for each d-pad bit pattern (8 = none)
	db $08,$02,$06,$08,$04,$03,$05,$08,$00,$01,$07,$08,$08,$08,$08,$08
RandomWord:							; A = a random word: the sum of two 16-bit shift-register generators
	lda.w seed
	beq .3
	asl a
	bcc .1
	eor.w #$1D87
.1:									; the first generator
	sta.w seed
	lda.w seed+2
	beq .4
	asl a
	bcc .2
	eor.w #$1D87
.2:									; the second generator, then the sum
	sta.w seed+2
	clc
	adc.w seed
	rtl
.3:									; seed 0: start it
	lda.w #$A5A5
	bra .1
.4:									; seed+2 0: start it
	lda.w #$B4B4
	bra .2
.t1:								; rtl
	rtl
BlankScreen:						; wait a frame, the default hooks, IRQ off, fade out, HDMA off
	jsl.l WaitFrame
	jsl.l IRQOff
	jsl.l ClearFrameHook
	jsl.l ClearNMIHook
	lda.w #$FFFF
	sta.w fadestep
	stz.w DMAEnShadow
.loop:								; until the fade is out
	lda.w brightness-1
	bpl .loop
	rtl
forceblack:							; BlankScreen, then ResetPPURegs
	jsl.l BlankScreen
	bra ResetPPURegs
ScreenOn:							; fade the screen in (fadestep 0)
	stz.w fadestep
	rtl
ResetPPURegs:						; reset the scroll copies and the window and colour math registers
	pha
	stz.w BG1HScroll
	stz.w BG2HScroll
	stz.w BG3HScroll
	lda.w #$FFFF
	sta.w BG1VScroll
	sta.w BG2VScroll
	sta.w BG3VScroll
	phd
	lda.w #INIDISP					; direct page on the PPU registers
	tcd
	sep #$20
	stz.b CGADSUB&$FF
	stz.b CGWSEL&$FF
	stz.b TMW&$FF
	stz.b MOSAIC&$FF
	stz.b SETINI&$FF
	stz.b TS&$FF
	stz.b TSW&$FF
	stz.b W12SEL&$FF
	stz.b W34SEL&$FF
	stz.b WOBJSEL&$FF
	stz.b $C8						; no PPU register here (as the game has it)
	lda.b #$E0
	sta.b COLDATA&$FF
	rep #$20
	pld
	pla
	rtl
Mul8U:								; A * X, 8 by 8 bits, unsigned, into A
	sep #$20
	sta.l WRMPYA
	txa
	sta.l WRMPYB
	rep #$20
	nop
	lda.l RDMPYL
	rtl
Mul8XS:								; A * X, 8 by 8 bits, X signed, into A
	cpx.w #$0000
	bpl Mul8U
	sep #$21
	sta.l WRMPYA
	txa
	eor.b #$FF
	inc a
	sta.l WRMPYB
	rep #$20
	lda.w #$0000
	sbc.l RDMPYL
	rtl
Mul8S:								; A * X, 8 by 8 bits, both signed, into A
	phy
	tay
	bpl .xsigned
	txa
	bpl .neg
	eor.w #$FFFF
	inc a
	sta.l WRMPYA
	tya
	eor.w #$FFFF
	inc a
	sta.l WRMPYB
	nop
	nop
	lda.l RDMPYL
	ply
	rtl
.xsigned:							; A positive: X decides
	cpx.w #$0000
	bpl .pos
.neg:								; one operand negative: negate the product
	sep #$21
	sta.l WRMPYA
	tya
	eor.b #$FF
	inc a
	sta.l WRMPYB
	rep #$20
	lda.w #$0000
	sbc.l RDMPYL
	ply
	rtl
.pos:								; both positive
	sep #$20
	sta.l WRMPYA
	txa
	sta.l WRMPYB
	rep #$20
	nop
	lda.l RDMPYL
	ply
	rtl
Mul16x8U_Pre:						; Mul16x8U from its second step, with Y saved
	phy
	bra Mul16x8U_go
Mul16x8U:							; X (16 bits) * A (8 bits) into r2, unsigned
	phy
	tay
	beq Mul16x8_Zero
	txa
	beq Mul16x8_Zero
Mul16x8U_go:						; entry used by the routines after it
	stz.b r2+2
	sep #$20
	sta.l WRMPYA
	tya
	sta.l WRMPYB
	xba
	sta.l WRMPYA
	rep #$21
	lda.l RDMPYL
	sta.b r2
	tax
	tya
	sta.l WRMPYB
	lda.b r2+1
	adc.l RDMPYL
	sta.b r2+1
	ply
	rtl
Mul16x8_Zero:						; product 0 into r2
	stz.b r2
	stz.b r2+2
	ply
	rtl
Mul16x8XS:							; X (16 bits) * A (8 bits) into r2, X signed
	phy
	tay
	beq Mul16x8_Zero
Mul16x8XS_neg:						; entry used by the routines after it
	txa
	beq Mul16x8_Zero
	bpl Mul16x8U_go
	eor.w #$FFFF
	inc a
Mul16x8XS_mul:						; entry used by the routines after it
	jsl.l Mul16x8U_Pre
Mul16x8XS_negres:					; entry used by the routines after it
	lda.w #$0000
	sec
	sbc.b r2
	sta.b r2
	lda.w #$0000
	sbc.b r2+2
	sta.b r2+2
	ply
	rtl
Mul16x8S:							; X (16 bits) * A (8 bits) into r2, both signed
	phy
	tay
	beq Mul16x8_Zero
	bpl Mul16x8XS_neg
	eor.w #$FFFF
	inc a
	tay
	txa
	beq Mul16x8_Zero
	bpl Mul16x8XS_mul
	eor.w #$FFFF
	inc a
	jmp.w Mul16x8U_go
Mul16x8HiU_Pre:						; Mul16x8HiU from its second step, with Y saved
	phy
	bra Mul16x8HiU_Go
Mul16x8HiU:							; X * A (low byte) / 256 into r2+1, unsigned
	phy
	tay
	beq Mul16x8Hi_Zero
	txa
	beq Mul16x8Hi_Zero
Mul16x8HiU_Go:						; entry used by the routines after it
	sep #$20
	sta.l WRMPYA
	tya
	sta.l WRMPYB
	stz.b r2+2
	xba
	sta.l WRMPYA
	lda.l RDMPYH
	sta.b r2+1
	tya
	sta.l WRMPYB
	rep #$21
	lda.b r2+1
	adc.l RDMPYL
	sta.b r2+1
	ply
	rtl
Mul16x8Hi_Zero:						; the zero result of the Mul16x8Hi forms: r2+1 = 0, pull Y
	stz.b r2+1
	ply
	rtl

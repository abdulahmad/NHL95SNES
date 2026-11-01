; Segment bankC0_1000: the sound driver (SMSG 3.07w) as upload blocks, sent after SoundRAMClear: an init
; block, then the main block (port 3 commands, the timer tick, the command queue, the music sequencer).
; Routines the code shows are named; the rest keep their sound RAM address as their name.

; sound driver variables (sound CPU direct page and RAM)
spcQueueWrite = $00					; write index of spcQueue
spcQueueRead = $01					; read index of spcQueue
spcArg0 = $0D						; port 0 when the command came
spcArg1 = $0E						; port 1
spcArg2 = $0F						; port 2
spcCmdIndex = $10					; the command number times 2
spcControl = $18					; what the command loop writes to SPC_CONTROL
spcENDX = $19						; DSP_ENDX at the last tick
spcStatus = $20						; port 2 status: bit 7 busy, bit 6 in the tick
spcQueue = $FF80					; queued commands, 4 bytes each: three arguments and the command
spcTcallVectors = $FFC0				; the tcall vectors, in the RAM under the boot ROM

org $C00F49
SoundDriver:						; sound CPU program as upload blocks (length, sound RAM address,
									; bytes; length 0 ends with the start address), sent after SoundRAMClear
	dw .initend-.initcode,.init
.initcode:							; the init block
	arch spc700
	base $1000
.init:								; the start address of the upload: runs once after it
	clrp
	mov x,#$1F
	mov sp,x
	mov.b SPC_CONTROL,#$30			; boot ROM off, ports cleared
	mov.b SPC_PORT3,#$7E			; busy
	mov y,#$08
.l100C:								; loop
	mov a,.dspregs-1+y
	mov.b SPC_DSPADDR,a
	mov a,.dspvalues-1+y
	mov.b SPC_DSPDATA,a
	dbnz y,.l100C
	mov y,#$50
	mov a,#$07
	clrc
.l101D:								; loop
	mov.b SPC_DSPADDR,a				; gain of every voice
	mov.b SPC_DSPDATA,y
	adc a,#$10
	cmp a,#$87
	bne .l101D
	mov y,#$00
	mov $21,y
	mov a,#$05
.l102D:								; loop
	mov.b SPC_DSPADDR,a				; ADSR off on every voice
	mov.b SPC_DSPDATA,y
	adc a,#$10
	cmp a,#$85
	bne .l102D
	mov a,y
	mov x,#$4F
.l103A:								; loop
	mov (x+),a
	cmp x,#$5F
	bne .l103A
	mov $15,a
	dec a
	mov x,#$5F
.l1044:								; loop
	mov (x+),a
	cmp x,#$6F
	bne .l1044
.l1049:								; loop
	mov a,.tcallvectors+y
	mov spcTcallVectors+y,a
	mov a,.tcallvectors+1+y
	mov spcTcallVectors+1+y,a
	inc y
	inc y
	cmp y,#$20
	bne .l1049
	mov.b spcControl,#$20
	mov.b SPC_DSPADDR,#DSP_ENDX
	mov.b a,SPC_DSPDATA
	mov.b spcENDX,a
	call .resetSound
	tcall 15
	mov a,#$7F						; ready: the CPU waits for this on port 3
	mov.b SPC_PORT3,a
.l106D:								; loop
	cbne.b SPC_PORT0,.l106D			; until the CPU echoes it on port 0
	mov.b SPC_PORT3,#$7E
	jmp .mainloop
.dspregs:							; DSP registers the init sets (read from the end down)
	db DSP_ENDX,DSP_PMON,DSP_KOF,DSP_KON,DSP_DIR,DSP_EFB,DSP_EON,DSP_NON
.dspvalues:							; their values: all voices keyed off, the sample directory page, rest 0
	db $00,$00,$FF,$00,$FE,$00,$00,$00
.tcallvectors:						; copied to spcTcallVectors: the handlers of tcall 15 down to 0
	dw .l0574,.l0467,.l04CD,.l0773,.l04DF,.l06A1,.l043F,.l038A
	dw .l049C,.l06FD,.l070F,.l03A3,.l03D5,.l09A9,.l09AD,.l0452
.version:							; the driver's name, version, authors and date
	db "SMSG 3.07w Jason Andersen/John Schappert 8/17/1994"
	base off
	arch 65816
.initend:							; the main block
	dw .mainend-.maincode,.mainloop
.maincode:							; its bytes
	arch spc700
	base $0120
.mainloop:							; from .l106D, .ticks, .cmdcall
	clr1.b spcStatus.7
	mov.b SPC_PORT2,spcStatus		; status to port 2
.poll:								; from .command, .l0140
	mov.b a,SPC_T0OUT				; timer 0 ticks since the last read
	beq .command
	set1.b spcStatus.7
	set1.b spcStatus.6
	mov.b SPC_PORT2,spcStatus
.ticks:								; loop
	push a
	call .tick
	pop a
	dec a
	bne .ticks
	clr1.b spcStatus.6
	bra .mainloop
.command:							; from .poll
	mov.b a,SPC_PORT3
	beq .poll
.l0140:								; loop
	mov.b a,SPC_PORT3
	cmp.b a,SPC_PORT3
	bne .l0140
	cmp a,#$21						; commands 1 to $20
	bcs .poll
	set1.b spcStatus.7
	mov.b SPC_PORT2,spcStatus
	asl a
	mov.b spcCmdIndex,a
	mov x,a
	mov a,.commands-2+x
	mov .cmdcall+1,a
	mov a,.commands-1+x
	mov .cmdcall+2,a
	mov.b a,SPC_PORT0
	mov.b x,SPC_PORT1
	mov.b y,SPC_PORT2
	mov.b spcArg0,a
	mov.b spcArg1,x
	mov.b spcArg2,y
	mov.b SPC_CONTROL,spcControl	; clear the ports
.cmdcall:							; operand set by .l0140
	call $FFFF
	bra .mainloop
.tick:								; called from .ticks
	mov a,$1B
	tset.w $001A,a
	mov $1B,#$00
	mov.b SPC_DSPADDR,#DSP_ENDX
	mov.b a,SPC_DSPDATA
	cmp.b a,spcENDX
	beq .l0194
	mov.b spcENDX,a
	mov a,$1C
	or a,$1A
	eor a,#$FF
	and.b a,spcENDX
	beq .l0194
	or a,$1A
	mov $1A,a
.l0194:								; from .tick
	mov x,#$07
.l0196:								; from .l01AD
	mov a,.voicebits+x
	and a,$1A
	bne .l01AD
	inc $5F+x
	bne .l01A3
	dec $5F+x
.l01A3:								; from .l0196
	mov a,$57+x
	beq .l01AD
	dec a
	mov $57+x,a
	bne .l01AD
	tcall 8
.l01AD:								; from .l0196, .l01A3
	dec x
	bpl .l0196
	tcall 13
	bcs .l01E8
	mov.b a,spcQueueRead
	cmp.b a,spcQueueWrite
	beq .l01E8
	mov x,a
	clrc
	adc a,#$04
	and a,#$3F
	mov.b spcQueueRead,a
	mov a,spcQueue+3+x
	bmi .l01E8
	mov y,a
	mov a,#$FF
	mov spcQueue+3+x,a
	mov a,.commands-2+y
	mov .queuecall+1,a
	mov a,.commands-1+y
	mov .queuecall+2,a
	mov a,spcQueue+2+x
	mov y,a
	mov a,spcQueue+x
	push a
	mov a,spcQueue+1+x
	mov x,a
	pop a
.queuecall:							; operand set by .l01AD
	call $FFFF
.l01E8:								; from .l01AD
	bbs $15.7,.l01EC
.l01EB:								; from .l01EC
	ret
.l01EC:								; from .l01E8
	bbs $15.4,.l01EB
	mov $24,$22
	mov $25,$23
.l01F5:								; from .l0244
	mov y,#$02
	mov a,($24)+y
	mov $31,a
	inc y
	mov a,($24)+y
	mov $32,a
	inc y
	mov a,($24)+y
	mov .l047C+1,a
	inc y
	mov a,($24)+y
	mov .l047C+2,a
	call .l09B9
	dec $09
	mov y,$09
.l0213:								; from .l023E, .l0241
	mov a,($37)+y
	cmp a,($39)+y
	bne .l021D
	cmp a,#$FF
	beq .l0241
.l021D:								; from .l0213
	dec a
	mov ($37)+y,a
	inc a
	bne .l0241
	mov a,($39)+y
	dec a
	mov ($39)+y,a
	bpl .l0241
	tcall 14
	asl a
	bcc .l0263
	mov x,a
	mov a,.events+x
	mov .eventcall+1,a
	mov a,.events+1+x
	mov .eventcall+2,a
.eventcall:							; operand set by .l021D
	call $FFFF
.l023E:								; from .l0263, .l036D
	tcall 9
	bra .l0213
.l0241:								; from .l0213, .l021D, .l043B
	dec y
	bpl .l0213
.l0244:								; from .l0405, .l0435
	call .l0A66
	mov y,#$00
	mov a,($24)+y
	mov $31,a
	inc y
	mov a,($24)+y
	mov $32,a
	mov a,#$FF
	mov y,a
	cmpw ya,$31
	beq .l0262
	movw ya,$31
	movw $24,ya
	movw.b SPC_PORT0,ya
	jmp .l01F5
.l0262:								; from .l0244
	ret
.l0263:								; from .l021D
	lsr a
	mov $13,a
	mov a,($33)+y
	push x
	mov x,a
	mov a,$F480+x
	pop x
	asl a
	mov x,a
	mov a,$FF00+x
	adc a,$13
	mov $14,a
	mov a,$FF01+x
	mov $16,a
	tcall 14
	mov $4D,a
	tcall 14
	mov $4E,a
	push y
	tcall 13
	pop y
	bcs .l023E
	mov $09,y
	push x
	push a
	or a,#$04
	mov.b SPC_DSPADDR,a
	mov a,($33)+y
	push x
	mov x,a
	mov a,$F480+x
	pop x
	mov.b SPC_DSPDATA,a
	asl a
	tcall 0
	asl a
	mov x,a
	pop a
	push a
	or a,#$00
	mov.b SPC_DSPADDR,a
	mov y,$4E
	mov a,$FD02+x
	mul ya
	push x
	mov x,#$7F
	div ya,x
	tcall 1
	pop x
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	mov y,$4E
	mov a,$FD03+x
	mul ya
	push x
	mov x,#$7F
	div ya,x
	tcall 1
	mov.b SPC_DSPDATA,a
	mov y,$09
	mov a,($35)+y
	lsr a
	pop x
	pop a
	or a,#$02
	mov.b SPC_DSPADDR,a
	bcs .l0331
	mov y,#$00
	mov $05,y
	mov a,$14
	mov x,#$0C
	div ya,x
	mov x,a
	mov a,.pitchhi+y
	mov $04,a
	mov a,.pitchlo+y
	dec x
	bmi .l02EA
.l02E2:								; loop
	asl a
	rol $04
	rol $05
	dec x
	bpl .l02E2
.l02EA:								; from .l0263
	movw ya,$04
	movw $02,ya
	lsr $05
	lsr a
	lsr $05
	lsr a
	lsr $05
	lsr a
	lsr $05
	lsr a
	mov $04,a
	mov y,a
	mov a,$16
	bpl .l0304
	eor a,#$FF
	inc a
.l0304:								; from .l02EA
	mov x,a
	mul ya
	movw $06,ya
	mov $08,#$00
	mov a,x
	mov y,$05
	mul ya
	addw ya,$07
	movw $07,ya
	asl $06
	asl $07
	asl $08
	movw ya,$02
	mov x,$16
	bpl .l0323
	subw ya,$07
	bra .l0325
.l0323:								; from .l0304
	addw ya,$07
.l0325:								; from .l0304
	movw $02,ya
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	mov.b SPC_DSPDATA,y
	mov y,$09
	bra .l034C
.l0331:								; from .l0263
	mov a,($33)+y
	push x
	mov x,a
	mov a,$F480+x
	pop x
	asl a
	asl a
	mov x,a
	mov a,$FD00+x
	mov.b SPC_DSPDATA,a
	mov $02,a
	inc.b SPC_DSPADDR
	mov a,$FD01+x
	mov.b SPC_DSPDATA,a
	mov $03,a
.l034C:								; from .l0325
	pop x
	mov a,$02
	mov $7F+x,a
	mov a,$03
	mov $87+x,a
	mov a,($35)+y
	asl a
	bcc .l0360
	mov a,.voicebits+x
	tset.w $001C,a
.l0360:								; from .l034C
	mov a,$4D
	mov $57+x,a
	mov a,($35)+y
	lsr a
	bcc .l036D
	mov a,#$00
	mov $57+x,a
.l036D:								; from .l0360
	mov a,($33)+y
	push x
	mov x,a
	mov a,$F480+x
	pop x
	mov $4F+x,a
	mov a,#$00
	mov $5F+x,a
	mov $67+x,y
	mov a,$24
	mov $6F+x,a
	mov a,$25
	mov $77+x,a
	tcall 4
	tcall 12
	jmp .l023E
.l038A:								; tcall 8
	mov a,.voicebits+x
	mov.b SPC_DSPADDR,#DSP_KOF
	mov.b SPC_DSPDATA,a
	tset.w $001B,a
	tclr.w $001C,a
	mov a,#$FF
	mov $67+x,a
	mov $4F+x,a
	mov $6F+x,a
	mov $77+x,a
.l03A2:								; event $81
	ret
.l03A3:								; tcall 4
	push y
	mov a,.voiceregs+x
	or a,#$02
	mov.b SPC_DSPADDR,a
	mov a,$7F+x
	mov $04,a
	mov $02,a
	mov a,$87+x
	mov $05,a
	lsr a
	ror $02
	mov $03,a
	mov a,($3F)+y
	bpl .l03CA
	eor a,#$FF
	inc a
	tcall 3
	movw $02,ya
	movw ya,$04
	subw ya,$02
	bra .l03CD
.l03CA:								; from .l03A3
	tcall 3
	addw ya,$04
.l03CD:								; from .l03A3
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	mov.b SPC_DSPDATA,y
	pop y
	ret
.l03D5:								; tcall 3
	asl a
	push a
	mov y,$02
	mul ya
	mov $02,y
	pop a
	mov y,$03
	mul ya
	mov $03,#$00
	addw ya,$02
	ret
.l03E6:								; event $82
	tcall 14
	mov ($3F)+y,a
	mov x,#$07
.l03EB:								; from .l03FD
	mov a,y
	cmp a,$67+x
	bne .l03FD
	mov a,$24
	cmp a,$6F+x
	bne .l03FD
	mov a,$25
	cmp a,$77+x
	bne .l03FD
	tcall 4
.l03FD:								; from .l03EB
	dec x
	bpl .l03EB
	ret
.l0401:								; event $83
	tcall 14
	mov ($3B)+y,a
	ret
.l0405:								; event $80
	mov a,#$FF
	mov ($37)+y,a
	mov ($39)+y,a
	pop a
	pop a
	push y
	clrc
	mov y,#$06
	mov a,($24)+y
	dec a
	mov ($24)+y,a
	bne .l043B
	pop y
	mov y,#$01
	mov a,($31)+y
	asl a
	bcc .l0435
	call .l05B0
	mov y,#$B7
	mov a,($24)+y
	push a
	call .l060E
	mov y,#$B7
	pop a
	mov ($24)+y,a
	set1 $15.7
	jmp .l0244
.l0435:								; from .l0405
	call .l05B0
	jmp .l0244
.l043B:								; from .l0405
	pop y
	jmp .l0241
.l043F:								; tcall 9
	tcall 14
	cmp a,#$FF
	bne .l044B
	tcall 14
	mov ($37)+y,a
	tcall 14
	mov ($39)+y,a
	ret
.l044B:								; from .l043F
	mov ($37)+y,a
	mov a,#$00
	mov ($39)+y,a
	ret
.l0452:								; tcall 0
	inc.b SPC_DSPADDR
	mov x,a
	mov a,$F580+x
	mov.b SPC_DSPDATA,a
	bmi .l045E
	inc.b SPC_DSPADDR
.l045E:								; from .l0452
	inc.b SPC_DSPADDR
	mov a,$F581+x
	mov.b SPC_DSPDATA,a
	mov a,x
	ret
.l0467:								; tcall 14
	push x
	mov x,#$00
	mov $1F,x
.l046C:								; loop
	inc x
	tcall 7
	bcc .l046C
	rol $1F
.l0472:								; loop
	tcall 7
	rol $1F
	dec x
	bne .l0472
	mov x,$1F
	dec x
	dec x
.l047C:								; operand set by .l01F5, .l0615
	mov a,$FFFF+x
	pop x
	ret
.l0481:								; no branch, call or table refers to it (a patched call may)
	mov a,($45)+y
	mov .l0498+1,a
	inc a
	mov ($45)+y,a
	bne .l0493
	mov a,($47)+y
	inc a
	mov ($47)+y,a
	dec a
	bra .l0495
.l0493:								; from .l0481
	mov a,($47)+y
.l0495:								; from .l0481
	mov .l0498+2,a
.l0498:								; operand set by .l0481, .l0495
	mov a,$FFFF
	ret
.l049C:								; tcall 7
	mov a,($41)+y
	dec a
	bpl .l04C5
	mov a,($45)+y
	mov .l04BA+1,a
	inc a
	mov ($45)+y,a
	bne .l04B5
	mov a,($47)+y
	mov .l04BA+2,a
	inc a
	mov ($47)+y,a
	bra .l04BA
.l04B5:								; from .l049C
	mov a,($47)+y
	mov .l04BA+2,a
.l04BA:								; from .l049C; operand set by .l049C, .l04B5
	mov a,$FFFF
	lsr a
	mov ($43)+y,a
	mov a,#$07
	mov ($41)+y,a
	ret
.l04C5:								; from .l049C
	mov ($41)+y,a
	mov a,($43)+y
	lsr a
	mov ($43)+y,a
	ret
.l04CD:								; tcall 13
	mov a,$1A
	mov x,#$07
.l04D1:								; loop
	asl a
	bcs .l04D9
	dec x
	bpl .l04D1
	setc
	ret
.l04D9:								; from .l04D1
	mov a,.voiceregs+x
	mov y,a
	clrc
	ret
.l04DF:								; tcall 11
	mov $09,a
	mov $0A,x
	mov x,#$07
.l04E5:								; loop
	cmp a,$4F+x
	beq .l04EE
	dec x
	bpl .l04E5
	setc
	ret
.l04EE:								; from .l04E5
	mov a,.voiceregs+x
	clrc
	ret
.commands:							; handlers of commands 1 to $20 (port 3, or a queued command)
	dw .playSound,.playSamplePitch,.playSampleVolume,.playSamplePacked
	dw .l0540,.fadeVoicesOut,.fadeVoicesIn,.setMasterVolume
	dw .stopSequences,.l056B,.l0830,.l0827,.setSequenceVolume,.setTickPeriod,.disableSamples,.enableSamples
	dw .stopSamples,.setSampleVolumeScale,.setSampleVolume,.setSamplePitch
	dw .setPlayingSampleVolume,.setPlayingSamplePitch,.stopSample,.resetSound
	dw .stopAndReceiveData,.receiveData,.bootrom,.keyOffAll,.reportVoiceAges,.l0540,.l054C,.commandNoOp
.events:							; handlers of music events $80 to $83
	dw .l0405,.l03A2,.l03E6,.l0401
.bootrom:							; command 27
	mov.b SPC_CONTROL,#$80			; boot ROM on
	pcall $C0
.l0540:								; command 5, 30
	mov x,#$7F
.l0542:								; loop
	mov.b SPC_DSPADDR,x
	mov.b a,SPC_DSPDATA
	mov $F000+x,a
	dec x
	bpl .l0542
.l054C:								; command 31
	mov.b SPC_PORT3,#$7F
	mov.b SPC_DSPADDR,#$0F
	mov a,#$C4
	mov.b SPC_DSPDATA,a
	mov a,#$2F
	mov $F8,a
	mov a,#$F9
	mov $F9,a
	mov a,#$E5
.l0560:								; loop
	cmp.b a,SPC_PORT1
	bne .l0560
	call.w $00F5
	mov.b SPC_PORT3,#$7E
	ret
.l056B:								; command 10; from .playSound
	mov a,$21
	beq .l0573
	set1 $15.7
	clr1 $15.4
.l0573:								; from .l056B
	ret
.l0574:								; tcall 15
	mov.b SPC_T0TARGET,$11
	set1.b spcControl.0
	mov.b SPC_CONTROL,spcControl
	mov.b a,SPC_T0OUT
	mov $21,#$00
	mov $22,#$FF
	mov $23,#$FF
	mov $26,#$27
	mov x,#$08
	mov $02,#$B8
	mov $03,#$00
	mov y,#$F7
	mov a,#$00
.l0596:								; loop
	mov $27+x,a
	mov $28+x,y
	addw ya,$02
	dec x
	dec x
	bpl .l0596
	call .keyOffAll
.l05A3:								; called from .l05B6, .l0615
	mov a,#$38
	tclr.w $0020,a
	mov a,$21
	xcn a
	lsr a
	tset.w $0020,a
	ret
.l05B0:								; called from .l0405, .l0435
	dec $21
	bne .l05B6
	clr1 $15.7
.l05B6:								; from .l05B0
	call .l05A3
	mov x,$26
	dec x
	dec x
	mov $26,x
	mov a,$24
	mov.b spcQueueWrite+x,a
	mov y,$25
	mov.b spcQueueRead+x,y
	cmpw ya,$22
	bne .l05D7
	mov y,#$00
	mov a,($24)+y
	mov $22,a
	inc y
	mov a,($24)+y
	mov $23,a
	ret
.l05D7:								; from .l05B6
	movw ya,$22
	movw $02,ya
	mov y,#$00
.l05DD:								; from .l05F4
	mov a,($02)+y
	cmp a,$24
	bne .l05F4
	inc y
	mov a,($02)+y
	cmp a,$25
	bne .l05F4
	mov a,($24)+y
	mov ($02)+y,a
	dec y
	mov a,($24)+y
	mov ($02)+y,a
	ret
.l05F4:								; from .l05DD
	mov y,#$01
	mov a,($02)+y
	mov x,a
	dec y
	mov a,($02)+y
	mov $02,a
	mov $03,x
	bra .l05DD
.l0602:								; called from .playSound
	asl a
	mov x,a
	mov a,$F600+x
	mov $31,a
	mov a,$F601+x
	mov $32,a
.l060E:								; called from .l0405
	mov a,$21
	cmp a,#$05
	bcc .l0615
	ret
.l0615:								; from .l060E
	inc $21
	call .l05A3
	mov x,$26
	mov.b a,spcQueueWrite+x
	mov $24,a
	mov.b a,spcQueueRead+x
	mov $25,a
	inc x
	inc x
	mov $26,x
	mov y,#$00
	mov a,$22
	mov ($24)+y,a
	inc y
	mov a,$23
	mov ($24)+y,a
	inc y
	mov a,$31
	mov ($24)+y,a
	inc y
	mov a,$32
	mov ($24)+y,a
	mov $22,$24
	mov $23,$25
	mov y,#$00
	mov a,($31)+y
	addw ya,$31
	mov $02,y
	mov y,#$04
	mov ($24)+y,a
	mov .l047C+1,a
	mov a,$02
	inc y
	mov ($24)+y,a
	mov .l047C+2,a
	call .l09B9
	mov a,$09
	mov y,#$06
	mov ($24)+y,a
	mov y,#$00
	mov a,$09
	addw ya,$35
	movw $02,ya
	mov x,#$00
	mov y,#$00
.l066F:								; loop
	clrc
	mov a,($02+x)
	adc a,$31
	mov ($49)+y,a
	mov ($45)+y,a
	incw $02
	mov a,($02+x)
	adc a,$32
	mov ($4B)+y,a
	mov ($47)+y,a
	incw $02
	inc y
	cmp y,$09
	bne .l066F
	mov y,$09
	dec y
.l068C:								; loop
	mov a,#$00
	mov ($41)+y,a
	mov ($3B)+y,a
	mov ($3D)+y,a
	mov ($3F)+y,a
	tcall 9
	dec y
	bpl .l068C
	mov y,#$B7
	mov a,$1E
	mov ($24)+y,a
	ret
.l06A1:								; tcall 10
	mov x,a
	mov a,$F480+x
	push a
	tcall 13
	bcs .l06D5
	or a,#$04
	mov.b SPC_DSPADDR,a
	mov a,#$00
	mov $5F+x,a
	mov $57+x,a
	dec a
	mov $67+x,a
	pop a
	mov $4F+x,a
	mov.b SPC_DSPDATA,a
	mov $09,x
	asl a
	tcall 0
	asl a
	mov x,a
	mov a,$FE02+x
	or a,$FE03+x
	beq .l06D3
	push x
	mov x,$09
	mov a,.voicebits+x
	tset.w $001C,a
	pop x
.l06D3:								; from .l06A1
	clrc
	ret
.l06D5:								; from .l06A1
	pop a
	asl a
	mov x,a
	mov a,$FF01+x
	beq .l06FB
	mov.b x,spcQueueWrite
	mov.b a,spcArg0
	mov spcQueue+x,a
	mov.b a,spcArg1
	mov spcQueue+1+x,a
	mov.b a,spcArg2
	mov spcQueue+2+x,a
	mov.b a,spcCmdIndex
	mov spcQueue+3+x,a
	mov a,x
	clrc
	adc a,#$04
	and a,#$3F
	mov.b spcQueueWrite,a
.l06FB:								; from .l06D5
	setc
	ret
.l06FD:								; tcall 6
	mov a,y
	or a,#$02
	mov.b SPC_DSPADDR,a
	mov a,$FD00+x
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	mov a,$FD01+x
	mov.b SPC_DSPDATA,a
	ret
.l070F:								; tcall 5
	mov a,y
	or a,#$00
	mov.b SPC_DSPADDR,a
	mov a,$FD02+x
	push y
	push x
	tcall 2
	pop x
	push x
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	mov a,$FD03+x
	tcall 2
	mov.b SPC_DSPDATA,a
.l0726:								; from .playSampleVolume
	pop x
	pop y
.l0728:								; from .playSampleVolume, .playSamplePitch, .l0769
	ret
.commandNoOp:						; Command 32: returns without changing state.
	ret
.playSampleVolume:					; Command 3: plays sample A with left/right volumes X/Y and the sample's
									; default pitch.
	bbs $15.5,.l0728
	push y
	push x
	tcall 10
	bcs .l0726
	tcall 6
	mov a,y
	or a,#$00
	mov.b SPC_DSPADDR,a
	pop a
	tcall 2
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	pop a
	tcall 2
	mov.b SPC_DSPDATA,a
	bra .l0771
.playSamplePitch:					; Command 2: plays sample A with pitch Y:X and the sample's default
									; volume.
	bbs $15.5,.l0728
	push y
	push x
	tcall 10
	bcc .l074F
.l074C:								; from .playSamplePacked
	pop x
	pop y
.l074E:								; from .l0769
	ret
.l074F:								; from .playSamplePitch
	tcall 5
	mov a,y
	or a,#$02
	mov.b SPC_DSPADDR,a
	pop a
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	pop a
	mov.b SPC_DSPDATA,a
	bra .l0771
.playSound:							; Command 1: starts sample A below $80, otherwise starts sequence A masked
									; to seven bits.
	cmp a,#$80
	bcc .l0769
	call .l0602
	jmp .l056B
.l0769:								; from .playSound
	bbs $15.5,.l0728
	tcall 10
	bcs .l074E
	tcall 6
	tcall 5
.l0771:								; from .playSampleVolume, .l074F, .l07BF
	mov x,$09
.l0773:								; tcall 12
	bbs $15.6,.l077B
	call .l07E5
	set1 $15.6
.l077B:								; from .l0773
	mov a,.voicebits+x
	mov.b SPC_DSPADDR,#DSP_KOF
	mov.b SPC_DSPDATA,#$00
	mov.b SPC_DSPADDR,#DSP_KON
	mov.b SPC_DSPDATA,a
	tclr.w $001A,a
.l078C:								; from .playSamplePacked
	ret
.playSamplePacked:					; Command 4: plays sample A with packed stereo volumes in X and signed
									; pitch offset Y times 16.
	bbs $15.5,.l078C
	push x
	push y
	tcall 10
	bcs .l074C
	mov $0A,y
	mov a,y
	or a,#$02
	mov.b SPC_DSPADDR,a
	mov a,$FD00+x
	mov $02,a
	mov a,$FD01+x
	mov $03,a
	mov y,#$10
	pop a
	mov x,a
	bmi .l07AF
	mul ya
	bra .l07BF
.l07AF:								; from .playSamplePacked
	eor a,#$FF
	inc a
	mul ya
	eor a,#$FF
	mov x,a
	mov a,y
	eor a,#$FF
	inc x
	bne .l07BD
	inc a
.l07BD:								; from .l07AF
	mov y,a
	mov a,x
.l07BF:								; from .playSamplePacked
	addw ya,$02
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	mov.b SPC_DSPDATA,y
	mov a,$0A
	or a,#$00
	mov.b SPC_DSPADDR,a
	pop a
	push a
	and a,#$0F
	asl a
	asl a
	asl a
	tcall 2
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	pop a
	xcn a
	and a,#$0F
	asl a
	asl a
	asl a
	tcall 2
	mov.b SPC_DSPDATA,a
	bra .l0771
.l07E5:								; called from .l0773
	mov.b SPC_DSPADDR,#DSP_FLG
	mov.b SPC_DSPDATA,#$20
	ret
.disableSamples:					; Command 15: blocks sample starts, then stops sample voices and clears
									; spcQueue.
	set1 $15.5
.stopSamples:						; Command 17: keys off voices without a sequence channel and clears
									; spcQueue.
	mov x,#$07
.l07F0:								; from .l07F6
	mov.w a,$0067+x
	bpl .l07F6
	tcall 8
.l07F6:								; from .l07F0
	dec x
	bpl .l07F0
.l07F9:								; called from .resetSound
	mov a,#$00
	mov.b spcQueueWrite,a
	mov.b spcQueueRead,a
	ret
.enableSamples:						; Command 16: allows sample starts again.
	clr1 $15.5
	ret
.resetSound:						; Command 24: resets volumes, tick period, playback flags, sequence state
									; and spcQueue.
	mov a,#$7F
	mov $1D,a
	mov $1E,a
	mov x,a
	mov y,a
	call .setMasterVolume
	mov $11,#$A0
	clr1 $15.7
	clr1 $15.5
	clr1 $15.4
	tcall 15
	call .l07F9
.keyOffAll:							; Command 28: keys off each DSP voice through tcall 8.
	mov x,#$07
.l081D:								; loop
	tcall 8
	dec x
	bpl .l081D
	ret
.setTickPeriod:						; Command 14: writes A to SPC_T0TARGET and saves it for timer resets.
	mov.b SPC_T0TARGET,a
	mov $11,a
	ret
.l0827:								; command 12
	bbc $15.4,.l082F
	mov $15,$17
	clr1 $15.4
.l082F:								; from .l0827, .l0830
	ret
.l0830:								; command 11
	bbs $15.4,.l082F
	mov $17,$15
	set1 $15.4
.stopSequences:						; Command 9: clears sequence playback and resets sequence state, keying
									; off all voices.
	clr1 $15.7
	tcall 15
	ret
.fadeVoicesOut:						; Command 6: saves voice volumes, then steps each left and right volume
									; down to zero.
	mov x,#$07
.l083E:								; loop
	mov a,.voiceregs+x
	or a,#$00
	mov.b SPC_DSPADDR,a
	mov.b a,SPC_DSPDATA
	mov $FFE0+x,a
	inc.b SPC_DSPADDR
	mov.b a,SPC_DSPDATA
	mov $FFE8+x,a
	dec x
	bpl .l083E
	mov y,#$80
.l0856:								; from .l0871
	mov x,#$07
.l0858:								; from .l0871
	mov a,.voiceregs+x
	or a,#$00
	mov.b SPC_DSPADDR,a
	mov.b a,SPC_DSPDATA
	dec a
	bpl .l0866
	mov a,#$00
.l0866:								; from .l0858
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	mov.b a,SPC_DSPDATA
	dec a
	bpl .l0871
	mov a,#$00
.l0871:								; from .l0866
	mov.b SPC_DSPDATA,a
	dec x
	bpl .l0858
	dbnz y,.l0856
	ret
.fadeVoicesIn:						; Command 7: steps voice volumes up to the values saved by .fadeVoicesOut.
	mov y,#$80
.l087B:								; from .l089E
	mov x,#$07
.l087D:								; from .l089E
	mov a,.voiceregs+x
	or a,#$00
	mov.b SPC_DSPADDR,a
	mov.b a,SPC_DSPDATA
	inc a
	cmp a,$FFE0+x
	bcc .l088F
	mov a,$FFE0+x
.l088F:								; from .l087D
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	mov.b a,SPC_DSPDATA
	inc a
	cmp a,$FFE8+x
	bcc .l089E
	mov a,$FFE8+x
.l089E:								; from .l088F
	mov.b SPC_DSPDATA,a
	dec x
	bpl .l087D
	dbnz y,.l087B
	ret
.stopSample:						; Command 23: keys off a matching sample voice, or invalidates the first
									; matching queued command.
	tcall 11
	bcs .l08AB
	tcall 8
	ret
.l08AB:								; from .stopSample
	mov.b a,spcQueueRead
.l08AD:								; from .l08BF
	mov x,a
	cmp.b x,spcQueueWrite
	beq .l08BE
	mov a,$09
	cmp a,spcQueue+x
	bne .l08BF
	mov a,#$FF
	mov spcQueue+3+x,a
.l08BE:								; from .l08AD
	ret
.l08BF:								; from .l08AD
	mov a,x
	clrc
	adc a,#$04
	and a,#$3F
	bra .l08AD
.setSampleVolumeScale:				; Command 18: sets the volume multiplier used when starting samples.
	mov $1D,a
	ret
.setSequenceVolume:					; Command 13: sets the volume copied into subsequently started sequence
									; contexts.
	mov $1E,a
.l08CC:								; from .setPlayingSampleVolume
	ret
.setPlayingSampleVolume:			; Command 21: updates a matching voice's volumes, then its sample slot
									; defaults.
	tcall 11
	bcs .l08CC
	or a,#$00
	mov.b SPC_DSPADDR,a
	mov x,$0A
	mov a,x
	and a,$1D
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	mov a,y
	and a,$1D
	mov.b SPC_DSPDATA,a
	mov a,$09
.setSampleVolume:					; Command 19: writes X/Y as the default left/right volume for driver
									; sample slot A.
	asl a
	asl a
	push a
	mov a,x
	pop x
	mov $FD02+x,a
	mov a,y
	mov $FD03+x,a
.l08F0:								; from .setPlayingSamplePitch
	ret
.setPlayingSamplePitch:				; Command 22: updates a matching voice's pitch, then its sample slot
									; default.
	tcall 11
	bcs .l08F0
	or a,#$02
	mov.b SPC_DSPADDR,a
	mov x,$0A
	mov.b SPC_DSPDATA,x
	inc.b SPC_DSPADDR
	mov.b SPC_DSPDATA,y
	mov a,$09
.setSamplePitch:					; Command 20: writes Y:X as the default pitch for driver sample slot A.
	asl a
	asl a
	push a
	mov a,x
	pop x
	mov $FD00+x,a
	mov a,y
	mov $FD01+x,a
	ret
.setMasterVolume:					; Command 8: writes X/Y to DSP_MVOLL/DSP_MVOLR.
	mov.b SPC_DSPADDR,#DSP_MVOLL
	mov.b SPC_DSPDATA,x
	mov.b SPC_DSPADDR,#DSP_MVOLR
	mov.b SPC_DSPDATA,y
	ret
.stopAndReceiveData:				; Command 25: stops playback and receives bytes into sound RAM starting at
									; Y:X.
	push x
	push y
	call .stopSequences
	call .keyOffAll
	tcall 15
	pop y
	pop x
.receiveData:						; Command 26: receives port 0-2 byte groups at Y:X; port 3 controls
									; acknowledgement and final length.
	mov .l094C+2,y
	mov .l095D+2,y
	mov .l0970+2,y
	mov .l094C+1,x
	mov .l095D+1,x
	mov .l0970+1,x
	mov a,#$00
	mov y,a
	mov x,a
	mov.b SPC_PORT3,x
.l093D:								; from .l0970; loop
	mov.b SPC_PORT2,x
	mov.b SPC_PORT1,SPC_PORT3
	cmp.b x,SPC_PORT3
	beq .l093D
	mov.b x,SPC_PORT3
	bmi .l0981
	mov.b a,SPC_PORT0
.l094C:								; operand set by .receiveData, .l094C, .l095D, .l0970, .l0981
	mov $FFFF+y,a
	inc y
	bne .l095B
	inc .l094C+2
	inc .l095D+2
	inc .l0970+2
.l095B:								; from .l094C
	mov.b a,SPC_PORT1
.l095D:								; operand set by .receiveData, .l094C, .l095D, .l0970
	mov $FFFF+y,a
	inc y
	bne .l096C
	inc .l094C+2
	inc .l095D+2
	inc .l0970+2
.l096C:								; from .l095D
	mov.b SPC_PORT3,x
	mov.b a,SPC_PORT2
.l0970:								; operand set by .receiveData, .l094C, .l095D, .l0970
	mov $FFFF+y,a
	inc y
	bne .l093D
	inc .l094C+2
	inc .l095D+2
	inc .l0970+2
	bra .l093D
.l0981:								; from .l093D
	mov a,.l094C+1
	mov $09,a
	mov a,.l094C+2
	mov $0A,a
	mov a,x
	and a,#$7F
	mov x,a
	mov.b a,SPC_PORT0
	mov ($09)+y,a
	dec x
	beq .l09A5
	incw $09
	mov.b a,SPC_PORT1
	mov ($09)+y,a
	dec x
	beq .l09A5
	incw $09
	mov.b a,SPC_PORT2
	mov ($09)+y,a
.l09A5:								; from .l0981
	mov.b SPC_PORT3,#$7E
	ret
.l09A9:								; tcall 2
	mov y,$1D
	bra .l09B4
.l09AD:								; tcall 1
	mov y,#$B7
	mov x,a
	mov a,($24)+y
	mov y,a
	mov a,x
.l09B4:								; from .l09A9
	mul ya
	mov x,#$7F
	div ya,x
	ret
.l09B9:								; called from .l01F5, .l0615
	mov y,#$00
	mov a,($31)+y
	bne .l09C8
	mov a,#$81
	mov $FFC2,a
	mov a,#$04
	bra .l09CF
.l09C8:								; from .l09B9
	mov a,#$67
	mov $FFC2,a
	mov a,#$04
.l09CF:								; from .l09B9
	mov $FFC3,a
	mov a,#$02
	addw ya,$31
	movw $33,ya
	mov y,#$01
	mov a,($31)+y
	and a,#$7F
	mov $09,a
	mov y,#$00
	addw ya,$33
	movw $35,ya
	mov $02,#$10
	mov y,#$00
	mov $03,y
	mov a,#$07
	addw ya,$24
	movw $37,ya
	addw ya,$02
	movw $39,ya
	addw ya,$02
	movw $3B,ya
	addw ya,$02
	movw $3D,ya
	addw ya,$02
	movw $3F,ya
	addw ya,$02
	movw $41,ya
	addw ya,$02
	movw $43,ya
	addw ya,$02
	movw $45,ya
	addw ya,$02
	movw $47,ya
	addw ya,$02
	movw $49,ya
	addw ya,$02
	movw $4B,ya
	ret
.reportVoiceAges:					; Command 29: returns packed, inverted voice ages and the free-voice mask
									; through the ports.
	mov x,#$08
	mov y,#$04
.l0A20:								; from .l0A3D
	mov a,$5E+x
	cmp a,#$10
	bcc .l0A2B
	mov $09,#$00
	bra .l0A30
.l0A2B:								; from .l0A20
	eor a,#$0F
	xcn a
	mov $09,a
.l0A30:								; from .l0A20
	dec x
	mov a,$5E+x
	cmp a,#$10
	bcc .l0A3B
	mov a,#$00
	bra .l0A3D
.l0A3B:								; from .l0A30
	eor a,#$0F
.l0A3D:								; from .l0A30
	or a,$09
	mov.w $008E+y,a
	dec x
	dbnz y,.l0A20
	mov.b SPC_PORT0,$8F
	mov.b SPC_PORT1,$90
	mov.b SPC_PORT2,$1A
	mov a,#$7F
	mov.b SPC_PORT3,a
.l0A52:								; loop
	cbne.b SPC_PORT3,.l0A52
	mov.b SPC_PORT0,$91
	mov.b SPC_PORT1,$92
	mov a,#$00
	mov.b SPC_PORT3,a
.l0A5F:								; loop
	cbne.b SPC_PORT3,.l0A5F
	mov.b SPC_PORT3,#$7E
	ret
.l0A66:								; called from .l0244
	mov x,#$07
.l0A68:								; from .l0AC0
	mov y,$67+x
	bmi .l0AC0
	mov a,$24
	cmp a,$6F+x
	bne .l0AC0
	mov a,$25
	cmp a,$77+x
	bne .l0AC0
	mov a,($3F)+y
	bne .l0AC0
	push x
	mov a,($3B)+y
	asl a
	asl a
	mov x,a
	mov a,($3D)+y
	clrc
	adc a,#$07
	mov ($3D)+y,a
	mov $03,#$00
	push x
	and a,#$3F
	mov x,a
	mov a,.sine+x
	pop y
	bmi .l0A9C
	mul ya
	mov x,#$7F
	div ya,x
	bra .l0AAA
.l0A9C:								; from .l0A68
	eor a,#$FF
	inc a
	mul ya
	mov x,#$7F
	div ya,x
	beq .l0AAA
	eor a,#$FF
	inc a
	dec $03
.l0AAA:								; from .l0A68, .l0A9C
	mov $02,a
	pop x
	mov a,.voiceregs+x
	or a,#$02
	mov.b SPC_DSPADDR,a
	mov y,$87+x
	mov a,$7F+x
	addw ya,$02
	mov.b SPC_DSPDATA,a
	inc.b SPC_DSPADDR
	mov.b SPC_DSPDATA,y
.l0AC0:								; from .l0A68
	dec x
	bpl .l0A68
	ret
.voicebits:							; the bit of each voice
	db $01,$02,$04,$08,$10,$20,$40,$80
.voiceregs:							; the DSP register base of each voice
	db $00,$10,$20,$30,$40,$50,$60,$70
.pitchlo:							; pitch of the 12 notes of an octave, a semitone apart: low bytes
	db $82,$27,$F5,$ED,$13,$69,$F1,$AF,$A6,$DA,$4D,$05
.pitchhi:							; high bytes
	db $2C,$2F,$31,$34,$38,$3B,$3E,$42,$46,$4A,$4F,$54
.sine:								; one sine period, signed
	db $00,$02,$04,$06,$08,$0A,$0C,$0D,$0F,$10,$11,$13,$13,$14,$15,$15
	db $15,$15,$15,$14,$13,$13,$11,$10,$0F,$0D,$0C,$0A,$08,$06,$04,$02
	db $00,$FE,$FC,$FA,$F8,$F6,$F4,$F3,$F1,$F0,$EF,$ED,$ED,$EC,$EB,$EB
	db $EB,$EB,$EB,$EC,$ED,$ED,$EF,$F0,$F1,$F3,$F4,$F6,$F8,$FA,$FC,$FE
	base off
	arch 65816
.mainend:							; end block: start at .init
	dw $0000,.init

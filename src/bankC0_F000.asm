; Segment bankC0_F000: the last sound sample of bank $C0, the interrupt and reset entry points the vectors use
; (they run in bank $00), fill, the extended and the internal cartridge header, then the vectors.
org $C0F288
Sample15:							; sound sample 15 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_F000.bin":$288..$D0E
Reset:								; reset vector: native mode, decimal off, 16-bit A and index, then the
									; rest of the reset in FastROM
	sei
	clc
	xce
	rep #$39						; 16-bit A and index, decimal and carry clear
	jml.l $C580C6
NullInterrupt:						; the COP and ABORT vectors: return at once
	rti
NMI:								; NMI vector: jml NMI_Fast
	jml.l NMI_Fast
BRKHandler:							; BRK vector: a cop, so the COP vector (NullInterrupt) returns past it;
									; the fill comes after it
	cop #$00
	padbyte $CD						; unused up to the extended header
	pad $C0FFB0
ExtHeader:							; extended cartridge header (CartHeader says it is there)
	db "69"							; maker code: Electronic Arts
	db "ANHE"						; game code
	db $00,$00,$00,$00,$00,$00,$00	; reserved
	db $00							; expansion RAM: none
	db $00							; special version
	db $00							; cartridge sub-type
CartHeader:							; cartridge header: the console and copiers read it
	db "NHL '95              "		; title, 21 characters
	db $31							; map mode: HiROM, FastROM
	db $02							; cartridge type: ROM, RAM and battery
	db $0A							; ROM size: 1 MB
	db $03							; SRAM size: 8 KB
	db $01							; region: North America
	db $33							; maker code follows in the extended header
	db $00							; version 1.0
	dw $7E7E						; checksum complement
	dw $8181						; checksum
	db $FF,$FF,$00,$00				; native mode vectors: 4 unused bytes
	dw NullInterrupt&$FFFF			; COP
	dw BRKHandler&$FFFF				; BRK
	dw NullInterrupt&$FFFF			; ABORT
	dw NMI&$FFFF					; NMI
	dw Reset&$FFFF					; (unused)
	dw $18A6						; IRQ: an entry in RAM (not traced)
	db "JAWA"						; emulation mode vectors: 4 unused bytes
	dw NullInterrupt&$FFFF			; COP
	dw BRKHandler&$FFFF				; (unused)
	dw NullInterrupt&$FFFF			; ABORT
	dw NMI&$FFFF					; NMI
	dw Reset&$FFFF					; RESET
	dw $18A6						; IRQ / BRK: the RAM entry

; Segment bankC0_F000: not yet disassembled, except the cartridge header at the end of the bank.
org $C0F000
	incbin "../Extracted/segments/bankC0_F000.bin":0..$FC0
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
	incbin "../Extracted/segments/bankC0_F000.bin":$FE0..$1000	; native and emulation mode vectors

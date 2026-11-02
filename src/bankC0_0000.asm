; Segment bankC0_0000: data read with long addresses. The team palettes and three tile sets, packed for the
; game's unpacker (size word, format word, then the stream as a ROM cut), an unused palette, and a
; sound CPU program sent before the sound driver: it clears sound RAM and returns to the boot ROM.
org $C00000
TeamPalettes:						; one 16 colour palette per team in team order (the all-star teams last):
									; two shade ramps in the team colours and a gold; unpacked to RAM, from
									; where the palettes of two team numbers go to CGRAM
	dw $0380						; unpacked size in bytes
	dw $0002						; format 2: literal runs and copies from up to 10 bits back
	incbin "../Extracted/segments/bankC0_0000.bin":4..$27E
ArrowFontTiles:						; 4bpp tiles, packed: a two colour font, ASCII from the space, with
									; four arrows in place of ^ _ ~ and the last character
	dw $0C00						; unpacked size in bytes
	dw $0004						; format 4: literal runs and copies from up to 11 bits back
	incbin "../Extracted/segments/bankC0_0000.bin":$282..$83D
GradientBarTiles:					; 4bpp tiles, packed: bars shaded from dark to light
	dw $0240						; unpacked size in bytes
	dw $0002						; format 2: literal runs and copies from up to 10 bits back
	incbin "../Extracted/segments/bankC0_0000.bin":$841..$976
MeterFontTiles:						; 4bpp tiles, packed: meter bars in three colours, a PwrPlay label,
									; box corners, then a font, ASCII from the space
	dw $1000						; unpacked size in bytes
	dw $0006						; format 6: a flag byte per 8 literal runs or copies, up to 11 bits back
	incbin "../Extracted/segments/bankC0_0000.bin":$97A..$EE5
UnusedPalette:						; 16 colours: blue, black, slate, white, green, yellow, red, then magenta;
									; no code refers to it
	dw $7C00,$0000,$45CB,$7FFF,$03E0,$03FF,$001F,$7C1F
	dw $7C1F,$7C1F,$7C1F,$7C1F,$7C1F,$7C1F,$7C1F,$7C1F
SoundRAMClear:						; sound CPU program as upload blocks (length, sound RAM address, bytes;
									; length 0 ends with the start address): sent before the sound driver,
									; it silences the DSP, clears sound RAM and returns to the boot ROM
	dw .end-.code,.start
.code:								; the block's bytes
	arch spc700
	base $0020
.start:								; DSP muted, echo buffer set, sound RAM above the program cleared
	clrp
	mov.b SPC_DSPADDR,#DSP_FLG
	mov.b SPC_DSPDATA,#$FF			; reset, mute, echo writes off
	mov.b SPC_DSPADDR,#DSP_ESA
	mov.b SPC_DSPDATA,#$20			; echo buffer page
	mov.b SPC_DSPADDR,#DSP_EDL
	mov.b SPC_DSPDATA,#$01			; echo delay
	mov a,#$00
	mov y,#$FE						; pages to clear
	mov x,a
.loop:								; clear a page; the store's high address byte is the page number
	mov $0100+x,a
	inc x
	bne .loop
	inc.b .loop+2					; next page
	dec y
	bne .loop
	mov.b SPC_DSPADDR,#DSP_EVOLL	; echo and main volumes 0
	mov.b SPC_DSPDATA,a
	mov.b SPC_DSPADDR,#DSP_EVOLR
	mov.b SPC_DSPDATA,a
	mov.b SPC_DSPADDR,#DSP_MVOLL
	mov.b SPC_DSPDATA,a
	mov.b SPC_DSPADDR,#DSP_MVOLR
	mov.b SPC_DSPDATA,a
	mov.b SPC_CONTROL,#$B0			; boot ROM on, ports cleared, timers off
	pcall SPC_IPLROM-$FF00			; boot ROM: wait for the next upload
	base off
	arch 65816
.end:								; end block: start at .start
	dw $0000,.start

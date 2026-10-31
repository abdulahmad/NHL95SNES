;	Segment build for bankC5_8000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_8000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
WaitFrame = $C08D7E
ScreenOn = $C08E99
BlankScreen = $C08E74
ClearFrameHook = $C08D4A
ClearNMIHook = $C08D64
SetNMIHook = $C08D73
SetFrameHook = $C08D59
forceblack = $C08E93
ResetPPURegs = $C08E9D
IRQOff = $C08CFC
SetIRQ = $C08D16
RandomWord = $C08E48
Mul8U = $C08ED9

incsrc "../bankC5_8000.asm"

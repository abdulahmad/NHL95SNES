;	Segment build for bankC5_8000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_8000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C55EC7 = $C55EC7
Opening = $C50000
BuildSpriteOAM = $C5F0D1
CODE_C5F3DB = $C5F3DB
AnimateSprites = $C5E9C7
CODE_C5E50E = $C5E50E
CODE_C5B67A = $C5B67A
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
CODE_C58FD8 = $C58FD8
CODE_C59012 = $C59012
CODE_C59052 = $C59052
CODE_C5909A = $C5909A
CODE_C590B8 = $C590B8
CODE_C590DA = $C590DA
CODE_C5939D = $C5939D
CODE_C593B1 = $C593B1
CODE_C59588 = $C59588
CODE_C59643 = $C59643

incsrc "../bankC5_8000.asm"

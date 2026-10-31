;	Segment build for bankC5_9000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_9000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C5B67A = $C5B67A
CODE_C5BBC0 = $C5BBC0
CODE_C59F79 = $C59F79
CODE_C5A07A = $C5A07A
CODE_C5A09B = $C5A09B
CODE_C5A164 = $C5A164
CODE_C5A17B = $C5A17B
CODE_C5A20D = $C5A20D
CODE_C5A291 = $C5A291
CODE_C5A2B4 = $C5A2B4
CODE_C5A2D3 = $C5A2D3
CODE_C5A2EC = $C5A2EC
CODE_C5A3C1 = $C5A3C1
CODE_C5A4B9 = $C5A4B9
CODE_C5A4E2 = $C5A4E2
CODE_C5A50B = $C5A50B
CODE_C5A51C = $C5A51C
CODE_C5ABC4 = $C5ABC4
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
CODE_C5852B = $C5852B
CODE_C589B0 = $C589B0
CODE_C589E4 = $C589E4
CODE_C58B11 = $C58B11
CODE_C58D05 = $C58D05
CODE_C58D32 = $C58D32
CODE_C58F75 = $C58F75
Decompress = $C581E1
DecompressUnpackbuf = $C581D7
FadeOutWait = $C58A99
SetupHDMA = $C58AA5

incsrc "../bankC5_9000.asm"

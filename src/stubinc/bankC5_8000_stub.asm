;	Segment build for bankC5_8000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_8000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C36B83 = $C36B83
ReadMenuPads = $C36C2D
SendTextMap = $C4C2AA
UnpackText = $C4C3BA
ResetWorkBuf = $C4C530
AllocWorkBuf = $C4C558
AllocWorkBuf2 = $C4C561
FreeWorkBuf = $C4C56A
WaitTransfers = $C4CEDB
CODE_C4CEF5 = $C4CEF5
PrintBoldCentred = $C4BBE5
PrintBoldCentredStr = $C4BBF1
PrintItalicLeft = $C4BC26
PrintItalicCentred = $C4BCA4
PrintItalicRight = $C4BCBC
CODE_C5611C = $C5611C
BCDText = $C55EC7
Opening = $C50000
BuildSpriteOAM = $C5F0D1
PackOAMHigh = $C5F3DB
AnimateSprites = $C5E9C7
CODE_C5E50E = $C5E50E
BinToBCD = $C5B67A
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
setoptions = $C590DA
CODE_C5939D = $C5939D
CODE_C593B1 = $C593B1
StartSeason = $C59588
CreatePlayer = $C59643
TradePlayers = $C5CA6C
SignFreeAgents = $C5C109
ReleasePlayers = $C5C722
CODE_C5ABA1 = $C5ABA1

incsrc "../bankC5_8000.asm"

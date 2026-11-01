;	Segment build for bankC4_E000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_E000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_CF0134 = $CF0134
CODE_CF039E = $CF039E
CODE_CF03D0 = $CF03D0
CODE_CF040B = $CF040B
StanleyCupMap = $CEF3E9				; the Stanley Cup map set
CODE_C387D8 = $C387D8
DATA8_C3585C = $C3585C
DATA8_C35E51 = $C35E51
CODE_C36C2D = $C36C2D
CODE_C4F01E = $C4F01E
CODE_C4F2AE = $C4F2AE
AnimateSprites = $C5E9C7
BlueColoursHook = $C04A65
BuildSpriteOAM = $C5F0D1
CODE_C4BAF6 = $C4BAF6
PrintBoldCentred = $C4BBE5
PrintBoldCentredStr = $C4BBF1
PrintBoldLeftStr = $C4BC08
PrintBoldRightStr = $C4BC1A
PrintItalicCentred = $C4BCA4
PrintThinCentred = $C4BCAA
PrintTitle = $C4BDAE
CODE_C4C2AA = $C4C2AA
UnpackText = $C4C3BA
ResetWorkBuf = $C4C530
RestoreWorkBuf = $C4C536
MarkWorkBuf = $C4C541
AllocClearWorkBuf = $C4C547
AllocWorkBuf = $C4C558
CODE_C4CEDB = $C4CEDB
CODE_C4D773 = $C4D773
CODE_C55AB8 = $C55AB8
CODE_C55C54 = $C55C54
CODE_C55EC3 = $C55EC3
CODE_C55F8A = $C55F8A
CODE_C56005 = $C56005
CODE_C560A8 = $C560A8
CODE_C571C7 = $C571C7
CODE_C5881C = $C5881C
CODE_C589B0 = $C589B0
CODE_C589E4 = $C589E4
ClearRAM7E = $C58B11
CODE_C5A4B5 = $C5A4B5
CODE_C5A4DE = $C5A4DE
CODE_C5B676 = $C5B676
CODE_C5BBBC = $C5BBBC
CODE_C5E50E = $C5E50E
CODE_C5E596 = $C5E596
CODE_C5F3DB = $C5F3DB
ClearNMIHook = $C08D64
CreateSprite = $C5E665
Decompress = $C581E1
FadeOutWait = $C58A99
MapSetToVRAM = $C58527
SetNMIHook = $C08D73
SetupHDMA = $C58AA5
DATA8_CF05D4 = $CF05D4
TiledBackMap = $C087F2

incsrc "../bankC4_E000.asm"

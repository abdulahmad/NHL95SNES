;	Segment build for bankC5_B000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_B000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
MapTileBlock = $C387D8
DATA8_C3585C = $C3585C
DATA8_C360D4 = $C360D4
PlayerList = $C30038
DATA8_C4C4A6 = $C4C4A6
SendTextMap = $C4C2AA
UnpackText = $C4C3BA
ResetWorkBuf = $C4C530
MarkWorkBuf = $C4C541
AllocClearWorkBuf = $C4C547
AllocWorkBuf = $C4C558
WaitTransfers = $C4CEDB
InitTextMap = $C4BAF6
PrintTextPage = $C4BB5A
PrintBoldLeft = $C4BBFC
PrintBoldLeftStr = $C4BC08
PrintBoldRight = $C4BC0E
PrintBoldRightStr = $C4BC1A
PrintItalicRightStr = $C4BC20
PrintItalicCentred = $C4BCA4
PrintThinCentred = $C4BCAA
StartScrollList = $C55ABC
BCDText = $C55EC7
BCDTextAt = $C55ECA
FitNameToWorkBuf = $C55F8A
UnpackFitName = $C55F98
LoadGameRosters = $C52CC1
BCDTable = $C08C76
DivisionNames = $C04CB7
Div32x32U = $C09113
Mul16U = $C0906C
Mul16x8U = $C08F5E
BuildSpriteOAM = $C5F0D1
PackOAMHigh = $C5F3DB
AnimateSprites = $C5E9C7
CODE_C5E37E = $C5E37E
DeleteSprite = $C5E596
CreateSprite = $C5E665
CreatedPlayerBits = $C5D7CD
NextSaveBits3 = $C5D7E9
NextSaveBits5 = $C5D804
KeepDivisionTeams = $C5BFE0
SortStandingsByStat = $C5C029
ClearVRAM = $C589B0
QueueClearVRAM = $C589E4
ClearRAM7E = $C58B11
BCDDigits4 = $C5A321
QueueHomePalette = $C5A4B9
FadeOutWait = $C58A99
Mul8U = $C08ED9

incsrc "../bankC5_B000.asm"

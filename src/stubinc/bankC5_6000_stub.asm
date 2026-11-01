;	Segment build for bankC5_6000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_6000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
MapTileBlock = $C387D8
DATA8_C3585C = $C3585C
DATA8_C35E25 = $C35E25
DATA8_C35E2D = $C35E2D
DATA8_C35F60 = $C35F60
ReadMenuPads = $C36C2D
DATA8_C34499 = $C34499
SendTextMap = $C4C2AA
UnpackText = $C4C3BA
AllocWorkBuf = $C4C558
WaitTransfers = $C4CEDB
PrintTextPage = $C4BB5A
PrintBoldCentred = $C4BBE5
PrintBoldCentredStr = $C4BBF1
PrintBoldLeft = $C4BBFC
PrintBoldLeftStr = $C4BC08
PrintBoldRightStr = $C4BC1A
PrintItalicLeft = $C4BC26
PrintItalicCentred = $C4BCA4
PrintTitleBar = $C4BDE6
CODE_C56F5C = $C56F5C
AnimateSprites = $C5E9C7
BCDTable = $C08C76
BuildSpriteOAM = $C5F0D1
CODE_C5004E = $C5004E
GetPadTeam = $C53ABC
reenergizeteam = $C54AEF
CODE_C54FA9 = $C54FA9
CODE_C552AC = $C552AC
SetupScreen = $C55951
ExitToPauseMenu = $C55A09
SetupStatsPage = $C55A40
StartScrollList = $C55ABC
ScrollListArrows = $C55BE8
CODE_C55C12 = $C55C12
ScrollListDown = $C55C58
ScrollListUp = $C55CE6
CODE_C55E57 = $C55E57
BCDText = $C55EC7
BCDTextAt = $C55ECA
CODE_C55F1F = $C55F1F
ClearRAM7E = $C58B11
CODE_C58BB9 = $C58BB9
CODE_C5A321 = $C5A321
DeleteSprite = $C5E596
PackOAMHigh = $C5F3DB
DATA8_C55D6B = $C55D6B
Div16U = $C091F3
Div16x8U = $C09257
FadeOutWait = $C58A99
Mul8U = $C08ED9
WaitFrames_Inc = $C08D89

incsrc "../bankC5_6000.asm"

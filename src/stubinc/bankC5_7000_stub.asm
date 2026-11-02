;	Segment build for bankC5_7000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_7000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
MapTileBlock = $C387D8
ReplayMode = $C3736B				; open instant replay and restore the live frame on exit
DATA8_C3585C = $C3585C
DATA8_C35E25 = $C35E25
DATA8_C35E37 = $C35E37
DATA8_C35E47 = $C35E47
DATA8_C35E67 = $C35E67
DATA8_C35E87 = $C35E87
DATA8_C35E9F = $C35E9F
DATA8_C35F60 = $C35F60
ReadMenuPads = $C36C2D
PhotoPaletteTable = $C35EAB
SendTextMap = $C4C2AA
UnpackText = $C4C3BA
WaitTransfers = $C4CEDB
PrintTextPage = $C4BB5A
PrintBoldCentred = $C4BBE5
PrintBoldCentredStr = $C4BBF1
PrintBoldLeft = $C4BBFC
PrintBoldLeftStr = $C4BC08
PrintBoldRight = $C4BC0E
PrintBoldRightStr = $C4BC1A
PrintItalicLeft = $C4BC26
PrintItalicCentredStr = $C4BCB0
PrintTitle = $C4BDAE
PrintTitleBar = $C4BDE6
AnimateSprites = $C5E9C7
BitMaskTable2 = $C09C24
BuildSpriteOAM = $C5F0D1
GetPadTeam = $C53ABC
setpersonel = $C541D3
CODE_C54F37 = $C54F37
CODE_C55513 = $C55513
CODE_C558D7 = $C558D7
SetupScreen = $C55951
ExitToPauseMenu = $C55A09
StartScrollList = $C55ABC
ScrollListArrows = $C55BE8
CODE_C55C12 = $C55C12
ScrollListDown = $C55C58
ScrollListUp = $C55CE6
ClearTextRow = $C55D73
CODE_C55E57 = $C55E57
BCDText = $C55EC7
BCDTextAt = $C55ECA
ConcatStrings = $C56009
TimeTextMSS = $C5605D
CODE_C56168 = $C56168
CODE_C5800C = $C5800C
CODE_C580AB = $C580AB
CODE_C580B7 = $C580B7
ClearRAM7E = $C58B11
BinToBCD = $C5B67A
RefreshSprites = $C5BBC0
GetUserName = $C5D2B4
ReadUserRecord = $C5D6F5
DeleteSprite = $C5E596
PackOAMHigh = $C5F3DB
DATA8_C09B54 = $C09B54
DATA8_C09B94 = $C09B94
Div16x8U = $C09257
DivX8U = $C0927A
FadeOutWait = $C58A99
Mul16x8U = $C08F5E
Mul8U = $C08ED9
Div32U_hi0entry = $C091AE
Pausemode_menu_resume = $C54EF1

incsrc "../bankC5_7000.asm"

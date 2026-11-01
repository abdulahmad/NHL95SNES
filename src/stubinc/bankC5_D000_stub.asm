;	Segment build for bankC5_D000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_D000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
MapTileBlock = $C387D8
ReadPauseMenuPad = $C37065			; read the pause pad into the menu word and update the repeat timer
DATA8_C3585C = $C3585C
CODE_C4EFD8 = $C4EFD8
SendTextMap = $C4C2AA
RestoreWorkBuf = $C4C536
WaitTransfers = $C4CEDB
PrintTextPage = $C4BB5A
PrintBoldLeft = $C4BBFC
PrintBoldLeftStr = $C4BC08
CODE_C4BC2C = $C4BC2C
CODE_C4BC68 = $C4BC68
PrintThinCentred = $C4BCAA
ClearTextRow = $C55D73
BCDText = $C55EC7
LoadGameRosters = $C52CC1
BCDTable = $C08C76
Div16U = $C091F3
BuildSpriteOAM = $C5F0D1
PackOAMHigh = $C5F3DB
AnimateSprites = $C5E9C7
CODE_C5DF5F = $C5DF5F
SimTeamTotals = $C5E123
DeleteSprite = $C5E596
SetSpriteAnim = $C5ECBD
CreateSprite = $C5E665
ClearVRAM = $C589B0
ClearRAM7E = $C58B11
RandomBelowA = $C58CCD
CODE_C5C6B7 = $C5C6B7
DATA8_C598FA = $C598FA
DATA8_C5A1D7 = $C5A1D7
DATA8_C5A225 = $C5A225
DATA8_C5A25B = $C5A25B
FadeOutWait = $C58A99
Mul8U = $C08ED9
SetupHDMA = $C58AA5

incsrc "../bankC5_D000.asm"

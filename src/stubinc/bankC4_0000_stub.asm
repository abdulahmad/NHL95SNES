;	Segment build for bankC4_0000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_0000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
UpdateMenuSpritesTwice = $C3716D	; run the menu sprite update and transfer wait twice
ReadMenuPads = $C36C2D
StanleyCupScreen = $C4DFD6
SeasonAwards = $C4D818
SendTextMap = $C4C2AA
UnpackText = $C4C3BA
ResetWorkBuf = $C4C530
RestoreWorkBuf = $C4C536
MarkWorkBuf = $C4C541
AllocWorkBuf = $C4C558
WaitTransfers = $C4CEDB
InitTextMap = $C4BAF6
PrintTextPage = $C4BB5A
PrintBoldCentred = $C4BBE5
PrintBoldLeft = $C4BBFC
PrintBoldLeftStr = $C4BC08
DATA8_C41006 = $C41006
DATA8_C4103E = $C4103E
DATA8_C41076 = $C41076
DATA8_C410AE = $C410AE
DATA8_C410E6 = $C410E6
DATA8_C41166 = $C41166
AnimateSprites = $C5E9C7
BuildSpriteOAM = $C5F0D1
CODE_C52CA3 = $C52CA3
BCDTextLong = $C55EC3
MapSetToUnpackbuf = $C58812
ClearVRAM = $C589B0
QueueClearVRAM = $C589E4
ClearRAM7E = $C58B11
RandomBelowA = $C58CCD
GameSetUp = $C58D32
CODE_C5A507 = $C5A507
SeasonOptions = $C5A51C
CODE_C5ADDC = $C5ADDC
CODE_C5AF07 = $C5AF07
RefreshSpritesLong = $C5BBBC
SeasonGoalsLong = $C5BD52
SeasonAssistsLong = $C5BD7D
SeasonSavesLong = $C5BDA8
SeasonGoalieGamesLong = $C5BDE7
SeasonGoalsAgainstLong = $C5BE33
CODE_C5E37E = $C5E37E
CODE_C5E50E = $C5E50E
DeleteSprite = $C5E596
PackOAMHigh = $C5F3DB
CreateSprite = $C5E665
DecompressUnpackbuf = $C581D7
FadeOutWait = $C58A99
Reset = $C0FD0E
SetNMIHook = $C08D73
SetupHDMA = $C58AA5
BlueColoursHook = $C04A65
DarkBlueColoursHook = $C04A87
GradientBarTiles = $C0083D
PlayoffBracketMap = $C1DC7B
TeamNameBarsMap = $C1E9B2

incsrc "../bankC4_0000.asm"

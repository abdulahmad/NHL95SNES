;	Segment build for bankC4_D000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_D000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
LoadSounds = $CF0134
SoundVolumeDown = $CF039E
SoundVolumeUp = $CF03D0
StartSound = $CF040B
VezinaPicMap = $C6FDE8				; award 0 picture
SelkePicMap = $C7FE7E				; award 1 picture
ConnSmythePicMap = $C8FE39			; award 2 picture
JenningsPicMap = $C9FFEB			; award 3 picture
HartPicMap = $CDF32B				; award 4 picture
ArtRossPicMap = $CAFDF9				; award 5 picture
NorrisPicMap = $CBFDD5				; award 6 picture
PresidentsPicMap = $CEF0AB			; award 7 picture
MapTileBlock = $C387D8
UpdateMenuSpritesTwice = $C3716D	; run the menu sprite update and transfer wait twice
DATA8_C3585C = $C3585C
ReadMenuPads = $C36C2D
CODE_C4EC88 = $C4EC88
CODE_C4EE9D = $C4EE9D
AnimateSprites = $C5E9C7
BlueColoursHook = $C04A65
BuildSpriteOAM = $C5F0D1
CODE_C4B6D2 = $C4B6D2
InitTasks = $C4B6EB
AddStartKeyTask = $C4B738
StartTasks = $C4B743
AddTask = $C4B763
RunTasks = $C4B7D4
QueueColours16 = $C4B84C
CODE_C4B871 = $C4B871
CODE_C4B8AC = $C4B8AC
CODE_C4B8D1 = $C4B8D1
CODE_C4B970 = $C4B970
InitTextMap = $C4BAF6
PrintTextPage = $C4BB5A
PrintBoldCentred = $C4BBE5
PrintBoldCentredStr = $C4BBF1
PrintThinCentred = $C4BCAA
SendTextMap = $C4C2AA
ResetWorkBuf = $C4C530
MarkWorkBuf = $C4C541
AllocWorkBuf = $C4C558
FreeWorkBuf = $C4C56A
CODE_C4C574 = $C4C574
WaitTransfers = $C4CEDB
CODE_C4CF7B = $C4CF7B
CODE_C52CA3 = $C52CA3
CODE_C531BC = $C531BC
MapSetToWRAM = $C5881C
ClearVRAM = $C589B0
QueueClearVRAM = $C589E4
ClearRAM7E = $C58B11
CODE_C58B2B = $C58B2B
CODE_C5A4B5 = $C5A4B5
CODE_C5B5EA = $C5B5EA
CODE_C5B97F = $C5B97F
CODE_C5BBBC = $C5BBBC
CODE_C5BD52 = $C5BD52
CODE_C5BD7D = $C5BD7D
CODE_C5BDA8 = $C5BDA8
CODE_C5BDE7 = $C5BDE7
CODE_C5E474 = $C5E474
CODE_C5E50E = $C5E50E
DeleteSprite = $C5E596
SetSpriteAnim = $C5ECBD
PackOAMHigh = $C5F3DB
ClearNMIHook = $C08D64
CreateSprite = $C5E665
DATA8_C40D76 = $C40D76
Decompress = $C581E1
Div32x32U = $C09113
FadeOutWait = $C58A99
MapSetToVRAM = $C58527
SetNMIHook = $C08D73
SetupHDMA = $C58AA5
TextPalettes = $C4BAD6
DATA8_CF05D4 = $CF05D4
GradientBarTiles = $C0083D
TeamPalettes = $C00000
TiledBackMap = $C087F2
TitleGoalieMap = $C22CB2
TitleLogoMap = $C271F6
TitlePlayersMap = $C20AB8

incsrc "../bankC4_D000.asm"

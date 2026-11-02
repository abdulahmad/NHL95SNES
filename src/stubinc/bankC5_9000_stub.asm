;	Segment build for bankC5_9000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_9000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
SoundVolumeDown = $CF039E
UpdateMenuSpritesTwice = $C3716D	; run the menu sprite update and transfer wait twice
ReadMenuPads = $C36C2D
ReadPads = $C36CBF
DATA8_C4C4A6 = $C4C4A6
SendTextMap = $C4C2AA
ResetWorkBuf = $C4C530
ResetTransferQueues = $C4C574
WaitTransfers = $C4CEDB
InitTextMap = $C4BAF6
PrintTextPage = $C4BB5A
PrintBoldLeft = $C4BBFC
PrintBoldRightStr = $C4BC1A
PrintItalicLeft = $C4BC26
PrintItalicFixedLeftStr = $C4BC46	; print a RAM string in italic with glyph width A
PrintItalicLeftStr = $C4BC9E
PrintItalicCentred = $C4BCA4
PrintItalicRight = $C4BCBC
PrintTitleStr = $C4BDCA
CheckCreateSlots = $C406A8
BCDText = $C55EC7
Div16U = $C091F3
BuildSpriteOAM = $C5F0D1
PackOAMHigh = $C5F3DB
AnimateSprites = $C5E9C7
ClampRosterTeams = $C5E41D
ClearPlayerGoals = $C5E447
ResetSprites = $C5E50E
DeleteSprite = $C5E596
SetSpriteAnim = $C5ECBD
UseSpritePalette = $C5EE6C
CreateSprite = $C5E665
CreateSpriteSharePal = $C5EEF3
UserNameEntry = $C5D0F5
DrawSetupTeams = $C5C0BE
BinToBCD = $C5B67A
RefreshSprites = $C5BBC0
PrintCreatedOverall = $C59F79
RatingNibble = $C5A07A
DrawNameEntry = $C5A09B
PlaceYesNoCursor = $C5A164
LetterCellPalette3 = $C5A17B
MoveCreateGridCursor = $C5A20D
FieldPos = $C5A291
FieldWeight = $C5A2B4
FieldJersey = $C5A2D3
FieldHand = $C5A2EC
PrintVisTeamName = $C5A3C1
QueueHomePalette = $C5A4B9
QueueVisPalette = $C5A4E2
DeleteArrowSprites = $C5A50B
SeasonOptions = $C5A51C
InitSetupScroll = $C5ABC4
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
MapSetToVRAMBody = $C5852B
ClearVRAM = $C589B0
QueueClearVRAM = $C589E4
ClearRAM7E = $C58B11
SeedRandom = $C58D05
GameSetUp = $C58D32
DrawSetupLine = $C58F75
Decompress = $C581E1
DecompressUnpackbuf = $C581D7
FadeOutWait = $C58A99
SetupHDMA = $C58AA5
SeasonOptionsInput = $C5AC07
GamesTodayInput = $C5A816
LeagueLeadersInput = $C5A5B0
SeasonTeamStatsInput = $C5A623
SeasonPlayerStatsInput = $C5A66E
StandingsInput = $C5A773
NoGameSelectedInput = $C5AB16
StartSeasonInput = $C5AB27
BlueColoursHook = $C04A65
GradientBarTiles = $C0083D
TeamPalettes = $C00000
TiledBackMap = $C087F2

incsrc "../bankC5_9000.asm"

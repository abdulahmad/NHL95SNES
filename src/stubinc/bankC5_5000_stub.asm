;	Segment build for bankC5_5000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_5000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
SoundVolumeDown = $CF039E
LoadTeamSongs = $CF0427
IceRinkMap = $CCEEA5				; the rink map set
MapTileBlock = $C387D8
BackupPauseBuffers = $C387FF		; allocate and copy the buffers saved for the pause screen
DATA8_C3585C = $C3585C
SendTextMap = $C4C2AA
UnpackText = $C4C3BA
RestoreWorkBuf = $C4C536
MarkWorkBuf = $C4C541
AllocWorkBuf = $C4C558
FreeWorkBuf = $C4C56A
WaitTransfers = $C4CEDB
InitTextMap = $C4BAF6
PrintTextPage = $C4BB5A
PrintBoldCentredStr = $C4BBF1
PrintThinCentred = $C4BCAA
PauseReplay = $C57329
EditLinesScreen = $C57361
PauseGoalie = $C578B0
ShowOtherScores = $C57A7D
RecordHoldersScreen = $C57C34
CODE_C5605D = $C5605D
CODE_C560AC = $C560AC
ShowGameStats = $C56293
ShowPeriodStats = $C56368
ShowPlayerStats = $C5649F
ShowPenaltySummary = $C56993
CODE_C56B7B = $C56B7B
CODE_C56B80 = $C56B80
CODE_C56B8C = $C56B8C
PauseTimeout = $C56B90
ShowScoringSummary = $C56C6A
PauseGoalieMode = $C56E55
TeamRoster = $C56E6A
AnimateSprites = $C5E9C7
BCDTable = $C08C76
BuildSpriteOAM = $C5F0D1
CODE_C534E8 = $C534E8
CODE_C53A29 = $C53A29
GetPadTeam = $C53ABC
MapSetToVRAMBody = $C5852B
MapSetToWRAM = $C5881C
ClearVRAM = $C589B0
QueueClearVRAM = $C589E4
CODE_C5A4B9 = $C5A4B9
CODE_C5A4E2 = $C5A4E2
ResetSprites = $C5E50E
SetSpriteAnim = $C5ECBD
CODE_C5EE9B = $C5EE9B
QueueFrameTiles = $C5F368
PackOAMHigh = $C5F3DB
ClearNMIHook = $C08D64
CreateSprite = $C5E665
Decompress = $C581E1
DecompressLZSS = $C58458
DecompressToVRAM = $C58A65
DivX8U = $C0927A
FadeOutWait = $C58A99
Mul8U = $C08ED9
ScreenOn = $C08E99
SetNMIHook = $C08D73
SetupHDMA = $C58AA5
UploadSpriteFrame = $C5E8A5
forceblack = $C08E93
ArrowFontTiles = $C0027E
BlueColoursHook = $C04A65
CenterIceTiles = $C2792B
DigitFontTiles = $C04642
FaceOffMap = $C1CFE2
GradientBarTiles = $C0083D
MeterFontTiles = $C00976
PauseScreenMap = $C1BA31
RefsMap = $C2CC6E
TeamNicknameTiles = $C19B68
TiledBackMap = $C087F2

incsrc "../bankC5_5000.asm"

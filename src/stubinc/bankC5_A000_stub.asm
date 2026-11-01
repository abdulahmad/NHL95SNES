;	Segment build for bankC5_A000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_A000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
DATA8_C3585C = $C3585C
DATA8_C35F60 = $C35F60
DATA8_C35F62 = $C35F62
DATA8_C360D4 = $C360D4
CODE_C4CFF5 = $C4CFF5
DATA8_C4C4A6 = $C4C4A6
SendTextMap = $C4C2AA
ResetWorkBuf = $C4C530
CODE_C4C574 = $C4C574
WaitTransfers = $C4CEDB
InitTextMap = $C4BAF6
PrintTextPage = $C4BB5A
PrintBoldLeft = $C4BBFC
PrintBoldRightStr = $C4BC1A
PrintItalicLeft = $C4BC26
CODE_C4BC2C = $C4BC2C
CODE_C4BC46 = $C4BC46
PrintItalicLeftStr = $C4BC9E
PrintThinCentred = $C4BCAA
CODE_C40000 = $C40000
CODE_C401E5 = $C401E5
CODE_C40296 = $C40296
CODE_C40D96 = $C40D96
ShowOtherScores = $C57A7D
CODE_C56168 = $C56168
SetupScreen = $C55951
StartScrollList = $C55ABC
ScrollListArrows = $C55BE8
ScrollListDown = $C55C58
ScrollListUp = $C55CE6
BCDText = $C55EC7
CODE_C52CC1 = $C52CC1
DATA8_C5B35D = $C5B35D
DATA8_C5B363 = $C5B363
Restart = $C50056
SaveDayGameStats = $C5E17C
CODE_C5E336 = $C5E336
ShowPleaseWait = $C5E49A
CODE_C5E50E = $C5E50E
DeleteSprite = $C5E596
SetSpriteAnim = $C5ECBD
CreateSprite = $C5E665
SimDayScores = $C5DD47
RecordDayResults = $C5DDF0
SimDayGameStats = $C5DE9B
CODE_C5C0BE = $C5C0BE
CODE_C5C6B7 = $C5C6B7
DrawLeagueLeaders = $C5AFCC
DrawStandings = $C5B1AF
CODE_C5B20E = $C5B20E
CODE_C5B22D = $C5B22D
CODE_C5B369 = $C5B369
CODE_C5B38F = $C5B38F
BinToBCD = $C5B67A
DrawSeasonTeamStats = $C5B7F1
DrawSeasonPlayerRow = $C5BBDD
CODE_C5BCD9 = $C5BCD9
ClearVRAM = $C589B0
QueueClearVRAM = $C589E4
ClearRAM7E = $C58B11
CODE_C5909D = $C5909D
CODE_C590BB = $C590BB
setoptions = $C590DA
CODE_C59217 = $C59217
CODE_C59308 = $C59308
CODE_C593B1 = $C593B1
CODE_C5963A = $C5963A
DecompressUnpackbuf = $C581D7
FadeOutWait = $C58A99
SetupHDMA = $C58AA5
StandingsScreen = $C5B17A
LeagueLeadersScreen = $C5AFB6
SeasonTeamStats = $C5B07C
SeasonPlayerStats = $C5B0EA
WonCheckTiles = $C03CF9
GameSetUp_reenter = $C58D44

incsrc "../bankC5_A000.asm"

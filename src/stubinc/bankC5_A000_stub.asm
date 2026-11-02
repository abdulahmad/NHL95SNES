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
ClearSeasonData = $C4CFF5
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
PrintItalicFixedLeft = $C4BC2C		; print packed italic text from the left margin with glyph width A
PrintItalicFixedLeftStr = $C4BC46	; print a RAM string in italic with glyph width A
PrintItalicLeftStr = $C4BC9E
PrintThinCentred = $C4BCAA
PlayoffBracketScreen = $C40000
BuildPlayoffDay = $C401E5
RecordPlayoffDay = $C40296
SetupPlayoffs = $C40D96
ShowOtherScores = $C57A7D
MakeDateString = $C56168
SetupScreen = $C55951
StartScrollList = $C55ABC
ScrollListArrows = $C55BE8
ScrollListDown = $C55C58
ScrollListUp = $C55CE6
BCDText = $C55EC7
LoadGameRosters = $C52CC1
DATA8_C5B35D = $C5B35D
DATA8_C5B363 = $C5B363
Restart = $C50056
SaveDayGameStats = $C5E17C
RestoreDayScores = $C5E336
ShowPleaseWait = $C5E49A
ResetSprites = $C5E50E
DeleteSprite = $C5E596
SetSpriteAnim = $C5ECBD
CreateSprite = $C5E665
SimDayScores = $C5DD47
RecordDayResults = $C5DDF0
SimDayGameStats = $C5DE9B
DrawSetupTeams = $C5C0BE
RecordOverall = $C5C6B7
DrawLeagueLeaders = $C5AFCC
DrawStandings = $C5B1AF
DayFirstGame = $C5B20E
DrawDayGames = $C5B22D
QueueTeamPalette = $C5B369
DrawGameMarks = $C5B38F
BinToBCD = $C5B67A
DrawSeasonTeamStats = $C5B7F1
DrawSeasonPlayerRow = $C5BBDD
DrawPlayerStatsTeam = $C5BCD9
ClearVRAM = $C589B0
QueueClearVRAM = $C589E4
ClearRAM7E = $C58B11
SetRowPalette3 = $C5909D
SetRowPalette0 = $C590BB
setoptions = $C590DA
CreateSetupArrows = $C59217
DrawOptionList = $C59308
StartExhibition = $C593B1
EnterLeagueMenu = $C5963A
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

;	Segment build for bankC5_C000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_C000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
MapTileBlock = $C387D8
DATA8_C3585C = $C3585C
DATA8_C35E5B = $C35E5B
PlayerList = $C30038
ReadMenuPads = $C36C2D
SendTextMap = $C4C2AA
UnpackText = $C4C3BA
ResetWorkBuf = $C4C530
WaitTransfers = $C4CEDB
InitTextMap = $C4BAF6
PrintTextPage = $C4BB5A
PrintBoldCentred = $C4BBE5
PrintBoldCentredStr = $C4BBF1
PrintBoldLeft = $C4BBFC
PrintBoldLeftStr = $C4BC08
PrintItalicLeft = $C4BC26
PrintThinCentred = $C4BCAA
DATA8_C40EDA = $C40EDA
DATA8_C57309 = $C57309
CheckTradesFrozen = $C406DD
StartScrollList = $C55ABC
ScrollListArrows = $C55BE8
CODE_C55C12 = $C55C12
ScrollListDown = $C55C58
ScrollListUp = $C55CE6
BCDText = $C55EC7
FitNameToWorkBuf = $C55F8A
LoadGameRosters = $C52CC1
BCDTable = $C08C76
BitMaskTable2 = $C09C24
DATA8_C04CBF = $C04CBF
DATA8_C04CC3 = $C04CC3
BuildSpriteOAM = $C5F0D1
PackOAMHigh = $C5F3DB
AnimateSprites = $C5E9C7
DeleteSprite = $C5E596
SetSpriteAnim = $C5ECBD
CreateSprite = $C5E665
TradeValue = $C5D00D
ExecuteTrade = $C5D08C
CODE_C5D794 = $C5D794
CreatedPlayerBits = $C5D7CD
NextSaveBits3 = $C5D7E9
NextSaveBits5 = $C5D804
NextSaveBits7 = $C5D821
NextSaveBits8 = $C5D83F
PrintPositionCounts = $C5D85D
CODE_C5D8E7 = $C5D8E7
CODE_C5DA09 = $C5DA09
CODE_C5DA58 = $C5DA58
CODE_C5DAF3 = $C5DAF3
CODE_C5DB9F = $C5DB9F
ClearVRAM = $C589B0
QueueClearVRAM = $C589E4
GameSetUp = $C58D32
CODE_C5A3C1 = $C5A3C1
CODE_C5A46A = $C5A46A
CODE_C5A4A5 = $C5A4A5
CODE_C5A4B9 = $C5A4B9
CODE_C5A4E2 = $C5A4E2
BinToBCD = $C5B67A
FadeOutWait = $C58A99
Mul8U = $C08ED9

incsrc "../bankC5_C000.asm"

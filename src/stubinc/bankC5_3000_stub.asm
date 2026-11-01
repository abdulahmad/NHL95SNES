;	Segment build for bankC5_3000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_3000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CalcPuckDistances = $C38799			; update every object distance and direction to the puck
PlayerList = $C30038
UnpackText = $C4C3BA
ResetWorkBuf = $C4C530
AllocWorkBuf2 = $C4C561
Sweepcheck = $C45606				; start a sweep check by player X
assinsert = $C43734
assreplace = $C4373E
chkpk2 = $C42DA2
BCDText = $C55EC7
ResetTeamPlayers = $C53FE5
GetTeamLines = $C54E59
BCDTable = $C08C76
GetPeriodTime = $C510F6
showclockdma = $C51397
CODE_C528D4 = $C528D4
Framer = $C58C36
BinToBCD = $C5B67A
CreatedPlayerBits = $C5D7CD
NextSaveBits3 = $C5D7E9
CODE_C5E50E = $C5E50E
CODE_C5EE6C = $C5EE6C
CreateSpriteSharePal = $C5EEF3
Div16x8U = $C09257
Mul8U = $C08ED9
QueueVRAMDMALen = $C58A15

incsrc "../bankC5_3000.asm"

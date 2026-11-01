;	Segment build for bankC4_7000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_7000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
StartSound = $CF040B
SignedSquareTable = $C38A4A
GetFrameHot = $C37FE2				; return the current frame hot spot in d0 and d1
setpads = $C38043
StartBenchCheer = $C382B6
SprSort = $C384FC
UpdatePA = $C38C4A					; advance the referee animation and penalty message timers
SetPA = $C38C6D						; start the referee animation and message for penalty d0
PushRef = $C38CFC					; draw a referee frame or clear the referee window
randoma8 = $C37EAA
vtoa = $C37F6D
AllocWorkBuf2 = $C4C561
skatetopuckinit = $C495BB
updatepentime = $C47FB5
PenShotChk = $C480B5
ClearPenaltyBuffer = $C4818C
checkagr = $C48199
StartPenaltyShot = $C4866D
assexit = $C4370C
assinsert = $C43734
assreplace = $C4373E
FallDown = $C44F20
CODE_C45606 = $C45606
SetSPA = $C457A1
SetSPAFromA = $C457B5
skateto = $C45950
CODE_C45A9F = $C45A9F
doplayeracc = $C4694F
CODE_C46BF6 = $C46BF6
GetPeriodTimeRemaining = $C510DF
CODE_C513F4 = $C513F4
PushTime = $C516C2
limitfo = $C51F7C
SetHor = $C5226A
freezewindow = $C52284
PassPadToTeammate = $C538DE
CODE_C53A29 = $C53A29
CODE_C53A71 = $C53A71
CODE_C54BAF = $C54BAF
DATA8_C58942 = $C58942
FadeOutWait = $C58A99
Mul16S = $C09035
Mul16x8XS = $C08F95
Mul8U = $C08ED9
QueueVRAMDMALen = $C58A15

incsrc "../bankC4_7000.asm"

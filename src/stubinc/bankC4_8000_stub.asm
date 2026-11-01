;	Segment build for bankC4_8000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_8000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
StartSound = $CF040B
GetFrameHot = $C37FE2				; return the current frame hot spot in d0 and d1
ApproxLength = $C38778
PushRef = $C38CFC					; draw a referee frame or clear the referee window
randoma8 = $C37EAA
randomd0 = $C37EBF					; replace d0 with a random number below its current value
vtoa = $C37F6D
DATA8_C34499 = $C34499
DATA8_C3449B = $C3449B
WaitTransfers = $C4CEDB
chk4pass = $C49FBD
CODE_C492F8 = $C492F8
CODE_C4932B = $C4932B
AdjustFacingDirection = $C4933E
GoaliePuckVector = $C4937C
ShootoutWonBy = $C093DD
assexit = $C4370C
CODE_C43734 = $C43734
SetSPA = $C457A1
SetSPAFromA = $C457B5
stopna = $C458E4
skateto = $C45950
CODE_C45A9F = $C45A9F
playeracc = $C45ABE
doplayeracc = $C4694F
CODE_C46BF6 = $C46BF6
chkatop = $C47200
CountPowerPlayTime = $C47231
CODE_C4785E = $C4785E
AddPenalty = $C4789D
AddPenalty2 = $C478C3
CODE_C533E1 = $C533E1
Setplass = $C53C20
setplayer = $C53C46
setpersonel = $C541D3
check4bench = $C549A8
CODE_C54BAF = $C54BAF
CODE_C58944 = $C58944
CODE_C58C36 = $C58C36
Div32S = $C09145
Mul16x8XS = $C08F95
QueueVRAMDMALen = $C58A15
RandomWord = $C08E48

incsrc "../bankC4_8000.asm"

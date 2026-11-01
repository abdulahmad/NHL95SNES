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
ClampGoalieTargetY = $C492F8		; clamp the goalie target between goal lines and make its Y relative to d3
GoalieTargetReturn = $C4932B		; return from goalie targeting
AdjustFacingDirection = $C4933E
GoaliePuckVector = $C4937C
ShootoutWonBy = $C093DD
assexit = $C4370C
assinsert = $C43734
SetSPA = $C457A1
SetSPAFromA = $C457B5
stopna = $C458E4
skateto = $C45950
RemovePlayerFromList = $C45A9F		; remove a player from the penalty box list by shifting later entries down
playeracc = $C45ABE
doplayeracc = $C4694F
avdgoal = $C46BF6					; adjust the skating target so the path avoids a goal
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
CloseLCBoxes = $C54BAF
CODE_C58944 = $C58944
Framer = $C58C36
Div32S = $C09145
Mul16x8XS = $C08F95
QueueVRAMDMALen = $C58A15
RandomWord = $C08E48

incsrc "../bankC4_8000.asm"

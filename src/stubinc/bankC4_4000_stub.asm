;	Segment build for bankC4_4000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_4000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
QueueSoundCmd = $CF00E3
StartSound = $CF040B
StartSoundVolume = $CF0418			; sound routine in bankCF_0000
SquareTable = $C3884A
GetFrameHot = $C37FE2				; return the current frame hot spot in d0 and d1
ApproxLength = $C38778
puckbody = $C4A6B1
puckgoalie = $C4A782
ChkShotStat = $C4A967
Goal = $C4AA65
puckstick = $C4AD26
puckflip = $C49572
EndPenaltyShot = $C486C7
AddPenalty2 = $C478C3
checkint = $C47AB4
checkcheck = $C453C1
ShootoutWonBy = $C093DD
PuckCarrierPad = $C53724
AssignPadIfFree = $C5376A
RandomBelowA = $C58CCD
Div32S = $C09145
DivX8S = $C09290
Mul16S = $C09035
Mul16x8S = $C08FB7
Mul16x8XS = $C08F95
Mul8S = $C08F09
RandomWord = $C08E48

incsrc "../bankC4_4000.asm"

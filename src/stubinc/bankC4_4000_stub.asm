;	Segment build for bankC4_4000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_4000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_CF00E3 = $CF00E3
CODE_CF040B = $CF040B
CODE_CF0418 = $CF0418
DATA8_C3884A = $C3884A
CODE_C37FE2 = $C37FE2
ApproxLength = $C38778
CODE_C4A6B1 = $C4A6B1
CODE_C4A782 = $C4A782
ChkShotStat = $C4A967
CODE_C4AA65 = $C4AA65
CODE_C4AD26 = $C4AD26
puckflip = $C49572
EndPenaltyShot = $C486C7
AddPenalty2 = $C478C3
checkint = $C47AB4
checkcheck = $C453C1
ShootoutWonBy = $C093DD
CODE_C53724 = $C53724
CODE_C5376A = $C5376A
CODE_C58CCD = $C58CCD
Div32S = $C09145
DivX8S = $C09290
Mul16S = $C09035
Mul16x8S = $C08FB7
Mul16x8XS = $C08F95
Mul8S = $C08F09
RandomWord = $C08E48

incsrc "../bankC4_4000.asm"

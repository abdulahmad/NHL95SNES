;	Segment build for bankC4_A000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_A000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_CF00E3 = $CF00E3
CODE_CF040B = $CF040B
CODE_CF0418 = $CF0418
CODE_CF0485 = $CF0485
CODE_C37FE2 = $C37FE2
CODE_C382B6 = $C382B6
ApproxLength = $C38778
randomd0A = $C37E95
CODE_C37EAA = $C37EAA
randomd0s = $C37EC8
vtoa = $C37F6D
ClearOffsidesIfAllPlayers = $C4B00F
assexit = $C4370C
CODE_C43734 = $C43734
assreplace = $C4373E
CODE_C44E0A = $C44E0A
CODE_C44F20 = $C44F20
SetSPA = $C457A1
SetSPAFromA = $C457B5
AddPenalty2 = $C478C3
CODE_C4797A = $C4797A
CODE_C4843B = $C4843B
StartBreakaway = $C4862C
EndPenaltyShot = $C486C7
AdjustFacingDirection = $C4933E
puckflip = $C49572
CompShoot = $C4981D
Findhittype = $C49D8D
CODE_C510DF = $C510DF
freezewindow = $C52284
loadTeamStruct = $C53616
CODE_C5376A = $C5376A
findpc = $C537C4
CODE_C539D7 = $C539D7
CODE_C54A47 = $C54A47
CODE_C5F368 = $C5F368
DATA8_C41E48 = $C41E48
Div32S = $C09145
DivX8U = $C0927A
Mul16S = $C09035
Mul16U = $C0906C
Mul16XS = $C09053
Mul16x8U = $C08F5E
Mul16x8XS = $C08F95
Mul8XS = $C08EEC
RandomWord = $C08E48

incsrc "../bankC4_A000.asm"

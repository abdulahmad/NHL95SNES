;	Segment build for bankC4_8000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_8000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_CF040B = $CF040B
CODE_C37FE2 = $C37FE2
CODE_C38778 = $C38778
CODE_C38CFC = $C38CFC
CODE_C37EAA = $C37EAA
CODE_C37EBF = $C37EBF
CODE_C37F6D = $C37F6D
DATA8_C34499 = $C34499
DATA8_C3449B = $C3449B
CODE_C4CEDB = $C4CEDB
CODE_C49FBD = $C49FBD
CODE_C492F8 = $C492F8
CODE_C4932B = $C4932B
AdjustFacingDirection = $C4933E
CODE_C4937C = $C4937C
CODE_C093DD = $C093DD
assexit = $C4370C
CODE_C43734 = $C43734
SetSPA = $C457A1
SetSPAFromA = $C457B5
CODE_C458E4 = $C458E4
CODE_C45950 = $C45950
CODE_C45A9F = $C45A9F
CODE_C45ABE = $C45ABE
CODE_C4694F = $C4694F
CODE_C46BF6 = $C46BF6
CODE_C47200 = $C47200
CountPowerPlayTime = $C47231
CODE_C4785E = $C4785E
CODE_C4789D = $C4789D
CODE_C478C3 = $C478C3
CODE_C533E1 = $C533E1
Setplass = $C53C20
CODE_C53C46 = $C53C46
CODE_C541D3 = $C541D3
check4bench = $C549A8
CODE_C54BAF = $C54BAF
CODE_C58944 = $C58944
CODE_C58C36 = $C58C36
Div32S = $C09145
Mul16x8XS = $C08F95
QueueVRAMDMALen = $C58A15
RandomWord = $C08E48

incsrc "../bankC4_8000.asm"

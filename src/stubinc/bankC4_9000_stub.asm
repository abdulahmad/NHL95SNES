;	Segment build for bankC4_9000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_9000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_CF040B = $CF040B
DATA8_C38A4A = $C38A4A
CODE_C37FE2 = $C37FE2
CODE_C38778 = $C38778
CODE_C37E95 = $C37E95
CODE_C37EAA = $C37EAA
CODE_C37EC8 = $C37EC8
CODE_C37ED4 = $C37ED4
CODE_C37F6D = $C37F6D
CODE_C4A4AB = $C4A4AB
CODE_C4AE9C = $C4AE9C
CODE_C4AED5 = $C4AED5
CODE_C42B18 = $C42B18
CODE_C42D98 = $C42D98
donothing = $C436FD
assexit = $C4370C
assreplace = $C4373E
CODE_C44B0F = $C44B0F
SetSPA = $C457A1
SetSPAFromA = $C457B5
updateanim = $C457DD
CODE_C45950 = $C45950
CODE_C478C3 = $C478C3
CODE_C4843B = $C4843B
CheckBreakaway = $C48590
CODE_C486C7 = $C486C7
CODE_C54A47 = $C54A47
Div32S = $C09145
Div32U = $C09188
Mul16S = $C09035
Mul16U = $C0906C
Mul16XS = $C09053
Mul16x8U = $C08F5E
Mul16x8XS = $C08F95
RandomWord = $C08E48

incsrc "../bankC4_9000.asm"

;	Segment build for bankC4_A000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_A000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C40000 = $C40000
CODE_C4370C = $C4370C
CODE_C43734 = $C43734
CODE_C4373E = $C4373E
CODE_C44E0A = $C44E0A
CODE_C44F20 = $C44F20
CODE_C457A1 = $C457A1
CODE_C457B5 = $C457B5
CODE_C478C3 = $C478C3
CODE_C4797A = $C4797A
CODE_C4843B = $C4843B
CODE_C4862C = $C4862C
CODE_C486C7 = $C486C7
CODE_C4933E = $C4933E
CODE_C49572 = $C49572
CODE_C4981D = $C4981D
CODE_C49D8D = $C49D8D
CODE_C510DF = $C510DF
CODE_C52284 = $C52284
CODE_C53616 = $C53616
CODE_C5376A = $C5376A
CODE_C537C4 = $C537C4
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

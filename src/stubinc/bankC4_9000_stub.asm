;	Segment build for bankC4_9000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_9000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C42B18 = $C42B18
CODE_C42D98 = $C42D98
CODE_C436FD = $C436FD
CODE_C4370C = $C4370C
CODE_C4373E = $C4373E
CODE_C44B0F = $C44B0F
CODE_C457A1 = $C457A1
CODE_C457B5 = $C457B5
CODE_C457DD = $C457DD
CODE_C45950 = $C45950
CODE_C478C3 = $C478C3
CODE_C4843B = $C4843B
CODE_C48590 = $C48590
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

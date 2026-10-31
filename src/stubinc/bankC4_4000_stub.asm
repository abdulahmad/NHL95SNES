;	Segment build for bankC4_4000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_4000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C486C7 = $C486C7
CODE_C478C3 = $C478C3
CODE_C47AB4 = $C47AB4
CODE_C453C1 = $C453C1
CODE_C093DD = $C093DD
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

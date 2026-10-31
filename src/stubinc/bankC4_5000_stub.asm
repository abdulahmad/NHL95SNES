;	Segment build for bankC4_5000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_5000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C480B5 = $C480B5
CODE_C48199 = $C48199
CODE_C4824A = $C4824A
CODE_C47323 = $C47323
CODE_C4789D = $C4789D
CODE_C478C3 = $C478C3
CODE_C47C8C = $C47C8C
DATA8_C4692F = $C4692F
DATA8_C4693F = $C4693F
CODE_C45FAC = $C45FAC
CODE_C46075 = $C46075
CODE_C4615F = $C4615F
CODE_C4624F = $C4624F
CODE_C46317 = $C46317
CODE_C463E3 = $C463E3
CODE_C464CE = $C464CE
CODE_C465C1 = $C465C1
CODE_C46689 = $C46689
CODE_C46755 = $C46755
CODE_C4683F = $C4683F
CODE_C4694F = $C4694F
CODE_C46BF6 = $C46BF6
CODE_C42D10 = $C42D10
CODE_C44EE1 = $C44EE1
CODE_C54A0E = $C54A0E
CODE_C54A2F = $C54A2F
DATA8_C09BC4 = $C09BC4
DivX8S = $C09290

incsrc "../bankC4_5000.asm"

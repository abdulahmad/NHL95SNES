;	Segment build for bankC4_5000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_5000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C42D10 = $C42D10
CODE_C44EE1 = $C44EE1
CODE_C54A0E = $C54A0E
CODE_C54A2F = $C54A2F
DATA8_C09BC4 = $C09BC4
DivX8S = $C09290

incsrc "../bankC4_5000.asm"

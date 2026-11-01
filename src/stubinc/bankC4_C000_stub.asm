;	Segment build for bankC4_C000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_C000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C4D05B = $C4D05B
CODE_C4D0D5 = $C4D0D5
CODE_C4BE34 = $C4BE34
CODE_C4BE53 = $C4BE53
CODE_C4BF1A = $C4BF1A
CODE_C58AF3 = $C58AF3
CODE_C58B11 = $C58B11
TeamPalettes = $C00000

incsrc "../bankC4_C000.asm"

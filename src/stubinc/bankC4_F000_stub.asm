;	Segment build for bankC4_F000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_F000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C52CA7 = $C52CA7
CODE_C5C6A2 = $C5C6A2

incsrc "../bankC4_F000.asm"

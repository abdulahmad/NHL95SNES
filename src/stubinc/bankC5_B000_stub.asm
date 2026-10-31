;	Segment build for bankC5_B000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_B000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C589B0 = $C589B0
CODE_C589E4 = $C589E4
CODE_C58B11 = $C58B11
CODE_C5A321 = $C5A321
CODE_C5A4B9 = $C5A4B9
FadeOutWait = $C58A99
Mul8U = $C08ED9

incsrc "../bankC5_B000.asm"

;	Segment build for bankC5_C000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_C000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C589B0 = $C589B0
CODE_C589E4 = $C589E4
CODE_C58D32 = $C58D32
CODE_C5A3C1 = $C5A3C1
CODE_C5A46A = $C5A46A
CODE_C5A4A5 = $C5A4A5
CODE_C5A4B9 = $C5A4B9
CODE_C5A4E2 = $C5A4E2
CODE_C5B67A = $C5B67A
FadeOutWait = $C58A99
Mul8U = $C08ED9

incsrc "../bankC5_C000.asm"

;	Segment build for bankC5_E000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_E000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C4BCA4 = $C4BCA4
CODE_C40A6D = $C40A6D
CODE_C55951 = $C55951
DATA8_C04AA9 = $C04AA9
Div16x8U = $C09257
Mul16U = $C0906C
UnpackStream0 = $C5F071
CODE_C58CCD = $C58CCD
CODE_C5A3C1 = $C5A3C1
CODE_C5A46A = $C5A46A
CODE_C5B983 = $C5B983
CODE_C5BBC0 = $C5BBC0
CODE_C5D7E9 = $C5D7E9
FadeOutWait = $C58A99

incsrc "../bankC5_E000.asm"

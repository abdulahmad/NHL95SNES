;	Segment build for bankCF_E000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankCF_E000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
DATA8_CFF3A0 = $CFF3A0				; layout pointers (bankCF_F000)
DATA8_CFF3A2 = $CFF3A2				; layout pointers (bankCF_F000)
CODE_CFF0CB = $CFF0CB
CODE_CFF0F6 = $CFF0F6
CODE_CFF137 = $CFF137
CODE_CFF240 = $CFF240
CODE_CFF279 = $CFF279
DATA8_C60848 = $C60848				; source bank and layout words (bankC6_0000)
CODE_C3846C = $C3846C
CODE_C5287A = $C5287A
DATA8_C61090 = $C61090
DATA8_C618D8 = $C618D8
DATA8_C62120 = $C62120

incsrc "../bankCF_E000.asm"

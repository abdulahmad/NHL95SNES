;	Segment build for bankC5_D000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_D000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C52CC1 = $C52CC1
BCDTable = $C08C76
Div16U = $C091F3
BuildSpriteOAM = $C5F0D1
CODE_C5F3DB = $C5F3DB
AnimateSprites = $C5E9C7
CODE_C5DF5F = $C5DF5F
CODE_C5E123 = $C5E123
CODE_C5E596 = $C5E596
CODE_C5ECBD = $C5ECBD
CreateSprite = $C5E665
CODE_C589B0 = $C589B0
CODE_C58B11 = $C58B11
CODE_C58CCD = $C58CCD
CODE_C5C6B7 = $C5C6B7
DATA8_C598FA = $C598FA
DATA8_C5A1D7 = $C5A1D7
DATA8_C5A225 = $C5A225
DATA8_C5A25B = $C5A25B
FadeOutWait = $C58A99
Mul8U = $C08ED9
SetupHDMA = $C58AA5

incsrc "../bankC5_D000.asm"

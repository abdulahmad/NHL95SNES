;	Segment build for bankC5_3000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_3000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C55EC7 = $C55EC7
CODE_C53FE5 = $C53FE5
CODE_C54E59 = $C54E59
BCDTable = $C08C76
CODE_C510F6 = $C510F6
CODE_C51397 = $C51397
CODE_C528D4 = $C528D4
CODE_C58C36 = $C58C36
CODE_C5B67A = $C5B67A
CODE_C5D7CD = $C5D7CD
CODE_C5D7E9 = $C5D7E9
CODE_C5E50E = $C5E50E
CODE_C5EE6C = $C5EE6C
CreateSpriteSharePal = $C5EEF3
Div16x8U = $C09257
Mul8U = $C08ED9
QueueVRAMDMALen = $C58A15

incsrc "../bankC5_3000.asm"

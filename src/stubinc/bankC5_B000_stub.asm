;	Segment build for bankC5_B000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_B000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
AnimateSprites = $C5E9C7
CODE_C5E37E = $C5E37E
CODE_C5E596 = $C5E596
CreateSprite = $C5E665
CODE_C5D7CD = $C5D7CD
CODE_C5D7E9 = $C5D7E9
CODE_C5D804 = $C5D804
CODE_C5BFE0 = $C5BFE0
CODE_C5C029 = $C5C029
CODE_C589B0 = $C589B0
CODE_C589E4 = $C589E4
CODE_C58B11 = $C58B11
CODE_C5A321 = $C5A321
CODE_C5A4B9 = $C5A4B9
FadeOutWait = $C58A99
Mul8U = $C08ED9

incsrc "../bankC5_B000.asm"

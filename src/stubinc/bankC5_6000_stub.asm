;	Segment build for bankC5_6000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_6000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
AnimateSprites = $C5E9C7
BCDTable = $C08C76
BuildSpriteOAM = $C5F0D1
CODE_C5004E = $C5004E
CODE_C53ABC = $C53ABC
CODE_C54AEF = $C54AEF
CODE_C54FA9 = $C54FA9
CODE_C552AC = $C552AC
CODE_C55951 = $C55951
CODE_C55A09 = $C55A09
CODE_C55A40 = $C55A40
CODE_C55ABC = $C55ABC
CODE_C55BE8 = $C55BE8
CODE_C55C12 = $C55C12
CODE_C55C58 = $C55C58
CODE_C55CE6 = $C55CE6
CODE_C55E57 = $C55E57
CODE_C55EC7 = $C55EC7
CODE_C55ECA = $C55ECA
CODE_C55F1F = $C55F1F
CODE_C58B11 = $C58B11
CODE_C58BB9 = $C58BB9
CODE_C5A321 = $C5A321
CODE_C5E596 = $C5E596
CODE_C5F3DB = $C5F3DB
DATA8_C55D6B = $C55D6B
Div16U = $C091F3
Div16x8U = $C09257
FadeOutWait = $C58A99
Mul8U = $C08ED9
WaitFrames_Inc = $C08D89

incsrc "../bankC5_6000.asm"

;	Segment build for bankC4_B000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_B000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
AnimateSprites = $C5E9C7
BuildSpriteOAM = $C5F0D1
CODE_C4AF74 = $C4AF74
CODE_C58AD9 = $C58AD9
CODE_C58AF3 = $C58AF3
CODE_C58B2B = $C58B2B
CODE_C58B2E = $C58B2E
CODE_C58B48 = $C58B48
CODE_C58BE4 = $C58BE4
CODE_C5F3DB = $C5F3DB
ClearNMIHook = $C08D64
CreateSprite = $C5E665
FadeOutWait = $C58A99
MapSetToVRAM = $C58527
ResetPPURegs = $C08E9D
SetNMIHook = $C08D73
SpritePieces = $C19660
TeamPalettes = $C00000

incsrc "../bankC4_B000.asm"

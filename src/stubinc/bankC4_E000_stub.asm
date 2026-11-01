;	Segment build for bankC4_E000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_E000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
AnimateSprites = $C5E9C7
BlueColoursHook = $C04A65
BuildSpriteOAM = $C5F0D1
CODE_C4BAF6 = $C4BAF6
CODE_C4BBE5 = $C4BBE5
CODE_C4BBF1 = $C4BBF1
CODE_C4BC08 = $C4BC08
CODE_C4BC1A = $C4BC1A
CODE_C4BCA4 = $C4BCA4
CODE_C4BCAA = $C4BCAA
CODE_C4BDAE = $C4BDAE
CODE_C4C2AA = $C4C2AA
CODE_C4C3BA = $C4C3BA
CODE_C4C530 = $C4C530
CODE_C4C536 = $C4C536
CODE_C4C541 = $C4C541
CODE_C4C547 = $C4C547
CODE_C4C558 = $C4C558
CODE_C4CEDB = $C4CEDB
CODE_C4D773 = $C4D773
CODE_C55AB8 = $C55AB8
CODE_C55C54 = $C55C54
CODE_C55EC3 = $C55EC3
CODE_C55F8A = $C55F8A
CODE_C56005 = $C56005
CODE_C560A8 = $C560A8
CODE_C571C7 = $C571C7
CODE_C5881C = $C5881C
CODE_C589B0 = $C589B0
CODE_C589E4 = $C589E4
CODE_C58B11 = $C58B11
CODE_C5A4B5 = $C5A4B5
CODE_C5A4DE = $C5A4DE
CODE_C5B676 = $C5B676
CODE_C5BBBC = $C5BBBC
CODE_C5E50E = $C5E50E
CODE_C5E596 = $C5E596
CODE_C5F3DB = $C5F3DB
ClearNMIHook = $C08D64
CreateSprite = $C5E665
Decompress = $C581E1
FadeOutWait = $C58A99
MapSetToVRAM = $C58527
SetNMIHook = $C08D73
SetupHDMA = $C58AA5

incsrc "../bankC4_E000.asm"

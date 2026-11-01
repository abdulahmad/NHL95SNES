;	Segment build for bankC5_B000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_B000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C387D8 = $C387D8
DATA8_C3585C = $C3585C
DATA8_C360D4 = $C360D4
PlayerList = $C30038
DATA8_C4C4A6 = $C4C4A6
CODE_C4C2AA = $C4C2AA
UnpackText = $C4C3BA
ResetWorkBuf = $C4C530
MarkWorkBuf = $C4C541
AllocClearWorkBuf = $C4C547
AllocWorkBuf = $C4C558
CODE_C4CEDB = $C4CEDB
CODE_C4BAF6 = $C4BAF6
PrintTextPage = $C4BB5A
CODE_C4BBFC = $C4BBFC
CODE_C4BC08 = $C4BC08
CODE_C4BC0E = $C4BC0E
CODE_C4BC1A = $C4BC1A
CODE_C4BC20 = $C4BC20
CODE_C4BCA4 = $C4BCA4
CODE_C4BCAA = $C4BCAA
CODE_C55ABC = $C55ABC
CODE_C55EC7 = $C55EC7
CODE_C55ECA = $C55ECA
CODE_C55F8A = $C55F8A
CODE_C55F98 = $C55F98
CODE_C52CC1 = $C52CC1
BCDTable = $C08C76
DATA8_C04CB7 = $C04CB7
Div32x32U = $C09113
Mul16U = $C0906C
Mul16x8U = $C08F5E
BuildSpriteOAM = $C5F0D1
CODE_C5F3DB = $C5F3DB
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
ClearRAM7E = $C58B11
CODE_C5A321 = $C5A321
CODE_C5A4B9 = $C5A4B9
FadeOutWait = $C58A99
Mul8U = $C08ED9

incsrc "../bankC5_B000.asm"

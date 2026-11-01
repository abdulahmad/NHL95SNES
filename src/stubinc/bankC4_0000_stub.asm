;	Segment build for bankC4_0000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_0000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C3716D = $C3716D
CODE_C36C2D = $C36C2D
StanleyCupScreen = $C4DFD6
SeasonAwards = $C4D818
CODE_C4C2AA = $C4C2AA
CODE_C4C3BA = $C4C3BA
CODE_C4C530 = $C4C530
CODE_C4C536 = $C4C536
CODE_C4C541 = $C4C541
CODE_C4C558 = $C4C558
CODE_C4CEDB = $C4CEDB
CODE_C4BAF6 = $C4BAF6
CODE_C4BB5A = $C4BB5A
CODE_C4BBE5 = $C4BBE5
CODE_C4BBFC = $C4BBFC
CODE_C4BC08 = $C4BC08
DATA8_C41006 = $C41006
DATA8_C4103E = $C4103E
DATA8_C41076 = $C41076
DATA8_C410AE = $C410AE
DATA8_C410E6 = $C410E6
DATA8_C41166 = $C41166
AnimateSprites = $C5E9C7
BuildSpriteOAM = $C5F0D1
CODE_C52CA3 = $C52CA3
CODE_C55EC3 = $C55EC3
CODE_C58812 = $C58812
CODE_C589B0 = $C589B0
CODE_C589E4 = $C589E4
CODE_C58B11 = $C58B11
CODE_C58CCD = $C58CCD
GameSetUp = $C58D32
CODE_C5A507 = $C5A507
SeasonOptions = $C5A51C
CODE_C5ADDC = $C5ADDC
CODE_C5AF07 = $C5AF07
CODE_C5BBBC = $C5BBBC
CODE_C5BD52 = $C5BD52
CODE_C5BD7D = $C5BD7D
CODE_C5BDA8 = $C5BDA8
CODE_C5BDE7 = $C5BDE7
CODE_C5BE33 = $C5BE33
CODE_C5E37E = $C5E37E
CODE_C5E50E = $C5E50E
CODE_C5E596 = $C5E596
CODE_C5F3DB = $C5F3DB
CreateSprite = $C5E665
DecompressUnpackbuf = $C581D7
FadeOutWait = $C58A99
Reset = $C0FD0E
SetNMIHook = $C08D73
SetupHDMA = $C58AA5

incsrc "../bankC4_0000.asm"

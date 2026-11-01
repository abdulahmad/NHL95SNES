;	Segment build for bankC5_4000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_4000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C4C3AE = $C4C3AE
CODE_C4C561 = $C4C561
CODE_C4CEDB = $C4CEDB
CODE_C4981D = $C4981D
CODE_C4694F = $C4694F
CODE_C457B5 = $C457B5
CODE_C457C7 = $C457C7
CODE_C45950 = $C45950
CODE_C4370C = $C4370C
CODE_C4373E = $C4373E
CODE_C56104 = $C56104
CODE_C56262 = $C56262
CODE_C54F05 = $C54F05
CODE_C54F94 = $C54F94
CODE_C5503C = $C5503C
CODE_C55513 = $C55513
AnimateSprites = $C5E9C7
BuildSpriteOAM = $C5F0D1
CODE_C5111A = $C5111A
CODE_C51397 = $C51397
CODE_C53616 = $C53616
CODE_C5362E = $C5362E
CODE_C539D7 = $C539D7
CODE_C53AE0 = $C53AE0
CODE_C53C20 = $C53C20
CODE_C53C46 = $C53C46
CODE_C58C36 = $C58C36
CODE_C5E596 = $C5E596
CODE_C5F3DB = $C5F3DB
DATA8_C09B3F = $C09B3F
Div16U = $C091F3
Div16x8U = $C09257
FadeOutWait = $C58A99
Mul16S = $C09035
Mul16x8XS = $C08F95
QueueVRAMDMALen = $C58A15

incsrc "../bankC5_4000.asm"

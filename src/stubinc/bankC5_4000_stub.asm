;	Segment build for bankC5_4000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_4000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_CF0134 = $CF0134
CODE_CF039E = $CF039E
CODE_CF03D0 = $CF03D0
CODE_CF040B = $CF040B
randoma8 = $C37EAA
CODE_C36C49 = $C36C49
UnpackText2 = $C4C3AE
AllocWorkBuf2 = $C4C561
CODE_C4CEDB = $C4CEDB
CompShoot = $C4981D
doplayeracc = $C4694F
SetSPAFromA = $C457B5
SetSPAUpdate = $C457C7
skateto = $C45950
assexit = $C4370C
assreplace = $C4373E
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
loadTeamStruct = $C53616
CODE_C5362E = $C5362E
CODE_C539D7 = $C539D7
ResetBench = $C53AE0
Setplass = $C53C20
setplayer = $C53C46
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
DATA8_CF05D4 = $CF05D4

incsrc "../bankC5_4000.asm"

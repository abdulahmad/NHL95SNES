;	Segment build for bankC4_3000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_3000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_CF038E = $CF038E
CODE_CF040B = $CF040B
CODE_CF048A = $CF048A
SprSort = $C384FC
randomd0s = $C37EC8
vtoa = $C37F6D
RestoreWorkBuf = $C4C536
MarkWorkBuf = $C4C541
AllocWorkBuf = $C4C558
CODE_C4CEDB = $C4CEDB
SeatPenaltyBox = $C47F7A
doplayeracc = $C4694F
check4check = $C45529
SetSPA = $C457A1
SetSPAFromA = $C457B5
updateanim = $C457DD
skateto = $C45950
CODE_C42D98 = $C42D98
CODE_C516C2 = $C516C2
CODE_C51999 = $C51999
CODE_C51A13 = $C51A13
CODE_C51A61 = $C51A61
CODE_C51AFF = $C51AFF
CODE_C52008 = $C52008
CODE_C52264 = $C52264
checkwindow = $C529D7
CODE_C533EF = $C533EF
CODE_C53651 = $C53651
CODE_C539D7 = $C539D7
CODE_C53A29 = $C53A29
ResetBench = $C53AE0
CODE_C53B51 = $C53B51
CODE_C53F8D = $C53F8D
setpersonel = $C541D3
check4bench = $C549A8
CODE_C54BAF = $C54BAF
CODE_C5881C = $C5881C
CODE_C58944 = $C58944
CODE_C58C36 = $C58C36
CODE_C5ECBD = $C5ECBD
CODE_C5EE6C = $C5EE6C
CreateSpriteSharePal = $C5EEF3
DATA8_C09B3F = $C09B3F
FadeOutWait = $C58A99
QueueVRAMDMALen = $C58A15
RandomWord = $C08E48
FaceOffMap = $C1CFE2

incsrc "../bankC4_3000.asm"

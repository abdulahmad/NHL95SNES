;	Segment build for bankC4_3000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_3000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_CF038E = $CF038E
StartSound = $CF040B
PlayTeamSong = $CF048A
SprSort = $C384FC
randomd0s = $C37EC8
vtoa = $C37F6D
RestoreWorkBuf = $C4C536
MarkWorkBuf = $C4C541
AllocWorkBuf = $C4C558
WaitTransfers = $C4CEDB
SeatPenaltyBox = $C47F7A
doplayeracc = $C4694F
check4check = $C45529
SetSPA = $C457A1
SetSPAFromA = $C457B5
updateanim = $C457DD
skateto = $C45950
CODE_C42D98 = $C42D98
PushTime = $C516C2
CODE_C51999 = $C51999
CODE_C51A13 = $C51A13
SetupPenaltyShot = $C51A61
CODE_C51AFF = $C51AFF
CODE_C52008 = $C52008
ClrHor = $C52264
checkwindow = $C529D7
CODE_C533EF = $C533EF
CODE_C53651 = $C53651
CODE_C539D7 = $C539D7
CODE_C53A29 = $C53A29
ResetBench = $C53AE0
forcepldata = $C53B51
resetplstuff = $C53F8D
setpersonel = $C541D3
check4bench = $C549A8
CODE_C54BAF = $C54BAF
MapSetToWRAM = $C5881C
CODE_C58944 = $C58944
Framer = $C58C36
SetSpriteAnim = $C5ECBD
CODE_C5EE6C = $C5EE6C
CreateSpriteSharePal = $C5EEF3
DATA8_C09B3F = $C09B3F
FadeOutWait = $C58A99
QueueVRAMDMALen = $C58A15
RandomWord = $C08E48
FaceOffMap = $C1CFE2

incsrc "../bankC4_3000.asm"

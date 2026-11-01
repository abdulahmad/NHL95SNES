;	Segment build for bankC5_1000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_1000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_CF03D0 = $CF03D0
CODE_CF040B = $CF040B
CODE_C38824 = $C38824
ReadjoyA = $C3704D
randoma8 = $C37EAA
CODE_C37EBF = $C37EBF
CODE_C36CBF = $C36CBF
CopyString2 = $C4C47E
AllocWorkBuf2 = $C4C561
pucknorm_move = $C493E1
CODE_C4818C = $C4818C
a2touchpuck = $C4843B
ReturnGoalies = $C48840
Stop4Pen = $C47323
SetSPAFromA = $C457B5
assreplace = $C4373E
GetShifter = $C4075F
CODE_C40A02 = $C40A02
CODE_C56262 = $C56262
CODE_C5589E = $C5589E
CODE_C558CC = $C558CC
BCDText = $C55EC7
CODE_C55F22 = $C55F22
CODE_C5404A = $C5404A
CODE_C54070 = $C54070
setpersonel = $C541D3
CompLine = $C547CB
CODE_C54BAF = $C54BAF
lcfound = $C54DA4
SetupTeamForIntermission = $C54DDF
Pausemode_menu = $C54E6D
CODE_C538FE = $C538FE
CODE_C52008 = $C52008
CODE_C52264 = $C52264
freezewindow = $C52284
CODE_C52295 = $C52295
CODE_C528D3 = $C528D3
CODE_C528D4 = $C528D4
clockcont_0 = $C50A14
CODE_C50ADD = $C50ADD
CODE_C58944 = $C58944
CODE_C58C36 = $C58C36
BinToBCD = $C5B67A
DeleteSprite = $C5E596
DATA8_C09C04 = $C09C04
Div16x8U = $C09257
QueueVRAMDMALen = $C58A15
RandomWord = $C08E48

incsrc "../bankC5_1000.asm"

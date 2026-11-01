;	Segment build for bankC0_9000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC0_9000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C370A5 = $C370A5
ProcessInputWithRepeat = $C370B2
ReadPads = $C36CBF
UnpackText = $C4C3BA
AllocWorkBuf2 = $C4C561
CODE_C4818C = $C4818C
StartPenaltyShot = $C4866D
CODE_C48A41 = $C48A41
AddPenalty2 = $C478C3
Create_HotCold_Table = $C54E27
CODE_C5362E = $C5362E
CODE_C53980 = $C53980
GetPadTeam = $C53ABC
CODE_C528D4 = $C528D4
CODE_C52CA3 = $C52CA3
CODE_C5009B = $C5009B
CODE_C5016D = $C5016D
Gameloop = $C5021B
CODE_C50F08 = $C50F08
CODE_C58C36 = $C58C36
QueueVRAMDMALen = $C58A15
Mul16x8XS_negres = $C08FA6
WaitFrame = $C08D7E
Mul16x8HiU_Pre = $C08FCE
Mul16x8HiU_Go = $C08FD8
Mul16x8Hi_Zero = $C09001
ScreenOn = $C08E99
DATA8_C09BC4 = $C09BC4

incsrc "../bankC0_9000.asm"

;	Segment build for bankC0_9000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC0_9000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
ReadPausePad = $C370A5				; read the controller that owns the pause menu
ProcessInputWithRepeat = $C370B2
ReadPads = $C36CBF
UnpackText = $C4C3BA
AllocWorkBuf2 = $C4C561
ClearPenaltyBuffer = $C4818C
StartPenaltyShot = $C4866D
GoalieCount = $C48A41				; count the goalie odds nibbles for team a2 into d0
AddPenalty2 = $C478C3
Create_HotCold_Table = $C54E27
GetPlayerCount = $C5362E
CODE_C53980 = $C53980
GetPadTeam = $C53ABC
eraser = $C528D4
LoadGameRostersLong = $C52CA3
StartGame_go = $C5009B
StartPer = $C5016D
Gameloop = $C5021B
GetNameandAttrib = $C50F08
Framer = $C58C36
QueueVRAMDMALen = $C58A15
Mul16x8XS_negres = $C08FA6
WaitFrame = $C08D7E
Mul16x8HiU_Pre = $C08FCE
Mul16x8HiU_Go = $C08FD8
Mul16x8Hi_Zero = $C09001
ScreenOn = $C08E99
DATA8_C09BC4 = $C09BC4

incsrc "../bankC0_9000.asm"

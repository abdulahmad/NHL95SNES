;	Segment build for bankC0_9000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC0_9000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C5009B = $C5009B
CODE_C5016D = $C5016D
CODE_C5021B = $C5021B
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

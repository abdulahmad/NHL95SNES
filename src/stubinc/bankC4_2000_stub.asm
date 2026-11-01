;	Segment build for bankC4_2000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_2000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C37EBF = $C37EBF
CODE_C37EC8 = $C37EC8
CODE_C37F6D = $C37F6D
CODE_C49FBD = $C49FBD
CODE_C495BB = $C495BB
CODE_C495E8 = $C495E8
CODE_C4837C = $C4837C
CODE_C48A71 = $C48A71
CODE_C4702E = $C4702E
CODE_C45529 = $C45529
SetSPAFromA = $C457B5
CODE_C45950 = $C45950
donothing = $C436FD
assexit = $C4370C
CODE_C43734 = $C43734
CODE_C4373E = $C4373E
CODE_C5492E = $C5492E
check4bench = $C549A8
getpde = $C54A0E
CODE_C54A2F = $C54A2F
Mul8XS = $C08EEC

incsrc "../bankC4_2000.asm"

;	Segment build for bankC4_7000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_7000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C4370C = $C4370C
CODE_C43734 = $C43734
CODE_C4373E = $C4373E
CODE_C44F20 = $C44F20
CODE_C45606 = $C45606
CODE_C457A1 = $C457A1
CODE_C457B5 = $C457B5
CODE_C45950 = $C45950
CODE_C45A9F = $C45A9F
CODE_C4694F = $C4694F
CODE_C46BF6 = $C46BF6
CODE_C510DF = $C510DF
CODE_C513F4 = $C513F4
CODE_C516C2 = $C516C2
CODE_C51F7C = $C51F7C
CODE_C5226A = $C5226A
CODE_C52284 = $C52284
CODE_C538DE = $C538DE
CODE_C53A29 = $C53A29
CODE_C53A71 = $C53A71
CODE_C54BAF = $C54BAF
DATA8_C58942 = $C58942
FadeOutWait = $C58A99
Mul16S = $C09035
Mul16x8XS = $C08F95
Mul8U = $C08ED9
QueueVRAMDMALen = $C58A15

incsrc "../bankC4_7000.asm"

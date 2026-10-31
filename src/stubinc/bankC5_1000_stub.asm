;	Segment build for bankC5_1000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_1000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C538FE = $C538FE
CODE_C52008 = $C52008
CODE_C52264 = $C52264
CODE_C52284 = $C52284
CODE_C52295 = $C52295
CODE_C528D3 = $C528D3
CODE_C528D4 = $C528D4
CODE_C50A14 = $C50A14
CODE_C50ADD = $C50ADD
CODE_C58944 = $C58944
CODE_C58C36 = $C58C36
CODE_C5B67A = $C5B67A
CODE_C5E596 = $C5E596
DATA8_C09C04 = $C09C04
Div16x8U = $C09257
QueueVRAMDMALen = $C58A15
RandomWord = $C08E48

incsrc "../bankC5_1000.asm"

;	Segment build for bankC3_8000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC3_8000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_CFEE25 = $CFEE25
CODE_CFEE6C = $CFEE6C
DATA8_CE0192 = $CE0192				; a per-frame offset table
DATA8_CDF94A = $CDF94A				; a per-frame offset table
vtoa = $C37F6D
assinsert = $C43734
CODE_C481D5 = $C481D5
UnpackText2 = $C4C3AE
AllocWorkBuf = $C4C558
ShowGoalBox = $C51825
FitNameToWorkBuf = $C55F8A
CODE_C56100 = $C56100
CODE_C5625E = $C5625E
Framer = $C58C36
QueueFrameTiles = $C5F368
DATA8_C34499 = $C34499
DATA8_C3449A = $C3449A
DATA8_C3449B = $C3449B
DATA8_C58942 = $C58942
QueueVRAMDMALen = $C58A15
SetIRQ = $C08D16

incsrc "../bankC3_8000.asm"

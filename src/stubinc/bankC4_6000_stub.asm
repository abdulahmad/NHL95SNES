;	Segment build for bankC4_6000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_6000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
DATA8_C38A4A = $C38A4A
CODE_C37F6D = $C37F6D
CODE_C486FD = $C486FD
CODE_C457A1 = $C457A1
CODE_C457B5 = $C457B5
CODE_C458A2 = $C458A2
CODE_C45ABE = $C45ABE
CODE_C54A0E = $C54A0E
CODE_C54A2F = $C54A2F
DATA8_C09BC4 = $C09BC4
DATA8_C45C7D = $C45C7D
Mul16x8S = $C08FB7

incsrc "../bankC4_6000.asm"

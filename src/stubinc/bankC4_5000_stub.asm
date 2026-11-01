;	Segment build for bankC4_5000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_5000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
StartSound = $CF040B
SignedSquareTable = $C38A4A
CODE_C382B6 = $C382B6
ApproxLength = $C38778
randomd0A = $C37E95
randoma8 = $C37EAA
randomd0 = $C37EBF					; replace d0 with a random number below its current value
vtoa = $C37F6D
PenShotChk = $C480B5
checkagr = $C48199
setInjuryType = $C4824A
Stop4Pen = $C47323
AddPenalty = $C4789D
AddPenalty2 = $C478C3
CODE_C47C8C = $C47C8C
DATA8_C4692F = $C4692F
DATA8_C4693F = $C4693F
PlayerAccDir2x2 = $C45FAC
PlayerAccDir3 = $C46075
PlayerAccDir3x2 = $C4615F
PlayerAccDir4 = $C4624F
PlayerAccDir4x2 = $C46317
PlayerAccDir5 = $C463E3
PlayerAccDir5x2 = $C464CE
PlayerAccDir6 = $C465C1
PlayerAccDir6x2 = $C46689
PlayerAccDir7 = $C46755
PlayerAccDir7x2 = $C4683F
doplayeracc = $C4694F
CODE_C46BF6 = $C46BF6
CODE_C42D10 = $C42D10
CollisionSfx = $C44EE1
getpde = $C54A0E
setpde = $C54A2F
DATA8_C09BC4 = $C09BC4
DivX8S = $C09290

incsrc "../bankC4_5000.asm"

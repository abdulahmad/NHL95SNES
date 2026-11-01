;	Segment build for bankC4_2000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_2000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
randomd0 = $C37EBF					; replace d0 with a random number below its current value
randomd0s = $C37EC8
vtoa = $C37F6D
chk4pass = $C49FBD
skatetopuckinit = $C495BB
chk4shot = $C495E8
checkob = $C4837C
assgoalie = $C48A71
skatetopuck = $C4702E
check4check = $C45529
SetSPAFromA = $C457B5
skateto = $C45950
donothing = $C436FD
assexit = $C4370C
assinsert = $C43734
assreplace = $C4373E
chk4lc = $C5492E
check4bench = $C549A8
getpde = $C54A0E
setpde = $C54A2F
Mul8XS = $C08EEC

incsrc "../bankC4_2000.asm"

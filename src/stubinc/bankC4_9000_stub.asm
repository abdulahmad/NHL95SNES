;	Segment build for bankC4_9000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_9000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
StartSound = $CF040B
SignedSquareTable = $C38A4A
GetFrameHot = $C37FE2				; return the current frame hot spot in d0 and d1
ApproxLength = $C38778
randomd0A = $C37E95
randoma8 = $C37EAA
randomd0s = $C37EC8
randomd0sd0 = $C37ED4
vtoa = $C37F6D
AssignDumpIn = $C4A4AB				; replace the current assignment with a dump-in
PuckIChk = $C4AE9C
ChkOffsides = $C4AED5
GlideBack = $C42B18
chkpk = $C42D98						; return zero if player X is killing a penalty
donothing = $C436FD
assexit = $C4370C
assreplace = $C4373E
checkpuckcoll = $C44B0F
SetSPA = $C457A1
SetSPAFromA = $C457B5
updateanim = $C457DD
skateto = $C45950
AddPenalty2 = $C478C3
a2touchpuck = $C4843B
CheckBreakaway = $C48590
EndPenaltyShot = $C486C7
makepde = $C54A47
Div32S = $C09145
Div32U = $C09188
Mul16S = $C09035
Mul16U = $C0906C
Mul16XS = $C09053
Mul16x8U = $C08F5E
Mul16x8XS = $C08F95
RandomWord = $C08E48

incsrc "../bankC4_9000.asm"

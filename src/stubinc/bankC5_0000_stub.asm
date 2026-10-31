;	Segment build for bankC5_0000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_0000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
BitMaskTable = $C04CC7
BitMaskTable2 = $C09C24
CODE_C092B3 = $C092B3
CODE_C093DD = $C093DD
CODE_C5897B = $C5897B
CODE_C589B0 = $C589B0
CODE_C58D32 = $C58D32
CODE_C5ADDC = $C5ADDC
CODE_C5AF07 = $C5AF07
CODE_C5D5CD = $C5D5CD
CODE_C5DD47 = $C5DD47
CODE_C5DDF0 = $C5DDF0
CODE_C5DE1F = $C5DE1F
CODE_C5DE9B = $C5DE9B
CODE_C5E17C = $C5E17C
CODE_C5E20B = $C5E20B
CODE_C5E49A = $C5E49A
CODE_C5E4D2 = $C5E4D2
Div16x8U = $C09257
Div32U = $C09188
DivX8U = $C0927A
FadeOutWait = $C58A99
InitHooks = $C08B37
Mul16x8HiXS = $C09005
Mul16x8U = $C08F5E
Mul16x8XS = $C08F95
Mul8U = $C08ED9
QueueVRAMDMALen = $C58A15
RandomWord = $C08E48
ScreenOn = $C08E99
asstab = $C09A24
forceblack = $C08E93

incsrc "../bankC5_0000.asm"

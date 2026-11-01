;	Segment build for bankC3_7000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC3_7000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
QueueSoundCmd = $CF00E3
SquareTable = $C3884A
SignedSquareTable = $C38A4A
UpdateGameObjectSprites = $C382B8	; queue changed player frames and build sorted object sprites
SprSort = $C384FC
showref = $C38CF5					; clear the referee window changed flag
AnimateSprites = $C5E9C7
BuildSpriteOAM = $C5F0D1
ReadPads = $C36CBF
checkwallcoll = $C440C2
WaitTransfers = $C4CEDB
FadeOut = $C50E94
CODE_C52264 = $C52264
CODE_C5226A = $C5226A
updatescroll = $C526E8
CODE_C526FB = $C526FB
updatescroll_rows = $C528D5
MapSetToWRAM = $C5881C
CODE_C5897B = $C5897B
QueueFrameTiles = $C5F368
PackOAMHigh = $C5F3DB
Div32U = $C09188
Mul16U = $C0906C
Mul8U = $C08ED9
RandomWord = $C08E48
ScreenOn = $C08E99
WaitFrames_Inc = $C08D89
forceblack = $C08E93
PadButtonsMap = $C1D778

incsrc "../bankC3_7000.asm"

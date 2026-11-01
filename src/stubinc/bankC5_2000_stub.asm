;	Segment build for bankC5_2000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_2000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_CFEE6C = $CFEE6C
IceRinkMap = $CCEEA5				; the rink map set
setpads = $C38043
CODE_C382B8 = $C382B8
CODE_C3856E = $C3856E
CODE_C38CF5 = $C38CF5
PhotoPaletteTable = $C35EAB
UnpackText = $C4C3BA
RestoreWorkBuf = $C4C536
MarkWorkBuf = $C4C541
AllocWorkBuf = $C4C558
WaitTransfers = $C4CEDB
CODE_C4A0C1 = $C4A0C1
SetShotMode = $C49858
CODE_C498D3 = $C498D3
setpassmode = $C49DC7
checkob = $C4837C
doplayeracc = $C4694F
Holdplayer = $C45610
CODE_C43734 = $C43734
CODE_C42D10 = $C42D10
CODE_C5404A = $C5404A
lineinput = $C54541
CODE_C5308D = $C5308D
CODE_C530A0 = $C530A0
CODE_C53106 = $C53106
CODE_C53167 = $C53167
CODE_C531C7 = $C531C7
AssignPadPlayer = $C53776
findpc = $C537C4
CODE_C538FE = $C538FE
CODE_C53903 = $C53903
CODE_C53921 = $C53921
CODE_C539D7 = $C539D7
CODE_C53A29 = $C53A29
AnimateSprites = $C5E9C7
BuildSpriteOAM = $C5F0D1
PauseFromPad = $C50D24
CODE_C51C58 = $C51C58
CODE_C58812 = $C58812
CODE_C5897B = $C5897B
CODE_C5BD30 = $C5BD30
CODE_C5D7CD = $C5D7CD
CODE_C5D7E9 = $C5D7E9
CODE_C5D804 = $C5D804
CODE_C5D821 = $C5D821
CODE_C5D83F = $C5D83F
CODE_C5F368 = $C5F368
CODE_C5F3DB = $C5F3DB
Decompress = $C581E1
DecompressToVRAM = $C58A65
DecompressUnpackbuf = $C581D7
forceblack = $C08E93
CenterIceTiles = $C2792B
DigitFontTiles = $C04642
LinePieceTiles = $C04708
MeterFontTiles = $C00976
RefsMap = $C2CC6E

incsrc "../bankC5_2000.asm"

;	Segment build for bankC4_B000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC4_B000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
LoadSounds = $CF0134
StartSound = $CF040B
ReadMenuPads = $C36C2D
Multi5Bios = $C36D3A
DATA8_C4C07D = $C4C07D
DATA8_C4C4B6 = $C4C4B6
DATA8_C4C4D7 = $C4C4D7
DATA8_C4C502 = $C4C502
CODE_C4C068 = $C4C068
CODE_C4C070 = $C4C070
CODE_C4C08D = $C4C08D
QueueTextTiles = $C4C20C
MapTextTiles = $C4C270
SendTextMap = $C4C2AA
TextWidth = $C4C31D
CODE_C4C386 = $C4C386
UnpackText = $C4C3BA
CentreText = $C4C46B
RestoreWorkBuf = $C4C536
MarkWorkBuf = $C4C541
AllocClearWorkBuf = $C4C547
AllocWorkBuf = $C4C558
WaitTransfers = $C4CEDB
AnimateSprites = $C5E9C7
BuildSpriteOAM = $C5F0D1
CODE_C4AF74 = $C4AF74
CODE_C58AD9 = $C58AD9
CODE_C58AF3 = $C58AF3
CODE_C58B2B = $C58B2B
CODE_C58B2E = $C58B2E
SetupMode7Screen = $C58B48
SetupMode1Screen = $C58BE4
PackOAMHigh = $C5F3DB
ClearNMIHook = $C08D64
CreateSprite = $C5E665
FadeOutWait = $C58A99
MapSetToVRAM = $C58527
ResetPPURegs = $C08E9D
SetNMIHook = $C08D73
SpritePieces = $C19660
DATA8_C07F7B = $C07F7B
HighScoreMap = $C2BB69
VisualConceptsMap = $C2B14A
VisualConceptsPalette = $C2BB22
BoldFontGlyphs = $C01A39
ItalicFontGlyphs = $C01FF9
ThinFontGlyphs = $C03239

incsrc "../bankC4_B000.asm"

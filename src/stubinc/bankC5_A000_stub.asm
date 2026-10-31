;	Segment build for bankC5_A000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC5_A000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C589B0 = $C589B0
CODE_C589E4 = $C589E4
CODE_C58B11 = $C58B11
CODE_C5909D = $C5909D
CODE_C590BB = $C590BB
CODE_C590DA = $C590DA
CODE_C59217 = $C59217
CODE_C59308 = $C59308
CODE_C593B1 = $C593B1
CODE_C5963A = $C5963A
DecompressUnpackbuf = $C581D7
FadeOutWait = $C58A99
SetupHDMA = $C58AA5

incsrc "../bankC5_A000.asm"

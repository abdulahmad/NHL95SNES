;	Segment build for bankC0_A000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC0_A000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
CODE_C493CA = $C493CA
CODE_C49595 = $C49595
CODE_C498A1 = $C498A1
CODE_C49B59 = $C49B59
CODE_C49DFB = $C49DFB
CODE_C488BB = $C488BB
CODE_C48A71 = $C48A71
rtss = $C4883F
CODE_C47122 = $C47122
CODE_C47B3F = $C47B3F
CODE_C47D2E = $C47D2E
CODE_C47F4C = $C47F4C
CODE_C45A47 = $C45A47
CODE_C4313E = $C4313E
CODE_C4332A = $C4332A
CODE_C4348E = $C4348E
CODE_C43590 = $C43590
CODE_C4375B = $C4375B
CODE_C4376F = $C4376F
CODE_C43826 = $C43826
CODE_C42B25 = $C42B25
CODE_C42DB8 = $C42DB8
CODE_C42F62 = $C42F62
CODE_C43099 = $C43099
CODE_C545C7 = $C545C7
CODE_C5474A = $C5474A
CODE_C51CC1 = $C51CC1

incsrc "../bankC0_A000.asm"

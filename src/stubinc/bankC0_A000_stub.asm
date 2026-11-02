;	Segment build for bankC0_A000.asm: sets the mapping and the outside labels it uses, then includes the file
;	on its own for checking against the ROM (tools/verify_segment.sh bankC0_A000). The org is in the segment
;	file.
hirom
incsrc "../inc/snes_regs.asm"
incsrc "../ram95s.asm"

; External addresses outside, read from the ROM. Equates only (the full build has the labels).
assdumpin = $C4A4B3
puckshadow = $C4A65D
pucknorm = $C493CA
pucknothing = $C49595
assshoot = $C498A1
assbreakaway = $C49B59
asspassrec = $C49DFB
assgoalietopuck = $C488BB
assgoalie = $C48A71
rtss = $C4883F
assscore = $C47122
assepen = $C47B3F
asspenalty = $C47D2E
assdopen = $C47F4C
assstanley = $C45A47
assdefd = $C4313E
assdefo = $C4332A
asswingd = $C4348E
asswingo = $C43590
assfaceoff = $C4375B
assfaceoffpl = $C4376F
puckfaceoff2 = $C43826
assnearest = $C42B25
asspuckc = $C42DB8
asscentero = $C42F62
asscenterd = $C43099
assbench = $C545C7
asseben = $C5474A
puckfaceoff = $C51CC1

incsrc "../bankC0_A000.asm"

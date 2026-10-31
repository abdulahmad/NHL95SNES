; Segment bankC2_0000: not yet disassembled. It starts with the rest of the team name bars' tile stream.
org $C20000
	incbin "../Extracted/segments/bankC2_0000.bin":0..$A91
TeamNameBarsPalette:				; the colours chunk of the team name bars' map set (as in bankC1_B000)
	incbin "../Extracted/segments/bankC2_0000.bin":$A91..$1000

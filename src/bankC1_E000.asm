; Segment bankC1_E000: not yet disassembled. It starts after the playoff bracket's map set.
org $C1E9B2
TeamNameBarsMap:					; a map set (map, tiles, colours, as in bankC1_B000): the team name bars
	incbin "../Extracted/segments/bankC1_E000.bin":$9B2..$1000

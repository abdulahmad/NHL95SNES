; Segment bankC2_B000: not yet disassembled. It starts with the High Score Productions credit, in the previous
; 4 KB.
org $C2BB69
HighScoreMap:						; a map set (map, tiles, colours, as in bankC1_B000): the developer credit
	incbin "../Extracted/segments/bankC2_B000.bin":$B69..$1000

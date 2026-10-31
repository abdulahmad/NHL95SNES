; Segment bankC2_3000: not yet disassembled. It starts with the title goalie's tiles, in the previous 4 KB.
org $C2334F
TitleGoalieTiles:					; the tiles chunk of the title goalie's map set
	incbin "../Extracted/segments/bankC2_3000.bin":$34F..$1000

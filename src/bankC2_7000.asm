; Segment bankC2_7000: not yet disassembled.
org $C27000
	incbin "../Extracted/segments/bankC2_7000.bin":0..$1CF
TitleGoaliePalette:					; the colours chunk of the title goalie's map set
	incbin "../Extracted/segments/bankC2_7000.bin":$1CF..$1000

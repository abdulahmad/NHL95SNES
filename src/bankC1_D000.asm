; Segment bankC1_D000: not yet disassembled. It starts after the faceoff box's map set, in the previous 4 KB.
org $C1D778
PadButtonsMap:						; a map set (map, tiles, colours, as in bankC1_B000): a pad's four buttons
	incbin "../Extracted/segments/bankC1_D000.bin":$778..$1000

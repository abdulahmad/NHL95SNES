; Segment bankC1_C000: not yet disassembled. It starts after the pause screen's map set, in the previous 4 KB.
org $C1CFE2
FaceOffMap:							; the faceoff box map set (map, tiles, colours, as in bankC1_B000)
	incbin "../Extracted/segments/bankC1_C000.bin":$FE2..$1000

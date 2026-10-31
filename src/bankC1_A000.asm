; Segment bankC1_A000: the team nickname tiles, a set for Decompress. The map sets that follow (map, tiles
; and colours each) start in bankC1_B000.
org $C19B68
TeamNicknameTiles:					; the team nicknames in yellow dot-matrix letters, 10 x 2 tiles
									; each: the teams in 94S order (WSH before WPG), then All Stars E
									; and W; a screen setup unpacks them
	dw $4600						; the unpacked size: 560 tiles
	dw $0000						; format 0
	incbin "../Extracted/segments/bankC1_9000.bin":$B6C..$1000
	incbin "../Extracted/segments/bankC1_A000.bin"
	incbin "../Extracted/segments/bankC1_B000.bin":0..$A31

; Segment bankCD_2000: not yet disassembled (the end of the IceRinkTiles stream, then IceRinkPalette).
org $CD2000
	incbin "../Extracted/segments/bankCD_2000.bin":$0..$559
IceRinkPalette:						; the colours chunk of IceRinkMap (this segment is not yet disassembled)
	incbin "../Extracted/segments/bankCD_2000.bin":$559..$1000

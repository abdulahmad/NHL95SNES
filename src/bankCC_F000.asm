; Segment bankCC_F000: not yet disassembled.
org $CCFE36
IceRinkTiles:						; the tiles chunk of IceRinkMap (this segment is not yet disassembled)
	incbin "../Extracted/segments/bankCC_F000.bin":$E36..$1000

; Segment bankC2_8000: not yet disassembled. It starts with CenterIceTiles, in the previous 4 KB.
org $C2792B
CenterIceTiles:						; the centre ice logos of the 28 teams, a set for Decompress
	incbin "../Extracted/segments/bankC2_7000.bin":$92B..$1000
	incbin "../Extracted/segments/bankC2_8000.bin"

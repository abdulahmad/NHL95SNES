; Segment bankC2_D000: not yet disassembled. It starts with a sound sample, in the previous 4 KB.
org $C2DF3B
Sample09:							; sound sample 9 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC2_D000.bin":$F3B..$1000

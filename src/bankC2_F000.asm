; Segment bankC2_F000: not yet disassembled. It starts with a sound sample, in the previous 4 KB.
org $C2F4AA
Sample11:							; sound sample 11 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC2_F000.bin":$4AA..$1000

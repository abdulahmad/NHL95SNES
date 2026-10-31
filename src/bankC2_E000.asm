; Segment bankC2_E000: not yet disassembled. It starts with a sound sample, in the previous 4 KB.
org $C2E51D
Sample10:							; sound sample 10 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC2_E000.bin":$51D..$1000

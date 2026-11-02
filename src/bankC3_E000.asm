; Segment bankC3_E000: sound samples (a 12-byte header, then 9-byte BRR blocks up to the end flag).
org $C3E82F
Sample29:							; sound sample 29 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC3_E000.bin":$82F..$1000

; Segment bankC2_E000: sound sample 10 (a 12-byte header, then 9-byte BRR blocks up to the end flag).
org $C2E51D
Sample10:							; sound sample 10 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC2_E000.bin":$51D..$1000
	incbin "../Extracted/segments/bankC2_F000.bin":$0..$4AA

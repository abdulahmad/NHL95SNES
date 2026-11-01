; Segment bankC3_9000: sound samples (a 12-byte header, then 9-byte BRR blocks up to the end flag).
org $C38EFE
Sample03:							; sound sample 3 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC3_8000.bin":$EFE..$1000
	incbin "../Extracted/segments/bankC3_9000.bin":$0..$65A
Sample04:							; sound sample 4 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC3_9000.bin":$65A..$1000
	incbin "../Extracted/segments/bankC3_A000.bin":$0..$C29

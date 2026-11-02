; Segment bankC3_B000: sound samples (a 12-byte header, then 9-byte BRR blocks up to the end flag).
org $C3B574
Sample28:							; sound sample 28 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC3_B000.bin":$574..$94C
Sample07:							; sound sample 7 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC3_B000.bin":$94C..$1000
	incbin "../Extracted/segments/bankC3_C000.bin":$0..$70E

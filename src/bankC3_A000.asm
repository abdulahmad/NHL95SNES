; Segment bankC3_A000: sound samples (a 12-byte header, then 9-byte BRR blocks up to the end flag).
org $C3AC29
Sample05:							; sound sample 5 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC3_A000.bin":$C29..$1000
	incbin "../Extracted/segments/bankC3_B000.bin":$0..$574

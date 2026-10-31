; Segment bankC2_D000: sound sample 9 (a 12-byte header, then 9-byte BRR blocks up to the end flag).
org $C2DF3B
Sample09:							; sound sample 9 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC2_D000.bin":$F3B..$1000
	incbin "../Extracted/segments/bankC2_E000.bin":$0..$51D

; Segment bankC3_C000: sound samples (a 12-byte header, then 9-byte BRR blocks up to the end flag).
org $C3C70E
Sample08:							; sound sample 8 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC3_C000.bin":$70E..$DBF
Sample24:							; sound sample 24 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC3_C000.bin":$DBF..$1000
	incbin "../Extracted/segments/bankC3_D000.bin":$0..$52D

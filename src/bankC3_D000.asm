; Segment bankC3_D000: sound samples (a 12-byte header, then 9-byte BRR blocks up to the end flag).
org $C3D52D
Sample25:							; sound sample 25 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC3_D000.bin":$52D..$C1D
Sample30:							; sound sample 30 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC3_D000.bin":$C1D..$1000
	incbin "../Extracted/segments/bankC3_E000.bin":$0..$82F

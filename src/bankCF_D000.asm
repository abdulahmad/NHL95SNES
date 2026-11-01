; Segment bankCF_D000: sound data: Sample06.
org $CFD29C
Sample06:							; sound sample 6 of SampleList: header, then BRR blocks
	incbin "../Extracted/segments/bankCF_D000.bin":$29C..$1000
	incbin "../Extracted/segments/bankCF_E000.bin":$0..$E1D

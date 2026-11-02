; Segment bankCF_9000: sound data: Sample26.
org $CF95A4
Sample26:							; sound sample 26 (and 27) of SampleList: header, then BRR blocks
	incbin "../Extracted/segments/bankCF_9000.bin":$5A4..$1000
	incbin "../Extracted/segments/bankCF_A000.bin":$0..$AAD

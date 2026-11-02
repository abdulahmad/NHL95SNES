; Segment bankCF_A000: sound data: Sample31.
org $CFAAAD
Sample31:							; sound sample 31 of SampleList: header, then BRR blocks
	incbin "../Extracted/segments/bankCF_A000.bin":$AAD..$1000

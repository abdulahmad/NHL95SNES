; Segment bankCF_C000: sound data: sound 34 (DATA8_CFC262), Sample23.
org $CFC262
DATA8_CFC262:						; sound 34 of DATA8_CF04E3: a length word, then its data; CODE_CF0313
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $02FD						; length of the data that follows
	incbin "../Extracted/segments/bankCF_C000.bin":$264..$561
Sample23:							; sound sample 23 of SampleList: header, then BRR blocks
	incbin "../Extracted/segments/bankCF_C000.bin":$561..$1000
	incbin "../Extracted/segments/bankCF_D000.bin":$0..$29C

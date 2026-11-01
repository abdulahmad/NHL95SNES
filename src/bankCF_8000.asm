; Segment bankCF_8000: sound data: sound 39 (DATA8_CF8145).
org $CF8145
DATA8_CF8145:						; sound 39 of DATA8_CF04E3: a length word, then its data; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $145D						; length of the data that follows
	incbin "../Extracted/segments/bankCF_8000.bin":$147..$1000
	incbin "../Extracted/segments/bankCF_9000.bin":$0..$5A4

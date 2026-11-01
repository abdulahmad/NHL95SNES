; Segment bankCF_6000: sound data: sound 38 (DATA8_CF6A1A).
org $CF6A1A
DATA8_CF6A1A:						; sound 38 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $1729						; length of the data that follows
	incbin "../Extracted/segments/bankCF_6000.bin":$A1C..$1000

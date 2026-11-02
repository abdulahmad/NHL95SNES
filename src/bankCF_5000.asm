; Segment bankCF_5000: sound data: sound 35 (DATA8_CF5717), sound 37 (DATA8_CF590B).
org $CF5717
DATA8_CF5717:						; sound 35 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $01F2						; length of the data that follows
	incbin "../Extracted/segments/bankCF_5000.bin":$719..$90B
DATA8_CF590B:						; sound 37 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $110D						; length of the data that follows
	incbin "../Extracted/segments/bankCF_5000.bin":$90D..$1000
	incbin "../Extracted/segments/bankCF_6000.bin":$0..$A1A

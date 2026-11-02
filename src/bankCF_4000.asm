; Segment bankCF_4000: sound data: sound 30 (DATA8_CF410C), sound 31 (DATA8_CF41BE), ..., sound 36
; (DATA8_CF46CE).
org $CF410C
DATA8_CF410C:						; sound 30 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $00B0						; length of the data that follows
	incbin "../Extracted/segments/bankCF_4000.bin":$10E..$1BE
DATA8_CF41BE:						; sound 31 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $0191						; length of the data that follows
	incbin "../Extracted/segments/bankCF_4000.bin":$1C0..$351
DATA8_CF4351:						; sound 32 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $00AF						; length of the data that follows
	incbin "../Extracted/segments/bankCF_4000.bin":$353..$402
DATA8_CF4402:						; sound 33 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $02CA						; length of the data that follows
	incbin "../Extracted/segments/bankCF_4000.bin":$404..$6CE
DATA8_CF46CE:						; sound 36 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $1047						; length of the data that follows
	incbin "../Extracted/segments/bankCF_4000.bin":$6D0..$1000
	incbin "../Extracted/segments/bankCF_5000.bin":$0..$717

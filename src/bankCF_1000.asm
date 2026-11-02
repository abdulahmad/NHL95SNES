; Segment bankCF_1000: sound data: sound 5 (DATA8_CF1099), sound 6 (DATA8_CF1284), ..., sound 13
; (DATA8_CF1EFB).
org $CF1099
DATA8_CF1099:						; sound 5 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $01E9						; length of the data that follows
	incbin "../Extracted/segments/bankCF_1000.bin":$9B..$284
DATA8_CF1284:						; sound 6 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $01CE						; length of the data that follows
	incbin "../Extracted/segments/bankCF_1000.bin":$286..$454
DATA8_CF1454:						; sound 7 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $012C						; length of the data that follows
	incbin "../Extracted/segments/bankCF_1000.bin":$456..$582
DATA8_CF1582:						; sound 8 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $0194						; length of the data that follows
	incbin "../Extracted/segments/bankCF_1000.bin":$584..$718
DATA8_CF1718:						; sound 9 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $02A6						; length of the data that follows
	incbin "../Extracted/segments/bankCF_1000.bin":$71A..$9C0
DATA8_CF19C0:						; sound 10 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $01FD						; length of the data that follows
	incbin "../Extracted/segments/bankCF_1000.bin":$9C2..$BBF
DATA8_CF1BBF:						; sound 11 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $0177						; length of the data that follows
	incbin "../Extracted/segments/bankCF_1000.bin":$BC1..$D38
DATA8_CF1D38:						; sound 12 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $01C1						; length of the data that follows
	incbin "../Extracted/segments/bankCF_1000.bin":$D3A..$EFB
DATA8_CF1EFB:						; sound 13 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $0226						; length of the data that follows
	incbin "../Extracted/segments/bankCF_1000.bin":$EFD..$1000
	incbin "../Extracted/segments/bankCF_2000.bin":$0..$123

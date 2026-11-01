; Segment bankCF_3000: sound data: sound 23 (DATA8_CF319B), sound 24 (DATA8_CF33DD), ..., sound 29
; (DATA8_CF3F79).
org $CF319B
DATA8_CF319B:						; sound 23 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $0240						; length of the data that follows
	incbin "../Extracted/segments/bankCF_3000.bin":$19D..$3DD
DATA8_CF33DD:						; sound 24 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $0240						; length of the data that follows
	incbin "../Extracted/segments/bankCF_3000.bin":$3DF..$61F
DATA8_CF361F:						; sound 25 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $01CD						; length of the data that follows
	incbin "../Extracted/segments/bankCF_3000.bin":$621..$7EE
DATA8_CF37EE:						; sound 26 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $02C7						; length of the data that follows
	incbin "../Extracted/segments/bankCF_3000.bin":$7F0..$AB7
DATA8_CF3AB7:						; sound 27 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $02E4						; length of the data that follows
	incbin "../Extracted/segments/bankCF_3000.bin":$AB9..$D9D
DATA8_CF3D9D:						; sound 28 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $01DA						; length of the data that follows
	incbin "../Extracted/segments/bankCF_3000.bin":$D9F..$F79
DATA8_CF3F79:						; sound 29 of SoundSequenceTable: a length word, then its data;
									; LoadSequence
									; sends the samples it lists from +3 (a count, then the sample numbers)
	dw $0191						; length of the data that follows
	incbin "../Extracted/segments/bankCF_3000.bin":$F7B..$1000
	incbin "../Extracted/segments/bankCF_4000.bin":$0..$10C

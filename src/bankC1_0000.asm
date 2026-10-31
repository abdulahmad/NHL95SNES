; Segment bankC1_0000: data the records of DATA8_C08000 point into (the code that reads them is not
; traced yet): 39 palettes, a run of words, then the first blocks the records point at.
org $C10000
DATA8_C10000:						; not traced: 39 palettes of 16 colours (colour 0 black)
	incbin "../Extracted/segments/bankC1_0000.bin":0..$4E0
DATA8_C104E0:						; not traced: a run of the word $04E2; records point at words in it
	incbin "../Extracted/segments/bankC1_0000.bin":$4E0..$533
DATA8_C10533:						; not traced: a block a DATA8_C08000 record points at
	incbin "../Extracted/segments/bankC1_0000.bin":$533..$94E
DATA8_C1094E:						; not traced: the next block a record points at
	incbin "../Extracted/segments/bankC1_0000.bin":$94E..$CFD
DATA8_C10CFD:						; not traced: the next block a record points at
	incbin "../Extracted/segments/bankC1_0000.bin":$CFD..$1000
	incbin "../Extracted/segments/bankC1_1000.bin":0..$B8

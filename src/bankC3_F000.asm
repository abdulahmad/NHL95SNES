; Segment bankC3_F000: sound samples (a 12-byte header, then 9-byte BRR blocks up to the end flag).
org $C3F000
	incbin "../Extracted/segments/bankC3_F000.bin":$0..$E10	; the rest of Sample29
	padbyte $00						; unused to the end of the bank
	pad $C40000

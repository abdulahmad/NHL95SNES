; Segment bankC2_F000: sound samples 11 and 12 (a 12-byte header, then 9-byte BRR blocks up to the end flag),
; then zeros to the end of the bank.
org $C2F4AA
Sample11:							; sound sample 11 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC2_F000.bin":$4AA..$C60
Sample12:							; sound sample 12 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC2_F000.bin":$C60..$F4E
	padbyte $00						; unused to the end of the bank
	pad $C30000

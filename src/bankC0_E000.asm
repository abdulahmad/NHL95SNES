; Segment bankC0_E000: sound samples, back to back as the sample list in bank $CF points at them: each a
; 12 byte header, then BRR blocks of 9 bytes up to the one with the end flag.
org $C0E5C5
Sample16:							; sound sample 16 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_E000.bin":$5C5..$AA2
Sample17:							; sound sample 17 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_E000.bin":$AA2..$C5E
Sample14:							; sound sample 14 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_E000.bin":$C5E..$1000
	incbin "../Extracted/segments/bankC0_F000.bin":$0..$288

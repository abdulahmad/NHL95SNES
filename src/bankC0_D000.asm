; Segment bankC0_D000: sound samples, back to back as the sample list in bank $CF points at them: each a
; 12 byte header, then BRR blocks of 9 bytes up to the one with the end flag.
org $C0D359
Sample13:							; sound sample 13 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_D000.bin":$359..$42B
Sample32:							; sound sample 32 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_D000.bin":$42B..$E06
Sample18:							; sound sample 18 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_D000.bin":$E06..$1000
	incbin "../Extracted/segments/bankC0_E000.bin":$0..$5C5

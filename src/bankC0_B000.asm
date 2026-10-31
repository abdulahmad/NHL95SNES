; Segment bankC0_B000: sound samples, back to back as the sample list in bank $CF points at them: each a
; 12 byte header, then BRR blocks of 9 bytes up to the one with the end flag.
org $C0B5BF
Sample22:							; sound sample 22 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_B000.bin":$5BF..$E7A
Sample01:							; sound sample 1 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_B000.bin":$E7A..$1000
	incbin "../Extracted/segments/bankC0_C000.bin":$0..$1CB

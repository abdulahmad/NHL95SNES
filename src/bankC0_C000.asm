; Segment bankC0_C000: sound samples, back to back as the sample list in bank $CF points at them: each a
; 12 byte header, then BRR blocks of 9 bytes up to the one with the end flag.
org $C0C1CB
Sample00:							; sound sample 0 of the sample list: header, then BRR blocks
	incbin "../Extracted/segments/bankC0_C000.bin":$1CB..$1000
	incbin "../Extracted/segments/bankC0_D000.bin":$0..$359

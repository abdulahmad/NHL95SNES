; Segment bankC0_1000: not yet disassembled. It starts where the sound driver's upload blocks start, in the
; last bytes of the previous 4 KB.
org $C00F49
	incbin "../Extracted/segments/bankC0_0000.bin":$F49..$1000
	incbin "../Extracted/segments/bankC0_1000.bin"

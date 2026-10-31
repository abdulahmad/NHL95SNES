; Segment bankC5_B000: not yet disassembled. It starts at a routine in the previous 4 KB.
org $C5AFB6
	incbin "../Extracted/segments/bankC5_A000.bin":$FB6..$1000
	incbin "../Extracted/segments/bankC5_B000.bin"

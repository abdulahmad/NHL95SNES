; Segment bankC5_E000: not yet disassembled. It starts at a routine in the previous 4 KB.
org $C5DF5F
	incbin "../Extracted/segments/bankC5_D000.bin":$F5F..$1000
	incbin "../Extracted/segments/bankC5_E000.bin"

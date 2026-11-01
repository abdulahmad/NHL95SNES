; Segment bankCF_F000: not yet disassembled. It starts where bankCF_E000 ends.
org $CFF0CB
	incbin "../Extracted/segments/bankCF_F000.bin":$CB..$1000

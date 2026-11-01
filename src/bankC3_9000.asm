; Segment bankC3_9000: not yet disassembled. It starts where bankC3_8000 ends, in the previous 4 KB.
org $C38EFE
	incbin "../Extracted/segments/bankC3_8000.bin":$EFE..$1000
	incbin "../Extracted/segments/bankC3_9000.bin"

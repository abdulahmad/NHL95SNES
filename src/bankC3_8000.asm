; Segment bankC3_8000: not yet disassembled. It starts where bankC3_7000 ends, in the previous 4 KB.
org $C37FE2
	incbin "../Extracted/segments/bankC3_7000.bin":$FE2..$1000
	incbin "../Extracted/segments/bankC3_8000.bin"

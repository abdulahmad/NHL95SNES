; Segment bankC5_7000: not yet disassembled. It starts at a routine in the previous 4 KB.
org $C56F5C
	incbin "../Extracted/segments/bankC5_6000.bin":$F5C..$1000
	incbin "../Extracted/segments/bankC5_7000.bin"
	incbin "../Extracted/segments/bankC5_8000.bin":$0..$C

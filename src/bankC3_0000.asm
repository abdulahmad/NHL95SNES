; Segment bankC3_0000: not yet disassembled. It ends where bankC3_1000 starts.
org $C30000
	incbin "../Extracted/segments/bankC3_0000.bin"
	incbin "../Extracted/segments/bankC3_1000.bin":$0..$7

; Segment bankC3_7000: not yet disassembled. It starts where bankC3_6000 ends, in the previous 4 KB.
org $C36FF2
	incbin "../Extracted/segments/bankC3_6000.bin":$FF2..$1000
	incbin "../Extracted/segments/bankC3_7000.bin"

; Segment bankC4_5000: not yet disassembled. It starts where bankC4_4000 ends, in the previous 4 KB.
org $C44F20
	incbin "../Extracted/segments/bankC4_4000.bin":$F20..$1000
	incbin "../Extracted/segments/bankC4_5000.bin"

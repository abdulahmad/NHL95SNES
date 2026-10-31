; Segment bankC4_4000: not yet disassembled. It starts where bankC4_3000 ends, in the previous 4 KB.
org $C43FC8
	incbin "../Extracted/segments/bankC4_3000.bin":$FC8..$1000
	incbin "../Extracted/segments/bankC4_4000.bin"

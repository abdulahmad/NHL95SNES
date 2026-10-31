; Segment bankC4_6000: not yet disassembled. It starts where bankC4_5000 ends, in the previous 4 KB.
org $C45FAC
	incbin "../Extracted/segments/bankC4_5000.bin":$FAC..$1000
	incbin "../Extracted/segments/bankC4_6000.bin"

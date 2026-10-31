; Segment bankC4_A000: not yet disassembled. It starts where bankC4_9000 ends, in the previous 4 KB.
org $C49FBD
	incbin "../Extracted/segments/bankC4_9000.bin":$FBD..$1000
	incbin "../Extracted/segments/bankC4_A000.bin"

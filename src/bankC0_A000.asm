; Segment bankC0_A000: not yet disassembled. It starts with the tables after the game code, in the previous
; 4 KB.
org $C09A24
	incbin "../Extracted/segments/bankC0_9000.bin":$A24..$1000
	incbin "../Extracted/segments/bankC0_A000.bin"

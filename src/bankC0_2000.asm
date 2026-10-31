; Segment bankC0_2000: not yet disassembled. It starts after the sound driver, in the previous 4 KB.
org $C01A39
	incbin "../Extracted/segments/bankC0_1000.bin":$A39..$1000
	incbin "../Extracted/segments/bankC0_2000.bin"

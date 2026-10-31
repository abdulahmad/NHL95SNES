; Segment bankC5_9000: not yet disassembled. It starts at a routine in the previous 4 KB.
org $C58FD8
	incbin "../Extracted/segments/bankC5_8000.bin":$FD8..$1000
	incbin "../Extracted/segments/bankC5_9000.bin"

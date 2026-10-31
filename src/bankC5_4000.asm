; Segment bankC5_4000: not yet disassembled. It starts at a routine in the previous 4 KB.
org $C53FE5
	incbin "../Extracted/segments/bankC5_3000.bin":$FE5..$1000
	incbin "../Extracted/segments/bankC5_4000.bin"

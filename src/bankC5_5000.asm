; Segment bankC5_5000: not yet disassembled. It starts at a routine in the previous 4 KB.
org $C54F05
	incbin "../Extracted/segments/bankC5_4000.bin":$F05..$1000
	incbin "../Extracted/segments/bankC5_5000.bin"

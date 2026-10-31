; Segment bankC5_C000: not yet disassembled. It starts at a routine in the previous 4 KB.
org $C5BFE0
	incbin "../Extracted/segments/bankC5_B000.bin":$FE0..$1000
	incbin "../Extracted/segments/bankC5_C000.bin"

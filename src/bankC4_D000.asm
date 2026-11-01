; Segment bankC4_D000: not yet disassembled. It starts where bankC4_C000 ends, in the previous 4 KB.
org $C4CFF5
	incbin "../Extracted/segments/bankC4_C000.bin":$FF5..$1000
	incbin "../Extracted/segments/bankC4_D000.bin"

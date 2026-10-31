; Segment bankC5_7000: not yet disassembled. It runs to the end of a routine just past $C58000.
org $C57000
	incbin "../Extracted/segments/bankC5_7000.bin"
	incbin "../Extracted/segments/bankC5_8000.bin":0..$C

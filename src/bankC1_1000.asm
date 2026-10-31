; Segment bankC1_1000: not yet disassembled. It starts with a block the records of DATA8_C08000 point at.
org $C110B8
	incbin "../Extracted/segments/bankC1_1000.bin":$B8..$1000

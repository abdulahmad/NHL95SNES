; Segment bankC2_C000: not yet disassembled. It starts with the ref windows' map set, in the previous 4 KB.
org $C2CC6E
RefsMap:							; a map set (map, tiles, colours, as in bankC1_B000): the ref windows
	incbin "../Extracted/segments/bankC2_C000.bin":$C6E..$1000

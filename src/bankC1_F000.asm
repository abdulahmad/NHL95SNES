; Segment bankC1_F000: not yet disassembled. It starts with the team name bars' tiles, in the previous 4 KB.
org $C1EE6B
TeamNameBarsTiles:					; the tiles chunk of the team name bars' map set
	incbin "../Extracted/segments/bankC1_E000.bin":$E6B..$1000
	incbin "../Extracted/segments/bankC1_F000.bin"

; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CC05E5
DATA8_CC05E5:						; raw frame tiles for transfer index $37B; pose not traced
	incbin "../Extracted/segments/bankCC_0000.bin":$5E5..$845
DATA8_CC0845:						; raw frame tiles for transfer index $37C; pose not traced
	incbin "../Extracted/segments/bankCC_0000.bin":$845..$A45
DATA8_CC0A45:						; raw frame tiles for transfer index $37D; pose not traced
	incbin "../Extracted/segments/bankCC_0000.bin":$A45..$CA5
DATA8_CC0CA5:						; raw frame tiles for transfer index $37E; pose not traced
	incbin "../Extracted/segments/bankCC_0000.bin":$CA5..$F25
DATA8_CC0F25:						; raw frame tiles for transfer index $37F; pose not traced
	incbin "../Extracted/segments/bankCC_0000.bin":$F25..$1000
	incbin "../Extracted/segments/bankCC_1000.bin":$0..$1A5

; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CCB125
DATA8_CCB125:						; raw frame tiles for transfer index $3C9; pose not traced
	incbin "../Extracted/segments/bankCC_B000.bin":$125..$325
DATA8_CCB325:						; raw frame tiles for transfer index $3CA; pose not traced
	incbin "../Extracted/segments/bankCC_B000.bin":$325..$525
DATA8_CCB525:						; raw frame tiles for transfer index $3CB; pose not traced
	incbin "../Extracted/segments/bankCC_B000.bin":$525..$725
DATA8_CCB725:						; raw frame tiles for transfer index $3EC; pose not traced
	incbin "../Extracted/segments/bankCC_B000.bin":$725..$925
DATA8_CCB925:						; raw frame tiles for transfer index $3ED; pose not traced
	incbin "../Extracted/segments/bankCC_B000.bin":$925..$B85
DATA8_CCBB85:						; raw frame tiles for transfer index $3EE; pose not traced
	incbin "../Extracted/segments/bankCC_B000.bin":$B85..$D85
DATA8_CCBD85:						; raw frame tiles for transfer index $3EF; pose not traced
	incbin "../Extracted/segments/bankCC_B000.bin":$D85..$FE5
DATA8_CCBFE5:						; raw frame tiles for transfer index $3F0; pose not traced
	incbin "../Extracted/segments/bankCC_B000.bin":$FE5..$1000
	incbin "../Extracted/segments/bankCC_C000.bin":$0..$1E5

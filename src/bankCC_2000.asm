; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CC2225
DATA8_CC2225:						; raw frame tiles for transfer index $387; pose not traced
	incbin "../Extracted/segments/bankCC_2000.bin":$225..$4A5
DATA8_CC24A5:						; raw frame tiles for transfer index $388; pose not traced
	incbin "../Extracted/segments/bankCC_2000.bin":$4A5..$6A5
DATA8_CC26A5:						; raw frame tiles for transfer index $389; pose not traced
	incbin "../Extracted/segments/bankCC_2000.bin":$6A5..$905
DATA8_CC2905:						; raw frame tiles for transfer index $38A; pose not traced
	incbin "../Extracted/segments/bankCC_2000.bin":$905..$B05
DATA8_CC2B05:						; raw frame tiles for transfer index $38B; pose not traced
	incbin "../Extracted/segments/bankCC_2000.bin":$B05..$D05
DATA8_CC2D05:						; raw frame tiles for transfer index $38C; pose not traced
	incbin "../Extracted/segments/bankCC_2000.bin":$D05..$F05
DATA8_CC2F05:						; raw frame tiles for transfer index $38D; pose not traced
	incbin "../Extracted/segments/bankCC_2000.bin":$F05..$1000
	incbin "../Extracted/segments/bankCC_3000.bin":$0..$85

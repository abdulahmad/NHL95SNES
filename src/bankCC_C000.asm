; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CCC1E5
DATA8_CCC1E5:						; raw frame tiles for transfer index $3F1; pose not traced
	incbin "../Extracted/segments/bankCC_C000.bin":$1E5..$445
DATA8_CCC445:						; raw frame tiles for transfer index $3F2; pose not traced
	incbin "../Extracted/segments/bankCC_C000.bin":$445..$6A5
DATA8_CCC6A5:						; raw frame tiles for transfer index $3F3; pose not traced
	incbin "../Extracted/segments/bankCC_C000.bin":$6A5..$905
DATA8_CCC905:						; raw frame tiles for transfer index $3F4; pose not traced
	incbin "../Extracted/segments/bankCC_C000.bin":$905..$B65
DATA8_CCCB65:						; raw frame tiles for transfer index $3F5; pose not traced
	incbin "../Extracted/segments/bankCC_C000.bin":$B65..$DE5
DATA8_CCCDE5:						; raw frame tiles for transfer index $3F6; pose not traced
	incbin "../Extracted/segments/bankCC_C000.bin":$DE5..$FE5
DATA8_CCCFE5:						; raw frame tiles for transfer index $3F7; pose not traced
	incbin "../Extracted/segments/bankCC_C000.bin":$FE5..$1000
	incbin "../Extracted/segments/bankCC_D000.bin":$0..$265

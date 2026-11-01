; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CC3085
DATA8_CC3085:						; raw frame tiles for transfer index $38E; pose not traced
	incbin "../Extracted/segments/bankCC_3000.bin":$85..$285
DATA8_CC3285:						; raw frame tiles for transfer index $38F; pose not traced
	incbin "../Extracted/segments/bankCC_3000.bin":$285..$485
DATA8_CC3485:						; raw frame tiles for transfer index $390; pose not traced
	incbin "../Extracted/segments/bankCC_3000.bin":$485..$685
DATA8_CC3685:						; raw frame tiles for transfer index $391; pose not traced
	incbin "../Extracted/segments/bankCC_3000.bin":$685..$8E5
DATA8_CC38E5:						; raw frame tiles for transfer index $392; pose not traced
	incbin "../Extracted/segments/bankCC_3000.bin":$8E5..$B45
DATA8_CC3B45:						; raw frame tiles for transfer index $393; pose not traced
	incbin "../Extracted/segments/bankCC_3000.bin":$B45..$DA5
DATA8_CC3DA5:						; raw frame tiles for transfer index $394; pose not traced
	incbin "../Extracted/segments/bankCC_3000.bin":$DA5..$FA5
DATA8_CC3FA5:						; raw frame tiles for transfer index $395; pose not traced
	incbin "../Extracted/segments/bankCC_3000.bin":$FA5..$1000
	incbin "../Extracted/segments/bankCC_4000.bin":$0..$205

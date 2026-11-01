; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CC51E5
DATA8_CC51E5:						; raw frame tiles for transfer index $39D; pose not traced
	incbin "../Extracted/segments/bankCC_5000.bin":$1E5..$445
DATA8_CC5445:						; raw frame tiles for transfer index $39E; pose not traced
	incbin "../Extracted/segments/bankCC_5000.bin":$445..$6C5
DATA8_CC56C5:						; raw frame tiles for transfer index $39F; pose not traced
	incbin "../Extracted/segments/bankCC_5000.bin":$6C5..$8C5
DATA8_CC58C5:						; raw frame tiles for transfer index $3A0; pose not traced
	incbin "../Extracted/segments/bankCC_5000.bin":$8C5..$AC5
DATA8_CC5AC5:						; raw frame tiles for transfer index $3A1; pose not traced
	incbin "../Extracted/segments/bankCC_5000.bin":$AC5..$CC5
DATA8_CC5CC5:						; raw frame tiles for transfer index $3A2; pose not traced
	incbin "../Extracted/segments/bankCC_5000.bin":$CC5..$F25
DATA8_CC5F25:						; raw frame tiles for transfer index $3A3; pose not traced
	incbin "../Extracted/segments/bankCC_5000.bin":$F25..$1000
	incbin "../Extracted/segments/bankCC_6000.bin":$0..$1A5

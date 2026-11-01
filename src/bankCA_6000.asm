; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CA6139
DATA8_CA6139:						; raw frame tiles for transfer index $267; pose not traced
	incbin "../Extracted/segments/bankCA_6000.bin":$139..$339
DATA8_CA6339:						; raw frame tiles for transfer index $268; pose not traced
	incbin "../Extracted/segments/bankCA_6000.bin":$339..$539
DATA8_CA6539:						; raw frame tiles for transfer index $269; pose not traced
	incbin "../Extracted/segments/bankCA_6000.bin":$539..$739
DATA8_CA6739:						; raw frame tiles for transfer index $26A; pose not traced
	incbin "../Extracted/segments/bankCA_6000.bin":$739..$939
DATA8_CA6939:						; raw frame tiles for transfer index $26B; pose not traced
	incbin "../Extracted/segments/bankCA_6000.bin":$939..$B39
DATA8_CA6B39:						; raw frame tiles for transfer index $26C; pose not traced
	incbin "../Extracted/segments/bankCA_6000.bin":$B39..$D39
DATA8_CA6D39:						; raw frame tiles for transfer index $26D; pose not traced
	incbin "../Extracted/segments/bankCA_6000.bin":$D39..$F39
DATA8_CA6F39:						; raw frame tiles for transfer index $26E; pose not traced
	incbin "../Extracted/segments/bankCA_6000.bin":$F39..$1000
	incbin "../Extracted/segments/bankCA_7000.bin":$0..$199

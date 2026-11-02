; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CA3219
DATA8_CA3219:						; raw frame tiles for transfer index $252; pose not traced
	incbin "../Extracted/segments/bankCA_3000.bin":$219..$439
DATA8_CA3439:						; raw frame tiles for transfer index $253; pose not traced
	incbin "../Extracted/segments/bankCA_3000.bin":$439..$6B9
DATA8_CA36B9:						; raw frame tiles for transfer index $254; pose not traced
	incbin "../Extracted/segments/bankCA_3000.bin":$6B9..$939
DATA8_CA3939:						; raw frame tiles for transfer index $255; pose not traced
	incbin "../Extracted/segments/bankCA_3000.bin":$939..$B99
DATA8_CA3B99:						; raw frame tiles for transfer index $256; pose not traced
	incbin "../Extracted/segments/bankCA_3000.bin":$B99..$DF9
DATA8_CA3DF9:						; raw frame tiles for transfer index $257; pose not traced
	incbin "../Extracted/segments/bankCA_3000.bin":$DF9..$1000
	incbin "../Extracted/segments/bankCA_4000.bin":$0..$79

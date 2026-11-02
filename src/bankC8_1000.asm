; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C811B9
DATA8_C811B9:						; raw frame tiles for transfer index $106; pose not traced
	incbin "../Extracted/segments/bankC8_1000.bin":$1B9..$439
DATA8_C81439:						; raw frame tiles for transfer index $107; pose not traced
	incbin "../Extracted/segments/bankC8_1000.bin":$439..$6B9
DATA8_C816B9:						; raw frame tiles for transfer index $108; pose not traced
	incbin "../Extracted/segments/bankC8_1000.bin":$6B9..$939
DATA8_C81939:						; raw frame tiles for transfer index $109; pose not traced
	incbin "../Extracted/segments/bankC8_1000.bin":$939..$BB9
DATA8_C81BB9:						; raw frame tiles for transfer index $10A; pose not traced
	incbin "../Extracted/segments/bankC8_1000.bin":$BB9..$DB9
DATA8_C81DB9:						; raw frame tiles for transfer index $10B; pose not traced
	incbin "../Extracted/segments/bankC8_1000.bin":$DB9..$FB9
DATA8_C81FB9:						; raw frame tiles for transfer index $10C; pose not traced
	incbin "../Extracted/segments/bankC8_1000.bin":$FB9..$1000
	incbin "../Extracted/segments/bankC8_2000.bin":$0..$239

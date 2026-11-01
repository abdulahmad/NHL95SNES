; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C6D0E8
DATA8_C6D0E8:						; raw frame tiles for transfer index $084; pose not traced
	incbin "../Extracted/segments/bankC6_D000.bin":$E8..$368
DATA8_C6D368:						; raw frame tiles for transfer index $085; pose not traced
	incbin "../Extracted/segments/bankC6_D000.bin":$368..$568
DATA8_C6D568:						; raw frame tiles for transfer index $086; pose not traced
	incbin "../Extracted/segments/bankC6_D000.bin":$568..$768
DATA8_C6D768:						; raw frame tiles for transfer index $087; pose not traced
	incbin "../Extracted/segments/bankC6_D000.bin":$768..$968
DATA8_C6D968:						; raw frame tiles for transfer index $088; pose not traced
	incbin "../Extracted/segments/bankC6_D000.bin":$968..$B68
DATA8_C6DB68:						; raw frame tiles for transfer index $089; pose not traced
	incbin "../Extracted/segments/bankC6_D000.bin":$B68..$D68
DATA8_C6DD68:						; raw frame tiles for transfer index $08A; pose not traced
	incbin "../Extracted/segments/bankC6_D000.bin":$D68..$F68
DATA8_C6DF68:						; raw frame tiles for transfer index $08B; pose not traced
	incbin "../Extracted/segments/bankC6_D000.bin":$F68..$1000
	incbin "../Extracted/segments/bankC6_E000.bin":$0..$1E8

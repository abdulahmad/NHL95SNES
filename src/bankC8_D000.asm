; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C8D199
DATA8_C8D199:						; raw frame tiles for transfer index $1C2; pose not traced
	incbin "../Extracted/segments/bankC8_D000.bin":$199..$419
DATA8_C8D419:						; raw frame tiles for transfer index $1C3; pose not traced
	incbin "../Extracted/segments/bankC8_D000.bin":$419..$699
DATA8_C8D699:						; raw frame tiles for transfer index $1C4; pose not traced
	incbin "../Extracted/segments/bankC8_D000.bin":$699..$8B9
DATA8_C8D8B9:						; raw frame tiles for transfer index $1C5; pose not traced
	incbin "../Extracted/segments/bankC8_D000.bin":$8B9..$AD9
DATA8_C8DAD9:						; raw frame tiles for transfer index $1C6; pose not traced
	incbin "../Extracted/segments/bankC8_D000.bin":$AD9..$CD9
DATA8_C8DCD9:						; raw frame tiles for transfer index $1C7; pose not traced
	incbin "../Extracted/segments/bankC8_D000.bin":$CD9..$ED9
DATA8_C8DED9:						; raw frame tiles for transfer index $1C8; pose not traced
	incbin "../Extracted/segments/bankC8_D000.bin":$ED9..$1000
	incbin "../Extracted/segments/bankC8_E000.bin":$0..$139

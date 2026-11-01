; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C85179
DATA8_C85179:						; raw frame tiles for transfer index $135; pose not traced
	incbin "../Extracted/segments/bankC8_5000.bin":$179..$3B9
DATA8_C853B9:						; raw frame tiles for transfer index $136; pose not traced
	incbin "../Extracted/segments/bankC8_5000.bin":$3B9..$5F9
DATA8_C855F9:						; raw frame tiles for transfer index $13B; pose not traced
	incbin "../Extracted/segments/bankC8_5000.bin":$5F9..$839
DATA8_C85839:						; raw frame tiles for transfer index $13C; pose not traced
	incbin "../Extracted/segments/bankC8_5000.bin":$839..$A79
DATA8_C85A79:						; raw frame tiles for transfer index $13D; pose not traced
	incbin "../Extracted/segments/bankC8_5000.bin":$A79..$CD9
DATA8_C85CD9:						; raw frame tiles for transfer index $13E; pose not traced
	incbin "../Extracted/segments/bankC8_5000.bin":$CD9..$F39
DATA8_C85F39:						; raw frame tiles for transfer index $143; pose not traced
	incbin "../Extracted/segments/bankC8_5000.bin":$F39..$1000
	incbin "../Extracted/segments/bankC8_6000.bin":$0..$1B9

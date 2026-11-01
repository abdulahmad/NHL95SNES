; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C88019
DATA8_C88019:						; raw frame tiles for transfer index $15C; pose not traced
	incbin "../Extracted/segments/bankC8_8000.bin":$19..$299
DATA8_C88299:						; raw frame tiles for transfer index $15D; pose not traced
	incbin "../Extracted/segments/bankC8_8000.bin":$299..$4F9
DATA8_C884F9:						; raw frame tiles for transfer index $160; pose not traced
	incbin "../Extracted/segments/bankC8_8000.bin":$4F9..$739
DATA8_C88739:						; raw frame tiles for transfer index $161; pose not traced
	incbin "../Extracted/segments/bankC8_8000.bin":$739..$979
DATA8_C88979:						; raw frame tiles for transfer index $162; pose not traced
	incbin "../Extracted/segments/bankC8_8000.bin":$979..$BB9
DATA8_C88BB9:						; raw frame tiles for transfer index $164; pose not traced
	incbin "../Extracted/segments/bankC8_8000.bin":$BB9..$E19
DATA8_C88E19:						; raw frame tiles for transfer index $165; pose not traced
	incbin "../Extracted/segments/bankC8_8000.bin":$E19..$1000
	incbin "../Extracted/segments/bankC8_9000.bin":$0..$79

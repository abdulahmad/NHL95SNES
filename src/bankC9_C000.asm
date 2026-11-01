; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C9C18B
DATA8_C9C18B:						; raw frame tiles for transfer index $227; pose not traced
	incbin "../Extracted/segments/bankC9_C000.bin":$18B..$3EB
DATA8_C9C3EB:						; raw frame tiles for transfer index $228; pose not traced
	incbin "../Extracted/segments/bankC9_C000.bin":$3EB..$66B
DATA8_C9C66B:						; raw frame tiles for transfer index $229; pose not traced
	incbin "../Extracted/segments/bankC9_C000.bin":$66B..$8EB
DATA8_C9C8EB:						; raw frame tiles for transfer index $22A; pose not traced
	incbin "../Extracted/segments/bankC9_C000.bin":$8EB..$AEB
DATA8_C9CAEB:						; raw frame tiles for transfer index $22B; pose not traced
	incbin "../Extracted/segments/bankC9_C000.bin":$AEB..$D6B
DATA8_C9CD6B:						; raw frame tiles for transfer index $22C; pose not traced
	incbin "../Extracted/segments/bankC9_C000.bin":$D6B..$F8B
DATA8_C9CF8B:						; raw frame tiles for transfer index $22D; pose not traced
	incbin "../Extracted/segments/bankC9_C000.bin":$F8B..$1000
	incbin "../Extracted/segments/bankC9_D000.bin":$0..$20B

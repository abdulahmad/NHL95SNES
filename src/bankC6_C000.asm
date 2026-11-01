; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C6C0A8
DATA8_C6C0A8:						; raw frame tiles for transfer index $07D; pose not traced
	incbin "../Extracted/segments/bankC6_C000.bin":$A8..$2A8
DATA8_C6C2A8:						; raw frame tiles for transfer index $07E; pose not traced
	incbin "../Extracted/segments/bankC6_C000.bin":$2A8..$508
DATA8_C6C508:						; raw frame tiles for transfer index $07F; pose not traced
	incbin "../Extracted/segments/bankC6_C000.bin":$508..$708
DATA8_C6C708:						; raw frame tiles for transfer index $080; pose not traced
	incbin "../Extracted/segments/bankC6_C000.bin":$708..$968
DATA8_C6C968:						; raw frame tiles for transfer index $081; pose not traced
	incbin "../Extracted/segments/bankC6_C000.bin":$968..$BE8
DATA8_C6CBE8:						; raw frame tiles for transfer index $082; pose not traced
	incbin "../Extracted/segments/bankC6_C000.bin":$BE8..$E68
DATA8_C6CE68:						; raw frame tiles for transfer index $083; pose not traced
	incbin "../Extracted/segments/bankC6_C000.bin":$E68..$1000
	incbin "../Extracted/segments/bankC6_D000.bin":$0..$E8

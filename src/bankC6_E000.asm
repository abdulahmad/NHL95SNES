; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C6E1E8
DATA8_C6E1E8:						; raw frame tiles for transfer index $08C; pose not traced
	incbin "../Extracted/segments/bankC6_E000.bin":$1E8..$468
DATA8_C6E468:						; raw frame tiles for transfer index $08D; pose not traced
	incbin "../Extracted/segments/bankC6_E000.bin":$468..$6E8
DATA8_C6E6E8:						; raw frame tiles for transfer index $08E; pose not traced
	incbin "../Extracted/segments/bankC6_E000.bin":$6E8..$968
DATA8_C6E968:						; raw frame tiles for transfer index $08F; pose not traced
	incbin "../Extracted/segments/bankC6_E000.bin":$968..$BE8
DATA8_C6EBE8:						; raw frame tiles for transfer index $090; pose not traced
	incbin "../Extracted/segments/bankC6_E000.bin":$BE8..$E68
DATA8_C6EE68:						; raw frame tiles for transfer index $091; pose not traced
	incbin "../Extracted/segments/bankC6_E000.bin":$E68..$1000
	incbin "../Extracted/segments/bankC6_F000.bin":$0..$68

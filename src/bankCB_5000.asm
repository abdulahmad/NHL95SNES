; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CB5015
DATA8_CB5015:						; raw frame tiles for transfer index $32B; pose not traced
	incbin "../Extracted/segments/bankCB_5000.bin":$15..$295
DATA8_CB5295:						; raw frame tiles for transfer index $32C; pose not traced
	incbin "../Extracted/segments/bankCB_5000.bin":$295..$515
DATA8_CB5515:						; raw frame tiles for transfer index $32D; pose not traced
	incbin "../Extracted/segments/bankCB_5000.bin":$515..$715
DATA8_CB5715:						; raw frame tiles for transfer index $32E; pose not traced
	incbin "../Extracted/segments/bankCB_5000.bin":$715..$975
DATA8_CB5975:						; raw frame tiles for transfer index $32F; pose not traced
	incbin "../Extracted/segments/bankCB_5000.bin":$975..$BF5
DATA8_CB5BF5:						; raw frame tiles for transfer index $330; pose not traced
	incbin "../Extracted/segments/bankCB_5000.bin":$BF5..$E75
DATA8_CB5E75:						; raw frame tiles for transfer index $331; pose not traced
	incbin "../Extracted/segments/bankCB_5000.bin":$E75..$1000
	incbin "../Extracted/segments/bankCB_6000.bin":$0..$D5

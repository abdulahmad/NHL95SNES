; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C89079
DATA8_C89079:						; raw frame tiles for transfer index $168; pose not traced
	incbin "../Extracted/segments/bankC8_9000.bin":$79..$2D9
DATA8_C892D9:						; raw frame tiles for transfer index $169; pose not traced
	incbin "../Extracted/segments/bankC8_9000.bin":$2D9..$539
DATA8_C89539:						; raw frame tiles for transfer index $16A; pose not traced
	incbin "../Extracted/segments/bankC8_9000.bin":$539..$779
DATA8_C89779:						; raw frame tiles for transfer index $16C; pose not traced
	incbin "../Extracted/segments/bankC8_9000.bin":$779..$9D9
DATA8_C899D9:						; raw frame tiles for transfer index $16D; pose not traced
	incbin "../Extracted/segments/bankC8_9000.bin":$9D9..$C39
DATA8_C89C39:						; raw frame tiles for transfer index $170; pose not traced
	incbin "../Extracted/segments/bankC8_9000.bin":$C39..$E99
DATA8_C89E99:						; raw frame tiles for transfer index $171; pose not traced
	incbin "../Extracted/segments/bankC8_9000.bin":$E99..$1000
	incbin "../Extracted/segments/bankC8_A000.bin":$0..$F9

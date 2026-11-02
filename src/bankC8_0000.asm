; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $C80559
DATA8_C80559:						; raw frame tiles for transfer index $101; pose not traced
	incbin "../Extracted/segments/bankC8_0000.bin":$559..$7D9
DATA8_C807D9:						; raw frame tiles for transfer index $102; pose not traced
	incbin "../Extracted/segments/bankC8_0000.bin":$7D9..$A59
DATA8_C80A59:						; raw frame tiles for transfer index $103; pose not traced
	incbin "../Extracted/segments/bankC8_0000.bin":$A59..$CD9
DATA8_C80CD9:						; raw frame tiles for transfer index $104; pose not traced
	incbin "../Extracted/segments/bankC8_0000.bin":$CD9..$F59
DATA8_C80F59:						; raw frame tiles for transfer index $105; pose not traced
	incbin "../Extracted/segments/bankC8_0000.bin":$F59..$1000
	incbin "../Extracted/segments/bankC8_1000.bin":$0..$1B9

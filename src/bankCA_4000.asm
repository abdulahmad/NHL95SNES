; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CA4079
DATA8_CA4079:						; raw frame tiles for transfer index $258; pose not traced
	incbin "../Extracted/segments/bankCA_4000.bin":$79..$2D9
DATA8_CA42D9:						; raw frame tiles for transfer index $259; pose not traced
	incbin "../Extracted/segments/bankCA_4000.bin":$2D9..$559
DATA8_CA4559:						; raw frame tiles for transfer index $25A; pose not traced
	incbin "../Extracted/segments/bankCA_4000.bin":$559..$7D9
DATA8_CA47D9:						; raw frame tiles for transfer index $25B; pose not traced
	incbin "../Extracted/segments/bankCA_4000.bin":$7D9..$A39
DATA8_CA4A39:						; raw frame tiles for transfer index $25C; pose not traced
	incbin "../Extracted/segments/bankCA_4000.bin":$A39..$CB9
DATA8_CA4CB9:						; raw frame tiles for transfer index $25D; pose not traced
	incbin "../Extracted/segments/bankCA_4000.bin":$CB9..$F39
DATA8_CA4F39:						; raw frame tiles for transfer index $25E; pose not traced
	incbin "../Extracted/segments/bankCA_4000.bin":$F39..$1000
	incbin "../Extracted/segments/bankCA_5000.bin":$0..$139

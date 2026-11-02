; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CA09D9
DATA8_CA09D9:						; raw frame tiles for transfer index $241; pose not traced
	incbin "../Extracted/segments/bankCA_0000.bin":$9D9..$C39
DATA8_CA0C39:						; raw frame tiles for transfer index $242; pose not traced
	incbin "../Extracted/segments/bankCA_0000.bin":$C39..$E99
DATA8_CA0E99:						; raw frame tiles for transfer index $243; pose not traced
	incbin "../Extracted/segments/bankCA_0000.bin":$E99..$1000
	incbin "../Extracted/segments/bankCA_1000.bin":$0..$99

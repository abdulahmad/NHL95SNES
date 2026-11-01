; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CA81F9
DATA8_CA81F9:						; raw frame tiles for transfer index $276; pose not traced
	incbin "../Extracted/segments/bankCA_8000.bin":$1F9..$459
DATA8_CA8459:						; raw frame tiles for transfer index $277; pose not traced
	incbin "../Extracted/segments/bankCA_8000.bin":$459..$659
DATA8_CA8659:						; raw frame tiles for transfer index $278; pose not traced
	incbin "../Extracted/segments/bankCA_8000.bin":$659..$859
DATA8_CA8859:						; raw frame tiles for transfer index $279; pose not traced
	incbin "../Extracted/segments/bankCA_8000.bin":$859..$A59
DATA8_CA8A59:						; raw frame tiles for transfer index $27A; pose not traced
	incbin "../Extracted/segments/bankCA_8000.bin":$A59..$C59
DATA8_CA8C59:						; raw frame tiles for transfer index $27B; pose not traced
	incbin "../Extracted/segments/bankCA_8000.bin":$C59..$E59
DATA8_CA8E59:						; raw frame tiles for transfer index $27C; pose not traced
	incbin "../Extracted/segments/bankCA_8000.bin":$E59..$1000
	incbin "../Extracted/segments/bankCA_9000.bin":$0..$B9

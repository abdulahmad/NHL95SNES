; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CB90D5
DATA8_CB90D5:						; raw frame tiles for transfer index $348; pose not traced
	incbin "../Extracted/segments/bankCB_9000.bin":$D5..$335
DATA8_CB9335:						; raw frame tiles for transfer index $349; pose not traced
	incbin "../Extracted/segments/bankCB_9000.bin":$335..$5B5
DATA8_CB95B5:						; raw frame tiles for transfer index $34A; pose not traced
	incbin "../Extracted/segments/bankCB_9000.bin":$5B5..$815
DATA8_CB9815:						; raw frame tiles for transfer index $34B; pose not traced
	incbin "../Extracted/segments/bankCB_9000.bin":$815..$A95
DATA8_CB9A95:						; raw frame tiles for transfer index $34C; pose not traced
	incbin "../Extracted/segments/bankCB_9000.bin":$A95..$C95
DATA8_CB9C95:						; raw frame tiles for transfer index $34D; pose not traced
	incbin "../Extracted/segments/bankCB_9000.bin":$C95..$F15
DATA8_CB9F15:						; raw frame tiles for transfer index $34E; pose not traced
	incbin "../Extracted/segments/bankCB_9000.bin":$F15..$1000
	incbin "../Extracted/segments/bankCB_A000.bin":$0..$115

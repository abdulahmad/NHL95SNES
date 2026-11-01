; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CBB235
DATA8_CBB235:						; raw frame tiles for transfer index $356; pose not traced
	incbin "../Extracted/segments/bankCB_B000.bin":$235..$435
DATA8_CBB435:						; raw frame tiles for transfer index $357; pose not traced
	incbin "../Extracted/segments/bankCB_B000.bin":$435..$635
DATA8_CBB635:						; raw frame tiles for transfer index $358; pose not traced
	incbin "../Extracted/segments/bankCB_B000.bin":$635..$835
DATA8_CBB835:						; raw frame tiles for transfer index $359; pose not traced
	incbin "../Extracted/segments/bankCB_B000.bin":$835..$A35
DATA8_CBBA35:						; raw frame tiles for transfer index $35A; pose not traced
	incbin "../Extracted/segments/bankCB_B000.bin":$A35..$C35
DATA8_CBBC35:						; raw frame tiles for transfer index $35B; pose not traced
	incbin "../Extracted/segments/bankCB_B000.bin":$C35..$E35
DATA8_CBBE35:						; raw frame tiles for transfer index $35C; pose not traced
	incbin "../Extracted/segments/bankCB_B000.bin":$E35..$1000
	incbin "../Extracted/segments/bankCB_C000.bin":$0..$35

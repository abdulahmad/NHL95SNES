; Raw planar frame tiles sent directly to VRAM by CODE_C5F368.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CB81F5
DATA8_CB81F5:						; raw frame tiles for transfer index $341; pose not traced
	incbin "../Extracted/segments/bankCB_8000.bin":$1F5..$3F5
DATA8_CB83F5:						; raw frame tiles for transfer index $342; pose not traced
	incbin "../Extracted/segments/bankCB_8000.bin":$3F5..$5F5
DATA8_CB85F5:						; raw frame tiles for transfer index $343; pose not traced
	incbin "../Extracted/segments/bankCB_8000.bin":$5F5..$7F5
DATA8_CB87F5:						; raw frame tiles for transfer index $344; pose not traced
	incbin "../Extracted/segments/bankCB_8000.bin":$7F5..$9F5
DATA8_CB89F5:						; raw frame tiles for transfer index $345; pose not traced
	incbin "../Extracted/segments/bankCB_8000.bin":$9F5..$BF5
DATA8_CB8BF5:						; raw frame tiles for transfer index $346; pose not traced
	incbin "../Extracted/segments/bankCB_8000.bin":$BF5..$E55
DATA8_CB8E55:						; raw frame tiles for transfer index $347; pose not traced
	incbin "../Extracted/segments/bankCB_8000.bin":$E55..$1000
	incbin "../Extracted/segments/bankCB_9000.bin":$0..$D5

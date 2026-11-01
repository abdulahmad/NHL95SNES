; Raw planar frame tiles sent directly to VRAM by QueueFrameTiles.
; Frame poses are not traced; DATA8_ labels identify the transfer sources.
org $CB4075
DATA8_CB4075:						; raw frame tiles for transfer index $2EF; pose not traced
	incbin "../Extracted/segments/bankCB_4000.bin":$75..$275
DATA8_CB4275:						; raw frame tiles for transfer index $2F0; pose not traced
	incbin "../Extracted/segments/bankCB_4000.bin":$275..$4D5
DATA8_CB44D5:						; raw frame tiles for transfer index $2F1; pose not traced
	incbin "../Extracted/segments/bankCB_4000.bin":$4D5..$6D5
DATA8_CB46D5:						; raw frame tiles for transfer index $2F2; pose not traced
	incbin "../Extracted/segments/bankCB_4000.bin":$6D5..$935
DATA8_CB4935:						; raw frame tiles for transfer index $312; pose not traced
	incbin "../Extracted/segments/bankCB_4000.bin":$935..$BB5
DATA8_CB4BB5:						; raw frame tiles for transfer index $319; pose not traced
	incbin "../Extracted/segments/bankCB_4000.bin":$BB5..$DB5
DATA8_CB4DB5:						; raw frame tiles for transfer index $32A; pose not traced
	incbin "../Extracted/segments/bankCB_4000.bin":$DB5..$1000
	incbin "../Extracted/segments/bankCB_5000.bin":$0..$15
